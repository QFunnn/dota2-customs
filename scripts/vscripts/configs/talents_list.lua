--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


_G.basictalents = 
{
	"modifier_woda_talent_hp1", 
	"modifier_woda_talent_regenhp1",
	"modifier_woda_talent_attack1",
	"modifier_woda_talent_str3",
	"modifier_woda_talent_cloak",
	"modifier_woda_talent_quickhp",
	"modifier_woda_talent_str4",
	"modifier_woda_talent_hp2",
	"modifier_woda_talent_sliver",
	"modifier_woda_talent_sasha",
	"modifier_woda_talent_armor2",
	"modifier_woda_talent_regenhp2",
	"modifier_woda_talent_str5",
	"modifier_woda_talent_octar",
	"modifier_woda_talent_str6",
	"modifier_woda_talent_armor1",
	"modifier_woda_talent_speed1",
	"modifier_woda_talent_attackspeed1",
	"modifier_woda_talent_agi3",
	"modifier_woda_talent_miss1",
	"modifier_woda_talent_mask1",
	"modifier_woda_talent_agi4",
	"modifier_woda_talent_speed2",
	"modifier_woda_talent_grovebow",
	"modifier_woda_talent_yasha",
	"modifier_woda_talent_attack2",
	"modifier_woda_talent_attackspeed2",
	"modifier_woda_talent_agi5",
	"modifier_woda_talent_miss2",
	"modifier_woda_talent_agi6",
	"modifier_woda_talent_mp1",
	"modifier_woda_talent_regenmp1",
	"modifier_woda_talent_spell",
	"modifier_woda_talent_int3",
	"modifier_woda_talent_fairy",
	"modifier_woda_talent_mask2",
	"modifier_woda_talent_int4",
	"modifier_woda_talent_mp2",
	"modifier_woda_talent_blood",
	"modifier_woda_talent_kaya",
	"modifier_woda_talent_spellprism",
	"modifier_woda_talent_regenmp2",
	"modifier_woda_talent_int5",
	"modifier_woda_talent_timeless",
	"modifier_woda_talent_int6"
}

_G.LockedTalents =
{
    ["npc_dota_hero_chen"] =
    {
        ["modifier_chen_1"] =
        {
            "modifier_chen_8",
            "modifier_chen_15",
        },
        ["modifier_chen_8"] =
        {
            "modifier_chen_1",
            "modifier_chen_15",
        },
        ["modifier_chen_15"] =
        {
            "modifier_chen_1",
            "modifier_chen_8",
        },
    },
    ["npc_dota_hero_windrunner"] =
    {
        ["modifier_windrunner_7"] =
        {
            "modifier_windrunner_19",
        },
        ["modifier_windrunner_19"] =
        {
            "modifier_windrunner_7",
        },
    },
    ["npc_dota_hero_kez"] =
    {
        ["modifier_kez_1"] =
        {
            "modifier_kez_8",
        },
        ["modifier_kez_8"] =
        {
            "modifier_kez_1",
        },
    },
    ["npc_dota_hero_zuus"] =
    {
        ["modifier_zuus_1"] =
        {
            "modifier_zuus_19",
        },
        ["modifier_zuus_19"] =
        {
            "modifier_zuus_1",
        },
    },
    ["npc_dota_hero_axe"] =
    {
        ["modifier_axe_16"] =
        {
            "modifier_axe_9",
        },
        ["modifier_axe_9"] =
        {
            "modifier_axe_16",
        },
    },
    ["npc_dota_hero_phoenix"] =
    {
        ["modifier_phoenix_14"] =
        {
            "modifier_phoenix_15",
        },
        ["modifier_phoenix_12"] =
        {
            "modifier_phoenix_15",
        },
        ["modifier_phoenix_15"] =
        {
            "modifier_phoenix_14",
            "modifier_phoenix_12",
        },
    },
    ["npc_dota_hero_lich"] =
    {
        ["modifier_lich_8"] =
        {
            "modifier_lich_16",
        },
        ["modifier_lich_16"] =
        {
            "modifier_lich_8",
        },
    },
    ["npc_dota_hero_keeper_of_the_light"] =
    {
        ["modifier_keeper_of_the_light_7"] =
        {
            "modifier_keeper_of_the_light_8",
        },
    },
    ["npc_dota_hero_phantom_assassin"] =
    {
        ["modifier_phantom_assassin_21"] =
        {
            "modifier_phantom_assassin_2",
        },
        ["modifier_phantom_assassin_2"] =
        {
            "modifier_phantom_assassin_21",
        },
        ["modifier_phantom_assassin_15"] =
        {
            "modifier_phantom_assassin_2",
        },
        ["modifier_phantom_assassin_9"] =
        {
            "modifier_phantom_assassin_2",
        },
    },
}

_G.herotalents = 
{
	["npc_dota_hero_crystal_maiden"] = {
		[1] = {
			[1] = {
				{"modifier_woda_talent_hp1", "#woda_talent_hp1", 3, "hp1", {}},
				{"modifier_woda_talent_regenhp1", "#woda_talent_regenhp1", 2, "regenhp1", {}},
				{"modifier_woda_talent_attack1", "#woda_talent_attack1", 3, "attack1", {}},
				{"modifier_crystal_maiden_1","#modifier_crystal_maiden_1", 3, "crystal_maiden/1", {}},
				{"modifier_woda_talent_str3", "#woda_talent_str3", 2, "str3", {}}
			},
			[2] = {
				{"empty_2"},
				{"modifier_crystal_maiden_4","#modifier_crystal_maiden_4", 1, "crystal_maiden/4", {}},
				{"empty_3"},
				{"modifier_woda_talent_cloak", "#woda_talent_cloak", 2, "cloak", {}},
				{"modifier_woda_talent_str6", "#woda_talent_str6", 1, "str6", {"modifier_woda_talent_str3",2}}
			},
			[3] = {
				{"empty_6"},
				{"modifier_woda_talent_quickhp", "#woda_talent_quickhp", 2, "quickhp", {}},
				{"modifier_crystal_maiden_2","#modifier_crystal_maiden_2", 1, "crystal_maiden/2", {}},
				{"empty_8"},
				{"modifier_woda_talent_sasha", "#woda_talent_sasha", 1, "sasha", {"modifier_woda_talent_str6",1}}
			},
			[4] = {
				{"modifier_woda_talent_hp2", "#woda_talent_hp2", 3, "hp2", {"modifier_woda_talent_hp1",3}},
				{"empty_9"},
				{"modifier_crystal_maiden_3","#modifier_crystal_maiden_3", 2, "crystal_maiden/3", {}},
				{"modifier_woda_talent_octar", "#woda_talent_octar", 2, "octar", {}},
				{"modifier_woda_talent_str4", "#woda_talent_str4", 1, "str4", {"modifier_woda_talent_sasha",1}}
			},
			[5] = {
				{"modifier_woda_talent_armor2", "#woda_talent_armor2", 3, "armor2", {}},
				{"modifier_crystal_maiden_6","#modifier_crystal_maiden_6", 3, "crystal_maiden/6", {}},
				{"empty_10"},
				{"empty_11"},
				{"modifier_woda_talent_str5", "#woda_talent_str5", 3, "str5", {"modifier_woda_talent_str4",1}}
			},
			[6] = {
				{"modifier_woda_talent_sliver", "#woda_talent_sliver", 2, "sliver", {}},
				{"modifier_woda_talent_regenhp2", "#woda_talent_regenhp2", 3, "regenhp2", {}},
				{"modifier_crystal_maiden_5","#modifier_crystal_maiden_5", 3, "crystal_maiden/5", {}},
				{"empty_15"},
				{"empty_16"}
			},
			[7] = {
				{"empty_17"},
				{"empty_18"},
				{"modifier_crystal_maiden_7","#modifier_crystal_maiden_7", 1, "crystal_maiden/7", {}},
				{"empty_20"},
				{"empty_21"}
			}
		},
		[2] = {
			[1] = {
				{"modifier_woda_talent_armor1", "#woda_talent_armor1", 3, "armor1", {}},
				{"modifier_woda_talent_speed1", "#woda_talent_speed1", 2, "speed1", {}},
				{"modifier_woda_talent_attackspeed1", "#woda_talent_attackspeed1", 3, "attackspeed1", {}},
				{"modifier_crystal_maiden_8","#modifier_crystal_maiden_8", 2, "crystal_maiden/8", {}},
				{"modifier_woda_talent_agi3", "#woda_talent_agi3", 2, "agi3", {}}
			},
			[2] = {
				{"empty_2"},
				{"empty_3"},
				{"modifier_crystal_maiden_15","#modifier_crystal_maiden_15", 2, "crystal_maiden/15", {}},
				{"modifier_woda_talent_miss1", "#woda_talent_miss1", 2, "miss1", {}},
				{"modifier_woda_talent_agi6", "#woda_talent_agi6", 1, "agi6", {"modifier_woda_talent_agi3",2}}
			},
			[3] = {
				{"empty_6"},
				{"empty_7"},
				{"modifier_crystal_maiden_11","#modifier_crystal_maiden_11", 3, "crystal_maiden/11", {}},
				{"modifier_woda_talent_mask1", "#woda_talent_mask1", 2, "mask1", {}},
				{"modifier_woda_talent_yasha", "#woda_talent_yasha", 1, "yasha", {"modifier_woda_talent_agi6",1}}
			},
			[4] = {
				{"modifier_crystal_maiden_9","#modifier_crystal_maiden_9", 3, "crystal_maiden/9", {}},
				{"modifier_woda_talent_speed2", "#woda_talent_speed2", 3, "speed2", {"modifier_woda_talent_speed1",2}},
				{"modifier_woda_talent_grovebow", "#woda_talent_grovebow", 2, "grovebow", {}},
				{"empty_9"},			
				{"modifier_woda_talent_agi4", "#woda_talent_agi4", 1, "agi4", {"modifier_woda_talent_yasha",1}}
			},
			[5] = {
				{"modifier_woda_talent_attack2", "#woda_talent_attack2", 3, "attack2", {}},
				{"empty_10"},
				{"modifier_crystal_maiden_13","#modifier_crystal_maiden_13", 3, "crystal_maiden/13", {}},
				{"empty_11"},
				{"modifier_woda_talent_agi5", "#woda_talent_agi5", 3, "agi5", {"modifier_woda_talent_agi4",1}}
			},
			[6] = {
				{"modifier_woda_talent_miss2", "#woda_talent_miss2", 2, "miss2", {}},
				{"empty_12"},
				{"modifier_woda_talent_attackspeed2", "#woda_talent_attackspeed2", 3, "attackspeed2", {}},
				{"empty_13"},
				{"modifier_crystal_maiden_10","#modifier_crystal_maiden_10", 1, "crystal_maiden/10", {}}
			},
			[7] = {
				{"empty_17"},
				{"empty_18"},
				{"modifier_crystal_maiden_14","#modifier_crystal_maiden_14", 1, "crystal_maiden/14", {}},
				{"empty_20"},
				{"empty_21"}
			}
		},
		[3] = {
			[1] = {
				{"modifier_woda_talent_mp1", "#woda_talent_mp1", 3, "mp1", {}},
				{"modifier_woda_talent_regenmp1", "#woda_talent_regenmp1", 2, "regenmp1", {}},
				{"modifier_woda_talent_spell", "#woda_talent_spell", 3, "spell", {}},
				{"modifier_crystal_maiden_16","#modifier_crystal_maiden_16", 2, "crystal_maiden/16", {}},
				{"modifier_woda_talent_int3", "#woda_talent_int3", 2, "int3", {}}
			},
			[2] = {
				{"empty_2"},
				{"modifier_crystal_maiden_17","#modifier_crystal_maiden_17", 2, "crystal_maiden/17", {}},
				{"empty_3"},
				{"modifier_woda_talent_blood", "#woda_talent_blood", 2, "blood", {}},
				{"modifier_woda_talent_int6", "#woda_talent_int6", 1, "int6", {"modifier_woda_talent_int3",2}}
			},
			[3] = {
				{"empty_6"},
				{"modifier_crystal_maiden_19","#modifier_crystal_maiden_19", 3, "crystal_maiden/19", {}},
				{"empty_7"},
				{"modifier_woda_talent_mask2", "#woda_talent_mask2", 2, "mask2", {}},
				{"modifier_woda_talent_kaya", "#woda_talent_kaya", 1, "kaya", {"modifier_woda_talent_int6",1}}
			},
			[4] = {
				{"modifier_woda_talent_mp2", "#woda_talent_mp2", 3, "mp2", {"modifier_woda_talent_mp1",3}},
				{"modifier_woda_talent_fairy", "#woda_talent_fairy", 2, "fairy", {}},
				{"modifier_crystal_maiden_18","#modifier_crystal_maiden_18", 1, "crystal_maiden/18", {}},
				{"empty_9"},
				{"modifier_woda_talent_int4", "#woda_talent_int4", 1, "int4", {"modifier_woda_talent_kaya",1}}
			},
			[5] = {
				{"modifier_woda_talent_spellprism", "#woda_talent_spellprism", 3, "spellprism", {}},
				{"empty_11"},
				{"empty_12"},
				{"modifier_crystal_maiden_12","#modifier_crystal_maiden_12", 1, "crystal_maiden/12", {}},
				{"modifier_woda_talent_int5", "#woda_talent_int5", 3, "int5", {"modifier_woda_talent_int4",1}}
			},
			[6] = {
				{"modifier_woda_talent_timeless", "#woda_talent_timeless", 2, "timeless", {}},
				{"modifier_woda_talent_regenmp2", "#woda_talent_regenmp2", 3, "regenmp2", {}},
				{"modifier_crystal_maiden_20","#modifier_crystal_maiden_20", 3, "crystal_maiden/20", {}},
				{"empty_15"},
				{"empty_16"}
			},
			[7] = {
				{"empty_17"},
				{"empty_18"},
				{"modifier_crystal_maiden_21","#modifier_crystal_maiden_21", 1, "crystal_maiden/21", {}},
				{"empty_20"},
				{"empty_21"}
			}
		}
	},
	["npc_dota_hero_dragon_knight"] = {
		[1] = {
			[1] = {
				{"modifier_woda_talent_hp1", "#woda_talent_hp1", 3, "hp1", {}},
				{"modifier_woda_talent_regenhp1", "#woda_talent_regenhp1", 2, "regenhp1", {}},
				{"modifier_dragon_knight_2","#modifier_dragon_knight_2", 3, "dragon_knight/2", {}},
				{"modifier_woda_talent_attack1", "#woda_talent_attack1", 3, "attack1", {}},
				{"modifier_woda_talent_str3", "#woda_talent_str3", 2, "str3", {}}
			},
			[2] = {
				{"empty_2"},
				{"empty_3"},
				{"modifier_dragon_knight_3","#modifier_dragon_knight_3", 1, "dragon_knight/3", {"modifier_dragon_knight_2",3}},
				{"modifier_woda_talent_cloak", "#woda_talent_cloak", 2, "cloak", {}},
				{"modifier_woda_talent_str6", "#woda_talent_str6", 1, "str6", {"modifier_woda_talent_str3",2}}
			},
			[3] = {
				{"empty_6"},
				{"modifier_woda_talent_quickhp", "#woda_talent_quickhp", 2, "quickhp", {}},
				{"modifier_dragon_knight_1","#modifier_dragon_knight_1", 2, "dragon_knight/1", {}},
				{"empty_8"},
				{"modifier_woda_talent_sasha", "#woda_talent_sasha", 1, "sasha", {"modifier_woda_talent_str6",1}}
			},
			[4] = {
				{"modifier_woda_talent_hp2", "#woda_talent_hp2", 3, "hp2", {"modifier_woda_talent_hp1",3}},
				{"modifier_dragon_knight_4","#modifier_dragon_knight_4", 3, "dragon_knight/4", {}},
				{"empty_9"},
				{"modifier_woda_talent_octar", "#woda_talent_octar", 2, "octar", {}},
				{"modifier_woda_talent_str4", "#woda_talent_str4", 1, "str4", {"modifier_woda_talent_sasha",1}}
			},
			[5] = {
				{"modifier_woda_talent_armor2", "#woda_talent_armor2", 3, "armor2", {}},
				{"empty_10"},
				{"empty_11"},
				{"modifier_dragon_knight_5","#modifier_dragon_knight_5", 3, "dragon_knight/5", {}},
				{"modifier_woda_talent_str5", "#woda_talent_str5", 3, "str5", {"modifier_woda_talent_str4",1}}
			},
			[6] = {
				{"modifier_woda_talent_sliver", "#woda_talent_sliver", 2, "sliver", {}},
				{"modifier_woda_talent_regenhp2", "#woda_talent_regenhp2", 3, "regenhp2", {}},
				{"modifier_dragon_knight_6","#modifier_dragon_knight_6", 1, "dragon_knight/6", {}},
				{"empty_15"},
				{"empty_16"}
			},
			[7] = {
				{"empty_17"},
				{"empty_18"},
				{"modifier_dragon_knight_7","#modifier_dragon_knight_7", 1, "dragon_knight/7", {}},
				{"empty_20"},
				{"empty_21"}
			}
		},
		[2] = {
			[1] = {
				{"modifier_dragon_knight_9","#modifier_dragon_knight_9", 2, "dragon_knight/9", {}},
				{"modifier_woda_talent_speed1", "#woda_talent_speed1", 2, "speed1", {}},
				{"modifier_woda_talent_attackspeed1", "#woda_talent_attackspeed1", 3, "attackspeed1", {}},
				{"modifier_woda_talent_armor1", "#woda_talent_armor1", 3, "armor1", {}},
				{"modifier_woda_talent_agi3", "#woda_talent_agi3", 2, "agi3", {}}
			},
			[2] = {
				{"modifier_dragon_knight_10","#modifier_dragon_knight_10", 1, "dragon_knight/10", {"modifier_dragon_knight_9",2}},
				{"empty_3"},
				{"empty_4"},
				{"modifier_woda_talent_miss1", "#woda_talent_miss1", 2, "miss1", {}},
				{"modifier_woda_talent_agi6", "#woda_talent_agi6", 1, "agi6", {"modifier_woda_talent_agi3",2}}
			},
			[3] = {
				{"empty_8"},
				{"empty_7"},
				{"modifier_dragon_knight_8","#modifier_dragon_knight_8", 3, "dragon_knight/8", {}},
				{"modifier_woda_talent_mask1", "#woda_talent_mask1", 2, "mask1", {}},
				{"modifier_woda_talent_yasha", "#woda_talent_yasha", 1, "yasha", {"modifier_woda_talent_agi6",1}}
			},
			[4] = {
				{"empty_9"},
				{"modifier_woda_talent_speed2", "#woda_talent_speed2", 3, "speed2", {"modifier_woda_talent_speed1",2}},
				{"modifier_woda_talent_grovebow", "#woda_talent_grovebow", 2, "grovebow", {}},
				{"modifier_dragon_knight_11","#modifier_dragon_knight_11", 3, "dragon_knight/11", {}},			
				{"modifier_woda_talent_agi4", "#woda_talent_agi4", 1, "agi4", {"modifier_woda_talent_yasha",1}}
			},
			[5] = {
				{"modifier_woda_talent_attack2", "#woda_talent_attack2", 3, "attack2", {}},
				{"modifier_dragon_knight_12","#modifier_dragon_knight_12", 3, "dragon_knight/12", {}},
				{"empty_12"},
				{"empty_13"},
				{"modifier_woda_talent_agi5", "#woda_talent_agi5", 3, "agi5", {"modifier_woda_talent_agi4",1}}
			},
			[6] = {
				{"modifier_woda_talent_miss2", "#woda_talent_miss2", 2, "miss2", {}},
				{"empty_14"},
				{"modifier_woda_talent_attackspeed2", "#woda_talent_attackspeed2", 3, "attackspeed2", {}},
				{"empty_15"},
				{"modifier_dragon_knight_13","#modifier_dragon_knight_13", 1, "dragon_knight/13", {}}
			},
			[7] = {
				{"empty_17"},
				{"empty_18"},
				{"modifier_dragon_knight_14","#modifier_dragon_knight_14", 1, "dragon_knight/14", {}},
				{"empty_20"},
				{"empty_21"}
			}
		},
		[3] = {
			[1] = {
				{"modifier_woda_talent_mp1", "#woda_talent_mp1", 3, "mp1", {}},
				{"modifier_woda_talent_regenmp1", "#woda_talent_regenmp1", 2, "regenmp1", {}},
				{"modifier_woda_talent_spell", "#woda_talent_spell", 3, "spell", {}},
				{"modifier_dragon_knight_20","#modifier_dragon_knight_20", 3, "dragon_knight/20", {}},
				{"modifier_woda_talent_int3", "#woda_talent_int3", 2, "int3", {}}
			},
			[2] = {
				{"empty_2"},
				{"empty_3"},
				{"modifier_dragon_knight_16","#modifier_dragon_knight_16", 2, "dragon_knight/16", {}},
				{"modifier_woda_talent_blood", "#woda_talent_blood", 2, "blood", {}},
				{"modifier_woda_talent_int6", "#woda_talent_int6", 1, "int6", {"modifier_woda_talent_int3",2}}
			},
			[3] = {
				{"empty_6"},
				{"empty_7"},
				{"modifier_dragon_knight_15","#modifier_dragon_knight_15", 3, "dragon_knight/15", {}},
				{"modifier_woda_talent_mask2", "#woda_talent_mask2", 2, "mask2", {}},
				{"modifier_woda_talent_kaya", "#woda_talent_kaya", 1, "kaya", {"modifier_woda_talent_int6",1}}
			},
			[4] = {
				{"modifier_woda_talent_mp2", "#woda_talent_mp2", 3, "mp2", {"modifier_woda_talent_mp1",3}},
				{"modifier_woda_talent_fairy", "#woda_talent_fairy", 2, "fairy", {}},
				{"empty_9"},
				{"modifier_dragon_knight_17","#modifier_dragon_knight_17", 1, "dragon_knight/17", {}},
				{"modifier_woda_talent_int4", "#woda_talent_int4", 1, "int4", {"modifier_woda_talent_kaya",1}}
			},
			[5] = {
				{"modifier_woda_talent_spellprism", "#woda_talent_spellprism", 3, "spellprism", {}},
				{"modifier_dragon_knight_19","#modifier_dragon_knight_19", 2, "dragon_knight/19", {}},
				{"empty_10"},
				{"empty_11"},
				{"modifier_woda_talent_int5", "#woda_talent_int5", 3, "int5", {"modifier_woda_talent_int4",1}}
			},
			[6] = {
				{"modifier_woda_talent_timeless", "#woda_talent_timeless", 2, "timeless", {}},
				{"modifier_woda_talent_regenmp2", "#woda_talent_regenmp2", 3, "regenmp2", {}},
				{"empty_14"},
				{"modifier_dragon_knight_18","#modifier_dragon_knight_18", 2, "dragon_knight/18", {}},
				{"empty_16"}
			},
			[7] = {
				{"empty_17"},
				{"empty_18"},
				{"modifier_dragon_knight_21","#modifier_dragon_knight_21", 1, "dragon_knight/21", {}},
				{"empty_20"},
				{"empty_21"}
			}
		}
	},
	["npc_dota_hero_omniknight"] = {
		[1] = {
			[1] = {
				{"modifier_woda_talent_hp1", "#woda_talent_hp1", 3, "hp1", {}},
				{"modifier_woda_talent_regenhp1", "#woda_talent_regenhp1", 2, "regenhp1", {}},
				{"modifier_woda_talent_attack1", "#woda_talent_attack1", 3, "attack1", {}},
				{"modifier_omniknight_3","#modifier_omniknight_3", 2, "omniknight/3", {}},
				{"modifier_woda_talent_str3", "#woda_talent_str3", 2, "str3", {}}
			},
			[2] = {
				{"empty_2"},
				{"empty_3"},
				{"modifier_omniknight_2","#modifier_omniknight_2", 2, "omniknight/2", {}},
				{"modifier_woda_talent_cloak", "#woda_talent_cloak", 2, "cloak", {}},
				{"modifier_woda_talent_str6", "#woda_talent_str6", 1, "str6", {"modifier_woda_talent_str3",2}}
			},
			[3] = {
				{"empty_6"},
				{"modifier_woda_talent_quickhp", "#woda_talent_quickhp", 2, "quickhp", {}},
				{"empty_7"},
				{"modifier_omniknight_1","#modifier_omniknight_1", 2, "omniknight/1", {}},
				{"modifier_woda_talent_sasha", "#woda_talent_sasha", 1, "sasha", {"modifier_woda_talent_str6",1}}
			},
			[4] = {
				{"modifier_woda_talent_hp2", "#woda_talent_hp2", 3, "hp2", {"modifier_woda_talent_hp1",3}},
				{"empty_9"},
				{"modifier_omniknight_4","#modifier_omniknight_4", 3, "omniknight/4", {}},
				{"modifier_woda_talent_octar", "#woda_talent_octar", 2, "octar", {}},
				{"modifier_woda_talent_str4", "#woda_talent_str4", 1, "str4", {"modifier_woda_talent_sasha",1}}
			},
			[5] = {
				{"modifier_woda_talent_armor2", "#woda_talent_armor2", 3, "armor2", {}},
				{"empty_10"},
				{"empty_11"},
				{"modifier_omniknight_5","#modifier_omniknight_5", 2, "omniknight/5", {}},
				{"modifier_woda_talent_str5", "#woda_talent_str5", 3, "str5", {"modifier_woda_talent_str4",1}}
			},
			[6] = {
				{"modifier_woda_talent_sliver", "#woda_talent_sliver", 2, "sliver", {}},
				{"modifier_woda_talent_regenhp2", "#woda_talent_regenhp2", 3, "regenhp2", {}},
				{"empty_14"},
				{"modifier_omniknight_6","#modifier_omniknight_6", 2, "omniknight/6", {"modifier_omniknight_5",2}},
				{"empty_16"}
			},
			[7] = {
				{"empty_17"},
				{"empty_18"},
				{"modifier_omniknight_7","#modifier_omniknight_7", 1, "omniknight/7", {}},
				{"empty_20"},
				{"empty_21"}
			}
		},
		[2] = {
			[1] = {
				{"modifier_woda_talent_armor1", "#woda_talent_armor1", 3, "armor1", {}},
				{"modifier_woda_talent_speed1", "#woda_talent_speed1", 2, "speed1", {}},
				{"modifier_woda_talent_attackspeed1", "#woda_talent_attackspeed1", 3, "attackspeed1", {}},
				{"modifier_omniknight_8","#modifier_omniknight_8", 3, "omniknight/8", {}},
				{"modifier_woda_talent_agi3", "#woda_talent_agi3", 2, "agi3", {}}
			},
			[2] = {
				{"empty_3"},
				{"empty_4"},
				{"modifier_omniknight_11","#modifier_omniknight_11", 3, "omniknight/11", {}},
				{"modifier_woda_talent_miss1", "#woda_talent_miss1", 2, "miss1", {}},
				{"modifier_woda_talent_agi6", "#woda_talent_agi6", 1, "agi6", {"modifier_woda_talent_agi3",2}}
			},
			[3] = {
				{"modifier_omniknight_10","#modifier_omniknight_10", 2, "omniknight/10", {}},
				{"empty_7"},
				{"empty_8"},
				{"modifier_woda_talent_mask1", "#woda_talent_mask1", 2, "mask1", {}},
				{"modifier_woda_talent_yasha", "#woda_talent_yasha", 1, "yasha", {"modifier_woda_talent_agi6",1}}
			},
			[4] = {
				{"modifier_omniknight_13","#modifier_omniknight_13", 3, "omniknight/13", {}},
				{"modifier_woda_talent_speed2", "#woda_talent_speed2", 3, "speed2", {"modifier_woda_talent_speed1",2}},
				{"modifier_woda_talent_grovebow", "#woda_talent_grovebow", 2, "grovebow", {}},
				{"empty_10"},			
				{"modifier_woda_talent_agi4", "#woda_talent_agi4", 1, "agi4", {"modifier_woda_talent_yasha",1}}
			},
			[5] = {
				{"modifier_woda_talent_attack2", "#woda_talent_attack2", 3, "attack2", {}},
				{"empty_11"},
				{"modifier_omniknight_12","#modifier_omniknight_12", 1, "omniknight/12", {}},
				{"empty_12"},
				{"modifier_woda_talent_agi5", "#woda_talent_agi5", 3, "agi5", {"modifier_woda_talent_agi4",1}}
			},
			[6] = {
				{"modifier_woda_talent_miss2", "#woda_talent_miss2", 2, "miss2", {}},
				{"empty_13"},
				{"modifier_woda_talent_attackspeed2", "#woda_talent_attackspeed2", 3, "attackspeed2", {}},
				{"modifier_omniknight_9","#modifier_omniknight_9", 1, "omniknight/9", {}},
				{"empty_16"}
			},
			[7] = {
				{"empty_17"},
				{"empty_18"},
				{"modifier_omniknight_14","#modifier_omniknight_14", 1, "omniknight/14", {}},
				{"empty_20"},
				{"empty_21"}
			}
		},
		[3] = {
			[1] = {
				{"modifier_woda_talent_mp1", "#woda_talent_mp1", 3, "mp1", {}},
				{"modifier_woda_talent_regenmp1", "#woda_talent_regenmp1", 2, "regenmp1", {}},
				{"modifier_woda_talent_spell", "#woda_talent_spell", 3, "spell", {}},
				{"modifier_omniknight_15","#modifier_omniknight_15", 2, "omniknight/15", {}},
				{"modifier_woda_talent_int3", "#woda_talent_int3", 2, "int3", {}}
			},
			[2] = {
				{"empty_2"},
				{"empty_3"},
				{"modifier_omniknight_17","#modifier_omniknight_17", 3, "omniknight/17", {}},
				{"modifier_woda_talent_blood", "#woda_talent_blood", 2, "blood", {}},
				{"modifier_woda_talent_int6", "#woda_talent_int6", 1, "int6", {"modifier_woda_talent_int3",2}}
			},
			[3] = {
				{"empty_6"},
				{"empty_7"},
				{"modifier_omniknight_19","#modifier_omniknight_19", 1, "omniknight/19", {"modifier_omniknight_17",3}},
				{"modifier_woda_talent_mask2", "#woda_talent_mask2", 2, "mask2", {}},
				{"modifier_woda_talent_kaya", "#woda_talent_kaya", 1, "kaya", {"modifier_woda_talent_int6",1}}
			},
			[4] = {
				{"modifier_woda_talent_mp2", "#woda_talent_mp2", 3, "mp2", {"modifier_woda_talent_mp1",3}},
				{"modifier_woda_talent_fairy", "#woda_talent_fairy", 2, "fairy", {}},
				{"empty_9"},
				{"modifier_omniknight_16","#modifier_omniknight_16", 1, "omniknight/16", {}},
				{"modifier_woda_talent_int4", "#woda_talent_int4", 1, "int4", {"modifier_woda_talent_kaya",1}}
			},
			[5] = {
				{"modifier_woda_talent_spellprism", "#woda_talent_spellprism", 3, "spellprism", {}},
				{"empty_11"},
				{"modifier_omniknight_18","#modifier_omniknight_18", 3, "omniknight/18", {}},
				{"empty_12"},
				{"modifier_woda_talent_int5", "#woda_talent_int5", 3, "int5", {"modifier_woda_talent_int4",1}}
			},
			[6] = {
				{"modifier_woda_talent_timeless", "#woda_talent_timeless", 2, "timeless", {}},
				{"modifier_woda_talent_regenmp2", "#woda_talent_regenmp2", 3, "regenmp2", {}},
				{"modifier_omniknight_20","#modifier_omniknight_20", 3, "omniknight/20", {}},
				{"empty_15"},
				{"empty_16"}
			},
			[7] = {
				{"empty_17"},
				{"empty_18"},
				{"modifier_omniknight_21","#modifier_omniknight_21", 1, "omniknight/21", {}},
				{"empty_20"},
				{"empty_21"}
			}
		}
	},
	["npc_dota_hero_lone_druid"] = {
		[1] = {
			[1] = {
				{"modifier_woda_talent_hp1", "#woda_talent_hp1", 3, "hp1", {}},
				{"modifier_woda_talent_regenhp1", "#woda_talent_regenhp1", 2, "regenhp1", {}},
				{"modifier_lone_druid_6","#modifier_lone_druid_6", 2, "lone_druid/6", {}},
				{"modifier_woda_talent_attack1", "#woda_talent_attack1", 3, "attack1", {}},
				{"modifier_woda_talent_str3", "#woda_talent_str3", 2, "str3", {}}
			},
			[2] = {
				{"empty_2"},
				{"empty_3"},
				{"modifier_lone_druid_7","#modifier_lone_druid_7", 3, "lone_druid/7", {}},
				{"modifier_woda_talent_cloak", "#woda_talent_cloak", 2, "cloak", {}},
				{"modifier_woda_talent_str6", "#woda_talent_str6", 1, "str6", {"modifier_woda_talent_str3",2}}
			},
			[3] = {
				{"empty_6"},
				{"modifier_woda_talent_quickhp", "#woda_talent_quickhp", 2, "quickhp", {}},
				{"modifier_lone_druid_5","#modifier_lone_druid_5", 2, "lone_druid/5", {}},
				{"empty_7"},
				{"modifier_woda_talent_sasha", "#woda_talent_sasha", 1, "sasha", {"modifier_woda_talent_str6",1}}
			},
			[4] = {
				{"modifier_woda_talent_hp2", "#woda_talent_hp2", 3, "hp2", {"modifier_woda_talent_hp1",3}},
				{"modifier_lone_druid_4","#modifier_lone_druid_4", 1, "lone_druid/4", {}},
				{"empty_9"},
				{"modifier_woda_talent_octar", "#woda_talent_octar", 2, "octar", {}},
				{"modifier_woda_talent_str4", "#woda_talent_str4", 1, "str4", {"modifier_woda_talent_sasha",1}}
			},
			[5] = {
				{"modifier_woda_talent_armor2", "#woda_talent_armor2", 3, "armor2", {}},
				{"empty_10"},
				{"empty_11"},
				{"modifier_lone_druid_3","#modifier_lone_druid_3", 2, "lone_druid/3", {}},
				{"modifier_woda_talent_str5", "#woda_talent_str5", 3, "str5", {"modifier_woda_talent_str4",1}}
			},
			[6] = {
				{"modifier_woda_talent_sliver", "#woda_talent_sliver", 2, "sliver", {}},
				{"modifier_woda_talent_regenhp2", "#woda_talent_regenhp2", 3, "regenhp2", {}},
				{"empty_14"},
				{"modifier_lone_druid_2","#modifier_lone_druid_2", 3, "lone_druid/2", {}},
				{"empty_15"}
			},
			[7] = {
				{"empty_17"},
				{"empty_18"},
				{"modifier_lone_druid_23","#modifier_lone_druid_23", 1, "lone_druid/23", {}},
				{"empty_20"},
				{"empty_21"}
			}
		},
		[2] = {
			[1] = {
				{"modifier_woda_talent_armor1", "#woda_talent_armor1", 3, "armor1", {}},
				{"modifier_woda_talent_speed1", "#woda_talent_speed1", 2, "speed1", {}},
				{"modifier_lone_druid_9","#modifier_lone_druid_9", 1, "lone_druid/9", {}},
				{"modifier_woda_talent_attackspeed1", "#woda_talent_attackspeed1", 3, "attackspeed1", {}},
				{"modifier_woda_talent_agi3", "#woda_talent_agi3", 2, "agi3", {}}
			},
			[2] = {
				{"empty_4"},
				{"empty_3"},
				{"modifier_lone_druid_10","#modifier_lone_druid_10", 3, "lone_druid/10", {"modifier_lone_druid_9",1}},
				{"modifier_woda_talent_miss1", "#woda_talent_miss1", 2, "miss1", {}},
				{"modifier_woda_talent_agi6", "#woda_talent_agi6", 1, "agi6", {"modifier_woda_talent_agi3",2}}
			},
			[3] = {
				{"empty_8"},
				{"empty_7"},
				{"modifier_lone_druid_8","#modifier_lone_druid_8", 3, "lone_druid/8", {"modifier_lone_druid_10",3}},
				{"modifier_woda_talent_mask1", "#woda_talent_mask1", 2, "mask1", {}},
				{"modifier_woda_talent_yasha", "#woda_talent_yasha", 1, "yasha", {"modifier_woda_talent_agi6",1}}
			},
			[4] = {
				{"empty_10"},
				{"modifier_woda_talent_speed2", "#woda_talent_speed2", 3, "speed2", {"modifier_woda_talent_speed1",2}},
				{"modifier_lone_druid_11","#modifier_lone_druid_11", 1, "lone_druid/11", {"modifier_lone_druid_8",3}},
				{"modifier_woda_talent_grovebow", "#woda_talent_grovebow", 2, "grovebow", {}},			
				{"modifier_woda_talent_agi4", "#woda_talent_agi4", 1, "agi4", {"modifier_woda_talent_yasha",1}}
			},
			[5] = {
				{"modifier_woda_talent_attack2", "#woda_talent_attack2", 3, "attack2", {}},
				{"modifier_lone_druid_12","#modifier_lone_druid_12", 2, "lone_druid/12", {}},
				{"empty_11"},
				{"empty_12"},
				{"modifier_woda_talent_agi5", "#woda_talent_agi5", 3, "agi5", {"modifier_woda_talent_agi4",1}}
			},
			[6] = {
				{"modifier_woda_talent_miss2", "#woda_talent_miss2", 2, "miss2", {}},
				{"empty_13"},
				{"modifier_woda_talent_attackspeed2", "#woda_talent_attackspeed2", 3, "attackspeed2", {}},
				{"modifier_lone_druid_14","#modifier_lone_druid_14", 3, "lone_druid/14", {}},
				{"empty_16"}
			},
			[7] = {
				{"empty_17"},
				{"empty_18"},
				{"modifier_lone_druid_15","#modifier_lone_druid_15", 1, "lone_druid/15", {}},
				{"empty_20"},
				{"empty_21"}
			}
		},
		[3] = {
			[1] = {
				{"modifier_woda_talent_mp1", "#woda_talent_mp1", 3, "mp1", {}},
				{"modifier_woda_talent_regenmp1", "#woda_talent_regenmp1", 2, "regenmp1", {}},
				{"modifier_lone_druid_17","#modifier_lone_druid_17", 1, "lone_druid/17", {}},
				{"modifier_woda_talent_spell", "#woda_talent_spell", 3, "spell", {}},
				{"modifier_woda_talent_int3", "#woda_talent_int3", 2, "int3", {}}
			},
			[2] = {
				{"empty_2"},
				{"empty_3"},
				{"modifier_lone_druid_19","#modifier_lone_druid_19", 1, "lone_druid/19", {"modifier_lone_druid_17",1}},
				{"modifier_woda_talent_blood", "#woda_talent_blood", 2, "blood", {}},
				{"modifier_woda_talent_int6", "#woda_talent_int6", 1, "int6", {"modifier_woda_talent_int3",2}}
			},
			[3] = {
				{"empty_6"},
				{"empty_7"},
				{"modifier_lone_druid_18","#modifier_lone_druid_18", 3, "lone_druid/18", {"modifier_lone_druid_19",1}},
				{"modifier_woda_talent_mask2", "#woda_talent_mask2", 2, "mask2", {}},
				{"modifier_woda_talent_kaya", "#woda_talent_kaya", 1, "kaya", {"modifier_woda_talent_int6",1}}
			},
			[4] = {
				{"modifier_woda_talent_mp2", "#woda_talent_mp2", 3, "mp2", {"modifier_woda_talent_mp1",3}},
				{"modifier_woda_talent_fairy", "#woda_talent_fairy", 2, "fairy", {}},
				{"empty_9"},
				{"modifier_lone_druid_20","#modifier_lone_druid_20", 3, "lone_druid/20", {}},
				{"modifier_woda_talent_int4", "#woda_talent_int4", 1, "int4", {"modifier_woda_talent_kaya",1}}
			},
			[5] = {
				{"modifier_woda_talent_spellprism", "#woda_talent_spellprism", 3, "spellprism", {}},
				{"modifier_lone_druid_16","#modifier_lone_druid_16", 3, "lone_druid/16", {}},
				{"empty_11"},
				{"empty_10"},
				{"modifier_woda_talent_int5", "#woda_talent_int5", 3, "int5", {"modifier_woda_talent_int4",1}}
			},
			[6] = {
				{"modifier_woda_talent_timeless", "#woda_talent_timeless", 2, "timeless", {}},
				{"modifier_woda_talent_regenmp2", "#woda_talent_regenmp2", 3, "regenmp2", {}},
				{"modifier_lone_druid_21","#modifier_lone_druid_21", 2, "lone_druid/21", {}},
				{"empty_15"},
				{"empty_16"}
			},
			[7] = {
				{"empty_17"},
				{"empty_18"},
				{"modifier_lone_druid_22","#modifier_lone_druid_22", 1, "lone_druid/22", {}},
				{"empty_20"},
				{"empty_21"}
			}
		}
	},
	["npc_dota_hero_windrunner"] = {
		[1] = {
			[1] = {
				{"modifier_woda_talent_hp1", "#woda_talent_hp1", 3, "hp1", {}},
				{"modifier_woda_talent_regenhp1", "#woda_talent_regenhp1", 2, "regenhp1", {}},
				{"modifier_woda_talent_attack1", "#woda_talent_attack1", 3, "attack1", {}},
				{"modifier_windrunner_1","#modifier_windrunner_1", 3, "windrunner/1", {}},
				{"modifier_woda_talent_str3", "#woda_talent_str3", 2, "str3", {}}
			},
			[2] = {
				{"empty_2"},
				{"modifier_windrunner_2","#modifier_windrunner_2", 2, "windrunner/2", {}},
				{"empty_3"},
				{"modifier_woda_talent_cloak", "#woda_talent_cloak", 2, "cloak", {}},
				{"modifier_woda_talent_str6", "#woda_talent_str6", 1, "str6", {"modifier_woda_talent_str3",2}}
			},
			[3] = {
				{"empty_6"},
				{"modifier_woda_talent_quickhp", "#woda_talent_quickhp", 2, "quickhp", {}},
				{"modifier_windrunner_3","#modifier_windrunner_3", 1, "windrunner/3", {}},
				{"empty_7"},
				{"modifier_woda_talent_sasha", "#woda_talent_sasha", 1, "sasha", {"modifier_woda_talent_str6",1}}
			},
			[4] = {
				{"modifier_woda_talent_hp2", "#woda_talent_hp2", 3, "hp2", {"modifier_woda_talent_hp1",3}},
				{"empty_9"},
				{"modifier_windrunner_4","#modifier_windrunner_4", 2, "windrunner/4", {"modifier_windrunner_3",1}},
				{"modifier_woda_talent_octar", "#woda_talent_octar", 2, "octar", {}},
				{"modifier_woda_talent_str4", "#woda_talent_str4", 1, "str4", {"modifier_woda_talent_sasha",1}}
			},
			[5] = {
				{"modifier_woda_talent_armor2", "#woda_talent_armor2", 3, "armor2", {}},
				{"empty_10"},
				{"modifier_windrunner_6","#modifier_windrunner_6", 3, "windrunner/6", {"modifier_windrunner_4",2}},
				{"empty_12"},
				{"modifier_woda_talent_str5", "#woda_talent_str5", 3, "str5", {"modifier_woda_talent_str4",1}}
			},
			[6] = {
				{"modifier_woda_talent_sliver", "#woda_talent_sliver", 2, "sliver", {}},
				{"modifier_woda_talent_regenhp2", "#woda_talent_regenhp2", 3, "regenhp2", {}},
				{"empty_14"},
				{"modifier_windrunner_8","#modifier_windrunner_8", 2, "windrunner/8", {}},
				{"empty_16"}
			},
			[7] = {
				{"empty_17"},
				{"empty_18"},
				{"modifier_windrunner_5","#modifier_windrunner_5", 1, "windrunner/5", {}},
				{"empty_20"},
				{"empty_21"}
			}
		},
		[2] = {
			[1] = {
				{"modifier_windrunner_9","#modifier_windrunner_9", 1, "windrunner/9", {}},
				{"modifier_woda_talent_speed1", "#woda_talent_speed1", 2, "speed1", {}},
				{"modifier_woda_talent_attackspeed1", "#woda_talent_attackspeed1", 3, "attackspeed1", {}},
				{"modifier_woda_talent_armor1", "#woda_talent_armor1", 3, "armor1", {}},
				{"modifier_woda_talent_agi3", "#woda_talent_agi3", 2, "agi3", {}}
			},
			[2] = {
				{"modifier_windrunner_10","#modifier_windrunner_10", 3, "windrunner/10", {"modifier_windrunner_9",1}},
				{"empty_3"},
				{"empty_4"},
				{"modifier_woda_talent_miss1", "#woda_talent_miss1", 2, "miss1", {}},
				{"modifier_woda_talent_agi6", "#woda_talent_agi6", 1, "agi6", {"modifier_woda_talent_agi3",2}}
			},
			[3] = {
				{"modifier_windrunner_11","#modifier_windrunner_11", 3, "windrunner/11", {"modifier_windrunner_10",3}},
				{"empty_7"},
				{"empty_8"},
				{"modifier_woda_talent_mask1", "#woda_talent_mask1", 2, "mask1", {}},
				{"modifier_woda_talent_yasha", "#woda_talent_yasha", 1, "yasha", {"modifier_woda_talent_agi6",1}}
			},
			[4] = {
				{"empty_10"},
				{"modifier_woda_talent_speed2", "#woda_talent_speed2", 3, "speed2", {"modifier_woda_talent_speed1",2}},
				{"modifier_woda_talent_grovebow", "#woda_talent_grovebow", 2, "grovebow", {}},
				{"modifier_windrunner_7","#modifier_windrunner_7", 1, "windrunner/7", {}},			
				{"modifier_woda_talent_agi4", "#woda_talent_agi4", 1, "agi4", {"modifier_woda_talent_yasha",1}}
			},
			[5] = {
				{"modifier_woda_talent_attack2", "#woda_talent_attack2", 3, "attack2", {}},
				{"modifier_windrunner_12","#modifier_windrunner_12", 3, "windrunner/12", {}},
				{"empty_11"},
				{"empty_12"},
				{"modifier_woda_talent_agi5", "#woda_talent_agi5", 3, "agi5", {"modifier_woda_talent_agi4",1}}
			},
			[6] = {
				{"modifier_woda_talent_miss2", "#woda_talent_miss2", 2, "miss2", {}},
				{"modifier_windrunner_14","#modifier_windrunner_14", 2, "windrunner/14", {}},
				{"modifier_woda_talent_attackspeed2", "#woda_talent_attackspeed2", 3, "attackspeed2", {}},
				{"empty_13"},
				{"empty_16"}
			},
			[7] = {
				{"empty_17"},
				{"empty_18"},
				{"modifier_windrunner_15","#modifier_windrunner_15", 1, "windrunner/15", {}},
				{"empty_20"},
				{"empty_21"}
			}
		},
		[3] = {
			[1] = {
				{"modifier_woda_talent_mp1", "#woda_talent_mp1", 3, "mp1", {}},
				{"modifier_woda_talent_regenmp1", "#woda_talent_regenmp1", 2, "regenmp1", {}},
				{"modifier_woda_talent_spell", "#woda_talent_spell", 3, "spell", {}},
				{"modifier_windrunner_16","#modifier_windrunner_16", 3, "windrunner/16", {}},
				{"modifier_woda_talent_int3", "#woda_talent_int3", 2, "int3", {}}
			},
			[2] = {
				{"empty_2"},
				{"empty_3"},
				{"modifier_windrunner_22","#modifier_windrunner_22", 3, "windrunner/22", {}},
				{"modifier_woda_talent_blood", "#woda_talent_blood", 2, "blood", {}},
				{"modifier_woda_talent_int6", "#woda_talent_int6", 1, "int6", {"modifier_woda_talent_int3",2}}
			},
			[3] = {
				{"empty_6"},
				{"modifier_windrunner_18","#modifier_windrunner_18", 2, "windrunner/18", {}},
				{"empty_7"},
				{"modifier_woda_talent_mask2", "#woda_talent_mask2", 2, "mask2", {}},
				{"modifier_woda_talent_kaya", "#woda_talent_kaya", 1, "kaya", {"modifier_woda_talent_int6",1}}
			},
			[4] = {
				{"modifier_woda_talent_mp2", "#woda_talent_mp2", 3, "mp2", {"modifier_woda_talent_mp1",3}},
				{"modifier_woda_talent_fairy", "#woda_talent_fairy", 2, "fairy", {}},
				{"empty_9"},
				{"modifier_windrunner_17","#modifier_windrunner_17", 3, "windrunner/17", {}},
				{"modifier_woda_talent_int4", "#woda_talent_int4", 1, "int4", {"modifier_woda_talent_kaya",1}}
			},
			[5] = {
				{"modifier_woda_talent_spellprism", "#woda_talent_spellprism", 3, "spellprism", {}},
				{"empty_10"},
				{"empty_11"},
				{"modifier_windrunner_19","#modifier_windrunner_19", 1, "windrunner/19", {}},
				{"modifier_woda_talent_int5", "#woda_talent_int5", 3, "int5", {"modifier_woda_talent_int4",1}}
			},
			[6] = {
				{"modifier_woda_talent_timeless", "#woda_talent_timeless", 2, "timeless", {}},
				{"modifier_woda_talent_regenmp2", "#woda_talent_regenmp2", 3, "regenmp2", {}},
				{"empty_14"},
				{"empty_15"},
				{"modifier_windrunner_20","#modifier_windrunner_20", 1, "windrunner/20", {}}
			},
			[7] = {
				{"empty_17"},
				{"empty_18"},
				{"modifier_windrunner_23","#modifier_windrunner_23", 1, "windrunner/23", {}},
				{"empty_20"},
				{"empty_21"}
			}
		}
	},
	["npc_dota_hero_drow_ranger"] = {
		[1] = {
			[1] = {
				{"modifier_woda_talent_hp1", "#woda_talent_hp1", 3, "hp1", {}},
				{"modifier_woda_talent_regenhp1", "#woda_talent_regenhp1", 2, "regenhp1", {}},
				{"modifier_woda_talent_attack1", "#woda_talent_attack1", 3, "attack1", {}},
				{"modifier_drow_ranger_2","#modifier_drow_ranger_2", 3, "drow_ranger/2", {}},
				{"modifier_woda_talent_str3", "#woda_talent_str3", 2, "str3", {}}
			},
			[2] = {
				{"empty_2"},
				{"modifier_drow_ranger_1","#modifier_drow_ranger_1", 3, "drow_ranger/1", {}},
				{"empty_3"},
				{"modifier_woda_talent_cloak", "#woda_talent_cloak", 2, "cloak", {}},
				{"modifier_woda_talent_str6", "#woda_talent_str6", 1, "str6", {"modifier_woda_talent_str3",2}}
			},
			[3] = {
				{"empty_6"},
				{"modifier_woda_talent_quickhp", "#woda_talent_quickhp", 2, "quickhp", {}},
				{"empty_8"},
				{"modifier_drow_ranger_3","#modifier_drow_ranger_3", 2, "drow_ranger/3", {}},
				{"modifier_woda_talent_sasha", "#woda_talent_sasha", 1, "sasha", {"modifier_woda_talent_str6",1}}
			},
			[4] = {
				{"modifier_woda_talent_hp2", "#woda_talent_hp2", 3, "hp2", {"modifier_woda_talent_hp1",3}},
				{"modifier_drow_ranger_5","#modifier_drow_ranger_5", 2, "drow_ranger/5", {}},
				{"empty_9"},
				{"modifier_woda_talent_octar", "#woda_talent_octar", 2, "octar", {}},
				{"modifier_woda_talent_str4", "#woda_talent_str4", 1, "str4", {"modifier_woda_talent_sasha",1}}
			},
			[5] = {
				{"modifier_woda_talent_armor2", "#woda_talent_armor2", 3, "armor2", {}},
				{"empty_10"},
				{"modifier_drow_ranger_4","#modifier_drow_ranger_4", 1, "drow_ranger/4", {}},
				{"empty_11"},
				{"modifier_woda_talent_str5", "#woda_talent_str5", 3, "str5", {"modifier_woda_talent_str4",1}}
			},
			[6] = {
				{"modifier_woda_talent_sliver", "#woda_talent_sliver", 2, "sliver", {}},
				{"modifier_woda_talent_regenhp2", "#woda_talent_regenhp2", 3, "regenhp2", {}},
				{"modifier_drow_ranger_6","#modifier_drow_ranger_6", 2, "drow_ranger/6", {"modifier_drow_ranger_4",1}},
				{"empty_15"},
				{"empty_16"}
			},
			[7] = {
				{"empty_17"},
				{"empty_18"},
				{"modifier_drow_ranger_7","#modifier_drow_ranger_7", 1, "drow_ranger/7", {}},
				{"empty_20"},
				{"empty_21"}
			}
		},
		[2] = {
			[1] = {
				{"modifier_woda_talent_armor1", "#woda_talent_armor1", 3, "armor1", {}},
				{"modifier_woda_talent_speed1", "#woda_talent_speed1", 2, "speed1", {}},
				{"modifier_woda_talent_attackspeed1", "#woda_talent_attackspeed1", 3, "attackspeed1", {}},
				{"modifier_drow_ranger_8","#modifier_drow_ranger_8", 3, "drow_ranger/8", {}},
				{"modifier_woda_talent_agi3", "#woda_talent_agi3", 2, "agi3", {}}
			},
			[2] = {
				{"modifier_drow_ranger_14","#modifier_drow_ranger_14", 1, "drow_ranger/14", {}},
				{"empty_3"},
				{"empty_4"},
				{"modifier_woda_talent_miss1", "#woda_talent_miss1", 2, "miss1", {}},
				{"modifier_woda_talent_agi6", "#woda_talent_agi6", 1, "agi6", {"modifier_woda_talent_agi3",2}}
			},
			[3] = {
				{"empty_5"},
				{"empty_6"},
				{"modifier_drow_ranger_9","#modifier_drow_ranger_9", 3, "drow_ranger/9", {}},
				{"modifier_woda_talent_mask1", "#woda_talent_mask1", 2, "mask1", {}},
				{"modifier_woda_talent_yasha", "#woda_talent_yasha", 1, "yasha", {"modifier_woda_talent_agi6",1}}
			},
			[4] = {
				{"empty_10"},
				{"modifier_woda_talent_speed2", "#woda_talent_speed2", 3, "speed2", {"modifier_woda_talent_speed1",2}},
				{"modifier_woda_talent_grovebow", "#woda_talent_grovebow", 2, "grovebow", {}},
				{"modifier_drow_ranger_11","#modifier_drow_ranger_11", 3, "drow_ranger/11", {}},			
				{"modifier_woda_talent_agi4", "#woda_talent_agi4", 1, "agi4", {"modifier_woda_talent_yasha",1}}
			},
			[5] = {
				{"modifier_woda_talent_attack2", "#woda_talent_attack2", 3, "attack2", {}},
				{"empty_11"},
				{"empty_12"},
				{"modifier_drow_ranger_10","#modifier_drow_ranger_10", 2, "drow_ranger/10", {}},
				{"modifier_woda_talent_agi5", "#woda_talent_agi5", 3, "agi5", {"modifier_woda_talent_agi4",1}}
			},
			[6] = {
				{"modifier_woda_talent_miss2", "#woda_talent_miss2", 2, "miss2", {}},
				{"modifier_drow_ranger_13","#modifier_drow_ranger_13", 1, "drow_ranger/13", {}},
				{"modifier_woda_talent_attackspeed2", "#woda_talent_attackspeed2", 3, "attackspeed2", {}},
				{"empty_13"},
				{"empty_16"}
			},
			[7] = {
				{"empty_17"},
				{"empty_18"},
				{"modifier_drow_ranger_16","#modifier_drow_ranger_16", 1, "drow_ranger/16", {}},
				{"empty_20"},
				{"empty_21"}
			}
		},
		[3] = {
			[1] = {
				{"modifier_woda_talent_mp1", "#woda_talent_mp1", 3, "mp1", {}},
				{"modifier_woda_talent_regenmp1", "#woda_talent_regenmp1", 2, "regenmp1", {}},
				{"modifier_woda_talent_spell", "#woda_talent_spell", 3, "spell", {}},
				{"modifier_drow_ranger_17","#modifier_drow_ranger_17", 3, "drow_ranger/17", {}},
				{"modifier_woda_talent_int3", "#woda_talent_int3", 2, "int3", {}}
			},
			[2] = {
				{"empty_2"},
				{"empty_3"},
				{"modifier_drow_ranger_18","#modifier_drow_ranger_18", 2, "drow_ranger/18", {}},
				{"modifier_woda_talent_blood", "#woda_talent_blood", 2, "blood", {}},
				{"modifier_woda_talent_int6", "#woda_talent_int6", 1, "int6", {"modifier_woda_talent_int3",2}}
			},
			[3] = {
				{"empty_6"},
				{"modifier_drow_ranger_15","#modifier_drow_ranger_15", 3, "drow_ranger/15", {}},
				{"empty_7"},
				{"modifier_woda_talent_mask2", "#woda_talent_mask2", 2, "mask2", {}},
				{"modifier_woda_talent_kaya", "#woda_talent_kaya", 1, "kaya", {"modifier_woda_talent_int6",1}}
			},
			[4] = {
				{"modifier_woda_talent_mp2", "#woda_talent_mp2", 3, "mp2", {"modifier_woda_talent_mp1",3}},
				{"modifier_woda_talent_fairy", "#woda_talent_fairy", 2, "fairy", {}},
				{"modifier_drow_ranger_19","#modifier_drow_ranger_19", 1, "drow_ranger/19", {}},
				{"empty_9"},
				{"modifier_woda_talent_int4", "#woda_talent_int4", 1, "int4", {"modifier_woda_talent_kaya",1}}
			},
			[5] = {
				{"modifier_woda_talent_spellprism", "#woda_talent_spellprism", 3, "spellprism", {}},
				{"empty_10"},
				{"empty_11"},
				{"modifier_drow_ranger_21","#modifier_drow_ranger_21", 1, "drow_ranger/21", {}},
				{"modifier_woda_talent_int5", "#woda_talent_int5", 3, "int5", {"modifier_woda_talent_int4",1}}
			},
			[6] = {
				{"modifier_woda_talent_timeless", "#woda_talent_timeless", 2, "timeless", {}},
				{"modifier_woda_talent_regenmp2", "#woda_talent_regenmp2", 3, "regenmp2", {}},
				{"empty_14"},
				{"modifier_drow_ranger_20","#modifier_drow_ranger_20", 3, "drow_ranger/20", {}},
				{"empty_15"}
			},
			[7] = {
				{"empty_17"},
				{"empty_18"},
				{"modifier_drow_ranger_22","#modifier_drow_ranger_22", 1, "drow_ranger/22", {}},
				{"empty_20"},
				{"empty_21"}
			}
		}
	},
	["npc_dota_hero_witch_doctor"] = {
		[1] = {
			[1] = {
				{"modifier_woda_talent_hp1", "#woda_talent_hp1", 3, "hp1", {}},
				{"modifier_woda_talent_regenhp1", "#woda_talent_regenhp1", 2, "regenhp1", {}},
				{"modifier_woda_talent_attack1", "#woda_talent_attack1", 3, "attack1", {}},
				{"modifier_witch_doctor_1","#modifier_witch_doctor_1", 2, "witch_doctor/1", {}},
				{"modifier_woda_talent_str3", "#woda_talent_str3", 2, "str3", {}}
			},
			[2] = {
				{"empty_2"},
				{"modifier_witch_doctor_6","#modifier_witch_doctor_6", 3, "witch_doctor/6", {}},
				{"empty_3"},
				{"modifier_woda_talent_cloak", "#woda_talent_cloak", 2, "cloak", {}},
				{"modifier_woda_talent_str6", "#woda_talent_str6", 1, "str6", {"modifier_woda_talent_str3",2}}
			},
			[3] = {
				{"empty_6"},
				{"modifier_woda_talent_quickhp", "#woda_talent_quickhp", 2, "quickhp", {}},
				{"empty_7"},
				{"modifier_witch_doctor_3","#modifier_witch_doctor_3", 2, "witch_doctor/3", {}},
				{"modifier_woda_talent_sasha", "#woda_talent_sasha", 1, "sasha", {"modifier_woda_talent_str6",1}}
			},
			[4] = {
				{"modifier_woda_talent_hp2", "#woda_talent_hp2", 3, "hp2", {"modifier_woda_talent_hp1",3}},
				{"modifier_witch_doctor_2","#modifier_witch_doctor_2", 2, "witch_doctor/2", {}},
				{"empty_9"},
				{"modifier_woda_talent_octar", "#woda_talent_octar", 2, "octar", {}},
				{"modifier_woda_talent_str4", "#woda_talent_str4", 1, "str4", {"modifier_woda_talent_sasha",1}}
			},
			[5] = {
				{"modifier_woda_talent_armor2", "#woda_talent_armor2", 3, "armor2", {}},
				{"modifier_witch_doctor_5","#modifier_witch_doctor_5", 1, "witch_doctor/5", {}},
				{"empty_10"},
				{"empty_11"},
				{"modifier_woda_talent_str5", "#woda_talent_str5", 3, "str5", {"modifier_woda_talent_str4",1}}
			},
			[6] = {
				{"modifier_woda_talent_sliver", "#woda_talent_sliver", 2, "sliver", {}},
				{"modifier_woda_talent_regenhp2", "#woda_talent_regenhp2", 3, "regenhp2", {}},
				{"modifier_witch_doctor_4","#modifier_witch_doctor_4", 3, "witch_doctor/4", {}},
				{"empty_15"},
				{"empty_16"}
			},
			[7] = {
				{"empty_17"},
				{"empty_18"},
				{"modifier_witch_doctor_7","#modifier_witch_doctor_7", 1, "witch_doctor/7", {}},
				{"empty_20"},
				{"empty_21"}
			}
		},
		[2] = {
			[1] = {
				{"modifier_woda_talent_armor1", "#woda_talent_armor1", 3, "armor1", {}},
				{"modifier_woda_talent_speed1", "#woda_talent_speed1", 2, "speed1", {}},
				{"modifier_woda_talent_attackspeed1", "#woda_talent_attackspeed1", 3, "attackspeed1", {}},
				{"modifier_witch_doctor_8","#modifier_witch_doctor_8", 2, "witch_doctor/8", {}},
				{"modifier_woda_talent_agi3", "#woda_talent_agi3", 2, "agi3", {}}
			},
			[2] = {
				{"empty_3"},
				{"empty_4"},
				{"modifier_witch_doctor_9","#modifier_witch_doctor_9", 3, "witch_doctor/9", {}},
				{"modifier_woda_talent_miss1", "#woda_talent_miss1", 2, "miss1", {}},
				{"modifier_woda_talent_agi6", "#woda_talent_agi6", 1, "agi6", {"modifier_woda_talent_agi3",2}}
			},
			[3] = {
				{"modifier_witch_doctor_10","#modifier_witch_doctor_10", 3, "witch_doctor/10", {}},
				{"empty_7"},
				{"empty_8"},
				{"modifier_woda_talent_mask1", "#woda_talent_mask1", 2, "mask1", {}},
				{"modifier_woda_talent_yasha", "#woda_talent_yasha", 1, "yasha", {"modifier_woda_talent_agi6",1}}
			},
			[4] = {
				{"modifier_witch_doctor_11","#modifier_witch_doctor_11", 1, "witch_doctor/11", {"modifier_witch_doctor_10",3}},
				{"modifier_woda_talent_speed2", "#woda_talent_speed2", 3, "speed2", {"modifier_woda_talent_speed1",2}},
				{"modifier_woda_talent_grovebow", "#woda_talent_grovebow", 2, "grovebow", {}},
				{"empty_10"},			
				{"modifier_woda_talent_agi4", "#woda_talent_agi4", 1, "agi4", {"modifier_woda_talent_yasha",1}}
			},
			[5] = {
				{"modifier_woda_talent_attack2", "#woda_talent_attack2", 3, "attack2", {}},
				{"modifier_witch_doctor_12","#modifier_witch_doctor_12", 3, "witch_doctor/12", {}},
				{"empty_11"},
				{"empty_12"},
				{"modifier_woda_talent_agi5", "#woda_talent_agi5", 3, "agi5", {"modifier_woda_talent_agi4",1}}
			},
			[6] = {
				{"modifier_woda_talent_miss2", "#woda_talent_miss2", 2, "miss2", {}},
				{"empty_13"},
				{"modifier_woda_talent_attackspeed2", "#woda_talent_attackspeed2", 3, "attackspeed2", {}},
				{"modifier_witch_doctor_13","#modifier_witch_doctor_13", 1, "witch_doctor/13", {}},
				{"empty_16"}
			},
			[7] = {
				{"empty_17"},
				{"empty_18"},
				{"modifier_witch_doctor_14","#modifier_witch_doctor_14", 1, "witch_doctor/14", {}},
				{"empty_20"},
				{"empty_21"}
			}
		},
		[3] = {
			[1] = {
				{"modifier_woda_talent_mp1", "#woda_talent_mp1", 3, "mp1", {}},
				{"modifier_woda_talent_regenmp1", "#woda_talent_regenmp1", 2, "regenmp1", {}},
				{"modifier_woda_talent_spell", "#woda_talent_spell", 3, "spell", {}},
				{"modifier_witch_doctor_15","#modifier_witch_doctor_15", 3, "witch_doctor/15", {}},
				{"modifier_woda_talent_int3", "#woda_talent_int3", 2, "int3", {}}
			},
			[2] = {
				{"empty_2"},
				{"empty_3"},
				{"modifier_witch_doctor_19","#modifier_witch_doctor_19", 3, "witch_doctor/19", {}},
				{"modifier_woda_talent_blood", "#woda_talent_blood", 2, "blood", {}},
				{"modifier_woda_talent_int6", "#woda_talent_int6", 1, "int6", {"modifier_woda_talent_int3",2}}
			},
			[3] = {
				{"empty_6"},
				{"modifier_witch_doctor_18","#modifier_witch_doctor_18", 2, "witch_doctor/18", {}},
				{"empty_7"},
				{"modifier_woda_talent_mask2", "#woda_talent_mask2", 2, "mask2", {}},
				{"modifier_woda_talent_kaya", "#woda_talent_kaya", 1, "kaya", {"modifier_woda_talent_int6",1}}
			},
			[4] = {
				{"modifier_woda_talent_mp2", "#woda_talent_mp2", 3, "mp2", {"modifier_woda_talent_mp1",3}},
				{"modifier_woda_talent_fairy", "#woda_talent_fairy", 2, "fairy", {}},
				{"modifier_witch_doctor_16","#modifier_witch_doctor_16", 1, "witch_doctor/16", {}},
				{"empty_9"},
				{"modifier_woda_talent_int4", "#woda_talent_int4", 1, "int4", {"modifier_woda_talent_kaya",1}}
			},
			[5] = {
				{"modifier_woda_talent_spellprism", "#woda_talent_spellprism", 3, "spellprism", {}},
				{"modifier_witch_doctor_17","#modifier_witch_doctor_17", 2, "witch_doctor/17", {}},
				{"empty_10"},
				{"empty_11"},
				{"modifier_woda_talent_int5", "#woda_talent_int5", 3, "int5", {"modifier_woda_talent_int4",1}}
			},
			[6] = {
				{"modifier_woda_talent_timeless", "#woda_talent_timeless", 2, "timeless", {}},
				{"modifier_woda_talent_regenmp2", "#woda_talent_regenmp2", 3, "regenmp2", {}},
				{"modifier_witch_doctor_20","#modifier_witch_doctor_20", 2, "witch_doctor/20", {}},
				{"empty_14"},
				{"empty_16"}
			},
			[7] = {
				{"empty_17"},
				{"empty_18"},
				{"modifier_witch_doctor_21","#modifier_witch_doctor_21", 1, "witch_doctor/21", {}},
				{"empty_20"},
				{"empty_21"}
			}
		}
	},
	["npc_dota_hero_nevermore"] = {
		[1] = {
			[1] = {
				{"modifier_woda_talent_hp1", "#woda_talent_hp1", 3, "hp1", {}},
				{"modifier_woda_talent_regenhp1", "#woda_talent_regenhp1", 2, "regenhp1", {}},
				{"modifier_nevermore_2","#modifier_nevermore_2", 1, "nevermore/2", {}},
				{"modifier_woda_talent_attack1", "#woda_talent_attack1", 3, "attack1", {}},
				{"modifier_woda_talent_str3", "#woda_talent_str3", 2, "str3", {}}
			},
			[2] = {
				{"empty_2"},
				{"empty_3"},
				{"modifier_nevermore_3","#modifier_nevermore_3", 3, "nevermore/3", {"modifier_nevermore_2",1}},
				{"modifier_woda_talent_cloak", "#woda_talent_cloak", 2, "cloak", {}},
				{"modifier_woda_talent_str6", "#woda_talent_str6", 1, "str6", {"modifier_woda_talent_str3",2}}
			},
			[3] = {
				{"empty_6"},
				{"modifier_woda_talent_quickhp", "#woda_talent_quickhp", 2, "quickhp", {}},
				{"modifier_nevermore_4","#modifier_nevermore_4", 2, "nevermore/4", {"modifier_nevermore_3",3}},
				{"empty_8"},
				{"modifier_woda_talent_sasha", "#woda_talent_sasha", 1, "sasha", {"modifier_woda_talent_str6",1}}
			},
			[4] = {
				{"modifier_woda_talent_hp2", "#woda_talent_hp2", 3, "hp2", {"modifier_woda_talent_hp1",3}},
				{"empty_9"},
				{"modifier_nevermore_5","#modifier_nevermore_5", 3, "nevermore/5", {"modifier_nevermore_4",2}},
				{"modifier_woda_talent_octar", "#woda_talent_octar", 2, "octar", {}},
				{"modifier_woda_talent_str4", "#woda_talent_str4", 1, "str4", {"modifier_woda_talent_sasha",1}}
			},
			[5] = {
				{"modifier_woda_talent_armor2", "#woda_talent_armor2", 3, "armor2", {}},
				{"empty_10"},
				{"modifier_nevermore_6","#modifier_nevermore_6", 3, "nevermore/6", {"modifier_nevermore_5",3}},
				{"empty_12"},
				{"modifier_woda_talent_str5", "#woda_talent_str5", 3, "str5", {"modifier_woda_talent_str4",1}}
			},
			[6] = {
				{"modifier_woda_talent_sliver", "#woda_talent_sliver", 2, "sliver", {}},
				{"modifier_woda_talent_regenhp2", "#woda_talent_regenhp2", 3, "regenhp2", {}},
				{"empty_14"},
				{"empty_15"},
				{"modifier_nevermore_1","#modifier_nevermore_1", 1, "nevermore/1", {}}
			},
			[7] = {
				{"empty_17"},
				{"empty_18"},
				{"modifier_nevermore_7","#modifier_nevermore_7", 1, "nevermore/7", {}},
				{"empty_20"},
				{"empty_21"}
			}
		},
		[2] = {
			[1] = {
				{"modifier_woda_talent_armor1", "#woda_talent_armor1", 3, "armor1", {}},
				{"modifier_woda_talent_speed1", "#woda_talent_speed1", 2, "speed1", {}},
				{"modifier_woda_talent_attackspeed1", "#woda_talent_attackspeed1", 3, "attackspeed1", {}},
				{"modifier_nevermore_8","#modifier_nevermore_8", 2, "nevermore/8", {}},
				{"modifier_woda_talent_agi3", "#woda_talent_agi3", 2, "agi3", {}}
			},
			[2] = {
				{"empty_2"},
				{"empty_3"},
				{"modifier_nevermore_9","#modifier_nevermore_9", 1, "nevermore/9", {}},
				{"modifier_woda_talent_miss1", "#woda_talent_miss1", 2, "miss1", {}},
				{"modifier_woda_talent_agi6", "#woda_talent_agi6", 1, "agi6", {"modifier_woda_talent_agi3",2}}
			},
			[3] = {
				{"empty_6"},
				{"empty_7"},
				{"modifier_nevermore_10","#modifier_nevermore_10", 3, "nevermore/10", {}},
				{"modifier_woda_talent_mask1", "#woda_talent_mask1", 2, "mask1", {}},
				{"modifier_woda_talent_yasha", "#woda_talent_yasha", 1, "yasha", {"modifier_woda_talent_agi6",1}}
			},
			[4] = {
				{"empty_10"},
				{"modifier_woda_talent_speed2", "#woda_talent_speed2", 3, "speed2", {"modifier_woda_talent_speed1",2}},
				{"modifier_woda_talent_grovebow", "#woda_talent_grovebow", 2, "grovebow", {}},
				{"modifier_nevermore_13","#modifier_nevermore_13", 3, "nevermore/13", {}},			
				{"modifier_woda_talent_agi4", "#woda_talent_agi4", 1, "agi4", {"modifier_woda_talent_yasha",1}}
			},
			[5] = {
				{"modifier_woda_talent_attack2", "#woda_talent_attack2", 3, "attack2", {}},
				{"empty_11"},
				{"modifier_nevermore_21","#modifier_nevermore_21", 1, "nevermore/21", {}},
				{"empty_12"},
				{"modifier_woda_talent_agi5", "#woda_talent_agi5", 3, "agi5", {"modifier_woda_talent_agi4",1}}
			},
			[6] = {
				{"modifier_woda_talent_miss2", "#woda_talent_miss2", 2, "miss2", {}},
				{"empty_13"},
				{"modifier_woda_talent_attackspeed2", "#woda_talent_attackspeed2", 3, "attackspeed2", {}},
				{"modifier_nevermore_11","#modifier_nevermore_11", 3, "nevermore/11", {}},
				{"empty_16"}
			},
			[7] = {
				{"empty_17"},
				{"empty_18"},
				{"modifier_nevermore_14","#modifier_nevermore_14", 1, "nevermore/14", {}},
				{"empty_20"},
				{"empty_21"}
			}
		},
		[3] = {
			[1] = {
				{"modifier_woda_talent_mp1", "#woda_talent_mp1", 3, "mp1", {}},
				{"modifier_woda_talent_regenmp1", "#woda_talent_regenmp1", 2, "regenmp1", {}},
				{"modifier_woda_talent_spell", "#woda_talent_spell", 3, "spell", {}},
				{"modifier_nevermore_15","#modifier_nevermore_15", 3, "nevermore/15", {}},
				{"modifier_woda_talent_int3", "#woda_talent_int3", 2, "int3", {}}
			},
			[2] = {
				{"empty_2"},
				{"empty_3"},
				{"modifier_nevermore_16","#modifier_nevermore_16", 2, "nevermore/16", {}},
				{"modifier_woda_talent_blood", "#woda_talent_blood", 2, "blood", {}},
				{"modifier_woda_talent_int6", "#woda_talent_int6", 1, "int6", {"modifier_woda_talent_int3",2}}
			},
			[3] = {
				{"empty_6"},
				{"empty_7"},
				{"modifier_nevermore_17","#modifier_nevermore_17", 3, "nevermore/17", {"modifier_nevermore_16",2}},
				{"modifier_woda_talent_mask2", "#woda_talent_mask2", 2, "mask2", {}},
				{"modifier_woda_talent_kaya", "#woda_talent_kaya", 1, "kaya", {"modifier_woda_talent_int6",1}}
			},
			[4] = {
				{"modifier_woda_talent_mp2", "#woda_talent_mp2", 3, "mp2", {"modifier_woda_talent_mp1",3}},
				{"modifier_woda_talent_fairy", "#woda_talent_fairy", 2, "fairy", {}},
				{"modifier_nevermore_18","#modifier_nevermore_18", 1, "nevermore/18", {}},
				{"empty_9"},
				{"modifier_woda_talent_int4", "#woda_talent_int4", 1, "int4", {"modifier_woda_talent_kaya",1}}
			},
			[5] = {
				{"modifier_woda_talent_spellprism", "#woda_talent_spellprism", 3, "spellprism", {}},
				{"empty_10"},
				{"empty_11"},
				{"modifier_nevermore_20","#modifier_nevermore_20", 3, "nevermore/20", {}},
				{"modifier_woda_talent_int5", "#woda_talent_int5", 3, "int5", {"modifier_woda_talent_int4",1}}
			},
			[6] = {
				{"modifier_woda_talent_timeless", "#woda_talent_timeless", 2, "timeless", {}},
				{"modifier_woda_talent_regenmp2", "#woda_talent_regenmp2", 3, "regenmp2", {}},
				{"empty_14"},
				{"empty_15"},
				{"modifier_nevermore_19","#modifier_nevermore_19", 1, "nevermore/19", {}}
			},
			[7] = {
				{"empty_17"},
				{"empty_18"},
				{"modifier_nevermore_12","#modifier_nevermore_12", 1, "nevermore/12", {}},
				{"empty_20"},
				{"empty_21"}
			}
		}
	},
	["npc_dota_hero_earthshaker"] = {
		[1] = {
			[1] = {
				{"modifier_woda_talent_hp1", "#woda_talent_hp1", 3, "hp1", {}},
				{"modifier_woda_talent_regenhp1", "#woda_talent_regenhp1", 2, "regenhp1", {}},
				{"modifier_woda_talent_attack1", "#woda_talent_attack1", 3, "attack1", {}},
				{"modifier_earthshaker_1","#modifier_earthshaker_1", 3, "earthshaker/1", {}},
				{"modifier_woda_talent_str3", "#woda_talent_str3", 2, "str3", {}}
			},
			[2] = {
				{"empty_2"},
				{"empty_3"},
				{"modifier_earthshaker_4","#modifier_earthshaker_4", 2, "earthshaker/4", {}},
				{"modifier_woda_talent_cloak", "#woda_talent_cloak", 2, "cloak", {}},
				{"modifier_woda_talent_str6", "#woda_talent_str6", 1, "str6", {"modifier_woda_talent_str3",2}}
			},
			[3] = {
				{"empty_6"},
				{"modifier_woda_talent_quickhp", "#woda_talent_quickhp", 2, "quickhp", {}},
				{"empty_7"},
				{"modifier_earthshaker_3","#modifier_earthshaker_3", 2, "earthshaker/3", {}},
				{"modifier_woda_talent_sasha", "#woda_talent_sasha", 1, "sasha", {"modifier_woda_talent_str6",1}}
			},
			[4] = {
				{"modifier_woda_talent_hp2", "#woda_talent_hp2", 3, "hp2", {"modifier_woda_talent_hp1",3}},
				{"empty_9"},
				{"modifier_earthshaker_6","#modifier_earthshaker_6", 2, "earthshaker/6", {}},
				{"modifier_woda_talent_octar", "#woda_talent_octar", 2, "octar", {}},
				{"modifier_woda_talent_str4", "#woda_talent_str4", 1, "str4", {"modifier_woda_talent_sasha",1}}
			},
			[5] = {
				{"modifier_woda_talent_armor2", "#woda_talent_armor2", 3, "armor2", {}},
				{"modifier_earthshaker_2","#modifier_earthshaker_2", 2, "earthshaker/2", {}},
				{"empty_11"},
				{"empty_10"},
				{"modifier_woda_talent_str5", "#woda_talent_str5", 3, "str5", {"modifier_woda_talent_str4",1}}
			},
			[6] = {
				{"modifier_woda_talent_sliver", "#woda_talent_sliver", 2, "sliver", {}},
				{"modifier_woda_talent_regenhp2", "#woda_talent_regenhp2", 3, "regenhp2", {}},
				{"modifier_earthshaker_5","#modifier_earthshaker_5", 2, "earthshaker/5", {}},
				{"empty_15"},
				{"empty_16"}
			},
			[7] = {
				{"empty_17"},
				{"empty_18"},
				{"modifier_earthshaker_7","#modifier_earthshaker_7", 1, "earthshaker/7", {}},
				{"empty_20"},
				{"empty_21"}
			}
		},
		[2] = {
			[1] = {
				{"modifier_woda_talent_armor1", "#woda_talent_armor1", 3, "armor1", {}},
				{"modifier_woda_talent_speed1", "#woda_talent_speed1", 2, "speed1", {}},
				{"modifier_woda_talent_attackspeed1", "#woda_talent_attackspeed1", 3, "attackspeed1", {}},
				{"modifier_earthshaker_8","#modifier_earthshaker_8", 3, "earthshaker/8", {}},
				{"modifier_woda_talent_agi3", "#woda_talent_agi3", 2, "agi3", {}}
			},
			[2] = {
				{"modifier_earthshaker_11","#modifier_earthshaker_11", 3, "earthshaker/11", {}},
				{"empty_3"},
				{"empty_4"},
				{"modifier_woda_talent_miss1", "#woda_talent_miss1", 2, "miss1", {}},
				{"modifier_woda_talent_agi6", "#woda_talent_agi6", 1, "agi6", {"modifier_woda_talent_agi3",2}}
			},
			[3] = {
				{"modifier_earthshaker_10","#modifier_earthshaker_10", 2, "earthshaker/10", {}},
				{"empty_7"},
				{"empty_8"},
				{"modifier_woda_talent_mask1", "#woda_talent_mask1", 2, "mask1", {}},
				{"modifier_woda_talent_yasha", "#woda_talent_yasha", 1, "yasha", {"modifier_woda_talent_agi6",1}}
			},
			[4] = {
				{"modifier_earthshaker_12","#modifier_earthshaker_12", 1, "earthshaker/12", {}},
				{"modifier_woda_talent_speed2", "#woda_talent_speed2", 3, "speed2", {"modifier_woda_talent_speed1",2}},
				{"modifier_woda_talent_grovebow", "#woda_talent_grovebow", 2, "grovebow", {}},
				{"empty_10"},			
				{"modifier_woda_talent_agi4", "#woda_talent_agi4", 1, "agi4", {"modifier_woda_talent_yasha",1}}
			},
			[5] = {
				{"modifier_woda_talent_attack2", "#woda_talent_attack2", 3, "attack2", {}},
				{"modifier_earthshaker_9","#modifier_earthshaker_9", 2, "earthshaker/9", {}},
				{"empty_11"},
				{"empty_12"},
				{"modifier_woda_talent_agi5", "#woda_talent_agi5", 3, "agi5", {"modifier_woda_talent_agi4",1}}
			},
			[6] = {
				{"modifier_woda_talent_miss2", "#woda_talent_miss2", 2, "miss2", {}},
				{"modifier_earthshaker_13","#modifier_earthshaker_13", 2, "earthshaker/13", {}},
				{"modifier_woda_talent_attackspeed2", "#woda_talent_attackspeed2", 3, "attackspeed2", {}},
				{"empty_15"},
				{"empty_16"}
			},
			[7] = {
				{"empty_17"},
				{"empty_18"},
				{"modifier_earthshaker_14","#modifier_earthshaker_14", 1, "earthshaker/14", {}},
				{"empty_20"},
				{"empty_21"}
			}
		},
		[3] = {
			[1] = {
				{"modifier_woda_talent_mp1", "#woda_talent_mp1", 3, "mp1", {}},
				{"modifier_woda_talent_regenmp1", "#woda_talent_regenmp1", 2, "regenmp1", {}},
				{"modifier_woda_talent_spell", "#woda_talent_spell", 3, "spell", {}},
				{"modifier_earthshaker_15","#modifier_earthshaker_15", 3, "earthshaker/15", {}},
				{"modifier_woda_talent_int3", "#woda_talent_int3", 2, "int3", {}}
			},
			[2] = {
				{"empty_2"},
				{"empty_3"},
				{"modifier_earthshaker_18","#modifier_earthshaker_18", 1, "earthshaker/18", {}},
				{"modifier_woda_talent_blood", "#woda_talent_blood", 2, "blood", {}},
				{"modifier_woda_talent_int6", "#woda_talent_int6", 1, "int6", {"modifier_woda_talent_int3",2}}
			},
			[3] = {
				{"empty_6"},
				{"empty_7"},
				{"modifier_earthshaker_19","#modifier_earthshaker_19", 3, "earthshaker/19", {"modifier_earthshaker_18",1}},
				{"modifier_woda_talent_mask2", "#woda_talent_mask2", 2, "mask2", {}},
				{"modifier_woda_talent_kaya", "#woda_talent_kaya", 1, "kaya", {"modifier_woda_talent_int6",1}}
			},
			[4] = {
				{"modifier_woda_talent_mp2", "#woda_talent_mp2", 3, "mp2", {"modifier_woda_talent_mp1",3}},
				{"modifier_woda_talent_fairy", "#woda_talent_fairy", 2, "fairy", {}},
				{"modifier_earthshaker_20","#modifier_earthshaker_20", 2, "earthshaker/20", {}},
				{"empty_9"},
				{"modifier_woda_talent_int4", "#woda_talent_int4", 1, "int4", {"modifier_woda_talent_kaya",1}}
			},
			[5] = {
				{"modifier_woda_talent_spellprism", "#woda_talent_spellprism", 3, "spellprism", {}},
				{"modifier_earthshaker_16","#modifier_earthshaker_16", 2, "earthshaker/16", {}},
				{"empty_11"},
				{"empty_12"},
				{"modifier_woda_talent_int5", "#woda_talent_int5", 3, "int5", {"modifier_woda_talent_int4",1}}
			},
			[6] = {
				{"modifier_woda_talent_timeless", "#woda_talent_timeless", 2, "timeless", {}},
				{"modifier_woda_talent_regenmp2", "#woda_talent_regenmp2", 3, "regenmp2", {}},
				{"empty_14"},
				{"modifier_earthshaker_17","#modifier_earthshaker_17", 2, "earthshaker/17", {}},
				{"empty_16"}
			},
			[7] = {
				{"empty_17"},
				{"empty_18"},
				{"modifier_earthshaker_21","#modifier_earthshaker_21", 1, "earthshaker/21", {}},
				{"empty_20"},
				{"empty_21"}
			}
		}
	},
	["npc_dota_hero_antimage"] = {
		[1] = {
			[1] = {
				{"modifier_woda_talent_hp1", "#woda_talent_hp1", 3, "hp1", {}},
				{"modifier_woda_talent_regenhp1", "#woda_talent_regenhp1", 2, "regenhp1", {}},
				{"modifier_woda_talent_attack1", "#woda_talent_attack1", 3, "attack1", {}},
				{"modifier_antimage_4","#modifier_antimage_4", 3, "antimage/4", {}},
				{"modifier_woda_talent_str3", "#woda_talent_str3", 2, "str3", {}}
			},
			[2] = {
				{"empty_2"},
				{"empty_3"},
				{"modifier_antimage_1","#modifier_antimage_1", 3, "antimage/1", {}},
				{"modifier_woda_talent_cloak", "#woda_talent_cloak", 2, "cloak", {}},
				{"modifier_woda_talent_str6", "#woda_talent_str6", 1, "str6", {"modifier_woda_talent_str3",2}}
			},
			[3] = {
				{"empty_6"},
				{"modifier_woda_talent_quickhp", "#woda_talent_quickhp", 2, "quickhp", {}},
				{"modifier_antimage_5","#modifier_antimage_5", 2, "antimage/5", {}},
				{"empty_8"},
				{"modifier_woda_talent_sasha", "#woda_talent_sasha", 1, "sasha", {"modifier_woda_talent_str6",1}}
			},
			[4] = {
				{"modifier_woda_talent_hp2", "#woda_talent_hp2", 3, "hp2", {"modifier_woda_talent_hp1",3}},
				{"empty_9"},
				{"modifier_antimage_2","#modifier_antimage_2", 2, "antimage/2", {}},
				{"modifier_woda_talent_octar", "#woda_talent_octar", 2, "octar", {}},
				{"modifier_woda_talent_str4", "#woda_talent_str4", 1, "str4", {"modifier_woda_talent_sasha",1}}
			},
			[5] = {
				{"modifier_woda_talent_armor2", "#woda_talent_armor2", 3, "armor2", {}},
				{"empty_10"},
				{"empty_11"},
				{"modifier_antimage_3","#modifier_antimage_3", 2, "antimage/3", {}},
				{"modifier_woda_talent_str5", "#woda_talent_str5", 3, "str5", {"modifier_woda_talent_str4",1}}
			},
			[6] = {
				{"modifier_woda_talent_sliver", "#woda_talent_sliver", 2, "sliver", {}},
				{"modifier_woda_talent_regenhp2", "#woda_talent_regenhp2", 3, "regenhp2", {}},
				{"empty_14"},
				{"empty_15"},
				{"modifier_antimage_6","#modifier_antimage_6", 1, "antimage/6", {}}
			},
			[7] = {
				{"empty_17"},
				{"empty_18"},
				{"modifier_antimage_7","#modifier_antimage_7", 1, "antimage/7", {}},
				{"empty_20"},
				{"empty_21"}
			}
		},
		[2] = {
			[1] = {
				{"modifier_woda_talent_armor1", "#woda_talent_armor1", 3, "armor1", {}},
				{"modifier_woda_talent_speed1", "#woda_talent_speed1", 2, "speed1", {}},
				{"modifier_woda_talent_attackspeed1", "#woda_talent_attackspeed1", 3, "attackspeed1", {}},
				{"modifier_antimage_8","#modifier_antimage_8", 3, "antimage/8", {}},
				{"modifier_woda_talent_agi3", "#woda_talent_agi3", 2, "agi3", {}}
			},
			[2] = {
				{"modifier_antimage_12","#modifier_antimage_12", 1, "antimage/12", {}},
				{"empty_3"},
				{"empty_4"},
				{"modifier_woda_talent_miss1", "#woda_talent_miss1", 2, "miss1", {}},
				{"modifier_woda_talent_agi6", "#woda_talent_agi6", 1, "agi6", {"modifier_woda_talent_agi3",2}}
			},
			[3] = {
				{"modifier_antimage_13","#modifier_antimage_13", 2, "antimage/13", {"modifier_antimage_12",1}},
				{"empty_7"},
				{"empty_8"},
				{"modifier_woda_talent_mask1", "#woda_talent_mask1", 2, "mask1", {}},
				{"modifier_woda_talent_yasha", "#woda_talent_yasha", 1, "yasha", {"modifier_woda_talent_agi6",1}}
			},
			[4] = {
				{"empty_10"},
				{"modifier_woda_talent_speed2", "#woda_talent_speed2", 3, "speed2", {"modifier_woda_talent_speed1",2}},
				{"modifier_woda_talent_grovebow", "#woda_talent_grovebow", 2, "grovebow", {}},
				{"modifier_antimage_11","#modifier_antimage_11", 3, "antimage/11", {}},			
				{"modifier_woda_talent_agi4", "#woda_talent_agi4", 1, "agi4", {"modifier_woda_talent_yasha",1}}
			},
			[5] = {
				{"modifier_woda_talent_attack2", "#woda_talent_attack2", 3, "attack2", {}},
				{"modifier_antimage_9","#modifier_antimage_9", 2, "antimage/9", {}},
				{"empty_11"},
				{"empty_12"},
				{"modifier_woda_talent_agi5", "#woda_talent_agi5", 3, "agi5", {"modifier_woda_talent_agi4",1}}
			},
			[6] = {
				{"modifier_woda_talent_miss2", "#woda_talent_miss2", 2, "miss2", {}},
				{"empty_14"},
				{"modifier_woda_talent_attackspeed2", "#woda_talent_attackspeed2", 3, "attackspeed2", {}},
				{"empty_15"},
				{"modifier_antimage_10","#modifier_antimage_10", 2, "antimage/10", {}}
			},
			[7] = {
				{"empty_17"},
				{"empty_18"},
				{"modifier_antimage_14","#modifier_antimage_14", 1, "antimage/14", {}},
				{"empty_20"},
				{"empty_21"}
			}
		},
		[3] = {
			[1] = {
				{"modifier_woda_talent_mp1", "#woda_talent_mp1", 3, "mp1", {}},
				{"modifier_woda_talent_regenmp1", "#woda_talent_regenmp1", 2, "regenmp1", {}},
				{"modifier_woda_talent_spell", "#woda_talent_spell", 3, "spell", {}},
				{"modifier_antimage_18","#modifier_antimage_18", 3, "antimage/18", {}},
				{"modifier_woda_talent_int3", "#woda_talent_int3", 2, "int3", {}}
			},
			[2] = {
				{"empty_2"},
				{"modifier_antimage_16","#modifier_antimage_16", 3, "antimage/16", {}},
				{"empty_3"},
				{"modifier_woda_talent_blood", "#woda_talent_blood", 2, "blood", {}},
				{"modifier_woda_talent_int6", "#woda_talent_int6", 1, "int6", {"modifier_woda_talent_int3",2}}
			},
			[3] = {
				{"empty_6"},
				{"empty_7"},
				{"modifier_antimage_15","#modifier_antimage_15", 2, "antimage/15", {}},
				{"modifier_woda_talent_mask2", "#woda_talent_mask2", 2, "mask2", {}},
				{"modifier_woda_talent_kaya", "#woda_talent_kaya", 1, "kaya", {"modifier_woda_talent_int6",1}}
			},
			[4] = {
				{"modifier_woda_talent_mp2", "#woda_talent_mp2", 3, "mp2", {"modifier_woda_talent_mp1",3}},
				{"modifier_woda_talent_fairy", "#woda_talent_fairy", 2, "fairy", {}},
				{"empty_9"},
				{"modifier_antimage_17","#modifier_antimage_17", 2, "antimage/17", {}},
				{"modifier_woda_talent_int4", "#woda_talent_int4", 1, "int4", {"modifier_woda_talent_kaya",1}}
			},
			[5] = {
				{"modifier_woda_talent_spellprism", "#woda_talent_spellprism", 3, "spellprism", {}},
				{"empty_10"},
				{"empty_11"},
				{"modifier_antimage_19","#modifier_antimage_19", 2, "antimage/19", {}},
				{"modifier_woda_talent_int5", "#woda_talent_int5", 3, "int5", {"modifier_woda_talent_int4",1}}
			},
			[6] = {
				{"modifier_woda_talent_timeless", "#woda_talent_timeless", 2, "timeless", {}},
				{"modifier_woda_talent_regenmp2", "#woda_talent_regenmp2", 3, "regenmp2", {}},
				{"modifier_antimage_20","#modifier_antimage_20", 1, "antimage/20", {}},
				{"empty_14"},
				{"empty_16"}
			},
			[7] = {
				{"empty_17"},
				{"empty_18"},
				{"modifier_antimage_21","#modifier_antimage_21", 1, "antimage/21", {}},
				{"empty_20"},
				{"empty_21"}
			}
		}
	},
	["npc_dota_hero_tidehunter"] = {
		[1] = {
			[1] = {
				{"modifier_woda_talent_hp1", "#woda_talent_hp1", 3, "hp1", {}},
				{"modifier_woda_talent_regenhp1", "#woda_talent_regenhp1", 2, "regenhp1", {}},
				{"modifier_woda_talent_attack1", "#woda_talent_attack1", 3, "attack1", {}},
				{"modifier_tidehunter_1","#modifier_tidehunter_1", 3, "tidehunter/1", {}},
				{"modifier_woda_talent_str3", "#woda_talent_str3", 2, "str3", {}}
			},
			[2] = {
				{"empty_2"},
				{"empty_3"},
				{"modifier_tidehunter_16","#modifier_tidehunter_16", 3, "tidehunter/16", {}},
				{"modifier_woda_talent_cloak", "#woda_talent_cloak", 2, "cloak", {}},
				{"modifier_woda_talent_str6", "#woda_talent_str6", 1, "str6", {"modifier_woda_talent_str3",2}}
			},
			[3] = {
				{"empty_6"},
				{"modifier_woda_talent_quickhp", "#woda_talent_quickhp", 2, "quickhp", {}},
				{"empty_7"},
				{"modifier_tidehunter_3","#modifier_tidehunter_3", 1, "tidehunter/3", {}},
				{"modifier_woda_talent_sasha", "#woda_talent_sasha", 1, "sasha", {"modifier_woda_talent_str6",1}}
			},
			[4] = {
				{"modifier_woda_talent_hp2", "#woda_talent_hp2", 3, "hp2", {"modifier_woda_talent_hp1",3}},
				{"empty_9"},
				{"modifier_tidehunter_6","#modifier_tidehunter_6", 2, "tidehunter/6", {}},
				{"modifier_woda_talent_octar", "#woda_talent_octar", 2, "octar", {}},
				{"modifier_woda_talent_str4", "#woda_talent_str4", 1, "str4", {"modifier_woda_talent_sasha",1}}
			},
			[5] = {
				{"modifier_woda_talent_armor2", "#woda_talent_armor2", 3, "armor2", {}},
				{"modifier_tidehunter_5","#modifier_tidehunter_5", 2, "tidehunter/5", {}},
				{"empty_10"},
				{"empty_11"},
				{"modifier_woda_talent_str5", "#woda_talent_str5", 3, "str5", {"modifier_woda_talent_str4",1}}
			},
			[6] = {
				{"modifier_woda_talent_sliver", "#woda_talent_sliver", 2, "sliver", {}},
				{"modifier_woda_talent_regenhp2", "#woda_talent_regenhp2", 3, "regenhp2", {}},
				{"empty_14"},
				{"empty_15"},
				{"modifier_tidehunter_4","#modifier_tidehunter_4", 2, "tidehunter/4", {}}
			},
			[7] = {
				{"empty_17"},
				{"empty_18"},
				{"modifier_tidehunter_7","#modifier_tidehunter_7", 1, "tidehunter/7", {}},
				{"empty_20"},
				{"empty_21"}
			}
		},
		[2] = {
			[1] = {
				{"modifier_woda_talent_armor1", "#woda_talent_armor1", 3, "armor1", {}},
				{"modifier_woda_talent_speed1", "#woda_talent_speed1", 2, "speed1", {}},
				{"modifier_woda_talent_attackspeed1", "#woda_talent_attackspeed1", 3, "attackspeed1", {}},
				{"modifier_tidehunter_8","#modifier_tidehunter_8", 2, "tidehunter/8", {}},
				{"modifier_woda_talent_agi3", "#woda_talent_agi3", 2, "agi3", {}}
			},
			[2] = {
				{"modifier_tidehunter_10","#modifier_tidehunter_10", 1, "tidehunter/10", {}},
				{"empty_3"},
				{"empty_4"},
				{"modifier_woda_talent_miss1", "#woda_talent_miss1", 2, "miss1", {}},
				{"modifier_woda_talent_agi6", "#woda_talent_agi6", 1, "agi6", {"modifier_woda_talent_agi3",2}}
			},
			[3] = {
				{"modifier_tidehunter_12","#modifier_tidehunter_12", 3, "tidehunter/12", {}},
				{"empty_7"},
				{"empty_8"},
				{"modifier_woda_talent_mask1", "#woda_talent_mask1", 2, "mask1", {}},
				{"modifier_woda_talent_yasha", "#woda_talent_yasha", 1, "yasha", {"modifier_woda_talent_agi6",1}}
			},
			[4] = {
				{"empty_10"},
				{"modifier_woda_talent_speed2", "#woda_talent_speed2", 3, "speed2", {"modifier_woda_talent_speed1",2}},
				{"modifier_woda_talent_grovebow", "#woda_talent_grovebow", 2, "grovebow", {}},
				{"modifier_tidehunter_9","#modifier_tidehunter_9", 1, "tidehunter/9", {}},			
				{"modifier_woda_talent_agi4", "#woda_talent_agi4", 1, "agi4", {"modifier_woda_talent_yasha",1}}
			},
			[5] = {
				{"modifier_woda_talent_attack2", "#woda_talent_attack2", 3, "attack2", {}},
				{"empty_11"},
				{"modifier_tidehunter_11","#modifier_tidehunter_11", 3, "tidehunter/11", {}},
				{"empty_12"},
				{"modifier_woda_talent_agi5", "#woda_talent_agi5", 3, "agi5", {"modifier_woda_talent_agi4",1}}
			},
			[6] = {
				{"modifier_woda_talent_miss2", "#woda_talent_miss2", 2, "miss2", {}},
				{"empty_13"},
				{"modifier_woda_talent_attackspeed2", "#woda_talent_attackspeed2", 3, "attackspeed2", {}},
				{"modifier_tidehunter_13","#modifier_tidehunter_13", 3, "tidehunter/13", {}},
				{"empty_16"}
			},
			[7] = {
				{"empty_17"},
				{"empty_18"},
				{"modifier_tidehunter_14","#modifier_tidehunter_14", 1, "tidehunter/14", {}},
				{"empty_20"},
				{"empty_21"}
			}
		},
		[3] = {
			[1] = {
				{"modifier_woda_talent_mp1", "#woda_talent_mp1", 3, "mp1", {}},
				{"modifier_woda_talent_regenmp1", "#woda_talent_regenmp1", 2, "regenmp1", {}},
				{"modifier_woda_talent_spell", "#woda_talent_spell", 3, "spell", {}},
				{"modifier_tidehunter_15","#modifier_tidehunter_15", 3, "tidehunter/15", {}},
				{"modifier_woda_talent_int3", "#woda_talent_int3", 2, "int3", {}}
			},
			[2] = {
				{"empty_2"},
				{"empty_3"},
				{"modifier_tidehunter_17","#modifier_tidehunter_17", 1, "tidehunter/17", {}},
				{"modifier_woda_talent_blood", "#woda_talent_blood", 2, "blood", {}},
				{"modifier_woda_talent_int6", "#woda_talent_int6", 1, "int6", {"modifier_woda_talent_int3",2}}
			},
			[3] = {
				{"empty_6"},
				{"modifier_tidehunter_18","#modifier_tidehunter_18", 3, "tidehunter/18", {}},
				{"empty_7"},
				{"modifier_woda_talent_mask2", "#woda_talent_mask2", 2, "mask2", {}},
				{"modifier_woda_talent_kaya", "#woda_talent_kaya", 1, "kaya", {"modifier_woda_talent_int6",1}}
			},
			[4] = {
				{"modifier_woda_talent_mp2", "#woda_talent_mp2", 3, "mp2", {"modifier_woda_talent_mp1",3}},
				{"modifier_woda_talent_fairy", "#woda_talent_fairy", 2, "fairy", {}},
				{"modifier_tidehunter_19","#modifier_tidehunter_19", 1, "tidehunter/19", {}},
				{"empty_9"},
				{"modifier_woda_talent_int4", "#woda_talent_int4", 1, "int4", {"modifier_woda_talent_kaya",1}}
			},
			[5] = {
				{"modifier_woda_talent_spellprism", "#woda_talent_spellprism", 3, "spellprism", {}},
				{"empty_10"},
				{"modifier_tidehunter_21","#modifier_tidehunter_21", 3, "tidehunter/21", {}},
				{"empty_11"},
				{"modifier_woda_talent_int5", "#woda_talent_int5", 3, "int5", {"modifier_woda_talent_int4",1}}
			},
			[6] = {
				{"modifier_woda_talent_timeless", "#woda_talent_timeless", 2, "timeless", {}},
				{"modifier_woda_talent_regenmp2", "#woda_talent_regenmp2", 3, "regenmp2", {}},
				{"empty_14"},
				{"modifier_tidehunter_20","#modifier_tidehunter_20", 2, "tidehunter/20", {}},
				{"empty_16"}
			},
			[7] = {
				{"empty_17"},
				{"empty_18"},
				{"modifier_tidehunter_22","#modifier_tidehunter_22", 1, "tidehunter/22", {}},
				{"empty_20"},
				{"empty_21"}
			}
		}
	},
	["npc_dota_hero_skywrath_mage"] = {
		[1] = {
			[1] = {
				{"modifier_woda_talent_hp1", "#woda_talent_hp1", 3, "hp1", {}},
				{"modifier_woda_talent_regenhp1", "#woda_talent_regenhp1", 2, "regenhp1", {}},
				{"modifier_woda_talent_attack1", "#woda_talent_attack1", 3, "attack1", {}},
				{"modifier_skywrath_mage_1","#modifier_skywrath_mage_1", 3, "skywrath_mage/1", {}},
				{"modifier_woda_talent_str3", "#woda_talent_str3", 2, "str3", {}}
			},
			[2] = {
				{"empty_2"},
				{"empty_3"},
				{"modifier_skywrath_mage_2","#modifier_skywrath_mage_2", 2, "skywrath_mage/2", {}},
				{"modifier_woda_talent_cloak", "#woda_talent_cloak", 2, "cloak", {}},
				{"modifier_woda_talent_str6", "#woda_talent_str6", 1, "str6", {"modifier_woda_talent_str3",2}}
			},
			[3] = {
				{"empty_6"},
				{"modifier_woda_talent_quickhp", "#woda_talent_quickhp", 2, "quickhp", {}},
				{"modifier_skywrath_mage_4","#modifier_skywrath_mage_4", 1, "skywrath_mage/4", {}},
				{"empty_7"},
				{"modifier_woda_talent_sasha", "#woda_talent_sasha", 1, "sasha", {"modifier_woda_talent_str6",1}}
			},
			[4] = {
				{"modifier_woda_talent_hp2", "#woda_talent_hp2", 3, "hp2", {"modifier_woda_talent_hp1",3}},
				{"empty_9"},
				{"modifier_skywrath_mage_3","#modifier_skywrath_mage_3", 3, "skywrath_mage/3", {}},
				{"modifier_woda_talent_octar", "#woda_talent_octar", 2, "octar", {}},
				{"modifier_woda_talent_str4", "#woda_talent_str4", 1, "str4", {"modifier_woda_talent_sasha",1}}
			},
			[5] = {
				{"modifier_woda_talent_armor2", "#woda_talent_armor2", 3, "armor2", {}},
				{"empty_10"},
				{"empty_11"},
				{"modifier_skywrath_mage_5","#modifier_skywrath_mage_5", 2, "skywrath_mage/5", {}},
				{"modifier_woda_talent_str5", "#woda_talent_str5", 3, "str5", {"modifier_woda_talent_str4",1}}
			},
			[6] = {
				{"modifier_woda_talent_sliver", "#woda_talent_sliver", 2, "sliver", {}},
				{"modifier_woda_talent_regenhp2", "#woda_talent_regenhp2", 3, "regenhp2", {}},
				{"empty_14"},
				{"empty_15"},
				{"modifier_skywrath_mage_6","#modifier_skywrath_mage_6", 2, "skywrath_mage/6", {}}
			},
			[7] = {
				{"empty_17"},
				{"empty_18"},
				{"modifier_skywrath_mage_8","#modifier_skywrath_mage_8", 1, "skywrath_mage/8", {}},
				{"empty_20"},
				{"empty_21"}
			}
		},
		[2] = {
			[1] = {
				{"modifier_woda_talent_armor1", "#woda_talent_armor1", 3, "armor1", {}},
				{"modifier_woda_talent_speed1", "#woda_talent_speed1", 2, "speed1", {}},
				{"modifier_woda_talent_attackspeed1", "#woda_talent_attackspeed1", 3, "attackspeed1", {}},
				{"modifier_skywrath_mage_9","#modifier_skywrath_mage_9", 1, "skywrath_mage/9", {}},
				{"modifier_woda_talent_agi3", "#woda_talent_agi3", 2, "agi3", {}}
			},
			[2] = {
				{"modifier_skywrath_mage_10","#modifier_skywrath_mage_10", 1, "skywrath_mage/10", {}},
				{"empty_3"},
				{"empty_4"},
				{"modifier_woda_talent_miss1", "#woda_talent_miss1", 2, "miss1", {}},
				{"modifier_woda_talent_agi6", "#woda_talent_agi6", 1, "agi6", {"modifier_woda_talent_agi3",2}}
			},
			[3] = {
				{"modifier_skywrath_mage_11","#modifier_skywrath_mage_11", 3, "skywrath_mage/11", {"modifier_skywrath_mage_10",1}},
				{"empty_7"},
				{"empty_8"},
				{"modifier_woda_talent_mask1", "#woda_talent_mask1", 2, "mask1", {}},
				{"modifier_woda_talent_yasha", "#woda_talent_yasha", 1, "yasha", {"modifier_woda_talent_agi6",1}}
			},
			[4] = {
				{"modifier_skywrath_mage_12","#modifier_skywrath_mage_12", 3, "skywrath_mage/12", {"modifier_skywrath_mage_11",3}},
				{"modifier_woda_talent_speed2", "#woda_talent_speed2", 3, "speed2", {"modifier_woda_talent_speed1",2}},
				{"modifier_woda_talent_grovebow", "#woda_talent_grovebow", 2, "grovebow", {}},
				{"empty_10"},			
				{"modifier_woda_talent_agi4", "#woda_talent_agi4", 1, "agi4", {"modifier_woda_talent_yasha",1}}
			},
			[5] = {
				{"modifier_woda_talent_attack2", "#woda_talent_attack2", 3, "attack2", {}},
				{"empty_11"},
				{"empty_12"},
				{"modifier_skywrath_mage_13","#modifier_skywrath_mage_13", 2, "skywrath_mage/13", {}},
				{"modifier_woda_talent_agi5", "#woda_talent_agi5", 3, "agi5", {"modifier_woda_talent_agi4",1}}
			},
			[6] = {
				{"modifier_woda_talent_miss2", "#woda_talent_miss2", 2, "miss2", {}},
				{"empty_13"},
				{"modifier_woda_talent_attackspeed2", "#woda_talent_attackspeed2", 3, "attackspeed2", {}},
				{"modifier_skywrath_mage_14","#modifier_skywrath_mage_14", 3, "skywrath_mage/14", {}},
				{"empty_16"}
			},
			[7] = {
				{"empty_17"},
				{"empty_18"},
				{"modifier_skywrath_mage_15","#modifier_skywrath_mage_15", 1, "skywrath_mage/15", {}},
				{"empty_20"},
				{"empty_21"}
			}
		},
		[3] = {
			[1] = {
				{"modifier_woda_talent_mp1", "#woda_talent_mp1", 3, "mp1", {}},
				{"modifier_woda_talent_regenmp1", "#woda_talent_regenmp1", 2, "regenmp1", {}},
				{"modifier_woda_talent_spell", "#woda_talent_spell", 3, "spell", {}},
				{"modifier_skywrath_mage_16","#modifier_skywrath_mage_16", 2, "skywrath_mage/16", {}},
				{"modifier_woda_talent_int3", "#woda_talent_int3", 2, "int3", {}}
			},
			[2] = {
				{"empty_2"},
				{"empty_3"},
				{"modifier_skywrath_mage_17","#modifier_skywrath_mage_17", 2, "skywrath_mage/17", {}},
				{"modifier_woda_talent_blood", "#woda_talent_blood", 2, "blood", {}},
				{"modifier_woda_talent_int6", "#woda_talent_int6", 1, "int6", {"modifier_woda_talent_int3",2}}
			},
			[3] = {
				{"empty_6"},
				{"empty_7"},
				{"modifier_skywrath_mage_18","#modifier_skywrath_mage_18", 2, "skywrath_mage/18", {}},
				{"modifier_woda_talent_mask2", "#woda_talent_mask2", 2, "mask2", {}},
				{"modifier_woda_talent_kaya", "#woda_talent_kaya", 1, "kaya", {"modifier_woda_talent_int6",1}}
			},
			[4] = {
				{"modifier_woda_talent_mp2", "#woda_talent_mp2", 3, "mp2", {"modifier_woda_talent_mp1",3}},
				{"modifier_woda_talent_fairy", "#woda_talent_fairy", 2, "fairy", {}},
				{"modifier_skywrath_mage_19","#modifier_skywrath_mage_19", 3, "skywrath_mage/19", {}},
				{"empty_9"},
				{"modifier_woda_talent_int4", "#woda_talent_int4", 1, "int4", {"modifier_woda_talent_kaya",1}}
			},
			[5] = {
				{"modifier_woda_talent_spellprism", "#woda_talent_spellprism", 3, "spellprism", {}},
				{"empty_11"},
				{"modifier_skywrath_mage_20","#modifier_skywrath_mage_20", 3, "skywrath_mage/20", {}},
				{"empty_12"},
				{"modifier_woda_talent_int5", "#woda_talent_int5", 3, "int5", {"modifier_woda_talent_int4",1}}
			},
			[6] = {
				{"modifier_woda_talent_timeless", "#woda_talent_timeless", 2, "timeless", {}},
				{"modifier_woda_talent_regenmp2", "#woda_talent_regenmp2", 3, "regenmp2", {}},
				{"modifier_skywrath_mage_22","#modifier_skywrath_mage_22", 1, "skywrath_mage/22", {}},
				{"empty_15"},
				{"empty_16"}
			},
			[7] = {
				{"empty_17"},
				{"empty_18"},
				{"modifier_skywrath_mage_21","#modifier_skywrath_mage_21", 1, "skywrath_mage/21", {}},
				{"empty_20"},
				{"empty_21"}
			}
		}
	},
	["npc_dota_hero_pudge"] = {
		[1] = {
			[1] = {
				{"modifier_woda_talent_hp1", "#woda_talent_hp1", 3, "hp1", {}},
				{"modifier_woda_talent_regenhp1", "#woda_talent_regenhp1", 2, "regenhp1", {}},
				{"modifier_woda_talent_attack1", "#woda_talent_attack1", 3, "attack1", {}},
				{"modifier_pudge_2","#modifier_pudge_2", 2, "pudge/2", {}},
				{"modifier_woda_talent_str3", "#woda_talent_str3", 2, "str3", {}}
			},
			[2] = {
				{"empty_2"},
				{"empty_3"},
				{"modifier_pudge_4","#modifier_pudge_4", 3, "pudge/4", {}},
				{"modifier_woda_talent_cloak", "#woda_talent_cloak", 2, "cloak", {}},
				{"modifier_woda_talent_str6", "#woda_talent_str6", 1, "str6", {"modifier_woda_talent_str3",2}}
			},
			[3] = {
				{"empty_6"},
				{"modifier_woda_talent_quickhp", "#woda_talent_quickhp", 2, "quickhp", {}},
				{"empty_8"},
				{"modifier_pudge_1","#modifier_pudge_1", 3, "pudge/1", {}},
				{"modifier_woda_talent_sasha", "#woda_talent_sasha", 1, "sasha", {"modifier_woda_talent_str6",1}}
			},
			[4] = {
				{"modifier_woda_talent_hp2", "#woda_talent_hp2", 3, "hp2", {"modifier_woda_talent_hp1",3}},
				{"empty_9"},
				{"modifier_pudge_5","#modifier_pudge_5", 2, "pudge/5", {"modifier_pudge_4",3}},
				{"modifier_woda_talent_octar", "#woda_talent_octar", 2, "octar", {}},
				{"modifier_woda_talent_str4", "#woda_talent_str4", 1, "str4", {"modifier_woda_talent_sasha",1}}
			},
			[5] = {
				{"modifier_woda_talent_armor2", "#woda_talent_armor2", 3, "armor2", {}},
				{"empty_10"},
				{"modifier_pudge_3","#modifier_pudge_3", 1, "pudge/3", {"modifier_pudge_5",2}},
				{"empty_11"},
				{"modifier_woda_talent_str5", "#woda_talent_str5", 3, "str5", {"modifier_woda_talent_str4",1}}
			},
			[6] = {
				{"modifier_woda_talent_sliver", "#woda_talent_sliver", 2, "sliver", {}},
				{"modifier_woda_talent_regenhp2", "#woda_talent_regenhp2", 3, "regenhp2", {}},
				{"empty_14"},
				{"empty_15"},
				{"modifier_pudge_6","#modifier_pudge_6", 2, "pudge/6", {}}
			},
			[7] = {
				{"empty_17"},
				{"empty_18"},
				{"modifier_pudge_7","#modifier_pudge_7", 1, "pudge/7", {}},
				{"empty_20"},
				{"empty_21"}
			}
		},
		[2] = {
			[1] = {
				{"modifier_woda_talent_armor1", "#woda_talent_armor1", 3, "armor1", {}},
				{"modifier_woda_talent_speed1", "#woda_talent_speed1", 2, "speed1", {}},
				{"modifier_woda_talent_attackspeed1", "#woda_talent_attackspeed1", 3, "attackspeed1", {}},
				{"modifier_pudge_8","#modifier_pudge_8", 3, "pudge/8", {}},
				{"modifier_woda_talent_agi3", "#woda_talent_agi3", 2, "agi3", {}}
			},
			[2] = {
				{"modifier_pudge_9","#modifier_pudge_9", 2, "pudge/9", {}},
				{"empty_3"},
				{"empty_4"},
				{"modifier_woda_talent_miss1", "#woda_talent_miss1", 2, "miss1", {}},
				{"modifier_woda_talent_agi6", "#woda_talent_agi6", 1, "agi6", {"modifier_woda_talent_agi3",2}}
			},
			[3] = {
				{"empty_6"},
				{"empty_7"},
				{"modifier_pudge_10","#modifier_pudge_10", 3, "pudge/10", {}},
				{"modifier_woda_talent_mask1", "#woda_talent_mask1", 2, "mask1", {}},
				{"modifier_woda_talent_yasha", "#woda_talent_yasha", 1, "yasha", {"modifier_woda_talent_agi6",1}}
			},
			[4] = {
				{"modifier_pudge_11","#modifier_pudge_11", 1, "pudge/11", {}},
				{"modifier_woda_talent_speed2", "#woda_talent_speed2", 3, "speed2", {"modifier_woda_talent_speed1",2}},
				{"modifier_woda_talent_grovebow", "#woda_talent_grovebow", 2, "grovebow", {}},
				{"empty_10"},			
				{"modifier_woda_talent_agi4", "#woda_talent_agi4", 1, "agi4", {"modifier_woda_talent_yasha",1}}
			},
			[5] = {
				{"modifier_woda_talent_attack2", "#woda_talent_attack2", 3, "attack2", {}},
				{"empty_11"},
				{"modifier_pudge_12","#modifier_pudge_12", 3, "pudge/12", {}},
				{"empty_12"},
				{"modifier_woda_talent_agi5", "#woda_talent_agi5", 3, "agi5", {"modifier_woda_talent_agi4",1}}
			},
			[6] = {
				{"modifier_woda_talent_miss2", "#woda_talent_miss2", 2, "miss2", {}},
				{"empty_13"},
				{"modifier_woda_talent_attackspeed2", "#woda_talent_attackspeed2", 3, "attackspeed2", {}},
				{"empty_15"},
				{"modifier_pudge_13","#modifier_pudge_13", 1, "pudge/13", {}}
			},
			[7] = {
				{"empty_17"},
				{"empty_18"},
				{"modifier_pudge_14","#modifier_pudge_14", 1, "pudge/14", {}},
				{"empty_20"},
				{"empty_21"}
			}
		},
		[3] = {
			[1] = {
				{"modifier_woda_talent_mp1", "#woda_talent_mp1", 3, "mp1", {}},
				{"modifier_woda_talent_regenmp1", "#woda_talent_regenmp1", 2, "regenmp1", {}},
				{"modifier_woda_talent_spell", "#woda_talent_spell", 3, "spell", {}},
				{"modifier_pudge_18","#modifier_pudge_18", 3, "pudge/18", {}},
				{"modifier_woda_talent_int3", "#woda_talent_int3", 2, "int3", {}}
			},
			[2] = {
				{"empty_2"},
				{"empty_3"},
				{"modifier_pudge_19","#modifier_pudge_19", 2, "pudge/19", {}},
				{"modifier_woda_talent_blood", "#woda_talent_blood", 2, "blood", {}},
				{"modifier_woda_talent_int6", "#woda_talent_int6", 1, "int6", {"modifier_woda_talent_int3",2}}
			},
			[3] = {
				{"empty_6"},
				{"empty_7"},
				{"modifier_pudge_17","#modifier_pudge_17", 3, "pudge/17", {"modifier_pudge_19",2}},
				{"modifier_woda_talent_mask2", "#woda_talent_mask2", 2, "mask2", {}},
				{"modifier_woda_talent_kaya", "#woda_talent_kaya", 1, "kaya", {"modifier_woda_talent_int6",1}}
			},
			[4] = {
				{"modifier_woda_talent_mp2", "#woda_talent_mp2", 3, "mp2", {"modifier_woda_talent_mp1",3}},
				{"modifier_woda_talent_fairy", "#woda_talent_fairy", 2, "fairy", {}},
				{"modifier_pudge_16","#modifier_pudge_16", 2, "pudge/16", {}},
				{"empty_9"},
				{"modifier_woda_talent_int4", "#woda_talent_int4", 1, "int4", {"modifier_woda_talent_kaya",1}}
			},
			[5] = {
				{"modifier_woda_talent_spellprism", "#woda_talent_spellprism", 3, "spellprism", {}},
				{"empty_10"},
				{"empty_11"},
				{"modifier_pudge_15","#modifier_pudge_15", 2, "pudge/15", {}},
				{"modifier_woda_talent_int5", "#woda_talent_int5", 3, "int5", {"modifier_woda_talent_int4",1}}
			},
			[6] = {
				{"modifier_woda_talent_timeless", "#woda_talent_timeless", 2, "timeless", {}},
				{"modifier_woda_talent_regenmp2", "#woda_talent_regenmp2", 3, "regenmp2", {}},
				{"empty_14"},
				{"empty_15"},
				{"modifier_pudge_20","#modifier_pudge_20", 1, "pudge/20", {}}
			},
			[7] = {
				{"empty_17"},
				{"empty_18"},
				{"modifier_pudge_21","#modifier_pudge_21", 1, "pudge/21", {}},
				{"empty_20"},
				{"empty_21"}
			}
		}
	},
	["npc_dota_hero_bounty_hunter"] = {
		[1] = {
			[1] = {
				{"modifier_woda_talent_hp1", "#woda_talent_hp1", 3, "hp1", {}},
				{"modifier_woda_talent_regenhp1", "#woda_talent_regenhp1", 2, "regenhp1", {}},
				{"modifier_woda_talent_attack1", "#woda_talent_attack1", 3, "attack1", {}},
				{"modifier_bounty_hunter_1","#modifier_bounty_hunter_1", 2, "bounty_hunter/1", {}},
				{"modifier_woda_talent_str3", "#woda_talent_str3", 2, "str3", {}}
			},
			[2] = {
				{"empty_2"},
				{"empty_3"},
				{"modifier_bounty_hunter_17","#modifier_bounty_hunter_17", 2, "bounty_hunter/17", {}},
				{"modifier_woda_talent_cloak", "#woda_talent_cloak", 2, "cloak", {}},
				{"modifier_woda_talent_str6", "#woda_talent_str6", 1, "str6", {"modifier_woda_talent_str3",2}}
			},
			[3] = {
				{"empty_6"},
				{"modifier_woda_talent_quickhp", "#woda_talent_quickhp", 2, "quickhp", {}},
				{"modifier_bounty_hunter_7","#modifier_bounty_hunter_7", 2, "bounty_hunter/7", {}},
				{"empty_7"},
				{"modifier_woda_talent_sasha", "#woda_talent_sasha", 1, "sasha", {"modifier_woda_talent_str6",1}}
			},
			[4] = {
				{"modifier_woda_talent_hp2", "#woda_talent_hp2", 3, "hp2", {"modifier_woda_talent_hp1",3}},
				{"modifier_bounty_hunter_6","#modifier_bounty_hunter_6", 2, "bounty_hunter/6", {}},
				{"empty_9"},
				{"modifier_woda_talent_octar", "#woda_talent_octar", 2, "octar", {}},
				{"modifier_woda_talent_str4", "#woda_talent_str4", 1, "str4", {"modifier_woda_talent_sasha",1}}
			},
			[5] = {
				{"modifier_woda_talent_armor2", "#woda_talent_armor2", 3, "armor2", {}},
				{"empty_11"},
				{"modifier_bounty_hunter_16","#modifier_bounty_hunter_16", 2, "bounty_hunter/16", {}},
				{"empty_12"},
				{"modifier_woda_talent_str5", "#woda_talent_str5", 3, "str5", {"modifier_woda_talent_str4",1}}
			},
			[6] = {
				{"modifier_woda_talent_sliver", "#woda_talent_sliver", 2, "sliver", {}},
				{"modifier_woda_talent_regenhp2", "#woda_talent_regenhp2", 3, "regenhp2", {}},
				{"empty_14"},
				{"empty_15"},
				{"modifier_bounty_hunter_2","#modifier_bounty_hunter_2", 3, "bounty_hunter/2", {}}
			},
			[7] = {
				{"empty_17"},
				{"empty_18"},
				{"modifier_bounty_hunter_5","#modifier_bounty_hunter_5", 1, "bounty_hunter/5", {}},
				{"empty_20"},
				{"empty_21"}
			}
		},
		[2] = {
			[1] = {
				{"modifier_woda_talent_armor1", "#woda_talent_armor1", 3, "armor1", {}},
				{"modifier_woda_talent_speed1", "#woda_talent_speed1", 2, "speed1", {}},
				{"modifier_woda_talent_attackspeed1", "#woda_talent_attackspeed1", 3, "attackspeed1", {}},
				{"modifier_bounty_hunter_8","#modifier_bounty_hunter_8", 2, "bounty_hunter/8", {}},
				{"modifier_woda_talent_agi3", "#woda_talent_agi3", 2, "agi3", {}}
			},
			[2] = {
				{"modifier_bounty_hunter_11","#modifier_bounty_hunter_11", 3, "bounty_hunter/11", {}},
				{"empty_3"},
				{"empty_4"},
				{"modifier_woda_talent_miss1", "#woda_talent_miss1", 2, "miss1", {}},
				{"modifier_woda_talent_agi6", "#woda_talent_agi6", 1, "agi6", {"modifier_woda_talent_agi3",2}}
			},
			[3] = {
				{"modifier_bounty_hunter_10","#modifier_bounty_hunter_10", 2, "bounty_hunter/10", {}},
				{"empty_7"},
				{"empty_8"},
				{"modifier_woda_talent_mask1", "#woda_talent_mask1", 2, "mask1", {}},
				{"modifier_woda_talent_yasha", "#woda_talent_yasha", 1, "yasha", {"modifier_woda_talent_agi6",1}}
			},
			[4] = {
				{"modifier_bounty_hunter_13","#modifier_bounty_hunter_13", 1, "bounty_hunter/13", {}},
				{"modifier_woda_talent_speed2", "#woda_talent_speed2", 3, "speed2", {"modifier_woda_talent_speed1",2}},
				{"modifier_woda_talent_grovebow", "#woda_talent_grovebow", 2, "grovebow", {}},
				{"empty_10"},			
				{"modifier_woda_talent_agi4", "#woda_talent_agi4", 1, "agi4", {"modifier_woda_talent_yasha",1}}
			},
			[5] = {
				{"modifier_woda_talent_attack2", "#woda_talent_attack2", 3, "attack2", {}},
				{"modifier_bounty_hunter_12","#modifier_bounty_hunter_12", 3, "bounty_hunter/12", {}},
				{"empty_11"},
				{"empty_12"},
				{"modifier_woda_talent_agi5", "#woda_talent_agi5", 3, "agi5", {"modifier_woda_talent_agi4",1}}
			},
			[6] = {
				{"modifier_woda_talent_miss2", "#woda_talent_miss2", 2, "miss2", {}},
				{"empty_15"},
				{"modifier_woda_talent_attackspeed2", "#woda_talent_attackspeed2", 3, "attackspeed2", {}},
				{"modifier_bounty_hunter_9","#modifier_bounty_hunter_9", 2, "bounty_hunter/9", {}},
				{"empty_16"}
			},
			[7] = {
				{"empty_17"},
				{"empty_18"},
				{"modifier_bounty_hunter_14","#modifier_bounty_hunter_14", 1, "bounty_hunter/14", {}},
				{"empty_20"},
				{"empty_21"}
			}
		},
		[3] = {
			[1] = {
				{"modifier_woda_talent_mp1", "#woda_talent_mp1", 3, "mp1", {}},
				{"modifier_woda_talent_regenmp1", "#woda_talent_regenmp1", 2, "regenmp1", {}},
				{"modifier_woda_talent_spell", "#woda_talent_spell", 3, "spell", {}},
				{"modifier_bounty_hunter_15","#modifier_bounty_hunter_15", 1, "bounty_hunter/15", {}},
				{"modifier_woda_talent_int3", "#woda_talent_int3", 2, "int3", {}}
			},
			[2] = {
				{"empty_2"},
				{"empty_3"},
				{"modifier_bounty_hunter_4","#modifier_bounty_hunter_4", 3, "bounty_hunter/4", {}},
				{"modifier_woda_talent_blood", "#woda_talent_blood", 2, "blood", {}},
				{"modifier_woda_talent_int6", "#woda_talent_int6", 1, "int6", {"modifier_woda_talent_int3",2}}
			},
			[3] = {
				{"empty_6"},
				{"empty_7"},
				{"modifier_bounty_hunter_20","#modifier_bounty_hunter_20", 2, "bounty_hunter/20", {}},
				{"modifier_woda_talent_mask2", "#woda_talent_mask2", 2, "mask2", {}},
				{"modifier_woda_talent_kaya", "#woda_talent_kaya", 1, "kaya", {"modifier_woda_talent_int6",1}}
			},
			[4] = {
				{"modifier_woda_talent_mp2", "#woda_talent_mp2", 3, "mp2", {"modifier_woda_talent_mp1",3}},
				{"modifier_woda_talent_fairy", "#woda_talent_fairy", 2, "fairy", {}},
				{"empty_9"},
				{"modifier_bounty_hunter_3","#modifier_bounty_hunter_3", 3, "bounty_hunter/3", {}},
				{"modifier_woda_talent_int4", "#woda_talent_int4", 1, "int4", {"modifier_woda_talent_kaya",1}}
			},
			[5] = {
				{"modifier_woda_talent_spellprism", "#woda_talent_spellprism", 3, "spellprism", {}},
				{"empty_10"},
				{"empty_11"},
				{"modifier_bounty_hunter_21","#modifier_bounty_hunter_21", 1, "bounty_hunter/21", {}},
				{"modifier_woda_talent_int5", "#woda_talent_int5", 3, "int5", {"modifier_woda_talent_int4",1}}
			},
			[6] = {
				{"modifier_woda_talent_timeless", "#woda_talent_timeless", 2, "timeless", {}},
				{"modifier_woda_talent_regenmp2", "#woda_talent_regenmp2", 3, "regenmp2", {}},
				{"empty_15"},
				{"empty_16"},
				{"modifier_bounty_hunter_19","#modifier_bounty_hunter_19", 3, "bounty_hunter/19", {}}
			},
			[7] = {
				{"empty_17"},
				{"empty_18"},
				{"modifier_bounty_hunter_18","#modifier_bounty_hunter_18", 1, "bounty_hunter/18", {}},
				{"empty_20"},
				{"empty_21"}
			}
		}
	},
	["npc_dota_hero_furion"] = {
		[1] = {
			[1] = {
				{"modifier_woda_talent_hp1", "#woda_talent_hp1", 3, "hp1", {}},
				{"modifier_woda_talent_regenhp1", "#woda_talent_regenhp1", 2, "regenhp1", {}},
				{"modifier_woda_talent_attack1", "#woda_talent_attack1", 3, "attack1", {}},
				{"modifier_furion_1","#modifier_furion_1", 2, "furion/1", {}},
				{"modifier_woda_talent_str3", "#woda_talent_str3", 2, "str3", {}}
			},
			[2] = {
				{"empty_2"},
				{"empty_3"},
				{"modifier_furion_3","#modifier_furion_3", 3, "furion/3", {}},
				{"modifier_woda_talent_cloak", "#woda_talent_cloak", 2, "cloak", {}},
				{"modifier_woda_talent_str6", "#woda_talent_str6", 1, "str6", {"modifier_woda_talent_str3",2}}
			},
			[3] = {
				{"empty_6"},
				{"modifier_woda_talent_quickhp", "#woda_talent_quickhp", 2, "quickhp", {}},
				{"modifier_furion_2","#modifier_furion_2", 3, "furion/2", {"modifier_furion_3",3}},
				{"empty_8"},
				{"modifier_woda_talent_sasha", "#woda_talent_sasha", 1, "sasha", {"modifier_woda_talent_str6",1}}
			},
			[4] = {
				{"modifier_woda_talent_hp2", "#woda_talent_hp2", 3, "hp2", {"modifier_woda_talent_hp1",3}},
				{"empty_9"},
				{"modifier_furion_4","#modifier_furion_4", 2, "furion/4", {"modifier_furion_2",3}},
				{"modifier_woda_talent_octar", "#woda_talent_octar", 2, "octar", {}},
				{"modifier_woda_talent_str4", "#woda_talent_str4", 1, "str4", {"modifier_woda_talent_sasha",1}}
			},
			[5] = {
				{"modifier_woda_talent_armor2", "#woda_talent_armor2", 3, "armor2", {}},
				{"modifier_furion_6","#modifier_furion_6", 1, "furion/6", {}},
				{"empty_11"},
				{"empty_12"},
				{"modifier_woda_talent_str5", "#woda_talent_str5", 3, "str5", {"modifier_woda_talent_str4",1}}
			},
			[6] = {
				{"modifier_woda_talent_sliver", "#woda_talent_sliver", 2, "sliver", {}},
				{"modifier_woda_talent_regenhp2", "#woda_talent_regenhp2", 3, "regenhp2", {}},
				{"empty_14"},
				{"modifier_furion_5","#modifier_furion_5", 2, "furion/5", {}},
				{"empty_16"}
			},
			[7] = {
				{"empty_17"},
				{"empty_18"},
				{"modifier_furion_7","#modifier_furion_7", 1, "furion/7", {}},
				{"empty_20"},
				{"empty_21"}
			}
		},
		[2] = {
			[1] = {
				{"modifier_woda_talent_armor1", "#woda_talent_armor1", 3, "armor1", {}},
				{"modifier_woda_talent_speed1", "#woda_talent_speed1", 2, "speed1", {}},
				{"modifier_woda_talent_attackspeed1", "#woda_talent_attackspeed1", 3, "attackspeed1", {}},
				{"modifier_furion_9","#modifier_furion_9", 3, "furion/9", {}},
				{"modifier_woda_talent_agi3", "#woda_talent_agi3", 2, "agi3", {}}
			},
			[2] = {
				{"empty_2"},
				{"empty_3"},
				{"modifier_furion_12","#modifier_furion_12", 2, "furion/12", {}},
				{"modifier_woda_talent_miss1", "#woda_talent_miss1", 2, "miss1", {}},
				{"modifier_woda_talent_agi6", "#woda_talent_agi6", 1, "agi6", {"modifier_woda_talent_agi3",2}}
			},
			[3] = {
				{"empty_6"},
				{"empty_7"},
				{"modifier_furion_8","#modifier_furion_8", 2, "furion/8", {}},
				{"modifier_woda_talent_mask1", "#woda_talent_mask1", 2, "mask1", {}},
				{"modifier_woda_talent_yasha", "#woda_talent_yasha", 1, "yasha", {"modifier_woda_talent_agi6",1}}
			},
			[4] = {
				{"modifier_furion_13","#modifier_furion_13", 3, "furion/13", {}},
				{"modifier_woda_talent_speed2", "#woda_talent_speed2", 3, "speed2", {"modifier_woda_talent_speed1",2}},
				{"modifier_woda_talent_grovebow", "#woda_talent_grovebow", 2, "grovebow", {}},
				{"empty_10"},			
				{"modifier_woda_talent_agi4", "#woda_talent_agi4", 1, "agi4", {"modifier_woda_talent_yasha",1}}
			},
			[5] = {
				{"modifier_woda_talent_attack2", "#woda_talent_attack2", 3, "attack2", {}},
				{"empty_11"},
				{"modifier_furion_11","#modifier_furion_11", 1, "furion/11", {}},
				{"empty_12"},
				{"modifier_woda_talent_agi5", "#woda_talent_agi5", 3, "agi5", {"modifier_woda_talent_agi4",1}}
			},
			[6] = {
				{"modifier_woda_talent_miss2", "#woda_talent_miss2", 2, "miss2", {}},
				{"empty_13"},
				{"modifier_woda_talent_attackspeed2", "#woda_talent_attackspeed2", 3, "attackspeed2", {}},
				{"modifier_furion_10","#modifier_furion_10", 2, "furion/10", {}},
				{"empty_16"}
			},
			[7] = {
				{"empty_17"},
				{"empty_18"},
				{"modifier_furion_14","#modifier_furion_14", 1, "furion/14", {}},
				{"empty_20"},
				{"empty_21"}
			}
		},
		[3] = {
			[1] = {
				{"modifier_woda_talent_mp1", "#woda_talent_mp1", 3, "mp1", {}},
				{"modifier_woda_talent_regenmp1", "#woda_talent_regenmp1", 2, "regenmp1", {}},
				{"modifier_woda_talent_spell", "#woda_talent_spell", 3, "spell", {}},
				{"modifier_furion_17","#modifier_furion_17", 1, "furion/17", {}},
				{"modifier_woda_talent_int3", "#woda_talent_int3", 2, "int3", {}}
			},
			[2] = {
				{"empty_2"},
				{"empty_3"},
				{"modifier_furion_15","#modifier_furion_15", 1, "furion/15", {}},
				{"modifier_woda_talent_blood", "#woda_talent_blood", 2, "blood", {}},
				{"modifier_woda_talent_int6", "#woda_talent_int6", 1, "int6", {"modifier_woda_talent_int3",2}}
			},
			[3] = {
				{"empty_6"},
				{"modifier_furion_16","#modifier_furion_16", 3, "furion/16", {}},
				{"empty_7"},
				{"modifier_woda_talent_mask2", "#woda_talent_mask2", 2, "mask2", {}},
				{"modifier_woda_talent_kaya", "#woda_talent_kaya", 1, "kaya", {"modifier_woda_talent_int6",1}}
			},
			[4] = {
				{"modifier_woda_talent_mp2", "#woda_talent_mp2", 3, "mp2", {"modifier_woda_talent_mp1",3}},
				{"modifier_woda_talent_fairy", "#woda_talent_fairy", 2, "fairy", {}},
				{"empty_9"},
				{"modifier_furion_19","#modifier_furion_19", 2, "furion/19", {}},
				{"modifier_woda_talent_int4", "#woda_talent_int4", 1, "int4", {"modifier_woda_talent_kaya",1}}
			},
			[5] = {
				{"modifier_woda_talent_spellprism", "#woda_talent_spellprism", 3, "spellprism", {}},
				{"empty_10"},
				{"empty_11"},
				{"modifier_furion_18","#modifier_furion_18", 3, "furion/18", {}},
				{"modifier_woda_talent_int5", "#woda_talent_int5", 3, "int5", {"modifier_woda_talent_int4",1}}
			},
			[6] = {
				{"modifier_woda_talent_timeless", "#woda_talent_timeless", 2, "timeless", {}},
				{"modifier_woda_talent_regenmp2", "#woda_talent_regenmp2", 3, "regenmp2", {}},
				{"modifier_furion_21","#modifier_furion_21", 3, "furion/21", {}},
				{"empty_14"},
				{"empty_15"}
			},
			[7] = {
				{"empty_17"},
				{"empty_18"},
				{"modifier_furion_20","#modifier_furion_20", 1, "furion/20", {}},
				{"empty_20"},
				{"empty_21"}
			}
		}
	},
	["npc_dota_hero_phantom_assassin"] = {
		[1] = {
			[1] = {
				{"modifier_woda_talent_hp1", "#woda_talent_hp1", 3, "hp1", {}},
				{"modifier_woda_talent_regenhp1", "#woda_talent_regenhp1", 2, "regenhp1", {}},
				{"modifier_woda_talent_attack1", "#woda_talent_attack1", 3, "attack1", {}},
				{"modifier_phantom_assassin_1","#modifier_phantom_assassin_1", 2, "phantom_assassin/1", {}},
				{"modifier_woda_talent_str3", "#woda_talent_str3", 2, "str3", {}}
			},
			[2] = {
				{"empty_2"},
				{"empty_3"},
				{"modifier_phantom_assassin_6","#modifier_phantom_assassin_6", 2, "phantom_assassin/6", {}},
				{"modifier_woda_talent_cloak", "#woda_talent_cloak", 2, "cloak", {}},
				{"modifier_woda_talent_str6", "#woda_talent_str6", 1, "str6", {"modifier_woda_talent_str3",2}}
			},
			[3] = {
				{"empty_6"},
				{"modifier_woda_talent_quickhp", "#woda_talent_quickhp", 2, "quickhp", {}},
				{"empty_7"},
				{"modifier_phantom_assassin_3","#modifier_phantom_assassin_3", 2, "phantom_assassin/3", {}},
				{"modifier_woda_talent_sasha", "#woda_talent_sasha", 1, "sasha", {"modifier_woda_talent_str6",1}}
			},
			[4] = {
				{"modifier_woda_talent_hp2", "#woda_talent_hp2", 3, "hp2", {"modifier_woda_talent_hp1",3}},
				{"empty_9"},
				{"modifier_phantom_assassin_2","#modifier_phantom_assassin_2", 2, "phantom_assassin/2", {"modifier_phantom_assassin_6",2}},
				{"modifier_woda_talent_octar", "#woda_talent_octar", 2, "octar", {}},
				{"modifier_woda_talent_str4", "#woda_talent_str4", 1, "str4", {"modifier_woda_talent_sasha",1}}
			},
			[5] = {
				{"modifier_woda_talent_armor2", "#woda_talent_armor2", 3, "armor2", {}},
				{"modifier_phantom_assassin_5","#modifier_phantom_assassin_5", 3, "phantom_assassin/5", {}},
				{"empty_10"},
				{"empty_11"},
				{"modifier_woda_talent_str5", "#woda_talent_str5", 3, "str5", {"modifier_woda_talent_str4",1}}
			},
			[6] = {
				{"modifier_woda_talent_sliver", "#woda_talent_sliver", 2, "sliver", {}},
				{"modifier_woda_talent_regenhp2", "#woda_talent_regenhp2", 3, "regenhp2", {}},
				{"modifier_phantom_assassin_4","#modifier_phantom_assassin_4", 2, "phantom_assassin/4", {"modifier_phantom_assassin_2",2}},
				{"empty_15"},
				{"empty_16"}
			},
			[7] = {
				{"empty_17"},
				{"empty_18"},
				{"modifier_phantom_assassin_7","#modifier_phantom_assassin_7", 1, "phantom_assassin/7", {}},
				{"empty_20"},
				{"empty_21"}
			}
		},
		[2] = {
			[1] = {
				{"modifier_woda_talent_armor1", "#woda_talent_armor1", 3, "armor1", {}},
				{"modifier_woda_talent_speed1", "#woda_talent_speed1", 2, "speed1", {}},
				{"modifier_woda_talent_attackspeed1", "#woda_talent_attackspeed1", 3, "attackspeed1", {}},
				{"modifier_phantom_assassin_8","#modifier_phantom_assassin_8", 2, "phantom_assassin/8", {}},
				{"modifier_woda_talent_agi3", "#woda_talent_agi3", 2, "agi3", {}}
			},
			[2] = {
				{"empty_2"},
				{"empty_3"},
				{"modifier_phantom_assassin_11","#modifier_phantom_assassin_11", 3, "phantom_assassin/11", {}},
				{"modifier_woda_talent_miss1", "#woda_talent_miss1", 2, "miss1", {}},
				{"modifier_woda_talent_agi6", "#woda_talent_agi6", 1, "agi6", {"modifier_woda_talent_agi3",2}}
			},
			[3] = {
				{"empty_7"},
				{"empty_8"},
				{"modifier_phantom_assassin_12","#modifier_phantom_assassin_12", 2, "phantom_assassin/12", {}},
				{"modifier_woda_talent_mask1", "#woda_talent_mask1", 2, "mask1", {}},
				{"modifier_woda_talent_yasha", "#woda_talent_yasha", 1, "yasha", {"modifier_woda_talent_agi6",1}}
			},
			[4] = {
				{"modifier_phantom_assassin_18","#modifier_phantom_assassin_18", 2, "phantom_assassin/18", {}},
				{"modifier_woda_talent_speed2", "#woda_talent_speed2", 3, "speed2", {"modifier_woda_talent_speed1",2}},
				{"modifier_woda_talent_grovebow", "#woda_talent_grovebow", 2, "grovebow", {}},
				{"empty_10"},			
				{"modifier_woda_talent_agi4", "#woda_talent_agi4", 1, "agi4", {"modifier_woda_talent_yasha",1}}
			},
			[5] = {
				{"modifier_woda_talent_attack2", "#woda_talent_attack2", 3, "attack2", {}},
				{"modifier_phantom_assassin_10","#modifier_phantom_assassin_10", 1, "phantom_assassin/10", {}},
				{"empty_11"},
				{"empty_12"},
				{"modifier_woda_talent_agi5", "#woda_talent_agi5", 3, "agi5", {"modifier_woda_talent_agi4",1}}
			},
			[6] = {
				{"modifier_woda_talent_miss2", "#woda_talent_miss2", 2, "miss2", {}},
				{"empty_13"},
				{"modifier_woda_talent_attackspeed2", "#woda_talent_attackspeed2", 3, "attackspeed2", {}},
				{"empty_15"},
				{"modifier_phantom_assassin_13","#modifier_phantom_assassin_13", 3, "phantom_assassin/13", {}}
			},
			[7] = {
				{"empty_17"},
				{"empty_18"},
				{"modifier_phantom_assassin_14","#modifier_phantom_assassin_14", 1, "phantom_assassin/14", {}},
				{"empty_20"},
				{"empty_21"}
			}
		},
		[3] = {
			[1] = {
				{"modifier_woda_talent_mp1", "#woda_talent_mp1", 3, "mp1", {}},
				{"modifier_woda_talent_regenmp1", "#woda_talent_regenmp1", 2, "regenmp1", {}},
				{"modifier_woda_talent_spell", "#woda_talent_spell", 3, "spell", {}},
				{"modifier_phantom_assassin_15","#modifier_phantom_assassin_15", 2, "phantom_assassin/15", {}},
				{"modifier_woda_talent_int3", "#woda_talent_int3", 2, "int3", {}}
			},
			[2] = {
				{"empty_2"},
				{"empty_3"},
				{"modifier_phantom_assassin_16","#modifier_phantom_assassin_16", 3, "phantom_assassin/16", {}},
				{"modifier_woda_talent_blood", "#woda_talent_blood", 2, "blood", {}},
				{"modifier_woda_talent_int6", "#woda_talent_int6", 1, "int6", {"modifier_woda_talent_int3",2}}
			},
			[3] = {
				{"empty_6"},
				{"empty_7"},
				{"modifier_phantom_assassin_17","#modifier_phantom_assassin_17", 2, "phantom_assassin/17", {"modifier_phantom_assassin_16",3}},
				{"modifier_woda_talent_mask2", "#woda_talent_mask2", 2, "mask2", {}},
				{"modifier_woda_talent_kaya", "#woda_talent_kaya", 1, "kaya", {"modifier_woda_talent_int6",1}}
			},
			[4] = {
				{"modifier_woda_talent_mp2", "#woda_talent_mp2", 3, "mp2", {"modifier_woda_talent_mp1",3}},
				{"modifier_woda_talent_fairy", "#woda_talent_fairy", 2, "fairy", {}},
				{"modifier_phantom_assassin_9","#modifier_phantom_assassin_9", 2, "phantom_assassin/9", {}},
				{"empty_9"},
				{"modifier_woda_talent_int4", "#woda_talent_int4", 1, "int4", {"modifier_woda_talent_kaya",1}}
			},
			[5] = {
				{"modifier_woda_talent_spellprism", "#woda_talent_spellprism", 3, "spellprism", {}},
				{"empty_10"},
				{"empty_11"},
				{"modifier_phantom_assassin_19","#modifier_phantom_assassin_19", 1, "phantom_assassin/19", {}},
				{"modifier_woda_talent_int5", "#woda_talent_int5", 3, "int5", {"modifier_woda_talent_int4",1}}
			},
			[6] = {
				{"modifier_woda_talent_timeless", "#woda_talent_timeless", 2, "timeless", {}},
				{"modifier_woda_talent_regenmp2", "#woda_talent_regenmp2", 3, "regenmp2", {}},
				{"modifier_phantom_assassin_20","#modifier_phantom_assassin_20", 3, "phantom_assassin/20", {}},
				{"empty_15"},
				{"empty_16"}
			},
			[7] = {
				{"empty_17"},
				{"empty_18"},
				{"modifier_phantom_assassin_21","#modifier_phantom_assassin_21", 1, "phantom_assassin/21", {}},
				{"empty_20"},
				{"empty_21"}
			}
		}
	},
	["npc_dota_hero_death_prophet"] = {
		[1] = {
			[1] = {
				{"modifier_woda_talent_hp1", "#woda_talent_hp1", 3, "hp1", {}},
				{"modifier_woda_talent_regenhp1", "#woda_talent_regenhp1", 2, "regenhp1", {}},
				{"modifier_death_prophet_1","#modifier_death_prophet_1", 3, "death_prophet/1", {}},
				{"modifier_woda_talent_attack1", "#woda_talent_attack1", 3, "attack1", {}},
				{"modifier_woda_talent_str3", "#woda_talent_str3", 2, "str3", {}}
			},
			[2] = {
				{"empty_2"},
				{"empty_3"},
				{"modifier_death_prophet_2","#modifier_death_prophet_2", 2, "death_prophet/2", {}},
				{"modifier_woda_talent_cloak", "#woda_talent_cloak", 2, "cloak", {}},
				{"modifier_woda_talent_str6", "#woda_talent_str6", 1, "str6", {"modifier_woda_talent_str3",2}}
			},
			[3] = {
				{"empty_6"},
				{"modifier_woda_talent_quickhp", "#woda_talent_quickhp", 2, "quickhp", {}},
				{"modifier_death_prophet_3","#modifier_death_prophet_3", 2, "death_prophet/3", {}},
				{"empty_8"},
				{"modifier_woda_talent_sasha", "#woda_talent_sasha", 1, "sasha", {"modifier_woda_talent_str6",1}}
			},
			[4] = {
				{"modifier_woda_talent_hp2", "#woda_talent_hp2", 3, "hp2", {"modifier_woda_talent_hp1",3}},
				{"empty_9"},
				{"modifier_death_prophet_5","#modifier_death_prophet_5", 2, "death_prophet/5", {}},
				{"modifier_woda_talent_octar", "#woda_talent_octar", 2, "octar", {}},
				{"modifier_woda_talent_str4", "#woda_talent_str4", 1, "str4", {"modifier_woda_talent_sasha",1}}
			},
			[5] = {
				{"modifier_woda_talent_armor2", "#woda_talent_armor2", 3, "armor2", {}},
				{"empty_10"},
				{"modifier_death_prophet_4","#modifier_death_prophet_4", 2, "death_prophet/4", {}},
				{"empty_11"},
				{"modifier_woda_talent_str5", "#woda_talent_str5", 3, "str5", {"modifier_woda_talent_str4",1}}
			},
			[6] = {
				{"modifier_woda_talent_sliver", "#woda_talent_sliver", 2, "sliver", {}},
				{"modifier_woda_talent_regenhp2", "#woda_talent_regenhp2", 3, "regenhp2", {}},
				{"modifier_death_prophet_6","#modifier_death_prophet_6", 2, "death_prophet/6", {}},
				{"empty_15"},
				{"empty_16"}
			},
			[7] = {
				{"empty_17"},
				{"empty_18"},
				{"modifier_death_prophet_7","#modifier_death_prophet_7", 1, "death_prophet/7", {}},
				{"empty_20"},
				{"empty_21"}
			}
		},
		[2] = {
			[1] = {
				{"modifier_woda_talent_armor1", "#woda_talent_armor1", 3, "armor1", {}},
				{"modifier_woda_talent_speed1", "#woda_talent_speed1", 2, "speed1", {}},
				{"modifier_woda_talent_attackspeed1", "#woda_talent_attackspeed1", 3, "attackspeed1", {}},
				{"modifier_death_prophet_8","#modifier_death_prophet_8", 3, "death_prophet/8", {}},
				{"modifier_woda_talent_agi3", "#woda_talent_agi3", 2, "agi3", {}}
			},
			[2] = {
				{"modifier_death_prophet_9","#modifier_death_prophet_9", 1, "death_prophet/9", {}},
				{"empty_3"},
				{"empty_4"},
				{"modifier_woda_talent_miss1", "#woda_talent_miss1", 2, "miss1", {}},
				{"modifier_woda_talent_agi6", "#woda_talent_agi6", 1, "agi6", {"modifier_woda_talent_agi3",2}}
			},
			[3] = {
				{"modifier_death_prophet_10","#modifier_death_prophet_10", 2, "death_prophet/10", {"modifier_death_prophet_9",1}},
				{"empty_7"},
				{"empty_8"},
				{"modifier_woda_talent_mask1", "#woda_talent_mask1", 2, "mask1", {}},
				{"modifier_woda_talent_yasha", "#woda_talent_yasha", 1, "yasha", {"modifier_woda_talent_agi6",1}}
			},
			[4] = {
				{"empty_10"},
				{"modifier_woda_talent_speed2", "#woda_talent_speed2", 3, "speed2", {"modifier_woda_talent_speed1",2}},
				{"modifier_woda_talent_grovebow", "#woda_talent_grovebow", 2, "grovebow", {}},
				{"modifier_death_prophet_11","#modifier_death_prophet_11", 2, "death_prophet/11", {}},			
				{"modifier_woda_talent_agi4", "#woda_talent_agi4", 1, "agi4", {"modifier_woda_talent_yasha",1}}
			},
			[5] = {
				{"modifier_woda_talent_attack2", "#woda_talent_attack2", 3, "attack2", {}},
				{"empty_11"},
				{"empty_12"},
				{"modifier_death_prophet_12","#modifier_death_prophet_12", 3, "death_prophet/12", {}},
				{"modifier_woda_talent_agi5", "#woda_talent_agi5", 3, "agi5", {"modifier_woda_talent_agi4",1}}
			},
			[6] = {
				{"modifier_woda_talent_miss2", "#woda_talent_miss2", 2, "miss2", {}},
				{"empty_13"},
				{"modifier_woda_talent_attackspeed2", "#woda_talent_attackspeed2", 3, "attackspeed2", {}},
				{"empty_15"},
				{"modifier_death_prophet_13","#modifier_death_prophet_13", 2, "death_prophet/13", {}}
			},
			[7] = {
				{"empty_17"},
				{"empty_18"},
				{"modifier_death_prophet_14","#modifier_death_prophet_14", 1, "death_prophet/14", {}},
				{"empty_20"},
				{"empty_21"}
			}
		},
		[3] = {
			[1] = {
				{"modifier_woda_talent_mp1", "#woda_talent_mp1", 3, "mp1", {}},
				{"modifier_woda_talent_regenmp1", "#woda_talent_regenmp1", 2, "regenmp1", {}},
				{"modifier_woda_talent_spell", "#woda_talent_spell", 3, "spell", {}},
				{"modifier_death_prophet_15","#modifier_death_prophet_15", 1, "death_prophet/15", {}},
				{"modifier_woda_talent_int3", "#woda_talent_int3", 2, "int3", {}}
			},
			[2] = {
				{"empty_2"},
				{"modifier_death_prophet_16","#modifier_death_prophet_16", 2, "death_prophet/16", {}},
				{"empty_3"},
				{"modifier_woda_talent_blood", "#woda_talent_blood", 2, "blood", {}},
				{"modifier_woda_talent_int6", "#woda_talent_int6", 1, "int6", {"modifier_woda_talent_int3",2}}
			},
			[3] = {
				{"empty_6"},
				{"empty_7"},
				{"modifier_death_prophet_19","#modifier_death_prophet_19", 3, "death_prophet/19", {}},
				{"modifier_woda_talent_mask2", "#woda_talent_mask2", 2, "mask2", {}},
				{"modifier_woda_talent_kaya", "#woda_talent_kaya", 1, "kaya", {"modifier_woda_talent_int6",1}}
			},
			[4] = {
				{"modifier_woda_talent_mp2", "#woda_talent_mp2", 3, "mp2", {"modifier_woda_talent_mp1",3}},
				{"modifier_woda_talent_fairy", "#woda_talent_fairy", 2, "fairy", {}},
				{"modifier_death_prophet_20","#modifier_death_prophet_20", 2, "death_prophet/20", {}},
				{"empty_9"},
				{"modifier_woda_talent_int4", "#woda_talent_int4", 1, "int4", {"modifier_woda_talent_kaya",1}}
			},
			[5] = {
				{"modifier_woda_talent_spellprism", "#woda_talent_spellprism", 3, "spellprism", {}},
				{"empty_10"},
				{"empty_12"},
				{"modifier_death_prophet_17","#modifier_death_prophet_17", 2, "death_prophet/17", {}},
				{"modifier_woda_talent_int5", "#woda_talent_int5", 3, "int5", {"modifier_woda_talent_int4",1}}
			},
			[6] = {
				{"modifier_woda_talent_timeless", "#woda_talent_timeless", 2, "timeless", {}},
				{"modifier_woda_talent_regenmp2", "#woda_talent_regenmp2", 3, "regenmp2", {}},
				{"empty_14"},
				{"empty_15"},
				{"modifier_death_prophet_18","#modifier_death_prophet_18", 3, "death_prophet/18", {}}
			},
			[7] = {
				{"empty_17"},
				{"empty_18"},
				{"modifier_death_prophet_21","#modifier_death_prophet_21", 1, "death_prophet/21", {}},
				{"empty_20"},
				{"empty_21"}
			}
		}
	},
	["npc_dota_hero_doom_bringer"] = {
		[1] = {
			[1] = {
				{"modifier_woda_talent_hp1", "#woda_talent_hp1", 3, "hp1", {}},
				{"modifier_woda_talent_regenhp1", "#woda_talent_regenhp1", 2, "regenhp1", {}},
				{"modifier_woda_talent_attack1", "#woda_talent_attack1", 3, "attack1", {}},
				{"modifier_doom_bringer_1","#modifier_doom_bringer_1", 2, "doom_bringer/1", {}},
				{"modifier_woda_talent_str3", "#woda_talent_str3", 2, "str3", {}}
			},
			[2] = {
				{"empty_2"},
				{"empty_3"},
				{"modifier_doom_bringer_2","#modifier_doom_bringer_2", 3, "doom_bringer/2", {}},
				{"modifier_woda_talent_cloak", "#woda_talent_cloak", 2, "cloak", {}},
				{"modifier_woda_talent_str6", "#woda_talent_str6", 1, "str6", {"modifier_woda_talent_str3",2}}
			},
			[3] = {
				{"empty_6"},
				{"modifier_woda_talent_quickhp", "#woda_talent_quickhp", 2, "quickhp", {}},
				{"modifier_doom_bringer_3","#modifier_doom_bringer_3", 1, "doom_bringer/3", {}},
				{"empty_8"},
				{"modifier_woda_talent_sasha", "#woda_talent_sasha", 1, "sasha", {"modifier_woda_talent_str6",1}}
			},
			[4] = {
				{"modifier_woda_talent_hp2", "#woda_talent_hp2", 3, "hp2", {"modifier_woda_talent_hp1",3}},
				{"modifier_doom_bringer_4","#modifier_doom_bringer_4", 3, "doom_bringer/4", {}},
				{"empty_9"},
				{"modifier_woda_talent_octar", "#woda_talent_octar", 2, "octar", {}},
				{"modifier_woda_talent_str4", "#woda_talent_str4", 1, "str4", {"modifier_woda_talent_sasha",1}}
			},
			[5] = {
				{"modifier_woda_talent_armor2", "#woda_talent_armor2", 3, "armor2", {}},
				{"modifier_doom_bringer_5","#modifier_doom_bringer_5", 3, "doom_bringer/5", {}},
				{"empty_10"},
				{"empty_11"},
				{"modifier_woda_talent_str5", "#woda_talent_str5", 3, "str5", {"modifier_woda_talent_str4",1}}
			},
			[6] = {
				{"modifier_woda_talent_sliver", "#woda_talent_sliver", 2, "sliver", {}},
				{"modifier_woda_talent_regenhp2", "#woda_talent_regenhp2", 3, "regenhp2", {}},
				{"modifier_doom_bringer_6","#modifier_doom_bringer_6", 1, "doom_bringer/6", {}},
				{"empty_15"},
				{"empty_16"}
			},
			[7] = {
				{"empty_17"},
				{"empty_18"},
				{"modifier_doom_bringer_7","#modifier_doom_bringer_7", 1, "doom_bringer/7", {}},
				{"empty_20"},
				{"empty_21"}
			}
		},
		[2] = {
			[1] = {
				{"modifier_woda_talent_armor1", "#woda_talent_armor1", 3, "armor1", {}},
				{"modifier_woda_talent_speed1", "#woda_talent_speed1", 2, "speed1", {}},
				{"modifier_woda_talent_attackspeed1", "#woda_talent_attackspeed1", 3, "attackspeed1", {}},
				{"modifier_doom_bringer_8","#modifier_doom_bringer_8", 2, "doom_bringer/8", {}},
				{"modifier_woda_talent_agi3", "#woda_talent_agi3", 2, "agi3", {}}
			},
			[2] = {
				{"empty_2"},
				{"empty_3"},
				{"modifier_doom_bringer_9","#modifier_doom_bringer_9", 2, "doom_bringer/9", {}},
				{"modifier_woda_talent_miss1", "#woda_talent_miss1", 2, "miss1", {}},
				{"modifier_woda_talent_agi6", "#woda_talent_agi6", 1, "agi6", {"modifier_woda_talent_agi3",2}}
			},
			[3] = {
				{"modifier_doom_bringer_13","#modifier_doom_bringer_13", 3, "doom_bringer/13", {}},
				{"empty_7"},
				{"empty_8"},
				{"modifier_woda_talent_mask1", "#woda_talent_mask1", 2, "mask1", {}},
				{"modifier_woda_talent_yasha", "#woda_talent_yasha", 1, "yasha", {"modifier_woda_talent_agi6",1}}
			},
			[4] = {
				{"modifier_doom_bringer_11","#modifier_doom_bringer_11", 2, "doom_bringer/11", {}},
				{"modifier_woda_talent_speed2", "#woda_talent_speed2", 3, "speed2", {"modifier_woda_talent_speed1",2}},
				{"modifier_woda_talent_grovebow", "#woda_talent_grovebow", 2, "grovebow", {}},
				{"empty_10"},			
				{"modifier_woda_talent_agi4", "#woda_talent_agi4", 1, "agi4", {"modifier_woda_talent_yasha",1}}
			},
			[5] = {
				{"modifier_woda_talent_attack2", "#woda_talent_attack2", 3, "attack2", {}},
				{"modifier_doom_bringer_10","#modifier_doom_bringer_10", 2, "doom_bringer/10", {}},
				{"empty_11"},
				{"empty_12"},
				{"modifier_woda_talent_agi5", "#woda_talent_agi5", 3, "agi5", {"modifier_woda_talent_agi4",1}}
			},
			[6] = {
				{"modifier_woda_talent_miss2", "#woda_talent_miss2", 2, "miss2", {}},
				{"modifier_doom_bringer_12","#modifier_doom_bringer_12", 2, "doom_bringer/12", {}},
				{"modifier_woda_talent_attackspeed2", "#woda_talent_attackspeed2", 3, "attackspeed2", {}},
				{"empty_15"},
				{"empty_16"}
			},
			[7] = {
				{"empty_17"},
				{"empty_18"},
				{"modifier_doom_bringer_14","#modifier_doom_bringer_14", 1, "doom_bringer/14", {}},
				{"empty_20"},
				{"empty_21"}
			}
		},
		[3] = {
			[1] = {
				{"modifier_woda_talent_mp1", "#woda_talent_mp1", 3, "mp1", {}},
				{"modifier_woda_talent_regenmp1", "#woda_talent_regenmp1", 2, "regenmp1", {}},
				{"modifier_woda_talent_spell", "#woda_talent_spell", 3, "spell", {}},
				{"modifier_doom_bringer_16","#modifier_doom_bringer_16", 2, "doom_bringer/16", {}},
				{"modifier_woda_talent_int3", "#woda_talent_int3", 2, "int3", {}}
			},
			[2] = {
				{"empty_2"},
				{"empty_3"},
				{"modifier_doom_bringer_20","#modifier_doom_bringer_20", 3, "doom_bringer/20", {}},
				{"modifier_woda_talent_blood", "#woda_talent_blood", 2, "blood", {}},
				{"modifier_woda_talent_int6", "#woda_talent_int6", 1, "int6", {"modifier_woda_talent_int3",2}}
			},
			[3] = {
				{"empty_6"},
				{"empty_7"},
				{"modifier_doom_bringer_15","#modifier_doom_bringer_15", 3, "doom_bringer/15", {}},
				{"modifier_woda_talent_mask2", "#woda_talent_mask2", 2, "mask2", {}},
				{"modifier_woda_talent_kaya", "#woda_talent_kaya", 1, "kaya", {"modifier_woda_talent_int6",1}}
			},
			[4] = {
				{"modifier_woda_talent_mp2", "#woda_talent_mp2", 3, "mp2", {"modifier_woda_talent_mp1",3}},
				{"modifier_woda_talent_fairy", "#woda_talent_fairy", 2, "fairy", {}},
				{"modifier_doom_bringer_17","#modifier_doom_bringer_17", 1, "doom_bringer/17", {}},
				{"empty_9"},
				{"modifier_woda_talent_int4", "#woda_talent_int4", 1, "int4", {"modifier_woda_talent_kaya",1}}
			},
			[5] = {
				{"modifier_woda_talent_spellprism", "#woda_talent_spellprism", 3, "spellprism", {}},
				{"empty_11"},
				{"modifier_doom_bringer_18","#modifier_doom_bringer_18", 2, "doom_bringer/18", {}},
				{"empty_12"},
				{"modifier_woda_talent_int5", "#woda_talent_int5", 3, "int5", {"modifier_woda_talent_int4",1}}
			},
			[6] = {
				{"modifier_woda_talent_timeless", "#woda_talent_timeless", 2, "timeless", {}},
				{"modifier_woda_talent_regenmp2", "#woda_talent_regenmp2", 3, "regenmp2", {}},
				{"modifier_doom_bringer_19","#modifier_doom_bringer_19", 2, "doom_bringer/19", {}},
				{"empty_15"},
				{"empty_16"}
			},
			[7] = {
				{"empty_17"},
				{"empty_18"},
				{"modifier_doom_bringer_21","#modifier_doom_bringer_21", 1, "doom_bringer/21", {}},
				{"empty_20"},
				{"empty_21"}
			}
		}
	},
	["npc_dota_hero_invoker"] = {
		[1] = {
			[1] = {
				{"modifier_woda_talent_hp1", "#woda_talent_hp1", 3, "hp1", {}},
				{"modifier_woda_talent_regenhp1", "#woda_talent_regenhp1", 2, "regenhp1", {}},
				{"modifier_woda_talent_attack1", "#woda_talent_attack1", 3, "attack1", {}},
				{"modifier_invoker_2","#modifier_invoker_2", 1, "invoker/2", {}},
				{"modifier_woda_talent_str3", "#woda_talent_str3", 2, "str3", {}}
			},
			[2] = {
				{"empty_2"},
				{"empty_3"},
				{"modifier_invoker_3","#modifier_invoker_3", 3, "invoker/3", {}},
				{"modifier_woda_talent_cloak", "#woda_talent_cloak", 2, "cloak", {}},
				{"modifier_woda_talent_str6", "#woda_talent_str6", 1, "str6", {"modifier_woda_talent_str3",2}}
			},
			[3] = {
				{"empty_6"},
				{"modifier_woda_talent_quickhp", "#woda_talent_quickhp", 2, "quickhp", {}},
				{"empty_7"},
				{"modifier_invoker_6","#modifier_invoker_6", 1, "invoker/6", {}},
				{"modifier_woda_talent_sasha", "#woda_talent_sasha", 1, "sasha", {"modifier_woda_talent_str6",1}}
			},
			[4] = {
				{"modifier_woda_talent_hp2", "#woda_talent_hp2", 3, "hp2", {"modifier_woda_talent_hp1",3}},
				{"empty_9"},
				{"modifier_invoker_4","#modifier_invoker_4", 3, "invoker/4", {}},
				{"modifier_woda_talent_octar", "#woda_talent_octar", 2, "octar", {}},
				{"modifier_woda_talent_str4", "#woda_talent_str4", 1, "str4", {"modifier_woda_talent_sasha",1}}
			},
			[5] = {
				{"modifier_woda_talent_armor2", "#woda_talent_armor2", 3, "armor2", {}},
				{"modifier_invoker_1","#modifier_invoker_1", 3, "invoker/1", {}},
				{"empty_10"},
				{"empty_11"},
				{"modifier_woda_talent_str5", "#woda_talent_str5", 3, "str5", {"modifier_woda_talent_str4",1}}
			},
			[6] = {
				{"modifier_woda_talent_sliver", "#woda_talent_sliver", 2, "sliver", {}},
				{"modifier_woda_talent_regenhp2", "#woda_talent_regenhp2", 3, "regenhp2", {}},
				{"modifier_invoker_5","#modifier_invoker_5", 2, "invoker/5", {}},
				{"empty_15"},
				{"empty_16"}
			},
			[7] = {
				{"empty_17"},
				{"empty_18"},
				{"modifier_invoker_7","#modifier_invoker_7", 1, "invoker/7", {}},
				{"empty_20"},
				{"empty_21"}
			}
		},
		[2] = {
			[1] = {
				{"modifier_woda_talent_armor1", "#woda_talent_armor1", 3, "armor1", {}},
				{"modifier_woda_talent_speed1", "#woda_talent_speed1", 2, "speed1", {}},
				{"modifier_woda_talent_attackspeed1", "#woda_talent_attackspeed1", 3, "attackspeed1", {}},
				{"modifier_invoker_12","#modifier_invoker_12", 2, "invoker/12", {}},
				{"modifier_woda_talent_agi3", "#woda_talent_agi3", 2, "agi3", {}}
			},
			[2] = {
				{"modifier_invoker_9","#modifier_invoker_9", 2, "invoker/9", {}},
				{"empty_2"},
				{"empty_3"},
				{"modifier_woda_talent_miss1", "#woda_talent_miss1", 2, "miss1", {}},
				{"modifier_woda_talent_agi6", "#woda_talent_agi6", 1, "agi6", {"modifier_woda_talent_agi3",2}}
			},
			[3] = {
				{"empty_6"},
				{"empty_7"},
				{"modifier_invoker_8","#modifier_invoker_8", 3, "invoker/8", {}},
				{"modifier_woda_talent_mask1", "#woda_talent_mask1", 2, "mask1", {}},
				{"modifier_woda_talent_yasha", "#woda_talent_yasha", 1, "yasha", {"modifier_woda_talent_agi6",1}}
			},
			[4] = {
				{"modifier_invoker_11","#modifier_invoker_11", 2, "invoker/11", {}},
				{"modifier_woda_talent_speed2", "#woda_talent_speed2", 3, "speed2", {"modifier_woda_talent_speed1",2}},
				{"modifier_woda_talent_grovebow", "#woda_talent_grovebow", 2, "grovebow", {}},
				{"empty_9"},			
				{"modifier_woda_talent_agi4", "#woda_talent_agi4", 1, "agi4", {"modifier_woda_talent_yasha",1}}
			},
			[5] = {
				{"modifier_woda_talent_attack2", "#woda_talent_attack2", 3, "attack2", {}},
				{"empty_11"},
				{"empty_12"},
				{"modifier_invoker_13","#modifier_invoker_13", 2, "invoker/13", {}},
				{"modifier_woda_talent_agi5", "#woda_talent_agi5", 3, "agi5", {"modifier_woda_talent_agi4",1}}
			},
			[6] = {
				{"modifier_woda_talent_miss2", "#woda_talent_miss2", 2, "miss2", {}},
				{"empty_13"},
				{"modifier_woda_talent_attackspeed2", "#woda_talent_attackspeed2", 3, "attackspeed2", {}},
				{"empty_16"},
				{"modifier_invoker_10","#modifier_invoker_10", 2, "invoker/10", {}}
			},
			[7] = {
				{"empty_17"},
				{"empty_18"},
				{"modifier_invoker_14","#modifier_invoker_14", 1, "invoker/14", {}},
				{"empty_20"},
				{"empty_21"}
			}
		},
		[3] = {
			[1] = {
				{"modifier_woda_talent_mp1", "#woda_talent_mp1", 3, "mp1", {}},
				{"modifier_woda_talent_regenmp1", "#woda_talent_regenmp1", 2, "regenmp1", {}},
				{"modifier_woda_talent_spell", "#woda_talent_spell", 3, "spell", {}},
				{"modifier_invoker_17","#modifier_invoker_17", 2, "invoker/17", {}},
				{"modifier_woda_talent_int3", "#woda_talent_int3", 2, "int3", {}}
			},
			[2] = {
				{"empty_2"},
				{"modifier_invoker_16","#modifier_invoker_16", 3, "invoker/16", {}},
				{"empty_3"},
				{"modifier_woda_talent_blood", "#woda_talent_blood", 2, "blood", {}},
				{"modifier_woda_talent_int6", "#woda_talent_int6", 1, "int6", {"modifier_woda_talent_int3",2}}
			},
			[3] = {
				{"empty_6"},
				{"modifier_invoker_15","#modifier_invoker_15", 3, "invoker/15", {}},
				{"empty_7"},
				{"modifier_woda_talent_mask2", "#woda_talent_mask2", 2, "mask2", {}},
				{"modifier_woda_talent_kaya", "#woda_talent_kaya", 1, "kaya", {"modifier_woda_talent_int6",1}}
			},
			[4] = {
				{"modifier_woda_talent_mp2", "#woda_talent_mp2", 3, "mp2", {"modifier_woda_talent_mp1",3}},
				{"modifier_woda_talent_fairy", "#woda_talent_fairy", 2, "fairy", {}},
				{"modifier_invoker_19","#modifier_invoker_19", 2, "invoker/19", {}},
				{"empty_9"},
				{"modifier_woda_talent_int4", "#woda_talent_int4", 1, "int4", {"modifier_woda_talent_kaya",1}}
			},
			[5] = {
				{"modifier_woda_talent_spellprism", "#woda_talent_spellprism", 3, "spellprism", {}},
				{"empty_11"},
				{"modifier_invoker_18","#modifier_invoker_18", 2, "invoker/18", {}},
				{"empty_12"},
				{"modifier_woda_talent_int5", "#woda_talent_int5", 3, "int5", {"modifier_woda_talent_int4",1}}
			},
			[6] = {
				{"modifier_woda_talent_timeless", "#woda_talent_timeless", 2, "timeless", {}},
				{"modifier_woda_talent_regenmp2", "#woda_talent_regenmp2", 3, "regenmp2", {}},
				{"empty_14"},
				{"empty_15"},
				{"modifier_invoker_20","#modifier_invoker_20", 1, "invoker/20", {}}
			},
			[7] = {
				{"empty_17"},
				{"empty_18"},
				{"modifier_invoker_21","#modifier_invoker_21", 1, "invoker/21", {}},
				{"empty_20"},
				{"empty_21"}
			}
		}
	},
	["npc_dota_hero_terrorblade"] = {
		[1] = {
			[1] = {
				{"modifier_woda_talent_hp1", "#woda_talent_hp1", 3, "hp1", {}},
				{"modifier_woda_talent_regenhp1", "#woda_talent_regenhp1", 2, "regenhp1", {}},
				{"modifier_woda_talent_attack1", "#woda_talent_attack1", 3, "attack1", {}},
				{"modifier_terrorblade_1","#modifier_terrorblade_1", 2, "terrorblade/1", {}},
				{"modifier_woda_talent_str3", "#woda_talent_str3", 2, "str3", {}}
			},
			[2] = {
				{"empty_2"},
				{"empty_3"},
				{"modifier_terrorblade_2","#modifier_terrorblade_2", 1, "terrorblade/2", {}},
				{"modifier_woda_talent_cloak", "#woda_talent_cloak", 2, "cloak", {}},
				{"modifier_woda_talent_str6", "#woda_talent_str6", 1, "str6", {"modifier_woda_talent_str3",2}}
			},
			[3] = {
				{"empty_6"},
				{"modifier_woda_talent_quickhp", "#woda_talent_quickhp", 2, "quickhp", {}},
				{"empty_7"},
				{"modifier_terrorblade_3","#modifier_terrorblade_3", 3, "terrorblade/3", {}},
				{"modifier_woda_talent_sasha", "#woda_talent_sasha", 1, "sasha", {"modifier_woda_talent_str6",1}}
			},
			[4] = {
				{"modifier_woda_talent_hp2", "#woda_talent_hp2", 3, "hp2", {"modifier_woda_talent_hp1",3}},
				{"empty_9"},
				{"modifier_terrorblade_4","#modifier_terrorblade_4", 2, "terrorblade/4", {"modifier_terrorblade_2",1}},
				{"modifier_woda_talent_octar", "#woda_talent_octar", 2, "octar", {}},
				{"modifier_woda_talent_str4", "#woda_talent_str4", 1, "str4", {"modifier_woda_talent_sasha",1}}
			},
			[5] = {
				{"modifier_woda_talent_armor2", "#woda_talent_armor2", 3, "armor2", {}},
				{"modifier_terrorblade_5","#modifier_terrorblade_5", 2, "terrorblade/5", {}},
				{"empty_10"},
				{"empty_11"},
				{"modifier_woda_talent_str5", "#woda_talent_str5", 3, "str5", {"modifier_woda_talent_str4",1}}
			},
			[6] = {
				{"modifier_woda_talent_sliver", "#woda_talent_sliver", 2, "sliver", {}},
				{"modifier_woda_talent_regenhp2", "#woda_talent_regenhp2", 3, "regenhp2", {}},
				{"modifier_terrorblade_6","#modifier_terrorblade_6", 3, "terrorblade/6", {"modifier_terrorblade_4",2}},
				{"empty_15"},
				{"empty_16"}
			},
			[7] = {
				{"empty_17"},
				{"empty_18"},
				{"modifier_terrorblade_7","#modifier_terrorblade_7", 1, "terrorblade/7", {}},
				{"empty_20"},
				{"empty_21"}
			}
		},
		[2] = {
			[1] = {
				{"modifier_woda_talent_armor1", "#woda_talent_armor1", 3, "armor1", {}},
				{"modifier_woda_talent_speed1", "#woda_talent_speed1", 2, "speed1", {}},
				{"modifier_woda_talent_attackspeed1", "#woda_talent_attackspeed1", 3, "attackspeed1", {}},
				{"modifier_terrorblade_9","#modifier_terrorblade_9", 2, "terrorblade/9", {}},
				{"modifier_woda_talent_agi3", "#woda_talent_agi3", 2, "agi3", {}}
			},
			[2] = {
				{"empty_2"},
				{"empty_3"},
				{"modifier_terrorblade_8","#modifier_terrorblade_8", 2, "terrorblade/8", {}},
				{"modifier_woda_talent_miss1", "#woda_talent_miss1", 2, "miss1", {}},
				{"modifier_woda_talent_agi6", "#woda_talent_agi6", 1, "agi6", {"modifier_woda_talent_agi3",2}}
			},
			[3] = {
				{"modifier_terrorblade_10","#modifier_terrorblade_10", 3, "terrorblade/10", {}},
				{"empty_7"},
				{"empty_8"},
				{"modifier_woda_talent_mask1", "#woda_talent_mask1", 2, "mask1", {}},
				{"modifier_woda_talent_yasha", "#woda_talent_yasha", 1, "yasha", {"modifier_woda_talent_agi6",1}}
			},
			[4] = {
				{"modifier_terrorblade_11","#modifier_terrorblade_11", 3, "terrorblade/11", {}},
				{"modifier_woda_talent_speed2", "#woda_talent_speed2", 3, "speed2", {"modifier_woda_talent_speed1",2}},
				{"modifier_woda_talent_grovebow", "#woda_talent_grovebow", 2, "grovebow", {}},
				{"empty_10"},			
				{"modifier_woda_talent_agi4", "#woda_talent_agi4", 1, "agi4", {"modifier_woda_talent_yasha",1}}
			},
			[5] = {
				{"modifier_woda_talent_attack2", "#woda_talent_attack2", 3, "attack2", {}},
				{"empty_11"},
				{"empty_12"},
				{"modifier_terrorblade_12","#modifier_terrorblade_12", 2, "terrorblade/12", {}},
				{"modifier_woda_talent_agi5", "#woda_talent_agi5", 3, "agi5", {"modifier_woda_talent_agi4",1}}
			},
			[6] = {
				{"modifier_woda_talent_miss2", "#woda_talent_miss2", 2, "miss2", {}},
				{"modifier_terrorblade_13","#modifier_terrorblade_13", 1, "terrorblade/13", {}},
				{"modifier_woda_talent_attackspeed2", "#woda_talent_attackspeed2", 3, "attackspeed2", {}},
				{"empty_13"},
				{"empty_16"}
			},
			[7] = {
				{"empty_17"},
				{"empty_18"},
				{"modifier_terrorblade_14","#modifier_terrorblade_14", 1, "terrorblade/14", {}},
				{"empty_20"},
				{"empty_21"}
			}
		},
		[3] = {
			[1] = {
				{"modifier_woda_talent_mp1", "#woda_talent_mp1", 3, "mp1", {}},
				{"modifier_woda_talent_regenmp1", "#woda_talent_regenmp1", 2, "regenmp1", {}},
				{"modifier_woda_talent_spell", "#woda_talent_spell", 3, "spell", {}},
				{"modifier_terrorblade_15","#modifier_terrorblade_15", 3, "terrorblade/15", {}},
				{"modifier_woda_talent_int3", "#woda_talent_int3", 2, "int3", {}}
			},
			[2] = {
				{"empty_2"},
				{"empty_3"},
				{"modifier_terrorblade_21","#modifier_terrorblade_21", 1, "terrorblade/21", {}},
				{"modifier_woda_talent_blood", "#woda_talent_blood", 2, "blood", {}},
				{"modifier_woda_talent_int6", "#woda_talent_int6", 1, "int6", {"modifier_woda_talent_int3",2}}
			},
			[3] = {
				{"empty_6"},
				{"empty_7"},
				{"modifier_terrorblade_16","#modifier_terrorblade_16", 1, "terrorblade/16", {"modifier_terrorblade_21",1}},
				{"modifier_woda_talent_mask2", "#woda_talent_mask2", 2, "mask2", {}},
				{"modifier_woda_talent_kaya", "#woda_talent_kaya", 1, "kaya", {"modifier_woda_talent_int6",1}}
			},
			[4] = {
				{"modifier_woda_talent_mp2", "#woda_talent_mp2", 3, "mp2", {"modifier_woda_talent_mp1",3}},
				{"modifier_woda_talent_fairy", "#woda_talent_fairy", 2, "fairy", {}},
				{"modifier_terrorblade_17","#modifier_terrorblade_17", 3, "terrorblade/17", {"modifier_terrorblade_16",1}},
				{"empty_9"},
				{"modifier_woda_talent_int4", "#woda_talent_int4", 1, "int4", {"modifier_woda_talent_kaya",1}}
			},
			[5] = {
				{"modifier_woda_talent_spellprism", "#woda_talent_spellprism", 3, "spellprism", {}},
				{"empty_10"},
				{"empty_11"},
				{"modifier_terrorblade_20","#modifier_terrorblade_20", 2, "terrorblade/20", {}},
				{"modifier_woda_talent_int5", "#woda_talent_int5", 3, "int5", {"modifier_woda_talent_int4",1}}
			},
			[6] = {
				{"modifier_woda_talent_timeless", "#woda_talent_timeless", 2, "timeless", {}},
				{"modifier_woda_talent_regenmp2", "#woda_talent_regenmp2", 3, "regenmp2", {}},
				{"modifier_terrorblade_18","#modifier_terrorblade_18", 3, "terrorblade/18", {"modifier_terrorblade_17",3}},
				{"empty_15"},
				{"empty_16"}
			},
			[7] = {
				{"empty_17"},
				{"empty_18"},
				{"modifier_terrorblade_19","#modifier_terrorblade_19", 1, "terrorblade/19", {}},
				{"empty_20"},
				{"empty_21"}
			}
		}
	},
	["npc_dota_hero_undying"] = {
		[1] = {
			[1] = {
				{"modifier_woda_talent_hp1", "#woda_talent_hp1", 3, "hp1", {}},
				{"modifier_woda_talent_regenhp1", "#woda_talent_regenhp1", 2, "regenhp1", {}},
				{"modifier_woda_talent_attack1", "#woda_talent_attack1", 3, "attack1", {}},
				{"modifier_undying_1","#modifier_undying_1", 3, "undying/1", {}},
				{"modifier_woda_talent_str3", "#woda_talent_str3", 2, "str3", {}}
			},
			[2] = {
				{"empty_2"},
				{"empty_3"},
				{"modifier_undying_2","#modifier_undying_2", 2, "undying/2", {}},
				{"modifier_woda_talent_cloak", "#woda_talent_cloak", 2, "cloak", {}},
				{"modifier_woda_talent_str6", "#woda_talent_str6", 1, "str6", {"modifier_woda_talent_str3",2}}
			},
			[3] = {
				{"empty_6"},
				{"modifier_woda_talent_quickhp", "#woda_talent_quickhp", 2, "quickhp", {}},
				{"modifier_undying_3","#modifier_undying_3", 1, "undying/3", {}},
				{"empty_8"},
				{"modifier_woda_talent_sasha", "#woda_talent_sasha", 1, "sasha", {"modifier_woda_talent_str6",1}}
			},
			[4] = {
				{"modifier_woda_talent_hp2", "#woda_talent_hp2", 3, "hp2", {"modifier_woda_talent_hp1",3}},
				{"empty_9"},
				{"modifier_undying_4","#modifier_undying_4", 3, "undying/4", {"modifier_undying_3",1}},
				{"modifier_woda_talent_octar", "#woda_talent_octar", 2, "octar", {}},
				{"modifier_woda_talent_str4", "#woda_talent_str4", 1, "str4", {"modifier_woda_talent_sasha",1}}
			},
			[5] = {
				{"modifier_woda_talent_armor2", "#woda_talent_armor2", 3, "armor2", {}},
				{"modifier_undying_6","#modifier_undying_6", 2, "undying/6", {}},
				{"empty_11"},
				{"empty_12"},
				{"modifier_woda_talent_str5", "#woda_talent_str5", 3, "str5", {"modifier_woda_talent_str4",1}}
			},
			[6] = {
				{"modifier_woda_talent_sliver", "#woda_talent_sliver", 2, "sliver", {}},
				{"modifier_woda_talent_regenhp2", "#woda_talent_regenhp2", 3, "regenhp2", {}},
				{"modifier_undying_5","#modifier_undying_5", 2, "undying/5", {"modifier_undying_4",3}},
				{"empty_15"},
				{"empty_16"}
			},
			[7] = {
				{"empty_17"},
				{"empty_18"},
				{"modifier_undying_7","#modifier_undying_7", 1, "undying/7", {}},
				{"empty_20"},
				{"empty_21"}
			}
		},
		[2] = {
			[1] = {
				{"modifier_woda_talent_armor1", "#woda_talent_armor1", 3, "armor1", {}},
				{"modifier_woda_talent_speed1", "#woda_talent_speed1", 2, "speed1", {}},
				{"modifier_woda_talent_attackspeed1", "#woda_talent_attackspeed1", 3, "attackspeed1", {}},
				{"modifier_undying_8","#modifier_undying_8", 2, "undying/8", {}},
				{"modifier_woda_talent_agi3", "#woda_talent_agi3", 2, "agi3", {}}
			},
			[2] = {
				{"modifier_undying_10","#modifier_undying_10", 3, "undying/10", {}},
				{"empty_3"},
				{"empty_4"},
				{"modifier_woda_talent_miss1", "#woda_talent_miss1", 2, "miss1", {}},
				{"modifier_woda_talent_agi6", "#woda_talent_agi6", 1, "agi6", {"modifier_woda_talent_agi3",2}}
			},
			[3] = {
				{"modifier_undying_14","#modifier_undying_14", 2, "undying/14", {"modifier_undying_10",3}},
				{"empty_7"},
				{"empty_8"},
				{"modifier_woda_talent_mask1", "#woda_talent_mask1", 2, "mask1", {}},
				{"modifier_woda_talent_yasha", "#woda_talent_yasha", 1, "yasha", {"modifier_woda_talent_agi6",1}}
			},
			[4] = {
				{"modifier_undying_11","#modifier_undying_11", 3, "undying/11", {"modifier_undying_14",2}},
				{"modifier_woda_talent_speed2", "#woda_talent_speed2", 3, "speed2", {"modifier_woda_talent_speed1",2}},
				{"modifier_woda_talent_grovebow", "#woda_talent_grovebow", 2, "grovebow", {}},
				{"empty_10"},			
				{"modifier_woda_talent_agi4", "#woda_talent_agi4", 1, "agi4", {"modifier_woda_talent_yasha",1}}
			},
			[5] = {
				{"modifier_woda_talent_attack2", "#woda_talent_attack2", 3, "attack2", {}},
				{"empty_11"},
				{"empty_12"},
				{"modifier_undying_12","#modifier_undying_12", 1, "undying/12", {}},
				{"modifier_woda_talent_agi5", "#woda_talent_agi5", 3, "agi5", {"modifier_woda_talent_agi4",1}}
			},
			[6] = {
				{"modifier_woda_talent_miss2", "#woda_talent_miss2", 2, "miss2", {}},
				{"empty_15"},
				{"modifier_woda_talent_attackspeed2", "#woda_talent_attackspeed2", 3, "attackspeed2", {}},
				{"empty_16"},
				{"modifier_undying_9","#modifier_undying_9", 2, "undying/9", {}}
			},
			[7] = {
				{"empty_17"},
				{"empty_18"},
				{"modifier_undying_13","#modifier_undying_13", 1, "undying/13", {}},
				{"empty_20"},
				{"empty_21"}
			}
		},
		[3] = {
			[1] = {
				{"modifier_woda_talent_mp1", "#woda_talent_mp1", 3, "mp1", {}},
				{"modifier_woda_talent_regenmp1", "#woda_talent_regenmp1", 2, "regenmp1", {}},
				{"modifier_woda_talent_spell", "#woda_talent_spell", 3, "spell", {}},
				{"modifier_undying_15","#modifier_undying_15", 2, "undying/15", {}},
				{"modifier_woda_talent_int3", "#woda_talent_int3", 2, "int3", {}}
			},
			[2] = {
				{"empty_2"},
				{"empty_3"},
				{"modifier_undying_18","#modifier_undying_18", 1, "undying/18", {}},
				{"modifier_woda_talent_blood", "#woda_talent_blood", 2, "blood", {}},
				{"modifier_woda_talent_int6", "#woda_talent_int6", 1, "int6", {"modifier_woda_talent_int3",2}}
			},
			[3] = {
				{"empty_6"},
				{"modifier_undying_17","#modifier_undying_17", 3, "undying/17", {}},
				{"empty_7"},
				{"modifier_woda_talent_mask2", "#woda_talent_mask2", 2, "mask2", {}},
				{"modifier_woda_talent_kaya", "#woda_talent_kaya", 1, "kaya", {"modifier_woda_talent_int6",1}}
			},
			[4] = {
				{"modifier_woda_talent_mp2", "#woda_talent_mp2", 3, "mp2", {"modifier_woda_talent_mp1",3}},
				{"modifier_woda_talent_fairy", "#woda_talent_fairy", 2, "fairy", {}},
				{"empty_9"},
				{"modifier_undying_20","#modifier_undying_20", 3, "undying/20", {}},
				{"modifier_woda_talent_int4", "#woda_talent_int4", 1, "int4", {"modifier_woda_talent_kaya",1}}
			},
			[5] = {
				{"modifier_woda_talent_spellprism", "#woda_talent_spellprism", 3, "spellprism", {}},
				{"modifier_undying_19","#modifier_undying_19", 2, "undying/19", {}},
				{"empty_10"},
				{"empty_11"},
				{"modifier_woda_talent_int5", "#woda_talent_int5", 3, "int5", {"modifier_woda_talent_int4",1}}
			},
			[6] = {
				{"modifier_woda_talent_timeless", "#woda_talent_timeless", 2, "timeless", {}},
				{"modifier_woda_talent_regenmp2", "#woda_talent_regenmp2", 3, "regenmp2", {}},
				{"empty_15"},
				{"empty_16"},
				{"modifier_undying_16","#modifier_undying_16", 2, "undying/16", {}}
			},
			[7] = {
				{"empty_17"},
				{"empty_18"},
				{"modifier_undying_21","#modifier_undying_21", 1, "undying/21", {}},
				{"empty_20"},
				{"empty_21"}
			}
		}
	},
	["npc_dota_hero_vengefulspirit"] = {
		[1] = {
			[1] = {
				{"modifier_woda_talent_hp1", "#woda_talent_hp1", 3, "hp1", {}},
				{"modifier_woda_talent_regenhp1", "#woda_talent_regenhp1", 2, "regenhp1", {}},
				{"modifier_woda_talent_attack1", "#woda_talent_attack1", 3, "attack1", {}},
				{"modifier_vengefulspirit_2","#modifier_vengefulspirit_2", 3, "vengefulspirit/2", {}},
				{"modifier_woda_talent_str3", "#woda_talent_str3", 2, "str3", {}}
			},
			[2] = {
				{"empty_2"},
				{"empty_3"},
				{"modifier_vengefulspirit_12","#modifier_vengefulspirit_12", 3, "vengefulspirit/12", {}},
				{"modifier_woda_talent_cloak", "#woda_talent_cloak", 2, "cloak", {}},
				{"modifier_woda_talent_str6", "#woda_talent_str6", 1, "str6", {"modifier_woda_talent_str3",2}}
			},
			[3] = {
				{"empty_6"},
				{"modifier_woda_talent_quickhp", "#woda_talent_quickhp", 2, "quickhp", {}},
				{"empty_8"},
				{"modifier_vengefulspirit_4","#modifier_vengefulspirit_4", 2, "vengefulspirit/4", {}},
				{"modifier_woda_talent_sasha", "#woda_talent_sasha", 1, "sasha", {"modifier_woda_talent_str6",1}}
			},
			[4] = {
				{"modifier_woda_talent_hp2", "#woda_talent_hp2", 3, "hp2", {"modifier_woda_talent_hp1",3}},
				{"empty_9"},
				{"modifier_vengefulspirit_5","#modifier_vengefulspirit_5", 2, "vengefulspirit/5", {}},
				{"modifier_woda_talent_octar", "#woda_talent_octar", 2, "octar", {}},
				{"modifier_woda_talent_str4", "#woda_talent_str4", 1, "str4", {"modifier_woda_talent_sasha",1}}
			},
			[5] = {
				{"modifier_woda_talent_armor2", "#woda_talent_armor2", 3, "armor2", {}},
				{"modifier_vengefulspirit_7","#modifier_vengefulspirit_7", 1, "vengefulspirit/7", {}},
				{"empty_10"},
				{"empty_11"},
				{"modifier_woda_talent_str5", "#woda_talent_str5", 3, "str5", {"modifier_woda_talent_str4",1}}
			},
			[6] = {
				{"modifier_woda_talent_sliver", "#woda_talent_sliver", 2, "sliver", {}},
				{"modifier_woda_talent_regenhp2", "#woda_talent_regenhp2", 3, "regenhp2", {}},
				{"modifier_vengefulspirit_6","#modifier_vengefulspirit_6", 2, "vengefulspirit/6", {}},
				{"empty_14"},
				{"empty_16"}
			},
			[7] = {
				{"empty_17"},
				{"empty_18"},
				{"modifier_vengefulspirit_3","#modifier_vengefulspirit_3", 1, "vengefulspirit/3", {}},
				{"empty_20"},
				{"empty_21"}
			}
		},
		[2] = {
			[1] = {
				{"modifier_woda_talent_armor1", "#woda_talent_armor1", 3, "armor1", {}},
				{"modifier_woda_talent_speed1", "#woda_talent_speed1", 2, "speed1", {}},
				{"modifier_woda_talent_attackspeed1", "#woda_talent_attackspeed1", 3, "attackspeed1", {}},
				{"modifier_vengefulspirit_8","#modifier_vengefulspirit_8", 3, "vengefulspirit/8", {}},
				{"modifier_woda_talent_agi3", "#woda_talent_agi3", 2, "agi3", {}}
			},
			[2] = {
				{"modifier_vengefulspirit_9","#modifier_vengefulspirit_9", 3, "vengefulspirit/9", {}},
				{"empty_3"},
				{"empty_4"},
				{"modifier_woda_talent_miss1", "#woda_talent_miss1", 2, "miss1", {}},
				{"modifier_woda_talent_agi6", "#woda_talent_agi6", 1, "agi6", {"modifier_woda_talent_agi3",2}}
			},
			[3] = {
				{"modifier_vengefulspirit_13","#modifier_vengefulspirit_13", 1, "vengefulspirit/13", {}},
				{"empty_7"},
				{"empty_8"},
				{"modifier_woda_talent_mask1", "#woda_talent_mask1", 2, "mask1", {}},
				{"modifier_woda_talent_yasha", "#woda_talent_yasha", 1, "yasha", {"modifier_woda_talent_agi6",1}}
			},
			[4] = {
				{"modifier_vengefulspirit_20","#modifier_vengefulspirit_20", 3, "vengefulspirit/20", {}},
				{"modifier_woda_talent_speed2", "#woda_talent_speed2", 3, "speed2", {"modifier_woda_talent_speed1",2}},
				{"modifier_woda_talent_grovebow", "#woda_talent_grovebow", 2, "grovebow", {}},
				{"empty_10"},			
				{"modifier_woda_talent_agi4", "#woda_talent_agi4", 1, "agi4", {"modifier_woda_talent_yasha",1}}
			},
			[5] = {
				{"modifier_woda_talent_attack2", "#woda_talent_attack2", 3, "attack2", {}},
				{"modifier_vengefulspirit_1","#modifier_vengefulspirit_1", 2, "vengefulspirit/1", {}},
				{"empty_11"},
				{"empty_12"},
				{"modifier_woda_talent_agi5", "#woda_talent_agi5", 3, "agi5", {"modifier_woda_talent_agi4",1}}
			},
			[6] = {
				{"modifier_woda_talent_miss2", "#woda_talent_miss2", 2, "miss2", {}},
				{"empty_13"},
				{"modifier_woda_talent_attackspeed2", "#woda_talent_attackspeed2", 3, "attackspeed2", {}},
				{"empty_15"},
				{"modifier_vengefulspirit_10","#modifier_vengefulspirit_10", 1, "vengefulspirit/10", {}}
			},
			[7] = {
				{"empty_17"},
				{"empty_18"},
				{"modifier_vengefulspirit_14","#modifier_vengefulspirit_14", 1, "vengefulspirit/14", {}},
				{"empty_20"},
				{"empty_21"}
			}
		},
		[3] = {
			[1] = {
				{"modifier_woda_talent_mp1", "#woda_talent_mp1", 3, "mp1", {}},
				{"modifier_woda_talent_regenmp1", "#woda_talent_regenmp1", 2, "regenmp1", {}},
				{"modifier_woda_talent_spell", "#woda_talent_spell", 3, "spell", {}},
				{"modifier_vengefulspirit_15","#modifier_vengefulspirit_15", 3, "vengefulspirit/15", {}},
				{"modifier_woda_talent_int3", "#woda_talent_int3", 2, "int3", {}}
			},
			[2] = {
				{"empty_2"},
				{"empty_3"},
				{"modifier_vengefulspirit_18","#modifier_vengefulspirit_18", 2, "vengefulspirit/18", {}},
				{"modifier_woda_talent_blood", "#woda_talent_blood", 2, "blood", {}},
				{"modifier_woda_talent_int6", "#woda_talent_int6", 1, "int6", {"modifier_woda_talent_int3",2}}
			},
			[3] = {
				{"empty_6"},
				{"empty_7"},
				{"modifier_vengefulspirit_17","#modifier_vengefulspirit_17", 2, "vengefulspirit/17", {"modifier_vengefulspirit_18",2}},
				{"modifier_woda_talent_mask2", "#woda_talent_mask2", 2, "mask2", {}},
				{"modifier_woda_talent_kaya", "#woda_talent_kaya", 1, "kaya", {"modifier_woda_talent_int6",1}}
			},
			[4] = {
				{"modifier_woda_talent_mp2", "#woda_talent_mp2", 3, "mp2", {"modifier_woda_talent_mp1",3}},
				{"modifier_woda_talent_fairy", "#woda_talent_fairy", 2, "fairy", {}},
				{"modifier_vengefulspirit_16","#modifier_vengefulspirit_16", 3, "vengefulspirit/16", {}},
				{"empty_9"},
				{"modifier_woda_talent_int4", "#woda_talent_int4", 1, "int4", {"modifier_woda_talent_kaya",1}}
			},
			[5] = {
				{"modifier_woda_talent_spellprism", "#woda_talent_spellprism", 3, "spellprism", {}},
				{"modifier_vengefulspirit_19","#modifier_vengefulspirit_19", 1, "vengefulspirit/19", {}},
				{"empty_10"},
				{"empty_11"},
				{"modifier_woda_talent_int5", "#woda_talent_int5", 3, "int5", {"modifier_woda_talent_int4",1}}
			},
			[6] = {
				{"modifier_woda_talent_timeless", "#woda_talent_timeless", 2, "timeless", {}},
				{"modifier_woda_talent_regenmp2", "#woda_talent_regenmp2", 3, "regenmp2", {}},
				{"empty_14"},
				{"empty_15"},
				{"modifier_vengefulspirit_11","#modifier_vengefulspirit_11", 2, "vengefulspirit/11", {}}
			},
			[7] = {
				{"empty_17"},
				{"empty_18"},
				{"modifier_vengefulspirit_21","#modifier_vengefulspirit_21", 1, "vengefulspirit/21", {}},
				{"empty_20"},
				{"empty_21"}
			}
		}
	},
	["npc_dota_hero_muerta"] = {
		[1] = {
			[1] = {
				{"modifier_woda_talent_hp1", "#woda_talent_hp1", 3, "hp1", {}},
				{"modifier_woda_talent_regenhp1", "#woda_talent_regenhp1", 2, "regenhp1", {}},
				{"modifier_woda_talent_attack1", "#woda_talent_attack1", 3, "attack1", {}},
				{"modifier_muerta_1","#modifier_muerta_1", 2, "muerta/1", {}},
				{"modifier_woda_talent_str3", "#woda_talent_str3", 2, "str3", {}}
			},
			[2] = {
				{"empty_2"},
				{"empty_3"},
				{"modifier_muerta_2","#modifier_muerta_2", 2, "muerta/2", {}},
				{"modifier_woda_talent_cloak", "#woda_talent_cloak", 2, "cloak", {}},
				{"modifier_woda_talent_str6", "#woda_talent_str6", 1, "str6", {"modifier_woda_talent_str3",2}}
			},
			[3] = {
				{"empty_6"},
				{"modifier_woda_talent_quickhp", "#woda_talent_quickhp", 2, "quickhp", {}},
				{"empty_8"},
				{"modifier_muerta_3","#modifier_muerta_3", 2, "muerta/3", {}},
				{"modifier_woda_talent_sasha", "#woda_talent_sasha", 1, "sasha", {"modifier_woda_talent_str6",1}}
			},
			[4] = {
				{"modifier_woda_talent_hp2", "#woda_talent_hp2", 3, "hp2", {"modifier_woda_talent_hp1",3}},
				{"modifier_muerta_4","#modifier_muerta_4", 3, "muerta/4", {}},
				{"empty_9"},
				{"modifier_woda_talent_octar", "#woda_talent_octar", 2, "octar", {}},
				{"modifier_woda_talent_str4", "#woda_talent_str4", 1, "str4", {"modifier_woda_talent_sasha",1}}
			},
			[5] = {
				{"modifier_woda_talent_armor2", "#woda_talent_armor2", 3, "armor2", {}},
				{"empty_10"},
				{"modifier_muerta_5","#modifier_muerta_5", 1, "muerta/5", {}},
				{"empty_11"},
				{"modifier_woda_talent_str5", "#woda_talent_str5", 3, "str5", {"modifier_woda_talent_str4",1}}
			},
			[6] = {
				{"modifier_woda_talent_sliver", "#woda_talent_sliver", 2, "sliver", {}},
				{"modifier_woda_talent_regenhp2", "#woda_talent_regenhp2", 3, "regenhp2", {}},
				{"empty_14"},
				{"modifier_muerta_6","#modifier_muerta_6", 3, "muerta/6", {}},
				{"empty_16"}
			},
			[7] = {
				{"empty_17"},
				{"empty_18"},
				{"modifier_muerta_7","#modifier_muerta_7", 1, "muerta/7", {}},
				{"empty_20"},
				{"empty_21"}
			}
		},
		[2] = {
			[1] = {
				{"modifier_woda_talent_armor1", "#woda_talent_armor1", 3, "armor1", {}},
				{"modifier_woda_talent_speed1", "#woda_talent_speed1", 2, "speed1", {}},
				{"modifier_woda_talent_attackspeed1", "#woda_talent_attackspeed1", 3, "attackspeed1", {}},
				{"modifier_muerta_13","#modifier_muerta_13", 3, "muerta/13", {}},
				{"modifier_woda_talent_agi3", "#woda_talent_agi3", 2, "agi3", {}}
			},
			[2] = {
				{"modifier_muerta_9","#modifier_muerta_9", 3, "muerta/9", {}},
				{"empty_3"},
				{"empty_4"},
				{"modifier_woda_talent_miss1", "#woda_talent_miss1", 2, "miss1", {}},
				{"modifier_woda_talent_agi6", "#woda_talent_agi6", 1, "agi6", {"modifier_woda_talent_agi3",2}}
			},
			[3] = {
				{"modifier_muerta_10","#modifier_muerta_10", 2, "muerta/10", {}},
				{"empty_7"},
				{"empty_8"},
				{"modifier_woda_talent_mask1", "#woda_talent_mask1", 2, "mask1", {}},
				{"modifier_woda_talent_yasha", "#woda_talent_yasha", 1, "yasha", {"modifier_woda_talent_agi6",1}}
			},
			[4] = {
				{"modifier_muerta_11","#modifier_muerta_11", 1, "muerta/11", {}},
				{"modifier_woda_talent_speed2", "#woda_talent_speed2", 3, "speed2", {"modifier_woda_talent_speed1",2}},
				{"modifier_woda_talent_grovebow", "#woda_talent_grovebow", 2, "grovebow", {}},
				{"empty_10"},			
				{"modifier_woda_talent_agi4", "#woda_talent_agi4", 1, "agi4", {"modifier_woda_talent_yasha",1}}
			},
			[5] = {
				{"modifier_woda_talent_attack2", "#woda_talent_attack2", 3, "attack2", {}},
				{"empty_11"},
				{"modifier_muerta_12","#modifier_muerta_12", 2, "muerta/12", {}},
				{"empty_12"},
				{"modifier_woda_talent_agi5", "#woda_talent_agi5", 3, "agi5", {"modifier_woda_talent_agi4",1}}
			},
			[6] = {
				{"modifier_woda_talent_miss2", "#woda_talent_miss2", 2, "miss2", {}},
				{"empty_13"},
				{"modifier_woda_talent_attackspeed2", "#woda_talent_attackspeed2", 3, "attackspeed2", {}},
				{"modifier_muerta_8","#modifier_muerta_8", 2, "muerta/8", {}},
				{"empty_16"}
			},
			[7] = {
				{"empty_17"},
				{"empty_18"},
				{"modifier_muerta_14","#modifier_muerta_14", 1, "muerta/14", {}},
				{"empty_20"},
				{"empty_21"}
			}
		},
		[3] = {
			[1] = {
				{"modifier_woda_talent_mp1", "#woda_talent_mp1", 3, "mp1", {}},
				{"modifier_woda_talent_regenmp1", "#woda_talent_regenmp1", 2, "regenmp1", {}},
				{"modifier_woda_talent_spell", "#woda_talent_spell", 3, "spell", {}},
				{"modifier_muerta_15","#modifier_muerta_15", 3, "muerta/15", {}},
				{"modifier_woda_talent_int3", "#woda_talent_int3", 2, "int3", {}}
			},
			[2] = {
				{"empty_2"},
				{"modifier_muerta_16","#modifier_muerta_16", 1, "muerta/16", {}},
				{"empty_3"},
				{"modifier_woda_talent_blood", "#woda_talent_blood", 2, "blood", {}},
				{"modifier_woda_talent_int6", "#woda_talent_int6", 1, "int6", {"modifier_woda_talent_int3",2}}
			},
			[3] = {
				{"empty_6"},
				{"modifier_muerta_17","#modifier_muerta_17", 3, "muerta/17", {}},
				{"empty_7"},
				{"modifier_woda_talent_mask2", "#woda_talent_mask2", 2, "mask2", {}},
				{"modifier_woda_talent_kaya", "#woda_talent_kaya", 1, "kaya", {"modifier_woda_talent_int6",1}}
			},
			[4] = {
				{"modifier_woda_talent_mp2", "#woda_talent_mp2", 3, "mp2", {"modifier_woda_talent_mp1",3}},
				{"modifier_woda_talent_fairy", "#woda_talent_fairy", 2, "fairy", {}},
				{"modifier_muerta_20","#modifier_muerta_20", 2, "muerta/20", {}},
				{"empty_9"},
				{"modifier_woda_talent_int4", "#woda_talent_int4", 1, "int4", {"modifier_woda_talent_kaya",1}}
			},
			[5] = {
				{"modifier_woda_talent_spellprism", "#woda_talent_spellprism", 3, "spellprism", {}},
				{"empty_10"},
				{"modifier_muerta_19","#modifier_muerta_19", 3, "muerta/19", {}},
				{"empty_11"},
				{"modifier_woda_talent_int5", "#woda_talent_int5", 3, "int5", {"modifier_woda_talent_int4",1}}
			},
			[6] = {
				{"modifier_woda_talent_timeless", "#woda_talent_timeless", 2, "timeless", {}},
				{"modifier_woda_talent_regenmp2", "#woda_talent_regenmp2", 3, "regenmp2", {}},
				{"empty_15"},
				{"modifier_muerta_21","#modifier_muerta_21", 1, "muerta/21", {}},
				{"empty_16"}
			},
			[7] = {
				{"empty_17"},
				{"empty_18"},
				{"modifier_muerta_18","#modifier_muerta_18", 1, "muerta/18", {}},
				{"empty_20"},
				{"empty_21"}
			}
		}
	},
	["npc_dota_hero_legion_commander"] = {
		[1] = {
			[1] = {
				{"modifier_woda_talent_hp1", "#woda_talent_hp1", 3, "hp1", {}},
				{"modifier_woda_talent_regenhp1", "#woda_talent_regenhp1", 2, "regenhp1", {}},
				{"modifier_woda_talent_attack1", "#woda_talent_attack1", 3, "attack1", {}},
				{"modifier_legion_commander_1","#modifier_legion_commander_1", 2, "legion_commander/1", {}},
				{"modifier_woda_talent_str3", "#woda_talent_str3", 2, "str3", {}}
			},
			[2] = {
				{"empty_2"},
				{"empty_3"},
				{"modifier_legion_commander_2","#modifier_legion_commander_2", 3, "legion_commander/2", {}},
				{"modifier_woda_talent_cloak", "#woda_talent_cloak", 2, "cloak", {}},
				{"modifier_woda_talent_str6", "#woda_talent_str6", 1, "str6", {"modifier_woda_talent_str3",2}}
			},
			[3] = {
				{"empty_6"},
				{"modifier_woda_talent_quickhp", "#woda_talent_quickhp", 2, "quickhp", {}},
				{"empty_8"},
				{"modifier_legion_commander_3","#modifier_legion_commander_3", 2, "legion_commander/3", {}},
				{"modifier_woda_talent_sasha", "#woda_talent_sasha", 1, "sasha", {"modifier_woda_talent_str6",1}}
			},
			[4] = {
				{"modifier_woda_talent_hp2", "#woda_talent_hp2", 3, "hp2", {"modifier_woda_talent_hp1",3}},
				{"empty_9"},
				{"modifier_legion_commander_4","#modifier_legion_commander_4", 2, "legion_commander/4", {}},
				{"modifier_woda_talent_octar", "#woda_talent_octar", 2, "octar", {}},
				{"modifier_woda_talent_str4", "#woda_talent_str4", 1, "str4", {"modifier_woda_talent_sasha",1}}
			},
			[5] = {
				{"modifier_woda_talent_armor2", "#woda_talent_armor2", 3, "armor2", {}},
				{"empty_10"},
				{"empty_11"},
				{"modifier_legion_commander_7","#modifier_legion_commander_7", 2, "legion_commander/7", {}},
				{"modifier_woda_talent_str5", "#woda_talent_str5", 3, "str5", {"modifier_woda_talent_str4",1}}
			},
			[6] = {
				{"modifier_woda_talent_sliver", "#woda_talent_sliver", 2, "sliver", {}},
				{"modifier_woda_talent_regenhp2", "#woda_talent_regenhp2", 3, "regenhp2", {}},
				{"modifier_legion_commander_6","#modifier_legion_commander_6", 2, "legion_commander/6", {}},
				{"empty_15"},
				{"empty_16"}
			},
			[7] = {
				{"empty_17"},
				{"empty_18"},
				{"modifier_legion_commander_5","#modifier_legion_commander_5", 1, "legion_commander/5", {}},
				{"empty_20"},
				{"empty_21"}
			}
		},
		[2] = {
			[1] = {
				{"modifier_woda_talent_armor1", "#woda_talent_armor1", 3, "armor1", {}},
				{"modifier_woda_talent_speed1", "#woda_talent_speed1", 2, "speed1", {}},
				{"modifier_woda_talent_attackspeed1", "#woda_talent_attackspeed1", 3, "attackspeed1", {}},
				{"modifier_legion_commander_8","#modifier_legion_commander_8", 1, "legion_commander/8", {}},
				{"modifier_woda_talent_agi3", "#woda_talent_agi3", 2, "agi3", {}}
			},
			[2] = {
				{"modifier_legion_commander_9","#modifier_legion_commander_9", 3, "legion_commander/9", {}},
				{"empty_3"},
				{"empty_4"},
				{"modifier_woda_talent_miss1", "#woda_talent_miss1", 2, "miss1", {}},
				{"modifier_woda_talent_agi6", "#woda_talent_agi6", 1, "agi6", {"modifier_woda_talent_agi3",2}}
			},
			[3] = {
				{"modifier_legion_commander_10","#modifier_legion_commander_10", 3, "legion_commander/10", {}},
				{"empty_7"},
				{"empty_8"},
				{"modifier_woda_talent_mask1", "#woda_talent_mask1", 2, "mask1", {}},
				{"modifier_woda_talent_yasha", "#woda_talent_yasha", 1, "yasha", {"modifier_woda_talent_agi6",1}}
			},
			[4] = {
				{"modifier_legion_commander_11","#modifier_legion_commander_11", 1, "legion_commander/11", {}},
				{"modifier_woda_talent_speed2", "#woda_talent_speed2", 3, "speed2", {"modifier_woda_talent_speed1",2}},
				{"modifier_woda_talent_grovebow", "#woda_talent_grovebow", 2, "grovebow", {}},
				{"empty_10"},			
				{"modifier_woda_talent_agi4", "#woda_talent_agi4", 1, "agi4", {"modifier_woda_talent_yasha",1}}
			},
			[5] = {
				{"modifier_woda_talent_attack2", "#woda_talent_attack2", 3, "attack2", {}},
				{"modifier_legion_commander_12","#modifier_legion_commander_12", 2, "legion_commander/12", {}},
				{"empty_11"},
				{"empty_12"},
				{"modifier_woda_talent_agi5", "#woda_talent_agi5", 3, "agi5", {"modifier_woda_talent_agi4",1}}
			},
			[6] = {
				{"modifier_woda_talent_miss2", "#woda_talent_miss2", 2, "miss2", {}},
				{"empty_13"},
				{"modifier_woda_talent_attackspeed2", "#woda_talent_attackspeed2", 3, "attackspeed2", {}},
				{"modifier_legion_commander_18","#modifier_legion_commander_18", 3, "legion_commander/18", {}},
				{"empty_16"}
			},
			[7] = {
				{"empty_17"},
				{"empty_18"},
				{"modifier_legion_commander_14","#modifier_legion_commander_14", 1, "legion_commander/14", {}},
				{"empty_20"},
				{"empty_21"}
			}
		},
		[3] = {
			[1] = {
				{"modifier_woda_talent_mp1", "#woda_talent_mp1", 3, "mp1", {}},
				{"modifier_woda_talent_regenmp1", "#woda_talent_regenmp1", 2, "regenmp1", {}},
				{"modifier_woda_talent_spell", "#woda_talent_spell", 3, "spell", {}},
				{"modifier_legion_commander_15","#modifier_legion_commander_15", 3, "legion_commander/15", {}},
				{"modifier_woda_talent_int3", "#woda_talent_int3", 2, "int3", {}}
			},
			[2] = {
				{"empty_2"},
				{"empty_3"},
				{"modifier_legion_commander_16","#modifier_legion_commander_16", 1, "legion_commander/16", {}},
				{"modifier_woda_talent_blood", "#woda_talent_blood", 2, "blood", {}},
				{"modifier_woda_talent_int6", "#woda_talent_int6", 1, "int6", {"modifier_woda_talent_int3",2}}
			},
			[3] = {
				{"empty_6"},
				{"empty_7"},
				{"modifier_legion_commander_17","#modifier_legion_commander_17", 2, "legion_commander/17", {}},
				{"modifier_woda_talent_mask2", "#woda_talent_mask2", 2, "mask2", {}},
				{"modifier_woda_talent_kaya", "#woda_talent_kaya", 1, "kaya", {"modifier_woda_talent_int6",1}}
			},
			[4] = {
				{"modifier_woda_talent_mp2", "#woda_talent_mp2", 3, "mp2", {"modifier_woda_talent_mp1",3}},
				{"modifier_woda_talent_fairy", "#woda_talent_fairy", 2, "fairy", {}},
				{"empty_9"},
				{"modifier_legion_commander_13","#modifier_legion_commander_13", 3, "legion_commander/13", {}},
				{"modifier_woda_talent_int4", "#woda_talent_int4", 1, "int4", {"modifier_woda_talent_kaya",1}}
			},
			[5] = {
				{"modifier_woda_talent_spellprism", "#woda_talent_spellprism", 3, "spellprism", {}},
				{"empty_11"},
				{"modifier_legion_commander_19","#modifier_legion_commander_19", 2, "legion_commander/19", {}},
				{"empty_12"},
				{"modifier_woda_talent_int5", "#woda_talent_int5", 3, "int5", {"modifier_woda_talent_int4",1}}
			},
			[6] = {
				{"modifier_woda_talent_timeless", "#woda_talent_timeless", 2, "timeless", {}},
				{"modifier_woda_talent_regenmp2", "#woda_talent_regenmp2", 3, "regenmp2", {}},
				{"modifier_legion_commander_20","#modifier_legion_commander_20", 2, "legion_commander/20", {}},
				{"empty_15"},
				{"empty_16"}
			},
			[7] = {
				{"empty_17"},
				{"empty_18"},
				{"modifier_legion_commander_21","#modifier_legion_commander_21", 1, "legion_commander/21", {}},
				{"empty_20"},
				{"empty_21"}
			}
		}
	},
	["npc_dota_hero_lion"] = {
		[1] = {
			[1] = {
				{"modifier_woda_talent_hp1", "#woda_talent_hp1", 3, "hp1", {}},
				{"modifier_woda_talent_regenhp1", "#woda_talent_regenhp1", 2, "regenhp1", {}},
				{"modifier_lion_2","#modifier_lion_2", 1, "lion/2", {}},
				{"modifier_woda_talent_attack1", "#woda_talent_attack1", 3, "attack1", {}},
				{"modifier_woda_talent_str3", "#woda_talent_str3", 2, "str3", {}}
			},
			[2] = {
				{"empty_2"},
				{"modifier_lion_1","#modifier_lion_1", 2, "lion/1", {}},
				{"empty_3"},
				{"modifier_woda_talent_cloak", "#woda_talent_cloak", 2, "cloak", {}},
				{"modifier_woda_talent_str6", "#woda_talent_str6", 1, "str6", {"modifier_woda_talent_str3",2}}
			},
			[3] = {
				{"empty_6"},
				{"modifier_woda_talent_quickhp", "#woda_talent_quickhp", 2, "quickhp", {}},
				{"empty_8"},
				{"modifier_lion_3","#modifier_lion_3", 2, "lion/3", {}},
				{"modifier_woda_talent_sasha", "#woda_talent_sasha", 1, "sasha", {"modifier_woda_talent_str6",1}}
			},
			[4] = {
				{"modifier_woda_talent_hp2", "#woda_talent_hp2", 3, "hp2", {"modifier_woda_talent_hp1",3}},
				{"empty_9"},
				{"modifier_lion_4","#modifier_lion_4", 3, "lion/4", {"modifier_lion_2",1}},
				{"modifier_woda_talent_octar", "#woda_talent_octar", 2, "octar", {}},
				{"modifier_woda_talent_str4", "#woda_talent_str4", 1, "str4", {"modifier_woda_talent_sasha",1}}
			},
			[5] = {
				{"modifier_woda_talent_armor2", "#woda_talent_armor2", 3, "armor2", {}},
				{"empty_10"},
				{"empty_11"},
				{"modifier_lion_5","#modifier_lion_5", 2, "lion/5", {}},
				{"modifier_woda_talent_str5", "#woda_talent_str5", 3, "str5", {"modifier_woda_talent_str4",1}}
			},
			[6] = {
				{"modifier_woda_talent_sliver", "#woda_talent_sliver", 2, "sliver", {}},
				{"modifier_woda_talent_regenhp2", "#woda_talent_regenhp2", 3, "regenhp2", {}},
				{"modifier_lion_6","#modifier_lion_6", 3, "lion/6", {}},
				{"empty_15"},
				{"empty_16"}
			},
			[7] = {
				{"empty_17"},
				{"empty_18"},
				{"modifier_lion_7","#modifier_lion_7", 1, "lion/7", {}},
				{"empty_20"},
				{"empty_21"}
			}
		},
		[2] = {
			[1] = {
				{"modifier_woda_talent_armor1", "#woda_talent_armor1", 3, "armor1", {}},
				{"modifier_woda_talent_speed1", "#woda_talent_speed1", 2, "speed1", {}},
				{"modifier_woda_talent_attackspeed1", "#woda_talent_attackspeed1", 3, "attackspeed1", {}},
				{"modifier_lion_8","#modifier_lion_8", 2, "lion/8", {}},
				{"modifier_woda_talent_agi3", "#woda_talent_agi3", 2, "agi3", {}}
			},
			[2] = {
				{"empty_2"},
				{"empty_3"},
				{"modifier_lion_9","#modifier_lion_9", 3, "lion/9", {}},
				{"modifier_woda_talent_miss1", "#woda_talent_miss1", 2, "miss1", {}},
				{"modifier_woda_talent_agi6", "#woda_talent_agi6", 1, "agi6", {"modifier_woda_talent_agi3",2}}
			},
			[3] = {
				{"empty_6"},
				{"empty_7"},
				{"modifier_lion_10","#modifier_lion_10", 2, "lion/10", {"modifier_lion_9",3}},
				{"modifier_woda_talent_mask1", "#woda_talent_mask1", 2, "mask1", {}},
				{"modifier_woda_talent_yasha", "#woda_talent_yasha", 1, "yasha", {"modifier_woda_talent_agi6",1}}
			},
			[4] = {
				{"modifier_lion_11","#modifier_lion_11", 1, "lion/11", {}},
				{"modifier_woda_talent_speed2", "#woda_talent_speed2", 3, "speed2", {"modifier_woda_talent_speed1",2}},
				{"modifier_woda_talent_grovebow", "#woda_talent_grovebow", 2, "grovebow", {}},
				{"empty_10"},			
				{"modifier_woda_talent_agi4", "#woda_talent_agi4", 1, "agi4", {"modifier_woda_talent_yasha",1}}
			},
			[5] = {
				{"modifier_woda_talent_attack2", "#woda_talent_attack2", 3, "attack2", {}},
				{"modifier_lion_12","#modifier_lion_12", 3, "lion/12", {}},
				{"empty_11"},
				{"empty_12"},
				{"modifier_woda_talent_agi5", "#woda_talent_agi5", 3, "agi5", {"modifier_woda_talent_agi4",1}}
			},
			[6] = {
				{"modifier_woda_talent_miss2", "#woda_talent_miss2", 2, "miss2", {}},
				{"modifier_lion_13","#modifier_lion_13", 2, "lion/13", {"modifier_lion_12",3}},
				{"modifier_woda_talent_attackspeed2", "#woda_talent_attackspeed2", 3, "attackspeed2", {}},
				{"empty_13"},
				{"empty_16"}
			},
			[7] = {
				{"empty_17"},
				{"empty_18"},
				{"modifier_lion_14","#modifier_lion_14", 1, "lion/14", {}},
				{"empty_20"},
				{"empty_21"}
			}
		},
		[3] = {
			[1] = {
				{"modifier_woda_talent_mp1", "#woda_talent_mp1", 3, "mp1", {}},
				{"modifier_woda_talent_regenmp1", "#woda_talent_regenmp1", 2, "regenmp1", {}},
				{"modifier_woda_talent_spell", "#woda_talent_spell", 3, "spell", {}},
				{"modifier_lion_20","#modifier_lion_20", 3, "lion/20", {}},
				{"modifier_woda_talent_int3", "#woda_talent_int3", 2, "int3", {}}
			},
			[2] = {
				{"empty_2"},
				{"modifier_lion_15","#modifier_lion_15", 1, "lion/15", {}},
				{"empty_3"},
				{"modifier_woda_talent_blood", "#woda_talent_blood", 2, "blood", {}},
				{"modifier_woda_talent_int6", "#woda_talent_int6", 1, "int6", {"modifier_woda_talent_int3",2}}
			},
			[3] = {
				{"empty_6"},
				{"empty_7"},
				{"modifier_lion_17","#modifier_lion_17", 1, "lion/17", {}},
				{"modifier_woda_talent_mask2", "#woda_talent_mask2", 2, "mask2", {}},
				{"modifier_woda_talent_kaya", "#woda_talent_kaya", 1, "kaya", {"modifier_woda_talent_int6",1}}
			},
			[4] = {
				{"modifier_woda_talent_mp2", "#woda_talent_mp2", 3, "mp2", {"modifier_woda_talent_mp1",3}},
				{"modifier_woda_talent_fairy", "#woda_talent_fairy", 2, "fairy", {}},
				{"empty_9"},
				{"modifier_lion_16","#modifier_lion_16", 3, "lion/16", {}},
				{"modifier_woda_talent_int4", "#woda_talent_int4", 1, "int4", {"modifier_woda_talent_kaya",1}}
			},
			[5] = {
				{"modifier_woda_talent_spellprism", "#woda_talent_spellprism", 3, "spellprism", {}},
				{"empty_10"},
				{"empty_11"},
				{"modifier_lion_19","#modifier_lion_19", 2, "lion/19", {}},
				{"modifier_woda_talent_int5", "#woda_talent_int5", 3, "int5", {"modifier_woda_talent_int4",1}}
			},
			[6] = {
				{"modifier_woda_talent_timeless", "#woda_talent_timeless", 2, "timeless", {}},
				{"modifier_woda_talent_regenmp2", "#woda_talent_regenmp2", 3, "regenmp2", {}},
				{"modifier_lion_18","#modifier_lion_18", 3, "lion/18", {}},
				{"empty_15"},
				{"empty_16"}
			},
			[7] = {
				{"empty_17"},
				{"empty_18"},
				{"modifier_lion_21","#modifier_lion_21", 1, "lion/21", {}},
				{"empty_20"},
				{"empty_21"}
			}
		}
	},
	["npc_dota_hero_slardar"] = {
		[1] = {
			[1] = {
				{"modifier_woda_talent_hp1", "#woda_talent_hp1", 3, "hp1", {}},
				{"modifier_woda_talent_regenhp1", "#woda_talent_regenhp1", 2, "regenhp1", {}},
				{"modifier_woda_talent_attack1", "#woda_talent_attack1", 3, "attack1", {}},
				{"modifier_slardar_1","#modifier_slardar_1", 2, "slardar/1", {}},
				{"modifier_woda_talent_str3", "#woda_talent_str3", 2, "str3", {}}
			},
			[2] = {
				{"empty_2"},
				{"modifier_slardar_2","#modifier_slardar_2", 3, "slardar/2", {}},
				{"empty_3"},
				{"modifier_woda_talent_cloak", "#woda_talent_cloak", 2, "cloak", {}},
				{"modifier_woda_talent_str6", "#woda_talent_str6", 1, "str6", {"modifier_woda_talent_str3",2}}
			},
			[3] = {
				{"empty_6"},
				{"modifier_woda_talent_quickhp", "#woda_talent_quickhp", 2, "quickhp", {}},
				{"empty_8"},
				{"modifier_slardar_6","#modifier_slardar_6", 2, "slardar/6", {}},
				{"modifier_woda_talent_sasha", "#woda_talent_sasha", 1, "sasha", {"modifier_woda_talent_str6",1}}
			},
			[4] = {
				{"modifier_woda_talent_hp2", "#woda_talent_hp2", 3, "hp2", {"modifier_woda_talent_hp1",3}},
				{"modifier_slardar_5","#modifier_slardar_5", 1, "slardar/5", {}},
				{"empty_9"},
				{"modifier_woda_talent_octar", "#woda_talent_octar", 2, "octar", {}},
				{"modifier_woda_talent_str4", "#woda_talent_str4", 1, "str4", {"modifier_woda_talent_sasha",1}}
			},
			[5] = {
				{"modifier_woda_talent_armor2", "#woda_talent_armor2", 3, "armor2", {}},
				{"empty_10"},
				{"empty_11"},
				{"modifier_slardar_4","#modifier_slardar_4", 3, "slardar/4", {}},
				{"modifier_woda_talent_str5", "#woda_talent_str5", 3, "str5", {"modifier_woda_talent_str4",1}}
			},
			[6] = {
				{"modifier_woda_talent_sliver", "#woda_talent_sliver", 2, "sliver", {}},
				{"modifier_woda_talent_regenhp2", "#woda_talent_regenhp2", 3, "regenhp2", {}},
				{"modifier_slardar_3","#modifier_slardar_3", 2, "slardar/3", {}},
				{"empty_15"},
				{"empty_16"}
			},
			[7] = {
				{"empty_17"},
				{"empty_18"},
				{"modifier_slardar_7","#modifier_slardar_7", 1, "slardar/7", {}},
				{"empty_20"},
				{"empty_21"}
			}
		},
		[2] = {
			[1] = {
				{"modifier_woda_talent_armor1", "#woda_talent_armor1", 3, "armor1", {}},
				{"modifier_woda_talent_speed1", "#woda_talent_speed1", 2, "speed1", {}},
				{"modifier_woda_talent_attackspeed1", "#woda_talent_attackspeed1", 3, "attackspeed1", {}},
				{"modifier_slardar_8","#modifier_slardar_8", 2, "slardar/8", {}},
				{"modifier_woda_talent_agi3", "#woda_talent_agi3", 2, "agi3", {}}
			},
			[2] = {
				{"modifier_slardar_9","#modifier_slardar_9", 2, "slardar/9", {}},
				{"empty_3"},
				{"empty_4"},
				{"modifier_woda_talent_miss1", "#woda_talent_miss1", 2, "miss1", {}},
				{"modifier_woda_talent_agi6", "#woda_talent_agi6", 1, "agi6", {"modifier_woda_talent_agi3",2}}
			},
			[3] = {
				{"empty_6"},
				{"empty_7"},
				{"modifier_slardar_10","#modifier_slardar_10", 2, "slardar/10", {}},
				{"modifier_woda_talent_mask1", "#woda_talent_mask1", 2, "mask1", {}},
				{"modifier_woda_talent_yasha", "#woda_talent_yasha", 1, "yasha", {"modifier_woda_talent_agi6",1}}
			},
			[4] = {
				{"modifier_slardar_11","#modifier_slardar_11", 3, "slardar/11", {}},
				{"modifier_woda_talent_speed2", "#woda_talent_speed2", 3, "speed2", {"modifier_woda_talent_speed1",2}},
				{"modifier_woda_talent_grovebow", "#woda_talent_grovebow", 2, "grovebow", {}},
				{"empty_10"},			
				{"modifier_woda_talent_agi4", "#woda_talent_agi4", 1, "agi4", {"modifier_woda_talent_yasha",1}}
			},
			[5] = {
				{"modifier_woda_talent_attack2", "#woda_talent_attack2", 3, "attack2", {}},
				{"modifier_slardar_13","#modifier_slardar_13", 1, "slardar/13", {}},
				{"empty_11"},
				{"empty_12"},
				{"modifier_woda_talent_agi5", "#woda_talent_agi5", 3, "agi5", {"modifier_woda_talent_agi4",1}}
			},
			[6] = {
				{"modifier_woda_talent_miss2", "#woda_talent_miss2", 2, "miss2", {}},
				{"empty_13"},
				{"modifier_woda_talent_attackspeed2", "#woda_talent_attackspeed2", 3, "attackspeed2", {}},
				{"empty_15"},
				{"modifier_slardar_18","#modifier_slardar_18", 3, "slardar/18", {}}
			},
			[7] = {
				{"empty_17"},
				{"empty_18"},
				{"modifier_slardar_14","#modifier_slardar_14", 1, "slardar/14", {}},
				{"empty_20"},
				{"empty_21"}
			}
		},
		[3] = {
			[1] = {
				{"modifier_woda_talent_mp1", "#woda_talent_mp1", 3, "mp1", {}},
				{"modifier_woda_talent_regenmp1", "#woda_talent_regenmp1", 2, "regenmp1", {}},
				{"modifier_woda_talent_spell", "#woda_talent_spell", 3, "spell", {}},
				{"modifier_slardar_12","#modifier_slardar_12", 3, "slardar/12", {}},
				{"modifier_woda_talent_int3", "#woda_talent_int3", 2, "int3", {}}
			},
			[2] = {
				{"empty_2"},
				{"empty_3"},
				{"modifier_slardar_20","#modifier_slardar_20", 3, "slardar/20", {}},
				{"modifier_woda_talent_blood", "#woda_talent_blood", 2, "blood", {}},
				{"modifier_woda_talent_int6", "#woda_talent_int6", 1, "int6", {"modifier_woda_talent_int3",2}}
			},
			[3] = {
				{"empty_6"},
				{"empty_7"},
				{"modifier_slardar_17","#modifier_slardar_17", 1, "slardar/17", {}},
				{"modifier_woda_talent_mask2", "#woda_talent_mask2", 2, "mask2", {}},
				{"modifier_woda_talent_kaya", "#woda_talent_kaya", 1, "kaya", {"modifier_woda_talent_int6",1}}
			},
			[4] = {
				{"modifier_woda_talent_mp2", "#woda_talent_mp2", 3, "mp2", {"modifier_woda_talent_mp1",3}},
				{"modifier_woda_talent_fairy", "#woda_talent_fairy", 2, "fairy", {}},
				{"modifier_slardar_19","#modifier_slardar_19", 1, "slardar/19", {}},
				{"empty_9"},
				{"modifier_woda_talent_int4", "#woda_talent_int4", 1, "int4", {"modifier_woda_talent_kaya",1}}
			},
			[5] = {
				{"modifier_woda_talent_spellprism", "#woda_talent_spellprism", 3, "spellprism", {}},
				{"empty_10"},
				{"empty_11"},
				{"modifier_slardar_16","#modifier_slardar_16", 2, "slardar/16", {}},
				{"modifier_woda_talent_int5", "#woda_talent_int5", 3, "int5", {"modifier_woda_talent_int4",1}}
			},
			[6] = {
				{"modifier_woda_talent_timeless", "#woda_talent_timeless", 2, "timeless", {}},
				{"modifier_woda_talent_regenmp2", "#woda_talent_regenmp2", 3, "regenmp2", {}},
				{"empty_14"},
				{"empty_15"},
				{"modifier_slardar_15","#modifier_slardar_15", 3, "slardar/15", {}}
			},
			[7] = {
				{"empty_17"},
				{"empty_18"},
				{"modifier_slardar_21","#modifier_slardar_21", 1, "slardar/21", {}},
				{"empty_20"},
				{"empty_21"}
			}
		}
	},
	["npc_dota_hero_kunkka"] = {
		[1] = {
			[1] = {
				{"modifier_woda_talent_hp1", "#woda_talent_hp1", 3, "hp1", {}},
				{"modifier_woda_talent_regenhp1", "#woda_talent_regenhp1", 2, "regenhp1", {}},
				{"modifier_woda_talent_attack1", "#woda_talent_attack1", 3, "attack1", {}},
				{"modifier_kunkka_1","#modifier_kunkka_1", 3, "kunkka/1", {}},
				{"modifier_woda_talent_str3", "#woda_talent_str3", 2, "str3", {}}
			},
			[2] = {
				{"empty_2"},
				{"empty_3"},
				{"modifier_kunkka_3","#modifier_kunkka_3", 2, "kunkka/3", {}},
				{"modifier_woda_talent_cloak", "#woda_talent_cloak", 2, "cloak", {}},
				{"modifier_woda_talent_str6", "#woda_talent_str6", 1, "str6", {"modifier_woda_talent_str3",2}}
			},
			[3] = {
				{"empty_6"},
				{"modifier_woda_talent_quickhp", "#woda_talent_quickhp", 2, "quickhp", {}},
				{"modifier_kunkka_4","#modifier_kunkka_4", 3, "kunkka/4", {}},
				{"empty_8"},
				{"modifier_woda_talent_sasha", "#woda_talent_sasha", 1, "sasha", {"modifier_woda_talent_str6",1}}
			},
			[4] = {
				{"modifier_woda_talent_hp2", "#woda_talent_hp2", 3, "hp2", {"modifier_woda_talent_hp1",3}},
				{"modifier_kunkka_2","#modifier_kunkka_2", 3, "kunkka/2", {}},
				{"empty_9"},
				{"modifier_woda_talent_octar", "#woda_talent_octar", 2, "octar", {}},
				{"modifier_woda_talent_str4", "#woda_talent_str4", 1, "str4", {"modifier_woda_talent_sasha",1}}
			},
			[5] = {
				{"modifier_woda_talent_armor2", "#woda_talent_armor2", 3, "armor2", {}},
				{"modifier_kunkka_6","#modifier_kunkka_6", 1, "kunkka/6", {}},
				{"empty_10"},
				{"empty_11"},
				{"modifier_woda_talent_str5", "#woda_talent_str5", 3, "str5", {"modifier_woda_talent_str4",1}}
			},
			[6] = {
				{"modifier_woda_talent_sliver", "#woda_talent_sliver", 2, "sliver", {}},
				{"modifier_woda_talent_regenhp2", "#woda_talent_regenhp2", 3, "regenhp2", {}},
				{"empty_14"},
				{"empty_15"},
				{"modifier_kunkka_5","#modifier_kunkka_5", 1, "kunkka/5", {}}
			},
			[7] = {
				{"empty_17"},
				{"empty_18"},
				{"modifier_kunkka_7","#modifier_kunkka_7", 1, "kunkka/7", {}},
				{"empty_20"},
				{"empty_21"}
			}
		},
		[2] = {
			[1] = {
				{"modifier_woda_talent_armor1", "#woda_talent_armor1", 3, "armor1", {}},
				{"modifier_woda_talent_speed1", "#woda_talent_speed1", 2, "speed1", {}},
				{"modifier_woda_talent_attackspeed1", "#woda_talent_attackspeed1", 3, "attackspeed1", {}},
				{"modifier_kunkka_8","#modifier_kunkka_8", 1, "kunkka/8", {}},
				{"modifier_woda_talent_agi3", "#woda_talent_agi3", 2, "agi3", {}}
			},
			[2] = {
				{"empty_3"},
				{"empty_4"},
				{"modifier_kunkka_9","#modifier_kunkka_9", 3, "kunkka/9", {}},
				{"modifier_woda_talent_miss1", "#woda_talent_miss1", 2, "miss1", {}},
				{"modifier_woda_talent_agi6", "#woda_talent_agi6", 1, "agi6", {"modifier_woda_talent_agi3",2}}
			},
			[3] = {
				{"modifier_kunkka_10","#modifier_kunkka_10", 1, "kunkka/10", {}},
				{"empty_7"},
				{"empty_8"},
				{"modifier_woda_talent_mask1", "#woda_talent_mask1", 2, "mask1", {}},
				{"modifier_woda_talent_yasha", "#woda_talent_yasha", 1, "yasha", {"modifier_woda_talent_agi6",1}}
			},
			[4] = {
				{"modifier_kunkka_11","#modifier_kunkka_11", 2, "kunkka/11", {}},
				{"modifier_woda_talent_speed2", "#woda_talent_speed2", 3, "speed2", {"modifier_woda_talent_speed1",2}},
				{"modifier_woda_talent_grovebow", "#woda_talent_grovebow", 2, "grovebow", {}},
				{"empty_10"},			
				{"modifier_woda_talent_agi4", "#woda_talent_agi4", 1, "agi4", {"modifier_woda_talent_yasha",1}}
			},
			[5] = {
				{"modifier_woda_talent_attack2", "#woda_talent_attack2", 3, "attack2", {}},
				{"empty_11"},
				{"modifier_kunkka_12","#modifier_kunkka_12", 3, "kunkka/12", {}},
				{"empty_12"},
				{"modifier_woda_talent_agi5", "#woda_talent_agi5", 3, "agi5", {"modifier_woda_talent_agi4",1}}
			},
			[6] = {
				{"modifier_woda_talent_miss2", "#woda_talent_miss2", 2, "miss2", {}},
				{"empty_13"},
				{"modifier_woda_talent_attackspeed2", "#woda_talent_attackspeed2", 3, "attackspeed2", {}},
				{"modifier_kunkka_13","#modifier_kunkka_13", 3, "kunkka/13", {}},
				{"empty_16"}
			},
			[7] = {
				{"empty_17"},
				{"empty_18"},
				{"modifier_kunkka_14","#modifier_kunkka_14", 1, "kunkka/14", {}},
				{"empty_20"},
				{"empty_21"}
			}
		},
		[3] = {
			[1] = {
				{"modifier_woda_talent_mp1", "#woda_talent_mp1", 3, "mp1", {}},
				{"modifier_woda_talent_regenmp1", "#woda_talent_regenmp1", 2, "regenmp1", {}},
				{"modifier_kunkka_16","#modifier_kunkka_16", 1, "kunkka/16", {}},
				{"modifier_woda_talent_spell", "#woda_talent_spell", 3, "spell", {}},
				{"modifier_woda_talent_int3", "#woda_talent_int3", 2, "int3", {}}
			},
			[2] = {
				{"empty_2"},
				{"empty_3"},
				{"modifier_kunkka_19","#modifier_kunkka_19", 3, "kunkka/19", {"modifier_kunkka_16",1}},
				{"modifier_woda_talent_blood", "#woda_talent_blood", 2, "blood", {}},
				{"modifier_woda_talent_int6", "#woda_talent_int6", 1, "int6", {"modifier_woda_talent_int3",2}}
			},
			[3] = {
				{"empty_6"},
				{"modifier_kunkka_15","#modifier_kunkka_15", 3, "kunkka/15", {}},
				{"empty_7"},
				{"modifier_woda_talent_mask2", "#woda_talent_mask2", 2, "mask2", {}},
				{"modifier_woda_talent_kaya", "#woda_talent_kaya", 1, "kaya", {"modifier_woda_talent_int6",1}}
			},
			[4] = {
				{"modifier_woda_talent_mp2", "#woda_talent_mp2", 3, "mp2", {"modifier_woda_talent_mp1",3}},
				{"modifier_woda_talent_fairy", "#woda_talent_fairy", 2, "fairy", {}},
				{"modifier_kunkka_18","#modifier_kunkka_18", 3, "kunkka/18", {}},
				{"empty_9"},
				{"modifier_woda_talent_int4", "#woda_talent_int4", 1, "int4", {"modifier_woda_talent_kaya",1}}
			},
			[5] = {
				{"modifier_woda_talent_spellprism", "#woda_talent_spellprism", 3, "spellprism", {}},
				{"modifier_kunkka_20","#modifier_kunkka_20", 1, "kunkka/20", {}},
				{"empty_10"},
				{"empty_11"},
				{"modifier_woda_talent_int5", "#woda_talent_int5", 3, "int5", {"modifier_woda_talent_int4",1}}
			},
			[6] = {
				{"modifier_woda_talent_timeless", "#woda_talent_timeless", 2, "timeless", {}},
				{"modifier_woda_talent_regenmp2", "#woda_talent_regenmp2", 3, "regenmp2", {}},
				{"empty_14"},
				{"empty_15"},
				{"modifier_kunkka_17","#modifier_kunkka_17", 2, "kunkka/17", {}}
			},
			[7] = {
				{"empty_17"},
				{"empty_18"},
				{"modifier_kunkka_21","#modifier_kunkka_21", 1, "kunkka/21", {}},
				{"empty_20"},
				{"empty_21"}
			}
		}
	},
	["npc_dota_hero_slark"] = {
		[1] = {
			[1] = {
				{"modifier_woda_talent_hp1", "#woda_talent_hp1", 3, "hp1", {}},
				{"modifier_woda_talent_regenhp1", "#woda_talent_regenhp1", 2, "regenhp1", {}},
				{"modifier_woda_talent_attack1", "#woda_talent_attack1", 3, "attack1", {}},
				{"modifier_slark_1","#modifier_slark_1", 1, "slark/1", {}},
				{"modifier_woda_talent_str3", "#woda_talent_str3", 2, "str3", {}}
			},
			[2] = {
				{"empty_2"},
				{"modifier_slark_6","#modifier_slark_6", 3, "slark/6", {}},
				{"empty_3"},
				{"modifier_woda_talent_cloak", "#woda_talent_cloak", 2, "cloak", {}},
				{"modifier_woda_talent_str6", "#woda_talent_str6", 1, "str6", {"modifier_woda_talent_str3",2}}
			},
			[3] = {
				{"empty_6"},
				{"modifier_woda_talent_quickhp", "#woda_talent_quickhp", 2, "quickhp", {}},
				{"empty_8"},
				{"modifier_slark_3","#modifier_slark_3", 2, "slark/3", {}},
				{"modifier_woda_talent_sasha", "#woda_talent_sasha", 1, "sasha", {"modifier_woda_talent_str6",1}}
			},
			[4] = {
				{"modifier_woda_talent_hp2", "#woda_talent_hp2", 3, "hp2", {"modifier_woda_talent_hp1",3}},
				{"modifier_slark_5","#modifier_slark_5", 3, "slark/5", {}},
				{"empty_9"},
				{"modifier_woda_talent_octar", "#woda_talent_octar", 2, "octar", {}},
				{"modifier_woda_talent_str4", "#woda_talent_str4", 1, "str4", {"modifier_woda_talent_sasha",1}}
			},
			[5] = {
				{"modifier_woda_talent_armor2", "#woda_talent_armor2", 3, "armor2", {}},
				{"modifier_slark_4","#modifier_slark_4", 1, "slark/4", {}},
				{"empty_10"},
				{"empty_11"},
				{"modifier_woda_talent_str5", "#woda_talent_str5", 3, "str5", {"modifier_woda_talent_str4",1}}
			},
			[6] = {
				{"modifier_woda_talent_sliver", "#woda_talent_sliver", 2, "sliver", {}},
				{"modifier_woda_talent_regenhp2", "#woda_talent_regenhp2", 3, "regenhp2", {}},
				{"modifier_slark_2","#modifier_slark_2", 3, "slark/2", {}},
				{"empty_15"},
				{"empty_16"}
			},
			[7] = {
				{"empty_17"},
				{"empty_18"},
				{"modifier_slark_7","#modifier_slark_7", 1, "slark/7", {}},
				{"empty_20"},
				{"empty_21"}
			}
		},
		[2] = {
			[1] = {
				{"modifier_woda_talent_armor1", "#woda_talent_armor1", 3, "armor1", {}},
				{"modifier_woda_talent_speed1", "#woda_talent_speed1", 2, "speed1", {}},
				{"modifier_woda_talent_attackspeed1", "#woda_talent_attackspeed1", 3, "attackspeed1", {}},
				{"modifier_slark_8","#modifier_slark_8", 2, "slark/8", {}},
				{"modifier_woda_talent_agi3", "#woda_talent_agi3", 2, "agi3", {}}
			},
			[2] = {
				{"modifier_slark_9","#modifier_slark_9", 2, "slark/9", {}},
				{"empty_3"},
				{"empty_4"},
				{"modifier_woda_talent_miss1", "#woda_talent_miss1", 2, "miss1", {}},
				{"modifier_woda_talent_agi6", "#woda_talent_agi6", 1, "agi6", {"modifier_woda_talent_agi3",2}}
			},
			[3] = {
				{"modifier_slark_10","#modifier_slark_10", 3, "slark/10", {}},
				{"empty_7"},
				{"empty_8"},
				{"modifier_woda_talent_mask1", "#woda_talent_mask1", 2, "mask1", {}},
				{"modifier_woda_talent_yasha", "#woda_talent_yasha", 1, "yasha", {"modifier_woda_talent_agi6",1}}
			},
			[4] = {
				{"empty_10"},
				{"modifier_woda_talent_speed2", "#woda_talent_speed2", 3, "speed2", {"modifier_woda_talent_speed1",2}},
				{"modifier_woda_talent_grovebow", "#woda_talent_grovebow", 2, "grovebow", {}},
				{"modifier_slark_11","#modifier_slark_11", 2, "slark/11", {}},			
				{"modifier_woda_talent_agi4", "#woda_talent_agi4", 1, "agi4", {"modifier_woda_talent_yasha",1}}
			},
			[5] = {
				{"modifier_woda_talent_attack2", "#woda_talent_attack2", 3, "attack2", {}},
				{"empty_11"},
				{"empty_12"},
				{"modifier_slark_12","#modifier_slark_12", 2, "slark/12", {}},
				{"modifier_woda_talent_agi5", "#woda_talent_agi5", 3, "agi5", {"modifier_woda_talent_agi4",1}}
			},
			[6] = {
				{"modifier_woda_talent_miss2", "#woda_talent_miss2", 2, "miss2", {}},
				{"empty_13"},
				{"modifier_woda_talent_attackspeed2", "#woda_talent_attackspeed2", 3, "attackspeed2", {}},
				{"modifier_slark_13","#modifier_slark_13", 2, "slark/13", {}},
				{"empty_16"}
			},
			[7] = {
				{"empty_17"},
				{"empty_18"},
				{"modifier_slark_14","#modifier_slark_14", 1, "slark/14", {}},
				{"empty_20"},
				{"empty_21"}
			}
		},
		[3] = {
			[1] = {
				{"modifier_woda_talent_mp1", "#woda_talent_mp1", 3, "mp1", {}},
				{"modifier_woda_talent_regenmp1", "#woda_talent_regenmp1", 2, "regenmp1", {}},
				{"modifier_woda_talent_spell", "#woda_talent_spell", 3, "spell", {}},
				{"modifier_slark_15","#modifier_slark_15", 1, "slark/15", {}},
				{"modifier_woda_talent_int3", "#woda_talent_int3", 2, "int3", {}}
			},
			[2] = {
				{"empty_2"},
				{"modifier_slark_16","#modifier_slark_16", 2, "slark/16", {}},
				{"empty_3"},
				{"modifier_woda_talent_blood", "#woda_talent_blood", 2, "blood", {}},
				{"modifier_woda_talent_int6", "#woda_talent_int6", 1, "int6", {"modifier_woda_talent_int3",2}}
			},
			[3] = {
				{"empty_6"},
				{"empty_7"},
				{"modifier_slark_17","#modifier_slark_17", 3, "slark/17", {}},
				{"modifier_woda_talent_mask2", "#woda_talent_mask2", 2, "mask2", {}},
				{"modifier_woda_talent_kaya", "#woda_talent_kaya", 1, "kaya", {"modifier_woda_talent_int6",1}}
			},
			[4] = {
				{"modifier_woda_talent_mp2", "#woda_talent_mp2", 3, "mp2", {"modifier_woda_talent_mp1",3}},
				{"modifier_woda_talent_fairy", "#woda_talent_fairy", 2, "fairy", {}},
				{"modifier_slark_18","#modifier_slark_18", 3, "slark/18", {}},
				{"empty_9"},
				{"modifier_woda_talent_int4", "#woda_talent_int4", 1, "int4", {"modifier_woda_talent_kaya",1}}
			},
			[5] = {
				{"modifier_woda_talent_spellprism", "#woda_talent_spellprism", 3, "spellprism", {}},
				{"empty_10"},
				{"empty_11"},
				{"modifier_slark_19","#modifier_slark_19", 3, "slark/19", {}},
				{"modifier_woda_talent_int5", "#woda_talent_int5", 3, "int5", {"modifier_woda_talent_int4",1}}
			},
			[6] = {
				{"modifier_woda_talent_timeless", "#woda_talent_timeless", 2, "timeless", {}},
				{"modifier_woda_talent_regenmp2", "#woda_talent_regenmp2", 3, "regenmp2", {}},
				{"modifier_slark_20","#modifier_slark_20", 1, "slark/20", {"modifier_slark_18",3}},
				{"empty_15"},
				{"empty_16"}
			},
			[7] = {
				{"empty_17"},
				{"empty_18"},
				{"modifier_slark_21","#modifier_slark_21", 1, "slark/21", {}},
				{"empty_20"},
				{"empty_21"}
			}
		}
	},
	["npc_dota_hero_morphling"] = {
		[1] = {
			[1] = {
				{"modifier_woda_talent_hp1", "#woda_talent_hp1", 3, "hp1", {}},
				{"modifier_woda_talent_regenhp1", "#woda_talent_regenhp1", 2, "regenhp1", {}},
				{"modifier_woda_talent_attack1", "#woda_talent_attack1", 3, "attack1", {}},
				{"modifier_morphling_1","#modifier_morphling_1", 3, "morphling/1", {}},
				{"modifier_woda_talent_str3", "#woda_talent_str3", 2, "str3", {}}
			},
			[2] = {
				{"empty_2"},
				{"empty_3"},
				{"modifier_morphling_2","#modifier_morphling_2", 3, "morphling/2", {}},
				{"modifier_woda_talent_cloak", "#woda_talent_cloak", 2, "cloak", {}},
				{"modifier_woda_talent_str6", "#woda_talent_str6", 1, "str6", {"modifier_woda_talent_str3",2}}
			},
			[3] = {
				{"empty_6"},
				{"modifier_woda_talent_quickhp", "#woda_talent_quickhp", 2, "quickhp", {}},
				{"modifier_morphling_3","#modifier_morphling_3", 1, "morphling/3", {}},
				{"empty_9"},
				{"modifier_woda_talent_sasha", "#woda_talent_sasha", 1, "sasha", {"modifier_woda_talent_str6",1}}
			},
			[4] = {
				{"modifier_woda_talent_hp2", "#woda_talent_hp2", 3, "hp2", {"modifier_woda_talent_hp1",3}},
				{"empty_9"},
				{"modifier_morphling_4","#modifier_morphling_4", 3, "morphling/4", {"modifier_morphling_3",1}},
				{"modifier_woda_talent_octar", "#woda_talent_octar", 2, "octar", {}},
				{"modifier_woda_talent_str4", "#woda_talent_str4", 1, "str4", {"modifier_woda_talent_sasha",1}}
			},
			[5] = {
				{"modifier_woda_talent_armor2", "#woda_talent_armor2", 3, "armor2", {}},
				{"empty_10"},
				{"empty_11"},
				{"modifier_morphling_5","#modifier_morphling_5", 1, "morphling/5", {}},
				{"modifier_woda_talent_str5", "#woda_talent_str5", 3, "str5", {"modifier_woda_talent_str4",1}}
			},
			[6] = {
				{"modifier_woda_talent_sliver", "#woda_talent_sliver", 2, "sliver", {}},
				{"modifier_woda_talent_regenhp2", "#woda_talent_regenhp2", 3, "regenhp2", {}},
				{"modifier_morphling_6","#modifier_morphling_6", 2, "morphling/6", {}},
				{"empty_15"},
				{"empty_16"}
			},
			[7] = {
				{"empty_17"},
				{"empty_18"},
				{"modifier_morphling_7","#modifier_morphling_7", 1, "morphling/7", {}},
				{"empty_20"},
				{"empty_21"}
			}
		},
		[2] = {
			[1] = {
				{"modifier_woda_talent_armor1", "#woda_talent_armor1", 3, "armor1", {}},
				{"modifier_woda_talent_speed1", "#woda_talent_speed1", 2, "speed1", {}},
				{"modifier_woda_talent_attackspeed1", "#woda_talent_attackspeed1", 3, "attackspeed1", {}},
				{"modifier_morphling_8","#modifier_morphling_8", 3, "morphling/8", {}},
				{"modifier_woda_talent_agi3", "#woda_talent_agi3", 2, "agi3", {}}
			},
			[2] = {
				{"modifier_morphling_9","#modifier_morphling_9", 3, "morphling/9", {}},
				{"empty_3"},
				{"empty_4"},
				{"modifier_woda_talent_miss1", "#woda_talent_miss1", 2, "miss1", {}},
				{"modifier_woda_talent_agi6", "#woda_talent_agi6", 1, "agi6", {"modifier_woda_talent_agi3",2}}
			},
			[3] = {
				{"modifier_morphling_10","#modifier_morphling_10", 2, "morphling/10", {}},
				{"empty_7"},
				{"empty_8"},
				{"modifier_woda_talent_mask1", "#woda_talent_mask1", 2, "mask1", {}},
				{"modifier_woda_talent_yasha", "#woda_talent_yasha", 1, "yasha", {"modifier_woda_talent_agi6",1}}
			},
			[4] = {
				{"empty_10"},
				{"modifier_woda_talent_speed2", "#woda_talent_speed2", 3, "speed2", {"modifier_woda_talent_speed1",2}},
				{"modifier_woda_talent_grovebow", "#woda_talent_grovebow", 2, "grovebow", {}},
				{"modifier_morphling_12","#modifier_morphling_12", 3, "morphling/12", {}},			
				{"modifier_woda_talent_agi4", "#woda_talent_agi4", 1, "agi4", {"modifier_woda_talent_yasha",1}}
			},
			[5] = {
				{"modifier_woda_talent_attack2", "#woda_talent_attack2", 3, "attack2", {}},
				{"empty_11"},
				{"modifier_morphling_11","#modifier_morphling_11", 1, "morphling/11", {}},
				{"empty_12"},
				{"modifier_woda_talent_agi5", "#woda_talent_agi5", 3, "agi5", {"modifier_woda_talent_agi4",1}}
			},
			[6] = {
				{"modifier_woda_talent_miss2", "#woda_talent_miss2", 2, "miss2", {}},
				{"modifier_morphling_14","#modifier_morphling_14", 1, "morphling/14", {}},
				{"modifier_woda_talent_attackspeed2", "#woda_talent_attackspeed2", 3, "attackspeed2", {}},
				{"empty_15"},
				{"empty_16"}
			},
			[7] = {
				{"empty_17"},
				{"empty_18"},
				{"modifier_morphling_13","#modifier_morphling_13", 1, "morphling/13", {}},
				{"empty_20"},
				{"empty_21"}
			}
		},
		[3] = {
			[1] = {
				{"modifier_woda_talent_mp1", "#woda_talent_mp1", 3, "mp1", {}},
				{"modifier_woda_talent_regenmp1", "#woda_talent_regenmp1", 2, "regenmp1", {}},
				{"modifier_morphling_15","#modifier_morphling_15", 3, "morphling/15", {}},
				{"modifier_woda_talent_spell", "#woda_talent_spell", 3, "spell", {}},
				{"modifier_woda_talent_int3", "#woda_talent_int3", 2, "int3", {}}
			},
			[2] = {
				{"empty_2"},
				{"empty_3"},
				{"modifier_morphling_21","#modifier_morphling_21", 1, "morphling/21", {"modifier_morphling_15",3}},
				{"modifier_woda_talent_blood", "#woda_talent_blood", 2, "blood", {}},
				{"modifier_woda_talent_int6", "#woda_talent_int6", 1, "int6", {"modifier_woda_talent_int3",2}}
			},
			[3] = {
				{"empty_6"},
				{"empty_7"},
				{"modifier_morphling_17","#modifier_morphling_17", 3, "morphling/17", {"modifier_morphling_21",1}},
				{"modifier_woda_talent_mask2", "#woda_talent_mask2", 2, "mask2", {}},
				{"modifier_woda_talent_kaya", "#woda_talent_kaya", 1, "kaya", {"modifier_woda_talent_int6",1}}
			},
			[4] = {
				{"modifier_woda_talent_mp2", "#woda_talent_mp2", 3, "mp2", {"modifier_woda_talent_mp1",3}},
				{"modifier_woda_talent_fairy", "#woda_talent_fairy", 2, "fairy", {}},
				{"modifier_morphling_18","#modifier_morphling_18", 1, "morphling/18", {"modifier_morphling_17",3}},
				{"empty_9"},
				{"modifier_woda_talent_int4", "#woda_talent_int4", 1, "int4", {"modifier_woda_talent_kaya",1}}
			},
			[5] = {
				{"modifier_woda_talent_spellprism", "#woda_talent_spellprism", 3, "spellprism", {}},
				{"empty_11"},
				{"modifier_morphling_19","#modifier_morphling_19", 2, "morphling/19", {"modifier_morphling_18",1}},
				{"empty_12"},
				{"modifier_woda_talent_int5", "#woda_talent_int5", 3, "int5", {"modifier_woda_talent_int4",1}}
			},
			[6] = {
				{"modifier_woda_talent_timeless", "#woda_talent_timeless", 2, "timeless", {}},
				{"modifier_woda_talent_regenmp2", "#woda_talent_regenmp2", 3, "regenmp2", {}},
				{"modifier_morphling_20","#modifier_morphling_20", 3, "morphling/20", {"modifier_morphling_19",2}},
				{"empty_15"},
				{"empty_16"}
			},
			[7] = {
				{"empty_17"},
				{"empty_18"},
				{"modifier_morphling_16","#modifier_morphling_16", 1, "morphling/16", {}},
				{"empty_20"},
				{"empty_21"}
			}
		}
	},
	["npc_dota_hero_oracle"] = {
		[1] = {
			[1] = {
				{"modifier_woda_talent_hp1", "#woda_talent_hp1", 3, "hp1", {}},
				{"modifier_woda_talent_regenhp1", "#woda_talent_regenhp1", 2, "regenhp1", {}},
				{"modifier_woda_talent_attack1", "#woda_talent_attack1", 3, "attack1", {}},
				{"modifier_oracle_1","#modifier_oracle_1", 3, "oracle/1", {}},
				{"modifier_woda_talent_str3", "#woda_talent_str3", 2, "str3", {}}
			},
			[2] = {
				{"empty_2"},
				{"modifier_oracle_2","#modifier_oracle_2", 1, "oracle/2", {}},
				{"empty_3"},
				{"modifier_woda_talent_cloak", "#woda_talent_cloak", 2, "cloak", {}},
				{"modifier_woda_talent_str6", "#woda_talent_str6", 1, "str6", {"modifier_woda_talent_str3",2}}
			},
			[3] = {
				{"empty_6"},
				{"modifier_woda_talent_quickhp", "#woda_talent_quickhp", 2, "quickhp", {}},
				{"modifier_oracle_3","#modifier_oracle_3", 3, "oracle/3", {}},
				{"empty_8"},
				{"modifier_woda_talent_sasha", "#woda_talent_sasha", 1, "sasha", {"modifier_woda_talent_str6",1}}
			},
			[4] = {
				{"modifier_woda_talent_hp2", "#woda_talent_hp2", 3, "hp2", {"modifier_woda_talent_hp1",3}},
				{"empty_9"},
				{"modifier_oracle_4","#modifier_oracle_4", 3, "oracle/4", {"modifier_oracle_3",3}},
				{"modifier_woda_talent_octar", "#woda_talent_octar", 2, "octar", {}},
				{"modifier_woda_talent_str4", "#woda_talent_str4", 1, "str4", {"modifier_woda_talent_sasha",1}}
			},
			[5] = {
				{"modifier_woda_talent_armor2", "#woda_talent_armor2", 3, "armor2", {}},
				{"modifier_oracle_5","#modifier_oracle_5", 2, "oracle/5", {}},
				{"empty_10"},
				{"empty_11"},
				{"modifier_woda_talent_str5", "#woda_talent_str5", 3, "str5", {"modifier_woda_talent_str4",1}}
			},
			[6] = {
				{"modifier_woda_talent_sliver", "#woda_talent_sliver", 2, "sliver", {}},
				{"modifier_woda_talent_regenhp2", "#woda_talent_regenhp2", 3, "regenhp2", {}},
				{"modifier_oracle_6","#modifier_oracle_6", 1, "oracle/6", {"modifier_oracle_4",3}},
				{"empty_15"},
				{"empty_16"}
			},
			[7] = {
				{"empty_17"},
				{"empty_18"},
				{"modifier_oracle_7","#modifier_oracle_7", 1, "oracle/7", {}},
				{"empty_20"},
				{"empty_21"}
			}
		},
		[2] = {
			[1] = {
				{"modifier_woda_talent_armor1", "#woda_talent_armor1", 3, "armor1", {}},
				{"modifier_woda_talent_speed1", "#woda_talent_speed1", 2, "speed1", {}},
				{"modifier_woda_talent_attackspeed1", "#woda_talent_attackspeed1", 3, "attackspeed1", {}},
				{"modifier_oracle_10","#modifier_oracle_10", 1, "oracle/10", {}},
				{"modifier_woda_talent_agi3", "#woda_talent_agi3", 2, "agi3", {}}
			},
			[2] = {
				{"empty_2"},
				{"empty_3"},
				{"modifier_oracle_13","#modifier_oracle_13", 3, "oracle/13", {}},
				{"modifier_woda_talent_miss1", "#woda_talent_miss1", 2, "miss1", {}},
				{"modifier_woda_talent_agi6", "#woda_talent_agi6", 1, "agi6", {"modifier_woda_talent_agi3",2}}
			},
			[3] = {
				{"modifier_oracle_11","#modifier_oracle_11", 3, "oracle/11", {}},
				{"empty_7"},
				{"empty_8"},
				{"modifier_woda_talent_mask1", "#woda_talent_mask1", 2, "mask1", {}},
				{"modifier_woda_talent_yasha", "#woda_talent_yasha", 1, "yasha", {"modifier_woda_talent_agi6",1}}
			},
			[4] = {
				{"modifier_oracle_8","#modifier_oracle_8", 3, "oracle/8", {}},
				{"modifier_woda_talent_speed2", "#woda_talent_speed2", 3, "speed2", {"modifier_woda_talent_speed1",2}},
				{"modifier_woda_talent_grovebow", "#woda_talent_grovebow", 2, "grovebow", {}},
				{"empty_10"},			
				{"modifier_woda_talent_agi4", "#woda_talent_agi4", 1, "agi4", {"modifier_woda_talent_yasha",1}}
			},
			[5] = {
				{"modifier_woda_talent_attack2", "#woda_talent_attack2", 3, "attack2", {}},
				{"empty_11"},
				{"empty_12"},
				{"modifier_oracle_9","#modifier_oracle_9", 2, "oracle/9", {}},
				{"modifier_woda_talent_agi5", "#woda_talent_agi5", 3, "agi5", {"modifier_woda_talent_agi4",1}}
			},
			[6] = {
				{"modifier_woda_talent_miss2", "#woda_talent_miss2", 2, "miss2", {}},
				{"empty_13"},
				{"modifier_woda_talent_attackspeed2", "#woda_talent_attackspeed2", 3, "attackspeed2", {}},
				{"empty_15"},
				{"modifier_oracle_12","#modifier_oracle_12", 1, "oracle/12", {}}
			},
			[7] = {
				{"empty_17"},
				{"empty_18"},
				{"modifier_oracle_21","#modifier_oracle_21", 1, "oracle/21", {}},
				{"empty_20"},
				{"empty_21"}
			}
		},
		[3] = {
			[1] = {
				{"modifier_woda_talent_mp1", "#woda_talent_mp1", 3, "mp1", {}},
				{"modifier_woda_talent_regenmp1", "#woda_talent_regenmp1", 2, "regenmp1", {}},
				{"modifier_woda_talent_spell", "#woda_talent_spell", 3, "spell", {}},
				{"modifier_oracle_15","#modifier_oracle_15", 2, "oracle/15", {}},
				{"modifier_woda_talent_int3", "#woda_talent_int3", 2, "int3", {}}
			},
			[2] = {
				{"empty_2"},
				{"empty_3"},
				{"modifier_oracle_17","#modifier_oracle_17", 1, "oracle/17", {}},
				{"modifier_woda_talent_blood", "#woda_talent_blood", 2, "blood", {}},
				{"modifier_woda_talent_int6", "#woda_talent_int6", 1, "int6", {"modifier_woda_talent_int3",2}}
			},
			[3] = {
				{"empty_6"},
				{"modifier_oracle_16","#modifier_oracle_16", 3, "oracle/16", {}},
				{"empty_7"},
				{"modifier_woda_talent_mask2", "#woda_talent_mask2", 2, "mask2", {}},
				{"modifier_woda_talent_kaya", "#woda_talent_kaya", 1, "kaya", {"modifier_woda_talent_int6",1}}
			},
			[4] = {
				{"modifier_woda_talent_mp2", "#woda_talent_mp2", 3, "mp2", {"modifier_woda_talent_mp1",3}},
				{"modifier_woda_talent_fairy", "#woda_talent_fairy", 2, "fairy", {}},
				{"modifier_oracle_18","#modifier_oracle_18", 3, "oracle/18", {}},
				{"empty_9"},
				{"modifier_woda_talent_int4", "#woda_talent_int4", 1, "int4", {"modifier_woda_talent_kaya",1}}
			},
			[5] = {
				{"modifier_woda_talent_spellprism", "#woda_talent_spellprism", 3, "spellprism", {}},
				{"modifier_oracle_19","#modifier_oracle_19", 2, "oracle/19", {}},
				{"empty_11"},
				{"empty_12"},
				{"modifier_woda_talent_int5", "#woda_talent_int5", 3, "int5", {"modifier_woda_talent_int4",1}}
			},
			[6] = {
				{"modifier_woda_talent_timeless", "#woda_talent_timeless", 2, "timeless", {}},
				{"modifier_woda_talent_regenmp2", "#woda_talent_regenmp2", 3, "regenmp2", {}},
				{"modifier_oracle_20","#modifier_oracle_20", 2, "oracle/20", {}},
				{"empty_14"},
				{"empty_16"}
			},
			[7] = {
				{"empty_17"},
				{"empty_18"},
				{"modifier_oracle_14","#modifier_oracle_14", 1, "oracle/14", {}},
				{"empty_20"},
				{"empty_21"}
			}
		}
	},
	["npc_dota_hero_disruptor"] = {
		[1] = {
			[1] = {
				{"modifier_woda_talent_hp1", "#woda_talent_hp1", 3, "hp1", {}},
				{"modifier_woda_talent_regenhp1", "#woda_talent_regenhp1", 2, "regenhp1", {}},
				{"modifier_woda_talent_attack1", "#woda_talent_attack1", 3, "attack1", {}},
				{"modifier_disruptor_1","#modifier_disruptor_1", 2, "disruptor/1", {}},
				{"modifier_woda_talent_str3", "#woda_talent_str3", 2, "str3", {}}
			},
			[2] = {
				{"empty_2"},
				{"empty_3"},
				{"modifier_disruptor_2","#modifier_disruptor_2", 3, "disruptor/2", {}},
				{"modifier_woda_talent_cloak", "#woda_talent_cloak", 2, "cloak", {}},
				{"modifier_woda_talent_str6", "#woda_talent_str6", 1, "str6", {"modifier_woda_talent_str3",2}}
			},
			[3] = {
				{"empty_6"},
				{"modifier_woda_talent_quickhp", "#woda_talent_quickhp", 2, "quickhp", {}},
				{"modifier_disruptor_3","#modifier_disruptor_3", 2, "disruptor/3", {}},
				{"empty_9"},
				{"modifier_woda_talent_sasha", "#woda_talent_sasha", 1, "sasha", {"modifier_woda_talent_str6",1}}
			},
			[4] = {
				{"modifier_woda_talent_hp2", "#woda_talent_hp2", 3, "hp2", {"modifier_woda_talent_hp1",3}},
				{"empty_9"},
				{"modifier_disruptor_4","#modifier_disruptor_4", 3, "disruptor/4", {}},
				{"modifier_woda_talent_octar", "#woda_talent_octar", 2, "octar", {}},
				{"modifier_woda_talent_str4", "#woda_talent_str4", 1, "str4", {"modifier_woda_talent_sasha",1}}
			},
			[5] = {
				{"modifier_woda_talent_armor2", "#woda_talent_armor2", 3, "armor2", {}},
				{"modifier_disruptor_6","#modifier_disruptor_6", 1, "disruptor/6", {}},
				{"empty_10"},
				{"empty_11"},
				{"modifier_woda_talent_str5", "#woda_talent_str5", 3, "str5", {"modifier_woda_talent_str4",1}}
			},
			[6] = {
				{"modifier_woda_talent_sliver", "#woda_talent_sliver", 2, "sliver", {}},
				{"modifier_woda_talent_regenhp2", "#woda_talent_regenhp2", 3, "regenhp2", {}},
				{"empty_14"},
				{"empty_15"},
				{"modifier_disruptor_5","#modifier_disruptor_5", 2, "disruptor/5", {}}
			},
			[7] = {
				{"empty_17"},
				{"empty_18"},
				{"modifier_disruptor_7","#modifier_disruptor_7", 1, "disruptor/7", {}},
				{"empty_20"},
				{"empty_21"}
			}
		},
		[2] = {
			[1] = {
				{"modifier_woda_talent_armor1", "#woda_talent_armor1", 3, "armor1", {}},
				{"modifier_woda_talent_speed1", "#woda_talent_speed1", 2, "speed1", {}},
				{"modifier_woda_talent_attackspeed1", "#woda_talent_attackspeed1", 3, "attackspeed1", {}},
				{"modifier_disruptor_8","#modifier_disruptor_8", 2, "disruptor/8", {}},
				{"modifier_woda_talent_agi3", "#woda_talent_agi3", 2, "agi3", {}}
			},
			[2] = {
				{"modifier_disruptor_9","#modifier_disruptor_9", 3, "disruptor/9", {}},
				{"empty_3"},
				{"empty_4"},
				{"modifier_woda_talent_miss1", "#woda_talent_miss1", 2, "miss1", {}},
				{"modifier_woda_talent_agi6", "#woda_talent_agi6", 1, "agi6", {"modifier_woda_talent_agi3",2}}
			},
			[3] = {
				{"modifier_disruptor_10","#modifier_disruptor_10", 3, "disruptor/10", {"modifier_disruptor_9",3}},
				{"empty_7"},
				{"empty_8"},
				{"modifier_woda_talent_mask1", "#woda_talent_mask1", 2, "mask1", {}},
				{"modifier_woda_talent_yasha", "#woda_talent_yasha", 1, "yasha", {"modifier_woda_talent_agi6",1}}
			},
			[4] = {
				{"modifier_disruptor_11","#modifier_disruptor_11", 1, "disruptor/11", {"modifier_disruptor_10",3}},
				{"modifier_woda_talent_speed2", "#woda_talent_speed2", 3, "speed2", {"modifier_woda_talent_speed1",2}},
				{"modifier_woda_talent_grovebow", "#woda_talent_grovebow", 2, "grovebow", {}},
				{"empty_10"},			
				{"modifier_woda_talent_agi4", "#woda_talent_agi4", 1, "agi4", {"modifier_woda_talent_yasha",1}}
			},
			[5] = {
				{"modifier_woda_talent_attack2", "#woda_talent_attack2", 3, "attack2", {}},
				{"modifier_disruptor_12","#modifier_disruptor_12", 2, "disruptor/12", {}},
				{"empty_11"},
				{"empty_12"},
				{"modifier_woda_talent_agi5", "#woda_talent_agi5", 3, "agi5", {"modifier_woda_talent_agi4",1}}
			},
			[6] = {
				{"modifier_woda_talent_miss2", "#woda_talent_miss2", 2, "miss2", {}},
				{"modifier_disruptor_13","#modifier_disruptor_13", 2, "disruptor/13", {}},
				{"modifier_woda_talent_attackspeed2", "#woda_talent_attackspeed2", 3, "attackspeed2", {}},
				{"empty_13"},
				{"empty_16"}
			},
			[7] = {
				{"empty_17"},
				{"empty_18"},
				{"modifier_disruptor_14","#modifier_disruptor_14", 1, "disruptor/14", {}},
				{"empty_20"},
				{"empty_21"}
			}
		},
		[3] = {
			[1] = {
				{"modifier_woda_talent_mp1", "#woda_talent_mp1", 3, "mp1", {}},
				{"modifier_woda_talent_regenmp1", "#woda_talent_regenmp1", 2, "regenmp1", {}},
				{"modifier_woda_talent_spell", "#woda_talent_spell", 3, "spell", {}},
				{"modifier_disruptor_15","#modifier_disruptor_15", 3, "disruptor/15", {}},
				{"modifier_woda_talent_int3", "#woda_talent_int3", 2, "int3", {}}
			},
			[2] = {
				{"empty_2"},
				{"empty_3"},
				{"modifier_disruptor_16","#modifier_disruptor_16", 1, "disruptor/16", {}},
				{"modifier_woda_talent_blood", "#woda_talent_blood", 2, "blood", {}},
				{"modifier_woda_talent_int6", "#woda_talent_int6", 1, "int6", {"modifier_woda_talent_int3",2}}
			},
			[3] = {
				{"empty_6"},
				{"empty_7"},
				{"modifier_disruptor_18","#modifier_disruptor_18", 3, "disruptor/18", {}},
				{"modifier_woda_talent_mask2", "#woda_talent_mask2", 2, "mask2", {}},
				{"modifier_woda_talent_kaya", "#woda_talent_kaya", 1, "kaya", {"modifier_woda_talent_int6",1}}
			},
			[4] = {
				{"modifier_woda_talent_mp2", "#woda_talent_mp2", 3, "mp2", {"modifier_woda_talent_mp1",3}},
				{"modifier_woda_talent_fairy", "#woda_talent_fairy", 2, "fairy", {}},
				{"modifier_disruptor_19","#modifier_disruptor_19", 2, "disruptor/19", {}},
				{"empty_9"},
				{"modifier_woda_talent_int4", "#woda_talent_int4", 1, "int4", {"modifier_woda_talent_kaya",1}}
			},
			[5] = {
				{"modifier_woda_talent_spellprism", "#woda_talent_spellprism", 3, "spellprism", {}},
				{"empty_10"},
				{"empty_11"},
				{"modifier_disruptor_17","#modifier_disruptor_17", 1, "disruptor/17", {}},
				{"modifier_woda_talent_int5", "#woda_talent_int5", 3, "int5", {"modifier_woda_talent_int4",1}}
			},
			[6] = {
				{"modifier_woda_talent_timeless", "#woda_talent_timeless", 2, "timeless", {}},
				{"modifier_woda_talent_regenmp2", "#woda_talent_regenmp2", 3, "regenmp2", {}},
				{"empty_14"},
				{"empty_15"},
				{"modifier_disruptor_20","#modifier_disruptor_20", 3, "disruptor/20", {}}
			},
			[7] = {
				{"empty_17"},
				{"empty_18"},
				{"modifier_disruptor_21","#modifier_disruptor_21", 1, "disruptor/21", {}},
				{"empty_20"},
				{"empty_21"}
			}
		}
	},
	["npc_dota_hero_juggernaut"] = {
		[1] = {
			[1] = {
				{"modifier_woda_talent_hp1", "#woda_talent_hp1", 3, "hp1", {}},
				{"modifier_woda_talent_regenhp1", "#woda_talent_regenhp1", 2, "regenhp1", {}},
				{"modifier_woda_talent_attack1", "#woda_talent_attack1", 3, "attack1", {}},
				{"modifier_juggernaut_1","#modifier_juggernaut_1", 2, "juggernaut/1", {}},
				{"modifier_woda_talent_str3", "#woda_talent_str3", 2, "str3", {}}
			},
			[2] = {
				{"empty_2"},
				{"empty_3"},
				{"modifier_juggernaut_2","#modifier_juggernaut_2", 3, "juggernaut/2", {}},
				{"modifier_woda_talent_cloak", "#woda_talent_cloak", 2, "cloak", {}},
				{"modifier_woda_talent_str6", "#woda_talent_str6", 1, "str6", {"modifier_woda_talent_str3",2}}
			},
			[3] = {
				{"empty_6"},
				{"modifier_woda_talent_quickhp", "#woda_talent_quickhp", 2, "quickhp", {}},
				{"empty_8"},
				{"modifier_juggernaut_3","#modifier_juggernaut_3", 1, "juggernaut/3", {}},
				{"modifier_woda_talent_sasha", "#woda_talent_sasha", 1, "sasha", {"modifier_woda_talent_str6",1}}
			},
			[4] = {
				{"modifier_woda_talent_hp2", "#woda_talent_hp2", 3, "hp2", {"modifier_woda_talent_hp1",3}},
				{"empty_9"},
				{"modifier_juggernaut_4","#modifier_juggernaut_4", 2, "juggernaut/4", {}},
				{"modifier_woda_talent_octar", "#woda_talent_octar", 2, "octar", {}},
				{"modifier_woda_talent_str4", "#woda_talent_str4", 1, "str4", {"modifier_woda_talent_sasha",1}}
			},
			[5] = {
				{"modifier_woda_talent_armor2", "#woda_talent_armor2", 3, "armor2", {}},
				{"empty_10"},
				{"empty_11"},
				{"modifier_juggernaut_5","#modifier_juggernaut_5", 3, "juggernaut/5", {}},
				{"modifier_woda_talent_str5", "#woda_talent_str5", 3, "str5", {"modifier_woda_talent_str4",1}}
			},
			[6] = {
				{"modifier_woda_talent_sliver", "#woda_talent_sliver", 2, "sliver", {}},
				{"modifier_woda_talent_regenhp2", "#woda_talent_regenhp2", 3, "regenhp2", {}},
				{"modifier_juggernaut_6","#modifier_juggernaut_6", 2, "juggernaut/6", {}},
				{"empty_15"},
				{"empty_16"}
			},
			[7] = {
				{"empty_17"},
				{"empty_18"},
				{"modifier_juggernaut_7","#modifier_juggernaut_7", 1, "juggernaut/7", {}},
				{"empty_20"},
				{"empty_21"}
			}
		},
		[2] = {
			[1] = {
				{"modifier_woda_talent_armor1", "#woda_talent_armor1", 3, "armor1", {}},
				{"modifier_woda_talent_speed1", "#woda_talent_speed1", 2, "speed1", {}},
				{"modifier_woda_talent_attackspeed1", "#woda_talent_attackspeed1", 3, "attackspeed1", {}},
				{"modifier_juggernaut_8","#modifier_juggernaut_8", 2, "juggernaut/8", {}},
				{"modifier_woda_talent_agi3", "#woda_talent_agi3", 2, "agi3", {}}
			},
			[2] = {
				{"modifier_juggernaut_9","#modifier_juggernaut_9", 2, "juggernaut/9", {}},
				{"empty_3"},
				{"empty_4"},
				{"modifier_woda_talent_miss1", "#woda_talent_miss1", 2, "miss1", {}},
				{"modifier_woda_talent_agi6", "#woda_talent_agi6", 1, "agi6", {"modifier_woda_talent_agi3",2}}
			},
			[3] = {
				{"modifier_juggernaut_10","#modifier_juggernaut_10", 3, "juggernaut/10", {}},
				{"empty_7"},
				{"empty_8"},
				{"modifier_woda_talent_mask1", "#woda_talent_mask1", 2, "mask1", {}},
				{"modifier_woda_talent_yasha", "#woda_talent_yasha", 1, "yasha", {"modifier_woda_talent_agi6",1}}
			},
			[4] = {
				{"modifier_juggernaut_11","#modifier_juggernaut_11", 2, "juggernaut/11", {}},
				{"modifier_woda_talent_speed2", "#woda_talent_speed2", 3, "speed2", {"modifier_woda_talent_speed1",2}},
				{"modifier_woda_talent_grovebow", "#woda_talent_grovebow", 2, "grovebow", {}},
				{"empty_10"},			
				{"modifier_woda_talent_agi4", "#woda_talent_agi4", 1, "agi4", {"modifier_woda_talent_yasha",1}}
			},
			[5] = {
				{"modifier_woda_talent_attack2", "#woda_talent_attack2", 3, "attack2", {}},
				{"empty_11"},
				{"empty_12"},
				{"modifier_juggernaut_12","#modifier_juggernaut_12", 3, "juggernaut/12", {}},
				{"modifier_woda_talent_agi5", "#woda_talent_agi5", 3, "agi5", {"modifier_woda_talent_agi4",1}}
			},
			[6] = {
				{"modifier_woda_talent_miss2", "#woda_talent_miss2", 2, "miss2", {}},
				{"empty_13"},
				{"modifier_woda_talent_attackspeed2", "#woda_talent_attackspeed2", 3, "attackspeed2", {}},
				{"modifier_juggernaut_13","#modifier_juggernaut_13", 1, "juggernaut/13", {}},
				{"empty_16"}
			},
			[7] = {
				{"empty_17"},
				{"empty_18"},
				{"modifier_juggernaut_14","#modifier_juggernaut_14", 1, "juggernaut/14", {}},
				{"empty_20"},
				{"empty_21"}
			}
		},
		[3] = {
			[1] = {
				{"modifier_woda_talent_mp1", "#woda_talent_mp1", 3, "mp1", {}},
				{"modifier_woda_talent_regenmp1", "#woda_talent_regenmp1", 2, "regenmp1", {}},
				{"modifier_woda_talent_spell", "#woda_talent_spell", 3, "spell", {}},
				{"modifier_juggernaut_15","#modifier_juggernaut_15", 3, "juggernaut/15", {}},
				{"modifier_woda_talent_int3", "#woda_talent_int3", 2, "int3", {}}
			},
			[2] = {
				{"empty_2"},
				{"empty_3"},
				{"modifier_juggernaut_18","#modifier_juggernaut_18", 3, "juggernaut/18", {}},
				{"modifier_woda_talent_blood", "#woda_talent_blood", 2, "blood", {}},
				{"modifier_woda_talent_int6", "#woda_talent_int6", 1, "int6", {"modifier_woda_talent_int3",2}}
			},
			[3] = {
				{"empty_6"},
				{"empty_7"},
				{"modifier_juggernaut_19","#modifier_juggernaut_19", 2, "juggernaut/19", {}},
				{"modifier_woda_talent_mask2", "#woda_talent_mask2", 2, "mask2", {}},
				{"modifier_woda_talent_kaya", "#woda_talent_kaya", 1, "kaya", {"modifier_woda_talent_int6",1}}
			},
			[4] = {
				{"modifier_woda_talent_mp2", "#woda_talent_mp2", 3, "mp2", {"modifier_woda_talent_mp1",3}},
				{"modifier_woda_talent_fairy", "#woda_talent_fairy", 2, "fairy", {}},
				{"empty_9"},
				{"modifier_juggernaut_21","#modifier_juggernaut_21", 1, "juggernaut/21", {}},
				{"modifier_woda_talent_int4", "#woda_talent_int4", 1, "int4", {"modifier_woda_talent_kaya",1}}
			},
			[5] = {
				{"modifier_woda_talent_spellprism", "#woda_talent_spellprism", 3, "spellprism", {}},
				{"empty_11"},
				{"empty_12"},
				{"modifier_juggernaut_17","#modifier_juggernaut_17", 1, "juggernaut/17", {}},
				{"modifier_woda_talent_int5", "#woda_talent_int5", 3, "int5", {"modifier_woda_talent_int4",1}}
			},
			[6] = {
				{"modifier_woda_talent_timeless", "#woda_talent_timeless", 2, "timeless", {}},
				{"modifier_woda_talent_regenmp2", "#woda_talent_regenmp2", 3, "regenmp2", {}},
				{"empty_15"},
				{"empty_16"},
				{"modifier_juggernaut_16","#modifier_juggernaut_16", 3, "juggernaut/16", {}}
			},
			[7] = {
				{"empty_17"},
				{"empty_18"},
				{"modifier_juggernaut_20","#modifier_juggernaut_20", 1, "juggernaut/20", {}},
				{"empty_20"},
				{"empty_21"}
			}
		}
	},
	["npc_dota_hero_spectre"] = {
		[1] = {
			[1] = {
				{"modifier_woda_talent_hp1", "#woda_talent_hp1", 3, "hp1", {}},
				{"modifier_woda_talent_regenhp1", "#woda_talent_regenhp1", 2, "regenhp1", {}},
				{"modifier_woda_talent_attack1", "#woda_talent_attack1", 3, "attack1", {}},
				{"modifier_spectre_2","#modifier_spectre_2", 2, "spectre/2", {}},
				{"modifier_woda_talent_str3", "#woda_talent_str3", 2, "str3", {}}
			},
			[2] = {
				{"empty_2"},
				{"modifier_spectre_1","#modifier_spectre_1", 3, "spectre/1", {}},
				{"empty_3"},
				{"modifier_woda_talent_cloak", "#woda_talent_cloak", 2, "cloak", {}},
				{"modifier_woda_talent_str6", "#woda_talent_str6", 1, "str6", {"modifier_woda_talent_str3",2}}
			},
			[3] = {
				{"empty_6"},
				{"modifier_woda_talent_quickhp", "#woda_talent_quickhp", 2, "quickhp", {}},
				{"modifier_spectre_6","#modifier_spectre_6", 2, "spectre/6", {}},
				{"empty_9"},
				{"modifier_woda_talent_sasha", "#woda_talent_sasha", 1, "sasha", {"modifier_woda_talent_str6",1}}
			},
			[4] = {
				{"modifier_woda_talent_hp2", "#woda_talent_hp2", 3, "hp2", {"modifier_woda_talent_hp1",3}},
				{"empty_9"},
				{"modifier_spectre_3","#modifier_spectre_3", 2, "spectre/3", {}},
				{"modifier_woda_talent_octar", "#woda_talent_octar", 2, "octar", {}},
				{"modifier_woda_talent_str4", "#woda_talent_str4", 1, "str4", {"modifier_woda_talent_sasha",1}}
			},
			[5] = {
				{"modifier_woda_talent_armor2", "#woda_talent_armor2", 3, "armor2", {}},
				{"modifier_spectre_5","#modifier_spectre_5", 3, "spectre/5", {}},
				{"empty_10"},
				{"empty_11"},
				{"modifier_woda_talent_str5", "#woda_talent_str5", 3, "str5", {"modifier_woda_talent_str4",1}}
			},
			[6] = {
				{"modifier_woda_talent_sliver", "#woda_talent_sliver", 2, "sliver", {}},
				{"modifier_woda_talent_regenhp2", "#woda_talent_regenhp2", 3, "regenhp2", {}},
				{"modifier_spectre_4","#modifier_spectre_4", 1, "spectre/4", {"modifier_spectre_3",2}},
				{"empty_15"},
				{"empty_16"}
			},
			[7] = {
				{"empty_17"},
				{"empty_18"},
				{"modifier_spectre_7","#modifier_spectre_7", 1, "spectre/7", {}},
				{"empty_20"},
				{"empty_21"}
			}
		},
		[2] = {
			[1] = {
				{"modifier_woda_talent_armor1", "#woda_talent_armor1", 3, "armor1", {}},
				{"modifier_woda_talent_speed1", "#woda_talent_speed1", 2, "speed1", {}},
				{"modifier_woda_talent_attackspeed1", "#woda_talent_attackspeed1", 3, "attackspeed1", {}},
				{"modifier_spectre_8","#modifier_spectre_8", 1, "spectre/8", {}},
				{"modifier_woda_talent_agi3", "#woda_talent_agi3", 2, "agi3", {}}
			},
			[2] = {
				{"modifier_spectre_10","#modifier_spectre_10", 3, "spectre/10", {}},
				{"empty_3"},
				{"empty_4"},
				{"modifier_woda_talent_miss1", "#woda_talent_miss1", 2, "miss1", {}},
				{"modifier_woda_talent_agi6", "#woda_talent_agi6", 1, "agi6", {"modifier_woda_talent_agi3",2}}
			},
			[3] = {
				{"modifier_spectre_9","#modifier_spectre_9", 2, "spectre/9", {}},
				{"empty_7"},
				{"empty_8"},
				{"modifier_woda_talent_mask1", "#woda_talent_mask1", 2, "mask1", {}},
				{"modifier_woda_talent_yasha", "#woda_talent_yasha", 1, "yasha", {"modifier_woda_talent_agi6",1}}
			},
			[4] = {
				{"modifier_spectre_11","#modifier_spectre_11", 3, "spectre/11", {}},
				{"modifier_woda_talent_speed2", "#woda_talent_speed2", 3, "speed2", {"modifier_woda_talent_speed1",2}},
				{"modifier_woda_talent_grovebow", "#woda_talent_grovebow", 2, "grovebow", {}},
				{"empty_10"},			
				{"modifier_woda_talent_agi4", "#woda_talent_agi4", 1, "agi4", {"modifier_woda_talent_yasha",1}}
			},
			[5] = {
				{"modifier_woda_talent_attack2", "#woda_talent_attack2", 3, "attack2", {}},
				{"empty_11"},
				{"modifier_spectre_12","#modifier_spectre_12", 3, "spectre/12", {}},
				{"empty_12"},
				{"modifier_woda_talent_agi5", "#woda_talent_agi5", 3, "agi5", {"modifier_woda_talent_agi4",1}}
			},
			[6] = {
				{"modifier_woda_talent_miss2", "#woda_talent_miss2", 2, "miss2", {}},
				{"empty_13"},
				{"modifier_woda_talent_attackspeed2", "#woda_talent_attackspeed2", 3, "attackspeed2", {}},
				{"modifier_spectre_13","#modifier_spectre_13", 1, "spectre/13", {}},
				{"empty_16"}
			},
			[7] = {
				{"empty_17"},
				{"empty_18"},
				{"modifier_spectre_14","#modifier_spectre_14", 1, "spectre/14", {}},
				{"empty_20"},
				{"empty_21"}
			}
		},
		[3] = {
			[1] = {
				{"modifier_woda_talent_mp1", "#woda_talent_mp1", 3, "mp1", {}},
				{"modifier_woda_talent_regenmp1", "#woda_talent_regenmp1", 2, "regenmp1", {}},
				{"modifier_woda_talent_spell", "#woda_talent_spell", 3, "spell", {}},
				{"modifier_spectre_16","#modifier_spectre_16", 2, "spectre/16", {}},
				{"modifier_woda_talent_int3", "#woda_talent_int3", 2, "int3", {}}
			},
			[2] = {
				{"empty_2"},
				{"empty_3"},
				{"modifier_spectre_17","#modifier_spectre_17", 3, "spectre/17", {}},
				{"modifier_woda_talent_blood", "#woda_talent_blood", 2, "blood", {}},
				{"modifier_woda_talent_int6", "#woda_talent_int6", 1, "int6", {"modifier_woda_talent_int3",2}}
			},
			[3] = {
				{"empty_6"},
				{"empty_7"},
				{"modifier_spectre_15","#modifier_spectre_15", 2, "spectre/15", {}},
				{"modifier_woda_talent_mask2", "#woda_talent_mask2", 2, "mask2", {}},
				{"modifier_woda_talent_kaya", "#woda_talent_kaya", 1, "kaya", {"modifier_woda_talent_int6",1}}
			},
			[4] = {
				{"modifier_woda_talent_mp2", "#woda_talent_mp2", 3, "mp2", {"modifier_woda_talent_mp1",3}},
				{"modifier_woda_talent_fairy", "#woda_talent_fairy", 2, "fairy", {}},
				{"modifier_spectre_18","#modifier_spectre_18", 1, "spectre/18", {}},
				{"empty_9"},
				{"modifier_woda_talent_int4", "#woda_talent_int4", 1, "int4", {"modifier_woda_talent_kaya",1}}
			},
			[5] = {
				{"modifier_woda_talent_spellprism", "#woda_talent_spellprism", 3, "spellprism", {}},
				{"modifier_spectre_19","#modifier_spectre_19", 3, "spectre/19", {}},
				{"empty_10"},
				{"empty_11"},
				{"modifier_woda_talent_int5", "#woda_talent_int5", 3, "int5", {"modifier_woda_talent_int4",1}}
			},
			[6] = {
				{"modifier_woda_talent_timeless", "#woda_talent_timeless", 2, "timeless", {}},
				{"modifier_woda_talent_regenmp2", "#woda_talent_regenmp2", 3, "regenmp2", {}},
				{"modifier_spectre_20","#modifier_spectre_20", 2, "spectre/20", {}},
				{"empty_15"},
				{"empty_16"}
			},
			[7] = {
				{"empty_17"},
				{"empty_18"},
				{"modifier_spectre_21","#modifier_spectre_21", 1, "spectre/21", {}},
				{"empty_20"},
				{"empty_21"}
			}
		}
	},
	["npc_dota_hero_bristleback"] = {
		[1] = {
			[1] = {
				{"modifier_woda_talent_hp1", "#woda_talent_hp1", 3, "hp1", {}},
				{"modifier_woda_talent_regenhp1", "#woda_talent_regenhp1", 2, "regenhp1", {}},
				{"modifier_woda_talent_attack1", "#woda_talent_attack1", 3, "attack1", {}},
				{"modifier_bristleback_3","#modifier_bristleback_3", 2, "bristleback/3", {}},
				{"modifier_woda_talent_str3", "#woda_talent_str3", 2, "str3", {}}
			},
			[2] = {
				{"empty_2"},
				{"modifier_bristleback_4","#modifier_bristleback_4", 2, "bristleback/4", {}},
				{"empty_3"},
				{"modifier_woda_talent_cloak", "#woda_talent_cloak", 2, "cloak", {}},
				{"modifier_woda_talent_str6", "#woda_talent_str6", 1, "str6", {"modifier_woda_talent_str3",2}}
			},
			[3] = {
				{"empty_6"},
				{"modifier_woda_talent_quickhp", "#woda_talent_quickhp", 2, "quickhp", {}},
				{"modifier_bristleback_2","#modifier_bristleback_2", 3, "bristleback/2", {}},
				{"empty_8"},
				{"modifier_woda_talent_sasha", "#woda_talent_sasha", 1, "sasha", {"modifier_woda_talent_str6",1}}
			},
			[4] = {
				{"modifier_woda_talent_hp2", "#woda_talent_hp2", 3, "hp2", {"modifier_woda_talent_hp1",3}},
				{"modifier_bristleback_5","#modifier_bristleback_5", 2, "bristleback/5", {}},
				{"empty_9"},
				{"modifier_woda_talent_octar", "#woda_talent_octar", 2, "octar", {}},
				{"modifier_woda_talent_str4", "#woda_talent_str4", 1, "str4", {"modifier_woda_talent_sasha",1}}
			},
			[5] = {
				{"modifier_woda_talent_armor2", "#woda_talent_armor2", 3, "armor2", {}},
				{"empty_10"},
				{"modifier_bristleback_1","#modifier_bristleback_1", 1, "bristleback/1", {}},
				{"empty_11"},
				{"modifier_woda_talent_str5", "#woda_talent_str5", 3, "str5", {"modifier_woda_talent_str4",1}}
			},
			[6] = {
				{"modifier_woda_talent_sliver", "#woda_talent_sliver", 2, "sliver", {}},
				{"modifier_woda_talent_regenhp2", "#woda_talent_regenhp2", 3, "regenhp2", {}},
				{"empty_14"},
				{"modifier_bristleback_6","#modifier_bristleback_6", 3, "bristleback/6", {}},
				{"empty_16"}
			},
			[7] = {
				{"empty_17"},
				{"empty_18"},
				{"modifier_bristleback_7","#modifier_bristleback_7", 1, "bristleback/7", {}},
				{"empty_20"},
				{"empty_21"}
			}
		},
		[2] = {
			[1] = {
				{"modifier_bristleback_8","#modifier_bristleback_8", 3, "bristleback/8", {}},
				{"modifier_woda_talent_speed1", "#woda_talent_speed1", 2, "speed1", {}},
				{"modifier_woda_talent_attackspeed1", "#woda_talent_attackspeed1", 3, "attackspeed1", {}},
				{"modifier_woda_talent_armor1", "#woda_talent_armor1", 3, "armor1", {}},
				{"modifier_woda_talent_agi3", "#woda_talent_agi3", 2, "agi3", {}}
			},
			[2] = {
				{"modifier_bristleback_9","#modifier_bristleback_9", 2, "bristleback/9", {"modifier_bristleback_8",3}},
				{"empty_3"},
				{"empty_4"},
				{"modifier_woda_talent_miss1", "#woda_talent_miss1", 2, "miss1", {}},
				{"modifier_woda_talent_agi6", "#woda_talent_agi6", 1, "agi6", {"modifier_woda_talent_agi3",2}}
			},
			[3] = {
				{"modifier_bristleback_10","#modifier_bristleback_10", 2, "bristleback/10", {"modifier_bristleback_9",2}},
				{"empty_7"},
				{"empty_8"},
				{"modifier_woda_talent_mask1", "#woda_talent_mask1", 2, "mask1", {}},
				{"modifier_woda_talent_yasha", "#woda_talent_yasha", 1, "yasha", {"modifier_woda_talent_agi6",1}}
			},
			[4] = {
				{"modifier_bristleback_11","#modifier_bristleback_11", 3, "bristleback/11", {"modifier_bristleback_10",2}},
				{"modifier_woda_talent_speed2", "#woda_talent_speed2", 3, "speed2", {"modifier_woda_talent_speed1",2}},
				{"modifier_woda_talent_grovebow", "#woda_talent_grovebow", 2, "grovebow", {}},
				{"empty_10"},			
				{"modifier_woda_talent_agi4", "#woda_talent_agi4", 1, "agi4", {"modifier_woda_talent_yasha",1}}
			},
			[5] = {
				{"modifier_woda_talent_attack2", "#woda_talent_attack2", 3, "attack2", {}},
				{"empty_11"},
				{"empty_12"},
				{"modifier_bristleback_12","#modifier_bristleback_12", 1, "bristleback/12", {}},
				{"modifier_woda_talent_agi5", "#woda_talent_agi5", 3, "agi5", {"modifier_woda_talent_agi4",1}}
			},
			[6] = {
				{"modifier_woda_talent_miss2", "#woda_talent_miss2", 2, "miss2", {}},
				{"empty_13"},
				{"modifier_woda_talent_attackspeed2", "#woda_talent_attackspeed2", 3, "attackspeed2", {}},
				{"empty_15"},
				{"modifier_bristleback_13","#modifier_bristleback_13", 2, "bristleback/13", {}}
			},
			[7] = {
				{"empty_17"},
				{"empty_18"},
				{"modifier_bristleback_14","#modifier_bristleback_14", 1, "bristleback/14", {}},
				{"empty_20"},
				{"empty_21"}
			}
		},
		[3] = {
			[1] = {
				{"modifier_woda_talent_mp1", "#woda_talent_mp1", 3, "mp1", {}},
				{"modifier_woda_talent_regenmp1", "#woda_talent_regenmp1", 2, "regenmp1", {}},
				{"modifier_woda_talent_spell", "#woda_talent_spell", 3, "spell", {}},
				{"modifier_bristleback_19","#modifier_bristleback_19", 3, "bristleback/19", {}},
				{"modifier_woda_talent_int3", "#woda_talent_int3", 2, "int3", {}}
			},
			[2] = {
				{"empty_2"},
				{"modifier_bristleback_15","#modifier_bristleback_15", 2, "bristleback/15", {}},
				{"empty_3"},
				{"modifier_woda_talent_blood", "#woda_talent_blood", 2, "blood", {}},
				{"modifier_woda_talent_int6", "#woda_talent_int6", 1, "int6", {"modifier_woda_talent_int3",2}}
			},
			[3] = {
				{"empty_6"},
				{"empty_7"},
				{"modifier_bristleback_16","#modifier_bristleback_16", 1, "bristleback/16", {}},
				{"modifier_woda_talent_mask2", "#woda_talent_mask2", 2, "mask2", {}},
				{"modifier_woda_talent_kaya", "#woda_talent_kaya", 1, "kaya", {"modifier_woda_talent_int6",1}}
			},
			[4] = {
				{"modifier_woda_talent_mp2", "#woda_talent_mp2", 3, "mp2", {"modifier_woda_talent_mp1",3}},
				{"modifier_woda_talent_fairy", "#woda_talent_fairy", 2, "fairy", {}},
				{"empty_9"},
				{"modifier_bristleback_17","#modifier_bristleback_17", 2, "bristleback/17", {}},
				{"modifier_woda_talent_int4", "#woda_talent_int4", 1, "int4", {"modifier_woda_talent_kaya",1}}
			},
			[5] = {
				{"modifier_woda_talent_spellprism", "#woda_talent_spellprism", 3, "spellprism", {}},
				{"empty_10"},
				{"modifier_bristleback_20","#modifier_bristleback_20", 2, "bristleback/20", {}},
				{"empty_11"},
				{"modifier_woda_talent_int5", "#woda_talent_int5", 3, "int5", {"modifier_woda_talent_int4",1}}
			},
			[6] = {
				{"modifier_woda_talent_timeless", "#woda_talent_timeless", 2, "timeless", {}},
				{"modifier_woda_talent_regenmp2", "#woda_talent_regenmp2", 3, "regenmp2", {}},
				{"empty_14"},
				{"empty_15"},
				{"modifier_bristleback_18","#modifier_bristleback_18", 3, "bristleback/18", {}}
			},
			[7] = {
				{"empty_17"},
				{"empty_18"},
				{"modifier_bristleback_21","#modifier_bristleback_21", 1, "bristleback/21", {}},
				{"empty_20"},
				{"empty_21"}
			}
		}
	},
	["npc_dota_hero_spirit_breaker"] = {
		[1] = {
			[1] = {
				{"modifier_woda_talent_hp1", "#woda_talent_hp1", 3, "hp1", {}},
				{"modifier_woda_talent_regenhp1", "#woda_talent_regenhp1", 2, "regenhp1", {}},
				{"modifier_woda_talent_attack1", "#woda_talent_attack1", 3, "attack1", {}},
				{"modifier_spirit_breaker_1","#modifier_spirit_breaker_1", 2, "spirit_breaker/1", {}},
				{"modifier_woda_talent_str3", "#woda_talent_str3", 2, "str3", {}}
			},
			[2] = {
				{"empty_2"},
				{"modifier_spirit_breaker_2","#modifier_spirit_breaker_2", 2, "spirit_breaker/2", {}},
				{"empty_3"},
				{"modifier_woda_talent_cloak", "#woda_talent_cloak", 2, "cloak", {}},
				{"modifier_woda_talent_str6", "#woda_talent_str6", 1, "str6", {"modifier_woda_talent_str3",2}}
			},
			[3] = {
				{"empty_6"},
				{"modifier_woda_talent_quickhp", "#woda_talent_quickhp", 2, "quickhp", {}},
				{"modifier_spirit_breaker_4","#modifier_spirit_breaker_4", 3, "spirit_breaker/4", {}},
				{"empty_9"},
				{"modifier_woda_talent_sasha", "#woda_talent_sasha", 1, "sasha", {"modifier_woda_talent_str6",1}}
			},
			[4] = {
				{"modifier_woda_talent_hp2", "#woda_talent_hp2", 3, "hp2", {"modifier_woda_talent_hp1",3}},
				{"empty_9"},
				{"modifier_spirit_breaker_5","#modifier_spirit_breaker_5", 2, "spirit_breaker/5", {}},
				{"modifier_woda_talent_octar", "#woda_talent_octar", 2, "octar", {}},
				{"modifier_woda_talent_str4", "#woda_talent_str4", 1, "str4", {"modifier_woda_talent_sasha",1}}
			},
			[5] = {
				{"modifier_woda_talent_armor2", "#woda_talent_armor2", 3, "armor2", {}},
				{"modifier_spirit_breaker_3","#modifier_spirit_breaker_3", 3, "spirit_breaker/3", {}},
				{"empty_10"},
				{"empty_11"},
				{"modifier_woda_talent_str5", "#woda_talent_str5", 3, "str5", {"modifier_woda_talent_str4",1}}
			},
			[6] = {
				{"modifier_woda_talent_sliver", "#woda_talent_sliver", 2, "sliver", {}},
				{"modifier_woda_talent_regenhp2", "#woda_talent_regenhp2", 3, "regenhp2", {}},
				{"empty_14"},
				{"modifier_spirit_breaker_21","#modifier_spirit_breaker_21", 1, "spirit_breaker/21", {}},
				{"empty_16"}
			},
			[7] = {
				{"empty_17"},
				{"empty_18"},
				{"modifier_spirit_breaker_7","#modifier_spirit_breaker_7", 1, "spirit_breaker/7", {}},
				{"empty_20"},
				{"empty_21"}
			}
		},
		[2] = {
			[1] = {
				{"modifier_woda_talent_armor1", "#woda_talent_armor1", 3, "armor1", {}},
				{"modifier_woda_talent_speed1", "#woda_talent_speed1", 2, "speed1", {}},
				{"modifier_woda_talent_attackspeed1", "#woda_talent_attackspeed1", 3, "attackspeed1", {}},
				{"modifier_spirit_breaker_8","#modifier_spirit_breaker_8", 2, "spirit_breaker/8", {}},
				{"modifier_woda_talent_agi3", "#woda_talent_agi3", 2, "agi3", {}}
			},
			[2] = {
				{"empty_2"},
				{"empty_3"},
				{"modifier_spirit_breaker_9","#modifier_spirit_breaker_9", 3, "spirit_breaker/9", {}},
				{"modifier_woda_talent_miss1", "#woda_talent_miss1", 2, "miss1", {}},
				{"modifier_woda_talent_agi6", "#woda_talent_agi6", 1, "agi6", {"modifier_woda_talent_agi3",2}}
			},
			[3] = {
				{"modifier_spirit_breaker_12","#modifier_spirit_breaker_12", 2, "spirit_breaker/12", {}},
				{"empty_5"},
				{"empty_6"},
				{"modifier_woda_talent_mask1", "#woda_talent_mask1", 2, "mask1", {}},
				{"modifier_woda_talent_yasha", "#woda_talent_yasha", 1, "yasha", {"modifier_woda_talent_agi6",1}}
			},
			[4] = {
				{"empty_10"},
				{"modifier_woda_talent_speed2", "#woda_talent_speed2", 3, "speed2", {"modifier_woda_talent_speed1",2}},
				{"modifier_woda_talent_grovebow", "#woda_talent_grovebow", 2, "grovebow", {}},
				{"modifier_spirit_breaker_14","#modifier_spirit_breaker_14", 3, "spirit_breaker/14", {}},			
				{"modifier_woda_talent_agi4", "#woda_talent_agi4", 1, "agi4", {"modifier_woda_talent_yasha",1}}
			},
			[5] = {
				{"modifier_woda_talent_attack2", "#woda_talent_attack2", 3, "attack2", {}},
				{"empty_11"},
				{"modifier_spirit_breaker_13","#modifier_spirit_breaker_13", 2, "spirit_breaker/13", {}},
				{"empty_12"},
				{"modifier_woda_talent_agi5", "#woda_talent_agi5", 3, "agi5", {"modifier_woda_talent_agi4",1}}
			},
			[6] = {
				{"modifier_woda_talent_miss2", "#woda_talent_miss2", 2, "miss2", {}},
				{"modifier_spirit_breaker_20","#modifier_spirit_breaker_20", 1, "spirit_breaker/20", {}},
				{"modifier_woda_talent_attackspeed2", "#woda_talent_attackspeed2", 3, "attackspeed2", {}},
				{"empty_13"},
				{"empty_16"}
			},
			[7] = {
				{"empty_17"},
				{"empty_18"},
				{"modifier_spirit_breaker_11","#modifier_spirit_breaker_11", 1, "spirit_breaker/11", {}},
				{"empty_20"},
				{"empty_21"}
			}
		},
		[3] = {
			[1] = {
				{"modifier_woda_talent_mp1", "#woda_talent_mp1", 3, "mp1", {}},
				{"modifier_woda_talent_regenmp1", "#woda_talent_regenmp1", 2, "regenmp1", {}},
				{"modifier_woda_talent_spell", "#woda_talent_spell", 3, "spell", {}},
				{"modifier_spirit_breaker_15","#modifier_spirit_breaker_15", 3, "spirit_breaker/15", {}},
				{"modifier_woda_talent_int3", "#woda_talent_int3", 2, "int3", {}}
			},
			[2] = {
				{"empty_2"},
				{"modifier_spirit_breaker_16","#modifier_spirit_breaker_16", 2, "spirit_breaker/16", {}},
				{"empty_3"},
				{"modifier_woda_talent_blood", "#woda_talent_blood", 2, "blood", {}},
				{"modifier_woda_talent_int6", "#woda_talent_int6", 1, "int6", {"modifier_woda_talent_int3",2}}
			},
			[3] = {
				{"empty_6"},
				{"modifier_spirit_breaker_17","#modifier_spirit_breaker_17", 2, "spirit_breaker/17", {}},
				{"empty_7"},
				{"modifier_woda_talent_mask2", "#woda_talent_mask2", 2, "mask2", {}},
				{"modifier_woda_talent_kaya", "#woda_talent_kaya", 1, "kaya", {"modifier_woda_talent_int6",1}}
			},
			[4] = {
				{"modifier_woda_talent_mp2", "#woda_talent_mp2", 3, "mp2", {"modifier_woda_talent_mp1",3}},
				{"modifier_woda_talent_fairy", "#woda_talent_fairy", 2, "fairy", {}},
				{"empty_9"},
				{"modifier_spirit_breaker_19","#modifier_spirit_breaker_19", 3, "spirit_breaker/19", {}},
				{"modifier_woda_talent_int4", "#woda_talent_int4", 1, "int4", {"modifier_woda_talent_kaya",1}}
			},
			[5] = {
				{"modifier_woda_talent_spellprism", "#woda_talent_spellprism", 3, "spellprism", {}},
				{"modifier_spirit_breaker_6","#modifier_spirit_breaker_6", 1, "spirit_breaker/6", {}},
				{"empty_12"},
				{"empty_13"},
				{"modifier_woda_talent_int5", "#woda_talent_int5", 3, "int5", {"modifier_woda_talent_int4",1}}
			},
			[6] = {
				{"modifier_woda_talent_timeless", "#woda_talent_timeless", 2, "timeless", {}},
				{"modifier_woda_talent_regenmp2", "#woda_talent_regenmp2", 3, "regenmp2", {}},
				{"empty_14"},
				{"modifier_spirit_breaker_18","#modifier_spirit_breaker_18", 2, "spirit_breaker/18", {}},
				{"empty_16"}
			},
			[7] = {
				{"empty_17"},
				{"empty_18"},
				{"modifier_spirit_breaker_10","#modifier_spirit_breaker_10", 1, "spirit_breaker/10", {}},
				{"empty_20"},
				{"empty_21"}
			}
		}
	},
	["npc_dota_hero_ancient_apparition"] = {
		[1] = {
			[1] = {
				{"modifier_woda_talent_hp1", "#woda_talent_hp1", 3, "hp1", {}},
				{"modifier_woda_talent_regenhp1", "#woda_talent_regenhp1", 2, "regenhp1", {}},
				{"modifier_woda_talent_attack1", "#woda_talent_attack1", 3, "attack1", {}},
				{"modifier_ancient_apparition_1","#modifier_ancient_apparition_1", 3, "ancient_apparition/1", {}},
				{"modifier_woda_talent_str3", "#woda_talent_str3", 2, "str3", {}}
			},
			[2] = {
				{"empty_2"},
				{"empty_3"},
				{"modifier_ancient_apparition_2","#modifier_ancient_apparition_2", 2, "ancient_apparition/2", {}},
				{"modifier_woda_talent_cloak", "#woda_talent_cloak", 2, "cloak", {}},
				{"modifier_woda_talent_str6", "#woda_talent_str6", 1, "str6", {"modifier_woda_talent_str3",2}}
			},
			[3] = {
				{"empty_6"},
				{"modifier_woda_talent_quickhp", "#woda_talent_quickhp", 2, "quickhp", {}},
				{"empty_8"},
				{"modifier_ancient_apparition_3","#modifier_ancient_apparition_3", 1, "ancient_apparition/3", {}},
				{"modifier_woda_talent_sasha", "#woda_talent_sasha", 1, "sasha", {"modifier_woda_talent_str6",1}}
			},
			[4] = {
				{"modifier_woda_talent_hp2", "#woda_talent_hp2", 3, "hp2", {"modifier_woda_talent_hp1",3}},
				{"empty_9"},
				{"modifier_ancient_apparition_4","#modifier_ancient_apparition_4", 3, "ancient_apparition/4", {"modifier_ancient_apparition_2",2}},
				{"modifier_woda_talent_octar", "#woda_talent_octar", 2, "octar", {}},
				{"modifier_woda_talent_str4", "#woda_talent_str4", 1, "str4", {"modifier_woda_talent_sasha",1}}
			},
			[5] = {
				{"modifier_woda_talent_armor2", "#woda_talent_armor2", 3, "armor2", {}},
				{"modifier_ancient_apparition_5","#modifier_ancient_apparition_5", 3, "ancient_apparition/5", {}},
				{"empty_10"},
				{"empty_11"},
				{"modifier_woda_talent_str5", "#woda_talent_str5", 3, "str5", {"modifier_woda_talent_str4",1}}
			},
			[6] = {
				{"modifier_woda_talent_sliver", "#woda_talent_sliver", 2, "sliver", {}},
				{"modifier_woda_talent_regenhp2", "#woda_talent_regenhp2", 3, "regenhp2", {}},
				{"modifier_ancient_apparition_6","#modifier_ancient_apparition_6", 1, "ancient_apparition/6", {"modifier_ancient_apparition_4",3}},
				{"empty_15"},
				{"empty_16"}
			},
			[7] = {
				{"empty_17"},
				{"empty_18"},
				{"modifier_ancient_apparition_7","#modifier_ancient_apparition_7", 1, "ancient_apparition/7", {}},
				{"empty_20"},
				{"empty_21"}
			}
		},
		[2] = {
			[1] = {
				{"modifier_woda_talent_armor1", "#woda_talent_armor1", 3, "armor1", {}},
				{"modifier_woda_talent_speed1", "#woda_talent_speed1", 2, "speed1", {}},
				{"modifier_woda_talent_attackspeed1", "#woda_talent_attackspeed1", 3, "attackspeed1", {}},
				{"modifier_ancient_apparition_8","#modifier_ancient_apparition_8", 1, "ancient_apparition/8", {}},
				{"modifier_woda_talent_agi3", "#woda_talent_agi3", 2, "agi3", {}}
			},
			[2] = {
				{"empty_2"},
				{"empty_3"},
				{"modifier_ancient_apparition_9","#modifier_ancient_apparition_9", 3, "ancient_apparition/9", {}},
				{"modifier_woda_talent_miss1", "#woda_talent_miss1", 2, "miss1", {}},
				{"modifier_woda_talent_agi6", "#woda_talent_agi6", 1, "agi6", {"modifier_woda_talent_agi3",2}}
			},
			[3] = {
				{"empty_6"},
				{"empty_7"},
				{"modifier_ancient_apparition_10","#modifier_ancient_apparition_10", 2, "ancient_apparition/10", {}},
				{"modifier_woda_talent_mask1", "#woda_talent_mask1", 2, "mask1", {}},
				{"modifier_woda_talent_yasha", "#woda_talent_yasha", 1, "yasha", {"modifier_woda_talent_agi6",1}}
			},
			[4] = {
				{"empty_10"},
				{"modifier_woda_talent_speed2", "#woda_talent_speed2", 3, "speed2", {"modifier_woda_talent_speed1",2}},
				{"modifier_woda_talent_grovebow", "#woda_talent_grovebow", 2, "grovebow", {}},
				{"modifier_ancient_apparition_11","#modifier_ancient_apparition_11", 2, "ancient_apparition/11", {}},			
				{"modifier_woda_talent_agi4", "#woda_talent_agi4", 1, "agi4", {"modifier_woda_talent_yasha",1}}
			},
			[5] = {
				{"modifier_woda_talent_attack2", "#woda_talent_attack2", 3, "attack2", {}},
				{"empty_11"},
				{"modifier_ancient_apparition_12","#modifier_ancient_apparition_12", 2, "ancient_apparition/12", {}},
				{"empty_12"},
				{"modifier_woda_talent_agi5", "#woda_talent_agi5", 3, "agi5", {"modifier_woda_talent_agi4",1}}
			},
			[6] = {
				{"modifier_woda_talent_miss2", "#woda_talent_miss2", 2, "miss2", {}},
				{"modifier_ancient_apparition_13","#modifier_ancient_apparition_13", 3, "ancient_apparition/13", {}},
				{"modifier_woda_talent_attackspeed2", "#woda_talent_attackspeed2", 3, "attackspeed2", {}},
				{"empty_13"},
				{"empty_16"}
			},
			[7] = {
				{"empty_17"},
				{"empty_18"},
				{"modifier_ancient_apparition_14","#modifier_ancient_apparition_14", 1, "ancient_apparition/14", {}},
				{"empty_20"},
				{"empty_21"}
			}
		},
		[3] = {
			[1] = {
				{"modifier_woda_talent_mp1", "#woda_talent_mp1", 3, "mp1", {}},
				{"modifier_woda_talent_regenmp1", "#woda_talent_regenmp1", 2, "regenmp1", {}},
				{"modifier_woda_talent_spell", "#woda_talent_spell", 3, "spell", {}},
				{"modifier_ancient_apparition_15","#modifier_ancient_apparition_15", 2, "ancient_apparition/15", {}},
				{"modifier_woda_talent_int3", "#woda_talent_int3", 2, "int3", {}}
			},
			[2] = {
				{"empty_2"},
				{"empty_3"},
				{"modifier_ancient_apparition_16","#modifier_ancient_apparition_16", 3, "ancient_apparition/16", {}},
				{"modifier_woda_talent_blood", "#woda_talent_blood", 2, "blood", {}},
				{"modifier_woda_talent_int6", "#woda_talent_int6", 1, "int6", {"modifier_woda_talent_int3",2}}
			},
			[3] = {
				{"empty_6"},
				{"empty_7"},
				{"modifier_ancient_apparition_18","#modifier_ancient_apparition_18", 3, "ancient_apparition/18", {}},
				{"modifier_woda_talent_mask2", "#woda_talent_mask2", 2, "mask2", {}},
				{"modifier_woda_talent_kaya", "#woda_talent_kaya", 1, "kaya", {"modifier_woda_talent_int6",1}}
			},
			[4] = {
				{"modifier_woda_talent_mp2", "#woda_talent_mp2", 3, "mp2", {"modifier_woda_talent_mp1",3}},
				{"modifier_woda_talent_fairy", "#woda_talent_fairy", 2, "fairy", {}},
				{"empty_9"},
				{"modifier_ancient_apparition_19","#modifier_ancient_apparition_19", 3, "ancient_apparition/19", {}},
				{"modifier_woda_talent_int4", "#woda_talent_int4", 1, "int4", {"modifier_woda_talent_kaya",1}}
			},
			[5] = {
				{"modifier_woda_talent_spellprism", "#woda_talent_spellprism", 3, "spellprism", {}},
				{"modifier_ancient_apparition_20","#modifier_ancient_apparition_20", 1, "ancient_apparition/20", {}},
				{"empty_11"},
				{"empty_12"},
				{"modifier_woda_talent_int5", "#woda_talent_int5", 3, "int5", {"modifier_woda_talent_int4",1}}
			},
			[6] = {
				{"modifier_woda_talent_timeless", "#woda_talent_timeless", 2, "timeless", {}},
				{"modifier_woda_talent_regenmp2", "#woda_talent_regenmp2", 3, "regenmp2", {}},
				{"modifier_ancient_apparition_17","#modifier_ancient_apparition_17", 1, "ancient_apparition/17", {}},
				{"empty_14"},
				{"empty_16"}
			},
			[7] = {
				{"empty_17"},
				{"empty_18"},
				{"modifier_ancient_apparition_21","#modifier_ancient_apparition_21", 1, "ancient_apparition/21", {}},
				{"empty_20"},
				{"empty_21"}
			}
		}
	},
	["npc_dota_hero_lich"] = {
		[1] = {
			[1] = {
				{"modifier_woda_talent_hp1", "#woda_talent_hp1", 3, "hp1", {}},
				{"modifier_woda_talent_regenhp1", "#woda_talent_regenhp1", 2, "regenhp1", {}},
				{"modifier_woda_talent_attack1", "#woda_talent_attack1", 3, "attack1", {}},
				{"modifier_lich_1","#modifier_lich_1", 3, "lich/1", {}},
				{"modifier_woda_talent_str3", "#woda_talent_str3", 2, "str3", {}}
			},
			[2] = {
				{"empty_2"},
				{"empty_3"},
				{"modifier_lich_2","#modifier_lich_2", 1, "lich/2", {}},
				{"modifier_woda_talent_cloak", "#woda_talent_cloak", 2, "cloak", {}},
				{"modifier_woda_talent_str6", "#woda_talent_str6", 1, "str6", {"modifier_woda_talent_str3",2}}
			},
			[3] = {
				{"empty_6"},
				{"modifier_woda_talent_quickhp", "#woda_talent_quickhp", 2, "quickhp", {}},
				{"empty_8"},
				{"modifier_lich_3","#modifier_lich_3", 1, "lich/3", {}},
				{"modifier_woda_talent_sasha", "#woda_talent_sasha", 1, "sasha", {"modifier_woda_talent_str6",1}}
			},
			[4] = {
				{"modifier_woda_talent_hp2", "#woda_talent_hp2", 3, "hp2", {"modifier_woda_talent_hp1",3}},
				{"empty_9"},
				{"modifier_lich_4","#modifier_lich_4", 2, "lich/4", {"modifier_lich_2",1}},
				{"modifier_woda_talent_octar", "#woda_talent_octar", 2, "octar", {}},
				{"modifier_woda_talent_str4", "#woda_talent_str4", 1, "str4", {"modifier_woda_talent_sasha",1}}
			},
			[5] = {
				{"modifier_woda_talent_armor2", "#woda_talent_armor2", 3, "armor2", {}},
				{"modifier_lich_5","#modifier_lich_5", 3, "lich/5", {}},
				{"empty_10"},
				{"empty_11"},
				{"modifier_woda_talent_str5", "#woda_talent_str5", 3, "str5", {"modifier_woda_talent_str4",1}}
			},
			[6] = {
				{"modifier_woda_talent_sliver", "#woda_talent_sliver", 2, "sliver", {}},
				{"modifier_woda_talent_regenhp2", "#woda_talent_regenhp2", 3, "regenhp2", {}},
				{"modifier_lich_6","#modifier_lich_6", 3, "lich/6", {"modifier_lich_4",2}},
				{"empty_15"},
				{"empty_16"}
			},
			[7] = {
				{"empty_17"},
				{"empty_18"},
				{"modifier_lich_7","#modifier_lich_7", 1, "lich/7", {}},
				{"empty_20"},
				{"empty_21"}
			}
		},
		[2] = {
			[1] = {
				{"modifier_woda_talent_armor1", "#woda_talent_armor1", 3, "armor1", {}},
				{"modifier_woda_talent_speed1", "#woda_talent_speed1", 2, "speed1", {}},
				{"modifier_woda_talent_attackspeed1", "#woda_talent_attackspeed1", 3, "attackspeed1", {}},
				{"modifier_lich_8","#modifier_lich_8", 1, "lich/8", {}},
				{"modifier_woda_talent_agi3", "#woda_talent_agi3", 2, "agi3", {}}
			},
			[2] = {
				{"empty_2"},
				{"empty_3"},
				{"modifier_lich_9","#modifier_lich_9", 3, "lich/9", {}},
				{"modifier_woda_talent_miss1", "#woda_talent_miss1", 2, "miss1", {}},
				{"modifier_woda_talent_agi6", "#woda_talent_agi6", 1, "agi6", {"modifier_woda_talent_agi3",2}}
			},
			[3] = {
				{"empty_6"},
				{"empty_7"},
				{"modifier_lich_10","#modifier_lich_10", 2, "lich/10", {}},
				{"modifier_woda_talent_mask1", "#woda_talent_mask1", 2, "mask1", {}},
				{"modifier_woda_talent_yasha", "#woda_talent_yasha", 1, "yasha", {"modifier_woda_talent_agi6",1}}
			},
			[4] = {
				{"empty_10"},
				{"modifier_woda_talent_speed2", "#woda_talent_speed2", 3, "speed2", {"modifier_woda_talent_speed1",2}},
				{"modifier_woda_talent_grovebow", "#woda_talent_grovebow", 2, "grovebow", {}},
				{"modifier_lich_11","#modifier_lich_11", 3, "lich/11", {}},			
				{"modifier_woda_talent_agi4", "#woda_talent_agi4", 1, "agi4", {"modifier_woda_talent_yasha",1}}
			},
			[5] = {
				{"modifier_woda_talent_attack2", "#woda_talent_attack2", 3, "attack2", {}},
				{"empty_11"},
				{"modifier_lich_12","#modifier_lich_12", 1, "lich/12", {}},
				{"empty_12"},
				{"modifier_woda_talent_agi5", "#woda_talent_agi5", 3, "agi5", {"modifier_woda_talent_agi4",1}}
			},
			[6] = {
				{"modifier_woda_talent_miss2", "#woda_talent_miss2", 2, "miss2", {}},
				{"empty_13"},
				{"modifier_woda_talent_attackspeed2", "#woda_talent_attackspeed2", 3, "attackspeed2", {}},
				{"empty_15"},
				{"modifier_lich_13","#modifier_lich_13", 3, "lich/13", {}}
			},
			[7] = {
				{"empty_17"},
				{"empty_18"},
				{"modifier_lich_14","#modifier_lich_14", 1, "lich/14", {}},
				{"empty_20"},
				{"empty_21"}
			}
		},
		[3] = {
			[1] = {
				{"modifier_woda_talent_mp1", "#woda_talent_mp1", 3, "mp1", {}},
				{"modifier_woda_talent_regenmp1", "#woda_talent_regenmp1", 2, "regenmp1", {}},
				{"modifier_woda_talent_spell", "#woda_talent_spell", 3, "spell", {}},
				{"modifier_lich_15","#modifier_lich_15", 2, "lich/15", {}},
				{"modifier_woda_talent_int3", "#woda_talent_int3", 2, "int3", {}}
			},
			[2] = {
				{"empty_2"},
				{"empty_3"},
				{"modifier_lich_18","#modifier_lich_18", 1, "lich/18", {}},
				{"modifier_woda_talent_blood", "#woda_talent_blood", 2, "blood", {}},
				{"modifier_woda_talent_int6", "#woda_talent_int6", 1, "int6", {"modifier_woda_talent_int3",2}}
			},
			[3] = {
				{"empty_6"},
				{"empty_7"},
				{"modifier_lich_20","#modifier_lich_20", 3, "lich/20", {"modifier_lich_18",1}},
				{"modifier_woda_talent_mask2", "#woda_talent_mask2", 2, "mask2", {}},
				{"modifier_woda_talent_kaya", "#woda_talent_kaya", 1, "kaya", {"modifier_woda_talent_int6",1}}
			},
			[4] = {
				{"modifier_woda_talent_mp2", "#woda_talent_mp2", 3, "mp2", {"modifier_woda_talent_mp1",3}},
				{"modifier_woda_talent_fairy", "#woda_talent_fairy", 2, "fairy", {}},
				{"modifier_lich_16","#modifier_lich_16", 1, "lich/16", {"modifier_lich_20",3}},
				{"empty_9"},
				{"modifier_woda_talent_int4", "#woda_talent_int4", 1, "int4", {"modifier_woda_talent_kaya",1}}
			},
			[5] = {
				{"modifier_woda_talent_spellprism", "#woda_talent_spellprism", 3, "spellprism", {}},
				{"empty_11"},
				{"modifier_lich_17","#modifier_lich_17", 3, "lich/17", {"modifier_lich_16",1}},
				{"empty_12"},
				{"modifier_woda_talent_int5", "#woda_talent_int5", 3, "int5", {"modifier_woda_talent_int4",1}}
			},
			[6] = {
				{"modifier_woda_talent_timeless", "#woda_talent_timeless", 2, "timeless", {}},
				{"modifier_woda_talent_regenmp2", "#woda_talent_regenmp2", 3, "regenmp2", {}},
				{"modifier_lich_19","#modifier_lich_19", 3, "lich/19", {"modifier_lich_17",3}},
				{"empty_15"},
				{"empty_16"}
			},
			[7] = {
				{"empty_17"},
				{"empty_18"},
				{"modifier_lich_21","#modifier_lich_21", 1, "lich/21", {}},
				{"empty_20"},
				{"empty_21"}
			}
		}
	},
	["npc_dota_hero_meepo"] = {
		[1] = {
			[1] = {
				{"modifier_woda_talent_hp1", "#woda_talent_hp1", 3, "hp1", {}},
				{"modifier_woda_talent_regenhp1", "#woda_talent_regenhp1", 2, "regenhp1", {}},
				{"modifier_woda_talent_attack1", "#woda_talent_attack1", 3, "attack1", {}},
				{"modifier_meepo_1","#modifier_meepo_1", 3, "meepo/1", {}},
				{"modifier_woda_talent_str3", "#woda_talent_str3", 2, "str3", {}}
			},
			[2] = {
				{"empty_2"},
				{"empty_3"},
				{"modifier_meepo_2","#modifier_meepo_2", 3, "meepo/2", {}},
				{"modifier_woda_talent_cloak", "#woda_talent_cloak", 2, "cloak", {}},
				{"modifier_woda_talent_str6", "#woda_talent_str6", 1, "str6", {"modifier_woda_talent_str3",2}}
			},
			[3] = {
				{"empty_6"},
				{"modifier_woda_talent_quickhp", "#woda_talent_quickhp", 2, "quickhp", {}},
				{"empty_7"},
				{"modifier_meepo_3","#modifier_meepo_3", 1, "meepo/3", {}},
				{"modifier_woda_talent_sasha", "#woda_talent_sasha", 1, "sasha", {"modifier_woda_talent_str6",1}}
			},
			[4] = {
				{"modifier_woda_talent_hp2", "#woda_talent_hp2", 3, "hp2", {"modifier_woda_talent_hp1",3}},
				{"empty_9"},
				{"modifier_meepo_4","#modifier_meepo_4", 2, "meepo/4", {"modifier_meepo_2",3}},
				{"modifier_woda_talent_octar", "#woda_talent_octar", 2, "octar", {}},
				{"modifier_woda_talent_str4", "#woda_talent_str4", 1, "str4", {"modifier_woda_talent_sasha",1}}
			},
			[5] = {
				{"modifier_woda_talent_armor2", "#woda_talent_armor2", 3, "armor2", {}},
				{"empty_10"},
				{"empty_11"},
				{"modifier_meepo_5","#modifier_meepo_5", 3, "meepo/5", {}},
				{"modifier_woda_talent_str5", "#woda_talent_str5", 3, "str5", {"modifier_woda_talent_str4",1}}
			},
			[6] = {
				{"modifier_woda_talent_sliver", "#woda_talent_sliver", 2, "sliver", {}},
				{"modifier_woda_talent_regenhp2", "#woda_talent_regenhp2", 3, "regenhp2", {}},
				{"modifier_meepo_6","#modifier_meepo_6", 1, "meepo/6", {"modifier_meepo_4",2}},
				{"empty_15"},
				{"empty_16"}
			},
			[7] = {
				{"empty_17"},
				{"empty_18"},
				{"modifier_meepo_7","#modifier_meepo_7", 1, "meepo/7", {}},
				{"empty_20"},
				{"empty_21"}
			}
		},
		[2] = {
			[1] = {
				{"modifier_woda_talent_armor1", "#woda_talent_armor1", 3, "armor1", {}},
				{"modifier_woda_talent_speed1", "#woda_talent_speed1", 2, "speed1", {}},
				{"modifier_woda_talent_attackspeed1", "#woda_talent_attackspeed1", 3, "attackspeed1", {}},
				{"modifier_meepo_8","#modifier_meepo_8", 3, "meepo/8", {}},
				{"modifier_woda_talent_agi3", "#woda_talent_agi3", 2, "agi3", {}}
			},
			[2] = {
				{"empty_2"},
				{"empty_3"},
				{"modifier_meepo_9","#modifier_meepo_9", 2, "meepo/9", {}},
				{"modifier_woda_talent_miss1", "#woda_talent_miss1", 2, "miss1", {}},
				{"modifier_woda_talent_agi6", "#woda_talent_agi6", 1, "agi6", {"modifier_woda_talent_agi3",2}}
			},
			[3] = {
				{"empty_6"},
				{"empty_7"},
				{"modifier_meepo_10","#modifier_meepo_10", 2, "meepo/10", {}},
				{"modifier_woda_talent_mask1", "#woda_talent_mask1", 2, "mask1", {}},
				{"modifier_woda_talent_yasha", "#woda_talent_yasha", 1, "yasha", {"modifier_woda_talent_agi6",1}}
			},
			[4] = {
				{"modifier_meepo_11","#modifier_meepo_11", 3, "meepo/11", {}},
				{"modifier_woda_talent_speed2", "#woda_talent_speed2", 3, "speed2", {"modifier_woda_talent_speed1",2}},
				{"modifier_woda_talent_grovebow", "#woda_talent_grovebow", 2, "grovebow", {}},
				{"empty_10"},			
				{"modifier_woda_talent_agi4", "#woda_talent_agi4", 1, "agi4", {"modifier_woda_talent_yasha",1}}
			},
			[5] = {
				{"modifier_woda_talent_attack2", "#woda_talent_attack2", 3, "attack2", {}},
				{"modifier_meepo_12","#modifier_meepo_12", 2, "meepo/12", {}},
				{"empty_11"},
				{"empty_12"},
				{"modifier_woda_talent_agi5", "#woda_talent_agi5", 3, "agi5", {"modifier_woda_talent_agi4",1}}
			},
			[6] = {
				{"modifier_woda_talent_miss2", "#woda_talent_miss2", 2, "miss2", {}},
				{"modifier_meepo_13","#modifier_meepo_13", 1, "meepo/13", {}},
				{"modifier_woda_talent_attackspeed2", "#woda_talent_attackspeed2", 3, "attackspeed2", {}},
				{"empty_15"},
				{"empty_16"}
			},
			[7] = {
				{"empty_17"},
				{"empty_18"},
				{"modifier_meepo_14","#modifier_meepo_14", 1, "meepo/14", {}},
				{"empty_20"},
				{"empty_21"}
			}
		},
		[3] = {
			[1] = {
				{"modifier_woda_talent_mp1", "#woda_talent_mp1", 3, "mp1", {}},
				{"modifier_woda_talent_regenmp1", "#woda_talent_regenmp1", 2, "regenmp1", {}},
				{"modifier_woda_talent_spell", "#woda_talent_spell", 3, "spell", {}},
				{"modifier_meepo_15","#modifier_meepo_15", 2, "meepo/15", {}},
				{"modifier_woda_talent_int3", "#woda_talent_int3", 2, "int3", {}}
			},
			[2] = {
				{"empty_2"},
				{"empty_3"},
				{"modifier_meepo_21","#modifier_meepo_21", 2, "meepo/21", {}},
				{"modifier_woda_talent_blood", "#woda_talent_blood", 2, "blood", {}},
				{"modifier_woda_talent_int6", "#woda_talent_int6", 1, "int6", {"modifier_woda_talent_int3",2}}
			},
			[3] = {
				{"empty_6"},
				{"modifier_meepo_17","#modifier_meepo_17", 2, "meepo/17", {}},
				{"empty_7"},
				{"modifier_woda_talent_mask2", "#woda_talent_mask2", 2, "mask2", {}},
				{"modifier_woda_talent_kaya", "#woda_talent_kaya", 1, "kaya", {"modifier_woda_talent_int6",1}}
			},
			[4] = {
				{"modifier_woda_talent_mp2", "#woda_talent_mp2", 3, "mp2", {"modifier_woda_talent_mp1",3}},
				{"modifier_woda_talent_fairy", "#woda_talent_fairy", 2, "fairy", {}},
				{"empty_9"},
				{"modifier_meepo_19","#modifier_meepo_19", 2, "meepo/19", {}},
				{"modifier_woda_talent_int4", "#woda_talent_int4", 1, "int4", {"modifier_woda_talent_kaya",1}}
			},
			[5] = {
				{"modifier_woda_talent_spellprism", "#woda_talent_spellprism", 3, "spellprism", {}},
				{"empty_10"},
				{"empty_11"},
				{"modifier_meepo_18","#modifier_meepo_18", 3, "meepo/18", {}},
				{"modifier_woda_talent_int5", "#woda_talent_int5", 3, "int5", {"modifier_woda_talent_int4",1}}
			},
			[6] = {
				{"modifier_woda_talent_timeless", "#woda_talent_timeless", 2, "timeless", {}},
				{"modifier_woda_talent_regenmp2", "#woda_talent_regenmp2", 3, "regenmp2", {}},
				{"empty_14"},
				{"empty_15"},
				{"modifier_meepo_20","#modifier_meepo_20", 2, "meepo/20", {}}
			},
			[7] = {
				{"empty_17"},
				{"empty_18"},
				{"modifier_meepo_16","#modifier_meepo_16", 1, "meepo/16", {}},
				{"empty_20"},
				{"empty_21"}
			}
		}
	},
	["npc_dota_hero_dazzle"] = {
		[1] = {
			[1] = {
				{"modifier_woda_talent_hp1", "#woda_talent_hp1", 3, "hp1", {}},
				{"modifier_woda_talent_regenhp1", "#woda_talent_regenhp1", 2, "regenhp1", {}},
				{"modifier_dazzle_1","#modifier_dazzle_1", 3, "dazzle/1", {}},
				{"modifier_woda_talent_attack1", "#woda_talent_attack1", 3, "attack1", {}},
				{"modifier_woda_talent_str3", "#woda_talent_str3", 2, "str3", {}}
			},
			[2] = {
				{"empty_2"},
				{"empty_3"},
				{"modifier_dazzle_2","#modifier_dazzle_2", 2, "dazzle/2", {"modifier_dazzle_1",3}},
				{"modifier_woda_talent_cloak", "#woda_talent_cloak", 2, "cloak", {}},
				{"modifier_woda_talent_str6", "#woda_talent_str6", 1, "str6", {"modifier_woda_talent_str3",2}}
			},
			[3] = {
				{"empty_6"},
				{"modifier_woda_talent_quickhp", "#woda_talent_quickhp", 2, "quickhp", {}},
				{"empty_7"},
				{"modifier_dazzle_3","#modifier_dazzle_3", 2, "dazzle/3", {}},
				{"modifier_woda_talent_sasha", "#woda_talent_sasha", 1, "sasha", {"modifier_woda_talent_str6",1}}
			},
			[4] = {
				{"modifier_woda_talent_hp2", "#woda_talent_hp2", 3, "hp2", {"modifier_woda_talent_hp1",3}},
				{"empty_9"},
				{"modifier_dazzle_4","#modifier_dazzle_4", 2, "dazzle/4", {"modifier_dazzle_2",2}},
				{"modifier_woda_talent_octar", "#woda_talent_octar", 2, "octar", {}},
				{"modifier_woda_talent_str4", "#woda_talent_str4", 1, "str4", {"modifier_woda_talent_sasha",1}}
			},
			[5] = {
				{"modifier_woda_talent_armor2", "#woda_talent_armor2", 3, "armor2", {}},
				{"modifier_dazzle_5","#modifier_dazzle_5", 2, "dazzle/5", {}},
				{"empty_10"},
				{"empty_11"},
				{"modifier_woda_talent_str5", "#woda_talent_str5", 3, "str5", {"modifier_woda_talent_str4",1}}
			},
			[6] = {
				{"modifier_woda_talent_sliver", "#woda_talent_sliver", 2, "sliver", {}},
				{"modifier_woda_talent_regenhp2", "#woda_talent_regenhp2", 3, "regenhp2", {}},
				{"modifier_dazzle_6","#modifier_dazzle_6", 2, "dazzle/6", {"modifier_dazzle_4",2}},
				{"empty_15"},
				{"empty_16"}
			},
			[7] = {
				{"empty_17"},
				{"empty_18"},
				{"modifier_dazzle_7","#modifier_dazzle_7", 1, "dazzle/7", {}},
				{"empty_20"},
				{"empty_21"}
			}
		},
		[2] = {
			[1] = {
				{"modifier_woda_talent_armor1", "#woda_talent_armor1", 3, "armor1", {}},
				{"modifier_woda_talent_speed1", "#woda_talent_speed1", 2, "speed1", {}},
				{"modifier_woda_talent_attackspeed1", "#woda_talent_attackspeed1", 3, "attackspeed1", {}},
				{"modifier_dazzle_12","#modifier_dazzle_12", 3, "dazzle/12", {}},
				{"modifier_woda_talent_agi3", "#woda_talent_agi3", 2, "agi3", {}}
			},
			[2] = {
				{"modifier_dazzle_8","#modifier_dazzle_8", 1, "dazzle/8", {}},
				{"empty_3"},
				{"empty_4"},
				{"modifier_woda_talent_miss1", "#woda_talent_miss1", 2, "miss1", {}},
				{"modifier_woda_talent_agi6", "#woda_talent_agi6", 1, "agi6", {"modifier_woda_talent_agi3",2}}
			},
			[3] = {
				{"modifier_dazzle_10","#modifier_dazzle_10", 2, "dazzle/10", {}},
				{"empty_7"},
				{"empty_8"},
				{"modifier_woda_talent_mask1", "#woda_talent_mask1", 2, "mask1", {}},
				{"modifier_woda_talent_yasha", "#woda_talent_yasha", 1, "yasha", {"modifier_woda_talent_agi6",1}}
			},
			[4] = {
				{"modifier_dazzle_11","#modifier_dazzle_11", 1, "dazzle/11", {}},
				{"modifier_woda_talent_speed2", "#woda_talent_speed2", 3, "speed2", {"modifier_woda_talent_speed1",2}},
				{"modifier_woda_talent_grovebow", "#woda_talent_grovebow", 2, "grovebow", {}},
				{"empty_10"},			
				{"modifier_woda_talent_agi4", "#woda_talent_agi4", 1, "agi4", {"modifier_woda_talent_yasha",1}}
			},
			[5] = {
				{"modifier_woda_talent_attack2", "#woda_talent_attack2", 3, "attack2", {}},
				{"empty_11"},
				{"empty_12"},
				{"modifier_dazzle_9","#modifier_dazzle_9", 3, "dazzle/9", {}},
				{"modifier_woda_talent_agi5", "#woda_talent_agi5", 3, "agi5", {"modifier_woda_talent_agi4",1}}
			},
			[6] = {
				{"modifier_woda_talent_miss2", "#woda_talent_miss2", 2, "miss2", {}},
				{"empty_13"},
				{"modifier_woda_talent_attackspeed2", "#woda_talent_attackspeed2", 3, "attackspeed2", {}},
				{"modifier_dazzle_13","#modifier_dazzle_13", 3, "dazzle/13", {}},
				{"empty_16"}
			},
			[7] = {
				{"empty_17"},
				{"empty_18"},
				{"modifier_dazzle_14","#modifier_dazzle_14", 1, "dazzle/14", {}},
				{"empty_20"},
				{"empty_21"}
			}
		},
		[3] = {
			[1] = {
				{"modifier_woda_talent_mp1", "#woda_talent_mp1", 3, "mp1", {}},
				{"modifier_woda_talent_regenmp1", "#woda_talent_regenmp1", 2, "regenmp1", {}},
				{"modifier_woda_talent_spell", "#woda_talent_spell", 3, "spell", {}},
				{"modifier_dazzle_15","#modifier_dazzle_15", 3, "dazzle/15", {}},
				{"modifier_woda_talent_int3", "#woda_talent_int3", 2, "int3", {}}
			},
			[2] = {
				{"empty_2"},
				{"empty_3"},
				{"modifier_dazzle_16","#modifier_dazzle_16", 1, "dazzle/16", {}},
				{"modifier_woda_talent_blood", "#woda_talent_blood", 2, "blood", {}},
				{"modifier_woda_talent_int6", "#woda_talent_int6", 1, "int6", {"modifier_woda_talent_int3",2}}
			},
			[3] = {
				{"empty_6"},
				{"empty_7"},
				{"modifier_dazzle_17","#modifier_dazzle_17", 3, "dazzle/17", {"modifier_dazzle_16",1}},
				{"modifier_woda_talent_mask2", "#woda_talent_mask2", 2, "mask2", {}},
				{"modifier_woda_talent_kaya", "#woda_talent_kaya", 1, "kaya", {"modifier_woda_talent_int6",1}}
			},
			[4] = {
				{"modifier_woda_talent_mp2", "#woda_talent_mp2", 3, "mp2", {"modifier_woda_talent_mp1",3}},
				{"modifier_woda_talent_fairy", "#woda_talent_fairy", 2, "fairy", {}},
				{"modifier_dazzle_18","#modifier_dazzle_18", 1, "dazzle/18", {"modifier_dazzle_17",3}},
				{"empty_9"},
				{"modifier_woda_talent_int4", "#woda_talent_int4", 1, "int4", {"modifier_woda_talent_kaya",1}}
			},
			[5] = {
				{"modifier_woda_talent_spellprism", "#woda_talent_spellprism", 3, "spellprism", {}},
				{"empty_10"},
				{"empty_11"},
				{"modifier_dazzle_19","#modifier_dazzle_19", 2, "dazzle/19", {}},
				{"modifier_woda_talent_int5", "#woda_talent_int5", 3, "int5", {"modifier_woda_talent_int4",1}}
			},
			[6] = {
				{"modifier_woda_talent_timeless", "#woda_talent_timeless", 2, "timeless", {}},
				{"modifier_woda_talent_regenmp2", "#woda_talent_regenmp2", 3, "regenmp2", {}},
				{"modifier_dazzle_20","#modifier_dazzle_20", 3, "dazzle/20", {}},
				{"empty_15"},
				{"empty_16"}
			},
			[7] = {
				{"empty_17"},
				{"empty_18"},
				{"modifier_dazzle_21","#modifier_dazzle_21", 1, "dazzle/21", {}},
				{"empty_20"},
				{"empty_21"}
			}
		}
	},
	["npc_dota_hero_skeleton_king"] = {
		[1] = {
			[1] = {
				{"modifier_woda_talent_hp1", "#woda_talent_hp1", 3, "hp1", {}},
				{"modifier_woda_talent_regenhp1", "#woda_talent_regenhp1", 2, "regenhp1", {}},
				{"modifier_woda_talent_attack1", "#woda_talent_attack1", 3, "attack1", {}},
				{"modifier_skeleton_king_1","#modifier_skeleton_king_1", 2, "skeleton_king/1", {}},
				{"modifier_woda_talent_str3", "#woda_talent_str3", 2, "str3", {}}
			},
			[2] = {
				{"empty_2"},
				{"modifier_skeleton_king_2","#modifier_skeleton_king_2", 1, "skeleton_king/2", {}},
				{"empty_3"},
				{"modifier_woda_talent_cloak", "#woda_talent_cloak", 2, "cloak", {}},
				{"modifier_woda_talent_str6", "#woda_talent_str6", 1, "str6", {"modifier_woda_talent_str3",2}}
			},
			[3] = {
				{"empty_6"},
				{"modifier_woda_talent_quickhp", "#woda_talent_quickhp", 2, "quickhp", {}},
				{"empty_7"},
				{"modifier_skeleton_king_3","#modifier_skeleton_king_3", 2, "skeleton_king/3", {}},
				{"modifier_woda_talent_sasha", "#woda_talent_sasha", 1, "sasha", {"modifier_woda_talent_str6",1}}
			},
			[4] = {
				{"modifier_woda_talent_hp2", "#woda_talent_hp2", 3, "hp2", {"modifier_woda_talent_hp1",3}},
				{"empty_9"},
				{"modifier_skeleton_king_5","#modifier_skeleton_king_5", 2, "skeleton_king/5", {}},
				{"modifier_woda_talent_octar", "#woda_talent_octar", 2, "octar", {}},
				{"modifier_woda_talent_str4", "#woda_talent_str4", 1, "str4", {"modifier_woda_talent_sasha",1}}
			},
			[5] = {
				{"modifier_woda_talent_armor2", "#woda_talent_armor2", 3, "armor2", {}},
				{"empty_10"},
				{"modifier_skeleton_king_4","#modifier_skeleton_king_4", 3, "skeleton_king/4", {"modifier_skeleton_king_5",2}},
				{"empty_11"},
				{"modifier_woda_talent_str5", "#woda_talent_str5", 3, "str5", {"modifier_woda_talent_str4",1}}
			},
			[6] = {
				{"modifier_woda_talent_sliver", "#woda_talent_sliver", 2, "sliver", {}},
				{"modifier_woda_talent_regenhp2", "#woda_talent_regenhp2", 3, "regenhp2", {}},
				{"empty_14"},
				{"modifier_skeleton_king_6","#modifier_skeleton_king_6", 3, "skeleton_king/6", {}},
				{"empty_16"}
			},
			[7] = {
				{"empty_17"},
				{"empty_18"},
				{"modifier_skeleton_king_7","#modifier_skeleton_king_7", 1, "skeleton_king/7", {}},
				{"empty_20"},
				{"empty_21"}
			}
		},
		[2] = {
			[1] = {
				{"modifier_woda_talent_armor1", "#woda_talent_armor1", 3, "armor1", {}},
				{"modifier_woda_talent_speed1", "#woda_talent_speed1", 2, "speed1", {}},
				{"modifier_woda_talent_attackspeed1", "#woda_talent_attackspeed1", 3, "attackspeed1", {}},
				{"modifier_skeleton_king_8","#modifier_skeleton_king_8", 3, "skeleton_king/8", {}},
				{"modifier_woda_talent_agi3", "#woda_talent_agi3", 2, "agi3", {}}
			},
			[2] = {
				{"modifier_skeleton_king_9","#modifier_skeleton_king_9", 3, "skeleton_king/9", {}},
				{"empty_3"},
				{"empty_4"},
				{"modifier_woda_talent_miss1", "#woda_talent_miss1", 2, "miss1", {}},
				{"modifier_woda_talent_agi6", "#woda_talent_agi6", 1, "agi6", {"modifier_woda_talent_agi3",2}}
			},
			[3] = {
				{"modifier_skeleton_king_10","#modifier_skeleton_king_10", 2, "skeleton_king/10", {}},
				{"empty_7"},
				{"empty_8"},
				{"modifier_woda_talent_mask1", "#woda_talent_mask1", 2, "mask1", {}},
				{"modifier_woda_talent_yasha", "#woda_talent_yasha", 1, "yasha", {"modifier_woda_talent_agi6",1}}
			},
			[4] = {
				{"modifier_skeleton_king_11","#modifier_skeleton_king_11", 2, "skeleton_king/11", {}},
				{"modifier_woda_talent_speed2", "#woda_talent_speed2", 3, "speed2", {"modifier_woda_talent_speed1",2}},
				{"modifier_woda_talent_grovebow", "#woda_talent_grovebow", 2, "grovebow", {}},
				{"empty_10"},			
				{"modifier_woda_talent_agi4", "#woda_talent_agi4", 1, "agi4", {"modifier_woda_talent_yasha",1}}
			},
			[5] = {
				{"modifier_woda_talent_attack2", "#woda_talent_attack2", 3, "attack2", {}},
				{"empty_11"},
				{"empty_12"},
				{"modifier_skeleton_king_12","#modifier_skeleton_king_12", 1, "skeleton_king/12", {}},
				{"modifier_woda_talent_agi5", "#woda_talent_agi5", 3, "agi5", {"modifier_woda_talent_agi4",1}}
			},
			[6] = {
				{"modifier_woda_talent_miss2", "#woda_talent_miss2", 2, "miss2", {}},
				{"modifier_skeleton_king_13","#modifier_skeleton_king_13", 2, "skeleton_king/13", {}},
				{"modifier_woda_talent_attackspeed2", "#woda_talent_attackspeed2", 3, "attackspeed2", {}},
				{"empty_15"},
				{"empty_16"}
			},
			[7] = {
				{"empty_17"},
				{"empty_18"},
				{"modifier_skeleton_king_14","#modifier_skeleton_king_14", 1, "skeleton_king/14", {}},
				{"empty_20"},
				{"empty_21"}
			}
		},
		[3] = {
			[1] = {
				{"modifier_woda_talent_mp1", "#woda_talent_mp1", 3, "mp1", {}},
				{"modifier_woda_talent_regenmp1", "#woda_talent_regenmp1", 2, "regenmp1", {}},
				{"modifier_woda_talent_spell", "#woda_talent_spell", 3, "spell", {}},
				{"modifier_skeleton_king_16","#modifier_skeleton_king_16", 2, "skeleton_king/16", {}},
				{"modifier_woda_talent_int3", "#woda_talent_int3", 2, "int3", {}}
			},
			[2] = {
				{"empty_2"},
				{"empty_3"},
				{"modifier_skeleton_king_15","#modifier_skeleton_king_15", 3, "skeleton_king/15", {}},
				{"modifier_woda_talent_blood", "#woda_talent_blood", 2, "blood", {}},
				{"modifier_woda_talent_int6", "#woda_talent_int6", 1, "int6", {"modifier_woda_talent_int3",2}}
			},
			[3] = {
				{"empty_6"},
				{"modifier_skeleton_king_17","#modifier_skeleton_king_17", 1, "skeleton_king/17", {}},
				{"empty_7"},
				{"modifier_woda_talent_mask2", "#woda_talent_mask2", 2, "mask2", {}},
				{"modifier_woda_talent_kaya", "#woda_talent_kaya", 1, "kaya", {"modifier_woda_talent_int6",1}}
			},
			[4] = {
				{"modifier_woda_talent_mp2", "#woda_talent_mp2", 3, "mp2", {"modifier_woda_talent_mp1",3}},
				{"modifier_woda_talent_fairy", "#woda_talent_fairy", 2, "fairy", {}},
				{"modifier_skeleton_king_18","#modifier_skeleton_king_18", 3, "skeleton_king/18", {}},
				{"empty_9"},
				{"modifier_woda_talent_int4", "#woda_talent_int4", 1, "int4", {"modifier_woda_talent_kaya",1}}
			},
			[5] = {
				{"modifier_woda_talent_spellprism", "#woda_talent_spellprism", 3, "spellprism", {}},
				{"empty_10"},
				{"empty_11"},
				{"modifier_skeleton_king_20","#modifier_skeleton_king_20", 3, "skeleton_king/20", {}},
				{"modifier_woda_talent_int5", "#woda_talent_int5", 3, "int5", {"modifier_woda_talent_int4",1}}
			},
			[6] = {
				{"modifier_woda_talent_timeless", "#woda_talent_timeless", 2, "timeless", {}},
				{"modifier_woda_talent_regenmp2", "#woda_talent_regenmp2", 3, "regenmp2", {}},
				{"empty_14"},
				{"empty_15"},
				{"modifier_skeleton_king_19","#modifier_skeleton_king_19", 1, "skeleton_king/19", {}}
			},
			[7] = {
				{"empty_17"},
				{"empty_18"},
				{"modifier_skeleton_king_21","#modifier_skeleton_king_21", 1, "skeleton_king/21", {}},
				{"empty_20"},
				{"empty_21"}
			}
		}
	},
	["npc_dota_hero_weaver"] = {
		[1] = {
			[1] = {
				{"modifier_woda_talent_hp1", "#woda_talent_hp1", 3, "hp1", {}},
				{"modifier_woda_talent_regenhp1", "#woda_talent_regenhp1", 2, "regenhp1", {}},
				{"modifier_woda_talent_attack1", "#woda_talent_attack1", 3, "attack1", {}},
				{"modifier_weaver_1","#modifier_weaver_1", 3, "weaver/1", {}},
				{"modifier_woda_talent_str3", "#woda_talent_str3", 2, "str3", {}}
			},
			[2] = {
				{"empty_2"},
				{"empty_3"},
				{"modifier_weaver_5","#modifier_weaver_5", 3, "weaver/5", {}},
				{"modifier_woda_talent_cloak", "#woda_talent_cloak", 2, "cloak", {}},
				{"modifier_woda_talent_str6", "#woda_talent_str6", 1, "str6", {"modifier_woda_talent_str3",2}}
			},
			[3] = {
				{"empty_6"},
				{"modifier_woda_talent_quickhp", "#woda_talent_quickhp", 2, "quickhp", {}},
				{"empty_7"},
				{"modifier_weaver_2","#modifier_weaver_2", 1, "weaver/2", {}},
				{"modifier_woda_talent_sasha", "#woda_talent_sasha", 1, "sasha", {"modifier_woda_talent_str6",1}}
			},
			[4] = {
				{"modifier_woda_talent_hp2", "#woda_talent_hp2", 3, "hp2", {"modifier_woda_talent_hp1",3}},
				{"empty_9"},
				{"modifier_weaver_4","#modifier_weaver_4", 3, "weaver/4", {}},
				{"modifier_woda_talent_octar", "#woda_talent_octar", 2, "octar", {}},
				{"modifier_woda_talent_str4", "#woda_talent_str4", 1, "str4", {"modifier_woda_talent_sasha",1}}
			},
			[5] = {
				{"modifier_woda_talent_armor2", "#woda_talent_armor2", 3, "armor2", {}},
				{"modifier_weaver_3","#modifier_weaver_3", 1, "weaver/3", {}},
				{"empty_10"},
				{"empty_11"},
				{"modifier_woda_talent_str5", "#woda_talent_str5", 3, "str5", {"modifier_woda_talent_str4",1}}
			},
			[6] = {
				{"modifier_woda_talent_sliver", "#woda_talent_sliver", 2, "sliver", {}},
				{"modifier_woda_talent_regenhp2", "#woda_talent_regenhp2", 3, "regenhp2", {}},
				{"modifier_weaver_6","#modifier_weaver_6", 2, "weaver/6", {"modifier_weaver_4",3}},
				{"empty_15"},
				{"empty_16"}
			},
			[7] = {
				{"empty_17"},
				{"empty_18"},
				{"modifier_weaver_7","#modifier_weaver_7", 1, "weaver/7", {}},
				{"empty_20"},
				{"empty_21"}
			}
		},
		[2] = {
			[1] = {
				{"modifier_woda_talent_armor1", "#woda_talent_armor1", 3, "armor1", {}},
				{"modifier_woda_talent_speed1", "#woda_talent_speed1", 2, "speed1", {}},
				{"modifier_woda_talent_attackspeed1", "#woda_talent_attackspeed1", 3, "attackspeed1", {}},
				{"modifier_weaver_8","#modifier_weaver_8", 3, "weaver/8", {}},
				{"modifier_woda_talent_agi3", "#woda_talent_agi3", 2, "agi3", {}}
			},
			[2] = {
				{"empty_2"},
				{"empty_3"},
				{"modifier_weaver_10","#modifier_weaver_10", 3, "weaver/10", {}},
				{"modifier_woda_talent_miss1", "#woda_talent_miss1", 2, "miss1", {}},
				{"modifier_woda_talent_agi6", "#woda_talent_agi6", 1, "agi6", {"modifier_woda_talent_agi3",2}}
			},
			[3] = {
				{"empty_7"},
				{"empty_8"},
				{"modifier_weaver_9","#modifier_weaver_9", 1, "weaver/9", {}},
				{"modifier_woda_talent_mask1", "#woda_talent_mask1", 2, "mask1", {}},
				{"modifier_woda_talent_yasha", "#woda_talent_yasha", 1, "yasha", {"modifier_woda_talent_agi6",1}}
			},
			[4] = {
				{"empty_10"},
				{"modifier_woda_talent_speed2", "#woda_talent_speed2", 3, "speed2", {"modifier_woda_talent_speed1",2}},
				{"modifier_woda_talent_grovebow", "#woda_talent_grovebow", 2, "grovebow", {}},
				{"modifier_weaver_11","#modifier_weaver_11", 2, "weaver/11", {}},			
				{"modifier_woda_talent_agi4", "#woda_talent_agi4", 1, "agi4", {"modifier_woda_talent_yasha",1}}
			},
			[5] = {
				{"modifier_woda_talent_attack2", "#woda_talent_attack2", 3, "attack2", {}},
				{"empty_11"},
				{"empty_12"},
				{"modifier_weaver_12","#modifier_weaver_12", 2, "weaver/12", {}},
				{"modifier_woda_talent_agi5", "#woda_talent_agi5", 3, "agi5", {"modifier_woda_talent_agi4",1}}
			},
			[6] = {
				{"modifier_woda_talent_miss2", "#woda_talent_miss2", 2, "miss2", {}},
				{"empty_13"},
				{"modifier_woda_talent_attackspeed2", "#woda_talent_attackspeed2", 3, "attackspeed2", {}},
				{"empty_15"},
				{"modifier_weaver_13","#modifier_weaver_13", 2, "weaver/13", {}}
			},
			[7] = {
				{"empty_17"},
				{"empty_18"},
				{"modifier_weaver_14","#modifier_weaver_14", 1, "weaver/14", {}},
				{"empty_20"},
				{"empty_21"}
			}
		},
		[3] = {
			[1] = {
				{"modifier_woda_talent_mp1", "#woda_talent_mp1", 3, "mp1", {}},
				{"modifier_woda_talent_regenmp1", "#woda_talent_regenmp1", 2, "regenmp1", {}},
				{"modifier_woda_talent_spell", "#woda_talent_spell", 3, "spell", {}},
				{"modifier_weaver_15","#modifier_weaver_15", 2, "weaver/15", {}},
				{"modifier_woda_talent_int3", "#woda_talent_int3", 2, "int3", {}}
			},
			[2] = {
				{"empty_2"},
				{"empty_3"},
				{"modifier_weaver_16","#modifier_weaver_16", 3, "weaver/16", {}},
				{"modifier_woda_talent_blood", "#woda_talent_blood", 2, "blood", {}},
				{"modifier_woda_talent_int6", "#woda_talent_int6", 1, "int6", {"modifier_woda_talent_int3",2}}
			},
			[3] = {
				{"empty_6"},
				{"empty_7"},
				{"modifier_weaver_17","#modifier_weaver_17", 2, "weaver/17", {}},
				{"modifier_woda_talent_mask2", "#woda_talent_mask2", 2, "mask2", {}},
				{"modifier_woda_talent_kaya", "#woda_talent_kaya", 1, "kaya", {"modifier_woda_talent_int6",1}}
			},
			[4] = {
				{"modifier_woda_talent_mp2", "#woda_talent_mp2", 3, "mp2", {"modifier_woda_talent_mp1",3}},
				{"modifier_woda_talent_fairy", "#woda_talent_fairy", 2, "fairy", {}},
				{"modifier_weaver_18","#modifier_weaver_18", 2, "weaver/18", {}},
				{"empty_9"},
				{"modifier_woda_talent_int4", "#woda_talent_int4", 1, "int4", {"modifier_woda_talent_kaya",1}}
			},
			[5] = {
				{"modifier_woda_talent_spellprism", "#woda_talent_spellprism", 3, "spellprism", {}},
				{"modifier_weaver_19","#modifier_weaver_19", 1, "weaver/19", {}},
				{"empty_10"},
				{"empty_11"},
				{"modifier_woda_talent_int5", "#woda_talent_int5", 3, "int5", {"modifier_woda_talent_int4",1}}
			},
			[6] = {
				{"modifier_woda_talent_timeless", "#woda_talent_timeless", 2, "timeless", {}},
				{"modifier_woda_talent_regenmp2", "#woda_talent_regenmp2", 3, "regenmp2", {}},
				{"modifier_weaver_20","#modifier_weaver_20", 3, "weaver/20", {}},
				{"empty_15"},
				{"empty_16"}
			},
			[7] = {
				{"empty_17"},
				{"empty_18"},
				{"modifier_weaver_21","#modifier_weaver_21", 1, "weaver/21", {}},
				{"empty_20"},
				{"empty_21"}
			}
		}
	},
	["npc_dota_hero_abaddon"] = {
		[1] = {
			[1] = {
				{"modifier_woda_talent_hp1", "#woda_talent_hp1", 3, "hp1", {}},
				{"modifier_woda_talent_regenhp1", "#woda_talent_regenhp1", 2, "regenhp1", {}},
				{"modifier_woda_talent_attack1", "#woda_talent_attack1", 3, "attack1", {}},
				{"modifier_abaddon_1","#modifier_abaddon_1", 1, "abaddon/1", {}},
				{"modifier_woda_talent_str3", "#woda_talent_str3", 2, "str3", {}}
			},
			[2] = {
				{"empty_2"},
				{"modifier_abaddon_4","#modifier_abaddon_4", 3, "abaddon/4", {}},
				{"empty_3"},
				{"modifier_woda_talent_cloak", "#woda_talent_cloak", 2, "cloak", {}},
				{"modifier_woda_talent_str6", "#woda_talent_str6", 1, "str6", {"modifier_woda_talent_str3",2}}
			},
			[3] = {
				{"empty_6"},
				{"modifier_woda_talent_quickhp", "#woda_talent_quickhp", 2, "quickhp", {}},
				{"empty_7"},
				{"modifier_abaddon_3","#modifier_abaddon_3", 3, "abaddon/3", {}},
				{"modifier_woda_talent_sasha", "#woda_talent_sasha", 1, "sasha", {"modifier_woda_talent_str6",1}}
			},
			[4] = {
				{"modifier_woda_talent_hp2", "#woda_talent_hp2", 3, "hp2", {"modifier_woda_talent_hp1",3}},
				{"modifier_abaddon_5","#modifier_abaddon_5", 3, "abaddon/5", {}},
				{"empty_9"},
				{"modifier_woda_talent_octar", "#woda_talent_octar", 2, "octar", {}},
				{"modifier_woda_talent_str4", "#woda_talent_str4", 1, "str4", {"modifier_woda_talent_sasha",1}}
			},
			[5] = {
				{"modifier_woda_talent_armor2", "#woda_talent_armor2", 3, "armor2", {}},
				{"empty_10"},
				{"empty_11"},
				{"modifier_abaddon_7","#modifier_abaddon_7", 1, "abaddon/7", {}},
				{"modifier_woda_talent_str5", "#woda_talent_str5", 3, "str5", {"modifier_woda_talent_str4",1}}
			},
			[6] = {
				{"modifier_woda_talent_sliver", "#woda_talent_sliver", 2, "sliver", {}},
				{"modifier_woda_talent_regenhp2", "#woda_talent_regenhp2", 3, "regenhp2", {}},
				{"empty_14"},
				{"empty_16"},
				{"modifier_abaddon_6","#modifier_abaddon_6", 2, "abaddon/6", {}}
			},
			[7] = {
				{"empty_17"},
				{"empty_18"},
				{"modifier_abaddon_2","#modifier_abaddon_2", 1, "abaddon/2", {}},
				{"empty_20"},
				{"empty_21"}
			}
		},
		[2] = {
			[1] = {
				{"modifier_abaddon_8","#modifier_abaddon_8", 1, "abaddon/8", {}},
				{"modifier_woda_talent_speed1", "#woda_talent_speed1", 2, "speed1", {}},
				{"modifier_woda_talent_attackspeed1", "#woda_talent_attackspeed1", 3, "attackspeed1", {}},
				{"modifier_woda_talent_armor1", "#woda_talent_armor1", 3, "armor1", {}},
				{"modifier_woda_talent_agi3", "#woda_talent_agi3", 2, "agi3", {}}
			},
			[2] = {
				{"modifier_abaddon_9","#modifier_abaddon_9", 3, "abaddon/9", {"modifier_abaddon_8",1}},
				{"empty_3"},
				{"empty_4"},
				{"modifier_woda_talent_miss1", "#woda_talent_miss1", 2, "miss1", {}},
				{"modifier_woda_talent_agi6", "#woda_talent_agi6", 1, "agi6", {"modifier_woda_talent_agi3",2}}
			},
			[3] = {
				{"modifier_abaddon_10","#modifier_abaddon_10", 1, "abaddon/10", {"modifier_abaddon_9",3}},
				{"empty_7"},
				{"empty_8"},
				{"modifier_woda_talent_mask1", "#woda_talent_mask1", 2, "mask1", {}},
				{"modifier_woda_talent_yasha", "#woda_talent_yasha", 1, "yasha", {"modifier_woda_talent_agi6",1}}
			},
			[4] = {
				{"modifier_abaddon_11","#modifier_abaddon_11", 3, "abaddon/11", {"modifier_abaddon_10",1}},
				{"modifier_woda_talent_speed2", "#woda_talent_speed2", 3, "speed2", {"modifier_woda_talent_speed1",2}},
				{"modifier_woda_talent_grovebow", "#woda_talent_grovebow", 2, "grovebow", {}},
				{"empty_10"},			
				{"modifier_woda_talent_agi4", "#woda_talent_agi4", 1, "agi4", {"modifier_woda_talent_yasha",1}}
			},
			[5] = {
				{"modifier_abaddon_12","#modifier_abaddon_12", 2, "abaddon/12", {"modifier_abaddon_11",3}},
				{"modifier_woda_talent_attack2", "#woda_talent_attack2", 3, "attack2", {}},
				{"empty_11"},
				{"empty_12"},
				{"modifier_woda_talent_agi5", "#woda_talent_agi5", 3, "agi5", {"modifier_woda_talent_agi4",1}}
			},
			[6] = {
				{"modifier_abaddon_13","#modifier_abaddon_13", 3, "abaddon/13", {"modifier_abaddon_12",2}},
				{"modifier_woda_talent_miss2", "#woda_talent_miss2", 2, "miss2", {}},
				{"modifier_woda_talent_attackspeed2", "#woda_talent_attackspeed2", 3, "attackspeed2", {}},
				{"empty_15"},
				{"empty_16"}
			},
			[7] = {
				{"empty_17"},
				{"empty_18"},
				{"modifier_abaddon_14","#modifier_abaddon_14", 1, "abaddon/14", {}},
				{"empty_20"},
				{"empty_21"}
			}
		},
		[3] = {
			[1] = {
				{"modifier_woda_talent_mp1", "#woda_talent_mp1", 3, "mp1", {}},
				{"modifier_woda_talent_regenmp1", "#woda_talent_regenmp1", 2, "regenmp1", {}},
				{"modifier_woda_talent_spell", "#woda_talent_spell", 3, "spell", {}},
				{"modifier_abaddon_18","#modifier_abaddon_18", 3, "abaddon/18", {}},
				{"modifier_woda_talent_int3", "#woda_talent_int3", 2, "int3", {}}
			},
			[2] = {
				{"empty_2"},
				{"empty_3"},
				{"modifier_abaddon_15","#modifier_abaddon_15", 1, "abaddon/15", {}},
				{"modifier_woda_talent_blood", "#woda_talent_blood", 2, "blood", {}},
				{"modifier_woda_talent_int6", "#woda_talent_int6", 1, "int6", {"modifier_woda_talent_int3",2}}
			},
			[3] = {
				{"empty_6"},
				{"empty_7"},
				{"modifier_abaddon_16","#modifier_abaddon_16", 2, "abaddon/16", {"modifier_abaddon_15",1}},
				{"modifier_woda_talent_mask2", "#woda_talent_mask2", 2, "mask2", {}},
				{"modifier_woda_talent_kaya", "#woda_talent_kaya", 1, "kaya", {"modifier_woda_talent_int6",1}}
			},
			[4] = {
				{"modifier_woda_talent_mp2", "#woda_talent_mp2", 3, "mp2", {"modifier_woda_talent_mp1",3}},
				{"modifier_woda_talent_fairy", "#woda_talent_fairy", 2, "fairy", {}},
				{"empty_9"},
				{"modifier_abaddon_20","#modifier_abaddon_20", 3, "abaddon/20", {}},
				{"modifier_woda_talent_int4", "#woda_talent_int4", 1, "int4", {"modifier_woda_talent_kaya",1}}
			},
			[5] = {
				{"modifier_woda_talent_spellprism", "#woda_talent_spellprism", 3, "spellprism", {}},
				{"modifier_abaddon_17","#modifier_abaddon_17", 2, "abaddon/17", {}},
				{"empty_10"},
				{"empty_11"},
				{"modifier_woda_talent_int5", "#woda_talent_int5", 3, "int5", {"modifier_woda_talent_int4",1}}
			},
			[6] = {
				{"modifier_woda_talent_timeless", "#woda_talent_timeless", 2, "timeless", {}},
				{"modifier_woda_talent_regenmp2", "#woda_talent_regenmp2", 3, "regenmp2", {}},
				{"modifier_abaddon_19","#modifier_abaddon_19", 2, "abaddon/19", {}},
				{"empty_14"},
				{"empty_16"}
			},
			[7] = {
				{"empty_17"},
				{"empty_18"},
				{"modifier_abaddon_21","#modifier_abaddon_21", 1, "abaddon/21", {}},
				{"empty_20"},
				{"empty_21"}
			}
		}
	},
	["npc_dota_hero_tiny"] = {
		[1] = {
			[1] = {
				{"modifier_woda_talent_hp1", "#woda_talent_hp1", 3, "hp1", {}},
				{"modifier_woda_talent_regenhp1", "#woda_talent_regenhp1", 2, "regenhp1", {}},
				{"modifier_woda_talent_attack1", "#woda_talent_attack1", 3, "attack1", {}},
				{"modifier_tiny_1","#modifier_tiny_1", 1, "tiny/1", {}},
				{"modifier_woda_talent_str3", "#woda_talent_str3", 2, "str3", {}}
			},
			[2] = {
				{"empty_2"},
				{"empty_3"},
				{"modifier_tiny_3","#modifier_tiny_3", 3, "tiny/3", {}},
				{"modifier_woda_talent_cloak", "#woda_talent_cloak", 2, "cloak", {}},
				{"modifier_woda_talent_str6", "#woda_talent_str6", 1, "str6", {"modifier_woda_talent_str3",2}}
			},
			[3] = {
				{"empty_6"},
				{"modifier_woda_talent_quickhp", "#woda_talent_quickhp", 2, "quickhp", {}},
				{"empty_7"},
				{"modifier_tiny_2","#modifier_tiny_2", 1, "tiny/2", {}},
				{"modifier_woda_talent_sasha", "#woda_talent_sasha", 1, "sasha", {"modifier_woda_talent_str6",1}}
			},
			[4] = {
				{"modifier_woda_talent_hp2", "#woda_talent_hp2", 3, "hp2", {"modifier_woda_talent_hp1",3}},
				{"empty_9"},
				{"modifier_tiny_4","#modifier_tiny_4", 2, "tiny/4", {}},
				{"modifier_woda_talent_octar", "#woda_talent_octar", 2, "octar", {}},
				{"modifier_woda_talent_str4", "#woda_talent_str4", 1, "str4", {"modifier_woda_talent_sasha",1}}
			},
			[5] = {
				{"modifier_woda_talent_armor2", "#woda_talent_armor2", 3, "armor2", {}},
				{"empty_10"},
				{"empty_11"},
				{"modifier_tiny_5","#modifier_tiny_5", 3, "tiny/5", {}},
				{"modifier_woda_talent_str5", "#woda_talent_str5", 3, "str5", {"modifier_woda_talent_str4",1}}
			},
			[6] = {
				{"modifier_woda_talent_sliver", "#woda_talent_sliver", 2, "sliver", {}},
				{"modifier_woda_talent_regenhp2", "#woda_talent_regenhp2", 3, "regenhp2", {}},
				{"modifier_tiny_6","#modifier_tiny_6", 3, "tiny/6", {}},
				{"empty_15"},
				{"empty_16"}
			},
			[7] = {
				{"empty_17"},
				{"empty_18"},
				{"modifier_tiny_7","#modifier_tiny_7", 1, "tiny/7", {}},
				{"empty_20"},
				{"empty_21"}
			}
		},
		[2] = {
			[1] = {
				{"modifier_woda_talent_armor1", "#woda_talent_armor1", 3, "armor1", {}},
				{"modifier_woda_talent_speed1", "#woda_talent_speed1", 2, "speed1", {}},
				{"modifier_woda_talent_attackspeed1", "#woda_talent_attackspeed1", 3, "attackspeed1", {}},
				{"modifier_tiny_8","#modifier_tiny_8", 2, "tiny/8", {}},
				{"modifier_woda_talent_agi3", "#woda_talent_agi3", 2, "agi3", {}}
			},
			[2] = {
				{"modifier_tiny_9","#modifier_tiny_9", 1, "tiny/9", {}},
				{"empty_3"},
				{"empty_4"},
				{"modifier_woda_talent_miss1", "#woda_talent_miss1", 2, "miss1", {}},
				{"modifier_woda_talent_agi6", "#woda_talent_agi6", 1, "agi6", {"modifier_woda_talent_agi3",2}}
			},
			[3] = {
				{"modifier_tiny_10","#modifier_tiny_10", 2, "tiny/10", {"modifier_tiny_9",1}},
				{"empty_7"},
				{"empty_8"},
				{"modifier_woda_talent_mask1", "#woda_talent_mask1", 2, "mask1", {}},
				{"modifier_woda_talent_yasha", "#woda_talent_yasha", 1, "yasha", {"modifier_woda_talent_agi6",1}}
			},
			[4] = {
				{"modifier_tiny_11","#modifier_tiny_11", 2, "tiny/11", {"modifier_tiny_10",2}},
				{"modifier_woda_talent_speed2", "#woda_talent_speed2", 3, "speed2", {"modifier_woda_talent_speed1",2}},
				{"modifier_woda_talent_grovebow", "#woda_talent_grovebow", 2, "grovebow", {}},
				{"empty_10"},			
				{"modifier_woda_talent_agi4", "#woda_talent_agi4", 1, "agi4", {"modifier_woda_talent_yasha",1}}
			},
			[5] = {
				{"modifier_woda_talent_attack2", "#woda_talent_attack2", 3, "attack2", {}},
				{"empty_11"},
				{"empty_12"},
				{"modifier_tiny_12","#modifier_tiny_12", 3, "tiny/12", {}},
				{"modifier_woda_talent_agi5", "#woda_talent_agi5", 3, "agi5", {"modifier_woda_talent_agi4",1}}
			},
			[6] = {
				{"modifier_woda_talent_miss2", "#woda_talent_miss2", 2, "miss2", {}},
				{"modifier_tiny_13","#modifier_tiny_13", 3, "tiny/13", {}},
				{"modifier_woda_talent_attackspeed2", "#woda_talent_attackspeed2", 3, "attackspeed2", {}},
				{"empty_15"},
				{"empty_16"}
			},
			[7] = {
				{"empty_17"},
				{"empty_18"},
				{"modifier_tiny_14","#modifier_tiny_14", 1, "tiny/14", {}},
				{"empty_20"},
				{"empty_21"}
			}
		},
		[3] = {
			[1] = {
				{"modifier_woda_talent_mp1", "#woda_talent_mp1", 3, "mp1", {}},
				{"modifier_woda_talent_regenmp1", "#woda_talent_regenmp1", 2, "regenmp1", {}},
				{"modifier_tiny_15","#modifier_tiny_15", 2, "tiny/15", {}},
				{"modifier_woda_talent_spell", "#woda_talent_spell", 3, "spell", {}},
				{"modifier_woda_talent_int3", "#woda_talent_int3", 2, "int3", {}}
			},
			[2] = {
				{"empty_2"},
				{"empty_3"},
				{"modifier_tiny_16","#modifier_tiny_16", 1, "tiny/16", {"modifier_tiny_15",2}},
				{"modifier_woda_talent_blood", "#woda_talent_blood", 2, "blood", {}},
				{"modifier_woda_talent_int6", "#woda_talent_int6", 1, "int6", {"modifier_woda_talent_int3",2}}
			},
			[3] = {
				{"empty_6"},
				{"empty_7"},
				{"modifier_tiny_17","#modifier_tiny_17", 3, "tiny/17", {}},
				{"modifier_woda_talent_mask2", "#woda_talent_mask2", 2, "mask2", {}},
				{"modifier_woda_talent_kaya", "#woda_talent_kaya", 1, "kaya", {"modifier_woda_talent_int6",1}}
			},
			[4] = {
				{"modifier_woda_talent_mp2", "#woda_talent_mp2", 3, "mp2", {"modifier_woda_talent_mp1",3}},
				{"modifier_woda_talent_fairy", "#woda_talent_fairy", 2, "fairy", {}},
				{"modifier_tiny_18","#modifier_tiny_18", 3, "tiny/18", {}},
				{"empty_9"},
				{"modifier_woda_talent_int4", "#woda_talent_int4", 1, "int4", {"modifier_woda_talent_kaya",1}}
			},
			[5] = {
				{"modifier_woda_talent_spellprism", "#woda_talent_spellprism", 3, "spellprism", {}},
				{"empty_10"},
				{"empty_11"},
				{"modifier_tiny_19","#modifier_tiny_19", 1, "tiny/19", {}},
				{"modifier_woda_talent_int5", "#woda_talent_int5", 3, "int5", {"modifier_woda_talent_int4",1}}
			},
			[6] = {
				{"modifier_woda_talent_timeless", "#woda_talent_timeless", 2, "timeless", {}},
				{"modifier_woda_talent_regenmp2", "#woda_talent_regenmp2", 3, "regenmp2", {}},
				{"empty_14"},
				{"empty_15"},
				{"modifier_tiny_20","#modifier_tiny_20", 3, "tiny/20", {}}
			},
			[7] = {
				{"empty_17"},
				{"empty_18"},
				{"modifier_tiny_21","#modifier_tiny_21", 1, "tiny/21", {}},
				{"empty_20"},
				{"empty_21"}
			}
		}
	},
	["npc_dota_hero_medusa"] = {
		[1] = {
			[1] = {
				{"modifier_woda_talent_hp1", "#woda_talent_hp1", 3, "hp1", {}},
				{"modifier_woda_talent_regenhp1", "#woda_talent_regenhp1", 2, "regenhp1", {}},
				{"modifier_medusa_3","#modifier_medusa_3", 1, "medusa/3", {}},
				{"modifier_woda_talent_attack1", "#woda_talent_attack1", 3, "attack1", {}},
				{"modifier_woda_talent_str3", "#woda_talent_str3", 2, "str3", {}}
			},
			[2] = {
				{"empty_2"},
				{"empty_3"},
				{"modifier_medusa_4","#modifier_medusa_4", 3, "medusa/4", {}},
				{"modifier_woda_talent_cloak", "#woda_talent_cloak", 2, "cloak", {}},
				{"modifier_woda_talent_str6", "#woda_talent_str6", 1, "str6", {"modifier_woda_talent_str3",2}}
			},
			[3] = {
				{"empty_6"},
				{"modifier_woda_talent_quickhp", "#woda_talent_quickhp", 2, "quickhp", {}},
				{"modifier_medusa_6","#modifier_medusa_6", 3, "medusa/6", {}},
				{"empty_7"},
				{"modifier_woda_talent_sasha", "#woda_talent_sasha", 1, "sasha", {"modifier_woda_talent_str6",1}}
			},
			[4] = {
				{"modifier_woda_talent_hp2", "#woda_talent_hp2", 3, "hp2", {"modifier_woda_talent_hp1",3}},
				{"empty_9"},
				{"modifier_medusa_1","#modifier_medusa_1", 2, "medusa/1", {}},
				{"modifier_woda_talent_octar", "#woda_talent_octar", 2, "octar", {}},
				{"modifier_woda_talent_str4", "#woda_talent_str4", 1, "str4", {"modifier_woda_talent_sasha",1}}
			},
			[5] = {
				{"modifier_woda_talent_armor2", "#woda_talent_armor2", 3, "armor2", {}},
				{"empty_10"},
				{"empty_11"},
				{"modifier_medusa_5","#modifier_medusa_5", 1, "medusa/5", {}},
				{"modifier_woda_talent_str5", "#woda_talent_str5", 3, "str5", {"modifier_woda_talent_str4",1}}
			},
			[6] = {
				{"modifier_woda_talent_sliver", "#woda_talent_sliver", 2, "sliver", {}},
				{"modifier_woda_talent_regenhp2", "#woda_talent_regenhp2", 3, "regenhp2", {}},
				{"empty_14"},
				{"empty_16"},
				{"modifier_medusa_2","#modifier_medusa_2", 3, "medusa/2", {}}
			},
			[7] = {
				{"empty_17"},
				{"empty_18"},
				{"modifier_medusa_7","#modifier_medusa_7", 1, "medusa/7", {}},
				{"empty_20"},
				{"empty_21"}
			}
		},
		[2] = {
			[1] = {
				{"modifier_woda_talent_armor1", "#woda_talent_armor1", 3, "armor1", {}},
				{"modifier_woda_talent_speed1", "#woda_talent_speed1", 2, "speed1", {}},
				{"modifier_woda_talent_attackspeed1", "#woda_talent_attackspeed1", 3, "attackspeed1", {}},
				{"modifier_medusa_8","#modifier_medusa_8", 1, "medusa/8", {}},
				{"modifier_woda_talent_agi3", "#woda_talent_agi3", 2, "agi3", {}}
			},
			[2] = {
				{"modifier_medusa_9","#modifier_medusa_9", 3, "medusa/9", {}},
				{"empty_3"},
				{"empty_4"},
				{"modifier_woda_talent_miss1", "#woda_talent_miss1", 2, "miss1", {}},
				{"modifier_woda_talent_agi6", "#woda_talent_agi6", 1, "agi6", {"modifier_woda_talent_agi3",2}}
			},
			[3] = {
				{"modifier_medusa_10","#modifier_medusa_10", 2, "medusa/10", {}},
				{"empty_7"},
				{"empty_8"},
				{"modifier_woda_talent_mask1", "#woda_talent_mask1", 2, "mask1", {}},
				{"modifier_woda_talent_yasha", "#woda_talent_yasha", 1, "yasha", {"modifier_woda_talent_agi6",1}}
			},
			[4] = {
				{"empty_10"},
				{"modifier_woda_talent_speed2", "#woda_talent_speed2", 3, "speed2", {"modifier_woda_talent_speed1",2}},
				{"modifier_woda_talent_grovebow", "#woda_talent_grovebow", 2, "grovebow", {}},
				{"modifier_medusa_11","#modifier_medusa_11", 3, "medusa/11", {}},			
				{"modifier_woda_talent_agi4", "#woda_talent_agi4", 1, "agi4", {"modifier_woda_talent_yasha",1}}
			},
			[5] = {
				{"modifier_woda_talent_attack2", "#woda_talent_attack2", 3, "attack2", {}},
				{"empty_11"},
				{"empty_12"},
				{"modifier_medusa_12","#modifier_medusa_12", 1, "medusa/12", {}},
				{"modifier_woda_talent_agi5", "#woda_talent_agi5", 3, "agi5", {"modifier_woda_talent_agi4",1}}
			},
			[6] = {
				{"modifier_woda_talent_miss2", "#woda_talent_miss2", 2, "miss2", {}},
				{"empty_13"},
				{"modifier_woda_talent_attackspeed2", "#woda_talent_attackspeed2", 3, "attackspeed2", {}},
				{"empty_15"},
				{"modifier_medusa_13","#modifier_medusa_13", 3, "medusa/13", {}}
			},
			[7] = {
				{"empty_17"},
				{"empty_18"},
				{"modifier_medusa_14","#modifier_medusa_14", 1, "medusa/14", {}},
				{"empty_20"},
				{"empty_21"}
			}
		},
		[3] = {
			[1] = {
				{"modifier_woda_talent_mp1", "#woda_talent_mp1", 3, "mp1", {}},
				{"modifier_woda_talent_regenmp1", "#woda_talent_regenmp1", 2, "regenmp1", {}},
				{"modifier_woda_talent_spell", "#woda_talent_spell", 3, "spell", {}},
				{"modifier_medusa_15","#modifier_medusa_15", 2, "medusa/15", {}},
				{"modifier_woda_talent_int3", "#woda_talent_int3", 2, "int3", {}}
			},
			[2] = {
				{"empty_2"},
				{"empty_3"},
				{"modifier_medusa_16","#modifier_medusa_16", 1, "medusa/16", {}},
				{"modifier_woda_talent_blood", "#woda_talent_blood", 2, "blood", {}},
				{"modifier_woda_talent_int6", "#woda_talent_int6", 1, "int6", {"modifier_woda_talent_int3",2}}
			},
			[3] = {
				{"empty_6"},
				{"empty_7"},
				{"modifier_medusa_20","#modifier_medusa_20", 1, "medusa/20", {}},
				{"modifier_woda_talent_mask2", "#woda_talent_mask2", 2, "mask2", {}},
				{"modifier_woda_talent_kaya", "#woda_talent_kaya", 1, "kaya", {"modifier_woda_talent_int6",1}}
			},
			[4] = {
				{"modifier_woda_talent_mp2", "#woda_talent_mp2", 3, "mp2", {"modifier_woda_talent_mp1",3}},
				{"modifier_woda_talent_fairy", "#woda_talent_fairy", 2, "fairy", {}},
				{"modifier_medusa_18","#modifier_medusa_18", 3, "medusa/18", {}},
				{"empty_9"},
				{"modifier_woda_talent_int4", "#woda_talent_int4", 1, "int4", {"modifier_woda_talent_kaya",1}}
			},
			[5] = {
				{"modifier_woda_talent_spellprism", "#woda_talent_spellprism", 3, "spellprism", {}},
				{"modifier_medusa_17","#modifier_medusa_17", 3, "medusa/17", {}},
				{"empty_10"},
				{"empty_11"},
				{"modifier_woda_talent_int5", "#woda_talent_int5", 3, "int5", {"modifier_woda_talent_int4",1}}
			},
			[6] = {
				{"modifier_woda_talent_timeless", "#woda_talent_timeless", 2, "timeless", {}},
				{"modifier_woda_talent_regenmp2", "#woda_talent_regenmp2", 3, "regenmp2", {}},
				{"empty_15"},
				{"modifier_medusa_19","#modifier_medusa_19", 3, "medusa/19", {}},
				{"empty_16"}
			},
			[7] = {
				{"empty_17"},
				{"empty_18"},
				{"modifier_medusa_21","#modifier_medusa_21", 1, "medusa/21", {}},
				{"empty_20"},
				{"empty_21"}
			}
		}
	},
	["npc_dota_hero_naga_siren"] = {
		[1] = {
			[1] = {
				{"modifier_woda_talent_hp1", "#woda_talent_hp1", 3, "hp1", {}},
				{"modifier_woda_talent_regenhp1", "#woda_talent_regenhp1", 2, "regenhp1", {}},
				{"modifier_woda_talent_attack1", "#woda_talent_attack1", 3, "attack1", {}},
				{"modifier_naga_siren_2","#modifier_naga_siren_2", 3, "naga_siren/2", {}},
				{"modifier_woda_talent_str3", "#woda_talent_str3", 2, "str3", {}}
			},
			[2] = {
				{"empty_2"},
				{"empty_3"},
				{"modifier_naga_siren_3","#modifier_naga_siren_3", 3, "naga_siren/3", {}},
				{"modifier_woda_talent_cloak", "#woda_talent_cloak", 2, "cloak", {}},
				{"modifier_woda_talent_str6", "#woda_talent_str6", 1, "str6", {"modifier_woda_talent_str3",2}}
			},
			[3] = {
				{"empty_6"},
				{"modifier_woda_talent_quickhp", "#woda_talent_quickhp", 2, "quickhp", {}},
				{"empty_7"},
				{"modifier_naga_siren_4","#modifier_naga_siren_4", 1, "naga_siren/4", {}},
				{"modifier_woda_talent_sasha", "#woda_talent_sasha", 1, "sasha", {"modifier_woda_talent_str6",1}}
			},
			[4] = {
				{"modifier_woda_talent_hp2", "#woda_talent_hp2", 3, "hp2", {"modifier_woda_talent_hp1",3}},
				{"empty_9"},
				{"modifier_naga_siren_5","#modifier_naga_siren_5", 1, "naga_siren/5", {}},
				{"modifier_woda_talent_octar", "#woda_talent_octar", 2, "octar", {}},
				{"modifier_woda_talent_str4", "#woda_talent_str4", 1, "str4", {"modifier_woda_talent_sasha",1}}
			},
			[5] = {
				{"modifier_woda_talent_armor2", "#woda_talent_armor2", 3, "armor2", {}},
				{"modifier_naga_siren_1","#modifier_naga_siren_1", 3, "naga_siren/1", {}},
				{"empty_10"},
				{"empty_11"},
				{"modifier_woda_talent_str5", "#woda_talent_str5", 3, "str5", {"modifier_woda_talent_str4",1}}
			},
			[6] = {
				{"modifier_woda_talent_sliver", "#woda_talent_sliver", 2, "sliver", {}},
				{"modifier_woda_talent_regenhp2", "#woda_talent_regenhp2", 3, "regenhp2", {}},
				{"empty_14"},
				{"empty_16"},
				{"modifier_naga_siren_6","#modifier_naga_siren_6", 2, "naga_siren/6", {}}
			},
			[7] = {
				{"empty_17"},
				{"empty_18"},
				{"modifier_naga_siren_7","#modifier_naga_siren_7", 1, "naga_siren/7", {}},
				{"empty_20"},
				{"empty_21"}
			}
		},
		[2] = {
			[1] = {
				{"modifier_woda_talent_armor1", "#woda_talent_armor1", 3, "armor1", {}},
				{"modifier_woda_talent_speed1", "#woda_talent_speed1", 2, "speed1", {}},
				{"modifier_woda_talent_attackspeed1", "#woda_talent_attackspeed1", 3, "attackspeed1", {}},
				{"modifier_naga_siren_8","#modifier_naga_siren_8", 3, "naga_siren/8", {}},
				{"modifier_woda_talent_agi3", "#woda_talent_agi3", 2, "agi3", {}}
			},
			[2] = {
				{"empty_2"},
				{"empty_3"},
				{"modifier_naga_siren_9","#modifier_naga_siren_9", 1, "naga_siren/9", {}},
				{"modifier_woda_talent_miss1", "#woda_talent_miss1", 2, "miss1", {}},
				{"modifier_woda_talent_agi6", "#woda_talent_agi6", 1, "agi6", {"modifier_woda_talent_agi3",2}}
			},
			[3] = {
				{"modifier_naga_siren_17","#modifier_naga_siren_17", 2, "naga_siren/17", {}},
				{"empty_7"},
				{"empty_8"},
				{"modifier_woda_talent_mask1", "#woda_talent_mask1", 2, "mask1", {}},
				{"modifier_woda_talent_yasha", "#woda_talent_yasha", 1, "yasha", {"modifier_woda_talent_agi6",1}}
			},
			[4] = {
				{"modifier_naga_siren_11","#modifier_naga_siren_11", 2, "naga_siren/11", {}},
				{"modifier_woda_talent_speed2", "#woda_talent_speed2", 3, "speed2", {"modifier_woda_talent_speed1",2}},
				{"modifier_woda_talent_grovebow", "#woda_talent_grovebow", 2, "grovebow", {}},
				{"empty_10"},			
				{"modifier_woda_talent_agi4", "#woda_talent_agi4", 1, "agi4", {"modifier_woda_talent_yasha",1}}
			},
			[5] = {
				{"modifier_woda_talent_attack2", "#woda_talent_attack2", 3, "attack2", {}},
				{"empty_11"},
				{"empty_12"},
				{"modifier_naga_siren_12","#modifier_naga_siren_12", 2, "naga_siren/12", {}},
				{"modifier_woda_talent_agi5", "#woda_talent_agi5", 3, "agi5", {"modifier_woda_talent_agi4",1}}
			},
			[6] = {
				{"modifier_woda_talent_miss2", "#woda_talent_miss2", 2, "miss2", {}},
				{"empty_13"},
				{"modifier_woda_talent_attackspeed2", "#woda_talent_attackspeed2", 3, "attackspeed2", {}},
				{"modifier_naga_siren_13","#modifier_naga_siren_13", 3, "naga_siren/13", {}},
				{"empty_16"}
			},
			[7] = {
				{"empty_17"},
				{"empty_18"},
				{"modifier_naga_siren_14","#modifier_naga_siren_14", 1, "naga_siren/14", {}},
				{"empty_20"},
				{"empty_21"}
			}
		},
		[3] = {
			[1] = {
				{"modifier_woda_talent_mp1", "#woda_talent_mp1", 3, "mp1", {}},
				{"modifier_woda_talent_regenmp1", "#woda_talent_regenmp1", 2, "regenmp1", {}},
				{"modifier_woda_talent_spell", "#woda_talent_spell", 3, "spell", {}},
				{"modifier_naga_siren_15","#modifier_naga_siren_15", 2, "naga_siren/15", {}},
				{"modifier_woda_talent_int3", "#woda_talent_int3", 2, "int3", {}}
			},
			[2] = {
				{"empty_2"},
				{"empty_3"},
				{"modifier_naga_siren_16","#modifier_naga_siren_16", 1, "naga_siren/16", {}},
				{"modifier_woda_talent_blood", "#woda_talent_blood", 2, "blood", {}},
				{"modifier_woda_talent_int6", "#woda_talent_int6", 1, "int6", {"modifier_woda_talent_int3",2}}
			},
			[3] = {
				{"empty_6"},
				{"empty_7"},
				{"modifier_naga_siren_10","#modifier_naga_siren_10", 3, "naga_siren/10", {"modifier_naga_siren_16",1}},
				{"modifier_woda_talent_mask2", "#woda_talent_mask2", 2, "mask2", {}},
				{"modifier_woda_talent_kaya", "#woda_talent_kaya", 1, "kaya", {"modifier_woda_talent_int6",1}}
			},
			[4] = {
				{"modifier_woda_talent_mp2", "#woda_talent_mp2", 3, "mp2", {"modifier_woda_talent_mp1",3}},
				{"modifier_woda_talent_fairy", "#woda_talent_fairy", 2, "fairy", {}},
				{"modifier_naga_siren_18","#modifier_naga_siren_18", 3, "naga_siren/18", {}},
				{"empty_9"},
				{"modifier_woda_talent_int4", "#woda_talent_int4", 1, "int4", {"modifier_woda_talent_kaya",1}}
			},
			[5] = {
				{"modifier_woda_talent_spellprism", "#woda_talent_spellprism", 3, "spellprism", {}},
				{"empty_10"},
				{"empty_11"},
				{"modifier_naga_siren_19","#modifier_naga_siren_19", 3, "naga_siren/19", {}},
				{"modifier_woda_talent_int5", "#woda_talent_int5", 3, "int5", {"modifier_woda_talent_int4",1}}
			},
			[6] = {
				{"modifier_woda_talent_timeless", "#woda_talent_timeless", 2, "timeless", {}},
				{"modifier_woda_talent_regenmp2", "#woda_talent_regenmp2", 3, "regenmp2", {}},
				{"empty_14"},
				{"empty_15"},
				{"modifier_naga_siren_20","#modifier_naga_siren_20", 1, "naga_siren/20", {}}
			},
			[7] = {
				{"empty_17"},
				{"empty_18"},
				{"modifier_naga_siren_21","#modifier_naga_siren_21", 1, "naga_siren/21", {}},
				{"empty_20"},
				{"empty_21"}
			}
		}
	},
	["npc_dota_hero_night_stalker"] = {
		[1] = {
			[1] = {
				{"modifier_woda_talent_hp1", "#woda_talent_hp1", 3, "hp1", {}},
				{"modifier_woda_talent_regenhp1", "#woda_talent_regenhp1", 2, "regenhp1", {}},
				{"modifier_woda_talent_attack1", "#woda_talent_attack1", 3, "attack1", {}},
				{"modifier_night_stalker_1","#modifier_night_stalker_1", 3, "night_stalker/1", {}},
				{"modifier_woda_talent_str3", "#woda_talent_str3", 2, "str3", {}}
			},
			[2] = {
				{"empty_2"},
				{"empty_3"},
				{"modifier_night_stalker_2","#modifier_night_stalker_2", 2, "night_stalker/2", {}},
				{"modifier_woda_talent_cloak", "#woda_talent_cloak", 2, "cloak", {}},
				{"modifier_woda_talent_str6", "#woda_talent_str6", 1, "str6", {"modifier_woda_talent_str3",2}}
			},
			[3] = {
				{"empty_6"},
				{"modifier_woda_talent_quickhp", "#woda_talent_quickhp", 2, "quickhp", {}},
				{"empty_7"},
				{"modifier_night_stalker_3","#modifier_night_stalker_3", 3, "night_stalker/3", {}},
				{"modifier_woda_talent_sasha", "#woda_talent_sasha", 1, "sasha", {"modifier_woda_talent_str6",1}}
			},
			[4] = {
				{"modifier_woda_talent_hp2", "#woda_talent_hp2", 3, "hp2", {"modifier_woda_talent_hp1",3}},
				{"empty_9"},
				{"modifier_night_stalker_4","#modifier_night_stalker_4", 1, "night_stalker/4", {"modifier_night_stalker_2",2}},
				{"modifier_woda_talent_octar", "#woda_talent_octar", 2, "octar", {}},
				{"modifier_woda_talent_str4", "#woda_talent_str4", 1, "str4", {"modifier_woda_talent_sasha",1}}
			},
			[5] = {
				{"modifier_woda_talent_armor2", "#woda_talent_armor2", 3, "armor2", {}},
				{"empty_10"},
				{"empty_11"},
				{"modifier_night_stalker_5","#modifier_night_stalker_5", 1, "night_stalker/5", {}},
				{"modifier_woda_talent_str5", "#woda_talent_str5", 3, "str5", {"modifier_woda_talent_str4",1}}
			},
			[6] = {
				{"modifier_woda_talent_sliver", "#woda_talent_sliver", 2, "sliver", {}},
				{"modifier_woda_talent_regenhp2", "#woda_talent_regenhp2", 3, "regenhp2", {}},
				{"empty_14"},
				{"modifier_night_stalker_6","#modifier_night_stalker_6", 3, "night_stalker/6", {}},
				{"empty_16"}
			},
			[7] = {
				{"empty_17"},
				{"empty_18"},
				{"modifier_night_stalker_7","#modifier_night_stalker_7", 1, "night_stalker/7", {}},
				{"empty_20"},
				{"empty_21"}
			}
		},
		[2] = {
			[1] = {
				{"modifier_woda_talent_armor1", "#woda_talent_armor1", 3, "armor1", {}},
				{"modifier_woda_talent_speed1", "#woda_talent_speed1", 2, "speed1", {}},
				{"modifier_woda_talent_attackspeed1", "#woda_talent_attackspeed1", 3, "attackspeed1", {}},
				{"modifier_night_stalker_8","#modifier_night_stalker_8", 3, "night_stalker/8", {}},
				{"modifier_woda_talent_agi3", "#woda_talent_agi3", 2, "agi3", {}}
			},
			[2] = {
				{"modifier_night_stalker_9","#modifier_night_stalker_9", 2, "night_stalker/9", {}},
				{"empty_3"},
				{"empty_4"},
				{"modifier_woda_talent_miss1", "#woda_talent_miss1", 2, "miss1", {}},
				{"modifier_woda_talent_agi6", "#woda_talent_agi6", 1, "agi6", {"modifier_woda_talent_agi3",2}}
			},
			[3] = {
				{"modifier_night_stalker_10","#modifier_night_stalker_10", 3, "night_stalker/10", {"modifier_night_stalker_9",2}},
				{"empty_7"},
				{"empty_8"},
				{"modifier_woda_talent_mask1", "#woda_talent_mask1", 2, "mask1", {}},
				{"modifier_woda_talent_yasha", "#woda_talent_yasha", 1, "yasha", {"modifier_woda_talent_agi6",1}}
			},
			[4] = {
				{"modifier_night_stalker_11","#modifier_night_stalker_11", 1, "night_stalker/11", {}},
				{"modifier_woda_talent_speed2", "#woda_talent_speed2", 3, "speed2", {"modifier_woda_talent_speed1",2}},
				{"modifier_woda_talent_grovebow", "#woda_talent_grovebow", 2, "grovebow", {}},
				{"empty_10"},			
				{"modifier_woda_talent_agi4", "#woda_talent_agi4", 1, "agi4", {"modifier_woda_talent_yasha",1}}
			},
			[5] = {
				{"modifier_woda_talent_attack2", "#woda_talent_attack2", 3, "attack2", {}},
				{"modifier_night_stalker_12","#modifier_night_stalker_12", 1, "night_stalker/12", {}},
				{"empty_11"},
				{"empty_12"},
				{"modifier_woda_talent_agi5", "#woda_talent_agi5", 3, "agi5", {"modifier_woda_talent_agi4",1}}
			},
			[6] = {
				{"modifier_woda_talent_miss2", "#woda_talent_miss2", 2, "miss2", {}},
				{"modifier_night_stalker_13","#modifier_night_stalker_13", 3, "night_stalker/13", {"modifier_night_stalker_12",1}},
				{"modifier_woda_talent_attackspeed2", "#woda_talent_attackspeed2", 3, "attackspeed2", {}},
				{"empty_15"},
				{"empty_16"}
			},
			[7] = {
				{"empty_17"},
				{"empty_18"},
				{"modifier_night_stalker_14","#modifier_night_stalker_14", 1, "night_stalker/14", {}},
				{"empty_20"},
				{"empty_21"}
			}
		},
		[3] = {
			[1] = {
				{"modifier_woda_talent_mp1", "#woda_talent_mp1", 3, "mp1", {}},
				{"modifier_woda_talent_regenmp1", "#woda_talent_regenmp1", 2, "regenmp1", {}},
				{"modifier_woda_talent_spell", "#woda_talent_spell", 3, "spell", {}},
				{"modifier_night_stalker_15","#modifier_night_stalker_15", 3, "night_stalker/15", {}},
				{"modifier_woda_talent_int3", "#woda_talent_int3", 2, "int3", {}}
			},
			[2] = {
				{"empty_2"},
				{"empty_3"},
				{"modifier_night_stalker_16","#modifier_night_stalker_16", 2, "night_stalker/16", {}},
				{"modifier_woda_talent_blood", "#woda_talent_blood", 2, "blood", {}},
				{"modifier_woda_talent_int6", "#woda_talent_int6", 1, "int6", {"modifier_woda_talent_int3",2}}
			},
			[3] = {
				{"empty_6"},
				{"empty_7"},
				{"modifier_night_stalker_17","#modifier_night_stalker_17", 1, "night_stalker/17", {}},
				{"modifier_woda_talent_mask2", "#woda_talent_mask2", 2, "mask2", {}},
				{"modifier_woda_talent_kaya", "#woda_talent_kaya", 1, "kaya", {"modifier_woda_talent_int6",1}}
			},
			[4] = {
				{"modifier_woda_talent_mp2", "#woda_talent_mp2", 3, "mp2", {"modifier_woda_talent_mp1",3}},
				{"modifier_woda_talent_fairy", "#woda_talent_fairy", 2, "fairy", {}},
				{"modifier_night_stalker_18","#modifier_night_stalker_18", 2, "night_stalker/18", {}},
				{"empty_9"},
				{"modifier_woda_talent_int4", "#woda_talent_int4", 1, "int4", {"modifier_woda_talent_kaya",1}}
			},
			[5] = {
				{"modifier_woda_talent_spellprism", "#woda_talent_spellprism", 3, "spellprism", {}},
				{"empty_10"},
				{"empty_11"},
				{"modifier_night_stalker_19","#modifier_night_stalker_19", 3, "night_stalker/19", {}},
				{"modifier_woda_talent_int5", "#woda_talent_int5", 3, "int5", {"modifier_woda_talent_int4",1}}
			},
			[6] = {
				{"modifier_woda_talent_timeless", "#woda_talent_timeless", 2, "timeless", {}},
				{"modifier_woda_talent_regenmp2", "#woda_talent_regenmp2", 3, "regenmp2", {}},
				{"modifier_night_stalker_20","#modifier_night_stalker_20", 2, "night_stalker/20", {}},
				{"empty_15"},
				{"empty_16"}
			},
			[7] = {
				{"empty_17"},
				{"empty_18"},
				{"modifier_night_stalker_21","#modifier_night_stalker_21", 1, "night_stalker/21", {}},
				{"empty_20"},
				{"empty_21"}
			}
		}
	},
	["npc_dota_hero_chen"] = {
		[1] = {
			[1] = {
				{"modifier_woda_talent_hp1", "#woda_talent_hp1", 3, "hp1", {}},
				{"modifier_woda_talent_regenhp1", "#woda_talent_regenhp1", 2, "regenhp1", {}},
				{"modifier_chen_1","#modifier_chen_1", 1, "chen/1", {}},
				{"modifier_woda_talent_attack1", "#woda_talent_attack1", 3, "attack1", {}},
				{"modifier_woda_talent_str3", "#woda_talent_str3", 2, "str3", {}}
			},
			[2] = {
				{"empty_2"},
				{"empty_3"},
				{"modifier_chen_6","#modifier_chen_6", 3, "chen/6", {"modifier_chen_1",1}},
				{"modifier_woda_talent_cloak", "#woda_talent_cloak", 2, "cloak", {}},
				{"modifier_woda_talent_str6", "#woda_talent_str6", 1, "str6", {"modifier_woda_talent_str3",2}}
			},
			[3] = {
				{"empty_6"},
				{"modifier_woda_talent_quickhp", "#woda_talent_quickhp", 2, "quickhp", {}},
				{"modifier_chen_4","#modifier_chen_4", 3, "chen/4", {"modifier_chen_6",3}},
				{"empty_8"},
				{"modifier_woda_talent_sasha", "#woda_talent_sasha", 1, "sasha", {"modifier_woda_talent_str6",1}}
			},
			[4] = {
				{"modifier_woda_talent_hp2", "#woda_talent_hp2", 3, "hp2", {"modifier_woda_talent_hp1",3}},
				{"empty_9"},
				{"modifier_chen_3","#modifier_chen_3", 2, "chen/3", {"modifier_chen_4",3}},
				{"modifier_woda_talent_octar", "#woda_talent_octar", 2, "octar", {}},
				{"modifier_woda_talent_str4", "#woda_talent_str4", 1, "str4", {"modifier_woda_talent_sasha",1}}
			},
			[5] = {
				{"modifier_woda_talent_armor2", "#woda_talent_armor2", 3, "armor2", {}},
				{"empty_10"},
				{"empty_11"},
				{"modifier_chen_2","#modifier_chen_2", 2, "chen/2", {}},
				{"modifier_woda_talent_str5", "#woda_talent_str5", 3, "str5", {"modifier_woda_talent_str4",1}}
			},
			[6] = {
				{"modifier_woda_talent_sliver", "#woda_talent_sliver", 2, "sliver", {}},
				{"modifier_woda_talent_regenhp2", "#woda_talent_regenhp2", 3, "regenhp2", {}},
				{"empty_14"},
				{"empty_15"},
				{"modifier_chen_5","#modifier_chen_5", 2, "chen/5", {}}
			},
			[7] = {
				{"empty_17"},
				{"empty_18"},
				{"modifier_chen_7","#modifier_chen_7", 1, "chen/7", {}},
				{"empty_20"},
				{"empty_21"}
			}
		},
		[2] = {
			[1] = {
				{"modifier_chen_8","#modifier_chen_8", 3, "chen/8", {}},
				{"modifier_woda_talent_speed1", "#woda_talent_speed1", 2, "speed1", {}},
				{"modifier_woda_talent_attackspeed1", "#woda_talent_attackspeed1", 3, "attackspeed1", {}},
				{"modifier_woda_talent_armor1", "#woda_talent_armor1", 3, "armor1", {}},
				{"modifier_woda_talent_agi3", "#woda_talent_agi3", 2, "agi3", {}}
			},
			[2] = {
				{"modifier_chen_9","#modifier_chen_9", 2, "chen/9", {"modifier_chen_8",3}},
				{"empty_3"},
				{"empty_4"},
				{"modifier_woda_talent_miss1", "#woda_talent_miss1", 2, "miss1", {}},
				{"modifier_woda_talent_agi6", "#woda_talent_agi6", 1, "agi6", {"modifier_woda_talent_agi3",2}}
			},
			[3] = {
				{"modifier_chen_10","#modifier_chen_10", 3, "chen/10", {"modifier_chen_9",2}},
				{"empty_7"},
				{"empty_8"},
				{"modifier_woda_talent_mask1", "#woda_talent_mask1", 2, "mask1", {}},
				{"modifier_woda_talent_yasha", "#woda_talent_yasha", 1, "yasha", {"modifier_woda_talent_agi6",1}}
			},
			[4] = {
				{"modifier_chen_11","#modifier_chen_11", 1, "chen/11", {"modifier_chen_10",3}},
				{"modifier_woda_talent_speed2", "#woda_talent_speed2", 3, "speed2", {"modifier_woda_talent_speed1",2}},
				{"modifier_woda_talent_grovebow", "#woda_talent_grovebow", 2, "grovebow", {}},
				{"empty_10"},			
				{"modifier_woda_talent_agi4", "#woda_talent_agi4", 1, "agi4", {"modifier_woda_talent_yasha",1}}
			},
			[5] = {
				{"modifier_woda_talent_attack2", "#woda_talent_attack2", 3, "attack2", {}},
				{"modifier_chen_12","#modifier_chen_12", 1, "chen/12", {}},
				{"empty_11"},
				{"empty_12"},
				{"modifier_woda_talent_agi5", "#woda_talent_agi5", 3, "agi5", {"modifier_woda_talent_agi4",1}}
			},
			[6] = {
				{"modifier_woda_talent_miss2", "#woda_talent_miss2", 2, "miss2", {}},
				{"empty_13"},
				{"modifier_woda_talent_attackspeed2", "#woda_talent_attackspeed2", 3, "attackspeed2", {}},
				{"modifier_chen_13","#modifier_chen_13", 3, "chen/13", {}},
				{"empty_16"}
			},
			[7] = {
				{"empty_17"},
				{"empty_18"},
				{"modifier_chen_14","#modifier_chen_14", 1, "chen/14", {}},
				{"empty_20"},
				{"empty_21"}
			}
		},
		[3] = {
			[1] = {
				{"modifier_woda_talent_mp1", "#woda_talent_mp1", 3, "mp1", {}},
				{"modifier_woda_talent_regenmp1", "#woda_talent_regenmp1", 2, "regenmp1", {}},
				{"modifier_chen_15","#modifier_chen_15", 2, "chen/15", {}},
				{"modifier_woda_talent_spell", "#woda_talent_spell", 3, "spell", {}},
				{"modifier_woda_talent_int3", "#woda_talent_int3", 2, "int3", {}}
			},
			[2] = {
				{"empty_2"},
				{"empty_3"},
				{"modifier_chen_16","#modifier_chen_16", 2, "chen/16", {"modifier_chen_15",2}},
				{"modifier_woda_talent_blood", "#woda_talent_blood", 2, "blood", {}},
				{"modifier_woda_talent_int6", "#woda_talent_int6", 1, "int6", {"modifier_woda_talent_int3",2}}
			},
			[3] = {
				{"empty_6"},
				{"empty_7"},
				{"modifier_chen_18","#modifier_chen_18", 1, "chen/18", {"modifier_chen_16",2}},
				{"modifier_woda_talent_mask2", "#woda_talent_mask2", 2, "mask2", {}},
				{"modifier_woda_talent_kaya", "#woda_talent_kaya", 1, "kaya", {"modifier_woda_talent_int6",1}}
			},
			[4] = {
				{"modifier_woda_talent_mp2", "#woda_talent_mp2", 3, "mp2", {"modifier_woda_talent_mp1",3}},
				{"modifier_woda_talent_fairy", "#woda_talent_fairy", 2, "fairy", {}},
				{"modifier_chen_17","#modifier_chen_17", 3, "chen/17", {"modifier_chen_18",1}},
				{"empty_9"},
				{"modifier_woda_talent_int4", "#woda_talent_int4", 1, "int4", {"modifier_woda_talent_kaya",1}}
			},
			[5] = {
				{"modifier_woda_talent_spellprism", "#woda_talent_spellprism", 3, "spellprism", {}},
				{"modifier_chen_19","#modifier_chen_19", 2, "chen/19", {}},
				{"empty_11"},
				{"empty_12"},
				{"modifier_woda_talent_int5", "#woda_talent_int5", 3, "int5", {"modifier_woda_talent_int4",1}}
			},
			[6] = {
				{"modifier_woda_talent_timeless", "#woda_talent_timeless", 2, "timeless", {}},
				{"modifier_woda_talent_regenmp2", "#woda_talent_regenmp2", 3, "regenmp2", {}},
				{"modifier_chen_20","#modifier_chen_20", 3, "chen/20", {}},
				{"empty_15"},
				{"empty_16"}
			},
			[7] = {
				{"empty_17"},
				{"empty_18"},
				{"modifier_chen_21","#modifier_chen_21", 1, "chen/21", {}},
				{"empty_20"},
				{"empty_21"}
			}
		}
	},
	["npc_dota_hero_arc_warden"] = {
		[1] = {
			[1] = {
				{"modifier_woda_talent_hp1", "#woda_talent_hp1", 3, "hp1", {}},
				{"modifier_woda_talent_regenhp1", "#woda_talent_regenhp1", 2, "regenhp1", {}},
				{"modifier_woda_talent_attack1", "#woda_talent_attack1", 3, "attack1", {}},
				{"modifier_arc_warden_2","#modifier_arc_warden_2", 2, "arc_warden/2", {}},
				{"modifier_woda_talent_str3", "#woda_talent_str3", 2, "str3", {}}
			},
			[2] = {
				{"empty_2"},
				{"empty_3"},
				{"modifier_arc_warden_3","#modifier_arc_warden_3", 1, "arc_warden/3", {}},
				{"modifier_woda_talent_cloak", "#woda_talent_cloak", 2, "cloak", {}},
				{"modifier_woda_talent_str6", "#woda_talent_str6", 1, "str6", {"modifier_woda_talent_str3",2}}
			},
			[3] = {
				{"empty_6"},
				{"modifier_woda_talent_quickhp", "#woda_talent_quickhp", 2, "quickhp", {}},
				{"empty_8"},
				{"modifier_arc_warden_9","#modifier_arc_warden_9", 2, "arc_warden/9", {}},
				{"modifier_woda_talent_sasha", "#woda_talent_sasha", 1, "sasha", {"modifier_woda_talent_str6",1}}
			},
			[4] = {
				{"modifier_woda_talent_hp2", "#woda_talent_hp2", 3, "hp2", {"modifier_woda_talent_hp1",3}},
				{"empty_9"},
				{"modifier_arc_warden_4","#modifier_arc_warden_4", 2, "arc_warden/4", {"modifier_arc_warden_3",1}},
				{"modifier_woda_talent_octar", "#woda_talent_octar", 2, "octar", {}},
				{"modifier_woda_talent_str4", "#woda_talent_str4", 1, "str4", {"modifier_woda_talent_sasha",1}}
			},
			[5] = {
				{"modifier_woda_talent_armor2", "#woda_talent_armor2", 3, "armor2", {}},
				{"modifier_arc_warden_5","#modifier_arc_warden_5", 3, "arc_warden/5", {}},
				{"empty_10"},
				{"empty_11"},
				{"modifier_woda_talent_str5", "#woda_talent_str5", 3, "str5", {"modifier_woda_talent_str4",1}}
			},
			[6] = {
				{"modifier_woda_talent_sliver", "#woda_talent_sliver", 2, "sliver", {}},
				{"modifier_woda_talent_regenhp2", "#woda_talent_regenhp2", 3, "regenhp2", {}},
				{"modifier_arc_warden_6","#modifier_arc_warden_6", 3, "arc_warden/6", {}},
				{"empty_14"},
				{"empty_16"}
			},
			[7] = {
				{"empty_17"},
				{"empty_18"},
				{"modifier_arc_warden_7","#modifier_arc_warden_7", 1, "arc_warden/7", {}},
				{"empty_20"},
				{"empty_21"}
			}
		},
		[2] = {
			[1] = {
				{"modifier_woda_talent_armor1", "#woda_talent_armor1", 3, "armor1", {}},
				{"modifier_woda_talent_speed1", "#woda_talent_speed1", 2, "speed1", {}},
				{"modifier_woda_talent_attackspeed1", "#woda_talent_attackspeed1", 3, "attackspeed1", {}},
				{"modifier_arc_warden_1","#modifier_arc_warden_1", 3, "arc_warden/1", {}},
				{"modifier_woda_talent_agi3", "#woda_talent_agi3", 2, "agi3", {}}
			},
			[2] = {
				{"empty_2"},
				{"empty_3"},
				{"modifier_arc_warden_8","#modifier_arc_warden_8", 2, "arc_warden/8", {}},
				{"modifier_woda_talent_miss1", "#woda_talent_miss1", 2, "miss1", {}},
				{"modifier_woda_talent_agi6", "#woda_talent_agi6", 1, "agi6", {"modifier_woda_talent_agi3",2}}
			},
			[3] = {
				{"modifier_arc_warden_10","#modifier_arc_warden_10", 1, "arc_warden/10", {}},
				{"empty_6"},
				{"empty_7"},
				{"modifier_woda_talent_mask1", "#woda_talent_mask1", 2, "mask1", {}},
				{"modifier_woda_talent_yasha", "#woda_talent_yasha", 1, "yasha", {"modifier_woda_talent_agi6",1}}
			},
			[4] = {
				{"modifier_arc_warden_11","#modifier_arc_warden_11", 3, "arc_warden/11", {"modifier_arc_warden_10",1}},
				{"modifier_woda_talent_speed2", "#woda_talent_speed2", 3, "speed2", {"modifier_woda_talent_speed1",2}},
				{"modifier_woda_talent_grovebow", "#woda_talent_grovebow", 2, "grovebow", {}},
				{"empty_11"},			
				{"modifier_woda_talent_agi4", "#woda_talent_agi4", 1, "agi4", {"modifier_woda_talent_yasha",1}}
			},
			[5] = {
				{"modifier_woda_talent_attack2", "#woda_talent_attack2", 3, "attack2", {}},
				{"empty_12"},
				{"modifier_arc_warden_14","#modifier_arc_warden_14", 1, "arc_warden/14", {}},
				{"empty_13"},
				{"modifier_woda_talent_agi5", "#woda_talent_agi5", 3, "agi5", {"modifier_woda_talent_agi4",1}}
			},
			[6] = {
				{"modifier_woda_talent_miss2", "#woda_talent_miss2", 2, "miss2", {}},
				{"empty_15"},
				{"modifier_woda_talent_attackspeed2", "#woda_talent_attackspeed2", 3, "attackspeed2", {}},
				{"modifier_arc_warden_13","#modifier_arc_warden_13", 3, "arc_warden/13", {}},
				{"empty_16"}
			},
			[7] = {
				{"empty_17"},
				{"empty_18"},
				{"modifier_arc_warden_12","#modifier_arc_warden_12", 1, "arc_warden/12", {}},
				{"empty_20"},
				{"empty_21"}
			}
		},
		[3] = {
			[1] = {
				{"modifier_woda_talent_mp1", "#woda_talent_mp1", 3, "mp1", {}},
				{"modifier_woda_talent_regenmp1", "#woda_talent_regenmp1", 2, "regenmp1", {}},
				{"modifier_woda_talent_spell", "#woda_talent_spell", 3, "spell", {}},
				{"modifier_arc_warden_15","#modifier_arc_warden_15", 2, "arc_warden/15", {}},
				{"modifier_woda_talent_int3", "#woda_talent_int3", 2, "int3", {}}
			},
			[2] = {
				{"empty_2"},
				{"empty_3"},
				{"modifier_arc_warden_17","#modifier_arc_warden_17", 2, "arc_warden/17", {}},
				{"modifier_woda_talent_blood", "#woda_talent_blood", 2, "blood", {}},
				{"modifier_woda_talent_int6", "#woda_talent_int6", 1, "int6", {"modifier_woda_talent_int3",2}}
			},
			[3] = {
				{"empty_6"},
				{"empty_7"},
				{"modifier_arc_warden_16","#modifier_arc_warden_16", 1, "arc_warden/16", {}},
				{"modifier_woda_talent_mask2", "#woda_talent_mask2", 2, "mask2", {}},
				{"modifier_woda_talent_kaya", "#woda_talent_kaya", 1, "kaya", {"modifier_woda_talent_int6",1}}
			},
			[4] = {
				{"modifier_woda_talent_mp2", "#woda_talent_mp2", 3, "mp2", {"modifier_woda_talent_mp1",3}},
				{"modifier_woda_talent_fairy", "#woda_talent_fairy", 2, "fairy", {}},
				{"empty_9"},
				{"modifier_arc_warden_19","#modifier_arc_warden_19", 3, "arc_warden/19", {}},
				{"modifier_woda_talent_int4", "#woda_talent_int4", 1, "int4", {"modifier_woda_talent_kaya",1}}
			},
			[5] = {
				{"modifier_woda_talent_spellprism", "#woda_talent_spellprism", 3, "spellprism", {}},
				{"modifier_arc_warden_18","#modifier_arc_warden_18", 3, "arc_warden/18", {}},
				{"empty_10"},
				{"empty_11"},
				{"modifier_woda_talent_int5", "#woda_talent_int5", 3, "int5", {"modifier_woda_talent_int4",1}}
			},
			[6] = {
				{"modifier_woda_talent_timeless", "#woda_talent_timeless", 2, "timeless", {}},
				{"modifier_woda_talent_regenmp2", "#woda_talent_regenmp2", 3, "regenmp2", {}},
				{"empty_14"},
				{"empty_15"},
				{"modifier_arc_warden_20","#modifier_arc_warden_20", 2, "arc_warden/20", {}}
			},
			[7] = {
				{"empty_17"},
				{"empty_18"},
				{"modifier_arc_warden_21","#modifier_arc_warden_21", 1, "arc_warden/21", {}},
				{"empty_20"},
				{"empty_21"}
			}
		}
	},
	["npc_dota_hero_necrolyte"] = {
		[1] = {
			[1] = {
				{"modifier_woda_talent_hp1", "#woda_talent_hp1", 3, "hp1", {}},
				{"modifier_woda_talent_regenhp1", "#woda_talent_regenhp1", 2, "regenhp1", {}},
				{"modifier_woda_talent_attack1", "#woda_talent_attack1", 3, "attack1", {}},
				{"modifier_necrolyte_1","#modifier_necrolyte_1", 1, "necrolyte/1", {}},
				{"modifier_woda_talent_str3", "#woda_talent_str3", 2, "str3", {}}
			},
			[2] = {
				{"empty_2"},
				{"empty_3"},
				{"modifier_necrolyte_2","#modifier_necrolyte_2", 3, "necrolyte/2", {}},
				{"modifier_woda_talent_cloak", "#woda_talent_cloak", 2, "cloak", {}},
				{"modifier_woda_talent_str6", "#woda_talent_str6", 1, "str6", {"modifier_woda_talent_str3",2}}
			},
			[3] = {
				{"empty_6"},
				{"modifier_woda_talent_quickhp", "#woda_talent_quickhp", 2, "quickhp", {}},
				{"modifier_necrolyte_3","#modifier_necrolyte_3", 1, "necrolyte/3", {"modifier_necrolyte_2",3}},
				{"empty_8"},
				{"modifier_woda_talent_sasha", "#woda_talent_sasha", 1, "sasha", {"modifier_woda_talent_str6",1}}
			},
			[4] = {
				{"modifier_woda_talent_hp2", "#woda_talent_hp2", 3, "hp2", {"modifier_woda_talent_hp1",3}},
				{"empty_9"},
				{"modifier_necrolyte_4","#modifier_necrolyte_4", 3, "necrolyte/4", {}},
				{"modifier_woda_talent_octar", "#woda_talent_octar", 2, "octar", {}},
				{"modifier_woda_talent_str4", "#woda_talent_str4", 1, "str4", {"modifier_woda_talent_sasha",1}}
			},
			[5] = {
				{"modifier_woda_talent_armor2", "#woda_talent_armor2", 3, "armor2", {}},
				{"modifier_necrolyte_5","#modifier_necrolyte_5", 2, "necrolyte/5", {}},
				{"empty_10"},
				{"empty_11"},
				{"modifier_woda_talent_str5", "#woda_talent_str5", 3, "str5", {"modifier_woda_talent_str4",1}}
			},
			[6] = {
				{"modifier_woda_talent_sliver", "#woda_talent_sliver", 2, "sliver", {}},
				{"modifier_woda_talent_regenhp2", "#woda_talent_regenhp2", 3, "regenhp2", {}},
				{"empty_14"},
				{"modifier_necrolyte_6","#modifier_necrolyte_6", 3, "necrolyte/6", {}},
				{"empty_16"}
			},
			[7] = {
				{"empty_17"},
				{"empty_18"},
				{"modifier_necrolyte_7","#modifier_necrolyte_7", 1, "necrolyte/7", {}},
				{"empty_20"},
				{"empty_21"}
			}
		},
		[2] = {
			[1] = {
				{"modifier_woda_talent_armor1", "#woda_talent_armor1", 3, "armor1", {}},
				{"modifier_woda_talent_speed1", "#woda_talent_speed1", 2, "speed1", {}},
				{"modifier_woda_talent_attackspeed1", "#woda_talent_attackspeed1", 3, "attackspeed1", {}},
				{"modifier_necrolyte_8","#modifier_necrolyte_8", 2, "necrolyte/8", {}},
				{"modifier_woda_talent_agi3", "#woda_talent_agi3", 2, "agi3", {}}
			},
			[2] = {
				{"empty_2"},
				{"empty_3"},
				{"modifier_necrolyte_9","#modifier_necrolyte_9", 3, "necrolyte/9", {}},
				{"modifier_woda_talent_miss1", "#woda_talent_miss1", 2, "miss1", {}},
				{"modifier_woda_talent_agi6", "#woda_talent_agi6", 1, "agi6", {"modifier_woda_talent_agi3",2}}
			},
			[3] = {
				{"modifier_necrolyte_10","#modifier_necrolyte_10", 1, "necrolyte/10", {}},
				{"empty_7"},
				{"empty_8"},
				{"modifier_woda_talent_mask1", "#woda_talent_mask1", 2, "mask1", {}},
				{"modifier_woda_talent_yasha", "#woda_talent_yasha", 1, "yasha", {"modifier_woda_talent_agi6",1}}
			},
			[4] = {
				{"modifier_necrolyte_11","#modifier_necrolyte_11", 1, "necrolyte/11", {"modifier_necrolyte_10",1}},
				{"modifier_woda_talent_speed2", "#woda_talent_speed2", 3, "speed2", {"modifier_woda_talent_speed1",2}},
				{"modifier_woda_talent_grovebow", "#woda_talent_grovebow", 2, "grovebow", {}},
				{"empty_10"},			
				{"modifier_woda_talent_agi4", "#woda_talent_agi4", 1, "agi4", {"modifier_woda_talent_yasha",1}}
			},
			[5] = {
				{"modifier_woda_talent_attack2", "#woda_talent_attack2", 3, "attack2", {}},
				{"empty_11"},
				{"empty_12"},
				{"modifier_necrolyte_12","#modifier_necrolyte_12", 3, "necrolyte/12", {}},
				{"modifier_woda_talent_agi5", "#woda_talent_agi5", 3, "agi5", {"modifier_woda_talent_agi4",1}}
			},
			[6] = {
				{"modifier_woda_talent_miss2", "#woda_talent_miss2", 2, "miss2", {}},
				{"empty_13"},
				{"modifier_woda_talent_attackspeed2", "#woda_talent_attackspeed2", 3, "attackspeed2", {}},
				{"empty_15"},
				{"modifier_necrolyte_13","#modifier_necrolyte_13", 3, "necrolyte/13", {}}
			},
			[7] = {
				{"empty_17"},
				{"empty_18"},
				{"modifier_necrolyte_14","#modifier_necrolyte_14", 1, "necrolyte/14", {}},
				{"empty_20"},
				{"empty_21"}
			}
		},
		[3] = {
			[1] = {
				{"modifier_woda_talent_mp1", "#woda_talent_mp1", 3, "mp1", {}},
				{"modifier_woda_talent_regenmp1", "#woda_talent_regenmp1", 2, "regenmp1", {}},
				{"modifier_woda_talent_spell", "#woda_talent_spell", 3, "spell", {}},
				{"modifier_necrolyte_15","#modifier_necrolyte_15", 2, "necrolyte/15", {}},
				{"modifier_woda_talent_int3", "#woda_talent_int3", 2, "int3", {}}
			},
			[2] = {
				{"empty_2"},
				{"empty_3"},
				{"modifier_necrolyte_20","#modifier_necrolyte_20", 1, "necrolyte/20", {}},
				{"modifier_woda_talent_blood", "#woda_talent_blood", 2, "blood", {}},
				{"modifier_woda_talent_int6", "#woda_talent_int6", 1, "int6", {"modifier_woda_talent_int3",2}}
			},
			[3] = {
				{"empty_6"},
				{"modifier_necrolyte_16","#modifier_necrolyte_16", 3, "necrolyte/16", {}},
				{"empty_7"},
				{"modifier_woda_talent_mask2", "#woda_talent_mask2", 2, "mask2", {}},
				{"modifier_woda_talent_kaya", "#woda_talent_kaya", 1, "kaya", {"modifier_woda_talent_int6",1}}
			},
			[4] = {
				{"modifier_woda_talent_mp2", "#woda_talent_mp2", 3, "mp2", {"modifier_woda_talent_mp1",3}},
				{"modifier_necrolyte_17","#modifier_necrolyte_17", 1, "necrolyte/17", {"modifier_necrolyte_16",3}},
				{"empty_9"},
				{"modifier_woda_talent_fairy", "#woda_talent_fairy", 2, "fairy", {}},
				{"modifier_woda_talent_int4", "#woda_talent_int4", 1, "int4", {"modifier_woda_talent_kaya",1}}
			},
			[5] = {
				{"modifier_woda_talent_spellprism", "#woda_talent_spellprism", 3, "spellprism", {}},
				{"modifier_necrolyte_19","#modifier_necrolyte_19", 3, "necrolyte/19", {}},
				{"empty_10"},
				{"empty_11"},
				{"modifier_woda_talent_int5", "#woda_talent_int5", 3, "int5", {"modifier_woda_talent_int4",1}}
			},
			[6] = {
				{"modifier_woda_talent_timeless", "#woda_talent_timeless", 2, "timeless", {}},
				{"modifier_woda_talent_regenmp2", "#woda_talent_regenmp2", 3, "regenmp2", {}},
				{"modifier_necrolyte_18","#modifier_necrolyte_18", 3, "necrolyte/18", {}},
				{"empty_15"},
				{"empty_16"}
			},
			[7] = {
				{"empty_17"},
				{"empty_18"},
				{"modifier_necrolyte_21","#modifier_necrolyte_21", 1, "necrolyte/21", {}},
				{"empty_20"},
				{"empty_21"}
			}
		}
	},
	["npc_dota_hero_nyx_assassin"] = {
		[1] = {
			[1] = {
				{"modifier_woda_talent_hp1", "#woda_talent_hp1", 3, "hp1", {}},
				{"modifier_woda_talent_regenhp1", "#woda_talent_regenhp1", 2, "regenhp1", {}},
				{"modifier_woda_talent_attack1", "#woda_talent_attack1", 3, "attack1", {}},
				{"modifier_nyx_assassin_1","#modifier_nyx_assassin_1", 2, "nyx_assassin/1", {}},
				{"modifier_woda_talent_str3", "#woda_talent_str3", 2, "str3", {}}
			},
			[2] = {
				{"empty_2"},
				{"modifier_nyx_assassin_2","#modifier_nyx_assassin_2", 1, "nyx_assassin/2", {}},
				{"empty_3"},
				{"modifier_woda_talent_cloak", "#woda_talent_cloak", 2, "cloak", {}},
				{"modifier_woda_talent_str6", "#woda_talent_str6", 1, "str6", {"modifier_woda_talent_str3",2}}
			},
			[3] = {
				{"empty_6"},
				{"modifier_woda_talent_quickhp", "#woda_talent_quickhp", 2, "quickhp", {}},
				{"empty_7"},
				{"modifier_nyx_assassin_3","#modifier_nyx_assassin_3", 3, "nyx_assassin/3", {}},
				{"modifier_woda_talent_sasha", "#woda_talent_sasha", 1, "sasha", {"modifier_woda_talent_str6",1}}
			},
			[4] = {
				{"modifier_woda_talent_hp2", "#woda_talent_hp2", 3, "hp2", {"modifier_woda_talent_hp1",3}},
				{"modifier_nyx_assassin_4","#modifier_nyx_assassin_4", 3, "nyx_assassin/4", {}},
				{"empty_9"},
				{"modifier_woda_talent_octar", "#woda_talent_octar", 2, "octar", {}},
				{"modifier_woda_talent_str4", "#woda_talent_str4", 1, "str4", {"modifier_woda_talent_sasha",1}}
			},
			[5] = {
				{"modifier_woda_talent_armor2", "#woda_talent_armor2", 3, "armor2", {}},
				{"empty_10"},
				{"empty_11"},
				{"modifier_nyx_assassin_5","#modifier_nyx_assassin_5", 3, "nyx_assassin/5", {}},
				{"modifier_woda_talent_str5", "#woda_talent_str5", 3, "str5", {"modifier_woda_talent_str4",1}}
			},
			[6] = {
				{"modifier_woda_talent_sliver", "#woda_talent_sliver", 2, "sliver", {}},
				{"modifier_woda_talent_regenhp2", "#woda_talent_regenhp2", 3, "regenhp2", {}},
				{"empty_14"},
				{"empty_15"},
				{"modifier_nyx_assassin_7","#modifier_nyx_assassin_7", 1, "nyx_assassin/7", {}}
			},
			[7] = {
				{"empty_17"},
				{"empty_18"},
				{"modifier_nyx_assassin_6","#modifier_nyx_assassin_6", 1, "nyx_assassin/6", {}},
				{"empty_20"},
				{"empty_21"}
			}
		},
		[2] = {
			[1] = {
				{"modifier_woda_talent_armor1", "#woda_talent_armor1", 3, "armor1", {}},
				{"modifier_woda_talent_speed1", "#woda_talent_speed1", 2, "speed1", {}},
				{"modifier_woda_talent_attackspeed1", "#woda_talent_attackspeed1", 3, "attackspeed1", {}},
				{"modifier_nyx_assassin_8","#modifier_nyx_assassin_8", 3, "nyx_assassin/8", {}},
				{"modifier_woda_talent_agi3", "#woda_talent_agi3", 2, "agi3", {}}
			},
			[2] = {
				{"modifier_nyx_assassin_9","#modifier_nyx_assassin_9", 1, "nyx_assassin/9", {}},
				{"empty_3"},
				{"empty_4"},
				{"modifier_woda_talent_miss1", "#woda_talent_miss1", 2, "miss1", {}},
				{"modifier_woda_talent_agi6", "#woda_talent_agi6", 1, "agi6", {"modifier_woda_talent_agi3",2}}
			},
			[3] = {
				{"modifier_nyx_assassin_10","#modifier_nyx_assassin_10", 1, "nyx_assassin/10", {"modifier_nyx_assassin_9",1}},
				{"empty_7"},
				{"empty_8"},
				{"modifier_woda_talent_mask1", "#woda_talent_mask1", 2, "mask1", {}},
				{"modifier_woda_talent_yasha", "#woda_talent_yasha", 1, "yasha", {"modifier_woda_talent_agi6",1}}
			},
			[4] = {
				{"modifier_nyx_assassin_11","#modifier_nyx_assassin_11", 3, "nyx_assassin/11", {"modifier_nyx_assassin_10",1}},
				{"modifier_woda_talent_speed2", "#woda_talent_speed2", 3, "speed2", {"modifier_woda_talent_speed1",2}},
				{"modifier_woda_talent_grovebow", "#woda_talent_grovebow", 2, "grovebow", {}},
				{"empty_10"},			
				{"modifier_woda_talent_agi4", "#woda_talent_agi4", 1, "agi4", {"modifier_woda_talent_yasha",1}}
			},
			[5] = {
				{"modifier_woda_talent_attack2", "#woda_talent_attack2", 3, "attack2", {}},
				{"empty_11"},
				{"empty_12"},
				{"modifier_nyx_assassin_13","#modifier_nyx_assassin_13", 2, "nyx_assassin/13", {}},
				{"modifier_woda_talent_agi5", "#woda_talent_agi5", 3, "agi5", {"modifier_woda_talent_agi4",1}}
			},
			[6] = {
				{"modifier_woda_talent_miss2", "#woda_talent_miss2", 2, "miss2", {}},
				{"modifier_nyx_assassin_12","#modifier_nyx_assassin_12", 3, "nyx_assassin/12", {}},
				{"modifier_woda_talent_attackspeed2", "#woda_talent_attackspeed2", 3, "attackspeed2", {}},
				{"empty_13"},
				{"empty_16"}
			},
			[7] = {
				{"empty_17"},
				{"empty_18"},
				{"modifier_nyx_assassin_14","#modifier_nyx_assassin_14", 1, "nyx_assassin/14", {}},
				{"empty_20"},
				{"empty_21"}
			}
		},
		[3] = {
			[1] = {
				{"modifier_woda_talent_mp1", "#woda_talent_mp1", 3, "mp1", {}},
				{"modifier_woda_talent_regenmp1", "#woda_talent_regenmp1", 2, "regenmp1", {}},
				{"modifier_woda_talent_spell", "#woda_talent_spell", 3, "spell", {}},
				{"modifier_nyx_assassin_15","#modifier_nyx_assassin_15", 1, "nyx_assassin/15", {}},
				{"modifier_woda_talent_int3", "#woda_talent_int3", 2, "int3", {}}
			},
			[2] = {
				{"empty_2"},
				{"empty_3"},
				{"modifier_nyx_assassin_16","#modifier_nyx_assassin_16", 3, "nyx_assassin/16", {}},
				{"modifier_woda_talent_blood", "#woda_talent_blood", 2, "blood", {}},
				{"modifier_woda_talent_int6", "#woda_talent_int6", 1, "int6", {"modifier_woda_talent_int3",2}}
			},
			[3] = {
				{"empty_6"},
				{"empty_7"},
				{"modifier_nyx_assassin_17","#modifier_nyx_assassin_17", 3, "nyx_assassin/17", {}},
				{"modifier_woda_talent_mask2", "#woda_talent_mask2", 2, "mask2", {}},
				{"modifier_woda_talent_kaya", "#woda_talent_kaya", 1, "kaya", {"modifier_woda_talent_int6",1}}
			},
			[4] = {
				{"modifier_woda_talent_mp2", "#woda_talent_mp2", 3, "mp2", {"modifier_woda_talent_mp1",3}},
				{"modifier_woda_talent_fairy", "#woda_talent_fairy", 2, "fairy", {}},
				{"empty_9"},
				{"modifier_nyx_assassin_18","#modifier_nyx_assassin_18", 1, "nyx_assassin/18", {}},
				{"modifier_woda_talent_int4", "#woda_talent_int4", 1, "int4", {"modifier_woda_talent_kaya",1}}
			},
			[5] = {
				{"modifier_woda_talent_spellprism", "#woda_talent_spellprism", 3, "spellprism", {}},
				{"modifier_nyx_assassin_19","#modifier_nyx_assassin_19", 2, "nyx_assassin/19", {}},
				{"empty_10"},
				{"empty_11"},
				{"modifier_woda_talent_int5", "#woda_talent_int5", 3, "int5", {"modifier_woda_talent_int4",1}}
			},
			[6] = {
				{"modifier_woda_talent_timeless", "#woda_talent_timeless", 2, "timeless", {}},
				{"modifier_woda_talent_regenmp2", "#woda_talent_regenmp2", 3, "regenmp2", {}},
				{"modifier_nyx_assassin_20","#modifier_nyx_assassin_20", 3, "nyx_assassin/20", {}},
				{"empty_15"},
				{"empty_16"}
			},
			[7] = {
				{"empty_17"},
				{"empty_18"},
				{"modifier_nyx_assassin_21","#modifier_nyx_assassin_21", 1, "nyx_assassin/21", {}},
				{"empty_20"},
				{"empty_21"}
			}
		}
	},
	["npc_dota_hero_rubick"] = {
		[1] = {
			[1] = {
				{"modifier_woda_talent_hp1", "#woda_talent_hp1", 3, "hp1", {}},
				{"modifier_woda_talent_regenhp1", "#woda_talent_regenhp1", 2, "regenhp1", {}},
				{"modifier_woda_talent_attack1", "#woda_talent_attack1", 3, "attack1", {}},
				{"modifier_rubick_1","#modifier_rubick_1", 3, "rubick/1", {}},
				{"modifier_woda_talent_str3", "#woda_talent_str3", 2, "str3", {}}
			},
			[2] = {
				{"empty_2"},
				{"empty_3"},
				{"modifier_rubick_2","#modifier_rubick_2", 2, "rubick/2", {}},
				{"modifier_woda_talent_cloak", "#woda_talent_cloak", 2, "cloak", {}},
				{"modifier_woda_talent_str6", "#woda_talent_str6", 1, "str6", {"modifier_woda_talent_str3",2}}
			},
			[3] = {
				{"empty_6"},
				{"modifier_woda_talent_quickhp", "#woda_talent_quickhp", 2, "quickhp", {}},
				{"empty_7"},
				{"modifier_rubick_3","#modifier_rubick_3", 1, "rubick/3", {}},
				{"modifier_woda_talent_sasha", "#woda_talent_sasha", 1, "sasha", {"modifier_woda_talent_str6",1}}
			},
			[4] = {
				{"modifier_woda_talent_hp2", "#woda_talent_hp2", 3, "hp2", {"modifier_woda_talent_hp1",3}},
				{"empty_9"},
				{"modifier_rubick_4","#modifier_rubick_4", 1, "rubick/4", {"modifier_rubick_2",2}},
				{"modifier_woda_talent_octar", "#woda_talent_octar", 2, "octar", {}},
				{"modifier_woda_talent_str4", "#woda_talent_str4", 1, "str4", {"modifier_woda_talent_sasha",1}}
			},
			[5] = {
				{"modifier_woda_talent_armor2", "#woda_talent_armor2", 3, "armor2", {}},
				{"empty_10"},
				{"empty_11"},
				{"modifier_rubick_5","#modifier_rubick_5", 3, "rubick/5", {}},
				{"modifier_woda_talent_str5", "#woda_talent_str5", 3, "str5", {"modifier_woda_talent_str4",1}}
			},
			[6] = {
				{"modifier_woda_talent_sliver", "#woda_talent_sliver", 2, "sliver", {}},
				{"modifier_woda_talent_regenhp2", "#woda_talent_regenhp2", 3, "regenhp2", {}},
				{"modifier_rubick_6","#modifier_rubick_6", 3, "rubick/6", {"modifier_rubick_4",1}},
				{"empty_15"},
				{"empty_16"}
			},
			[7] = {
				{"empty_17"},
				{"empty_18"},
				{"modifier_rubick_7","#modifier_rubick_7", 1, "rubick/7", {}},
				{"empty_20"},
				{"empty_21"}
			}
		},
		[2] = {
			[1] = {
				{"modifier_woda_talent_armor1", "#woda_talent_armor1", 3, "armor1", {}},
				{"modifier_woda_talent_speed1", "#woda_talent_speed1", 2, "speed1", {}},
				{"modifier_woda_talent_attackspeed1", "#woda_talent_attackspeed1", 3, "attackspeed1", {}},
				{"modifier_rubick_8","#modifier_rubick_8", 3, "rubick/8", {}},
				{"modifier_woda_talent_agi3", "#woda_talent_agi3", 2, "agi3", {}}
			},
			[2] = {
				{"empty_2"},
				{"empty_3"},
				{"modifier_rubick_9","#modifier_rubick_9", 2, "rubick/9", {}},
				{"modifier_woda_talent_miss1", "#woda_talent_miss1", 2, "miss1", {}},
				{"modifier_woda_talent_agi6", "#woda_talent_agi6", 1, "agi6", {"modifier_woda_talent_agi3",2}}
			},
			[3] = {
				{"modifier_rubick_10","#modifier_rubick_10", 1, "rubick/10", {}},
				{"empty_7"},
				{"empty_8"},
				{"modifier_woda_talent_mask1", "#woda_talent_mask1", 2, "mask1", {}},
				{"modifier_woda_talent_yasha", "#woda_talent_yasha", 1, "yasha", {"modifier_woda_talent_agi6",1}}
			},
			[4] = {
				{"modifier_rubick_11","#modifier_rubick_11", 3, "rubick/11", {"modifier_rubick_10",1}},
				{"modifier_woda_talent_speed2", "#woda_talent_speed2", 3, "speed2", {"modifier_woda_talent_speed1",2}},
				{"modifier_woda_talent_grovebow", "#woda_talent_grovebow", 2, "grovebow", {}},
				{"empty_10"},			
				{"modifier_woda_talent_agi4", "#woda_talent_agi4", 1, "agi4", {"modifier_woda_talent_yasha",1}}
			},
			[5] = {
				{"modifier_woda_talent_attack2", "#woda_talent_attack2", 3, "attack2", {}},
				{"empty_11"},
				{"empty_12"},
				{"modifier_rubick_12","#modifier_rubick_12", 1, "rubick/12", {}},
				{"modifier_woda_talent_agi5", "#woda_talent_agi5", 3, "agi5", {"modifier_woda_talent_agi4",1}}
			},
			[6] = {
				{"modifier_woda_talent_miss2", "#woda_talent_miss2", 2, "miss2", {}},
				{"empty_13"},
				{"modifier_woda_talent_attackspeed2", "#woda_talent_attackspeed2", 3, "attackspeed2", {}},
				{"modifier_rubick_13","#modifier_rubick_13", 3, "rubick/13", {"modifier_rubick_12",1}},
				{"empty_16"}
			},
			[7] = {
				{"empty_17"},
				{"empty_18"},
				{"modifier_rubick_14","#modifier_rubick_14", 1, "rubick/14", {}},
				{"empty_20"},
				{"empty_21"}
			}
		},
		[3] = {
			[1] = {
				{"modifier_woda_talent_mp1", "#woda_talent_mp1", 3, "mp1", {}},
				{"modifier_woda_talent_regenmp1", "#woda_talent_regenmp1", 2, "regenmp1", {}},
				{"modifier_woda_talent_spell", "#woda_talent_spell", 3, "spell", {}},
				{"modifier_rubick_15","#modifier_rubick_15", 2, "rubick/15", {}},
				{"modifier_woda_talent_int3", "#woda_talent_int3", 2, "int3", {}}
			},
			[2] = {
				{"empty_2"},
				{"empty_3"},
				{"modifier_rubick_16","#modifier_rubick_16", 2, "rubick/16", {}},
				{"modifier_woda_talent_blood", "#woda_talent_blood", 2, "blood", {}},
				{"modifier_woda_talent_int6", "#woda_talent_int6", 1, "int6", {"modifier_woda_talent_int3",2}}
			},
			[3] = {
				{"empty_6"},
				{"empty_7"},
				{"modifier_rubick_17","#modifier_rubick_17", 3, "rubick/17", {}},
				{"modifier_woda_talent_mask2", "#woda_talent_mask2", 2, "mask2", {}},
				{"modifier_woda_talent_kaya", "#woda_talent_kaya", 1, "kaya", {"modifier_woda_talent_int6",1}}
			},
			[4] = {
				{"modifier_woda_talent_mp2", "#woda_talent_mp2", 3, "mp2", {"modifier_woda_talent_mp1",3}},
				{"modifier_woda_talent_fairy", "#woda_talent_fairy", 2, "fairy", {}},
				{"modifier_rubick_18","#modifier_rubick_18", 2, "rubick/18", {}},
				{"empty_9"},
				{"modifier_woda_talent_int4", "#woda_talent_int4", 1, "int4", {"modifier_woda_talent_kaya",1}}
			},
			[5] = {
				{"modifier_woda_talent_spellprism", "#woda_talent_spellprism", 3, "spellprism", {}},
				{"modifier_rubick_19","#modifier_rubick_19", 3, "rubick/19", {}},
				{"empty_10"},
				{"empty_11"},
				{"modifier_woda_talent_int5", "#woda_talent_int5", 3, "int5", {"modifier_woda_talent_int4",1}}
			},
			[6] = {
				{"modifier_woda_talent_timeless", "#woda_talent_timeless", 2, "timeless", {}},
				{"modifier_woda_talent_regenmp2", "#woda_talent_regenmp2", 3, "regenmp2", {}},
				{"modifier_rubick_20","#modifier_rubick_20", 1, "rubick/20", {}},
				{"empty_15"},
				{"empty_16"}
			},
			[7] = {
				{"empty_17"},
				{"empty_18"},
				{"modifier_rubick_21","#modifier_rubick_21", 1, "rubick/21", {}},
				{"empty_20"},
				{"empty_21"}
			}
		}
	},
	["npc_dota_hero_techies"] = {
		[1] = {
			[1] = {
				{"modifier_woda_talent_hp1", "#woda_talent_hp1", 3, "hp1", {}},
				{"modifier_woda_talent_regenhp1", "#woda_talent_regenhp1", 2, "regenhp1", {}},
				{"modifier_woda_talent_attack1", "#woda_talent_attack1", 3, "attack1", {}},
				{"modifier_techies_1","#modifier_techies_1", 3, "techies/1", {}},
				{"modifier_woda_talent_str3", "#woda_talent_str3", 2, "str3", {}}
			},
			[2] = {
				{"empty_2"},
				{"empty_3"},
				{"modifier_techies_2","#modifier_techies_2", 3, "techies/2", {}},
				{"modifier_woda_talent_cloak", "#woda_talent_cloak", 2, "cloak", {}},
				{"modifier_woda_talent_str6", "#woda_talent_str6", 1, "str6", {"modifier_woda_talent_str3",2}}
			},
			[3] = {
				{"empty_6"},
				{"modifier_woda_talent_quickhp", "#woda_talent_quickhp", 2, "quickhp", {}},
				{"modifier_techies_4","#modifier_techies_4", 1, "techies/4", {"modifier_techies_2",3}},
				{"empty_8"},
				{"modifier_woda_talent_sasha", "#woda_talent_sasha", 1, "sasha", {"modifier_woda_talent_str6",1}}
			},
			[4] = {
				{"modifier_woda_talent_hp2", "#woda_talent_hp2", 3, "hp2", {"modifier_woda_talent_hp1",3}},
				{"modifier_techies_3","#modifier_techies_3", 3, "techies/3", {}},
				{"empty_9"},
				{"modifier_woda_talent_octar", "#woda_talent_octar", 2, "octar", {}},
				{"modifier_woda_talent_str4", "#woda_talent_str4", 1, "str4", {"modifier_woda_talent_sasha",1}}
			},
			[5] = {
				{"modifier_woda_talent_armor2", "#woda_talent_armor2", 3, "armor2", {}},
				{"empty_10"},
				{"modifier_techies_5","#modifier_techies_5", 2, "techies/5", {"modifier_techies_4",1}},
				{"empty_11"},
				{"modifier_woda_talent_str5", "#woda_talent_str5", 3, "str5", {"modifier_woda_talent_str4",1}}
			},
			[6] = {
				{"modifier_woda_talent_sliver", "#woda_talent_sliver", 2, "sliver", {}},
				{"modifier_woda_talent_regenhp2", "#woda_talent_regenhp2", 3, "regenhp2", {}},
				{"empty_14"},
				{"modifier_techies_6","#modifier_techies_6", 1, "techies/6", {}},
				{"empty_16"}
			},
			[7] = {
				{"empty_17"},
				{"empty_18"},
				{"modifier_techies_7","#modifier_techies_7", 1, "techies/7", {}},
				{"empty_20"},
				{"empty_21"}
			}
		},
		[2] = {
			[1] = {
				{"modifier_woda_talent_armor1", "#woda_talent_armor1", 3, "armor1", {}},
				{"modifier_woda_talent_speed1", "#woda_talent_speed1", 2, "speed1", {}},
				{"modifier_woda_talent_attackspeed1", "#woda_talent_attackspeed1", 3, "attackspeed1", {}},
				{"modifier_techies_15","#modifier_techies_15", 1, "techies/15", {}},
				{"modifier_woda_talent_agi3", "#woda_talent_agi3", 2, "agi3", {}}
			},
			[2] = {
				{"empty_4"},
				{"empty_3"},
				{"modifier_techies_16","#modifier_techies_16", 3, "techies/16", {}},
				{"modifier_woda_talent_miss1", "#woda_talent_miss1", 2, "miss1", {}},
				{"modifier_woda_talent_agi6", "#woda_talent_agi6", 1, "agi6", {"modifier_woda_talent_agi3",2}}
			},
			[3] = {
				{"empty_8"},
				{"empty_7"},
				{"modifier_techies_18","#modifier_techies_18", 1, "techies/18", {}},
				{"modifier_woda_talent_mask1", "#woda_talent_mask1", 2, "mask1", {}},
				{"modifier_woda_talent_yasha", "#woda_talent_yasha", 1, "yasha", {"modifier_woda_talent_agi6",1}}
			},
			[4] = {
				{"modifier_techies_20","#modifier_techies_20", 3, "techies/20", {}},
				{"modifier_woda_talent_speed2", "#woda_talent_speed2", 3, "speed2", {"modifier_woda_talent_speed1",2}},
				{"modifier_woda_talent_grovebow", "#woda_talent_grovebow", 2, "grovebow", {}},
				{"empty_10"},			
				{"modifier_woda_talent_agi4", "#woda_talent_agi4", 1, "agi4", {"modifier_woda_talent_yasha",1}}
			},
			[5] = {
				{"modifier_woda_talent_attack2", "#woda_talent_attack2", 3, "attack2", {}},
				{"empty_11"},
				{"modifier_techies_19","#modifier_techies_19", 2, "techies/19", {}},
				{"empty_12"},
				{"modifier_woda_talent_agi5", "#woda_talent_agi5", 3, "agi5", {"modifier_woda_talent_agi4",1}}
			},
			[6] = {
				{"modifier_woda_talent_miss2", "#woda_talent_miss2", 2, "miss2", {}},
				{"empty_14"},
				{"modifier_woda_talent_attackspeed2", "#woda_talent_attackspeed2", 3, "attackspeed2", {}},
				{"empty_16"},
				{"modifier_techies_17","#modifier_techies_17", 3, "techies/17", {}}
			},
			[7] = {
				{"empty_17"},
				{"empty_18"},
				{"modifier_techies_21","#modifier_techies_21", 1, "techies/21", {}},
				{"empty_20"},
				{"empty_21"}
			}
		},
		[3] = {
			[1] = {
				{"modifier_woda_talent_mp1", "#woda_talent_mp1", 3, "mp1", {}},
				{"modifier_woda_talent_regenmp1", "#woda_talent_regenmp1", 2, "regenmp1", {}},
				{"modifier_woda_talent_spell", "#woda_talent_spell", 3, "spell", {}},
				{"modifier_techies_9","#modifier_techies_9", 1, "techies/9", {}},
				{"modifier_woda_talent_int3", "#woda_talent_int3", 2, "int3", {}}
			},
			[2] = {
				{"empty_2"},
				{"modifier_techies_10","#modifier_techies_10", 2, "techies/10", {}},
				{"empty_3"},
				{"modifier_woda_talent_blood", "#woda_talent_blood", 2, "blood", {}},
				{"modifier_woda_talent_int6", "#woda_talent_int6", 1, "int6", {"modifier_woda_talent_int3",2}}
			},
			[3] = {
				{"empty_6"},
				{"modifier_techies_11","#modifier_techies_11", 3, "techies/11", {}},
				{"empty_7"},
				{"modifier_woda_talent_mask2", "#woda_talent_mask2", 2, "mask2", {}},
				{"modifier_woda_talent_kaya", "#woda_talent_kaya", 1, "kaya", {"modifier_woda_talent_int6",1}}
			},
			[4] = {
				{"modifier_woda_talent_mp2", "#woda_talent_mp2", 3, "mp2", {"modifier_woda_talent_mp1",3}},
				{"modifier_woda_talent_fairy", "#woda_talent_fairy", 2, "fairy", {}},
				{"empty_9"},
				{"modifier_techies_8","#modifier_techies_8", 3, "techies/8", {}},
				{"modifier_woda_talent_int4", "#woda_talent_int4", 1, "int4", {"modifier_woda_talent_kaya",1}}
			},
			[5] = {
				{"modifier_woda_talent_spellprism", "#woda_talent_spellprism", 3, "spellprism", {}},
				{"empty_10"},
				{"empty_11"},
				{"modifier_techies_12","#modifier_techies_12", 3, "techies/12", {}},
				{"modifier_woda_talent_int5", "#woda_talent_int5", 3, "int5", {"modifier_woda_talent_int4",1}}
			},
			[6] = {
				{"modifier_woda_talent_timeless", "#woda_talent_timeless", 2, "timeless", {}},
				{"modifier_woda_talent_regenmp2", "#woda_talent_regenmp2", 3, "regenmp2", {}},
				{"empty_14"},
				{"modifier_techies_13","#modifier_techies_13", 1, "techies/13", {}},
				{"empty_15"}
			},
			[7] = {
				{"empty_17"},
				{"empty_18"},
				{"modifier_techies_14","#modifier_techies_14", 1, "techies/14", {}},
				{"empty_20"},
				{"empty_21"}
			}
		}
	},
	["npc_dota_hero_huskar"] = {
		[1] = {
			[1] = {
				{"modifier_woda_talent_hp1", "#woda_talent_hp1", 3, "hp1", {}},
				{"modifier_woda_talent_regenhp1", "#woda_talent_regenhp1", 2, "regenhp1", {}},
				{"modifier_huskar_1","#modifier_huskar_1", 2, "huskar/1", {}},
				{"modifier_woda_talent_attack1", "#woda_talent_attack1", 3, "attack1", {}},
				{"modifier_woda_talent_str3", "#woda_talent_str3", 2, "str3", {}}
			},
			[2] = {
				{"empty_2"},
				{"empty_3"},
				{"modifier_huskar_2","#modifier_huskar_2", 1, "huskar/2", {"modifier_huskar_1",2}},
				{"modifier_woda_talent_cloak", "#woda_talent_cloak", 2, "cloak", {}},
				{"modifier_woda_talent_str6", "#woda_talent_str6", 1, "str6", {"modifier_woda_talent_str3",2}}
			},
			[3] = {
				{"empty_6"},
				{"modifier_woda_talent_quickhp", "#woda_talent_quickhp", 2, "quickhp", {}},
				{"empty_7"},
				{"modifier_huskar_3","#modifier_huskar_3", 2, "huskar/3", {}},
				{"modifier_woda_talent_sasha", "#woda_talent_sasha", 1, "sasha", {"modifier_woda_talent_str6",1}}
			},
			[4] = {
				{"modifier_woda_talent_hp2", "#woda_talent_hp2", 3, "hp2", {"modifier_woda_talent_hp1",3}},
				{"modifier_huskar_4","#modifier_huskar_4", 3, "huskar/4", {}},
				{"empty_9"},
				{"modifier_woda_talent_octar", "#woda_talent_octar", 2, "octar", {}},
				{"modifier_woda_talent_str4", "#woda_talent_str4", 1, "str4", {"modifier_woda_talent_sasha",1}}
			},
			[5] = {
				{"modifier_woda_talent_armor2", "#woda_talent_armor2", 3, "armor2", {}},
				{"empty_10"},
				{"empty_11"},
				{"modifier_huskar_5","#modifier_huskar_5", 2, "huskar/5", {}},
				{"modifier_woda_talent_str5", "#woda_talent_str5", 3, "str5", {"modifier_woda_talent_str4",1}}
			},
			[6] = {
				{"modifier_woda_talent_sliver", "#woda_talent_sliver", 2, "sliver", {}},
				{"modifier_woda_talent_regenhp2", "#woda_talent_regenhp2", 3, "regenhp2", {}},
				{"modifier_huskar_6","#modifier_huskar_6", 3, "huskar/6", {}},
				{"empty_15"},
				{"empty_16"}
			},
			[7] = {
				{"empty_17"},
				{"empty_18"},
				{"modifier_huskar_7","#modifier_huskar_7", 1, "huskar/7", {}},
				{"empty_20"},
				{"empty_21"}
			}
		},
		[2] = {
			[1] = {
				{"modifier_huskar_8","#modifier_huskar_8", 3, "huskar/8", {}},
				{"modifier_woda_talent_speed1", "#woda_talent_speed1", 2, "speed1", {}},
				{"modifier_woda_talent_attackspeed1", "#woda_talent_attackspeed1", 3, "attackspeed1", {}},
				{"modifier_woda_talent_armor1", "#woda_talent_armor1", 3, "armor1", {}},
				{"modifier_woda_talent_agi3", "#woda_talent_agi3", 2, "agi3", {}}
			},
			[2] = {
				{"modifier_huskar_9","#modifier_huskar_9", 3, "huskar/9", {"modifier_huskar_8",3}},
				{"empty_3"},
				{"empty_4"},
				{"modifier_woda_talent_miss1", "#woda_talent_miss1", 2, "miss1", {}},
				{"modifier_woda_talent_agi6", "#woda_talent_agi6", 1, "agi6", {"modifier_woda_talent_agi3",2}}
			},
			[3] = {
				{"modifier_huskar_10","#modifier_huskar_10", 2, "huskar/10", {"modifier_huskar_9",3}},
				{"empty_7"},
				{"empty_8"},
				{"modifier_woda_talent_mask1", "#woda_talent_mask1", 2, "mask1", {}},
				{"modifier_woda_talent_yasha", "#woda_talent_yasha", 1, "yasha", {"modifier_woda_talent_agi6",1}}
			},
			[4] = {
				{"modifier_huskar_11","#modifier_huskar_11", 2, "huskar/11", {}},
				{"modifier_woda_talent_speed2", "#woda_talent_speed2", 3, "speed2", {"modifier_woda_talent_speed1",2}},
				{"modifier_woda_talent_grovebow", "#woda_talent_grovebow", 2, "grovebow", {}},
				{"empty_10"},			
				{"modifier_woda_talent_agi4", "#woda_talent_agi4", 1, "agi4", {"modifier_woda_talent_yasha",1}}
			},
			[5] = {
				{"modifier_woda_talent_attack2", "#woda_talent_attack2", 3, "attack2", {}},
				{"empty_11"},
				{"modifier_huskar_12","#modifier_huskar_12", 1, "huskar/12", {}},
				{"empty_12"},
				{"modifier_woda_talent_agi5", "#woda_talent_agi5", 3, "agi5", {"modifier_woda_talent_agi4",1}}
			},
			[6] = {
				{"modifier_woda_talent_miss2", "#woda_talent_miss2", 2, "miss2", {}},
				{"modifier_huskar_13","#modifier_huskar_13", 2, "huskar/13", {}},
				{"modifier_woda_talent_attackspeed2", "#woda_talent_attackspeed2", 3, "attackspeed2", {}},
				{"empty_15"},
				{"empty_16"}
			},
			[7] = {
				{"empty_17"},
				{"empty_18"},
				{"modifier_huskar_14","#modifier_huskar_14", 1, "huskar/14", {}},
				{"empty_20"},
				{"empty_21"}
			}
		},
		[3] = {
			[1] = {
				{"modifier_woda_talent_mp1", "#woda_talent_mp1", 3, "mp1", {}},
				{"modifier_woda_talent_regenmp1", "#woda_talent_regenmp1", 2, "regenmp1", {}},
				{"modifier_woda_talent_spell", "#woda_talent_spell", 3, "spell", {}},
				{"modifier_huskar_15","#modifier_huskar_15", 2, "huskar/15", {}},
				{"modifier_woda_talent_int3", "#woda_talent_int3", 2, "int3", {}}
			},
			[2] = {
				{"empty_2"},
				{"empty_3"},
				{"modifier_huskar_17","#modifier_huskar_17", 3, "huskar/17", {}},
				{"modifier_woda_talent_blood", "#woda_talent_blood", 2, "blood", {}},
				{"modifier_woda_talent_int6", "#woda_talent_int6", 1, "int6", {"modifier_woda_talent_int3",2}}
			},
			[3] = {
				{"empty_6"},
				{"empty_7"},
				{"modifier_huskar_16","#modifier_huskar_16", 3, "huskar/16", {}},
				{"modifier_woda_talent_mask2", "#woda_talent_mask2", 2, "mask2", {}},
				{"modifier_woda_talent_kaya", "#woda_talent_kaya", 1, "kaya", {"modifier_woda_talent_int6",1}}
			},
			[4] = {
				{"modifier_woda_talent_mp2", "#woda_talent_mp2", 3, "mp2", {"modifier_woda_talent_mp1",3}},
				{"modifier_woda_talent_fairy", "#woda_talent_fairy", 2, "fairy", {}},
				{"modifier_huskar_18","#modifier_huskar_18", 1, "huskar/18", {"modifier_huskar_16",3}},
				{"empty_9"},
				{"modifier_woda_talent_int4", "#woda_talent_int4", 1, "int4", {"modifier_woda_talent_kaya",1}}
			},
			[5] = {
				{"modifier_woda_talent_spellprism", "#woda_talent_spellprism", 3, "spellprism", {}},
				{"empty_11"},
				{"modifier_huskar_19","#modifier_huskar_19", 3, "huskar/19", {"modifier_huskar_18",1}},
				{"empty_12"},
				{"modifier_woda_talent_int5", "#woda_talent_int5", 3, "int5", {"modifier_woda_talent_int4",1}}
			},
			[6] = {
				{"modifier_woda_talent_timeless", "#woda_talent_timeless", 2, "timeless", {}},
				{"modifier_woda_talent_regenmp2", "#woda_talent_regenmp2", 3, "regenmp2", {}},
				{"modifier_huskar_20","#modifier_huskar_20", 1, "huskar/20", {"modifier_huskar_19",3}},
				{"empty_15"},
				{"empty_16"}
			},
			[7] = {
				{"empty_17"},
				{"empty_18"},
				{"modifier_huskar_21","#modifier_huskar_21", 1, "huskar/21", {}},
				{"empty_20"},
				{"empty_21"}
			}
		}
	},
	["npc_dota_hero_marci"] = {
		[1] = {
			[1] = {
				{"modifier_woda_talent_hp1", "#woda_talent_hp1", 3, "hp1", {}},
				{"modifier_woda_talent_regenhp1", "#woda_talent_regenhp1", 2, "regenhp1", {}},
				{"modifier_woda_talent_attack1", "#woda_talent_attack1", 3, "attack1", {}},
				{"modifier_marci_1","#modifier_marci_1", 2, "marci/1", {}},
				{"modifier_woda_talent_str3", "#woda_talent_str3", 2, "str3", {}}
			},
			[2] = {
				{"empty_2"},
				{"modifier_marci_4","#modifier_marci_4", 2, "marci/4", {}},
				{"empty_3"},
				{"modifier_woda_talent_cloak", "#woda_talent_cloak", 2, "cloak", {}},
				{"modifier_woda_talent_str6", "#woda_talent_str6", 1, "str6", {"modifier_woda_talent_str3",2}}
			},
			[3] = {
				{"empty_6"},
				{"modifier_woda_talent_quickhp", "#woda_talent_quickhp", 2, "quickhp", {}},
				{"empty_7"},
				{"modifier_marci_3","#modifier_marci_3", 2, "marci/3", {}},
				{"modifier_woda_talent_sasha", "#woda_talent_sasha", 1, "sasha", {"modifier_woda_talent_str6",1}}
			},
			[4] = {
				{"modifier_woda_talent_hp2", "#woda_talent_hp2", 3, "hp2", {"modifier_woda_talent_hp1",3}},
				{"empty_9"},
				{"modifier_marci_2","#modifier_marci_2", 2, "marci/2", {}},
				{"modifier_woda_talent_octar", "#woda_talent_octar", 2, "octar", {}},
				{"modifier_woda_talent_str4", "#woda_talent_str4", 1, "str4", {"modifier_woda_talent_sasha",1}}
			},
			[5] = {
				{"modifier_woda_talent_armor2", "#woda_talent_armor2", 3, "armor2", {}},
				{"empty_10"},
				{"empty_11"},
				{"modifier_marci_5","#modifier_marci_5", 3, "marci/5", {}},
				{"modifier_woda_talent_str5", "#woda_talent_str5", 3, "str5", {"modifier_woda_talent_str4",1}}
			},
			[6] = {
				{"modifier_woda_talent_sliver", "#woda_talent_sliver", 2, "sliver", {}},
				{"modifier_woda_talent_regenhp2", "#woda_talent_regenhp2", 3, "regenhp2", {}},
				{"empty_14"},
				{"modifier_marci_6","#modifier_marci_6", 2, "marci/6", {}},
				{"empty_16"}
			},
			[7] = {
				{"empty_17"},
				{"empty_18"},
				{"modifier_marci_7","#modifier_marci_7", 1, "marci/7", {}},
				{"empty_20"},
				{"empty_21"}
			}
		},
		[2] = {
			[1] = {
				{"modifier_woda_talent_armor1", "#woda_talent_armor1", 3, "armor1", {}},
				{"modifier_woda_talent_speed1", "#woda_talent_speed1", 2, "speed1", {}},
				{"modifier_woda_talent_attackspeed1", "#woda_talent_attackspeed1", 3, "attackspeed1", {}},
				{"modifier_marci_10","#modifier_marci_10", 1, "marci/10", {}},
				{"modifier_woda_talent_agi3", "#woda_talent_agi3", 2, "agi3", {}}
			},
			[2] = {
				{"modifier_marci_9","#modifier_marci_9", 3, "marci/9", {}},
				{"empty_3"},
				{"empty_4"},
				{"modifier_woda_talent_miss1", "#woda_talent_miss1", 2, "miss1", {}},
				{"modifier_woda_talent_agi6", "#woda_talent_agi6", 1, "agi6", {"modifier_woda_talent_agi3",2}}
			},
			[3] = {
				{"empty_7"},
				{"empty_8"},
				{"modifier_marci_8","#modifier_marci_8", 2, "marci/8", {}},
				{"modifier_woda_talent_mask1", "#woda_talent_mask1", 2, "mask1", {}},
				{"modifier_woda_talent_yasha", "#woda_talent_yasha", 1, "yasha", {"modifier_woda_talent_agi6",1}}
			},
			[4] = {
				{"empty_10"},
				{"modifier_woda_talent_speed2", "#woda_talent_speed2", 3, "speed2", {"modifier_woda_talent_speed1",2}},
				{"modifier_woda_talent_grovebow", "#woda_talent_grovebow", 2, "grovebow", {}},
				{"modifier_marci_12","#modifier_marci_12", 2, "marci/12", {}},			
				{"modifier_woda_talent_agi4", "#woda_talent_agi4", 1, "agi4", {"modifier_woda_talent_yasha",1}}
			},
			[5] = {
				{"modifier_woda_talent_attack2", "#woda_talent_attack2", 3, "attack2", {}},
				{"empty_11"},
				{"empty_12"},
				{"modifier_marci_11","#modifier_marci_11", 2, "marci/11", {}},
				{"modifier_woda_talent_agi5", "#woda_talent_agi5", 3, "agi5", {"modifier_woda_talent_agi4",1}}
			},
			[6] = {
				{"modifier_woda_talent_miss2", "#woda_talent_miss2", 2, "miss2", {}},
				{"modifier_marci_13","#modifier_marci_13", 3, "marci/13", {}},
				{"modifier_woda_talent_attackspeed2", "#woda_talent_attackspeed2", 3, "attackspeed2", {}},
				{"empty_15"},
				{"empty_16"}
			},
			[7] = {
				{"empty_17"},
				{"empty_18"},
				{"modifier_marci_14","#modifier_marci_14", 1, "marci/14", {}},
				{"empty_20"},
				{"empty_21"}
			}
		},
		[3] = {
			[1] = {
				{"modifier_woda_talent_mp1", "#woda_talent_mp1", 3, "mp1", {}},
				{"modifier_woda_talent_regenmp1", "#woda_talent_regenmp1", 2, "regenmp1", {}},
				{"modifier_marci_15","#modifier_marci_15", 3, "marci/15", {}},
				{"modifier_woda_talent_spell", "#woda_talent_spell", 3, "spell", {}},
				{"modifier_woda_talent_int3", "#woda_talent_int3", 2, "int3", {}}
			},
			[2] = {
				{"empty_2"},
				{"empty_3"},
				{"modifier_marci_16","#modifier_marci_16", 1, "marci/16", {"modifier_marci_15",3}},
				{"modifier_woda_talent_blood", "#woda_talent_blood", 2, "blood", {}},
				{"modifier_woda_talent_int6", "#woda_talent_int6", 1, "int6", {"modifier_woda_talent_int3",2}}
			},
			[3] = {
				{"empty_6"},
				{"empty_7"},
				{"modifier_marci_17","#modifier_marci_17", 3, "marci/17", {"modifier_marci_16",1}},
				{"modifier_woda_talent_mask2", "#woda_talent_mask2", 2, "mask2", {}},
				{"modifier_woda_talent_kaya", "#woda_talent_kaya", 1, "kaya", {"modifier_woda_talent_int6",1}}
			},
			[4] = {
				{"modifier_woda_talent_mp2", "#woda_talent_mp2", 3, "mp2", {"modifier_woda_talent_mp1",3}},
				{"modifier_woda_talent_fairy", "#woda_talent_fairy", 2, "fairy", {}},
				{"empty_9"},
				{"modifier_marci_20","#modifier_marci_20", 3, "marci/20", {}},
				{"modifier_woda_talent_int4", "#woda_talent_int4", 1, "int4", {"modifier_woda_talent_kaya",1}}
			},
			[5] = {
				{"modifier_woda_talent_spellprism", "#woda_talent_spellprism", 3, "spellprism", {}},
				{"modifier_marci_19","#modifier_marci_19", 1, "marci/19", {}},
				{"empty_10"},
				{"empty_11"},
				{"modifier_woda_talent_int5", "#woda_talent_int5", 3, "int5", {"modifier_woda_talent_int4",1}}
			},
			[6] = {
				{"modifier_woda_talent_timeless", "#woda_talent_timeless", 2, "timeless", {}},
				{"modifier_woda_talent_regenmp2", "#woda_talent_regenmp2", 3, "regenmp2", {}},
				{"modifier_marci_18","#modifier_marci_18", 2, "marci/18", {"modifier_marci_17",3}},
				{"empty_15"},
				{"empty_16"}
			},
			[7] = {
				{"empty_17"},
				{"empty_18"},
				{"modifier_marci_21","#modifier_marci_21", 1, "marci/21", {}},
				{"empty_20"},
				{"empty_21"}
			}
		}
	},
	["npc_dota_hero_ursa"] = {
		[1] = {
			[1] = {
				{"modifier_woda_talent_hp1", "#woda_talent_hp1", 3, "hp1", {}},
				{"modifier_woda_talent_regenhp1", "#woda_talent_regenhp1", 2, "regenhp1", {}},
				{"modifier_woda_talent_attack1", "#woda_talent_attack1", 3, "attack1", {}},
				{"modifier_ursa_3","#modifier_ursa_3", 2, "ursa/3", {}},
				{"modifier_woda_talent_str3", "#woda_talent_str3", 2, "str3", {}}
			},
			[2] = {
				{"empty_2"},
				{"empty_3"},
				{"modifier_ursa_2","#modifier_ursa_2", 2, "ursa/2", {}},
				{"modifier_woda_talent_cloak", "#woda_talent_cloak", 2, "cloak", {}},
				{"modifier_woda_talent_str6", "#woda_talent_str6", 1, "str6", {"modifier_woda_talent_str3",2}}
			},
			[3] = {
				{"empty_6"},
				{"modifier_woda_talent_quickhp", "#woda_talent_quickhp", 2, "quickhp", {}},
				{"empty_7"},
				{"modifier_ursa_1","#modifier_ursa_1", 3, "ursa/1", {}},
				{"modifier_woda_talent_sasha", "#woda_talent_sasha", 1, "sasha", {"modifier_woda_talent_str6",1}}
			},
			[4] = {
				{"modifier_woda_talent_hp2", "#woda_talent_hp2", 3, "hp2", {"modifier_woda_talent_hp1",3}},
				{"empty_9"},
				{"modifier_ursa_4","#modifier_ursa_4", 3, "ursa/4", {}},
				{"modifier_woda_talent_octar", "#woda_talent_octar", 2, "octar", {}},
				{"modifier_woda_talent_str4", "#woda_talent_str4", 1, "str4", {"modifier_woda_talent_sasha",1}}
			},
			[5] = {
				{"modifier_woda_talent_armor2", "#woda_talent_armor2", 3, "armor2", {}},
				{"empty_10"},
				{"empty_11"},
				{"modifier_ursa_5","#modifier_ursa_5", 2, "ursa/5", {}},
				{"modifier_woda_talent_str5", "#woda_talent_str5", 3, "str5", {"modifier_woda_talent_str4",1}}
			},
			[6] = {
				{"modifier_woda_talent_sliver", "#woda_talent_sliver", 2, "sliver", {}},
				{"modifier_woda_talent_regenhp2", "#woda_talent_regenhp2", 3, "regenhp2", {}},
				{"modifier_ursa_6","#modifier_ursa_6", 1, "ursa/6", {}},
				{"empty_15"},
				{"empty_16"}
			},
			[7] = {
				{"empty_17"},
				{"empty_18"},
				{"modifier_ursa_7","#modifier_ursa_7", 1, "ursa/7", {}},
				{"empty_20"},
				{"empty_21"}
			}
		},
		[2] = {
			[1] = {
				{"modifier_woda_talent_armor1", "#woda_talent_armor1", 3, "armor1", {}},
				{"modifier_woda_talent_speed1", "#woda_talent_speed1", 2, "speed1", {}},
				{"modifier_woda_talent_attackspeed1", "#woda_talent_attackspeed1", 3, "attackspeed1", {}},
				{"modifier_ursa_8","#modifier_ursa_8", 1, "ursa/8", {}},
				{"modifier_woda_talent_agi3", "#woda_talent_agi3", 2, "agi3", {}}
			},
			[2] = {
				{"empty_2"},
				{"empty_3"},
				{"modifier_ursa_9","#modifier_ursa_9", 3, "ursa/9", {}},
				{"modifier_woda_talent_miss1", "#woda_talent_miss1", 2, "miss1", {}},
				{"modifier_woda_talent_agi6", "#woda_talent_agi6", 1, "agi6", {"modifier_woda_talent_agi3",2}}
			},
			[3] = {
				{"modifier_ursa_10","#modifier_ursa_10", 2, "ursa/10", {}},
				{"empty_7"},
				{"empty_8"},
				{"modifier_woda_talent_mask1", "#woda_talent_mask1", 2, "mask1", {}},
				{"modifier_woda_talent_yasha", "#woda_talent_yasha", 1, "yasha", {"modifier_woda_talent_agi6",1}}
			},
			[4] = {
				{"empty_10"},
				{"modifier_woda_talent_speed2", "#woda_talent_speed2", 3, "speed2", {"modifier_woda_talent_speed1",2}},
				{"modifier_woda_talent_grovebow", "#woda_talent_grovebow", 2, "grovebow", {}},
				{"modifier_ursa_13","#modifier_ursa_13", 2, "ursa/13", {}},			
				{"modifier_woda_talent_agi4", "#woda_talent_agi4", 1, "agi4", {"modifier_woda_talent_yasha",1}}
			},
			[5] = {
				{"modifier_woda_talent_attack2", "#woda_talent_attack2", 3, "attack2", {}},
				{"modifier_ursa_12","#modifier_ursa_12", 3, "ursa/12", {}},
				{"empty_11"},
				{"empty_12"},
				{"modifier_woda_talent_agi5", "#woda_talent_agi5", 3, "agi5", {"modifier_woda_talent_agi4",1}}
			},
			[6] = {
				{"modifier_woda_talent_miss2", "#woda_talent_miss2", 2, "miss2", {}},
				{"empty_13"},
				{"modifier_woda_talent_attackspeed2", "#woda_talent_attackspeed2", 3, "attackspeed2", {}},
				{"modifier_ursa_11","#modifier_ursa_11", 2, "ursa/11", {}},
				{"empty_16"}
			},
			[7] = {
				{"empty_17"},
				{"empty_18"},
				{"modifier_ursa_14","#modifier_ursa_14", 1, "ursa/14", {}},
				{"empty_20"},
				{"empty_21"}
			}
		},
		[3] = {
			[1] = {
				{"modifier_woda_talent_mp1", "#woda_talent_mp1", 3, "mp1", {}},
				{"modifier_woda_talent_regenmp1", "#woda_talent_regenmp1", 2, "regenmp1", {}},
				{"modifier_woda_talent_spell", "#woda_talent_spell", 3, "spell", {}},
				{"modifier_ursa_15","#modifier_ursa_15", 3, "ursa/15", {}},
				{"modifier_woda_talent_int3", "#woda_talent_int3", 2, "int3", {}}
			},
			[2] = {
				{"empty_2"},
				{"empty_3"},
				{"modifier_ursa_19","#modifier_ursa_19", 2, "ursa/19", {}},
				{"modifier_woda_talent_blood", "#woda_talent_blood", 2, "blood", {}},
				{"modifier_woda_talent_int6", "#woda_talent_int6", 1, "int6", {"modifier_woda_talent_int3",2}}
			},
			[3] = {
				{"empty_6"},
				{"empty_7"},
				{"modifier_ursa_16","#modifier_ursa_16", 3, "ursa/16", {}},
				{"modifier_woda_talent_mask2", "#woda_talent_mask2", 2, "mask2", {}},
				{"modifier_woda_talent_kaya", "#woda_talent_kaya", 1, "kaya", {"modifier_woda_talent_int6",1}}
			},
			[4] = {
				{"modifier_woda_talent_mp2", "#woda_talent_mp2", 3, "mp2", {"modifier_woda_talent_mp1",3}},
				{"modifier_woda_talent_fairy", "#woda_talent_fairy", 2, "fairy", {}},
				{"empty_9"},
				{"modifier_ursa_17","#modifier_ursa_17", 2, "ursa/17", {}},
				{"modifier_woda_talent_int4", "#woda_talent_int4", 1, "int4", {"modifier_woda_talent_kaya",1}}
			},
			[5] = {
				{"modifier_woda_talent_spellprism", "#woda_talent_spellprism", 3, "spellprism", {}},
				{"empty_10"},
				{"empty_11"},
				{"modifier_ursa_18","#modifier_ursa_18", 1, "ursa/18", {}},
				{"modifier_woda_talent_int5", "#woda_talent_int5", 3, "int5", {"modifier_woda_talent_int4",1}}
			},
			[6] = {
				{"modifier_woda_talent_timeless", "#woda_talent_timeless", 2, "timeless", {}},
				{"modifier_woda_talent_regenmp2", "#woda_talent_regenmp2", 3, "regenmp2", {}},
				{"modifier_ursa_20","#modifier_ursa_20", 2, "ursa/20", {}},
				{"empty_15"},
				{"empty_16"}
			},
			[7] = {
				{"empty_17"},
				{"empty_18"},
				{"modifier_ursa_21","#modifier_ursa_21", 1, "ursa/21", {}},
				{"empty_20"},
				{"empty_21"}
			}
		}
	},
	["npc_dota_hero_warlock"] = {
		[1] = {
			[1] = {
				{"modifier_woda_talent_hp1", "#woda_talent_hp1", 3, "hp1", {}},
				{"modifier_woda_talent_regenhp1", "#woda_talent_regenhp1", 2, "regenhp1", {}},
				{"modifier_woda_talent_attack1", "#woda_talent_attack1", 3, "attack1", {}},
				{"modifier_warlock_1","#modifier_warlock_1", 1, "warlock/1", {}},
				{"modifier_woda_talent_str3", "#woda_talent_str3", 2, "str3", {}}
			},
			[2] = {
				{"empty_2"},
				{"empty_3"},
				{"modifier_warlock_2","#modifier_warlock_2", 3, "warlock/2", {}},
				{"modifier_woda_talent_cloak", "#woda_talent_cloak", 2, "cloak", {}},
				{"modifier_woda_talent_str6", "#woda_talent_str6", 1, "str6", {"modifier_woda_talent_str3",2}}
			},
			[3] = {
				{"empty_6"},
				{"modifier_woda_talent_quickhp", "#woda_talent_quickhp", 2, "quickhp", {}},
				{"empty_7"},
				{"modifier_warlock_5","#modifier_warlock_5", 3, "warlock/5", {}},
				{"modifier_woda_talent_sasha", "#woda_talent_sasha", 1, "sasha", {"modifier_woda_talent_str6",1}}
			},
			[4] = {
				{"modifier_woda_talent_hp2", "#woda_talent_hp2", 3, "hp2", {"modifier_woda_talent_hp1",3}},
				{"empty_9"},
				{"modifier_warlock_4","#modifier_warlock_4", 3, "warlock/4", {}},
				{"modifier_woda_talent_octar", "#woda_talent_octar", 2, "octar", {}},
				{"modifier_woda_talent_str4", "#woda_talent_str4", 1, "str4", {"modifier_woda_talent_sasha",1}}
			},
			[5] = {
				{"modifier_woda_talent_armor2", "#woda_talent_armor2", 3, "armor2", {}},
				{"empty_10"},
				{"empty_11"},
				{"modifier_warlock_3","#modifier_warlock_3", 2, "warlock/3", {}},
				{"modifier_woda_talent_str5", "#woda_talent_str5", 3, "str5", {"modifier_woda_talent_str4",1}}
			},
			[6] = {
				{"modifier_woda_talent_sliver", "#woda_talent_sliver", 2, "sliver", {}},
				{"modifier_woda_talent_regenhp2", "#woda_talent_regenhp2", 3, "regenhp2", {}},
				{"modifier_warlock_6","#modifier_warlock_6", 1, "warlock/6", {}},
				{"empty_15"},
				{"empty_16"}
			},
			[7] = {
				{"empty_17"},
				{"empty_18"},
				{"modifier_warlock_7","#modifier_warlock_7", 1, "warlock/7", {}},
				{"empty_20"},
				{"empty_21"}
			}
		},
		[2] = {
			[1] = {
				{"modifier_warlock_8","#modifier_warlock_8", 1, "warlock/8", {}},
				{"modifier_woda_talent_speed1", "#woda_talent_speed1", 2, "speed1", {}},
				{"modifier_woda_talent_attackspeed1", "#woda_talent_attackspeed1", 3, "attackspeed1", {}},
				{"modifier_woda_talent_armor1", "#woda_talent_armor1", 3, "armor1", {}},
				{"modifier_woda_talent_agi3", "#woda_talent_agi3", 2, "agi3", {}}
			},
			[2] = {
				{"modifier_warlock_9","#modifier_warlock_9", 3, "warlock/9", {"modifier_warlock_8",1}},
				{"empty_3"},
				{"empty_4"},
				{"modifier_woda_talent_miss1", "#woda_talent_miss1", 2, "miss1", {}},
				{"modifier_woda_talent_agi6", "#woda_talent_agi6", 1, "agi6", {"modifier_woda_talent_agi3",2}}
			},
			[3] = {
				{"modifier_warlock_10","#modifier_warlock_10", 3, "warlock/10", {"modifier_warlock_9",3}},
				{"empty_7"},
				{"empty_8"},
				{"modifier_woda_talent_mask1", "#woda_talent_mask1", 2, "mask1", {}},
				{"modifier_woda_talent_yasha", "#woda_talent_yasha", 1, "yasha", {"modifier_woda_talent_agi6",1}}
			},
			[4] = {
				{"empty_10"},
				{"modifier_woda_talent_speed2", "#woda_talent_speed2", 3, "speed2", {"modifier_woda_talent_speed1",2}},
				{"modifier_woda_talent_grovebow", "#woda_talent_grovebow", 2, "grovebow", {}},
				{"modifier_warlock_19","#modifier_warlock_19", 1, "warlock/19", {}},			
				{"modifier_woda_talent_agi4", "#woda_talent_agi4", 1, "agi4", {"modifier_woda_talent_yasha",1}}
			},
			[5] = {
				{"modifier_woda_talent_attack2", "#woda_talent_attack2", 3, "attack2", {}},
				{"modifier_warlock_12","#modifier_warlock_12", 2, "warlock/12", {}},
				{"empty_11"},
				{"empty_12"},
				{"modifier_woda_talent_agi5", "#woda_talent_agi5", 3, "agi5", {"modifier_woda_talent_agi4",1}}
			},
			[6] = {
				{"modifier_woda_talent_miss2", "#woda_talent_miss2", 2, "miss2", {}},
				{"empty_13"},
				{"modifier_woda_talent_attackspeed2", "#woda_talent_attackspeed2", 3, "attackspeed2", {}},
				{"empty_15"},
				{"modifier_warlock_13","#modifier_warlock_13", 3, "warlock/13", {}}
			},
			[7] = {
				{"empty_17"},
				{"empty_18"},
				{"modifier_warlock_21","#modifier_warlock_21", 1, "warlock/21", {}},
				{"empty_20"},
				{"empty_21"}
			}
		},
		[3] = {
			[1] = {
				{"modifier_woda_talent_mp1", "#woda_talent_mp1", 3, "mp1", {}},
				{"modifier_woda_talent_regenmp1", "#woda_talent_regenmp1", 2, "regenmp1", {}},
				{"modifier_woda_talent_spell", "#woda_talent_spell", 3, "spell", {}},
				{"modifier_warlock_15","#modifier_warlock_15", 1, "warlock/15", {}},
				{"modifier_woda_talent_int3", "#woda_talent_int3", 2, "int3", {}}
			},
			[2] = {
				{"empty_2"},
				{"empty_3"},
				{"modifier_warlock_20","#modifier_warlock_20", 3, "warlock/20", {}},
				{"modifier_woda_talent_blood", "#woda_talent_blood", 2, "blood", {}},
				{"modifier_woda_talent_int6", "#woda_talent_int6", 1, "int6", {"modifier_woda_talent_int3",2}}
			},
			[3] = {
				{"empty_6"},
				{"empty_7"},
				{"modifier_warlock_16","#modifier_warlock_16", 2, "warlock/16", {}},
				{"modifier_woda_talent_mask2", "#woda_talent_mask2", 2, "mask2", {}},
				{"modifier_woda_talent_kaya", "#woda_talent_kaya", 1, "kaya", {"modifier_woda_talent_int6",1}}
			},
			[4] = {
				{"modifier_woda_talent_mp2", "#woda_talent_mp2", 3, "mp2", {"modifier_woda_talent_mp1",3}},
				{"modifier_woda_talent_fairy", "#woda_talent_fairy", 2, "fairy", {}},
				{"empty_9"},
				{"modifier_warlock_17","#modifier_warlock_17", 2, "warlock/17", {}},
				{"modifier_woda_talent_int4", "#woda_talent_int4", 1, "int4", {"modifier_woda_talent_kaya",1}}
			},
			[5] = {
				{"modifier_woda_talent_spellprism", "#woda_talent_spellprism", 3, "spellprism", {}},
				{"modifier_warlock_18","#modifier_warlock_18", 3, "warlock/18", {}},
				{"empty_11"},
				{"empty_12"},
				{"modifier_woda_talent_int5", "#woda_talent_int5", 3, "int5", {"modifier_woda_talent_int4",1}}
			},
			[6] = {
				{"modifier_woda_talent_timeless", "#woda_talent_timeless", 2, "timeless", {}},
				{"modifier_woda_talent_regenmp2", "#woda_talent_regenmp2", 3, "regenmp2", {}},
				{"modifier_warlock_11","#modifier_warlock_11", 2, "warlock/11", {}},
				{"empty_15"},
				{"empty_16"}
			},
			[7] = {
				{"empty_17"},
				{"empty_18"},
				{"modifier_warlock_14","#modifier_warlock_14", 1, "warlock/14", {}},
				{"empty_20"},
				{"empty_21"}
			}
		}
	},
	["npc_dota_hero_kez"] = {
		[1] = {
			[1] = {
				{"modifier_woda_talent_hp1", "#woda_talent_hp1", 3, "hp1", {}},
				{"modifier_woda_talent_regenhp1", "#woda_talent_regenhp1", 2, "regenhp1", {}},
				{"modifier_kez_1","#modifier_kez_1", 1, "kez/1", {}},
				{"modifier_woda_talent_attack1", "#woda_talent_attack1", 3, "attack1", {}},
				{"modifier_woda_talent_str3", "#woda_talent_str3", 2, "str3", {}}
			},
			[2] = {
				{"empty_2"},
				{"empty_3"},
				{"modifier_kez_2","#modifier_kez_2", 2, "kez/2", {"modifier_kez_1",1}},
				{"modifier_woda_talent_cloak", "#woda_talent_cloak", 2, "cloak", {}},
				{"modifier_woda_talent_str6", "#woda_talent_str6", 1, "str6", {"modifier_woda_talent_str3",2}}
			},
			[3] = {
				{"empty_6"},
				{"modifier_woda_talent_quickhp", "#woda_talent_quickhp", 2, "quickhp", {}},
				{"modifier_kez_3","#modifier_kez_3", 3, "kez/3", {"modifier_kez_2",2}},
				{"empty_8"},
				{"modifier_woda_talent_sasha", "#woda_talent_sasha", 1, "sasha", {"modifier_woda_talent_str6",1}}
			},
			[4] = {
				{"modifier_woda_talent_hp2", "#woda_talent_hp2", 3, "hp2", {"modifier_woda_talent_hp1",3}},
				{"empty_9"},
				{"modifier_kez_4","#modifier_kez_4", 1, "kez/4", {"modifier_kez_3",3}},
				{"modifier_woda_talent_octar", "#woda_talent_octar", 2, "octar", {}},
				{"modifier_woda_talent_str4", "#woda_talent_str4", 1, "str4", {"modifier_woda_talent_sasha",1}}
			},
			[5] = {
				{"modifier_woda_talent_armor2", "#woda_talent_armor2", 3, "armor2", {}},
				{"empty_10"},
				{"empty_11"},
				{"modifier_kez_5","#modifier_kez_5", 3, "kez/5", {}},
				{"modifier_woda_talent_str5", "#woda_talent_str5", 3, "str5", {"modifier_woda_talent_str4",1}}
			},
			[6] = {
				{"modifier_woda_talent_sliver", "#woda_talent_sliver", 2, "sliver", {}},
				{"modifier_woda_talent_regenhp2", "#woda_talent_regenhp2", 3, "regenhp2", {}},
				{"modifier_kez_6","#modifier_kez_6", 3, "kez/6", {}},
				{"empty_15"},
				{"empty_16"}
			},
			[7] = {
				{"empty_17"},
				{"empty_18"},
				{"modifier_kez_7","#modifier_kez_7", 1, "kez/7", {}},
				{"empty_20"},
				{"empty_21"}
			}
		},
		[2] = {
			[1] = {
				{"modifier_kez_8","#modifier_kez_8", 1, "kez/8", {}},
				{"modifier_woda_talent_speed1", "#woda_talent_speed1", 2, "speed1", {}},
				{"modifier_woda_talent_attackspeed1", "#woda_talent_attackspeed1", 3, "attackspeed1", {}},
				{"modifier_woda_talent_armor1", "#woda_talent_armor1", 3, "armor1", {}},
				{"modifier_woda_talent_agi3", "#woda_talent_agi3", 2, "agi3", {}}
			},
			[2] = {
				{"modifier_kez_9","#modifier_kez_9", 2, "kez/9", {"modifier_kez_8",1}},
				{"empty_3"},
				{"empty_4"},
				{"modifier_woda_talent_miss1", "#woda_talent_miss1", 2, "miss1", {}},
				{"modifier_woda_talent_agi6", "#woda_talent_agi6", 1, "agi6", {"modifier_woda_talent_agi3",2}}
			},
			[3] = {
				{"modifier_kez_10","#modifier_kez_10", 3, "kez/10", {"modifier_kez_9",2}},
				{"empty_7"},
				{"empty_8"},
				{"modifier_woda_talent_mask1", "#woda_talent_mask1", 2, "mask1", {}},
				{"modifier_woda_talent_yasha", "#woda_talent_yasha", 1, "yasha", {"modifier_woda_talent_agi6",1}}
			},
			[4] = {
				{"modifier_kez_11","#modifier_kez_11", 1, "kez/11", {"modifier_kez_10",3}},
				{"modifier_woda_talent_speed2", "#woda_talent_speed2", 3, "speed2", {"modifier_woda_talent_speed1",2}},
				{"modifier_woda_talent_grovebow", "#woda_talent_grovebow", 2, "grovebow", {}},
				{"empty_10"},			
				{"modifier_woda_talent_agi4", "#woda_talent_agi4", 1, "agi4", {"modifier_woda_talent_yasha",1}}
			},
			[5] = {
				{"modifier_woda_talent_attack2", "#woda_talent_attack2", 3, "attack2", {}},
				{"empty_11"},
				{"empty_12"},
				{"modifier_kez_12","#modifier_kez_12", 3, "kez/12", {}},
				{"modifier_woda_talent_agi5", "#woda_talent_agi5", 3, "agi5", {"modifier_woda_talent_agi4",1}}
			},
			[6] = {
				{"modifier_woda_talent_miss2", "#woda_talent_miss2", 2, "miss2", {}},
				{"empty_13"},
				{"modifier_woda_talent_attackspeed2", "#woda_talent_attackspeed2", 3, "attackspeed2", {}},
				{"modifier_kez_13","#modifier_kez_13", 3, "kez/13", {}},
				{"empty_16"}
			},
			[7] = {
				{"empty_17"},
				{"empty_18"},
				{"modifier_kez_14","#modifier_kez_14", 1, "kez/14", {}},
				{"empty_20"},
				{"empty_21"}
			}
		},
		[3] = {
			[1] = {
				{"modifier_woda_talent_mp1", "#woda_talent_mp1", 3, "mp1", {}},
				{"modifier_woda_talent_regenmp1", "#woda_talent_regenmp1", 2, "regenmp1", {}},
				{"modifier_woda_talent_spell", "#woda_talent_spell", 3, "spell", {}},
				{"modifier_kez_15","#modifier_kez_15", 2, "kez/15", {}},
				{"modifier_woda_talent_int3", "#woda_talent_int3", 2, "int3", {}}
			},
			[2] = {
				{"empty_2"},
				{"empty_3"},
				{"modifier_kez_16","#modifier_kez_16", 3, "kez/16", {}},
				{"modifier_woda_talent_blood", "#woda_talent_blood", 2, "blood", {}},
				{"modifier_woda_talent_int6", "#woda_talent_int6", 1, "int6", {"modifier_woda_talent_int3",2}}
			},
			[3] = {
				{"empty_6"},
				{"empty_7"},
				{"modifier_kez_17","#modifier_kez_17", 1, "kez/17", {}},
				{"modifier_woda_talent_mask2", "#woda_talent_mask2", 2, "mask2", {}},
				{"modifier_woda_talent_kaya", "#woda_talent_kaya", 1, "kaya", {"modifier_woda_talent_int6",1}}
			},
			[4] = {
				{"modifier_woda_talent_mp2", "#woda_talent_mp2", 3, "mp2", {"modifier_woda_talent_mp1",3}},
				{"modifier_woda_talent_fairy", "#woda_talent_fairy", 2, "fairy", {}},
				{"modifier_kez_18","#modifier_kez_18", 2, "kez/18", {}},
				{"empty_9"},
				{"modifier_woda_talent_int4", "#woda_talent_int4", 1, "int4", {"modifier_woda_talent_kaya",1}}
			},
			[5] = {
				{"modifier_woda_talent_spellprism", "#woda_talent_spellprism", 3, "spellprism", {}},
				{"modifier_kez_19","#modifier_kez_19", 2, "kez/19", {}},
				{"empty_10"},
				{"empty_11"},
				{"modifier_woda_talent_int5", "#woda_talent_int5", 3, "int5", {"modifier_woda_talent_int4",1}}
			},
			[6] = {
				{"modifier_woda_talent_timeless", "#woda_talent_timeless", 2, "timeless", {}},
				{"modifier_woda_talent_regenmp2", "#woda_talent_regenmp2", 3, "regenmp2", {}},
				{"empty_14"},
				{"modifier_kez_20","#modifier_kez_20", 3, "kez/20", {}},
				{"empty_16"}
			},
			[7] = {
				{"empty_17"},
				{"empty_18"},
				{"modifier_kez_21","#modifier_kez_21", 1, "kez/21", {}},
				{"empty_20"},
				{"empty_21"}
			}
		}
	},
	["npc_dota_hero_zuus"] = {
		[1] = {
			[1] = {
				{"modifier_woda_talent_hp1", "#woda_talent_hp1", 3, "hp1", {}},
				{"modifier_woda_talent_regenhp1", "#woda_talent_regenhp1", 2, "regenhp1", {}},
				{"modifier_zuus_1","#modifier_zuus_1", 2, "zuus/1", {}},
				{"modifier_woda_talent_attack1", "#woda_talent_attack1", 3, "attack1", {}},
				{"modifier_woda_talent_str3", "#woda_talent_str3", 2, "str3", {}}
			},
			[2] = {
				{"empty_2"},
				{"empty_3"},
				{"modifier_zuus_2","#modifier_zuus_2", 2, "zuus/2", {"modifier_zuus_1",2}},
				{"modifier_woda_talent_cloak", "#woda_talent_cloak", 2, "cloak", {}},
				{"modifier_woda_talent_str6", "#woda_talent_str6", 1, "str6", {"modifier_woda_talent_str3",2}}
			},
			[3] = {
				{"empty_6"},
				{"modifier_woda_talent_quickhp", "#woda_talent_quickhp", 2, "quickhp", {}},
				{"modifier_zuus_3","#modifier_zuus_3", 2, "zuus/3", {"modifier_zuus_2",2}},
				{"empty_8"},
				{"modifier_woda_talent_sasha", "#woda_talent_sasha", 1, "sasha", {"modifier_woda_talent_str6",1}}
			},
			[4] = {
				{"modifier_woda_talent_hp2", "#woda_talent_hp2", 3, "hp2", {"modifier_woda_talent_hp1",3}},
				{"empty_9"},
				{"modifier_zuus_4","#modifier_zuus_4", 1, "zuus/4", {"modifier_zuus_3",2}},
				{"modifier_woda_talent_octar", "#woda_talent_octar", 2, "octar", {}},
				{"modifier_woda_talent_str4", "#woda_talent_str4", 1, "str4", {"modifier_woda_talent_sasha",1}}
			},
			[5] = {
				{"modifier_woda_talent_armor2", "#woda_talent_armor2", 3, "armor2", {}},
				{"empty_10"},
				{"empty_11"},
				{"modifier_zuus_5","#modifier_zuus_5", 3, "zuus/5", {}},
				{"modifier_woda_talent_str5", "#woda_talent_str5", 3, "str5", {"modifier_woda_talent_str4",1}}
			},
			[6] = {
				{"modifier_woda_talent_sliver", "#woda_talent_sliver", 2, "sliver", {}},
				{"modifier_woda_talent_regenhp2", "#woda_talent_regenhp2", 3, "regenhp2", {}},
				{"empty_14"},
				{"empty_15"},
				{"modifier_zuus_6","#modifier_zuus_6", 3, "zuus/6", {}}
			},
			[7] = {
				{"empty_17"},
				{"empty_18"},
				{"modifier_zuus_7","#modifier_zuus_7", 1, "zuus/7", {}},
				{"empty_20"},
				{"empty_21"}
			}
		},
		[2] = {
			[1] = {
				{"modifier_woda_talent_armor1", "#woda_talent_armor1", 3, "armor1", {}},
				{"modifier_woda_talent_speed1", "#woda_talent_speed1", 2, "speed1", {}},
				{"modifier_woda_talent_attackspeed1", "#woda_talent_attackspeed1", 3, "attackspeed1", {}},
				{"modifier_zuus_8","#modifier_zuus_8", 3, "zuus/8", {}},
				{"modifier_woda_talent_agi3", "#woda_talent_agi3", 2, "agi3", {}}
			},
			[2] = {
				{"empty_2"},
				{"empty_3"},
				{"modifier_zuus_9","#modifier_zuus_9", 3, "zuus/9", {}},
				{"modifier_woda_talent_miss1", "#woda_talent_miss1", 2, "miss1", {}},
				{"modifier_woda_talent_agi6", "#woda_talent_agi6", 1, "agi6", {"modifier_woda_talent_agi3",2}}
			},
			[3] = {
				{"empty_6"},
				{"empty_7"},
				{"modifier_zuus_10","#modifier_zuus_10", 1, "zuus/10", {}},
				{"modifier_woda_talent_mask1", "#woda_talent_mask1", 2, "mask1", {}},
				{"modifier_woda_talent_yasha", "#woda_talent_yasha", 1, "yasha", {"modifier_woda_talent_agi6",1}}
			},
			[4] = {
				{"modifier_zuus_11","#modifier_zuus_11", 2, "zuus/11", {}},
				{"modifier_woda_talent_speed2", "#woda_talent_speed2", 3, "speed2", {"modifier_woda_talent_speed1",2}},
				{"modifier_woda_talent_grovebow", "#woda_talent_grovebow", 2, "grovebow", {}},
				{"empty_10"},			
				{"modifier_woda_talent_agi4", "#woda_talent_agi4", 1, "agi4", {"modifier_woda_talent_yasha",1}}
			},
			[5] = {
				{"modifier_woda_talent_attack2", "#woda_talent_attack2", 3, "attack2", {}},
				{"empty_11"},
				{"modifier_zuus_12","#modifier_zuus_12", 2, "zuus/12", {}},
				{"empty_12"},
				{"modifier_woda_talent_agi5", "#woda_talent_agi5", 3, "agi5", {"modifier_woda_talent_agi4",1}}
			},
			[6] = {
				{"modifier_woda_talent_miss2", "#woda_talent_miss2", 2, "miss2", {}},
				{"empty_13"},
				{"modifier_woda_talent_attackspeed2", "#woda_talent_attackspeed2", 3, "attackspeed2", {}},
				{"empty_16"},
				{"modifier_zuus_13","#modifier_zuus_13", 2, "zuus/13", {}}
			},
			[7] = {
				{"empty_17"},
				{"empty_18"},
				{"modifier_zuus_14","#modifier_zuus_14", 1, "zuus/14", {}},
				{"empty_20"},
				{"empty_21"}
			}
		},
		[3] = {
			[1] = {
				{"modifier_woda_talent_mp1", "#woda_talent_mp1", 3, "mp1", {}},
				{"modifier_woda_talent_regenmp1", "#woda_talent_regenmp1", 2, "regenmp1", {}},
				{"modifier_woda_talent_spell", "#woda_talent_spell", 3, "spell", {}},
				{"modifier_zuus_15","#modifier_zuus_15", 3, "zuus/15", {}},
				{"modifier_woda_talent_int3", "#woda_talent_int3", 2, "int3", {}}
			},
			[2] = {
				{"empty_2"},
				{"empty_3"},
				{"modifier_zuus_16","#modifier_zuus_16", 2, "zuus/16", {}},
				{"modifier_woda_talent_blood", "#woda_talent_blood", 2, "blood", {}},
				{"modifier_woda_talent_int6", "#woda_talent_int6", 1, "int6", {"modifier_woda_talent_int3",2}}
			},
			[3] = {
				{"empty_6"},
				{"empty_7"},
				{"modifier_zuus_18","#modifier_zuus_18", 3, "zuus/18", {}},
				{"modifier_woda_talent_mask2", "#woda_talent_mask2", 2, "mask2", {}},
				{"modifier_woda_talent_kaya", "#woda_talent_kaya", 1, "kaya", {"modifier_woda_talent_int6",1}}
			},
			[4] = {
				{"modifier_woda_talent_mp2", "#woda_talent_mp2", 3, "mp2", {"modifier_woda_talent_mp1",3}},
				{"modifier_woda_talent_fairy", "#woda_talent_fairy", 2, "fairy", {}},
				{"modifier_zuus_17","#modifier_zuus_17", 1, "zuus/17", {}},
				{"empty_9"},
				{"modifier_woda_talent_int4", "#woda_talent_int4", 1, "int4", {"modifier_woda_talent_kaya",1}}
			},
			[5] = {
				{"modifier_woda_talent_spellprism", "#woda_talent_spellprism", 3, "spellprism", {}},
				{"empty_10"},
				{"empty_11"},
				{"modifier_zuus_19","#modifier_zuus_19", 1, "zuus/19", {}},
				{"modifier_woda_talent_int5", "#woda_talent_int5", 3, "int5", {"modifier_woda_talent_int4",1}}
			},
			[6] = {
				{"modifier_woda_talent_timeless", "#woda_talent_timeless", 2, "timeless", {}},
				{"modifier_woda_talent_regenmp2", "#woda_talent_regenmp2", 3, "regenmp2", {}},
				{"empty_14"},
				{"modifier_zuus_20","#modifier_zuus_20", 3, "zuus/20", {"modifier_zuus_19",1}},
				{"empty_16"}
			},
			[7] = {
				{"empty_17"},
				{"empty_18"},
				{"modifier_zuus_21","#modifier_zuus_21", 1, "zuus/21", {}},
				{"empty_20"},
				{"empty_21"}
			}
		}
	},
	["npc_dota_hero_pangolier"] = {
		[1] = {
			[1] = {
				{"modifier_woda_talent_hp1", "#woda_talent_hp1", 3, "hp1", {}},
				{"modifier_woda_talent_regenhp1", "#woda_talent_regenhp1", 2, "regenhp1", {}},
				{"modifier_woda_talent_attack1", "#woda_talent_attack1", 3, "attack1", {}},
				{"modifier_pangolier_1","#modifier_pangolier_1", 2, "pangolier/1", {}},
				{"modifier_woda_talent_str3", "#woda_talent_str3", 2, "str3", {}}
			},
			[2] = {
				{"empty_2"},
				{"empty_3"},
				{"modifier_pangolier_2","#modifier_pangolier_2", 2, "pangolier/2", {}},
				{"modifier_woda_talent_cloak", "#woda_talent_cloak", 2, "cloak", {}},
				{"modifier_woda_talent_str6", "#woda_talent_str6", 1, "str6", {"modifier_woda_talent_str3",2}}
			},
			[3] = {
				{"empty_6"},
				{"modifier_woda_talent_quickhp", "#woda_talent_quickhp", 2, "quickhp", {}},
				{"empty_7"},
				{"modifier_pangolier_3","#modifier_pangolier_3", 1, "pangolier/3", {}},
				{"modifier_woda_talent_sasha", "#woda_talent_sasha", 1, "sasha", {"modifier_woda_talent_str6",1}}
			},
			[4] = {
				{"modifier_woda_talent_hp2", "#woda_talent_hp2", 3, "hp2", {"modifier_woda_talent_hp1",3}},
				{"modifier_pangolier_4","#modifier_pangolier_4", 2, "pangolier/4", {}},
				{"empty_9"},
				{"modifier_woda_talent_octar", "#woda_talent_octar", 2, "octar", {}},
				{"modifier_woda_talent_str4", "#woda_talent_str4", 1, "str4", {"modifier_woda_talent_sasha",1}}
			},
			[5] = {
				{"modifier_woda_talent_armor2", "#woda_talent_armor2", 3, "armor2", {}},
				{"modifier_pangolier_5","#modifier_pangolier_5", 3, "pangolier/5", {"modifier_pangolier_4",2}},
				{"empty_10"},
				{"empty_11"},
				{"modifier_woda_talent_str5", "#woda_talent_str5", 3, "str5", {"modifier_woda_talent_str4",1}}
			},
			[6] = {
				{"modifier_woda_talent_sliver", "#woda_talent_sliver", 2, "sliver", {}},
				{"modifier_woda_talent_regenhp2", "#woda_talent_regenhp2", 3, "regenhp2", {}},
				{"modifier_pangolier_6","#modifier_pangolier_6", 3, "pangolier/6", {}},
				{"empty_14"},
				{"empty_16"}
			},
			[7] = {
				{"empty_17"},
				{"empty_18"},
				{"modifier_pangolier_7","#modifier_pangolier_7", 1, "pangolier/7", {}},
				{"empty_20"},
				{"empty_21"}
			}
		},
		[2] = {
			[1] = {
				{"modifier_woda_talent_armor1", "#woda_talent_armor1", 3, "armor1", {}},
				{"modifier_woda_talent_speed1", "#woda_talent_speed1", 2, "speed1", {}},
				{"modifier_woda_talent_attackspeed1", "#woda_talent_attackspeed1", 3, "attackspeed1", {}},
				{"modifier_pangolier_8","#modifier_pangolier_8", 3, "pangolier/8", {}},
				{"modifier_woda_talent_agi3", "#woda_talent_agi3", 2, "agi3", {}}
			},
			[2] = {
				{"empty_2"},
				{"empty_3"},
				{"modifier_pangolier_9","#modifier_pangolier_9", 2, "pangolier/9", {}},
				{"modifier_woda_talent_miss1", "#woda_talent_miss1", 2, "miss1", {}},
				{"modifier_woda_talent_agi6", "#woda_talent_agi6", 1, "agi6", {"modifier_woda_talent_agi3",2}}
			},
			[3] = {
				{"empty_6"},
				{"empty_7"},
				{"modifier_pangolier_10","#modifier_pangolier_10", 2, "pangolier/10", {}},
				{"modifier_woda_talent_mask1", "#woda_talent_mask1", 2, "mask1", {}},
				{"modifier_woda_talent_yasha", "#woda_talent_yasha", 1, "yasha", {"modifier_woda_talent_agi6",1}}
			},
			[4] = {
				{"empty_10"},
				{"modifier_woda_talent_speed2", "#woda_talent_speed2", 3, "speed2", {"modifier_woda_talent_speed1",2}},
				{"modifier_woda_talent_grovebow", "#woda_talent_grovebow", 2, "grovebow", {}},
				{"modifier_pangolier_11","#modifier_pangolier_11", 1, "pangolier/11", {}},			
				{"modifier_woda_talent_agi4", "#woda_talent_agi4", 1, "agi4", {"modifier_woda_talent_yasha",1}}
			},
			[5] = {
				{"modifier_woda_talent_attack2", "#woda_talent_attack2", 3, "attack2", {}},
				{"empty_11"},
				{"modifier_pangolier_13","#modifier_pangolier_13", 2, "pangolier/13", {}},
				{"empty_12"},
				{"modifier_woda_talent_agi5", "#woda_talent_agi5", 3, "agi5", {"modifier_woda_talent_agi4",1}}
			},
			[6] = {
				{"modifier_woda_talent_miss2", "#woda_talent_miss2", 2, "miss2", {}},
				{"empty_13"},
				{"modifier_woda_talent_attackspeed2", "#woda_talent_attackspeed2", 3, "attackspeed2", {}},
				{"modifier_pangolier_12","#modifier_pangolier_12", 3, "pangolier/12", {}},
				{"empty_16"}
			},
			[7] = {
				{"empty_17"},
				{"empty_18"},
				{"modifier_pangolier_14","#modifier_pangolier_14", 1, "pangolier/14", {}},
				{"empty_20"},
				{"empty_21"}
			}
		},
		[3] = {
			[1] = {
				{"modifier_woda_talent_mp1", "#woda_talent_mp1", 3, "mp1", {}},
				{"modifier_woda_talent_regenmp1", "#woda_talent_regenmp1", 2, "regenmp1", {}},
				{"modifier_woda_talent_spell", "#woda_talent_spell", 3, "spell", {}},
				{"modifier_pangolier_15","#modifier_pangolier_15", 1, "pangolier/15", {}},
				{"modifier_woda_talent_int3", "#woda_talent_int3", 2, "int3", {}}
			},
			[2] = {
				{"empty_2"},
				{"modifier_pangolier_19","#modifier_pangolier_19", 3, "pangolier/19", {}},
				{"empty_3"},
				{"modifier_woda_talent_blood", "#woda_talent_blood", 2, "blood", {}},
				{"modifier_woda_talent_int6", "#woda_talent_int6", 1, "int6", {"modifier_woda_talent_int3",2}}
			},
			[3] = {
				{"empty_6"},
				{"empty_7"},
				{"modifier_pangolier_20","#modifier_pangolier_20", 2, "pangolier/20", {}},
				{"modifier_woda_talent_mask2", "#woda_talent_mask2", 2, "mask2", {}},
				{"modifier_woda_talent_kaya", "#woda_talent_kaya", 1, "kaya", {"modifier_woda_talent_int6",1}}
			},
			[4] = {
				{"modifier_woda_talent_mp2", "#woda_talent_mp2", 3, "mp2", {"modifier_woda_talent_mp1",3}},
				{"modifier_woda_talent_fairy", "#woda_talent_fairy", 2, "fairy", {}},
				{"modifier_pangolier_17","#modifier_pangolier_17", 1, "pangolier/17", {}},
				{"empty_9"},
				{"modifier_woda_talent_int4", "#woda_talent_int4", 1, "int4", {"modifier_woda_talent_kaya",1}}
			},
			[5] = {
				{"modifier_woda_talent_spellprism", "#woda_talent_spellprism", 3, "spellprism", {}},
				{"empty_10"},
				{"empty_11"},
				{"modifier_pangolier_16","#modifier_pangolier_16", 3, "pangolier/16", {}},
				{"modifier_woda_talent_int5", "#woda_talent_int5", 3, "int5", {"modifier_woda_talent_int4",1}}
			},
			[6] = {
				{"modifier_woda_talent_timeless", "#woda_talent_timeless", 2, "timeless", {}},
				{"modifier_woda_talent_regenmp2", "#woda_talent_regenmp2", 3, "regenmp2", {}},
				{"empty_14"},
				{"empty_15"},
				{"modifier_pangolier_18","#modifier_pangolier_18", 3, "pangolier/18", {}}
			},
			[7] = {
				{"empty_17"},
				{"empty_18"},
				{"modifier_pangolier_21","#modifier_pangolier_21", 1, "pangolier/21", {}},
				{"empty_20"},
				{"empty_21"}
			}
		}
	},
	["npc_dota_hero_jakiro"] = {
		[1] = {
			[1] = {
				{"modifier_woda_talent_hp1", "#woda_talent_hp1", 3, "hp1", {}},
				{"modifier_woda_talent_regenhp1", "#woda_talent_regenhp1", 2, "regenhp1", {}},
				{"modifier_woda_talent_attack1", "#woda_talent_attack1", 3, "attack1", {}},
				{"modifier_jakiro_1","#modifier_jakiro_1", 2, "jakiro/1", {}},
				{"modifier_woda_talent_str3", "#woda_talent_str3", 2, "str3", {}}
			},
			[2] = {
				{"empty_2"},
				{"modifier_jakiro_2","#modifier_jakiro_2", 2, "jakiro/2", {}},
				{"empty_3"},
				{"modifier_woda_talent_cloak", "#woda_talent_cloak", 2, "cloak", {}},
				{"modifier_woda_talent_str6", "#woda_talent_str6", 1, "str6", {"modifier_woda_talent_str3",2}}
			},
			[3] = {
				{"empty_6"},
				{"modifier_woda_talent_quickhp", "#woda_talent_quickhp", 2, "quickhp", {}},
				{"empty_7"},
				{"modifier_jakiro_4","#modifier_jakiro_4", 1, "jakiro/4", {}},
				{"modifier_woda_talent_sasha", "#woda_talent_sasha", 1, "sasha", {"modifier_woda_talent_str6",1}}
			},
			[4] = {
				{"modifier_woda_talent_hp2", "#woda_talent_hp2", 3, "hp2", {"modifier_woda_talent_hp1",3}},
				{"empty_9"},
				{"modifier_jakiro_5","#modifier_jakiro_5", 3, "jakiro/5", {}},
				{"modifier_woda_talent_octar", "#woda_talent_octar", 2, "octar", {}},
				{"modifier_woda_talent_str4", "#woda_talent_str4", 1, "str4", {"modifier_woda_talent_sasha",1}}
			},
			[5] = {
				{"modifier_woda_talent_armor2", "#woda_talent_armor2", 3, "armor2", {}},
				{"empty_10"},
				{"empty_11"},
				{"modifier_jakiro_3","#modifier_jakiro_3", 3, "jakiro/3", {}},
				{"modifier_woda_talent_str5", "#woda_talent_str5", 3, "str5", {"modifier_woda_talent_str4",1}}
			},
			[6] = {
				{"modifier_woda_talent_sliver", "#woda_talent_sliver", 2, "sliver", {}},
				{"modifier_woda_talent_regenhp2", "#woda_talent_regenhp2", 3, "regenhp2", {}},
				{"empty_14"},
				{"modifier_jakiro_6","#modifier_jakiro_6", 2, "jakiro/6", {}},
				{"empty_16"}
			},
			[7] = {
				{"empty_17"},
				{"empty_18"},
				{"modifier_jakiro_7","#modifier_jakiro_7", 1, "jakiro/7", {}},
				{"empty_20"},
				{"empty_21"}
			}
		},
		[2] = {
			[1] = {
				{"modifier_jakiro_8","#modifier_jakiro_8", 2, "jakiro/8", {}},
				{"modifier_woda_talent_speed1", "#woda_talent_speed1", 2, "speed1", {}},
				{"modifier_woda_talent_attackspeed1", "#woda_talent_attackspeed1", 3, "attackspeed1", {}},
				{"modifier_woda_talent_armor1", "#woda_talent_armor1", 3, "armor1", {}},
				{"modifier_woda_talent_agi3", "#woda_talent_agi3", 2, "agi3", {}}
			},
			[2] = {
				{"empty_4"},
				{"empty_3"},
				{"modifier_jakiro_9","#modifier_jakiro_9", 2, "jakiro/9", {}},
				{"modifier_woda_talent_miss1", "#woda_talent_miss1", 2, "miss1", {}},
				{"modifier_woda_talent_agi6", "#woda_talent_agi6", 1, "agi6", {"modifier_woda_talent_agi3",2}}
			},
			[3] = {
				{"modifier_jakiro_10","#modifier_jakiro_10", 2, "jakiro/10", {"modifier_jakiro_8",2}},
				{"empty_7"},
				{"empty_8"},
				{"modifier_woda_talent_mask1", "#woda_talent_mask1", 2, "mask1", {}},
				{"modifier_woda_talent_yasha", "#woda_talent_yasha", 1, "yasha", {"modifier_woda_talent_agi6",1}}
			},
			[4] = {
				{"empty_9"},
				{"modifier_woda_talent_speed2", "#woda_talent_speed2", 3, "speed2", {"modifier_woda_talent_speed1",2}},
				{"modifier_woda_talent_grovebow", "#woda_talent_grovebow", 2, "grovebow", {}},
				{"modifier_jakiro_11","#modifier_jakiro_11", 3, "jakiro/11", {}},
				{"modifier_woda_talent_agi4", "#woda_talent_agi4", 1, "agi4", {"modifier_woda_talent_yasha",1}}
			},
			[5] = {
				{"modifier_woda_talent_attack2", "#woda_talent_attack2", 3, "attack2", {}},
				{"empty_11"},
				{"modifier_jakiro_12","#modifier_jakiro_12", 2, "jakiro/12", {}},
				{"empty_12"},
				{"modifier_woda_talent_agi5", "#woda_talent_agi5", 3, "agi5", {"modifier_woda_talent_agi4",1}}
			},
			[6] = {
				{"modifier_woda_talent_miss2", "#woda_talent_miss2", 2, "miss2", {}},
				{"empty_13"},
				{"modifier_woda_talent_attackspeed2", "#woda_talent_attackspeed2", 3, "attackspeed2", {}},
				{"modifier_jakiro_13","#modifier_jakiro_13", 2, "jakiro/13", {"modifier_jakiro_11",3}},
				{"empty_16"}
			},
			[7] = {
				{"empty_17"},
				{"empty_18"},
				{"modifier_jakiro_14","#modifier_jakiro_14", 1, "jakiro/14", {}},
				{"empty_20"},
				{"empty_21"}
			}
		},
		[3] = {
			[1] = {
				{"modifier_woda_talent_mp1", "#woda_talent_mp1", 3, "mp1", {}},
				{"modifier_woda_talent_regenmp1", "#woda_talent_regenmp1", 2, "regenmp1", {}},
				{"modifier_woda_talent_spell", "#woda_talent_spell", 3, "spell", {}},
				{"modifier_jakiro_15","#modifier_jakiro_15", 1, "jakiro/15", {}},
				{"modifier_woda_talent_int3", "#woda_talent_int3", 2, "int3", {}}
			},
			[2] = {
				{"empty_2"},
				{"empty_3"},
				{"modifier_jakiro_16","#modifier_jakiro_16", 2, "jakiro/16", {}},
				{"modifier_woda_talent_blood", "#woda_talent_blood", 2, "blood", {}},
				{"modifier_woda_talent_int6", "#woda_talent_int6", 1, "int6", {"modifier_woda_talent_int3",2}}
			},
			[3] = {
				{"empty_6"},
				{"empty_7"},
				{"modifier_jakiro_17","#modifier_jakiro_17", 3, "jakiro/17", {"modifier_jakiro_16",2}},
				{"modifier_woda_talent_mask2", "#woda_talent_mask2", 2, "mask2", {}},
				{"modifier_woda_talent_kaya", "#woda_talent_kaya", 1, "kaya", {"modifier_woda_talent_int6",1}}
			},
			[4] = {
				{"modifier_woda_talent_mp2", "#woda_talent_mp2", 3, "mp2", {"modifier_woda_talent_mp1",3}},
				{"modifier_woda_talent_fairy", "#woda_talent_fairy", 2, "fairy", {}},
				{"modifier_jakiro_18","#modifier_jakiro_18", 2, "jakiro/18", {}},
				{"empty_9"},
				{"modifier_woda_talent_int4", "#woda_talent_int4", 1, "int4", {"modifier_woda_talent_kaya",1}}
			},
			[5] = {
				{"modifier_woda_talent_spellprism", "#woda_talent_spellprism", 3, "spellprism", {}},
				{"empty_10"},
				{"empty_11"},
				{"modifier_jakiro_20","#modifier_jakiro_20", 2, "jakiro/20", {}},
				{"modifier_woda_talent_int5", "#woda_talent_int5", 3, "int5", {"modifier_woda_talent_int4",1}}
			},
			[6] = {
				{"modifier_woda_talent_timeless", "#woda_talent_timeless", 2, "timeless", {}},
				{"modifier_woda_talent_regenmp2", "#woda_talent_regenmp2", 3, "regenmp2", {}},
				{"modifier_jakiro_19","#modifier_jakiro_19", 3, "jakiro/19", {}},
				{"empty_15"},
				{"empty_16"}
			},
			[7] = {
				{"empty_17"},
				{"empty_18"},
				{"modifier_jakiro_21","#modifier_jakiro_21", 1, "jakiro/21", {}},
				{"empty_20"},
				{"empty_21"}
			}
		}
	},
	["npc_dota_hero_luna"] = {
		[1] = {
			[1] = {
				{"modifier_woda_talent_hp1", "#woda_talent_hp1", 3, "hp1", {}},
				{"modifier_woda_talent_regenhp1", "#woda_talent_regenhp1", 2, "regenhp1", {}},
				{"modifier_woda_talent_attack1", "#woda_talent_attack1", 3, "attack1", {}},
				{"modifier_luna_8","#modifier_luna_8", 3, "luna/8", {}},
				{"modifier_woda_talent_str3", "#woda_talent_str3", 2, "str3", {}}
			},
			[2] = {
				{"empty_2"},
				{"empty_3"},
				{"modifier_luna_11","#modifier_luna_11", 3, "luna/11", {}},
				{"modifier_woda_talent_cloak", "#woda_talent_cloak", 2, "cloak", {}},
				{"modifier_woda_talent_str6", "#woda_talent_str6", 1, "str6", {"modifier_woda_talent_str3",2}}
			},
			[3] = {
				{"empty_6"},
				{"modifier_woda_talent_quickhp", "#woda_talent_quickhp", 2, "quickhp", {}},
				{"empty_7"},
				{"modifier_luna_13","#modifier_luna_13", 3, "luna/13", {}},
				{"modifier_woda_talent_sasha", "#woda_talent_sasha", 1, "sasha", {"modifier_woda_talent_str6",1}}
			},
			[4] = {
				{"modifier_woda_talent_hp2", "#woda_talent_hp2", 3, "hp2", {"modifier_woda_talent_hp1",3}},
				{"empty_9"},
				{"modifier_luna_9","#modifier_luna_9", 1, "luna/9", {}},
				{"modifier_woda_talent_octar", "#woda_talent_octar", 2, "octar", {}},
				{"modifier_woda_talent_str4", "#woda_talent_str4", 1, "str4", {"modifier_woda_talent_sasha",1}}
			},
			[5] = {
				{"modifier_woda_talent_armor2", "#woda_talent_armor2", 3, "armor2", {}},
				{"empty_10"},
				{"empty_11"},
				{"modifier_luna_12","#modifier_luna_12", 1, "luna/12", {}},
				{"modifier_woda_talent_str5", "#woda_talent_str5", 3, "str5", {"modifier_woda_talent_str4",1}}
			},
			[6] = {
				{"modifier_woda_talent_sliver", "#woda_talent_sliver", 2, "sliver", {}},
				{"modifier_woda_talent_regenhp2", "#woda_talent_regenhp2", 3, "regenhp2", {}},
				{"empty_14"},
				{"empty_15"},
				{"modifier_luna_10","#modifier_luna_10", 2, "luna/10", {}}
			},
			[7] = {
				{"empty_17"},
				{"empty_18"},
				{"modifier_luna_14","#modifier_luna_14", 1, "luna/14", {}},
				{"empty_20"},
				{"empty_21"}
			}
		},
		[2] = {
			[1] = {
				{"modifier_woda_talent_armor1", "#woda_talent_armor1", 3, "armor1", {}},
				{"modifier_woda_talent_speed1", "#woda_talent_speed1", 2, "speed1", {}},
				{"modifier_woda_talent_attackspeed1", "#woda_talent_attackspeed1", 3, "attackspeed1", {}},
				{"modifier_luna_1","#modifier_luna_1", 2, "luna/1", {}},
				{"modifier_woda_talent_agi3", "#woda_talent_agi3", 2, "agi3", {}}
			},
			[2] = {
				{"empty_2"},
				{"empty_3"},
				{"modifier_luna_2","#modifier_luna_2", 3, "luna/2", {}},
				{"modifier_woda_talent_miss1", "#woda_talent_miss1", 2, "miss1", {}},
				{"modifier_woda_talent_agi6", "#woda_talent_agi6", 1, "agi6", {"modifier_woda_talent_agi3",2}}
			},
			[3] = {
				{"empty_7"},
				{"empty_8"},
				{"modifier_luna_3","#modifier_luna_3", 2, "luna/3", {}},
				{"modifier_woda_talent_mask1", "#woda_talent_mask1", 2, "mask1", {}},
				{"modifier_woda_talent_yasha", "#woda_talent_yasha", 1, "yasha", {"modifier_woda_talent_agi6",1}}
			},
			[4] = {
				{"modifier_luna_4","#modifier_luna_4", 3, "luna/4", {}},
				{"modifier_woda_talent_speed2", "#woda_talent_speed2", 3, "speed2", {"modifier_woda_talent_speed1",2}},
				{"modifier_woda_talent_grovebow", "#woda_talent_grovebow", 2, "grovebow", {}},
				{"empty_10"},			
				{"modifier_woda_talent_agi4", "#woda_talent_agi4", 1, "agi4", {"modifier_woda_talent_yasha",1}}
			},
			[5] = {
				{"modifier_woda_talent_attack2", "#woda_talent_attack2", 3, "attack2", {}},
				{"empty_11"},
				{"modifier_luna_5","#modifier_luna_5", 1, "luna/5", {}},
				{"empty_12"},
				{"modifier_woda_talent_agi5", "#woda_talent_agi5", 3, "agi5", {"modifier_woda_talent_agi4",1}}
			},
			[6] = {
				{"modifier_woda_talent_miss2", "#woda_talent_miss2", 2, "miss2", {}},
				{"empty_13"},
				{"modifier_woda_talent_attackspeed2", "#woda_talent_attackspeed2", 3, "attackspeed2", {}},
				{"empty_15"},
				{"modifier_luna_6","#modifier_luna_6", 2, "luna/6", {}}
			},
			[7] = {
				{"empty_17"},
				{"empty_18"},
				{"modifier_luna_7","#modifier_luna_7", 1, "luna/7", {}},
				{"empty_20"},
				{"empty_21"}
			}
		},
		[3] = {
			[1] = {
				{"modifier_woda_talent_mp1", "#woda_talent_mp1", 3, "mp1", {}},
				{"modifier_woda_talent_regenmp1", "#woda_talent_regenmp1", 2, "regenmp1", {}},
				{"modifier_woda_talent_spell", "#woda_talent_spell", 3, "spell", {}},
				{"modifier_luna_15","#modifier_luna_15", 1, "luna/15", {}},
				{"modifier_woda_talent_int3", "#woda_talent_int3", 2, "int3", {}}
			},
			[2] = {
				{"empty_2"},
				{"empty_3"},
				{"modifier_luna_16","#modifier_luna_16", 2, "luna/16", {}},
				{"modifier_woda_talent_blood", "#woda_talent_blood", 2, "blood", {}},
				{"modifier_woda_talent_int6", "#woda_talent_int6", 1, "int6", {"modifier_woda_talent_int3",2}}
			},
			[3] = {
				{"empty_6"},
				{"modifier_luna_20","#modifier_luna_20", 3, "luna/20", {}},
				{"empty_7"},
				{"modifier_woda_talent_mask2", "#woda_talent_mask2", 2, "mask2", {}},
				{"modifier_woda_talent_kaya", "#woda_talent_kaya", 1, "kaya", {"modifier_woda_talent_int6",1}}
			},
			[4] = {
				{"modifier_woda_talent_mp2", "#woda_talent_mp2", 3, "mp2", {"modifier_woda_talent_mp1",3}},
				{"modifier_woda_talent_fairy", "#woda_talent_fairy", 2, "fairy", {}},
				{"modifier_luna_17","#modifier_luna_17", 2, "luna/17", {}},
				{"empty_9"},
				{"modifier_woda_talent_int4", "#woda_talent_int4", 1, "int4", {"modifier_woda_talent_kaya",1}}
			},
			[5] = {
				{"modifier_woda_talent_spellprism", "#woda_talent_spellprism", 3, "spellprism", {}},
				{"empty_10"},
				{"modifier_luna_18","#modifier_luna_18", 2, "luna/18", {}},
				{"empty_11"},
				{"modifier_woda_talent_int5", "#woda_talent_int5", 3, "int5", {"modifier_woda_talent_int4",1}}
			},
			[6] = {
				{"modifier_woda_talent_timeless", "#woda_talent_timeless", 2, "timeless", {}},
				{"modifier_woda_talent_regenmp2", "#woda_talent_regenmp2", 3, "regenmp2", {}},
				{"empty_14"},
				{"empty_16"},
				{"modifier_luna_19","#modifier_luna_19", 3, "luna/19", {}}
			},
			[7] = {
				{"empty_17"},
				{"empty_18"},
				{"modifier_luna_21","#modifier_luna_21", 1, "luna/21", {}},
				{"empty_20"},
				{"empty_21"}
			}
		}
	},
	["npc_dota_hero_winter_wyvern"] = {
		[1] = {
			[1] = {
				{"modifier_woda_talent_hp1", "#woda_talent_hp1", 3, "hp1", {}},
				{"modifier_woda_talent_regenhp1", "#woda_talent_regenhp1", 2, "regenhp1", {}},
				{"modifier_woda_talent_attack1", "#woda_talent_attack1", 3, "attack1", {}},
				{"modifier_winter_wyvern_1","#modifier_winter_wyvern_1", 1, "winter_wyvern/1", {}},
				{"modifier_woda_talent_str3", "#woda_talent_str3", 2, "str3", {}}
			},
			[2] = {
				{"empty_2"},
				{"empty_3"},
				{"modifier_winter_wyvern_2","#modifier_winter_wyvern_2", 3, "winter_wyvern/2", {}},
				{"modifier_woda_talent_cloak", "#woda_talent_cloak", 2, "cloak", {}},
				{"modifier_woda_talent_str6", "#woda_talent_str6", 1, "str6", {"modifier_woda_talent_str3",2}}
			},
			[3] = {
				{"empty_6"},
				{"modifier_woda_talent_quickhp", "#woda_talent_quickhp", 2, "quickhp", {}},
				{"empty_7"},
				{"modifier_winter_wyvern_3","#modifier_winter_wyvern_3", 2, "winter_wyvern/3", {}},
				{"modifier_woda_talent_sasha", "#woda_talent_sasha", 1, "sasha", {"modifier_woda_talent_str6",1}}
			},
			[4] = {
				{"modifier_woda_talent_hp2", "#woda_talent_hp2", 3, "hp2", {"modifier_woda_talent_hp1",3}},
				{"modifier_winter_wyvern_5","#modifier_winter_wyvern_5", 3, "winter_wyvern/5", {}},
				{"empty_9"},
				{"modifier_woda_talent_octar", "#woda_talent_octar", 2, "octar", {}},
				{"modifier_woda_talent_str4", "#woda_talent_str4", 1, "str4", {"modifier_woda_talent_sasha",1}}
			},
			[5] = {
				{"modifier_woda_talent_armor2", "#woda_talent_armor2", 3, "armor2", {}},
				{"empty_10"},
				{"empty_11"},
				{"modifier_winter_wyvern_4","#modifier_winter_wyvern_4", 2, "winter_wyvern/4", {}},
				{"modifier_woda_talent_str5", "#woda_talent_str5", 3, "str5", {"modifier_woda_talent_str4",1}}
			},
			[6] = {
				{"modifier_woda_talent_sliver", "#woda_talent_sliver", 2, "sliver", {}},
				{"modifier_woda_talent_regenhp2", "#woda_talent_regenhp2", 3, "regenhp2", {}},
				{"modifier_winter_wyvern_6","#modifier_winter_wyvern_6", 2, "winter_wyvern/6", {}},
				{"empty_14"},
				{"empty_16"}
			},
			[7] = {
				{"empty_17"},
				{"empty_18"},
				{"modifier_winter_wyvern_7","#modifier_winter_wyvern_7", 1, "winter_wyvern/7", {}},
				{"empty_20"},
				{"empty_21"}
			}
		},
		[2] = {
			[1] = {
				{"modifier_woda_talent_armor1", "#woda_talent_armor1", 3, "armor1", {}},
				{"modifier_woda_talent_speed1", "#woda_talent_speed1", 2, "speed1", {}},
				{"modifier_woda_talent_attackspeed1", "#woda_talent_attackspeed1", 3, "attackspeed1", {}},
				{"modifier_winter_wyvern_8","#modifier_winter_wyvern_8", 2, "winter_wyvern/8", {}},
				{"modifier_woda_talent_agi3", "#woda_talent_agi3", 2, "agi3", {}}
			},
			[2] = {
				{"empty_2"},
				{"empty_3"},
				{"modifier_winter_wyvern_9","#modifier_winter_wyvern_9", 3, "winter_wyvern/9", {}},
				{"modifier_woda_talent_miss1", "#woda_talent_miss1", 2, "miss1", {}},
				{"modifier_woda_talent_agi6", "#woda_talent_agi6", 1, "agi6", {"modifier_woda_talent_agi3",2}}
			},
			[3] = {
				{"modifier_winter_wyvern_10","#modifier_winter_wyvern_10", 3, "winter_wyvern/10", {}},
				{"empty_7"},
				{"empty_8"},
				{"modifier_woda_talent_mask1", "#woda_talent_mask1", 2, "mask1", {}},
				{"modifier_woda_talent_yasha", "#woda_talent_yasha", 1, "yasha", {"modifier_woda_talent_agi6",1}}
			},
			[4] = {
				{"modifier_winter_wyvern_11","#modifier_winter_wyvern_11", 1, "winter_wyvern/11", {}},
				{"modifier_woda_talent_speed2", "#woda_talent_speed2", 3, "speed2", {"modifier_woda_talent_speed1",2}},
				{"modifier_woda_talent_grovebow", "#woda_talent_grovebow", 2, "grovebow", {}},
				{"empty_10"},			
				{"modifier_woda_talent_agi4", "#woda_talent_agi4", 1, "agi4", {"modifier_woda_talent_yasha",1}}
			},
			[5] = {
				{"modifier_woda_talent_attack2", "#woda_talent_attack2", 3, "attack2", {}},
				{"empty_11"},
				{"empty_12"},
				{"modifier_winter_wyvern_12","#modifier_winter_wyvern_12", 2, "winter_wyvern/12", {}},
				{"modifier_woda_talent_agi5", "#woda_talent_agi5", 3, "agi5", {"modifier_woda_talent_agi4",1}}
			},
			[6] = {
				{"modifier_woda_talent_miss2", "#woda_talent_miss2", 2, "miss2", {}},
				{"empty_13"},
				{"modifier_woda_talent_attackspeed2", "#woda_talent_attackspeed2", 3, "attackspeed2", {}},
				{"modifier_winter_wyvern_13","#modifier_winter_wyvern_13", 2, "winter_wyvern/13", {}},
				{"empty_16"}
			},
			[7] = {
				{"empty_17"},
				{"empty_18"},
				{"modifier_winter_wyvern_14","#modifier_winter_wyvern_14", 1, "winter_wyvern/14", {}},
				{"empty_20"},
				{"empty_21"}
			}
		},
		[3] = {
			[1] = {
				{"modifier_woda_talent_mp1", "#woda_talent_mp1", 3, "mp1", {}},
				{"modifier_woda_talent_regenmp1", "#woda_talent_regenmp1", 2, "regenmp1", {}},
				{"modifier_woda_talent_spell", "#woda_talent_spell", 3, "spell", {}},
				{"modifier_winter_wyvern_15","#modifier_winter_wyvern_15", 1, "winter_wyvern/15", {}},
				{"modifier_woda_talent_int3", "#woda_talent_int3", 2, "int3", {}}
			},
			[2] = {
				{"empty_2"},
				{"modifier_winter_wyvern_16","#modifier_winter_wyvern_16", 3, "winter_wyvern/16", {}},
				{"empty_3"},
				{"modifier_woda_talent_blood", "#woda_talent_blood", 2, "blood", {}},
				{"modifier_woda_talent_int6", "#woda_talent_int6", 1, "int6", {"modifier_woda_talent_int3",2}}
			},
			[3] = {
				{"empty_6"},
				{"empty_7"},
				{"modifier_winter_wyvern_17","#modifier_winter_wyvern_17", 2, "winter_wyvern/17", {}},
				{"modifier_woda_talent_mask2", "#woda_talent_mask2", 2, "mask2", {}},
				{"modifier_woda_talent_kaya", "#woda_talent_kaya", 1, "kaya", {"modifier_woda_talent_int6",1}}
			},
			[4] = {
				{"modifier_woda_talent_mp2", "#woda_talent_mp2", 3, "mp2", {"modifier_woda_talent_mp1",3}},
				{"modifier_woda_talent_fairy", "#woda_talent_fairy", 2, "fairy", {}},
				{"modifier_winter_wyvern_18","#modifier_winter_wyvern_18", 3, "winter_wyvern/18", {}},
				{"empty_9"},
				{"modifier_woda_talent_int4", "#woda_talent_int4", 1, "int4", {"modifier_woda_talent_kaya",1}}
			},
			[5] = {
				{"modifier_woda_talent_spellprism", "#woda_talent_spellprism", 3, "spellprism", {}},
				{"empty_10"},
				{"empty_11"},
				{"modifier_winter_wyvern_20","#modifier_winter_wyvern_20", 3, "winter_wyvern/20", {}},
				{"modifier_woda_talent_int5", "#woda_talent_int5", 3, "int5", {"modifier_woda_talent_int4",1}}
			},
			[6] = {
				{"modifier_woda_talent_timeless", "#woda_talent_timeless", 2, "timeless", {}},
				{"modifier_woda_talent_regenmp2", "#woda_talent_regenmp2", 3, "regenmp2", {}},
				{"empty_14"},
				{"empty_15"},
				{"modifier_winter_wyvern_19","#modifier_winter_wyvern_19", 1, "winter_wyvern/19", {}}
			},
			[7] = {
				{"empty_17"},
				{"empty_18"},
				{"modifier_winter_wyvern_21","#modifier_winter_wyvern_21", 1, "winter_wyvern/21", {}},
				{"empty_20"},
				{"empty_21"}
			}
		}
	},
	["npc_dota_hero_axe"] = {
		[1] = {
			[1] = {
				{"modifier_woda_talent_hp1", "#woda_talent_hp1", 3, "hp1", {}},
				{"modifier_woda_talent_regenhp1", "#woda_talent_regenhp1", 2, "regenhp1", {}},
				{"modifier_woda_talent_attack1", "#woda_talent_attack1", 3, "attack1", {}},
				{"modifier_axe_1","#modifier_axe_1", 2, "axe/1", {}},
				{"modifier_woda_talent_str3", "#woda_talent_str3", 2, "str3", {}}
			},
			[2] = {
				{"empty_2"},
				{"modifier_axe_2","#modifier_axe_2", 1, "axe/2", {}},
				{"empty_3"},
				{"modifier_woda_talent_cloak", "#woda_talent_cloak", 2, "cloak", {}},
				{"modifier_woda_talent_str6", "#woda_talent_str6", 1, "str6", {"modifier_woda_talent_str3",2}}
			},
			[3] = {
				{"empty_6"},
				{"modifier_woda_talent_quickhp", "#woda_talent_quickhp", 2, "quickhp", {}},
				{"empty_7"},
				{"modifier_axe_3","#modifier_axe_3", 3, "axe/3", {}},
				{"modifier_woda_talent_sasha", "#woda_talent_sasha", 1, "sasha", {"modifier_woda_talent_str6",1}}
			},
			[4] = {
				{"modifier_woda_talent_hp2", "#woda_talent_hp2", 3, "hp2", {"modifier_woda_talent_hp1",3}},
				{"empty_9"},
				{"modifier_axe_4","#modifier_axe_4", 3, "axe/4", {}},
				{"modifier_woda_talent_octar", "#woda_talent_octar", 2, "octar", {}},
				{"modifier_woda_talent_str4", "#woda_talent_str4", 1, "str4", {"modifier_woda_talent_sasha",1}}
			},
			[5] = {
				{"modifier_woda_talent_armor2", "#woda_talent_armor2", 3, "armor2", {}},
				{"empty_10"},
				{"modifier_axe_5","#modifier_axe_5", 3, "axe/5", {}},
				{"empty_11"},
				{"modifier_woda_talent_str5", "#woda_talent_str5", 3, "str5", {"modifier_woda_talent_str4",1}}
			},
			[6] = {
				{"modifier_woda_talent_sliver", "#woda_talent_sliver", 2, "sliver", {}},
				{"modifier_woda_talent_regenhp2", "#woda_talent_regenhp2", 3, "regenhp2", {}},
				{"modifier_axe_6","#modifier_axe_6", 1, "axe/6", {}},
				{"empty_15"},
				{"empty_16"}
			},
			[7] = {
				{"empty_17"},
				{"empty_18"},
				{"modifier_axe_7","#modifier_axe_7", 1, "axe/7", {}},
				{"empty_20"},
				{"empty_21"}
			}
		},
		[2] = {
			[1] = {
				{"modifier_woda_talent_armor1", "#woda_talent_armor1", 3, "armor1", {}},
				{"modifier_woda_talent_speed1", "#woda_talent_speed1", 2, "speed1", {}},
				{"modifier_woda_talent_attackspeed1", "#woda_talent_attackspeed1", 3, "attackspeed1", {}},
				{"modifier_axe_8","#modifier_axe_8", 1, "axe/8", {}},
				{"modifier_woda_talent_agi3", "#woda_talent_agi3", 2, "agi3", {}}
			},
			[2] = {
				{"modifier_axe_9","#modifier_axe_9", 3, "axe/9", {}},
				{"empty_3"},
				{"empty_4"},
				{"modifier_woda_talent_miss1", "#woda_talent_miss1", 2, "miss1", {}},
				{"modifier_woda_talent_agi6", "#woda_talent_agi6", 1, "agi6", {"modifier_woda_talent_agi3",2}}
			},
			[3] = {
				{"modifier_axe_10","#modifier_axe_10", 2, "axe/10", {"modifier_axe_9",3}},
				{"empty_7"},
				{"empty_8"},
				{"modifier_woda_talent_mask1", "#woda_talent_mask1", 2, "mask1", {}},
				{"modifier_woda_talent_yasha", "#woda_talent_yasha", 1, "yasha", {"modifier_woda_talent_agi6",1}}
			},
			[4] = {
				{"modifier_axe_11","#modifier_axe_11", 1, "axe/11", {"modifier_axe_10",2}},
				{"modifier_woda_talent_speed2", "#woda_talent_speed2", 3, "speed2", {"modifier_woda_talent_speed1",2}},
				{"modifier_woda_talent_grovebow", "#woda_talent_grovebow", 2, "grovebow", {}},
				{"empty_10"},			
				{"modifier_woda_talent_agi4", "#woda_talent_agi4", 1, "agi4", {"modifier_woda_talent_yasha",1}}
			},
			[5] = {
				{"modifier_woda_talent_attack2", "#woda_talent_attack2", 3, "attack2", {}},
				{"empty_13"},
				{"empty_11"},
				{"modifier_axe_13","#modifier_axe_13", 3, "axe/13", {}},
				{"modifier_woda_talent_agi5", "#woda_talent_agi5", 3, "agi5", {"modifier_woda_talent_agi4",1}}
			},
			[6] = {
				{"modifier_woda_talent_miss2", "#woda_talent_miss2", 2, "miss2", {}},
				{"modifier_axe_12","#modifier_axe_12", 3, "axe/12", {}},
				{"modifier_woda_talent_attackspeed2", "#woda_talent_attackspeed2", 3, "attackspeed2", {}},
				{"empty_15"},
				{"empty_12"}
			},
			[7] = {
				{"empty_17"},
				{"empty_18"},
				{"modifier_axe_14","#modifier_axe_14", 1, "axe/14", {}},
				{"empty_20"},
				{"empty_21"}
			}
		},
		[3] = {
			[1] = {
				{"modifier_woda_talent_mp1", "#woda_talent_mp1", 3, "mp1", {}},
				{"modifier_woda_talent_regenmp1", "#woda_talent_regenmp1", 2, "regenmp1", {}},
				{"modifier_woda_talent_spell", "#woda_talent_spell", 3, "spell", {}},
				{"modifier_axe_15","#modifier_axe_15", 2, "axe/15", {}},
				{"modifier_woda_talent_int3", "#woda_talent_int3", 2, "int3", {}}
			},
			[2] = {
				{"empty_2"},
				{"empty_3"},
				{"modifier_axe_16","#modifier_axe_16", 3, "axe/16", {}},
				{"modifier_woda_talent_blood", "#woda_talent_blood", 2, "blood", {}},
				{"modifier_woda_talent_int6", "#woda_talent_int6", 1, "int6", {"modifier_woda_talent_int3",2}}
			},
			[3] = {
				{"empty_6"},
				{"empty_7"},
				{"modifier_axe_18","#modifier_axe_18", 1, "axe/18", {}},
				{"modifier_woda_talent_mask2", "#woda_talent_mask2", 2, "mask2", {}},
				{"modifier_woda_talent_kaya", "#woda_talent_kaya", 1, "kaya", {"modifier_woda_talent_int6",1}}
			},
			[4] = {
				{"modifier_woda_talent_mp2", "#woda_talent_mp2", 3, "mp2", {"modifier_woda_talent_mp1",3}},
				{"modifier_woda_talent_fairy", "#woda_talent_fairy", 2, "fairy", {}},
				{"modifier_axe_17","#modifier_axe_17", 2, "axe/17", {}},
				{"empty_9"},
				{"modifier_woda_talent_int4", "#woda_talent_int4", 1, "int4", {"modifier_woda_talent_kaya",1}}
			},
			[5] = {
				{"modifier_woda_talent_spellprism", "#woda_talent_spellprism", 3, "spellprism", {}},
				{"empty_10"},
				{"empty_11"},
				{"modifier_axe_19","#modifier_axe_19", 3, "axe/19", {}},
				{"modifier_woda_talent_int5", "#woda_talent_int5", 3, "int5", {"modifier_woda_talent_int4",1}}
			},
			[6] = {
				{"modifier_woda_talent_timeless", "#woda_talent_timeless", 2, "timeless", {}},
				{"modifier_woda_talent_regenmp2", "#woda_talent_regenmp2", 3, "regenmp2", {}},
				{"empty_14"},
				{"empty_15"},
				{"modifier_axe_20","#modifier_axe_20", 2, "axe/20", {}}
			},
			[7] = {
				{"empty_17"},
				{"empty_18"},
				{"modifier_axe_21","#modifier_axe_21", 1, "axe/21", {}},
				{"empty_20"},
				{"empty_21"}
			}
		}
	},
	["npc_dota_hero_lina"] = {
		[1] = {
			[1] = {
				{"modifier_woda_talent_hp1", "#woda_talent_hp1", 3, "hp1", {}},
				{"modifier_woda_talent_regenhp1", "#woda_talent_regenhp1", 2, "regenhp1", {}},
				{"modifier_woda_talent_attack1", "#woda_talent_attack1", 3, "attack1", {}},
				{"modifier_lina_1","#modifier_lina_1", 3, "lina/1", {}},
				{"modifier_woda_talent_str3", "#woda_talent_str3", 2, "str3", {}}
			},
			[2] = {
				{"empty_2"},
				{"empty_3"},
				{"modifier_woda_talent_cloak", "#woda_talent_cloak", 2, "cloak", {}},
				{"modifier_lina_2","#modifier_lina_2", 2, "lina/2", {"modifier_lina_1",3}},
				{"modifier_woda_talent_str6", "#woda_talent_str6", 1, "str6", {"modifier_woda_talent_str3",2}}
			},
			[3] = {
				{"empty_6"},
				{"modifier_woda_talent_quickhp", "#woda_talent_quickhp", 2, "quickhp", {}},
				{"empty_7"},
				{"modifier_lina_3","#modifier_lina_3", 3, "lina/3", {"modifier_lina_2",2}},
				{"modifier_woda_talent_sasha", "#woda_talent_sasha", 1, "sasha", {"modifier_woda_talent_str6",1}}
			},
			[4] = {
				{"modifier_woda_talent_hp2", "#woda_talent_hp2", 3, "hp2", {"modifier_woda_talent_hp1",3}},
				{"empty_9"},
				{"modifier_lina_6","#modifier_lina_6", 2, "lina/6", {}},
				{"modifier_woda_talent_octar", "#woda_talent_octar", 2, "octar", {}},
				{"modifier_woda_talent_str4", "#woda_talent_str4", 1, "str4", {"modifier_woda_talent_sasha",1}}
			},
			[5] = {
				{"modifier_woda_talent_armor2", "#woda_talent_armor2", 3, "armor2", {}},
				{"empty_11"},
				{"modifier_lina_5","#modifier_lina_5", 1, "lina/5", {}},
				{"empty_12"},
				{"modifier_woda_talent_str5", "#woda_talent_str5", 3, "str5", {"modifier_woda_talent_str4",1}}
			},
			[6] = {
				{"modifier_woda_talent_sliver", "#woda_talent_sliver", 2, "sliver", {}},
				{"modifier_woda_talent_regenhp2", "#woda_talent_regenhp2", 3, "regenhp2", {}},
				{"modifier_lina_4","#modifier_lina_4", 2, "lina/4", {}},
				{"empty_15"},
				{"empty_16"}
			},
			[7] = {
				{"empty_17"},
				{"empty_18"},
				{"modifier_lina_7","#modifier_lina_7", 1, "lina/7", {}},
				{"empty_20"},
				{"empty_21"}
			}
		},
		[2] = {
			[1] = {
				{"modifier_woda_talent_armor1", "#woda_talent_armor1", 3, "armor1", {}},
				{"modifier_woda_talent_speed1", "#woda_talent_speed1", 2, "speed1", {}},
				{"modifier_woda_talent_attackspeed1", "#woda_talent_attackspeed1", 3, "attackspeed1", {}},
				{"modifier_lina_8","#modifier_lina_8", 3, "lina/8", {}},
				{"modifier_woda_talent_agi3", "#woda_talent_agi3", 2, "agi3", {}}
			},
			[2] = {
				{"modifier_lina_9","#modifier_lina_9", 2, "lina/9", {}},
				{"empty_3"},
				{"empty_4"},
				{"modifier_woda_talent_miss1", "#woda_talent_miss1", 2, "miss1", {}},
				{"modifier_woda_talent_agi6", "#woda_talent_agi6", 1, "agi6", {"modifier_woda_talent_agi3",2}}
			},
			[3] = {
				{"empty_7"},
				{"empty_8"},
				{"modifier_lina_10","#modifier_lina_10", 2, "lina/10", {}},
				{"modifier_woda_talent_mask1", "#woda_talent_mask1", 2, "mask1", {}},
				{"modifier_woda_talent_yasha", "#woda_talent_yasha", 1, "yasha", {"modifier_woda_talent_agi6",1}}
			},
			[4] = {
				{"modifier_lina_11","#modifier_lina_11", 3, "lina/11", {}},
				{"modifier_woda_talent_speed2", "#woda_talent_speed2", 3, "speed2", {"modifier_woda_talent_speed1",2}},
				{"modifier_woda_talent_grovebow", "#woda_talent_grovebow", 2, "grovebow", {}},
				{"empty_10"},			
				{"modifier_woda_talent_agi4", "#woda_talent_agi4", 1, "agi4", {"modifier_woda_talent_yasha",1}}
			},
			[5] = {
				{"modifier_woda_talent_attack2", "#woda_talent_attack2", 3, "attack2", {}},
				{"empty_11"},
				{"empty_12"},
				{"modifier_lina_12","#modifier_lina_12", 1, "lina/12", {}},
				{"modifier_woda_talent_agi5", "#woda_talent_agi5", 3, "agi5", {"modifier_woda_talent_agi4",1}}
			},
			[6] = {
				{"modifier_woda_talent_miss2", "#woda_talent_miss2", 2, "miss2", {}},
				{"empty_13"},
				{"modifier_woda_talent_attackspeed2", "#woda_talent_attackspeed2", 3, "attackspeed2", {}},
				{"modifier_lina_13","#modifier_lina_13", 2, "lina/13", {"modifier_lina_12",1}},
				{"empty_16"}
			},
			[7] = {
				{"empty_17"},
				{"empty_18"},
				{"modifier_lina_14","#modifier_lina_14", 1, "lina/14", {}},
				{"empty_20"},
				{"empty_21"}
			}
		},
		[3] = {
			[1] = {
				{"modifier_woda_talent_mp1", "#woda_talent_mp1", 3, "mp1", {}},
				{"modifier_woda_talent_regenmp1", "#woda_talent_regenmp1", 2, "regenmp1", {}},
				{"modifier_woda_talent_spell", "#woda_talent_spell", 3, "spell", {}},
				{"modifier_lina_15","#modifier_lina_15", 2, "lina/15", {}},
				{"modifier_woda_talent_int3", "#woda_talent_int3", 2, "int3", {}}
			},
			[2] = {
				{"empty_2"},
				{"empty_3"},
				{"modifier_lina_16","#modifier_lina_16", 2, "lina/16", {}},
				{"modifier_woda_talent_blood", "#woda_talent_blood", 2, "blood", {}},
				{"modifier_woda_talent_int6", "#woda_talent_int6", 1, "int6", {"modifier_woda_talent_int3",2}}
			},
			[3] = {
				{"empty_6"},
				{"modifier_lina_17","#modifier_lina_17", 2, "lina/17", {}},
				{"empty_7"},
				{"modifier_woda_talent_mask2", "#woda_talent_mask2", 2, "mask2", {}},
				{"modifier_woda_talent_kaya", "#woda_talent_kaya", 1, "kaya", {"modifier_woda_talent_int6",1}}
			},
			[4] = {
				{"modifier_woda_talent_mp2", "#woda_talent_mp2", 3, "mp2", {"modifier_woda_talent_mp1",3}},
				{"modifier_woda_talent_fairy", "#woda_talent_fairy", 2, "fairy", {}},
				{"modifier_lina_19","#modifier_lina_19", 2, "lina/19", {}},
				{"empty_9"},
				{"modifier_woda_talent_int4", "#woda_talent_int4", 1, "int4", {"modifier_woda_talent_kaya",1}}
			},
			[5] = {
				{"modifier_woda_talent_spellprism", "#woda_talent_spellprism", 3, "spellprism", {}},
				{"empty_10"},
				{"modifier_lina_18","#modifier_lina_18", 2, "lina/18", {}},
				{"empty_11"},
				{"modifier_woda_talent_int5", "#woda_talent_int5", 3, "int5", {"modifier_woda_talent_int4",1}}
			},
			[6] = {
				{"modifier_woda_talent_timeless", "#woda_talent_timeless", 2, "timeless", {}},
				{"modifier_woda_talent_regenmp2", "#woda_talent_regenmp2", 3, "regenmp2", {}},
				{"empty_14"},
				{"modifier_lina_20","#modifier_lina_20", 3, "lina/20", {}},
				{"empty_16"}
			},
			[7] = {
				{"empty_17"},
				{"empty_18"},
				{"modifier_lina_21","#modifier_lina_21", 1, "lina/21", {}},
				{"empty_20"},
				{"empty_21"}
			}
		}
	},
	["npc_dota_hero_void_spirit"] = {
		[1] = {
			[1] = {
				{"modifier_woda_talent_hp1", "#woda_talent_hp1", 3, "hp1", {}},
				{"modifier_woda_talent_regenhp1", "#woda_talent_regenhp1", 2, "regenhp1", {}},
				{"modifier_woda_talent_attack1", "#woda_talent_attack1", 3, "attack1", {}},
				{"modifier_void_spirit_1","#modifier_void_spirit_1", 1, "void_spirit/1", {}},
				{"modifier_woda_talent_str3", "#woda_talent_str3", 2, "str3", {}}
			},
			[2] = {
				{"empty_2"},
				{"empty_3"},
				{"modifier_void_spirit_2","#modifier_void_spirit_2", 3, "void_spirit/2", {}},
				{"modifier_woda_talent_cloak", "#woda_talent_cloak", 2, "cloak", {}},
				{"modifier_woda_talent_str6", "#woda_talent_str6", 1, "str6", {"modifier_woda_talent_str3",2}}
			},
			[3] = {
				{"empty_6"},
				{"modifier_woda_talent_quickhp", "#woda_talent_quickhp", 2, "quickhp", {}},
				{"modifier_void_spirit_3","#modifier_void_spirit_3", 3, "void_spirit/3", {}},
				{"empty_8"},
				{"modifier_woda_talent_sasha", "#woda_talent_sasha", 1, "sasha", {"modifier_woda_talent_str6",1}}
			},
			[4] = {
				{"modifier_woda_talent_hp2", "#woda_talent_hp2", 3, "hp2", {"modifier_woda_talent_hp1",3}},
				{"empty_9"},
				{"modifier_void_spirit_4","#modifier_void_spirit_4", 1, "void_spirit/4", {}},
				{"modifier_woda_talent_octar", "#woda_talent_octar", 2, "octar", {}},
				{"modifier_woda_talent_str4", "#woda_talent_str4", 1, "str4", {"modifier_woda_talent_sasha",1}}
			},
			[5] = {
				{"modifier_woda_talent_armor2", "#woda_talent_armor2", 3, "armor2", {}},
				{"empty_11"},
				{"empty_12"},
				{"modifier_void_spirit_5","#modifier_void_spirit_5", 3, "void_spirit/5", {}},
				{"modifier_woda_talent_str5", "#woda_talent_str5", 3, "str5", {"modifier_woda_talent_str4",1}}
			},
			[6] = {
				{"modifier_woda_talent_sliver", "#woda_talent_sliver", 2, "sliver", {}},
				{"modifier_woda_talent_regenhp2", "#woda_talent_regenhp2", 3, "regenhp2", {}},
				{"modifier_void_spirit_6","#modifier_void_spirit_6", 2, "void_spirit/6", {}},
				{"empty_15"},
				{"empty_16"}
			},
			[7] = {
				{"empty_17"},
				{"empty_18"},
				{"modifier_void_spirit_7","#modifier_void_spirit_7", 1, "void_spirit/7", {}},
				{"empty_20"},
				{"empty_21"}
			}
		},
		[2] = {
			[1] = {
				{"modifier_woda_talent_armor1", "#woda_talent_armor1", 3, "armor1", {}},
				{"modifier_woda_talent_speed1", "#woda_talent_speed1", 2, "speed1", {}},
				{"modifier_woda_talent_attackspeed1", "#woda_talent_attackspeed1", 3, "attackspeed1", {}},
				{"modifier_void_spirit_8","#modifier_void_spirit_8", 2, "void_spirit/8", {}},
				{"modifier_woda_talent_agi3", "#woda_talent_agi3", 2, "agi3", {}}
			},
			[2] = {
				{"empty_2"},
				{"empty_3"},
				{"modifier_void_spirit_9","#modifier_void_spirit_9", 2, "void_spirit/9", {}},
				{"modifier_woda_talent_miss1", "#woda_talent_miss1", 2, "miss1", {}},
				{"modifier_woda_talent_agi6", "#woda_talent_agi6", 1, "agi6", {"modifier_woda_talent_agi3",2}}
			},
			[3] = {
				{"empty_6"},
				{"empty_7"},
				{"modifier_void_spirit_10","#modifier_void_spirit_10", 1, "void_spirit/10", {}},
				{"modifier_woda_talent_mask1", "#woda_talent_mask1", 2, "mask1", {}},
				{"modifier_woda_talent_yasha", "#woda_talent_yasha", 1, "yasha", {"modifier_woda_talent_agi6",1}}
			},
			[4] = {
				{"modifier_void_spirit_11","#modifier_void_spirit_11", 2, "void_spirit/11", {}},
				{"modifier_woda_talent_speed2", "#woda_talent_speed2", 3, "speed2", {"modifier_woda_talent_speed1",2}},
				{"modifier_woda_talent_grovebow", "#woda_talent_grovebow", 2, "grovebow", {}},
				{"empty_10"},			
				{"modifier_woda_talent_agi4", "#woda_talent_agi4", 1, "agi4", {"modifier_woda_talent_yasha",1}}
			},
			[5] = {
				{"modifier_woda_talent_attack2", "#woda_talent_attack2", 3, "attack2", {}},
				{"empty_11"},
				{"empty_12"},
				{"modifier_void_spirit_12","#modifier_void_spirit_12", 3, "void_spirit/12", {}},
				{"modifier_woda_talent_agi5", "#woda_talent_agi5", 3, "agi5", {"modifier_woda_talent_agi4",1}}
			},
			[6] = {
				{"modifier_woda_talent_miss2", "#woda_talent_miss2", 2, "miss2", {}},
				{"empty_13"},
				{"modifier_woda_talent_attackspeed2", "#woda_talent_attackspeed2", 3, "attackspeed2", {}},
				{"modifier_void_spirit_13","#modifier_void_spirit_13", 3, "void_spirit/13", {}},
				{"empty_16"}
			},
			[7] = {
				{"empty_17"},
				{"empty_18"},
				{"modifier_void_spirit_14","#modifier_void_spirit_14", 1, "void_spirit/14", {}},
				{"empty_20"},
				{"empty_21"}
			}
		},
		[3] = {
			[1] = {
				{"modifier_woda_talent_mp1", "#woda_talent_mp1", 3, "mp1", {}},
				{"modifier_woda_talent_regenmp1", "#woda_talent_regenmp1", 2, "regenmp1", {}},
				{"modifier_woda_talent_spell", "#woda_talent_spell", 3, "spell", {}},
				{"modifier_void_spirit_15","#modifier_void_spirit_15", 3, "void_spirit/15", {}},
				{"modifier_woda_talent_int3", "#woda_talent_int3", 2, "int3", {}}
			},
			[2] = {
				{"empty_2"},
				{"modifier_void_spirit_16","#modifier_void_spirit_16", 2, "void_spirit/16", {}},
				{"empty_3"},
				{"modifier_woda_talent_blood", "#woda_talent_blood", 2, "blood", {}},
				{"modifier_woda_talent_int6", "#woda_talent_int6", 1, "int6", {"modifier_woda_talent_int3",2}}
			},
			[3] = {
				{"empty_6"},
				{"modifier_void_spirit_17","#modifier_void_spirit_17", 1, "void_spirit/17", {}},
				{"empty_7"},
				{"modifier_woda_talent_mask2", "#woda_talent_mask2", 2, "mask2", {}},
				{"modifier_woda_talent_kaya", "#woda_talent_kaya", 1, "kaya", {"modifier_woda_talent_int6",1}}
			},
			[4] = {
				{"modifier_woda_talent_mp2", "#woda_talent_mp2", 3, "mp2", {"modifier_woda_talent_mp1",3}},
				{"modifier_woda_talent_fairy", "#woda_talent_fairy", 2, "fairy", {}},
				{"empty_9"},
				{"modifier_void_spirit_18","#modifier_void_spirit_18", 3, "void_spirit/18", {}},
				{"modifier_woda_talent_int4", "#woda_talent_int4", 1, "int4", {"modifier_woda_talent_kaya",1}}
			},
			[5] = {
				{"modifier_woda_talent_spellprism", "#woda_talent_spellprism", 3, "spellprism", {}},
				{"empty_10"},
				{"empty_11"},
				{"modifier_void_spirit_20","#modifier_void_spirit_20", 3, "void_spirit/20", {}},
				{"modifier_woda_talent_int5", "#woda_talent_int5", 3, "int5", {"modifier_woda_talent_int4",1}}
			},
			[6] = {
				{"modifier_woda_talent_timeless", "#woda_talent_timeless", 2, "timeless", {}},
				{"modifier_woda_talent_regenmp2", "#woda_talent_regenmp2", 3, "regenmp2", {}},
				{"modifier_void_spirit_19","#modifier_void_spirit_19", 1, "void_spirit/19", {}},
				{"empty_15"},
				{"empty_16"}
			},
			[7] = {
				{"empty_17"},
				{"empty_18"},
				{"modifier_void_spirit_21","#modifier_void_spirit_21", 1, "void_spirit/21", {}},
				{"empty_20"},
				{"empty_21"}
			}
		}
	},
	["npc_dota_hero_phoenix"] = {
		[1] = {
			[1] = {
				{"modifier_woda_talent_hp1", "#woda_talent_hp1", 3, "hp1", {}},
				{"modifier_woda_talent_regenhp1", "#woda_talent_regenhp1", 2, "regenhp1", {}},
				{"modifier_phoenix_1","#modifier_phoenix_1", 2, "phoenix/1", {}},
				{"modifier_woda_talent_attack1", "#woda_talent_attack1", 3, "attack1", {}},
				{"modifier_woda_talent_str3", "#woda_talent_str3", 2, "str3", {}}
			},
			[2] = {
				{"empty_2"},
				{"empty_3"},
				{"modifier_phoenix_2","#modifier_phoenix_2", 2, "phoenix/2", {}},
				{"modifier_woda_talent_cloak", "#woda_talent_cloak", 2, "cloak", {}},
				{"modifier_woda_talent_str6", "#woda_talent_str6", 1, "str6", {"modifier_woda_talent_str3",2}}
			},
			[3] = {
				{"empty_6"},
				{"modifier_woda_talent_quickhp", "#woda_talent_quickhp", 2, "quickhp", {}},
				{"empty_7"},
				{"modifier_phoenix_4","#modifier_phoenix_4", 2, "phoenix/4", {}},
				{"modifier_woda_talent_sasha", "#woda_talent_sasha", 1, "sasha", {"modifier_woda_talent_str6",1}}
			},
			[4] = {
				{"modifier_woda_talent_hp2", "#woda_talent_hp2", 3, "hp2", {"modifier_woda_talent_hp1",3}},
				{"modifier_phoenix_3","#modifier_phoenix_3", 3, "phoenix/3", {}},
				{"empty_9"},
				{"modifier_woda_talent_octar", "#woda_talent_octar", 2, "octar", {}},
				{"modifier_woda_talent_str4", "#woda_talent_str4", 1, "str4", {"modifier_woda_talent_sasha",1}}
			},
			[5] = {
				{"modifier_woda_talent_armor2", "#woda_talent_armor2", 3, "armor2", {}},
				{"empty_10"},
				{"empty_11"},
				{"modifier_phoenix_5","#modifier_phoenix_5", 3, "phoenix/5", {}},
				{"modifier_woda_talent_str5", "#woda_talent_str5", 3, "str5", {"modifier_woda_talent_str4",1}}
			},
			[6] = {
				{"modifier_woda_talent_sliver", "#woda_talent_sliver", 2, "sliver", {}},
				{"modifier_woda_talent_regenhp2", "#woda_talent_regenhp2", 3, "regenhp2", {}},
				{"modifier_phoenix_6","#modifier_phoenix_6", 1, "phoenix/6", {}},
				{"empty_15"},
				{"empty_16"}
			},
			[7] = {
				{"empty_17"},
				{"empty_18"},
				{"modifier_phoenix_7","#modifier_phoenix_7", 1, "phoenix/7", {}},
				{"empty_20"},
				{"empty_21"}
			}
		},
		[2] = {
			[1] = {
				{"modifier_woda_talent_armor1", "#woda_talent_armor1", 3, "armor1", {}},
				{"modifier_woda_talent_speed1", "#woda_talent_speed1", 2, "speed1", {}},
				{"modifier_woda_talent_attackspeed1", "#woda_talent_attackspeed1", 3, "attackspeed1", {}},
				{"modifier_phoenix_8","#modifier_phoenix_8", 2, "phoenix/8", {}},
				{"modifier_woda_talent_agi3", "#woda_talent_agi3", 2, "agi3", {}}
			},
			[2] = {
				{"empty_2"},
				{"empty_3"},
				{"modifier_phoenix_9","#modifier_phoenix_9", 3, "phoenix/9", {}},
				{"modifier_woda_talent_miss1", "#woda_talent_miss1", 2, "miss1", {}},
				{"modifier_woda_talent_agi6", "#woda_talent_agi6", 1, "agi6", {"modifier_woda_talent_agi3",2}}
			},
			[3] = {
				{"empty_6"},
				{"empty_7"},
				{"modifier_phoenix_10","#modifier_phoenix_10", 2, "phoenix/10", {}},
				{"modifier_woda_talent_mask1", "#woda_talent_mask1", 2, "mask1", {}},
				{"modifier_woda_talent_yasha", "#woda_talent_yasha", 1, "yasha", {"modifier_woda_talent_agi6",1}}
			},
			[4] = {
				{"empty_8"},
				{"modifier_woda_talent_speed2", "#woda_talent_speed2", 3, "speed2", {"modifier_woda_talent_speed1",2}},
				{"modifier_woda_talent_grovebow", "#woda_talent_grovebow", 2, "grovebow", {}},
				{"modifier_phoenix_11","#modifier_phoenix_11", 1, "phoenix/11", {}},			
				{"modifier_woda_talent_agi4", "#woda_talent_agi4", 1, "agi4", {"modifier_woda_talent_yasha",1}}
			},
			[5] = {
				{"modifier_woda_talent_attack2", "#woda_talent_attack2", 3, "attack2", {}},
				{"modifier_phoenix_12","#modifier_phoenix_12", 3, "phoenix/12", {}},
				{"empty_11"},
				{"empty_12"},
				{"modifier_woda_talent_agi5", "#woda_talent_agi5", 3, "agi5", {"modifier_woda_talent_agi4",1}}
			},
			[6] = {
				{"modifier_woda_talent_miss2", "#woda_talent_miss2", 2, "miss2", {}},
				{"empty_13"},
				{"modifier_woda_talent_attackspeed2", "#woda_talent_attackspeed2", 3, "attackspeed2", {}},
				{"empty_14"},
				{"modifier_phoenix_13","#modifier_phoenix_13", 2, "phoenix/13", {}}
			},
			[7] = {
				{"empty_17"},
				{"empty_18"},
				{"modifier_phoenix_14","#modifier_phoenix_14", 1, "phoenix/14", {}},
				{"empty_20"},
				{"empty_21"}
			}
		},
		[3] = {
			[1] = {
				{"modifier_woda_talent_mp1", "#woda_talent_mp1", 3, "mp1", {}},
				{"modifier_woda_talent_regenmp1", "#woda_talent_regenmp1", 2, "regenmp1", {}},
				{"modifier_phoenix_15","#modifier_phoenix_15", 3, "phoenix/15", {}},
				{"modifier_woda_talent_spell", "#woda_talent_spell", 3, "spell", {}},
				{"modifier_woda_talent_int3", "#woda_talent_int3", 2, "int3", {}}
			},
			[2] = {
				{"empty_2"},
				{"empty_3"},
				{"modifier_phoenix_16","#modifier_phoenix_16", 2, "phoenix/16", {"modifier_phoenix_15",3}},
				{"modifier_woda_talent_blood", "#woda_talent_blood", 2, "blood", {}},
				{"modifier_woda_talent_int6", "#woda_talent_int6", 1, "int6", {"modifier_woda_talent_int3",2}}
			},
			[3] = {
				{"empty_6"},
				{"empty_7"},
				{"modifier_phoenix_17","#modifier_phoenix_17", 2, "phoenix/17", {"modifier_phoenix_16",2}},
				{"modifier_woda_talent_mask2", "#woda_talent_mask2", 2, "mask2", {}},
				{"modifier_woda_talent_kaya", "#woda_talent_kaya", 1, "kaya", {"modifier_woda_talent_int6",1}}
			},
			[4] = {
				{"modifier_woda_talent_mp2", "#woda_talent_mp2", 3, "mp2", {"modifier_woda_talent_mp1",3}},
				{"modifier_woda_talent_fairy", "#woda_talent_fairy", 2, "fairy", {}},
				{"modifier_phoenix_18","#modifier_phoenix_18", 1, "phoenix/18", {"modifier_phoenix_17",2}},
				{"empty_9"},
				{"modifier_woda_talent_int4", "#woda_talent_int4", 1, "int4", {"modifier_woda_talent_kaya",1}}
			},
			[5] = {
				{"modifier_woda_talent_spellprism", "#woda_talent_spellprism", 3, "spellprism", {}},
				{"empty_10"},
				{"modifier_phoenix_19","#modifier_phoenix_19", 2, "phoenix/19", {"modifier_phoenix_18",1}},
				{"empty_11"},
				{"modifier_woda_talent_int5", "#woda_talent_int5", 3, "int5", {"modifier_woda_talent_int4",1}}
			},
			[6] = {
				{"modifier_woda_talent_timeless", "#woda_talent_timeless", 2, "timeless", {}},
				{"modifier_woda_talent_regenmp2", "#woda_talent_regenmp2", 3, "regenmp2", {}},
				{"modifier_phoenix_20","#modifier_phoenix_20", 3, "phoenix/20", {"modifier_phoenix_19",2}},
				{"empty_15"},
				{"empty_16"}
			},
			[7] = {
				{"empty_17"},
				{"empty_18"},
				{"modifier_phoenix_21","#modifier_phoenix_21", 1, "phoenix/21", {}},
				{"empty_20"},
				{"empty_21"}
			}
		}
	},
	["npc_dota_hero_wisp"] = {
		[1] = {
			[1] = {
				{"modifier_woda_talent_hp1", "#woda_talent_hp1", 3, "hp1", {}},
				{"modifier_woda_talent_regenhp1", "#woda_talent_regenhp1", 2, "regenhp1", {}},
				{"modifier_wisp_1","#modifier_wisp_1", 1, "wisp/1", {}},
				{"modifier_woda_talent_attack1", "#woda_talent_attack1", 3, "attack1", {}},
				{"modifier_woda_talent_str3", "#woda_talent_str3", 2, "str3", {}}
			},
			[2] = {
				{"empty_2"},
				{"empty_3"},
				{"modifier_wisp_2","#modifier_wisp_2", 2, "wisp/2", {"modifier_wisp_1",1}},
				{"modifier_woda_talent_cloak", "#woda_talent_cloak", 2, "cloak", {}},
				{"modifier_woda_talent_str6", "#woda_talent_str6", 1, "str6", {"modifier_woda_talent_str3",2}}
			},
			[3] = {
				{"empty_6"},
				{"modifier_woda_talent_quickhp", "#woda_talent_quickhp", 2, "quickhp", {}},
				{"modifier_wisp_3","#modifier_wisp_3", 2, "wisp/3", {"modifier_wisp_2",2}},
				{"empty_7"},
				{"modifier_woda_talent_sasha", "#woda_talent_sasha", 1, "sasha", {"modifier_woda_talent_str6",1}}
			},
			[4] = {
				{"modifier_woda_talent_hp2", "#woda_talent_hp2", 3, "hp2", {"modifier_woda_talent_hp1",3}},
				{"modifier_wisp_4","#modifier_wisp_4", 3, "wisp/4", {}},
				{"empty_9"},
				{"modifier_woda_talent_octar", "#woda_talent_octar", 2, "octar", {}},
				{"modifier_woda_talent_str4", "#woda_talent_str4", 1, "str4", {"modifier_woda_talent_sasha",1}}
			},
			[5] = {
				{"modifier_woda_talent_armor2", "#woda_talent_armor2", 3, "armor2", {}},
				{"modifier_wisp_5","#modifier_wisp_5", 3, "wisp/5", {}},
				{"empty_11"},
				{"empty_12"},
				{"modifier_woda_talent_str5", "#woda_talent_str5", 3, "str5", {"modifier_woda_talent_str4",1}}
			},
			[6] = {
				{"modifier_woda_talent_sliver", "#woda_talent_sliver", 2, "sliver", {}},
				{"modifier_woda_talent_regenhp2", "#woda_talent_regenhp2", 3, "regenhp2", {}},
				{"modifier_wisp_6","#modifier_wisp_6", 2, "wisp/6", {"modifier_wisp_3",2}},
				{"empty_15"},
				{"empty_16"}
			},
			[7] = {
				{"empty_17"},
				{"empty_18"},
				{"modifier_wisp_7","#modifier_wisp_7", 1, "wisp/7", {}},
				{"empty_20"},
				{"empty_21"}
			}
		},
		[2] = {
			[1] = {
				{"modifier_woda_talent_armor1", "#woda_talent_armor1", 3, "armor1", {}},
				{"modifier_woda_talent_speed1", "#woda_talent_speed1", 2, "speed1", {}},
				{"modifier_woda_talent_attackspeed1", "#woda_talent_attackspeed1", 3, "attackspeed1", {}},
				{"modifier_wisp_8","#modifier_wisp_8", 2, "wisp/8", {}},
				{"modifier_woda_talent_agi3", "#woda_talent_agi3", 2, "agi3", {}}
			},
			[2] = {
				{"empty_2"},
				{"empty_3"},
				{"modifier_wisp_9","#modifier_wisp_9", 3, "wisp/9", {}},
				{"modifier_woda_talent_miss1", "#woda_talent_miss1", 2, "miss1", {}},
				{"modifier_woda_talent_agi6", "#woda_talent_agi6", 1, "agi6", {"modifier_woda_talent_agi3",2}}
			},
			[3] = {
				{"empty_6"},
				{"empty_7"},
				{"modifier_wisp_12","#modifier_wisp_12", 2, "wisp/12", {}},
				{"modifier_woda_talent_mask1", "#woda_talent_mask1", 2, "mask1", {}},
				{"modifier_woda_talent_yasha", "#woda_talent_yasha", 1, "yasha", {"modifier_woda_talent_agi6",1}}
			},
			[4] = {
				{"empty_9"},
				{"modifier_woda_talent_speed2", "#woda_talent_speed2", 3, "speed2", {"modifier_woda_talent_speed1",2}},
				{"modifier_woda_talent_grovebow", "#woda_talent_grovebow", 2, "grovebow", {}},
				{"modifier_wisp_10","#modifier_wisp_10", 2, "wisp/10", {}},			
				{"modifier_woda_talent_agi4", "#woda_talent_agi4", 1, "agi4", {"modifier_woda_talent_yasha",1}}
			},
			[5] = {
				{"modifier_woda_talent_attack2", "#woda_talent_attack2", 3, "attack2", {}},
				{"empty_10"},
				{"empty_11"},
				{"modifier_wisp_11","#modifier_wisp_11", 2, "wisp/11", {"modifier_wisp_10",2}},
				{"modifier_woda_talent_agi5", "#woda_talent_agi5", 3, "agi5", {"modifier_woda_talent_agi4",1}}
			},
			[6] = {
				{"modifier_woda_talent_miss2", "#woda_talent_miss2", 2, "miss2", {}},
				{"empty_13"},
				{"modifier_woda_talent_attackspeed2", "#woda_talent_attackspeed2", 3, "attackspeed2", {}},
				{"empty_14"},
				{"modifier_wisp_13","#modifier_wisp_13", 2, "wisp/13", {}}
			},
			[7] = {
				{"empty_17"},
				{"empty_18"},
				{"modifier_wisp_14","#modifier_wisp_14", 1, "wisp/14", {}},
				{"empty_20"},
				{"empty_21"}
			}
		},
		[3] = {
			[1] = {
				{"modifier_woda_talent_mp1", "#woda_talent_mp1", 3, "mp1", {}},
				{"modifier_woda_talent_regenmp1", "#woda_talent_regenmp1", 2, "regenmp1", {}},
				{"modifier_woda_talent_spell", "#woda_talent_spell", 3, "spell", {}},
				{"modifier_wisp_15","#modifier_wisp_15", 2, "wisp/15", {}},
				{"modifier_woda_talent_int3", "#woda_talent_int3", 2, "int3", {}}
			},
			[2] = {
				{"empty_2"},
				{"modifier_wisp_16","#modifier_wisp_16", 2, "wisp/16", {}},
				{"empty_3"},
				{"modifier_woda_talent_blood", "#woda_talent_blood", 2, "blood", {}},
				{"modifier_woda_talent_int6", "#woda_talent_int6", 1, "int6", {"modifier_woda_talent_int3",2}}
			},
			[3] = {
				{"empty_6"},
				{"modifier_wisp_17","#modifier_wisp_17", 2, "wisp/17", {}},
				{"empty_7"},
				{"modifier_woda_talent_mask2", "#woda_talent_mask2", 2, "mask2", {}},
				{"modifier_woda_talent_kaya", "#woda_talent_kaya", 1, "kaya", {"modifier_woda_talent_int6",1}}
			},
			[4] = {
				{"modifier_woda_talent_mp2", "#woda_talent_mp2", 3, "mp2", {"modifier_woda_talent_mp1",3}},
				{"modifier_woda_talent_fairy", "#woda_talent_fairy", 2, "fairy", {}},
				{"modifier_wisp_18","#modifier_wisp_18", 1, "wisp/18", {}},
				{"empty_9"},
				{"modifier_woda_talent_int4", "#woda_talent_int4", 1, "int4", {"modifier_woda_talent_kaya",1}}
			},
			[5] = {
				{"modifier_woda_talent_spellprism", "#woda_talent_spellprism", 3, "spellprism", {}},
				{"empty_10"},
				{"modifier_wisp_19","#modifier_wisp_19", 3, "wisp/19", {"modifier_wisp_18",1}},
				{"empty_11"},
				{"modifier_woda_talent_int5", "#woda_talent_int5", 3, "int5", {"modifier_woda_talent_int4",1}}
			},
			[6] = {
				{"modifier_woda_talent_timeless", "#woda_talent_timeless", 2, "timeless", {}},
				{"modifier_woda_talent_regenmp2", "#woda_talent_regenmp2", 3, "regenmp2", {}},
				{"modifier_wisp_20","#modifier_wisp_20", 3, "wisp/20", {}},
				{"empty_15"},
				{"empty_16"}
			},
			[7] = {
				{"empty_17"},
				{"empty_18"},
				{"modifier_wisp_21","#modifier_wisp_21", 1, "wisp/21", {}},
				{"empty_20"},
				{"empty_21"}
			}
		}
	},
	["npc_dota_hero_razor"] = {
		[1] = {
			[1] = {
				{"modifier_woda_talent_hp1", "#woda_talent_hp1", 3, "hp1", {}},
				{"modifier_woda_talent_regenhp1", "#woda_talent_regenhp1", 2, "regenhp1", {}},
				{"modifier_razor_1","#modifier_razor_1", 3, "razor/1", {}},
				{"modifier_woda_talent_attack1", "#woda_talent_attack1", 3, "attack1", {}},
				{"modifier_woda_talent_str3", "#woda_talent_str3", 2, "str3", {}}
			},
			[2] = {
				{"empty_2"},
				{"empty_3"},
				{"modifier_razor_2","#modifier_razor_2", 1, "razor/2", {"modifier_razor_1",3}},
				{"modifier_woda_talent_cloak", "#woda_talent_cloak", 2, "cloak", {}},
				{"modifier_woda_talent_str6", "#woda_talent_str6", 1, "str6", {"modifier_woda_talent_str3",2}}
			},
			[3] = {
				{"empty_6"},
				{"modifier_woda_talent_quickhp", "#woda_talent_quickhp", 2, "quickhp", {}},
				{"modifier_razor_3","#modifier_razor_3", 2, "razor/3", {"modifier_razor_2",1}},
				{"empty_8"},
				{"modifier_woda_talent_sasha", "#woda_talent_sasha", 1, "sasha", {"modifier_woda_talent_str6",1}}
			},
			[4] = {
				{"modifier_woda_talent_hp2", "#woda_talent_hp2", 3, "hp2", {"modifier_woda_talent_hp1",3}},
				{"empty_9"},
				{"modifier_razor_4","#modifier_razor_4", 3, "razor/4", {"modifier_razor_3",2}},
				{"modifier_woda_talent_octar", "#woda_talent_octar", 2, "octar", {}},
				{"modifier_woda_talent_str4", "#woda_talent_str4", 1, "str4", {"modifier_woda_talent_sasha",1}}
			},
			[5] = {
				{"modifier_woda_talent_armor2", "#woda_talent_armor2", 3, "armor2", {}},
				{"empty_10"},
				{"empty_11"},
				{"modifier_razor_5","#modifier_razor_5", 3, "razor/5", {}},
				{"modifier_woda_talent_str5", "#woda_talent_str5", 3, "str5", {"modifier_woda_talent_str4",1}}
			},
			[6] = {
				{"modifier_woda_talent_sliver", "#woda_talent_sliver", 2, "sliver", {}},
				{"modifier_woda_talent_regenhp2", "#woda_talent_regenhp2", 3, "regenhp2", {}},
				{"empty_15"},
				{"modifier_razor_6","#modifier_razor_6", 1, "razor/6", {}},
				{"empty_16"}
			},
			[7] = {
				{"empty_17"},
				{"empty_18"},
				{"modifier_razor_7","#modifier_razor_7", 1, "razor/7", {}},
				{"empty_20"},
				{"empty_21"}
			}
		},
		[2] = {
			[1] = {
				{"modifier_woda_talent_armor1", "#woda_talent_armor1", 3, "armor1", {}},
				{"modifier_woda_talent_speed1", "#woda_talent_speed1", 2, "speed1", {}},
				{"modifier_woda_talent_attackspeed1", "#woda_talent_attackspeed1", 3, "attackspeed1", {}},
				{"modifier_razor_8","#modifier_razor_8", 1, "razor/8", {}},
				{"modifier_woda_talent_agi3", "#woda_talent_agi3", 2, "agi3", {}}
			},
			[2] = {
				{"empty_2"},
				{"empty_3"},
				{"modifier_razor_9","#modifier_razor_9", 3, "razor/9", {}},
				{"modifier_woda_talent_miss1", "#woda_talent_miss1", 2, "miss1", {}},
				{"modifier_woda_talent_agi6", "#woda_talent_agi6", 1, "agi6", {"modifier_woda_talent_agi3",2}}
			},
			[3] = {
				{"empty_6"},
				{"empty_7"},
				{"modifier_razor_11","#modifier_razor_11", 2, "razor/11", {}},
				{"modifier_woda_talent_mask1", "#woda_talent_mask1", 2, "mask1", {}},
				{"modifier_woda_talent_yasha", "#woda_talent_yasha", 1, "yasha", {"modifier_woda_talent_agi6",1}}
			},
			[4] = {
				{"empty_8"},
				{"modifier_woda_talent_speed2", "#woda_talent_speed2", 3, "speed2", {"modifier_woda_talent_speed1",2}},
				{"modifier_woda_talent_grovebow", "#woda_talent_grovebow", 2, "grovebow", {}},
				{"modifier_razor_12","#modifier_razor_12", 3, "razor/12", {}},			
				{"modifier_woda_talent_agi4", "#woda_talent_agi4", 1, "agi4", {"modifier_woda_talent_yasha",1}}
			},
			[5] = {
				{"modifier_woda_talent_attack2", "#woda_talent_attack2", 3, "attack2", {}},
				{"empty_11"},
				{"modifier_razor_13","#modifier_razor_13", 1, "razor/13", {}},
				{"empty_12"},
				{"modifier_woda_talent_agi5", "#woda_talent_agi5", 3, "agi5", {"modifier_woda_talent_agi4",1}}
			},
			[6] = {
				{"modifier_woda_talent_miss2", "#woda_talent_miss2", 2, "miss2", {}},
				{"empty_13"},
				{"modifier_woda_talent_attackspeed2", "#woda_talent_attackspeed2", 3, "attackspeed2", {}},
				{"modifier_razor_10","#modifier_razor_10", 3, "razor/10", {}},
				{"empty_16"}
			},
			[7] = {
				{"empty_17"},
				{"empty_18"},
				{"modifier_razor_14","#modifier_razor_14", 1, "razor/14", {}},
				{"empty_20"},
				{"empty_21"}
			}
		},
		[3] = {
			[1] = {
				{"modifier_woda_talent_mp1", "#woda_talent_mp1", 3, "mp1", {}},
				{"modifier_woda_talent_regenmp1", "#woda_talent_regenmp1", 2, "regenmp1", {}},
				{"modifier_woda_talent_spell", "#woda_talent_spell", 3, "spell", {}},
				{"modifier_razor_15","#modifier_razor_15", 2, "razor/15", {}},
				{"modifier_woda_talent_int3", "#woda_talent_int3", 2, "int3", {}}
			},
			[2] = {
				{"empty_2"},
				{"modifier_razor_17","#modifier_razor_17", 2, "razor/17", {}},
				{"empty_3"},
				{"modifier_woda_talent_blood", "#woda_talent_blood", 2, "blood", {}},
				{"modifier_woda_talent_int6", "#woda_talent_int6", 1, "int6", {"modifier_woda_talent_int3",2}}
			},
			[3] = {
				{"empty_6"},
				{"empty_7"},
				{"modifier_razor_16","#modifier_razor_16", 3, "razor/16", {}},
				{"modifier_woda_talent_mask2", "#woda_talent_mask2", 2, "mask2", {}},
				{"modifier_woda_talent_kaya", "#woda_talent_kaya", 1, "kaya", {"modifier_woda_talent_int6",1}}
			},
			[4] = {
				{"modifier_woda_talent_mp2", "#woda_talent_mp2", 3, "mp2", {"modifier_woda_talent_mp1",3}},
				{"modifier_woda_talent_fairy", "#woda_talent_fairy", 2, "fairy", {}},
				{"empty_9"},
				{"modifier_razor_18","#modifier_razor_18", 3, "razor/18", {}},
				{"modifier_woda_talent_int4", "#woda_talent_int4", 1, "int4", {"modifier_woda_talent_kaya",1}}
			},
			[5] = {
				{"modifier_woda_talent_spellprism", "#woda_talent_spellprism", 3, "spellprism", {}},
				{"empty_10"},
				{"modifier_razor_19","#modifier_razor_19", 2, "razor/19", {}},
				{"empty_11"},
				{"modifier_woda_talent_int5", "#woda_talent_int5", 3, "int5", {"modifier_woda_talent_int4",1}}
			},
			[6] = {
				{"modifier_woda_talent_timeless", "#woda_talent_timeless", 2, "timeless", {}},
				{"modifier_woda_talent_regenmp2", "#woda_talent_regenmp2", 3, "regenmp2", {}},
				{"empty_14"},
				{"modifier_razor_20","#modifier_razor_20", 1, "razor/20", {}},
				{"empty_16"}
			},
			[7] = {
				{"empty_17"},
				{"empty_18"},
				{"modifier_razor_21","#modifier_razor_21", 1, "razor/21", {}},
				{"empty_20"},
				{"empty_21"}
			}
		}
	},
	["npc_dota_hero_sniper"] = {
		[1] = {
			[1] = {
				{"modifier_woda_talent_hp1", "#woda_talent_hp1", 3, "hp1", {}},
				{"modifier_woda_talent_regenhp1", "#woda_talent_regenhp1", 2, "regenhp1", {}},
				{"modifier_sniper_1","#modifier_sniper_1", 1, "sniper/1", {}},
				{"modifier_woda_talent_attack1", "#woda_talent_attack1", 3, "attack1", {}},
				{"modifier_woda_talent_str3", "#woda_talent_str3", 2, "str3", {}}
			},
			[2] = {
				{"empty_2"},
				{"empty_3"},
				{"modifier_sniper_2","#modifier_sniper_2", 3, "sniper/2", {"modifier_sniper_1",1}},
				{"modifier_woda_talent_cloak", "#woda_talent_cloak", 2, "cloak", {}},
				{"modifier_woda_talent_str6", "#woda_talent_str6", 1, "str6", {"modifier_woda_talent_str3",2}}
			},
			[3] = {
				{"empty_6"},
				{"modifier_woda_talent_quickhp", "#woda_talent_quickhp", 2, "quickhp", {}},
				{"empty_7"},
				{"modifier_sniper_3","#modifier_sniper_3", 3, "sniper/3", {}},
				{"modifier_woda_talent_sasha", "#woda_talent_sasha", 1, "sasha", {"modifier_woda_talent_str6",1}}
			},
			[4] = {
				{"modifier_woda_talent_hp2", "#woda_talent_hp2", 3, "hp2", {"modifier_woda_talent_hp1",3}},
				{"modifier_sniper_4","#modifier_sniper_4", 2, "sniper/4", {}},
				{"empty_10"},
				{"modifier_woda_talent_octar", "#woda_talent_octar", 2, "octar", {}},
				{"modifier_woda_talent_str4", "#woda_talent_str4", 1, "str4", {"modifier_woda_talent_sasha",1}}
			},
			[5] = {
				{"modifier_woda_talent_armor2", "#woda_talent_armor2", 3, "armor2", {}},
				{"empty_10"},
				{"modifier_sniper_5","#modifier_sniper_5", 2, "sniper/5", {"modifier_sniper_2",3}},
				{"empty_12"},
				{"modifier_woda_talent_str5", "#woda_talent_str5", 3, "str5", {"modifier_woda_talent_str4",1}}
			},
			[6] = {
				{"modifier_woda_talent_sliver", "#woda_talent_sliver", 2, "sliver", {}},
				{"modifier_woda_talent_regenhp2", "#woda_talent_regenhp2", 3, "regenhp2", {}},
				{"empty_15"},
				{"modifier_sniper_6","#modifier_sniper_6", 2, "sniper/6", {}},
				{"empty_16"}
			},
			[7] = {
				{"empty_17"},
				{"empty_18"},
				{"modifier_sniper_7","#modifier_sniper_7", 1, "sniper/7", {}},
				{"empty_20"},
				{"empty_21"}
			}
		},
		[2] = {
			[1] = {
				{"modifier_woda_talent_armor1", "#woda_talent_armor1", 3, "armor1", {}},
				{"modifier_woda_talent_speed1", "#woda_talent_speed1", 2, "speed1", {}},
				{"modifier_woda_talent_attackspeed1", "#woda_talent_attackspeed1", 3, "attackspeed1", {}},
				{"modifier_sniper_8","#modifier_sniper_8", 3, "sniper/8", {}},
				{"modifier_woda_talent_agi3", "#woda_talent_agi3", 2, "agi3", {}}
			},
			[2] = {
				{"empty_2"},
				{"empty_3"},
				{"modifier_sniper_9","#modifier_sniper_9", 2, "sniper/9", {}},
				{"modifier_woda_talent_miss1", "#woda_talent_miss1", 2, "miss1", {}},
				{"modifier_woda_talent_agi6", "#woda_talent_agi6", 1, "agi6", {"modifier_woda_talent_agi3",2}}
			},
			[3] = {
				{"empty_6"},
				{"empty_7"},
				{"modifier_sniper_10","#modifier_sniper_10", 1, "sniper/10", {}},
				{"modifier_woda_talent_mask1", "#woda_talent_mask1", 2, "mask1", {}},
				{"modifier_woda_talent_yasha", "#woda_talent_yasha", 1, "yasha", {"modifier_woda_talent_agi6",1}}
			},
			[4] = {
				{"empty_8"},
				{"modifier_woda_talent_speed2", "#woda_talent_speed2", 3, "speed2", {"modifier_woda_talent_speed1",2}},
				{"modifier_woda_talent_grovebow", "#woda_talent_grovebow", 2, "grovebow", {}},
				{"modifier_sniper_11","#modifier_sniper_11", 2, "sniper/11", {}},			
				{"modifier_woda_talent_agi4", "#woda_talent_agi4", 1, "agi4", {"modifier_woda_talent_yasha",1}}
			},
			[5] = {
				{"modifier_woda_talent_attack2", "#woda_talent_attack2", 3, "attack2", {}},
				{"modifier_sniper_12","#modifier_sniper_12", 2, "sniper/12", {}},
				{"empty_11"},
				{"empty_12"},
				{"modifier_woda_talent_agi5", "#woda_talent_agi5", 3, "agi5", {"modifier_woda_talent_agi4",1}}
			},
			[6] = {
				{"modifier_woda_talent_miss2", "#woda_talent_miss2", 2, "miss2", {}},
				{"empty_13"},
				{"modifier_woda_talent_attackspeed2", "#woda_talent_attackspeed2", 3, "attackspeed2", {}},
				{"modifier_sniper_13","#modifier_sniper_13", 3, "sniper/13", {}},
				{"empty_16"}
			},
			[7] = {
				{"empty_17"},
				{"empty_18"},
				{"modifier_sniper_14","#modifier_sniper_14", 1, "sniper/14", {}},
				{"empty_20"},
				{"empty_21"}
			}
		},
		[3] = {
			[1] = {
				{"modifier_woda_talent_mp1", "#woda_talent_mp1", 3, "mp1", {}},
				{"modifier_woda_talent_regenmp1", "#woda_talent_regenmp1", 2, "regenmp1", {}},
				{"modifier_woda_talent_spell", "#woda_talent_spell", 3, "spell", {}},
				{"modifier_sniper_15","#modifier_sniper_15", 3, "sniper/15", {}},
				{"modifier_woda_talent_int3", "#woda_talent_int3", 2, "int3", {}}
			},
			[2] = {
				{"empty_2"},
				{"empty_4"},
				{"modifier_sniper_16","#modifier_sniper_16", 3, "sniper/16", {}},
				{"modifier_woda_talent_blood", "#woda_talent_blood", 2, "blood", {}},
				{"modifier_woda_talent_int6", "#woda_talent_int6", 1, "int6", {"modifier_woda_talent_int3",2}}
			},
			[3] = {
				{"empty_6"},
				{"empty_7"},
				{"modifier_sniper_17","#modifier_sniper_17", 1, "sniper/17", {}},
				{"modifier_woda_talent_mask2", "#woda_talent_mask2", 2, "mask2", {}},
				{"modifier_woda_talent_kaya", "#woda_talent_kaya", 1, "kaya", {"modifier_woda_talent_int6",1}}
			},
			[4] = {
				{"modifier_woda_talent_mp2", "#woda_talent_mp2", 3, "mp2", {"modifier_woda_talent_mp1",3}},
				{"modifier_woda_talent_fairy", "#woda_talent_fairy", 2, "fairy", {}},
				{"modifier_sniper_18","#modifier_sniper_18", 3, "sniper/18", {}},
				{"empty_8"},
				{"modifier_woda_talent_int4", "#woda_talent_int4", 1, "int4", {"modifier_woda_talent_kaya",1}}
			},
			[5] = {
				{"modifier_woda_talent_spellprism", "#woda_talent_spellprism", 3, "spellprism", {}},
				{"modifier_sniper_19","#modifier_sniper_19", 1, "sniper/19", {}},
				{"empty_10"},
				{"empty_11"},
				{"modifier_woda_talent_int5", "#woda_talent_int5", 3, "int5", {"modifier_woda_talent_int4",1}}
			},
			[6] = {
				{"modifier_woda_talent_timeless", "#woda_talent_timeless", 2, "timeless", {}},
				{"modifier_woda_talent_regenmp2", "#woda_talent_regenmp2", 3, "regenmp2", {}},
				{"modifier_sniper_20","#modifier_sniper_20", 2, "sniper/20", {}},
				{"empty_15"},
				{"empty_16"}
			},
			[7] = {
				{"empty_17"},
				{"empty_18"},
				{"modifier_sniper_21","#modifier_sniper_21", 1, "sniper/21", {}},
				{"empty_20"},
				{"empty_21"}
			}
		}
	},
	["npc_dota_hero_monkey_king"] = {
		[1] = {
			[1] = {
				{"modifier_woda_talent_hp1", "#woda_talent_hp1", 3, "hp1", {}},
				{"modifier_woda_talent_regenhp1", "#woda_talent_regenhp1", 2, "regenhp1", {}},
				{"modifier_woda_talent_attack1", "#woda_talent_attack1", 3, "attack1", {}},
				{"modifier_monkey_king_1","#modifier_monkey_king_1", 1, "monkey_king/1", {}},
				{"modifier_woda_talent_str3", "#woda_talent_str3", 2, "str3", {}}
			},
			[2] = {
				{"empty_2"},
				{"empty_3"},
				{"modifier_monkey_king_2","#modifier_monkey_king_2", 2, "monkey_king/2", {}},
				{"modifier_woda_talent_cloak", "#woda_talent_cloak", 2, "cloak", {}},
				{"modifier_woda_talent_str6", "#woda_talent_str6", 1, "str6", {"modifier_woda_talent_str3",2}}
			},
			[3] = {
				{"empty_6"},
				{"modifier_woda_talent_quickhp", "#woda_talent_quickhp", 2, "quickhp", {}},
				{"modifier_monkey_king_3","#modifier_monkey_king_3", 3, "monkey_king/3", {"modifier_monkey_king_2",2}},
				{"empty_7"},
				{"modifier_woda_talent_sasha", "#woda_talent_sasha", 1, "sasha", {"modifier_woda_talent_str6",1}}
			},
			[4] = {
				{"modifier_woda_talent_hp2", "#woda_talent_hp2", 3, "hp2", {"modifier_woda_talent_hp1",3}},
				{"modifier_monkey_king_4","#modifier_monkey_king_4", 1, "monkey_king/4", {}},
				{"empty_10"},
				{"modifier_woda_talent_octar", "#woda_talent_octar", 2, "octar", {}},
				{"modifier_woda_talent_str4", "#woda_talent_str4", 1, "str4", {"modifier_woda_talent_sasha",1}}
			},
			[5] = {
				{"modifier_woda_talent_armor2", "#woda_talent_armor2", 3, "armor2", {}},
				{"empty_10"},
				{"modifier_monkey_king_5","#modifier_monkey_king_5", 3, "monkey_king/5", {"modifier_monkey_king_3",3}},
				{"empty_12"},
				{"modifier_woda_talent_str5", "#woda_talent_str5", 3, "str5", {"modifier_woda_talent_str4",1}}
			},
			[6] = {
				{"modifier_woda_talent_sliver", "#woda_talent_sliver", 2, "sliver", {}},
				{"modifier_woda_talent_regenhp2", "#woda_talent_regenhp2", 3, "regenhp2", {}},
				{"empty_15"},
				{"modifier_monkey_king_6","#modifier_monkey_king_6", 3, "monkey_king/6", {}},
				{"empty_16"}
			},
			[7] = {
				{"empty_17"},
				{"empty_18"},
				{"modifier_monkey_king_7","#modifier_monkey_king_7", 1, "monkey_king/7", {}},
				{"empty_20"},
				{"empty_21"}
			}
		},
		[2] = {
			[1] = {
				{"modifier_woda_talent_armor1", "#woda_talent_armor1", 3, "armor1", {}},
				{"modifier_woda_talent_speed1", "#woda_talent_speed1", 2, "speed1", {}},
				{"modifier_woda_talent_attackspeed1", "#woda_talent_attackspeed1", 3, "attackspeed1", {}},
				{"modifier_monkey_king_8","#modifier_monkey_king_8", 2, "monkey_king/8", {}},
				{"modifier_woda_talent_agi3", "#woda_talent_agi3", 2, "agi3", {}}
			},
			[2] = {
				{"modifier_monkey_king_12","#modifier_monkey_king_12", 2, "monkey_king/12", {}},
				{"empty_3"},
				{"empty_2"},
				{"modifier_woda_talent_miss1", "#woda_talent_miss1", 2, "miss1", {}},
				{"modifier_woda_talent_agi6", "#woda_talent_agi6", 1, "agi6", {"modifier_woda_talent_agi3",2}}
			},
			[3] = {
				{"modifier_monkey_king_10","#modifier_monkey_king_10", 3, "monkey_king/10", {}},
				{"empty_7"},
				{"empty_6"},
				{"modifier_woda_talent_mask1", "#woda_talent_mask1", 2, "mask1", {}},
				{"modifier_woda_talent_yasha", "#woda_talent_yasha", 1, "yasha", {"modifier_woda_talent_agi6",1}}
			},
			[4] = {
				{"modifier_monkey_king_11","#modifier_monkey_king_11", 1, "monkey_king/11", {}},
				{"modifier_woda_talent_speed2", "#woda_talent_speed2", 3, "speed2", {"modifier_woda_talent_speed1",2}},
				{"modifier_woda_talent_grovebow", "#woda_talent_grovebow", 2, "grovebow", {}},
				{"empty_8"},			
				{"modifier_woda_talent_agi4", "#woda_talent_agi4", 1, "agi4", {"modifier_woda_talent_yasha",1}}
			},
			[5] = {
				{"modifier_woda_talent_attack2", "#woda_talent_attack2", 3, "attack2", {}},
				{"empty_11"},
				{"modifier_monkey_king_9","#modifier_monkey_king_9", 2, "monkey_king/9", {}},
				{"empty_12"},
				{"modifier_woda_talent_agi5", "#woda_talent_agi5", 3, "agi5", {"modifier_woda_talent_agi4",1}}
			},
			[6] = {
				{"modifier_woda_talent_miss2", "#woda_talent_miss2", 2, "miss2", {}},
				{"modifier_monkey_king_13","#modifier_monkey_king_13", 3, "monkey_king/13", {}},
				{"modifier_woda_talent_attackspeed2", "#woda_talent_attackspeed2", 3, "attackspeed2", {}},
				{"empty_13"},
				{"empty_16"}
			},
			[7] = {
				{"empty_17"},
				{"empty_18"},
				{"modifier_monkey_king_14","#modifier_monkey_king_14", 1, "monkey_king/14", {}},
				{"empty_20"},
				{"empty_21"}
			}
		},
		[3] = {
			[1] = {
				{"modifier_woda_talent_mp1", "#woda_talent_mp1", 3, "mp1", {}},
				{"modifier_woda_talent_regenmp1", "#woda_talent_regenmp1", 2, "regenmp1", {}},
				{"modifier_woda_talent_spell", "#woda_talent_spell", 3, "spell", {}},
				{"modifier_monkey_king_15","#modifier_monkey_king_15", 3, "monkey_king/15", {}},
				{"modifier_woda_talent_int3", "#woda_talent_int3", 2, "int3", {}}
			},
			[2] = {
				{"empty_2"},
				{"modifier_monkey_king_16","#modifier_monkey_king_16", 2, "monkey_king/16", {}},
				{"empty_4"},
				{"modifier_woda_talent_blood", "#woda_talent_blood", 2, "blood", {}},
				{"modifier_woda_talent_int6", "#woda_talent_int6", 1, "int6", {"modifier_woda_talent_int3",2}}
			},
			[3] = {
				{"empty_6"},
				{"modifier_monkey_king_19","#modifier_monkey_king_19", 2, "monkey_king/19", {}},
				{"empty_7"},
				{"modifier_woda_talent_mask2", "#woda_talent_mask2", 2, "mask2", {}},
				{"modifier_woda_talent_kaya", "#woda_talent_kaya", 1, "kaya", {"modifier_woda_talent_int6",1}}
			},
			[4] = {
				{"modifier_woda_talent_mp2", "#woda_talent_mp2", 3, "mp2", {"modifier_woda_talent_mp1",3}},
				{"modifier_woda_talent_fairy", "#woda_talent_fairy", 2, "fairy", {}},
				{"empty_8"},
				{"modifier_monkey_king_17","#modifier_monkey_king_17", 2, "monkey_king/17", {}},
				{"modifier_woda_talent_int4", "#woda_talent_int4", 1, "int4", {"modifier_woda_talent_kaya",1}}
			},
			[5] = {
				{"modifier_woda_talent_spellprism", "#woda_talent_spellprism", 3, "spellprism", {}},
				{"empty_9"},
				{"empty_10"},
				{"modifier_monkey_king_18","#modifier_monkey_king_18", 3, "monkey_king/18", {}},
				{"modifier_woda_talent_int5", "#woda_talent_int5", 3, "int5", {"modifier_woda_talent_int4",1}}
			},
			[6] = {
				{"modifier_woda_talent_timeless", "#woda_talent_timeless", 2, "timeless", {}},
				{"modifier_woda_talent_regenmp2", "#woda_talent_regenmp2", 3, "regenmp2", {}},
				{"modifier_monkey_king_20","#modifier_monkey_king_20", 1, "monkey_king/20", {}},
				{"empty_15"},
				{"empty_16"}
			},
			[7] = {
				{"empty_17"},
				{"empty_18"},
				{"modifier_monkey_king_21","#modifier_monkey_king_21", 1, "monkey_king/21", {}},
				{"empty_20"},
				{"empty_21"}
			}
		}
	},
    ["npc_dota_hero_riki"] = {
        [1] = {
            [1] = {
                {"modifier_woda_talent_hp1", "#woda_talent_hp1", 3, "hp1", {}},
                {"modifier_woda_talent_regenhp1", "#woda_talent_regenhp1", 2, "regenhp1", {}},
                {"modifier_woda_talent_attack1", "#woda_talent_attack1", 3, "attack1", {}},
                {"modifier_riki_1","#modifier_riki_1", 1, "riki/1", {}},
                {"modifier_woda_talent_str3", "#woda_talent_str3", 2, "str3", {}}
            },
            [2] = {
                {"empty_2"},
                {"empty_3"},
                {"modifier_riki_3","#modifier_riki_3", 2, "riki/3", {}},
                {"modifier_woda_talent_cloak", "#woda_talent_cloak", 2, "cloak", {}},
                {"modifier_woda_talent_str6", "#woda_talent_str6", 1, "str6", {"modifier_woda_talent_str3",2}}
            },
            [3] = {
                {"empty_6"},
                {"modifier_woda_talent_quickhp", "#woda_talent_quickhp", 2, "quickhp", {}},
                {"modifier_riki_4","#modifier_riki_4", 3, "riki/4", {}},
                {"empty_7"},
                {"modifier_woda_talent_sasha", "#woda_talent_sasha", 1, "sasha", {"modifier_woda_talent_str6",1}}
            },
            [4] = {
                {"modifier_woda_talent_hp2", "#woda_talent_hp2", 3, "hp2", {"modifier_woda_talent_hp1",3}},
                {"modifier_riki_2","#modifier_riki_2", 3, "riki/2", {}},
                {"empty_9"},
                {"modifier_woda_talent_octar", "#woda_talent_octar", 2, "octar", {}},
                {"modifier_woda_talent_str4", "#woda_talent_str4", 1, "str4", {"modifier_woda_talent_sasha",1}}
            },
            [5] = {
                {"modifier_woda_talent_armor2", "#woda_talent_armor2", 3, "armor2", {}},
                {"empty_10"},
                {"modifier_riki_5","#modifier_riki_5", 2, "riki/5", {"modifier_riki_4",3}},
                {"empty_12"},
                {"modifier_woda_talent_str5", "#woda_talent_str5", 3, "str5", {"modifier_woda_talent_str4",1}}
            },
            [6] = {
                {"modifier_woda_talent_sliver", "#woda_talent_sliver", 2, "sliver", {}},
                {"modifier_woda_talent_regenhp2", "#woda_talent_regenhp2", 3, "regenhp2", {}},
                {"modifier_riki_6","#modifier_riki_6", 2, "riki/6", {"modifier_riki_5",2}},
                {"empty_15"},
                {"empty_16"}
            },
            [7] = {
                {"empty_17"},
                {"empty_18"},
                {"modifier_riki_7","#modifier_riki_7", 1, "riki/7", {}},
                {"empty_20"},
                {"empty_21"}
            }
        },
        [2] = {
            [1] = {
                {"modifier_woda_talent_armor1", "#woda_talent_armor1", 3, "armor1", {}},
                {"modifier_woda_talent_speed1", "#woda_talent_speed1", 2, "speed1", {}},
                {"modifier_woda_talent_attackspeed1", "#woda_talent_attackspeed1", 3, "attackspeed1", {}},
                {"modifier_riki_8","#modifier_riki_8", 3, "riki/8", {}},
                {"modifier_woda_talent_agi3", "#woda_talent_agi3", 2, "agi3", {}}
            },
            [2] = {
                {"empty_2"},
                {"empty_3"},
                {"modifier_riki_13","#modifier_riki_13", 3, "riki/13", {}},
                {"modifier_woda_talent_miss1", "#woda_talent_miss1", 2, "miss1", {}},
                {"modifier_woda_talent_agi6", "#woda_talent_agi6", 1, "agi6", {"modifier_woda_talent_agi3",2}}
            },
            [3] = {
                {"modifier_riki_10","#modifier_riki_10", 2, "riki/10", {}},
                {"empty_6"},
                {"empty_7"},
                {"modifier_woda_talent_mask1", "#woda_talent_mask1", 2, "mask1", {}},
                {"modifier_woda_talent_yasha", "#woda_talent_yasha", 1, "yasha", {"modifier_woda_talent_agi6",1}}
            },
            [4] = {
                {"empty_9"},
                {"modifier_woda_talent_speed2", "#woda_talent_speed2", 3, "speed2", {"modifier_woda_talent_speed1",2}},
                {"modifier_woda_talent_grovebow", "#woda_talent_grovebow", 2, "grovebow", {}},
                {"modifier_riki_12","#modifier_riki_12", 2, "riki/12", {}},            
                {"modifier_woda_talent_agi4", "#woda_talent_agi4", 1, "agi4", {"modifier_woda_talent_yasha",1}}
            },
            [5] = {
                {"modifier_woda_talent_attack2", "#woda_talent_attack2", 3, "attack2", {}},
                {"modifier_riki_11","#modifier_riki_11", 2, "riki/11", {}},
                {"empty_11"},
                {"empty_12"},
                {"modifier_woda_talent_agi5", "#woda_talent_agi5", 3, "agi5", {"modifier_woda_talent_agi4",1}}
            },
            [6] = {
                {"modifier_woda_talent_miss2", "#woda_talent_miss2", 2, "miss2", {}},
                {"empty_13"},
                {"modifier_woda_talent_attackspeed2", "#woda_talent_attackspeed2", 3, "attackspeed2", {}},
                {"modifier_riki_9","#modifier_riki_9", 1, "riki/9", {}},
                {"empty_14"}
            },
            [7] = {
                {"empty_17"},
                {"empty_18"},
                {"modifier_riki_14","#modifier_riki_14", 1, "riki/14", {}},
                {"empty_20"},
                {"empty_21"}
            }
        },
        [3] = {
            [1] = {
                {"modifier_woda_talent_mp1", "#woda_talent_mp1", 3, "mp1", {}},
                {"modifier_woda_talent_regenmp1", "#woda_talent_regenmp1", 2, "regenmp1", {}},
                {"modifier_riki_15","#modifier_riki_15", 1, "riki/15", {}},
                {"modifier_woda_talent_spell", "#woda_talent_spell", 3, "spell", {}},
                {"modifier_woda_talent_int3", "#woda_talent_int3", 2, "int3", {}}
            },
            [2] = {
                {"empty_2"},
                {"modifier_riki_16","#modifier_riki_16", 2, "riki/16", {}},
                {"empty_4"},
                {"modifier_woda_talent_blood", "#woda_talent_blood", 2, "blood", {}},
                {"modifier_woda_talent_int6", "#woda_talent_int6", 1, "int6", {"modifier_woda_talent_int3",2}}
            },
            [3] = {
                {"empty_6"},
                {"empty_7"},
                {"modifier_riki_17","#modifier_riki_17", 3, "riki/17", {"modifier_riki_15",1}},
                {"modifier_woda_talent_mask2", "#woda_talent_mask2", 2, "mask2", {}},
                {"modifier_woda_talent_kaya", "#woda_talent_kaya", 1, "kaya", {"modifier_woda_talent_int6",1}}
            },
            [4] = {
                {"modifier_woda_talent_mp2", "#woda_talent_mp2", 3, "mp2", {"modifier_woda_talent_mp1",3}},
                {"modifier_woda_talent_fairy", "#woda_talent_fairy", 2, "fairy", {}},
                {"empty_8"},
                {"modifier_riki_18","#modifier_riki_18", 2, "riki/18", {}},
                {"modifier_woda_talent_int4", "#woda_talent_int4", 1, "int4", {"modifier_woda_talent_kaya",1}}
            },
            [5] = {
                {"modifier_woda_talent_spellprism", "#woda_talent_spellprism", 3, "spellprism", {}},
                {"empty_9"},
                {"modifier_riki_19","#modifier_riki_19", 3, "riki/19", {"modifier_riki_17",3}},
                {"empty_11"},
                {"modifier_woda_talent_int5", "#woda_talent_int5", 3, "int5", {"modifier_woda_talent_int4",1}}
            },
            [6] = {
                {"modifier_woda_talent_timeless", "#woda_talent_timeless", 2, "timeless", {}},
                {"modifier_woda_talent_regenmp2", "#woda_talent_regenmp2", 3, "regenmp2", {}},
                {"empty_14"},
                {"empty_15"},
                {"modifier_riki_20","#modifier_riki_20", 2, "riki/20", {}}
            },
            [7] = {
                {"empty_17"},
                {"empty_18"},
                {"modifier_riki_21","#modifier_riki_21", 1, "riki/21", {}},
                {"empty_20"},
                {"empty_21"}
            }
        }
    },
    ["npc_dota_hero_faceless_void"] = {
        [1] = {
            [1] = {
                {"modifier_woda_talent_hp1", "#woda_talent_hp1", 3, "hp1", {}},
                {"modifier_woda_talent_regenhp1", "#woda_talent_regenhp1", 2, "regenhp1", {}},
                {"modifier_woda_talent_attack1", "#woda_talent_attack1", 3, "attack1", {}},
                {"modifier_faceless_void_3","#modifier_faceless_void_3", 3, "faceless_void/3", {}},
                {"modifier_woda_talent_str3", "#woda_talent_str3", 2, "str3", {}}
            },
            [2] = {
                {"empty_2"},
                {"empty_3"},
                {"modifier_faceless_void_1","#modifier_faceless_void_1", 1, "faceless_void/1", {}},
                {"modifier_woda_talent_cloak", "#woda_talent_cloak", 2, "cloak", {}},
                {"modifier_woda_talent_str6", "#woda_talent_str6", 1, "str6", {"modifier_woda_talent_str3",2}}
            },
            [3] = {
                {"empty_6"},
                {"modifier_woda_talent_quickhp", "#woda_talent_quickhp", 2, "quickhp", {}},
                {"modifier_faceless_void_2","#modifier_faceless_void_2", 2, "faceless_void/2", {}},
                {"empty_7"},
                {"modifier_woda_talent_sasha", "#woda_talent_sasha", 1, "sasha", {"modifier_woda_talent_str6",1}}
            },
            [4] = {
                {"modifier_woda_talent_hp2", "#woda_talent_hp2", 3, "hp2", {"modifier_woda_talent_hp1",3}},
                {"empty_9"},
                {"modifier_faceless_void_4","#modifier_faceless_void_4", 3, "faceless_void/4", {}},
                {"modifier_woda_talent_octar", "#woda_talent_octar", 2, "octar", {}},
                {"modifier_woda_talent_str4", "#woda_talent_str4", 1, "str4", {"modifier_woda_talent_sasha",1}}
            },
            [5] = {
                {"modifier_woda_talent_armor2", "#woda_talent_armor2", 3, "armor2", {}},
                {"empty_10"},
                {"modifier_faceless_void_5","#modifier_faceless_void_5", 1, "faceless_void/5", {"modifier_faceless_void_4",3}},
                {"empty_12"},
                {"modifier_woda_talent_str5", "#woda_talent_str5", 3, "str5", {"modifier_woda_talent_str4",1}}
            },
            [6] = {
                {"modifier_woda_talent_sliver", "#woda_talent_sliver", 2, "sliver", {}},
                {"modifier_woda_talent_regenhp2", "#woda_talent_regenhp2", 3, "regenhp2", {}},
                {"empty_14"},
                {"empty_15"},
                {"modifier_faceless_void_6","#modifier_faceless_void_6", 3, "faceless_void/6", {}}
            },
            [7] = {
                {"empty_17"},
                {"empty_18"},
                {"modifier_faceless_void_7","#modifier_faceless_void_7", 1, "faceless_void/7", {}},
                {"empty_20"},
                {"empty_21"}
            }
        },
        [2] = {
            [1] = {
                {"modifier_woda_talent_armor1", "#woda_talent_armor1", 3, "armor1", {}},
                {"modifier_woda_talent_speed1", "#woda_talent_speed1", 2, "speed1", {}},
                {"modifier_faceless_void_8","#modifier_faceless_void_8", 2, "faceless_void/8", {}},
                {"modifier_woda_talent_attackspeed1", "#woda_talent_attackspeed1", 3, "attackspeed1", {}},
                {"modifier_woda_talent_agi3", "#woda_talent_agi3", 2, "agi3", {}}
            },
            [2] = {
                {"empty_2"},
                {"empty_3"},
                {"modifier_faceless_void_9","#modifier_faceless_void_9", 2, "faceless_void/9", {"modifier_faceless_void_8",2}},
                {"modifier_woda_talent_miss1", "#woda_talent_miss1", 2, "miss1", {}},
                {"modifier_woda_talent_agi6", "#woda_talent_agi6", 1, "agi6", {"modifier_woda_talent_agi3",2}}
            },
            [3] = {
                {"empty_6"},
                {"empty_7"},
                {"modifier_faceless_void_10","#modifier_faceless_void_10", 2, "faceless_void/10", {"modifier_faceless_void_9",2}},
                {"modifier_woda_talent_mask1", "#woda_talent_mask1", 2, "mask1", {}},
                {"modifier_woda_talent_yasha", "#woda_talent_yasha", 1, "yasha", {"modifier_woda_talent_agi6",1}}
            },
            [4] = {
                {"empty_8"},
                {"modifier_woda_talent_speed2", "#woda_talent_speed2", 3, "speed2", {"modifier_woda_talent_speed1",2}},
                {"modifier_faceless_void_13","#modifier_faceless_void_13", 2, "faceless_void/13", {"modifier_faceless_void_10",2}},
                {"modifier_woda_talent_grovebow", "#woda_talent_grovebow", 2, "grovebow", {}},            
                {"modifier_woda_talent_agi4", "#woda_talent_agi4", 1, "agi4", {"modifier_woda_talent_yasha",1}}
            },
            [5] = {
                {"modifier_woda_talent_attack2", "#woda_talent_attack2", 3, "attack2", {}},
                {"modifier_faceless_void_12","#modifier_faceless_void_12", 2, "faceless_void/12", {}},
                {"empty_11"},
                {"empty_12"},
                {"modifier_woda_talent_agi5", "#woda_talent_agi5", 3, "agi5", {"modifier_woda_talent_agi4",1}}
            },
            [6] = {
                {"modifier_woda_talent_miss2", "#woda_talent_miss2", 2, "miss2", {}},
                {"empty_13"},
                {"modifier_faceless_void_11","#modifier_faceless_void_11", 3, "faceless_void/11", {"modifier_faceless_void_13",2}},
                {"empty_14"},
                {"modifier_woda_talent_attackspeed2", "#woda_talent_attackspeed2", 3, "attackspeed2", {}}
            },
            [7] = {
                {"empty_17"},
                {"empty_18"},
                {"modifier_faceless_void_14","#modifier_faceless_void_14", 1, "faceless_void/14", {}},
                {"empty_20"},
                {"empty_21"}
            }
        },
        [3] = {
            [1] = {
                {"modifier_woda_talent_mp1", "#woda_talent_mp1", 3, "mp1", {}},
                {"modifier_woda_talent_regenmp1", "#woda_talent_regenmp1", 2, "regenmp1", {}},
                {"modifier_woda_talent_spell", "#woda_talent_spell", 3, "spell", {}},
                {"modifier_faceless_void_15","#modifier_faceless_void_15", 1, "faceless_void/15", {}},
                {"modifier_woda_talent_int3", "#woda_talent_int3", 2, "int3", {}}
            },
            [2] = {
                {"empty_2"},
                {"modifier_faceless_void_16","#modifier_faceless_void_16", 3, "faceless_void/16", {}},
                {"empty_4"},
                {"modifier_woda_talent_blood", "#woda_talent_blood", 2, "blood", {}},
                {"modifier_woda_talent_int6", "#woda_talent_int6", 1, "int6", {"modifier_woda_talent_int3",2}}
            },
            [3] = {
                {"empty_6"},
                {"modifier_faceless_void_17","#modifier_faceless_void_17", 2, "faceless_void/17", {}},
                {"empty_7"},
                {"modifier_woda_talent_mask2", "#woda_talent_mask2", 2, "mask2", {}},
                {"modifier_woda_talent_kaya", "#woda_talent_kaya", 1, "kaya", {"modifier_woda_talent_int6",1}}
            },
            [4] = {
                {"modifier_woda_talent_mp2", "#woda_talent_mp2", 3, "mp2", {"modifier_woda_talent_mp1",3}},
                {"empty_8"},
                {"modifier_faceless_void_18","#modifier_faceless_void_18", 3, "faceless_void/18", {}},
                {"modifier_woda_talent_fairy", "#woda_talent_fairy", 2, "fairy", {}},
                {"modifier_woda_talent_int4", "#woda_talent_int4", 1, "int4", {"modifier_woda_talent_kaya",1}}
            },
            [5] = {
                {"modifier_woda_talent_spellprism", "#woda_talent_spellprism", 3, "spellprism", {}},
                {"modifier_faceless_void_19","#modifier_faceless_void_19", 3, "faceless_void/19", {"modifier_faceless_void_17",2}},
                {"empty_10"},
                {"empty_11"},
                {"modifier_woda_talent_int5", "#woda_talent_int5", 3, "int5", {"modifier_woda_talent_int4",1}}
            },
            [6] = {
                {"modifier_woda_talent_timeless", "#woda_talent_timeless", 2, "timeless", {}},
                {"modifier_woda_talent_regenmp2", "#woda_talent_regenmp2", 3, "regenmp2", {}},
                {"empty_14"},
                {"modifier_faceless_void_20","#modifier_faceless_void_20", 1, "faceless_void/20", {}},
                {"empty_16"}
            },
            [7] = {
                {"empty_17"},
                {"empty_18"},
                {"modifier_faceless_void_21","#modifier_faceless_void_21", 1, "faceless_void/21", {}},
                {"empty_20"},
                {"empty_21"}
            }
        }
    },
    ["npc_dota_hero_tinker"] = {
        [1] = {
            [1] = {
                {"modifier_woda_talent_hp1", "#woda_talent_hp1", 3, "hp1", {}},
                {"modifier_woda_talent_regenhp1", "#woda_talent_regenhp1", 2, "regenhp1", {}},
                {"modifier_tinker_1","#modifier_tinker_1", 1, "tinker/1", {}},
                {"modifier_woda_talent_attack1", "#woda_talent_attack1", 3, "attack1", {}},
                {"modifier_woda_talent_str3", "#woda_talent_str3", 2, "str3", {}}
            },
            [2] = {
                {"empty_2"},
                {"modifier_tinker_2","#modifier_tinker_2", 3, "tinker/2", {}},
                {"empty_4"},
                {"modifier_woda_talent_cloak", "#woda_talent_cloak", 2, "cloak", {}},
                {"modifier_woda_talent_str6", "#woda_talent_str6", 1, "str6", {"modifier_woda_talent_str3",2}}
            },
            [3] = {
                {"empty_6"},
                {"modifier_woda_talent_quickhp", "#woda_talent_quickhp", 2, "quickhp", {}},
                {"empty_7"},
                {"modifier_tinker_3","#modifier_tinker_3", 3, "tinker/3", {}},
                {"modifier_woda_talent_sasha", "#woda_talent_sasha", 1, "sasha", {"modifier_woda_talent_str6",1}}
            },
            [4] = {
                {"modifier_woda_talent_hp2", "#woda_talent_hp2", 3, "hp2", {"modifier_woda_talent_hp1",3}},
                {"empty_9"},
                {"modifier_tinker_4","#modifier_tinker_4", 1, "tinker/4", {"modifier_tinker_1",1}},
                {"modifier_woda_talent_octar", "#woda_talent_octar", 2, "octar", {}},
                {"modifier_woda_talent_str4", "#woda_talent_str4", 1, "str4", {"modifier_woda_talent_sasha",1}}
            },
            [5] = {
                {"modifier_woda_talent_armor2", "#woda_talent_armor2", 3, "armor2", {}},
                {"empty_10"},
                {"empty_11"},
                {"modifier_tinker_5","#modifier_tinker_5", 3, "tinker/5", {}},
                {"modifier_woda_talent_str5", "#woda_talent_str5", 3, "str5", {"modifier_woda_talent_str4",1}}
            },
            [6] = {
                {"modifier_woda_talent_sliver", "#woda_talent_sliver", 2, "sliver", {}},
                {"modifier_woda_talent_regenhp2", "#woda_talent_regenhp2", 3, "regenhp2", {}},
                {"modifier_tinker_7","#modifier_tinker_7", 2, "tinker/7", {"modifier_tinker_4",1}},
                {"empty_15"},
                {"empty_16"}
            },
            [7] = {
                {"empty_17"},
                {"empty_18"},
                {"modifier_tinker_6","#modifier_tinker_6", 1, "tinker/6", {}},
                {"empty_20"},
                {"empty_21"}
            }
        },
        [2] = {
            [1] = {
                {"modifier_woda_talent_armor1", "#woda_talent_armor1", 3, "armor1", {}},
                {"modifier_woda_talent_speed1", "#woda_talent_speed1", 2, "speed1", {}},
                {"modifier_woda_talent_attackspeed1", "#woda_talent_attackspeed1", 3, "attackspeed1", {}},
                {"modifier_tinker_11","#modifier_tinker_11", 1, "tinker/11", {}},
                {"modifier_woda_talent_agi3", "#woda_talent_agi3", 2, "agi3", {}}
            },
            [2] = {
                {"empty_2"},
                {"empty_3"},
                {"modifier_tinker_8","#modifier_tinker_8", 3, "tinker/8", {}},
                {"modifier_woda_talent_miss1", "#woda_talent_miss1", 2, "miss1", {}},
                {"modifier_woda_talent_agi6", "#woda_talent_agi6", 1, "agi6", {"modifier_woda_talent_agi3",2}}
            },
            [3] = {
                {"empty_8"},
                {"empty_7"},
                {"modifier_tinker_12","#modifier_tinker_12", 1, "tinker/12", {}},
                {"modifier_woda_talent_mask1", "#woda_talent_mask1", 2, "mask1", {}},
                {"modifier_woda_talent_yasha", "#woda_talent_yasha", 1, "yasha", {"modifier_woda_talent_agi6",1}}
            },
            [4] = {
                {"empty_10"},
                {"modifier_woda_talent_speed2", "#woda_talent_speed2", 3, "speed2", {"modifier_woda_talent_speed1",2}},
                {"modifier_woda_talent_grovebow", "#woda_talent_grovebow", 2, "grovebow", {}},
                {"modifier_tinker_13","#modifier_tinker_13", 2, "tinker/13", {}},            
                {"modifier_woda_talent_agi4", "#woda_talent_agi4", 1, "agi4", {"modifier_woda_talent_yasha",1}}
            },
            [5] = {
                {"modifier_woda_talent_attack2", "#woda_talent_attack2", 3, "attack2", {}},
                {"empty_11"},
                {"modifier_tinker_10","#modifier_tinker_10", 3, "tinker/10", {}},
                {"empty_12"},
                {"modifier_woda_talent_agi5", "#woda_talent_agi5", 3, "agi5", {"modifier_woda_talent_agi4",1}}
            },
            [6] = {
                {"modifier_woda_talent_miss2", "#woda_talent_miss2", 2, "miss2", {}},
                {"empty_14"},
                {"modifier_woda_talent_attackspeed2", "#woda_talent_attackspeed2", 3, "attackspeed2", {}},
                {"modifier_tinker_9","#modifier_tinker_9", 3, "tinker/9", {}},
                {"empty_15"}
            },
            [7] = {
                {"empty_17"},
                {"empty_18"},
                {"modifier_tinker_21","#modifier_tinker_21", 1, "tinker/21", {}},
                {"empty_20"},
                {"empty_21"}
            }
        },
        [3] = {
            [1] = {
                {"modifier_woda_talent_mp1", "#woda_talent_mp1", 3, "mp1", {}},
                {"modifier_woda_talent_regenmp1", "#woda_talent_regenmp1", 2, "regenmp1", {}},
                {"modifier_tinker_15","#modifier_tinker_15", 3, "tinker/15", {}},
                {"modifier_woda_talent_spell", "#woda_talent_spell", 3, "spell", {}},
                {"modifier_woda_talent_int3", "#woda_talent_int3", 2, "int3", {}}
            },
            [2] = {
                {"empty_2"},
                {"empty_4"},
                {"modifier_tinker_16","#modifier_tinker_16", 1, "tinker/16", {"modifier_tinker_15",3}},
                {"modifier_woda_talent_blood", "#woda_talent_blood", 2, "blood", {}},
                {"modifier_woda_talent_int6", "#woda_talent_int6", 1, "int6", {"modifier_woda_talent_int3",2}}
            },
            [3] = {
                {"empty_6"},
                {"modifier_tinker_19","#modifier_tinker_19", 1, "tinker/19", {}},
                {"empty_7"},
                {"modifier_woda_talent_mask2", "#woda_talent_mask2", 2, "mask2", {}},
                {"modifier_woda_talent_kaya", "#woda_talent_kaya", 1, "kaya", {"modifier_woda_talent_int6",1}}
            },
            [4] = {
                {"modifier_woda_talent_mp2", "#woda_talent_mp2", 3, "mp2", {"modifier_woda_talent_mp1",3}},
                {"modifier_woda_talent_fairy", "#woda_talent_fairy", 2, "fairy", {}},
                {"empty_8"},
                {"modifier_tinker_18","#modifier_tinker_18", 3, "tinker/18", {}},
                {"modifier_woda_talent_int4", "#woda_talent_int4", 1, "int4", {"modifier_woda_talent_kaya",1}}
            },
            [5] = {
                {"modifier_woda_talent_spellprism", "#woda_talent_spellprism", 3, "spellprism", {}},
                {"modifier_tinker_20","#modifier_tinker_20", 3, "tinker/20", {}},
                {"empty_10"},
                {"empty_11"},
                {"modifier_woda_talent_int5", "#woda_talent_int5", 3, "int5", {"modifier_woda_talent_int4",1}}
            },
            [6] = {
                {"modifier_woda_talent_timeless", "#woda_talent_timeless", 2, "timeless", {}},
                {"empty_15"},
                {"modifier_woda_talent_regenmp2", "#woda_talent_regenmp2", 3, "regenmp2", {}},
                {"modifier_tinker_17","#modifier_tinker_17", 2, "tinker/17", {"modifier_tinker_18",3}},
                {"empty_16"}
            },
            [7] = {
                {"empty_17"},
                {"empty_18"},
                {"modifier_tinker_14","#modifier_tinker_14", 1, "tinker/14", {}},
                {"empty_20"},
                {"empty_21"}
            }
        }
    },
    ["npc_dota_hero_keeper_of_the_light"] = {
        [1] = {
            [1] = {
                {"modifier_woda_talent_hp1", "#woda_talent_hp1", 3, "hp1", {}},
                {"modifier_woda_talent_regenhp1", "#woda_talent_regenhp1", 2, "regenhp1", {}},
                {"modifier_woda_talent_attack1", "#woda_talent_attack1", 3, "attack1", {}},
                {"modifier_keeper_of_the_light_1","#modifier_keeper_of_the_light_1", 2, "keeper_of_the_light/1", {}},
                {"modifier_woda_talent_str3", "#woda_talent_str3", 2, "str3", {}}
            },
            [2] = {
                {"empty_2"},
                {"modifier_keeper_of_the_light_2","#modifier_keeper_of_the_light_2", 3, "keeper_of_the_light/2", {}},
                {"empty_4"},
                {"modifier_woda_talent_cloak", "#woda_talent_cloak", 2, "cloak", {}},
                {"modifier_woda_talent_str6", "#woda_talent_str6", 1, "str6", {"modifier_woda_talent_str3",2}}
            },
            [3] = {
                {"empty_6"},
                {"modifier_woda_talent_quickhp", "#woda_talent_quickhp", 2, "quickhp", {}},
                {"modifier_keeper_of_the_light_3","#modifier_keeper_of_the_light_3", 2, "keeper_of_the_light/3", {}},
                {"empty_8"},
                {"modifier_woda_talent_sasha", "#woda_talent_sasha", 1, "sasha", {"modifier_woda_talent_str6",1}}
            },
            [4] = {
                {"modifier_woda_talent_hp2", "#woda_talent_hp2", 3, "hp2", {"modifier_woda_talent_hp1",3}},
                {"modifier_keeper_of_the_light_4","#modifier_keeper_of_the_light_4", 2, "keeper_of_the_light/4", {}},
                {"empty_9"},
                {"modifier_woda_talent_octar", "#woda_talent_octar", 2, "octar", {}},
                {"modifier_woda_talent_str4", "#woda_talent_str4", 1, "str4", {"modifier_woda_talent_sasha",1}}
            },
            [5] = {
                {"modifier_woda_talent_armor2", "#woda_talent_armor2", 3, "armor2", {}},
                {"empty_10"},
                {"modifier_keeper_of_the_light_5","#modifier_keeper_of_the_light_5", 2, "keeper_of_the_light/5", {"modifier_keeper_of_the_light_3",2}},
                {"empty_12"},
                {"modifier_woda_talent_str5", "#woda_talent_str5", 3, "str5", {"modifier_woda_talent_str4",1}}
            },
            [6] = {
                {"modifier_woda_talent_sliver", "#woda_talent_sliver", 2, "sliver", {}},
                {"modifier_woda_talent_regenhp2", "#woda_talent_regenhp2", 3, "regenhp2", {}},
                {"modifier_keeper_of_the_light_6","#modifier_keeper_of_the_light_6", 2, "keeper_of_the_light/6", {}},
                {"empty_15"},
                {"empty_16"}
            },
            [7] = {
                {"empty_17"},
                {"empty_18"},
                {"modifier_keeper_of_the_light_7","#modifier_keeper_of_the_light_7", 1, "keeper_of_the_light/7", {}},
                {"empty_20"},
                {"empty_21"}
            }
        },
        [2] = {
            [1] = {
                {"modifier_woda_talent_armor1", "#woda_talent_armor1", 3, "armor1", {}},
                {"modifier_woda_talent_speed1", "#woda_talent_speed1", 2, "speed1", {}},
                {"modifier_keeper_of_the_light_8","#modifier_keeper_of_the_light_8", 1, "keeper_of_the_light/8", {}},
                {"modifier_woda_talent_attackspeed1", "#woda_talent_attackspeed1", 3, "attackspeed1", {}},
                {"modifier_woda_talent_agi3", "#woda_talent_agi3", 2, "agi3", {}}
            },
            [2] = {
                {"empty_2"},
                {"empty_3"},
                {"modifier_keeper_of_the_light_9","#modifier_keeper_of_the_light_9", 3, "keeper_of_the_light/9", {"modifier_keeper_of_the_light_8",1}},
                {"modifier_woda_talent_miss1", "#woda_talent_miss1", 2, "miss1", {}},
                {"modifier_woda_talent_agi6", "#woda_talent_agi6", 1, "agi6", {"modifier_woda_talent_agi3",2}}
            },
            [3] = {
                {"empty_6"},
                {"empty_7"},
                {"modifier_keeper_of_the_light_10","#modifier_keeper_of_the_light_10", 3, "keeper_of_the_light/10", {"modifier_keeper_of_the_light_9",3}},
                {"modifier_woda_talent_mask1", "#woda_talent_mask1", 2, "mask1", {}},
                {"modifier_woda_talent_yasha", "#woda_talent_yasha", 1, "yasha", {"modifier_woda_talent_agi6",1}}
            },
            [4] = {
                {"empty_9"},
                {"modifier_woda_talent_speed2", "#woda_talent_speed2", 3, "speed2", {"modifier_woda_talent_speed1",2}},
                {"modifier_woda_talent_grovebow", "#woda_talent_grovebow", 2, "grovebow", {}},
                {"modifier_keeper_of_the_light_11","#modifier_keeper_of_the_light_11", 1, "keeper_of_the_light/11", {}},            
                {"modifier_woda_talent_agi4", "#woda_talent_agi4", 1, "agi4", {"modifier_woda_talent_yasha",1}}
            },
            [5] = {
                {"modifier_woda_talent_attack2", "#woda_talent_attack2", 3, "attack2", {}},
                {"empty_10"},
                {"empty_11"},
                {"modifier_keeper_of_the_light_12","#modifier_keeper_of_the_light_12", 2, "keeper_of_the_light/12", {"modifier_keeper_of_the_light_11",1}},
                {"modifier_woda_talent_agi5", "#woda_talent_agi5", 3, "agi5", {"modifier_woda_talent_agi4",1}}
            },
            [6] = {
                {"modifier_woda_talent_miss2", "#woda_talent_miss2", 2, "miss2", {}},
                {"empty_13"},
                {"modifier_woda_talent_attackspeed2", "#woda_talent_attackspeed2", 3, "attackspeed2", {}},
                {"modifier_keeper_of_the_light_13","#modifier_keeper_of_the_light_13", 3, "keeper_of_the_light/13", {"modifier_keeper_of_the_light_12",2}},
                {"empty_14"}
            },
            [7] = {
                {"empty_17"},
                {"empty_18"},
                {"modifier_keeper_of_the_light_14","#modifier_keeper_of_the_light_14", 1, "keeper_of_the_light/14", {}},
                {"empty_20"},
                {"empty_21"}
            }
        },
        [3] = {
            [1] = {
                {"modifier_woda_talent_mp1", "#woda_talent_mp1", 3, "mp1", {}},
                {"modifier_woda_talent_regenmp1", "#woda_talent_regenmp1", 2, "regenmp1", {}},
                {"modifier_woda_talent_spell", "#woda_talent_spell", 3, "spell", {}},
                {"modifier_keeper_of_the_light_15","#modifier_keeper_of_the_light_15", 3, "keeper_of_the_light/15", {}},
                {"modifier_woda_talent_int3", "#woda_talent_int3", 2, "int3", {}}
            },
            [2] = {
                {"empty_2"},
                {"empty_4"},
                {"modifier_keeper_of_the_light_16","#modifier_keeper_of_the_light_16", 3, "keeper_of_the_light/16", {}},
                {"modifier_woda_talent_blood", "#woda_talent_blood", 2, "blood", {}},
                {"modifier_woda_talent_int6", "#woda_talent_int6", 1, "int6", {"modifier_woda_talent_int3",2}}
            },
            [3] = {
                {"empty_6"},
                {"modifier_keeper_of_the_light_17","#modifier_keeper_of_the_light_17", 3, "keeper_of_the_light/17", {}},
                {"empty_7"},
                {"modifier_woda_talent_mask2", "#woda_talent_mask2", 2, "mask2", {}},
                {"modifier_woda_talent_kaya", "#woda_talent_kaya", 1, "kaya", {"modifier_woda_talent_int6",1}}
            },
            [4] = {
                {"modifier_woda_talent_mp2", "#woda_talent_mp2", 3, "mp2", {"modifier_woda_talent_mp1",3}},
                {"modifier_woda_talent_fairy", "#woda_talent_fairy", 2, "fairy", {}},
                {"modifier_keeper_of_the_light_18","#modifier_keeper_of_the_light_18", 2, "keeper_of_the_light/18", {}},
                {"empty_8"},
                {"modifier_woda_talent_int4", "#woda_talent_int4", 1, "int4", {"modifier_woda_talent_kaya",1}}
            },
            [5] = {
                {"modifier_woda_talent_spellprism", "#woda_talent_spellprism", 3, "spellprism", {}},
                {"empty_9"},
                {"empty_10"},
                {"modifier_keeper_of_the_light_20","#modifier_keeper_of_the_light_20", 1, "keeper_of_the_light/20", {}},
                {"modifier_woda_talent_int5", "#woda_talent_int5", 3, "int5", {"modifier_woda_talent_int4",1}}
            },
            [6] = {
                {"modifier_woda_talent_timeless", "#woda_talent_timeless", 2, "timeless", {}},
                {"empty_14"},
                {"modifier_woda_talent_regenmp2", "#woda_talent_regenmp2", 3, "regenmp2", {}},
                {"modifier_keeper_of_the_light_19","#modifier_keeper_of_the_light_19", 1, "keeper_of_the_light/19", {}},
                {"empty_15"}
            },
            [7] = {
                {"empty_17"},
                {"empty_18"},
                {"modifier_keeper_of_the_light_21","#modifier_keeper_of_the_light_21", 1, "keeper_of_the_light/21", {}},
                {"empty_20"},
                {"empty_21"}
            }
        }
    },
	["npc_dota_hero_dawnbreaker"] = {
		[1] = {
			[1] = {
				{"modifier_woda_talent_hp1", "#woda_talent_hp1", 3, "hp1", {}},
				{"modifier_woda_talent_regenhp1", "#woda_talent_regenhp1", 2, "regenhp1", {}},
				{"modifier_woda_talent_attack1", "#woda_talent_attack1", 3, "attack1", {}},
				{"modifier_dawnbreaker_1","#modifier_dawnbreaker_1", 3, "dawnbreaker/1", {}},
				{"modifier_woda_talent_str3", "#woda_talent_str3", 2, "str3", {}}
			},
			[2] = {
				{"empty_2"},
				{"modifier_dawnbreaker_2","#modifier_dawnbreaker_2", 2, "dawnbreaker/2", {}},
				{"empty_3"},
				{"modifier_woda_talent_cloak", "#woda_talent_cloak", 2, "cloak", {}},
				{"modifier_woda_talent_str6", "#woda_talent_str6", 1, "str6", {"modifier_woda_talent_str3",2}}
			},
			[3] = {
				{"empty_6"},
				{"modifier_woda_talent_quickhp", "#woda_talent_quickhp", 2, "quickhp", {}},
				{"modifier_dawnbreaker_3","#modifier_dawnbreaker_3", 2, "dawnbreaker/3", {}},
				{"empty_7"},
				{"modifier_woda_talent_sasha", "#woda_talent_sasha", 1, "sasha", {"modifier_woda_talent_str6",1}}
			},
			[4] = {
				{"modifier_woda_talent_hp2", "#woda_talent_hp2", 3, "hp2", {"modifier_woda_talent_hp1",3}},
				{"empty_9"},
				{"modifier_dawnbreaker_4","#modifier_dawnbreaker_4", 2, "dawnbreaker/4", {}},
				{"modifier_woda_talent_octar", "#woda_talent_octar", 2, "octar", {}},
				{"modifier_woda_talent_str4", "#woda_talent_str4", 1, "str4", {"modifier_woda_talent_sasha",1}}
			},
			[5] = {
				{"modifier_woda_talent_armor2", "#woda_talent_armor2", 3, "armor2", {}},
				{"empty_10"},
				{"empty_11"},
				{"modifier_dawnbreaker_5","#modifier_dawnbreaker_5", 2, "dawnbreaker/5", {}},
				{"modifier_woda_talent_str5", "#woda_talent_str5", 3, "str5", {"modifier_woda_talent_str4",1}}
			},
			[6] = {
				{"modifier_woda_talent_sliver", "#woda_talent_sliver", 2, "sliver", {}},
				{"modifier_woda_talent_regenhp2", "#woda_talent_regenhp2", 3, "regenhp2", {}},
				{"modifier_dawnbreaker_6","#modifier_dawnbreaker_6", 2, "dawnbreaker/6", {}},
				{"empty_15"},
				{"empty_16"}
			},
			[7] = {
				{"empty_17"},
				{"empty_18"},
				{"modifier_dawnbreaker_7","#modifier_dawnbreaker_7", 1, "dawnbreaker/7", {}},
				{"empty_20"},
				{"empty_21"}
			}
		},
		[2] = {
			[1] = {
				{"modifier_woda_talent_armor1", "#woda_talent_armor1", 3, "armor1", {}},
				{"modifier_woda_talent_speed1", "#woda_talent_speed1", 2, "speed1", {}},
				{"modifier_woda_talent_attackspeed1", "#woda_talent_attackspeed1", 3, "attackspeed1", {}},
				{"modifier_dawnbreaker_8","#modifier_dawnbreaker_8", 2, "dawnbreaker/8", {}},
				{"modifier_woda_talent_agi3", "#woda_talent_agi3", 2, "agi3", {}}
			},
			[2] = {
				{"modifier_dawnbreaker_9","#modifier_dawnbreaker_9", 2, "dawnbreaker/9", {}},
				{"empty_2"},
				{"empty_3"},
				{"modifier_woda_talent_miss1", "#woda_talent_miss1", 2, "miss1", {}},
				{"modifier_woda_talent_agi6", "#woda_talent_agi6", 1, "agi6", {"modifier_woda_talent_agi3",2}}
			},
			[3] = {
				{"modifier_dawnbreaker_10","#modifier_dawnbreaker_10", 2, "dawnbreaker/10", {}},
				{"empty_6"},
				{"empty_7"},
				{"modifier_woda_talent_mask1", "#woda_talent_mask1", 2, "mask1", {}},
				{"modifier_woda_talent_yasha", "#woda_talent_yasha", 1, "yasha", {"modifier_woda_talent_agi6",1}}
			},
			[4] = {
				{"modifier_dawnbreaker_11","#modifier_dawnbreaker_11", 2, "dawnbreaker/11", {}},
				{"modifier_woda_talent_speed2", "#woda_talent_speed2", 3, "speed2", {"modifier_woda_talent_speed1",2}},
				{"modifier_woda_talent_grovebow", "#woda_talent_grovebow", 2, "grovebow", {}},
				{"empty_10"},			
				{"modifier_woda_talent_agi4", "#woda_talent_agi4", 1, "agi4", {"modifier_woda_talent_yasha",1}}
			},
			[5] = {
				{"modifier_woda_talent_attack2", "#woda_talent_attack2", 3, "attack2", {}},
				{"empty_11"},
				{"empty_12"},
				{"modifier_dawnbreaker_12","#modifier_dawnbreaker_12", 3, "dawnbreaker/12", {}},
				{"modifier_woda_talent_agi5", "#woda_talent_agi5", 3, "agi5", {"modifier_woda_talent_agi4",1}}
			},
			[6] = {
				{"modifier_woda_talent_miss2", "#woda_talent_miss2", 2, "miss2", {}},
				{"empty_14"},
				{"modifier_woda_talent_attackspeed2", "#woda_talent_attackspeed2", 3, "attackspeed2", {}},
				{"modifier_dawnbreaker_13","#modifier_dawnbreaker_13", 2, "dawnbreaker/13", {}},
				{"empty_15"}
			},
			[7] = {
				{"empty_17"},
				{"empty_18"},
				{"modifier_dawnbreaker_14","#modifier_dawnbreaker_14", 1, "dawnbreaker/14", {}},
				{"empty_20"},
				{"empty_21"}
			}
		},
		[3] = {
			[1] = {
				{"modifier_woda_talent_mp1", "#woda_talent_mp1", 3, "mp1", {}},
				{"modifier_woda_talent_regenmp1", "#woda_talent_regenmp1", 2, "regenmp1", {}},
				{"modifier_woda_talent_spell", "#woda_talent_spell", 3, "spell", {}},
				{"modifier_dawnbreaker_15","#modifier_dawnbreaker_15", 2, "dawnbreaker/15", {}},
				{"modifier_woda_talent_int3", "#woda_talent_int3", 2, "int3", {}}
			},
			[2] = {
				{"empty_2"},
				{"empty_3"},
				{"modifier_dawnbreaker_16","#modifier_dawnbreaker_16", 3, "dawnbreaker/16", {}},
				{"modifier_woda_talent_blood", "#woda_talent_blood", 2, "blood", {}},
				{"modifier_woda_talent_int6", "#woda_talent_int6", 1, "int6", {"modifier_woda_talent_int3",2}}
			},
			[3] = {
				{"empty_6"},
				{"empty_7"},
				{"modifier_dawnbreaker_17","#modifier_dawnbreaker_17", 1, "dawnbreaker/17", {}},
				{"modifier_woda_talent_mask2", "#woda_talent_mask2", 2, "mask2", {}},
				{"modifier_woda_talent_kaya", "#woda_talent_kaya", 1, "kaya", {"modifier_woda_talent_int6",1}}
			},
			[4] = {
				{"modifier_woda_talent_mp2", "#woda_talent_mp2", 3, "mp2", {"modifier_woda_talent_mp1",3}},
				{"modifier_woda_talent_fairy", "#woda_talent_fairy", 2, "fairy", {}},
				{"empty_9"},
				{"modifier_dawnbreaker_18","#modifier_dawnbreaker_18", 3, "dawnbreaker/18", {}},
				{"modifier_woda_talent_int4", "#woda_talent_int4", 1, "int4", {"modifier_woda_talent_kaya",1}}
			},
			[5] = {
				{"modifier_woda_talent_spellprism", "#woda_talent_spellprism", 3, "spellprism", {}},
				{"empty_10"},
				{"modifier_dawnbreaker_19","#modifier_dawnbreaker_19", 2, "dawnbreaker/19", {"modifier_dawnbreaker_17",1}},
				{"empty_12"},
				{"modifier_woda_talent_int5", "#woda_talent_int5", 3, "int5", {"modifier_woda_talent_int4",1}}
			},
			[6] = {
				{"modifier_woda_talent_timeless", "#woda_talent_timeless", 2, "timeless", {}},
				{"modifier_woda_talent_regenmp2", "#woda_talent_regenmp2", 3, "regenmp2", {}},
				{"empty_14"},
				{"modifier_dawnbreaker_20","#modifier_dawnbreaker_20", 2, "dawnbreaker/20", {}},
				{"empty_16"}
			},
			[7] = {
				{"empty_17"},
				{"empty_18"},
				{"modifier_dawnbreaker_21","#modifier_dawnbreaker_21", 1, "dawnbreaker/21", {}},
				{"empty_20"},
				{"empty_21"}
			}
		}
	},
	["npc_dota_hero_chaos_knight"] = {
		[1] = {
			[1] = {
				{"modifier_woda_talent_hp1", "#woda_talent_hp1", 3, "hp1", {}},
				{"modifier_woda_talent_regenhp1", "#woda_talent_regenhp1", 2, "regenhp1", {}},
				{"modifier_woda_talent_attack1", "#woda_talent_attack1", 3, "attack1", {}},
				{"modifier_chaos_knight_1","#modifier_chaos_knight_1", 1, "chaos_knight/1", {}},
				{"modifier_woda_talent_str3", "#woda_talent_str3", 2, "str3", {}}
			},
			[2] = {
				{"empty_2"},
				{"modifier_chaos_knight_2","#modifier_chaos_knight_2", 2, "chaos_knight/2", {}},
				{"empty_3"},
				{"modifier_woda_talent_cloak", "#woda_talent_cloak", 2, "cloak", {}},
				{"modifier_woda_talent_str6", "#woda_talent_str6", 1, "str6", {"modifier_woda_talent_str3",2}}
			},
			[3] = {
				{"empty_6"},
				{"modifier_woda_talent_quickhp", "#woda_talent_quickhp", 2, "quickhp", {}},
				{"modifier_chaos_knight_3","#modifier_chaos_knight_3", 3, "chaos_knight/3", {}},
				{"empty_7"},
				{"modifier_woda_talent_sasha", "#woda_talent_sasha", 1, "sasha", {"modifier_woda_talent_str6",1}}
			},
			[4] = {
				{"modifier_woda_talent_hp2", "#woda_talent_hp2", 3, "hp2", {"modifier_woda_talent_hp1",3}},
				{"empty_9"},
				{"modifier_chaos_knight_4","#modifier_chaos_knight_4", 2, "chaos_knight/4", {}},
				{"modifier_woda_talent_octar", "#woda_talent_octar", 2, "octar", {}},
				{"modifier_woda_talent_str4", "#woda_talent_str4", 1, "str4", {"modifier_woda_talent_sasha",1}}
			},
			[5] = {
				{"modifier_woda_talent_armor2", "#woda_talent_armor2", 3, "armor2", {}},
				{"empty_10"},
				{"modifier_chaos_knight_5","#modifier_chaos_knight_5", 2, "chaos_knight/5", {}},
				{"empty_11"},
				{"modifier_woda_talent_str5", "#woda_talent_str5", 3, "str5", {"modifier_woda_talent_str4",1}}
			},
			[6] = {
				{"modifier_woda_talent_sliver", "#woda_talent_sliver", 2, "sliver", {}},
				{"modifier_woda_talent_regenhp2", "#woda_talent_regenhp2", 3, "regenhp2", {}},
				{"modifier_chaos_knight_6","#modifier_chaos_knight_6", 3, "chaos_knight/6", {}},
				{"empty_15"},
				{"empty_16"}
			},
			[7] = {
				{"empty_17"},
				{"empty_18"},
				{"modifier_chaos_knight_7","#modifier_chaos_knight_7", 1, "chaos_knight/7", {}},
				{"empty_20"},
				{"empty_21"}
			}
		},
		[2] = {
			[1] = {
				{"modifier_woda_talent_armor1", "#woda_talent_armor1", 3, "armor1", {}},
				{"modifier_woda_talent_speed1", "#woda_talent_speed1", 2, "speed1", {}},
				{"modifier_woda_talent_attackspeed1", "#woda_talent_attackspeed1", 3, "attackspeed1", {}},
				{"modifier_chaos_knight_8","#modifier_chaos_knight_8", 1, "chaos_knight/8", {}},
				{"modifier_woda_talent_agi3", "#woda_talent_agi3", 2, "agi3", {}}
			},
			[2] = {
				{"modifier_chaos_knight_9","#modifier_chaos_knight_9", 3, "chaos_knight/9", {}},
				{"empty_3"},
				{"empty_4"},
				{"modifier_woda_talent_miss1", "#woda_talent_miss1", 2, "miss1", {}},
				{"modifier_woda_talent_agi6", "#woda_talent_agi6", 1, "agi6", {"modifier_woda_talent_agi3",2}}
			},
			[3] = {
				{"empty_6"},
				{"empty_7"},
				{"modifier_chaos_knight_10","#modifier_chaos_knight_10", 2, "chaos_knight/10", {}},
				{"modifier_woda_talent_mask1", "#woda_talent_mask1", 2, "mask1", {}},
				{"modifier_woda_talent_yasha", "#woda_talent_yasha", 1, "yasha", {"modifier_woda_talent_agi6",1}}
			},
			[4] = {
				{"modifier_chaos_knight_11","#modifier_chaos_knight_11", 3, "chaos_knight/11", {}},
				{"modifier_woda_talent_speed2", "#woda_talent_speed2", 3, "speed2", {"modifier_woda_talent_speed1",2}},
				{"modifier_woda_talent_grovebow", "#woda_talent_grovebow", 2, "grovebow", {}},
				{"empty_10"},			
				{"modifier_woda_talent_agi4", "#woda_talent_agi4", 1, "agi4", {"modifier_woda_talent_yasha",1}}
			},
			[5] = {
				{"modifier_woda_talent_attack2", "#woda_talent_attack2", 3, "attack2", {}},
				{"modifier_chaos_knight_12","#modifier_chaos_knight_12", 1, "chaos_knight/12", {}},
				{"empty_11"},
				{"empty_12"},
				{"modifier_woda_talent_agi5", "#woda_talent_agi5", 3, "agi5", {"modifier_woda_talent_agi4",1}}
			},
			[6] = {
				{"modifier_woda_talent_miss2", "#woda_talent_miss2", 2, "miss2", {}},
				{"modifier_chaos_knight_13","#modifier_chaos_knight_13", 3, "chaos_knight/13", {}},
				{"modifier_woda_talent_attackspeed2", "#woda_talent_attackspeed2", 3, "attackspeed2", {}},
				{"empty_15"},
				{"empty_13"}
			},
			[7] = {
				{"empty_17"},
				{"empty_18"},
				{"modifier_chaos_knight_14","#modifier_chaos_knight_14", 1, "chaos_knight/14", {}},
				{"empty_20"},
				{"empty_21"}
			}
		},
		[3] = {
			[1] = {
				{"modifier_woda_talent_mp1", "#woda_talent_mp1", 3, "mp1", {}},
				{"modifier_woda_talent_regenmp1", "#woda_talent_regenmp1", 2, "regenmp1", {}},
				{"modifier_woda_talent_spell", "#woda_talent_spell", 3, "spell", {}},
				{"modifier_chaos_knight_15","#modifier_chaos_knight_15", 2, "chaos_knight/15", {}},
				{"modifier_woda_talent_int3", "#woda_talent_int3", 2, "int3", {}}
			},
			[2] = {
				{"empty_2"},
				{"modifier_chaos_knight_16","#modifier_chaos_knight_16", 3, "chaos_knight/16", {}},
				{"empty_3"},
				{"modifier_woda_talent_blood", "#woda_talent_blood", 2, "blood", {}},
				{"modifier_woda_talent_int6", "#woda_talent_int6", 1, "int6", {"modifier_woda_talent_int3",2}}
			},
			[3] = {
				{"empty_6"},
				{"empty_7"},
				{"modifier_chaos_knight_17","#modifier_chaos_knight_17", 3, "chaos_knight/17", {}},
				{"modifier_woda_talent_mask2", "#woda_talent_mask2", 2, "mask2", {}},
				{"modifier_woda_talent_kaya", "#woda_talent_kaya", 1, "kaya", {"modifier_woda_talent_int6",1}}
			},
			[4] = {
				{"modifier_woda_talent_mp2", "#woda_talent_mp2", 3, "mp2", {"modifier_woda_talent_mp1",3}},
				{"modifier_woda_talent_fairy", "#woda_talent_fairy", 2, "fairy", {}},
				{"empty_9"},
				{"modifier_chaos_knight_18","#modifier_chaos_knight_18", 2, "chaos_knight/18", {}},
				{"modifier_woda_talent_int4", "#woda_talent_int4", 1, "int4", {"modifier_woda_talent_kaya",1}}
			},
			[5] = {
				{"modifier_woda_talent_spellprism", "#woda_talent_spellprism", 3, "spellprism", {}},
				{"empty_10"},
				{"modifier_chaos_knight_19","#modifier_chaos_knight_19", 2, "chaos_knight/19", {}},
				{"empty_12"},
				{"modifier_woda_talent_int5", "#woda_talent_int5", 3, "int5", {"modifier_woda_talent_int4",1}}
			},
			[6] = {
				{"modifier_woda_talent_timeless", "#woda_talent_timeless", 2, "timeless", {}},
				{"modifier_woda_talent_regenmp2", "#woda_talent_regenmp2", 3, "regenmp2", {}},
				{"empty_14"},
				{"modifier_chaos_knight_20","#modifier_chaos_knight_20", 1, "chaos_knight/20", {}},
				{"empty_16"}
			},
			[7] = {
				{"empty_17"},
				{"empty_18"},
				{"modifier_chaos_knight_21","#modifier_chaos_knight_21", 1, "chaos_knight/21", {}},
				{"empty_20"},
				{"empty_21"}
			}
		}
	},
	["npc_dota_hero_ogre_magi"] = {
		[1] = {
			[1] = {
				{"modifier_woda_talent_hp1", "#woda_talent_hp1", 3, "hp1", {}},
				{"modifier_woda_talent_regenhp1", "#woda_talent_regenhp1", 2, "regenhp1", {}},
				{"modifier_woda_talent_attack1", "#woda_talent_attack1", 3, "attack1", {}},
				{"modifier_ogre_magi_1","#modifier_ogre_magi_1", 2, "ogre_magi/1", {}},
				{"modifier_woda_talent_str3", "#woda_talent_str3", 2, "str3", {}}
			},
			[2] = {
				{"empty_2"},
				{"modifier_ogre_magi_2","#modifier_ogre_magi_2", 1, "ogre_magi/2", {}},
				{"empty_3"},
				{"modifier_woda_talent_cloak", "#woda_talent_cloak", 2, "cloak", {}},
				{"modifier_woda_talent_str6", "#woda_talent_str6", 1, "str6", {"modifier_woda_talent_str3",2}}
			},
			[3] = {
				{"empty_6"},
				{"empty_7"},
				{"modifier_ogre_magi_3","#modifier_ogre_magi_3", 1, "ogre_magi/3", {}},
				{"modifier_woda_talent_quickhp", "#woda_talent_quickhp", 2, "quickhp", {}},
				{"modifier_woda_talent_sasha", "#woda_talent_sasha", 1, "sasha", {"modifier_woda_talent_str6",1}}
			},
			[4] = {
				{"modifier_woda_talent_hp2", "#woda_talent_hp2", 3, "hp2", {"modifier_woda_talent_hp1",3}},
				{"modifier_ogre_magi_4","#modifier_ogre_magi_4", 3, "ogre_magi/4", {"modifier_ogre_magi_2",1}},
				{"empty_9"},
				{"modifier_woda_talent_octar", "#woda_talent_octar", 2, "octar", {}},
				{"modifier_woda_talent_str4", "#woda_talent_str4", 1, "str4", {"modifier_woda_talent_sasha",1}}
			},
			[5] = {
				{"modifier_woda_talent_armor2", "#woda_talent_armor2", 3, "armor2", {}},
				{"modifier_ogre_magi_5","#modifier_ogre_magi_5", 3, "ogre_magi/5", {"modifier_ogre_magi_4",3}},
				{"empty_10"},
				{"empty_11"},
				{"modifier_woda_talent_str5", "#woda_talent_str5", 3, "str5", {"modifier_woda_talent_str4",1}}
			},
			[6] = {
				{"modifier_woda_talent_sliver", "#woda_talent_sliver", 2, "sliver", {}},
				{"modifier_woda_talent_regenhp2", "#woda_talent_regenhp2", 3, "regenhp2", {}},
				{"empty_15"},
				{"empty_16"},
				{"modifier_ogre_magi_6","#modifier_ogre_magi_6", 3, "ogre_magi/6", {}}
			},
			[7] = {
				{"empty_17"},
				{"empty_18"},
				{"modifier_ogre_magi_7","#modifier_ogre_magi_7", 1, "ogre_magi/7", {}},
				{"empty_20"},
				{"empty_21"}
			}
		},
		[2] = {
			[1] = {
				{"modifier_woda_talent_armor1", "#woda_talent_armor1", 3, "armor1", {}},
				{"modifier_woda_talent_speed1", "#woda_talent_speed1", 2, "speed1", {}},
				{"modifier_woda_talent_attackspeed1", "#woda_talent_attackspeed1", 3, "attackspeed1", {}},
				{"modifier_ogre_magi_8","#modifier_ogre_magi_8", 2, "ogre_magi/8", {}},
				{"modifier_woda_talent_agi3", "#woda_talent_agi3", 2, "agi3", {}}
			},
			[2] = {
				{"empty_2"},
				{"empty_3"},
				{"modifier_ogre_magi_9","#modifier_ogre_magi_9", 3, "ogre_magi/9", {}},
				{"modifier_woda_talent_miss1", "#woda_talent_miss1", 2, "miss1", {}},
				{"modifier_woda_talent_agi6", "#woda_talent_agi6", 1, "agi6", {"modifier_woda_talent_agi3",2}}
			},
			[3] = {
				{"empty_6"},
				{"empty_7"},
				{"modifier_ogre_magi_10","#modifier_ogre_magi_10", 2, "ogre_magi/10", {}},
				{"modifier_woda_talent_mask1", "#woda_talent_mask1", 2, "mask1", {}},
				{"modifier_woda_talent_yasha", "#woda_talent_yasha", 1, "yasha", {"modifier_woda_talent_agi6",1}}
			},
			[4] = {
				{"empty_8"},
				{"modifier_woda_talent_speed2", "#woda_talent_speed2", 3, "speed2", {"modifier_woda_talent_speed1",2}},
				{"modifier_woda_talent_grovebow", "#woda_talent_grovebow", 2, "grovebow", {}},
				{"modifier_ogre_magi_11","#modifier_ogre_magi_11", 3, "ogre_magi/11", {}},			
				{"modifier_woda_talent_agi4", "#woda_talent_agi4", 1, "agi4", {"modifier_woda_talent_yasha",1}}
			},
			[5] = {
				{"modifier_woda_talent_attack2", "#woda_talent_attack2", 3, "attack2", {}},
				{"empty_10"},
				{"modifier_ogre_magi_12","#modifier_ogre_magi_12", 2, "ogre_magi/12", {}},
				{"empty_12"},
				{"modifier_woda_talent_agi5", "#woda_talent_agi5", 3, "agi5", {"modifier_woda_talent_agi4",1}}
			},
			[6] = {
				{"modifier_woda_talent_miss2", "#woda_talent_miss2", 2, "miss2", {}},
				{"modifier_ogre_magi_13","#modifier_ogre_magi_13", 1, "ogre_magi/13", {}},
				{"modifier_woda_talent_attackspeed2", "#woda_talent_attackspeed2", 3, "attackspeed2", {}},
				{"empty_15"},
				{"empty_13"}
			},
			[7] = {
				{"empty_17"},
				{"empty_18"},
				{"modifier_ogre_magi_14","#modifier_ogre_magi_14", 1, "ogre_magi/14", {}},
				{"empty_20"},
				{"empty_21"}
			}
		},
		[3] = {
			[1] = {
				{"modifier_woda_talent_mp1", "#woda_talent_mp1", 3, "mp1", {}},
				{"modifier_woda_talent_regenmp1", "#woda_talent_regenmp1", 2, "regenmp1", {}},
				{"modifier_woda_talent_spell", "#woda_talent_spell", 3, "spell", {}},
				{"modifier_ogre_magi_15","#modifier_ogre_magi_15", 2, "ogre_magi/15", {}},
				{"modifier_woda_talent_int3", "#woda_talent_int3", 2, "int3", {}}
			},
			[2] = {
				{"empty_2"},
				{"empty_3"},
				{"modifier_ogre_magi_16","#modifier_ogre_magi_16", 2, "ogre_magi/16", {}},
				{"modifier_woda_talent_blood", "#woda_talent_blood", 2, "blood", {}},
				{"modifier_woda_talent_int6", "#woda_talent_int6", 1, "int6", {"modifier_woda_talent_int3",2}}
			},
			[3] = {
				{"empty_6"},
				{"empty_7"},
				{"modifier_ogre_magi_17","#modifier_ogre_magi_17", 2, "ogre_magi/17", {}},
				{"modifier_woda_talent_mask2", "#woda_talent_mask2", 2, "mask2", {}},
				{"modifier_woda_talent_kaya", "#woda_talent_kaya", 1, "kaya", {"modifier_woda_talent_int6",1}}
			},
			[4] = {
				{"modifier_woda_talent_mp2", "#woda_talent_mp2", 3, "mp2", {"modifier_woda_talent_mp1",3}},
				{"modifier_woda_talent_fairy", "#woda_talent_fairy", 2, "fairy", {}},
				{"modifier_ogre_magi_18","#modifier_ogre_magi_18", 3, "ogre_magi/18", {}},
				{"empty_9"},
				{"modifier_woda_talent_int4", "#woda_talent_int4", 1, "int4", {"modifier_woda_talent_kaya",1}}
			},
			[5] = {
				{"modifier_woda_talent_spellprism", "#woda_talent_spellprism", 3, "spellprism", {}},
				{"empty_10"},
				{"empty_11"},
				{"modifier_ogre_magi_19","#modifier_ogre_magi_19", 2, "ogre_magi/19", {}},
				{"modifier_woda_talent_int5", "#woda_talent_int5", 3, "int5", {"modifier_woda_talent_int4",1}}
			},
			[6] = {
				{"modifier_woda_talent_timeless", "#woda_talent_timeless", 2, "timeless", {}},
				{"modifier_woda_talent_regenmp2", "#woda_talent_regenmp2", 3, "regenmp2", {}},
				{"empty_14"},
				{"modifier_ogre_magi_20","#modifier_ogre_magi_20", 2, "ogre_magi/20", {"modifier_ogre_magi_19",2}},
				{"empty_16"}
			},
			[7] = {
				{"empty_17"},
				{"empty_18"},
				{"modifier_ogre_magi_21","#modifier_ogre_magi_21", 1, "ogre_magi/21", {}},
				{"empty_20"},
				{"empty_21"}
			}
		}
	},
	["npc_dota_hero_visage"] = {
		[1] = {
			[1] = {
				{"modifier_woda_talent_hp1", "#woda_talent_hp1", 3, "hp1", {}},
				{"modifier_woda_talent_regenhp1", "#woda_talent_regenhp1", 2, "regenhp1", {}},
				{"modifier_woda_talent_attack1", "#woda_talent_attack1", 3, "attack1", {}},
				{"modifier_visage_1","#modifier_visage_1", 2, "visage/1", {}},
				{"modifier_woda_talent_str3", "#woda_talent_str3", 2, "str3", {}}
			},
			[2] = {
				{"empty_2"},
				{"modifier_visage_2","#modifier_visage_2", 3, "visage/2", {}},
				{"empty_3"},
				{"modifier_woda_talent_cloak", "#woda_talent_cloak", 2, "cloak", {}},
				{"modifier_woda_talent_str6", "#woda_talent_str6", 1, "str6", {"modifier_woda_talent_str3",2}}
			},
			[3] = {
				{"empty_6"},
				{"modifier_woda_talent_quickhp", "#woda_talent_quickhp", 2, "quickhp", {}},
				{"modifier_visage_3","#modifier_visage_3", 2, "visage/3", {}},
				{"empty_7"},
				{"modifier_woda_talent_sasha", "#woda_talent_sasha", 1, "sasha", {"modifier_woda_talent_str6",1}}
			},
			[4] = {
				{"modifier_woda_talent_hp2", "#woda_talent_hp2", 3, "hp2", {"modifier_woda_talent_hp1",3}},
				{"modifier_visage_4","#modifier_visage_4", 2, "visage/4", {}},
				{"empty_9"},
				{"modifier_woda_talent_octar", "#woda_talent_octar", 2, "octar", {}},
				{"modifier_woda_talent_str4", "#woda_talent_str4", 1, "str4", {"modifier_woda_talent_sasha",1}}
			},
			[5] = {
				{"modifier_woda_talent_armor2", "#woda_talent_armor2", 3, "armor2", {}},
				{"empty_10"},
				{"modifier_visage_5","#modifier_visage_5", 1, "visage/5", {}},
				{"empty_11"},
				{"modifier_woda_talent_str5", "#woda_talent_str5", 3, "str5", {"modifier_woda_talent_str4",1}}
			},
			[6] = {
				{"modifier_woda_talent_sliver", "#woda_talent_sliver", 2, "sliver", {}},
				{"modifier_woda_talent_regenhp2", "#woda_talent_regenhp2", 3, "regenhp2", {}},
				{"modifier_visage_6","#modifier_visage_6", 3, "visage/6", {"modifier_visage_5",1}},
				{"empty_15"},
				{"empty_16"}
			},
			[7] = {
				{"empty_17"},
				{"empty_18"},
				{"modifier_visage_7","#modifier_visage_7", 1, "visage/7", {}},
				{"empty_20"},
				{"empty_21"}
			}
		},
		[2] = {
			[1] = {
				{"modifier_woda_talent_armor1", "#woda_talent_armor1", 3, "armor1", {}},
				{"modifier_woda_talent_speed1", "#woda_talent_speed1", 2, "speed1", {}},
				{"modifier_woda_talent_attackspeed1", "#woda_talent_attackspeed1", 3, "attackspeed1", {}},
				{"modifier_visage_9","#modifier_visage_9", 2, "visage/9", {}},
				{"modifier_woda_talent_agi3", "#woda_talent_agi3", 2, "agi3", {}}
			},
			[2] = {
				{"modifier_visage_8","#modifier_visage_8", 2, "visage/8", {}},
				{"empty_3"},
				{"empty_4"},
				{"modifier_woda_talent_miss1", "#woda_talent_miss1", 2, "miss1", {}},
				{"modifier_woda_talent_agi6", "#woda_talent_agi6", 1, "agi6", {"modifier_woda_talent_agi3",2}}
			},
			[3] = {
				{"empty_6"},
				{"empty_7"},
				{"modifier_visage_10","#modifier_visage_10", 2, "visage/10", {}},
				{"modifier_woda_talent_mask1", "#woda_talent_mask1", 2, "mask1", {}},
				{"modifier_woda_talent_yasha", "#woda_talent_yasha", 1, "yasha", {"modifier_woda_talent_agi6",1}}
			},
			[4] = {
				{"modifier_visage_11","#modifier_visage_11", 2, "visage/11", {}},
				{"modifier_woda_talent_speed2", "#woda_talent_speed2", 3, "speed2", {"modifier_woda_talent_speed1",2}},
				{"modifier_woda_talent_grovebow", "#woda_talent_grovebow", 2, "grovebow", {}},
				{"empty_10"},			
				{"modifier_woda_talent_agi4", "#woda_talent_agi4", 1, "agi4", {"modifier_woda_talent_yasha",1}}
			},
			[5] = {
				{"modifier_woda_talent_attack2", "#woda_talent_attack2", 3, "attack2", {}},
				{"empty_11"},
				{"empty_12"},
				{"modifier_visage_12","#modifier_visage_12", 3, "visage/12", {}},
				{"modifier_woda_talent_agi5", "#woda_talent_agi5", 3, "agi5", {"modifier_woda_talent_agi4",1}}
			},
			[6] = {
				{"modifier_woda_talent_miss2", "#woda_talent_miss2", 2, "miss2", {}},
				{"modifier_visage_13","#modifier_visage_13", 2, "visage/13", {}},
				{"modifier_woda_talent_attackspeed2", "#woda_talent_attackspeed2", 3, "attackspeed2", {}},
				{"empty_15"},
				{"empty_13"}
			},
			[7] = {
				{"empty_17"},
				{"empty_18"},
				{"modifier_visage_14","#modifier_visage_14", 1, "visage/14", {}},
				{"empty_20"},
				{"empty_21"}
			}
		},
		[3] = {
			[1] = {
				{"modifier_woda_talent_mp1", "#woda_talent_mp1", 3, "mp1", {}},
				{"modifier_woda_talent_regenmp1", "#woda_talent_regenmp1", 2, "regenmp1", {}},
				{"modifier_woda_talent_spell", "#woda_talent_spell", 3, "spell", {}},
				{"modifier_visage_16","#modifier_visage_16", 3, "visage/16", {}},
				{"modifier_woda_talent_int3", "#woda_talent_int3", 2, "int3", {}}
			},
			[2] = {
				{"empty_2"},
				{"empty_3"},
				{"modifier_visage_15","#modifier_visage_15", 2, "visage/15", {}},
				{"modifier_woda_talent_blood", "#woda_talent_blood", 2, "blood", {}},
				{"modifier_woda_talent_int6", "#woda_talent_int6", 1, "int6", {"modifier_woda_talent_int3",2}}
			},
			[3] = {
				{"empty_6"},
				{"empty_7"},
				{"modifier_visage_17","#modifier_visage_17", 2, "visage/17", {}},
				{"modifier_woda_talent_mask2", "#woda_talent_mask2", 2, "mask2", {}},
				{"modifier_woda_talent_kaya", "#woda_talent_kaya", 1, "kaya", {"modifier_woda_talent_int6",1}}
			},
			[4] = {
				{"modifier_woda_talent_mp2", "#woda_talent_mp2", 3, "mp2", {"modifier_woda_talent_mp1",3}},
				{"modifier_woda_talent_fairy", "#woda_talent_fairy", 2, "fairy", {}},
				{"empty_9"},
				{"modifier_visage_20","#modifier_visage_20", 2, "visage/20", {}},
				{"modifier_woda_talent_int4", "#woda_talent_int4", 1, "int4", {"modifier_woda_talent_kaya",1}}
			},
			[5] = {
				{"modifier_woda_talent_spellprism", "#woda_talent_spellprism", 3, "spellprism", {}},
				{"modifier_visage_18","#modifier_visage_18", 2, "visage/18", {}},
				{"empty_10"},
				{"empty_12"},
				{"modifier_woda_talent_int5", "#woda_talent_int5", 3, "int5", {"modifier_woda_talent_int4",1}}
			},
			[6] = {
				{"modifier_woda_talent_timeless", "#woda_talent_timeless", 2, "timeless", {}},
				{"modifier_woda_talent_regenmp2", "#woda_talent_regenmp2", 3, "regenmp2", {}},
				{"modifier_visage_19","#modifier_visage_19", 2, "visage/19", {}},
				{"empty_14"},
				{"empty_16"}
			},
			[7] = {
				{"empty_17"},
				{"empty_18"},
				{"modifier_visage_21","#modifier_visage_21", 1, "visage/21", {}},
				{"empty_20"},
				{"empty_21"}
			}
		}
	}
}