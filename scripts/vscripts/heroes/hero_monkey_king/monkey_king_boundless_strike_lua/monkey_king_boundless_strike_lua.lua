--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 9d26fbd · 2026-08-05 05:42:45 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier(
	"modifier_monkey_king_boundless_strike_lua_crit",
	"heroes/hero_monkey_king/monkey_king_boundless_strike_lua/monkey_king_boundless_strike_lua",
	LUA_MODIFIER_MOTION_NONE
)

monkey_king_boundless_strike_lua = class({})

function monkey_king_boundless_strike_lua:GetCooldown(level)
	local ability = self:GetCaster():FindAbilityByName("special_bonus_monkey_king_8")
	if ability ~= nil and ability:GetLevel() > 0 then
		return self.BaseClass.GetCooldown(self, level) - 6
	end
	return self.BaseClass.GetCooldown(self, level)
end

function monkey_king_boundless_strike_lua:OnAbilityPhaseStart()
	EmitSoundOn("Hero_MonkeyKing.Strike.Cast", self:GetCaster())
	self.pfx = ParticleManager:CreateParticle(
		"particles/units/heroes/hero_monkey_king/monkey_king_strike_cast.vpcf",
		PATTACH_POINT_FOLLOW,
		self:GetCaster()
	)
	ParticleManager:SetParticleControl(self.pfx, 0, self:GetCaster():GetAbsOrigin())
	ParticleManager:SetParticleControlEnt(
		self.pfx,
		1,
		self:GetCaster(),
		PATTACH_POINT_FOLLOW,
		"attach_weapon_bot",
		self:GetCaster():GetAbsOrigin(),
		true
	)
	ParticleManager:SetParticleControlEnt(
		self.pfx,
		2,
		self:GetCaster(),
		PATTACH_POINT_FOLLOW,
		"attach_weapon_top",
		self:GetCaster():GetAbsOrigin(),
		true
	)
	ParticleManager:ReleaseParticleIndex(self.pfx)
	return true
end

function monkey_king_boundless_strike_lua:OnAbilityPhaseInterrupted()
	ParticleManager:DestroyParticle(self.pfx, true)
	ParticleManager:ReleaseParticleIndex(self.pfx)
end

function monkey_king_boundless_strike_lua:OnSpellStart()
	local start_point = self:GetCaster():GetAbsOrigin()
	local end_point = (self:GetCursorPosition() - start_point):Normalized() * self:GetCastRange(start_point, nil)
		+ start_point
	local width = self:GetSpecialValueFor("strike_radius")
	local stun_duration = self:GetSpecialValueFor("stun_duration")
	local mod = self:GetCaster()
		:AddNewModifier(self:GetCaster(), self, "modifier_monkey_king_boundless_strike_lua_crit", {})
	local units = FindUnitsInLine(
		self:GetCaster():GetTeamNumber(),
		start_point,
		end_point,
		nil,
		width,
		DOTA_UNIT_TARGET_TEAM_ENEMY,
		DOTA_UNIT_TARGET_BASIC + DOTA_UNIT_TARGET_HERO,
		DOTA_UNIT_TARGET_FLAG_NONE
	)
	local m = self:GetCaster():FindModifierByName("modifier_monkey_king_jingu_mastery_lua_active")
	if m then
		m:DecrementStackCount()
	end
	self:GetCaster().cast_boundless_strike = true
	for _, u in pairs(units) do
		u:AddNewModifier(self:GetCaster(), self, "modifier_stunned", { duration = stun_duration })
		self:GetCaster():PerformAttack(u, true, true, true, true, false, false, true)
	end
	self:GetCaster().cast_boundless_strike = false
	mod:Destroy()

	local sound_cast_1 = "Hero_MonkeyKing.Strike.Impact"
	-- EmitSoundOnLocationWithCaster(start_point, sound_cast_1, self:GetCaster())
	EmitSoundOn(sound_cast_1, self:GetCaster())
	local sound_cast_2 = "Hero_MonkeyKing.Strike.Impact.EndPos"
	-- EmitSoundOnLocationWithCaster(end_point, sound_cast_2, self:GetCaster())
	EmitSoundOn(sound_cast_2, self:GetCaster())

	local pfx = ParticleManager:CreateParticle(
		"particles/units/heroes/hero_monkey_king/monkey_king_strike.vpcf",
		PATTACH_POINT,
		self:GetCaster()
	)
	ParticleManager:SetParticleControl(pfx, 1, end_point)
	ParticleManager:ReleaseParticleIndex(pfx)
end

---------------------------------------------------------

modifier_monkey_king_boundless_strike_lua_crit = class({})

function modifier_monkey_king_boundless_strike_lua_crit:IsHidden()
	return true
end

function modifier_monkey_king_boundless_strike_lua_crit:IsPurgable()
	return false
end

function modifier_monkey_king_boundless_strike_lua_crit:OnCreated()
	self.strike_crit_mult = self:GetAbility():GetSpecialValueFor("strike_crit_mult")
	self.strike_bonus_damage = self:GetAbility():GetSpecialValueFor("strike_bonus_damage")

	local ability = self:GetCaster():FindAbilityByName("special_bonus_monkey_king_2")
	if ability ~= nil and ability:GetLevel() > 0 then
		self.strike_crit_mult = self.strike_crit_mult + 100
	end

	local ability = self:GetCaster():FindAbilityByName("special_bonus_monkey_king_4")
	if ability ~= nil and ability:GetLevel() > 0 then
		self.strike_bonus_damage = self.strike_bonus_damage + 75
	end
end

function modifier_monkey_king_boundless_strike_lua_crit:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_PREATTACK_BONUS_DAMAGE,
		MODIFIER_PROPERTY_PREATTACK_CRITICALSTRIKE,
		MODIFIER_PROPERTY_OVERRIDE_ATTACK_MAGICAL,
		MODIFIER_PROPERTY_TOTALDAMAGEOUTGOING_PERCENTAGE,
	}
end

function modifier_monkey_king_boundless_strike_lua_crit:GetModifierPreAttack_BonusDamage()
	return self.strike_bonus_damage
end

function modifier_monkey_king_boundless_strike_lua_crit:GetModifierPreAttack_CriticalStrike()
	return self.strike_crit_mult
end

function modifier_monkey_king_boundless_strike_lua_crit:GetOverrideAttackMagical()
	return 1
end