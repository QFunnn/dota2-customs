--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build b9dc48c · 2026-08-02 17:42:46 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_item_power_pendant", "items/d_items/item_power_pendant", LUA_MODIFIER_MOTION_NONE)

--------------------------------------------------------------------------------
item_power_pendant = item_power_pendant or class({})
item_power_pendant2 = item_power_pendant or class({})
item_power_pendant3 = item_power_pendant or class({})
item_power_pendant4 = item_power_pendant or class({})
item_power_pendant5 = item_power_pendant or class({})

function item_power_pendant:GetIntrinsicModifierName()
	return "modifier_item_power_pendant"
end

function item_power_pendant:Spawn()
	self.required_level = self:GetSpecialValueFor("required_level")
end

function item_power_pendant:OnHeroLevelUp()
	if IsServer() then
		if self:GetCaster():GetLevel() == self.required_level and self:IsInBackpack() == false then
			self:OnUnequip()
			self:OnEquip()
		end
	end
end

function item_power_pendant:IsMuted()
	if self.required_level > self:GetCaster():GetLevel() then
		return true
	end

	return self.BaseClass.IsMuted(self)
end

function item_power_pendant:OnSpellStart()
	if IsServer() then
		self.caster = self:GetCaster()
		self.mp = self:GetSpecialValueFor("mp_cost")
		if self.caster:GetMana() >= self.mp then
			self.caster:Script_ReduceMana(self.mp, nil)
			EmitSoundOn("Hero_Dazzle.Shadow_Wave", self.caster)
			self.caster:Heal(self:GetSpecialValueFor("helth_recovery"), self)
			self:PlayEffects1(self.caster, self.caster)
		end
	end
end

function item_power_pendant:PlayEffects1(source, target)
	local particle_cast = "particles/units/heroes/hero_dazzle/dazzle_shadow_wave.vpcf"

	if not target then
		target = source
	end

	local effect_cast = ParticleManager:CreateParticle(particle_cast, PATTACH_ABSORIGIN_FOLLOW, source)

	ParticleManager:SetParticleControlEnt(
		effect_cast,
		0,
		source,
		PATTACH_POINT_FOLLOW,
		"attach_hitloc",
		source:GetOrigin(), -- unknown
		true -- unknown, true
	)
	ParticleManager:SetParticleControlEnt(
		effect_cast,
		1,
		target,
		PATTACH_POINT_FOLLOW,
		"attach_hitloc",
		target:GetOrigin(), -- unknown
		true -- unknown, true
	)
	ParticleManager:ReleaseParticleIndex(effect_cast)
end

-----------------------------------------------------------------------------------------------------------------------

modifier_item_power_pendant = class({})

function modifier_item_power_pendant:IsHidden()
	return true
end

function modifier_item_power_pendant:IsPurgable()
	return false
end

function modifier_item_power_pendant:GetAttributes()
	return MODIFIER_ATTRIBUTE_NONE
end

function modifier_item_power_pendant:OnCreated(kv)
	self.bonus_all = self:GetAbility():GetSpecialValueFor("bonus_all")
end

function modifier_item_power_pendant:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_STATS_STRENGTH_BONUS,
		MODIFIER_PROPERTY_STATS_AGILITY_BONUS,
		MODIFIER_PROPERTY_STATS_INTELLECT_BONUS,
		MODIFIER_ATTRIBUTE_NONE,
	}
	return funcs
end

function modifier_item_power_pendant:GetModifierBonusStats_Strength(params)
	return self.bonus_all
end

function modifier_item_power_pendant:GetModifierBonusStats_Agility(params)
	return self.bonus_all
end

function modifier_item_power_pendant:GetModifierBonusStats_Intellect(params)
	return self.bonus_all
end