--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1a5b3bb 
  ~ auto-generated — do not edit
]]


if DebugTool == nil then
	DebugTool = class({})
	---@alias DebugToolEvent {PlayerID:number,Unit:CDOTA_BaseNPC,Position:Vector,arg:string}
end

local DEBUG_FUTURE_ROUND_LIMIT = 100
local DEBUG_FUTURE_ROUND_CHUNK_SIZE = 20
local DEBUG_FUTURE_ROUND_CHUNK_COUNT = math.ceil(DEBUG_FUTURE_ROUND_LIMIT / DEBUG_FUTURE_ROUND_CHUNK_SIZE)

function DebugTool:Init()
	GameListener:SubscribeProtected("debug_tool_command", function(...)
		local event = nil
		for _, value in ipairs({ ... }) do
			if type(value) == "table" then
				event = value
				break
			end
		end
		if type(event) ~= "table" then
			return
		end

		if not (GameRules:IsCheatMode() or Debugger:IsAdmin(PlayerResource:GetSteamAccountID(event.PlayerID))) then
			local message = string.format(
				"<font color='#fc030f'>Обнаружена попытка использования запрещенного функционала от игрока %s</font>",
				PlayerResource:GetPlayerName(event.PlayerID)
			)
			GameRulesCustom:SendCustomMessage(message, 0, 0)
			return
		end

		local sCommand = event.command
		local iPlayerID = event.player_id or -1
		local hUnit = EntIndexToHScript(event.unit or -1)
		local vPosition = event.position and Vector(event.position["0"], event.position["1"], event.position["2"])
		local sArg = event.arg
		if type(sCommand) == "string" and type(DebugTool[sCommand]) == "function" then
			DebugTool[sCommand](DebugTool, {
				callerPlayerId = event.PlayerID,
				PlayerID = iPlayerID,
				Unit = hUnit,
				Position = vPosition,
				arg = sArg,
			})
		end
	end)
end

---@param event DebugToolEvent
function DebugTool:SetGameSpeed(event)
	SendToServerConsole("host_timescale " .. event.arg)
end

---@param event DebugToolEvent
function DebugTool:JumpToRound(event)
	local units = FindUnitsInRadius(
		DOTA_TEAM_NEUTRALS,
		Vector(0, 0, 0),
		nil,
		FIND_UNITS_EVERYWHERE,
		DOTA_UNIT_TARGET_TEAM_FRIENDLY,
		DOTA_UNIT_TARGET_ALL,
		DOTA_UNIT_TARGET_FLAG_NONE,
		FIND_ANY_ORDER,
		false
	)
	for _, unit in pairs(units) do
		if IsValid(unit) then
			unit:ForceKill(false)
		end
	end
	local currentRound = GameMode:GetMatch():GetCurrentRound()
	if currentRound then
		currentRound:End()
	end
	GameMode:GetMatch():StartRound(tonumber(event.arg))
	self:UpdateFutureRoundsNetTable()
end

---@param roundData table
---@return table
local function BuildDebugRoundCreatureList(roundData)
	local creatures = {}
	for index, unitData in pairs(roundData or {}) do
		creatures[tostring(index)] = {
			name = unitData.unitName or "",
			count = tonumber(unitData.unitNumber) or 0,
		}
	end
	return creatures
end

---@param event DebugToolEvent
function DebugTool:GetFutureRounds(event)
	self:UpdateFutureRoundsNetTable()
end

