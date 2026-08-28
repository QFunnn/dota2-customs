--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 0b85d8d 
  ~ auto-generated — do not edit
]]


require("libraries/game_perks/perks/base_game_perk")

crit = class(base_game_perk)

function crit:DeclareFunctions()
	return { MODIFIER_PROPERTY_PREATTACK_CRITICALSTRIKE }
end
function crit:GetModifierPreAttack_CriticalStrike(params)
	if not IsServer() then
		return
	end

	if
		params.target ~= nil
		and params.attacker == self.parent
		and RollPseudoRandomPercentage(self.crit_chance, DOTA_PSEUDO_RANDOM_CUSTOM_GAME_1, self.parent) == true
	then
		return self.crit_multi
	end

	return 0
end