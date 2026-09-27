--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1a5b3bb 
  ~ auto-generated — do not edit
]]


local function bevavior()
	if not IsValidEntity(thisEntity) then
		return -1
	end
	if not thisEntity.spawn then
		return 0.1
	end
	if not thisEntity:IsAlive() then
		return -1
	end
	if GameRules:IsGamePaused() then
		return 0.5
	end
	if thisEntity:HasModifier("modifier_patrol_start") then
		return 0.1
	end

	if thisEntity.go_on_start then
		thisEntity.go_on_start = false
		thisEntity.gospawn_ordered = false
		thisEntity:AddNewModifier(thisEntity, nil, "modifier_patrol_gospawn", {})
	end

	if thisEntity:HasModifier("modifier_patrol_gospawn") then
		if not thisEntity.gospawn_ordered or not thisEntity:IsMoving() then
			thisEntity.gospawn_ordered = true
			thisEntity:MoveToPosition(thisEntity.spawn)
		end

		if (thisEntity:GetAbsOrigin() - thisEntity.spawn):Length2D() < 10 then
			thisEntity:RemoveModifierByName("modifier_patrol_gospawn")
		end

		return 0.1
	end

	if (thisEntity:GetAbsOrigin() - thisEntity.spawn):Length2D() > thisEntity.spawn_radius then
		thisEntity.gospawn_ordered = false
		thisEntity:AddNewModifier(thisEntity, nil, "modifier_patrol_gospawn", {})
		return 0.1
	end

	local enemy = thisEntity:FindTargets(
		thisEntity.agro,
		nil,
		nil,
		DOTA_UNIT_TARGET_FLAG_FOW_VISIBLE
			+ DOTA_UNIT_TARGET_FLAG_NOT_ANCIENTS
			+ DOTA_UNIT_TARGET_FLAG_INVULNERABLE
			+ DOTA_UNIT_TARGET_FLAG_OUT_OF_WORLD
	)[1]

	if enemy then
		thisEntity:MoveToTargetToAttack(enemy)
	end

	return 0.5
end

function Spawn()
	if not IsServer() then
		return
	end
	if not IsValidEntity(thisEntity) then
		return
	end

	thisEntity.agro = 450
	thisEntity.spawn_radius = 600
	thisEntity.go_on_start = true

	thisEntity:SetContextThink("bevavior", bevavior, FrameTime())
end