--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_keeper_of_the_light_dark_form", "heroes/npc_dota_hero_keeper_of_the_light_custom/keeper_of_the_light_dark_form", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_keeper_of_the_light_dark_form_debuff", "heroes/npc_dota_hero_keeper_of_the_light_custom/keeper_of_the_light_dark_form", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_keeper_of_the_light_dark_form_fx", "heroes/npc_dota_hero_keeper_of_the_light_custom/keeper_of_the_light_dark_form", LUA_MODIFIER_MOTION_NONE)

keeper_of_the_light_dark_form = class({})

function keeper_of_the_light_dark_form:Precache(context)
    PrecacheResource("particle", "particles/units/heroes/hero_abaddon/abaddon_obscure.vpcf", context)
    PrecacheResource("particle", "particles/status_fx/status_effect_keeper_spirit_form_obscure.vpcf", context)
end

function keeper_of_the_light_dark_form:GetIntrinsicModifierName()
    return "modifier_keeper_of_the_light_dark_form"
end

modifier_keeper_of_the_light_dark_form = class({})
function modifier_keeper_of_the_light_dark_form:IsHidden() return true end
function modifier_keeper_of_the_light_dark_form:IsPurgable() return false end
function modifier_keeper_of_the_light_dark_form:IsPurgeException() return false end
function modifier_keeper_of_the_light_dark_form:RemoveOnDeath() return false end
function modifier_keeper_of_the_light_dark_form:IsAura() return true end
function modifier_keeper_of_the_light_dark_form:GetModifierAura() return "modifier_keeper_of_the_light_dark_form_debuff" end
function modifier_keeper_of_the_light_dark_form:GetAuraRadius() return self:GetAbility():GetSpecialValueFor("radius") end
function modifier_keeper_of_the_light_dark_form:GetAuraSearchFlags() return DOTA_UNIT_TARGET_FLAG_INVULNERABLE end
function modifier_keeper_of_the_light_dark_form:GetAuraSearchTeam() return DOTA_UNIT_TARGET_TEAM_ENEMY end
function modifier_keeper_of_the_light_dark_form:GetAuraSearchType() return DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC end
function modifier_keeper_of_the_light_dark_form:GetAuraDuration() return 0 end
function modifier_keeper_of_the_light_dark_form:DeclareFunctions()
    return
    {
        MODIFIER_PROPERTY_CONVERT_MANA_COST_TO_HEALTH_COST,
        MODIFIER_PROPERTY_FORCE_MAX_MANA,
    }
end

function modifier_keeper_of_the_light_dark_form:OnCreated()
    if not IsServer() then return end
    self:OnIntervalThink()
    self:StartIntervalThink(1)
end

function modifier_keeper_of_the_light_dark_form:OnIntervalThink()
    if not IsServer() then return end
    if not self:GetParent():IsAlive() then
        self:StartIntervalThink(FrameTime())
        self:GetParent():RemoveModifierByName("modifier_keeper_of_the_light_dark_form_fx")
    else
        if not self:GetParent():HasModifier("modifier_keeper_of_the_light_dark_form_fx") then
            self:GetParent():AddNewModifier(self:GetParent(), self:GetAbility(), "modifier_keeper_of_the_light_dark_form_fx", {})
        end
        self:StartIntervalThink(1)
    end
end

function modifier_keeper_of_the_light_dark_form:GetModifierConvertManaCostToHealthCost()
    return 1
end

function modifier_keeper_of_the_light_dark_form:GetModifierForceMaxMana()
    return 0
end

modifier_keeper_of_the_light_dark_form_fx = class({})
function modifier_keeper_of_the_light_dark_form_fx:IsHidden() return true end
function modifier_keeper_of_the_light_dark_form_fx:IsPurgable() return false end
function modifier_keeper_of_the_light_dark_form_fx:IsPurgeException() return false end
function modifier_keeper_of_the_light_dark_form_fx:GetEffectName()
	return "particles/units/heroes/hero_abaddon/abaddon_obscure.vpcf"
end
function modifier_keeper_of_the_light_dark_form_fx:GetStatusEffectName()
	return "particles/status_fx/status_effect_keeper_spirit_form_obscure.vpcf"
end
function modifier_keeper_of_the_light_dark_form_fx:StatusEffectPriority()
    return 100000
end

modifier_keeper_of_the_light_dark_form_debuff = class({})

function modifier_keeper_of_the_light_dark_form_debuff:DeclareFunctions()
    return
    {
        MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE,
        MODIFIER_PROPERTY_CAST_RANGE_BONUS_STACKING
    }
end

function modifier_keeper_of_the_light_dark_form_debuff:GetModifierMoveSpeedBonus_Percentage()
    return self:GetAbility():GetSpecialValueFor("slow")
end

function modifier_keeper_of_the_light_dark_form_debuff:GetModifierCastRangeBonusStacking()
    return self:GetAbility():GetSpecialValueFor("cast_range")
end