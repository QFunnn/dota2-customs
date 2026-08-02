--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build b9dc48c · 2026-08-02 17:42:46 UTC
  ~ auto-generated — do not edit
]]


require("libraries/game_perks/perks/base_game_perk")

magician = class(base_game_perk)

function magician:__OnCreated()
	self.aoe_multiplier = 1 + self.aoe_pct / 100
end

local aoe_keywords = {
	aoe = true,
	area_of_effect = true,
	radius = true,
}

local other_keywords = {
	scepter_range = true,
	arrow_range_multiplier = true,
	wave_width = true,
	agility_range = true,
	aftershock_range = true,
	echo_slam_damage_range = true,
	echo_slam_echo_search_range = true,
	echo_slam_echo_range = true,
	torrent_max_distance = true,
	cleave_ending_width = true,
	cleave_distance = true,
	ghostship_width = true,
	dragon_slave_distance = true,
	dragon_slave_width_initial = true,
	dragon_slave_width_end = true,
	width = true,
	requiem_line_width_start = true,
	requiem_line_width_end = true,
	orb_vision = true,
	hook_distance = true,
	flesh_heap_range = true,
	hook_width = true,
	end_distance = true,
	burrow_width = true,
	splash_width = true,
	splash_range = true,
	arrow_width = true,
	jump_range = true,
	bounce_range = true,
	attack_spill_range = true,
	attack_spill_width = true,
	range = true,
	metamorph_aura_tooltip = true,
}

local other_key_by_abilities = {
	range = {
		terrorblade_reflection = true,
		magnataur_skewer = false,
	},
	speed = {
		razor_plasma_field = true,
	},
	radius = {
		furion_curse_of_the_forest = true,
	},
	max_range = {
		wisp_spirits = true,
	},
}

local ignore_keywords = {
	visibility_radius = true, -- smoke of deceit
	placement_radius = true, -- proximity mines
}

local ignore_abilities = {
	phantom_assassin_blur = true,
	spectre_desolate = true,
	slark_barracuda = true,
}

local ignore_abilities_specials = {
	faceless_void_time_walk = {
		range = true,
	},
	ember_spirit_fire_remnant = {
		scepter_range = true,
	},
}

local affected_talents = {
	special_bonus_unique_dark_seer_3 = true,
}

function magician:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_OVERRIDE_ABILITY_SPECIAL,
		MODIFIER_PROPERTY_OVERRIDE_ABILITY_SPECIAL_VALUE,
	}
end

function magician:CheckAbilitySpecial(ability_name, ability_special)
	if ignore_abilities_specials[ability_name] and ignore_abilities_specials[ability_name][ability_special] then
		return false
	end

	for keyword, _ in pairs(aoe_keywords) do
		if string.find(ability_special, keyword) and not ignore_keywords[ability_special] then
			return true
		end
	end

	if
		ability_name
		and other_key_by_abilities[ability_special]
		and other_key_by_abilities[ability_special][ability_name] ~= nil
	then
		return other_key_by_abilities[ability_special][ability_name]
	end

	if other_keywords[ability_special] then
		return true
	end

	return false
end

function magician:GetModifierOverrideAbilitySpecial(keys)
	if (not keys.ability) or not keys.ability_special_value or not aoe_keywords then
		return 0
	end

	local ability_name = keys.ability:GetAbilityName()

	if affected_talents[ability_name] then
		return 1
	end

	if ignore_abilities[ability_name] then
		return
	end

	local check = self:CheckAbilitySpecial(ability_name, keys.ability_special_value)

	if check then
		return 1
	end

	return 0
end

function magician:GetModifierOverrideAbilitySpecialValue(keys)
	local value = keys.ability:GetLevelSpecialValueNoOverride(keys.ability_special_value, keys.ability_special_level)
	local ability_name = keys.ability.GetAbilityName and keys.ability:GetAbilityName()

	if affected_talents[ability_name] then
		return value * (self.aoe_multiplier or 1)
	end

	local check = self:CheckAbilitySpecial(ability_name, keys.ability_special_value)

	if check then
		return value * (self.aoe_multiplier or 1)
	end

	return value
end