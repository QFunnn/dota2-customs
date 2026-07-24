--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_pangolier_heartpiercer_custom", "heroes/hero_pangolier/pangolier_heartpiercer_custom", LUA_MODIFIER_MOTION_NONE)

pangolier_heartpiercer_custom = class({})

local proc_abilities = 
{
    pangolier_swashbuckle = true,
    pangolier_shield_crash = true,
    pangolier_gyroshell = true,
    pangolier_rollup = true,
}

function pangolier_heartpiercer_custom:GetIntrinsicModifierName()
    return "modifier_pangolier_heartpiercer_custom"
end

modifier_pangolier_heartpiercer_custom = class({})

function modifier_pangolier_heartpiercer_custom:IsHidden() return true end
function modifier_pangolier_heartpiercer_custom:IsPurgable() return false end
function modifier_pangolier_heartpiercer_custom:GetAttributes() return MODIFIER_ATTRIBUTE_PERMANENT + MODIFIER_ATTRIBUTE_IGNORE_INVULNERABLE end

function modifier_pangolier_heartpiercer_custom:DeclareFunctions()
    return 
    {
        MODIFIER_PROPERTY_TOTALDAMAGEOUTGOING_PERCENTAGE
    }
end

function modifier_pangolier_heartpiercer_custom:GetModifierTotalDamageOutgoing_Percentage(params)
    if self:GetParent():PassivesDisabled() or self:GetParent():IsIllusion() then return end

    if params.damage_category == DOTA_DAMAGE_CATEGORY_ATTACK or (params.inflictor and proc_abilities[params.inflictor:GetAbilityName()]) then
        local chance = self:GetAbility():GetSpecialValueFor("chance_pct")

        if (not params.target:IsMagicImmune() and RollPercentage(chance)) or IsInToolsMode() then
            local duration = self:GetAbility():GetSpecialValueFor("duration")
            --params.target:AddNewModifier(self:GetParent(), self:GetAbility(), "modifier_pangolier_heartpiercer_debuff", { duration = duration * (1 - params.target:GetStatusResistance()) })
            params.target:AddNewModifier(self:GetParent(), self:GetAbility(), "modifier_pangolier_heartpiercer_delay", { duration = 2 })
        end
    end
end