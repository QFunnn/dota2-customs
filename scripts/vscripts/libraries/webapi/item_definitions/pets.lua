--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


ITEM_DEFINITIONS["forest_wolf"] = {
	slot = INVENTORY_SLOTS.PET,
	type = ITEM_TYPES.EQUIPMENT,
	rarity = ITEM_RARITIES.UNCOMMON,

	unlocked_with = {
		currency = 1500,
	},

	model_path = "models/items/lycan/ultimate/_ascension_of_the_hallowed_beast_form/_ascension_of_the_hallowed_beast_form.vmdl",
	model_scale = 0.5,

	particles = {
		{
			path = "particles/econ/items/lycan/lycan_cache_2021/lycan_cache_2021_form.vpcf",
			attach_type = PATTACH_RENDERORIGIN_FOLLOW,
		}
	},
}

ITEM_DEFINITIONS["onibi"] = {
	slot = INVENTORY_SLOTS.PET,
	type = ITEM_TYPES.EQUIPMENT,
	rarity = ITEM_RARITIES.LEGENDARY,

	unlocked_with = {
		treasure = "treasure_3"
	},

	model_path = "models/items/courier/onibi_lvl_21/onibi_lvl_21.vmdl",
	model_scale = 1,
	is_flying = true,

	particles = {
		{
			path = "particles/econ/courier/courier_onibi/courier_onibi_black_lvl21_ambient.vpcf",
			attach_type = PATTACH_RENDERORIGIN_FOLLOW,
			control_points = {
				[0] = {
					attach_type = PATTACH_POINT_FOLLOW,
					attachment = "attach_eye_l",
				},
				[1] = {
					attach_type = PATTACH_POINT_FOLLOW,
					attachment = "attach_eye_r",
				},
			}
		}
	},

	blink_particles = {
		start_name = "particles/econ/events/ti6/blink_dagger_start_ti6_lvl2.vpcf",
		end_name = "particles/econ/events/ti6/blink_dagger_end_ti6_lvl2.vpcf"
	}
}

