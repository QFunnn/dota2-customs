--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


ITEM_DEFINITIONS["high_five_bronze"] = {
	slot = INVENTORY_SLOTS.HIGH_FIVE,
	type = ITEM_TYPES.EQUIPMENT,
	rarity = ITEM_RARITIES.UNCOMMON,

	unlocked_with = {
		subscription_tier = 1,
	},

	-- these are controlled by high_five_custom ability
	particle_variants = {
		-- wave particle
		["wave"] = {
			path = "particles/econ/events/ti9/high_five/high_five_lvl1_overhead.vpcf",
		},
		-- travel particle
		["travel"] = {
			path = "particles/econ/events/ti9/high_five/high_five_lvl1_travel.vpcf",
		},
		-- impact particle
		["impact"] = {
			path = "particles/econ/events/ti9/high_five/high_five_impact.vpcf",
		}
	},
}

ITEM_DEFINITIONS["high_five_dark"] = {
	slot = INVENTORY_SLOTS.HIGH_FIVE,
	type = ITEM_TYPES.EQUIPMENT,
	rarity = ITEM_RARITIES.IMMORTAL,

	unlocked_with = {
		subscription_tier = 2,
	},

	-- these are controlled by high_five_custom ability
	particle_variants = {
		-- wave particle
		["wave"] = {
			path = "particles/econ/events/ti9/high_five/high_five_lvl2_overhead.vpcf",
		},
		-- travel particle
		["travel"] = {
			path = "particles/econ/events/ti9/high_five/high_five_lvl2_travel.vpcf",
		},
		-- impact particle
		["impact"] = {
			path = "particles/econ/events/ti9/high_five/high_five_impact.vpcf",
		}
	},
}

ITEM_DEFINITIONS["high_five_diretide"] = {
	slot = INVENTORY_SLOTS.HIGH_FIVE,
	type = ITEM_TYPES.EQUIPMENT,
	rarity = ITEM_RARITIES.UNCOMMON,

	unlocked_with = {
		treasure = "treasure_1"
	},

	-- these are controlled by high_five_custom ability
	particle_variants = {
		-- wave particle
		["wave"] = {
			path = "particles/econ/events/diretide_2020/high_five/high_five_lvl1_overhead.vpcf",
		},
		-- travel particle
		["travel"] = {
			path = "particles/econ/events/diretide_2020/high_five/high_five_lvl1_travel.vpcf",
		},
		-- impact particle
		["impact"] = {
			path = "particles/econ/events/diretide_2020/high_five/high_five_impact.vpcf",
		}
	},
}

ITEM_DEFINITIONS["high_five_fire"] = {
	slot = INVENTORY_SLOTS.HIGH_FIVE,
	type = ITEM_TYPES.EQUIPMENT,
	rarity = ITEM_RARITIES.RARE,

	unlocked_with = {
		treasure = "treasure_3",
	},

	-- these are controlled by high_five_custom ability
	particle_variants = {
		-- wave particle
		["wave"] = {
			path = "particles/econ/events/ti10/high_five/high_five_lvl2_overhead.vpcf",
		},
		-- travel particle
		["travel"] = {
			path = "particles/econ/events/ti10/high_five/high_five_lvl2_travel.vpcf",
		},
		-- impact particle
		["impact"] = {
			path = "particles/econ/events/ti10/high_five/high_five_lvl2_impact.vpcf",
		}
	},
}

ITEM_DEFINITIONS["high_five_ice"] = {
	slot = INVENTORY_SLOTS.HIGH_FIVE,
	type = ITEM_TYPES.EQUIPMENT,
	rarity = ITEM_RARITIES.UNCOMMON,

	unlocked_with = {
		treasure = "treasure_1",
	},

	-- these are controlled by high_five_custom ability
	particle_variants = {
		-- wave particle
		["wave"] = {
			path = "particles/econ/events/ti10/high_five/high_five_lvl1_overhead.vpcf",
		},
		-- travel particle
		["travel"] = {
			path = "particles/econ/events/ti10/high_five/high_five_lvl1_travel.vpcf",
		},
		-- impact particle
		["impact"] = {
			path = "particles/econ/events/diretide_2020/high_five/high_five_impact.vpcf",
		}
	},
}

