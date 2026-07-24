--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_item_enhancement_fleetfooted_custom", "abilities/items/neutral/item_enhancement_fleetfooted_custom", LUA_MODIFIER_MOTION_NONE)

item_enhancement_fleetfooted_custom = class({})

function item_enhancement_fleetfooted_custom:GetIntrinsicModifierName()
return "modifier_item_enhancement_fleetfooted_custom"
end


modifier_item_enhancement_fleetfooted_custom = class({})
function modifier_item_enhancement_fleetfooted_custom:IsHidden() return true end
function modifier_item_enhancement_fleetfooted_custom:IsPurgable() return false end
function modifier_item_enhancement_fleetfooted_custom:RemoveOnDeath() return false end
function modifier_item_enhancement_fleetfooted_custom:OnCreated(table)
self.parent = self:GetParent()
self.ability = self:GetAbility()

self.movespeed = self.ability:GetSpecialValueFor("movespeed")
self.slow_resist = self.ability:GetSpecialValueFor("slow_resist")

end

function modifier_item_enhancement_fleetfooted_custom:OnDestroy()
if not IsServer() then return end
if not self.mod or self.mod:IsNull() then return end
self.mod:Destroy()
end

function modifier_item_enhancement_fleetfooted_custom:DeclareFunctions()
return
{
    MODIFIER_PROPERTY_MOVESPEED_BONUS_CONSTANT,
    MODIFIER_PROPERTY_SLOW_RESISTANCE_STACKING
}
end

function modifier_item_enhancement_fleetfooted_custom:GetModifierSlowResistance_Stacking()
return self.slow_resist
end

function modifier_item_enhancement_fleetfooted_custom:GetModifierMoveSpeedBonus_Constant()
return self.movespeed
end
