--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


COMMON_AURA_CONTROL_POINTS = {
	[0] = {
		attach_type = PATTACH_POINT_FOLLOW,
		attachment = "attach_hitlock"
	},
}
COMMON_WINGS_CONTROL_POINTS = {
	[0] = {
		attach_type = PATTACH_ABSORIGIN_FOLLOW,
		attachment = "attach_hitloc",
		orientation = 1
	},
}

ITEM_DEFINITIONS["aura_green_1"] = {
	slot = INVENTORY_SLOTS.AURA,
	type = ITEM_TYPES.EQUIPMENT,
	rarity = ITEM_RARITIES.UNCOMMON,

	unlocked_with = {
		subscription_tier = 1,
	},

	particles = {
		{
			path = "particles/cosmetic/auras/test_aura_1_sup1/test_aura_1_sup1.vpcf",
			attach_type = PATTACH_POINT_FOLLOW,
			control_points = COMMON_AURA_CONTROL_POINTS,
		},
	},

	sound_effect_name = "Blink_Layer.Swift",
}

ITEM_DEFINITIONS["aura_purple_1"] = {
	slot = INVENTORY_SLOTS.AURA,
	type = ITEM_TYPES.EQUIPMENT,
	rarity = ITEM_RARITIES.COMMON,

	unlocked_with = {
		currency = 500,
	},

	particles = {
		{
			path = "particles/cosmetic/auras/test_aura_3_treasure/test_aura_3_treasure.vpcf",
			attach_type = PATTACH_POINT_FOLLOW,
			control_points = COMMON_AURA_CONTROL_POINTS,
		},
	},
}

ITEM_DEFINITIONS["diretide_emblem_orange"] = {
	slot = INVENTORY_SLOTS.AURA,
	type = ITEM_TYPES.EQUIPMENT,
	rarity = ITEM_RARITIES.IMMORTAL,

	unlocked_with = {
		currency = 10000,
	},

	particles = {
		{
			path = "particles/cosmetic/auras/diretide_emblem_red/diretide_emblem_red.vpcf",
			attach_type = PATTACH_POINT_FOLLOW,
			control_points = COMMON_AURA_CONTROL_POINTS,
		},
	},
}

ITEM_DEFINITIONS["emblem_ti7"] = {
	slot = INVENTORY_SLOTS.AURA,
	type = ITEM_TYPES.EQUIPMENT,
	rarity = ITEM_RARITIES.LEGENDARY,

	unlocked_with = {
		treasure = "treasure_1",
	},

	particles = {
		{
			path = "particles/econ/events/ti7/ti7_hero_effect.vpcf",
			attach_type = PATTACH_POINT_FOLLOW,
			control_points = COMMON_AURA_CONTROL_POINTS,
		},
	},
}

ITEM_DEFINITIONS["emblem_ti8"] = {
	slot = INVENTORY_SLOTS.AURA,
	type = ITEM_TYPES.EQUIPMENT,
	rarity = ITEM_RARITIES.LEGENDARY,

	unlocked_with = {
		treasure = "treasure_2",
	},

	particles = {
		{
			path = "particles/econ/events/ti8/ti8_hero_effect.vpcf",
			attach_type = PATTACH_POINT_FOLLOW,
			control_points = COMMON_AURA_CONTROL_POINTS,
		},
	},
}

ITEM_DEFINITIONS["emblem_ti9"] = {
	slot = INVENTORY_SLOTS.AURA,
	type = ITEM_TYPES.EQUIPMENT,
	rarity = ITEM_RARITIES.LEGENDARY,

	unlocked_with = {
		treasure = "treasure_3",
	},

	particles = {
		{
			path = "particles/cosmetic/auras/overgrown_emblem/overgrown_emblem.vpcf",
			attach_type = PATTACH_POINT_FOLLOW,
			control_points = COMMON_AURA_CONTROL_POINTS,
		},
	},
}

ITEM_DEFINITIONS["emblem_ti10"] = {
	slot = INVENTORY_SLOTS.AURA,
	type = ITEM_TYPES.EQUIPMENT,
	rarity = ITEM_RARITIES.IMMORTAL,

	unlocked_with = {
		subscription_tier = 2,
	},

	particles = {
		{
			path = "particles/econ/events/ti10/emblem/ti10_emblem_effect.vpcf",
			attach_type = PATTACH_POINT_FOLLOW,
			control_points = COMMON_AURA_CONTROL_POINTS,
		},
	},
}

