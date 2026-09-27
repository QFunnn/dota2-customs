--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1a5b3bb 
  ~ auto-generated — do not edit
]]


local check_mods = {
	["npc_werewolf_rupture"] = "modifier_bloodseeker_rupture",
	["npc_ogre_root"] = "modifier_ogre_root",
	["npc_centaur_double"] = "modifier_centaur_double_slow",
	["npc_satyr_purge"] = "modifier_satyr_slow",
	["npc_satyr_stomp"] = "modifier_stomp_break",
	["npc_arc_field"] = "modifier_arc_field_buf",
	["npc_dazzle_grave"] = "modifier_dazzle_grave",
	["npc_frostbitten_heal"] = "modifier_frostbitten_heal",
	["npc_silencer_lastword"] = "modifier_silencer_lastword_debuff",
}

local check_mods_friend = {
	["npc_frostbitten_spam"] = "modifier_frostbitten_spam",
}

local not_require_attack = {
	["npc_troll_summon"] = true,
	["npc_skelet_aura"] = true,
}

local check_self = {
	["npc_arc_field"] = true,
}

local require_friend = {
	["npc_wolf_howl"] = true,
}

local radius_check = {
	["npc_arc_knockback"] = true,
}

local check_health = {
	["npc_cone_armor"] = true,
}

local dont_check_order = {
	["npc_cone_armor"] = true,
	["npc_skelet_aura"] = true,
	["npc_treant_passive"] = true,
}

local new_return = {
	["npc_wolf_howl"] = 0.5,
	["npc_satyr_manaburn"] = 0.5,
	["npc_frostbitten_spam"] = 0.5,
	["npc_frostbitten_heal"] = 0.5,
	["npc_dazzle_grave"] = 0.7,
}

