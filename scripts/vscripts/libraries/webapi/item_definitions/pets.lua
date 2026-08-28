--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 0b85d8d 
  ~ auto-generated — do not edit
]]


ITEM_DEFINITIONS["chicken_pet"] = {
	slot = INVENTORY_SLOTS.PET,
	type = ITEM_TYPES.EQUIPMENT,
	rarity = ITEM_RARITIES.COMMON,
	unlocked_with = {
		treasure = "treasure_starter",
	},
	model_path = "models/items/courier/mighty_chicken/mighty_chicken.vmdl",
	model_scale = 1,
}

ITEM_DEFINITIONS["roshan_pet"] = {
	slot = INVENTORY_SLOTS.PET,
	type = ITEM_TYPES.EQUIPMENT,
	rarity = ITEM_RARITIES.IMMORTAL,
	unlocked_with = {
		subscription_tier = 2,
	},
	model_path = "models/courier/baby_rosh/babyroshan_ti10_dire.vmdl",
	model_scale = 0.95,
	particles = {
		{
			path = "particles/econ/courier/courier_babyroshan_ti10/courier_babyroshan_ti10_dire_ambient.vpcf",
			attach_type = PATTACH_RENDERORIGIN_FOLLOW,
		},
	},
}

ITEM_DEFINITIONS["red_dragon"] = {
	slot = INVENTORY_SLOTS.PET,
	type = ITEM_TYPES.EQUIPMENT,
	rarity = ITEM_RARITIES.UNCOMMON,
	unlocked_with = {
		treasure = "treasure_starter",
	},
	model_path = "models/courier/baby_winter_wyvern/baby_winter_wyvern.vmdl",
	model_scale = 1.05,
	material_group = "1",
	particles = {
		{
			path = "particles/econ/courier/courier_wyvern_hatchling/courier_wyvern_hatchling_fire.vpcf",
			attach_type = PATTACH_RENDERORIGIN_FOLLOW,
		},
	},
}

ITEM_DEFINITIONS["gold_dragon"] = {
	slot = INVENTORY_SLOTS.PET,
	type = ITEM_TYPES.EQUIPMENT,
	rarity = ITEM_RARITIES.IMMORTAL,
	unlocked_with = {
		subscription_tier = 1,
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
					attach_type = PATTACH_ROOTBONE_FOLLOW,
					attachment = "attach_fx",
				},
			},
		},
	},
}

ITEM_DEFINITIONS["platinum_roshan"] = {
	slot = INVENTORY_SLOTS.PET,
	type = ITEM_TYPES.EQUIPMENT,
	rarity = ITEM_RARITIES.ARCANA,
	unlocked_with = {
		currency = 99999,
	},
	model_path = "models/courier/baby_rosh/babyroshan_alt.vmdl",
	model_scale = 0.8,
	material_group = "2",
	particles = {
		{
			path = "particles/econ/courier/courier_babyrosh_alt_ti8/courier_babyrosh_alt_ti8.vpcf",
			attach_type = PATTACH_RENDERORIGIN_FOLLOW,
		},
	},
	is_hidden = true,
}

ITEM_DEFINITIONS["pet_spider"] = {
	slot = INVENTORY_SLOTS.PET,
	type = ITEM_TYPES.EQUIPMENT,
	rarity = ITEM_RARITIES.COMMON,
	unlocked_with = {
		treasure = "treasure_starter",
	},
	model_path = "models/items/courier/itsy/itsy.vmdl",
	model_scale = 0.9,
}

ITEM_DEFINITIONS["devourling"] = {
	slot = INVENTORY_SLOTS.PET,
	type = ITEM_TYPES.EQUIPMENT,
	rarity = ITEM_RARITIES.COMMON,
	unlocked_with = {
		treasure = "treasure_collection_1",
	},
	model_path = "models/items/courier/devourling/devourling.vmdl",
	model_scale = 1.1,
	particles = {
		{
			path = "particles/econ/courier/courier_devourling/courier_devourling_ambient.vpcf",
			attach_type = PATTACH_RENDERORIGIN_FOLLOW,
		},
	},
}

ITEM_DEFINITIONS["seekling"] = {
	slot = INVENTORY_SLOTS.PET,
	type = ITEM_TYPES.EQUIPMENT,
	rarity = ITEM_RARITIES.COMMON,
	unlocked_with = {
		treasure = "treasure_starter",
	},
	model_path = "models/courier/seekling/seekling.vmdl",
	model_scale = 1.1,
}

ITEM_DEFINITIONS["pudgling"] = {
	slot = INVENTORY_SLOTS.PET,
	type = ITEM_TYPES.EQUIPMENT,
	rarity = ITEM_RARITIES.COMMON,
	unlocked_with = {
		treasure = "treasure_starter",
	},
	model_path = "models/courier/minipudge/minipudge.vmdl",
	model_scale = 1,
}

