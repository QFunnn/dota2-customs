--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


modifier_hero_unique_modifier_dazzle_poison_touch = class({})
function modifier_hero_unique_modifier_dazzle_poison_touch:IsHidden() return true end
function modifier_hero_unique_modifier_dazzle_poison_touch:IsPurgable() return false end
function modifier_hero_unique_modifier_dazzle_poison_touch:IsPurgeException() return false end
function modifier_hero_unique_modifier_dazzle_poison_touch:RemoveOnDeath() return false end

function modifier_hero_unique_modifier_dazzle_poison_touch:OnCreated(params)
    self.parent = self:GetParent()
    self.ability = self:GetAbility()
    if not IsServer() then return end
    self:StartIntervalThink(1)
end

function modifier_hero_unique_modifier_dazzle_poison_touch:OnIntervalThink()
    if not IsServer() then return end
    if self.ability == nil or self.ability:IsNull() then
        self:Destroy()
    end
end

function modifier_hero_unique_modifier_dazzle_poison_touch:TakeDamageScriptModifier(params)
    if not IsServer() then return end
    if params.attacker ~= self:GetParent() then return end
    if params.inflictor == nil then return end
    if params.inflictor == self.ability then return end
    local target = params.unit
    if target and target:HasModifier("modifier_dazzle_poison_touch") then
        local modifier_dazzle_poison_touch = target:FindModifierByName("modifier_dazzle_poison_touch")
        if modifier_dazzle_poison_touch then
            modifier_dazzle_poison_touch:SetDuration(self.ability:GetSpecialValueFor("duration"), true)
        end
    end
end