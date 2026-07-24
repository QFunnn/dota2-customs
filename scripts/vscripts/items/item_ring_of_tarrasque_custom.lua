--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_item_ring_of_tarrasque_custom", "items/item_ring_of_tarrasque_custom", LUA_MODIFIER_MOTION_NONE)

item_ring_of_tarrasque_custom = class({})

function item_ring_of_tarrasque_custom:GetIntrinsicModifierName()
	return "modifier_item_ring_of_tarrasque_custom"
end

modifier_item_ring_of_tarrasque_custom = class({})

function modifier_item_ring_of_tarrasque_custom:IsHidden() return true end
function modifier_item_ring_of_tarrasque_custom:IsPurgable() return false end
function modifier_item_ring_of_tarrasque_custom:IsPurgeException() return false end
function modifier_item_ring_of_tarrasque_custom:RemoveOnDeath() return false end

function modifier_item_ring_of_tarrasque_custom:DeclareFunctions()
	return
	{
		MODIFIER_PROPERTY_HEALTH_BONUS,
		MODIFIER_PROPERTY_HEALTH_REGEN_PERCENTAGE,
	}
end

function modifier_item_ring_of_tarrasque_custom:GetModifierHealthBonus()
	if not self:GetAbility() then return end
	return self:GetAbility():GetSpecialValueFor("bonus_health")
end

function modifier_item_ring_of_tarrasque_custom:GetModifierHealthRegenPercentage()
	if not self:GetAbility() then return end
	return self:GetAbility():GetSpecialValueFor("bonus_health_regen")
end