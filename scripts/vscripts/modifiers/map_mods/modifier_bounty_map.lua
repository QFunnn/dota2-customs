--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 9d26fbd · 2026-08-03 22:18:26 UTC
  ~ auto-generated — do not edit
]]


modifier_bounty_map = class({})

function modifier_bounty_map:IsHidden()
	return false
end
function modifier_bounty_map:IsPurgable()
	return false
end

function modifier_bounty_map:CheckState()
	return {
		[MODIFIER_STATE_UNSELECTABLE] = true,
		[MODIFIER_STATE_NO_UNIT_COLLISION] = true,
		[MODIFIER_STATE_OUT_OF_GAME] = true,
		[MODIFIER_STATE_INVULNERABLE] = true,
		[MODIFIER_STATE_NO_HEALTH_BAR] = true,
	}
end

function modifier_bounty_map:RemoveOnDeath()
	return false
end

function modifier_bounty_map:DeclareFunctions()
	return { MODIFIER_PROPERTY_PROVIDES_FOW_POSITION }
end

function modifier_bounty_map:GetModifierProvidesFOWVision()
	return 1
end