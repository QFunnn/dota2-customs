--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build b9dc48c · 2026-08-02 17:42:46 UTC
  ~ auto-generated — do not edit
]]


COMMON_AURA_CONTROL_POINTS = {
	[0] = {
		attach_type = PATTACH_POINT_FOLLOW,
		attachment = "attach_hitlock",
	},
}

ITEM_DEFINITIONS["test_aura_tour"] = {
	slot = INVENTORY_SLOTS.AURA,
	type = ITEM_TYPES.EQUIPMENT,
	rarity = ITEM_RARITIES.IMMORTAL,
	unlocked_with = {
		other = "tournament_2020_4",
	},
	particles = {
		{
			path = "particles/cosmetic/auras/test_aura_1_sup1/test_aura_1_sup1.vpcf",
			attach_type = PATTACH_POINT_FOLLOW,
			control_points = {
				[0] = {
					attach_type = PATTACH_POINT_FOLLOW,
					attachment = "none",
				},
			},
		},
	},
	is_hidden = true,
}

ITEM_DEFINITIONS["test_aura_1_sup1"] = {
	slot = INVENTORY_SLOTS.AURA,
	type = ITEM_TYPES.EQUIPMENT,
	rarity = ITEM_RARITIES.COMMON,
	unlocked_with = {
		treasure = "treasure_starter",
	},
	particles = {
		{
			path = "particles/cosmetic/auras/test_aura_1_sup1/test_aura_1_sup1.vpcf",
			attach_type = PATTACH_POINT_FOLLOW,
			control_points = {
				[0] = {
					attach_type = PATTACH_POINT_FOLLOW,
					attachment = "none",
				},
			},
		},
	},
}

ITEM_DEFINITIONS["test_aura_2_mmr1700"] = {
	slot = INVENTORY_SLOTS.AURA,
	type = ITEM_TYPES.EQUIPMENT,
	rarity = ITEM_RARITIES.IMMORTAL,
	unlocked_with = {
		subscription_tier = 1,
	},
	particles = {
		{
			path = "particles/cosmetic/auras/test_aura_2_mmr1700/creature/test_aura_2_mmr1700.vpcf",
			attach_type = PATTACH_POINT_FOLLOW,
			control_points = {
				[0] = {
					attach_type = PATTACH_POINT_FOLLOW,
					attachment = "none",
				},
			},
		},
	},
}

ITEM_DEFINITIONS["divinity_emblem"] = {
	slot = INVENTORY_SLOTS.AURA,
	type = ITEM_TYPES.EQUIPMENT,
	rarity = ITEM_RARITIES.IMMORTAL,
	unlocked_with = {
		subscription_tier = 2,
	},
	particles = {
		{
			path = "particles/cosmetic/auras/test_aura_4_sup2/test_aura_4_sup2.vpcf",
			attach_type = PATTACH_POINT_FOLLOW,
			control_points = {
				[0] = {
					attach_type = PATTACH_POINT_FOLLOW,
					attachment = "none",
				},
			},
		},
	},
}

ITEM_DEFINITIONS["test_aura_3_treasure"] = {
	slot = INVENTORY_SLOTS.AURA,
	type = ITEM_TYPES.EQUIPMENT,
	rarity = ITEM_RARITIES.COMMON,
	unlocked_with = {
		treasure = "treasure_starter",
	},
	particles = {
		{
			path = "particles/cosmetic/auras/test_aura_3_treasure/test_aura_3_treasure.vpcf",
			attach_type = PATTACH_POINT_FOLLOW,
			control_points = {
				[0] = {
					attach_type = PATTACH_POINT_FOLLOW,
					attachment = "none",
				},
			},
		},
	},
}

ITEM_DEFINITIONS["diretide_emblem_yellow"] = {
	slot = INVENTORY_SLOTS.AURA,
	type = ITEM_TYPES.EQUIPMENT,
	rarity = ITEM_RARITIES.MYTHICAL,
	unlocked_with = {
		treasure = "treasure_hallowed_shimmer",
	},
	particles = {
		{
			path = "particles/cosmetic/auras/diretide_emblem_yellow/diretide_emblem_yellow.vpcf",
			attach_type = PATTACH_POINT_FOLLOW,
			control_points = {
				[0] = {
					attach_type = PATTACH_POINT_FOLLOW,
					attachment = "none",
				},
			},
		},
	},
}

