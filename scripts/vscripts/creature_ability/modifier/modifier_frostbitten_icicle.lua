--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


modifier_frostbitten_icicle = class({})

------------------------------------------------------------------

function modifier_frostbitten_icicle:OnCreated( kv )
end

function modifier_frostbitten_icicle:GetStatusEffectName()  
	return "particles/status_fx/status_effect_wyvern_cold_embrace.vpcf"
end

--------------------------------------------------------------------------------

function modifier_frostbitten_icicle:CheckState()
	local state = {}
	state[MODIFIER_STATE_STUNNED] = true
	state[MODIFIER_STATE_FROZEN] = true
	
	return state
end



