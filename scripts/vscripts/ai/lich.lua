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

		thisEntity.blast = thisEntity:FindAbilityByName("npc_lich_blast")
		thisEntity.ice = thisEntity:FindAbilityByName("npc_lich_ice")
		thisEntity.ulti = thisEntity:FindAbilityByName("npc_lich_ulti")

		local origin = thisEntity:GetAbsOrigin()

		if IsValid(thisEntity.blast) then
			thisEntity.blast_range = thisEntity.blast:GetCastRange(origin, thisEntity)
		end

		if IsValid(thisEntity.ice) then
			thisEntity.ice_health = thisEntity.ice:GetSpecialValueFor("health")
		end

		if IsValid(thisEntity.ulti) then
			thisEntity.ulti_range = thisEntity.ulti:GetCastRange(origin, thisEntity)
			thisEntity.ulti_radius = thisEntity.ulti:GetSpecialValueFor("radius")
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
		local blast = IsValid(thisEntity.blast) and thisEntity.blast:IsFullyCastable()
		local ulti = IsValid(thisEntity.ulti) and thisEntity.ulti:IsFullyCastable()
		local target = (blast or ulti) and thisEntity:FindTargets(1000, nil, nil, DOTA_UNIT_TARGET_FLAG_FOW_VISIBLE)[1]

		if blast and target and (origin - target:GetAbsOrigin()):Length2D() <= thisEntity.blast_range then
			thisEntity:CastAbilityOnTarget(target, thisEntity.blast, 1)
			return 0.5
		end

		if
			IsValid(thisEntity.ice)
			and thisEntity.ice:IsFullyCastable()
			and thisEntity:GetAttackTarget()
			and thisEntity:GetHealthPercent() <= thisEntity.ice_health
			and not thisEntity:HasModifier("modifier_lich_ice_resist")
		then
			thisEntity:CastAbilityNoTarget(thisEntity.ice, 1)
			return 0.5
		end

		if ulti and target and (origin - target:GetAbsOrigin()):Length2D() <= thisEntity.ulti_range then
			local point = target:GetAbsOrigin()

			for _, unit in
				pairs(
					FindUnitsInRadius(
						thisEntity:GetTeamNumber(),
						origin,
						nil,
						1000,
						DOTA_UNIT_TARGET_TEAM_FRIENDLY,
						DOTA_UNIT_TARGET_ALL,
						DOTA_UNIT_TARGET_FLAG_FOW_VISIBLE,
						FIND_CLOSEST,
						false
					)
				)
			do
				if
					unit:GetUnitName() == "npc_lich_ice_unit"
					and (unit:GetAbsOrigin() - point):Length2D() <= thisEntity.ulti_radius
				then
					thisEntity:CastAbilityOnTarget(target, thisEntity.ulti, 1)
					return 0.8
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

	thisEntity:SetContextThink("bevavior", bevavior, FrameTime())
end