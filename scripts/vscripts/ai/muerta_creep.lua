--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]




function Spawn( entityKeyValues )
    if not IsServer() then return end
    if not IsValidEntity(thisEntity) then return end


    thisEntity.agro = 700
    thisEntity.spawn_radius = 1200

    thisEntity.ursa_speed = thisEntity:FindAbilityByName("npc_muerta_ursa_speed")
    thisEntity.ursa_clap = thisEntity:FindAbilityByName("npc_muerta_ursa_clap")

    thisEntity.centaur_charge = thisEntity:FindAbilityByName("npc_muerta_centaur_charge")
    thisEntity.centaur_stun = thisEntity:FindAbilityByName("npc_muerta_centaur_stun")

    thisEntity.satyr_silence = thisEntity:FindAbilityByName("npc_muerta_satyr_silence")
    thisEntity.satyr_bkb = thisEntity:FindAbilityByName("npc_muerta_satyr_bkb")

    thisEntity.ogre_hit = thisEntity:FindAbilityByName("npc_muerta_ogre_hit")
    thisEntity.ogre_jump = thisEntity:FindAbilityByName("npc_muerta_ogre_jump")

    thisEntity:SetContextThink( "bevavior", bevavior, FrameTime() )
end


function bevavior()
	if not IsValidEntity(thisEntity) then return -1 end

	if not thisEntity.spawn then 
		thisEntity.spawn = thisEntity:GetAbsOrigin()
		return 0.1 
	end

	if (not thisEntity:IsAlive()) then
		return -1
	end

	if GameRules:IsGamePaused() then
		return 0.5
	end

	if thisEntity:IsChanneling() then 
		return 0.1
	end

	if thisEntity:HasModifier("modifier_muerta_innate_custom_creep_gospawn") then

		thisEntity:MoveToPosition(thisEntity.spawn)

		if (thisEntity:GetAbsOrigin() - thisEntity.spawn):Length2D() < 10 then
			thisEntity:RemoveModifierByName("modifier_muerta_innate_custom_creep_gospawn")
		end

		return 0.1
	end

	if thisEntity:HasModifier("modifier_npc_muerta_centaur_chrarge") then 
		return 0.1
	end

	---------------------------------------------------------------------------------------------------



	local enemy_for_attack = FindUnitsInRadius(thisEntity:GetTeamNumber(), thisEntity:GetAbsOrigin(), nil, thisEntity.agro, DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_BASIC + DOTA_UNIT_TARGET_HERO, DOTA_UNIT_TARGET_FLAG_FOW_VISIBLE + DOTA_UNIT_TARGET_FLAG_MAGIC_IMMUNE_ENEMIES  + DOTA_UNIT_TARGET_FLAG_NOT_ANCIENTS + DOTA_UNIT_TARGET_FLAG_INVULNERABLE, FIND_CLOSEST, false)

	local control = false
	if thisEntity:IsSilenced() or thisEntity:IsHexed() then
		control = true
	end



	if control == false then
		if thisEntity.ursa_clap and thisEntity.ursa_clap:IsFullyCastable() then

			local enemy_for_ability = FindUnitsInRadius(thisEntity:GetTeamNumber(), thisEntity:GetAbsOrigin(), nil, thisEntity.ursa_clap:GetSpecialValueFor("radius"), DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_BASIC + DOTA_UNIT_TARGET_HERO, DOTA_UNIT_TARGET_FLAG_FOW_VISIBLE + DOTA_UNIT_TARGET_FLAG_NOT_ANCIENTS , FIND_CLOSEST, false)

			if IsValidEntity(enemy_for_ability[1]) then

				thisEntity:CastAbilityNoTarget(thisEntity.ursa_clap, 1)
				return 1
			end
		end

		if thisEntity.ursa_speed and thisEntity.ursa_speed:IsFullyCastable() then

			local enemy_for_ability = FindUnitsInRadius(thisEntity:GetTeamNumber(), thisEntity:GetAbsOrigin(), nil, thisEntity.agro, DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_BASIC + DOTA_UNIT_TARGET_HERO, DOTA_UNIT_TARGET_FLAG_FOW_VISIBLE + DOTA_UNIT_TARGET_FLAG_NOT_ANCIENTS , FIND_CLOSEST, false)
			
			if IsValidEntity(enemy_for_ability[1]) then

				thisEntity:CastAbilityNoTarget(thisEntity.ursa_speed, 1)
				return 0.2
			end
		end


		if thisEntity.centaur_charge and thisEntity.centaur_charge:IsFullyCastable() then

			local enemy_for_ability = FindUnitsInRadius(thisEntity:GetTeamNumber(), thisEntity:GetAbsOrigin(), nil, thisEntity.centaur_charge:GetCastRange(thisEntity:GetAbsOrigin(), nil), DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_BASIC + DOTA_UNIT_TARGET_HERO, DOTA_UNIT_TARGET_FLAG_FOW_VISIBLE + DOTA_UNIT_TARGET_FLAG_NOT_ANCIENTS , FIND_CLOSEST, false)
			
			if IsValidEntity(enemy_for_ability[1]) then

				thisEntity:CastAbilityOnPosition(enemy_for_ability[1]:GetAbsOrigin(), thisEntity.centaur_charge, 1)
				return 0.8
			end
		end

		if thisEntity.centaur_stun and thisEntity.centaur_stun:IsFullyCastable() then

			local enemy_for_ability = FindUnitsInRadius(thisEntity:GetTeamNumber(), thisEntity:GetAbsOrigin(), nil, thisEntity.centaur_stun:GetSpecialValueFor("radius"), DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_BASIC + DOTA_UNIT_TARGET_HERO, DOTA_UNIT_TARGET_FLAG_FOW_VISIBLE + DOTA_UNIT_TARGET_FLAG_NOT_ANCIENTS , FIND_CLOSEST, false)

			if IsValidEntity(enemy_for_ability[1]) then

				thisEntity:CastAbilityNoTarget(thisEntity.centaur_stun, 1)
				return 0.5
			end
		end

		if thisEntity.satyr_bkb and thisEntity.satyr_bkb:IsFullyCastable() then

			local enemy_for_ability = FindUnitsInRadius(thisEntity:GetTeamNumber(), thisEntity:GetAbsOrigin(), nil, thisEntity.agro, DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_BASIC + DOTA_UNIT_TARGET_HERO, DOTA_UNIT_TARGET_FLAG_FOW_VISIBLE + DOTA_UNIT_TARGET_FLAG_NOT_ANCIENTS , FIND_CLOSEST, false)
			
			if IsValidEntity(enemy_for_ability[1]) and thisEntity:GetHealthPercent() <= thisEntity.satyr_bkb:GetSpecialValueFor("health") then

				thisEntity:CastAbilityNoTarget(thisEntity.satyr_bkb, 1)
				return 0.5
			end
		end


		if thisEntity.satyr_silence and thisEntity.satyr_silence:IsFullyCastable() then

			local enemy_for_ability = FindUnitsInRadius(thisEntity:GetTeamNumber(), thisEntity:GetAbsOrigin(), nil, thisEntity.satyr_silence:GetCastRange(thisEntity:GetAbsOrigin(), nil), DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_BASIC + DOTA_UNIT_TARGET_HERO, DOTA_UNIT_TARGET_FLAG_FOW_VISIBLE + DOTA_UNIT_TARGET_FLAG_NOT_ANCIENTS , FIND_CLOSEST, false)
			
			if IsValidEntity(enemy_for_ability[1]) then

				thisEntity:CastAbilityOnPosition(enemy_for_ability[1]:GetAbsOrigin(), thisEntity.satyr_silence, 1)
				return 0.8
			end
		end


		if thisEntity.ogre_hit and thisEntity.ogre_hit:IsFullyCastable() then

			local enemy_for_ability = FindUnitsInRadius(thisEntity:GetTeamNumber(), thisEntity:GetAbsOrigin(), nil, thisEntity.ogre_hit:GetCastRange(thisEntity:GetAbsOrigin(), nil), DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_BASIC + DOTA_UNIT_TARGET_HERO, DOTA_UNIT_TARGET_FLAG_FOW_VISIBLE + DOTA_UNIT_TARGET_FLAG_NOT_ANCIENTS , FIND_CLOSEST, false)
			
			if IsValidEntity(enemy_for_ability[1]) then

				thisEntity:CastAbilityOnPosition(enemy_for_ability[1]:GetAbsOrigin(), thisEntity.ogre_hit, 1)
				return 1.5
			end
		end


		if thisEntity.ogre_jump and thisEntity.ogre_jump:IsFullyCastable() then

			local enemy_for_ability = FindUnitsInRadius(thisEntity:GetTeamNumber(), thisEntity:GetAbsOrigin(), nil, 0.8*thisEntity.ogre_jump:GetCastRange(thisEntity:GetAbsOrigin(), nil), DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_BASIC + DOTA_UNIT_TARGET_HERO, DOTA_UNIT_TARGET_FLAG_FOW_VISIBLE + DOTA_UNIT_TARGET_FLAG_NOT_ANCIENTS , FIND_CLOSEST, false)
			
			if IsValidEntity(enemy_for_ability[1]) then

				thisEntity:CastAbilityNoTarget(thisEntity.ogre_jump, 1)
				return 1.6
			end
		end
	end

	local enemy = enemy_for_attack[1]


	if ((thisEntity:GetAbsOrigin() - thisEntity.spawn):Length2D() < thisEntity.spawn_radius ) and IsValidEntity(enemy) then
		thisEntity:MoveToTargetToAttack(enemy)
	else

		if ((thisEntity:GetAbsOrigin() - thisEntity.spawn):Length2D() > 10 ) then
			thisEntity:AddNewModifier(thisEntity, nil, "modifier_muerta_innate_custom_creep_gospawn", {})
			return 0.1
		end
	end

	return 0.5
end