ITEM_DEFINITIONS["high_five_midas"] = {
	slot = INVENTORY_SLOTS.HIGH_FIVE,
	type = ITEM_TYPES.EQUIPMENT,
	rarity = ITEM_RARITIES.IMMORTAL,

	unlocked_with = {
		currency = 9999,
	},

	-- these are controlled by high_five_custom ability
	particle_variants = {
		-- wave particle
		["wave"] = {
			path = "particles/econ/events/ti9/high_five/high_five_lvl3_overhead.vpcf",
		},
		-- travel particle
		["travel"] = {
			path = "particles/econ/events/ti9/high_five/high_five_lvl3_travel.vpcf",
		},
		-- impact particle
		["impact"] = {
			path = "particles/econ/events/ti9/high_five/high_five_impact.vpcf",
		}
	},
}

ITEM_DEFINITIONS["high_five_newbloom"] = {
	slot = INVENTORY_SLOTS.HIGH_FIVE,
	type = ITEM_TYPES.EQUIPMENT,
	rarity = ITEM_RARITIES.COMMON,

	unlocked_with = {
		currency = 250,
	},

	-- these are controlled by high_five_custom ability
	particle_variants = {
		-- wave particle
		["wave"] = {
			path = "particles/econ/events/newbloom_2020/high_five_newbloom_overhead.vpcf",
		},
		-- travel particle
		["travel"] = {
			path = "particles/econ/events/newbloom_2020/high_five_newbloom_travel.vpcf",
		},
		-- impact particle
		["impact"] = {
			path = "particles/econ/events/newbloom_2020/high_five_newbloom_impact.vpcf",
		}
	},
}

ITEM_DEFINITIONS["high_five_paw"] = {
	slot = INVENTORY_SLOTS.HIGH_FIVE,
	type = ITEM_TYPES.EQUIPMENT,
	rarity = ITEM_RARITIES.RARE,

	unlocked_with = {
		treasure = "treasure_2"
	},

	-- these are controlled by high_five_custom ability
	particle_variants = {
		-- wave particle
		["wave"] = {
			path = "particles/econ/events/plus/high_five/high_five_lvl3_overhead.vpcf",
		},
		-- travel particle
		["travel"] = {
			path = "particles/econ/events/ti10/high_five/high_five_lvl3_travel.vpcf",
		},
		-- impact particle
		["impact"] = {
			path = "particles/econ/events/ti10/high_five/high_five_lvl3_hearts_impact.vpcf",
		}
	},
}

ITEM_DEFINITIONS["high_five_winter"] = {
	slot = INVENTORY_SLOTS.HIGH_FIVE,
	type = ITEM_TYPES.EQUIPMENT,
	rarity = ITEM_RARITIES.UNCOMMON,

	unlocked_with = {
		treasure = "treasure_2",
	},

	-- these are controlled by high_five_custom ability
	particle_variants = {
		-- wave particle
		["wave"] = {
			path = "particles/econ/events/ti9/high_five/high_five_lvl2_overhead_2019.vpcf",
		},
		-- travel particle
		["travel"] = {
			path = "particles/econ/events/ti9/high_five/high_five_lvl2_travel_2019.vpcf",
		},
		-- impact particle
		["impact"] = {
			path = "particles/econ/events/ti9/high_five/high_five_impact.vpcf",
		}
	},
}

ITEM_DEFINITIONS["high_five_rgb"] = {
	slot = INVENTORY_SLOTS.HIGH_FIVE,
	type = ITEM_TYPES.EQUIPMENT,
	rarity = ITEM_RARITIES.ARCANA,

	unlocked_with = {
		currency = 6969,
	},

	-- these are controlled by high_five_custom ability
	particle_variants = {
		-- wave particle
		["wave"] = {
			path = "particles/econ/events/spring_2021/high_five_spring_2021_overhead.vpcf",
		},
		-- travel particle
		["travel"] = {
			path = "particles/econ/events/spring_2021/high_five_spring_2021_travel.vpcf",
		},
		-- impact particle
		["impact"] = {
			path = "particles/econ/events/spring_2021/high_five_spring_2021_impact.vpcf",
		}
	},
}