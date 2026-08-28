--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 0b85d8d 
  ~ auto-generated — do not edit
]]


require("libraries/game_perks/perks/base_game_perk")

bonus_int = class(base_game_perk)

function bonus_int:DeclareFunctions()
	return { MODIFIER_PROPERTY_STATS_INTELLECT_BONUS }
end

function bonus_int:GetModifierBonusStats_Intellect()
	return self:CalculateValueByLevel(self.flat, self.level_step, self.per_level)
end