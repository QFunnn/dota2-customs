--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build ec5ff63 
  ~ auto-generated — do not edit
]]


necrolyte_heartstopper_aura_lua = class({})
LinkLuaModifier(
	"modifier_necrolyte_heartstopper_aura_lua",
	"heroes/hero_necrolyte/modifier_necrolyte_heartstopper_aura_lua",
	LUA_MODIFIER_MOTION_NONE
)
LinkLuaModifier(
	"modifier_necrolyte_heartstopper_aura_lua_effect",
	"heroes/hero_necrolyte/modifier_necrolyte_heartstopper_aura_lua_effect",
	LUA_MODIFIER_MOTION_NONE
)
LinkLuaModifier(
	"modifier_necrolyte_heartstopper_aura_lua_counter",
	"heroes/hero_necrolyte/modifier_necrolyte_heartstopper_aura_lua_counter",
	LUA_MODIFIER_MOTION_NONE
)

--------------------------------------------------------------------------------
-- Passive Modifier
function necrolyte_heartstopper_aura_lua:GetIntrinsicModifierName()
	return "modifier_necrolyte_heartstopper_aura_lua"
end