--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


ITEM_DEFINITIONS["kill_effect_avowance"] = {
	slot = INVENTORY_SLOTS.KILL_EFFECT,
	type = ITEM_TYPES.EQUIPMENT,
	rarity = ITEM_RARITIES.IMMORTAL,

	unlocked_with = {
		subscription_tier = 2,
	},

	particle_variants = {
		-- hero kills should play full particle effect
		["hero"] = {
			path = "particles/cosmetic/kill_effects/avowance/avowance.vpcf",
			attach_type = PATTACH_POINT_FOLLOW,
			persists = false,
		},
		-- creature kills should play simplified, lighter subversion of effect
		["creature"] = {
			path = "particles/cosmetic/kill_effects/avowance/avowance_simple.vpcf",
			attach_type = PATTACH_POINT_FOLLOW,
			persists = false,
		}
	},
}

ITEM_DEFINITIONS["kill_effect_blast_zone"] = {
	slot = INVENTORY_SLOTS.KILL_EFFECT,
	type = ITEM_TYPES.EQUIPMENT,
	rarity = ITEM_RARITIES.MYTHICAL,

	unlocked_with = {
		treasure = "treasure_1",
	},

	particle_variants = {
		-- hero kills should play full particle effect
		["hero"] = {
			path = "particles/cosmetic/kill_effects/blast_zone/blast_zone.vpcf",
			attach_type = PATTACH_POINT_FOLLOW,
			persists = false,
			control_points = {
				[1] = {
					attach_type = PATTACH_POINT_FOLLOW,
					attachment = "attach_hitlock"
				},
			},
		},
		-- creature kills should play simplified, lighter subversion of effect
		["creature"] = {
			path = "particles/cosmetic/kill_effects/blast_zone/blast_zone_simple.vpcf",
			attach_type = PATTACH_POINT_FOLLOW,
			persists = false,
			control_points = {
				[1] = {
					attach_type = PATTACH_POINT_FOLLOW,
					attachment = "attach_hitlock"
				},
			},
		}
	},
}

ITEM_DEFINITIONS["kill_effect_bloodburst"] = {
	slot = INVENTORY_SLOTS.KILL_EFFECT,
	type = ITEM_TYPES.EQUIPMENT,
	rarity = ITEM_RARITIES.ARCANA,

	unlocked_with = {
		treasure = "treasure_2"
	},

	particle_variants = {
		-- hero kills should play full particle effect
		["hero"] = {
			path = "particles/cosmetic/kill_effects/bloodburst/bloodburst.vpcf",
			attach_type = PATTACH_POINT_FOLLOW,
			persists = false,
			control_points = {
				[1] = {
					attach_type = PATTACH_POINT_FOLLOW,
					attachment = "attach_hitlock"
				},
			},
		},
		-- creature kills should play simplified, lighter subversion of effect
		["creature"] = {
			path = "particles/cosmetic/kill_effects/bloodburst/bloodburst_simple.vpcf",
			attach_type = PATTACH_POINT_FOLLOW,
			persists = false,
			control_points = {
				[1] = {
					attach_type = PATTACH_POINT_FOLLOW,
					attachment = "attach_hitlock"
				},
			},
		}
	},
}

ITEM_DEFINITIONS["kill_effect_blue_whirl"] = {
	slot = INVENTORY_SLOTS.KILL_EFFECT,
	type = ITEM_TYPES.EQUIPMENT,
	rarity = ITEM_RARITIES.RARE,

	unlocked_with = {
		currency = 1500,
	},

	particle_variants = {
		-- hero kills should play full particle effect
		["hero"] = {
			path = "particles/cosmetic/kill_effects/blue_whirl/blue_whirl.vpcf",
			attach_type = PATTACH_POINT_FOLLOW,
			persists = false,
			control_points = {
				[1] = {
					attach_type = PATTACH_POINT_FOLLOW,
					attachment = "attach_hitlock"
				},
			},
		},
		-- creature kills should play simplified, lighter subversion of effect
		["creature"] = {
			path = "particles/cosmetic/kill_effects/blue_whirl/blue_whirl_simple.vpcf",
			attach_type = PATTACH_POINT_FOLLOW,
			persists = false,
			control_points = {
				[1] = {
					attach_type = PATTACH_POINT_FOLLOW,
					attachment = "attach_hitlock"
				},
			},
		}
	},
}

