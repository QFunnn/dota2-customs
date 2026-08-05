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
	thisEntity:SetContextThink("NecroLordThink", NecroLordThink, 0.5)
end

function NecroLordThink()
	if not thisEntity:IsAlive() then
		return -1
	end

	if GameRules:IsGamePaused() == true then
		return 1
	end

	if thisEntity:GetDayTimeVisionRange() >= 1000 then
		return -1
	end

	local enemies = _G.OldFindUnitsInRadius(
		thisEntity:GetTeamNumber(),
		thisEntity:GetOrigin(),
		thisEntity,
		150,
		DOTA_UNIT_TARGET_TEAM_FRIENDLY,
		DOTA_UNIT_TARGET_HERO,
		DOTA_UNIT_TARGET_FLAG_NONE,
		FIND_CLOSEST,
		false
	)

	if #enemies > 0 then
		thisEntity:SetDayTimeVisionRange(1500)
		thisEntity:SetNightTimeVisionRange(1500)
		quest_system:quest_23()
		local particleLeader =
			ParticleManager:CreateParticle("particles/dire_fx/fire_barracks.vpcf", PATTACH_OVERHEAD_FOLLOW, thisEntity)
		ParticleManager:SetParticleControlEnt(
			particleLeader,
			PATTACH_OVERHEAD_FOLLOW,
			thisEntity,
			PATTACH_OVERHEAD_FOLLOW,
			"follow_overhead",
			thisEntity:GetAbsOrigin(),
			true
		)
		thisEntity:Attribute_SetIntValue("particleID", particleLeader)
		return -1
	end
	return 0.5
end