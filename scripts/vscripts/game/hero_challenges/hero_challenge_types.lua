--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


HERO_CHALLENGE_TYPES = {
	types = HERO_PRESETS.CARRY_TANK
}


-- HERO_CHALLENGE_TYPES["npc_dota_hero_test"] = {
	-- `target_bias` applies multiplier to target of all challenges of a hero (OPTIONAL)
	-- target_bias = 0.5,

	-- possible types of challenges for this hero
	-- can be declared as a literal table i.e. {CHALLENGE_TYPE.HEAL, CHALLENGE_TYPE.ASSIST, CHALLENGE_TYPE.BREAK_WARD}
	-- or using presets and joins i.e. table.join(HERO_PRESETS.TANK, CHALLENGE_TYPE.BREAK_WARD)

	-- types = table.join(HERO_PRESETS.TANK, HERO_PRESETS.SUPPORT)

	--[[
	-- `types_override` allows to override base challenge type values for given hero and type if needed (OPTIONAL)

	types_override = {
		[CHALLENGE_TYPE.HEAL] = {
			-- override for base target (multiplied by difficulty)
			-- NOTE: `target_bias` (both hero-wide and per-challenge) still affects this!
			target = 1000,
			-- override for target bias per-challenge, applied after difficulty
			target_bias = 0.6,
		}
	}

	]]
-- }

HERO_CHALLENGE_TYPES["npc_dota_hero_abaddon"] = {
	types = HERO_PRESETS.HEAL_TANK,
	types_override = {
        [CHALLENGE_TYPE.CAPTURE_TIME] = {
            target_bias = 1.2,
        },
        [CHALLENGE_TYPE.TAKE_DAMAGE] = {
            target_bias = 1.4,
        },
        [CHALLENGE_TYPE.KILL] = {
            target_bias = 1.1,
        },
        [CHALLENGE_TYPE.ASSIST] = {
            target_bias = 1.05,
        },
        [CHALLENGE_TYPE.KILL] = {
            target_bias = 0.7,
        },
        [CHALLENGE_TYPE.DEAL_DAMAGE] = {
            target_bias = 0.6,
        },
    }
}

HERO_CHALLENGE_TYPES["npc_dota_hero_abyssal_underlord"] = {
	types = HERO_PRESETS.STUN_TANK,
	types_override = {
        [CHALLENGE_TYPE.CAPTURE_TIME] = {
            target_bias = 1.3,
        },
        [CHALLENGE_TYPE.DEAL_DAMAGE] = {
            target_bias = 1.0,
        },
        [CHALLENGE_TYPE.ASSIST] = {
            target_bias = 1.2,
        },
        [CHALLENGE_TYPE.KILL] = {
            target_bias = 1.1,
        },
        [CHALLENGE_TYPE.TAKE_DAMAGE] = {
            target_bias = 1.0,
        },
    }
}

HERO_CHALLENGE_TYPES["npc_dota_hero_alchemist"] = {
	types = HERO_PRESETS.STUN_TANK,
	types_override = {
        [CHALLENGE_TYPE.KILL] = {
            target_bias = 0.7,
        },
        [CHALLENGE_TYPE.CAPTURE_TIME] = {
            target_bias = 1.1,
        },
        [CHALLENGE_TYPE.DEAL_DAMAGE] = {
            target_bias = 0.7,
        },
        [CHALLENGE_TYPE.ASSIST] = {
            target_bias = 1.2,
        },
        [CHALLENGE_TYPE.TAKE_DAMAGE] = {
            target_bias = 1.0,
        },
        [CHALLENGE_TYPE.STUN] = {
            target_bias = 0.7,
        },
    }
}

HERO_CHALLENGE_TYPES["npc_dota_hero_ancient_apparition"] = {
	types = HERO_PRESETS.STUN,
	types_override = {
        [CHALLENGE_TYPE.ASSIST] = {
            target_bias = 1.1,
        },
        [CHALLENGE_TYPE.KILL] = {
            target_bias = 1.4,
        },
        [CHALLENGE_TYPE.STUN] = {
            target_bias = 0.4,
        },
        [CHALLENGE_TYPE.CAPTURE_TIME] = {
            target_bias = 0.7,
        },
        [CHALLENGE_TYPE.DEAL_DAMAGE] = {
            target_bias = 1.2,
        },
    }
}

HERO_CHALLENGE_TYPES["npc_dota_hero_antimage"] = {
	types = HERO_PRESETS.TANK,
	types_override = {
        [CHALLENGE_TYPE.KILL] = {
            target_bias = 1.1,
        },
        [CHALLENGE_TYPE.CAPTURE_TIME] = {
            target_bias = 1.2,
        },
        [CHALLENGE_TYPE.DEAL_DAMAGE] = {
            target_bias = 0.8,
        },
        [CHALLENGE_TYPE.ASSIST] = {
            target_bias = 0.7,
        },
    }
}

HERO_CHALLENGE_TYPES["npc_dota_hero_arc_warden"] = {
	types = HERO_PRESETS.BASIC,
	types_override = {
        [CHALLENGE_TYPE.ASSIST] = {
            target_bias = 1.15,
        },
        [CHALLENGE_TYPE.CAPTURE_TIME] = {
            target_bias = 0.3,
        },
        [CHALLENGE_TYPE.KILL] = {
            target_bias = 0.6,
        },
        [CHALLENGE_TYPE.DEAL_DAMAGE] = {
            target_bias = 0.6,
        },
    }
}

HERO_CHALLENGE_TYPES["npc_dota_hero_axe"] = {
	types = HERO_PRESETS.TANK,
	types_override = {
        [CHALLENGE_TYPE.KILL] = {
            target_bias = 1.1,
        },
        [CHALLENGE_TYPE.ASSIST] = {
            target_bias = 0.95,
        },
        [CHALLENGE_TYPE.TAKE_DAMAGE] = {
            target_bias = 1.6,
        },
        [CHALLENGE_TYPE.DEAL_DAMAGE] = {
            target_bias = 1.1,
        },
        [CHALLENGE_TYPE.CAPTURE_TIME] = {
            target_bias = 1.2,
        },
    }
}

HERO_CHALLENGE_TYPES["npc_dota_hero_bane"] = {
	types = HERO_PRESETS.STUN,
	types_override = {
        [CHALLENGE_TYPE.ASSIST] = {
            target_bias = 0.85,
        },
        [CHALLENGE_TYPE.KILL] = {
            target_bias = 0.7,
        },
        [CHALLENGE_TYPE.CAPTURE_TIME] = {
            target_bias = 0.6,
        },
        [CHALLENGE_TYPE.DEAL_DAMAGE] = {
            target_bias = 0.7,
        },
    }
}

HERO_CHALLENGE_TYPES["npc_dota_hero_batrider"] = {
	types = HERO_PRESETS.STUN,
	types_override = {
        [CHALLENGE_TYPE.ASSIST] = {
            target_bias = 1.0,
        },
        [CHALLENGE_TYPE.KILL] = {
            target_bias = 0.6,
        },
        [CHALLENGE_TYPE.STUN] = {
            target_bias = 0.5,
        },
        [CHALLENGE_TYPE.CAPTURE_TIME] = {
            target_bias = 0.6,
        },
        [CHALLENGE_TYPE.DEAL_DAMAGE] = {
            target_bias = 0.7,
        },
    }
}

HERO_CHALLENGE_TYPES["npc_dota_hero_beastmaster"] = {
	types = HERO_PRESETS.STUN_SUMMON,
	types_override = {
        [CHALLENGE_TYPE.DEAL_DAMAGE_WITH_SUMMONS] = {
            target_bias = 0.5,
        },
        [CHALLENGE_TYPE.ASSIST] = {
            target_bias = 0.9,
        },
        [CHALLENGE_TYPE.KILL] = {
            target_bias = 0.6,
        },
        [CHALLENGE_TYPE.CAPTURE_TIME] = {
            target_bias = 0.6,
        },
        [CHALLENGE_TYPE.DEAL_DAMAGE] = {
            target_bias = 0.7,
        },
        [CHALLENGE_TYPE.STUN] = {
            target_bias = 0.6,
        },
    }
}

HERO_CHALLENGE_TYPES["npc_dota_hero_bloodseeker"] = {
	types = HERO_PRESETS.TANK,
	types_override = {
        [CHALLENGE_TYPE.ASSIST] = {
            target_bias = 1.05,
        },
        [CHALLENGE_TYPE.KILL] = {
            target_bias = 1.1,
        },
        [CHALLENGE_TYPE.DEAL_DAMAGE] = {
            target_bias = 1.2,
        },
        [CHALLENGE_TYPE.TAKE_DAMAGE] = {
            target_bias = 1.1,
        },
    }
}

HERO_CHALLENGE_TYPES["npc_dota_hero_bounty_hunter"] = {
	types = HERO_PRESETS.BASIC,
	types_override = {
        [CHALLENGE_TYPE.ASSIST] = {
            target_bias = 0.8,
        },
        [CHALLENGE_TYPE.DEAL_DAMAGE] = {
            target_bias = 0.8,
        },
        [CHALLENGE_TYPE.CAPTURE_TIME] = {
            target_bias = 0.8,
        },
        [CHALLENGE_TYPE.KILL] = {
            target_bias = 1.1,
        },
    }
}

HERO_CHALLENGE_TYPES["npc_dota_hero_brewmaster"] = {
	types = HERO_PRESETS.STUN_SUMMON_TANK,
	types_override = {
        [CHALLENGE_TYPE.DEAL_DAMAGE_WITH_SUMMONS] = {
            target_bias = 0.8,
        },
        [CHALLENGE_TYPE.KILL] = {
            target_bias = 0.6,
        },
        [CHALLENGE_TYPE.STUN] = {
            target_bias = 0.6,
        },
        [CHALLENGE_TYPE.TAKE_DAMAGE] = {
            target_bias = 0.8,
        },
        [CHALLENGE_TYPE.DEAL_DAMAGE] = {
            target_bias = 0.8,
        },
        [CHALLENGE_TYPE.CAPTURE_TIME] = {
            target_bias = 1.2,
        },
        [CHALLENGE_TYPE.ASSIST] = {
            target_bias = 0.9,
        },
    }
}

HERO_CHALLENGE_TYPES["npc_dota_hero_bristleback"] = {
	types = HERO_PRESETS.TANK,
	types_override = {
        [CHALLENGE_TYPE.ASSIST] = {
            target_bias = 1.2,
        },
        [CHALLENGE_TYPE.TAKE_DAMAGE] = {
            target_bias = 1.8,
        },
        [CHALLENGE_TYPE.CAPTURE_TIME] = {
            target_bias = 1.3,
        },
        [CHALLENGE_TYPE.DEAL_DAMAGE] = {
            target_bias = 1.3,
        },
        [CHALLENGE_TYPE.KILL] = {
            target_bias = 1.1,
        },
    }
}

