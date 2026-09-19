--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1a5b3bb 
  ~ auto-generated — do not edit
]]


if HeroSelectionService == nil then
	HeroSelectionService = class({})
end ---@class HeroSelectionService

---@class PlayerHeroSelectInfo
---@field herolist table<integer, string[]>
---@field page integer
---@field reroll_count integer
---@field rerollButtonEnabled boolean

function HeroSelectionService:Init()
	self.allHeroeNames = table.deepcopy(GameRulesCustom.heroesPoolList)
	self.PlayerHeroSelect = {} ---@type table<PlayerID, PlayerHeroSelectInfo>
	self.playerHeroList = {} ---@type table<PlayerID, string[]>
	self.heroNameToPlayerIdMap = {} ---@type table<string, PlayerID> [npc_dota_hero_axe]: PlayerID
	self.Hero = {} ---@type table<PlayerID, string> подтверждённый герой игрока
	self.spawning = {} ---@type table<PlayerID, boolean> идёт форс-создание героя (защита от гонки)
	self.forcedAt = {} ---@type table<PlayerID, number> старт грейс-окна ожидания форс-героя

	for i = 0, MAX_PLAYER_COUNT - 1 do
		if not PlayerResource:IsFakeClient(i) then
			self:InitPlayerState(i)
		end
	end
end

---@param playerId PlayerID
function HeroSelectionService:InitPlayerState(playerId)
	self.PlayerHeroSelect[playerId] = {
		herolist = {},
		page = 1,
		reroll_count = 1,
		rerollButtonEnabled = true,
	}
	self.playerHeroList[playerId] = {}
	self.Hero[playerId] = ""
end

---@return string|nil
function HeroSelectionService:RandomHeroFromPool()
	return table.random(self.allHeroeNames)
end

---@param playerId integer
function HeroSelectionService:GenerateHeroSelection(playerId)
	self.playerHeroList[playerId] = self.playerHeroList[playerId] or {}
	if #self.playerHeroList[playerId] > 0 then
		return
	end

	logger:Logf("Generate hero selection for playerId %d", playerId)
	local heroList = table.random_some(self.allHeroeNames, 7)
	if heroList == nil then
		return
	end

	for i = 1, #heroList do
		local heroName = heroList[i]
		table.remove_item(self.allHeroeNames, heroName)
		table.insert(self.playerHeroList[playerId], heroName)
		self.heroNameToPlayerIdMap[heroName] = playerId
	end
	self:RefreshHeroSelection(playerId, self.playerHeroList[playerId])
end

---@param playerId PlayerID
function HeroSelectionService:EnsureHeroSelectionForPlayer(playerId)
	if PlayerResource:IsFakeClient(playerId) or not PlayerResource:IsValidPlayer(playerId) then
		return
	end
	if not self.PlayerHeroSelect[playerId] then
		self:InitPlayerState(playerId)
	end
	self:GenerateHeroSelection(playerId)
end

function HeroSelectionService:EnsureHeroSelectionForAll()
	for playerId = 0, MAX_PLAYER_COUNT - 1 do
		if PlayerResource:GetConnectionState(playerId) == DOTA_CONNECTION_STATE_CONNECTED then
			self:EnsureHeroSelectionForPlayer(playerId)
		end
	end
end

function HeroSelectionService:InternalSelectHeroForPlayersIfNotLockedIn()
	logger:Logf("InternalSelectHeroForPlayersIfNotLockedIn start, state=%d", GameRulesCustom:State_Get())
	for playerID = 0, MAX_PLAYER_COUNT - 1 do
		if PlayerResource:IsFakeClient(playerID) then
			goto continue
		end
		if not PlayerResource:IsValidPlayer(playerID) then
			goto continue
		end
		if self.Hero[playerID] ~= "" then
			goto continue
		end
		local heroList = self.playerHeroList[playerID]
		if not heroList or not heroList[1] then
			goto continue
		end
		self:ForceSelectHero(playerID, heroList[1])

		::continue::
	end
end

