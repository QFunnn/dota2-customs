--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build b9dc48c · 2026-08-02 17:42:46 UTC
  ~ auto-generated — do not edit
]]


modifier_generic_passing = class({})

function modifier_generic_passing:IsHidden()
	return true
end
function modifier_generic_passing:IsPurgable()
	return true
end
function modifier_generic_passing:CheckState()
	return {
		[MODIFIER_STATE_FLYING_FOR_PATHING_PURPOSES_ONLY] = true,
	}
end