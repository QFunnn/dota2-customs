--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build b9dc48c · 2026-08-02 17:42:46 UTC
  ~ auto-generated — do not edit
]]


local THINK_INTERVAL = 0.5
local RETREAT_DISTANCE = 1500
-- local non_100_pct_cast = {
--     "item_guardian_greaves",
--     "item_satanic",
--     "item_bloodstone",
--     "item_crimson_guard",
--     "item_pipe",
--     "item_glimmer_cape"
-- }

local LIMITED_CAST_SET = {
	["item_guardian_greaves"] = true,
	["item_satanic"] = true,
	["item_bloodstone"] = true,
	["item_crimson_guard"] = true,
	["item_pipe"] = true,
	["item_glimmer_cape"] = true,
	["creep_freezing_field_lua"] = true,
	["creep_purification_lua"] = true,
}

local CAST_HP_PCT = 80

function Spawn(entityKeyValues)
	if not IsServer() or not thisEntity then
		return
	end
	thisEntity.refresh = 0
	thisEntity.spells = {}
	thisEntity.items = {}
	thisEntity.bInitialized = false
	thisEntity.fTimeOfLastRetreat = 0
	thisEntity:SetContextThink("NeutralThink", function()
		return NeutralThink()
	end, THINK_INTERVAL)
end

function UpdateAbilitiesAndItems()
	thisEntity.spells = {}

	local abilityCount = thisEntity:GetAbilityCount()
	for i = 0, abilityCount - 1 do
		local ability = thisEntity:GetAbilityByIndex(i)
		if ability and not ability:IsAttributeBonus() and not ability:IsHidden() then
			table.insert(thisEntity.spells, ability)
		end
	end

	thisEntity.items = {}
	for i = 0, 5 do
		local item = thisEntity:GetItemInSlot(i)
		if item then
			table.insert(thisEntity.items, item)
		end
	end
end

