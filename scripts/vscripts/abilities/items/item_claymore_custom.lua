--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_item_claymore_custom_passive", "abilities/items/item_claymore_custom", LUA_MODIFIER_MOTION_NONE)

item_claymore_custom = class({})

function item_claymore_custom:GetIntrinsicModifierName()
return "modifier_item_claymore_custom_passive"
end

modifier_item_claymore_custom_passive = class(mod_hidden)
function modifier_item_claymore_custom_passive:GetAttributes() return MODIFIER_ATTRIBUTE_MULTIPLE end
function modifier_item_claymore_custom_passive:DeclareFunctions()
return
{
  MODIFIER_PROPERTY_PREATTACK_BONUS_DAMAGE,
  MODIFIER_PROPERTY_HEALTH_BONUS
}
end

function modifier_item_claymore_custom_passive:GetModifierPreAttack_BonusDamage()
return self.ability.bonus_damage
end

function modifier_item_claymore_custom_passive:GetModifierHealthBonus()
return self.ability.health_bonus
end

function modifier_item_claymore_custom_passive:OnCreated()
self.parent = self:GetParent()
self.ability = self:GetAbility()
self.ability.health_bonus = self.ability:GetSpecialValueFor("health_bonus")
self.ability.bonus_damage = self.ability:GetSpecialValueFor("bonus_damage")
end