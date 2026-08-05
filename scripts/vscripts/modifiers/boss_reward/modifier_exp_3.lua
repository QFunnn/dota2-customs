--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 9d26fbd · 2026-08-05 05:42:45 UTC
  ~ auto-generated — do not edit
]]


modifier_exp_3 = class({})

function modifier_exp_3:IsHidden()
	return true
end

function modifier_exp_3:IsPurgable()
	return false
end

function modifier_exp_3:RemoveOnDeath()
	return false
end

function modifier_exp_3:GetAttributes()
	return MODIFIER_ATTRIBUTE_MULTIPLE
end

function modifier_exp_3:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_EXP_RATE_BOOST,
	}
	return funcs
end

function modifier_exp_3:GetModifierPercentageExpRateBoost()
	return 2
end