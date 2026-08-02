--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build b9dc48c · 2026-08-02 17:42:46 UTC
  ~ auto-generated — do not edit
]]


modifier_can_not_push = class({})
function modifier_can_not_push:IsHidden()
	return false
end
function modifier_can_not_push:IsDebuff()
	return true
end
function modifier_can_not_push:IsPurgable()
	return false
end
function modifier_can_not_push:GetTexture()
	return "backdoor_protection"
end