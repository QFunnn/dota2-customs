--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 0b85d8d 
  ~ auto-generated — do not edit
]]


require("libraries/game_perks/perks/base_game_perk")

bonus_agi = class(base_game_perk)

function bonus_agi:DeclareFunctions()
	return { MODIFIER_PROPERTY_STATS_AGILITY_BONUS }
end

function bonus_agi:GetModifierBonusStats_Agility()
	return self:CalculateValueByLevel(self.flat, self.level_step, self.per_level)
end