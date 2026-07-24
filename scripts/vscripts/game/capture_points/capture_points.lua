--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


local ORB_PARTICLE_NAME = {
	[UPGRADE_RARITY_COMMON] = "particles/orb_common.vpcf",
	[UPGRADE_RARITY_RARE] = "particles/orb_rare.vpcf",
	[UPGRADE_RARITY_EPIC] = "particles/orb_epic.vpcf",
}

local ORB_PARTICLE_NAME_CHRISTMAS = {
	[UPGRADE_RARITY_COMMON] = "particles/orb_common_christmas.vpcf",
	[UPGRADE_RARITY_RARE] = "particles/orb_rare_christmas.vpcf",
	[UPGRADE_RARITY_EPIC] = "particles/orb_christmas.vpcf",
}

function GameMode:SpawnOrbDrop(spawn_point, orb_type, should_launch, on_destroyed_callback)
	EmitGlobalSound("Item.PickUpGemWorld")

	local capture_point = CreateUnitByName("npc_dummy_capture", spawn_point, false, nil, nil, DOTA_TEAM_NEUTRALS)
	capture_point:SetOrigin(spawn_point)
	capture_point:AddNewModifier(capture_point, nil, "capture_point_area", { orb_type = orb_type, should_launch = should_launch })
	capture_point.on_destroyed_callback = on_destroyed_callback

	local particle_name = ORB_PARTICLE_NAME[orb_type]

	if SeasonalEvents:IsChristmas() then particle_name = ORB_PARTICLE_NAME_CHRISTMAS[orb_type] end

	capture_point.orb_fx = ParticleManager:CreateParticle(particle_name, PATTACH_ABSORIGIN_FOLLOW, capture_point)
	local origin = GetGroundPosition(capture_point:GetOrigin(), capture_point)
	ParticleManager:SetParticleControl(capture_point.orb_fx, 0, origin)
	ParticleManager:SetParticleControl(capture_point.orb_fx, 3, origin)
	print("created orb particle", particle_name, capture_point.orb_fx, orb_type)

	return capture_point
end

-- models/props_winter/present.vmdl