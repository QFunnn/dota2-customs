--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 0b85d8d 
  ~ auto-generated — do not edit
]]


modifier_evasion_10 = class({})

function modifier_evasion_10:IsHidden()
	return true
end

function modifier_evasion_10:IsPurgable()
	return false
end

function modifier_evasion_10:RemoveOnDeath()
	return false
end

function modifier_evasion_10:GetAttributes()
	return MODIFIER_ATTRIBUTE_MULTIPLE
end

function modifier_evasion_10:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_EVASION_CONSTANT,
	}
	return funcs
end

function modifier_evasion_10:GetModifierEvasion_Constant()
	return 5
end