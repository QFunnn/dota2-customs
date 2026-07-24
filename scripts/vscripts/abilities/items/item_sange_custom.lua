--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_item_sange_custom", "abilities/items/item_sange_custom", LUA_MODIFIER_MOTION_NONE)

item_sange_custom = class({})

function item_sange_custom:GetIntrinsicModifierName() 
return "modifier_item_sange_custom" 
end




modifier_item_sange_custom = class({})
function modifier_item_sange_custom:IsHidden() return true end
function modifier_item_sange_custom:IsPurgable() return false end
function modifier_item_sange_custom:GetAttributes() return MODIFIER_ATTRIBUTE_MULTIPLE end
function modifier_item_sange_custom:DeclareFunctions()
return
{
    MODIFIER_PROPERTY_STATS_STRENGTH_BONUS,
    MODIFIER_PROPERTY_HP_REGEN_AMPLIFY_PERCENTAGE,
    MODIFIER_PROPERTY_SLOW_RESISTANCE_STACKING,
}
end

function modifier_item_sange_custom:GetModifierBonusStats_Strength() 
return self.str
end

function modifier_item_sange_custom:GetModifierHealChange() 
if self.parent:HasModifier("modifier_item_abyssal_blade_custom") then return end
if self.parent:HasModifier("modifier_item_sange_and_yasha_custom") then return end
if self.parent:HasModifier("modifier_item_kaya_and_sange_custom") then return end
return self.heal_amp
end

function modifier_item_sange_custom:GetModifierHPRegenAmplify_Percentage() 
if self.parent:HasModifier("modifier_item_abyssal_blade_custom") then return end
if self.parent:HasModifier("modifier_item_sange_and_yasha_custom") then return end
if self.parent:HasModifier("modifier_item_kaya_and_sange_custom") then return end
return self.heal_amp
end

function modifier_item_sange_custom:GetModifierSlowResistance_Stacking() 
if self.parent:HasModifier("modifier_item_abyssal_blade_custom") then return end
if self.parent:HasModifier("modifier_item_sange_and_yasha_custom") then return end
if self.parent:HasModifier("modifier_item_kaya_and_sange_custom") then return end
return self.slow_resistance
end

function modifier_item_sange_custom:OnCreated(table)
self.parent = self:GetParent()
self.ability = self:GetAbility()

self.str = self.ability:GetSpecialValueFor("bonus_str")
self.heal_amp = self.ability:GetSpecialValueFor("heal_amp")
self.slow_resistance = self.ability:GetSpecialValueFor("slow_resistance")
end