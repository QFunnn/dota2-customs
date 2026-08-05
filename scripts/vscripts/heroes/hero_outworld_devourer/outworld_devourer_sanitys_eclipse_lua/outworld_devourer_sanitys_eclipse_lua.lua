--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 9d26fbd · 2026-08-05 05:42:45 UTC
  ~ auto-generated — do not edit
]]


outworld_devourer_sanitys_eclipse_lua = class({})

function outworld_devourer_sanitys_eclipse_lua:GetAOERadius()
	return self:GetSpecialValueFor("radius")
end

function outworld_devourer_sanitys_eclipse_lua:OnSpellStart()
	local caster = self:GetCaster()
	local point = self:GetCursorPosition()

	local radius = self:GetSpecialValueFor("radius")

	local mana_mult = self:GetSpecialValueFor("mana_mult")

	local abil = self:GetCaster():FindAbilityByName("special_bonus_outworld_devourer_tal4")
	if abil ~= nil and abil:GetLevel() > 0 then
		mana_mult = self:GetSpecialValueFor("mana_mult") + 0.1
	end
	if not IsServer() then
		return
	end

	local damage = self:GetSpecialValueFor("damage")
		+ self:GetCaster():ExtraIntelligenceDamage() * self:GetSpecialValueFor("ExtraIntelligenceDamage")
	local try_damage = caster:GetMana() * mana_mult + damage
	local damageTable = {
		attacker = caster,
		damage_type = self:GetAbilityDamageType(),
		ability = self, --Optional.
	}

	local enemies = FindUnitsInRadius(
		caster:GetTeamNumber(),
		point,
		nil,
		radius,
		DOTA_UNIT_TARGET_TEAM_ENEMY,
		DOTA_UNIT_TARGET_ALL,
		DOTA_UNIT_TARGET_FLAG_INVULNERABLE + DOTA_UNIT_TARGET_FLAG_OUT_OF_WORLD,
		0,
		false
	)
	for _, enemy in pairs(enemies) do
		local astral = enemy:HasModifier("modifier_outworld_devourer_astral_imprisonment_lua")
		if enemy:IsOutOfGame() == astral then
			damageTable.victim = enemy
			damageTable.damage = try_damage

			if astral then
				damageTable.damage_flags = DOTA_DAMAGE_FLAG_BYPASSES_INVULNERABILITY
			else
				damageTable.damage_flags = 0
			end

			ApplyDamage(damageTable)
		end
	end
	self:PlayEffects(point, radius)
end

--------------------------------------------------------------------------------
function outworld_devourer_sanitys_eclipse_lua:PlayEffects(point, radius)
	local particle_cast = "particles/units/heroes/hero_obsidian_destroyer/obsidian_destroyer_sanity_eclipse_area.vpcf"
	local sound_cast1 = "Hero_ObsidianDestroyer.Sanityeclipse.Cast"
	local sound_cast2 = "Hero_ObsidianDestroyer.Sanityeclipse"

	local effect_cast = ParticleManager:CreateParticle(particle_cast, PATTACH_WORLDORIGIN, nil)
	ParticleManager:SetParticleControl(effect_cast, 0, point)
	ParticleManager:SetParticleControl(effect_cast, 1, Vector(radius, radius, 0))
	ParticleManager:SetParticleControl(effect_cast, 2, Vector(radius, radius, radius))
	ParticleManager:ReleaseParticleIndex(effect_cast)

	EmitSoundOn(sound_cast1, self:GetCaster())
	-- EmitSoundOnLocationWithCaster( point, sound_cast2, self:GetCaster() )
	EmitSoundOn(sound_cast2, self:GetCaster())
end