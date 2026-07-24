--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


modifier_generic_muted_lua = class({})

--------------------------------------------------------------------------------

function modifier_generic_muted_lua:IsDebuff()
	return true
end

function modifier_generic_muted_lua:IsHidden()
	return true
end

--------------------------------------------------------------------------------

function modifier_generic_muted_lua:CheckState()
	local state = {
	[MODIFIER_STATE_MUTED] = true,
	}
	return state
end