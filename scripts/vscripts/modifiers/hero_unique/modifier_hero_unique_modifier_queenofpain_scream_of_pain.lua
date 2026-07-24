--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


modifier_hero_unique_modifier_queenofpain_scream_of_pain = class({})
function modifier_hero_unique_modifier_queenofpain_scream_of_pain:IsHidden() return true end
function modifier_hero_unique_modifier_queenofpain_scream_of_pain:IsPurgable() return false end
function modifier_hero_unique_modifier_queenofpain_scream_of_pain:IsPurgeException() return false end
function modifier_hero_unique_modifier_queenofpain_scream_of_pain:RemoveOnDeath() return false end

function modifier_hero_unique_modifier_queenofpain_scream_of_pain:OnCreated(params)
    if not IsServer() then return end
    self.parent = self:GetParent()
    self.ability = self:GetAbility()
    self.dmg = 0
    self.cooldown = false
    self:StartIntervalThink(1)
end

function modifier_hero_unique_modifier_queenofpain_scream_of_pain:OnIntervalThink()
    if not IsServer() then return end
    if self.ability == nil or self.ability:IsNull() then
        self:Destroy()
    end
end

function modifier_hero_unique_modifier_queenofpain_scream_of_pain:TakeDamageScriptModifier(params)
    if not IsServer() then return end
    if params.attacker ~= self:GetParent() then return end
    if params.unit == self:GetParent() then return end
    if params.inflictor ~= self.ability then return end
    if not params.unit:IsDebuffImmune() then
        params.unit:AddNewModifier(self:GetParent(), self.ability, "modifier_queenofpain_scream_of_pain_fear", {duration = 1.5})
    end
end