ITEM_DEFINITIONS["diretide_emblem_red"] = {
	slot = INVENTORY_SLOTS.AURA,
	type = ITEM_TYPES.EQUIPMENT,
	rarity = ITEM_RARITIES.MYTHICAL,
	unlocked_with = {
		treasure = "treasure_hallowed_shimmer",
	},
	particles = {
		{
			path = "particles/cosmetic/auras/diretide_emblem_red/diretide_emblem_red.vpcf",
			attach_type = PATTACH_POINT_FOLLOW,
			control_points = {
				[0] = {
					attach_type = PATTACH_POINT_FOLLOW,
					attachment = "none",
				},
			},
		},
	},
}

ITEM_DEFINITIONS["diretide_emblem_green"] = {
	slot = INVENTORY_SLOTS.AURA,
	type = ITEM_TYPES.EQUIPMENT,
	rarity = ITEM_RARITIES.MYTHICAL,
	unlocked_with = {
		treasure = "treasure_hallowed_shimmer",
	},
	particles = {
		{
			path = "particles/cosmetic/auras/diretide_emblem_green/diretide_emblem_green.vpcf",
			attach_type = PATTACH_POINT_FOLLOW,
			control_points = {
				[0] = {
					attach_type = PATTACH_POINT_FOLLOW,
					attachment = "none",
				},
			},
		},
	},
}

ITEM_DEFINITIONS["diretide_emblem_blue"] = {
	slot = INVENTORY_SLOTS.AURA,
	type = ITEM_TYPES.EQUIPMENT,
	rarity = ITEM_RARITIES.MYTHICAL,
	unlocked_with = {
		treasure = "treasure_hallowed_shimmer",
	},
	particles = {
		{
			path = "particles/cosmetic/auras/diretide_emblem_blue/diretide_emblem_blue.vpcf",
			attach_type = PATTACH_POINT_FOLLOW,
			control_points = {
				[0] = {
					attach_type = PATTACH_POINT_FOLLOW,
					attachment = "none",
				},
			},
		},
	},
}

ITEM_DEFINITIONS["crystal_emblem"] = {
	slot = INVENTORY_SLOTS.AURA,
	type = ITEM_TYPES.EQUIPMENT,
	rarity = ITEM_RARITIES.LEGENDARY,
	unlocked_with = {
		treasure = "treasure_international_2018",
	},
	particles = {
		{
			path = "particles/cosmetic/auras/crystal_emblem/crystal_emblem.vpcf",
			attach_type = PATTACH_POINT_FOLLOW,
			control_points = {
				[0] = {
					attach_type = PATTACH_POINT_FOLLOW,
					attachment = "none",
				},
			},
		},
	},
	is_hidden = true,
}

ITEM_DEFINITIONS["overgrown_emblem"] = {
	slot = INVENTORY_SLOTS.AURA,
	type = ITEM_TYPES.EQUIPMENT,
	rarity = ITEM_RARITIES.LEGENDARY,
	unlocked_with = {
		treasure = "treasure_international_2019",
	},
	particles = {
		{
			path = "particles/cosmetic/auras/overgrown_emblem/overgrown_emblem.vpcf",
			attach_type = PATTACH_POINT_FOLLOW,
			control_points = {
				[0] = {
					attach_type = PATTACH_POINT_FOLLOW,
					attachment = "none",
				},
			},
		},
	},
	is_hidden = true,
}

ITEM_DEFINITIONS["sunken_emblem"] = {
	slot = INVENTORY_SLOTS.AURA,
	type = ITEM_TYPES.EQUIPMENT,
	rarity = ITEM_RARITIES.LEGENDARY,
	unlocked_with = {
		treasure = "treasure_international_2017",
	},
	particles = {
		{
			path = "particles/cosmetic/auras/sunken_emblem/sunken_emblem.vpcf",
			attach_type = PATTACH_POINT_FOLLOW,
			control_points = {
				[0] = {
					attach_type = PATTACH_POINT_FOLLOW,
					attachment = "none",
				},
			},
		},
	},
	is_hidden = true,
}

