--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 0b85d8d 
  ~ auto-generated — do not edit
]]


modifier_meat_hook_followthrough_lua = class({})

--------------------------------------------------------------------------------

function modifier_meat_hook_followthrough_lua:IsHidden()
	return true
end

--------------------------------------------------------------------------------

function modifier_meat_hook_followthrough_lua:CheckState()
	local state = {
		[MODIFIER_STATE_STUNNED] = true,
	}

	return state
end

--------------------------------------------------------------------------------