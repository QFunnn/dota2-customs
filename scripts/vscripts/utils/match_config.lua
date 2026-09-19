--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build c158db4 
  ~ auto-generated — do not edit
]]


local ____lualib = require("lualib_bundle")
local __TS__StringTrim = ____lualib.__TS__StringTrim
local __TS__StringCharAt = ____lualib.__TS__StringCharAt
local __TS__Number = ____lualib.__TS__Number
local __TS__ArraySlice = ____lualib.__TS__ArraySlice
local __TS__ArraySort = ____lualib.__TS__ArraySort
local __TS__ArrayMap = ____lualib.__TS__ArrayMap
local __TS__StringSplit = ____lualib.__TS__StringSplit
local ____exports = {}
--- SteamID64（公开个人账号）转换为 SteamAccountID32 字符串。
function ____exports.ConvertSteamId64ToAccountId(self, steamId64)
	if type(steamId64) ~= "string" then
		return nil
	end
	local value = __TS__StringTrim(steamId64)
	if #value ~= 17 or string.sub(value, 1, 3) ~= "765" then
		return nil
	end
	do
		local i = 3
		while i < #value do
			local digit = __TS__StringCharAt(value, i)
			if digit < "0" or digit > "9" then
				return nil
			end
			i = i + 1
		end
	end
	local accountId = __TS__Number(string.sub(value, 4)) - 61197960265728
	if accountId <= 0 or accountId > 4294967295 then
		return nil
	end
	return tostring(accountId)
end
--- 读取实例名单；仅本地 Tools Mode 缺少文件时，使用当前玩家生成默认名单。
function ____exports.LoadMatchSteamAccountIds(self)
	local config = LoadKeyValues("scripts_dedicated/match_config.kv")
	if config == nil and IsInToolsMode() then
		local steamIds = __TS__ArrayMap(
			__TS__ArraySort(__TS__ArraySlice(PlayerInfo:GetAllPlayerIds()), function(____, a, b)
				return a - b
			end),
			function(____, playerId)
				return PlayerInfo:GetPlayerSteamIdStr(playerId)
			end
		)
		print(
			(
				"[分队配置] 本地未提供比赛名单，按玩家编号生成默认名单：["
				.. table.concat(steamIds, ",")
			) .. "]"
		)
		return steamIds
	end
	local ____config_steamids_0 = config
	if ____config_steamids_0 ~= nil then
		____config_steamids_0 = ____config_steamids_0.steamids
	end
	if type(____config_steamids_0) ~= "string" then
		return nil
	end
	local steamIds = {}
	local seen = {}
	for ____, steamId64 in ipairs(__TS__StringSplit(config.steamids, "&")) do
		local accountId = ____exports.ConvertSteamId64ToAccountId(nil, steamId64)
		if accountId == nil or seen[accountId] then
			return nil
		end
		seen[accountId] = true
		steamIds[#steamIds + 1] = accountId
	end
	return steamIds
end
return ____exports