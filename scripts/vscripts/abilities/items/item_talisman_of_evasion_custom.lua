--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("item_talisman_of_evasion_custom", "abilities/items/item_claymore_custom", LUA_MODIFIER_MOTION_NONE)

item_claymore_custom = class({})

function item_claymore_custom:GetIntrinsicModifierName()
return "item_talisman_of_evasion_custom"
end

item_talisman_of_evasion_custom = class(mod_hidden)
function item_talisman_of_evasion_custom:GetAttributes() return MODIFIER_ATTRIBUTE_MULTIPLE end
function item_talisman_of_evasion_custom:DeclareFunctions()
return
{
  MODIFIER_PROPERTY_EVASION_CONSTANT,
  MODIFIER_PROPERTY_HEALTH_BONUS
}
end

function item_talisman_of_evasion_custom:GetModifierEvasion_Constant()
return self.ability.bonus_evasion
end

function item_talisman_of_evasion_custom:GetModifierHealthBonus()
return self.ability.health_bonus
end

function item_talisman_of_evasion_custom:OnCreated()
self.parent = self:GetParent()
self.ability = self:GetAbility()
self.ability.health_bonus = self.ability:GetSpecialValueFor("health_bonus")
self.ability.bonus_evasion = self.ability:GetSpecialValueFor("bonus_evasion")
end