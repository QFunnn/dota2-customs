--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 9d26fbd · 2026-08-05 05:42:45 UTC
  ~ auto-generated — do not edit
]]


modifier_hpr = class({})

function modifier_hpr:IsHidden()
	return true
end

function modifier_hpr:IsPurgable()
	return false
end

function modifier_hpr:RemoveOnDeath()
	return false
end

function modifier_hpr:GetAttributes()
	return MODIFIER_ATTRIBUTE_MULTIPLE
end

function modifier_hpr:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_HEALTH_REGEN_CONSTANT,
	}
	return funcs
end

function modifier_hpr:GetModifierConstantHealthRegen()
	return 0.5 * self:GetStackCount()
end