--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 9d26fbd · 2026-08-06 05:45:25 UTC
  ~ auto-generated — do not edit
]]


modifier_cha_high_cooldown = class({})
function modifier_cha_high_cooldown:IsHidden()
	return true
end
function modifier_cha_high_cooldown:IsPurgable()
	return false
end
function modifier_cha_high_cooldown:IsPurgeException()
	return false
end
function modifier_cha_high_cooldown:RemoveOnDeath()
	return false
end