--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


modifier_hero_unique_modifier_abaddon_death_coil = class({})
function modifier_hero_unique_modifier_abaddon_death_coil:IsHidden() return true end
function modifier_hero_unique_modifier_abaddon_death_coil:IsPurgable() return false end
function modifier_hero_unique_modifier_abaddon_death_coil:IsPurgeException() return false end
function modifier_hero_unique_modifier_abaddon_death_coil:RemoveOnDeath() return false end
function modifier_hero_unique_modifier_abaddon_death_coil:OnCreated(params)
    if not IsServer() then return end
    self.parent = self:GetParent()
    self.ability = self:GetAbility()
end
function modifier_hero_unique_modifier_abaddon_death_coil:DeclareFunctions()
    return
    {
        MODIFIER_EVENT_ON_ATTACK_LANDED,
    }
end
function modifier_hero_unique_modifier_abaddon_death_coil:OnAttackLanded(params)
    if not IsServer() then return end
    if params.attacker ~= self:GetParent() then return end
    if self.cooldown then return end
    if self:GetAbility():GetLevel() <= 0 then return end
    if RollPercentage(15) or IsInToolsMode() then
        self.cooldown = true
        Timers:CreateTimer(1, function()
            self.cooldown = false
        end)
        self:GetParent():SetCursorCastTarget(params.target)
        self:GetAbility():OnSpellStart()
    end
end