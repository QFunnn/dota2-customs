--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build b9dc48c · 2026-08-02 17:42:46 UTC
  ~ auto-generated — do not edit
]]


function Spawn(entityKeyValues)
	if not IsServer() then
		return
	end

	if thisEntity == nil then
		return
	end

	RoshanSlam = thisEntity:FindAbilityByName("roshan_slam_lua")
	thisEntity:SetContextThink("RoshanThink", RoshanThink, 0.3)
end

--------------------------------------------------------------------------------

function RoshanThink()
	if not thisEntity:IsAlive() then
		return -1
	end

	if GameRules:IsGamePaused() or thisEntity:IsChanneling() then
		return 1
	end

	if not thisEntity.bInitialized then
		thisEntity.vInitialSpawnPos = thisEntity:GetAbsOrigin()
		thisEntity.bInitialized = true
	end

	local distanceToSpawn = (thisEntity:GetOrigin() - thisEntity.vInitialSpawnPos):Length2D()
	if distanceToSpawn >= 700 then
		RetreatHome()
		return 0.3
	end

	local enemies = FindUnitsInRadius(
		thisEntity:GetTeamNumber(),
		thisEntity:GetOrigin(),
		thisEntity,
		350,
		DOTA_UNIT_TARGET_TEAM_ENEMY,
		DOTA_UNIT_TARGET_HERO,
		DOTA_UNIT_TARGET_FLAG_MAGIC_IMMUNE_ENEMIES + DOTA_UNIT_TARGET_FLAG_NO_INVIS,
		FIND_CLOSEST,
		false
	)

	if #enemies > 2 then
		if RoshanSlam ~= nil and RoshanSlam:IsCooldownReady() then
			RoshanSlamCast()
		end
	end
	return 0.3
end

--------------------------------------------------------------------------------

function RoshanSlamCast(unit)
	ExecuteOrderFromTable({
		UnitIndex = thisEntity:entindex(),
		OrderType = DOTA_UNIT_ORDER_CAST_NO_TARGET,
		AbilityIndex = RoshanSlam:entindex(),
		Queue = false,
	})
	return 0.3
end

function RetreatHome()
	ExecuteOrderFromTable({
		UnitIndex = thisEntity:entindex(),
		OrderType = DOTA_UNIT_ORDER_MOVE_TO_POSITION,
		Position = thisEntity.vInitialSpawnPos,
	})
	return 0.3
end