--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1a5b3bb 
  ~ auto-generated — do not edit
]]


local SelectState = require("service.ability.ability_select_state")
local AbilityExclusions = require("service.ability.ability_exclusions")

if AbilitySelectionService == nil then
	AbilitySelectionService = class({})
end ---@class AbilitySelectionService

local RELEARN_SOURCE_ITEMS = {
	item_relearn_book_lua = true,
	item_relearn_torn_page_lua = true,
}
local DEFAULT_SOURCE_ITEM = "item_relearn_book_lua"

function AbilitySelectionService:Init()
	---@type table<PlayerID, table>
	self.state = {}
	---@type table<PlayerID, string>
	self.pendingSource = {}

	for i = 0, MAX_PLAYER_COUNT - 1 do
		if not PlayerResource:IsFakeClient(i) then
			self.state[i] = {
				state = SelectState.NONE,
				abilitylist = {},
			}
		end
	end
end

---@param playerId PlayerID
---@return table|nil
function AbilitySelectionService:GetSelection(playerId)
	return self.state[playerId]
end

---@param playerId PlayerID
---@return integer|nil
function AbilitySelectionService:GetStateId(playerId)
	local selection = self.state[playerId]
	return selection and selection.state or nil
end

---@param playerId PlayerID
---@param stateId integer
---@return boolean
function AbilitySelectionService:IsState(playerId, stateId)
	return self:GetStateId(playerId) == stateId
end

---@param playerId PlayerID
---@return boolean
function AbilitySelectionService:IsIdle(playerId)
	return self:GetStateId(playerId) == SelectState.NONE
end

---Возвращает количество навыков, которые игрок может выбрать
---@param playerId integer
---@return integer
function AbilitySelectionService:GetPlayerAbilityCount(playerId)
	local hHero = PlayerResource:GetSelectedHeroEntity(playerId)

	if IsValid(hHero) then ---@cast hHero CDOTA_BaseNPC_Hero
		if hHero.abilitiesList ~= nil then
			return #hHero.abilitiesList
		else
			return 0
		end
	else
		return 6
	end
end

--- Валидированное имя предмета-источника (или дефолт).
---@param sourceItem string|nil
---@return string
function AbilitySelectionService:ValidateSource(sourceItem)
	if type(sourceItem) == "string" and RELEARN_SOURCE_ITEMS[sourceItem] then
		return sourceItem
	end
	return DEFAULT_SOURCE_ITEM
end

---@param playerId PlayerID
---@return string
function AbilitySelectionService:GetPendingSourceItem(playerId)
	return self.pendingSource[playerId] or DEFAULT_SOURCE_ITEM
end

---@param playerId PlayerID
---@param selection table
function AbilitySelectionService:Commit(playerId, selection)
	self.state[playerId] = selection
	CustomNetTables:SetTableValue("ability_select", tostring(playerId), selection)
end

---@param playerId PlayerID
function AbilitySelectionService:Reset(playerId)
	self.pendingSource[playerId] = nil
	self:Commit(playerId, {
		state = SelectState.NONE,
		abilitylist = {},
	})
end

---@param playerId PlayerID
---@param sourceItem string
function AbilitySelectionService:BeginRemove(playerId, sourceItem)
	self.pendingSource[playerId] = self:ValidateSource(sourceItem)
	self:ShowCurrentAbilitySelection(playerId, SelectState.REMOVE)
end

--- Переотправить текущее состояние выбора клиенту (реконнект). Нет-таблица персистит, но
--- Panorama-listener срабатывает только на ИЗМЕНЕНИЕ, а начальное чтение может прийтись на
--- момент до синка — поэтому форсим повторную запись с запасом по времени.
---@param playerId PlayerID
function AbilitySelectionService:ReEmit(playerId)
	local resend = function()
		local selection = self.state[playerId]
		if selection then
			CustomNetTables:SetTableValue("ability_select", tostring(playerId), selection)
		end
	end
	Timers:CreateTimer(0.5, function()
		resend()
	end)
	Timers:CreateTimer(1.5, function()
		resend()
	end)
end

-- переигрывает предложение выбора, пропущенное пока игрок был отключён (ReEmit шлёт только текущий state)
---@param playerId PlayerID
function AbilitySelectionService:ResumePendingSelection(playerId)
	if not self:IsIdle(playerId) then
		return
	end

	local hero = PlayerResource:GetSelectedHeroEntity(playerId)
	if not hero then
		return
	end

	hero.abilitiesList = hero.abilitiesList or {}
	if #hero.abilitiesList < AbilityQuota:GetTotal(playerId) then
		self:ShowRandomAbilitySelection(playerId)
	end
end

---@type table<PlayerID, string[]>
local playerRecentAbilities = {}

local SELECTION_ABILITIES_COUNT = 10
local MAX_STORED_ABILITIES = SELECTION_ABILITIES_COUNT * 4

