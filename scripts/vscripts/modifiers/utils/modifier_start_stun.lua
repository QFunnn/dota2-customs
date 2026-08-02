--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build b9dc48c · 2026-08-02 17:42:46 UTC
  ~ auto-generated — do not edit
]]


modifier_start_stun = class({})

function modifier_start_stun:IsHidden()
	return false
end
function modifier_start_stun:IsPurgable()
	return false
end
function modifier_start_stun:RemoveOnDeath()
	return false
end
function modifier_start_stun:CheckState()
	return {
		[MODIFIER_STATE_STUNNED] = true,
		[MODIFIER_STATE_INVULNERABLE] = true,
	}
end