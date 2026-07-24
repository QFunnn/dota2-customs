--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_chen_creep_time_warp", "heroes/npc_dota_hero_chen_custom/chen_creep_time_warp", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_chen_creep_time_warp_buff", "heroes/npc_dota_hero_chen_custom/chen_creep_time_warp", LUA_MODIFIER_MOTION_NONE)

chen_creep_time_warp = class({})

function chen_creep_time_warp:GetIntrinsicModifierName()
    return "modifier_chen_creep_time_warp"
end

modifier_chen_creep_time_warp = class({})
function modifier_chen_creep_time_warp:IsHidden() return true end
function modifier_chen_creep_time_warp:IsPurgable() return false end
function modifier_chen_creep_time_warp:IsPurgeException() return false end

function modifier_chen_creep_time_warp:IsAura()
    return true
end

function modifier_chen_creep_time_warp:GetModifierAura()
    return "modifier_chen_creep_time_warp_buff"
end

function modifier_chen_creep_time_warp:GetAuraRadius()
    return self:GetAbility():GetSpecialValueFor("radius")
end

function modifier_chen_creep_time_warp:GetAuraDuration()
    return 0
end

function modifier_chen_creep_time_warp:GetAuraSearchTeam()
    return DOTA_UNIT_TARGET_TEAM_FRIENDLY
end

function modifier_chen_creep_time_warp:GetAuraSearchType()
    return DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC
end

function modifier_chen_creep_time_warp:GetAuraSearchFlags()
    return DOTA_UNIT_TARGET_FLAG_INVULNERABLE
end

modifier_chen_creep_time_warp_buff = class({})

function modifier_chen_creep_time_warp_buff:DeclareFunctions()
    return
    {
        MODIFIER_PROPERTY_COOLDOWN_PERCENTAGE
    }
end

function modifier_chen_creep_time_warp_buff:GetModifierPercentageCooldown()
    return self:GetAbility():GetSpecialValueFor("cooldown_reduction")
end