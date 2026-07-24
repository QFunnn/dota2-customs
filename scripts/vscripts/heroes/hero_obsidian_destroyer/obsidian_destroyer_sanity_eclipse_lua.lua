--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


obsidian_destroyer_sanity_eclipse_lua = class({})

function obsidian_destroyer_sanity_eclipse_lua:GetAOERadius()
	return self:GetSpecialValueFor("radius")
end

function obsidian_destroyer_sanity_eclipse_lua:OnSpellStart()
	local caster = self:GetCaster()
	local target_location = self:GetCursorPosition()

	local radius = self:GetSpecialValueFor("radius")

	-- Particles and Sound
	caster:EmitSound("Hero_ObsidianDestroyer.SanityEclipse")

	local particle_cast = ParticleManager:GetParticleReplacement("particles/units/heroes/hero_obsidian_destroyer/obsidian_destroyer_sanity_eclipse_area.vpcf", caster)
	local particle_damage = ParticleManager:GetParticleReplacement("particles/units/heroes/hero_obsidian_destroyer/obsidian_destroyer_sanity_eclipse_damage.vpcf", caster)

	local eclipse_cast_particle = ParticleManager:CreateParticle(particle_cast, PATTACH_POINT, caster)
	ParticleManager:SetParticleControl(eclipse_cast_particle, 0, target_location)
	ParticleManager:SetParticleControl(eclipse_cast_particle, 1, Vector(radius, radius, 1))
	ParticleManager:SetParticleControl(eclipse_cast_particle, 2, Vector(1, 1, radius))
	ParticleManager:ReleaseParticleIndex(eclipse_cast_particle)

	-- Ability Logic
	local damage_base = self:GetSpecialValueFor("base_damage")
	local damage_mana_multiplier = self:GetSpecialValueFor("damage_multiplier")
	
	local enemies = FindUnitsInRadius(
		caster:GetTeam(), 
		target_location, 
		nil, 
		radius, 
		DOTA_UNIT_TARGET_TEAM_ENEMY, 
		DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC, 
		DOTA_UNIT_TARGET_FLAG_INVULNERABLE + DOTA_UNIT_TARGET_FLAG_OUT_OF_WORLD, -- Invulnerability + out of world flag only for astral imprisoned targets
		FIND_ANY_ORDER, false
	)

	local damage_table = {
		damage_type		= self:GetAbilityDamageType(),
		damage_flags 	= DOTA_DAMAGE_FLAG_BYPASSES_INVULNERABILITY,
		attacker 		= caster,
		ability 		= self
	}

	for _,enemy in pairs(enemies) do
		if (not enemy:IsInvulnerable() and not enemy:IsOutOfGame()) or enemy:HasModifier("modifier_obsidian_destroyer_astral_imprisonment_prison") then
			local max_mana_difference = math.max(caster:GetMaxMana() - enemy:GetMaxMana(), 0)
			
			damage_table.damage = damage_base + damage_mana_multiplier * max_mana_difference
			damage_table.victim = enemy
			ApplyDamage(damage_table)

			local eclipse_damage_particle = ParticleManager:CreateParticle(self.particle_damage, PATTACH_ABSORIGIN_FOLLOW, enemy)
			ParticleManager:ReleaseParticleIndex(eclipse_damage_particle)
		end
	end
end