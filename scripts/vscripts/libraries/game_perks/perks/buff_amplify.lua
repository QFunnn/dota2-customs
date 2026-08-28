--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 0b85d8d 
  ~ auto-generated — do not edit
]]


require("libraries/game_perks/perks/base_game_perk")

buff_amplify = class(base_game_perk)

function buff_amplify:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_OVERRIDE_ABILITY_SPECIAL,
		MODIFIER_PROPERTY_OVERRIDE_ABILITY_SPECIAL_VALUE,
		MODIFIER_EVENT_ON_ABILITY_EXECUTED,
	}
end

function buff_amplify:OnAbilityExecuted(event)
	if event.unit ~= self.parent then
		return
	end

	event.ability.last_cast_target = event.target
end

function buff_amplify:GetModifierOverrideAbilitySpecial(keys)
	if not keys.ability or not keys.ability_special_value then
		return 0
	end

	local name = keys.ability:GetAbilityName()

	if
		self.kv_list[name] and self.kv_list[name][keys.ability_special_value]
		or self.special_cases[name] and self.special_cases[name][keys.ability_special_value]
	then
		return 1
	else
		return 0
	end
end

function buff_amplify:GetModifierOverrideAbilitySpecialValue(keys)
	local ability = keys.ability
	local special_value = keys.ability_special_value -- "example_kv_dynamic_base"
	local special_level = keys.ability_special_level -- Ability Level (0 indexed iirc)

	local base_value = keys.ability:GetLevelSpecialValueNoOverride(special_value, special_level)

	local name = keys.ability:GetAbilityName()

	-- special exception for abilities which can be cast on either team
	if self.special_cases[name] and self.special_cases[name][keys.ability_special_value] then
		if IsClient() then
			return base_value
		end
		if not self.parent.GetCursorCastTarget then
			return base_value
		end -- dont know why but this errors sometimes lol

		local target = self.parent:GetCursorCastTarget() or ability.last_cast_target

		if not target then
			return base_value
		end
		if target:GetTeamNumber() ~= self.team then
			return base_value
		end
	end

	return base_value * (self.multiplier or 1)
end

function buff_amplify:__OnCreated()
	self.team = self.parent:GetTeamNumber()
	self.multiplier = 1 + self.bonus_pct / 100
end