ITEM_DEFINITIONS["fountain_effect_ti6"] = {
	slot = INVENTORY_SLOTS.AURA,
	type = ITEM_TYPES.EQUIPMENT,
	rarity = ITEM_RARITIES.RARE,
	unlocked_with = {
		treasure = "treasure_international_2016",
	},
	particles = {
		{
			path = "particles/cosmetic/auras/fountain_effect_ti6/fountain_effect_ti6.vpcf",
			attach_type = PATTACH_POINT_FOLLOW,
			control_points = {
				[0] = {
					attach_type = PATTACH_POINT_FOLLOW,
					attachment = "none",
				},
			},
		},
	},
	is_hidden = true,
}

ITEM_DEFINITIONS["fountain_effect_ti7"] = {
	slot = INVENTORY_SLOTS.AURA,
	type = ITEM_TYPES.EQUIPMENT,
	rarity = ITEM_RARITIES.RARE,
	unlocked_with = {
		treasure = "treasure_international_2017",
	},
	particles = {
		{
			path = "particles/cosmetic/auras/fountain_effect_ti7/fountain_effect_ti7.vpcf",
			attach_type = PATTACH_POINT_FOLLOW,
			control_points = {
				[0] = {
					attach_type = PATTACH_POINT_FOLLOW,
					attachment = "none",
				},
			},
		},
	},
	is_hidden = true,
}

ITEM_DEFINITIONS["fountain_effect_ti8"] = {
	slot = INVENTORY_SLOTS.AURA,
	type = ITEM_TYPES.EQUIPMENT,
	rarity = ITEM_RARITIES.RARE,
	unlocked_with = {
		treasure = "treasure_international_2018",
	},
	particles = {
		{
			path = "particles/cosmetic/auras/fountain_effect_ti8/fountain_effect_ti8.vpcf",
			attach_type = PATTACH_POINT_FOLLOW,
			control_points = {
				[0] = {
					attach_type = PATTACH_POINT_FOLLOW,
					attachment = "none",
				},
			},
		},
	},
	is_hidden = true,
}

ITEM_DEFINITIONS["fountain_effect_ti9"] = {
	slot = INVENTORY_SLOTS.AURA,
	type = ITEM_TYPES.EQUIPMENT,
	rarity = ITEM_RARITIES.RARE,
	unlocked_with = {
		treasure = "treasure_international_2019",
	},
	particles = {
		{
			path = "particles/cosmetic/auras/fountain_effect_ti9/fountain_effect_ti9.vpcf",
			attach_type = PATTACH_POINT_FOLLOW,
			control_points = {
				[0] = {
					attach_type = PATTACH_POINT_FOLLOW,
					attachment = "none",
				},
			},
		},
	},
	is_hidden = true,
}

ITEM_DEFINITIONS["newbloom"] = {
	slot = INVENTORY_SLOTS.AURA,
	type = ITEM_TYPES.EQUIPMENT,
	rarity = ITEM_RARITIES.MYTHICAL,
	unlocked_with = {
		treasure = "treasure_newbloom",
	},
	particles = {
		{
			path = "particles/cosmetic/auras/newbloom/newbloom.vpcf",
			attach_type = PATTACH_POINT_FOLLOW,
			control_points = {
				[0] = {
					attach_type = PATTACH_POINT_FOLLOW,
					attachment = "none",
				},
			},
		},
	},
	is_hidden = true,
}

ITEM_DEFINITIONS["game_breaker"] = {
	slot = INVENTORY_SLOTS.AURA,
	type = ITEM_TYPES.EQUIPMENT,
	rarity = ITEM_RARITIES.ARCANA,
	unlocked_with = {
		other = "dev_reward",
	},
	particles = {
		{
			path = "particles/collection/special/game_breaker.vpcf",
			attach_type = PATTACH_POINT_FOLLOW,
			control_points = {
				[0] = {
					attach_type = PATTACH_POINT_FOLLOW,
					attachment = "none",
				},
			},
		},
	},
	is_hidden = true,
}

ITEM_DEFINITIONS["cat_aura"] = {
	slot = INVENTORY_SLOTS.AURA,
	type = ITEM_TYPES.EQUIPMENT,
	rarity = ITEM_RARITIES.LEGENDARY,
	unlocked_with = {
		other = "season_5",
	},
	particles = {
		{
			path = "particles/cosmetic/auras/cat_aura/cat_aura.vpcf",
			attach_type = PATTACH_POINT_FOLLOW,
			control_points = {
				[0] = {
					attach_type = PATTACH_POINT_FOLLOW,
					attachment = "none",
				},
			},
		},
	},
	is_hidden = true,
}