HERO_CHALLENGE_TYPES["npc_dota_hero_broodmother"] = {
	types = HERO_PRESETS.SUMMON_TANK,
	types_override = {
        [CHALLENGE_TYPE.DEAL_DAMAGE_WITH_SUMMONS] = {
            target_bias = 0.1,
        },
        [CHALLENGE_TYPE.ASSIST] = {
            target_bias = 1.65,
        },
        [CHALLENGE_TYPE.KILL] = {
            target_bias = 0.5,
        },
        [CHALLENGE_TYPE.CAPTURE_TIME] = {
            target_bias = 0.4,
        },
        [CHALLENGE_TYPE.DEAL_DAMAGE] = {
            target_bias = 0.4,
        },
        [CHALLENGE_TYPE.TAKE_DAMAGE] = {
            target_bias = 0.4,
        },
    }
}

HERO_CHALLENGE_TYPES["npc_dota_hero_centaur"] = {
	types = HERO_PRESETS.STUN_TANK,
	types_override = {
        [CHALLENGE_TYPE.KILL] = {
            target_bias = 0.9,
        },
        [CHALLENGE_TYPE.ASSIST] = {
            target_bias = 1.1,
        },
        [CHALLENGE_TYPE.STUN] = {
            target_bias = 0.9,
        },
        [CHALLENGE_TYPE.TAKE_DAMAGE] = {
            target_bias = 1.4,
        },
        [CHALLENGE_TYPE.CAPTURE_TIME] = {
            target_bias = 1.3,
        },
        [CHALLENGE_TYPE.DEAL_DAMAGE] = {
            target_bias = 1.1,
        },
    }
}

HERO_CHALLENGE_TYPES["npc_dota_hero_chaos_knight"] = {
	types = HERO_PRESETS.STUN_TANK,
	types_override = {
        [CHALLENGE_TYPE.ASSIST] = {
            target_bias = 0.65,
        },
        [CHALLENGE_TYPE.KILL] = {
            target_bias = 0.7,
        },
        [CHALLENGE_TYPE.DEAL_DAMAGE] = {
            target_bias = 0.5,
        },
        [CHALLENGE_TYPE.TAKE_DAMAGE] = {
            target_bias = 0.8,
        },
        [CHALLENGE_TYPE.STUN] = {
            target_bias = 0.6,
        },
        [CHALLENGE_TYPE.CAPTURE_TIME] = {
            target_bias = 0.8,
        },
    }
}

HERO_CHALLENGE_TYPES["npc_dota_hero_chen"] = {
	types = HERO_PRESETS.HEAL_SUMMON,
	types_override = {
        [CHALLENGE_TYPE.DEAL_DAMAGE_WITH_SUMMONS] = {
            target_bias = 0.5,
        },
        [CHALLENGE_TYPE.ASSIST] = {
            target_bias = 0.85,
        },
        [CHALLENGE_TYPE.KILL] = {
            target_bias = 0.8,
        },
        [CHALLENGE_TYPE.CAPTURE_TIME] = {
            target_bias = 0.5,
        },
        [CHALLENGE_TYPE.DEAL_DAMAGE] = {
            target_bias = 0.8,
        },
        [CHALLENGE_TYPE.HEAL] = {
            target_bias = 1,
        },
    }
}

HERO_CHALLENGE_TYPES["npc_dota_hero_clinkz"] = {
	types = HERO_PRESETS.SUMMON,
	types_override = {
        [CHALLENGE_TYPE.ASSIST] = {
            target_bias = 1.1,
        },
        [CHALLENGE_TYPE.DEAL_DAMAGE] = {
            target_bias = 1.3,
        },
        [CHALLENGE_TYPE.KILL] = {
            target_bias = 1.2,
        },
        [CHALLENGE_TYPE.DEAL_DAMAGE_WITH_SUMMONS] = {
            target_bias = 1.7,
        },
        [CHALLENGE_TYPE.CAPTURE_TIME] = {
            target_bias = 0.4,
        },
    }
}

HERO_CHALLENGE_TYPES["npc_dota_hero_crystal_maiden"] = {
	types = HERO_PRESETS.STUN,
	types_override = {
        [CHALLENGE_TYPE.ASSIST] = {
            target_bias = 1.05,
        },
        [CHALLENGE_TYPE.STUN] = {
            target_bias = 1.4,
        },
        [CHALLENGE_TYPE.DEAL_DAMAGE] = {
            target_bias = 0.9,
        },
        [CHALLENGE_TYPE.CAPTURE_TIME] = {
            target_bias = 0.7,
        },
    }
}

HERO_CHALLENGE_TYPES["npc_dota_hero_dark_seer"] = {
	types = HERO_PRESETS.BASIC,
	types_override = {
        [CHALLENGE_TYPE.ASSIST] = {
            target_bias = 1.3,
        },
        [CHALLENGE_TYPE.KILL] = {
            target_bias = 0.7,
        },
        [CHALLENGE_TYPE.DEAL_DAMAGE] = {
            target_bias = 0.8,
        },
    }
}

HERO_CHALLENGE_TYPES["npc_dota_hero_dark_willow"] = {
	types = HERO_PRESETS.STUN,
	types_override = {
        [CHALLENGE_TYPE.ASSIST] = {
            target_bias = 0.9,
        },
        [CHALLENGE_TYPE.KILL] = {
            target_bias = 1.3,
        },
        [CHALLENGE_TYPE.STUN] = {
            target_bias = 1.55,
        },
        [CHALLENGE_TYPE.DEAL_DAMAGE] = {
            target_bias = 1.35,
        },
    }
}

HERO_CHALLENGE_TYPES["npc_dota_hero_dawnbreaker"] = {
	types = HERO_PRESETS.HEAL_TANK,
	types_override = {
        [CHALLENGE_TYPE.HEAL] = {
            target_bias = 0.8,
        },
        [CHALLENGE_TYPE.ASSIST] = {
            target_bias = 1,
        },
        [CHALLENGE_TYPE.KILL] = {
            target_bias = 0.7,
        },
        [CHALLENGE_TYPE.TAKE_DAMAGE] = {
            target_bias = 0.75,
        },
        [CHALLENGE_TYPE.CAPTURE_TIME] = {
            target_bias = 1,
        },
        [CHALLENGE_TYPE.DEAL_DAMAGE] = {
            target_bias = 0.7,
        },
    }
}

HERO_CHALLENGE_TYPES["npc_dota_hero_dazzle"] = {
	types = HERO_PRESETS.HEAL_TANK,
	types_override = {
        [CHALLENGE_TYPE.HEAL] = {
            target_bias = 1.6,
        },
        [CHALLENGE_TYPE.KILL] = {
            target_bias = 0.5,
        },
        [CHALLENGE_TYPE.CAPTURE_TIME] = {
            target_bias = 0.75,
        },
        [CHALLENGE_TYPE.DEAL_DAMAGE] = {
            target_bias = 0.45,
        },
        [CHALLENGE_TYPE.ASSIST] = {
            target_bias = 0.95,
        },
        [CHALLENGE_TYPE.TAKE_DAMAGE] = {
            target_bias = 1.0,
        },
    }
}

HERO_CHALLENGE_TYPES["npc_dota_hero_death_prophet"] = {
	types = HERO_PRESETS.TANK,
	types_override = {
        [CHALLENGE_TYPE.KILL] = {
            target_bias = 0.9,
        },
        [CHALLENGE_TYPE.ASSIST] = {
            target_bias = 1.15,
        },
        [CHALLENGE_TYPE.TAKE_DAMAGE] = {
            target_bias = 1.1,
        },
        [CHALLENGE_TYPE.CAPTURE_TIME] = {
            target_bias = 1.1,
        },
        [CHALLENGE_TYPE.DEAL_DAMAGE] = {
            target_bias = 0.7,
        },
    }
}

HERO_CHALLENGE_TYPES["npc_dota_hero_disruptor"] = {
	types = HERO_PRESETS.BASIC,
	types_override = {
        [CHALLENGE_TYPE.ASSIST] = {
            target_bias = 1.4,
        },
        [CHALLENGE_TYPE.KILL] = {
            target_bias = 0.8,
        },
        [CHALLENGE_TYPE.CAPTURE_TIME] = {
            target_bias = 1.1,
        },
        [CHALLENGE_TYPE.DEAL_DAMAGE] = {
            target_bias = 0.65,
        },
    }
}

HERO_CHALLENGE_TYPES["npc_dota_hero_doom_bringer"] = {
	types = HERO_PRESETS.TANK,
	types_override = {
        [CHALLENGE_TYPE.KILL] = {
            target_bias = 0.9,
        },
        [CHALLENGE_TYPE.ASSIST] = {
            target_bias = 1.1,
        },
        [CHALLENGE_TYPE.CAPTURE_TIME] = {
            target_bias = 1.1,
        },
        [CHALLENGE_TYPE.DEAL_DAMAGE] = {
            target_bias = 0.95,
        },
        [CHALLENGE_TYPE.TAKE_DAMAGE] = {
            target_bias = 0.9,
        },
    }
}

HERO_CHALLENGE_TYPES["npc_dota_hero_dragon_knight"] = {
	types = HERO_PRESETS.STUN_TANK,
	types_override = {
        [CHALLENGE_TYPE.KILL] = {
            target_bias = 0.8,
        },
        [CHALLENGE_TYPE.ASSIST] = {
            target_bias = 0.8,
        },
        [CHALLENGE_TYPE.STUN] = {
            target_bias = 0.5,
        },
        [CHALLENGE_TYPE.TAKE_DAMAGE] = {
            target_bias = 1.2,
        },
        [CHALLENGE_TYPE.CAPTURE_TIME] = {
            target_bias = 1.1,
        },
        [CHALLENGE_TYPE.DEAL_DAMAGE] = {
            target_bias = 0.65,
        },
    }
}

HERO_CHALLENGE_TYPES["npc_dota_hero_drow_ranger"] = {
	types = HERO_PRESETS.BASIC,
	types_override = {
        [CHALLENGE_TYPE.KILL] = {
            target_bias = 1.55,
        },
        [CHALLENGE_TYPE.CAPTURE_TIME] = {
            target_bias = 1,
        },
        [CHALLENGE_TYPE.DEAL_DAMAGE] = {
            target_bias = 1.45,
        },
        [CHALLENGE_TYPE.ASSIST] = {
            target_bias = 0.9,
        },
    }
}

HERO_CHALLENGE_TYPES["npc_dota_hero_earth_spirit"] = {
	types = HERO_PRESETS.STUN_TANK,
	types_override = {
        [CHALLENGE_TYPE.ASSIST] = {
            target_bias = 1.1,
        },
        [CHALLENGE_TYPE.KILL] = {
            target_bias = 0.75,
        },
        [CHALLENGE_TYPE.STUN] = {
            target_bias = 0.6,
        },
        [CHALLENGE_TYPE.TAKE_DAMAGE] = {
            target_bias = 0.9,
        },
        [CHALLENGE_TYPE.CAPTURE_TIME] = {
            target_bias = 0.8,
        },
        [CHALLENGE_TYPE.DEAL_DAMAGE] = {
            target_bias = 0.9,
        },
    }
}

