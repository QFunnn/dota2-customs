--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 0b85d8d 
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