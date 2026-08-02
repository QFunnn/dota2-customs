--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build b9dc48c · 2026-08-02 17:42:46 UTC
  ~ auto-generated — do not edit
]]


require("libraries/game_perks/perks/base_game_perk")

debuff_time = class(base_game_perk)

function debuff_time:DeclareFunctions()
	return { MODIFIER_PROPERTY_STATUS_RESISTANCE_CASTER }
end
function debuff_time:GetModifierStatusResistanceCaster()
	return -self.debuff_amp
end