--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 0b85d8d 
  ~ auto-generated — do not edit
]]


modifier_evasion = class({})

function modifier_evasion:IsHidden()
	return true
end

function modifier_evasion:IsPurgable()
	return false
end

function modifier_evasion:RemoveOnDeath()
	return false
end

function modifier_evasion:GetAttributes()
	return MODIFIER_ATTRIBUTE_MULTIPLE
end

function modifier_evasion:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_EVASION_CONSTANT,
	}
	return funcs
end

function modifier_evasion:GetModifierEvasion_Constant()
	return self:GetStackCount()
end