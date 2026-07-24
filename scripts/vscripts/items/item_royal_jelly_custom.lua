--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_item_royal_jelly_custom", "items/item_royal_jelly_custom", LUA_MODIFIER_MOTION_NONE)

item_royal_jelly_custom = class({})

function item_royal_jelly_custom:GetIntrinsicModifierName()
	return "modifier_item_royal_jelly_custom"
end

modifier_item_royal_jelly_custom = class({})

function modifier_item_royal_jelly_custom:IsHidden() return true end

function modifier_item_royal_jelly_custom:IsPurgable() return false end
function modifier_item_royal_jelly_custom:IsPurgeException() return false end

function modifier_item_royal_jelly_custom:OnCreated()
	self.health_regen = self:GetAbility():GetSpecialValueFor("health_regen")
	self.mana_regen = self:GetAbility():GetSpecialValueFor("mana_regen")
end

function modifier_item_royal_jelly_custom:DeclareFunctions()
	return 
	{
		MODIFIER_PROPERTY_MANA_REGEN_CONSTANT,
		MODIFIER_PROPERTY_HEALTH_REGEN_CONSTANT
	}
end

function modifier_item_royal_jelly_custom:GetModifierConstantHealthRegen()
	return self.health_regen
end

function modifier_item_royal_jelly_custom:GetModifierConstantManaRegen()
	return self.mana_regen
end