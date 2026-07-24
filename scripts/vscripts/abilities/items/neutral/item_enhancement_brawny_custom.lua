--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_item_enhancement_brawny_custom", "abilities/items/neutral/item_enhancement_brawny_custom", LUA_MODIFIER_MOTION_NONE)

item_enhancement_brawny_custom = class({})

function item_enhancement_brawny_custom:GetIntrinsicModifierName()
return "modifier_item_enhancement_brawny_custom"
end


modifier_item_enhancement_brawny_custom = class(mod_hidden)
function modifier_item_enhancement_brawny_custom:RemoveOnDeath() return false end
function modifier_item_enhancement_brawny_custom:OnCreated(table)
self.parent = self:GetParent()
self.ability = self:GetAbility()

self.health_bonus = self.ability:GetSpecialValueFor("health_bonus")
self.heal_bonus = self.ability:GetSpecialValueFor("heal_bonus")
end

function modifier_item_enhancement_brawny_custom:DeclareFunctions()
return
{
    MODIFIER_PROPERTY_HEALTH_BONUS,
    --MODIFIER_PROPERTY_HEAL_AMPLIFY_PERCENTAGE_TARGET,
    MODIFIER_PROPERTY_HP_REGEN_AMPLIFY_PERCENTAGE,
    --MODIFIER_PROPERTY_LIFESTEAL_AMPLIFY_PERCENTAGE
}
end

function modifier_item_enhancement_brawny_custom:GetModifierHealthBonus()
return self.health_bonus
end

function modifier_item_enhancement_brawny_custom:GetModifierLifestealRegenAmplify_Percentage() 
return self.heal_bonus
end

function modifier_item_enhancement_brawny_custom:GetModifierHealChange() 
return self.heal_bonus
end

function modifier_item_enhancement_brawny_custom:GetModifierHPRegenAmplify_Percentage() 
return self.heal_bonus
end
