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
	Ability = nil
	thisEntity:SetContextThink("Think", Think, 1)
end

function Think()
	if not thisEntity:IsAlive() then
		return -1
	end

	if GameRules:IsGamePaused() == true then
		return 1
	end

	Ability = thisEntity:FindAbilityByName("tinker_heat_seeking_missile_lua")

	local enemies = FindUnitsInRadius(
		thisEntity:GetTeamNumber(),
		thisEntity:GetOrigin(),
		thisEntity,
		700,
		DOTA_UNIT_TARGET_TEAM_ENEMY,
		DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,
		DOTA_UNIT_TARGET_FLAG_MAGIC_IMMUNE_ENEMIES + DOTA_UNIT_TARGET_FLAG_FOW_VISIBLE + DOTA_UNIT_TARGET_FLAG_NO_INVIS,
		FIND_CLOSEST,
		false
	)
	if #enemies == 0 then
		return 0.5
	end

	local point = thisEntity:GetAbsOrigin()
	local point_2 = thisEntity:GetOwner():GetAbsOrigin()

	local flDist = (point - point_2):Length2D()
	if flDist >= 500 then
		return 0.5
	end
	if Ability ~= nil and Ability:IsCooldownReady() then
		return Cast()
	end
	return 1
end

function Cast()
	ExecuteOrderFromTable({
		UnitIndex = thisEntity:entindex(),
		OrderType = DOTA_UNIT_ORDER_CAST_NO_TARGET,
		AbilityIndex = Ability:entindex(),
		Queue = false,
	})
	thisEntity:FindAbilityByName("tinker_heat_seeking_missile_lua"):EndCooldown()
	return 1
end