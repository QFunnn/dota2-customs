--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1a5b3bb 
  ~ auto-generated — do not edit
]]


-- utils/match_config.lua
local ____debugRuntime = require("utils.debug_runtime")
local debug = ____debugRuntime.safe_debug
local ____lualib = require("lualib_bundle")
local __TS__StringTrim = ____lualib.__TS__StringTrim
local __TS__StringCharAt = ____lualib.__TS__StringCharAt
local __TS__Number = ____lualib.__TS__Number
local __TS__StringSplit = ____lualib.__TS__StringSplit
local __TS__ArraySlice = ____lualib.__TS__ArraySlice
local __TS__ArraySort = ____lualib.__TS__ArraySort
local __TS__ArrayMap = ____lualib.__TS__ArrayMap
local __TS__NumberIsFinite = ____lualib.__TS__NumberIsFinite
local __TS__ObjectValues = ____lualib.__TS__ObjectValues
local __TS__ObjectEntries = ____lualib.__TS__ObjectEntries
____debugRuntime.register(
	"utils/match_config.lua",
	{
		["18"] = "2:1",
		["19"] = "3:9",
		["20"] = "3:40",
		["22"] = "4:11",
		["23"] = "5:9",
		["24"] = "5:61",
		["27"] = "6:14",
		["28"] = "6:21",
		["29"] = "7:15",
		["30"] = "8:13",
		["31"] = "8:41",
		["33"] = "6:39",
		["36"] = "12:11",
		["37"] = "13:9",
		["38"] = "13:51",
		["40"] = "14:5",
		["41"] = "2:1",
		["43"] = "21:1",
		["44"] = "22:11",
		["46"] = "23:14",
		["47"] = "23:28",
		["48"] = "24:13",
		["49"] = "24:55",
		["51"] = "23:62",
		["54"] = "26:5",
		["55"] = "21:1",
		["57"] = "30:1",
		["58"] = "31:16",
		["59"] = "31:16",
		["60"] = "31:16",
		["62"] = "31:9",
		["63"] = "31:47",
		["65"] = "33:11",
		["66"] = "34:11",
		["67"] = "35:5",
		["68"] = "36:15",
		["69"] = "37:13",
		["70"] = "37:57",
		["72"] = "38:9",
		["73"] = "39:9",
		["75"] = "41:5",
		["76"] = "30:1",
		["78"] = "45:1",
		["79"] = "46:11",
		["80"] = "47:11",
		["81"] = "48:27",
		["83"] = "48:27",
		["85"] = "48:5",
		["86"] = "49:9",
		["88"] = "51:5",
		["89"] = "45:1",
		["91"] = "55:1",
		["92"] = "56:11",
		["93"] = "57:9",
		["94"] = "60:26",
		["95"] = "60:26",
		["96"] = "61:15",
		["98"] = "62:15",
		["99"] = "62:15",
		["100"] = "62:15",
		["101"] = "64:25",
		["102"] = "62:15",
		["103"] = "65:24",
		["104"] = "62:15",
		["106"] = "60:15",
		["107"] = "66:9",
		["108"] = "67:9",
		["110"] = "69:12",
		["111"] = "69:12",
		["112"] = "69:12",
		["113"] = "69:12",
		["114"] = "69:44",
		["115"] = "69:12",
		["117"] = "69:5",
		["118"] = "55:1",
		["120"] = "73:1",
		["121"] = "74:11",
		["122"] = "75:9",
		["123"] = "75:50",
		["125"] = "76:9",
		["126"] = "76:37",
		["128"] = "78:11",
		["129"] = "79:5",
		["130"] = "79:17",
		["131"] = "79:26",
		["132"] = "81:13",
		["134"] = "82:18",
		["135"] = "82:25",
		["136"] = "83:19",
		["137"] = "84:17",
		["138"] = "84:45",
		["140"] = "85:17",
		["141"] = "85:32",
		["143"] = "82:45",
		["146"] = "87:14",
		["147"] = "87:62",
		["149"] = "88:9",
		["150"] = "89:17",
		["151"] = "89:73",
		["153"] = "90:19",
		["154"] = "91:18",
		["155"] = "91:129",
		["157"] = "92:19",
		["158"] = "93:17",
		["159"] = "93:99",
		["161"] = "94:13",
		["164"] = "97:5",
		["165"] = "73:1",
	}
)
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
--- 读取本场组队关系：外层键是 PartyID，内层值是 SteamAccountID32。仅 Tools 缺少文件时使用原生组队。
function ____exports.LoadMatchPartyIds(self, getToolsDefaultPartyIds)
	local config = LoadKeyValues("scripts_dedicated/party_steamids.kv")
	if config == nil and IsInToolsMode() then
		return getToolsDefaultPartyIds(nil)
	end
	if type(config) ~= "table" then
		return nil
	end
	local partyIds = {}
	for ____, ____value in ipairs(__TS__ObjectEntries(config)) do
		local partyId = ____value[1]
		local members = ____value[2]
		local hasNonZeroDigit = false
		do
			local i = 0
			while i < #partyId do
				local digit = __TS__StringCharAt(partyId, i)
				if digit < "0" or digit > "9" then
					return nil
				end
				if digit ~= "0" then
					hasNonZeroDigit = true
				end
				i = i + 1
			end
		end
		if not hasNonZeroDigit or type(members) ~= "table" then
			return nil
		end
		for ____, value in ipairs(__TS__ObjectValues(members)) do
			if type(value) ~= "string" and type(value) ~= "number" then
				return nil
			end
			local accountId = __TS__Number(value)
			if
				not __TS__NumberIsFinite(accountId)
				or accountId <= 0
				or accountId > 4294967295
				or math.floor(accountId) ~= accountId
			then
				return nil
			end
			local accountIdString = tostring(accountId)
			if partyIds[accountIdString] ~= nil and partyIds[accountIdString] ~= partyId then
				return nil
			end
			partyIds[accountIdString] = partyId
		end
	end
	return partyIds
end
return ____exports