HERO_CHALLENGE_TYPES["npc_dota_hero_earthshaker"] = {
	types = HERO_PRESETS.STUN,
	types_override = {
        [CHALLENGE_TYPE.KILL] = {
            target_bias = 1.5,
        },
        [CHALLENGE_TYPE.STUN] = {
            target_bias = 1.8,
        },
		[CHALLENGE_TYPE.TAKE_DAMAGE] = {
            target_bias = 1.05,
        },
        [CHALLENGE_TYPE.DEAL_DAMAGE] = {
            target_bias = 1.3,
        },
        [CHALLENGE_TYPE.ASSIST] = {
            target_bias = 0.9,
        },
        [CHALLENGE_TYPE.CAPTURE_TIME] = {
            target_bias = 1.2,
        },
    }
}

HERO_CHALLENGE_TYPES["npc_dota_hero_elder_titan"] = {
	types = HERO_PRESETS.STUN_TANK,
	types_override = {
        [CHALLENGE_TYPE.ASSIST] = {
            target_bias = 0.9,
        },
        [CHALLENGE_TYPE.STUN] = {
            target_bias = 0.8,
        },
        [CHALLENGE_TYPE.TAKE_DAMAGE] = {
            target_bias = 0.9,
        },
        [CHALLENGE_TYPE.CAPTURE_TIME] = {
            target_bias = 0.7,
        },
        [CHALLENGE_TYPE.DEAL_DAMAGE] = {
            target_bias = 0.8,
        },
        [CHALLENGE_TYPE.KILL] = {
            target_bias = 0.9,
        },
    }
}

HERO_CHALLENGE_TYPES["npc_dota_hero_ember_spirit"] = {
	types = HERO_PRESETS.STUN,
	types_override = {
        [CHALLENGE_TYPE.ASSIST] = {
            target_bias = 1.2,
        },
        [CHALLENGE_TYPE.KILL] = {
            target_bias = 1.45,
        },
        [CHALLENGE_TYPE.STUN] = {
            target_bias = 1.6,
        },
        [CHALLENGE_TYPE.CAPTURE_TIME] = {
            target_bias = 1,
        },
        [CHALLENGE_TYPE.DEAL_DAMAGE] = {
            target_bias = 1.3,
        },
    }
}

HERO_CHALLENGE_TYPES["npc_dota_hero_enchantress"] = {
	types = HERO_PRESETS.HEAL_SUMMON_TANK,
	types_override = {
        [CHALLENGE_TYPE.DEAL_DAMAGE_WITH_SUMMONS] = {
            target_bias = 0.1,
        },
        [CHALLENGE_TYPE.ASSIST] = {
            target_bias = 0.8,
        },
        [CHALLENGE_TYPE.STUN] = {
            target_bias = 0.7,
        },
        [CHALLENGE_TYPE.TAKE_DAMAGE] = {
            target_bias = 0.9,
        },
        [CHALLENGE_TYPE.DEAL_DAMAGE] = {
            target_bias = 1.15,
        },
        [CHALLENGE_TYPE.KILL] = {
            target_bias = 1.4,
        },
        [CHALLENGE_TYPE.CAPTURE_TIME] = {
            target_bias = 0.9,
        },
        [CHALLENGE_TYPE.HEAL] = {
            target_bias = 0.6,
        },
    }
}

HERO_CHALLENGE_TYPES["npc_dota_hero_enigma"] = {
	types = HERO_PRESETS.STUN_SUMMON,
	types_override = {
        [CHALLENGE_TYPE.DEAL_DAMAGE_WITH_SUMMONS] = {
            target_bias = 0.4,
        },
        [CHALLENGE_TYPE.STUN] = {
            target_bias = 0.8,
        },
        [CHALLENGE_TYPE.CAPTURE_TIME] = {
            target_bias = 0.8,
        },
        [CHALLENGE_TYPE.DEAL_DAMAGE] = {
            target_bias = 1.4,
        },
        [CHALLENGE_TYPE.ASSIST] = {
            target_bias = 1.15,
        },
        [CHALLENGE_TYPE.KILL] = {
            target_bias = 0.75,
        },
    }
}

HERO_CHALLENGE_TYPES["npc_dota_hero_faceless_void"] = {
	types = HERO_PRESETS.TANK,
	types_override = {
        [CHALLENGE_TYPE.KILL] = {
            target_bias = 1.15,
        },
        [CHALLENGE_TYPE.CAPTURE_TIME] = {
            target_bias = 1.3,
        },
        [CHALLENGE_TYPE.DEAL_DAMAGE] = {
            target_bias = 0.9,
        },
        [CHALLENGE_TYPE.ASSIST] = {
            target_bias = 1.05,
        },
    }
}

HERO_CHALLENGE_TYPES["npc_dota_hero_furion"] = {
	types = HERO_PRESETS.STUN_SUMMON,
	types_override = {
        [CHALLENGE_TYPE.DEAL_DAMAGE_WITH_SUMMONS] = {
            target_bias = 0.4,
        },
        [CHALLENGE_TYPE.STUN] = {
            target_bias = 1.2,
        },
        [CHALLENGE_TYPE.KILL] = {
            target_bias = 0.85,
        },
        [CHALLENGE_TYPE.CAPTURE_TIME] = {
            target_bias = 0.6,
        },
        [CHALLENGE_TYPE.ASSIST] = {
            target_bias = 1.2,
        },
        [CHALLENGE_TYPE.DEAL_DAMAGE] = {
            target_bias = 1.1,
        },
    }
}

HERO_CHALLENGE_TYPES["npc_dota_hero_grimstroke"] = {
	types = HERO_PRESETS.STUN,
	types_override = {
        [CHALLENGE_TYPE.KILL] = {
            target_bias = 0.8,
        },
        [CHALLENGE_TYPE.ASSIST] = {
            target_bias = 1.05,
        },
        [CHALLENGE_TYPE.STUN] = {
            target_bias = 0.8,
        },
        [CHALLENGE_TYPE.CAPTURE_TIME] = {
            target_bias = 0.7,
        },
        [CHALLENGE_TYPE.DEAL_DAMAGE] = {
            target_bias = 1.0,
        },
    }
}

HERO_CHALLENGE_TYPES["npc_dota_hero_gyrocopter"] = {
	types = HERO_PRESETS.STUN,
	types_override = {
        [CHALLENGE_TYPE.ASSIST] = {
            target_bias = 1.05,
        },
        [CHALLENGE_TYPE.KILL] = {
            target_bias = 1.4,
        },
        [CHALLENGE_TYPE.CAPTURE_TIME] = {
            target_bias = 1.4,
        },
        [CHALLENGE_TYPE.DEAL_DAMAGE] = {
            target_bias = 1.5,
        },
        [CHALLENGE_TYPE.STUN] = {
            target_bias = 0.75,
        },
    }
}

HERO_CHALLENGE_TYPES["npc_dota_hero_hoodwink"] = {
	types = HERO_PRESETS.STUN,
	types_override = {
        [CHALLENGE_TYPE.KILL] = {
            target_bias = 1.4,
        },
        [CHALLENGE_TYPE.CAPTURE_TIME] = {
            target_bias = 0.8,
        },
        [CHALLENGE_TYPE.DEAL_DAMAGE] = {
            target_bias = 1.3,
        },
        [CHALLENGE_TYPE.ASSIST] = {
            target_bias = 0.95,
        },
        [CHALLENGE_TYPE.STUN] = {
            target_bias = 0.7,
        },
    }
}

HERO_CHALLENGE_TYPES["npc_dota_hero_huskar"] = {
	types = HERO_PRESETS.TANK,
	types_override = {
        [CHALLENGE_TYPE.ASSIST] = {
            target_bias = 0.8,
        },
        [CHALLENGE_TYPE.TAKE_DAMAGE] = {
            target_bias = 1.5,
        },
        [CHALLENGE_TYPE.CAPTURE_TIME] = {
            target_bias = 1.1,
        },
        [CHALLENGE_TYPE.KILL] = {
            target_bias = 1.1,
        },
        [CHALLENGE_TYPE.DEAL_DAMAGE] = {
            target_bias = 1.2,
        },
    }
}

HERO_CHALLENGE_TYPES["npc_dota_hero_invoker"] = {
	types = HERO_PRESETS.STUN_SUMMON,
	types_override = {
        [CHALLENGE_TYPE.DEAL_DAMAGE_WITH_SUMMONS] = {
            target_bias = 0.15,
        },
        [CHALLENGE_TYPE.ASSIST] = {
            target_bias = 1,
        },
        [CHALLENGE_TYPE.KILL] = {
            target_bias = 1,
        },
        [CHALLENGE_TYPE.STUN] = {
            target_bias = 1.1,
        },
        [CHALLENGE_TYPE.CAPTURE_TIME] = {
            target_bias = 0.5,
        },
        [CHALLENGE_TYPE.DEAL_DAMAGE] = {
            target_bias = 1.1,
        },
    }
}

HERO_CHALLENGE_TYPES["npc_dota_hero_jakiro"] = {
	types = HERO_PRESETS.STUN,
	types_override = {
        [CHALLENGE_TYPE.ASSIST] = {
            target_bias = 1.05,
        },
        [CHALLENGE_TYPE.STUN] = {
            target_bias = 1.65,
        },
        [CHALLENGE_TYPE.DEAL_DAMAGE] = {
            target_bias = 1.3,
        },
        [CHALLENGE_TYPE.KILL] = {
            target_bias = 1.1,
        },
        [CHALLENGE_TYPE.CAPTURE_TIME] = {
            target_bias = 0.8,
        },
    }
}

HERO_CHALLENGE_TYPES["npc_dota_hero_juggernaut"] = {
	types = HERO_PRESETS.TANK,
	types_override = {
        [CHALLENGE_TYPE.ASSIST] = {
            target_bias = 0.85,
        },
        [CHALLENGE_TYPE.KILL] = {
            target_bias = 1.55,
        },
        [CHALLENGE_TYPE.CAPTURE_TIME] = {
            target_bias = 1.7,
        },
        [CHALLENGE_TYPE.DEAL_DAMAGE] = {
            target_bias = 1.3,
        },
        [CHALLENGE_TYPE.TAKE_DAMAGE] = {
            target_bias = 1.3,
        },
    }
}

HERO_CHALLENGE_TYPES["npc_dota_hero_keeper_of_the_light"] = {
	types = HERO_PRESETS.HEAL,
	types_override = {
        [CHALLENGE_TYPE.KILL] = {
            target_bias = 0.65,
        },
        [CHALLENGE_TYPE.CAPTURE_TIME] = {
            target_bias = 0.6,
        },
        [CHALLENGE_TYPE.ASSIST] = {
            target_bias = 1.05,
        },
        [CHALLENGE_TYPE.HEAL] = {
            target_bias = 1.0,
        },
        [CHALLENGE_TYPE.DEAL_DAMAGE] = {
            target_bias = 0.9,
        },
    }
}