ITEM_DEFINITIONS["silver_trophy_aura"] = {
	slot = INVENTORY_SLOTS.AURA,
	type = ITEM_TYPES.EQUIPMENT,
	rarity = ITEM_RARITIES.UNIQUE,
	unlocked_with = {
		other = "season_5",
	},
	particles = {
		{
			path = "particles/cosmetic/auras/silver_trophy_aura/silver_trophy_aura.vpcf",
			attach_type = PATTACH_POINT_FOLLOW,
			control_points = {
				[0] = {
					attach_type = PATTACH_POINT_FOLLOW,
					attachment = "none",
				},
			},
		},
	},
	is_hidden = true,
}

ITEM_DEFINITIONS["rapier_aura"] = {
	slot = INVENTORY_SLOTS.AURA,
	type = ITEM_TYPES.EQUIPMENT,
	rarity = ITEM_RARITIES.UNIQUE,
	unlocked_with = {
		other = "season_5",
	},
	particles = {
		{
			path = "particles/cosmetic/auras/rapier_aura/rapier_aura.vpcf",
			attach_type = PATTACH_POINT_FOLLOW,
			control_points = {
				[0] = {
					attach_type = PATTACH_POINT_FOLLOW,
					attachment = "none",
				},
			},
		},
	},
	is_hidden = true,
}

ITEM_DEFINITIONS["dragon_aura"] = {
	slot = INVENTORY_SLOTS.AURA,
	type = ITEM_TYPES.EQUIPMENT,
	rarity = ITEM_RARITIES.LEGENDARY,
	unlocked_with = {
		other = "season_6",
	},
	particles = {
		{
			path = "particles/cosmetic/auras/dragon_aura/dragon_aura.vpcf",
			attach_type = PATTACH_POINT_FOLLOW,
			control_points = {
				[0] = {
					attach_type = PATTACH_POINT_FOLLOW,
					attachment = "none",
				},
			},
		},
	},
	is_hidden = true,
}

ITEM_DEFINITIONS["season_6_silver_wings"] = {
	slot = INVENTORY_SLOTS.AURA,
	type = ITEM_TYPES.EQUIPMENT,
	rarity = ITEM_RARITIES.UNIQUE,
	unlocked_with = {
		other = "season_6",
	},
	particles = {
		{
			path = "particles/cosmetic/auras/season_6_silver_wings/season_6_silver_wings.vpcf",
			attach_type = PATTACH_ABSORIGIN_FOLLOW,
			control_points = {
				[0] = {
					attach_type = PATTACH_ABSORIGIN_FOLLOW,
					attachment = "attach_hitloc",
				},
			},
		},
	},
	is_hidden = true,
}

ITEM_DEFINITIONS["season_6_golden_wings"] = {
	slot = INVENTORY_SLOTS.AURA,
	type = ITEM_TYPES.EQUIPMENT,
	rarity = ITEM_RARITIES.UNIQUE,
	unlocked_with = {
		other = "season_6",
	},
	particles = {
		{
			path = "particles/cosmetic/auras/season_6_golden_wings/season_6_golden_wings.vpcf",
			attach_type = PATTACH_ABSORIGIN_FOLLOW,
			control_points = {
				[0] = {
					attach_type = PATTACH_ABSORIGIN_FOLLOW,
					attachment = "attach_hitloc",
				},
			},
		},
	},
	is_hidden = true,
}

ITEM_DEFINITIONS["season_7_top_100_aura"] = {
	slot = INVENTORY_SLOTS.AURA,
	type = ITEM_TYPES.EQUIPMENT,
	rarity = ITEM_RARITIES.IMMORTAL,
	unlocked_with = {
		other = "season_7",
	},
	particles = {
		{
			path = "particles/cosmetic/auras/season_7/season_7_top_100/season_7_top_100_aura.vpcf",
			attach_type = PATTACH_POINT_FOLLOW,
			control_points = {
				[0] = {
					attach_type = PATTACH_POINT_FOLLOW,
					attachment = "none",
				},
			},
		},
	},
	is_hidden = true,
}

