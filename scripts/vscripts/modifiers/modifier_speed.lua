--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build b9dc48c · 2026-08-02 17:42:46 UTC
  ~ auto-generated — do not edit
]]


modifier_speed = class({})

function modifier_speed:IsHidden()
	return true
end

function modifier_speed:IsPurgable()
	return false
end

function modifier_speed:RemoveOnDeath()
	return false
end

function modifier_speed:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_MOVESPEED_BASE_OVERRIDE,
		MODIFIER_PROPERTY_MOVESPEED_ABSOLUTE,
		MODIFIER_PROPERTY_MOVESPEED_LIMIT,
		MODIFIER_PROPERTY_MOVESPEED_MAX,
		MODIFIER_PROPERTY_SPELL_AMPLIFY_PERCENTAGE,
	}
	return funcs
end

function modifier_speed:GetModifierMoveSpeedOverride()
	return 1000
end

function modifier_speed:GetModifierMoveSpeed_Limit()
	return 1000
end

function modifier_speed:GetModifierMoveSpeed_Max()
	return 1000
end

function modifier_speed:GetModifierMoveSpeed_Absolute()
	return 1000
end

function modifier_speed:GetModifierSpellAmplify_Percentage()
	return 1000
end