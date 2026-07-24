--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


GAME_MAX_ROUNDS = 120

GAME_ROUND_GROUPS = {
    [1] = { min_round = 1, max_round = 20, randomize = false },
    [2] = { min_round = 20, max_round = 40, randomize = true },
    [3] = { min_round = 40, max_round = 60, randomize = true },
    [4] = { min_round = 60, max_round = 80, randomize = true },
    [5] = { min_round = 80, max_round = 100, randomize = true },
    [6] = { min_round = 101, max_round = 120, randomize = true },
}

GAME_ROUNDS_LIST = {
    [1] = {
        name = "#ROUNDS_Kobolds",

        type = ROUND_TYPES.BASIC,
        creeps = {
            npc_dota_kobold = {
                count = 8,
            },
        }
    },
    [2] = {
        name = "#ROUNDS_GreevilsTier2",

        type = ROUND_TYPES.BASIC,
        creeps = {
            npc_dota_greevil = {
                count = 6,
            },
            npc_dota_giant_wolf = {
                count = 3,
            },
        }
    },
    [3] = {
        name = "#ROUNDS_Skeletons",

        type = ROUND_TYPES.BASIC,
        creeps = {
            npc_dota_skeleton = {
                count = 8,
            },
        }
    },
    [4] = {
        name = "#ROUNDS_Kobolds2",

        type = ROUND_TYPES.BASIC,
        creeps = {
            npc_dota_kobold = {
                count = 4,
            },
            npc_dota_kobold_tunneler = {
                count = 2,
            },
            npc_dota_kobold_taskmaster = {
                count = 1,
            },
        }
    },
    [5] = {
        name = "#ROUNDS_Cones",

        type = ROUND_TYPES.BASIC,
        creeps = {
            npc_dota_warpine_cone_custom = {
                count = 8,
            },
        }
    },
    [6] = {
        name = "#ROUNDS_ExplodeSpider",

        type = ROUND_TYPES.BASIC,
        creeps = {
            npc_dota_explode_spider = {
                count = 8,
            },
        }
    },
    [7] = {
        name = "#ROUNDS_Crocos",

        type = ROUND_TYPES.BASIC,
        creeps = {
            npc_dota_crocodilian = {
                count = 6,
            },
            npc_dota_crocodilian_ranged = {
                count = 2,
            },
        }
    },
    [8] = {
        name = "#ROUNDS_Chameleons",

        type = ROUND_TYPES.BASIC,
        creeps = {
            npc_dota_chameleon = {
                count = 6,
            },
            npc_dota_chameleon_ranged = {
                count = 2,
            },
        }
    },
    [9] = {
        name = "#ROUNDS_Ogres",

        type = ROUND_TYPES.BASIC,
        creeps = {
            npc_dota_ogre_mauler = {
                count = 4,
            },
            npc_dota_ogre_magi = {
                count = 2,
            },
        }
    },
    [10] = {
        name = "#ROUNDS_cemetery",

        type = ROUND_TYPES.BASIC,
        creeps = {
            npc_dota_skeleton = {
                count = 5,
            },
            npc_dota_fel_beast = {
                count = 2,
            },
            npc_dota_ghost = {
                count = 1,
            },
        }
    },
    [11] = {
        name = "#ROUNDS_TimberSpider",

        type = ROUND_TYPES.BASIC,
        creeps = {
            npc_dota_timber_spider = {
                count = 8,
            },
        }
    },
    [12] = {
        name = "#ROUNDS_Centaurus",

        type = ROUND_TYPES.BASIC,
        creeps = {
            npc_dota_centaur_outrunner = {
                count = 5,
            },
            npc_dota_centaur_khan = {
                count = 1,
            },
        }
    },
    [13] = {
        name = "#ROUNDS_wildkin",

        type = ROUND_TYPES.BASIC,
        creeps = {
            npc_dota_big_wildkin_sovuh = {
                count = 1,
            },
            npc_dota_wildkin = {
                count = 5,
            },
        }
    },
    [14] = {
        name = "#ROUNDS_HarpyShock",

        type = ROUND_TYPES.BASIC,
        creeps = {
            npc_dota_harpy_scout = {
                count = 5,
            },
            npc_dota_harpy_storm = {
                count = 2,
            },
        }
    },
    [15] = {
        name = "#ROUNDS_Wolfs",

        type = ROUND_TYPES.BASIC,
        creeps = {
            npc_dota_giant_wolf = {
                count = 5,
            },
            npc_dota_alpha_wolf = {
                count = 2,
            },
        }
    },
    [16] = {
        name = "#ROUNDS_Gnolls",

        type = ROUND_TYPES.BASIC,
        creeps = {
            npc_dota_gnoll_assassin = {
                count = 7,
            },
        }
    },
    [17] = {
        name = "#ROUNDS_Fallen_Beasts",

        type = ROUND_TYPES.BASIC,
        creeps = {
            npc_dota_fel_beast = {
                count = 6,
            },
        }
    },
    [18] = {
        name = "#ROUNDS_Gnolls",

        type = ROUND_TYPES.BASIC,
        creeps = {
            npc_dota_gnoll_assassin = {
                count = 7,
            },
        }
    },
    [19] = {
        name = "#ROUNDS_Fallen_Beasts",

        type = ROUND_TYPES.BASIC,
        creeps = {
            npc_dota_fel_beast = {
                count = 6,
            },
            npc_dota_ghost = {
                count = 1,
            },
        }
    },
    [20] = {
        name = "#ROUNDS_Golems",

        type = ROUND_TYPES.BASIC,
        creeps = {
            npc_dota_rock_golem = {
                count = 5,
            },
            npc_dota_granite_golem = {
                count = 2,
            },
        }
    },
    [21] = {
        name = "#ROUNDS_ElfWolfs",
       
        type = ROUND_TYPES.BASIC,
        creeps = {
            npc_dota_elf_wolf = {
                count = 8,
            }
        }
    },
    [22] = {
        name = "#ROUNDS_TrollSquad",
        
        type = ROUND_TYPES.BASIC,
        creeps = {
            npc_dota_dark_troll = {
                count = 4,
            },
            npc_dota_forest_troll_high_priest = {
                count = 2,
            }
        }
    },
    [23] = {
        name = "#ROUNDS_SatyrMix",
        
        type = ROUND_TYPES.BASIC,
        creeps = {
            npc_dota_satyr_trickster = {
                count = 5,
            },
            npc_dota_satyr_soulstealer = {
                count = 2,
            }
        }
    },
    [24] = {
        name = "#ROUNDS_Centaurus",
        
        type = ROUND_TYPES.BASIC,
        creeps = {
            npc_dota_centaur_outrunner = {
                count = 6,
            },
            npc_dota_centaur_khan = {
                count = 2,
            }
        }
    },
    [25] = {
        name = "#ROUNDS_Urses",
        
        
        type = ROUND_TYPES.BASIC,
        creeps = {
            npc_dota_polar_furbolg_ursa_warrior = {
                count = 2,
            },
            npc_dota_polar_furbolg_champion = {
                count = 5,
            }
        }
    },
    [26] = {
        name = "#ROUNDS_Kobolds2",
        
        type = ROUND_TYPES.BASIC,
        creeps = {
            npc_dota_kobold = {
                count = 3,
            },
            npc_dota_kobold_tunneler = {
                count = 3,
            },
            npc_dota_kobold_taskmaster = {
                count = 2,
            }
        }
    },
    [27] = {
        name = "#ROUNDS_Golems",
        
        type = ROUND_TYPES.BASIC,
        creeps = {
            npc_dota_rock_golem = {
                count = 5,
            },
            npc_dota_granite_golem = {
                count = 2,
            }
        }
    },
    [28] = {
        name = "#ROUNDS_OgresBig",
        
        type = ROUND_TYPES.BASIC,
        creeps = {
            npc_dota_ogre_warlord = {
                count = 2,
            },
            npc_dota_ogre_mauler = {
                count = 4,            
            }
        }
    },
    [29] = {
        name = "#ROUNDS_ToxinSpiders",
        
        type = ROUND_TYPES.BASIC,
        creeps = {
            npc_dota_spider_melee = {
                count = 5,
            },
            npc_dota_spider_range = {
                count = 3,
            }
        }
    },
    [30] = {
        name = "#ROUNDS_VOTE",

        -- notification_text = "#minigame_notification1",
        
        type = ROUND_TYPES.VOTING,
    },
    [31] = {
        name = "#ROUNDS_BlackDragonFlight",
        
        type = ROUND_TYPES.BASIC,
        creeps = {
            npc_dota_black_drake = {
                count = 5,
            },
            npc_dota_black_dragon = {
                count = 2,
            }
        }
    },
    [32] = {
        name = "#ROUNDS_ProwlerAmbush",
        
        type = ROUND_TYPES.BASIC,
        creeps = {
            npc_dota_prowler_acolyte = {
                count = 5,
            },
            npc_dota_prowler_shaman = {
                count = 2,
            }
        }
    },
    [33] = {
        name = "#ROUNDS_FrostbittenGiants",
    
        type = ROUND_TYPES.BASIC,
        creeps = {
            npc_dota_frostbitten_mage = {
                count = 5,
            },
            npc_dota_frostbitten_gaint = {
                count = 2,
            }
            
        }
    },
    [34] = {
        name = "#ROUNDS_HarpyShock",
        
        type = ROUND_TYPES.BASIC,
        creeps = {
            npc_dota_harpy_scout = {
                count = 5,
            },
            npc_dota_harpy_storm = {
                count = 2,
            }
        }
    },
    [35] = {
        name = "#ROUNDS_OgreWarlord",
        
        
        type = ROUND_TYPES.BASIC,
        creeps = {
            npc_dota_ogre_mauler = {
                count = 6,
            },
            npc_dota_ogre_warlord = {
                count = 2,
            }
        }
    },
    [36] = {
        name = "#ROUNDS_SiltbreakerGuard",
        
        type = ROUND_TYPES.BASIC,
        creeps = {
            npc_dota_siltbreaker_blue = {
                count = 4,
            },
            npc_dota_siltbreaker_red = {
                count = 2,
            }
        }
    },
    [37] = {
        name = "#ROUNDS_RoshanFamily",
        
        type = ROUND_TYPES.BASIC,
        creeps = {
            npc_dota_roshling_small = {
                count = 5,
            },
            npc_dota_roshling_big = {
                count = 2,
            }
        }
    },
    [38] = {
        name = "#ROUNDS_OgreSealElite",
        
        type = ROUND_TYPES.BASIC,
        creeps = {
            npc_dota_ogreseal = {
                count = 5,
            },
            npc_dota_ogreseal_big = {
                count = 2,
            }
        }
    },
    [39] = {
        name = "#ROUNDS_TrollSquad",
        
        type = ROUND_TYPES.BASIC,
        creeps = {
            npc_dota_dark_troll = {
                count = 5,
            },
            npc_dota_forest_troll_high_priest = {
                count = 2,
            }
        }
    },
    [40] = {
        name = "#ROUNDS_Roshan",

        -- notification_text = "#boss_notification",

        is_boss = true,

        type = ROUND_TYPES.BASIC,
        creeps = {
            npc_dota_roshan = {
                count = 1,
                }
            }
    },
    [41] = {
        name = "#ROUNDS_Centaurus",
        
        type = ROUND_TYPES.BASIC,
        creeps = {
            npc_dota_centaur_outrunner = {
                count = 5,
            },
            npc_dota_centaur_khan = {
                count = 2,
            }
        }
    },
    [42] = {
        name = "#ROUNDS_Urses",
        
        type = ROUND_TYPES.BASIC,
        creeps = {
            npc_dota_polar_furbolg_ursa_warrior = {
                count = 2,
            },
            npc_dota_polar_furbolg_champion = {
                count = 5,
            }
        }
    },
    [43] = {
        name = "#ROUNDS_MixWave",
        
        -- notification_text = "#hard_rounds_notification",

        type = ROUND_TYPES.BASIC,
        creeps = {
            npc_dota_dark_troll_summoner = {
                count = 1,
            },
            npc_dota_centaur_khan = {
                count = 1,
            },
            npc_dota_spider_range = {
                count = 1,
            },
            npc_dota_satyr_trickster = {
                count = 2,
            },
            npc_dota_frostbitten_gaint = {
                count = 1,
            }
        }
    },
    [44] = {
        name = "#ROUNDS_wildkin",
        
        type = ROUND_TYPES.BASIC,
        creeps = {
            npc_dota_big_wildkin_sovuh = {
                count = 2,
            },
            npc_dota_wildkin = {
                count = 5,
            }
        }
    },
    [45] = {
        name = "#ROUNDS_cemetery",
        
        
        type = ROUND_TYPES.BASIC,
        creeps = {
            npc_dota_skeleton = {
                count = 4,
            },
            npc_dota_fel_beast = {
                count = 3,
            },
            npc_dota_ghost = {
                count = 2,
            }
        }
    },
    [46] = {
        name = "#ROUNDS_ElfWolfs",
        
        type = ROUND_TYPES.BASIC,
        creeps = {
            npc_dota_elf_wolf = {
                count = 8,
            }
        }
    },
    [47] = {
        name = "#ROUNDS_MudGolems",
        
        type = ROUND_TYPES.BASIC,
        creeps = {
            npc_dota_mud_golem = {
                count = 7,
            }
        }
    },
    [48] = {
        name = "#ROUNDS_SatyrMix",
        
        -- notification_text = "#hard_rounds_notification",

        type = ROUND_TYPES.BASIC,
        creeps = {
            npc_dota_satyr_trickster = {
                count = 4,
            },
            npc_dota_satyr_hellcaller = {
                count = 1,
            },
            npc_dota_satyr_soulstealer = {
                count = 2,
            }
        }
    },
    [49] = {
        name = "#ROUNDS_ExplodeSpider",
        
        type = ROUND_TYPES.BASIC,
        creeps = {
            npc_dota_explode_spider = {
                count = 8,
            }
        }
    },
    [50] = {
        name = "#ROUNDS_VOTE",
        
        -- notification_text = "#minigame_notification2",
        

        type = ROUND_TYPES.VOTING,
    },
    [51] = {
        name = "#ROUNDS_AntiMagic",
        
        -- notification_text = "#hard_rounds_notification",

        type = ROUND_TYPES.BASIC,
        creeps = {
            npc_dota_dark_troll_summoner = {
                count = 1,
            },
            npc_dota_centaur_khan = {
                count = 2,
            },
            npc_dota_granite_golem = {
                count = 1,
            },
            npc_dota_satyr_trickster = {
                count = 2,
            },
            npc_dota_mud_golem = {
                count = 1,
            }
        }
    },
    [52] = {
        name = "#ROUNDS_Wolfs",
        
        type = ROUND_TYPES.BASIC,
        creeps = {
            npc_dota_giant_wolf = {
                count = 6,
            },
            npc_dota_alpha_wolf = {
                count = 2,
            }
        }
    },
    [53] = {
        name = "#ROUNDS_OgreWarlord",
        
        type = ROUND_TYPES.BASIC,
        creeps = {
            npc_dota_ogre_mauler = {
                count = 6,
            },
            npc_dota_ogre_warlord = {
                count = 2,
            }
        }
    },
    [54] = {
        name = "#ROUNDS_RoshanFamily",
        
        type = ROUND_TYPES.BASIC,
        creeps = {
            npc_dota_roshling_small = {
                count = 5,
            },
            npc_dota_roshling_big = {
                count = 2,
            }
        }
    },
    [55] = {
        name = "#ROUNDS_ProwlerAmbush",
        
        
        type = ROUND_TYPES.BASIC,
        creeps = {
            npc_dota_prowler_shaman = {
                count = 2,
            },
            npc_dota_prowler_acolyte = {
                count = 5,
            }
        }
    },
    [56] = {
        name = "#ROUNDS_Kobolds2",
        
        type = ROUND_TYPES.BASIC,
        creeps = {
            npc_dota_kobold = {
                count = 4,
            },
            npc_dota_kobold_tunneler = {
                count = 3,
            },
            npc_dota_kobold_taskmaster = {
                count = 2,
            }
        }
    },
    [57] = {
        name = "#ROUNDS_MixWave",
        
        -- notification_text = "#hard_rounds_notification",

        type = ROUND_TYPES.BASIC,
        creeps = {
            npc_dota_dark_troll_summoner = {
                count = 1,
            },
            npc_dota_centaur_khan = {
                count = 1,
            },
            npc_dota_spider_range = {
                count = 1,
            },
            npc_dota_satyr_trickster = {
                count = 2,
            },
            npc_dota_frostbitten_gaint = {
                count = 1,
            }
        }
    },
    [58] = {
        name = "#ROUNDS_OgreSealElite",
        
        type = ROUND_TYPES.BASIC,
        creeps = {
            npc_dota_ogreseal = {
                count = 5,
            },
            npc_dota_ogreseal_big = {
                count = 2,
            }
        }
    },
    [59] = {
        name = "#ROUNDS_Crocos",
        
        type = ROUND_TYPES.BASIC,
        creeps = {
            npc_dota_crocodilian = {
                count = 5,
            },
            npc_dota_crocodilian_ranged = {
                count = 3,
            }
        }
    },
    [60] = {
        name = "#ROUNDS_Wildkin",
        
        type = ROUND_TYPES.BASIC,
        creeps = {
            npc_dota_big_wildkin_sovuh = {
                count = 2,
            },
            npc_dota_wildkin = {
                count = 5,
            }
        }
    },
    [61] = {
        name = "#ROUNDS_Nyan",

        -- notification_text = "#boss_notification",

        is_boss = true,

        type = ROUND_TYPES.BASIC,
        creeps = {
            npc_dota_nian = {
                count = 1,
            }
        }
    },
    [62] = {
        name = "#ROUNDS_SiltbreakerGuard",
        
        type = ROUND_TYPES.BASIC,
        creeps = {
            npc_dota_siltbreaker_blue = {
                count = 4,
            },
            npc_dota_siltbreaker_red = {
                count = 2,
            }
        }
    },
    [63] = {
        name = "#ROUNDS_TimberSpider",
        
        type = ROUND_TYPES.BASIC,
        creeps = {
            npc_dota_timber_spider = {
                count = 8,
            }
        }
    },
    [64] = {
        name = "#ROUNDS_BlackDragonFlight",
        
        type = ROUND_TYPES.BASIC,
        creeps = {
            npc_dota_black_drake = {
                count = 5,
            },
            npc_dota_black_dragon = {
                count = 2,
            }
        }
    },
    [65] = {
        name = "#ROUNDS_AntiWarriors",
        
        -- notification_text = "#hard_rounds_notification",
        

        type = ROUND_TYPES.BASIC,
        creeps = {
            npc_dota_elf_wolf = {
                count = 2,
            },
            npc_dota_timber_spider = {
                count = 2,
            },
            npc_dota_siltbreaker_red = {
                count = 1,
            },
            npc_dota_big_thunder_lizard = {
                count = 1,
            },
            npc_dota_spider_range = {
                count = 1,
            }
        }
    },
    [66] = {
        name = "#ROUNDS_Urses",
        
        type = ROUND_TYPES.BASIC,
        creeps = {
             npc_dota_polar_furbolg_ursa_warrior = {
                count = 2,
            },
            npc_dota_polar_furbolg_champion = {
                count = 5,
            }
        }
    },
    [67] = {
        name = "#ROUNDS_Golems",
        
        type = ROUND_TYPES.BASIC,
        creeps = {
            npc_dota_rock_golem = {
                count = 5,
            },
            npc_dota_granite_golem = {
                count = 2,
            }
        }
    },
    [68] = {
        name = "#ROUNDS_SatyrMix",
        
        -- notification_text = "#hard_rounds_notification",

        type = ROUND_TYPES.BASIC,
        creeps = {
            npc_dota_satyr_trickster = {
                count = 4,
            },
            npc_dota_satyr_hellcaller = {
                count = 2,
            },
            npc_dota_satyr_soulstealer = {
                count = 2,
            }
        }
    },
    [69] = {
        name = "#ROUNDS_TrollSquad",
        
        type = ROUND_TYPES.BASIC,
        creeps = {
            npc_dota_dark_troll = {
                count = 5,
            },
            npc_dota_forest_troll_high_priest = {
                count = 2,
            }
        }
    },
    [70] = {
        name = "#ROUNDS_VOTE",
        
        -- notification_text = "#minigame_notification2",
        

        type = ROUND_TYPES.VOTING,
    },
    [71] = {
        name = "#ROUNDS_RoshanFamily",
        
        type = ROUND_TYPES.BASIC,
        creeps = {
            npc_dota_roshling_small = {
                count = 5,
            },
            npc_dota_roshling_big = {
                count = 2,
            }
        }
    },
    [72] = {
        name = "#ROUNDS_ToxinSpiders",
        
        -- notification_text = "#hard_rounds_notification",

        type = ROUND_TYPES.BASIC,
        creeps = {
            npc_dota_spider_melee = {
                count = 5,
            },
            npc_dota_spider_range = {
                count = 3,
            }
        }
    },
    [73] = {
        name = "#ROUNDS_MixWave",
        
        -- notification_text = "#hard_rounds_notification",

        type = ROUND_TYPES.BASIC,
        creeps = {
            npc_dota_dark_troll_summoner = {
                count = 1,
            },
            npc_dota_centaur_khan = {
                count = 1,
            },
            npc_dota_spider_range = {
                count = 1,
            },
            npc_dota_satyr_trickster = {
                count = 2,
            },
            npc_dota_frostbitten_gaint = {
                count = 1,
            }
        }
    },
    [74] = {
        name = "#ROUNDS_BlackDragonFlight",
        
        type = ROUND_TYPES.BASIC,
        creeps = {
            npc_dota_black_dragon = {
                count = 2,
            },
            npc_dota_black_drake = {
                count = 4,
            }
        }
    },
    [75] = {
        name = "#ROUNDS_ProwlerAmbush",
        
        
        type = ROUND_TYPES.BASIC,
        creeps = {
            npc_dota_prowler_shaman = {
                count = 2,
            },
            npc_dota_prowler_acolyte = {
                count = 5,
            }
        }
    },
    [76] = {
        name = "#ROUNDS_ExplodeSpider",
        
        type = ROUND_TYPES.BASIC,
        creeps = {
            npc_dota_explode_spider = {
                count = 8,
            }
        }
    },
    [77] = {
        name = "#ROUNDS_OgreSealElite",
        
        type = ROUND_TYPES.BASIC,
        creeps = {
            npc_dota_ogreseal = {
                count = 5,
            },
            npc_dota_ogreseal_big = {
                count = 2,
            }
        }
    },
    [78] = {
        name = "#ROUNDS_FrostbittenGiants",
        
        type = ROUND_TYPES.BASIC,
        creeps = {
            npc_dota_frostbitten_mage = {
                count = 5,
            },
            npc_dota_frostbitten_gaint = {
                count = 2,
            }
        }
    },
    [79] = {
        name = "#ROUNDS_OgreWarlord",
        
        type = ROUND_TYPES.BASIC,
        creeps = {
            npc_dota_ogre_mauler = {
                count = 6,
            },
            npc_dota_ogre_warlord = {
                count = 2,
            }
        }
    },
    [80] = {
        name = "#ROUNDS_Roshan",

        -- notification_text = "#boss_notification",
        
        is_boss = true,

        type = ROUND_TYPES.BASIC,
        creeps = {
            npc_dota_roshan = {
                count = 1,
             }
        }
    },
    [81] = {
        name = "#ROUNDS_BlackDragonFlight",
        
        type = ROUND_TYPES.BASIC,
        creeps = {
            npc_dota_black_drake = {
                count = 5,
            },
            npc_dota_black_dragon = {
                count = 2,
            }
        }
    },
    [82] = {
        name = "#ROUNDS_ToxinSpiders",
        
        -- notification_text = "#hard_rounds_notification",

        type = ROUND_TYPES.BASIC,
        creeps = {
            npc_dota_spider_melee = {
                count = 5,
            },
            npc_dota_spider_range = {
                count = 3,
            }
        }
    },
    [83] = {
        name = "#ROUNDS_SiltbreakerGuard",
        
        type = ROUND_TYPES.BASIC,
        creeps = {
            npc_dota_siltbreaker_blue = {
                count = 5,
            },
            npc_dota_siltbreaker_red = {
                count = 2,
            }
        }
    },
    [84] = {
        name = "#ROUNDS_Urses",
        
        type = ROUND_TYPES.BASIC,
        creeps = {
            npc_dota_polar_furbolg_ursa_warrior = {
                count = 2,
            },
            npc_dota_polar_furbolg_champion = {
                count = 5,
            }
        }
    },
    [85] = {
        name = "#ROUNDS_RoshanFamily",
        
        
        type = ROUND_TYPES.BASIC,
        creeps = {
            npc_dota_roshling_small = {
                count = 5,
            },
            npc_dota_roshling_big = {
                count = 2,
            }
        }
    },
    [86] = {
        name = "#ROUNDS_TrollSquad",
        
        type = ROUND_TYPES.BASIC,
        creeps = {
            npc_dota_dark_troll = {
                count = 5,
            },
            npc_dota_forest_troll_high_priest = {
                count = 2,
            }
        }
    },
    [87] = {
        name = "#ROUNDS_AntiMagic",
        
        -- notification_text = "#hard_rounds_notification",

        type = ROUND_TYPES.BASIC,
        creeps = {
            npc_dota_dark_troll_summoner = {
                count = 1,
            },
            npc_dota_centaur_khan = {
                count = 2,
            },
            npc_dota_granite_golem = {
                count = 1,
            },
            npc_dota_satyr_trickster = {
                count = 2,
            },
            npc_dota_mud_golem = {
                count = 1,
            }
        }
    },
    [88] = {
        name = "#ROUNDS_ProwlerAmbush",
        
        type = ROUND_TYPES.BASIC,
        creeps = {
            npc_dota_prowler_shaman = {
                count = 2,
            },
            npc_dota_prowler_acolyte = {
                count = 5,
            }
        }
    },
    [89] = {
        name = "#ROUNDS_AntiWarriors",
        
        -- notification_text = "#hard_rounds_notification",

        type = ROUND_TYPES.BASIC,
        creeps = {
            npc_dota_elf_wolf = {
                count = 2,
            },
            npc_dota_timber_spider = {
                count = 2,
            },
            npc_dota_siltbreaker_red = {
                count = 1,
            },
            npc_dota_big_thunder_lizard = {
                count = 1,
            },
            npc_dota_spider_range = {
                count = 1,
            }
        }
    },
    [90] = {
        name = "#ROUNDS_VOTE",
        
        -- notification_text = "#minigame_notification2",
        

        type = ROUND_TYPES.VOTING,
    },
    [91] = {
        name = "#ROUNDS_BlackDragonFlight",

        -- notification_text = "#last_notification",

        type = ROUND_TYPES.BASIC,


        creeps = {
            npc_dota_black_drake = {
                count = 5,
            },
            npc_dota_black_dragon = {
                count = 2,
            }
        }
    },
    [92] = {
        name = "#ROUNDS_OgreSealElite",

        type = ROUND_TYPES.BASIC,

        creeps = {
            npc_dota_ogreseal = {
                count = 5,
            },
            npc_dota_ogreseal_big = {
                count = 2,
            }
        }
    },
    [93] = {
        name = "#ROUNDS_SiltbreakerGuard",

        type = ROUND_TYPES.BASIC,


        creeps = {
            npc_dota_siltbreaker_blue = {
                count = 4,
            },
            npc_dota_siltbreaker_red = {
                count = 2,
            }
        }
    },
    [94] = {
        name = "#ROUNDS_ToxinSpiders",

        type = ROUND_TYPES.BASIC,

        creeps = {
            npc_dota_spider_melee = {
                count = 5,
            },
            npc_dota_spider_range = {
                count = 3,
            }
        }
    },
    [95] = {
        name = "#ROUNDS_RoshanFamily",
        

        type = ROUND_TYPES.BASIC,


        creeps = {
            npc_dota_roshling_small = {
                count = 5,
            },
            npc_dota_roshling_big = {
                count = 2,
            }
        }
    },
    [96] = {
        name = "#ROUNDS_FrostbittenGiants",

        type = ROUND_TYPES.BASIC,

        creeps = {
            npc_dota_frostbitten_mage = {
                count = 5,
            },
            npc_dota_frostbitten_gaint = {
                count = 2,
            }
        }
    },
    [97] = {
        name = "#ROUNDS_AntiMagic",

        type = ROUND_TYPES.BASIC,


        creeps = {
            npc_dota_dark_troll_summoner = {
                count = 1,
            },
            npc_dota_centaur_khan = {
                count = 2,
            },
            npc_dota_granite_golem = {
                count = 1,
            },
            npc_dota_satyr_trickster = {
                count = 2,
            },
            npc_dota_mud_golem = {
                count = 1,
            }
        }
    },
    [98] = {
        name = "#ROUNDS_AntiWarriors",

        type = ROUND_TYPES.BASIC,

        creeps = {
            npc_dota_elf_wolf = {
                count = 2,
            },
            npc_dota_timber_spider = {
                count = 2,
            },
            npc_dota_siltbreaker_red = {
                count = 1,
            },
            npc_dota_big_thunder_lizard = {
                count = 1,
            },
            npc_dota_spider_range = {
                count = 1,
            }
        }
    },
    [99] = {
        name = "#ROUNDS_MixWave",

        type = ROUND_TYPES.BASIC,


        creeps = {
            npc_dota_dark_troll_summoner = {
                count = 1,
            },
            npc_dota_centaur_khan = {
                count = 1,
            },
            npc_dota_spider_range = {
                count = 1,
            },
            npc_dota_satyr_trickster = {
                count = 2,
            },
            npc_dota_frostbitten_gaint = {
                count = 1,
            }
        }
    },
    [100] = {
        name = "#ROUNDS_LastWaveorNot",
        
        type = ROUND_TYPES.BASIC,
        creeps = {
            npc_dota_nian = {
                count = 1,
            },
            npc_dota_granite_golem = {
                count = 1,
            },
            npc_dota_spider_range = {
                count = 1,
            },
            npc_dota_big_thunder_lizard = {
                count = 1,
            },
            npc_dota_roshling_big = {
                count = 1,
            },
            npc_dota_frostbitten_gaint = {
                count = 1,
            },
            npc_dota_ogreseal_big = {
                count = 1,
            },
            npc_dota_roshan = {
                count = 1,
            }
        }
    },
    [101] = {
        name = "#ROUNDS_GraniteSiege",
        type = ROUND_TYPES.BASIC,
        creeps = {
            npc_dota_rock_golem = {
                count = 4,
            },
            npc_dota_granite_golem = {
                count = 3,
            }
        }
    },
    [102] = {
        name = "#ROUNDS_BlackDragonAssault",
        type = ROUND_TYPES.BASIC,
        creeps = {
            npc_dota_black_drake = {
                count = 4,
            },
            npc_dota_black_dragon = {
                count = 3,
            }
        }
    },
    [103] = {
        name = "#ROUNDS_SiltbreakerLegion",
        type = ROUND_TYPES.BASIC,
        creeps = {
            npc_dota_siltbreaker_blue = {
                count = 4,
            },
            npc_dota_siltbreaker_red = {
                count = 3,
            }
        }
    },
    [104] = {
        name = "#ROUNDS_StoneTitans",
        type = ROUND_TYPES.BASIC,
        creeps = {
            npc_dota_granite_golem = {
                count = 4,
            },
            npc_dota_big_thunder_lizard = {
                count = 3,
            }
        }
    },
    [105] = {
        name = "#ROUNDS_RoshlingSwarm",
        type = ROUND_TYPES.BASIC,
        creeps = {
            npc_dota_roshling_small = {
                count = 4,
            },
            npc_dota_roshling_big = {
                count = 3,
            }
        }
    },
    [106] = {
        name = "#ROUNDS_DragonStorm",
        type = ROUND_TYPES.BASIC,
        creeps = {
            npc_dota_black_dragon = {
                count = 4,
            },
            npc_dota_frostbitten_gaint = {
                count = 3,
            }
        }
    },
    [107] = {
        name = "#ROUNDS_ProwlerVanguard",
        type = ROUND_TYPES.BASIC,
        creeps = {
            npc_dota_prowler_acolyte = {
                count = 4,
            },
            npc_dota_prowler_shaman = {
                count = 3,
            }
        }
    },
    [108] = {
        name = "#ROUNDS_OgreSealBattalion",
        type = ROUND_TYPES.BASIC,
        creeps = {
            npc_dota_ogreseal = {
                count = 4,
            },
            npc_dota_ogreseal_big = {
                count = 3,
            }
        }
    },
    [109] = {
        name = "#ROUNDS_FrostbittenArmy",
        type = ROUND_TYPES.BASIC,
        creeps = {
            npc_dota_frostbitten_mage = {
                count = 4,
            },
            npc_dota_frostbitten_gaint = {
                count = 3,
            }
        }
    },
    [110] = {
        name = "#ROUNDS_VenomousSpiders",
        type = ROUND_TYPES.BASIC,
        creeps = {
            npc_dota_spider_melee = {
                count = 4,
            },
            npc_dota_spider_range = {
                count = 3,
            }
        }
    },
    [111] = {
        name = "#ROUNDS_SatyrCult",
        type = ROUND_TYPES.BASIC,
        creeps = {
            npc_dota_satyr_soulstealer = {
                count = 4,
            },
            npc_dota_satyr_hellcaller = {
                count = 3,
            }
        }
    },
    [112] = {
        name = "#ROUNDS_CentaurRaid",
        type = ROUND_TYPES.BASIC,
        creeps = {
            npc_dota_centaur_outrunner = {
                count = 4,
            },
            npc_dota_centaur_khan = {
                count = 3,
            }
        }
    },
    [113] = {
        name = "#ROUNDS_WolfPack",
        type = ROUND_TYPES.BASIC,
        creeps = {
            npc_dota_giant_wolf = {
                count = 4,
            },
            npc_dota_alpha_wolf = {
                count = 3,
            }
        }
    },
    [114] = {
        name = "#ROUNDS_TricksterSwarm",
        type = ROUND_TYPES.BASIC,
        creeps = {
            npc_dota_satyr_trickster = {
                count = 4,
            },
            npc_dota_roshling_big = {
                count = 3,
            }
        }
    },
    [115] = {
        name = "#ROUNDS_OgreWarband",
        type = ROUND_TYPES.BASIC,
        creeps = {
            npc_dota_ogre_mauler = {
                count = 4,
            },
            npc_dota_ogre_warlord = {
                count = 3,
            }
        }
    },
    [116] = {
        name = "#ROUNDS_WildkinDruids",
        type = ROUND_TYPES.BASIC,
        creeps = {
            npc_dota_wildkin = {
                count = 4,
            },
            npc_dota_big_wildkin_sovuh = {
                count = 3,
            }
        }
    },
    [117] = {
        name = "#ROUNDS_TimberAmbush",
        type = ROUND_TYPES.BASIC,
        creeps = {
            npc_dota_timber_spider = {
                count = 4,
            },
            npc_dota_elf_wolf = {
                count = 3,
            }
        }
    },
    [118] = {
        name = "#ROUNDS_ExplodingSwarm",
        type = ROUND_TYPES.BASIC,
        creeps = {
            npc_dota_explode_spider = {
                count = 7,
            }
        }
    },
    [119] = {
        name = "#ROUNDS_ThunderTitans",
        type = ROUND_TYPES.BASIC,
        creeps = {
            npc_dota_big_thunder_lizard = {
                count = 7,
            }
        }
    },
    [120] = {
        name = "#ROUNDS_LastWave",

        type = ROUND_TYPES.BASIC,
        creeps = {
            npc_dota_nian = {
                count = 1,
            },
            npc_dota_roshan = {
                count = 1,
            },
            npc_dota_black_dragon = {
                count = 1,
            },
            npc_dota_big_thunder_lizard = {
                count = 1,
            },
            npc_dota_granite_golem = {
                count = 1,
            },
            npc_dota_frostbitten_gaint = {
                count = 1,
            },
            npc_dota_siltbreaker_red = {
                count = 1,
            },
            npc_dota_ogreseal_big = {
                count = 1,
            }
        }
    },

}