ITEM_DEFINITIONS["season_7_top_25_aura"] = {
	slot = INVENTORY_SLOTS.AURA,
	type = ITEM_TYPES.EQUIPMENT,
	rarity = ITEM_RARITIES.ARCANA,
	unlocked_with = {
		other = "season_7",
	},
	particles = {
		{
			path = "particles/cosmetic/auras/season_7/season_7_top_25/season_7_top_25_aura.vpcf",
			attach_type = PATTACH_POINT_FOLLOW,
			control_points = {
				[0] = {
					attach_type = PATTACH_POINT_FOLLOW,
					attachment = "none",
				},
			},
		},
	},
	is_hidden = true,
}

ITEM_DEFINITIONS["season_7_top_10_aura"] = {
	slot = INVENTORY_SLOTS.AURA,
	type = ITEM_TYPES.EQUIPMENT,
	rarity = ITEM_RARITIES.UNIQUE,
	unlocked_with = {
		other = "season_7",
	},
	particles = {
		{
			path = "particles/cosmetic/auras/season_7/season_7_top_10/season_7_top_10_aura.vpcf",
			attach_type = PATTACH_POINT_FOLLOW,
			control_points = {
				[0] = {
					attach_type = PATTACH_POINT_FOLLOW,
					attachment = "none",
				},
			},
		},
	},
	is_hidden = true,
}

ITEM_DEFINITIONS["season_7_top_3_aura"] = {
	slot = INVENTORY_SLOTS.AURA,
	type = ITEM_TYPES.EQUIPMENT,
	rarity = ITEM_RARITIES.UNIQUE,
	unlocked_with = {
		other = "season_7",
	},
	particles = {
		{
			path = "particles/cosmetic/auras/season_7/season_7_top_3/season_7_top_3_aura.vpcf",
			attach_type = PATTACH_POINT_FOLLOW,
			control_points = {
				[0] = {
					attach_type = PATTACH_POINT_FOLLOW,
					attachment = "none",
				},
			},
		},
	},
	is_hidden = true,
}

ITEM_DEFINITIONS["season_8_top_100_aura"] = {
	slot = INVENTORY_SLOTS.AURA,
	type = ITEM_TYPES.EQUIPMENT,
	rarity = ITEM_RARITIES.IMMORTAL,
	unlocked_with = {
		other = "season_8",
	},
	particles = {
		{
			path = "particles/cosmetic/auras/season_8/season_8_top_100/season_8_top_100.vpcf",
			attach_type = PATTACH_POINT_FOLLOW,
			control_points = {
				[0] = {
					attach_type = PATTACH_POINT_FOLLOW,
					attachment = "none",
				},
			},
		},
	},
	is_hidden = true,
}

ITEM_DEFINITIONS["season_8_top_25_aura"] = {
	slot = INVENTORY_SLOTS.AURA,
	type = ITEM_TYPES.EQUIPMENT,
	rarity = ITEM_RARITIES.ARCANA,
	unlocked_with = {
		other = "season_8",
	},
	particles = {
		{
			path = "particles/cosmetic/auras/season_8/season_8_top_25/season_8_top_25.vpcf",
			attach_type = PATTACH_POINT_FOLLOW,
			control_points = {
				[0] = {
					attach_type = PATTACH_POINT_FOLLOW,
					attachment = "none",
				},
			},
		},
	},
	is_hidden = true,
}

ITEM_DEFINITIONS["season_8_top_10_aura"] = {
	slot = INVENTORY_SLOTS.AURA,
	type = ITEM_TYPES.EQUIPMENT,
	rarity = ITEM_RARITIES.UNIQUE,
	unlocked_with = {
		other = "season_8",
	},
	particles = {
		{
			path = "particles/cosmetic/auras/season_8/season_8_top_10/season_8_top_10.vpcf",
			attach_type = PATTACH_POINT_FOLLOW,
			control_points = {
				[0] = {
					attach_type = PATTACH_POINT_FOLLOW,
					attachment = "none",
				},
			},
		},
	},
	is_hidden = true,
}

ITEM_DEFINITIONS["season_8_top_3_aura"] = {
	slot = INVENTORY_SLOTS.AURA,
	type = ITEM_TYPES.EQUIPMENT,
	rarity = ITEM_RARITIES.UNIQUE,
	unlocked_with = {
		other = "season_8",
	},
	particles = {
		{
			path = "particles/cosmetic/auras/season_8/season_8_top_3/season_8_top_3.vpcf",
			attach_type = PATTACH_POINT_FOLLOW,
			control_points = {
				[0] = {
					attach_type = PATTACH_POINT_FOLLOW,
					attachment = "none",
				},
			},
		},
	},
	is_hidden = true,
}

