--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1a5b3bb 
  ~ auto-generated — do not edit
]]


modifier_neutral_creep = class(mod_hidden)
function modifier_neutral_creep:RemoveOnDeath()
	return false
end
function modifier_neutral_creep:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_SLOW_RESISTANCE_STACKING,
	}
end

function modifier_neutral_creep:GetModifierSlowResistance_Stacking()
	return 50
end