HERO_CHALLENGE_TYPES["npc_dota_hero_kunkka"] = {
	types = HERO_PRESETS.STUN_TANK,
	types_override = {
        [CHALLENGE_TYPE.CAPTURE_TIME] = {
            target_bias = 1.3,
        },
        [CHALLENGE_TYPE.DEAL_DAMAGE] = {
            target_bias = 0.8,
        },
        [CHALLENGE_TYPE.STUN] = {
            target_bias = 1.2,
        },
        [CHALLENGE_TYPE.ASSIST] = {
            target_bias = 0.95,
        },
        [CHALLENGE_TYPE.TAKE_DAMAGE] = {
            target_bias = 0.8,
        },
    }
}

HERO_CHALLENGE_TYPES["npc_dota_hero_legion_commander"] = {
	types = HERO_PRESETS.TANK,
	types_override = {
        [CHALLENGE_TYPE.KILL] = {
            target_bias = 1.45,
        },
        [CHALLENGE_TYPE.ASSIST] = {
            target_bias = 0.8,
        },
        [CHALLENGE_TYPE.CAPTURE_TIME] = {
            target_bias = 1.4,
        },
        [CHALLENGE_TYPE.TAKE_DAMAGE] = {
            target_bias = 1.3,
        },
        [CHALLENGE_TYPE.DEAL_DAMAGE] = {
            target_bias = 1.05,
        },
    }
}

HERO_CHALLENGE_TYPES["npc_dota_hero_leshrac"] = {
	types = HERO_PRESETS.STUN_TANK,
	types_override = {
        [CHALLENGE_TYPE.KILL] = {
            target_bias = 1.1,
        },
        [CHALLENGE_TYPE.CAPTURE_TIME] = {
            target_bias = 1.1,
        },
        [CHALLENGE_TYPE.DEAL_DAMAGE] = {
            target_bias = 1.2,
        },
        [CHALLENGE_TYPE.ASSIST] = {
            target_bias = 1.15,
        },
        [CHALLENGE_TYPE.TAKE_DAMAGE] = {
            target_bias = 1.25,
        },
    }
}

HERO_CHALLENGE_TYPES["npc_dota_hero_lich"] = {
	types = HERO_PRESETS.BASIC,
	types_override = {
        [CHALLENGE_TYPE.ASSIST] = {
            target_bias = 1.1,
        },
        [CHALLENGE_TYPE.CAPTURE_TIME] = {
            target_bias = 1.0,
        },
        [CHALLENGE_TYPE.DEAL_DAMAGE] = {
            target_bias = 1.1,
        },
        [CHALLENGE_TYPE.KILL] = {
            target_bias = 1.2,
        },
    }
}

HERO_CHALLENGE_TYPES["npc_dota_hero_life_stealer"] = {
	types = HERO_PRESETS.TANK,
	types_override = {
        [CHALLENGE_TYPE.KILL] = {
            target_bias = 1.2,
        },
        [CHALLENGE_TYPE.CAPTURE_TIME] = {
            target_bias = 1.6,
        },
        [CHALLENGE_TYPE.DEAL_DAMAGE] = {
            target_bias = 1.0,
        },
        [CHALLENGE_TYPE.TAKE_DAMAGE] = {
            target_bias = 1.15,
        },
        [CHALLENGE_TYPE.ASSIST] = {
            target_bias = 0.85,
        },
    }
}

HERO_CHALLENGE_TYPES["npc_dota_hero_lina"] = {
	types = HERO_PRESETS.STUN,
	types_override = {
        [CHALLENGE_TYPE.ASSIST] = {
            target_bias = 1,
        },
        [CHALLENGE_TYPE.KILL] = {
            target_bias = 1.4,
        },
        [CHALLENGE_TYPE.STUN] = {
            target_bias = 1.1,
        },
        [CHALLENGE_TYPE.CAPTURE_TIME] = {
            target_bias = 0.8,
        },
        [CHALLENGE_TYPE.DEAL_DAMAGE] = {
            target_bias = 1.2,
        },
    }
}

HERO_CHALLENGE_TYPES["npc_dota_hero_lion"] = {
	types = HERO_PRESETS.STUN,
	types_override = {
        [CHALLENGE_TYPE.ASSIST] = {
            target_bias = 0.8,
        },
        [CHALLENGE_TYPE.KILL] = {
            target_bias = 1.6,
        },
        [CHALLENGE_TYPE.STUN] = {
            target_bias = 2.3,
        },
        [CHALLENGE_TYPE.CAPTURE_TIME] = {
            target_bias = 1.1,
        },
        [CHALLENGE_TYPE.DEAL_DAMAGE] = {
            target_bias = 1.0,
        },
    }
}

HERO_CHALLENGE_TYPES["npc_dota_hero_lone_druid"] = {
	types = HERO_PRESETS.STUN_SUMMON_TANK,
	types_override = {
        [CHALLENGE_TYPE.ASSIST] = {
            target_bias = 0.65,
        },
        [CHALLENGE_TYPE.KILL] = {
            target_bias = 0.3,
        },
        [CHALLENGE_TYPE.STUN] = {
            target_bias = 0.7,
        },
        [CHALLENGE_TYPE.TAKE_DAMAGE] = {
            target_bias = 0.4,
        },
        [CHALLENGE_TYPE.CAPTURE_TIME] = {
            target_bias = 0.4,
        },
        [CHALLENGE_TYPE.DEAL_DAMAGE] = {
            target_bias = 0.4,
        },
        [CHALLENGE_TYPE.DEAL_DAMAGE_WITH_SUMMONS] = {
            target_bias = 1.0,
        },
    }
}

HERO_CHALLENGE_TYPES["npc_dota_hero_luna"] = {
	types = HERO_PRESETS.STUN,
	types_override = {
        [CHALLENGE_TYPE.ASSIST] = {
            target_bias = 0.9,
        },
        [CHALLENGE_TYPE.KILL] = {
            target_bias = 1.3,
        },
        [CHALLENGE_TYPE.DEAL_DAMAGE] = {
            target_bias = 1.1,
        },
        [CHALLENGE_TYPE.CAPTURE_TIME] = {
            target_bias = 0.9,
        },
        [CHALLENGE_TYPE.STUN] = {
            target_bias = 0.65,
        },
    }
}

HERO_CHALLENGE_TYPES["npc_dota_hero_lycan"] = {
	types = HERO_PRESETS.SUMMON,
	types_override = {
        [CHALLENGE_TYPE.ASSIST] = {
            target_bias = 1.15,
        },
        [CHALLENGE_TYPE.KILL] = {
            target_bias = 0.3,
        },
        [CHALLENGE_TYPE.CAPTURE_TIME] = {
            target_bias = 0.5,
        },
        [CHALLENGE_TYPE.DEAL_DAMAGE] = {
            target_bias = 0.3,
        },
        [CHALLENGE_TYPE.DEAL_DAMAGE_WITH_SUMMONS] = {
            target_bias = 0.7,
        },
        [CHALLENGE_TYPE.TAKE_DAMAGE] = {
            target_bias = 0.65,
        },
    }
}

HERO_CHALLENGE_TYPES["npc_dota_hero_magnataur"] = {
	types = HERO_PRESETS.STUN_TANK,
	types_override = {
        [CHALLENGE_TYPE.KILL] = {
            target_bias = 0.8,
        },
        [CHALLENGE_TYPE.ASSIST] = {
            target_bias = 0.9,
        },
        [CHALLENGE_TYPE.STUN] = {
            target_bias = 0.95,
        },
		[CHALLENGE_TYPE.TAKE_DAMAGE] = {
            target_bias = 0.8,
        },
        [CHALLENGE_TYPE.DEAL_DAMAGE] = {
            target_bias = 0.8,
        },
        [CHALLENGE_TYPE.CAPTURE_TIME] = {
            target_bias = 0.95,
        },
    }
}

HERO_CHALLENGE_TYPES["npc_dota_hero_marci"] = {
	types = HERO_PRESETS.STUN_TANK,
	types_override = {
        [CHALLENGE_TYPE.ASSIST] = {
            target_bias = 0.8,
        },
        [CHALLENGE_TYPE.KILL] = {
            target_bias = 0.65,
        },
        [CHALLENGE_TYPE.STUN] = {
            target_bias = 0.3,
        },
        [CHALLENGE_TYPE.TAKE_DAMAGE] = {
            target_bias = 0.7,
        },
        [CHALLENGE_TYPE.DEAL_DAMAGE] = {
            target_bias = 0.45,
        },
        [CHALLENGE_TYPE.CAPTURE_TIME] = {
            target_bias = 0.8,
        },
    }
}

HERO_CHALLENGE_TYPES["npc_dota_hero_mars"] = {
	types = HERO_PRESETS.STUN_TANK,
	types_override = {
        [CHALLENGE_TYPE.KILL] = {
            target_bias = 1.0,
        },
        [CHALLENGE_TYPE.ASSIST] = {
            target_bias = 0.95,
        },
        [CHALLENGE_TYPE.STUN] = {
            target_bias = 0.5,
        },
        [CHALLENGE_TYPE.CAPTURE_TIME] = {
            target_bias = 1.1,
        },
        [CHALLENGE_TYPE.TAKE_DAMAGE] = {
            target_bias = 1.2,
        },
        [CHALLENGE_TYPE.DEAL_DAMAGE] = {
            target_bias = 1.0,
        },
    }
}

HERO_CHALLENGE_TYPES["npc_dota_hero_medusa"] = {
	types = HERO_PRESETS.STUN_TANK,
	types_override = {
        [CHALLENGE_TYPE.DEAL_DAMAGE] = {
            target_bias = 1.1,
        },
        [CHALLENGE_TYPE.TAKE_DAMAGE] = {
            target_bias = 1.6,
        },
        [CHALLENGE_TYPE.STUN] = {
            target_bias = 1.4,
        },
        [CHALLENGE_TYPE.ASSIST] = {
            target_bias = 1.1,
        },
        [CHALLENGE_TYPE.CAPTURE_TIME] = {
            target_bias = 1.1,
        },
        [CHALLENGE_TYPE.KILL] = {
            target_bias = 0.8,
        },
    }
}

HERO_CHALLENGE_TYPES["npc_dota_hero_meepo"] = {
	types = HERO_PRESETS.STUN_TANK,
	types_override = {
        [CHALLENGE_TYPE.ASSIST] = {
            target_bias = 0.5,
        },
        [CHALLENGE_TYPE.KILL] = {
            target_bias = 0.45,
        },
        [CHALLENGE_TYPE.STUN] = {
            target_bias = 0.75,
        },
        [CHALLENGE_TYPE.TAKE_DAMAGE] = {
            target_bias = 0.75,
        },
        [CHALLENGE_TYPE.CAPTURE_TIME] = {
            target_bias = 0.75,
        },
        [CHALLENGE_TYPE.DEAL_DAMAGE] = {
            target_bias = 0.6,
        },
    }
}