ITEM_DEFINITIONS["newbloom_aura"] = {
	slot = INVENTORY_SLOTS.AURA,
	type = ITEM_TYPES.EQUIPMENT,
	rarity = ITEM_RARITIES.RARE,

	unlocked_with = {
		currency = 1500,
	},

	particles = {
		{
			path = "particles/cosmetic/auras/newbloom/newbloom.vpcf",
			attach_type = PATTACH_POINT_FOLLOW,
			control_points = COMMON_AURA_CONTROL_POINTS,
		},
	},
}

ITEM_DEFINITIONS["aura_gyrus"] = {
	slot = INVENTORY_SLOTS.AURA,
	type = ITEM_TYPES.EQUIPMENT,
	rarity = ITEM_RARITIES.COMMON,

	particles = {
		{
			path = "particles/cosmetic/auras/gyrus/gyrus.vpcf",
			attach_type = PATTACH_POINT_FOLLOW,
			control_points = COMMON_AURA_CONTROL_POINTS,
		},
	},
}

ITEM_DEFINITIONS["aura_orbis"] = {
	slot = INVENTORY_SLOTS.AURA,
	type = ITEM_TYPES.EQUIPMENT,
	rarity = ITEM_RARITIES.UNCOMMON,

	particles = {
		{
			path = "particles/cosmetic/auras/orbis/orbis.vpcf",
			attach_type = PATTACH_POINT_FOLLOW,
			control_points = COMMON_AURA_CONTROL_POINTS,
		},
	},
}

ITEM_DEFINITIONS["aura_virtus"] = {
	slot = INVENTORY_SLOTS.AURA,
	type = ITEM_TYPES.EQUIPMENT,
	rarity = ITEM_RARITIES.RARE,

	particles = {
		{
			path = "particles/cosmetic/auras/virtus/virtus.vpcf",
			attach_type = PATTACH_POINT_FOLLOW,
			control_points = COMMON_AURA_CONTROL_POINTS,
		},
	},
}

ITEM_DEFINITIONS["aura_anima"] = {
	slot = INVENTORY_SLOTS.AURA,
	type = ITEM_TYPES.EQUIPMENT,
	rarity = ITEM_RARITIES.MYTHICAL,

	particles = {
		{
			path = "particles/cosmetic/auras/anima/anima.vpcf",
			attach_type = PATTACH_POINT_FOLLOW,
			control_points = COMMON_AURA_CONTROL_POINTS,
		},
	},
}

ITEM_DEFINITIONS["game_breaker"] = {
	slot = INVENTORY_SLOTS.AURA,
	type = ITEM_TYPES.EQUIPMENT,
	rarity = ITEM_RARITIES.ARCANA,

	particles = {
		{
			path = "particles/cosmetic/auras/game_breaker/game_breaker.vpcf",
			attach_type = PATTACH_POINT_FOLLOW,
			control_points = COMMON_AURA_CONTROL_POINTS,
		},
	},
}

-- Tournament

-- Top 20
ITEM_DEFINITIONS["blue_emblem"] = {
	slot = INVENTORY_SLOTS.AURA,
	type = ITEM_TYPES.EQUIPMENT,
	rarity = ITEM_RARITIES.IMMORTAL,

	particles = {
		{
			path = "particles/econ/tournament/blue_emblem.vpcf",
			attach_type = PATTACH_POINT_FOLLOW,
			control_points = COMMON_AURA_CONTROL_POINTS,
		},
	},
}

-- Top 10
ITEM_DEFINITIONS["red_emblem"] = {
	slot = INVENTORY_SLOTS.AURA,
	type = ITEM_TYPES.EQUIPMENT,
	rarity = ITEM_RARITIES.IMMORTAL,

	particles = {
		{
			path = "particles/econ/tournament/red_emblem.vpcf",
			attach_type = PATTACH_POINT_FOLLOW,
			control_points = COMMON_AURA_CONTROL_POINTS,
		},
	},
}

