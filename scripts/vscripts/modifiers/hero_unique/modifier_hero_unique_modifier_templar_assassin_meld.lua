--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


modifier_hero_unique_modifier_templar_assassin_meld = class({})
function modifier_hero_unique_modifier_templar_assassin_meld:IsHidden() return true end
function modifier_hero_unique_modifier_templar_assassin_meld:IsPurgable() return false end
function modifier_hero_unique_modifier_templar_assassin_meld:IsPurgeException() return false end
function modifier_hero_unique_modifier_templar_assassin_meld:RemoveOnDeath() return false end

function modifier_hero_unique_modifier_templar_assassin_meld:OnCreated(params)
    if not IsServer() then return end
    self.parent = self:GetParent()
    self.ability = self:GetAbility()
    self:StartIntervalThink(1)
end

function modifier_hero_unique_modifier_templar_assassin_meld:OnIntervalThink()
    if not IsServer() then return end
    if self.ability == nil or self.ability:IsNull() then
        self:Destroy()
    end
end

function modifier_hero_unique_modifier_templar_assassin_meld:DeclareFunctions()
    return
    {
        MODIFIER_PROPERTY_ATTACK_RANGE_BONUS
    }
end

function modifier_hero_unique_modifier_templar_assassin_meld:GetModifierAttackRangeBonus()
    return 300
end