HERO_CHALLENGE_TYPES["npc_dota_hero_mirana"] = {
	types = HERO_PRESETS.STUN,
	types_override = {
        [CHALLENGE_TYPE.STUN] = {
            target_bias = 1.2,
        },
        [CHALLENGE_TYPE.ASSIST] = {
            target_bias = 1,
        },
        [CHALLENGE_TYPE.KILL] = {
            target_bias = 1.1,
        },
        [CHALLENGE_TYPE.CAPTURE_TIME] = {
            target_bias = 0.8,
        },
        [CHALLENGE_TYPE.DEAL_DAMAGE] = {
            target_bias = 0.9,
        },
    }
}

HERO_CHALLENGE_TYPES["npc_dota_hero_monkey_king"] = {
	types = HERO_PRESETS.STUN_TANK,
	types_override = {
        [CHALLENGE_TYPE.ASSIST] = {
            target_bias = 0.8,
        },
        [CHALLENGE_TYPE.KILL] = {
            target_bias = 1.2,
        },
        [CHALLENGE_TYPE.STUN] = {
            target_bias = 0.65,
        },
        [CHALLENGE_TYPE.CAPTURE_TIME] = {
            target_bias = 1.2,
        },
        [CHALLENGE_TYPE.DEAL_DAMAGE] = {
            target_bias = 0.95,
        },
    }
}

HERO_CHALLENGE_TYPES["npc_dota_hero_morphling"] = {
	types = HERO_PRESETS.STUN_TANK,
	types_override = {
        [CHALLENGE_TYPE.ASSIST] = {
            target_bias = 0.75,
        },
        [CHALLENGE_TYPE.STUN] = {
            target_bias = 0.4,
        },
        [CHALLENGE_TYPE.TAKE_DAMAGE] = {
            target_bias = 0.9,
        },
        [CHALLENGE_TYPE.DEAL_DAMAGE] = {
            target_bias = 0.7,
        },
        [CHALLENGE_TYPE.CAPTURE_TIME] = {
            target_bias = 0.9,
        },
    }
}

HERO_CHALLENGE_TYPES["npc_dota_hero_muerta"] = {
	types = HERO_PRESETS.BASIC,
	types_override = {
        [CHALLENGE_TYPE.DEAL_DAMAGE] = {
            target_bias = 1.5,
        },
        [CHALLENGE_TYPE.ASSIST] = {
            target_bias = 1,
        },
        [CHALLENGE_TYPE.CAPTURE_TIME] = {
            target_bias = 0.5,
        },
        [CHALLENGE_TYPE.KILL] = {
            target_bias = 1.25,
        },
        [CHALLENGE_TYPE.TAKE_DAMAGE] = {
            target_bias = 1.15,
        },
    }
}

HERO_CHALLENGE_TYPES["npc_dota_hero_naga_siren"] = {
	types = HERO_PRESETS.STUN_TANK,
	types_override = {
        [CHALLENGE_TYPE.ASSIST] = {
            target_bias = 0.7,
        },
        [CHALLENGE_TYPE.KILL] = {
            target_bias = 0.5,
        },
        [CHALLENGE_TYPE.STUN] = {
            target_bias = 0.5,
        },
        [CHALLENGE_TYPE.TAKE_DAMAGE] = {
            target_bias = 0.6,
        },
        [CHALLENGE_TYPE.DEAL_DAMAGE] = {
            target_bias = 0.6,
        },
        [CHALLENGE_TYPE.CAPTURE_TIME] = {
            target_bias = 0.75,
        },
    }
}

HERO_CHALLENGE_TYPES["npc_dota_hero_necrolyte"] = {
	types = HERO_PRESETS.HEAL_TANK,
	types_override = {
        [CHALLENGE_TYPE.HEAL] = {
            target_bias = 1.25,
        },
        [CHALLENGE_TYPE.ASSIST] = {
            target_bias = 1.35,
        },
        [CHALLENGE_TYPE.KILL] = {
            target_bias = 1.5,
        },
        [CHALLENGE_TYPE.TAKE_DAMAGE] = {
            target_bias = 1.5,
        },
        [CHALLENGE_TYPE.CAPTURE_TIME] = {
            target_bias = 1.6,
        },
        [CHALLENGE_TYPE.DEAL_DAMAGE] = {
            target_bias = 1.45,
        },
    }
}

HERO_CHALLENGE_TYPES["npc_dota_hero_nevermore"] = {
	types = HERO_PRESETS.BASIC,
	types_override = {
        [CHALLENGE_TYPE.ASSIST] = {
            target_bias = 0.95,
        },
        [CHALLENGE_TYPE.KILL] = {
            target_bias = 1.55,
        },
        [CHALLENGE_TYPE.CAPTURE_TIME] = {
            target_bias = 1.2,
        },
        [CHALLENGE_TYPE.DEAL_DAMAGE] = {
            target_bias = 1.45,
        },
    }
}

HERO_CHALLENGE_TYPES["npc_dota_hero_night_stalker"] = {
	types = HERO_PRESETS.TANK,
	types_override = {
        [CHALLENGE_TYPE.ASSIST] = {
            target_bias = 0.8,
        },
        [CHALLENGE_TYPE.KILL] = {
            target_bias = 0.8,
        },
        [CHALLENGE_TYPE.TAKE_DAMAGE] = {
            target_bias = 0.75,
        },
        [CHALLENGE_TYPE.CAPTURE_TIME] = {
            target_bias = 0.75,
        },
        [CHALLENGE_TYPE.DEAL_DAMAGE] = {
            target_bias = 0.65,
        },
    }
}

HERO_CHALLENGE_TYPES["npc_dota_hero_nyx_assassin"] = {
	types = HERO_PRESETS.STUN_TANK,
	types_override = {
        [CHALLENGE_TYPE.KILL] = {
            target_bias = 1.0,
        },
        [CHALLENGE_TYPE.STUN] = {
            target_bias = 1.65,
        },
        [CHALLENGE_TYPE.TAKE_DAMAGE] = {
            target_bias = 0.8,
        },
        [CHALLENGE_TYPE.DEAL_DAMAGE] = {
            target_bias = 0.6,
        },
        [CHALLENGE_TYPE.CAPTURE_TIME] = {
            target_bias = 0.9,
        },
        [CHALLENGE_TYPE.ASSIST] = {
            target_bias = 0.9,
        },
    }
}

HERO_CHALLENGE_TYPES["npc_dota_hero_ogre_magi"] = {
	types = HERO_PRESETS.STUN_TANK,
	types_override = {
        [CHALLENGE_TYPE.ASSIST] = {
            target_bias = 1.05,
        },
        [CHALLENGE_TYPE.KILL] = {
            target_bias = 1.2,
        },
        [CHALLENGE_TYPE.STUN] = {
            target_bias = 1.6,
        },
        [CHALLENGE_TYPE.CAPTURE_TIME] = {
            target_bias = 1.25,
        },
        [CHALLENGE_TYPE.DEAL_DAMAGE] = {
            target_bias = 1.1,
        },
        [CHALLENGE_TYPE.TAKE_DAMAGE] = {
            target_bias = 1.2,
        },
    }
}

HERO_CHALLENGE_TYPES["npc_dota_hero_omniknight"] = {
	types = HERO_PRESETS.HEAL_TANK,
	types_override = {
        [CHALLENGE_TYPE.KILL] = {
            target_bias = 0.55,
        },
        [CHALLENGE_TYPE.TAKE_DAMAGE] = {
            target_bias = 0.8,
        },
        [CHALLENGE_TYPE.CAPTURE_TIME] = {
            target_bias = 1.1,
        },
        [CHALLENGE_TYPE.DEAL_DAMAGE] = {
            target_bias = 0.4,
        },
        [CHALLENGE_TYPE.HEAL] = {
            target_bias = 0.7,
        },
        [CHALLENGE_TYPE.ASSIST] = {
            target_bias = 0.7,
        },
    }
}

HERO_CHALLENGE_TYPES["npc_dota_hero_oracle"] = {
	types = HERO_PRESETS.HEAL_STUN,
	types_override = {
        [CHALLENGE_TYPE.ASSIST] = {
            target_bias = 0.95,
        },
        [CHALLENGE_TYPE.KILL] = {
            target_bias = 0.45,
        },
        [CHALLENGE_TYPE.STUN] = {
            target_bias = 0.5,
        },
        [CHALLENGE_TYPE.CAPTURE_TIME] = {
            target_bias = 0.5,
        },
        [CHALLENGE_TYPE.DEAL_DAMAGE] = {
            target_bias = 0.45,
        },
        [CHALLENGE_TYPE.TAKE_DAMAGE] = {
            target_bias = 0.7,
        },
        [CHALLENGE_TYPE.HEAL] = {
            target_bias = 0.5,
        },
    }
}

HERO_CHALLENGE_TYPES["npc_dota_hero_obsidian_destroyer"] = {
	types = HERO_PRESETS.STUN,
	types_override = {
        [CHALLENGE_TYPE.ASSIST] = {
            target_bias = 0.7,
        },
        [CHALLENGE_TYPE.KILL] = {
            target_bias = 1.05,
        },
        [CHALLENGE_TYPE.STUN] = {
            target_bias = 1.0,
        },
        [CHALLENGE_TYPE.CAPTURE_TIME] = {
            target_bias = 0.8,
        },
    }
}

HERO_CHALLENGE_TYPES["npc_dota_hero_pangolier"] = {
	types = HERO_PRESETS.STUN_TANK,
	types_override = {
        [CHALLENGE_TYPE.ASSIST] = {
            target_bias = 1.05,
        },
        [CHALLENGE_TYPE.STUN] = {
            target_bias = 0.45,
        },
        [CHALLENGE_TYPE.TAKE_DAMAGE] = {
            target_bias = 1.0,
        },
        [CHALLENGE_TYPE.CAPTURE_TIME] = {
            target_bias = 0.9,
        },
    }
}

HERO_CHALLENGE_TYPES["npc_dota_hero_phantom_assassin"] = {
	types = HERO_PRESETS.TANK,
	types_override = {
        [CHALLENGE_TYPE.KILL] = {
            target_bias = 1.7,
        },
        [CHALLENGE_TYPE.CAPTURE_TIME] = {
            target_bias = 1.3,
        },
        [CHALLENGE_TYPE.DEAL_DAMAGE] = {
            target_bias = 1.3,
        },
        [CHALLENGE_TYPE.TAKE_DAMAGE] = {
            target_bias = 1.0,
        },
        [CHALLENGE_TYPE.ASSIST] = {
            target_bias = 0.8,
        },
    }
}

HERO_CHALLENGE_TYPES["npc_dota_hero_phantom_lancer"] = {
	types = HERO_PRESETS.TANK,
	types_override = {
        [CHALLENGE_TYPE.ASSIST] = {
            target_bias = 0.85,
        },
        [CHALLENGE_TYPE.KILL] = {
            target_bias = 0.9,
        },
        [CHALLENGE_TYPE.TAKE_DAMAGE] = {
            target_bias = 0.9,
        },
        [CHALLENGE_TYPE.DEAL_DAMAGE] = {
            target_bias = 0.9,
        },
    }
}

