--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_item_enhancement_alert_custom", "abilities/items/neutral/item_enhancement_alert_custom", LUA_MODIFIER_MOTION_NONE)

item_enhancement_alert_custom = class({})

function item_enhancement_alert_custom:GetIntrinsicModifierName()
return "modifier_item_enhancement_alert_custom"
end


modifier_item_enhancement_alert_custom = class(mod_hidden)
function modifier_item_enhancement_alert_custom:RemoveOnDeath() return false end
function modifier_item_enhancement_alert_custom:OnCreated(table)
self.parent = self:GetParent()
self.ability = self:GetAbility()

self.speed_bonus = self.ability:GetSpecialValueFor("bonus_attack_speed")
self.evasion = self.ability:GetSpecialValueFor("evasion")
end

function modifier_item_enhancement_alert_custom:DeclareFunctions()
return
{
    MODIFIER_PROPERTY_ATTACKSPEED_BONUS_CONSTANT,
    MODIFIER_PROPERTY_EVASION_CONSTANT,
}
end

function modifier_item_enhancement_alert_custom:GetModifierAttackSpeedBonus_Constant()
return self.speed_bonus
end

function modifier_item_enhancement_alert_custom:GetModifierEvasion_Constant()
return self.evasion
end