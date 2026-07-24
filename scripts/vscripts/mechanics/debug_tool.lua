--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


if DebugTool == nil then
	DebugTool = class({})
	---@alias DebugToolEvent {PlayerID:number,Unit:CDOTA_BaseNPC,Position:Vector,str:string}
end

function DebugTool:Init()
	GameListener:SubscribeProtected("DemoEvent", function(...)
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
			local message = string.format("<font color='#fc030f'>Обнаружена попытка использования запрещенного функционала от игрока %s</font>", PlayerResource:GetPlayerName(event.PlayerID))
            GameRulesCustom:SendCustomMessage(message, 0, 0)
			return
		end

		local sEventName = event.event_name
		local iPlayerID = event.player_id or -1
		local hUnit = EntIndexToHScript(event.unit or -1)
		local vPosition = event.position
			and Vector(event.position["0"], event.position["1"], event.position["2"])
		local sStr = event.str
		if type(sEventName) == "string" and type(DebugTool[sEventName]) == "function" then
			DebugTool[sEventName](DebugTool, {
				callerPlayerId = event.PlayerID,
				PlayerID = iPlayerID,
				Unit = hUnit,
				Position = vPosition,
				str = sStr,
			})
		end
	end)
end

---@param event DebugToolEvent
function DebugTool:ChangeHostTimescale(event)
	SendToServerConsole("host_timescale " .. event.str)
end

---@param event DebugToolEvent
function DebugTool:ChangeCurrentRound(event)
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
	if GameMode.currentRound then
		GameMode.currentRound:End()
	end
	GameMode.currentRound = Round(tonumber(event.str))
end

---@param event DebugToolEvent
function DebugTool:StopRoundButtonPressed(event)
	if GameMode.currentRound then
		for _, spawner in pairs(GameMode.currentRound.spawners) do
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
	if GameMode.currentRound then
		GameMode.currentRound:End()
		for _, spawner in pairs(GameMode.currentRound.spawners) do
			spawner:Finish()
		end
	end
	Util:MoveHeroToCenter(event.PlayerID, true)
end

---@param event DebugToolEvent
function DebugTool:RemoveAbilitiesButtonPressed(event)
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
			HeroBuilder:RemoveAbility(event.PlayerID, abiility:GetAbilityName(), unit)
		end
		::continue::
	end
end

---@param event DebugToolEvent
function DebugTool:RemoveInventoryItemsButtonPressed(event)
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
function DebugTool:AddAbilityButtonPressed(event)
	if not event.Unit:HasAbility(event.str) then
		HeroBuilder:AddAbility(event.PlayerID, event.str, nil, nil, event.Unit)
		table.insert(event.Unit.abilitiesList, event.str)
		AbilityQuota:AddTotal(event.PlayerID, 1)
	else
		local points = event.Unit:GetAbilityPoints()
		local level = 0
		if
			event.Unit:FindAbilityByName(event.str) ~= nil
			and event.Unit:FindAbilityByName(event.str).GetLevel ~= nil
		then
			level = event.Unit:FindAbilityByName(event.str):GetLevel()
		end
		event.Unit:SetAbilityPoints(points + level)
		HeroBuilder:RemoveAbility(event.PlayerID, event.str, event.Unit)
		table.remove_item(event.Unit.abilitiesList, event.str)
		AbilityQuota:AddTotal(event.PlayerID, -1)
	end
end

---@param event DebugToolEvent
function DebugTool:SwitchHero(event)
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
		PrecacheUnitByNameAsync(event.str, function()
			local hHero = PlayerResource:ReplaceHeroWith(event.PlayerID, event.str, GoldOriginal, 0)
			HeroBuilder:InitPlayerHeroDebug(hHero)
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
function DebugTool:CreateDummyButtonPressed(event)
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
function DebugTool:RemoveDummyButtonPressed(event)
	if event.Unit then
		if event.Unit:GetUnitName() == "npc_dota_hero_target_dummy" then
			event.Unit:RemoveSelf()
		end
		SendToServerConsole("dota_easybuy 0")
		GameRulesCustom:SendCustomMessage("Server var dota_easybuy was set to false", 0, 0)
	end
end

---@param event DebugToolEvent
function DebugTool:SetHeroLevel(event)
	local unit = event.Unit
	if unit and event.str and unit:IsHero() then ---@cast unit CDOTA_BaseNPC_Hero
		local level = math.min(1000, tonumber(event.str))
		while unit:GetLevel() < level do
			unit:HeroLevelUp(false)
		end
	end
end

---@param event DebugToolEvent
function DebugTool:DebugRefresh(event)
	if event.Unit then
		Util:RefreshAbilityAndItem(event.Unit)
	end
end

---@param event DebugToolEvent
function DebugTool:DebugWTF(event)
	local bWTF = Convars:GetInt("dota_ability_debug") == 1
	if bWTF then
		SendToServerConsole("dota_ability_debug 0")
	else
		SendToServerConsole("dota_ability_debug 1")
	end
end

---@param event DebugToolEvent
function DebugTool:DebugModifyGold(event)
	logger:Log(string.format("Gold modifiy call."))
	local unit = event.Unit
	if unit and unit:IsHero() and event.str then ---@cast unit CDOTA_BaseNPC_Hero
		local goldValue = tonumber(event.str or "0")
		if type(goldValue) ~= "number" then
			goldValue = 0
		end
		logger:Log(
			string.format("Modified gold for %s, value = %s", unit:GetUnitName(), tostring(goldValue))
		)
		unit:ModifyGoldFiltered(goldValue, true, DOTA_ModifyGold_Unspecified)
	end
end

---@param event DebugToolEvent
function DebugTool:RestartButtonPressed(event)
	SendToServerConsole("restart")
end

---@param event DebugToolEvent
function DebugTool:ReloadScriptButtonPressed(event)
	SendToServerConsole("cl_script_reload")
	SendToServerConsole("script_reload")
end

---@param event DebugToolEvent
function DebugTool:ToggleEscapeController(event)
	local modifierEscapeName = "modifier_escape_controller"
	local isEscapeControllerDisabled =
		Features:GetFeatureState(Features.Keys.EscapeControllerDisabled)
	local allUnits = FindUnitsInRadius(
		DOTA_TEAM_NEUTRALS,
		Vector(0, 0, 0),
		nil,
		FIND_UNITS_EVERYWHERE,
		DOTA_UNIT_TARGET_TEAM_BOTH,
		DOTA_UNIT_TARGET_ALL,
		DOTA_UNIT_TARGET_FLAG_INVULNERABLE
			+ DOTA_UNIT_TARGET_FLAG_OUT_OF_WORLD
			+ DOTA_UNIT_TARGET_FLAG_DEAD,
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
		DOTA_UNIT_TARGET_FLAG_INVULNERABLE
			+ DOTA_UNIT_TARGET_FLAG_OUT_OF_WORLD
			+ DOTA_UNIT_TARGET_FLAG_DEAD,
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
function DebugTool:SetCurseCount(event)
	local unit = event.Unit
	local curseCount = tonumber(event.str)
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
function DebugTool:GameTimeFrozenButtonPressed(event)
	if event.str == "1" then
		-- GameRules:SetGameTimeFrozen(true);
	else
		-- GameRules:SetGameTimeFrozen(false);
	end
end

return DebugTool