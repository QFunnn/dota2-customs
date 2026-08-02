--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build b9dc48c · 2026-08-02 17:42:46 UTC
  ~ auto-generated — do not edit
]]


require("libraries/game_perks/perks/base_game_perk")

mag_resist = class(base_game_perk)

function mag_resist:DeclareFunctions()
	return { MODIFIER_PROPERTY_MAGICAL_RESISTANCE_BONUS }
end
function mag_resist:GetModifierMagicalResistanceBonus()
	return self.resist
end