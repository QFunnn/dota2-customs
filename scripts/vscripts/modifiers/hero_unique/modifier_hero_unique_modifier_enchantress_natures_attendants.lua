--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


modifier_hero_unique_modifier_enchantress_natures_attendants = class({})
function modifier_hero_unique_modifier_enchantress_natures_attendants:IsHidden() return true end
function modifier_hero_unique_modifier_enchantress_natures_attendants:IsPurgable() return false end
function modifier_hero_unique_modifier_enchantress_natures_attendants:IsPurgeException() return false end
function modifier_hero_unique_modifier_enchantress_natures_attendants:RemoveOnDeath() return false end

function modifier_hero_unique_modifier_enchantress_natures_attendants:OnCreated(params)
    if not IsServer() then return end
    self.parent = self:GetParent()
    self.ability = self:GetAbility()
    self:StartIntervalThink(1)
end

function modifier_hero_unique_modifier_enchantress_natures_attendants:OnIntervalThink()
    if not IsServer() then return end
    if self.ability == nil or self.ability:IsNull() then
        self:Destroy()
    end
end

function modifier_hero_unique_modifier_enchantress_natures_attendants:DeclareFunctions()
    return
    {
        MODIFIER_PROPERTY_HEALTH_REGEN_PERCENTAGE
    }
end

function modifier_hero_unique_modifier_enchantress_natures_attendants:GetModifierHealthRegenPercentage()
    if not self:GetParent():HasModifier("modifier_enchantress_natures_attendants") then return end
    return 5
end