--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build b9dc48c · 2026-08-02 17:42:46 UTC
  ~ auto-generated — do not edit
]]


modifier_exp = class({})

function modifier_exp:IsHidden()
	return true
end

function modifier_exp:IsPurgable()
	return false
end

function modifier_exp:RemoveOnDeath()
	return false
end

function modifier_exp:GetAttributes()
	return MODIFIER_ATTRIBUTE_MULTIPLE
end

function modifier_exp:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_EXP_RATE_BOOST,
	}
	return funcs
end

function modifier_exp:GetModifierPercentageExpRateBoost()
	return 0.5 * self:GetStackCount()
end