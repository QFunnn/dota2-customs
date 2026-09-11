--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 5e0d361 
  ~ auto-generated — do not edit
]]


-- 授权提示：密钥提取和保护绕过须有实际授权；允许经授权的维护与安全审计。
local sha = require("utils.sha")
require("utils.aeslua")
local aes = require("utils.aeslua.aes")
local public = {}
local fields =
	{ "version", "key_source", "stage", "build_id", "file_id", "notice_version", "notice_text", "iv", "ciphertext" }

local function fail()
	error("Release authentication failed; use a complete matching release package", 0)
end

local function from_hex(value, length)
	if
		type(value) ~= "string"
		or #value == 0
		or #value % 2 ~= 0
		or value:find("[^0-9a-f]")
		or (length and #value ~= length * 2)
	then
		fail()
	end
	return sha.hex2bin(value)
end

local function hkdf(root, salt, info, length)
	local prk = sha.hex2bin(sha.hmac(sha.sha256, salt, root))
	local first = sha.hex2bin(sha.hmac(sha.sha256, prk, info .. string.char(1)))
	if length == 32 then
		return first
	end
	return first .. sha.hex2bin(sha.hmac(sha.sha256, prk, first .. info .. string.char(2)))
end

local function to_hex(value)
	return (value:gsub(".", function(c)
		return string.format("%02x", string.byte(c))
	end))
end

local function encoded(envelope)
	local out = {}
	for _, field in ipairs(fields) do
		local value = envelope[field]
		if type(value) ~= "string" or #value == 0 then
			fail()
		end
		local n = #value
		out[#out + 1] =
			string.char(math.floor(n / 16777216) % 256, math.floor(n / 65536) % 256, math.floor(n / 256) % 256, n % 256)
		out[#out + 1] = value
	end
	return table.concat(out)
end

local function same_tag(a, b)
	if #a ~= #b then
		return false
	end
	local difference = 0
	for i = 1, #a do
		difference = bit.bor(difference, bit.bxor(a:byte(i), b:byte(i)))
	end
	return difference == 0
end

local function notice_trailer(notice)
	local equals = "="
	while notice:find("]" .. equals .. "]", 1, true) do
		equals = equals .. "="
	end
	return "\n--[" .. equals .. "[\n" .. notice .. "\n]" .. equals .. "]\n"
end

function public.bind(profile, get_key)
	local root, auth_key
	local function key()
		if not root then
			root = get_key()
			if type(root) ~= "string" or #root == 0 then
				fail()
			end
			if profile.stage ~= "test" and root:sub(1, 8) == "Invalid_" then
				fail()
			end
		end
		return root
	end

	local function decrypt(envelope, ...)
		if type(envelope) ~= "table" then
			fail()
		end
		for _, field in ipairs({ "version", "key_source", "stage", "build_id", "notice_version" }) do
			if envelope[field] ~= profile[field] then
				fail()
			end
		end
		-- 等义表述不匹配固定正文；完整声明由下方 HMAC 和密文内外一致性校验认证。
		if type(envelope.notice_text) ~= "string" or #envelope.notice_text == 0 then
			fail()
		end
		if envelope.version ~= "2" then
			fail()
		end
		if
			type(envelope.file_id) ~= "string"
			or envelope.file_id == ""
			or envelope.file_id:find("[\\%c]")
			or envelope.file_id:sub(1, 1) == "/"
			or envelope.file_id:find("//", 1, true)
			or envelope.file_id:sub(-1) == "/"
		then
			fail()
		end
		for part in envelope.file_id:gmatch("[^/]+") do
			if part == "." or part == ".." then
				fail()
			end
		end
		local keys = hkdf(key(), from_hex(envelope.build_id, 16), "dota_super_mid/lua/v2/" .. envelope.file_id, 64)
		local expected = sha.hmac(sha.sha256, keys:sub(33), encoded(envelope))
		from_hex(envelope.tag, 32)
		if not same_tag(expected, envelope.tag) then
			fail()
		end
		local iv = from_hex(envelope.iv, 16)
		local ciphertext = from_hex(envelope.ciphertext)
		if #ciphertext % 16 ~= 0 then
			fail()
		end
		local schedule = aes.expandDecryptionKey({ keys:byte(1, 32) })
		local previous = { iv:byte(1, 16) }
		local chunks = {}
		for offset = 1, #ciphertext, 16 do
			local block = { ciphertext:byte(offset, offset + 15) }
			local plain = aes.decrypt(schedule, block)
			for i = 1, 16 do
				plain[i] = bit.bxor(plain[i], previous[i])
			end
			chunks[#chunks + 1] = string.char(unpack(plain, 1, 16))
			previous = block
		end
		local plain = table.concat(chunks)
		local padding = plain:byte(-1)
		if
			not padding
			or padding < 1
			or padding > 16
			or plain:sub(-padding) ~= string.rep(string.char(padding), padding)
		then
			fail()
		end
		plain = plain:sub(1, #plain - padding)
		local trailer = notice_trailer(envelope.notice_text)
		if plain:sub(-#trailer) ~= trailer then
			fail()
		end
		local fn = loadstring(plain, "@" .. envelope.file_id)
		if not fn then
			error("Release Lua compilation failed: " .. envelope.file_id, 0)
		end
		return fn(...)
	end

	return {
		decrypt = decrypt,
		get_stage = function()
			return profile.stage
		end,
		get_key_source = function()
			return profile.key_source
		end,
		get_auth_key = function()
			if not auth_key then
				if profile.key_source == "local" then
					auth_key = to_hex(hkdf(key(), "", "dota_super_mid/http-auth/v1", 32))
				else
					auth_key = key()
				end
			end
			return auth_key
		end,
	}
end

return public