-- Top 3
ITEM_DEFINITIONS["bronze_emblem"] = {
	slot = INVENTORY_SLOTS.AURA,
	type = ITEM_TYPES.EQUIPMENT,
	rarity = ITEM_RARITIES.IMMORTAL,

	particles = {
		{
			path = "particles/econ/tournament/bronze_emblem.vpcf",
			attach_type = PATTACH_POINT_FOLLOW,
			control_points = COMMON_AURA_CONTROL_POINTS,
		},
	},
}

-- Top 2
ITEM_DEFINITIONS["silver_emblem"] = {
	slot = INVENTORY_SLOTS.AURA,
	type = ITEM_TYPES.EQUIPMENT,
	rarity = ITEM_RARITIES.IMMORTAL,

	particles = {
		{
			path = "particles/econ/tournament/silver_emblem.vpcf",
			attach_type = PATTACH_POINT_FOLLOW,
			control_points = COMMON_AURA_CONTROL_POINTS,
		},
	},
}

-- Top 1
ITEM_DEFINITIONS["gold_emblem"] = {
	slot = INVENTORY_SLOTS.AURA,
	type = ITEM_TYPES.EQUIPMENT,
	rarity = ITEM_RARITIES.IMMORTAL,

	particles = {
		{
			path = "particles/econ/tournament/gold_emblem.vpcf",
			attach_type = PATTACH_POINT_FOLLOW,
			control_points = COMMON_AURA_CONTROL_POINTS,
		},
	},
}

ITEM_DEFINITIONS["season_reset_1_silver"] = {
	slot = INVENTORY_SLOTS.AURA,
	type = ITEM_TYPES.EQUIPMENT,
	rarity = ITEM_RARITIES.UNIQUE,

	particles = {
		{
			path = "particles/cosmetic/auras/season_reward/001/silver_aura.vpcf",
			attach_type = PATTACH_POINT_FOLLOW,
			control_points = COMMON_AURA_CONTROL_POINTS,
		},
	},
}

ITEM_DEFINITIONS["season_reset_1_golden"] = {
	slot = INVENTORY_SLOTS.AURA,
	type = ITEM_TYPES.EQUIPMENT,
	rarity = ITEM_RARITIES.UNIQUE,

	particles = {
		{
			path = "particles/cosmetic/auras/season_reward/001/gold_aura.vpcf",
			attach_type = PATTACH_POINT_FOLLOW,
			control_points = COMMON_AURA_CONTROL_POINTS,
		},
	},
}

ITEM_DEFINITIONS["season_reset_2_silver"] = {
	slot = INVENTORY_SLOTS.AURA,
	type = ITEM_TYPES.EQUIPMENT,
	rarity = ITEM_RARITIES.UNIQUE,

	particles = {
		{
			path = "particles/cosmetic/auras/season_reward/002/s1_23_silver_reward.vpcf",
			attach_type = PATTACH_POINT_FOLLOW,
			control_points = COMMON_AURA_CONTROL_POINTS,
		},
	},
}

ITEM_DEFINITIONS["season_reset_2_golden"] = {
	slot = INVENTORY_SLOTS.AURA,
	type = ITEM_TYPES.EQUIPMENT,
	rarity = ITEM_RARITIES.UNIQUE,

	particles = {
		{
			path = "particles/cosmetic/auras/season_reward/002/s1_23_gold_reward.vpcf",
			attach_type = PATTACH_POINT_FOLLOW,
			control_points = COMMON_AURA_CONTROL_POINTS,
		},
	},
}

ITEM_DEFINITIONS["season_reset_3_silver"] = {
	slot = INVENTORY_SLOTS.AURA,
	type = ITEM_TYPES.EQUIPMENT,
	rarity = ITEM_RARITIES.UNIQUE,

	particles = {
		{
			path = "particles/cosmetic/auras/season_reward/003/s2_23_silver_reward.vpcf",
			attach_type = PATTACH_POINT_FOLLOW,
			control_points = COMMON_AURA_CONTROL_POINTS,
		},
	},
}

ITEM_DEFINITIONS["season_reset_3_golden"] = {
	slot = INVENTORY_SLOTS.AURA,
	type = ITEM_TYPES.EQUIPMENT,
	rarity = ITEM_RARITIES.UNIQUE,

	particles = {
		{
			path = "particles/cosmetic/auras/season_reward/003/s2_23_gold_reward.vpcf",
			attach_type = PATTACH_POINT_FOLLOW,
			control_points = COMMON_AURA_CONTROL_POINTS,
		},
	},
}

