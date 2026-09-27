--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1a5b3bb 
  ~ auto-generated — do not edit
]]


local function bevavior()
	if not IsValidEntity(thisEntity) then
		return
	end
	if not thisEntity:IsAlive() then
		return -1
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

	if not thisEntity.init then
		thisEntity.init = true
		thisEntity.start_abs = thisEntity:GetAbsOrigin()

		for _, tower in
			pairs(
				FindUnitsInRadius(
					thisEntity:GetTeamNumber(),
					thisEntity:GetAbsOrigin(),
					nil,
					FIND_UNITS_EVERYWHERE,
					DOTA_UNIT_TARGET_TEAM_BOTH,
					DOTA_UNIT_TARGET_BUILDING,
					DOTA_UNIT_TARGET_FLAG_NONE,
					FIND_CLOSEST,
					false
				)
			)
		do
			local name = tower:GetUnitName()
			if name == "npc_towerradiant" or name == "npc_towerdire" then
				thisEntity.tower = tower
				thisEntity.tower_location = tower:GetAbsOrigin()
				break
			end
		end

		thisEntity.black_hole = thisEntity:FindAbilityByName("enigma_boss_black_hole_custom")
		thisEntity.midnight = thisEntity:FindAbilityByName("enigma_boss_midnight_custom")
		thisEntity.malefice = thisEntity:FindAbilityByName("enigma_boss_malefice_custom")

		local origin = thisEntity:GetAbsOrigin()

		if IsValid(thisEntity.midnight) then
			thisEntity.midnight_range = thisEntity.midnight:GetCastRange(origin, thisEntity)
		end

		if IsValid(thisEntity.malefice) then
			thisEntity.malefice_range = thisEntity.malefice:GetCastRange(origin, thisEntity)
			thisEntity.malefice_health = thisEntity.malefice:GetSpecialValueFor("cast_health")
		end
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
		thisEntity:ForceKill(false)
		return -1
	end

	if not thisEntity:IsSilenced() and not thisEntity:IsHexed() then
		local origin = thisEntity:GetAbsOrigin()
		local midnight = IsValid(thisEntity.midnight) and thisEntity.midnight:IsFullyCastable()
		local malefice = IsValid(thisEntity.malefice)
			and thisEntity.malefice:IsFullyCastable()
			and thisEntity:GetHealthPercent() <= thisEntity.malefice_health
		local black_hole = IsValid(thisEntity.black_hole)
			and thisEntity.black_hole:IsFullyCastable()
			and not thisEntity:HasModifier("modifier_enigma_boss_black_hole_custom_caster")
		local target = (midnight or malefice or black_hole)
			and FindUnitsInRadius(
				thisEntity:GetTeamNumber(),
				origin,
				nil,
				1000,
				DOTA_UNIT_TARGET_TEAM_ENEMY,
				DOTA_UNIT_TARGET_HERO,
				DOTA_UNIT_TARGET_FLAG_FOW_VISIBLE
					+ DOTA_UNIT_TARGET_FLAG_NOT_ILLUSIONS
					+ DOTA_UNIT_TARGET_FLAG_NOT_CREEP_HERO,
				FIND_CLOSEST,
				false
			)[1]

		if midnight and target and (origin - target:GetAbsOrigin()):Length2D() <= thisEntity.midnight_range then
			thisEntity:CastAbilityOnTarget(target, thisEntity.midnight, 1)
			return 1
		end

		if malefice and target and (origin - target:GetAbsOrigin()):Length2D() <= thisEntity.malefice_range then
			thisEntity:CastAbilityOnTarget(target, thisEntity.malefice, 1)
			return 1
		end

		if black_hole and target then
			thisEntity:CastAbilityNoTarget(thisEntity.black_hole, 1)
			return 1
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

	thisEntity:SetContextThink("bevavior", bevavior, FrameTime())
end