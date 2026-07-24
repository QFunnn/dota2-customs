--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_zuus_static_field_custom", "heroes/npc_dota_hero_zuus_custom/zuus_static_field_custom", LUA_MODIFIER_MOTION_NONE)

zuus_static_field_custom = class({})
zuus_static_field_custom.modifier_zuus_21 = 2

function zuus_static_field_custom:GetIntrinsicModifierName()
    return "modifier_zuus_static_field_custom"
end

modifier_zuus_static_field_custom = class({})
function modifier_zuus_static_field_custom:IsHidden() return true end
function modifier_zuus_static_field_custom:IsPurgable() return false end
function modifier_zuus_static_field_custom:IsPurgeException() return false end
function modifier_zuus_static_field_custom:RemoveOnDeath() return false end
function modifier_zuus_static_field_custom:OnTakeDamage(params)
    if not IsServer() then return end
    if params.attacker ~= self:GetParent() then return end
    if params.unit == self:GetParent() then return end
    if params.inflictor and params.inflictor:GetAbilityName() == "zuus_static_field_custom" then return end
    if params.inflictor and params.inflictor:IsItem() then return end
    local damage_health_pct = self:GetAbility():GetSpecialValueFor("damage_health_pct")
    if self:GetCaster():HasModifier("modifier_zuus_21") then
        damage_health_pct = modifier_zuus_21 + self:GetAbility().modifier_zuus_21
    end
    local damage_percent = params.unit:GetHealth() / 100 * damage_health_pct
    ApplyDamage({victim = params.unit, attacker = self:GetCaster(), damage = damage_percent, damage_type = DAMAGE_TYPE_MAGICAL, ability = self:GetAbility()})
    local particle = ParticleManager:CreateParticle("particles/units/heroes/hero_zuus/zuus_static_field.vpcf", PATTACH_ABSORIGIN_FOLLOW, params.unit)
    ParticleManager:ReleaseParticleIndex(particle)
end