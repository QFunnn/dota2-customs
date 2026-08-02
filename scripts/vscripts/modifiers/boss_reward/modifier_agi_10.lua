--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build b9dc48c · 2026-08-02 17:42:46 UTC
  ~ auto-generated — do not edit
]]


modifier_agi_10 = class({})

function modifier_agi_10:IsHidden()
	return true
end

function modifier_agi_10:IsPurgable()
	return false
end

function modifier_agi_10:RemoveOnDeath()
	return false
end

function modifier_agi_10:GetAttributes()
	return MODIFIER_ATTRIBUTE_MULTIPLE
end

function modifier_agi_10:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_STATS_AGILITY_BONUS,
	}
	return funcs
end

function modifier_agi_10:GetModifierBonusStats_Agility()
	return 5
end