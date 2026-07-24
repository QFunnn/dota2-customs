--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_rubick_arcane_supremacy_custom", "heroes/npc_dota_hero_rubick_custom/rubick_arcane_supremacy_custom", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_rubick_arcane_supremacy_buff", "heroes/npc_dota_hero_rubick_custom/rubick_arcane_supremacy_custom", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_rubick_arcane_supremacy_debuff", "heroes/npc_dota_hero_rubick_custom/rubick_arcane_supremacy_custom", LUA_MODIFIER_MOTION_NONE)

rubick_arcane_supremacy_custom = class({})

rubick_arcane_supremacy_custom.modifier_rubick_5_radius = 1200
rubick_arcane_supremacy_custom.modifier_rubick_5_enemy = {-5,-10,-15}
rubick_arcane_supremacy_custom.modifier_rubick_5_friendly = {5,10,15}

function rubick_arcane_supremacy_custom:GetIntrinsicModifierName()
    return "modifier_rubick_arcane_supremacy_custom"
end

function rubick_arcane_supremacy_custom:GetAbilityTextureName()
    if self:GetToggleState() then
        return "rubick_5"
    end
    return "rubick_arcane_supremacy"
end

function rubick_arcane_supremacy_custom:ResetToggleOnRespawn()
    return false
end

function rubick_arcane_supremacy_custom:OnToggle()
    
end

function rubick_arcane_supremacy_custom:GetBehavior()
    if self:GetCaster():HasModifier("modifier_rubick_5") then
        return DOTA_ABILITY_BEHAVIOR_TOGGLE
    end
    return DOTA_ABILITY_BEHAVIOR_PASSIVE
end

modifier_rubick_arcane_supremacy_custom = class({})
function modifier_rubick_arcane_supremacy_custom:IsHidden() return true end
function modifier_rubick_arcane_supremacy_custom:IsPurgable() return false end
function modifier_rubick_arcane_supremacy_custom:IsPurgeException() return false end
function modifier_rubick_arcane_supremacy_custom:RemoveOnDeath() return false end
function modifier_rubick_arcane_supremacy_custom:DeclareFunctions()
    return
    {
        MODIFIER_PROPERTY_CAST_RANGE_BONUS_STACKING,
        MODIFIER_PROPERTY_SPELL_AMPLIFY_PERCENTAGE,
    }
end
function modifier_rubick_arcane_supremacy_custom:GetModifierCastRangeBonusStacking()
    return self:GetAbility():GetSpecialValueFor("cast_range")
end
function modifier_rubick_arcane_supremacy_custom:GetModifierSpellAmplify_Percentage()
    return self:GetAbility():GetSpecialValueFor("spell_amp")
end

function modifier_rubick_arcane_supremacy_custom:IsAura()
	return self:GetCaster():HasModifier("modifier_rubick_5")
end

function modifier_rubick_arcane_supremacy_custom:GetModifierAura()
    if self:GetAbility():GetToggleState() then
        return "modifier_rubick_arcane_supremacy_debuff"
    else
        return "modifier_rubick_arcane_supremacy_buff"
    end
end

function modifier_rubick_arcane_supremacy_custom:GetAuraRadius()
	return self:GetCaster():GetAoeBonus(self:GetAbility().modifier_rubick_5_radius)
end

function modifier_rubick_arcane_supremacy_custom:GetAuraDuration()
	return 0
end

function modifier_rubick_arcane_supremacy_custom:GetAuraSearchTeam()
    if self:GetAbility():GetToggleState() then
        return DOTA_UNIT_TARGET_TEAM_ENEMY
    else
        return DOTA_UNIT_TARGET_TEAM_FRIENDLY
    end
end

function modifier_rubick_arcane_supremacy_custom:GetAuraSearchType()
	return DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC
end

modifier_rubick_arcane_supremacy_buff = class({})
function modifier_rubick_arcane_supremacy_buff:IsPurgable() return false end
function modifier_rubick_arcane_supremacy_buff:IsPurgeException() return false end
function modifier_rubick_arcane_supremacy_buff:DeclareFunctions()
    return
    {
        MODIFIER_PROPERTY_SPELL_AMPLIFY_PERCENTAGE,
    }
end
function modifier_rubick_arcane_supremacy_buff:GetModifierSpellAmplify_Percentage()
    return self:GetAbility().modifier_rubick_5_friendly[self:GetCaster():GetTalentLevel("modifier_rubick_5")]
end

modifier_rubick_arcane_supremacy_debuff = class({})
function modifier_rubick_arcane_supremacy_debuff:IsPurgable() return false end
function modifier_rubick_arcane_supremacy_debuff:IsPurgeException() return false end
function modifier_rubick_arcane_supremacy_debuff:DeclareFunctions()
    return
    {
        MODIFIER_PROPERTY_SPELL_AMPLIFY_PERCENTAGE,
    }
end
function modifier_rubick_arcane_supremacy_debuff:GetModifierSpellAmplify_Percentage()
    return self:GetAbility().modifier_rubick_5_enemy[self:GetCaster():GetTalentLevel("modifier_rubick_5")]
end