ITEM_DEFINITIONS["season_reset_4_silver"] = {
	slot = INVENTORY_SLOTS.AURA,
	type = ITEM_TYPES.EQUIPMENT,
	rarity = ITEM_RARITIES.UNIQUE,

	particles = {
		{
			path = "particles/cosmetic/auras/season_reward/004/s3_23_silver_reward.vpcf",
			attach_type = PATTACH_POINT_FOLLOW,
			control_points = COMMON_AURA_CONTROL_POINTS,
		},
	},
}

ITEM_DEFINITIONS["season_reset_4_golden"] = {
	slot = INVENTORY_SLOTS.AURA,
	type = ITEM_TYPES.EQUIPMENT,
	rarity = ITEM_RARITIES.UNIQUE,

	particles = {
		{
			path = "particles/cosmetic/auras/season_reward/004/s3_23_gold_reward.vpcf",
			attach_type = PATTACH_POINT_FOLLOW,
			control_points = COMMON_AURA_CONTROL_POINTS,
		},
	},
}

ITEM_DEFINITIONS["season_reset_5_silver"] = {
	slot = INVENTORY_SLOTS.AURA,
	type = ITEM_TYPES.EQUIPMENT,
	rarity = ITEM_RARITIES.UNIQUE,

	particles = {
		{
			path = "particles/cosmetic/auras/season_reward/005/s4_23_silver_reward_alt_version_1.vpcf",
			attach_type = PATTACH_POINT_FOLLOW,
			control_points = COMMON_AURA_CONTROL_POINTS,
		},
	},
}

ITEM_DEFINITIONS["season_reset_5_golden"] = {
	slot = INVENTORY_SLOTS.AURA,
	type = ITEM_TYPES.EQUIPMENT,
	rarity = ITEM_RARITIES.UNIQUE,

	particles = {
		{
			path = "particles/cosmetic/auras/season_reward/005/s4_23_gold_reward_alt_version_1.vpcf",
			attach_type = PATTACH_POINT_FOLLOW,
			control_points = COMMON_AURA_CONTROL_POINTS,
		},
	},
}

-- ITEM_DEFINITIONS["season_reset_6_silver"] = {
-- 	slot = INVENTORY_SLOTS.AURA,
-- 	type = ITEM_TYPES.EQUIPMENT,
-- 	rarity = ITEM_RARITIES.UNIQUE,

-- 	particles = {
-- 		{
-- 			path = "particles/cosmetic/auras/season_reward/006/s1_24_silver_reward.vpcf",
-- 			attach_type = PATTACH_POINT_FOLLOW,
-- 			control_points = COMMON_AURA_CONTROL_POINTS,
-- 		},
-- 	},
-- }

-- ITEM_DEFINITIONS["season_reset_6_golden"] = {
-- 	slot = INVENTORY_SLOTS.AURA,
-- 	type = ITEM_TYPES.EQUIPMENT,
-- 	rarity = ITEM_RARITIES.UNIQUE,

-- 	particles = {
-- 		{
-- 			path = "particles/cosmetic/auras/season_reward/006/s1_24_gold_reward.vpcf",
-- 			attach_type = PATTACH_POINT_FOLLOW,
-- 			control_points = COMMON_AURA_CONTROL_POINTS,
-- 		},
-- 	},
-- }

ITEM_DEFINITIONS["season_reset_6_golden"] = {
	slot = INVENTORY_SLOTS.AURA,
	type = ITEM_TYPES.EQUIPMENT,
	rarity = ITEM_RARITIES.UNIQUE,

	particles = {
		{
			path = "particles/cosmetic/auras/season_6/season_6_top_10.vpcf",
			attach_type = PATTACH_ABSORIGIN_FOLLOW,
			control_points = COMMON_WINGS_CONTROL_POINTS,
		},
	},
}