ITEM_DEFINITIONS["doomling"] = {
	slot = INVENTORY_SLOTS.PET,
	type = ITEM_TYPES.EQUIPMENT,
	rarity = ITEM_RARITIES.COMMON,
	unlocked_with = {
		treasure = "treasure_collection_1",
	},
	model_path = "models/courier/doom_demihero_courier/doom_demihero_courier.vmdl",
	model_scale = 1,
	particles = {
		{
			path = "particles/econ/courier/courier_doomling/courier_doomling_ambient.vpcf",
			attach_type = PATTACH_RENDERORIGIN_FOLLOW,
		},
	},
}

ITEM_DEFINITIONS["huntling"] = {
	slot = INVENTORY_SLOTS.PET,
	type = ITEM_TYPES.EQUIPMENT,
	rarity = ITEM_RARITIES.COMMON,
	unlocked_with = {
		treasure = "treasure_starter",
	},
	model_path = "models/courier/huntling/huntling.vmdl",
	model_scale = 1,
}

ITEM_DEFINITIONS["venoling"] = {
	slot = INVENTORY_SLOTS.PET,
	type = ITEM_TYPES.EQUIPMENT,
	rarity = ITEM_RARITIES.COMMON,
	unlocked_with = {
		treasure = "treasure_starter",
	},
	model_path = "models/courier/venoling/venoling.vmdl",
	model_scale = 0.9,
	material_group = "0",
	particles = {
		{
			path = "particles/econ/courier/courier_venoling/courier_venoling_ambient.vpcf",
			attach_type = PATTACH_RENDERORIGIN_FOLLOW,
		},
	},
}

ITEM_DEFINITIONS["voidling"] = {
	slot = INVENTORY_SLOTS.PET,
	type = ITEM_TYPES.EQUIPMENT,
	rarity = ITEM_RARITIES.RARE,
	unlocked_with = {
		treasure = "treasure_collection_1",
	},
	model_path = "models/items/courier/faceless_rex/faceless_rex.vmdl",
	model_scale = 1.1,
}

ITEM_DEFINITIONS["lunaling"] = {
	slot = INVENTORY_SLOTS.PET,
	type = ITEM_TYPES.EQUIPMENT,
	rarity = ITEM_RARITIES.RARE,
	unlocked_with = {
		treasure = "treasure_collection_1",
	},
	model_path = "models/items/courier/lilnova/lilnova.vmdl",
	model_scale = 1.1,
}

ITEM_DEFINITIONS["butch"] = {
	slot = INVENTORY_SLOTS.PET,
	type = ITEM_TYPES.EQUIPMENT,
	rarity = ITEM_RARITIES.UNCOMMON,
	unlocked_with = {
		treasure = "treasure_collection_1",
	},
	model_path = "models/items/courier/butch_pudge_dog/butch_pudge_dog.vmdl",
	model_scale = 1,
}

ITEM_DEFINITIONS["wyvern"] = {
	slot = INVENTORY_SLOTS.PET,
	type = ITEM_TYPES.EQUIPMENT,
	rarity = ITEM_RARITIES.MYTHICAL,
	unlocked_with = {
		treasure = "treasure_collection_1",
	},
	model_path = "models/items/mirana/ti8_wyvernmount/ti8_wyvernmount.vmdl",
	model_scale = 0.6,
}

ITEM_DEFINITIONS["almond_the_frondillo"] = {
	slot = INVENTORY_SLOTS.PET,
	type = ITEM_TYPES.EQUIPMENT,
	rarity = ITEM_RARITIES.RARE,
	unlocked_with = {
		treasure = "treasure_starter",
	},
	model_path = "models/pets/armadillo/armadillo.vmdl",
	model_scale = 1,
	material_group = "1",
}

ITEM_DEFINITIONS["mechanical_spider"] = {
	slot = INVENTORY_SLOTS.PET,
	type = ITEM_TYPES.EQUIPMENT,
	rarity = ITEM_RARITIES.COMMON,
	unlocked_with = {
		treasure = "treasure_starter",
	},
	model_path = "models/items/broodmother/spiderling/ti9_cache_brood_mother_of_thousands_spiderling/ti9_cache_brood_mother_of_thousands_spiderling.vmdl",
	model_scale = 0.4,
}

ITEM_DEFINITIONS["ice_spider"] = {
	slot = INVENTORY_SLOTS.PET,
	type = ITEM_TYPES.EQUIPMENT,
	rarity = ITEM_RARITIES.COMMON,
	unlocked_with = {
		treasure = "treasure_winter",
	},
	model_path = "models/items/broodmother/spiderling/the_glacial_creeper_creepling/the_glacial_creeper_creepling.vmdl",
	model_scale = 0.4,
}

ITEM_DEFINITIONS["coconut_warrior"] = {
	slot = INVENTORY_SLOTS.PET,
	type = ITEM_TYPES.EQUIPMENT,
	rarity = ITEM_RARITIES.UNCOMMON,
	unlocked_with = {
		treasure = "treasure_collection_1",
	},
	model_path = "models/items/furion/treant/defender_of_the_jungle_lakad_coconut/defender_of_the_jungle_lakad_coconut.vmdl",
	model_scale = 0.7,
}

