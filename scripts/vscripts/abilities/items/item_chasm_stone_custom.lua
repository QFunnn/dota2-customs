--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_item_chasm_stone_custom", "abilities/items/item_chasm_stone_custom", LUA_MODIFIER_MOTION_NONE)

item_chasm_stone_custom = class({})

function item_chasm_stone_custom:GetIntrinsicModifierName()
return "modifier_item_chasm_stone_custom"
end

function item_chasm_stone_custom:Precache(context)
if self:GetCaster() and self:GetCaster():IsIllusion() then return end
end

modifier_item_chasm_stone_custom = class(mod_hidden)
function modifier_item_chasm_stone_custom:RemoveOnDeath() return false end
function modifier_item_chasm_stone_custom:OnCreated()
self.parent = self:GetParent()
self.ability = self:GetAbility()

self.cdr_bonus = self.ability:GetSpecialValueFor("cdr_bonus")
end

function modifier_item_chasm_stone_custom:DeclareFunctions()
return 
{
	MODIFIER_PROPERTY_COOLDOWN_PERCENTAGE
}
end

function modifier_item_chasm_stone_custom:GetModifierPercentageCooldown(params)
if self.parent:HasModifier("modifier_item_wind_waker_custom") then return end
if self.parent:HasModifier("modifier_item_sheepstick_custom") then return end
if self.parent:HasModifier("modifier_item_octarine_core_custom") then return end
if self.parent:HasModifier("modifier_item_nullifier_custom") then return end
if self.parent:HasModifier("modifier_alchemist_gold_shiva_custom_stats") then return end
if self.parent:HasModifier("modifier_item_alchemist_gold_octarine") then return end
if self.parent:HasModifier("modifier_tinker_rearm_custom_tracker") and params.ability and params.ability:IsItem() then return end
return self.cdr_bonus
end