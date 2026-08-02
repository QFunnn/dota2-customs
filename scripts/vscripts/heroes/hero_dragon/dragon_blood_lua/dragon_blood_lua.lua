--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build b9dc48c · 2026-08-02 17:42:46 UTC
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