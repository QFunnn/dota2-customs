--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build b9dc48c · 2026-08-02 17:42:46 UTC
  ~ auto-generated — do not edit
]]


modifier_command_restricted = class({})

--------------------------------------------------------------------------------

function modifier_command_restricted:IsHidden()
	return false
end
function modifier_command_restricted:IsPurgable()
	return false
end

--------------------------------------------------------------------------------

function modifier_command_restricted:CheckState()
	local state = {
		[MODIFIER_STATE_COMMAND_RESTRICTED] = true,
	}

	return state
end