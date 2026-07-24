--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_item_azure_song", "item_ability/item_azure_song.lua", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_item_azure_song_slow", "item_ability/item_azure_song.lua", LUA_MODIFIER_MOTION_NONE)
--Abilities
if item_star_design == nil then
	item_star_design = class({})
end
function item_star_design:GetIntrinsicModifierName()
	return "modifier_item_azure_song"
end
function item_star_design:GetAbilityTextureName()
	return self.sAbilityTexture or "item_star_design"
end