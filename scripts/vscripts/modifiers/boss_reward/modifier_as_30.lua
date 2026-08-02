--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build b9dc48c · 2026-08-02 17:42:46 UTC
  ~ auto-generated — do not edit
]]


modifier_as_30 = class({})

function modifier_as_30:IsHidden()
	return true
end

function modifier_as_30:IsPurgable()
	return false
end

function modifier_as_30:RemoveOnDeath()
	return false
end

function modifier_as_30:GetAttributes()
	return MODIFIER_ATTRIBUTE_MULTIPLE
end

function modifier_as_30:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_ATTACKSPEED_BONUS_CONSTANT,
	}
	return funcs
end

function modifier_as_30:GetModifierAttackSpeedBonus_Constant()
	return 15
end