local kv_list = {
	abaddon_aphotic_shield = {
		duration = true,
	},
	abaddon_borrowed_time = {
		duration = true,
		duration_scepter = true,
	},
	alchemist_berserk_potion = {
		duration = true,
	},
	alchemist_chemical_rage = {
		duration = true,
	},
	axe_culling_blade = {
		speed_duration = true,
	},
	beastmaster_primal_roar = {
		movement_speed_duration = true,
	},
	brewmaster_primal_split = {
		duration = true,
	},
	centaur_stampede = {
		duration = true,
	},
	centaur_work_horse = {
		duration = true,
	},
	centaur_mount = {
		duration = true,
	},
	rattletrap_battery_assault = {
		duration = true,
	},
	rattletrap_jetpack = {
		duration = true,
	},
	rattletrap_overclocking = {
		buff_duration = true,
	},
	doom_bringer_scorched_earth = {
		duration = true,
	},
	dragon_knight_elder_dragon_form = {
		duration = true,
	},
	earthshaker_enchant_totem = {
		AbilityDuration = true,
	},
	elder_titan_ancestral_spirit = {
		buff_duration = true,
		scepter_magic_immune_per_hero = true,
	},
	wisp_overcharge = {
		duration = true,
	},
	kunkka_torrent_storm = {
		torrent_duration = true,
	},
	kunkka_ghostship = {
		buff_duration = true,
	},
	legion_commander_overwhelming_odds = {
		duration = true,
	},
	legion_commander_press_the_attack = {
		duration = true,
	},
	special_bonus_unique_legion_commander_8 = {
		value = true,
	},
	life_stealer_rage = {
		duration = true,
	},
	lycan_shapeshift = {
		duration = true,
		kill_duration_extension = true,
	},
	magnataur_empower = {
		empower_duration = true,
		self_multiplier_bonus_stack_duration = true,
	},
	magnataur_reverse_polarity = {
		stat_buff_duration = true,
	},
	special_bonus_unique_magnus_4 = {
		value = true,
	},
	night_stalker_crippling_fear = {
		duration_night = true,
		duration_day = true,
	},
	night_stalker_darkness = {
		duration = true,
	},
	omniknight_martyr = {
		duration = true,
	},
	omniknight_guardian_angel = {
		duration = true,
		duration_scepter = true,
	},
	phoenix_fire_spirit = {
		spirit_duration = true,
	},
	phoenix_sun_ray = {
		AbilityDuration = true,
	},
	sandking_sand_storm = {
		AbilityDuration = true,
	},
	slardar_sprint = {
		duration = true,
	},
	snapfire_lil_shredder = {
		buff_duration_tooltip = true,
		AbilityDuration = true,
	},
	spirit_breaker_bulldoze = {
		duration = true,
	},
	sven_warcry = {
		duration = true,
	},
	special_bonus_unique_sven_5 = {
		value = true,
	},
	sven_gods_strength = {
		AbilityDuration = true,
	},
	shredder_flamethrower = {
		duration = true,
	},
	shredder_reactive_armor = {
		stack_duration = true,
	},
	treant_living_armor = {
		duration = true,
	},
	tusk_tag_team = {
		debuff_duration = true,
	},
	undying_flesh_golem = {
		duration = true,
	},
	skeleton_king_vampiric_spirit = {
		duration = true,
	},
	marci_companion_run = {
		ally_buff_duration = true,
	},
	marci_guardian = {
		buff_duration = true,
	},
	marci_unleash = {
		extend_duration = true,
		duration = true,
	},
	special_bonus_unique_marci_guardian_magic_immune = {
		value = true,
	},
	primal_beast_trample = {
		duration = true,
	},
	primal_beast_uproar = {
		stack_duration = true,
		roar_duration = true,
	},
	antimage_counterspell = {
		duration = true,
	},
	bloodseeker_bloodrage = {
		duration = true,
	},
	bounty_hunter_wind_walk = {
		duration = true,
	},
	broodmother_insatiable_hunger = {
		duration = true,
	},
	clinkz_wind_walk = {
		duration = true,
	},
	ember_spirit_flame_guard = {
		duration = true,
	},
	gyrocopter_rocket_barrage = {
		barrage_duration = true,
	},
	gyrocopter_flak_cannon = {
		AbilityDuration = true,
	},
	hoodwink_scurry = {
		duration = true,
	},
	juggernaut_blade_fury = {
		duration = true,
	},
	lone_druid_true_form = {
		duration = true,
	},
	lone_druid_savage_roar = {
		shard_duration = true,
	},
	medusa_stone_gaze = {
		duration = true,
	},
	meepo_petrify = {
		duration = true,
	},
	mirana_leap = {
		leap_bonus_duration = true,
	},
	mirana_invis = {
		duration = true,
	},
	mirana_solar_flare = {
		duration = true,
	},
	monkey_king_jingu_mastery = {
		max_duration = true,
	},
	naga_siren_song_of_the_siren = {
		duration = true,
	},
	nyx_assassin_vendetta = {
		duration = true,
	},
	nyx_assassin_spiked_carapace = {
		reflect_duration = true,
	},
	pangolier_rollup = {
		duration = true,
		rollup_bounce_duration = true,
	},
	pangolier_gyroshell = {
		duration = true,
	},
	special_bonus_unique_pangolier_6 = {
		value = true,
	},
	phantom_assassin_blur = {
		duration = true,
	},
	phantom_assassin_phantom_strike = {
		duration = true,
	},
	phantom_lancer_phantom_edge = {
		agility_duration = true,
	},
	razor_eye_of_the_storm = {
		duration = true,
	},
	slark_shadow_dance = {
		duration = true,
	},
	slark_depth_shroud = {
		duration = true,
	},
	sniper_take_aim = {
		duration = true,
	},
	special_bonus_unique_sniper_4 = {
		value = true,
	},
	templar_assassin_refraction = {
		duration = true,
	},
	terrorblade_metamorphosis = {
		duration = true,
	},
	special_bonus_unique_terrorblade_3 = {
		value = true,
	},
	terrorblade_demon_zeal = {
		duration = true,
	},
	troll_warlord_battle_trance = {
		trance_duration = true,
	},
	troll_warlord_rampage = {
		duration = true,
	},
	ursa_enrage = {
		duration = true,
	},
	ursa_overpower = {
		AbilityDuration = true,
	},
	ursa_earthshock = {
		shard_enrage_duration = true,
	},
	weaver_shukuchi = {
		duration = true,
	},
	weaver_rewoven = {
		duration = true,
	},
	batrider_firefly = {
		duration = true,
	},
	dark_seer_ion_shell = {
		duration = true,
	},
	dark_seer_surge = {
		duration = true,
	},
	dark_willow_bedlam = {
		roaming_duration = true,
	},
	dazzle_shallow_grave = {
		duration = true,
	},
	death_prophet_exorcism = {
		AbilityDuration = true,
	},
	enchantress_natures_attendants = {
		AbilityDuration = true,
	},
	grimstroke_spirit_walk = {
		buff_duration = true,
	},
	invoker_ghost_walk = {
		duration = true,
	},
	invoker_alacrity = {
		duration = true,
	},
	keeper_of_the_light_spirit_form = {
		duration = true,
	},
	special_bonus_unique_keeper_of_the_light_11 = {
		value = true,
	},
	leshrac_diabolic_edict = {
		AbilityDuration = true,
		num_explosions = true,
	},
	special_bonus_unique_leshrac_1 = {
		value = true,
	},
	leshrac_greater_lightning_storm = {
		duration = true,
	},
	lich_frost_shield = {
		duration = true,
	},
	lion_finger_of_death = {
		punch_duration = true,
	},
	necrolyte_heartstopper_aura = {
		regen_duration = true,
	},
	ogre_magi_bloodlust = {
		duration = true,
	},
	oracle_false_promise = {
		duration = true,
	},
	rubick_spell_steal = {
		duration = true,
	},
	shadow_demon_demonic_cleanse = {
		AbilityDuration = true,
	},
	storm_spirit_overload = {
		shard_activation_duration = true,
	},
	tinker_defense_matrix = {
		barrier_duration = true,
	},
	visage_silent_as_the_grave = {
		invis_duration = true,
		bonus_duration = true,
	},
	void_spirit_resonant_pulse = {
		buff_duration = true,
	},
	windrunner_windrun = {
		AbilityDuration = true,
	},
	windrunner_focusfire = {
		AbilityDuration = true,
	},
	winter_wyvern_arctic_burn = {
		duration = true,
	},
	winter_wyvern_cold_embrace = {
		duration = true,
	},
	necrolyte_sadist = {
		regen_duration = true,
	},
	lone_druid_spirit_link = {
		duration = true,
	},
	kez_falcon_rush = {
		duration = true,
	},
	kez_ravens_veil = {
		buff_duration = true,
	},
	item_black_king_bar = {
		duration = false,
	},
	item_clarity = {
		buff_duration = true,
	},
	item_tango = {
		buff_duration = true,
	},
	item_smoke_of_deceit = {
		duration = true,
	},
	item_flask = {
		buff_duration = true,
	},
	item_ghost = {
		duration = true,
	},
	item_soul_ring = {
		duration = true,
	},
	item_phase_boots = {
		phase_duration = true,
	},
	item_mask_of_madness = {
		berserk_duration = true,
	},
	item_ancient_janggo = {
		duration = true,
	},
	item_pipe = {
		barrier_duration = true,
	},
	item_glimmer_cape = {
		duration = true,
	},
	item_eternal_shroud = {
		stack_duration = true,
	},
	item_hood_of_defiance = {
		barrier_duration = true,
	},
	item_blade_mail = {
		duration = true,
	},
	item_aeon_disk = {
		buff_duration = true,
	},
	item_crimson_guard = {
		duration = true,
	},
	item_lotus_orb = {
		active_duration = true,
	},
	item_hurricane_pike = {
		range_duration = true,
	},
	item_bloodstone = {
		buff_duration = true,
	},
	item_silver_edge = {
		windwalk_duration = true,
	},
	item_invis_sword = {
		windwalk_duration = true,
	},
	item_satanic = {
		unholy_duration = true,
	},
	item_mjollnir = {
		static_duration = true,
	},
	item_swift_blink = {
		duration = true,
	},
	item_arcane_blink = {
		duration = true,
	},
	item_essence_ring = {
		health_gain_duration = true,
	},
	item_spider_legs = {
		duration = true,
	},
	item_minotaur_horn = {
		duration = true,
	},
	item_trickster_cloak = {
		duration = true,
	},
	item_woodland_striders = {
		active_duration = true,
	},
	item_unstable_wand = {
		duration = true,
	},
	item_mana_draught = {
		heal_duration = true,
	},
	item_polliwog_charm = {
		duration = true,
	},
	item_gale_guard = {
		barrier_duration = true,
	},
	item_ninja_gear = {
		duration = true,
	},
	item_boots_of_bearing = {
		duration = true,
	},
	bristleback_warpath = {
		stack_duration = true,
	},
	abyssal_underlord_atrophy_aura = {
		bonus_damage_duration = true,
	},
	furion_wrath_of_nature = {
		kill_damage_duration = true,
	},
	silencer_glaives_of_wisdom = {
		int_steal_duration = true,
	},
	skywrath_mage_shield_of_the_scion = {
		stack_duration = true,
		barrier_duration = true,
	},
	centaur_double_edge = {
		shard_str_duration = true,
	},
	pangolier_shield_crash = {
		duration = true,
	},
	clinkz_death_pact = {
		duration = true,
	},
	morphling_replicate = {
		duration = true,
	},
	item_bottle = {
		restore_time = true,
		health_restore = true,
		mana_restore = true,
		rune_expire_time = true,
	},
	lina_fiery_soul = {
		fiery_soul_stack_duration = true,
	},
	lina_flame_cloak = {
		flame_cloak_duration = true,
	},
	lina_laguna_blade = {
		supercharge_duration = true,
		barrier_duration = true,
	},
	pudge_flesh_heap = {
		duration = true,
	},
	item_ethereal_blade = {
		duration_ally = true,
	},
	muerta_pierce_the_veil = {
		duration = true,
	},
	item_ascetic_cap = {
		duration = true,
	},
	juggernaut_omni_slash = {
		duration = true,
	},
	juggernaut_swift_slash = {
		duration = true,
	},
	clinkz_strafe = {
		duration = true,
	},
	item_royal_jelly = {
		regen_duration = true,
	},
	item_craggy_coat = {
		active_duration = true,
	},
	item_disperser = {
		ally_effect_duration = true,
	},
	life_stealer_unfettered = {
		duration = true,
	},
	tusk_drinking_buddies = {
		buff_duration = true,
	},
	undying_soul_rip = {
		strength_share_duration = true,
	},
	void_spirit_symmetry = {
		buff_duration = true,
	},
	beastmaster_inner_beast = {
		berserk_duration = true,
	},
	crystal_maiden_brilliance_aura = {
		activation_duration = true,
	},
	luna_lunar_orbit = {
		rotating_glaives_duration = true,
	},
	spirit_breaker_planar_pocket = {
		duration = true,
	},
	tidehunter_kraken_shell = {
		active_duration = true,
	},
	largo_song_fight_song = {
		battle_burst_duration = true,
	},
	largo_song_double_time = {
		movement_burst_duration = true,
	},
	largo_croak_of_genius = {
		duration = true,
	},
	nevermore_frenzy = {
		duration = true,
	},
}

