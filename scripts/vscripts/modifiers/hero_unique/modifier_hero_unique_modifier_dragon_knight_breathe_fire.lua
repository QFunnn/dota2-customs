--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


modifier_hero_unique_modifier_dragon_knight_breathe_fire = class({})
function modifier_hero_unique_modifier_dragon_knight_breathe_fire:IsHidden() return true end
function modifier_hero_unique_modifier_dragon_knight_breathe_fire:IsPurgable() return false end
function modifier_hero_unique_modifier_dragon_knight_breathe_fire:IsPurgeException() return false end
function modifier_hero_unique_modifier_dragon_knight_breathe_fire:RemoveOnDeath() return false end

function modifier_hero_unique_modifier_dragon_knight_breathe_fire:OnCreated(params)
    if not IsServer() then return end
    self.parent = self:GetParent()
    self.ability = self:GetAbility()
    self.nextTime = 0
    self:StartIntervalThink(1)
end

function modifier_hero_unique_modifier_dragon_knight_breathe_fire:OnIntervalThink()
    if not IsServer() then return end
    if self.ability == nil or self.ability:IsNull() then
        self:Destroy()
    end
end

function modifier_hero_unique_modifier_dragon_knight_breathe_fire:AttackLandedModifier(params)
    if not IsServer() or params.attacker ~= self:GetParent() or self:GetAbility():GetLevel() <= 0 then return end

    if RollPercentage(25) and self.nextTime <= GameRules:GetGameTime() then
        self.nextTime = GameRules:GetGameTime() + 1.5

        self:GetParent():SetCursorPosition(self:GetParent():GetAbsOrigin() + self:GetParent():GetForwardVector() * 100)
        self:GetAbility():OnSpellStart()
    end
end