---@param allAbilities string[]
---@param ownAbilities string[] | nil
---@param abilityName string
local function RemoveAbilityFromPools(allAbilities, ownAbilities, abilityName)
	table.remove_item(allAbilities, abilityName)
	if ownAbilities then
		table.remove_item(ownAbilities, abilityName)
	end
end

---@param allAbilities string[]
---@param ownAbilities string[] | nil
---@param abilityNames string[] | nil
local function RemoveAbilityListFromPools(allAbilities, ownAbilities, abilityNames)
	if not abilityNames then
		return
	end

	for _, abilityName in ipairs(abilityNames) do
		RemoveAbilityFromPools(allAbilities, ownAbilities, abilityName)
	end
end

---@param allAbilities string[]
---@param ownAbilities string[] | nil
---@param abilityName string
local function RemoveAbilityWithExclusionsFromPools(allAbilities, ownAbilities, abilityName)
	RemoveAbilityFromPools(allAbilities, ownAbilities, abilityName)

	if not AbilityExclusions.byAbility[abilityName] then
		return
	end

	for _, exclusionAbilityName in ipairs(AbilityExclusions.byAbility[abilityName]) do
		RemoveAbilityFromPools(allAbilities, ownAbilities, exclusionAbilityName)
	end
end

---@param hero CDOTA_BaseNPC_Hero
---@param allAbilities string[]
---@param ownAbilities string[] | nil
---@param abilityName string
local function RemoveFacetReplacedAbilitiesFromPools(hero, allAbilities, ownAbilities, abilityName)
	if not hero.facetReplaceAbility then
		return
	end

	for originAbilityName, replacedAbilityName in pairs(hero.facetReplaceAbility) do
		if abilityName == replacedAbilityName then
			RemoveAbilityFromPools(allAbilities, ownAbilities, originAbilityName)
		end
	end
end

---@param hero CDOTA_BaseNPC_Hero
---@param allAbilities string[]
---@param ownAbilities string[] | nil
local function RemoveHeroCurrentAbilitiesFromPools(hero, allAbilities, ownAbilities)
	for i = 0, hero:GetAbilityCount() - 1 do
		local ability = hero:GetAbilityByIndex(i)
		if ability then
			local abilityName = ability:GetAbilityName()
			RemoveAbilityFromPools(allAbilities, ownAbilities, abilityName)
			RemoveFacetReplacedAbilitiesFromPools(hero, allAbilities, ownAbilities, abilityName)
		end
	end
end

---@param hero CDOTA_BaseNPC_Hero
---@param allAbilities string[]
---@param ownAbilities string[] | nil
local function RemoveHeroSelectedAbilitiesFromPools(hero, allAbilities, ownAbilities)
	if hero.abilitiesList == nil then
		hero.abilitiesList = {}
	end

	for _, abilityName in ipairs(hero.abilitiesList) do --todo подумать можно ли отказаться от этого
		RemoveAbilityWithExclusionsFromPools(allAbilities, ownAbilities, abilityName)
	end
end

---@param allAbilities string[]
---@param ownAbilities string[]
---@return string[]
local function GetRandomAbilityNames(allAbilities, ownAbilities)
	if RandomInt(1, 100) >= 90 or #ownAbilities == 0 then
		return table.random_some(allAbilities, SELECTION_ABILITIES_COUNT)
	end

	local randomOwnAbility = table.random_some(ownAbilities, 1)[1]

	table.remove_item(allAbilities, randomOwnAbility)

	local randomAbilities = table.random_some(allAbilities, SELECTION_ABILITIES_COUNT - 1)
	table.insert(randomAbilities, 1, randomOwnAbility)
	return randomAbilities
end

---@param randomAbilityNames string[]
---@param player CDOTAPlayerController
---@return {ability_name: string, linked_abilities: string}[]
local function BuildAbilitySelectionData(randomAbilityNames, player)
	local dataList = {}

	for _, randomAbilityName in pairs(randomAbilityNames) do
		local data = {
			ability_name = randomAbilityName,
		}

		local linkedAbilities = AbilityPool:GetLinkedAbilities(randomAbilityName)
		if linkedAbilities then
			data.linked_abilities = linkedAbilities
		end
		table.insert(dataList, data)

		CustomGameEventManager:Send_ServerToPlayer(player, "RegisterHoverableAbility", {
			ability_name = randomAbilityName,
		})
	end

	return dataList
end

---@param playerId PlayerID
---@param abilities string[]
local function RememberRecentAbilities(playerId, abilities)
	playerRecentAbilities[playerId] = playerRecentAbilities[playerId] or {}
	local recent = playerRecentAbilities[playerId]

	for _, abilityName in ipairs(abilities) do
		table.insert(recent, 1, abilityName)
	end

	while #recent > MAX_STORED_ABILITIES do
		table.remove(recent)
	end
