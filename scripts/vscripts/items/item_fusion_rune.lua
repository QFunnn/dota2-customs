--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_rune_arcane_custom", "modifiers/modifier_rune_arcane_custom", LUA_MODIFIER_MOTION_NONE)

item_fusion_rune_custom = class({})

function item_fusion_rune_custom:OnSpellStart()
	if not IsServer() then return end
	local caster = self:GetCaster()
	caster:AddNewModifier(self:GetCaster(), self, "modifier_rune_arcane_custom", {duration = 50})
	caster:AddNewModifier(self:GetCaster(), nil, "modifier_rune_doubledamage", {duration = 45})
	caster:AddNewModifier(self:GetCaster(), nil, "modifier_rune_haste", {duration = 22})
	caster:AddNewModifier(self:GetCaster(), nil, "modifier_rune_illusion", {duration = FrameTime()})
	caster:AddNewModifier(self:GetCaster(), nil, "modifier_rune_invis", {duration = 45})
	caster:AddNewModifier(self:GetCaster(), nil, "modifier_rune_regen", {duration = 30})
end






