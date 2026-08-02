--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build b9dc48c · 2026-08-02 17:42:46 UTC
  ~ auto-generated — do not edit
]]


require("libraries/game_perks/perks/base_game_perk")

spell_amp = class(base_game_perk)

function spell_amp:DeclareFunctions()
	return { MODIFIER_PROPERTY_SPELL_AMPLIFY_PERCENTAGE }
end
function spell_amp:GetModifierSpellAmplify_Percentage()
	return self.spell_amp
end