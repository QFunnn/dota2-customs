--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 0b85d8d 
  ~ auto-generated — do not edit
]]


modifier_attack_range_50 = class({})

function modifier_attack_range_50:IsHidden()
	return true
end

function modifier_attack_range_50:IsPurgable()
	return false
end

function modifier_attack_range_50:RemoveOnDeath()
	return false
end

function modifier_attack_range_50:GetAttributes()
	return MODIFIER_ATTRIBUTE_MULTIPLE
end

function modifier_attack_range_50:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_ATTACK_RANGE_BONUS,
	}
	return funcs
end

function modifier_attack_range_50:GetModifierAttackRangeBonus()
	return 25
end