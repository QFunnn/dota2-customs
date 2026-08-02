--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build b9dc48c · 2026-08-02 17:42:46 UTC
  ~ auto-generated — do not edit
]]


require("libraries/game_perks/perks/base_game_perk")

magician = class(base_game_perk)

function magician:DeclareFunctions()
	return { MODIFIER_PROPERTY_AOE_BONUS_CONSTANT_STACKING }
end

function magician:GetModifierAoEBonusConstantStacking()
	return self.aoe_flat
end