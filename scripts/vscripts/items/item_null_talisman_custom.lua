--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_item_null_talisman_custom", "items/item_null_talisman_custom", LUA_MODIFIER_MOTION_NONE)

item_null_talisman_custom = class({})

function item_null_talisman_custom:GetIntrinsicModifierName()
	return "modifier_item_null_talisman_custom"
end

modifier_item_null_talisman_custom = class({})

function modifier_item_null_talisman_custom:IsHidden() return true end
function modifier_item_null_talisman_custom:IsPurgable() return false end
function modifier_item_null_talisman_custom:IsPurgeException() return false end
function modifier_item_null_talisman_custom:GetAttributes() return MODIFIER_ATTRIBUTE_MULTIPLE end

function modifier_item_null_talisman_custom:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_STATS_STRENGTH_BONUS,
		MODIFIER_PROPERTY_STATS_AGILITY_BONUS,
		MODIFIER_PROPERTY_STATS_INTELLECT_BONUS,
		MODIFIER_PROPERTY_EXTRA_MANA_PERCENTAGE,
		MODIFIER_PROPERTY_MANA_REGEN_CONSTANT,
	}
end

function modifier_item_null_talisman_custom:GetModifierBonusStats_Strength()
	return self:GetAbility():GetSpecialValueFor("bonus_strength")
end

function modifier_item_null_talisman_custom:GetModifierBonusStats_Agility()
	return self:GetAbility():GetSpecialValueFor("bonus_agility")
end

function modifier_item_null_talisman_custom:GetModifierBonusStats_Intellect()
	return self:GetAbility():GetSpecialValueFor("bonus_intellect")
end

function modifier_item_null_talisman_custom:GetModifierExtraManaPercentage()
	return self:GetAbility():GetSpecialValueFor("bonus_max_mana_percentage")
end

function modifier_item_null_talisman_custom:GetModifierConstantManaRegen()
	return self:GetAbility():GetSpecialValueFor("bonus_mana_regen")
end