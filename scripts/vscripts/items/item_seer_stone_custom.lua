--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_item_seer_stone_custom", "items/item_seer_stone_custom", LUA_MODIFIER_MOTION_NONE)

item_seer_stone_custom = class({})

function item_seer_stone_custom:GetIntrinsicModifierName()
	return "modifier_item_seer_stone_custom"
end

modifier_item_seer_stone_custom = class({})

function modifier_item_seer_stone_custom:IsHidden() return true end

function modifier_item_seer_stone_custom:IsPurgable() return false end
function modifier_item_seer_stone_custom:IsPurgeException() return false end

function modifier_item_seer_stone_custom:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_CAST_RANGE_BONUS_STACKING,
		MODIFIER_PROPERTY_MANA_REGEN_TOTAL_PERCENTAGE
	}
end

function modifier_item_seer_stone_custom:GetModifierCastRangeBonusStacking()
	return self:GetAbility():GetSpecialValueFor("cast_range_bonus")
end

function modifier_item_seer_stone_custom:GetModifierTotalPercentageManaRegen()
	return self:GetAbility():GetSpecialValueFor("mana_regen")
end