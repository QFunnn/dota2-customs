--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 0b85d8d 
  ~ auto-generated — do not edit
]]


require("libraries/game_perks/perks/base_game_perk")

jungler = class(base_game_perk)

function jungler:DeclareFunctions()
	return { MODIFIER_PROPERTY_TOTALDAMAGEOUTGOING_PERCENTAGE }
end

function jungler:GetModifierTotalDamageOutgoing_Percentage(params)
	if not IsValidEntity(params.target) or not params.target:IsAlive() then
		return
	end
	if self.parent:GetTeam() == params.target:GetTeam() or not params.target:IsNeutralUnitType() then
		return
	end

	if
		bit.band(params.damage_flags, DOTA_DAMAGE_FLAG_NO_DAMAGE_MULTIPLIERS) == DOTA_DAMAGE_FLAG_NO_DAMAGE_MULTIPLIERS
	then
		return
	end

	return self.neutral_creeps_dmg_pct
end