ITEM_DEFINITIONS["season_reset_6_silver"] = {
	slot = INVENTORY_SLOTS.AURA,
	type = ITEM_TYPES.EQUIPMENT,
	rarity = ITEM_RARITIES.UNIQUE,

	particles = {
		{
			path = "particles/cosmetic/auras/season_6/season_6_top_100.vpcf",
			attach_type = PATTACH_ABSORIGIN_FOLLOW,
			control_points = COMMON_WINGS_CONTROL_POINTS,
		},
	},
}

-- Season 24 - 2

ITEM_DEFINITIONS["season_reset_7_silver"] = {
	slot = INVENTORY_SLOTS.AURA,
	type = ITEM_TYPES.EQUIPMENT,
	rarity = ITEM_RARITIES.UNIQUE,

	particles = {
		{
			path = "particles/cosmetic/auras/season_7/season_7_top_100.vpcf",
			attach_type = PATTACH_ABSORIGIN_FOLLOW,
			control_points = COMMON_WINGS_CONTROL_POINTS,
		},
	},
}

ITEM_DEFINITIONS["season_reset_7_golden"] = {
	slot = INVENTORY_SLOTS.AURA,
	type = ITEM_TYPES.EQUIPMENT,
	rarity = ITEM_RARITIES.UNIQUE,

	particles = {
		{
			path = "particles/cosmetic/auras/season_7/season_7_top_10.vpcf",
			attach_type = PATTACH_ABSORIGIN_FOLLOW,
			control_points = COMMON_WINGS_CONTROL_POINTS,
		},
	},
}

-- Season 24 - 3

ITEM_DEFINITIONS["season_reset_8_silver"] = {
	slot = INVENTORY_SLOTS.AURA,
	type = ITEM_TYPES.EQUIPMENT,
	rarity = ITEM_RARITIES.UNIQUE,

	particles = {
		{
			path = "particles/cosmetic/auras/season_8/season_8_top_100.vpcf",
			attach_type = PATTACH_ABSORIGIN_FOLLOW,
			control_points = COMMON_WINGS_CONTROL_POINTS,
		},
	}
}

ITEM_DEFINITIONS["season_reset_8_golden"] = {
	slot = INVENTORY_SLOTS.AURA,
	type = ITEM_TYPES.EQUIPMENT,
	rarity = ITEM_RARITIES.UNIQUE,

	particles = {
		{
			path = "particles/cosmetic/auras/season_8/season_8_top_10.vpcf",
			attach_type = PATTACH_ABSORIGIN_FOLLOW,
			control_points = COMMON_WINGS_CONTROL_POINTS,
		},
	}
}

-- Season 24 - 4

ITEM_DEFINITIONS["season_reset_9_silver"] = {
	slot = INVENTORY_SLOTS.AURA,
	type = ITEM_TYPES.EQUIPMENT,
	rarity = ITEM_RARITIES.UNIQUE,

	particles = {
		{
			path = "particles/cosmetic/auras/season_9/season_9_top_100.vpcf",
			attach_type = PATTACH_ABSORIGIN_FOLLOW,
			control_points = COMMON_AURA_CONTROL_POINTS,
		},
	}
}

ITEM_DEFINITIONS["season_reset_9_golden"] = {
	slot = INVENTORY_SLOTS.AURA,
	type = ITEM_TYPES.EQUIPMENT,
	rarity = ITEM_RARITIES.UNIQUE,

	particles = {
		{
			path = "particles/cosmetic/auras/season_9/season_9_top_10.vpcf",
			attach_type = PATTACH_ABSORIGIN_FOLLOW,
			control_points = COMMON_AURA_CONTROL_POINTS,
		},
	}
}

-- Season 25 - 1

ITEM_DEFINITIONS["season_reset_10_silver"] = {
	slot = INVENTORY_SLOTS.AURA,
	type = ITEM_TYPES.EQUIPMENT,
	rarity = ITEM_RARITIES.UNIQUE,

	particles = {
		{
			path = "particles/cosmetic/auras/season_10/season_10_top_100.vpcf",
			attach_type = PATTACH_ABSORIGIN_FOLLOW,
			control_points = COMMON_AURA_CONTROL_POINTS,
		},
	}
}

