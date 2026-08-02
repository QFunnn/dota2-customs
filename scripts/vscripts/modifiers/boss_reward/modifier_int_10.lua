--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build b9dc48c · 2026-08-02 17:42:46 UTC
  ~ auto-generated — do not edit
]]


modifier_int_10 = class({})

function modifier_int_10:IsHidden()
	return true
end

function modifier_int_10:IsPurgable()
	return false
end

function modifier_int_10:RemoveOnDeath()
	return false
end

function modifier_int_10:GetAttributes()
	return MODIFIER_ATTRIBUTE_MULTIPLE
end

function modifier_int_10:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_STATS_INTELLECT_BONUS,
	}
	return funcs
end

function modifier_int_10:GetModifierBonusStats_Intellect()
	return 5
end