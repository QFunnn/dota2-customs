--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


spray_custom = spray_custom or class({})


function spray_custom:OnSpellStart()
	if not IsServer() then return end

	-- this ability belongs and is casted by dummy
	local caster = self:GetCaster()
	local player_id = caster:GetPlayerOwnerID()
	local hero = PlayerResource:GetSelectedHeroEntity(player_id)

	local cast_postion = self:GetCursorPosition()

	local equipped_spray = Equipment:GetItemInSlot(player_id, INVENTORY_SLOTS.SPRAY)

	if not equipped_spray then
		DisplayError(player_id, "#dota_hud_error_no_spray_equipped")
		return
	end

	-- remove currently applied spray
	if equipped_spray.particles and #equipped_spray.particles > 0 then
		ParticleManager:DestroyParticle(equipped_spray.particles[1], true)
		ParticleManager:ReleaseParticleIndex(equipped_spray.particles[1])
		equipped_spray.particles = {}
	end

	-- cloudy particle of spray application
	-- released immediately
	local spray_creation_p_id = ParticleManager:CreateParticle(
		"particles/sprays/spray_placement.vpcf",
		PATTACH_WORLDORIGIN,
		nil
	)
	ParticleManager:SetParticleControl(spray_creation_p_id, 0, cast_postion)
	ParticleManager:ReleaseParticleIndex(spray_creation_p_id)

	-- spray particle itself
	-- lifetime controlled by equipment framework (and condition above)
	local spray_name = equipped_spray.name
	local particle_name = ITEM_DEFINITIONS[spray_name].particles[1].path
	local spray_p_id = ParticleManager:CreateParticle(particle_name, PATTACH_WORLDORIGIN, nil)
	ParticleManager:SetParticleControl(spray_p_id, 0, cast_postion)
	ParticleManager:SetParticleControl(spray_p_id, 1, Vector(196, 99999, 0))

	EmitSoundOnLocationWithCaster(cast_postion, "Spraywheel.Paint", hero)

	equipped_spray.particles = equipped_spray.particles or {}
	table.insert(equipped_spray.particles, spray_p_id)
end