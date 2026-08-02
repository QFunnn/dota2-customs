--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build b9dc48c · 2026-08-02 17:42:46 UTC
  ~ auto-generated — do not edit
]]


GameUI.CustomUIConfig().info_item_blessing = {
	"101": {
		id: 101,
		name: "月卡",
		effect: "六位Id的生成规则: 3+m+0+xym 其中xyz是祝福id m为过期时间的标记 1-永久 2-3天 3-7天 4-30天",
		attribute: {
			equip_drop_pct: 15,
			resource_profit_stone_pct: 15,
			resource_profit_forge_pct: 15,
			resource_profit_210001_pct: 15
		},
		blessing_effect: "privilege_031|privilege_033|privilege_037",
		hide: 0
	},
	"102": {
		id: 102,
		name: "永久卡",
		attribute: {
			equip_rarity_chance: 30,
			equip_extra_potential: 2,
			equip_drop_pct: 20,
			resource_profit_stone_pct: 20,
			resource_profit_forge_pct: 20,
			resource_profit_210001_pct: 20,
			resource_profit_talent_pct: 20
		},
		blessing_effect: "privilege_032|privilege_034|privilege_038",
		hide: 0
	},
	"103": {
		id: 103,
		name: "钓鱼卡",
		attribute: {
			idle_max_power: 300,
			idle_fish_lucky_num: 3,
			idle_fish_interaction_pct: 10,
			idle_fish_escape_speed_pct: 10,
			idle_fish_courier_slot: 1,
			aquarium_slot: 3,
			idle_fish_crit_chance: 5,
			idle_fish_crit_num: 30,
			idle_fish_wait_time_reduce_pct: 15
		},
		blessing_effect: "privilege_035",
		hide: 0
	},
	"104": {
		id: 104,
		name: "探险卡",
		attribute: {
			explore_profit_110005_pct: 40,
			explore_extra_chance: 3,
			explore_extra_profit_pct: 20
		},
		blessing_effect: "privilege_idle_explore_043|privilege_idle_explore_044|privilege_039|privilege_036|privilege_explore_slot",
		hide: 0
	},
	"501": {
		id: 501,
		name: "启示圣契",
		attribute: {
			damage_intensity: 50,
			defense_intensity: 50,
			hero_damage_boost: 5
		},
		blessing_effect: "privilege_bless_001",
		hide: 1
	},
	"502": {
		id: 502,
		name: "神杖圣契",
		attribute: {
			damage_intensity: 50,
			defense_intensity: 50,
			hero_damage_boost: 5
		},
		blessing_effect: "privilege_bless_002",
		hide: 0
	},
	"503": {
		id: 503,
		name: "商店圣契",
		attribute: {
			damage_intensity: 50,
			defense_intensity: 50,
			hero_damage_boost: 5
		},
		blessing_effect: "privilege_bless_003",
		hide: 1
	},
	"504": {
		id: 504,
		name: "复活圣契",
		attribute: {
			damage_intensity: 50,
			defense_intensity: 50,
			hero_damage_boost: 5,
			revive_health_recover: 30
		},
		blessing_effect: "privilege_bless_004",
		hide: 1
	},
	"505": {
		id: 505,
		name: "史诗圣契",
		attribute: {
			damage_intensity: 30,
			defense_intensity: 30,
			hero_damage_boost: 3,
			ability_upgrade_count: 1
		},
		hide: 1
	},
	"506": {
		id: 506,
		name: "许愿圣契",
		attribute: {
			damage_intensity: 30,
			defense_intensity: 30,
			hero_damage_boost: 3
		},
		blessing_effect: "privilege_bless_005",
		hide: 1
	},
	"507": {
		id: 507,
		name: "幸运圣契",
		attribute: {
			damage_intensity: 30,
			defense_intensity: 30,
			hero_damage_boost: 3
		},
		blessing_effect: "privilege_bless_006",
		hide: 1
	},
	"508": {
		id: 508,
		name: "陷阱圣契",
		attribute: {
			damage_intensity: 30,
			defense_intensity: 30,
			hero_damage_boost: 3
		},
		blessing_effect: "privilege_bless_008",
		hide: 1
	},
	"509": {
		id: 509,
		name: "酒馆圣契",
		attribute: {
			damage_intensity: 20,
			defense_intensity: 20,
			hero_damage_boost: 1,
			tavern_effect_amplify: 50
		},
		hide: 1
	},
	"510": {
		id: 510,
		name: "打折卡圣契",
		attribute: {
			damage_intensity: 20,
			defense_intensity: 20,
			hero_damage_boost: 1,
			initial_gold: 100
		},
		blessing_effect: "privilege_bless_007",
		hide: 0
	},
	"511": {
		id: 511,
		name: "雷电圣契",
		attribute: {
			damage_intensity: 20,
			defense_intensity: 20,
			hero_damage_boost: 1,
			zeus_bless_rarity_up: 10
		},
		hide: 1
	},
	"512": {
		id: 512,
		name: "剧毒圣契",
		attribute: {
			damage_intensity: 20,
			defense_intensity: 20,
			hero_damage_boost: 1,
			poison_bless_rarity_up: 10
		},
		hide: 1
	},
	"513": {
		id: 513,
		name: "冰冻圣契",
		attribute: {
			damage_intensity: 20,
			defense_intensity: 20,
			hero_damage_boost: 1,
			ice_bless_rarity_up: 10
		},
		hide: 1
	},
	"514": {
		id: 514,
		name: "狂暴圣契",
		attribute: {
			damage_intensity: 20,
			defense_intensity: 20,
			hero_damage_boost: 1,
			bleed_bless_rarity_up: 10
		},
		hide: 1
	},
	"515": {
		id: 515,
		name: "暴击圣契",
		attribute: {
			damage_intensity: 20,
			defense_intensity: 20,
			hero_damage_boost: 1,
			crit_bless_rarity_up: 10
		},
		hide: 1
	},
	"516": {
		id: 516,
		name: "神圣圣契",
		attribute: {
			damage_intensity: 20,
			defense_intensity: 20,
			hero_damage_boost: 1,
			holy_bless_rarity_up: 10
		},
		hide: 1
	},
	"517": {
		id: 517,
		name: "御风圣契",
		attribute: {
			damage_intensity: 20,
			defense_intensity: 20,
			hero_damage_boost: 1,
			wind_bless_rarity_up: 10
		},
		hide: 1
	},
	"518": {
		id: 518,
		name: "金币圣契",
		attribute: {
			damage_intensity: 20,
			defense_intensity: 20,
			hero_damage_boost: 1,
			initial_gold: 100
		},
		hide: 1
	},
	"519": {
		id: 519,
		name: "破坏圣契",
		attribute: {
			damage_intensity: 20,
			defense_intensity: 20,
			hero_damage_boost: 1
		},
		blessing_effect: "privilege_bless_009",
		hide: 1
	},
	"520": {
		id: 520,
		name: "神风圣契",
		attribute: {
			damage_intensity: 20,
			defense_intensity: 20,
			hero_damage_boost: 1
		},
		blessing_effect: "privilege_bless_010",
		hide: 1
	},
	"521": {
		id: 521,
		name: "升华圣契",
		attribute: {
			damage_intensity: 10,
			defense_intensity: 10,
			hero_damage_boost: 3,
			final_damage: 1
		},
		blessing_effect: "privilege_029",
		hide: 0
	},
	"522": {
		id: 522,
		name: "洗练圣契",
		attribute: {
			damage_intensity: 15,
			defense_intensity: 15,
			hero_damage_boost: 5,
			final_damage: 3,
			refine_inc_pct: 100
		},
		hide: 0
	},
	"523": {
		id: 523,
		name: "神眷圣契",
		attribute: {
			damage_intensity: 20,
			defense_intensity: 20,
			damage_intensity_boost: 10,
			defense_intensity_boost: 10,
			hero_damage_boost: 8,
			final_damage: 5,
			total_drop_num_pct: 50
		},
		hide: 0
	},
	"524": {
		id: 524,
		name: "精良珍宝圣契",
		attribute: {
			damage_intensity: 10,
			defense_intensity: 10,
			hero_damage_boost: 4,
			final_damage: 3
		},
		blessing_effect: "privilege_vip_001",
		hide: 0
	},
	"525": {
		id: 525,
		name: "稀有珍宝圣契",
		attribute: {
			damage_intensity: 15,
			defense_intensity: 15,
			hero_damage_boost: 5,
			final_damage: 3
		},
		blessing_effect: "privilege_vip_002",
		hide: 0
	},
	"526": {
		id: 526,
		name: "史诗珍宝圣契",
		attribute: {
			damage_intensity: 20,
			defense_intensity: 20,
			hero_damage_boost: 6,
			final_damage: 4
		},
		blessing_effect: "privilege_vip_003",
		hide: 0
	},
	"527": {
		id: 527,
		name: "传说珍宝圣契",
		attribute: {
			damage_intensity: 20,
			defense_intensity: 20,
			hero_damage_boost: 8,
			final_damage: 5
		},
		blessing_effect: "privilege_vip_005",
		hide: 0
	},
	"528": {
		id: 528,
		name: "祝福圣契",
		attribute: {
			damage_intensity: 50,
			defense_intensity: 50,
			hero_damage_boost: 5,
			zeus_bless_rarity_up: 10,
			poison_bless_rarity_up: 10,
			ice_bless_rarity_up: 10,
			bleed_bless_rarity_up: 10,
			crit_bless_rarity_up: 10,
			holy_bless_rarity_up: 10,
			wind_bless_rarity_up: 10
		},
		hide: 0
	},
	"529": {
		id: 529,
		name: "遗物圣契",
		attribute: {
			damage_intensity: 50,
			defense_intensity: 50,
			hero_damage_boost: 5
		},
		blessing_effect: "privilege_bless_018",
		hide: 0
	},
	"530": {
		id: 530,
		name: "月华圣契",
		attribute: {
			damage_intensity: 10,
			defense_intensity: 10,
			hero_damage_boost: 3
		},
		hide: 0
	},
	"531": {
		id: 531,
		name: "龙蛋圣契",
		attribute: {
			damage_intensity: 10,
			defense_intensity: 10,
			hero_damage_boost: 3
		},
		blessing_effect: "privilege_bless_019|privilege_bless_028",
		hide: 0
	},
	"532": {
		id: 532,
		name: "召唤圣契",
		attribute: {
			damage_intensity: 10,
			defense_intensity: 10,
			hero_damage_boost: 3,
			final_damage: 1,
			wisp_attackspeed: 10
		},
		hide: 0
	},
	"533": {
		id: 533,
		name: "米波圣契",
		attribute: {
			damage_intensity: 10,
			defense_intensity: 10,
			hero_damage_boost: 3,
			final_damage: 1
		},
		blessing_effect: "privilege_bless_024",
		hide: 0
	},
	"534": {
		id: 534,
		name: "遗物圣契",
		attribute: {
			damage_intensity: 10,
			defense_intensity: 10,
			hero_damage_boost: 3,
			final_damage: 1,
			artifact_item_rarity: 20
		},
		hide: 0
	},
	"535": {
		id: 535,
		name: "临别圣契",
		attribute: {
			damage_intensity: 10,
			defense_intensity: 10,
			hero_damage_boost: 3,
			final_damage: 1
		},
		blessing_effect: "privilege_bless_025",
		hide: 0
	},
	"536": {
		id: 536,
		name: "升级圣契",
		attribute: {
			damage_intensity: 10,
			defense_intensity: 10,
			hero_damage_boost: 3,
			final_damage: 1
		},
		blessing_effect: "privilege_bless_027",
		hide: 0
	},
	"537": {
		id: 537,
		name: "强化圣契",
		attribute: {
			damage_intensity: 10,
			defense_intensity: 10,
			hero_damage_boost: 3,
			final_damage: 1
		},
		blessing_effect: "privilege_bless_026",
		hide: 0
	},
	"538": {
		id: 538,
		name: "觉醒圣契",
		attribute: {
			damage_intensity: 10,
			defense_intensity: 10,
			hero_damage_boost: 3,
			final_damage: 1,
			ability_upgrade_allin_count: 1,
			bless_allin_count: 1,
			bless_upgrade_allin_count: 1,
			artifact_allin_count: 1
		},
		hide: 0
	}
};