ITEM_DEFINITIONS["flying_void_rex"] = {
	slot = INVENTORY_SLOTS.PET,
	type = ITEM_TYPES.EQUIPMENT,
	rarity = ITEM_RARITIES.MYTHICAL,

	unlocked_with = {
		treasure = "treasure_3",
	},

	model_path = "models/items/courier/faceless_rex/faceless_rex_flying.vmdl",
	model_scale = 1,
	is_flying = true,

	particles = {
		{
			path = "particles/econ/courier/courier_faceless_rex/cour_rex_flying.vpcf",
			attach_type = PATTACH_RENDERORIGIN_FOLLOW,
			control_points = {
				[0] = {
					attach_type = PATTACH_ROOTBONE_FOLLOW,
					attachment = "attach_flying_particles",
				},
			}
		}
	},

	blink_particles = {
		start_name = "particles/econ/events/ti4/blink_dagger_start_ti4.vpcf",
		end_name = "particles/econ/events/ti4/blink_dagger_end_ti4.vpcf"
	},
}
ITEM_DEFINITIONS["gold_dragon"] = {
	slot = INVENTORY_SLOTS.PET,
	type = ITEM_TYPES.EQUIPMENT,
	rarity = ITEM_RARITIES.IMMORTAL,

	unlocked_with = {
		currency = 12500,
	},

	model_path = "models/courier/baby_winter_wyvern/baby_winter_wyvern.vmdl",
	model_scale = 1.2,
	material_group = "2",

	particles = {
		{
			path = "particles/econ/courier/courier_wyvern_hatchling/courier_wyvern_hatchling_gold.vpcf",
			attach_type = PATTACH_RENDERORIGIN_FOLLOW,
		},
		{
			path = "particles/econ/courier/courier_wyvern_hatchling/courier_wyvern_hatchling_tail_gold.vpcf",
			attach_type = PATTACH_POINT_FOLLOW,
			control_points = {
				[0] = {
					attach_type = PATTACH_POINT_FOLLOW,
					attachment = "attach_fx",
				},
			}
		}
	},
}
ITEM_DEFINITIONS["nian"] = {
	slot = INVENTORY_SLOTS.PET,
	type = ITEM_TYPES.EQUIPMENT,
	rarity = ITEM_RARITIES.MYTHICAL,

	unlocked_with = {
		treasure = "treasure_2"
	},

	model_path = "models/items/courier/nian_courier/nian_courier.vmdl",
	model_scale = 1,

	particles = {
		{
			path = "particles/econ/courier/courier_nian/courier_nian_ambient.vpcf",
			attach_type = PATTACH_RENDERORIGIN_FOLLOW,
		},
	},
}
ITEM_DEFINITIONS["lefty_default"] = {
	slot = INVENTORY_SLOTS.PET,
	type = ITEM_TYPES.EQUIPMENT,
	rarity = ITEM_RARITIES.COMMON,

	unlocked_with = {
		treasure = "treasure_1"
	},

	model_path = "models/items/courier/hand_courier/hand_courier_radiant_lv1.vmdl",
	model_scale = 0.9,

	particles = {
		{
			path = "particles/econ/courier/hand_courier/hand_courier_radiant_lv1/hand_courier_radiant_lv1_ambient.vpcf",
			attach_type = PATTACH_RENDERORIGIN_FOLLOW,
		},
	},
}
ITEM_DEFINITIONS["lefty_gem"] = {
	slot = INVENTORY_SLOTS.PET,
	type = ITEM_TYPES.EQUIPMENT,
	rarity = ITEM_RARITIES.RARE,

	unlocked_with = {
		treasure = "treasure_1"
	},

	model_path = "models/items/courier/hand_courier/hand_courier_dire_lv2.vmdl",
	model_scale = 0.9,

	particles = {
		{
			path = "particles/econ/courier/hand_courier/hand_courier_dire_lv2/hand_courier_dire_lv2_ambient.vpcf",
			attach_type = PATTACH_RENDERORIGIN_FOLLOW,
		},
	},

	blink_particles = {
		start_name = "particles/econ/events/fall_major_2016/blink_dagger_start_fm06.vpcf",
		end_name = "particles/econ/events/fall_major_2016/blink_dagger_end_fm06.vpcf",
	},
}
ITEM_DEFINITIONS["lefty_ultimate"] = {
	slot = INVENTORY_SLOTS.PET,
	type = ITEM_TYPES.EQUIPMENT,
	rarity = ITEM_RARITIES.COMMON,

	unlocked_with = {
		treasure = "treasure_1"
	},

	model_path = "models/items/courier/hand_courier/hand_courier_radiant_lv3.vmdl",
	model_scale = 0.9,

	particles = {
		{
			path = "particles/econ/courier/hand_courier/hand_courier_radiant_lv3/hand_courier_radiant_lv3_ambient.vpcf",
			attach_type = PATTACH_RENDERORIGIN_FOLLOW,
		},
	},

	blink_particles = {
		start_name = "particles/econ/events/ti5/blink_dagger_start_ti5.vpcf",
		end_name = "particles/econ/events/ti5/blink_dagger_end_ti5.vpcf",
	},
}
ITEM_DEFINITIONS["lefty_linken"] = {
	slot = INVENTORY_SLOTS.PET,
	type = ITEM_TYPES.EQUIPMENT,
	rarity = ITEM_RARITIES.UNCOMMON,

	unlocked_with = {
		treasure = "treasure_2"
	},

	model_path = "models/items/courier/hand_courier/hand_courier_dire_lv4.vmdl",
	model_scale = 0.9,

	particles = {
		{
			path = "particles/econ/courier/hand_courier/hand_courier_dire_lv4/hand_courier_dire_lv4_ambient.vpcf",
			attach_type = PATTACH_RENDERORIGIN_FOLLOW,
		},
	},
}
ITEM_DEFINITIONS["lefty_refresh"] = {
	slot = INVENTORY_SLOTS.PET,
	type = ITEM_TYPES.EQUIPMENT,
	rarity = ITEM_RARITIES.RARE,

	unlocked_with = {
		treasure = "treasure_2"
	},

	model_path = "models/items/courier/hand_courier/hand_courier_dire_lv5.vmdl",
	model_scale = 0.9,

	particles = {
		{
			path = "particles/econ/courier/hand_courier/hand_courier_dire_lv5/hand_courier_dire_lv5_ambient.vpcf",
			attach_type = PATTACH_RENDERORIGIN_FOLLOW,
		},
	},

	blink_particles = {
		start_name = "particles/econ/events/fall_major_2016/blink_dagger_start_fm06.vpcf",
		end_name = "particles/econ/events/fall_major_2016/blink_dagger_end_fm06.vpcf",
	},
}
ITEM_DEFINITIONS["lefty_octarine"] = {
	slot = INVENTORY_SLOTS.PET,
	type = ITEM_TYPES.EQUIPMENT,
	rarity = ITEM_RARITIES.MYTHICAL,

	unlocked_with = {
		treasure = "treasure_3"
	},

	model_path = "models/items/courier/hand_courier/hand_courier_radiant_lv6.vmdl",
	model_scale = 0.9,

	particles = {
		{
			path = "particles/econ/courier/hand_courier/hand_courier_radiant_lv6/hand_courier_radiant_lv6_ambient.vpcf",
			attach_type = PATTACH_RENDERORIGIN_FOLLOW,
		},
	},

	blink_particles = {
		start_name = "particles/econ/events/ti4/blink_dagger_start_ti4.vpcf",
		end_name = "particles/econ/events/ti4/blink_dagger_end_ti4.vpcf"
	},
}
ITEM_DEFINITIONS["lefty_aegis"] = {
	slot = INVENTORY_SLOTS.PET,
	type = ITEM_TYPES.EQUIPMENT,
	rarity = ITEM_RARITIES.ARCANA,

	unlocked_with = {
		currency = 50000,
	},

	model_path = "models/items/courier/hand_courier/hand_courier_dire_lv7.vmdl",
	model_scale = 1,

	particles = {
		{
			path = "particles/econ/courier/hand_courier/hand_courier_dire_lv7/hand_courier_dire_lv7_ambient.vpcf",
			attach_type = PATTACH_RENDERORIGIN_FOLLOW,
		},
	},

	blink_particles = {
		start_name = "particles/econ/events/ti10/blink_dagger_start_ti10_lvl2.vpcf",
		end_name = "particles/econ/events/ti10/blink_dagger_end_ti10_lvl2.vpcf",
	}
}

