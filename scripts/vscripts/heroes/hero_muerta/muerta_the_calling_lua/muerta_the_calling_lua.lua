--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build b9dc48c · 2026-08-02 17:42:46 UTC
  ~ auto-generated — do not edit
]]


muerta_the_calling_lua = class({})
LinkLuaModifier(
	"modifier_muerta_the_calling_lua_thinker",
	"heroes/hero_muerta/muerta_the_calling_lua/muerta_the_calling_lua",
	LUA_MODIFIER_MOTION_HORIZONTAL
)
LinkLuaModifier(
	"modifier_muerta_the_calling_lua_slow",
	"heroes/hero_muerta/muerta_the_calling_lua/muerta_the_calling_lua",
	LUA_MODIFIER_MOTION_NONE
)

function muerta_the_calling_lua:OnSpellStart()
	local caster = self:GetCaster()
	local point = self:GetCaster():GetOrigin()

	local duration = self:GetSpecialValueFor("duration")

	local modifier =
		caster:AddNewModifier(caster, self, "modifier_muerta_the_calling_lua_thinker", { duration = duration })
	local sound_cast = "Hero_Muerta.Revenants.Cast"
	-- EmitSoundOnLocationWithCaster(point, sound_cast, caster)
	EmitSoundOn(sound_cast, caster)
end

-------------------------------------------------------------------------------------------

modifier_muerta_the_calling_lua_thinker = class({})

function modifier_muerta_the_calling_lua_thinker:IsHidden()
	return true
end

function modifier_muerta_the_calling_lua_thinker:IsPurgable()
	return false
end

function modifier_muerta_the_calling_lua_thinker:OnCreated(kv)
	self.parent = self:GetParent()
	self.ability = self:GetAbility()
	self.radius = self:GetAbility():GetSpecialValueFor("radius")
	self:StartIntervalThink(0)
	self:PlayEffects()
end

function modifier_muerta_the_calling_lua_thinker:IsAura()
	return true
end

function modifier_muerta_the_calling_lua_thinker:GetModifierAura()
	return "modifier_muerta_the_calling_lua_slow"
end

function modifier_muerta_the_calling_lua_thinker:GetAuraRadius()
	return self.radius
end

function modifier_muerta_the_calling_lua_thinker:GetAuraDuration()
	return 0.5
end

function modifier_muerta_the_calling_lua_thinker:GetAuraSearchTeam()
	return DOTA_UNIT_TARGET_TEAM_ENEMY
end

function modifier_muerta_the_calling_lua_thinker:GetAuraSearchType()
	return DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC
end

function modifier_muerta_the_calling_lua_thinker:PlayEffects()
	local particle_cast = "particles/units/heroes/hero_muerta/muerta_calling.vpcf"
	local sound_cast1 = "Hero_Muerta.Revenants"
	local sound_cast2 = "Hero_Muerta.Revenants.Layer"

	local caster = self:GetCaster()
	local parent = self:GetParent()

	self.effect_cast = ParticleManager:CreateParticle(particle_cast, PATTACH_ABSORIGIN_FOLLOW, caster)
	ParticleManager:SetParticleControl(self.effect_cast, 1, Vector(self.radius, 0, 0))
	ParticleManager:SetParticleControlEnt(
		self.effect_cast,
		2,
		caster,
		PATTACH_ABSORIGIN_FOLLOW,
		"attach_hitloc",
		Vector(0, 0, 0), -- unknown
		true -- unknown, true
	)

	self:AddParticle(
		self.effect_cast,
		false, -- bDestroyImmediately
		false, -- bStatusEffect
		-1, -- iPriority
		false, -- bHeroEffect
		false -- bOverheadEffect
	)

	EmitSoundOn(sound_cast1, self.parent)
	EmitSoundOn(sound_cast2, self.parent)
end

--------------------------------------------------------------------------------

modifier_muerta_the_calling_lua_slow = class({})

function modifier_muerta_the_calling_lua_slow:IsHidden()
	return true
end

function modifier_muerta_the_calling_lua_slow:IsDebuff()
	return true
end

function modifier_muerta_the_calling_lua_slow:IsPurgable()
	return false
end

function modifier_muerta_the_calling_lua_slow:OnCreated(kv)
	self.ms_slow = self:GetAbility():GetSpecialValueFor("aura_movespeed_slow")
	self.as_slow = self:GetAbility():GetSpecialValueFor("aura_attackspeed_slow")
	self.spell_ampl = self:GetAbility():GetSpecialValueFor("spell_ampl")

	if not IsServer() then
		return
	end
end

function modifier_muerta_the_calling_lua_slow:OnRefresh(kv) end

function modifier_muerta_the_calling_lua_slow:OnRemoved() end

function modifier_muerta_the_calling_lua_slow:OnDestroy() end

function modifier_muerta_the_calling_lua_slow:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_ATTACKSPEED_BONUS_CONSTANT,
		MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE,
		MODIFIER_PROPERTY_INCOMING_DAMAGE_PERCENTAGE,
	}
	return funcs
end

function modifier_muerta_the_calling_lua_slow:GetModifierAttackSpeedBonus_Constant()
	return self.as_slow
end

function modifier_muerta_the_calling_lua_slow:GetModifierMoveSpeedBonus_Percentage()
	return self.ms_slow
end

function modifier_muerta_the_calling_lua_slow:GetEffectName()
	return "particles/units/heroes/hero_muerta/muerta_calling_debuff_slow.vpcf"
end

function modifier_muerta_the_calling_lua_slow:GetEffectAttachType()
	return PATTACH_ABSORIGIN_FOLLOW
end

function modifier_muerta_the_calling_lua_slow:GetModifierIncomingDamage_Percentage(keys)
	if keys.damage_category == DOTA_DAMAGE_CATEGORY_SPELL then
		return self.spell_ampl
	end
end