ITEM_DEFINITIONS["shroomling"] = {
	slot = INVENTORY_SLOTS.PET,
	type = ITEM_TYPES.EQUIPMENT,
	rarity = ITEM_RARITIES.COMMON,
	unlocked_with = {
		treasure = "treasure_starter",
	},
	model_path = "models/items/furion/treant/shroomling_treant/shroomling_treant.vmdl",
	model_scale = 1,
}

ITEM_DEFINITIONS["luminaries"] = {
	slot = INVENTORY_SLOTS.PET,
	type = ITEM_TYPES.EQUIPMENT,
	rarity = ITEM_RARITIES.UNCOMMON,
	unlocked_with = {
		treasure = "treasure_collection_1",
	},
	model_path = "models/items/enigma/eidolon/ti9_cache_enigma_lord_of_luminaries_eidolons/ti9_cache_enigma_lord_of_luminaries_eidolons.vmdl",
	model_scale = 0.9,
}

ITEM_DEFINITIONS["baby_roshan"] = {
	slot = INVENTORY_SLOTS.PET,
	type = ITEM_TYPES.EQUIPMENT,
	rarity = ITEM_RARITIES.LEGENDARY,
	unlocked_with = {
		treasure = "treasure_starter",
	},
	model_path = "models/courier/baby_rosh/babyroshan.vmdl",
	model_scale = 0.8,
	material_group = "0",
}

ITEM_DEFINITIONS["baby_roshan_golden"] = {
	slot = INVENTORY_SLOTS.PET,
	type = ITEM_TYPES.EQUIPMENT,
	rarity = ITEM_RARITIES.IMMORTAL,
	unlocked_with = {
		currency = 99999,
	},
	model_path = "models/courier/baby_rosh/babyroshan.vmdl",
	model_scale = 0.8,
	material_group = "1",
	is_hidden = true,
}

ITEM_DEFINITIONS["baby_roshan_lava"] = {
	slot = INVENTORY_SLOTS.PET,
	type = ITEM_TYPES.EQUIPMENT,
	rarity = ITEM_RARITIES.ARCANA,
	unlocked_with = {
		currency = 99999,
	},
	model_path = "models/courier/baby_rosh/babyroshan_elemental.vmdl",
	model_scale = 0.8,
	material_group = "1",
	particles = {
		{
			path = "particles/econ/courier/courier_roshan_lava/courier_roshan_lava.vpcf",
			attach_type = PATTACH_RENDERORIGIN_FOLLOW,
		},
	},
	is_hidden = true,
}

ITEM_DEFINITIONS["baby_roshan_ice"] = {
	slot = INVENTORY_SLOTS.PET,
	type = ITEM_TYPES.EQUIPMENT,
	rarity = ITEM_RARITIES.LEGENDARY,
	unlocked_with = {
		treasure = "treasure_winter",
	},
	model_path = "models/courier/baby_rosh/babyroshan_elemental.vmdl",
	model_scale = 0.8,
	material_group = "2",
	particles = {
		{
			path = "particles/econ/courier/courier_roshan_frost/courier_roshan_frost_ambient.vpcf",
			attach_type = PATTACH_RENDERORIGIN_FOLLOW,
		},
	},
}

ITEM_DEFINITIONS["baby_roshan_desert_sand"] = {
	slot = INVENTORY_SLOTS.PET,
	type = ITEM_TYPES.EQUIPMENT,
	rarity = ITEM_RARITIES.ARCANA,
	unlocked_with = {
		currency = 99999,
	},
	model_path = "models/courier/baby_rosh/babyroshan.vmdl",
	model_scale = 0.8,
	material_group = "4",
	particles = {
		{
			path = "particles/econ/courier/courier_roshan_desert_sands/baby_roshan_desert_sands_ambient.vpcf",
			attach_type = PATTACH_RENDERORIGIN_FOLLOW,
		},
	},
	is_hidden = true,
}

ITEM_DEFINITIONS["baby_roshan_collector2017"] = {
	slot = INVENTORY_SLOTS.PET,
	type = ITEM_TYPES.EQUIPMENT,
	rarity = ITEM_RARITIES.ARCANA,
	unlocked_with = {
		currency = 99999,
	},
	model_path = "models/courier/baby_rosh/babyroshan_alt.vmdl",
	model_scale = 0.8,
	material_group = "1",
	particles = {
		{
			path = "particles/econ/courier/courier_babyrosh_alt_ti7/courier_babyrosh_alt_ti7.vpcf",
			attach_type = PATTACH_RENDERORIGIN_FOLLOW,
		},
	},
	is_hidden = true,
}

