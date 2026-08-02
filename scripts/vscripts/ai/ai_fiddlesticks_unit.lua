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
	thisEntity:SetContextThink("NecroLordThink", NecroLordThink, 0.1)
end

function NecroLordThink()
	if not thisEntity:IsAlive() then
		return -1
	end

	if GameRules:IsGamePaused() == true then
		return 1
	end

	local enemies = FindUnitsInRadius(
		thisEntity:GetTeamNumber(),
		thisEntity:GetOrigin(),
		thisEntity,
		500,
		DOTA_UNIT_TARGET_TEAM_ENEMY,
		DOTA_UNIT_TARGET_ALL,
		DOTA_UNIT_TARGET_FLAG_FOW_VISIBLE,
		FIND_CLOSEST,
		false
	)

	if #enemies > 0 then
		local enemy = enemies[1]
		if enemy ~= nil then
			return AttackMove(enemy)
		end
	end
	return 0.5
end

function AttackMove(enemy)
	if enemy == nil then
		return
	end
	ExecuteOrderFromTable({
		UnitIndex = thisEntity:entindex(),
		OrderType = DOTA_UNIT_ORDER_ATTACK_MOVE,
		Position = enemy:GetOrigin(),
		Queue = false,
	})
	return 1
end