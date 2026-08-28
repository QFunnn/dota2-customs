--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 0b85d8d 
  ~ auto-generated — do not edit
]]


modifier_armor_5 = class({})

function modifier_armor_5:IsHidden()
	return true
end

function modifier_armor_5:IsPurgable()
	return false
end

function modifier_armor_5:RemoveOnDeath()
	return false
end

function modifier_armor_5:GetAttributes()
	return MODIFIER_ATTRIBUTE_MULTIPLE
end

function modifier_armor_5:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_PHYSICAL_ARMOR_BONUS,
	}
	return funcs
end

function modifier_armor_5:GetModifierPhysicalArmorBonus()
	return 2
end