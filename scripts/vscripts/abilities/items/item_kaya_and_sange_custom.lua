--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_item_kaya_and_sange_custom", "abilities/items/item_kaya_and_sange_custom", LUA_MODIFIER_MOTION_NONE)

item_kaya_and_sange_custom = class({})

function item_kaya_and_sange_custom:GetIntrinsicModifierName() 
return "modifier_item_kaya_and_sange_custom" 
end


modifier_item_kaya_and_sange_custom = class(mod_hidden)
function modifier_item_kaya_and_sange_custom:DeclareFunctions()
return
{
    MODIFIER_PROPERTY_STATS_STRENGTH_BONUS,
    MODIFIER_PROPERTY_STATS_INTELLECT_BONUS,
    MODIFIER_PROPERTY_SPELL_AMPLIFY_PERCENTAGE,
    MODIFIER_PROPERTY_MP_REGEN_AMPLIFY_PERCENTAGE,
    MODIFIER_PROPERTY_HEALTH_BONUS,
    MODIFIER_PROPERTY_HP_REGEN_AMPLIFY_PERCENTAGE,
    MODIFIER_PROPERTY_STATUS_RESISTANCE_STACKING,
    MODIFIER_PROPERTY_SLOW_RESISTANCE_STACKING,
}
end

function modifier_item_kaya_and_sange_custom:GetModifierBonusStats_Strength() 
return self.str
end

function modifier_item_kaya_and_sange_custom:GetModifierBonusStats_Intellect()
return self.int
end

function modifier_item_kaya_and_sange_custom:GetModifierSpellAmplify_Percentage() 
if self.parent:HasModifier("modifier_item_yasha_and_kaya_custom") then return end 
return self.spell_damage
end

function modifier_item_kaya_and_sange_custom:GetModifierStatusResistanceStacking()
if self.parent:HasModifier("modifier_item_sange_and_yasha_custom") then return end
return self.status_bonus
end

function modifier_item_kaya_and_sange_custom:GetModifierMPRegenAmplify_Percentage()
if self.parent:HasModifier("modifier_item_yasha_and_kaya_custom") then return end 
return self.regen_amp
end

function modifier_item_kaya_and_sange_custom:GetModifierHealthBonus()
if self.parent:HasModifier("modifier_item_yasha_and_kaya_custom") then return end 
return self.health_bonus*self.parent:GetMaxMana()
end

function modifier_item_kaya_and_sange_custom:GetModifierHealChange() 
if self.parent:HasModifier("modifier_item_abyssal_blade_custom") then return end
return self.heal_amp
end

function modifier_item_kaya_and_sange_custom:GetModifierHPRegenAmplify_Percentage() 
if self.parent:HasModifier("modifier_item_abyssal_blade_custom") then return end
return self.heal_amp
end

function modifier_item_kaya_and_sange_custom:GetModifierSlowResistance_Stacking()
if self.parent:HasModifier("modifier_item_abyssal_blade_custom") then return end
return self.slow_resistance
end

function modifier_item_kaya_and_sange_custom:OnCreated(table)
self.parent = self:GetParent()
self.ability = self:GetAbility()

self.str = self.ability:GetSpecialValueFor("bonus_str")
self.int = self.ability:GetSpecialValueFor("bonus_int")
self.spell_damage = self.ability:GetSpecialValueFor("spell_damage")
self.health_bonus = self.ability:GetSpecialValueFor("health_bonus")/100
self.regen_amp = self.ability:GetSpecialValueFor("regen_amp")
self.heal_amp = self.ability:GetSpecialValueFor("heal_amp")
self.status_bonus = self.ability:GetSpecialValueFor("status_bonus")
self.slow_resistance = self.ability:GetSpecialValueFor("slow_resistance")
end