HERO_CHALLENGE_TYPES["npc_dota_hero_phoenix"] = {
	types = HERO_PRESETS.HEAL,
	types_override = {
        [CHALLENGE_TYPE.HEAL] = {
            target_bias = 0.6,
        },
        [CHALLENGE_TYPE.ASSIST] = {
            target_bias = 1.3,
        },
        [CHALLENGE_TYPE.KILL] = {
            target_bias = 0.45,
        },
        [CHALLENGE_TYPE.CAPTURE_TIME] = {
            target_bias = 0.4,
        },
        [CHALLENGE_TYPE.DEAL_DAMAGE] = {
            target_bias = 0.9,
        },
    }
}

HERO_CHALLENGE_TYPES["npc_dota_hero_primal_beast"] = {
	types = HERO_PRESETS.STUN_TANK,
	types_override = {
        [CHALLENGE_TYPE.KILL] = {
            target_bias = 0.8,
        },
        [CHALLENGE_TYPE.ASSIST] = {
            target_bias = 1,
        },
        [CHALLENGE_TYPE.STUN] = {
            target_bias = 0.7,
        },
        [CHALLENGE_TYPE.DEAL_DAMAGE] = {
            target_bias = 0.75,
        },
        [CHALLENGE_TYPE.CAPTURE_TIME] = {
            target_bias = 0.95,
        },
        [CHALLENGE_TYPE.TAKE_DAMAGE] = {
            target_bias = 1.1,
        },
    }
}

HERO_CHALLENGE_TYPES["npc_dota_hero_puck"] = {
	types = HERO_PRESETS.STUN,
	types_override = {
        [CHALLENGE_TYPE.ASSIST] = {
            target_bias = 0.9,
        },
        [CHALLENGE_TYPE.STUN] = {
            target_bias = 0.15,
        },
        [CHALLENGE_TYPE.CAPTURE_TIME] = {
            target_bias = 0.7,
        },
        [CHALLENGE_TYPE.DEAL_DAMAGE] = {
            target_bias = 0.8,
        },
        [CHALLENGE_TYPE.KILL] = {
            target_bias = 0.7,
        },
    }
}

HERO_CHALLENGE_TYPES["npc_dota_hero_pudge"] = {
	types = HERO_PRESETS.STUN_TANK,
	types_override = {
        [CHALLENGE_TYPE.ASSIST] = {
            target_bias = 1.0,
        },
        [CHALLENGE_TYPE.KILL] = {
            target_bias = 1.35,
        },
        [CHALLENGE_TYPE.TAKE_DAMAGE] = {
            target_bias = 1.9,
        },
        [CHALLENGE_TYPE.CAPTURE_TIME] = {
            target_bias = 1.6,
        },
        [CHALLENGE_TYPE.DEAL_DAMAGE] = {
            target_bias = 1.4,
        },
        [CHALLENGE_TYPE.STUN] = {
            target_bias = 0.85,
        },
    }
}

HERO_CHALLENGE_TYPES["npc_dota_hero_pugna"] = {
	types = HERO_PRESETS.BASIC,
	types_override = {
        [CHALLENGE_TYPE.KILL] = {
            target_bias = 1.5,
        },
        [CHALLENGE_TYPE.CAPTURE_TIME] = {
            target_bias = 0.85,
        },
        [CHALLENGE_TYPE.DEAL_DAMAGE] = {
            target_bias = 1.3,
        },
        [CHALLENGE_TYPE.ASSIST] = {
            target_bias = 1.3,
        },
    }
}

HERO_CHALLENGE_TYPES["npc_dota_hero_queenofpain"] = {
	types = HERO_PRESETS.TANK,
	types_override = {
        [CHALLENGE_TYPE.KILL] = {
            target_bias = 1.1,
        },
        [CHALLENGE_TYPE.TAKE_DAMAGE] = {
            target_bias = 0.95,
        },
        [CHALLENGE_TYPE.CAPTURE_TIME] = {
            target_bias = 1.1,
        },
        [CHALLENGE_TYPE.DEAL_DAMAGE] = {
            target_bias = 1.1,
        },
        [CHALLENGE_TYPE.ASSIST] = {
            target_bias = 1.15,
        },
    }
}

HERO_CHALLENGE_TYPES["npc_dota_hero_rattletrap"] = {
	types = HERO_PRESETS.STUN_TANK,
	types_override = {
        [CHALLENGE_TYPE.ASSIST] = {
            target_bias = 1.25,
        },
        [CHALLENGE_TYPE.TAKE_DAMAGE] = {
            target_bias = 0.75,
        },
        [CHALLENGE_TYPE.DEAL_DAMAGE] = {
            target_bias = 0.65,
        },
        [CHALLENGE_TYPE.CAPTURE_TIME] = {
            target_bias = 0.75,
        },
        [CHALLENGE_TYPE.KILL] = {
            target_bias = 0.6,
        },
        [CHALLENGE_TYPE.STUN] = {
            target_bias = 0.5,
        },
    }
}

HERO_CHALLENGE_TYPES["npc_dota_hero_razor"] = {
	types = HERO_PRESETS.TANK,
	types_override = {
        [CHALLENGE_TYPE.ASSIST] = {
            target_bias = 1.25,
        },
        [CHALLENGE_TYPE.KILL] = {
            target_bias = 0.8,
        },
        [CHALLENGE_TYPE.TAKE_DAMAGE] = {
            target_bias = 1.25,
        },
        [CHALLENGE_TYPE.CAPTURE_TIME] = {
            target_bias = 1.1,
        },
        [CHALLENGE_TYPE.DEAL_DAMAGE] = {
            target_bias = 1.2,
        },
    }
}

HERO_CHALLENGE_TYPES["npc_dota_hero_ringmaster"] = {
	types = HERO_PRESETS.BASIC,
	types_override = {
        [CHALLENGE_TYPE.KILL] = {
            target_bias = 1,
        },
        [CHALLENGE_TYPE.ASSIST] = {
            target_bias = 1,
        },
    }
}

HERO_CHALLENGE_TYPES["npc_dota_hero_riki"] = {
	types = HERO_PRESETS.BASIC,
	types_override = {
        [CHALLENGE_TYPE.KILL] = {
            target_bias = 1.15,
        },
        [CHALLENGE_TYPE.ASSIST] = {
            target_bias = 0.85,
        },
        [CHALLENGE_TYPE.DEAL_DAMAGE] = {
            target_bias = 0.85,
        },
        [CHALLENGE_TYPE.DEAL_DAMAGE] = {
            target_bias = 0.9,
        },
    }
}

HERO_CHALLENGE_TYPES["npc_dota_hero_rubick"] = {
	types = HERO_PRESETS.STUN,
	types_override = {
        [CHALLENGE_TYPE.ASSIST] = {
            target_bias = 1.1,
        },
        [CHALLENGE_TYPE.KILL] = {
            target_bias = 1.3,
        },
        [CHALLENGE_TYPE.STUN] = {
            target_bias = 1.05,
        },
        [CHALLENGE_TYPE.CAPTURE_TIME] = {
            target_bias = 0.7,
        },
    }
}

HERO_CHALLENGE_TYPES["npc_dota_hero_sand_king"] = {
	types = HERO_PRESETS.STUN,
	types_override = {
        [CHALLENGE_TYPE.ASSIST] = {
            target_bias = 1.1,
        },
        [CHALLENGE_TYPE.KILL] = {
            target_bias = 0.9,
        },
        [CHALLENGE_TYPE.STUN] = {
            target_bias = 1.2,
        },
        [CHALLENGE_TYPE.CAPTURE_TIME] = {
            target_bias = 1.2,
        },
    }
}

HERO_CHALLENGE_TYPES["npc_dota_hero_shadow_demon"] = {
	types = HERO_PRESETS.BASIC,
	types_override = {
        [CHALLENGE_TYPE.ASSIST] = {
            target_bias = 1.05,
        },
        [CHALLENGE_TYPE.KILL] = {
            target_bias = 0.5,
        },
        [CHALLENGE_TYPE.CAPTURE_TIME] = {
            target_bias = 0.4,
        },
        [CHALLENGE_TYPE.DEAL_DAMAGE] = {
            target_bias = 0.7,
        },
    }
}

HERO_CHALLENGE_TYPES["npc_dota_hero_shadow_shaman"] = {
	types = HERO_PRESETS.STUN_SUMMON,
	types_override = {
        [CHALLENGE_TYPE.DEAL_DAMAGE_WITH_SUMMONS] = {
            target_bias = 2.3,
        },
        [CHALLENGE_TYPE.ASSIST] = {
            target_bias = 1.25,
        },
        [CHALLENGE_TYPE.KILL] = {
            target_bias = 0.9,
        },
        [CHALLENGE_TYPE.STUN] = {
            target_bias = 1.6,
        },
        [CHALLENGE_TYPE.DEAL_DAMAGE] = {
            target_bias = 1.2,
        },
        [CHALLENGE_TYPE.CAPTURE_TIME] = {
            target_bias = 1.0,
        },
    }
}

HERO_CHALLENGE_TYPES["npc_dota_hero_shredder"] = {
	types = HERO_PRESETS.TANK,
	types_override = {
        [CHALLENGE_TYPE.ASSIST] = {
            target_bias = 1.1,
        },
        [CHALLENGE_TYPE.KILL] = {
            target_bias = 0.85,
        },
        [CHALLENGE_TYPE.CAPTURE_TIME] = {
            target_bias = 0.8,
        },
        [CHALLENGE_TYPE.DEAL_DAMAGE] = {
            target_bias = 0.7,
        },
    }
}

HERO_CHALLENGE_TYPES["npc_dota_hero_silencer"] = {
	types = HERO_PRESETS.BASIC,
	types_override = {
        [CHALLENGE_TYPE.KILL] = {
            target_bias = 1.3,
        },
        [CHALLENGE_TYPE.DEAL_DAMAGE] = {
            target_bias = 1.15,
        },
        [CHALLENGE_TYPE.ASSIST] = {
            target_bias = 1.1,
        },
        [CHALLENGE_TYPE.CAPTURE_TIME] = {
            target_bias = 0.75,
        },
    }
}

HERO_CHALLENGE_TYPES["npc_dota_hero_skeleton_king"] = {
	types = HERO_PRESETS.STUN_SUMMON_TANK,
	types_override = {
        [CHALLENGE_TYPE.DEAL_DAMAGE_WITH_SUMMONS] = {
            target_bias = 1.75,
        },
        [CHALLENGE_TYPE.KILL] = {
            target_bias = 0.95,
        },
        [CHALLENGE_TYPE.STUN] = {
            target_bias = 1.0,
        },
        [CHALLENGE_TYPE.TAKE_DAMAGE] = {
            target_bias = 1.45,
        },
        [CHALLENGE_TYPE.CAPTURE_TIME] = {
            target_bias = 1.3,
        },
        [CHALLENGE_TYPE.DEAL_DAMAGE] = {
            target_bias = 1,
        },
        [CHALLENGE_TYPE.ASSIST] = {
            target_bias = 0.9,
        },
    }
}

