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
local __TS__ArrayMap = ____lualib.__TS__ArrayMap
local __TS__ArraySlice = ____lualib.__TS__ArraySlice
local __TS__ArraySort = ____lualib.__TS__ArraySort
local __TS__NumberIsFinite = ____lualib.__TS__NumberIsFinite
local __TS__ObjectValues = ____lualib.__TS__ObjectValues
local __TS__ObjectEntries = ____lualib.__TS__ObjectEntries
____debugRuntime.register(
	"utils/match_config.lua",
	{
		["18"] = "11:1",
		["19"] = "12:11",
		["20"] = "13:9",
		["21"] = "14:16",
		["22"] = "14:16",
		["23"] = "14:34",
		["25"] = "14:84",
		["27"] = "14:9",
		["29"] = "16:9",
		["30"] = "16:48",
		["32"] = "19:12",
		["33"] = "20:10",
		["34"] = "20:42",
		["36"] = "21:11",
		["37"] = "22:20",
		["38"] = "22:20",
		["39"] = "22:56",
		["41"] = "22:86",
		["43"] = "22:11",
		["44"] = "23:9",
		["45"] = "24:9",
		["47"] = "26:5",
		["48"] = "11:1",
		["50"] = "30:1",
		["51"] = "31:9",
		["52"] = "31:40",
		["54"] = "32:11",
		["55"] = "33:9",
		["56"] = "33:61",
		["59"] = "34:14",
		["60"] = "34:21",
		["61"] = "35:15",
		["62"] = "36:13",
		["63"] = "36:41",
		["65"] = "34:39",
		["68"] = "40:11",
		["69"] = "41:9",
		["70"] = "41:51",
		["72"] = "42:5",
		["73"] = "30:1",
		["75"] = "49:1",
		["76"] = "50:11",
		["78"] = "51:14",
		["79"] = "51:28",
		["80"] = "52:13",
		["81"] = "52:55",
		["83"] = "51:62",
		["86"] = "54:5",
		["87"] = "49:1",
		["89"] = "58:1",
		["90"] = "59:16",
		["91"] = "59:16",
		["92"] = "59:16",
		["94"] = "59:9",
		["95"] = "59:47",
		["97"] = "61:11",
		["98"] = "62:11",
		["99"] = "63:5",
		["100"] = "64:15",
		["101"] = "65:13",
		["102"] = "65:57",
		["104"] = "66:9",
		["105"] = "67:9",
		["107"] = "69:5",
		["108"] = "58:1",
		["110"] = "73:1",
		["111"] = "74:12",
		["112"] = "74:12",
		["113"] = "74:12",
		["114"] = "74:12",
		["115"] = "74:50",
		["116"] = "74:12",
		["118"] = "74:5",
		["119"] = "73:1",
		["121"] = "78:1",
		["122"] = "79:11",
		["123"] = "80:11",
		["124"] = "81:5",
		["125"] = "81:21",
		["126"] = "81:69",
		["127"] = "81:98",
		["128"] = "81:129",
		["129"] = "81:129",
		["130"] = "81:129",
		["132"] = "81:129",
		["134"] = "81:129",
		["136"] = "81:5",
		["137"] = "78:1",
		["139"] = "85:1",
		["140"] = "86:11",
		["141"] = "87:11",
		["142"] = "88:11",
		["143"] = "89:27",
		["145"] = "89:27",
		["147"] = "89:5",
		["148"] = "90:9",
		["150"] = "92:5",
		["151"] = "93:12",
		["152"] = "93:12",
		["153"] = "93:12",
		["154"] = "93:12",
		["155"] = "93:26",
		["156"] = "93:12",
		["158"] = "93:5",
		["159"] = "85:1",
		["161"] = "97:1",
		["162"] = "98:11",
		["163"] = "99:9",
		["164"] = "102:26",
		["165"] = "102:26",
		["166"] = "103:15",
		["168"] = "104:15",
		["169"] = "104:15",
		["170"] = "104:15",
		["171"] = "106:25",
		["172"] = "104:15",
		["173"] = "107:24",
		["174"] = "104:15",
		["176"] = "102:15",
		["177"] = "108:9",
		["178"] = "109:9",
		["180"] = "111:12",
		["181"] = "111:38",
		["182"] = "111:38",
		["183"] = "111:38",
		["185"] = "111:5",
		["186"] = "97:1",
		["188"] = "115:1",
		["189"] = "116:11",
		["190"] = "117:9",
		["191"] = "117:50",
		["193"] = "118:9",
		["194"] = "118:37",
		["196"] = "120:11",
		["197"] = "121:5",
		["198"] = "121:17",
		["199"] = "121:26",
		["200"] = "123:13",
		["202"] = "124:18",
		["203"] = "124:25",
		["204"] = "125:19",
		["205"] = "126:17",
		["206"] = "126:45",
		["208"] = "127:17",
		["209"] = "127:32",
		["211"] = "124:45",
		["214"] = "129:14",
		["215"] = "129:62",
		["217"] = "130:9",
		["218"] = "131:17",
		["219"] = "131:73",
		["221"] = "132:19",
		["222"] = "133:18",
		["223"] = "133:129",
		["225"] = "134:19",
		["226"] = "135:17",
		["227"] = "135:99",
		["229"] = "136:13",
		["232"] = "139:5",
		["233"] = "115:1",
	}
)
local ____exports = {}
--- 与名单查询共用已有模块，避免本地载入依赖额外的认证 Lua 文件。
function ____exports.GetPlayerSteamAuthState(steamId32)
	local api = rawget(_G, "DotaPlatform")
	if type(api) ~= "table" or type(api.GetPlayerAuthState) ~= "function" then
		local ____IsInToolsMode_result_0
		if IsInToolsMode() then
			____IsInToolsMode_result_0 = { status = "tools_mode", reason = "local_tools" }
		else
			____IsInToolsMode_result_0 = { status = "unknown", reason = "api_unavailable" }
		end
		return ____IsInToolsMode_result_0
	end
	if steamId32 == "0" or steamId32 == "" then
		return { status = "unknown", reason = "invalid_account_id" }
	end
	local ok, result = pcall(function()
		return api.GetPlayerAuthState(steamId32)
	end)
	if not ok or type(result) ~= "table" then
		return { status = "unknown", reason = "query_failed" }
	end
	local status = result.status
	local ____temp_1
	if type(result.reason) == "string" then
		____temp_1 = string.sub(result.reason, 1, 256)
	else
		____temp_1 = ""
	end
	local reason = ____temp_1
	if
		status == "authenticated"
		or status == "not_authenticated"
		or status == "not_connected"
		or status == "unknown"
	then
		return { status = status, reason = reason }
	end
	return { status = "unknown", reason = "invalid_status" }
