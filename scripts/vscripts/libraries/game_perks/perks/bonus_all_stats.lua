--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 0b85d8d 
  ~ auto-generated — do not edit
]]


require("libraries/game_perks/perks/base_game_perk")

bonus_all_stats = class(base_game_perk)

function bonus_all_stats:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_STATS_AGILITY_BONUS,
		MODIFIER_PROPERTY_STATS_INTELLECT_BONUS,
		MODIFIER_PROPERTY_STATS_STRENGTH_BONUS,
	}
end

function bonus_all_stats:GetModifierBonusStats_Agility()
	return self:CalculateValueByLevel(self.flat, self.level_step, self.per_level)
end
function bonus_all_stats:GetModifierBonusStats_Intellect()
	return self:CalculateValueByLevel(self.flat, self.level_step, self.per_level)
end
function bonus_all_stats:GetModifierBonusStats_Strength()
	return self:CalculateValueByLevel(self.flat, self.level_step, self.per_level)
end