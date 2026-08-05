--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 9d26fbd · 2026-08-05 05:42:45 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_item_magic_soul", "items/d_items/item_magic_soul", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_item_magic_soul_effect", "items/d_items/item_magic_soul", LUA_MODIFIER_MOTION_NONE)

--------------------------------------------------------------------------------

item_magic_soul = item_magic_soul or class({})
item_magic_soul2 = item_magic_soul or class({})
item_magic_soul3 = item_magic_soul or class({})
item_magic_soul4 = item_magic_soul or class({})
item_magic_soul5 = item_magic_soul or class({})

function item_magic_soul:GetIntrinsicModifierName()
	return "modifier_item_magic_soul"
end

function item_magic_soul:Spawn()
	self.required_level = self:GetSpecialValueFor("required_level")
end

function item_magic_soul:OnHeroLevelUp()
	if IsServer() then
		if self:GetCaster():GetLevel() == self.required_level and self:IsInBackpack() == false then
			self:OnUnequip()
			self:OnEquip()
		end
	end
end

function item_magic_soul:IsMuted()
	if self.required_level > self:GetCaster():GetLevel() then
		return true
	end

	return self.BaseClass.IsMuted(self)
end

-----------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------

modifier_item_magic_soul = class({})

function modifier_item_magic_soul:IsHidden()
	return true
end

function modifier_item_magic_soul:IsPurgable()
	return false
end

function modifier_item_magic_soul:IsAura()
	return true
end

function modifier_item_magic_soul:GetTexture()
	return "soul"
end

function modifier_item_magic_soul:GetModifierAura()
	return "modifier_item_magic_soul_effect"
end

function modifier_item_magic_soul:GetAuraSearchTeam()
	return DOTA_UNIT_TARGET_TEAM_FRIENDLY
end

function modifier_item_magic_soul:GetAuraSearchType()
	return DOTA_UNIT_TARGET_ALL
end

function modifier_item_magic_soul:GetAuraRadius()
	return self.radius
end

function modifier_item_magic_soul:OnCreated(kv)
	self.radius = self:GetAbility():GetSpecialValueFor("AbilityCastRange")
	self.bonus_intelligence = self:GetAbility():GetSpecialValueFor("bonus_intelligence")
	self.cooldown_reduction_pct = self:GetAbility():GetSpecialValueFor("cooldown_reduction_pct")
end

function modifier_item_magic_soul:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_COOLDOWN_PERCENTAGE_STACKING,
		MODIFIER_PROPERTY_STATS_INTELLECT_BONUS,
		MODIFIER_ATTRIBUTE_NONE,
	}
	return funcs
end

function modifier_item_magic_soul:GetModifierBonusStats_Intellect(params)
	return self.bonus_intelligence
end

function modifier_item_magic_soul:GetModifierPercentageCooldownStacking(params)
	return self.cooldown_reduction_pct
end

function modifier_item_magic_soul:GetModifierUnitStatsNeedsRefresh(params)
	return 1
end

-----------------------------------------------------------------------------------------------------------------

modifier_item_magic_soul_effect = class({})

function modifier_item_magic_soul_effect:GetTexture()
	return "soul"
end

function modifier_item_magic_soul_effect:OnCreated(kv)
	self.cooldown_reduction_pct = self:GetAbility():GetSpecialValueFor("cooldown_reduction_pct")
	self.aura_mana_regen = self:GetAbility():GetSpecialValueFor("aura_mana_regen")
end

function modifier_item_magic_soul_effect:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_COOLDOWN_PERCENTAGE,
		MODIFIER_PROPERTY_MANA_REGEN_CONSTANT,
		MODIFIER_ATTRIBUTE_NONE,
	}
	return funcs
end

function modifier_item_magic_soul_effect:GetModifierConstantManaRegen(params)
	return self.aura_mana_regen
end

function modifier_item_magic_soul_effect:GetModifierPercentageCooldown(params)
	return self.cooldown_reduction_pct
end