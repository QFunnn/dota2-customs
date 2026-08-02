--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build b9dc48c · 2026-08-02 17:42:46 UTC
  ~ auto-generated — do not edit
]]


modifier_mg_resist_5 = class({})

function modifier_mg_resist_5:IsHidden()
	return true
end

function modifier_mg_resist_5:IsPurgable()
	return false
end

function modifier_mg_resist_5:RemoveOnDeath()
	return false
end

function modifier_mg_resist_5:GetAttributes()
	return MODIFIER_ATTRIBUTE_MULTIPLE
end

function modifier_mg_resist_5:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_MAGICAL_RESISTANCE_BONUS,
	}
	return funcs
end

function modifier_mg_resist_5:GetModifierMagicalResistanceBonus()
	return 2
end