---@param playerID PlayerID
---@param heroName string
function HeroSelectionService:ForceSelectHero(playerID, heroName)
	self.Hero[playerID] = heroName
	logger:Logf(
		"ForceSelectHero pid=%d hero=%s hasController=%s connState=%d",
		playerID,
		heroName,
		tostring(PlayerResource:GetPlayer(playerID) ~= nil),
		PlayerResource:GetConnectionState(playerID)
	)
	self:ApplySelectedHero(playerID, heroName)
end

local FORCED_HERO_GRACE_SECONDS = 30

---@param playerId PlayerID
---@return boolean
function HeroSelectionService:HasPendingForcedHero(playerId)
	local forced = self.Hero[playerId]
	if not forced or forced == "" then
		return false
	end
	if PlayerResource:GetSelectedHeroEntity(playerId) then
		self.forcedAt[playerId] = nil
		return false
	end
	if PlayerResource:GetConnectionState(playerId) == DOTA_CONNECTION_STATE_ABANDONED then
		return false
	end

	local now = GameRulesCustom:GetGameTime()
	if not self.forcedAt[playerId] then
		self.forcedAt[playerId] = now
	end
	return (now - self.forcedAt[playerId]) <= FORCED_HERO_GRACE_SECONDS
end

---@param playerID PlayerID
function HeroSelectionService:EnsureForcedHeroSpawned(playerID)
	local forced = self.Hero[playerID]
	local hasHero = PlayerResource:GetSelectedHeroEntity(playerID) ~= nil
	logger:Logf(
		"EnsureForcedHeroSpawned pid=%d forced=%s hasHero=%s connState=%d",
		playerID,
		tostring(forced),
		tostring(hasHero),
		PlayerResource:GetConnectionState(playerID)
	)
	if not forced or forced == "" then
		return
	end
	if hasHero then
		return
	end
	self:ApplySelectedHero(playerID, forced)
end

---@param playerID PlayerID
---@param heroName string
function HeroSelectionService:ApplySelectedHero(playerID, heroName)
	logger:Logf(
		"ApplySelectedHero pid=%d hero=%s hasController=%s hasHero=%s spawning=%s",
		playerID,
		tostring(heroName),
		tostring(PlayerResource:GetPlayer(playerID) ~= nil),
		tostring(PlayerResource:GetSelectedHeroEntity(playerID) ~= nil),
		tostring(self.spawning[playerID] == true)
	)
	if not PlayerResource:GetPlayer(playerID) then
		return
	end
	if PlayerResource:GetSelectedHeroEntity(playerID) then
		return
	end
	if self.spawning[playerID] then
		return
	end
	self.spawning[playerID] = true

	GameRulesCustom:RemoveHeroFromBlacklist(heroName)

	PrecacheUnitByNameAsync(heroName, function()
		self.spawning[playerID] = nil
		if PlayerResource:GetSelectedHeroEntity(playerID) then
			logger:Logf("ApplySelectedHero pid=%d precache done, hero already exists — skip create", playerID)
			return
		end
		local player = PlayerResource:GetPlayer(playerID)
		if not player then
			logger:Logf("ApplySelectedHero pid=%d precache done, but no controller — abort", playerID)
			return
		end

		local teamId = PlayerResource:GetTeam(playerID)
		if not GameMode:GetMatch():IsTeamAlive(teamId) then
			logger:Logf("ApplySelectedHero pid=%d team=%d already lost — skip create", playerID, teamId)
			return
		end

		local hero = CreateHeroForPlayer(heroName, player)
		if not IsValid(hero) then
			logger:LogError(
				string.format("ApplySelectedHero pid=%d CreateHeroForPlayer(%s) returned invalid", playerID, heroName)
			)
			return
		end ---@cast hero CDOTA_BaseNPC_Hero

		-- CreateHeroForPlayer не назначает героя игроку — привязываем явно
		player:SetAssignedHeroEntity(hero)

		if teamId ~= DOTA_TEAM_NOTEAM then
			hero:SetTeam(teamId)
		end
		hero:SetControllableByPlayer(playerID, true)
		if not hero:IsAlive() then
			hero:RespawnHero(false, false)
		end

		-- CreateHeroForPlayer не поднимает dota_on_hero_finish_spawn — инициализируем вручную
		HeroBuilderService:OnHeroFinishSpawn({ heroindex = hero:entindex() })

		if GameRulesCustom:State_Get() >= DOTA_GAMERULES_STATE_GAME_IN_PROGRESS then
			HeroPlacementService:MoveHeroToCenter(playerID)
		end

		logger:Logf(
			"ApplySelectedHero pid=%d created hero=%s ent=%d alive=%s team=%d assigned=%s",
			playerID,
			heroName,
			hero:entindex(),
			tostring(hero:IsAlive()),
			hero:GetTeamNumber(),
			tostring(PlayerResource:GetSelectedHeroEntity(playerID) ~= nil)
		)
	end, playerID)

	CustomGameEventManager:Send_ServerToAllClients("update_hero_select_state", {
		heroName = heroName,
		PlayerID = playerID,
	})