ITEM_DEFINITIONS["baby_roshan_honey_heist"] = {
	slot = INVENTORY_SLOTS.PET,
	type = ITEM_TYPES.EQUIPMENT,
	rarity = ITEM_RARITIES.LEGENDARY,
	unlocked_with = {
		treasure = "treasure_hallowed_shimmer",
	},
	model_path = "models/courier/baby_rosh/babyroshan_ti9.vmdl",
	model_scale = 0.8,
	particles = {
		{
			path = "particles/econ/courier/courier_babyroshan_ti9/courier_babyroshan_ti9_ambient.vpcf",
			attach_type = PATTACH_RENDERORIGIN_FOLLOW,
		},
	},
}

ITEM_DEFINITIONS["baby_roshan_gingerbread"] = {
	slot = INVENTORY_SLOTS.PET,
	type = ITEM_TYPES.EQUIPMENT,
	rarity = ITEM_RARITIES.ARCANA,
	unlocked_with = {
		currency = 99999,
	},
	model_path = "models/courier/baby_rosh/babyroshan_winter18.vmdl",
	model_scale = 0.8,
	particles = {
		{
			path = "particles/econ/courier/courier_babyroshan_winter18/courier_babyroshan_winter18_ambient.vpcf",
			attach_type = PATTACH_RENDERORIGIN_FOLLOW,
		},
	},
	is_hidden = true,
}

ITEM_DEFINITIONS["strongback_the_swift"] = {
	slot = INVENTORY_SLOTS.PET,
	type = ITEM_TYPES.EQUIPMENT,
	rarity = ITEM_RARITIES.UNCOMMON,
	unlocked_with = {
		treasure = "treasure_starter",
	},
	model_path = "models/courier/donkey_ti7/donkey_ti7.vmdl",
	model_scale = 0.8,
	particles = {
		{
			path = "particles/econ/courier/courier_donkey_ti7/courier_donkey_ti7_ambient.vpcf",
			attach_type = PATTACH_RENDERORIGIN_FOLLOW,
		},
	},
}

