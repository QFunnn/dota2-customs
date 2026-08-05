--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 9d26fbd · 2026-08-05 05:42:45 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_zuus_passive", "heroes/hero_zuus/zuus_passive/zuus_passive", LUA_MODIFIER_MOTION_NONE)

zuus_passive = class({})

function zuus_passive:GetCastRange()
	self.radius = self:GetSpecialValueFor("radius")
	local talent = self:GetCaster():FindAbilityByName("special_bonus_zuus_7")
	if talent and talent:GetLevel() > 0 then
		self.radius = self.radius + 200
	end
	return self.radius - self:GetCaster():GetCastRangeBonus()
end

function zuus_passive:GetIntrinsicModifierName()
	return "modifier_zuus_passive"
end

--------------------

modifier_zuus_passive = class({})

function modifier_zuus_passive:IsHidden()
	return true
end

function modifier_zuus_passive:IsPurgable()
	return false
end

function modifier_zuus_passive:OnCreated(kv)
	if not IsServer() then
		return
	end
	Timers:CreateTimer(0, function()
		if self:IsNull() then
			return
		end

		local caster = self:GetCaster()
		local ability = self:GetAbility()

		local talent1 = caster:FindAbilityByName("special_bonus_zuus_1")
		local talent3 = caster:FindAbilityByName("special_bonus_zuus_3")
		local talent7 = caster:FindAbilityByName("special_bonus_zuus_7")

		local cast_time = (talent1 and talent1:GetLevel() > 0) and 2 or 3

		if not caster:IsAlive() then
			return cast_time
		end

		ability:StartCooldown(cast_time)

		local damage_per_int = ability:GetSpecialValueFor("dmg_per_int")
		if talent3 and talent3:GetLevel() > 0 then
			damage_per_int = damage_per_int + 0.2
		end

		local damage = damage_per_int * caster:GetIntellect(true)

		local radius = ability:GetSpecialValueFor("radius")
		if talent7 and talent7:GetLevel() > 0 then
			radius = radius + 200
		end

		local hEnemies = FindUnitsInRadius(
			caster:GetTeamNumber(),
			caster:GetAbsOrigin(),
			caster,
			radius,
			DOTA_UNIT_TARGET_TEAM_ENEMY,
			DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,
			DOTA_UNIT_TARGET_FLAG_FOW_VISIBLE,
			FIND_CLOSEST,
			false
		)

		for _, unit in pairs(hEnemies) do
			ApplyDamage({
				victim = unit,
				attacker = caster,
				damage = damage,
				damage_type = DAMAGE_TYPE_MAGICAL,
				damage_flags = DOTA_DAMAGE_FLAG_NONE,
				ability = ability,
			})
			local particle = ParticleManager:CreateParticle(
				"particles/units/heroes/hero_zuus/zuus_static_field.vpcf",
				PATTACH_ABSORIGIN_FOLLOW,
				unit
			)
			ParticleManager:SetParticleControl(particle, 0, unit:GetAbsOrigin())
			ParticleManager:ReleaseParticleIndex(particle)
			EmitSoundOn("Hero_Zuus.StaticField", unit)
		end

		return cast_time
	end)
end