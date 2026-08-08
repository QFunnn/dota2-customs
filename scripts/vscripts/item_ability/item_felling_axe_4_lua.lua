--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 5a808f3 · 2026-08-08 04:09:05 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_item_felling_axe_lua", "item_ability/item_felling_axe_2_lua.lua", LUA_MODIFIER_MOTION_NONE)
--Abilities
if item_felling_axe_4_lua == nil then
	item_felling_axe_4_lua = class({})
end
function item_felling_axe_4_lua:GetIntrinsicModifierName()
	return "modifier_item_felling_axe_lua"
end