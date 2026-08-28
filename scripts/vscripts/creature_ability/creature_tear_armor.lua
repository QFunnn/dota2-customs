--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 0b85d8d 
  ~ auto-generated — do not edit
]]


creature_tear_armor = class({})
LinkLuaModifier(
	"modifier_creature_tear_armor",
	"creature_ability/modifier_creature_tear_armor",
	LUA_MODIFIER_MOTION_NONE
)

function creature_tear_armor:GetIntrinsicModifierName()
	return "modifier_creature_tear_armor"
end