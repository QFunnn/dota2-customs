--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_item_enhancement_mystical_custom", "abilities/items/neutral/item_enhancement_mystical_custom", LUA_MODIFIER_MOTION_NONE)

item_enhancement_mystical_custom = class({})

function item_enhancement_mystical_custom:GetIntrinsicModifierName()
return "modifier_item_enhancement_mystical_custom"
end


modifier_item_enhancement_mystical_custom = class(mod_hidden)
function modifier_item_enhancement_mystical_custom:RemoveOnDeath() return false end
function modifier_item_enhancement_mystical_custom:OnCreated(table)
self.parent = self:GetParent()
self.ability = self:GetAbility()

self.magic_res = self.ability:GetSpecialValueFor("magic_res")
self.bonus_mana = self.ability:GetSpecialValueFor("bonus_mana")
end

function modifier_item_enhancement_mystical_custom:DeclareFunctions()
return
{
    MODIFIER_PROPERTY_MAGICAL_RESISTANCE_BONUS,
    MODIFIER_PROPERTY_MANA_BONUS
}
end

function modifier_item_enhancement_mystical_custom:GetModifierMagicalResistanceBonus()
return self.magic_res
end

function modifier_item_enhancement_mystical_custom:GetModifierManaBonus()
return self.bonus_mana
end