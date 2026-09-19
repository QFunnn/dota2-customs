--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1a5b3bb 
  ~ auto-generated — do not edit
]]


---@class PlayerConnectionService
PlayerConnectionService = PlayerConnectionService or {}

---@param playerId integer
local function SendKick(playerId)
	local player = PlayerResource:GetPlayer(playerId)
	if not player then
		return
	end
	CustomGameEventManager:Send_ServerToPlayer(player, "KickPlayer", {
		security_key = Security:GetSecurityKey(playerId),
		player_id = playerId,
	})
end

---@param playerId integer
local function EnsurePlayerPresence(playerId)
	Security:StartSendingSecurityKeyToPlayer(playerId)
	if GameRulesCustom:State_Get() == DOTA_GAMERULES_STATE_HERO_SELECTION then
		HeroSelectionService:EnsureHeroSelectionForPlayer(playerId)
	end
	HeroSelectionService:EnsureForcedHeroSpawned(playerId)
end

---@param uid string
---@param tag {code: string, name: string, colorHex: string, icon: string}|nil
local function UpdatePlayerTag(uid, tag)
	local playerTagTable = CustomNetTables:GetTableValue("service", "player_tag") or {}
	playerTagTable[uid] = {
		code = tag and tag.code or nil,
		name = tag and tag.name or nil,
		colorHex = tag and tag.colorHex or nil,
		icon = tag and tag.icon or nil,
	}
	CustomNetTables:SetTableValue("service", "player_tag", playerTagTable)
end

---@param uid string
---@param ratingInfos table<integer, {rating: integer, matchTypeCode: string, playTime: integer}>
local function UpdateRankTable(uid, ratingInfos)
	local playerRankTable = CustomNetTables:GetTableValue("service", "player_rank") or {}
	for _, ratingInfo in pairs(ratingInfos) do
		if GameMode:GetMatchType() == ratingInfo.matchTypeCode then
			playerRankTable[uid] = {
				score = ratingInfo.rating,
				play_time = ratingInfo.playTime,
			}
			CustomNetTables:SetTableValue("service", "player_rank", playerRankTable)
		end
	end
end

---@param uid string
---@param banned boolean|nil
local function KickBannedPlayer(uid, banned)
	if not banned then
		return
	end
	for playerId = 0, DOTA_MAX_TEAM_PLAYERS - 1 do
		if uid == GetSteamID(playerId) then
			if not PlayerResource:GetPlayer(playerId) then
				return
			end
			local bannedPlayersTable = CustomNetTables:GetTableValue("service", "banned_players") or {}
			table.insert(bannedPlayersTable, playerId)
			CustomNetTables:SetTableValue("service", "banned_players", bannedPlayersTable)
			SendKick(playerId)
		end
	end
end

---@param uid string
---@param bans {abilities: table<integer, string>, heroes: table<integer, string>}
local function UpdateRecentBans(uid, bans)
	logger:Log(string.format("Update NetTables recent bans for user %s started.", uid))
	local abilityBansTable = CustomNetTables:GetTableValue("service", "player_ban_ability") or {}
	local heroBansTable = CustomNetTables:GetTableValue("service", "player_ban_hero") or {}
	abilityBansTable[uid] = bans and bans.abilities or {}
	heroBansTable[uid] = bans and bans.heroes or {}
	CustomNetTables:SetTableValue("service", "player_ban_ability", abilityBansTable)
	CustomNetTables:SetTableValue("service", "player_ban_hero", heroBansTable)
	logger:Log(string.format("Update NetTables recent bans for user %s finished.", uid))
end

---@class BanPresetTable
---@field name string
---@field heroes table<integer, string>
---@field abilities table<integer, string>

---@param uid string
---@param banPresets table<integer, BanPresetTable>|nil
local function UpdateBanPresets(uid, banPresets)
	logger:Log(string.format("Update NetTables ban presets for user %s started.", uid))
	local banPresetsTable = CustomNetTables:GetTableValue("service", "player_ban_presets") or {}
	banPresetsTable[uid] = banPresets or {}
	CustomNetTables:SetTableValue("service", "player_ban_presets", banPresetsTable)
	logger:Log(string.format("Update NetTables ban presets for user %s finished.", uid))
end

