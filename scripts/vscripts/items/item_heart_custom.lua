--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_item_heart_custom", "items/item_heart_custom", LUA_MODIFIER_MOTION_NONE)

item_heart_custom = class({})

function item_heart_custom:GetIntrinsicModifierName()
    return "modifier_item_heart_custom"
end

modifier_item_heart_custom = class({})
function modifier_item_heart_custom:IsHidden() return true end
function modifier_item_heart_custom:IsPurgable() return false end
function modifier_item_heart_custom:IsPurgeException() return false end
function modifier_item_heart_custom:RemoveOnDeath() return false end
function modifier_item_heart_custom:OnCreated()
    self.hp_regen = self:GetAbility():GetSpecialValueFor("hp_regen")
    self.bonus_strength = self:GetAbility():GetSpecialValueFor("bonus_strength")
    self.missing_health_regen = self:GetAbility():GetSpecialValueFor("missing_health_regen") / 100
end
function modifier_item_heart_custom:DeclareFunctions()
    return
    {
        MODIFIER_PROPERTY_HEALTH_REGEN_CONSTANT,
        MODIFIER_PROPERTY_STATS_STRENGTH_BONUS,
    }
end

function modifier_item_heart_custom:GetModifierConstantHealthRegen()
    return (self:GetCaster():GetMaxHealth() / 100 * self.hp_regen) + ((self:GetCaster():GetMaxHealth() - self:GetCaster():GetHealth()) * self.missing_health_regen)
end

function modifier_item_heart_custom:GetModifierBonusStats_Strength()
    return self.bonus_strength
end