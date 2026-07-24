--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_item_timeless_relic_custom", "items/item_timeless_relic_custom", LUA_MODIFIER_MOTION_NONE)

item_timeless_relic_custom = class({})

function item_timeless_relic_custom:GetIntrinsicModifierName()
	return "modifier_item_timeless_relic_custom"
end

modifier_item_timeless_relic_custom = class({})
function modifier_item_timeless_relic_custom:IsHidden() return true end
function modifier_item_timeless_relic_custom:IsPurgable() return false end
function modifier_item_timeless_relic_custom:IsPurgeException() return false end
function modifier_item_timeless_relic_custom:RemoveOnDeath() return false end

function modifier_item_timeless_relic_custom:DeclareFunctions()
	return
	{
		MODIFIER_PROPERTY_SPELL_AMPLIFY_PERCENTAGE,
	}
end

function modifier_item_timeless_relic_custom:GetModifierSpellAmplify_Percentage()
	if not self:GetAbility() then return end
	return self:GetAbility():GetSpecialValueFor("spell_amp")
end

function modifier_item_timeless_relic_custom:CustomIncreaseModifierDuration()
	return self:GetAbility():GetSpecialValueFor("debuff_amp")
end