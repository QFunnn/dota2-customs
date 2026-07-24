--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_roshan_strength_of_the_immortal_custom", "heroes/npc_dota_hero_arc_warden_custom/roshan_strength_of_the_immortal_custom", LUA_MODIFIER_MOTION_NONE)

roshan_strength_of_the_immortal_custom = class({})

function roshan_strength_of_the_immortal_custom:IsRefreshable() return false end

function roshan_strength_of_the_immortal_custom:GetIntrinsicModifierName()
    return "modifier_roshan_strength_of_the_immortal_custom"
end

modifier_roshan_strength_of_the_immortal_custom = class({})
function modifier_roshan_strength_of_the_immortal_custom:IsPurgable() return false end
function modifier_roshan_strength_of_the_immortal_custom:IsPurgeException() return false end
function modifier_roshan_strength_of_the_immortal_custom:RemoveOnDeath() return false end
function modifier_roshan_strength_of_the_immortal_custom:DeclareFunctions()
    return
    {
        MODIFIER_PROPERTY_HEALTH_BONUS,
        MODIFIER_PROPERTY_PHYSICAL_ARMOR_BONUS,
        MODIFIER_PROPERTY_BASEATTACK_BONUSDAMAGE,
    }
end

function modifier_roshan_strength_of_the_immortal_custom:OnCreated()
    self.interval = self:GetAbility():GetSpecialValueFor("interval")
    if not IsServer() then return end
    self:StartIntervalThink(self.interval)
    self:GetAbility():StartCooldown(self.interval)
end

function modifier_roshan_strength_of_the_immortal_custom:OnRefresh()
    self.interval = self:GetAbility():GetSpecialValueFor("interval")
    if not IsServer() then return end
end

function modifier_roshan_strength_of_the_immortal_custom:OnIntervalThink()
    if not IsServer() then return end
    self:IncrementStackCount()
    self:GetParent():CalculateStatBonus(true)
    self:GetAbility():StartCooldown(self.interval)
end

function modifier_roshan_strength_of_the_immortal_custom:GetModifierHealthBonus()
    return self:GetAbility():GetSpecialValueFor("bonus_health") * self:GetStackCount()
end

function modifier_roshan_strength_of_the_immortal_custom:GetModifierPhysicalArmorBonus()
    return self:GetAbility():GetSpecialValueFor("bonus_armor") * self:GetStackCount()
end

function modifier_roshan_strength_of_the_immortal_custom:GetModifierBaseAttack_BonusDamage()
    return self:GetAbility():GetSpecialValueFor("bonus_damage") * self:GetStackCount()
end