--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build b9dc48c · 2026-08-02 17:42:46 UTC
  ~ auto-generated — do not edit
]]


leshrac_split_earth_lua = class({})

function leshrac_split_earth_lua:GetAOERadius()
	return self:GetSpecialValueFor("main_blast_radius")
end

function leshrac_split_earth_lua:IsNetherWardStealable()
	return true
end

function leshrac_split_earth_lua:IsHiddenWhenStolen()
	return false
end

function leshrac_split_earth_lua:OnSpellStart()
	local caster = self:GetCaster()
	local ability = self
	local target_point = self:GetCursorPosition()
	local sound_cast = "Hero_Leshrac.Split_Earth"
	local particle_blast = "particles/units/heroes/hero_leshrac/leshrac_split_earth.vpcf"

	local mini_blast_count = 1
	local delay = ability:GetSpecialValueFor("delay")

	self.duration = ability:GetSpecialValueFor("duration")
	local mini_blast_distance = 200
	local mini_blast_radius = ability:GetSpecialValueFor("radius")

	if not IsServer() then
		return
	end
	self.damage = ability:GetSpecialValueFor("damage")
		+ self:GetCaster():ExtraIntelligenceDamage() * self:GetSpecialValueFor("ExtraIntelligenceDamage")
	if self:GetCaster():FindAbilityByName("special_bonus_leshrac_agi1") ~= nil then
		if self:GetCaster():FindAbilityByName("special_bonus_leshrac_agi1"):GetLevel() > 0 then
			self.damage = self:GetAbilityDamage() + 200
		end
	end

	if self:GetCaster():FindAbilityByName("special_bonus_leshrac_agi2") ~= nil then
		if self:GetCaster():FindAbilityByName("special_bonus_leshrac_agi2"):GetLevel() > 0 then
			mini_blast_count = 3
		end
	end

	EmitSoundOn(sound_cast, caster)

	for i = 1, mini_blast_count do
		local angle_gaps = 360 / mini_blast_count

		local qangle = QAngle(0, (i - 1) * angle_gaps, 0)
		local direction = (target_point - caster:GetAbsOrigin()):Normalized()

		local spawn_point = target_point + direction * mini_blast_distance

		if mini_blast_count == 1 then
			spawn_point = target_point
		end

		local mini_blast_center = RotatePosition(target_point, qangle, spawn_point)

		local particle_blast_fx = ParticleManager:CreateParticle(particle_blast, PATTACH_ABSORIGIN, caster)
		ParticleManager:SetParticleControl(particle_blast_fx, 0, mini_blast_center)
		ParticleManager:SetParticleControl(particle_blast_fx, 1, Vector(mini_blast_radius, 0, 0))
		ParticleManager:ReleaseParticleIndex(particle_blast_fx)

		local enemies = FindUnitsInRadius(
			caster:GetTeamNumber(),
			mini_blast_center,
			caster,
			mini_blast_radius,
			DOTA_UNIT_TARGET_TEAM_ENEMY,
			DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,
			DOTA_UNIT_TARGET_FLAG_NONE,
			FIND_ANY_ORDER,
			false
		)

		for _, enemy in pairs(enemies) do
			enemy:AddNewModifier(
				caster, -- player source
				self, -- ability source
				"modifier_stunned", -- modifier name
				{ duration = self.duration } -- kv
			)

			local damageTable = {
				victim = enemy,
				damage = self.damage,
				damage_type = DAMAGE_TYPE_MAGICAL,
				attacker = caster,
				ability = ability,
			}
			ApplyDamage(damageTable)
		end
	end
end