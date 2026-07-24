--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_item_whisper_of_the_dread_custom", "abilities/items/neutral/item_whisper_of_the_dread_custom", LUA_MODIFIER_MOTION_NONE)

item_whisper_of_the_dread_custom = class({})

function item_whisper_of_the_dread_custom:GetIntrinsicModifierName()
if not self:GetCaster():IsRealHero() then return end
return "modifier_item_whisper_of_the_dread_custom"
end


modifier_item_whisper_of_the_dread_custom = class(mod_hidden)
function modifier_item_whisper_of_the_dread_custom:RemoveOnDeath() return false end
function modifier_item_whisper_of_the_dread_custom:OnCreated(table)
self.parent = self:GetParent()
self.ability = self:GetAbility()

self.mana_reduce = self.ability:GetSpecialValueFor("mana_reduce")
self.bonus_spell_damage = self.ability:GetSpecialValueFor("bonus_spell_damage")
end

function modifier_item_whisper_of_the_dread_custom:DeclareFunctions()
return
{
	MODIFIER_PROPERTY_SPELL_AMPLIFY_PERCENTAGE,
	MODIFIER_PROPERTY_MANACOST_PERCENTAGE_STACKING
}
end

function modifier_item_whisper_of_the_dread_custom:GetModifierSpellAmplify_Percentage()
return self.bonus_spell_damage
end

function modifier_item_whisper_of_the_dread_custom:GetModifierPercentageManacostStacking()
return self.mana_reduce
end