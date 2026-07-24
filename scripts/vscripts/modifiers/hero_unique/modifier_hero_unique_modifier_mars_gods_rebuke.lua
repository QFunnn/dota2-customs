--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


modifier_hero_unique_modifier_mars_gods_rebuke = class({})
function modifier_hero_unique_modifier_mars_gods_rebuke:IsHidden() return true end
function modifier_hero_unique_modifier_mars_gods_rebuke:IsPurgable() return false end
function modifier_hero_unique_modifier_mars_gods_rebuke:IsPurgeException() return false end
function modifier_hero_unique_modifier_mars_gods_rebuke:RemoveOnDeath() return false end

function modifier_hero_unique_modifier_mars_gods_rebuke:OnCreated(params)
    if not IsServer() then return end
    self.parent = self:GetParent()
    self.ability = self:GetAbility()
    self.cooldown = false
    self:StartIntervalThink(1)
end

function modifier_hero_unique_modifier_mars_gods_rebuke:OnIntervalThink()
    if not IsServer() then return end
    if self.ability == nil or self.ability:IsNull() then
        self:Destroy()
    end
end

function modifier_hero_unique_modifier_mars_gods_rebuke:AttackLandedModifier(params)
    if not IsServer() then return end
    if params.attacker ~= self:GetParent() then return end
    if self.cooldown then return end
    if self:GetAbility():GetLevel() <= 0 then return end
    if RollPercentage(25) or IsInToolsMode() then
        self.cooldown = true
        Timers:CreateTimer(1.5, function()
            self.cooldown = false
        end)
        self:GetParent():SetCursorPosition(self:GetParent():GetAbsOrigin() + self:GetParent():GetForwardVector() * 100)
        self:GetAbility():OnSpellStart()
    end
end