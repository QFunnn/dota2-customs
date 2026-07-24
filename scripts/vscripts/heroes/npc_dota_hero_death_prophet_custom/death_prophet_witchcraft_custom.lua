--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_death_prophet_witchcraft_custom", "heroes/npc_dota_hero_death_prophet_custom/death_prophet_witchcraft_custom", LUA_MODIFIER_MOTION_NONE)

death_prophet_witchcraft_custom = class({})
death_prophet_witchcraft_custom.modifier_death_prophet_19 = {0.5,0.75,1}

function death_prophet_witchcraft_custom:GetIntrinsicModifierName()
    return "modifier_death_prophet_witchcraft_custom"
end

modifier_death_prophet_witchcraft_custom = class({})
function modifier_death_prophet_witchcraft_custom:IsHidden() return true end
function modifier_death_prophet_witchcraft_custom:IsPurgable() return false end
function modifier_death_prophet_witchcraft_custom:IsPurgeException() return false end
function modifier_death_prophet_witchcraft_custom:RemoveOnDeath() return false end

function modifier_death_prophet_witchcraft_custom:DeclareFunctions()
    return
    {
        MODIFIER_PROPERTY_COOLDOWN_PERCENTAGE,
        MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE,
        MODIFIER_PROPERTY_SPELL_AMPLIFY_PERCENTAGE,
    }
end

function modifier_death_prophet_witchcraft_custom:GetModifierMoveSpeedBonus_Percentage()
    return self:GetAbility():GetSpecialValueFor("movement_speed_pct")
end

function modifier_death_prophet_witchcraft_custom:GetModifierPercentageCooldown()
    return self:GetAbility():GetSpecialValueFor("cooldown_reduction_pct")
end

function modifier_death_prophet_witchcraft_custom:GetModifierSpellAmplify_Percentage()
    if self:GetCaster():HasModifier("modifier_death_prophet_19") then
        return self:GetAbility().modifier_death_prophet_19[self:GetCaster():GetTalentLevel("modifier_death_prophet_19")] * self:GetParent():GetLevel()
    end
end