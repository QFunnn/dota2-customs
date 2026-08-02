--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build b9dc48c · 2026-08-02 17:42:46 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_item_gang_letter", "item_ability/item_gang_letter.lua", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_item_gang_letter_effect", "item_ability/item_gang_letter.lua", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_item_gang_letter_fade", "item_ability/item_gang_letter.lua", LUA_MODIFIER_MOTION_NONE)
--Abilities
if item_gang_gauntlet == nil then
	item_gang_gauntlet = class({})
end
function item_gang_gauntlet:GetIntrinsicModifierName()
	return "modifier_item_gang_letter"
end