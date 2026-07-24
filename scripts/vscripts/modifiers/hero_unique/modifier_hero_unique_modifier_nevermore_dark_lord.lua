--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


modifier_hero_unique_modifier_nevermore_dark_lord = class({})
function modifier_hero_unique_modifier_nevermore_dark_lord:IsHidden() return true end
function modifier_hero_unique_modifier_nevermore_dark_lord:IsPurgable() return false end
function modifier_hero_unique_modifier_nevermore_dark_lord:IsPurgeException() return false end
function modifier_hero_unique_modifier_nevermore_dark_lord:RemoveOnDeath() return false end

function modifier_hero_unique_modifier_nevermore_dark_lord:OnCreated(params)
    if not IsServer() then return end
    self.parent = self:GetParent()
    self.ability = self:GetAbility()
    self:StartIntervalThink(1)
end

function modifier_hero_unique_modifier_nevermore_dark_lord:OnIntervalThink()
    if not IsServer() then return end
    if self.ability == nil or self.ability:IsNull() then
        self:Destroy()
    end
end

function modifier_hero_unique_modifier_nevermore_dark_lord:OnDeathEvent(params)
    if not IsServer() then return end
    if params.attacker ~= self:GetParent() then return end
    local modifier_nevermore_presence_aura = self.parent:FindModifierByName("modifier_nevermore_presence_aura")
    if modifier_nevermore_presence_aura then
        modifier_nevermore_presence_aura:IncrementStackCount()
        modifier_nevermore_presence_aura:SetDuration(20, true)
        if modifier_nevermore_presence_aura.dur then
            Timers:RemoveTimer(modifier_nevermore_presence_aura.dur)
        end
        modifier_nevermore_presence_aura.dur = Timers:CreateTimer(20, function()
            modifier_nevermore_presence_aura:SetStackCount(0)
        end)
    end
end