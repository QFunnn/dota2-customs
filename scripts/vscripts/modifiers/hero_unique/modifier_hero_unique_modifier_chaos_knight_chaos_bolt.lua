--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


modifier_hero_unique_modifier_chaos_knight_chaos_bolt = class({})
function modifier_hero_unique_modifier_chaos_knight_chaos_bolt:IsHidden() return true end
function modifier_hero_unique_modifier_chaos_knight_chaos_bolt:IsPurgable() return false end
function modifier_hero_unique_modifier_chaos_knight_chaos_bolt:IsPurgeException() return false end
function modifier_hero_unique_modifier_chaos_knight_chaos_bolt:RemoveOnDeath() return false end

function modifier_hero_unique_modifier_chaos_knight_chaos_bolt:OnCreated(params)
    if not IsServer() then return end
    self.parent = self:GetParent()
    self.ability = self:GetAbility()
    self.cooldown = false
    self:StartIntervalThink(1)
end

function modifier_hero_unique_modifier_chaos_knight_chaos_bolt:OnIntervalThink()
    if not IsServer() then return end
    if self.ability == nil or self.ability:IsNull() then
        self:Destroy()
    end
end

function modifier_hero_unique_modifier_chaos_knight_chaos_bolt:AttackLandedModifier(params)
    if not IsServer() then return end
    if params.attacker ~= self:GetParent() then return end
    if self.cooldown then return end
    if self:GetAbility():GetLevel() <= 0 then return end
    if RollPercentage(15) or IsInToolsMode() then
        self.cooldown = true
        Timers:CreateTimer(4.5, function()
            self.cooldown = false
        end)
        self:GetParent():SetCursorCastTarget(params.target)
        self:GetAbility():OnSpellStart()
    end
end