local special_cases = {
	earth_spirit_petrify = {
		duration = true,
	},
	necrolyte_death_seeker = {
		ethereal_duration = true,
	},
	oracle_purifying_flames = {
		duration = true,
		total_heal_tooltip = true,
	},
	oracle_fates_edict = {
		duration = true,
	},
	obsidian_destroyer_astral_imprisonment = {
		prison_duration = true,
	},
	pugna_decrepify = {
		AbilityDuration = true,
	},
	shadow_demon_disruption = {
		AbilityDuration = true,
	},
	shadow_demon_disseminate = {
		duration = true,
	},
	warlock_shadow_word = {
		duration = true,
	},
	techies_reactive_tazer = {
		duration = true,
	},
	item_urn_of_shadows = {
		soul_heal_amount = true,
	},
	item_medallion_of_courage = {
		duration = true,
	},
	item_spirit_vessel = {
		soul_heal_amount = true,
	},
	item_cyclone = {
		cyclone_duration = true,
	},
	item_solar_crest = {
		duration = true,
	},
	item_wind_waker = {
		cyclone_duration = true,
	},
	item_bullwhip = {
		duration = true,
	},
	item_book_of_shadows = {
		duration = true,
	},
}

--[[
maybe some day:

razor_static_link = {
	drain_duration = true
},
visage_grave_chill = {
	chill_duration = true
},
undying_decay = {
	decay_duration = true
},
slark_essence_shift = {
	duration = true
},
special_bonus_unique_timbersaw_2 = {
	value = true
},
--]]

buff_amplify.kv_list = kv_list
buff_amplify.special_cases = special_cases