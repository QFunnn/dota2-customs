--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 9d26fbd · 2026-08-05 19:52:08 UTC
  ~ auto-generated — do not edit
]]


modifier_stunned_without_anim = class({})
function modifier_stunned_without_anim:IsPurgable()
	return false
end
function modifier_stunned_without_anim:IsHidden()
	return true
end
function modifier_stunned_without_anim:IsPurgeException()
	return false
end
function modifier_stunned_without_anim:CheckState()
	return {
		[MODIFIER_STATE_STUNNED] = true,
		[MODIFIER_STATE_INVULNERABLE] = true,
		[MODIFIER_STATE_UNSELECTABLE] = true,
		[MODIFIER_STATE_OUT_OF_GAME] = true,
		[MODIFIER_STATE_NO_HEALTH_BAR] = true,
	}
end