ITEM_DEFINITIONS["aaf_promo_gold"] = {
	slot = INVENTORY_SLOTS.AURA,
	type = ITEM_TYPES.EQUIPMENT,
	rarity = ITEM_RARITIES.IMMORTAL,
	unlocked_with = {
		other = "aaf_release_promo",
	},
	particles = {
		{
			path = "particles/cosmetic/auras/aaf_crosspromo/gold_back_ring_origin.vpcf",
			attach_type = PATTACH_ABSORIGIN_FOLLOW,
			control_points = {
				[0] = {
					attach_type = PATTACH_POINT_FOLLOW,
					attachment = "none",
				},
			},
		},
	},
	is_hidden = true,
}

ITEM_DEFINITIONS["aaf_promo_angel"] = {
	slot = INVENTORY_SLOTS.AURA,
	type = ITEM_TYPES.EQUIPMENT,
	rarity = ITEM_RARITIES.IMMORTAL,
	unlocked_with = {
		other = "aaf_release_promo",
	},
	particles = {
		{
			path = "particles/cosmetic/auras/aaf_crosspromo/angel_back_ring_origin.vpcf",
			attach_type = PATTACH_ABSORIGIN_FOLLOW,
			control_points = {
				[0] = {
					attach_type = PATTACH_POINT_FOLLOW,
					attachment = "none",
				},
			},
		},
	},
	is_hidden = true,
}

ITEM_DEFINITIONS["aaf_promo_devil"] = {
	slot = INVENTORY_SLOTS.AURA,
	type = ITEM_TYPES.EQUIPMENT,
	rarity = ITEM_RARITIES.IMMORTAL,
	unlocked_with = {
		other = "aaf_release_promo",
	},
	particles = {
		{
			path = "particles/cosmetic/auras/aaf_crosspromo/devil_back_ring_origin.vpcf",
			attach_type = PATTACH_ABSORIGIN_FOLLOW,
			control_points = {
				[0] = {
					attach_type = PATTACH_POINT_FOLLOW,
					attachment = "none",
				},
			},
		},
	},
	is_hidden = true,
}

ITEM_DEFINITIONS["season_9_top_100_aura"] = {
	slot = INVENTORY_SLOTS.AURA,
	type = ITEM_TYPES.EQUIPMENT,
	rarity = ITEM_RARITIES.UNIQUE,
	unlocked_with = {
		other = "season_9",
	},
	particles = {
		{
			path = "particles/cosmetic/auras/season_9/season_9_top_100.vpcf",
			attach_type = PATTACH_POINT_FOLLOW,
			control_points = {
				[0] = {
					attach_type = PATTACH_POINT_FOLLOW,
					attachment = "none",
				},
			},
		},
	},
	is_hidden = true,
}
ITEM_DEFINITIONS["season_9_top_25_aura"] = {
	slot = INVENTORY_SLOTS.AURA,
	type = ITEM_TYPES.EQUIPMENT,
	rarity = ITEM_RARITIES.UNIQUE,
	unlocked_with = {
		other = "season_9",
	},
	particles = {
		{
			path = "particles/cosmetic/auras/season_9/season_9_top_25/season_9_top_25.vpcf",
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
	is_hidden = true,
}
ITEM_DEFINITIONS["season_9_top_10_aura"] = {
	slot = INVENTORY_SLOTS.AURA,
	type = ITEM_TYPES.EQUIPMENT,
	rarity = ITEM_RARITIES.UNIQUE,
	unlocked_with = {
		other = "season_9",
	},
	particles = {
		{
			path = "particles/cosmetic/auras/season_9/season_9_top_10.vpcf",
			attach_type = PATTACH_POINT_FOLLOW,
			control_points = {
				[0] = {
					attach_type = PATTACH_POINT_FOLLOW,
					attachment = "none",
				},
			},
		},
	},
	is_hidden = true,
}
ITEM_DEFINITIONS["season_9_top_3_aura"] = {
	slot = INVENTORY_SLOTS.AURA,
	type = ITEM_TYPES.EQUIPMENT,
	rarity = ITEM_RARITIES.UNIQUE,
	unlocked_with = {
		other = "season_9",
	},
	particles = {
		{
			path = "particles/cosmetic/auras/season_9/season_9_top_3/season_9_top_3.vpcf",
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
	is_hidden = true,
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