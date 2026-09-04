--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build ec5ff63 
  ~ auto-generated — do not edit
]]


LinkLuaModifier(
	"modifier_spectre_dispersion_lua",
	"heroes/hero_spectre/modifier_spectre_dispersion_lua",
	LUA_MODIFIER_MOTION_NONE
)

function ApplyModifier(keys)
	local caster = keys.caster
	local ability = keys.ability
	local modifier = "modifier_spectre_dispersion_lua"

	caster:AddNewModifier(caster, ability, modifier, {})
end