ITEM_DEFINITIONS["chicken"] = {
	slot = INVENTORY_SLOTS.PET,
	type = ITEM_TYPES.EQUIPMENT,
	rarity = ITEM_RARITIES.COMMON,

	unlocked_with = {
		currency = 100,
	},

	model_path = "models/items/courier/mighty_chicken/mighty_chicken.vmdl",
	model_scale = 1,
}

ITEM_DEFINITIONS["golden_greevil"] = {
	slot = INVENTORY_SLOTS.PET,
	type = ITEM_TYPES.EQUIPMENT,
	rarity = ITEM_RARITIES.IMMORTAL,

	unlocked_with = {
		currency = 10000,
	},

	model_path = "models/courier/greevil/gold_greevil.vmdl",
	model_scale = 1,

	particles = {
		{
			path = "particles/econ/courier/courier_greevil_yellow/courier_greevil_yellow_ambient_3.vpcf",
			attach_type = PATTACH_RENDERORIGIN_FOLLOW,
			control_points = {
				[1] = {
					attach_type = PATTACH_POINT_FOLLOW,
					attachment = "attach_eye_r",
				},
			}
		},
	},

	blink_particles = {
		start_name = "particles/econ/events/ti10/blink_dagger_start_ti10_lvl2.vpcf",
		end_name = "particles/econ/events/ti10/blink_dagger_end_ti10_lvl2.vpcf",
	}
}

ITEM_DEFINITIONS["golden_krobeling"] = {
	slot = INVENTORY_SLOTS.PET,
	type = ITEM_TYPES.EQUIPMENT,
	rarity = ITEM_RARITIES.IMMORTAL,

	unlocked_with = {
		currency = 15000,
	},

	model_path = "models/items/courier/krobeling_gold/krobeling_gold.vmdl",
	model_scale = 1,

	particles = {
		{
			path = "particles/econ/courier/courier_krobeling_gold/courier_krobeling_gold_ambient.vpcf",
			attach_type = PATTACH_RENDERORIGIN_FOLLOW,
		},
	},

	blink_particles = {
		start_name = "particles/econ/events/ti10/blink_dagger_start_ti10_lvl2.vpcf",
		end_name = "particles/econ/events/ti10/blink_dagger_end_ti10_lvl2.vpcf",
	}
}

