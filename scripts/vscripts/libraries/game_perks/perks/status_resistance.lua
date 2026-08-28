--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 0b85d8d 
  ~ auto-generated — do not edit
]]


require("libraries/game_perks/perks/base_game_perk")

status_resistance = class(base_game_perk)

function status_resistance:DeclareFunctions()
	return { MODIFIER_PROPERTY_STATUS_RESISTANCE_STACKING }
end
function status_resistance:GetModifierStatusResistanceStacking()
	return self.status_res
end