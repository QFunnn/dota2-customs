--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]



SUMMON_TO_ABILITY_MAP = {
	npc_dota_lycan_wolf1 = {
		ability = "lycan_summon_wolves",
		health = "wolf_hp",
		damage = "wolf_damage",
	},
	npc_dota_lycan_wolf2 = {
		ability = "lycan_summon_wolves",
		health = "wolf_hp",
		damage = "wolf_damage",
	},
	npc_dota_lycan_wolf3 = {
		ability = "lycan_summon_wolves",
		health = "wolf_hp",
		damage = "wolf_damage",
	},
	npc_dota_lycan_wolf4 = {
		ability = "lycan_summon_wolves",
		health = "wolf_hp",
		damage = "wolf_damage",
	},
	npc_dota_lycan_wolf5 = {
		ability = "lycan_summon_wolves",
		health = "wolf_hp",
		damage = "wolf_damage",
	},
	npc_dota_lycan_wolf6 = {
		ability = "lycan_summon_wolves",
		health = "wolf_hp",
		damage = "wolf_damage",
	},

	npc_dota_beastmaster_hawk = {
		ability = "beastmaster_call_of_the_wild_hawk",
		health = "hawk_base_max_health",
		ability_upgrades = true,
	},
	npc_dota_beastmaster_hawk_1 = {
		ability = "beastmaster_call_of_the_wild_hawk",
		health = "hawk_base_max_health",
		ability_upgrades = true,
	},
	npc_dota_beastmaster_hawk_2 = {
		ability = "beastmaster_call_of_the_wild_hawk",
		health = "hawk_base_max_health",
		ability_upgrades = true,
	},
	npc_dota_beastmaster_hawk_3 = {
		ability = "beastmaster_call_of_the_wild_hawk",
		health = "hawk_base_max_health",
		ability_upgrades = true,
	},
	npc_dota_beastmaster_hawk_4 = {
		ability = "beastmaster_call_of_the_wild_hawk",
		health = "hawk_base_max_health",
		ability_upgrades = true,
	},

	npc_dota_beastmaster_boar = {
		ability = "beastmaster_call_of_the_wild_boar",
		health = "boar_base_max_health",
		damage = "boar_base_damage"
	},
	npc_dota_beastmaster_boar_1 = {
		ability = "beastmaster_call_of_the_wild_boar",
		health = "boar_base_max_health",
		damage = "boar_base_damage"
	},
	npc_dota_beastmaster_boar_2 = {
		ability = "beastmaster_call_of_the_wild_boar",
		health = "boar_base_max_health",
		damage = "boar_base_damage"
	},
	npc_dota_beastmaster_boar_3 = {
		ability = "beastmaster_call_of_the_wild_boar",
		health = "boar_base_max_health",
		damage = "boar_base_damage"
	},
	npc_dota_beastmaster_boar_4 = {
		ability = "beastmaster_call_of_the_wild_boar",
		health = "boar_base_max_health",
		damage = "boar_base_damage"
	},
	npc_dota_beastmaster_greater_boar = {
		ability = "beastmaster_call_of_the_wild_boar",
		health = "boar_hp_tooltip",
		damage = "boar_damage_tooltip"
	},

	--[[
		-- deprecated
		-- done in furion_sprout_custom and furion_force_of_nature_custom
		npc_dota_furion_treant_1 = {
			ability = "furion_force_of_nature",
			health = "treant_health_tooltip",
			damage = "treant_dmg_tooltip",
		},
		npc_dota_furion_treant_2 = {
			ability = "furion_force_of_nature",
			health = "treant_health_tooltip",
			damage = "treant_dmg_tooltip",
		},
		npc_dota_furion_treant_3 = {
			ability = "furion_force_of_nature",
			health = "treant_health_tooltip",
			damage = "treant_dmg_tooltip",
		},
		npc_dota_furion_treant_4 = {
			ability = "furion_force_of_nature",
			health = "treant_health_tooltip",
			damage = "treant_dmg_tooltip",
		},

		npc_dota_furion_treant_large = {
			ability = "furion_force_of_nature",
			health = "treant_health_tooltip",
			damage = "treant_dmg_tooltip",
		},
	]]

	npc_dota_visage_familiar1 = {
		ability = "visage_summon_familiars",
		health = "familiar_hp",
		damage = "familiar_attack_damage",
	},
	npc_dota_visage_familiar2 = {
		ability = "visage_summon_familiars",
		health = "familiar_hp",
		damage = "familiar_attack_damage",
	},
	npc_dota_visage_familiar3 = {
		ability = "visage_summon_familiars",
		health = "familiar_hp",
		damage = "familiar_attack_damage",
	},

	-- npc_dota_witch_doctor_death_ward = "witch_doctor_death_ward",
	-- npc_dota_wraith_king_skeleton_warrior = "skeleton_king_vampiric_aura",

	npc_dota_venomancer_plague_ward_1 = {
		ability = "venomancer_plague_ward_custom",
		health = "ward_hp_tooltip",
		damage = "ward_damage_tooltip",
	},
	npc_dota_venomancer_plague_ward_2 = {
		ability = "venomancer_plague_ward_custom",
		health = "ward_hp_tooltip",
		damage = "ward_damage_tooltip",
	},
	npc_dota_venomancer_plague_ward_3 = {
		ability = "venomancer_plague_ward_custom",
		health = "ward_hp_tooltip",
		damage = "ward_damage_tooltip",
	},
	npc_dota_venomancer_plague_ward_4 = {
		ability = "venomancer_plague_ward_custom",
		health = "ward_hp_tooltip",
		damage = "ward_damage_tooltip",
	},

	npc_dota_eidolon = {
		ability = "enigma_demonic_conversion_custom",
		health = "eidolon_hp_tooltip",
		damage = "eidolon_dmg_tooltip"
	},
	npc_dota_lesser_eidolon = {
		ability = "enigma_demonic_conversion_custom",
		health = "eidolon_hp_tooltip",
		damage = "eidolon_dmg_tooltip"
	},
	npc_dota_greater_eidolon = {
		ability = "enigma_demonic_conversion_custom",
		health = "eidolon_hp_tooltip",
		damage = "eidolon_dmg_tooltip"
	},
	npc_dota_dire_eidolon = {
		ability = "enigma_demonic_conversion_custom",
		health = "eidolon_hp_tooltip",
		damage = "eidolon_dmg_tooltip"
	},

	npc_dota_warlock_golem = {
		ability = "warlock_rain_of_chaos",
		-- health = "golem_hp",
		-- damage = "golem_dmg",
		-- armor = "golem_armor",
		ability_upgrades = true,
	},

	npc_dota_warlock_major_imp = {
		ability = "warlock_upheaval",
		ability_upgrades = true,
	},
	npc_dota_warlock_minor_imp = {
		ability = "warlock_upheaval",
		ability_upgrades = true,
	},


	npc_dota_lone_druid_bear1 = {
		ability = "lone_druid_spirit_bear",
		retroactive = true,
		health = "bear_hp",
		armor = "bear_armor",

		generic_upgrades = true,
		health_bonus_as_modifier = true,
	},
	npc_dota_lone_druid_bear2 = {
		ability = "lone_druid_spirit_bear",
		retroactive = true,
		health = "bear_hp",
		armor = "bear_armor",

		generic_upgrades = true,
		health_bonus_as_modifier = true,
	},
	npc_dota_lone_druid_bear3 = {
		ability = "lone_druid_spirit_bear",
		retroactive = true,
		health = "bear_hp",
		armor = "bear_armor",

		generic_upgrades = true,
		health_bonus_as_modifier = true,
	},
	npc_dota_lone_druid_bear4 = {
		ability = "lone_druid_spirit_bear",
		retroactive = true,
		health = "bear_hp",
		armor = "bear_armor",

		generic_upgrades = true,
		health_bonus_as_modifier = true,
	},
	npc_dota_lone_druid_bear5 = {
		ability = "lone_druid_spirit_bear",
		retroactive = true,
		health = "bear_hp",
		armor = "bear_armor",

		generic_upgrades = true,
		health_bonus_as_modifier = true,
	},

	npc_dota_clinkz_skeleton_archer = {
		ability = "clinkz_wind_walk",
		ability_upgrades = true
	},

	npc_dota_brewmaster_earth_1 = {
		ability = "brewmaster_primal_split",
		added_health = "brewling_added_health",
		ability_upgrades = true,
	},

	npc_dota_brewmaster_earth_2 = {
		ability = "brewmaster_primal_split",
		added_health = "brewling_added_health",
		ability_upgrades = true,
	},

	npc_dota_brewmaster_earth_3 = {
		ability = "brewmaster_primal_split",
		added_health = "brewling_added_health",
		ability_upgrades = true,
	},

	npc_dota_brewmaster_earth_4 = {
		ability = "brewmaster_primal_split",
		added_health = "brewling_added_health",
		ability_upgrades = true,
	},

	npc_dota_brewmaster_storm_1 = {
		ability = "brewmaster_primal_split",
		added_health = "brewling_added_health",
		ability_upgrades = true,
	},

	npc_dota_brewmaster_storm_2 = {
		ability = "brewmaster_primal_split",
		added_health = "brewling_added_health",
		ability_upgrades = true,
	},

	npc_dota_brewmaster_storm_3 = {
		ability = "brewmaster_primal_split",
		added_health = "brewling_added_health",
		ability_upgrades = true,
	},

	npc_dota_brewmaster_storm_4 = {
		ability = "brewmaster_primal_split",
		added_health = "brewling_added_health",
		ability_upgrades = true,
	},

	npc_dota_brewmaster_fire_1 = {
		ability = "brewmaster_primal_split",
		added_health = "brewling_added_health",
		ability_upgrades = true,
	},

	npc_dota_brewmaster_fire_2 = {
		ability = "brewmaster_primal_split",
		added_health = "brewling_added_health",
		ability_upgrades = true,
	},

	npc_dota_brewmaster_fire_3 = {
		ability = "brewmaster_primal_split",
		added_health = "brewling_added_health",
		ability_upgrades = true,
	},

	npc_dota_brewmaster_fire_4 = {
		ability = "brewmaster_primal_split",
		added_health = "brewling_added_health",
		ability_upgrades = true,
	},

	npc_dota_zeus_cloud = {
		ability = "zuus_lightning_bolt",
		ability_upgrades = true
	},

	npc_dota_treant_eyes = {
		ability = "treant_eyes_in_the_forest",
		vision_day = "vision_aoe",
		vision_night = "vision_aoe",
	},

	npc_dota_wraith_king_skeleton_warrior = {
		ability = "skeleton_king_bone_guard",
		health = "skeleton_health",
		damage = "skeleton_damage_tooltip"
	},

	npc_dota_lich_ice_spire = {
		ability = "lich_ice_spire",
		added_health = "added_health",
	},

	npc_dota_broodmother_spiderling = {
		ability = "broodmother_spawn_spiderlings",
		ability_upgrades = true,
	},
}