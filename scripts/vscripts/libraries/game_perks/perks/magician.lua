--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 0b85d8d 
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