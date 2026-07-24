--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


modifier_tempest_double_min_health = class({})

function modifier_tempest_double_min_health:IsHidden() return true end
function modifier_tempest_double_min_health:IsPurgable() return false end
function modifier_tempest_double_min_health:IsDebuff() return false end

function modifier_tempest_double_min_health:StatusEffectPriority()
	return MODIFIER_PRIORITY_SUPER_ULTRA 
end


function modifier_tempest_double_min_health:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_MIN_HEALTH,
	}
end

function modifier_tempest_double_min_health:GetMinHealth()
	return 1
end