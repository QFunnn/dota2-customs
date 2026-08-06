--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 9d26fbd · 2026-08-06 05:45:25 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_item_gang_letter", "item_ability/item_gang_letter.lua", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_item_gang_letter_effect", "item_ability/item_gang_letter.lua", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_item_gang_letter_fade", "item_ability/item_gang_letter.lua", LUA_MODIFIER_MOTION_NONE)
--Abilities
if item_gang_senior_letter == nil then
	item_gang_senior_letter = class({}) ---@class CDOTA_Item_Lua
end
function item_gang_senior_letter:GetIntrinsicModifierName()
	return "modifier_item_gang_letter"
end