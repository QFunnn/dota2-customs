--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 0b85d8d 
  ~ auto-generated — do not edit
]]


require("libraries/game_perks/perks/base_game_perk")

bonus_movespeed = class(base_game_perk)

function bonus_movespeed:DeclareFunctions()
	return { MODIFIER_PROPERTY_MOVESPEED_BONUS_CONSTANT }
end
function bonus_movespeed:GetModifierMoveSpeedBonus_Constant()
	return self.bonus_ms
end