---@param playerId integer
function PlayerConnectionService:HandleConnect(playerId)
	local uid = GetSteamID(playerId)
	logger:Logf("HandleConnect pid=%d state=%d", playerId, GameRulesCustom:State_Get())
	EnsurePlayerPresence(playerId)
	Settings:Apply(playerId, nil, true) -- инициализация дефолтов, если логин не пройдет
	if DevUtils:Check() then
		if Shop and Shop.ApplyLocalDevelopmentState then
			Shop:ApplyLocalDevelopmentState(playerId)
		end
		return
	end
	local loginToken = tostring(uid) .. "|" .. tostring(GameRules:GetGameTime())
	if Shop and Shop.SetShopAvailability then
		Shop.BackendLoginTokens[playerId] = loginToken
		Shop:SetShopAvailability(playerId, false, "loading")
		Timers:CreateTimer(15, function()
			if Shop and Shop.BackendLoginTokens and Shop.BackendLoginTokens[playerId] == loginToken then
				Shop.BackendLoginTokens[playerId] = nil
				Shop:SetShopAvailability(playerId, false, "unavailable")
			end
			return nil
		end)
	end
	PlayerOutboundApi:Login(uid, function(res)
		if Shop and Shop.BackendLoginTokens then
			Shop.BackendLoginTokens[playerId] = nil
		end
		if not res or (res.StatusCode ~= 200 and res.StatusCode ~= 204) then
			if Shop and Shop.SetShopAvailability then
				local status = res and res.StatusCode == 401 and "unauthorized" or "unavailable"
				Shop:SetShopAvailability(playerId, false, status)
			end
			return
		end
		local ok, resBody = pcall(function()
			return json.decode(res.Body)
		end)
		if not ok or type(resBody) ~= "table" then
			if Shop and Shop.SetShopAvailability then
				Shop:SetShopAvailability(playerId, false, "unavailable")
			end
			return
		end
		if Shop and Shop.SetShopAvailability then
			Shop:SetShopAvailability(playerId, true, "available")
		end
		KickBannedPlayer(uid, resBody.banned)
		UpdateRankTable(uid, resBody.ratingInfos)
		UpdateRecentBans(uid, resBody.bans)
		UpdateBanPresets(uid, resBody.banPresets)
		UpdatePlayerTag(uid, resBody.tag)
		Settings:Apply(playerId, resBody.settings, true)
		if Shop and Shop.ApplySubscriptionFromLogin then
			Shop:ApplySubscriptionFromLogin(playerId, resBody)
		end
		if Shop and Shop.ApplyInventoryFromLogin then
			Shop:ApplyInventoryFromLogin(playerId, resBody)
		end
	end)
end

---@param playerId integer
function PlayerConnectionService:HandleReconnect(playerId)
	logger:Logf("HandleReconnect pid=%d state=%d", playerId, GameRulesCustom:State_Get())
	EnsurePlayerPresence(playerId)
	AbilitySelectionService:ResumePendingSelection(playerId)
	AbilitySelectionService:ReEmit(playerId)
	local bannedPlayersTable = CustomNetTables:GetTableValue("service", "banned_players") or {}
	if table.contains(bannedPlayersTable, playerId) then
		SendKick(playerId)
	end
end

function PlayerConnectionService:MonitorConnections()
	Timers:CreateTimer(1.5, function()
		for teamId, team in pairs(GameMode:GetMatch():GetTeams()) do
			local allAbandoned = true
			for _, playerId in ipairs(team:GetPlayers()) do
				if PlayerResource:GetConnectionState(playerId) ~= DOTA_CONNECTION_STATE_ABANDONED then
					allAbandoned = false
				end
			end
			if allAbandoned and not self.loggedAllAbandoned then
				self.loggedAllAbandoned = true
				logger:Log(string.format("MonitorConnections: allAbandoned=true for teamID=%d", teamId))
			end
			if allAbandoned then
				team:SetAbandoned()
			end
		end

		local allDisconnected = true
		for playerID = 0, DOTA_MAX_TEAM_PLAYERS - 1 do
			if PlayerResource:GetConnectionState(playerID) == DOTA_CONNECTION_STATE_CONNECTED then
				allDisconnected = false
				break
			end
		end

		if allDisconnected and not self.loggedAllDisconnected then
			self.loggedAllDisconnected = true
			logger:Log("MonitorConnections: allDisconnected=true (no CONNECTED players)")
		end

		return 1
	end)
end