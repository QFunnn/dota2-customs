--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 9d26fbd · 2026-08-07 04:51:43 UTC
  ~ auto-generated — do not edit
]]


GameUI.CustomUIConfig().GreevilEffectKV = {
	"greevil_effect_replace": {
		"Note": "空壳",
		"ScriptFile": "",
		"hero_name": "",
		"link_ability": "",
		"AbilityTextureName": "greevil_effect_icon",
	},
	"greevil_effect_1": {
		"Note": "每消耗200点魔法，获得30点护盾",
		"ScriptFile": "abilities/greevil_effect/greevil_effect_ability_upgrade",
		"hero_name": "crystal_maiden",
		"link_ability": "crystal_maiden_talent",
		"AbilityTextureName": "crystal_maiden_crystal_nova_icecowl",
		"AbilityValues": {
			"mana_cost": 100,
			"shield": 30,
		},
	},
	"greevil_effect_2": {
		"Note": "购买后，每次战斗胜利+【生命流经验*1】的固定生命值",
		"ScriptFile": "abilities/greevil_effect/greevil_effect_ability_upgrade",
		"hero_name": "pudge",
		"link_ability": "pudge_talent",
		"AbilityValues": {
			"max_health": 60,
		},
		"AbilityTextureName": "pudge/scavenger_dragon_ability/pudge_flesh_heap",
	},
	"greevil_effect_3": {
		"Note": "未闪避敌方普通攻击时有20%几率免疫此次伤害，并释放50%伤害的大招",
		"ScriptFile": "abilities/greevil_effect/greevil_effect_ability_upgrade",
		"hero_name": "hoodwink",
		"link_ability": "hoodwink_ult",
		"AbilityValues": {
			"chance": 15,
		},
		"AbilityTextureName": "hoodwink_bushwhack",
	},
	"greevil_effect_4": {
		"Note": "消耗当前未购买魔晶的其他玩家数*300金币，每有一个玩家在此之后购买魔晶，返还500金币并获得100点最大生命值//购买时需要判断金币是否足够",
		"ScriptFile": "abilities/greevil_effect/greevil_effect_4",
		"hero_name": "alchemist",
		"link_ability": "alchemist_talent",
		"AbilityValues": {
			"gold_cost": 200,
			"gold_get": 500,
			"health_bonus": 100,
		},
		"AbilityTextureName": "alchemist_goblins_greed",
	},
	"greevil_effect_5": {
		"Note": "每场战斗失败+2免费刷新次数，每场战斗胜利+10利息上限",
		"ScriptFile": "abilities/greevil_effect/greevil_effect_5",
		"hero_name": "alchemist",
		"link_ability": "alchemist_talent",
		"AbilityValues": {
			"free_refresh_count": 2,
			"interest_limit": 10,
		},
		"AbilityTextureName": "alchemist_goblins_greed",
	},
	"greevil_effect_6": {
		"Note": "静电连接附带40%攻击力的伤害，每次触发静电连接偷取敌方6点攻击力和10点攻速，最多10层。满层后持续3秒清空层数。不再获得魔法值。",
		"ScriptFile": "abilities/greevil_effect/greevil_effect_ability_upgrade",
		"hero_name": "razor",
		"link_ability": "razor_talent",
		"AbilityValues": {
			"talent_damage_bonus": 40,
			"steal_damage": 7,
			"steal_attackspeed": 10,
			"max_stack": 10,
			"max_duration": 3,
		},
		"AbilityTextureName": "razor_static_link_alt",
	},
	"greevil_effect_7": {
		"Note": "强化15级天赋左：期间-0.15攻击间隔，效果结束时溢出的吸血回复量在2秒内每0.5秒回复25%",
		"ScriptFile": "abilities/greevil_effect/greevil_effect_ability_upgrade",
		"hero_name": "broodmother",
		"link_ability": "broodmother_talent_5",
		"AbilityValues": {
			"reduce_attack_interval": 0.15,
			"duration": 1.6,
			"interval": 0.4,
			"reply_pct": 25,
		},
		"AbilityTextureName": "broodmother/virulent_matriarch/broodmother_incapacitating_bite",
	},
	"greevil_effect_8": {
		"Note": "奥法鹰隼有15%概率释放2次，并沉默敌方0.5秒",
		"ScriptFile": "abilities/greevil_effect/greevil_effect_ability_upgrade",
		"hero_name": "skywrath_mage",
		"link_ability": "skywrath_mage_talent",
		"AbilityValues": {
			"chance": 24,
			"slience": 0.6,
		},
		"AbilityTextureName": "skywrath_mage_arcane_bolt_ti9_crimson",
	},
	"greevil_effect_9": {
		"Note": "每场战斗胜利+1纪念品层数，每场战斗失败-2纪念品层数并回复2点玩家生命",
		"ScriptFile": "abilities/greevil_effect/greevil_effect_ability_upgrade",
		"hero_name": "ringmaster",
		"link_ability": "ringmaster_talent",
		"AbilityValues": {
			"stack_add": 1,
			"stack_lose": 2,
			"health_add": 2,
		},
		"AbilityTextureName": "ringmaster_spotlight",
	},
	"greevil_effect_10": {
		"Note": "死亡霜雾期间+攻击附带100点魔法伤害",
		"ScriptFile": "abilities/greevil_effect/greevil_effect_ability_upgrade",
		"hero_name": "ancient_apparition",
		"link_ability": "ancient_apparition_talent",
		"AbilityValues": {
			"magic_damage": 100,
		},
		"AbilityTextureName": "ancient_apparition_chilling_touch",
	},
	"greevil_effect_11": {
		"Note": "每张已拥有的不同普通技能会使传说技能伤害+5",
		"ScriptFile": "abilities/greevil_effect/greevil_effect_ability_upgrade",
		"hero_name": "tinker",
		"link_ability": "tinker_talent",
		"AbilityValues": {
			"skill_damage_bonus": 5,
		},
		"AbilityTextureName": "tinker_rearm",
	},
	"greevil_effect_12": {
		"Note": "每张满级的普通技能提供0.4%的全伤害增强",
		"ScriptFile": "abilities/greevil_effect/greevil_effect_12",
		"hero_name": "",
		"link_ability": "",
		"AbilityValues": {
			"damage_bonus": 0.4,
		},
		"AbilityTextureName": "greevil_effect_icon",
	},
	"greevil_effect_13": {
		"Note": "当你达到20级时，或者30次免费刷新",
		"ScriptFile": "abilities/greevil_effect/greevil_effect_13",
		"hero_name": "",
		"link_ability": "",
		"AbilityValues": {
			"level_target": 20,
			"free_refresh_count": 30,
		},
		"AbilityTextureName": "greevil_effect_icon",
	},
	"greevil_effect_14": {
		"Note": "接下来的4回合你无法购买技能，结束后获得400金币",
		"ScriptFile": "abilities/greevil_effect/greevil_effect_14",
		"hero_name": "",
		"link_ability": "",
		"AbilityValues": {
			"round_ban": 3,
			"gold_get": 400,
		},
		"AbilityTextureName": "greevil_effect_icon",
	},
	"greevil_effect_15": {
		"Note": "获得10技能吸血。治疗对敌方玩家造成伤害的15%",
		"ScriptFile": "abilities/greevil_effect/greevil_effect_15",
		"hero_name": "",
		"link_ability": "",
		"AbilityValues": {
			"skill_steal_health": 10,
			"heal_damage_pct": 20,
		},
		"AbilityTextureName": "greevil_effect_icon",
	},
	"greevil_effect_16": {
		"Note": "你购买的下一个稀有技能立即升至满级",
		"ScriptFile": "abilities/greevil_effect/greevil_effect_16",
		"hero_name": "",
		"link_ability": "",
		"AbilityValues": {
			"limit": 1,
		},
		"AbilityTextureName": "greevil_effect_icon",
	},
	"greevil_effect_17": {
		"Note": "在战斗开始后12秒，回复60%已损失生命值",
		"ScriptFile": "abilities/greevil_effect/greevil_effect_17",
		"hero_name": "",
		"link_ability": "",
		"AbilityValues": {
			"second": 10,
			"health_reply_pct": 60,
		},
		"AbilityTextureName": "greevil_effect_icon",
	},
	"greevil_effect_18": {
		"Note": "获得400点生命、4%物理伤害增强、4%魔法伤害增强、4%物理伤害减免、4%魔法伤害减免、10点攻速、4点魔法回复",
		"ScriptFile": "abilities/greevil_effect/greevil_effect_18",
		"hero_name": "",
		"link_ability": "",
		"AbilityValues": {
			"health_bonus": 400,
			"physical_bonus_pct": 4,
			"magic_bonus_pct": 4,
			"physical_reduce_pct": 4,
			"magic_reduce_pct": 4,
			"attackspeed_bonus": 10,
			"mana_reply_bonus": 4,
		},
		"AbilityTextureName": "greevil_effect_icon",
	},
	"greevil_effect_19": {
		"Note": "获得6点生命值，你商店最右边的技能消耗10%金币价格的玩家生命，而非金币",
		"ScriptFile": "abilities/greevil_effect/greevil_effect_19",
		"hero_name": "",
		"link_ability": "",
		"AbilityValues": {
			"health": 6,
			"gold_health_pctg": 1,
		},
		"AbilityTextureName": "greevil_effect_icon",
	},
	"greevil_effect_20": {
		"Note": "在玩家战斗后，胜利则获得2点流派经验，失败则获得2次免费刷新",
		"ScriptFile": "abilities/greevil_effect/greevil_effect_20",
		"hero_name": "",
		"link_ability": "",
		"AbilityValues": {
			"sect_exp": 2,
			"refresh_free": 3,
		},
		"AbilityTextureName": "greevil_effect_icon",
	},
	"greevil_effect_21": {
		"Note": "获得200金币，你的最大利息上限提升20",
		"ScriptFile": "abilities/greevil_effect/greevil_effect_21",
		"hero_name": "",
		"link_ability": "",
		"AbilityValues": {
			"gold": 200,
			"interest_limit_bonus": 30,
		},
		"AbilityTextureName": "greevil_effect_icon",
	},
	"greevil_effect_22": {
		"Note": "获得300金币，你的最大利息上限提升30",
		"ScriptFile": "abilities/greevil_effect/greevil_effect_22",
		"hero_name": "",
		"link_ability": "",
		"AbilityValues": {
			"gold": 300,
			"interest_limit_bonus": 50,
		},
		"AbilityTextureName": "greevil_effect_icon",
	},
	"greevil_effect_23": {
		"Note": "每场对战后获得2点玩家生命和50金币",
		"ScriptFile": "abilities/greevil_effect/greevil_effect_23",
		"hero_name": "",
		"link_ability": "",
		"AbilityValues": {
			"health": 1,
			"gold": 50,
		},
		"AbilityTextureName": "greevil_effect_icon",
	},
	"greevil_effect_24": {
		"Note": "每个回合商店自动刷新必定为稀有技能",
		"ScriptFile": "abilities/greevil_effect/greevil_effect_24",
		"hero_name": "",
		"link_ability": "",
		"AbilityTextureName": "greevil_effect_icon",
	},
	"greevil_effect_25": {
		"Note": "每回合从商店复制1张普通技能",
		"ScriptFile": "abilities/greevil_effect/greevil_effect_25",
		"hero_name": "",
		"link_ability": "",
		"AbilityValues": {
			"count": 1,
		},
		"AbilityTextureName": "greevil_effect_icon",
	},
	"greevil_effect_26": {
		"Note": "如果你上回合未购买技能，则获得3次免费刷新",
		"ScriptFile": "abilities/greevil_effect/greevil_effect_26",
		"hero_name": "",
		"link_ability": "",
		"AbilityValues": {
			"free_refresh_count": 3,
		},
		"AbilityTextureName": "greevil_effect_icon",
	},
	"greevil_effect_27": {
		"Note": "贪魔商店加入属性碎片，每回合首次购买属性碎片免费，随机获得1个属性碎片",
		"ScriptFile": "abilities/greevil_effect/greevil_effect_27",
		"hero_name": "",
		"link_ability": "",
		"AbilityTextureName": "greevil_effect_icon",
	},
};