function DebugTool:UpdateFutureRoundsNetTable()
	local entries = {}

	for index = 1, DEBUG_FUTURE_ROUND_LIMIT do
		local roundNumber = index
		local round = GameMode.RoundList and GameMode.RoundList[roundNumber]
		if round and round.RoundName and round.RoundData then
			table.insert(entries, {
				number = roundNumber,
				name = "#" .. round.RoundName,
				count = CountCreatures(round.RoundData),
				creatures = BuildDebugRoundCreatureList(round.RoundData),
			})
		end
	end

	for chunkIndex = 1, DEBUG_FUTURE_ROUND_CHUNK_COUNT do
		local chunkEntries = {}
		local chunkStart = (chunkIndex - 1) * DEBUG_FUTURE_ROUND_CHUNK_SIZE + 1
		local chunkEnd = math.min(chunkStart + DEBUG_FUTURE_ROUND_CHUNK_SIZE - 1, #entries)

		for entryIndex = chunkStart, chunkEnd do
			table.insert(chunkEntries, entries[entryIndex])
		end

		CustomNetTables:SetTableValue("rounds", "debug_future_rounds_" .. chunkIndex, {
			entries = chunkEntries,
		})
	end

	CustomNetTables:SetTableValue("rounds", "debug_future_rounds_meta", {
		total = #entries,
		chunk_count = DEBUG_FUTURE_ROUND_CHUNK_COUNT,
		chunk_size = DEBUG_FUTURE_ROUND_CHUNK_SIZE,
	})
end

---@param event DebugToolEvent
function DebugTool:StopRound(event)
	local currentRound = GameMode:GetMatch():GetCurrentRound()
	if currentRound then
		for _, spawner in pairs(currentRound.spawners) do
			spawner.isForceStop = true
		end
	end

	local units = FindUnitsInRadius(
		DOTA_TEAM_NEUTRALS,
		Vector(0, 0, 0),
		nil,
		FIND_UNITS_EVERYWHERE,
		DOTA_UNIT_TARGET_TEAM_FRIENDLY,
		DOTA_UNIT_TARGET_ALL,
		DOTA_UNIT_TARGET_FLAG_NONE,
		FIND_ANY_ORDER,
		false
	)
	for _, unit in pairs(units) do
		if IsValid(unit) then
			unit:ForceKill(false)
		end
	end
	if currentRound then
		currentRound:End()
		for _, spawner in pairs(currentRound.spawners) do
			spawner:Finish()
		end
	end
	HeroPlacementService:MoveHeroToCenter(event.PlayerID, true)
end

---@param event DebugToolEvent
function DebugTool:ClearAbilities(event)
	local unit = event.Unit
	if not unit then
		return
	end

	for i = 0, unit:GetAbilityCount() - 1 do
		local abiility = unit:GetAbilityByIndex(i)
		if not abiility then
			goto continue
		end

		local abilityName = abiility:GetAbilityName()
		local isInnate = abiility:GetAbilityKeyValues().Innate or 0
		local isBehaviorHidden = abiility:HasBehavior(DOTA_ABILITY_BEHAVIOR_HIDDEN)
		local isSpecialBonus = string.startsWith(abilityName, "special_bonus_")
		local isEmpty = string.startsWith(abilityName, "empty")

		logger:Log(
			string.format(
				"AbilityName = %s. IsInnate %d. IsSpecial = %d. IsEmpty = %d. isBehaviorHidden = %d.",
				abilityName,
				isInnate,
				isSpecialBonus,
				isEmpty,
				isBehaviorHidden
			)
		)

		if not (isInnate == 1 or isBehaviorHidden == 1 or isSpecialBonus == 1 or isEmpty == 1) then
			HeroBuilderService:RemoveAbility(event.PlayerID, abiility:GetAbilityName(), unit)
		end
		::continue::
	end
end

---@param event DebugToolEvent
function DebugTool:ClearInventory(event)
	local hUnit = event.Unit
	if IsValid(hUnit) and hUnit:HasInventory() then
		for i = DOTA_ITEM_SLOT_1, DOTA_ITEM_SLOT_9 do
			local hItem = hUnit:GetItemInSlot(i)
			if IsValid(hItem) then
				hUnit:TakeItem(hItem)
				UTIL_Remove(hItem)
			end
		end
	end
end

---@param event DebugToolEvent
function DebugTool:AddAbility(event)
	if not event.Unit:HasAbility(event.arg) then
		HeroBuilderService:AddAbility(event.PlayerID, event.arg, nil, nil, event.Unit)
		table.insert(event.Unit.abilitiesList, event.arg)
		AbilityQuota:AddTotal(event.PlayerID, 1)
	else
		local points = event.Unit:GetAbilityPoints()
		local level = 0
		if
			event.Unit:FindAbilityByName(event.arg) ~= nil
			and event.Unit:FindAbilityByName(event.arg).GetLevel ~= nil
		then
			level = event.Unit:FindAbilityByName(event.arg):GetLevel()
		end
		event.Unit:SetAbilityPoints(points + level)
		HeroBuilderService:RemoveAbility(event.PlayerID, event.arg, event.Unit)
		table.remove_item(event.Unit.abilitiesList, event.arg)
		AbilityQuota:AddTotal(event.PlayerID, -1)
	end
end

---@param event DebugToolEvent
function DebugTool:ReplaceHero(event)
	local iEntIndex = event.Unit:entindex()
	if type(event.Unit.FindAllModifiers) == "function" then
		for k, v in pairs(event.Unit:FindAllModifiers()) do
			if IsValid(v) then
				v:Destroy()
			end
		end
	end
	local GoldOriginal = event.Unit:GetGold()
	local hHeroOrigin = PlayerResource:GetSelectedHeroEntity(event.PlayerID)
	if IsValid(hHeroOrigin) then
		PrecacheUnitByNameAsync(event.arg, function()
			local hHero = PlayerResource:ReplaceHeroWith(event.PlayerID, event.arg, GoldOriginal, 0)
			HeroBuilderService:InitPlayerHeroDebug(hHero)
			AbilitySelectionService:ShowRandomAbilitySelection(event.PlayerID)
		end)
	end
end

---@param event DebugToolEvent
function DebugTool:ControlUnitButtonPressed(event)
	if event.Unit then
		if event.Unit:IsControllableByAnyPlayer() then
			event.Unit:SetControllableByPlayer(-1, true)
		else
			event.Unit:SetControllableByPlayer(event.PlayerID, true)
		end
	end
end

---@param event DebugToolEvent
function DebugTool:CreateDummy(event)
	if event.Unit then
		CreateUnitByNameAsync(
			"npc_dota_hero_target_dummy",
			event.Unit:GetAbsOrigin(),
			true,
			nil,
			nil,
			DOTA_TEAM_NEUTRALS,
			function(hDummy)
				hDummy:SetControllableByPlayer(event.PlayerID, true)
			end
		)
		SendToServerConsole("dota_easybuy 1")
		GameRulesCustom:SendCustomMessage("Server var dota_easybuy was set to true", 0, 0)
	end
end

---@param event DebugToolEvent
function DebugTool:RemoveDummy(event)
	if event.Unit then
		if event.Unit:GetUnitName() == "npc_dota_hero_target_dummy" then
			event.Unit:RemoveSelf()
		end
		SendToServerConsole("dota_easybuy 0")
		GameRulesCustom:SendCustomMessage("Server var dota_easybuy was set to false", 0, 0)
	end
end

---@param event DebugToolEvent
function DebugTool:LevelUpTo(event)
	local unit = event.Unit
	if unit and event.arg and unit:IsHero() then ---@cast unit CDOTA_BaseNPC_Hero
		local level = math.min(1000, tonumber(event.arg))
		while unit:GetLevel() < level do
			unit:HeroLevelUp(false)
		end
	end
end

---@param event DebugToolEvent
function DebugTool:RefreshCooldowns(event)
	if event.Unit then
		HeroRefreshService:RefreshAbilityAndItem(event.Unit)
	end
end

---@param event DebugToolEvent
function DebugTool:NoCooldowns(event)
	local bWTF = Convars:GetInt("dota_ability_debug") == 1
	if bWTF then
		SendToServerConsole("dota_ability_debug 0")
	else
		SendToServerConsole("dota_ability_debug 1")
	end
end

---@param event DebugToolEvent
function DebugTool:GiveGold(event)
	logger:Log(string.format("Gold modifiy call."))
	local unit = event.Unit
	if unit and unit:IsHero() and event.arg then ---@cast unit CDOTA_BaseNPC_Hero
		local goldValue = tonumber(event.arg or "0")
		if type(goldValue) ~= "number" then
			goldValue = 0
		end
		logger:Log(string.format("Modified gold for %s, value = %s", unit:GetUnitName(), tostring(goldValue)))
		unit:ModifyGoldFiltered(goldValue, true, DOTA_ModifyGold_Unspecified)
	end
end

---@param event DebugToolEvent
function DebugTool:RestartGame(event)
	SendToServerConsole("restart")
end

---@param event DebugToolEvent
function DebugTool:ReloadScripts(event)
	SendToServerConsole("cl_script_reload")
	SendToServerConsole("script_reload")
end

---@param event DebugToolEvent
function DebugTool:ToggleEscape(event)
	local modifierEscapeName = "modifier_escape_controller"
	local isEscapeControllerDisabled = Features:GetFeatureState(Features.Keys.EscapeControllerDisabled)
	local allUnits = FindUnitsInRadius(
		DOTA_TEAM_NEUTRALS,
		Vector(0, 0, 0),
		nil,
		FIND_UNITS_EVERYWHERE,
		DOTA_UNIT_TARGET_TEAM_BOTH,
		DOTA_UNIT_TARGET_ALL,
		DOTA_UNIT_TARGET_FLAG_INVULNERABLE + DOTA_UNIT_TARGET_FLAG_OUT_OF_WORLD + DOTA_UNIT_TARGET_FLAG_DEAD,
		FIND_ANY_ORDER,
		false
	)
	if not isEscapeControllerDisabled then
		Features:SetFeatureState(Features.Keys.EscapeControllerDisabled, true)
		for _, unit in ipairs(allUnits) do
			unit:RemoveModifierByName(modifierEscapeName)
		end
	else
		Features:SetFeatureState(Features.Keys.EscapeControllerDisabled, false)
		for _, unit in ipairs(allUnits) do
			unit:AddNewModifier(unit, nil, modifierEscapeName, {})
		end
	end
end

---@param event DebugToolEvent
function DebugTool:ToggleFountain(event)
	local modifierHeroRefreshing = "modifier_hero_refreshing"
	local isHeroRefreshingDisabled = Features:GetFeatureState(Features.Keys.HeroRefreshingDisabled)
	local allUnits = FindUnitsInRadius(
		DOTA_TEAM_NEUTRALS,
		Vector(0, 0, 0),
		nil,
		FIND_UNITS_EVERYWHERE,
		DOTA_UNIT_TARGET_TEAM_BOTH,
		DOTA_UNIT_TARGET_ALL,
		DOTA_UNIT_TARGET_FLAG_INVULNERABLE + DOTA_UNIT_TARGET_FLAG_OUT_OF_WORLD + DOTA_UNIT_TARGET_FLAG_DEAD,
		FIND_ANY_ORDER,
		false
	)
	if not isHeroRefreshingDisabled then
		Features:SetFeatureState(Features.Keys.HeroRefreshingDisabled, true)
		for _, unit in ipairs(allUnits) do
			unit:RemoveModifierByName(modifierHeroRefreshing)
		end
	else
		Features:SetFeatureState(Features.Keys.HeroRefreshingDisabled, false)
		for _, unit in ipairs(allUnits) do
			unit:AddNewModifier(unit, nil, modifierHeroRefreshing, {})
		end
	end
end

---@param event DebugToolEvent
function DebugTool:SetCurse(event)
	local unit = event.Unit
	local curseCount = tonumber(event.arg)
	logger:Log("Curse count = " .. curseCount)
	if unit and curseCount and curseCount >= 0 then
		local reaperAbility = nil
		if GoodFrog then
			hReaperAbility = GoodFrog:FindAbilityByName("frog_reaper")
		end
		local curse = unit:FindModifierByName("modifier_loser_curse")
		if not curse then
			curse = unit:AddNewModifier(unit, reaperAbility, "modifier_loser_curse", {})
		end
		curse:SetStackCount(curseCount)
		if curseCount == 0 then
			unit:RemoveModifierByName("modifier_loser_curse")
		end
	end
end

---@param event DebugToolEvent
function DebugTool:ToggleTimeFreeze(event)
	if event.arg == "1" then
		-- GameRules:SetGameTimeFrozen(true);
	else
		-- GameRules:SetGameTimeFrozen(false);
	end
end

return DebugTool