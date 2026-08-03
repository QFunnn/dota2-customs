--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 9d26fbd · 2026-08-03 22:18:26 UTC
  ~ auto-generated — do not edit
]]


modifier_no_cleave = class({})

function modifier_no_cleave:IsHidden()
	return true
end
function modifier_no_cleave:IsPurgable()
	return false
end
function modifier_no_cleave:RemoveOnDeath()
	return false
end