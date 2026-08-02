--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build b9dc48c · 2026-08-02 17:42:46 UTC
  ~ auto-generated — do not edit
]]


modifier_invisible_truesight_pet_custom = class({})
function modifier_invisible_truesight_pet_custom:IsHidden()
	return true
end
function modifier_invisible_truesight_pet_custom:IsPurgable()
	return false
end
function modifier_invisible_truesight_pet_custom:IsPurgeException()
	return false
end
function modifier_invisible_truesight_pet_custom:CheckState()
	return {
		[MODIFIER_STATE_INVISIBLE] = true,
	}
end