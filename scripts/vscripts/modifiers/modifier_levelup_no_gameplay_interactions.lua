--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build b9dc48c · 2026-08-02 17:42:46 UTC
  ~ auto-generated — do not edit
]]


modifier_levelup_no_gameplay_interactions = class({})

function modifier_levelup_no_gameplay_interactions:IsHidden()
	return true
end
function modifier_levelup_no_gameplay_interactions:IsPurgable()
	return false
end
function modifier_levelup_no_gameplay_interactions:IsPurgeException()
	return false
end
function modifier_levelup_no_gameplay_interactions:RemoveOnDeath()
	return false
end

function modifier_levelup_no_gameplay_interactions:CheckState()
	return {
		[MODIFIER_STATE_INVULNERABLE] = true,
		[MODIFIER_STATE_ATTACK_IMMUNE] = true,
		[MODIFIER_STATE_MAGIC_IMMUNE] = true,
		[MODIFIER_STATE_DISARMED] = true,
		[MODIFIER_STATE_ROOTED] = true,
		[MODIFIER_STATE_COMMAND_RESTRICTED] = true,
		[MODIFIER_STATE_NO_UNIT_COLLISION] = true,
	}
end