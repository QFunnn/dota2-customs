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

		thisEntity.ulti = thisEntity:FindAbilityByName("warlock_boss_rain_of_chaos")
		thisEntity.upheaval = thisEntity:FindAbilityByName("warlock_boss_upheaval")
		thisEntity.word = thisEntity:FindAbilityByName("warlock_boss_shadow_word")

		local origin = thisEntity:GetAbsOrigin()

		if IsValid(thisEntity.ulti) then
			thisEntity.ulti_range = thisEntity.ulti:GetCastRange(origin, thisEntity)
		end

		if IsValid(thisEntity.upheaval) then
			thisEntity.upheaval_range = thisEntity.upheaval:GetCastRange(origin, thisEntity)
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
		local upheaval = IsValid(thisEntity.upheaval) and thisEntity.upheaval:IsFullyCastable()
		local ulti = IsValid(thisEntity.ulti) and thisEntity.ulti:IsFullyCastable()
		local target = (upheaval or ulti)
			and thisEntity:FindTargets(1000, nil, nil, DOTA_UNIT_TARGET_FLAG_FOW_VISIBLE)[1]

		if upheaval and target and (origin - target:GetAbsOrigin()):Length2D() <= thisEntity.upheaval_range then
			thisEntity:CastAbilityOnPosition(target:GetAbsOrigin(), thisEntity.upheaval, 1)
			return 0.8
		end

		if ulti then
			local point = target and (origin - target:GetAbsOrigin()):Length2D() <= thisEntity.ulti_range and target

			if not point and IsValid(thisEntity:GetAttackTarget()) then
				point = thisEntity:GetAttackTarget()
			end

			if point then
				thisEntity:CastAbilityOnPosition(point:GetAbsOrigin(), thisEntity.ulti, 1)
				return 0.8
			end
		end

		if IsValid(thisEntity.word) and thisEntity.word:IsFullyCastable() and thisEntity:GetAttackTarget() then
			thisEntity:CastAbilityNoTarget(thisEntity.word, 1)
			return 1.9
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