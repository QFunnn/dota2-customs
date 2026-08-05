--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 9d26fbd · 2026-08-05 05:42:45 UTC
  ~ auto-generated — do not edit
]]


modifier_spellamp = class({})

function modifier_spellamp:IsHidden()
	return true
end

function modifier_spellamp:IsPurgable()
	return false
end

function modifier_spellamp:RemoveOnDeath()
	return false
end

function modifier_spellamp:GetAttributes()
	return MODIFIER_ATTRIBUTE_MULTIPLE
end

function modifier_spellamp:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_SPELL_AMPLIFY_PERCENTAGE,
	}
	return funcs
end

function modifier_spellamp:GetModifierSpellAmplify_Percentage()
	return self:GetStackCount() * 0.5
end