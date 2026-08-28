--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 0b85d8d 
  ~ auto-generated — do not edit
]]


modifier_damage_40 = class({})

function modifier_damage_40:IsHidden()
	return true
end

function modifier_damage_40:IsPurgable()
	return false
end

function modifier_damage_40:RemoveOnDeath()
	return false
end

function modifier_damage_40:GetAttributes()
	return MODIFIER_ATTRIBUTE_MULTIPLE
end

function modifier_damage_40:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_PREATTACK_BONUS_DAMAGE,
	}
	return funcs
end

function modifier_damage_40:GetModifierPreAttack_BonusDamage()
	return 20
end