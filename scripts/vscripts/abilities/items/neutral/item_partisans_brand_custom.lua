--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_item_partisans_brand_custom", "abilities/items/neutral/item_partisans_brand_custom", LUA_MODIFIER_MOTION_NONE)

item_partisans_brand_custom = class({})

function item_partisans_brand_custom:GetIntrinsicModifierName()
if not self:GetCaster():IsRealHero() then return end
return "modifier_item_partisans_brand_custom"
end


modifier_item_partisans_brand_custom = class(mod_hidden)
function modifier_item_partisans_brand_custom:RemoveOnDeath() return false end
function modifier_item_partisans_brand_custom:OnCreated(table)
self.parent = self:GetParent()
self.ability = self:GetAbility()

self.bonus_spell_damage = self.ability:GetSpecialValueFor("bonus_damage_pct")
end

function modifier_item_partisans_brand_custom:DeclareFunctions()
return
{
	MODIFIER_PROPERTY_SPELL_AMPLIFY_PERCENTAGE,
}
end

function modifier_item_partisans_brand_custom:GetModifierSpellAmplify_Percentage(params)
if not IsServer() then return end
if not params.inflictor or not params.inflictor:IsItem() then return end
return self.bonus_spell_damage
end