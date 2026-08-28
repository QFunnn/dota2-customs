--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 0b85d8d 
  ~ auto-generated — do not edit
]]


GameUI.CustomUIConfig().privilege.kv.REMOTE = {
	"privilege_001": {
		"Note": "受到伤害降低冲刺的%reduce_doge_cd%秒冷却时间，每%trigger_cd%秒触发1次",
		"IsGlobal": 0,
		"IsStackable": 0,
		"AbilityValues": {
			"reduce_doge_cd": "1 1 1",
			"trigger_cd": "12 11 10"
		}
	},
	"privilege_002": {
		"Note": "通关BOSS房间，获得%count%个随机神符",
		"IsGlobal": 0,
		"IsStackable": 0,
		"AbilityValues": {
			"count": "1 2 3"
		}
	},
	"privilege_003": {
		"Note": "通关BOSS房间，增加%value%点血量上限",
		"IsGlobal": 0,
		"IsStackable": 0,
		"AbilityValues": {
			"value": "20 40 60"
		}
	},
	"privilege_004": {
		"Note": "通关任意房间，回复%value%点血量",
		"IsGlobal": 0,
		"IsStackable": 0,
		"AbilityValues": {
			"value": "10 15 20"
		}
	},
	"privilege_006": {
		"Note": "通关BOSS房间，额外获得%value%金币",
		"IsGlobal": 0,
		"IsStackable": 0,
		"AbilityValues": {
			"value": 20
		}
	},
	"privilege_007": {
		"Note": "通关任意房间，额外获得%value%金币",
		"IsGlobal": 0,
		"IsStackable": 0,
		"AbilityValues": {
			"value": "2 3 4"
		}
	},
	"privilege_008": {
		"Note": "通关BOSS房间，有%chance%概率获得1个随机遗物",
		"IsGlobal": 0,
		"IsStackable": 0,
		"AbilityValues": {
			"chance": "70 80 90 100"
		}
	},
	"privilege_009": {
		"Note": "初始有%chance%概率获得1个随机神符",
		"IsGlobal": 0,
		"IsStackable": 0,
		"AbilityValues": {
			"chance": "70 80 90 100"
		}
	},
	"privilege_010": {
		"Note": "消费%cost_gold%金币随机获得1个随机神符",
		"IsGlobal": 0,
		"IsStackable": 0,
		"AbilityValues": {
			"cost_gold": "200 150 100"
		}
	},
	"privilege_011": {
		"Note": "初始随机获得1件%rarity%级的遗物，有%chance%的概率升级",
		"IsGlobal": 0,
		"IsStackable": 0,
		"AbilityValues": {
			"rarity": "1 1 1 1 1 1",
			"chance": "10 20 30 40 50 60"
		}
	},
	"privilege_012": {
		"Note": "每个房间必定掉落%drop_count%个血瓶",
		"IsGlobal": 0,
		"IsStackable": 0,
		"AbilityValues": {
			"drop_count": 1
		}
	},
	"privilege_013": {
		"Note": "首次施法绝招不消耗<Fury:怒气/>值",
		"IsGlobal": 0,
		"IsStackable": 0
	},
	"privilege_014": {
		"Note": "初始随机获得1件%rarity%级的祝福，有%chance%的概率升级",
		"IsGlobal": 0,
		"IsStackable": 0,
		"AbilityValues": {
			"rarity": 1,
			"chance": "10 20 30 40 50 60"
		}
	},
	"privilege_015": {
		"Note": "初始获得%value%点永续护盾",
		"IsGlobal": 0,
		"IsStackable": 0,
		"AbilityValues": {
			"value": {
				"value": 0,
				"+health": 0.1
			}
		}
	},
	"privilege_016": {
		"Note": "初始获得1次技能天赋",
		"IsGlobal": 0,
		"IsStackable": 0
	},
	"privilege_suit_001": {
		"Note": "飞剑击中单位额外获得%mana_amount%点怒气",
		"IsGlobal": 0,
		"IsStackable": 0,
		"AbilityValues": {
			"mana_amount": 3
		}
	},
	"privilege_suit_002": {
		"Note": "攻击时每隔%hit_count%次击中使敌人附着%shock_stacks%层触电",
		"IsGlobal": 0,
		"IsStackable": 0,
		"AbilityValues": {
			"hit_count": 5,
			"shock_stacks": 2
		}
	},
	"privilege_suit_003": {
		"Note": "对同一个目标每叠%frozen_stacks%层冰冻使其冻结%frozen_duration%秒",
		"IsGlobal": 0,
		"IsStackable": 0,
		"AbilityValues": {
			"frozen_stacks": 10,
			"freeze_time": 0.5
		}
	},
	"privilege_suit_004": {
		"Note": "使用特技时同时释放一道剑气(伤害：%damage_pct%%攻击力)",
		"IsGlobal": 0,
		"IsStackable": 0,
		"AbilityValues": {
			"damage": {
				"value": 0,
				"+attack": 1
			}
		}
	},
	"privilege_suit_005": {
		"Note": "每%interval%秒对周围发射%snowball_count%个雪球，施加冰冻（%frozen_stacks%层）",
		"IsGlobal": 0,
		"IsStackable": 0,
		"AbilityValues": {
			"interval": 2,
			"snowball_count": 2,
			"frozen_stacks": 1,
			"radius": 500,
			"damage": 2
		}
	},
	"privilege_suit_006": {
		"Note": "每用闪避穿行1个敌人获得生命值%shield_pct%的护盾",
		"IsGlobal": 0,
		"IsStackable": 0,
		"AbilityValues": {
			"shield": {
				"value": 0,
				"+health": 0.05
			}
		}
	},
	"privilege_suit_007": {
		"Note": "怒气上限+%mana%",
		"IsGlobal": 0,
		"IsStackable": 0,
		"AbilityValues": {
			"mana": 100
		}
	},
	"privilege_suit_008": {
		"Note": "暴击伤害+%crit_damage%%（备注：初始150%%→200%%）",
		"IsGlobal": 0,
		"IsStackable": 0,
		"AbilityValues": {
			"crit_damage": 50
		}
	},
	"privilege_suit_009": {
		"Note": "开局获得暴击祝福：每进入一个新房间召唤5把飞剑",
		"IsGlobal": 0,
		"IsStackable": 0
	},
	"privilege_suit_010": {
		"Note": "开局获得雷电祝福：对触电目标造成攻击暴击几率翻倍",
		"IsGlobal": 0,
		"IsStackable": 0
	},
	"privilege_suit_011": {
		"Note": "开局获得冰冻祝福：攻击处于冻结目标的敌人时必定暴击",
		"IsGlobal": 0,
		"IsStackable": 0
	},
	"privilege_suit_012": {
		"Note": "开局获得暴击祝福：剑气造成的暴击伤害提高20%(x)",
		"IsGlobal": 0,
		"IsStackable": 0
	},
	"privilege_suit_013": {
		"Note": "开局获得冰冻祝福：发射的所有雪球能够弹射1次",
		"IsGlobal": 0,
		"IsStackable": 0
	},
	"privilege_suit_014": {
		"Note": "开局获得神圣祝福：护盾每抵挡3次伤害立刻发起1次反击",
		"IsGlobal": 0,
		"IsStackable": 0
	},
	"privilege_suit_015": {
		"Note": "开局获得狂暴祝福：怒气超过上限的50%时伤害+40%",
		"IsGlobal": 0,
		"IsStackable": 0
	},
	"privilege_suit_016": {
		"Note": "开局获得暴击祝福：所有伤害暴击几率+8%",
		"IsGlobal": 0,
		"IsStackable": 0
	},
	"privilege_suit_017": {
		"Note": "释放绝招时召唤%sword_count%把大飞剑对敌人造成%damage_pct%%飞剑伤害(大飞剑拥有%split_radius%范围的分裂效果)",
		"AbilityValues": {
			"sword_count": 5,
			"damage_pct": 200,
			"split_radius": 400
		}
	},
	"privilege_suit_018": {
		"Note": "对触电目标造成攻击暴击时%expose_keep_chance%%概率不消耗触电层数",
		"IsGlobal": 0,
		"IsStackable": 0,
		"AbilityValues": {
			"expose_keep_chance": 80
		}
	},
	"privilege_suit_019": {
		"Note": "冻结持续时间提升至1.5秒，击杀处于冻结敌人时使周围400范围的敌人冻结1.5秒",
		"IsGlobal": 0,
		"IsStackable": 0,
		"AbilityValues": {
			"freeze_time": 1.5,
			"radius": 400
		}
	},
	"privilege_suit_020": {
		"Note": "剑气伤害叠加，剑气击中使敌人下次受到剑气伤害提高20%攻击力.（可叠加，持续20秒，最多提高200%攻击力）",
		"IsGlobal": 0,
		"IsStackable": 0,
		"AbilityValues": {
			"stack_limit": 10,
			"duration": 20,
			"damage_pct": 20
		}
	},
	"privilege_suit_021": {
		"Note": "敌方每有1层冰冻额外提升2点雪球伤害",
		"IsGlobal": 0,
		"IsStackable": 0,
		"AbilityValues": {
			"add_damage": 2
		}
	},
	"privilege_suit_022": {
		"Note": "受到低于当前30%盾量的伤害时50%概率完全格挡伤害。(内置1秒间隔)",
		"IsGlobal": 0,
		"IsStackable": 0,
		"AbilityValues": {
			"cd": 1,
			"shield_threshold": 30,
			"chance": 50
		}
	},
	"privilege_suit_023": {
		"Note": "绝招冷却时间缩减35%，绝招伤害和怒气消耗提升30%",
		"AbilityValues": {
			"cd_reduce_pct": 35,
			"damage_pct": 30,
			"mana_consume_pct": 30
		}
	},
	"privilege_suit_024": {
		"Note": "毒伤害+10%",
		"AbilityValues": {
			"poison_damage": 10
		}
	},
	"privilege_suit_025": {
		"Note": "开局获得剧毒祝福：每进入一个新房间获得15秒的剧毒药瓶(环绕物)(剧毒药瓶触碰敌人施加毒层数：4)"
	},
	"privilege_suit_026": {
		"Note": "剧毒药瓶击中敌人时使下一次剧毒药瓶施加的毒层数+1",
		"AbilityValues": {
			"extra_count": 1
		}
	},
	"privilege_myth_001": {
		"Note": "寒霜爆发施加冰冻层数50~100%概率+2层",
		"IsGlobal": 0,
		"IsStackable": 0,
		"AbilityValues": {
			"add_stacks": 2
		}
	},
	"privilege_myth_002": {
		"Note": "雪球20~40%概率额外发射1颗雪球",
		"IsGlobal": 0,
		"IsStackable": 0,
		"AbilityValues": {
			"extra_count": 1,
			"interval": 0.5,
			"damage": 2
		}
	},
	"privilege_myth_003": {
		"Note": "冰雹20~40%概率额外降下1个冰雹",
		"IsGlobal": 0,
		"IsStackable": 0,
		"AbilityValues": {
			"extra_count": 1,
			"interval": 0.5,
			"damage": 5
		}
	},
	"privilege_myth_004": {
		"Note": "寒霜爆发20~40%概率额外召唤1次寒霜爆发",
		"IsGlobal": 0,
		"IsStackable": 0,
		"AbilityValues": {
			"extra_count": 1,
			"damage": 5,
			"interval": 0.5
		}
	},
	"privilege_myth_005": {
		"Note": "冰雹对目标100~275范围内的所有单位造成伤害",
		"IsGlobal": 0,
		"IsStackable": 0
	},
	"privilege_myth_006": {
		"Note": "寒霜爆发击中时50~100%施加2层触电",
		"IsGlobal": 0,
		"IsStackable": 0,
		"AbilityValues": {
			"shock_stacks": 2
		}
	},
	"privilege_myth_007": {
		"Note": "施加冰冻使对敌人施加层数的50~100%点斩杀生命值",
		"IsGlobal": 0,
		"IsStackable": 0
	},
	"privilege_myth_008": {
		"Note": "寒霜爆发施加造成伤害的25~50%层数斩杀生命值",
		"IsGlobal": 0,
		"IsStackable": 0
	},
	"privilege_myth_009": {
		"Note": "触电伤害加成倍率+20~50%",
		"IsGlobal": 0,
		"IsStackable": 0
	},
	"privilege_myth_010": {
		"Note": "敌人被触发10~5次触电引发1次闪电风暴(伤害：20)",
		"IsGlobal": 0,
		"IsStackable": 0,
		"AbilityValues": {
			"count": 1,
			"damage": 20
		}
	},
	"privilege_myth_011": {
		"Note": "每触发一次触电40~80%概率获得1点强效护盾",
		"IsGlobal": 0,
		"IsStackable": 0,
		"AbilityValues": {
			"shield": 10,
			"interval": 0.5
		}
	},
	"privilege_myth_012": {
		"Note": "护盾抵挡伤害时40~80%对敌人引发1次闪电风暴(伤害：护盾抵消的层数)",
		"IsGlobal": 0,
		"IsStackable": 0,
		"AbilityValues": {
			"count": 1,
			"interval": 0.5
		}
	},
	"privilege_myth_013": {
		"Note": "每场遭遇战获得雷云跟随5~10秒，雷云自动打击周围敌人(单体打击,间隔：1秒，伤害：当前雷电等级)",
		"IsGlobal": 0,
		"IsStackable": 0,
		"AbilityValues": {
			"interval": 1
		}
	},
	"privilege_myth_014": {
		"Note": "雷云的伤害和持续时间提升20~50%",
		"IsGlobal": 0,
		"IsStackable": 0
	},
	"privilege_myth_015": {
		"Note": "雷云打击时有50~100%几率额外打击1个目标",
		"IsGlobal": 0,
		"IsStackable": 0,
		"AbilityValues": {
			"extra_target_count": 1
		}
	},
	"privilege_myth_016": {
		"Note": "闪电风暴打击时将目标周围的敌人拉进100~300距离(范围600，参考帕克2技能拉进)",
		"IsGlobal": 0,
		"IsStackable": 0,
		"AbilityValues": {
			"radius": 600
		}
	},
	"privilege_myth_017": {
		"Note": "雷击击中时5~15%概率施加中毒(层数：当前剧毒等级)",
		"IsGlobal": 0,
		"IsStackable": 0
	},
	"privilege_myth_018": {
		"Note": "雷击击中10~30%触发一次不衰减的中毒伤害",
		"IsGlobal": 0,
		"IsStackable": 0
	},
	"privilege_myth_019": {
		"Note": "寒霜爆发击中时20~50%触发一次不衰减的中毒伤害",
		"IsGlobal": 0,
		"IsStackable": 0
	},
	"privilege_myth_020": {
		"Note": "触发毒伤害使敌人造成伤害降低1.0~3.0%，最多叠加10层",
		"IsGlobal": 0,
		"IsStackable": 0,
		"AbilityValues": {
			"stack_limit": 10,
			"duration": 10
		}
	},
	"privilege_myth_021": {
		"Note": "每移动1000~500距离种下1个剧毒孢子(敌人触碰爆炸，325范围，剧毒层数：当前剧毒等级)",
		"IsGlobal": 0,
		"IsStackable": 0,
		"AbilityValues": {
			"plant_count": 1,
			"radius": 325,
			"sum_limit": 5
		}
	},
	"privilege_myth_022": {
		"Note": "剧毒孢子爆炸时50~100%几率立刻触发一次不衰减中毒",
		"IsGlobal": 0,
		"IsStackable": 0
	},
	"privilege_myth_023": {
		"Note": "拾取回复药获得剧毒药瓶环绕物60~140秒。可叠加，延长持续时间(触碰敌人施加毒层数：4）",
		"IsGlobal": 0,
		"IsStackable": 0,
		"AbilityValues": {
			"poison_stacks": 4
		}
	},
	"privilege_myth_024": {
		"Note": "剧毒药瓶施加的毒层数和药瓶持续时间提升20~50%",
		"IsGlobal": 0,
		"IsStackable": 0
	},
	"privilege_myth_025": {
		"Note": "怒气充盈时普攻消耗2.0~5.0%怒气，施加流血(层数：消耗的怒气)",
		"IsGlobal": 0,
		"IsStackable": 0
	},
	"privilege_myth_026": {
		"Note": "每次拾取回复药，回复20~50%怒气值",
		"IsGlobal": 0,
		"IsStackable": 0
	},
	"privilege_myth_027": {
		"Note": "每消耗100点怒气获得10~30%伤害提升,持续8秒.（独立持续可叠加）",
		"IsGlobal": 0,
		"IsStackable": 0,
		"AbilityValues": {
			"mana_cost": 100,
			"duration": 8,
			"stack_limit": 3
		}
	},
	"privilege_myth_028": {
		"Note": "击杀敌人回复2~5%的怒气值",
		"IsGlobal": 0,
		"IsStackable": 0
	},
	"privilege_myth_029": {
		"Note": "每消耗600~300怒气值立刻刷新绝招的冷却时间",
		"IsGlobal": 0,
		"IsStackable": 0
	},
	"privilege_myth_030": {
		"Note": "燃烧怒火：持续对周围敌人造成消耗愤怒值x100~200%的伤害。(满愤怒值自动开启，每秒消耗5%愤怒值，低于10%自动关闭,范围：500)",
		"IsGlobal": 0,
		"IsStackable": 0,
		"AbilityValues": {
			"interval": 1,
			"radius": 500,
			"consume_mana_pct": 5,
			"min_mana_pct": 10
		}
	},
	"privilege_myth_031": {
		"Note": "处于燃烧怒火状态时流血伤害和移动速度提升25~50%",
		"IsGlobal": 0,
		"IsStackable": 0
	},
	"privilege_myth_032": {
		"Note": "燃烧怒火消耗的怒火值50~100%生成护盾",
		"IsGlobal": 0,
		"IsStackable": 0
	},
	"privilege_myth_033": {
		"Note": "飞剑20~40%概率额外召唤1把飞剑",
		"IsGlobal": 0,
		"IsStackable": 0,
		"AbilityValues": {
			"extra_count": 1,
			"interval": 0.5
		}
	},
	"privilege_myth_034": {
		"Note": "每获得60~30点怒气召唤1柄飞剑",
		"IsGlobal": 0,
		"IsStackable": 0,
		"AbilityValues": {
			"sword_count": 1,
			"interval": 0.5
		}
	},
	"privilege_myth_035": {
		"Note": "护盾削减间隔延长20~50%",
		"IsGlobal": 0,
		"IsStackable": 0
	},
	"privilege_myth_036": {
		"Note": "当前护盾值超过50%最大血量时获得10~20%伤害减免",
		"IsGlobal": 0,
		"IsStackable": 0,
		"AbilityValues": {
			"shield_threshold": 50
		}
	},
	"privilege_myth_037": {
		"Note": "使用绝招时50~100%几率对周围敌人发起1次反击",
		"IsGlobal": 0,
		"IsStackable": 0,
		"AbilityValues": {
			"count": 1,
			"damage": 50,
			"interval": 0.5
		}
	},
	"privilege_myth_038": {
		"Note": "对冲刺碰撞的敌人造成5~10%当前盾量的伤害",
		"IsGlobal": 0,
		"IsStackable": 0
	},
	"privilege_myth_039": {
		"Name": "护盾神器",
		"Note": "护盾自动削减时有10~20%概率避免",
		"IsGlobal": 0,
		"IsStackable": 0
	}
};