ITEM_DEFINITIONS["golden_huntling"] = {
	slot = INVENTORY_SLOTS.PET,
	type = ITEM_TYPES.EQUIPMENT,
	rarity = ITEM_RARITIES.IMMORTAL,

	unlocked_with = {
		currency = 20000,
	},

	model_path = "models/courier/huntling/huntling.vmdl",
	model_scale = 1,
	material_group = "1",

	particles = {
		{
			path = "particles/econ/courier/courier_huntling_gold/courier_huntling_gold_ambient.vpcf",
			attach_type = PATTACH_RENDERORIGIN_FOLLOW,
		},
	},

	blink_particles = {
		start_name = "particles/econ/events/ti10/blink_dagger_start_ti10_lvl2.vpcf",
		end_name = "particles/econ/events/ti10/blink_dagger_end_ti10_lvl2.vpcf",
	}
}

ITEM_DEFINITIONS["golden_doomling"] = {
	slot = INVENTORY_SLOTS.PET,
	type = ITEM_TYPES.EQUIPMENT,
	rarity = ITEM_RARITIES.IMMORTAL,

	unlocked_with = {
		currency = 30000,
	},

	model_path = "models/courier/doom_demihero_courier/doom_demihero_courier.vmdl",
	model_scale = 1,
	material_group = "1",

	particles = {
		{
			path = "particles/econ/courier/courier_golden_doomling/courier_golden_doomling_ambient.vpcf",
			attach_type = PATTACH_RENDERORIGIN_FOLLOW,
		},
	},

	blink_particles = {
		start_name = "particles/econ/events/ti10/blink_dagger_start_ti10_lvl2.vpcf",
		end_name = "particles/econ/events/ti10/blink_dagger_end_ti10_lvl2.vpcf",
	}
}

ITEM_DEFINITIONS["golden_flopjaw"] = {
	slot = INVENTORY_SLOTS.PET,
	type = ITEM_TYPES.EQUIPMENT,
	rarity = ITEM_RARITIES.IMMORTAL,

	unlocked_with = {
		currency = 88888,
	},

	model_path = "models/courier/flopjaw/flopjaw.vmdl",
	model_scale = 1,
	material_group = "1",

	particles = {
		{
			path = "particles/econ/courier/courier_flopjaw_gold/courier_flopjaw_ambient_gold.vpcf",
			attach_type = PATTACH_RENDERORIGIN_FOLLOW,
		},
	},

	blink_particles = {
		start_name = "particles/econ/events/ti10/blink_dagger_start_ti10_lvl2.vpcf",
		end_name = "particles/econ/events/ti10/blink_dagger_end_ti10_lvl2.vpcf",
	}
}

ITEM_DEFINITIONS["golden_seekling"] = {
	slot = INVENTORY_SLOTS.PET,
	type = ITEM_TYPES.EQUIPMENT,
	rarity = ITEM_RARITIES.IMMORTAL,

	unlocked_with = {
		currency = 25000,
	},

	model_path = "models/courier/seekling/seekling.vmdl",
	model_scale = 1,
	material_group = "1",

	particles = {
		{
			path = "particles/econ/courier/courier_seekling_gold/courier_seekling_gold_ambient.vpcf",
			attach_type = PATTACH_RENDERORIGIN_FOLLOW,
		},
	},

	blink_particles = {
		start_name = "particles/econ/events/ti10/blink_dagger_start_ti10_lvl2.vpcf",
		end_name = "particles/econ/events/ti10/blink_dagger_end_ti10_lvl2.vpcf",
	}
}

ITEM_DEFINITIONS["golden_venoling"] = {
	slot = INVENTORY_SLOTS.PET,
	type = ITEM_TYPES.EQUIPMENT,
	rarity = ITEM_RARITIES.IMMORTAL,

	unlocked_with = {
		currency = 17500,
	},

	model_path = "models/courier/venoling/venoling.vmdl",
	model_scale = 1,
	material_group = "1",

	particles = {
		{
			path = "particles/econ/courier/courier_venoling_gold/courier_venoling_ambient_gold.vpcf",
			attach_type = PATTACH_RENDERORIGIN_FOLLOW,
		},
	},

	blink_particles = {
		start_name = "particles/econ/events/ti10/blink_dagger_start_ti10_lvl2.vpcf",
		end_name = "particles/econ/events/ti10/blink_dagger_end_ti10_lvl2.vpcf",
	}
}

