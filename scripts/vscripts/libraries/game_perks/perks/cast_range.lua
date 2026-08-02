--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build b9dc48c · 2026-08-02 17:42:46 UTC
  ~ auto-generated — do not edit
]]


require("libraries/game_perks/perks/base_game_perk")

cast_range = class(base_game_perk)

cast_range.ability_exceptions = {
	drow_ranger_frost_arrows = true,
	huskar_burning_spear = true,
	viper_poison_attack = true,
	ancient_apparition_chilling_touch = true,
	clinkz_searing_arrows = true,
	enchantress_impetus = true,
}

function cast_range:DeclareFunctions()
	return { MODIFIER_PROPERTY_CAST_RANGE_BONUS_STACKING }
end
function cast_range:GetModifierCastRangeBonusStacking(keys)
	if IsValidEntity(keys.ability) and self.ability_exceptions[keys.ability:GetAbilityName()] then
		return
	end
	return self.bonus_cast_range
end