--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 9d26fbd · 2026-08-05 05:42:45 UTC
  ~ auto-generated — do not edit
]]


zuus_thundergods_wrath_lua = class({})

function zuus_thundergods_wrath_lua:OnAbilityPhaseStart()
	self:GetCaster():EmitSound("Hero_Zuus.GodsWrath.PreCast")
	local attack_lock = self:GetCaster():GetAttachmentOrigin(self:GetCaster():ScriptLookupAttachment("attach_attack1"))
	self.thundergod_spell_cast = ParticleManager:CreateParticle(
		"particles/units/heroes/hero_zuus/zuus_thundergods_wrath_start.vpcf",
		PATTACH_ABSORIGIN_FOLLOW,
		self:GetCaster()
	)
	ParticleManager:SetParticleControl(
		self.thundergod_spell_cast,
		0,
		Vector(attack_lock.x, attack_lock.y, attack_lock.z)
	)
	ParticleManager:SetParticleControl(
		self.thundergod_spell_cast,
		1,
		Vector(attack_lock.x, attack_lock.y, attack_lock.z)
	)
	ParticleManager:SetParticleControl(
		self.thundergod_spell_cast,
		2,
		Vector(attack_lock.x, attack_lock.y, attack_lock.z)
	)
	return true
end

function zuus_thundergods_wrath_lua:OnAbilityPhaseInterrupted()
	if self.thundergod_spell_cast then
		ParticleManager:DestroyParticle(self.thundergod_spell_cast, true)
		ParticleManager:ReleaseParticleIndex(self.thundergod_spell_cast)
		self.thundergod_spell_cast = nil
	end
end

function zuus_thundergods_wrath_lua:OnSpellStart()
	if not IsServer() then
		return
	end

	local caster = self:GetCaster()
	local sight_radius = self:GetSpecialValueFor("sight_radius")
	local sight_duration = self:GetSpecialValueFor("sight_duration")
	local damage = self:GetSpecialValueFor("damage")
		+ caster:ExtraIntelligenceDamage() * self:GetSpecialValueFor("ExtraIntelligenceDamage")
	local position = caster:GetAbsOrigin()
	local range = self:GetCastRange(position, caster) + caster:GetCastRangeBonus()

	if self.thundergod_spell_cast then
		ParticleManager:ReleaseParticleIndex(self.thundergod_spell_cast)
		self.thundergod_spell_cast = nil
	end

	local sound_cast = "Hero_Zuus.GodsWrath"
	-- EmitSoundOnLocationForAllies(caster:GetAbsOrigin(), sound_cast, caster)
	EmitSoundOn(sound_cast, caster)

	-- Кэшируем таланты один раз
	local talent2 = caster:FindAbilityByName("special_bonus_zuus_2")
	local talent5 = caster:FindAbilityByName("special_bonus_zuus_5")

	local local_count = 1
	if talent2 and talent2:GetLevel() > 0 then
		local_count = 2
	end

	if talent5 and talent5:GetLevel() > 0 then
		damage = damage + 500
	end

	local damage_table = {
		attacker = caster,
		ability = self,
		damage_type = self:GetAbilityDamageType(),
		damage_flags = DOTA_DAMAGE_FLAG_NONE,
	}

	Timers:CreateTimer(0, function()
		local_count = local_count - 1
		local hEnemies = FindUnitsInRadius(
			caster:GetTeamNumber(),
			position,
			caster,
			range,
			DOTA_UNIT_TARGET_TEAM_ENEMY,
			DOTA_UNIT_TARGET_BASIC,
			DOTA_UNIT_TARGET_FLAG_NONE,
			FIND_CLOSEST,
			false
		)
		for _, enemy in pairs(hEnemies) do
			if enemy:IsAlive() then
				local target_point = enemy:GetAbsOrigin()
				local strike_pfx = ParticleManager:CreateParticle(
					"particles/units/heroes/hero_zuus/zuus_thundergods_wrath.vpcf",
					PATTACH_ABSORIGIN_FOLLOW,
					enemy
				)
				ParticleManager:SetParticleControl(
					strike_pfx,
					0,
					Vector(target_point.x, target_point.y, target_point.z + enemy:GetBoundingMaxs().z)
				)
				ParticleManager:SetParticleControl(strike_pfx, 1, Vector(target_point.x, target_point.y, 2000))
				ParticleManager:SetParticleControl(
					strike_pfx,
					2,
					Vector(target_point.x, target_point.y, target_point.z + enemy:GetBoundingMaxs().z)
				)
				ParticleManager:ReleaseParticleIndex(strike_pfx) -- фикс утечки

				if not enemy:IsMagicImmune() and not enemy:IsInvisible() then
					damage_table.damage = damage
					damage_table.victim = enemy
					ApplyDamage(damage_table)

					AddFOWViewer(caster:GetTeamNumber(), target_point, sight_radius, sight_duration, false)

					Timers:CreateTimer(FrameTime(), function()
						if not enemy:IsNull() and not enemy:IsAlive() then
							local kill_pfx = ParticleManager:CreateParticle(
								"particles/units/heroes/hero_zeus/zues_kill_empty.vpcf",
								PATTACH_WORLDORIGIN,
								nil
							)
							ParticleManager:SetParticleControl(kill_pfx, 0, enemy:GetAbsOrigin())
							ParticleManager:SetParticleControl(kill_pfx, 1, enemy:GetAbsOrigin())
							ParticleManager:SetParticleControl(kill_pfx, 2, enemy:GetAbsOrigin())
							ParticleManager:SetParticleControl(kill_pfx, 3, enemy:GetAbsOrigin())
							ParticleManager:SetParticleControl(kill_pfx, 6, enemy:GetAbsOrigin())
							ParticleManager:ReleaseParticleIndex(kill_pfx) -- фикс утечки
						end
					end)
				end
				enemy:EmitSound("Hero_Zuus.GodsWrath.Target")
			end
		end
		if local_count > 0 then
			return 0.5
		end
	end)
end