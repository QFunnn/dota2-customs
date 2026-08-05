--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 9d26fbd · 2026-08-05 05:42:45 UTC
  ~ auto-generated — do not edit
]]


modifier_mpr = class({})

function modifier_mpr:IsHidden()
	return true
end

function modifier_mpr:IsPurgable()
	return false
end

function modifier_mpr:RemoveOnDeath()
	return false
end

function modifier_mpr:GetAttributes()
	return MODIFIER_ATTRIBUTE_MULTIPLE
end

function modifier_mpr:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_MANA_REGEN_CONSTANT,
	}
	return funcs
end

function modifier_mpr:GetModifierConstantManaRegen()
	return self:GetStackCount() * 0.5
end