end
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
	local ____config_steamids_2 = config
	if ____config_steamids_2 ~= nil then
		____config_steamids_2 = ____config_steamids_2.steamids
	end
	if type(____config_steamids_2) ~= "string" then
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
--- 解析实例完整名单，统一使用精确的 SteamAccountID32 字符串。
function ____exports.ParseMatchSteamAccountIds(self, steamids)
	local ____ParseMatchSteamIds_result_map_result_4 = ParseMatchSteamIds(nil, { steamids = steamids })
	if ____ParseMatchSteamIds_result_map_result_4 ~= nil then
		____ParseMatchSteamIds_result_map_result_4 = __TS__ArrayMap(
			ParseMatchSteamIds(nil, { steamids = steamids }),
			function(____, steamId)
				return ____exports.ConvertSteamId64ToAccountId(nil, steamId)
			end
		)
	end
	return ____ParseMatchSteamIds_result_map_result_4
end
--- 打印当前阶段实际读取 KV 的结果，不使用 Tools 默认名单掩盖文件缺失。
function ____exports.PrintMatchConfigRead(self, stage)
	local config = LoadKeyValues("scripts_dedicated/match_config.kv")
	local steamIds = ParseMatchSteamIds(nil, config)
	local ____print_12 = print
	local ____stage_9 = stage
	local ____temp_10 = config ~= nil
	local ____temp_11 = steamIds ~= nil
	local ____steamIds_length_6 = steamIds
	if ____steamIds_length_6 ~= nil then
		____steamIds_length_6 = #____steamIds_length_6
	end
	local ____steamIds_length_6_8 = ____steamIds_length_6
	if ____steamIds_length_6_8 == nil then
		____steamIds_length_6_8 = 0
	end
	____print_12(
		(
			(
				(
					(
						(("[载入配置][" .. ____stage_9) .. "] scripts_dedicated/match_config.kv 可读取=")
						.. tostring(____temp_10)
					) .. "，名单有效="
				) .. tostring(____temp_11)
			) .. "，名单人数="
		) .. tostring(____steamIds_length_6_8)
	)
end
--- 载入阶段同步完整名单，未连接玩家也能显示占位行；返回已校验的账号名单。
function ____exports.SyncMatchLoadingPlayers(self)
	local config = LoadKeyValues("scripts_dedicated/match_config.kv")
	local steamIds = ParseMatchSteamIds(nil, config)
	local players = {}
	local ____steamIds_13 = steamIds
	if ____steamIds_13 == nil then
		____steamIds_13 = {}
	end
	for ____, steamId in ipairs(____steamIds_13) do
		players[steamId] = 1
	end
	CustomNetTables:SetTableValue("game_flow", "loading_players", players)
	local ____steamIds_map_result_14 = steamIds
	if ____steamIds_map_result_14 ~= nil then
		____steamIds_map_result_14 = __TS__ArrayMap(steamIds, function(____, steamId)
			return ____exports.ConvertSteamId64ToAccountId(nil, steamId)
		end)
	end
	return ____steamIds_map_result_14
end
--- 读取实例名单；仅本地 Tools Mode 缺少文件时，使用当前玩家生成默认名单。
function ____exports.LoadMatchSteamAccountIds(self, getToolsDefaultSteamIds)
	local config = LoadKeyValues("scripts_dedicated/match_config.kv")
	if config == nil and IsInToolsMode() then
		local ____getToolsDefaultSteamIds_16
		if getToolsDefaultSteamIds then
			____getToolsDefaultSteamIds_16 = getToolsDefaultSteamIds(nil)
		else
			____getToolsDefaultSteamIds_16 = __TS__ArrayMap(
				__TS__ArraySort(__TS__ArraySlice(PlayerInfo:GetAllPlayerIds()), function(____, a, b)
					return a - b
				end),
				function(____, playerId)
					return PlayerInfo:GetPlayerSteamIdStr(playerId)
				end
			)
		end
		local steamIds = ____getToolsDefaultSteamIds_16
		print(
			(
				"[分队配置] 本地未提供比赛名单，按玩家编号生成默认名单：["
				.. table.concat(steamIds, ",")
			) .. "]"
		)
		return steamIds
	end
	local ____exports_ParseMatchSteamAccountIds_19 = ____exports.ParseMatchSteamAccountIds
	local ____config_steamids_17 = config
	if ____config_steamids_17 ~= nil then
		____config_steamids_17 = ____config_steamids_17.steamids
	end
	return ____exports_ParseMatchSteamAccountIds_19(nil, ____config_steamids_17)
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