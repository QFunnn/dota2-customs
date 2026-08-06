--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 9d26fbd · 2026-08-06 05:45:25 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier(
	"modifier_item_felling_shield_lua_1",
	"item_ability/item_felling_shield_lua_1.lua",
	LUA_MODIFIER_MOTION_NONE
)
LinkLuaModifier(
	"modifier_item_felling_shield_lua_buff",
	"item_ability/item_felling_shield_lua_1.lua",
	LUA_MODIFIER_MOTION_NONE
)
LinkLuaModifier(
	"modifier_item_felling_shield_lua_shield",
	"item_ability/item_felling_shield_lua_1.lua",
	LUA_MODIFIER_MOTION_NONE
)
--Abilities
if item_felling_shield_lua_2 == nil then
	item_felling_shield_lua_2 = class({})
end
function item_felling_shield_lua_2:GetIntrinsicModifierName()
	return "modifier_item_felling_shield_lua_1"
end