end

---@param heroName string
function HeroSelectionService:OnHeroBan(heroName)
	table.remove_item(self.allHeroeNames, heroName)
	if not self.heroNameToPlayerIdMap[heroName] then
		return
	end

	local playerId = self.heroNameToPlayerIdMap[heroName]
	local newHero = table.random(self.allHeroeNames)
	logger:Logf("NewHero = %s", newHero)
	self.heroNameToPlayerIdMap[heroName] = nil
	if newHero then
		table.remove_item(self.allHeroeNames, newHero)
		self.heroNameToPlayerIdMap[newHero] = playerId
	end
	for i = 1, #self.playerHeroList[playerId] do
		if self.playerHeroList[playerId][i] == heroName then
			self.playerHeroList[playerId][i] = newHero
			break
		end
	end
	self:RefreshHeroSelection(playerId, self.playerHeroList[playerId])
end

---@param event any
function HeroSelectionService:OnRerollHeroes(event)
	logger:Log("RerollHeroes call.")
	local playerId = event.PlayerID
	if playerId ~= nil and playerId ~= -1 then
		if self.PlayerHeroSelect[playerId].rerollButtonEnabled == true then
			local playerHeroSelect = self.PlayerHeroSelect[playerId]
			playerHeroSelect.page = playerHeroSelect.page + 1
			playerHeroSelect.rerollButtonEnabled = playerHeroSelect.reroll_count == playerHeroSelect.page + 1
			self.PlayerHeroSelect[playerId] = playerHeroSelect
			self:UpdateHeroSelectNetTable(playerId)
		end
	end
end

---@param playerId PlayerID
function HeroSelectionService:UpdateHeroSelectNetTable(playerId)
	logger:Logf("NetTable was updated")
	PrintTable(self.PlayerHeroSelect[playerId])
	CustomNetTables:SetTableValue("hero_select", tostring(playerId), self.PlayerHeroSelect[playerId])
end

---@param playerId PlayerID
---@param choice any
function HeroSelectionService:RefreshHeroSelection(playerId, choice)
	for i = 1, self.PlayerHeroSelect[playerId].reroll_count + 1 do
		self.PlayerHeroSelect[playerId].herolist[i] = { choice[1] }
		for j = (i - 1) * 3 + 2, i * 3 + 1 do
			table.insert(self.PlayerHeroSelect[playerId].herolist[i], choice[j])
		end
	end
	self:UpdateHeroSelectNetTable(playerId)
end

---@param event {heroName: string, PlayerID: PlayerID}
function HeroSelectionService:OnHeroSelected(event)
	logger:Logf("OnHeroSelected call. HeroName = %s", event.heroName)
	local heroName = event.heroName
	local playerId = event.PlayerID
	local player = PlayerResource:GetPlayer(playerId)

	if not player then
		logger:Log("HeroSelected, but hPlayer is null")
		return
	end

	if not DevUtils:Check() then
		local currentPage = self.PlayerHeroSelect[playerId].page
		if not table.contains(self.PlayerHeroSelect[playerId].herolist[currentPage], heroName) then
			return
		end
	end

	GameRulesCustom:RemoveHeroFromBlacklist(heroName)
	self.Hero[playerId] = heroName
	player:SetSelectedHero(heroName)
	CustomGameEventManager:Send_ServerToAllClients("update_hero_select_state", {
		heroName = heroName,
		PlayerID = playerId,
	})
end