HERO_CHALLENGE_TYPES["npc_dota_hero_skywrath_mage"] = {
	types = HERO_PRESETS.BASIC,
	types_override = {
        [CHALLENGE_TYPE.KILL] = {
            target_bias = 1.45,
        },
        [CHALLENGE_TYPE.CAPTURE_TIME] = {
            target_bias = 0.7,
        },
        [CHALLENGE_TYPE.DEAL_DAMAGE] = {
            target_bias = 1.3,
        },
        [CHALLENGE_TYPE.ASSIST] = {
            target_bias = 1.2,
        },
    }
}

HERO_CHALLENGE_TYPES["npc_dota_hero_slardar"] = {
	types = HERO_PRESETS.STUN_TANK,
	types_override = {
        [CHALLENGE_TYPE.ASSIST] = {
            target_bias = 0.7,
        },
        [CHALLENGE_TYPE.STUN] = {
            target_bias = 0.8,
        },
        [CHALLENGE_TYPE.CAPTURE_TIME] = {
            target_bias = 1,
        },
        [CHALLENGE_TYPE.DEAL_DAMAGE] = {
            target_bias = 0.7,
        },
        [CHALLENGE_TYPE.TAKE_DAMAGE] = {
            target_bias = 1.0,
        },
        [CHALLENGE_TYPE.KILL] = {
            target_bias = 0.8,
        },
    }
}

HERO_CHALLENGE_TYPES["npc_dota_hero_slark"] = {
	types = HERO_PRESETS.TANK,
	types_override = {
        [CHALLENGE_TYPE.ASSIST] = {
            target_bias = 0.75,
        },
        [CHALLENGE_TYPE.TAKE_DAMAGE] = {
            target_bias = 1.1,
        },
        [CHALLENGE_TYPE.DEAL_DAMAGE] = {
            target_bias = 0.8,
        },
        [CHALLENGE_TYPE.CAPTURE_TIME] = {
            target_bias = 1.25,
        },
    }
}

HERO_CHALLENGE_TYPES["npc_dota_hero_snapfire"] = {
	types = HERO_PRESETS.STUN,
	types_override = {
        [CHALLENGE_TYPE.ASSIST] = {
            target_bias = 0.95,
        },
        [CHALLENGE_TYPE.KILL] = {
            target_bias = 1.3,
        },
        [CHALLENGE_TYPE.STUN] = {
            target_bias = 0.25,
        },
        [CHALLENGE_TYPE.CAPTURE_TIME] = {
            target_bias = 0.95,
        },
        [CHALLENGE_TYPE.DEAL_DAMAGE] = {
            target_bias = 1.35,
        },
    }
}

HERO_CHALLENGE_TYPES["npc_dota_hero_sniper"] = {
	types = HERO_PRESETS.BASIC,
	types_override = {
        [CHALLENGE_TYPE.ASSIST] = {
            target_bias = 1.05,
        },
        [CHALLENGE_TYPE.KILL] = {
            target_bias = 1.6,
        },
        [CHALLENGE_TYPE.CAPTURE_TIME] = {
            target_bias = 0.7,
        },
        [CHALLENGE_TYPE.DEAL_DAMAGE] = {
            target_bias = 1.45,
        },
    }
}

HERO_CHALLENGE_TYPES["npc_dota_hero_spectre"] = {
	types = HERO_PRESETS.TANK,
	types_override = {
        [CHALLENGE_TYPE.ASSIST] = {
            target_bias = 1.3,
        },
        [CHALLENGE_TYPE.KILL] = {
            target_bias = 1.1,
        },
        [CHALLENGE_TYPE.TAKE_DAMAGE] = {
            target_bias = 1.4,
        },
        [CHALLENGE_TYPE.CAPTURE_TIME] = {
            target_bias = 1.4,
        },
        [CHALLENGE_TYPE.DEAL_DAMAGE] = {
            target_bias = 1.2,
        },
    }
}

HERO_CHALLENGE_TYPES["npc_dota_hero_spirit_breaker"] = {
	types = HERO_PRESETS.STUN_TANK,
	types_override = {
        [CHALLENGE_TYPE.KILL] = {
            target_bias = 1.2,
        },
        [CHALLENGE_TYPE.STUN] = {
            target_bias = 2.2,
        },
        [CHALLENGE_TYPE.CAPTURE_TIME] = {
            target_bias = 1.15,
        },
        [CHALLENGE_TYPE.DEAL_DAMAGE] = {
            target_bias = 0.85,
        },
        [CHALLENGE_TYPE.ASSIST] = {
            target_bias = 0.9,
        },
        [CHALLENGE_TYPE.TAKE_DAMAGE] = {
            target_bias = 1.05,
        },
    }
}

HERO_CHALLENGE_TYPES["npc_dota_hero_storm_spirit"] = {
	types = HERO_PRESETS.STUN,
	types_override = {
        [CHALLENGE_TYPE.ASSIST] = {
            target_bias = 0.95,
        },
        [CHALLENGE_TYPE.STUN] = {
            target_bias = 0.8,
        },
    }
}

HERO_CHALLENGE_TYPES["npc_dota_hero_sven"] = {
	types = HERO_PRESETS.STUN_TANK,
	types_override = {
        [CHALLENGE_TYPE.ASSIST] = {
            target_bias = 0.8,
        },
        [CHALLENGE_TYPE.KILL] = {
            target_bias = 1,
        },
        [CHALLENGE_TYPE.STUN] = {
            target_bias = 0.8,
        },
        [CHALLENGE_TYPE.TAKE_DAMAGE] = {
            target_bias = 1.1,
        },
        [CHALLENGE_TYPE.CAPTURE_TIME] = {
            target_bias = 0.9,
        },
        [CHALLENGE_TYPE.DEAL_DAMAGE] = {
            target_bias = 0.9,
        },
    }
}

HERO_CHALLENGE_TYPES["npc_dota_hero_techies"] = {
	types = HERO_PRESETS.STUN,
	types_override = {
        [CHALLENGE_TYPE.KILL] = {
            target_bias = 1.0,
        },
        [CHALLENGE_TYPE.STUN] = {
            target_bias = 0.3,
        },
        [CHALLENGE_TYPE.DEAL_DAMAGE] = {
            target_bias = 1.1,
        },
        [CHALLENGE_TYPE.CAPTURE_TIME] = {
            target_bias = 0.7,
        },
        [CHALLENGE_TYPE.ASSIST] = {
            target_bias = 0.95,
        },
    }
}

HERO_CHALLENGE_TYPES["npc_dota_hero_templar_assassin"] = {
	types = HERO_PRESETS.BASIC,
	types_override = {
        [CHALLENGE_TYPE.ASSIST] = {
            target_bias = 0.75,
        },
        [CHALLENGE_TYPE.KILL] = {
            target_bias = 0.9,
        },
        [CHALLENGE_TYPE.DEAL_DAMAGE] = {
            target_bias = 0.8,
        },
        [CHALLENGE_TYPE.CAPTURE_TIME] = {
            target_bias = 0.65,
        },
    }
}

HERO_CHALLENGE_TYPES["npc_dota_hero_terrorblade"] = {
	types = HERO_PRESETS.TANK,
	types_override = {
        [CHALLENGE_TYPE.ASSIST] = {
            target_bias = 0.85,
        },
        [CHALLENGE_TYPE.KILL] = {
            target_bias = 0.7,
        },
        [CHALLENGE_TYPE.TAKE_DAMAGE] = {
            target_bias = 0.7,
        },
        [CHALLENGE_TYPE.DEAL_DAMAGE] = {
            target_bias = 0.75,
        },
        [CHALLENGE_TYPE.CAPTURE_TIME] = {
            target_bias = 0.8,
        },
    }
}

HERO_CHALLENGE_TYPES["npc_dota_hero_tidehunter"] = {
	types = HERO_PRESETS.STUN_TANK,
	types_override = {
        [CHALLENGE_TYPE.ASSIST] = {
            target_bias = 1,
        },
        [CHALLENGE_TYPE.KILL] = {
            target_bias = 0.8,
        },
        [CHALLENGE_TYPE.STUN] = {
            target_bias = 1.0,
        },
        [CHALLENGE_TYPE.TAKE_DAMAGE] = {
            target_bias = 1.3,
        },
        [CHALLENGE_TYPE.DEAL_DAMAGE] = {
            target_bias = 0.8,
        },
        [CHALLENGE_TYPE.CAPTURE_TIME] = {
            target_bias = 1.1,
        },
    }
}

HERO_CHALLENGE_TYPES["npc_dota_hero_tinker"] = {
	types = HERO_PRESETS.BASIC,
	types_override = {
        [CHALLENGE_TYPE.CAPTURE_TIME] = {
            target_bias = 0.7,
        },
        [CHALLENGE_TYPE.CAPTURE_TIME] = {
            target_bias = 0.3,
        },
        [CHALLENGE_TYPE.ASSIST] = {
            target_bias = 1.1,
        },
        [CHALLENGE_TYPE.KILL] = {
            target_bias = 0.9,
        },
    }
}

HERO_CHALLENGE_TYPES["npc_dota_hero_tiny"] = {
	types = HERO_PRESETS.STUN_TANK,
	types_override = {
        [CHALLENGE_TYPE.ASSIST] = {
            target_bias = 0.85,
        },
        [CHALLENGE_TYPE.KILL] = {
            target_bias = 1.2,
        },
        [CHALLENGE_TYPE.STUN] = {
            target_bias = 0.5,
        },
        [CHALLENGE_TYPE.CAPTURE_TIME] = {
            target_bias = 1.1,
        },
        [CHALLENGE_TYPE.DEAL_DAMAGE] = {
            target_bias = 0.8,
        },
    }
}

HERO_CHALLENGE_TYPES["npc_dota_hero_treant"] = {
	types = HERO_PRESETS.HEAL_STUN_TANK,
	types_override = {
        [CHALLENGE_TYPE.KILL] = {
            target_bias = 0.35,
        },
        [CHALLENGE_TYPE.STUN] = {
            target_bias = 0.8,
        },
        [CHALLENGE_TYPE.CAPTURE_TIME] = {
            target_bias = 0.8,
        },
        [CHALLENGE_TYPE.DEAL_DAMAGE] = {
            target_bias = 0.5,
        },
        [CHALLENGE_TYPE.HEAL] = {
            target_bias = 1.0,
        },
        [CHALLENGE_TYPE.TAKE_DAMAGE] = {
            target_bias = 0.6,
        },
        [CHALLENGE_TYPE.ASSIST] = {
            target_bias = 1.15,
        },
    }
}

HERO_CHALLENGE_TYPES["npc_dota_hero_troll_warlord"] = {
	types = HERO_PRESETS.STUN_TANK,
	types_override = {
        [CHALLENGE_TYPE.ASSIST] = {
            target_bias = 0.8,
        },
        [CHALLENGE_TYPE.STUN] = {
            target_bias = 0.65,
        },
        [CHALLENGE_TYPE.TAKE_DAMAGE] = {
            target_bias = 1.25,
        },
        [CHALLENGE_TYPE.DEAL_DAMAGE] = {
            target_bias = 0.85,
        },
    }
}

