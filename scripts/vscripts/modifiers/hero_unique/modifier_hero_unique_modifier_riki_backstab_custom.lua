--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


modifier_hero_unique_modifier_riki_backstab_custom = class({})
function modifier_hero_unique_modifier_riki_backstab_custom:IsHidden() return true end
function modifier_hero_unique_modifier_riki_backstab_custom:IsPurgable() return false end
function modifier_hero_unique_modifier_riki_backstab_custom:IsPurgeException() return false end
function modifier_hero_unique_modifier_riki_backstab_custom:RemoveOnDeath() return false end

function modifier_hero_unique_modifier_riki_backstab_custom:OnCreated(params)
    if not IsServer() then return end
    self.parent = self:GetParent()
    self.ability = self:GetAbility()
    self:StartIntervalThink(1)
end

function modifier_hero_unique_modifier_riki_backstab_custom:OnIntervalThink()
    if not IsServer() then return end
    if self.ability == nil or self.ability:IsNull() then
        self:Destroy()
    end
end