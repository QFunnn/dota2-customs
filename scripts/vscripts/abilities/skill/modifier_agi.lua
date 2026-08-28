--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 0b85d8d 
  ~ auto-generated — do not edit
]]


modifier_agi = class({})

function modifier_agi:IsHidden()
	return true
end

function modifier_agi:IsPurgable()
	return false
end

function modifier_agi:RemoveOnDeath()
	return false
end

function modifier_agi:GetAttributes()
	return MODIFIER_ATTRIBUTE_MULTIPLE
end

function modifier_agi:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_STATS_AGILITY_BONUS,
	}
	return funcs
end

function modifier_agi:GetModifierBonusStats_Agility()
	return self:GetStackCount()
end