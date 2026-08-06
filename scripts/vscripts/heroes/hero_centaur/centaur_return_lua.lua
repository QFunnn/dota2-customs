--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 9d26fbd · 2026-08-06 05:45:25 UTC
  ~ auto-generated — do not edit
]]


centaur_return_lua = class({})
LinkLuaModifier(
	"modifier_centaur_return_lua",
	"heroes/hero_centaur/modifier_centaur_return_lua",
	LUA_MODIFIER_MOTION_NONE
)
LinkLuaModifier(
	"modifier_centaur_return_lua_aura",
	"heroes/hero_centaur/modifier_centaur_return_lua_aura",
	LUA_MODIFIER_MOTION_NONE
)

--------------------------------------------------------------------------------
-- Passive Modifier
function centaur_return_lua:GetIntrinsicModifierName()
	return "modifier_centaur_return_lua_aura"
end