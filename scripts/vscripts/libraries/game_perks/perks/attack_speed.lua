--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 0b85d8d 
  ~ auto-generated — do not edit
]]


require("libraries/game_perks/perks/base_game_perk")

attack_speed = class(base_game_perk)

function attack_speed:DeclareFunctions()
	return { MODIFIER_PROPERTY_ATTACKSPEED_BONUS_CONSTANT }
end
function attack_speed:GetModifierAttackSpeedBonus_Constant()
	return self:CalculateValueByLevel(self.flat, self.level_step, self.per_level)
end