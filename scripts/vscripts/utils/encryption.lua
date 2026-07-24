--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


UPUP_ENCRYPTION_DEDICATED_KEY_NAME = UPUP_ENCRYPTION_DEDICATED_KEY_NAME or "dota_up_up"

local function ReadToolsDedicatedKey()
	if not IsInToolsMode or not IsInToolsMode() or not LoadKeyValues then
		return nil
	end

	local ok, key_data = pcall(LoadKeyValues, "scripts/level_up_key.txt")
	if not ok or not key_data then
		return nil
	end

	return key_data["CustomDedicatedKey"]
end

function GetServerKey()
	local key = nil

	if GetDedicatedServerKeyV3 then
		key = GetDedicatedServerKeyV3(UPUP_ENCRYPTION_DEDICATED_KEY_NAME)
	end

	local tools_key = ReadToolsDedicatedKey()
	if tools_key and tools_key ~= "" then
		key = tools_key
	end

	return key or ""
end

local function HexToString(str)
	str = tostring(str or ""):gsub("%s+", "")
	return (str:gsub("..", function(cc)
		return string.char(tonumber(cc, 16))
	end))
end

local function StringToHex(str)
	return (str:gsub(".", function(c)
		return string.format("%02X", string.byte(c))
	end))
end

string.fromhex = HexToString
string.tohex = StringToHex

local function NormalizeChunkArgs(chunk_name, ...)
	local args = { ... }

	if type(chunk_name) ~= "string" then
		if chunk_name ~= nil then
			table.insert(args, 1, chunk_name)
		end
		chunk_name = nil
	end

	return chunk_name, args
end

local function RunPlainChunk(plain, chunk_name, args)
	if not plain then
		error("[UPUP Encryption] Failed to decrypt " .. tostring(chunk_name or "chunk"))
	end

	local chunk, err = loadstring(plain, chunk_name or "upup_encrypted_chunk")
	if not chunk then
		error("[UPUP Encryption] Failed to load " .. tostring(chunk_name or "chunk") .. ": " .. tostring(err))
	end

	return chunk(unpack(args))
end

_G.decrypt = function(code, chunk_name, ...)
	local args
	chunk_name, args = NormalizeChunkArgs(chunk_name, ...)

	if not aeslua then
		require("tools/aeslua/aeslua")
	end

	local key = GetServerKey()
	if key == "" then
		error("[UPUP Encryption] Empty dedicated server key for " .. tostring(chunk_name or "chunk"))
	end

	local encrypted = HexToString(code)
	local plain = aeslua.decrypt(key, encrypted, aeslua.AES128, aeslua.CBCMODE)
	return RunPlainChunk(plain, chunk_name, args)
end

_G.normalDecrypt = function(code, chunk_name, ...)
	local args
	chunk_name, args = NormalizeChunkArgs(chunk_name, ...)

	local plain = HexToString(code)
	return RunPlainChunk(plain, chunk_name, args)
end