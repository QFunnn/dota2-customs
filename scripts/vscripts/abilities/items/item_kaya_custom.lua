--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_item_kaya_custom", "abilities/items/item_kaya_custom", LUA_MODIFIER_MOTION_NONE)

item_kaya_custom = class({})

function item_kaya_custom:GetIntrinsicModifierName() 
return "modifier_item_kaya_custom" 
end

modifier_item_kaya_custom = class(mod_hidden)
function modifier_item_kaya_custom:DeclareFunctions()
return
{
    MODIFIER_PROPERTY_STATS_INTELLECT_BONUS,
    MODIFIER_PROPERTY_SPELL_AMPLIFY_PERCENTAGE,
    MODIFIER_PROPERTY_MP_REGEN_AMPLIFY_PERCENTAGE,
    MODIFIER_PROPERTY_HEALTH_BONUS,
}
end

function modifier_item_kaya_custom:GetModifierBonusStats_Intellect()
return self.ability.bonus_intellect
end

function modifier_item_kaya_custom:GetModifierSpellAmplify_Percentage() 
if self.parent:HasModifier("modifier_item_yasha_and_kaya_custom") then return end 
if self.parent:HasModifier("modifier_item_kaya_and_sange_custom") then return end
return self.ability.spell_amp
end

function modifier_item_kaya_custom:GetModifierMPRegenAmplify_Percentage()
if self.parent:HasModifier("modifier_item_yasha_and_kaya_custom") then return end 
if self.parent:HasModifier("modifier_item_kaya_and_sange_custom") then return end
return self.ability.mana_regen_multiplier
end

function modifier_item_kaya_custom:GetModifierHealthBonus()
if self.parent:HasModifier("modifier_item_yasha_and_kaya_custom") then return end 
if self.parent:HasModifier("modifier_item_kaya_and_sange_custom") then return end
return self.ability.health_bonus*self.parent:GetMaxMana()
end

function modifier_item_kaya_custom:OnCreated(table)
self.parent = self:GetParent()
self.ability = self:GetAbility()

self.ability.bonus_intellect = self.ability:GetSpecialValueFor("bonus_intellect")
self.ability.spell_amp = self.ability:GetSpecialValueFor("spell_amp")
self.ability.mana_regen_multiplier = self.ability:GetSpecialValueFor("mana_regen_multiplier")
self.ability.health_bonus = self.ability:GetSpecialValueFor("health_bonus")/100
end