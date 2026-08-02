--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build b9dc48c · 2026-08-02 17:42:46 UTC
  ~ auto-generated — do not edit
]]


modifier_cd_5 = class({})

function modifier_cd_5:IsHidden()
	return true
end

function modifier_cd_5:IsPurgable()
	return false
end

function modifier_cd_5:RemoveOnDeath()
	return false
end

function modifier_cd_5:GetAttributes()
	return MODIFIER_ATTRIBUTE_MULTIPLE
end

function modifier_cd_5:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_COOLDOWN_PERCENTAGE,
	}
	return funcs
end

function modifier_cd_5:GetModifierPercentageCooldown()
	return 2
end