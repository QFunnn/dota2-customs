--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_roshan_custom_gospawn", "abilities/npc_roshan_custom_passive", LUA_MODIFIER_MOTION_NONE)


function Spawn( entityKeyValues )
    if not IsServer() then
        return
    end
	if not IsValidEntity(thisEntity) then return end

    thisEntity.agro = 1100
    thisEntity.spawn = Vector(41,140,343)
    thisEntity.slam = thisEntity:FindAbilityByName("npc_roshan_clap")

    thisEntity:SetContextThink( "bevavior", bevavior, FrameTime() )
end


function bevavior()
	if not IsValidEntity(thisEntity) then return -1 end
	if not thisEntity:IsAlive() then return -1 end

	if GameRules:IsGamePaused() then
		return 0.5
	end

	if thisEntity:HasModifier("modifier_roshan_custom_spawn") then
		return 0.1
	end

	if thisEntity:HasModifier("modifier_roshan_custom_gospawn") then
		if (thisEntity:GetAbsOrigin() - thisEntity.spawn):Length2D() < 10 then
			thisEntity:RemoveModifierByName("modifier_roshan_custom_gospawn")
		else
			thisEntity:MoveToPosition(thisEntity.spawn)
			return 0.1
		end
	end

	---------------------------------------------------------------------------------------------------

	local enemy_for_ability = FindUnitsInRadius(thisEntity:GetTeamNumber(), thisEntity:GetAbsOrigin(), nil,thisEntity.slam:GetSpecialValueFor("radius"), DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_BASIC + DOTA_UNIT_TARGET_HERO, DOTA_UNIT_TARGET_FLAG_FOW_VISIBLE + DOTA_UNIT_TARGET_FLAG_NOT_ANCIENTS , FIND_CLOSEST, false)

	local enemy_for_attack = FindUnitsInRadius(thisEntity:GetTeamNumber(), thisEntity:GetAbsOrigin(), nil, thisEntity.agro, DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_BASIC + DOTA_UNIT_TARGET_HERO, DOTA_UNIT_TARGET_FLAG_FOW_VISIBLE + DOTA_UNIT_TARGET_FLAG_MAGIC_IMMUNE_ENEMIES  + DOTA_UNIT_TARGET_FLAG_NOT_ANCIENTS + DOTA_UNIT_TARGET_FLAG_INVULNERABLE + DOTA_UNIT_TARGET_FLAG_OUT_OF_WORLD, FIND_CLOSEST, false)

	local control = false
	if thisEntity:IsSilenced() or thisEntity:IsHexed() then
		control = true
	end

	if control == false then
		if thisEntity.slam:IsFullyCastable() then
			if IsValidEntity(enemy_for_ability[1]) then
				thisEntity:CastAbilityOnTarget(enemy_for_ability[1], thisEntity.slam, 1)
				thisEntity:CastAbilityNoTarget(thisEntity.slam, 1)
				return 0.6
			end
		end
	end

	local enemy = enemy_for_attack[1]


	if ((thisEntity:GetAbsOrigin() - thisEntity.spawn):Length2D() < thisEntity.agro ) and IsValidEntity(enemy) then
		thisEntity:MoveToTargetToAttack(enemy)
	else
		if ((thisEntity:GetAbsOrigin() - thisEntity.spawn):Length2D() > 10 ) then
			thisEntity:AddNewModifier(thisEntity, nil, "modifier_roshan_custom_gospawn", {})
			thisEntity:MoveToPosition(thisEntity.spawn)
		end
	end

	return 0.5
end