--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1a5b3bb 
  ~ auto-generated — do not edit
]]


local ____lualib = require("lualib_bundle")
local __TS__StringTrim = ____lualib.__TS__StringTrim
local __TS__StringCharAt = ____lualib.__TS__StringCharAt
local __TS__Number = ____lualib.__TS__Number
local __TS__StringSplit = ____lualib.__TS__StringSplit
local __TS__ArraySlice = ____lualib.__TS__ArraySlice
local __TS__ArraySort = ____lualib.__TS__ArraySort
local __TS__ArrayMap = ____lualib.__TS__ArrayMap
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
--- 枚举引擎中的有效槽位；玩家人数不能作为 PlayerID 的上限。
function ____exports.GetValidPlayerIds(self)
	local playerIds = {}
	do
		local playerId = 0
		while playerId < DOTA_MAX_TEAM_PLAYERS do
			if PlayerResource:IsValidPlayerID(playerId) then
				playerIds[#playerIds + 1] = playerId
			end
			playerId = playerId + 1
		end
	end
	return playerIds
end
--- 校验完整名单并保留 SteamID64 字符串，供加载页精确匹配。
local function ParseMatchSteamIds(self, config)
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
		steamIds[#steamIds + 1] = __TS__StringTrim(steamId64)
	end
	return steamIds
end
--- 地图初始化时同步加载页名单；配置缺失或无效时不显示任何玩家。
function ____exports.SyncMatchLoadingPlayers(self)
	local config = LoadKeyValues("scripts_dedicated/match_config.kv")
	local players = {}
	local ____ParseMatchSteamIds_result_2 = ParseMatchSteamIds(nil, config)
	if ____ParseMatchSteamIds_result_2 == nil then
		____ParseMatchSteamIds_result_2 = {}
	end
	for ____, steamId in ipairs(____ParseMatchSteamIds_result_2) do
		players[steamId] = 1
	end
	CustomNetTables:SetTableValue("game_flow", "loading_players", players)
end
--- 读取实例名单；仅本地 Tools Mode 缺少文件时，使用当前玩家生成默认名单。
function ____exports.LoadMatchSteamAccountIds(self, getToolsDefaultSteamIds)
	local config = LoadKeyValues("scripts_dedicated/match_config.kv")
	if config == nil and IsInToolsMode() then
		local ____getToolsDefaultSteamIds_3
		if getToolsDefaultSteamIds then
			____getToolsDefaultSteamIds_3 = getToolsDefaultSteamIds(nil)
		else
			____getToolsDefaultSteamIds_3 = __TS__ArrayMap(
				__TS__ArraySort(__TS__ArraySlice(PlayerInfo:GetAllPlayerIds()), function(____, a, b)
					return a - b
				end),
				function(____, playerId)
					return PlayerInfo:GetPlayerSteamIdStr(playerId)
				end
			)
		end
		local steamIds = ____getToolsDefaultSteamIds_3
		print(
			(
				"[分队配置] 本地未提供比赛名单，按玩家编号生成默认名单：["
				.. table.concat(steamIds, ",")
			) .. "]"
		)
		return steamIds
	end
	local ____ParseMatchSteamIds_result_map_result_4 = ParseMatchSteamIds(nil, config)
	if ____ParseMatchSteamIds_result_map_result_4 ~= nil then
		____ParseMatchSteamIds_result_map_result_4 = __TS__ArrayMap(
			ParseMatchSteamIds(nil, config),
			function(____, steamId)
				return ____exports.ConvertSteamId64ToAccountId(nil, steamId)
			end
		)
	end
	return ____ParseMatchSteamIds_result_map_result_4
end
return ____exports