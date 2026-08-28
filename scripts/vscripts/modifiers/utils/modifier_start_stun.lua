--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 0b85d8d 
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