ITEM_DEFINITIONS["golden_devourling"] = {
	slot = INVENTORY_SLOTS.PET,
	type = ITEM_TYPES.EQUIPMENT,
	rarity = ITEM_RARITIES.IMMORTAL,

	unlocked_with = {
		currency = 22500,
	},

	model_path = "models/items/courier/devourling/devourling.vmdl",
	model_scale = 1,
	material_group = "1",

	particles = {
		{
			path = "particles/econ/courier/courier_devourling_gold/courier_devourling_gold_ambient.vpcf",
			attach_type = PATTACH_RENDERORIGIN_FOLLOW,
		},
	},

	blink_particles = {
		start_name = "particles/econ/events/ti10/blink_dagger_start_ti10_lvl2.vpcf",
		end_name = "particles/econ/events/ti10/blink_dagger_end_ti10_lvl2.vpcf",
	}
}

ITEM_DEFINITIONS["roshan_platinum"] = {
	slot = INVENTORY_SLOTS.PET,
	type = ITEM_TYPES.EQUIPMENT,
	rarity = ITEM_RARITIES.ARCANA,

	unlocked_with = {
		treasure = "treasure_3"
	},

	model_path = "models/courier/baby_rosh/babyroshan_alt.vmdl",
	model_scale = 1,
	material_group = "2",
	particles = {
		{
			path = "particles/econ/courier/courier_babyrosh_alt_ti8/courier_babyrosh_alt_ti8.vpcf",
			attach_type = PATTACH_RENDERORIGIN_FOLLOW,
		},
	},

	blink_particles = {
		start_name = "particles/econ/events/ti7/blink_dagger_start_ti7_lvl2.vpcf",
		end_name = "particles/econ/events/ti7/blink_dagger_end_ti7_lvl2.vpcf"
	}
}

ITEM_DEFINITIONS["roshan_courier"] = {
	slot = INVENTORY_SLOTS.PET,
	type = ITEM_TYPES.EQUIPMENT,
	rarity = ITEM_RARITIES.UNCOMMON,

	unlocked_with = {
		subscription_tier = 1,
	},

	model_path = "models/courier/baby_rosh/babyroshan.vmdl",
	model_scale = 1,
}

ITEM_DEFINITIONS["roshan_ti10"] = {
	slot = INVENTORY_SLOTS.PET,
	type = ITEM_TYPES.EQUIPMENT,
	rarity = ITEM_RARITIES.IMMORTAL,

	unlocked_with = {
		subscription_tier = 2,
	},

	model_path = "models/courier/baby_rosh/babyroshan_ti10_dire.vmdl",
	model_scale = 0.9,

	particles = {
		{
			path = "particles/econ/courier/courier_babyroshan_ti10/courier_babyroshan_ti10_dire_ambient.vpcf",
			attach_type = PATTACH_RENDERORIGIN_FOLLOW,
		}
	},
}


ITEM_DEFINITIONS["scotty_christmas_2023"] = {
	slot = INVENTORY_SLOTS.PET,
	type = ITEM_TYPES.EQUIPMENT,
	rarity = ITEM_RARITIES.UNIQUE,
	is_hidden = true,

	unlocked_with = {
		christmas = 2023,
	},

	model_path = "models/items/courier/scuttling_scotty_penguin/scuttling_scotty_penguin.vmdl",
	model_scale = 1.2,

	particles = {
		{
			-- path = "particles/killstreak/killstreak_ice_snowflakes_topbar.vpcf",
			path = "particles/econ/courier/courier_wyvern_hatchling/courier_wyvern_hatchling_ice.vpcf",
			attach_type = PATTACH_RENDERORIGIN_FOLLOW,
		},
		{
			path = "particles/killstreak/killstreak_ice_snowflakes_topbar.vpcf",
			attach_type = PATTACH_ABSORIGIN_FOLLOW,
		}
	},
}