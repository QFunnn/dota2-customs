--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 0b85d8d 
  ~ auto-generated — do not edit
]]


require("libraries/game_perks/perks/base_game_perk")

slow_resistance = class(base_game_perk)

function slow_resistance:DeclareFunctions()
	return { MODIFIER_PROPERTY_SLOW_RESISTANCE_STACKING }
end
function slow_resistance:GetModifierSlowResistance_Stacking()
	return self.slow_resistance
end