HERO_CHALLENGE_TYPES["npc_dota_hero_tusk"] = {
	types = HERO_PRESETS.STUN_TANK,
	types_override = {
        [CHALLENGE_TYPE.KILL] = {
            target_bias = 1.4,
        },
        [CHALLENGE_TYPE.STUN] = {
            target_bias = 1.05,
        },
        [CHALLENGE_TYPE.CAPTURE_TIME] = {
            target_bias = 1.05,
        },
        [CHALLENGE_TYPE.DEAL_DAMAGE] = {
            target_bias = 1,
        },
        [CHALLENGE_TYPE.ASSIST] = {
            target_bias = 0.75,
        },
    }
}

HERO_CHALLENGE_TYPES["npc_dota_hero_undying"] = {
	types = HERO_PRESETS.HEAL_SUMMON,
	types_override = {
        [CHALLENGE_TYPE.DEAL_DAMAGE_WITH_SUMMONS] = {
            target_bias = 1.3,
        },
        [CHALLENGE_TYPE.HEAL] = {
            target_bias = 0.3,
        },
        [CHALLENGE_TYPE.ASSIST] = {
            target_bias = 1.45,
        },
        [CHALLENGE_TYPE.CAPTURE_TIME] = {
            target_bias = 1.25,
        },
        [CHALLENGE_TYPE.DEAL_DAMAGE] = {
            target_bias = 0.9,
        },
        [CHALLENGE_TYPE.KILL] = {
            target_bias = 1.3,
        },
    }
}

HERO_CHALLENGE_TYPES["npc_dota_hero_ursa"] = {
	types = HERO_PRESETS.TANK,
	types_override = {
        [CHALLENGE_TYPE.ASSIST] = {
            target_bias = 0.8,
        },
        [CHALLENGE_TYPE.KILL] = {
            target_bias = 1.2,
        },
        [CHALLENGE_TYPE.TAKE_DAMAGE] = {
            target_bias = 1.4,
        },
        [CHALLENGE_TYPE.CAPTURE_TIME] = {
            target_bias = 1.3,
        },
        [CHALLENGE_TYPE.DEAL_DAMAGE] = {
            target_bias = 0.85,
        },
    }
}

HERO_CHALLENGE_TYPES["npc_dota_hero_vengefulspirit"] = {
	types = HERO_PRESETS.STUN_TANK,
	types_override = {
        [CHALLENGE_TYPE.ASSIST] = {
            target_bias = 1.0,
        },
        [CHALLENGE_TYPE.KILL] = {
            target_bias = 0.8,
        },
        [CHALLENGE_TYPE.STUN] = {
            target_bias = 1.6,
        },
        [CHALLENGE_TYPE.DEAL_DAMAGE] = {
            target_bias = 0.85,
        },
        [CHALLENGE_TYPE.TAKE_DAMAGE] = {
            target_bias = 0.9,
        },
        [CHALLENGE_TYPE.CAPTURE_TIME] = {
            target_bias = 0.9,
        },
    }
}

HERO_CHALLENGE_TYPES["npc_dota_hero_venomancer"] = {
	types = HERO_PRESETS.SUMMON,
	types_override = {
        [CHALLENGE_TYPE.DEAL_DAMAGE_WITH_SUMMONS] = {
            target_bias = 1.5,
        },
        [CHALLENGE_TYPE.ASSIST] = {
            target_bias = 1.2,
        },
        [CHALLENGE_TYPE.CAPTURE_TIME] = {
            target_bias = 1.0,
        },
        [CHALLENGE_TYPE.DEAL_DAMAGE] = {
            target_bias = 1.5,
        },
        [CHALLENGE_TYPE.KILL] = {
            target_bias = 1.15,
        },
    }
}

HERO_CHALLENGE_TYPES["npc_dota_hero_viper"] = {
	types = HERO_PRESETS.TANK,
	types_override = {
        [CHALLENGE_TYPE.ASSIST] = {
            target_bias = 1.1,
        },
        [CHALLENGE_TYPE.TAKE_DAMAGE] = {
            target_bias = 1.4,
        },
        [CHALLENGE_TYPE.DEAL_DAMAGE] = {
            target_bias = 1.35,
        },
        [CHALLENGE_TYPE.CAPTURE_TIME] = {
            target_bias = 1.2,
        },
        [CHALLENGE_TYPE.KILL] = {
            target_bias = 1.0,
        },
        [CHALLENGE_TYPE.ASSIST] = {
            target_bias = 0.8,
        },
    }
}

HERO_CHALLENGE_TYPES["npc_dota_hero_visage"] = {
	types = HERO_PRESETS.SUMMON_TANK,
	types_override = {
        [CHALLENGE_TYPE.DEAL_DAMAGE_WITH_SUMMONS] = {
            target_bias = 0.8,
        },
        [CHALLENGE_TYPE.ASSIST] = {
            target_bias = 0.9,
        },
        [CHALLENGE_TYPE.KILL] = {
            target_bias = 0.9,
        },
        [CHALLENGE_TYPE.TAKE_DAMAGE] = {
            target_bias = 0.9,
        },
        [CHALLENGE_TYPE.CAPTURE_TIME] = {
            target_bias = 1,
        },
        [CHALLENGE_TYPE.DEAL_DAMAGE] = {
            target_bias = 1,
        },
    }
}

HERO_CHALLENGE_TYPES["npc_dota_hero_void_spirit"] = {
	types = HERO_PRESETS.BASIC,
	types_override = {
        [CHALLENGE_TYPE.DEAL_DAMAGE] = {
            target_bias = 0.8,
        },
        [CHALLENGE_TYPE.CAPTURE_TIME] = {
            target_bias = 0.95,
        },
        [CHALLENGE_TYPE.ASSIST] = {
            target_bias = 0.95,
        },
        [CHALLENGE_TYPE.KILL] = {
            target_bias = 1.1,
        },
    }
}

HERO_CHALLENGE_TYPES["npc_dota_hero_warlock"] = {
	types = HERO_PRESETS.HEAL_SUMMON,
	types_override = {
        [CHALLENGE_TYPE.DEAL_DAMAGE_WITH_SUMMONS] = {
            target_bias = 1.25,
        },
        [CHALLENGE_TYPE.ASSIST] = {
            target_bias = 1.35,
        },
        [CHALLENGE_TYPE.KILL] = {
            target_bias = 0.8,
        },
        [CHALLENGE_TYPE.CAPTURE_TIME] = {
            target_bias = 0.45,
        },
        [CHALLENGE_TYPE.DEAL_DAMAGE] = {
            target_bias = 1.05,
        },
        [CHALLENGE_TYPE.HEAL] = {
            target_bias = 1.0,
        },
    }
}

HERO_CHALLENGE_TYPES["npc_dota_hero_weaver"] = {
	types = HERO_PRESETS.BASIC,
	types_override = {
        [CHALLENGE_TYPE.KILL] = {
            target_bias = 1.25,
        },
        [CHALLENGE_TYPE.CAPTURE_TIME] = {
            target_bias = 0.6,
        },
        [CHALLENGE_TYPE.DEAL_DAMAGE] = {
            target_bias = 1.05,
        },
        [CHALLENGE_TYPE.ASSIST] = {
            target_bias = 0.95,
        },
    }
}

HERO_CHALLENGE_TYPES["npc_dota_hero_windrunner"] = {
	types = HERO_PRESETS.STUN,
	types_override = {
        [CHALLENGE_TYPE.DEAL_DAMAGE] = {
            target_bias = 0.7,
        },
        [CHALLENGE_TYPE.DEAL_DAMAGE] = {
            target_bias = 0.8,
        },
        [CHALLENGE_TYPE.STUN] = {
            target_bias = 1.1,
        },
        [CHALLENGE_TYPE.KILL] = {
            target_bias = 1.15,
        },
        [CHALLENGE_TYPE.ASSIST] = {
            target_bias = 0.95,
        },
        [CHALLENGE_TYPE.CAPTURE_TIME] = {
            target_bias = 0.85,
        },
    }
}

HERO_CHALLENGE_TYPES["npc_dota_hero_winter_wyvern"] = {
	types = HERO_PRESETS.HEAL,
	types_override = {
        [CHALLENGE_TYPE.CAPTURE_TIME] = {
            target_bias = 0.75,
        },
        [CHALLENGE_TYPE.DEAL_DAMAGE] = {
            target_bias = 1.3,
        },
        [CHALLENGE_TYPE.HEAL] = {
            target_bias = 0.7,
        },
        [CHALLENGE_TYPE.KILL] = {
            target_bias = 1.1,
        },
        [CHALLENGE_TYPE.ASSIST] = {
            target_bias = 0.9,
        },
    }
}

HERO_CHALLENGE_TYPES["npc_dota_hero_wisp"] = {
	types = HERO_PRESETS.HEAL_TANK,
	types_override = {
        [CHALLENGE_TYPE.HEAL] = {
            target_bias = 1.45,
        },
        [CHALLENGE_TYPE.KILL] = {
            target_bias = 0.3,
        },
        [CHALLENGE_TYPE.DEAL_DAMAGE] = {
            target_bias = 0.7,
        },
        [CHALLENGE_TYPE.CAPTURE_TIME] = {
            target_bias = 0.85,
        },
        [CHALLENGE_TYPE.TAKE_DAMAGE] = {
            target_bias = 0.9,
        },
        [CHALLENGE_TYPE.ASSIST] = {
            target_bias = 1,
        },
    }
}

HERO_CHALLENGE_TYPES["npc_dota_hero_witch_doctor"] = {
	types = HERO_PRESETS.ALL,
	types_override = {
        [CHALLENGE_TYPE.DEAL_DAMAGE_WITH_SUMMONS] = {
            target_bias = 2.1,
        },
        [CHALLENGE_TYPE.HEAL] = {
            target_bias = 1.6,
        },
        [CHALLENGE_TYPE.ASSIST] = {
            target_bias = 1.1,
        },
        [CHALLENGE_TYPE.KILL] = {
            target_bias = 1.45,
        },
        [CHALLENGE_TYPE.STUN] = {
            target_bias = 1.5,
        },
        [CHALLENGE_TYPE.TAKE_DAMAGE] = {
            target_bias = 0.6,
        },
        [CHALLENGE_TYPE.CAPTURE_TIME] = {
            target_bias = 1.0,
        },
        [CHALLENGE_TYPE.DEAL_DAMAGE] = {
            target_bias = 1.6,
        },
    }
}

HERO_CHALLENGE_TYPES["npc_dota_hero_zuus"] = {
	types = HERO_PRESETS.BASIC,
	types_override = {
        [CHALLENGE_TYPE.ASSIST] = {
            target_bias = 1.55,
        },
        [CHALLENGE_TYPE.KILL] = {
            target_bias = 1.6,
        },
        [CHALLENGE_TYPE.CAPTURE_TIME] = {
            target_bias = 0.9,
        },
        [CHALLENGE_TYPE.DEAL_DAMAGE] = {
            target_bias = 1.7,
        },
    }
}

HERO_CHALLENGE_TYPES["npc_dota_hero_kez"] = {
	types = HERO_PRESETS.TANK,
}