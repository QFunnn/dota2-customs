--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_item_spy_gadget_custom", "items/item_spy_gadget_custom", LUA_MODIFIER_MOTION_NONE)

item_spy_gadget_custom = class({})

function item_spy_gadget_custom:GetIntrinsicModifierName()
	return "modifier_item_spy_gadget_custom"
end

modifier_item_spy_gadget_custom = class({})

function modifier_item_spy_gadget_custom:IsHidden() return true end

function modifier_item_spy_gadget_custom:IsPurgable() return false end
function modifier_item_spy_gadget_custom:IsPurgeException() return false end

function modifier_item_spy_gadget_custom:DeclareFunctions()
	return 
	{
		MODIFIER_PROPERTY_ATTACK_RANGE_BONUS,
		MODIFIER_PROPERTY_CAST_RANGE_BONUS_STACKING,
		MODIFIER_PROPERTY_CASTTIME_PERCENTAGE,
	}
end

function modifier_item_spy_gadget_custom:GetModifierAttackRangeBonus() 
	if not self:GetParent():IsRangedAttacker() then return 0 end
	return self:GetAbility():GetSpecialValueFor("attack_range") 
end

function modifier_item_spy_gadget_custom:GetModifierCastRangeBonusStacking() 
	return self:GetAbility():GetSpecialValueFor("cast_range") 
end

function modifier_item_spy_gadget_custom:GetModifierPercentageCasttime() 
	return self:GetAbility():GetSpecialValueFor("ability_cast_point") 
end