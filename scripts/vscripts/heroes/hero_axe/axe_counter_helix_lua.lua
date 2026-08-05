--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 9d26fbd · 2026-08-05 19:52:08 UTC
  ~ auto-generated — do not edit
]]


axe_counter_helix_lua = class({})
LinkLuaModifier(
	"modifier_axe_counter_helix_lua",
	"heroes/hero_axe/modifier_axe_counter_helix_lua",
	LUA_MODIFIER_MOTION_NONE
)
LinkLuaModifier(
	"modifier_axe_counter_helix_lua_debuff",
	"heroes/hero_axe/modifier_axe_counter_helix_lua_debuff",
	LUA_MODIFIER_MOTION_NONE
)

--------------------------------------------------------------------------------
-- Passive Modifier
function axe_counter_helix_lua:GetIntrinsicModifierName()
	return "modifier_axe_counter_helix_lua"
end