--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build ec5ff63 
  ~ auto-generated — do not edit
]]


modifier_windrunner_focus_fire_debuff = class({})
function modifier_windrunner_focus_fire_debuff:IsHidden()
	return true
end
function modifier_windrunner_focus_fire_debuff:IsPurgeException()
	return false
end
function modifier_windrunner_focus_fire_debuff:IsPurgable()
	return false
end
function modifier_windrunner_focus_fire_debuff:RemoveOnDeath()
	return false
end