ITEM_DEFINITIONS["season_reset_10_golden"] = {
	slot = INVENTORY_SLOTS.AURA,
	type = ITEM_TYPES.EQUIPMENT,
	rarity = ITEM_RARITIES.UNIQUE,

	particles = {
		{
			path = "particles/cosmetic/auras/season_10/season_10_top_10.vpcf",
			attach_type = PATTACH_ABSORIGIN_FOLLOW,
			control_points = COMMON_AURA_CONTROL_POINTS,
		},
	}
}

-- Season 25 - 2

ITEM_DEFINITIONS["season_reset_11_silver"] = {
	slot = INVENTORY_SLOTS.AURA,
	type = ITEM_TYPES.EQUIPMENT,
	rarity = ITEM_RARITIES.UNIQUE,

	particles = {
		{
			path = "particles/cosmetic/auras/season_11/season_11_top_100.vpcf",
			attach_type = PATTACH_ABSORIGIN_FOLLOW,
			control_points = COMMON_AURA_CONTROL_POINTS,
		},
	}
}

ITEM_DEFINITIONS["season_reset_11_golden"] = {
	slot = INVENTORY_SLOTS.AURA,
	type = ITEM_TYPES.EQUIPMENT,
	rarity = ITEM_RARITIES.UNIQUE,

	particles = {
		{
			path = "particles/cosmetic/auras/season_11/season_11_top_10.vpcf",
			attach_type = PATTACH_ABSORIGIN_FOLLOW,
			control_points = COMMON_AURA_CONTROL_POINTS,
		},
	}
}

-- Season 25 - 3

ITEM_DEFINITIONS["season_reset_12_silver"] = {
	slot = INVENTORY_SLOTS.AURA,
	type = ITEM_TYPES.EQUIPMENT,
	rarity = ITEM_RARITIES.UNIQUE,

	particles = {
		{
			path = "particles/cosmetic/auras/season_12/season_12_top_100.vpcf",
			attach_type = PATTACH_ABSORIGIN_FOLLOW,
			control_points = COMMON_AURA_CONTROL_POINTS,
		},
	}
}

ITEM_DEFINITIONS["season_reset_12_golden"] = {
	slot = INVENTORY_SLOTS.AURA,
	type = ITEM_TYPES.EQUIPMENT,
	rarity = ITEM_RARITIES.UNIQUE,

	particles = {
		{
			path = "particles/cosmetic/auras/season_12/season_12_top_10.vpcf",
			attach_type = PATTACH_ABSORIGIN_FOLLOW,
			control_points = COMMON_AURA_CONTROL_POINTS,
		},
	}
}

-- Season 25 - 4

ITEM_DEFINITIONS["season_reset_13_silver"] = {
	slot = INVENTORY_SLOTS.AURA,
	type = ITEM_TYPES.EQUIPMENT,
	rarity = ITEM_RARITIES.UNIQUE,

	particles = {
		{
			path = "particles/cosmetic/auras/season_13/season_13_top_100.vpcf",
			attach_type = PATTACH_ABSORIGIN_FOLLOW,
			control_points = COMMON_AURA_CONTROL_POINTS,
		},
	}
}

ITEM_DEFINITIONS["season_reset_13_golden"] = {
	slot = INVENTORY_SLOTS.AURA,
	type = ITEM_TYPES.EQUIPMENT,
	rarity = ITEM_RARITIES.UNIQUE,

	particles = {
		{
			path = "particles/cosmetic/auras/season_13/season_13_top_10.vpcf",
			attach_type = PATTACH_ABSORIGIN_FOLLOW,
			control_points = COMMON_AURA_CONTROL_POINTS,
		},
	}
}

-- Season 26 - 1

ITEM_DEFINITIONS["season_reset_14_silver"] = {
	slot = INVENTORY_SLOTS.AURA,
	type = ITEM_TYPES.EQUIPMENT,
	rarity = ITEM_RARITIES.UNIQUE,

	particles = {
		{
			path = "particles/cosmetic/auras/season_14/season_14_top_100.vpcf",
			attach_type = PATTACH_ABSORIGIN_FOLLOW,
			control_points = COMMON_AURA_CONTROL_POINTS,
		},
	}
}