local function bevavior()
	if not IsValidEntity(thisEntity) then
		return
	end
	if not thisEntity:IsAlive() then
		return -1
	end
	if not thisEntity.host_team then
		return 0.5
	end

	local tower = towers[thisEntity.host_team]

	if not tower or not tower:IsAlive() then
		thisEntity:AddNewModifier(thisEntity, nil, "modifier_death", {})
		thisEntity:Kill(nil, nil)
		return 1
	end

	if not thisEntity.init then
		thisEntity.init = true
		thisEntity.start_abs = thisEntity:GetAbsOrigin()
		thisEntity.tower = tower
		thisEntity.tower_location = tower:GetAbsOrigin()

		local first = thisEntity:GetAbilityByIndex(0)

		if IsValid(first) and bit.band(first:GetBehaviorInt(), DOTA_ABILITY_BEHAVIOR_PASSIVE) == 0 then
			local behavior = first:GetBehaviorInt()
			local team = first:GetAbilityTargetTeam()
			local name = first:GetAbilityName()

			thisEntity.ability = first
			thisEntity.ability_name = name
			thisEntity.ability_mod = check_mods[name]
			thisEntity.ability_ally_mod = check_mods_friend[name]
			thisEntity.ability_delay = new_return[name] or first:GetCastPoint() * 1.5
			thisEntity.ability_range = first:GetCastRange(thisEntity:GetAbsOrigin(), thisEntity)

			if
				bit.band(behavior, DOTA_ABILITY_BEHAVIOR_UNIT_TARGET) ~= 0
				and bit.band(team, DOTA_UNIT_TARGET_TEAM_ENEMY) ~= 0
			then
				thisEntity.abilityBehavior = "TargetEnemy"
			elseif
				bit.band(behavior, DOTA_ABILITY_BEHAVIOR_UNIT_TARGET) ~= 0
				and bit.band(team, DOTA_UNIT_TARGET_TEAM_FRIENDLY) ~= 0
			then
				thisEntity.abilityBehavior = "TargetFriendly"
			elseif bit.band(behavior, DOTA_ABILITY_BEHAVIOR_POINT) ~= 0 then
				thisEntity.abilityBehavior = "Point"
			elseif bit.band(behavior, DOTA_ABILITY_BEHAVIOR_NO_TARGET) ~= 0 then
				thisEntity.abilityBehavior = "NoTarget"
			end

			if check_health[name] or thisEntity.abilityBehavior == "TargetFriendly" then
				thisEntity.ability_health = first:GetSpecialValueFor("thealth")
			end

			if radius_check[name] then
				thisEntity.ability_radius = first:GetSpecialValueFor("radius_to_use")
			end

			if name == "npc_werewolf_rupture" then
				thisEntity.ability_rupture = first:GetSpecialValueFor("range")
			end
		end
	end

	if not thisEntity.ally and not thisEntity.summoned then
		return 0.5
	end
	if GameRules:IsGamePaused() then
		return 0.5
	end
	if thisEntity:IsChanneling() then
		return 0.5
	end
	if thisEntity:HasModifier("modifier_return_to_path") then
		return 0.3
	end

	if thisEntity:GetPathPoint(true) >= 700 then
		thisEntity:AddNewModifier(thisEntity, nil, "modifier_return_to_path", { duration = 6 })
		return 1
	end

	if not IsValidEntity(thisEntity.tower) then
		return -1
	end
	if not thisEntity.tower:IsAlive() then
		return -1
	end

	local ability = thisEntity.ability
	local cast = IsValid(ability)
		and not thisEntity:IsSilenced()
		and not thisEntity:IsHexed()
		and ability:IsFullyCastable()
	local name = cast and thisEntity.ability_name

	if cast and not dont_check_order[name] then
		for _, ally in pairs(thisEntity.ally) do
			if
				ally.ability
				and not ally:IsNull()
				and ally:IsAlive()
				and ally.ability:GetAbilityName() == name
				and thisEntity.number > ally.number
				and ally.ability:GetCooldownTimeRemaining() == 0
			then
				cast = false
				break
			end
		end
	end

	if cast then
		local behavior = thisEntity.abilityBehavior
		local mod = thisEntity.ability_mod
		local delay = thisEntity.ability_delay
		local origin = thisEntity:GetAbsOrigin()

		if behavior == "TargetEnemy" then
			local target = thisEntity:FindTargets(1000, nil, nil, DOTA_UNIT_TARGET_FLAG_FOW_VISIBLE)[1]
			local ally_mod = thisEntity.ability_ally_mod
			local use = target and (not mod or not target:HasModifier(mod))

			if use then
				local distance = (origin - target:GetAbsOrigin()):Length2D()
				use = distance <= thisEntity.ability_range
					or (thisEntity.ability_rupture and distance <= thisEntity.ability_rupture)
			end

			if use and ally_mod then
				for _, ally in pairs(thisEntity.ally) do
					if
						ally.ability
						and not ally:IsNull()
						and ally:IsAlive()
						and ally:HasModifier(ally_mod)
						and thisEntity.number > ally.number
					then
						use = false
						break
					end
				end
			end

			if use then
				thisEntity:CastAbilityOnTarget(target, ability, 1)
				return delay
			end
		elseif behavior == "NoTarget" then
			local target = thisEntity:GetAttackTarget()
			local use = not_require_attack[name] or (target and (not mod or not target:HasModifier(mod)))

			if use and check_health[name] then
				use = thisEntity:GetHealthPercent() <= thisEntity.ability_health
			end

			if use and check_self[name] then
				use = not mod or not thisEntity:HasModifier(mod)
			end

			if use and radius_check[name] and not not_require_attack[name] then
				use = (origin - target:GetAbsOrigin()):Length2D() <= thisEntity.ability_radius
			end

			if use and require_friend[name] then
				use = #thisEntity:FindFriends(1000, nil, FIND_ANY_ORDER, DOTA_UNIT_TARGET_FLAG_FOW_VISIBLE) > 1
			end

			if use then
				thisEntity:CastAbilityNoTarget(ability, 1)
				return delay
			end
		elseif behavior == "Point" then
			local target = thisEntity:FindTargets(1000, nil, nil, DOTA_UNIT_TARGET_FLAG_FOW_VISIBLE)[1]

			if target and (origin - target:GetAbsOrigin()):Length2D() <= thisEntity.ability_range then
				thisEntity:CastAbilityOnPosition(target:GetAbsOrigin(), ability, 1)
				return delay
			end
		elseif behavior == "TargetFriendly" then
			local health = thisEntity.ability_health
			local range = thisEntity.ability_range

			for _, friend in pairs(thisEntity:FindFriends(1000, nil, FIND_ANY_ORDER, DOTA_UNIT_TARGET_FLAG_FOW_VISIBLE)) do
				local friend_name = friend:GetUnitName()
				if
					friend:GetHealthPercent() <= health
					and friend_name ~= "npc_psi_blades_crystal"
					and friend_name ~= "npc_psi_blades_crystal_mini"
					and (origin - friend:GetAbsOrigin()):Length2D() <= range
					and (not mod or not friend:HasModifier(mod))
				then
					thisEntity:CastAbilityOnTarget(friend, ability, 1)
					return delay
				end
			end
		end
	end

	if (thisEntity:GetAbsOrigin() - thisEntity.tower_location):Length2D() <= 1000 then
		thisEntity:SetForceAttackTarget(thisEntity.tower)
		return 0.5
	end

	local enemies = thisEntity:FindTargets(
		1000,
		nil,
		nil,
		DOTA_UNIT_TARGET_FLAG_FOW_VISIBLE + DOTA_UNIT_TARGET_FLAG_INVULNERABLE + DOTA_UNIT_TARGET_FLAG_OUT_OF_WORLD
	)
	local enemy = enemies[1]

	if enemy and (enemy:IgnoredByCreeps() or (enemy:GetAbsOrigin() - thisEntity.tower_location):Length2D() <= 800) then
		enemy = nil
	end

	for _, target in pairs(enemies) do
		if
			not target:IgnoredByCreeps()
			and not target:IsInvulnerable()
			and not target:IsAttackImmune()
			and (target:GetAbsOrigin() - thisEntity.tower_location):Length2D() > 800
		then
			enemy = target
			break
		end
	end

	thisEntity:SetForceAttackTarget(enemy or thisEntity.tower)
	return 0.5
end

function Spawn()
	if not IsServer() then
		return
	end
	if not IsValidEntity(thisEntity) then
		return
	end

	thisEntity:SetContextThink("bevavior", function()
		local _, result = xpcall(bevavior, print)
		return result or 1
	end, 0.1)
end