end

---@param playerId PlayerID
---@param allAbilities string[]
---@param ownAbilities string[] | nil
local function RemoveRecentAbilities(playerId, allAbilities, ownAbilities)
	local recent = playerRecentAbilities[playerId]
	if not recent then
		return
	end

	for _, abilityName in ipairs(recent) do
		RemoveAbilityFromPools(allAbilities, nil, abilityName)
	end
end

---@param hero CDOTA_BaseNPC_Hero
---@param allAbilities string[]
---@param ownAbilities string[] | nil
local function ApplyCommonAbilityPoolFilters(hero, allAbilities, ownAbilities)
	RemoveHeroCurrentAbilitiesFromPools(hero, allAbilities, ownAbilities)
	RemoveHeroSelectedAbilitiesFromPools(hero, allAbilities, ownAbilities)
	RemoveAbilityListFromPools(allAbilities, ownAbilities, AbilityExclusions.byHeroModel[hero:GetUnitName()])
	local banAbilities = {} ---@type string[]
	for abilityName, _ in pairs(Pass.banAbilitiesMap) do
		table.insert(banAbilities, abilityName)
	end
	RemoveAbilityListFromPools(allAbilities, ownAbilities, banAbilities)
	RemoveRecentAbilities(hero:GetPlayerID(), allAbilities, ownAbilities)
end

---@param playerId integer
---@param exceptAbilityName string | nil
function AbilitySelectionService:ShowRandomAbilitySelection(playerId, exceptAbilityName)
	logger:Log("[ShowRandomAbilitySelection] call.")
	local hero = PlayerResource:GetSelectedHeroEntity(playerId)

	if not hero then
		return
	end

	local player = PlayerResource:GetPlayer(playerId)
	if not player then
		return
	end

	if not self:IsIdle(playerId) then
		return
	end

	local allAbilities = AbilityPool:CopyAllAbilities()
	local ownAbilities = AbilityPool:CopyHeroAbilityPool(hero:GetUnitName())

	if exceptAbilityName ~= nil and type(exceptAbilityName) == "string" then
		RemoveAbilityFromPools(allAbilities, ownAbilities, exceptAbilityName)
	end

	ApplyCommonAbilityPoolFilters(hero, allAbilities, ownAbilities)

	local randomAbilityNames = GetRandomAbilityNames(allAbilities, ownAbilities)
	RememberRecentAbilities(playerId, randomAbilityNames)

	local dataList = BuildAbilitySelectionData(randomAbilityNames, player)

	self:Commit(playerId, {
		state = SelectState.ADD,
		abilitylist = dataList,
		no_earlier = GameRulesCustom:GetGameTime() + 0.7,
	})
end

---@param playerId integer
---@return string | nil
function AbilitySelectionService:ChooseRandomOneAbility(playerId)
	local hero = PlayerResource:GetSelectedHeroEntity(playerId)
	if not IsValid(hero) then
		error("[AbilitySelectionService:ChooseRandomOneAbility] hHero is not valid")
	end ---@cast hero CDOTA_BaseNPC_Hero

	local allAbilities = AbilityPool:CopyAllAbilities()
	ApplyCommonAbilityPoolFilters(hero, allAbilities)
	local ability = table.random(allAbilities)
	RememberRecentAbilities(playerId, { ability })
	return ability
end

---@param playerId integer
---@param stateId any REMOVE / HIDE
function AbilitySelectionService:ShowCurrentAbilitySelection(playerId, stateId)
	local hero = PlayerResource:GetSelectedHeroEntity(playerId)
	if not IsValid(hero) then
		return
	end ---@cast hero CDOTA_BaseNPC_Hero
	if not self:IsIdle(playerId) then
		return
	end
	local abilitylist = {}

	for i = 0, hero:GetAbilityCount() - 1 do
		local ability = hero:GetAbilityByIndex(i)
		if ability ~= nil and not ability:IsHidden() and AbilityPool:Contains(ability:GetAbilityName()) then
			table.insert(abilitylist, { ability_name = ability:GetAbilityName() })
		end
	end

	self:Commit(playerId, {
		state = stateId,
		abilitylist = abilitylist,
	})
end

