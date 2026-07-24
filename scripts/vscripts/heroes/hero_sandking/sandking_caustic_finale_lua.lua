--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


sandking_caustic_finale_lua = class({})
LinkLuaModifier( "modifier_sand_king_caustic_finale_lua", "heroes/hero_sandking/modifier_sand_king_caustic_finale_lua", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_sand_king_caustic_finale_lua_debuff", "heroes/hero_sandking/modifier_sand_king_caustic_finale_lua_debuff", LUA_MODIFIER_MOTION_NONE )

--------------------------------------------------------------------------------
-- Passive Modifier
function sandking_caustic_finale_lua:GetIntrinsicModifierName()
	return "modifier_sand_king_caustic_finale_lua"
end