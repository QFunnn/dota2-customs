--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_aghanim_apex", "heroes/npc_dota_hero_meepo_custom/aghanim_apex", LUA_MODIFIER_MOTION_NONE)

aghanim_apex = class({})

function aghanim_apex:GetIntrinsicModifierName()
    return "modifier_aghanim_apex"
end

function aghanim_apex:OnHeroLevelUp()
    if not IsServer() then return end
    self:GetCaster():CalculateStatBonus(true)
end

function aghanim_apex:OnInventoryContentsChanged()
    if not IsServer() then return end
    self:GetCaster():CalculateStatBonus(true)
end

modifier_aghanim_apex = class({})
function modifier_aghanim_apex:IsHidden() return true end
function modifier_aghanim_apex:IsPurgable() return false end
function modifier_aghanim_apex:IsPurgeException() return false end
function modifier_aghanim_apex:RemoveOnDeath() return false end
function modifier_aghanim_apex:DeclareFunctions()
    return
    {
        MODIFIER_PROPERTY_STATS_STRENGTH_BONUS,
        MODIFIER_PROPERTY_STATS_AGILITY_BONUS,
        MODIFIER_PROPERTY_STATS_INTELLECT_BONUS
    }
end

function modifier_aghanim_apex:GetModifierBonusStats_Strength()
    local bonus = self:GetAbility():GetSpecialValueFor("bonus_stats")
    if self:GetCaster():HasModifier("modifier_item_moon_aghanim") or self:GetCaster():HasModifier("modifier_item_moon_aghanim_buff") then
        bonus = bonus + self:GetAbility():GetSpecialValueFor("bonus_scepter")
    end
    return bonus * self:GetCaster():GetLevel()
end

function modifier_aghanim_apex:GetModifierBonusStats_Agility()
    local bonus = self:GetAbility():GetSpecialValueFor("bonus_stats")
    if self:GetCaster():HasModifier("modifier_item_moon_aghanim") or self:GetCaster():HasModifier("modifier_item_moon_aghanim_buff") then
        bonus = bonus + self:GetAbility():GetSpecialValueFor("bonus_scepter")
    end
    return bonus * self:GetCaster():GetLevel()
end

function modifier_aghanim_apex:GetModifierBonusStats_Intellect()
    local bonus = self:GetAbility():GetSpecialValueFor("bonus_stats")
    if self:GetCaster():HasModifier("modifier_item_moon_aghanim") or self:GetCaster():HasModifier("modifier_item_moon_aghanim_buff") then
        bonus = bonus + self:GetAbility():GetSpecialValueFor("bonus_scepter")
    end
    return bonus * self:GetCaster():GetLevel()
end