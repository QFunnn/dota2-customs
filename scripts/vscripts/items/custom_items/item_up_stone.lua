--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 0b85d8d 
  ~ auto-generated — do not edit
]]


item_up_stone = class({})
LinkLuaModifier("modifier_item_up_stone", "items/custom_items/item_up_stone", LUA_MODIFIER_MOTION_NONE)

--------------------------------------------------------------------------------

function item_up_stone:GetIntrinsicModifierName()
	return "modifier_item_up_stone"
end

modifier_item_up_stone = class({})

--------------------------------------------------------------------------------

function modifier_item_up_stone:IsHidden()
	return true
end

--------------------------------------------------------------------------------

function modifier_item_up_stone:IsPurgable()
	return false
end

function modifier_item_up_stone:GetAttributes()
	return MODIFIER_ATTRIBUTE_MULTIPLE
end

--------------------------------------------------------------------------------

function modifier_item_up_stone:OnCreated(kv)
	self.bonus_strength = self:GetAbility():GetSpecialValueFor("bonus_strength")
	self.bonus_agility = self:GetAbility():GetSpecialValueFor("bonus_agility")
	self.bonus_intelligence = self:GetAbility():GetSpecialValueFor("bonus_intelligence")
	self.bonus_resistance = self:GetAbility():GetSpecialValueFor("bonus_resistance")
	self.bonus_as = self:GetAbility():GetSpecialValueFor("bonus_as")
	self.bonus_md = self:GetAbility():GetSpecialValueFor("bonus_md")
end

--------------------------------------------------------------------------------

function modifier_item_up_stone:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_SPELL_AMPLIFY_PERCENTAGE,
		MODIFIER_PROPERTY_ATTACKSPEED_BONUS_CONSTANT,
		MODIFIER_PROPERTY_MAGICAL_RESISTANCE_BONUS,
		MODIFIER_PROPERTY_STATS_STRENGTH_BONUS,
		MODIFIER_PROPERTY_STATS_AGILITY_BONUS,
		MODIFIER_PROPERTY_STATS_INTELLECT_BONUS,
	}
	return funcs
end

--------------------------------------------------------------------------------

--------------------------------------------------------------------------------
function modifier_item_up_stone:GetModifierSpellAmplify_Percentage(params)
	return self.bonus_md
end

function modifier_item_up_stone:GetModifierAttackSpeedBonus_Constant(params)
	return self.bonus_as
end

function modifier_item_up_stone:GetModifierMagicalResistanceBonus(params)
	return self.bonus_resistance
end

function modifier_item_up_stone:GetModifierBonusStats_Intellect(params)
	return self.bonus_intelligence
end

function modifier_item_up_stone:GetModifierBonusStats_Agility(params)
	return self.bonus_agility
end

function modifier_item_up_stone:GetModifierBonusStats_Strength(params)
	return self.bonus_strength
end