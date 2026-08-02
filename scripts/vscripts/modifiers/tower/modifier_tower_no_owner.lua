--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build b9dc48c · 2026-08-02 17:42:46 UTC
  ~ auto-generated — do not edit
]]


modifier_tower_no_owner = class({})
function modifier_tower_no_owner:IsHidden()
	return true
end
function modifier_tower_no_owner:IsPurgable()
	return false
end
function modifier_tower_no_owner:RemoveOnDeath()
	return false
end
function modifier_tower_no_owner:CheckState()
	return {
		[MODIFIER_STATE_INVULNERABLE] = true,
		[MODIFIER_STATE_DISARMED] = true,
		[MODIFIER_STATE_NO_HEALTH_BAR] = true,
		[MODIFIER_STATE_NOT_ON_MINIMAP] = true,
		[MODIFIER_STATE_UNTARGETABLE] = true,
		[MODIFIER_STATE_UNSELECTABLE] = true,
		[MODIFIER_STATE_OUT_OF_GAME] = true,
	}
end