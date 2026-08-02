--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build b9dc48c · 2026-08-02 17:42:46 UTC
  ~ auto-generated — do not edit
]]


function Suicide(keys)
	local caster = keys.caster
	local caster_location = caster:GetAbsOrigin()
	local ability = keys.ability
	local ability_level = ability:GetLevel() - 1

	--Kill the caster
	caster:Kill(ability, caster)
end