--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


modifier_hero_unique_modifier_clinkz_strafe = class({})
function modifier_hero_unique_modifier_clinkz_strafe:IsHidden() return true end
function modifier_hero_unique_modifier_clinkz_strafe:IsPurgable() return false end
function modifier_hero_unique_modifier_clinkz_strafe:IsPurgeException() return false end
function modifier_hero_unique_modifier_clinkz_strafe:RemoveOnDeath() return false end

function modifier_hero_unique_modifier_clinkz_strafe:OnCreated(params)
    self.parent = self:GetParent()
    self.ability = self:GetAbility()
    if not IsServer() then return end
    self:StartIntervalThink(1)
end

function modifier_hero_unique_modifier_clinkz_strafe:OnIntervalThink()
    if not IsServer() then return end
    if self.ability == nil or self.ability:IsNull() then
        self:Destroy()
    end
end

function modifier_hero_unique_modifier_clinkz_strafe:DeclareFunctions()
    return
    {
        MODIFIER_PROPERTY_ATTACK_RANGE_BONUS,
        MODIFIER_PROPERTY_EVASION_CONSTANT
    }
end

function modifier_hero_unique_modifier_clinkz_strafe:GetModifierAttackRangeBonus()
    if not self:GetParent():HasModifier("modifier_clinkz_strafe") then return end
    if self:GetParent():IsRangedAttacker() then return end
    return self:GetAbility():GetSpecialValueFor("attack_range_bonus")
end

function modifier_hero_unique_modifier_clinkz_strafe:GetModifierEvasion_Constant()
    if not self:GetParent():HasModifier("modifier_clinkz_strafe") or not self.ability then return 0 end

    return self.ability:GetSpecialValueFor("evasion_facet")
end