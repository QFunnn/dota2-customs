--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_luna_lunar_blessing_custom", "heroes/npc_dota_hero_luna_custom/luna_lunar_blessing_custom", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_luna_lunar_blessing_custom_buff", "heroes/npc_dota_hero_luna_custom/luna_lunar_blessing_custom", LUA_MODIFIER_MOTION_NONE)

luna_lunar_blessing_custom = class({})
luna_lunar_blessing_custom.modifier_luna_9 = 1

function luna_lunar_blessing_custom:GetIntrinsicModifierName()
    return "modifier_luna_lunar_blessing_custom"
end

modifier_luna_lunar_blessing_custom = class({})
function modifier_luna_lunar_blessing_custom:IsHidden() return true end
function modifier_luna_lunar_blessing_custom:IsPurgable() return false end
function modifier_luna_lunar_blessing_custom:IsPurgeException() return false end
function modifier_luna_lunar_blessing_custom:RemoveOnDeath() return false end

function modifier_luna_lunar_blessing_custom:OnCreated()
    self.bonus_night_vision = self:GetAbility():GetSpecialValueFor("bonus_night_vision")
end

function modifier_luna_lunar_blessing_custom:OnRefresh()
    self.bonus_night_vision = self:GetAbility():GetSpecialValueFor("bonus_night_vision")
end

function modifier_luna_lunar_blessing_custom:DeclareFunctions()
    return
    {
        MODIFIER_PROPERTY_BONUS_NIGHT_VISION,
    }
end

function modifier_luna_lunar_blessing_custom:GetBonusNightVision()
    return self.bonus_night_vision
end

function modifier_luna_lunar_blessing_custom:IsAura()
    if self:GetParent():IsIllusion() then return end
    return true
end

function modifier_luna_lunar_blessing_custom:GetModifierAura()
    return "modifier_luna_lunar_blessing_custom_buff"
end

function modifier_luna_lunar_blessing_custom:GetAuraRadius()
    if not GameRules:IsDaytime() then
        return 25000
    end
    return self:GetAbility():GetSpecialValueFor("radius")
end

function modifier_luna_lunar_blessing_custom:GetAuraDuration()
    return 0
end

function modifier_luna_lunar_blessing_custom:GetAuraSearchTeam()
    return DOTA_UNIT_TARGET_TEAM_FRIENDLY
end

function modifier_luna_lunar_blessing_custom:GetAuraSearchType()
    return DOTA_UNIT_TARGET_HERO
end

function modifier_luna_lunar_blessing_custom:GetAuraSearchFlags()
    return DOTA_UNIT_TARGET_FLAG_MAGIC_IMMUNE_ENEMIES + DOTA_UNIT_TARGET_FLAG_INVULNERABLE
end

modifier_luna_lunar_blessing_custom_buff = class({})
function modifier_luna_lunar_blessing_custom_buff:IsPurgable() return false end
function modifier_luna_lunar_blessing_custom_buff:IsPurgeException() return false end

function modifier_luna_lunar_blessing_custom_buff:OnCreated()
    self.bonus_damage = self:GetAbility():GetSpecialValueFor("bonus_damage")
    self.self_bonus_damage = self:GetAbility():GetSpecialValueFor("self_bonus_damage")
end

function modifier_luna_lunar_blessing_custom_buff:OnRefresh()
    self.bonus_damage = self:GetAbility():GetSpecialValueFor("bonus_damage")
    self.self_bonus_damage = self:GetAbility():GetSpecialValueFor("self_bonus_damage")
end

function modifier_luna_lunar_blessing_custom_buff:DeclareFunctions()
    return
    {
        MODIFIER_PROPERTY_PREATTACK_BONUS_DAMAGE
    }
end

function modifier_luna_lunar_blessing_custom_buff:GetModifierPreAttack_BonusDamage()
    local bonus_per_level = 0
    if self:GetCaster():HasModifier("modifier_luna_9") then
        bonus_per_level = self:GetAbility().modifier_luna_9 * self:GetCaster():GetLevel()
    end
    if self:GetParent() == self:GetCaster() then
        return self.self_bonus_damage + bonus_per_level
    else
        return self.bonus_damage + bonus_per_level
    end
end