--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build b9dc48c · 2026-08-02 17:42:46 UTC
  ~ auto-generated — do not edit
]]


modifier_damage = class({})

function modifier_damage:IsHidden()
	return true
end

function modifier_damage:IsPurgable()
	return false
end

function modifier_damage:RemoveOnDeath()
	return false
end

function modifier_damage:GetAttributes()
	return MODIFIER_ATTRIBUTE_MULTIPLE
end

function modifier_damage:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_PREATTACK_BONUS_DAMAGE,
	}
	return funcs
end

function modifier_damage:GetModifierPreAttack_BonusDamage()
	return 3 * self:GetStackCount()
end