ITEM_DEFINITIONS["season_reset_14_golden"] = {
	slot = INVENTORY_SLOTS.AURA,
	type = ITEM_TYPES.EQUIPMENT,
	rarity = ITEM_RARITIES.UNIQUE,

	particles = {
		{
			path = "particles/cosmetic/auras/season_14/season_14_top_10.vpcf",
			attach_type = PATTACH_ABSORIGIN_FOLLOW,
			control_points = COMMON_AURA_CONTROL_POINTS,
		},
	}
}

-- Season 26 - 2

ITEM_DEFINITIONS["season_reset_15_silver"] = {
	slot = INVENTORY_SLOTS.AURA,
	type = ITEM_TYPES.EQUIPMENT,
	rarity = ITEM_RARITIES.UNIQUE,

	particles = {
		{
			path = "particles/cosmetic/auras/season_15/season_15_top_100.vpcf",
			attach_type = PATTACH_ABSORIGIN_FOLLOW,
			control_points = COMMON_AURA_CONTROL_POINTS,
		},
	},
}

ITEM_DEFINITIONS["season_reset_15_golden"] = {
	slot = INVENTORY_SLOTS.AURA,
	type = ITEM_TYPES.EQUIPMENT,
	rarity = ITEM_RARITIES.UNIQUE,

	particles = {
		{
			path = "particles/cosmetic/auras/season_15/season_15_top_10.vpcf",
			attach_type = PATTACH_ABSORIGIN_FOLLOW,
			control_points = COMMON_AURA_CONTROL_POINTS,
		},
	},
}

-- AAF promos

ITEM_DEFINITIONS["aaf_promo_angel"] = {
	slot = INVENTORY_SLOTS.AURA,
	type = ITEM_TYPES.EQUIPMENT,
	rarity = ITEM_RARITIES.IMMORTAL,

	particles = {
		{
			path = "particles/cosmetic/auras/aaf_crosspromo/angel_back_ring_origin.vpcf",
			attach_type = PATTACH_ABSORIGIN_FOLLOW,
			control_points = COMMON_AURA_CONTROL_POINTS,
		},
	}
}

ITEM_DEFINITIONS["aaf_promo_devil"] = {
	slot = INVENTORY_SLOTS.AURA,
	type = ITEM_TYPES.EQUIPMENT,
	rarity = ITEM_RARITIES.IMMORTAL,

	particles = {
		{
			path = "particles/cosmetic/auras/aaf_crosspromo/devil_back_ring_origin.vpcf",
			attach_type = PATTACH_ABSORIGIN_FOLLOW,
			control_points = COMMON_AURA_CONTROL_POINTS,
		},
	}
}

ITEM_DEFINITIONS["aaf_promo_gold"] = {
	slot = INVENTORY_SLOTS.AURA,
	type = ITEM_TYPES.EQUIPMENT,
	rarity = ITEM_RARITIES.IMMORTAL,

	particles = {
		{
			path = "particles/cosmetic/auras/aaf_crosspromo/gold_back_ring_origin.vpcf",
			attach_type = PATTACH_ABSORIGIN_FOLLOW,
			control_points = COMMON_AURA_CONTROL_POINTS,
		},
	}
}

ITEM_DEFINITIONS["12v12_crosspromo_space_oddity"] = {
	slot = INVENTORY_SLOTS.AURA,
	type = ITEM_TYPES.EQUIPMENT,
	rarity = ITEM_RARITIES.IMMORTAL,

	particles = {
		{
			path = "particles/cosmetic/auras/12v12_crosspromo/space_oddity.vpcf",
			attach_type = PATTACH_ABSORIGIN_FOLLOW,
			control_points = COMMON_AURA_CONTROL_POINTS,
		},
	}
}

ITEM_DEFINITIONS["aura_dc"] = {
	slot = INVENTORY_SLOTS.AURA,
	type = ITEM_TYPES.EQUIPMENT,
	rarity = ITEM_RARITIES.LEGENDARY,
	unlocked_with = {
		treasure = "treasure_chat_wheel_dc",
	},
	particles = {
		{
			path = "particles/cosmetic/auras/aura_dc/aura_dc.vpcf",
			attach_type = PATTACH_POINT_FOLLOW,
			control_points = {
				[0] = {
					attach_type = PATTACH_POINT_FOLLOW,
					attachment = "none",
				},
				[10] = {
					attach_type = PATTACH_POINT_FOLLOW,
					attachment = "none",
				},
			},
		},
	},
}