function NeutralThink()
	if not thisEntity:IsAlive() then
		return -1
	end

	if thisEntity:IsChanneling() or thisEntity:IsStunned() or thisEntity:IsSilenced() or GameRules:IsGamePaused() then
		return THINK_INTERVAL
	end

	if not thisEntity.bInitialized then
		thisEntity.vInitialSpawnPos = thisEntity:GetAbsOrigin()
		UpdateAbilitiesAndItems()
		thisEntity.bInitialized = true
		thisEntity.bIsReturningHome = false
	end

	local aggroTarget = thisEntity:GetAggroTarget()
	local curTime = GameRules:GetGameTime()

	if aggroTarget then
		thisEntity.fTimeWeLostAggro = nil
		thisEntity.bIsReturningHome = false
	elseif not thisEntity.fTimeWeLostAggro then
		thisEntity.fTimeWeLostAggro = curTime
	end

	local bRecentlyDamaged = thisEntity:GetLastDamageTime() > (curTime - 0.5)
	if bRecentlyDamaged then
		thisEntity.bIsReturningHome = false
	end

	local enemies = FindUnitsInRadius(
		thisEntity:GetTeamNumber(),
		thisEntity:GetOrigin(),
		nil,
		RETREAT_DISTANCE,
		DOTA_UNIT_TARGET_TEAM_ENEMY,
		DOTA_UNIT_TARGET_ALL,
		DOTA_UNIT_TARGET_FLAG_MAGIC_IMMUNE_ENEMIES,
		FIND_CLOSEST,
		false
	)

	local filteredEnemiesForCast = {}
	for _, enemy in pairs(enemies) do
		local unitName = enemy:GetUnitName()
		local unitTeam = enemy:GetTeamNumber()

		if unitTeam == DOTA_TEAM_GOODGUYS and unitName ~= "npc_dota_observer_wards" then
			table.insert(filteredEnemiesForCast, enemy)
		end

		if thisEntity:IsRangedAttacker() then
			local flDist = (enemy:GetOrigin() - thisEntity:GetOrigin()):Length2D()
			if flDist < 400 then
				if thisEntity.fTimeOfLastRetreat and (curTime > thisEntity.fTimeOfLastRetreat + 3) then
					thisEntity.bIsReturningHome = false -- Прерываем возврат ради кайта
					return Retreat(enemy)
				end
			end
		end
	end

	local distFromHome = (thisEntity:GetAbsOrigin() - thisEntity.vInitialSpawnPos):Length2D()
	local bTooFar = distFromHome > RETREAT_DISTANCE
	local bLostAggro = (aggroTarget == nil) and (curTime - thisEntity.fTimeWeLostAggro > 2.0)

	if distFromHome >= 100 and (bTooFar or bLostAggro) then
		thisEntity.bIsReturningHome = true
	end

	if distFromHome < 150 then
		thisEntity.bIsReturningHome = false
	end

	if thisEntity.bIsReturningHome and not bRecentlyDamaged then
		if #filteredEnemiesForCast > 0 and not bTooFar then
			thisEntity.bIsReturningHome = false
		else
			return RetreatHome()
		end
	end

	if #filteredEnemiesForCast <= 0 then
		return 0.1
	end

	local target = filteredEnemiesForCast[RandomInt(1, #filteredEnemiesForCast)]
	local castables = {}

	for _, ability in ipairs(thisEntity.spells) do
		if ability:IsFullyCastable() and not ability:IsPassive() then
			local castRange = ability:GetCastRange(thisEntity:GetAbsOrigin(), target)
			local castRangeBonus = thisEntity:GetCastRangeBonus()
			local totalRange = castRange + castRangeBonus
			if totalRange <= 0 then
				totalRange = thisEntity:GetAcquisitionRange()
			end

			local dist = (target:GetAbsOrigin() - thisEntity:GetAbsOrigin()):Length2D()
			local behavior = ability:GetBehaviorInt()
			local needsRangeCheck = bit.band(behavior, DOTA_ABILITY_BEHAVIOR_UNIT_TARGET)
					== DOTA_ABILITY_BEHAVIOR_UNIT_TARGET
				or bit.band(behavior, DOTA_ABILITY_BEHAVIOR_POINT) == DOTA_ABILITY_BEHAVIOR_POINT
				or bit.band(behavior, DOTA_ABILITY_BEHAVIOR_NO_TARGET) == DOTA_ABILITY_BEHAVIOR_NO_TARGET

			if needsRangeCheck then
				if dist <= totalRange - 100 then
					table.insert(castables, ability)
				end
			else
				table.insert(castables, ability)
			end
		end
	end

	for _, item in ipairs(thisEntity.items) do
		if item and not item:IsNull() and item:IsFullyCastable() then
			local itemName = item:GetName()
			local castRange = item:GetCastRange(thisEntity:GetAbsOrigin(), target)

			if castRange <= 0 then
				castRange = thisEntity:GetAcquisitionRange()
			end

			local dist = (target:GetAbsOrigin() - thisEntity:GetAbsOrigin()):Length2D()

			if dist <= castRange then
				local canCast = true

				if LIMITED_CAST_SET[itemName] and thisEntity:GetHealthPercent() >= CAST_HP_PCT then
					canCast = false
				end
				if itemName == "item_octarine_core" and thisEntity.refresh < 4 then
					canCast = false
				end

				if canCast then
					table.insert(castables, item)
				end
			end
		end
	end

	if #castables > 0 then
		local spell = castables[RandomInt(1, #castables)]
		ExecuteSmartCast(spell, target)
		return THINK_INTERVAL
	end

	return THINK_INTERVAL
end

function ExecuteSmartCast(ability, target)
	local behavior = ability:GetBehaviorInt()
	local targetTeam = ability:GetAbilityTargetTeam()

	local order = {
		UnitIndex = thisEntity:entindex(),
		AbilityIndex = ability:entindex(),
		Queue = false,
	}

	if bit.band(behavior, DOTA_ABILITY_BEHAVIOR_UNIT_TARGET) == DOTA_ABILITY_BEHAVIOR_UNIT_TARGET then
		if bit.band(targetTeam, DOTA_UNIT_TARGET_TEAM_FRIENDLY) ~= 0 then
			local castRange = ability:GetCastRange(thisEntity:GetAbsOrigin(), nil) + thisEntity:GetCastRangeBonus()

			local friendlies = FindUnitsInRadius(
				thisEntity:GetTeamNumber(),
				thisEntity:GetAbsOrigin(),
				nil,
				castRange,
				DOTA_UNIT_TARGET_TEAM_FRIENDLY,
				DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,
				DOTA_UNIT_TARGET_FLAG_NONE,
				FIND_ANY_ORDER,
				false
			)

			local weakestFriendly = nil
			local lowestHealthPct = 1.1

			for _, friend in pairs(friendlies) do
				if friend:GetName() ~= "npc_dummy_unit" then
					local healthPct = friend:GetHealth() / friend:GetMaxHealth()
					if healthPct < lowestHealthPct then
						lowestHealthPct = healthPct
						weakestFriendly = friend
					end
				end
			end

			if weakestFriendly then
				order.OrderType = DOTA_UNIT_ORDER_CAST_TARGET
				order.TargetIndex = weakestFriendly:entindex()
			else
				return
			end
		else
			order.OrderType = DOTA_UNIT_ORDER_CAST_TARGET
			order.TargetIndex = target:entindex()
		end
	elseif bit.band(behavior, DOTA_ABILITY_BEHAVIOR_POINT) == DOTA_ABILITY_BEHAVIOR_POINT then
		order.OrderType = DOTA_UNIT_ORDER_CAST_POSITION
		order.Position = target:GetAbsOrigin()

		local fDist = (target:GetOrigin() - thisEntity:GetOrigin()):Length2D()
		if (fDist > 400) and target and target:IsMoving() then
			local vLeadingOffset = target:GetForwardVector() * RandomInt(200, 400)
			order.Position = target:GetOrigin() + vLeadingOffset
		end
	elseif bit.band(behavior, DOTA_ABILITY_BEHAVIOR_NO_TARGET) == DOTA_ABILITY_BEHAVIOR_NO_TARGET then
		order.OrderType = DOTA_UNIT_ORDER_CAST_NO_TARGET
	elseif bit.band(behavior, DOTA_ABILITY_BEHAVIOR_TOGGLE) == DOTA_ABILITY_BEHAVIOR_TOGGLE then
		if not ability:GetToggleState() then
			ability:ToggleAbility()
		end
		return
	else
		return
	end

	if string.find(ability:GetName(), "item_octarine_core") then
		thisEntity.refresh = 0
	else
		thisEntity.refresh = thisEntity.refresh + 1
	end

	ExecuteOrderFromTable(order)
end

function RetreatHome()
	ExecuteOrderFromTable({
		UnitIndex = thisEntity:entindex(),
		OrderType = DOTA_UNIT_ORDER_MOVE_TO_POSITION,
		Position = thisEntity.vInitialSpawnPos,
	})
	return THINK_INTERVAL
end

function Retreat(target)
	local vAwayFromEnemy = thisEntity:GetOrigin() - target:GetOrigin()
	vAwayFromEnemy = vAwayFromEnemy:Normalized()
	local vMoveToPos = thisEntity:GetOrigin() + vAwayFromEnemy * thisEntity:GetIdealSpeed()

	local nAttempts = 0
	while (not GridNav:CanFindPath(thisEntity:GetOrigin(), vMoveToPos)) and (nAttempts < 3) do
		vMoveToPos = thisEntity:GetOrigin() + RandomVector(thisEntity:GetIdealSpeed())
		nAttempts = nAttempts + 1
	end

	thisEntity.fTimeOfLastRetreat = GameRules:GetGameTime()

	ExecuteOrderFromTable({
		UnitIndex = thisEntity:entindex(),
		OrderType = DOTA_UNIT_ORDER_MOVE_TO_POSITION,
		Position = vMoveToPos,
	})

	return THINK_INTERVAL * 2
end