--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_item_enhancement_wise_custom", "abilities/items/neutral/item_enhancement_wise_custom", LUA_MODIFIER_MOTION_NONE)

item_enhancement_wise_custom = class({})

function item_enhancement_wise_custom:GetIntrinsicModifierName()
if not self:GetCaster():IsRealHero() then return end
return "modifier_item_enhancement_wise_custom"
end

modifier_item_enhancement_wise_custom = class(mod_hidden)
function modifier_item_enhancement_wise_custom:RemoveOnDeath() return false end
function modifier_item_enhancement_wise_custom:OnCreated(table)
self.parent = self:GetParent()
self.ability = self:GetAbility()


self.cooldown_reduction = self.ability:GetSpecialValueFor("cooldown_reduction")
self.mana_burn_reduce = self.ability:GetSpecialValueFor("mana_burn_reduce")
end

function modifier_item_enhancement_wise_custom:DeclareFunctions()
return
{
    MODIFIER_PROPERTY_MANACOST_PERCENTAGE_STACKING,
    MODIFIER_PROPERTY_COOLDOWN_PERCENTAGE
}
end

function modifier_item_enhancement_wise_custom:GetModifierPercentageCooldown() 
return self.cooldown_reduction
end

function modifier_item_enhancement_wise_custom:GetModifierPercentageManacostStacking(params)
return self.mana_burn_reduce
end

