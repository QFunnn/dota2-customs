--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_item_enhancement_tough_custom", "abilities/items/neutral/item_enhancement_tough_custom", LUA_MODIFIER_MOTION_NONE)

item_enhancement_tough_custom = class({})

function item_enhancement_tough_custom:GetIntrinsicModifierName()
return "modifier_item_enhancement_tough_custom"
end


modifier_item_enhancement_tough_custom = class(mod_hidden)
function modifier_item_enhancement_tough_custom:RemoveOnDeath() return false end
function modifier_item_enhancement_tough_custom:OnCreated(table)
self.parent = self:GetParent()
self.ability = self:GetAbility()

self.bonus_damage = self.ability:GetSpecialValueFor("bonus_damage")
self.armor = self.ability:GetSpecialValueFor("armor")
end

function modifier_item_enhancement_tough_custom:DeclareFunctions()
return
{
    MODIFIER_PROPERTY_PHYSICAL_ARMOR_BONUS,
    MODIFIER_PROPERTY_PREATTACK_BONUS_DAMAGE
}
end

function modifier_item_enhancement_tough_custom:GetModifierPreAttack_BonusDamage()
return self.bonus_damage
end

function modifier_item_enhancement_tough_custom:GetModifierPhysicalArmorBonus()
return self.armor
end
