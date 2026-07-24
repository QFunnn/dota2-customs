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

thisEntity.agro = 450
thisEntity.spawn_radius = 600
thisEntity.go_on_start = true

thisEntity:SetContextThink( "bevavior", bevavior, FrameTime() )
end


function bevavior()
if not IsValidEntity(thisEntity) then return -1 end
if not thisEntity.spawn then return 0.1 end

if (not thisEntity:IsAlive()) then
	return -1
end

if GameRules:IsGamePaused() then
	return 0.5
end

if thisEntity:HasModifier("modifier_patrol_start") then
	return 0.1
end

if thisEntity.go_on_start == true then
	thisEntity:AddNewModifier(thisEntity, nil, "modifier_patrol_gospawn", {})
	thisEntity.go_on_start = false
end


if thisEntity:HasModifier("modifier_patrol_gospawn") then
	thisEntity:MoveToPosition(thisEntity.spawn)

	if (thisEntity:GetAbsOrigin() - thisEntity.spawn):Length2D() < 10 then
		thisEntity:RemoveModifierByName("modifier_patrol_gospawn")
	end
	return 0.1
end


---------------------------------------------------------------------------------------------------

local enemy_for_ability = nil


local enemy_for_ability = FindUnitsInRadius(thisEntity:GetTeamNumber(), thisEntity:GetAbsOrigin(), nil, thisEntity.agro, DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_BASIC + DOTA_UNIT_TARGET_HERO, DOTA_UNIT_TARGET_FLAG_FOW_VISIBLE + DOTA_UNIT_TARGET_FLAG_NOT_ANCIENTS , FIND_CLOSEST, false)

local enemy_for_attack = FindUnitsInRadius(thisEntity:GetTeamNumber(), thisEntity:GetAbsOrigin(), nil, thisEntity.agro, DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_BASIC + DOTA_UNIT_TARGET_HERO, DOTA_UNIT_TARGET_FLAG_FOW_VISIBLE + DOTA_UNIT_TARGET_FLAG_MAGIC_IMMUNE_ENEMIES  + DOTA_UNIT_TARGET_FLAG_NOT_ANCIENTS + DOTA_UNIT_TARGET_FLAG_INVULNERABLE + DOTA_UNIT_TARGET_FLAG_OUT_OF_WORLD, FIND_CLOSEST, false)

local control = false
if thisEntity:IsSilenced() or thisEntity:IsHexed() then
	control = true
end

if false and control == false then
	if thisEntity.slam:IsFullyCastable() then
		if IsValidEntity(enemy_for_ability[1]) then
			thisEntity:CastAbilityOnTarget(enemy_for_ability[1], thisEntity.slam, 1)
			thisEntity:CastAbilityNoTarget(thisEntity.slam, 1)
			return 0.6
		end
	end
end

local enemy = enemy_for_attack[1]

if ((thisEntity:GetAbsOrigin() - thisEntity.spawn):Length2D() < thisEntity.spawn_radius ) and IsValidEntity(enemy) then
	thisEntity:MoveToTargetToAttack(enemy)
else
	if ((thisEntity:GetAbsOrigin() - thisEntity.spawn):Length2D() > thisEntity.spawn_radius ) then
		thisEntity:AddNewModifier(thisEntity, nil, "modifier_patrol_gospawn", {})
		return 0.1
	end
end

return 0.5
end