--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


modifier_stunned_duel_custom = class({})

function modifier_stunned_duel_custom:IsPurgable()
 	return false
end

function modifier_stunned_duel_custom:IsPurgeException()
	return false
end

function modifier_stunned_duel_custom:IsHidden() 
	return true
end

function modifier_stunned_duel_custom:RemoveOnDeath() 
	return false
end

function modifier_stunned_duel_custom:IsStunDebuff() 
	return false
end

function modifier_stunned_duel_custom:CheckState() 
	return {
		[MODIFIER_STATE_ROOTED] = true,
		[MODIFIER_STATE_STUNNED] = true,
		[MODIFIER_STATE_INVULNERABLE] = self:GetRemainingTime() > 0.1,
	}
end