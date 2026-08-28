--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 0b85d8d 
  ~ auto-generated — do not edit
]]


function Spawn(entityKeyValues)
	if not IsServer() then
		return
	end

	if thisEntity == nil then
		return
	end
	thisEntity:SetContextThink("NeutralThink", NeutralThink, 1)
end

function NeutralThink()
	if not thisEntity:IsAlive() then
		return -1
	end

	if GameRules:IsGamePaused() == true then
		return 1
	end

	local enemies = FindUnitsInRadius(
		DOTA_TEAM_GOODGUYS,
		thisEntity:GetOrigin(),
		thisEntity,
		500,
		DOTA_UNIT_TARGET_TEAM_FRIENDLY,
		DOTA_UNIT_TARGET_HERO,
		DOTA_UNIT_TARGET_FLAG_NONE,
		FIND_CLOSEST,
		false
	)

	if #enemies > 0 then
		local enemy = enemies[1]
		local away_vector = (thisEntity:GetOrigin() - enemy:GetOrigin()):Normalized()
		local angle_offset = -70
		local final_direction = RotatePosition(Vector(0, 0, 0), QAngle(0, angle_offset, 0), away_vector)
		thisEntity:SetForwardVector(final_direction)
	end
	return 1.0
end