--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 0b85d8d 
  ~ auto-generated — do not edit
]]


require("libraries/game_perks/perks/base_game_perk")

cooldown_reduction = class(base_game_perk)

local exceptions = {}
function cooldown_reduction:DeclareFunctions()
	return { MODIFIER_PROPERTY_COOLDOWN_PERCENTAGE }
end

function cooldown_reduction:GetModifierPercentageCooldown(params)
	if not params.ability then
		return
	end

	if not exceptions[params.ability:GetAbilityName()] then
		return self.cdr
	end
end