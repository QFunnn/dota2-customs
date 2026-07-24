--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


modifier_hero_unique_modifier_skywrath_mage_concussive_shot = class({})
function modifier_hero_unique_modifier_skywrath_mage_concussive_shot:IsHidden() return true end
function modifier_hero_unique_modifier_skywrath_mage_concussive_shot:IsPurgable() return false end
function modifier_hero_unique_modifier_skywrath_mage_concussive_shot:IsPurgeException() return false end
function modifier_hero_unique_modifier_skywrath_mage_concussive_shot:RemoveOnDeath() return false end

function modifier_hero_unique_modifier_skywrath_mage_concussive_shot:OnCreated(params)
    if not IsServer() then return end
    self.parent = self:GetParent()
    self.ability = self:GetAbility()
    self:StartIntervalThink(1)
    self.cooldown = false
end

function modifier_hero_unique_modifier_skywrath_mage_concussive_shot:OnIntervalThink()
    if not IsServer() then return end
    if self.ability == nil or self.ability:IsNull() then
        self:Destroy()
    end
end

function modifier_hero_unique_modifier_skywrath_mage_concussive_shot:OnAbilityfullCastCustom(params)
    if not IsServer() then return end
    if params.unit ~= self:GetParent() then return end
    if params.ability == self:GetAbility() then return end
    if self.cooldown then return end
    self.cooldown = true
    Timers:CreateTimer(5, function()
        self.cooldown = false
    end)
    self:GetAbility():OnSpellStart()
end