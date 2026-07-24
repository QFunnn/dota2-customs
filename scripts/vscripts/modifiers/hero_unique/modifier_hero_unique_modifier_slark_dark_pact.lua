--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


modifier_hero_unique_modifier_slark_dark_pact = class({})
function modifier_hero_unique_modifier_slark_dark_pact:IsHidden() return true end
function modifier_hero_unique_modifier_slark_dark_pact:IsPurgable() return false end
function modifier_hero_unique_modifier_slark_dark_pact:IsPurgeException() return false end
function modifier_hero_unique_modifier_slark_dark_pact:RemoveOnDeath() return false end

function modifier_hero_unique_modifier_slark_dark_pact:OnCreated(params)
    if not IsServer() then return end
    self.parent = self:GetParent()
    self.ability = self:GetAbility()
    self.dmg = 0
    self.cooldown = false
    self:StartIntervalThink(1)
end

function modifier_hero_unique_modifier_slark_dark_pact:OnIntervalThink()
    if not IsServer() then return end
    if self.ability == nil or self.ability:IsNull() then
        self:Destroy()
    end
end

function modifier_hero_unique_modifier_slark_dark_pact:TakeDamageScriptModifier(params)
    if not IsServer() then return end
    if params.unit ~= self:GetParent() then return end
    if self:GetParent():PassivesDisabled() then return end
    if self:GetAbility():GetLevel() <= 0 then return end
    if self.cooldown then return end
    self.dmg = self.dmg + params.damage
    if self.dmg >= 500 then
        self.dmg = 0
        self.cooldown = true
        self:GetAbility():OnSpellStart()
        Timers:CreateTimer(7, function()
            self.cooldown = false
        end)
    end
end