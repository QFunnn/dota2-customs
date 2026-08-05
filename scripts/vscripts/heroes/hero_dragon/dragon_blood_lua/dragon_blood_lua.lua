--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 9d26fbd · 2026-08-05 05:42:45 UTC
  ~ auto-generated — do not edit
]]


dragon_blood_lua = class({})
LinkLuaModifier(
	"modifier_dragon_blood_lua",
	"heroes/hero_dragon/dragon_blood_lua/modifier_dragon_blood_lua",
	LUA_MODIFIER_MOTION_NONE
)

--------------------------------------------------------------------------------
-- Passive Modifier
function dragon_blood_lua:GetIntrinsicModifierName()
	return "modifier_dragon_blood_lua"
end