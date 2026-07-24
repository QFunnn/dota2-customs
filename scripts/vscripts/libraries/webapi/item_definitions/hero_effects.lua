--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


COMMON_HERO_EFFECT_CONTROL_POINTS = {
	[0] = {
		attach_type = PATTACH_POINT_FOLLOW,
		attachment = "attach_hitlock"
	},
}

ITEM_DEFINITIONS["item_test_hero_effect"] = {
	slot = INVENTORY_SLOTS.HERO_EFFECT,
	type = ITEM_TYPES.EQUIPMENT,
	rarity = ITEM_RARITIES.LEGENDARY,
	--[[
	unlocked_with = {
		subscription_tier = 2,
	},
	]]

	particles = {
		{
			path = "particles/cosmetic/hero_skins/nightwing.vpcf",
			attach_type = PATTACH_SPECIAL_STATUS_FX,
		},
	},

	sound_effect_name = "Blink_Layer.Swift",
}

ITEM_DEFINITIONS["skin_constellation"] = {
	slot = INVENTORY_SLOTS.HERO_EFFECT,
	type = ITEM_TYPES.EQUIPMENT,
	rarity = ITEM_RARITIES.RARE,

	particles = {
		{
			path = "particles/cosmetic/hero_skins/constellation/constellation.vpcf",
			attach_type = PATTACH_SPECIAL_STATUS_FX,
		},
		{
			path = "particles/cosmetic/hero_skins/constellation/constellation_attach.vpcf",
			attach_type = PATTACH_POINT_FOLLOW,
			control_points = COMMON_HERO_EFFECT_CONTROL_POINTS,
		},
	},
}

ITEM_DEFINITIONS["skin_living_energy"] = {
	slot = INVENTORY_SLOTS.HERO_EFFECT,
	type = ITEM_TYPES.EQUIPMENT,
	rarity = ITEM_RARITIES.MYTHICAL,

	particles = {
		{
			path = "particles/cosmetic/hero_skins/living_energy/living_energy.vpcf",
			attach_type = PATTACH_SPECIAL_STATUS_FX,
		},
		{
			path = "particles/cosmetic/hero_skins/living_energy/living_energy_attach.vpcf",
			attach_type = PATTACH_POINT_FOLLOW,
			control_points = COMMON_HERO_EFFECT_CONTROL_POINTS,
		},
	},
}

ITEM_DEFINITIONS["skin_burning_conviction"] = {
	slot = INVENTORY_SLOTS.HERO_EFFECT,
	type = ITEM_TYPES.EQUIPMENT,
	rarity = ITEM_RARITIES.LEGENDARY,

	particles = {
		{
			path = "particles/cosmetic/hero_skins/burning_conviction/burning_conviction.vpcf",
			attach_type = PATTACH_SPECIAL_STATUS_FX,
		},
		{
			path = "particles/cosmetic/hero_skins/burning_conviction/burning_conviction_attach.vpcf",
			attach_type = PATTACH_POINT_FOLLOW,
			control_points = COMMON_HERO_EFFECT_CONTROL_POINTS,
		},
	},
}

ITEM_DEFINITIONS["skin_nightshade"] = {
	slot = INVENTORY_SLOTS.HERO_EFFECT,
	type = ITEM_TYPES.EQUIPMENT,
	rarity = ITEM_RARITIES.ARCANA,

	particles = {
		{
			path = "particles/cosmetic/hero_skins/nightshade/nightshade.vpcf",
			attach_type = PATTACH_SPECIAL_STATUS_FX,
		},
		{
			path = "particles/cosmetic/hero_skins/nightshade/nightshade_attach.vpcf",
			attach_type = PATTACH_POINT_FOLLOW,
			control_points = COMMON_HERO_EFFECT_CONTROL_POINTS,
		},
	},
}