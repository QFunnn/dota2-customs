--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 0b85d8d 
  ~ auto-generated — do not edit
]]


require("libraries/game_perks/perks/base_game_perk")

attack_range = class(base_game_perk)

function attack_range:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_ATTACK_RANGE_BONUS,
		MODIFIER_PROPERTY_CAST_RANGE_BONUS_STACKING,
	}
end

function attack_range:GetModifierCastRangeBonusStacking(event)
	if
		event.ability
		and IsBitSet(event.ability:GetBehaviorInt(), DOTA_ABILITY_BEHAVIOR_UNIT_TARGET, DOTA_ABILITY_BEHAVIOR_AUTOCAST)
	then
		return self:GetModifierAttackRangeBonus()
	end
end

function attack_range:GetModifierAttackRangeBonus()
	if self.parent:IsRangedAttacker() then
		return self.range_bonus
	else
		return self.melee_bonus
	end
end