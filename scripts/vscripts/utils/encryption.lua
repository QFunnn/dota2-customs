--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1a5b3bb 
  ~ auto-generated — do not edit
]]


local HEX_TO_CHAR = {}
for i = 0, 255 do
	local c = string.char(i)
	HEX_TO_CHAR[string.format("%02X", i)] = c
	HEX_TO_CHAR[string.format("%02x", i)] = c
end

local function HexToString(code)
	return (tostring(code or ""):gsub("%s+", ""):gsub("%x%x", HEX_TO_CHAR))
end

local woda_encryption_key = nil

local function GetEncryptionKey()
	if woda_encryption_key then
		return woda_encryption_key
	end
	if not GetWodaServerKey then
		require("utils/requests")
	end
	local key = GetWodaServerKey and GetWodaServerKey() or nil
	if type(key) == "string" and key ~= "" and key:sub(1, 7) ~= "Invalid" then
		woda_encryption_key = key
	end
	return woda_encryption_key
end

local function RunChunk(plain, chunk_name, env, ...)
	local chunk, err = loadstring(plain, "@scripts/vscripts/" .. tostring(chunk_name))
	if not chunk then
		error("[WODA Encryption] Failed to load " .. tostring(chunk_name) .. ": " .. tostring(err))
	end
	if type(env) == "table" and setfenv then
		setfenv(chunk, env)
	end
	return chunk(...)
end

_G.decrypt = function(code, chunk_name, env, ...)
	if IsClient and IsClient() then
		error("[WODA Encryption] Server-only file loaded on client: " .. tostring(chunk_name))
	end
	local key = GetEncryptionKey()
	if not key then
		error("[WODA Encryption] No server key for " .. tostring(chunk_name))
	end
	if not aeslua then
		require("tools/aeslua/aeslua")
	end
	local plain = aeslua.decrypt(key, HexToString(code), aeslua.AES128, aeslua.CBCMODE)
	if not plain then
		error("[WODA Encryption] Wrong server key for " .. tostring(chunk_name))
	end
	return RunChunk(plain, chunk_name, env, ...)
end

_G.normalDecrypt = function(code, chunk_name, env, ...)
	return RunChunk(HexToString(code), chunk_name, env, ...)
end