ITEM_DEFINITIONS["kill_effect_collapse"] = {
	slot = INVENTORY_SLOTS.KILL_EFFECT,
	type = ITEM_TYPES.EQUIPMENT,
	rarity = ITEM_RARITIES.UNCOMMON,

	unlocked_with = {
		treasure = "treasure_2"
	},

	particle_variants = {
		-- hero kills should play full particle effect
		["hero"] = {
			path = "particles/cosmetic/kill_effects/collapse/collapse.vpcf",
			attach_type = PATTACH_POINT_FOLLOW,
			persists = false,
			control_points = {
				[1] = {
					attach_type = PATTACH_POINT_FOLLOW,
					attachment = "attach_hitlock"
				},
			},
		},
		-- creature kills should play simplified, lighter subversion of effect
		["creature"] = {
			path = "particles/cosmetic/kill_effects/collapse/collapse_simple.vpcf",
			attach_type = PATTACH_POINT_FOLLOW,
			persists = false,
			control_points = {
				[1] = {
					attach_type = PATTACH_POINT_FOLLOW,
					attachment = "attach_hitlock"
				},
			},
		}
	},
}

ITEM_DEFINITIONS["kill_effect_diretide_bats"] = {
	slot = INVENTORY_SLOTS.KILL_EFFECT,
	type = ITEM_TYPES.EQUIPMENT,
	rarity = ITEM_RARITIES.RARE,

	unlocked_with = {
		currency = 2500,
	},

	particle_variants = {
		-- hero kills should play full particle effect
		["hero"] = {
			path = "particles/cosmetic/kill_effects/diretide_bats/diretide_bats.vpcf",
			attach_type = PATTACH_POINT_FOLLOW,
			persists = false,
		},
		-- creature kills should play simplified, lighter subversion of effect
		["creature"] = {
			path = "particles/cosmetic/kill_effects/diretide_bats/diretide_bats_simple.vpcf",
			attach_type = PATTACH_POINT_FOLLOW,
			persists = false,
		}
	},
}


ITEM_DEFINITIONS["kill_effect_dissolution"] = {
	slot = INVENTORY_SLOTS.KILL_EFFECT,
	type = ITEM_TYPES.EQUIPMENT,
	rarity = ITEM_RARITIES.UNCOMMON,

	unlocked_with = {
		treasure = "treasure_1"
	},

	particle_variants = {
		-- hero kills should play full particle effect
		["hero"] = {
			path = "particles/cosmetic/kill_effects/dissolution/dissolution.vpcf",
			attach_type = PATTACH_POINT_FOLLOW,
			persists = false,
		},
		-- creature kills should play simplified, lighter subversion of effect
		["creature"] = {
			path = "particles/cosmetic/kill_effects/dissolution/dissolution_simple.vpcf",
			attach_type = PATTACH_POINT_FOLLOW,
			persists = false,
		}
	},
}


ITEM_DEFINITIONS["kill_effect_glade_grave"] = {
	slot = INVENTORY_SLOTS.KILL_EFFECT,
	type = ITEM_TYPES.EQUIPMENT,
	rarity = ITEM_RARITIES.COMMON,

	unlocked_with = {
		treasure = "treasure_1",
	},

	particle_variants = {
		-- hero kills should play full particle effect
		["hero"] = {
			path = "particles/cosmetic/kill_effects/glade_grave/glade_grave.vpcf",
			attach_type = PATTACH_POINT_FOLLOW,
			persists = false,
		},
		-- creature kills should play simplified, lighter subversion of effect
		["creature"] = {
			path = "particles/cosmetic/kill_effects/glade_grave/glade_grave_simple.vpcf",
			attach_type = PATTACH_POINT_FOLLOW,
			persists = false,
		}
	},
}


ITEM_DEFINITIONS["kill_effect_golden_touch"] = {
	slot = INVENTORY_SLOTS.KILL_EFFECT,
	type = ITEM_TYPES.EQUIPMENT,
	rarity = ITEM_RARITIES.IMMORTAL,

	unlocked_with = {
		currency = 10000,
	},

	particle_variants = {
		-- hero kills should play full particle effect
		["hero"] = {
			path = "particles/cosmetic/kill_effects/golden_touch/golden_touch.vpcf",
			attach_type = PATTACH_POINT_FOLLOW,
			persists = false,
			control_points = {
				[1] = {
					attach_type = PATTACH_POINT_FOLLOW,
					attachment = "attach_hitlock"
				},
			},
		},
		-- creature kills should play simplified, lighter subversion of effect
		["creature"] = {
			path = "particles/cosmetic/kill_effects/golden_touch/golden_touch_simple.vpcf",
			attach_type = PATTACH_POINT_FOLLOW,
			persists = false,
			control_points = {
				[1] = {
					attach_type = PATTACH_POINT_FOLLOW,
					attachment = "attach_hitlock"
				},
			},
		}
	},
}


