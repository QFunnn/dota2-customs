--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_item_ascetic_cap_custom", "items/item_ascetic_cap_custom", LUA_MODIFIER_MOTION_NONE)

item_ascetic_cap_custom = class({})

function item_ascetic_cap_custom:GetIntrinsicModifierName()
	return "modifier_item_ascetic_cap_custom"
end

modifier_item_ascetic_cap_custom = class({})

function modifier_item_ascetic_cap_custom:IsHidden() return true end

function modifier_item_ascetic_cap_custom:IsPurgable() return false end
function modifier_item_ascetic_cap_custom:IsPurgeException() return false end

function modifier_item_ascetic_cap_custom:OnCreated()
	self.status_resistance = self:GetAbility():GetSpecialValueFor("status_resistance")
	self.bonus_health = self:GetAbility():GetSpecialValueFor("bonus_health")
	self.hp_regen = self:GetAbility():GetSpecialValueFor("hp_regen")
end

function modifier_item_ascetic_cap_custom:DeclareFunctions()
	return 
	{
		MODIFIER_PROPERTY_STATUS_RESISTANCE_STACKING,
		MODIFIER_PROPERTY_HEALTH_BONUS,
		MODIFIER_PROPERTY_HEALTH_REGEN_CONSTANT,
	}
end

function modifier_item_ascetic_cap_custom:GetModifierStatusResistanceStacking()
	return self.status_resistance
end

function modifier_item_ascetic_cap_custom:GetModifierHealthBonus()
	return self.bonus_health
end

function modifier_item_ascetic_cap_custom:GetModifierConstantHealthRegen()
	return self.hp_regen
end