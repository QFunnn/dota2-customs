--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


-- DISABLED (perf hit) --
-- Use "Events:modifier_added" with EventDriver if you need to do something with modifiers
function Filters:ModifierFilter(event)
	if DisableHelp.ModifierGainedFilter(event) == false then
		return false
	end

	local caster = event.entindex_caster_const and EntIndexToHScript(event.entindex_caster_const)
	local parent = event.entindex_caster_const and EntIndexToHScript(event.entindex_parent_const)
	local ability = event.entindex_ability_const and EntIndexToHScript(event.entindex_ability_const)
	local modifier_name = event.name_const

	return true
end