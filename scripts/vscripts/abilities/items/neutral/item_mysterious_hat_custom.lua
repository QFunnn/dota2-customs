--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_item_mysterious_hat_custom", "abilities/items/neutral/item_mysterious_hat_custom", LUA_MODIFIER_MOTION_NONE)

item_mysterious_hat_custom = class({})

function item_mysterious_hat_custom:GetIntrinsicModifierName()
if not self:GetCaster():IsRealHero() then return end
return "modifier_item_mysterious_hat_custom"
end


modifier_item_mysterious_hat_custom = class({})
function modifier_item_mysterious_hat_custom:IsHidden() return true end
function modifier_item_mysterious_hat_custom:IsPurgable() return false end
function modifier_item_mysterious_hat_custom:RemoveOnDeath() return false end
function modifier_item_mysterious_hat_custom:OnCreated(table)
self.parent = self:GetParent()
self.ability = self:GetAbility()

self.damage = self.ability:GetSpecialValueFor("damage")
self.resist = self.ability:GetSpecialValueFor("resist")
self.health = self.ability:GetSpecialValueFor("health")
end

function modifier_item_mysterious_hat_custom:DeclareFunctions()
return
{
    MODIFIER_PROPERTY_SPELL_AMPLIFY_PERCENTAGE,
    MODIFIER_PROPERTY_MAGICAL_RESISTANCE_BONUS,
}
end

function modifier_item_mysterious_hat_custom:GetModifierSpellAmplify_Percentage() 
if self.parent:GetHealthPercent() < self.health then return end
return self.damage
end


function modifier_item_mysterious_hat_custom:GetModifierMagicalResistanceBonus()
if self.parent:GetHealthPercent() >= self.health then return end
return self.resist
end