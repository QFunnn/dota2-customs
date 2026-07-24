--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_tinker_eureka_custom", "heroes/npc_dota_hero_tinker_custom/tinker_eureka_custom", LUA_MODIFIER_MOTION_NONE)

tinker_eureka_custom = class({})

tinker_eureka_custom.modifier_tinker_1 = 0.25
tinker_eureka_custom.modifier_tinker_1_max = 45

function tinker_eureka_custom:GetIntrinsicModifierName()
    return "modifier_tinker_eureka_custom"
end

modifier_tinker_eureka_custom = class({})
function modifier_tinker_eureka_custom:IsHidden() return true end
function modifier_tinker_eureka_custom:IsPurgable() return false end
function modifier_tinker_eureka_custom:IsPurgeException() return false end
function modifier_tinker_eureka_custom:RemoveOnDeath() return false end
function modifier_tinker_eureka_custom:DeclareFunctions()
    return
    {
        MODIFIER_PROPERTY_COOLDOWN_PERCENTAGE,
        MODIFIER_PROPERTY_OVERRIDE_ABILITY_SPECIAL,
        MODIFIER_PROPERTY_OVERRIDE_ABILITY_SPECIAL_VALUE,
    }
end

function modifier_tinker_eureka_custom:OnCreated()
    self.int_per_one_cdr = self:GetAbility():GetSpecialValueFor("int_per_one_cdr")
    self.one_percent_tooltip = self:GetAbility():GetSpecialValueFor("one_percent_tooltip")
    self.max_cdr = self:GetAbility():GetSpecialValueFor("max_cdr")
end

function modifier_tinker_eureka_custom:GetValueBonus()
    if self:GetParent():PassivesDisabled() then
        return 0
    end
    local attribute = self:GetCaster():GetIntellect(false)
    local one_percent_tooltip = self.one_percent_tooltip
    local max_cdr = self.max_cdr
    if self:GetParent():HasModifier("modifier_tinker_1") then
        attribute = self:GetCaster():GetStrength()
        one_percent_tooltip = one_percent_tooltip + self:GetAbility().modifier_tinker_1
        max_cdr = max_cdr + self:GetAbility().modifier_tinker_1_max
    end
    local bonus = attribute / self.int_per_one_cdr * one_percent_tooltip
    return math.min(max_cdr, bonus)
end

function modifier_tinker_eureka_custom:GetModifierOverrideAbilitySpecial(data)
    if data.ability:GetAbilityName() == "tinker_eureka_custom" and data.ability_special_value == "item_cooldown_tooltip" then
        return 1
    end
end

function modifier_tinker_eureka_custom:GetModifierPercentageCooldown(data)
    if data.ability and data.ability:IsItem() then
        return self:GetValueBonus()
    end
end

function modifier_tinker_eureka_custom:GetModifierOverrideAbilitySpecialValue(data)
    if data.ability:GetAbilityName() == "tinker_eureka_custom" and data.ability_special_value == "item_cooldown_tooltip" then
        return self:GetValueBonus()
    end
end