ITEM_DEFINITIONS["golden_doomling"] = {
	slot = INVENTORY_SLOTS.PET,
	type = ITEM_TYPES.EQUIPMENT,
	rarity = ITEM_RARITIES.MYTHICAL,
	unlocked_with = {
		treasure = "treasure_collection_1",
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
}

ITEM_DEFINITIONS["golden_huntling"] = {
	slot = INVENTORY_SLOTS.PET,
	type = ITEM_TYPES.EQUIPMENT,
	rarity = ITEM_RARITIES.MYTHICAL,
	unlocked_with = {
		treasure = "treasure_starter",
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
}

ITEM_DEFINITIONS["golden_venoling"] = {
	slot = INVENTORY_SLOTS.PET,
	type = ITEM_TYPES.EQUIPMENT,
	rarity = ITEM_RARITIES.MYTHICAL,
	unlocked_with = {
		treasure = "treasure_starter",
	},
	model_path = "models/courier/venoling/venoling.vmdl",
	model_scale = 0.9,
	material_group = "1",
	particles = {
		{
			path = "particles/econ/courier/courier_venoling_gold/courier_venoling_ambient_gold.vpcf",
			attach_type = PATTACH_RENDERORIGIN_FOLLOW,
		},
	},
}

ITEM_DEFINITIONS["golden_seekling"] = {
	slot = INVENTORY_SLOTS.PET,
	type = ITEM_TYPES.EQUIPMENT,
	rarity = ITEM_RARITIES.MYTHICAL,
	unlocked_with = {
		treasure = "treasure_starter",
	},
	model_path = "models/courier/seekling/seekling.vmdl",
	model_scale = 1.1,
	material_group = "1",
	particles = {
		{
			path = "particles/econ/courier/courier_seekling_gold/courier_seekling_gold_ambient.vpcf",
			attach_type = PATTACH_RENDERORIGIN_FOLLOW,
		},
	},
}

ITEM_DEFINITIONS["golden_devourling"] = {
	slot = INVENTORY_SLOTS.PET,
	type = ITEM_TYPES.EQUIPMENT,
	rarity = ITEM_RARITIES.MYTHICAL,
	unlocked_with = {
		treasure = "treasure_collection_1",
	},
	model_path = "models/items/courier/devourling/devourling.vmdl",
	model_scale = 1.1,
	material_group = "1",
	particles = {
		{
			path = "particles/econ/courier/courier_devourling_gold/courier_devourling_gold_ambient.vpcf",
			attach_type = PATTACH_RENDERORIGIN_FOLLOW,
		},
	},
}

ITEM_DEFINITIONS["golden_greevil"] = {
	slot = INVENTORY_SLOTS.PET,
	type = ITEM_TYPES.EQUIPMENT,
	rarity = ITEM_RARITIES.IMMORTAL,
	unlocked_with = {
		currency = 888,
	},
	model_path = "models/courier/greevil/gold_greevil.vmdl",
	model_scale = 1.1,
	particles = {
		{
			path = "particles/econ/courier/courier_greevil_yellow/courier_greevil_yellow_ambient_3.vpcf",
			attach_type = PATTACH_RENDERORIGIN_FOLLOW,
		},
	},
}

ITEM_DEFINITIONS["golden_beetlejaws"] = {
	slot = INVENTORY_SLOTS.PET,
	type = ITEM_TYPES.EQUIPMENT,
	rarity = ITEM_RARITIES.IMMORTAL,
	unlocked_with = {
		currency = 8888,
	},
	model_path = "models/courier/beetlejaws/mesh/beetlejaws.vmdl",
	model_scale = 1.25,
	material_group = "1",
	particles = {
		{
			path = "particles/econ/courier/courier_beetlejaw/courier_beetlejaw_ambient_gold.vpcf",
			attach_type = PATTACH_RENDERORIGIN_FOLLOW,
		},
		{
			path = "particles/econ/courier/courier_golden_roshan/golden_roshan_ambient.vpcf",
			attach_type = PATTACH_RENDERORIGIN_FOLLOW,
		},
	},
}

ITEM_DEFINITIONS["golden_flopjaw"] = {
	slot = INVENTORY_SLOTS.PET,
	type = ITEM_TYPES.EQUIPMENT,
	rarity = ITEM_RARITIES.IMMORTAL,
	unlocked_with = {
		currency = 88888,
	},
	model_path = "models/courier/flopjaw/flopjaw.vmdl",
	model_scale = 1.5,
	material_group = "1",
	particles = {
		{
			path = "particles/econ/courier/courier_flopjaw_gold/courier_flopjaw_ambient_gold.vpcf",
			attach_type = PATTACH_RENDERORIGIN_FOLLOW,
		},
		{
			path = "particles/econ/events/ti10/emblem/ti10_emblem_effect.vpcf",
			attach_type = PATTACH_RENDERORIGIN_FOLLOW,
		},
	},
}

ITEM_DEFINITIONS["skeleton_warrior"] = {
	slot = INVENTORY_SLOTS.PET,
	type = ITEM_TYPES.EQUIPMENT,
	rarity = ITEM_RARITIES.COMMON,
	unlocked_with = {
		treasure = "treasure_hallowed_shimmer",
	},
	model_path = "models/items/wraith_king/arcana/wk_arcana_skeleton.vmdl",
	model_scale = 1.1,
	particles = {
		{
			path = "particles/wk_arc_minion_ambient.vpcf",
			attach_type = PATTACH_ABSORIGIN_FOLLOW,
		},
	},
}

ITEM_DEFINITIONS["krobeling"] = {
	slot = INVENTORY_SLOTS.PET,
	type = ITEM_TYPES.EQUIPMENT,
	rarity = ITEM_RARITIES.COMMON,
	unlocked_with = {
		treasure = "treasure_hallowed_shimmer",
	},
	model_path = "models/items/courier/krobeling/krobeling.vmdl",
	model_scale = 1.1,
	particles = {
		{
			path = "particles/econ/courier/courier_krobeling/courier_krobeling_ambient_hair.vpcf",
			attach_type = PATTACH_RENDERORIGIN_FOLLOW,
		},
	},
}

ITEM_DEFINITIONS["golden_krobeling"] = {
	slot = INVENTORY_SLOTS.PET,
	type = ITEM_TYPES.EQUIPMENT,
	rarity = ITEM_RARITIES.MYTHICAL,
	unlocked_with = {
		treasure = "treasure_hallowed_shimmer",
	},
	model_path = "models/items/courier/krobeling_gold/krobeling_gold.vmdl",
	model_scale = 1.1,
	particles = {
		{
			path = "particles/econ/courier/courier_krobeling_gold/courier_krobeling_gold_ambient.vpcf",
			attach_type = PATTACH_RENDERORIGIN_FOLLOW,
		},
	},
}

ITEM_DEFINITIONS["scatter_brains"] = {
	slot = INVENTORY_SLOTS.PET,
	type = ITEM_TYPES.EQUIPMENT,
	rarity = ITEM_RARITIES.COMMON,
	unlocked_with = {
		treasure = "treasure_hallowed_shimmer",
	},
	model_path = "models/items/courier/calabaxa_courier/calabaxa_courier.vmdl",
	model_scale = 1,
}

ITEM_DEFINITIONS["hallowed_horde"] = {
	slot = INVENTORY_SLOTS.PET,
	type = ITEM_TYPES.EQUIPMENT,
	rarity = ITEM_RARITIES.COMMON,
	unlocked_with = {
		treasure = "treasure_hallowed_shimmer",
	},
	model_path = "models/items/furion/treant/hallowed_horde/hallowed_horde.vmdl",
	model_scale = 0.7,
}

ITEM_DEFINITIONS["fraidy_jack"] = {
	slot = INVENTORY_SLOTS.PET,
	type = ITEM_TYPES.EQUIPMENT,
	rarity = ITEM_RARITIES.COMMON,
	unlocked_with = {
		treasure = "treasure_hallowed_shimmer",
	},
	model_path = "models/items/courier/little_fraid_the_courier_of_simons_retribution/little_fraid_the_courier_of_simons_retribution.vmdl",
	model_scale = 1.1,
}

ITEM_DEFINITIONS["spooly"] = {
	slot = INVENTORY_SLOTS.PET,
	type = ITEM_TYPES.EQUIPMENT,
	rarity = ITEM_RARITIES.COMMON,
	unlocked_with = {
		treasure = "treasure_hallowed_shimmer",
	},
	model_path = "models/items/courier/courier_fall20/courier_fall20.vmdl",
	model_scale = 0.8,
	particles = {
		{
			path = "particles/econ/events/diretide_2020/courier_spooky_ambient/courier_spooky_ambient.vpcf",
			attach_type = PATTACH_RENDERORIGIN_FOLLOW,
		},
	},
}

ITEM_DEFINITIONS["wraith_spider"] = {
	slot = INVENTORY_SLOTS.PET,
	type = ITEM_TYPES.EQUIPMENT,
	rarity = ITEM_RARITIES.UNCOMMON,
	unlocked_with = {
		treasure = "treasure_hallowed_shimmer",
	},
	model_path = "models/items/broodmother/spiderling/lycosidae_spiderling/lycosidae_spiderling.vmdl",
	model_scale = 0.4,
}

ITEM_DEFINITIONS["hollow_jack"] = {
	slot = INVENTORY_SLOTS.PET,
	type = ITEM_TYPES.EQUIPMENT,
	rarity = ITEM_RARITIES.UNCOMMON,
	unlocked_with = {
		treasure = "treasure_hallowed_shimmer",
	},
	model_path = "models/items/courier/pumpkin_courier/pumpkin_courier.vmdl",
	model_scale = 1.1,
}

ITEM_DEFINITIONS["wraith_warrior_green"] = {
	slot = INVENTORY_SLOTS.PET,
	type = ITEM_TYPES.EQUIPMENT,
	rarity = ITEM_RARITIES.UNCOMMON,
	unlocked_with = {
		treasure = "treasure_hallowed_shimmer",
	},
	model_path = "models/items/wraith_king/wk_ti8_creep/wk_ti8_creep.vmdl",
	model_scale = 1.1,
}

ITEM_DEFINITIONS["wraith_warrior_red"] = {
	slot = INVENTORY_SLOTS.PET,
	type = ITEM_TYPES.EQUIPMENT,
	rarity = ITEM_RARITIES.UNCOMMON,
	unlocked_with = {
		treasure = "treasure_hallowed_shimmer",
	},
	model_path = "models/items/wraith_king/wk_ti8_creep/wk_ti8_creep_crimson.vmdl",
	model_scale = 1.1,
}

ITEM_DEFINITIONS["scuttling_scotty"] = {
	slot = INVENTORY_SLOTS.PET,
	type = ITEM_TYPES.EQUIPMENT,
	rarity = ITEM_RARITIES.COMMON,
	unlocked_with = {
		treasure = "treasure_winter",
	},
	model_path = "models/items/courier/scuttling_scotty_penguin/scuttling_scotty_penguin.vmdl",
	model_scale = 1.3,
	is_hidden = true,
}

ITEM_DEFINITIONS["snowl"] = {
	slot = INVENTORY_SLOTS.PET,
	type = ITEM_TYPES.EQUIPMENT,
	rarity = ITEM_RARITIES.COMMON,
	unlocked_with = {
		treasure = "treasure_winter",
	},
	model_path = "models/items/courier/snowl/snowl.vmdl",
	model_scale = 1.2,
}

ITEM_DEFINITIONS["serac_the_seal"] = {
	slot = INVENTORY_SLOTS.PET,
	type = ITEM_TYPES.EQUIPMENT,
	rarity = ITEM_RARITIES.COMMON,
	unlocked_with = {
		treasure = "treasure_winter",
	},
	model_path = "models/items/courier/frostivus2018_courier_serac_the_seal/frostivus2018_courier_serac_the_seal.vmdl",
	model_scale = 1,
}

ITEM_DEFINITIONS["blue_dragon"] = {
	slot = INVENTORY_SLOTS.PET,
	type = ITEM_TYPES.EQUIPMENT,
	rarity = ITEM_RARITIES.UNCOMMON,
	unlocked_with = {
		treasure = "treasure_winter",
	},
	model_path = "models/courier/baby_winter_wyvern/baby_winter_wyvern.vmdl",
	model_scale = 1,
	material_group = "0",
	particles = {
		{
			path = "particles/econ/courier/courier_wyvern_hatchling/courier_wyvern_hatchling_ice.vpcf",
			attach_type = PATTACH_RENDERORIGIN_FOLLOW,
		},
	},
}

ITEM_DEFINITIONS["throe"] = {
	slot = INVENTORY_SLOTS.PET,
	type = ITEM_TYPES.EQUIPMENT,
	rarity = ITEM_RARITIES.COMMON,
	unlocked_with = {
		treasure = "treasure_winter",
	},
	model_path = "models/items/courier/throe/throe.vmdl",
	model_scale = 0.8,
}

ITEM_DEFINITIONS["duskie"] = {
	slot = INVENTORY_SLOTS.PET,
	type = ITEM_TYPES.EQUIPMENT,
	rarity = ITEM_RARITIES.COMMON,
	unlocked_with = {
		treasure = "treasure_winter",
	},
	model_path = "models/items/courier/duskie/duskie.vmdl",
	model_scale = 1,
}

ITEM_DEFINITIONS["icewrack_wolf"] = {
	slot = INVENTORY_SLOTS.PET,
	type = ITEM_TYPES.EQUIPMENT,
	rarity = ITEM_RARITIES.MYTHICAL,
	unlocked_with = {
		treasure = "treasure_winter",
	},
	model_path = "models/pets/icewrack_wolf/icewrack_wolf.vmdl",
	model_scale = 1.2,
}

ITEM_DEFINITIONS["wabbit"] = {
	slot = INVENTORY_SLOTS.PET,
	type = ITEM_TYPES.EQUIPMENT,
	rarity = ITEM_RARITIES.UNCOMMON,
	unlocked_with = {
		treasure = "treasure_winter",
	},
	model_path = "models/items/courier/wabbit_the_mighty_courier_of_heroes/wabbit_the_mighty_courier_of_heroes.vmdl",
	model_scale = 1,
	material_group = "0",
	particles = {
		{
			path = "particles/econ/courier/courier_wabbit/courier_wabbit_ambient_lvl1.vpcf",
			attach_type = PATTACH_RENDERORIGIN_FOLLOW,
		},
	},
}

ITEM_DEFINITIONS["wabbit_the_mighty"] = {
	slot = INVENTORY_SLOTS.PET,
	type = ITEM_TYPES.EQUIPMENT,
	rarity = ITEM_RARITIES.MYTHICAL,
	unlocked_with = {
		treasure = "treasure_winter",
	},
	model_path = "models/items/courier/wabbit_the_mighty_courier_of_heroes/wabbit_the_mighty_courier_of_heroes_flying.vmdl",
	model_scale = 1,
	material_group = "3",
	particles = {
		{
			path = "particles/econ/courier/courier_wabbit/courier_wabbit_ambient_lvl3.vpcf",
			attach_type = PATTACH_RENDERORIGIN_FOLLOW,
		},
	},
}

ITEM_DEFINITIONS["bearling"] = {
	slot = INVENTORY_SLOTS.PET,
	type = ITEM_TYPES.EQUIPMENT,
	rarity = ITEM_RARITIES.UNCOMMON,
	unlocked_with = {
		treasure = "treasure_winter",
	},
	model_path = "models/items/courier/bearzky_v2/bearzky_v2.vmdl",
	model_scale = 1,
}

ITEM_DEFINITIONS["boreal_sigil"] = {
	slot = INVENTORY_SLOTS.PET,
	type = ITEM_TYPES.EQUIPMENT,
	rarity = ITEM_RARITIES.UNCOMMON,
	unlocked_with = {
		treasure = "treasure_winter",
	},
	model_path = "models/items/courier/basim/basim_flying.vmdl",
	model_scale = 0.95,
}

ITEM_DEFINITIONS["redhorn"] = {
	slot = INVENTORY_SLOTS.PET,
	type = ITEM_TYPES.EQUIPMENT,
	rarity = ITEM_RARITIES.COMMON,
	unlocked_with = {
		treasure = "treasure_newbloom",
	},
	model_path = "models/courier/ram/ram.vmdl",
	model_scale = 0.9,
	material_group = "0",
	particles = {
		{
			path = "particles/econ/courier/courier_red_horn/courier_red_horn_ambient.vpcf",
			attach_type = PATTACH_RENDERORIGIN_FOLLOW,
		},
	},
	is_hidden = true,
}

ITEM_DEFINITIONS["jade_dragon"] = {
	slot = INVENTORY_SLOTS.PET,
	type = ITEM_TYPES.EQUIPMENT,
	rarity = ITEM_RARITIES.COMMON,
	unlocked_with = {
		treasure = "treasure_newbloom",
	},
	model_path = "models/items/courier/green_jade_dragon/green_jade_dragon.vmdl",
	model_scale = 0.95,
	is_hidden = true,
}

ITEM_DEFINITIONS["azuremir"] = {
	slot = INVENTORY_SLOTS.PET,
	type = ITEM_TYPES.EQUIPMENT,
	rarity = ITEM_RARITIES.COMMON,
	unlocked_with = {
		treasure = "treasure_newbloom",
	},
	model_path = "models/items/courier/azuremircourierfinal/azuremircourierfinal_flying.vmdl",
	model_scale = 0.9,
	is_hidden = true,
}

ITEM_DEFINITIONS["teron"] = {
	slot = INVENTORY_SLOTS.PET,
	type = ITEM_TYPES.EQUIPMENT,
	rarity = ITEM_RARITIES.COMMON,
	unlocked_with = {
		treasure = "treasure_newbloom",
	},
	model_path = "models/items/courier/teron/teron.vmdl",
	model_scale = 1.2,
	is_hidden = true,
}

ITEM_DEFINITIONS["redhoof"] = {
	slot = INVENTORY_SLOTS.PET,
	type = ITEM_TYPES.EQUIPMENT,
	rarity = ITEM_RARITIES.UNCOMMON,
	unlocked_with = {
		treasure = "treasure_newbloom",
	},
	model_path = "models/courier/godhorse/godhorse.vmdl",
	model_scale = 0.85,
	material_group = "0",
	is_hidden = true,
}

ITEM_DEFINITIONS["gama_brothers"] = {
	slot = INVENTORY_SLOTS.PET,
	type = ITEM_TYPES.EQUIPMENT,
	rarity = ITEM_RARITIES.UNCOMMON,
	unlocked_with = {
		treasure = "treasure_newbloom",
	},
	model_path = "models/items/courier/gama_brothers/gama_brothers.vmdl",
	model_scale = 0.9,
	is_hidden = true,
}

ITEM_DEFINITIONS["nian_courier"] = {
	slot = INVENTORY_SLOTS.PET,
	type = ITEM_TYPES.EQUIPMENT,
	rarity = ITEM_RARITIES.RARE,
	unlocked_with = {
		treasure = "treasure_newbloom",
	},
	model_path = "models/items/courier/nian_courier/nian_courier.vmdl",
	model_scale = 0.9,
	particles = {
		{
			path = "particles/econ/courier/courier_nian/courier_nian_ambient.vpcf",
			attach_type = PATTACH_RENDERORIGIN_FOLLOW,
		},
	},
	is_hidden = true,
}

ITEM_DEFINITIONS["jadehorn"] = {
	slot = INVENTORY_SLOTS.PET,
	type = ITEM_TYPES.EQUIPMENT,
	rarity = ITEM_RARITIES.RARE,
	unlocked_with = {
		treasure = "treasure_newbloom",
	},
	model_path = "models/courier/ram/ram.vmdl",
	model_scale = 0.9,
	material_group = "1",
	particles = {
		{
			path = "particles/econ/courier/courier_jade_horn/courier_jade_horn_ambient.vpcf",
			attach_type = PATTACH_RENDERORIGIN_FOLLOW,
		},
	},
	is_hidden = true,
}

ITEM_DEFINITIONS["jadehoof"] = {
	slot = INVENTORY_SLOTS.PET,
	type = ITEM_TYPES.EQUIPMENT,
	rarity = ITEM_RARITIES.MYTHICAL,
	unlocked_with = {
		treasure = "treasure_newbloom",
	},
	model_path = "models/courier/godhorse/godhorse.vmdl",
	model_scale = 0.85,
	material_group = "1",
	particles = {
		{
			path = "particles/econ/courier/courier_jadehoof_ambient/jadehoof_ambient.vpcf",
			attach_type = PATTACH_RENDERORIGIN_FOLLOW,
		},
	},
	is_hidden = true,
}

ITEM_DEFINITIONS["baby_roshan_jade"] = {
	slot = INVENTORY_SLOTS.PET,
	type = ITEM_TYPES.EQUIPMENT,
	rarity = ITEM_RARITIES.LEGENDARY,
	unlocked_with = {
		treasure = "treasure_newbloom",
	},
	model_path = "models/courier/baby_rosh/babyroshan.vmdl",
	model_scale = 0.8,
	material_group = "5",
	particles = {
		{
			path = "particles/econ/courier/courier_roshan_ti8/courier_roshan_ti8.vpcf",
			attach_type = PATTACH_RENDERORIGIN_FOLLOW,
		},
	},
	is_hidden = true,
}

ITEM_DEFINITIONS["scotty_christmas_2023"] = {
	slot = INVENTORY_SLOTS.PET,
	type = ITEM_TYPES.EQUIPMENT,
	rarity = ITEM_RARITIES.UNIQUE,
	unlocked_with = {
		other = "christmas_2023",
	},
	model_path = "models/items/courier/scuttling_scotty_penguin/scuttling_scotty_penguin.vmdl",
	model_scale = 1.2,
	particles = {
		{
			path = "particles/econ/courier/courier_wyvern_hatchling/courier_wyvern_hatchling_ice.vpcf",
			attach_type = PATTACH_RENDERORIGIN_FOLLOW,
		},
		{
			path = "particles/killstreak/killstreak_ice_snowflakes_topbar.vpcf",
			attach_type = PATTACH_ABSORIGIN_FOLLOW,
		},
	},
	is_hidden = true,
}