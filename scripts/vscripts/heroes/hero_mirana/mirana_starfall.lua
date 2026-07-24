--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


function ScepterStarfall( keys )
	local caster = keys.caster
	local ability = keys.ability

	if not ability then return end

	-- is this an illusion?
	if caster:IsIllusion() then
		-- Remove thinker
		caster:RemoveModifierByName('modifier_mirana_starfall_scepter_thinker')

		return
	end

	-- Check if we actually have scepter
	if caster:HasScepter() and not caster:IsInvisible() then
		ability:OnSpellStart()
	end
end