--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 9d26fbd · 2026-08-05 05:42:45 UTC
  ~ auto-generated — do not edit
]]


modifier_spell_10 = class({})

function modifier_spell_10:IsHidden()
	return true
end

function modifier_spell_10:IsPurgable()
	return false
end

function modifier_spell_10:RemoveOnDeath()
	return false
end

function modifier_spell_10:GetAttributes()
	return MODIFIER_ATTRIBUTE_MULTIPLE
end

function modifier_spell_10:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_SPELL_AMPLIFY_PERCENTAGE,
	}
	return funcs
end

function modifier_spell_10:GetModifierSpellAmplify_Percentage()
	return 4
end