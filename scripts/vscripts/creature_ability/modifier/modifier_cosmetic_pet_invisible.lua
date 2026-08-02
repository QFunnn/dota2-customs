--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build b9dc48c · 2026-08-02 17:42:46 UTC
  ~ auto-generated — do not edit
]]


modifier_cosmetic_pet_invisible = class({})

function modifier_cosmetic_pet_invisible:CheckState()
	return {
		[MODIFIER_STATE_TRUESIGHT_IMMUNE] = true,
		[MODIFIER_STATE_INVISIBLE] = true,
	}
end