---@param event {ability_name: string|nil, PlayerID: PlayerID}
function AbilitySelectionService:OnAbilitySelected(event)
	local abilityName = event.ability_name
	local playerId = event.PlayerID
	local random = false
	local hero = PlayerResource:GetSelectedHeroEntity(playerId)

	if not IsValid(hero) then ---@cast hero CDOTA_BaseNPC_Hero
		logger:Log("Hero is null")
		return
	end

	local selection = self:GetSelection(playerId)

	if selection ~= nil and selection.no_earlier ~= nil and selection.no_earlier >= GameRulesCustom:GetGameTime() then
		logger:Log("Select no earlier than " .. selection.no_earlier)
		return
	end

	if selection == nil or selection.state == nil then
		logger:Log("No state")
		return
	end

	if selection.state ~= SelectState.ADD then
		logger:Log("Try add ability on other state")
		return
	end

	if abilityName == nil then
		logger:Log("Player choose random ability selection")
		random = true
		abilityName = self:ChooseRandomOneAbility(playerId)
	end

	if abilityName == nil then
		return
	end

	if self:GetPlayerAbilityCount(playerId) >= AbilityQuota:GetTotal(playerId) then
		logger:Log("Ability number reach total")
		return
	end

	local isValidChoice = random or false
	for _, data in pairs(selection.abilitylist) do
		if data.ability_name == abilityName then
			isValidChoice = true
			break
		end
	end

	if hero.abilitiesList == nil then
		hero.abilitiesList = {}
	end
	for _, sName in pairs(hero.abilitiesList) do
		if abilityName == sName then
			isValidChoice = false
			break
		end
	end

	if hero:HasAbility(abilityName) then
		isValidChoice = false
	end

	if isValidChoice then
		table.insert(hero.abilitiesList, abilityName)

		HeroBuilderService:AddAbility(playerId, abilityName)

		if
			self:GetPlayerAbilityCount(playerId) == AbilityQuota:GetTotal(playerId)
			and PlayerResource:GetPlayer(playerId)
		then
			local hPlayer = PlayerResource:GetPlayer(playerId)
			if self:GetPlayerAbilityCount(playerId) == 2 then
				Notifications:Bottom(hPlayer, {
					text = "#next_ability_round_3",
					duration = 5,
					style = { color = "Red" },
				})
			end
			if self:GetPlayerAbilityCount(playerId) == 3 then
				Notifications:Bottom(hPlayer, {
					text = "#next_ability_round_6",
					duration = 5,
					style = { color = "Red" },
				})
			end
			if self:GetPlayerAbilityCount(playerId) == 4 then
				Notifications:Bottom(hPlayer, {
					text = "#next_ability_round_9",
					duration = 5,
					style = { color = "Red" },
				})
			end
		end
	end
end

---@param event {ability_name: string | nil, PlayerID: PlayerID}
function AbilitySelectionService:OnRelearnBookAbilitySelected(event)
	self:ResolveRelearnBookSelection(event.PlayerID, event.ability_name)
end

---@param playerId PlayerID
---@param abilityName string | nil
function AbilitySelectionService:ResolveRelearnBookSelection(playerId, abilityName)
	local sourceItem = self:GetPendingSourceItem(playerId)

	if not self:IsState(playerId, SelectState.REMOVE) then
		logger:Log("Try remove ability on other state")
		return
	end

	local hero = PlayerResource:GetSelectedHeroEntity(playerId)

	if not IsValid(hero) then
		return
	end ---@cast hero CDOTA_BaseNPC_Hero

	if abilityName == "ancient_apparition_ice_blast" then
		local hAbility = hero:FindAbilityByName(abilityName)
		if hAbility and hAbility:IsHidden() then
			abilityName = nil
		end
	end

	if not table.contains(hero.abilitiesList, abilityName) then
		abilityName = nil
	end

	if abilityName == nil and self:IsState(playerId, SelectState.REMOVE) then
		logger:Log(
			string.format(
				"Player cancel relearn book ability selection. AbilityName = %s. State = %d",
				abilityName,
				SelectState.REMOVE
			)
		)
		local item = hero:AddItemByName(sourceItem)
		item:SetPurchaseTime(0)

		local playerBookStats = GameMode:GetMatch():GetPlayerBookStats(playerId) or {}
		playerBookStats[sourceItem] = (playerBookStats[sourceItem] or 0) - 1
		GameMode:GetMatch():SetPlayerBookStats(playerId, playerBookStats)
		CustomNetTables:SetTableValue("player_books", tostring(playerId), playerBookStats)

		self:Reset(playerId)
		return
	end

	local isFoundSomeWhere = false

	local hAbility = hero:FindAbilityByName(abilityName)
	if hAbility and hAbility.removalTimer == nil then
		local nAbilityLevel = hAbility:GetLevel()

		HeroBuilderService:RemoveAbility(playerId, abilityName)

		table.remove_item(hero.abilitiesList, abilityName)

		local nAbilityPoints = hero:GetAbilityPoints()
		nAbilityPoints = nAbilityPoints + nAbilityLevel
		hero:SetAbilityPoints(nAbilityPoints)
		isFoundSomeWhere = true
	end

	HeroBuilderService:RefreshAbilityOrder(playerId)
	self:Reset(playerId)

	-- Найти этот навык в панели умений или в свитке.
	if isFoundSomeWhere then
		self:ShowRandomAbilitySelection(playerId, abilityName)
	end
end