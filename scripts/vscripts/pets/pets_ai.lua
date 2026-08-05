--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 9d26fbd · 2026-08-05 05:42:45 UTC
  ~ auto-generated — do not edit
]]


function Spawn(entityKeyValues)
	if not IsServer() then
		return
	end

	if thisEntity == nil then
		return
	end
	thisEntity:SetContextThink("PetThink", PetThink, 0.5)
end

function PetThink()
	if not IsServer() then
		return
	end

	if not thisEntity:IsAlive() then
		return -1
	end

	if GameRules:IsGamePaused() == true then
		return 0.5
	end

	if not thisEntity.bInitialized then
		thisEntity.spells = {}
		thisEntity.bInitialized = true
		local abilityCount = thisEntity:GetAbilityCount()
		for i = 0, abilityCount - 1 do
			local ability = thisEntity:GetAbilityByIndex(i)
			if ability and not ability:IsAttributeBonus() and not ability:IsHidden() and not ability:IsPassive() then
				table.insert(thisEntity.spells, ability)
			end
		end
	end

	thisEntity.owner = thisEntity:GetOwner()

	local creatures = FindUnitsInRadius(
		thisEntity:GetTeamNumber(),
		thisEntity:GetOrigin(),
		thisEntity,
		1000,
		DOTA_UNIT_TARGET_TEAM_BOTH,
		DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_CREEP,
		DOTA_UNIT_TARGET_FLAG_NONE,
		FIND_CLOSEST,
		false
	)
	if #creatures > 0 then
		for _, creature in pairs(creatures) do
			if creature ~= nil and creature:IsAlive() then
				local flDist = (creature:GetOrigin() - thisEntity:GetOrigin()):Length2D()
				if flDist < 600 then
					check_can_use(thisEntity, creature)
				end
			end
		end
	end

	local to_far = (thisEntity.owner:GetOrigin() - thisEntity:GetOrigin()):Length2D()

	if to_far >= 400 and to_far < 1000 then
		return Approach(thisEntity.owner)
	end

	if to_far > 1200 then
		return blink(thisEntity.owner)
	end

	return 1
end

function check_can_use(thisEntity, target)
	if not thisEntity or thisEntity:IsNull() or not target or target:IsNull() then
		return
	end

	for _, Spell in ipairs(thisEntity.spells) do
		if Spell and not Spell:IsNull() and Spell:IsFullyCastable() and not Spell:IsPassive() then
			local Behavior = Spell:GetBehaviorInt()
			local TargetTeam = Spell:GetAbilityTargetTeam()
			local nTargetTeamNumber = target:GetTeamNumber()
			local nMyTeamNumber = thisEntity:GetTeamNumber()

			if bit.band(Behavior, DOTA_ABILITY_BEHAVIOR_UNIT_TARGET) == DOTA_ABILITY_BEHAVIOR_UNIT_TARGET then
				if
					nMyTeamNumber ~= nTargetTeamNumber
					and bit.band(TargetTeam, DOTA_UNIT_TARGET_TEAM_ENEMY) == DOTA_UNIT_TARGET_TEAM_ENEMY
				then
					Spell.Behavior = "target"
					Cast(Spell, target)
				elseif
					nMyTeamNumber == nTargetTeamNumber
					and bit.band(TargetTeam, DOTA_UNIT_TARGET_TEAM_FRIENDLY) == DOTA_UNIT_TARGET_TEAM_FRIENDLY
				then
					Spell.Behavior = "target"

					if Spell:GetName() == "pet_health_bag" then
						if target:GetHealthPercent() < 50 then
							Cast(Spell, target)
						end
					else
						Cast(Spell, target)
					end
				end
			elseif bit.band(Behavior, DOTA_ABILITY_BEHAVIOR_NO_TARGET) == DOTA_ABILITY_BEHAVIOR_NO_TARGET then
				if nMyTeamNumber == nTargetTeamNumber and target:GetHealthPercent() < 80 then
					Spell.Behavior = "no_target"
					local radius = Spell:GetSpecialValueFor("radius")

					if radius == 0 then
						Cast(Spell, target)
					elseif (target:GetOrigin() - thisEntity:GetOrigin()):Length2D() < radius then
						Cast(Spell, target)
					end
				end
			elseif bit.band(Behavior, DOTA_ABILITY_BEHAVIOR_POINT) == DOTA_ABILITY_BEHAVIOR_POINT then
				Spell.Behavior = "point"
				Cast(Spell, target)
			elseif bit.band(Behavior, DOTA_ABILITY_BEHAVIOR_TOGGLE) == DOTA_ABILITY_BEHAVIOR_TOGGLE then
				Spell.Behavior = "toggle"
				if not Spell:GetToggleState() then
					Spell:ToggleAbility()
				end
			elseif bit.band(Behavior, DOTA_ABILITY_BEHAVIOR_PASSIVE) == DOTA_ABILITY_BEHAVIOR_PASSIVE then
				Spell.Behavior = "passive"
			end
		end
	end
end

function Cast(Spell, enemy)
	local order_type
	local vTargetPos = enemy:GetOrigin()
	if Spell.Behavior == "target" then
		order_type = DOTA_UNIT_ORDER_CAST_TARGET
	elseif Spell.Behavior == "no_target" then
		order_type = DOTA_UNIT_ORDER_CAST_NO_TARGET
	elseif Spell.Behavior == "point" then
		order_type = DOTA_UNIT_ORDER_CAST_POSITION
	elseif Spell.Behavior == "passive" then
		return
	end

	ExecuteOrderFromTable({
		UnitIndex = thisEntity:entindex(),
		OrderType = order_type,
		Position = vTargetPos,
		TargetIndex = enemy:entindex(),
		AbilityIndex = Spell:entindex(),
		Queue = false,
	})
end

function blink(unit)
	local vToEnemy = unit:GetOrigin() - thisEntity:GetOrigin()
	vToEnemy = vToEnemy:Normalized()
	ExecuteOrderFromTable({
		UnitIndex = thisEntity:entindex(),
		thisEntity:SetAbsOrigin(unit:GetOrigin() + RandomVector(RandomFloat(50, 50))),
	})
	FindClearSpaceForUnit(thisEntity, unit:GetOrigin() + RandomVector(RandomFloat(50, 50)), true)
	return 1
end

function Approach(unit)
	local vToEnemy = unit:GetOrigin() - thisEntity:GetOrigin()
	vToEnemy = vToEnemy:Normalized()
	ExecuteOrderFromTable({
		UnitIndex = thisEntity:entindex(),
		OrderType = DOTA_UNIT_ORDER_MOVE_TO_POSITION,
		Position = thisEntity:GetOrigin() + vToEnemy * thisEntity:GetIdealSpeed(),
	})
	return 1
end