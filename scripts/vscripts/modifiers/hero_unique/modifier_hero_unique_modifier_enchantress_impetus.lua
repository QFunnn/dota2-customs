--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


modifier_hero_unique_modifier_enchantress_impetus = class({})
function modifier_hero_unique_modifier_enchantress_impetus:IsHidden() return true end
function modifier_hero_unique_modifier_enchantress_impetus:IsPurgable() return false end
function modifier_hero_unique_modifier_enchantress_impetus:IsPurgeException() return false end
function modifier_hero_unique_modifier_enchantress_impetus:RemoveOnDeath() return false end
function modifier_hero_unique_modifier_enchantress_impetus:DeclareFunctions()
    return
    {
        MODIFIER_EVENT_ON_TAKEDAMAGE
    }
end
function modifier_hero_unique_modifier_enchantress_impetus:OnTakeDamage(params)
    if params.attacker ~= self:GetParent() then return end
    if params.inflictor == nil then return end
    if params.inflictor:GetAbilityName() ~= "enchantress_impetus" then return end
    if self.ignore then return end
    self.ignore = true
    ApplyDamage({ victim = params.unit, attacker = self:GetParent(), damage = self:GetAbility():GetSpecialValueFor("bonus_damage"), damage_type = DAMAGE_TYPE_PURE, ability = self:GetAbility() })
    self.ignore = nil
end