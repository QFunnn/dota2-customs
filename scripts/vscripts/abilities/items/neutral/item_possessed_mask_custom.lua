--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_item_possessed_mask_custom", "abilities/items/neutral/item_possessed_mask_custom", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_item_possessed_mask_custom_health", "abilities/items/neutral/item_possessed_mask_custom", LUA_MODIFIER_MOTION_NONE)

item_possessed_mask_custom = class({})

function item_possessed_mask_custom:GetIntrinsicModifierName()
if not self:GetCaster():IsRealHero() then return end
return "modifier_item_possessed_mask_custom"
end


modifier_item_possessed_mask_custom = class(mod_hidden)
function modifier_item_possessed_mask_custom:RemoveOnDeath() return false end
function modifier_item_possessed_mask_custom:OnCreated(table)
self.parent = self:GetParent()
self.ability = self:GetAbility()

self.duration = self.ability:GetSpecialValueFor("duration")
self.parent:AddAttackEvent_out(self, true)
end

function modifier_item_possessed_mask_custom:AttackEvent_out(params)
if not IsServer() then return end
if self.parent ~= params.attacker then return end
if not params.target:IsUnit() then return end

params.target:AddNewModifier(self.parent, self.ability, "modifier_item_possessed_mask_custom_health", {duration = self.duration})
self.parent:AddNewModifier(self.parent, self.ability, "modifier_item_possessed_mask_custom_health", {duration = self.duration})
end


modifier_item_possessed_mask_custom_health = class(mod_visible)
function modifier_item_possessed_mask_custom_health:OnCreated()
self.parent = self:GetParent()
self.caster = self:GetCaster()
self.ability = self:GetAbility()

self.str = self.ability:GetSpecialValueFor("str")
if self.caster:GetTeamNumber() ~= self.parent:GetTeamNumber() then
    self.str = self.str*-1
end

self.max = self.ability:GetSpecialValueFor("max")
if not IsServer() then return end
self:SetStackCount(1)
end

function modifier_item_possessed_mask_custom_health:OnRefresh(table)
if not IsServer() then return end
if self:GetStackCount() >= self.max then return end
self:IncrementStackCount()
end

function modifier_item_possessed_mask_custom_health:OnStackCountChanged(iStackCount)
if not IsServer() then return end
if not self.parent:IsRealHero() then return end
self.parent:CalculateStatBonus(true)
end

function modifier_item_possessed_mask_custom_health:OnDestroy()
if not IsServer() then return end
self:OnStackCountChanged()
end

function modifier_item_possessed_mask_custom_health:DeclareFunctions()
return
{
    MODIFIER_PROPERTY_STATS_STRENGTH_BONUS
}
end

function modifier_item_possessed_mask_custom_health:GetModifierBonusStats_Strength()
return self:GetStackCount()*self.str
end