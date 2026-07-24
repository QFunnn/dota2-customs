--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_item_oblivion_staff_custom_passive", "abilities/items/item_oblivion_staff_custom", LUA_MODIFIER_MOTION_NONE)

item_oblivion_staff_custom = class({})

function item_oblivion_staff_custom:GetIntrinsicModifierName()
return "modifier_item_oblivion_staff_custom_passive"
end

modifier_item_oblivion_staff_custom_passive = class(mod_hidden)
function modifier_item_oblivion_staff_custom_passive:GetAttributes() return MODIFIER_ATTRIBUTE_MULTIPLE end
function modifier_item_oblivion_staff_custom_passive:DeclareFunctions()
return
{
  MODIFIER_PROPERTY_STATS_INTELLECT_BONUS,
  MODIFIER_PROPERTY_ATTACKSPEED_BONUS_CONSTANT,
  MODIFIER_PROPERTY_MANA_REGEN_CONSTANT,
  MODIFIER_PROPERTY_HEALTH_BONUS
}
end

function modifier_item_oblivion_staff_custom_passive:GetModifierBonusStats_Intellect()
return self.ability.bonus_intellect
end

function modifier_item_oblivion_staff_custom_passive:GetModifierAttackSpeedBonus_Constant()
return self.ability.bonus_attack_speed
end

function modifier_item_oblivion_staff_custom_passive:GetModifierConstantManaRegen()
return self.ability.bonus_regen
end

function modifier_item_oblivion_staff_custom_passive:GetModifierHealthBonus()
return self.ability.bonus_health
end

function modifier_item_oblivion_staff_custom_passive:OnCreated()
self.parent = self:GetParent()
self.ability = self:GetAbility()
self.ability.bonus_regen = self.ability:GetSpecialValueFor("bonus_regen")
self.ability.bonus_intellect = self.ability:GetSpecialValueFor("bonus_intellect")
self.ability.bonus_attack_speed = self.ability:GetSpecialValueFor("bonus_attack_speed")
self.ability.bonus_health = self.ability:GetSpecialValueFor("bonus_health")
end