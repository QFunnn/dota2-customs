--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 0b85d8d 
  ~ auto-generated — do not edit
]]


modifier_str_10 = class({})

function modifier_str_10:IsHidden()
	return true
end

function modifier_str_10:IsPurgable()
	return false
end

function modifier_str_10:RemoveOnDeath()
	return false
end

function modifier_str_10:GetAttributes()
	return MODIFIER_ATTRIBUTE_MULTIPLE
end

function modifier_str_10:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_STATS_STRENGTH_BONUS,
	}
	return funcs
end

function modifier_str_10:GetModifierBonusStats_Strength()
	return 5
end