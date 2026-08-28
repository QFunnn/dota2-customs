--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 0b85d8d 
  ~ auto-generated — do not edit
]]


modifier_minimap_hidden = class({})
function modifier_minimap_hidden:CheckState()
	return {
		[MODIFIER_STATE_NOT_ON_MINIMAP] = true,
	}
end