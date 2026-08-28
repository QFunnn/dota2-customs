--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 0b85d8d 
  ~ auto-generated — do not edit
]]


function Spawn(entityKeyValues)
	if not IsServer() or thisEntity == nil then
		return
	end
	thisEntity:SetContextThink("NecroLordThink", NecroLordThink, 0.1)
end

function NecroLordThink()
	if not thisEntity:IsAlive() then
		return nil
	end
	if GameRules:IsGamePaused() then
		return 1
	end

	local enemies = FindUnitsInRadius(
		thisEntity:GetTeamNumber(),
		thisEntity:GetAbsOrigin(),
		thisEntity,
		1000,
		DOTA_UNIT_TARGET_TEAM_ENEMY,
		DOTA_UNIT_TARGET_BASIC,
		DOTA_UNIT_TARGET_FLAG_FOW_VISIBLE + DOTA_UNIT_TARGET_FLAG_NO_INVIS,
		FIND_CLOSEST,
		false
	)

	if #enemies > 0 then
		return Approach(enemies[1])
	end
	return 0.5
end

function Approach(unit)
	local vToEnemy = unit:GetOrigin() - thisEntity:GetOrigin()
	vToEnemy = vToEnemy:Normalized()
	ExecuteOrderFromTable({
		UnitIndex = thisEntity:entindex(),
		OrderType = DOTA_UNIT_ORDER_MOVE_TO_POSITION,
		Position = thisEntity:GetOrigin() + vToEnemy * thisEntity:GetIdealSpeed(),
	})
	return 0.5
end