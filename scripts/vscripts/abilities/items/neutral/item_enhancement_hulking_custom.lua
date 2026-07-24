--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_item_enhancement_hulking_custom", "abilities/items/neutral/item_enhancement_hulking_custom", LUA_MODIFIER_MOTION_NONE)

item_enhancement_hulking_custom = class({})

function item_enhancement_hulking_custom:GetIntrinsicModifierName()
if not self:GetCaster():IsRealHero() then return end
return "modifier_item_enhancement_hulking_custom"
end



modifier_item_enhancement_hulking_custom = class(mod_hidden)
function modifier_item_enhancement_hulking_custom:RemoveOnDeath() return false end
function modifier_item_enhancement_hulking_custom:OnCreated(table)
self.parent = self:GetParent()
self.ability = self:GetAbility()

self.status = self.ability:GetSpecialValueFor("status")
self.health = self.ability:GetSpecialValueFor("health")
self.heal_bonus = self.ability:GetSpecialValueFor("heal_bonus")
end

function modifier_item_enhancement_hulking_custom:DeclareFunctions()
return
{
    MODIFIER_PROPERTY_HP_REGEN_AMPLIFY_PERCENTAGE,
    MODIFIER_PROPERTY_EXTRA_HEALTH_PERCENTAGE,
    MODIFIER_PROPERTY_STATUS_RESISTANCE_STACKING,
}
end

function modifier_item_enhancement_hulking_custom:GetModifierStatusResistanceStacking()
return self.status
end

function modifier_item_enhancement_hulking_custom:GetModifierExtraHealthPercentage()
return self.health
end

function modifier_item_enhancement_hulking_custom:GetModifierHealChange() 
return self.heal_bonus
end

function modifier_item_enhancement_hulking_custom:GetModifierHPRegenAmplify_Percentage() 
return self.heal_bonus
end