ITEM_DEFINITIONS["kill_effect_incineration"] = {
	slot = INVENTORY_SLOTS.KILL_EFFECT,
	type = ITEM_TYPES.EQUIPMENT,
	rarity = ITEM_RARITIES.RARE,

	unlocked_with = {
		treasure = "treasure_3",
	},

	particle_variants = {
		-- hero kills should play full particle effect
		["hero"] = {
			path = "particles/cosmetic/kill_effects/incineration/incineration.vpcf",
			attach_type = PATTACH_POINT_FOLLOW,
			persists = false,
			control_points = {
				[1] = {
					attach_type = PATTACH_POINT_FOLLOW,
					attachment = "attach_hitlock"
				},
			},
		},
		-- creature kills should play simplified, lighter subversion of effect
		["creature"] = {
			path = "particles/cosmetic/kill_effects/incineration/incineration_simple.vpcf",
			attach_type = PATTACH_POINT_FOLLOW,
			persists = false,
			control_points = {
				[1] = {
					attach_type = PATTACH_POINT_FOLLOW,
					attachment = "attach_hitlock"
				},
			},
		}
	},
}

ITEM_DEFINITIONS["kill_effect_meltdown"] = {
	slot = INVENTORY_SLOTS.KILL_EFFECT,
	type = ITEM_TYPES.EQUIPMENT,
	rarity = ITEM_RARITIES.MYTHICAL,

	unlocked_with = {
		treasure = "treasure_2"
	},

	particle_variants = {
		-- hero kills should play full particle effect
		["hero"] = {
			path = "particles/cosmetic/kill_effects/meltdown/meltdown.vpcf",
			attach_type = PATTACH_POINT_FOLLOW,
			persists = false,
		},
		-- creature kills should play simplified, lighter subversion of effect
		["creature"] = {
			path = "particles/cosmetic/kill_effects/meltdown/meltdown_simple.vpcf",
			attach_type = PATTACH_POINT_FOLLOW,
			persists = false,
		}
	},
}


ITEM_DEFINITIONS["kill_effect_raze"] = {
	slot = INVENTORY_SLOTS.KILL_EFFECT,
	type = ITEM_TYPES.EQUIPMENT,
	rarity = ITEM_RARITIES.MYTHICAL,

	unlocked_with = {
		treasure = "treasure_3"
	},

	particle_variants = {
		-- hero kills should play full particle effect
		["hero"] = {
			path = "particles/cosmetic/kill_effects/raze/raze.vpcf",
			attach_type = PATTACH_POINT_FOLLOW,
			persists = false,
		},
		-- creature kills should play simplified, lighter subversion of effect
		["creature"] = {
			path = "particles/cosmetic/kill_effects/raze/raze_simple.vpcf",
			attach_type = PATTACH_POINT_FOLLOW,
			persists = false,
		}
	},
}

ITEM_DEFINITIONS["kill_effect_snowstorm"] = {
	slot = INVENTORY_SLOTS.KILL_EFFECT,
	type = ITEM_TYPES.EQUIPMENT,
	rarity = ITEM_RARITIES.UNCOMMON,

	unlocked_with = {
		currency = 1000,
	},

	particle_variants = {
		-- hero kills should play full particle effect
		["hero"] = {
			path = "particles/cosmetic/kill_effects/snowstorm/snowstorm.vpcf",
			attach_type = PATTACH_POINT_FOLLOW,
			persists = false,
		},
		-- creature kills should play simplified, lighter subversion of effect
		["creature"] = {
			path = "particles/cosmetic/kill_effects/snowstorm/snowstorm_simple.vpcf",
			attach_type = PATTACH_POINT_FOLLOW,
			persists = false,
		}
	},
}

ITEM_DEFINITIONS["kill_effect_sparkles"] = {
	slot = INVENTORY_SLOTS.KILL_EFFECT,
	type = ITEM_TYPES.EQUIPMENT,
	rarity = ITEM_RARITIES.UNCOMMON,

	unlocked_with = {
		subscription_tier = 1,
	},

	particle_variants = {
		-- hero kills should play full particle effect
		["hero"] = {
			path = "particles/cosmetic/kill_effects/sparkles/sparkles.vpcf",
			attach_type = PATTACH_POINT_FOLLOW,
			persists = false,
		},
		-- creature kills should play simplified, lighter subversion of effect
		["creature"] = {
			path = "particles/cosmetic/kill_effects/sparkles/sparkles_simple.vpcf",
			attach_type = PATTACH_POINT_FOLLOW,
			persists = false,
		}
	},
}

ITEM_DEFINITIONS["kill_effect_supernova"] = {
	slot = INVENTORY_SLOTS.KILL_EFFECT,
	type = ITEM_TYPES.EQUIPMENT,
	rarity = ITEM_RARITIES.LEGENDARY,

	unlocked_with = {
		treasure = "treasure_3"
	},

	particle_variants = {
		-- hero kills should play full particle effect
		["hero"] = {
			path = "particles/cosmetic/kill_effects/supernova/supernova.vpcf",
			attach_type = PATTACH_POINT_FOLLOW,
			persists = false,
		},
		-- creature kills should play simplified, lighter subversion of effect
		["creature"] = {
			path = "particles/cosmetic/kill_effects/supernova/supernova_simple.vpcf",
			attach_type = PATTACH_POINT_FOLLOW,
			persists = false,
		}
	},
}