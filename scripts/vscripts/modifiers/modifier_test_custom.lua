--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 0b85d8d 
  ~ auto-generated — do not edit
]]


modifier_test_custom = class({})

function modifier_test_custom:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_SLOW_RESISTANCE_UNIQUE,
	}
end

function modifier_test_custom:GEtModifierSlowResistance_Unique()
	return 100
end