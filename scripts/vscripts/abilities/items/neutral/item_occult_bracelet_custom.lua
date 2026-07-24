--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_item_occult_bracelet_custom", "abilities/items/neutral/item_occult_bracelet_custom", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_item_occult_bracelet_custom_regen", "abilities/items/neutral/item_occult_bracelet_custom", LUA_MODIFIER_MOTION_NONE)

item_occult_bracelet_custom = class({})

function item_occult_bracelet_custom:GetIntrinsicModifierName()
if not self:GetCaster():IsRealHero() then return end
return "modifier_item_occult_bracelet_custom"
end


modifier_item_occult_bracelet_custom = class(mod_hidden)
function modifier_item_occult_bracelet_custom:RemoveOnDeath() return false end
function modifier_item_occult_bracelet_custom:OnCreated(table)
self.parent = self:GetParent()
self.ability = self:GetAbility()

self.duration = self.ability:GetSpecialValueFor("stack_duration")
self.parent:AddAttackEvent_inc(self, true)
end

function modifier_item_occult_bracelet_custom:AttackEvent_inc(params)
if not IsServer() then return end
if self.parent ~= params.target then return end
if not params.attacker:IsUnit() then return end

self.parent:AddNewModifier(self.parent, self.ability, "modifier_item_occult_bracelet_custom_regen", {duration = self.duration})
end


modifier_item_occult_bracelet_custom_regen = class(mod_visible)
function modifier_item_occult_bracelet_custom_regen:OnCreated()
self.parent = self:GetParent()
self.caster = self:GetCaster()
self.ability = self:GetAbility()

self.health = self.ability:GetSpecialValueFor("health_regen")
self.mana = self.ability:GetSpecialValueFor("mana_regen")
self.max = self.ability:GetSpecialValueFor("stack_limit")
if not IsServer() then return end
self:SetStackCount(1)
end

function modifier_item_occult_bracelet_custom_regen:OnRefresh(table)
if not IsServer() then return end
if self:GetStackCount() >= self.max then return end
self:IncrementStackCount()
end


function modifier_item_occult_bracelet_custom_regen:DeclareFunctions()
return
{
    MODIFIER_PROPERTY_HEALTH_REGEN_CONSTANT,
    MODIFIER_PROPERTY_MANA_REGEN_CONSTANT
}
end

function modifier_item_occult_bracelet_custom_regen:GetModifierConstantHealthRegen()
return self:GetStackCount()*self.health
end

function modifier_item_occult_bracelet_custom_regen:GetModifierConstantManaRegen()
return self:GetStackCount()*self.mana
end