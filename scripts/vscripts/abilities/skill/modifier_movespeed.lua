--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 9d26fbd · 2026-08-05 05:42:45 UTC
  ~ auto-generated — do not edit
]]


modifier_movespeed = class({})

function modifier_movespeed:IsHidden()
	return true
end

function modifier_movespeed:IsPurgable()
	return false
end

function modifier_movespeed:RemoveOnDeath()
	return false
end

function modifier_movespeed:GetAttributes()
	return MODIFIER_ATTRIBUTE_MULTIPLE
end

function modifier_movespeed:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_MOVESPEED_BONUS_CONSTANT,
	}
	return funcs
end

function modifier_movespeed:GetModifierMoveSpeedBonus_Constant()
	return 3 * self:GetStackCount()
end