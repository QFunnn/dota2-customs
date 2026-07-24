--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_item_mystic_spark_custom", "abilities/items/item_mystic_spark_custom", LUA_MODIFIER_MOTION_NONE)

item_mystic_spark_custom = class({})

function item_mystic_spark_custom:GetIntrinsicModifierName()
return "modifier_item_mystic_spark_custom"
end

function item_mystic_spark_custom:Precache(context)
if self:GetCaster() and self:GetCaster():IsIllusion() then return end
end

modifier_item_mystic_spark_custom = class(mod_hidden)
function modifier_item_mystic_spark_custom:RemoveOnDeath() return false end
function modifier_item_mystic_spark_custom:OnCreated()
self.parent = self:GetParent()
self.ability = self:GetAbility()

self.spell_damage = self.ability:GetSpecialValueFor("spell_damage")
end

function modifier_item_mystic_spark_custom:DeclareFunctions()
return 
{
	MODIFIER_PROPERTY_SPELL_AMPLIFY_PERCENTAGE
}
end

function modifier_item_mystic_spark_custom:GetModifierSpellAmplify_Percentage()
return self.spell_damage
end