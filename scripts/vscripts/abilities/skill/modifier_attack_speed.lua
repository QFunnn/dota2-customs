--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build b9dc48c · 2026-08-02 17:42:46 UTC
  ~ auto-generated — do not edit
]]


modifier_attack_speed = class({})

function modifier_attack_speed:IsHidden()
	return true
end

function modifier_attack_speed:IsPurgable()
	return false
end

function modifier_attack_speed:RemoveOnDeath()
	return false
end

function modifier_attack_speed:GetAttributes()
	return MODIFIER_ATTRIBUTE_MULTIPLE
end

function modifier_attack_speed:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_ATTACKSPEED_BONUS_CONSTANT,
	}
	return funcs
end

function modifier_attack_speed:GetModifierAttackSpeedBonus_Constant()
	return 2 * self:GetStackCount()
end