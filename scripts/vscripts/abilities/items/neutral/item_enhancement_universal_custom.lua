--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_item_enhancement_universal_custom", "abilities/items/neutral/item_enhancement_universal_custom", LUA_MODIFIER_MOTION_NONE)

item_enhancement_universal_custom = class({})

function item_enhancement_universal_custom:GetIntrinsicModifierName()
return "modifier_item_enhancement_universal_custom"
end


modifier_item_enhancement_universal_custom = class({})
function modifier_item_enhancement_universal_custom:IsHidden() return true end
function modifier_item_enhancement_universal_custom:IsPurgable() return false end
function modifier_item_enhancement_universal_custom:RemoveOnDeath() return false end
function modifier_item_enhancement_universal_custom:OnCreated(table)
self.parent = self:GetParent()
self.ability = self:GetAbility()

self.main_stat = self.ability:GetSpecialValueFor("main_stat")
self.main_stat_universal = self.ability:GetSpecialValueFor("main_stat_universal")
self.stats = self.ability:GetSpecialValueFor("stats")

if IsServer() then
    self:SetStackCount(self.parent:GetPrimaryAttribute())
end

self.agi = self:GetStackCount() == DOTA_ATTRIBUTE_AGILITY and self.main_stat or 0 
self.str = self:GetStackCount() == DOTA_ATTRIBUTE_STRENGTH and self.main_stat or 0 
self.int = self:GetStackCount() == DOTA_ATTRIBUTE_INTELLECT and self.main_stat or 0 

self.stats = self:GetStackCount() == DOTA_ATTRIBUTE_ALL and (self.stats + self.main_stat_universal) or self.stats
end

function modifier_item_enhancement_universal_custom:DeclareFunctions()
return
{
    MODIFIER_PROPERTY_STATS_AGILITY_BONUS,
    MODIFIER_PROPERTY_STATS_STRENGTH_BONUS,
    MODIFIER_PROPERTY_STATS_INTELLECT_BONUS,
}
end

function modifier_item_enhancement_universal_custom:GetModifierBonusStats_Agility()
return self.stats + self.agi
end

function modifier_item_enhancement_universal_custom:GetModifierBonusStats_Strength()
return self.stats + self.str
end

function modifier_item_enhancement_universal_custom:GetModifierBonusStats_Intellect()
return self.stats + self.int
end