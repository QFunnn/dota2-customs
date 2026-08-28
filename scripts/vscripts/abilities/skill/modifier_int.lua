--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 0b85d8d 
  ~ auto-generated — do not edit
]]


modifier_int = class({})

function modifier_int:IsHidden()
	return true
end

function modifier_int:IsPurgable()
	return false
end

function modifier_int:RemoveOnDeath()
	return false
end

function modifier_int:GetAttributes()
	return MODIFIER_ATTRIBUTE_MULTIPLE
end

function modifier_int:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_STATS_INTELLECT_BONUS,
	}
	return funcs
end

function modifier_int:GetModifierBonusStats_Intellect()
	return self:GetStackCount()
end