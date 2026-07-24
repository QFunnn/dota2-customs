--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_item_enhancement_quickened_custom", "abilities/items/neutral/item_enhancement_quickened_custom", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_item_enhancement_quickened_custom_slow", "abilities/items/neutral/item_enhancement_quickened_custom", LUA_MODIFIER_MOTION_NONE)

item_enhancement_quickened_custom = class({})

function item_enhancement_quickened_custom:GetIntrinsicModifierName()
return "modifier_item_enhancement_quickened_custom"
end


modifier_item_enhancement_quickened_custom = class(mod_hidden)
function modifier_item_enhancement_quickened_custom:RemoveOnDeath() return false end
function modifier_item_enhancement_quickened_custom:OnCreated(table)
self.parent = self:GetParent()
self.ability = self:GetAbility()

self.movement_speed = self.ability:GetSpecialValueFor("movement_speed")
self.duration = self.ability:GetSpecialValueFor("duration")
self.range = self.ability:GetSpecialValueFor("range")

if not self.parent:IsRealHero() then return end
self.parent:AddDamageEvent_out(self, true)
end

function modifier_item_enhancement_quickened_custom:DeclareFunctions()
return
{
    MODIFIER_PROPERTY_MOVESPEED_BONUS_CONSTANT
}
end

function modifier_item_enhancement_quickened_custom:GetModifierMoveSpeedBonus_Constant()
return self.movement_speed
end


function modifier_item_enhancement_quickened_custom:DamageEvent_out(params)
if not IsServer() then return end
if self.parent ~= params.attacker then return end
if not params.unit:IsUnit() then return end
if (self.parent:GetAbsOrigin() - params.unit:GetAbsOrigin()):Length2D() > self.range then return end

params.unit:AddNewModifier(self.parent, self.ability, "modifier_item_enhancement_quickened_custom_slow", {duration = self.duration})
end

modifier_item_enhancement_quickened_custom_slow = class(mod_hidden)
function modifier_item_enhancement_quickened_custom_slow:IsPurgable() return true end
function modifier_item_enhancement_quickened_custom_slow:OnCreated()
self.slow = self:GetAbility():GetSpecialValueFor("slow")
end

function modifier_item_enhancement_quickened_custom_slow:DeclareFunctions()
return
{
    MODIFIER_PROPERTY_MOVESPEED_BONUS_CONSTANT
}
end

function modifier_item_enhancement_quickened_custom_slow:GetModifierMoveSpeedBonus_Constant()
return self.slow
end