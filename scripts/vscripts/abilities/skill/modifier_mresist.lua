--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build b9dc48c · 2026-08-02 17:42:46 UTC
  ~ auto-generated — do not edit
]]


modifier_mresist = class({})

function modifier_mresist:IsHidden()
	return true
end

function modifier_mresist:IsPurgable()
	return false
end

function modifier_mresist:RemoveOnDeath()
	return false
end

function modifier_mresist:GetAttributes()
	return MODIFIER_ATTRIBUTE_MULTIPLE
end

function modifier_mresist:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_MAGICAL_RESISTANCE_BONUS,
	}
	return funcs
end

function modifier_mresist:GetModifierMagicalResistanceBonus()
	return 0.5 * self:GetStackCount()
end