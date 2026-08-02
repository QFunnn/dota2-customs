--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build b9dc48c · 2026-08-02 17:42:46 UTC
  ~ auto-generated — do not edit
]]


modifier_minimap_hidden = class({})
function modifier_minimap_hidden:CheckState()
	return {
		[MODIFIER_STATE_NOT_ON_MINIMAP] = true,
	}
end