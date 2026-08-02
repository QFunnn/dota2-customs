--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build b9dc48c · 2026-08-02 17:42:46 UTC
  ~ auto-generated — do not edit
]]


GameUI.CustomUIConfig().talent = {
	"a0": {
		"talent_id": "a0",
		"name": "+15点攻击力",
		"max_level": 1,
		"type": 3,
		"category": 1,
		"y": 1,
		"lock": 0
	},
	"a1": {
		"talent_id": "a1",
		"name": "+5%攻击暴击概率",
		"max_level": 6,
		"type": 1,
		"category": 1,
		"y": 1,
		"requires": {
			"a0": 1
		},
		"lock": 3
	},
	"a2": {
		"talent_id": "a2",
		"name": "+20%攻击暴击伤害",
		"max_level": 6,
		"type": 1,
		"category": 1,
		"y": 1,
		"requires": {
			"a1": 1
		},
		"lock": 6
	},
	"a3": {
		"talent_id": "a3",
		"name": "+20攻击速度",
		"max_level": 3,
		"type": 2,
		"category": 1,
		"y": 1,
		"requires": {
			"a2": 1
		},
		"lock": 10
	},
	"a4": {
		"talent_id": "a4",
		"name": "+15%攻击力",
		"max_level": 6,
		"type": 1,
		"category": 1,
		"y": 1,
		"requires": {
			"a3": 1
		},
		"lock": 15
	},
	"a5": {
		"talent_id": "a5",
		"name": "+15%首领伤害",
		"max_level": 6,
		"type": 1,
		"category": 1,
		"y": 1,
		"requires": {
			"a4": 1
		},
		"lock": 20
	},
	"a6": {
		"talent_id": "a6",
		"name": "+1冲刺技能充能次数",
		"max_level": 1,
		"type": 3,
		"category": 1,
		"y": 1,
		"requires": {
			"a5": 1
		},
		"lock": 25
	},
	"a7": {
		"talent_id": "a7",
		"name": "+5%技能暴击概率",
		"max_level": 6,
		"type": 1,
		"category": 1,
		"y": 2,
		"requires": {
			"a0": 1
		},
		"lock": 3
	},
	"a8": {
		"talent_id": "a8",
		"name": "+20%技能暴击伤害",
		"max_level": 6,
		"type": 1,
		"category": 1,
		"y": 2,
		"requires": {
			"a7": 1
		},
		"lock": 6
	},
	"a9": {
		"talent_id": "a9",
		"name": "+5%冷却缩减",
		"max_level": 3,
		"type": 2,
		"category": 1,
		"y": 2,
		"requires": {
			"a8": 1
		},
		"lock": 10
	},
	"a10": {
		"talent_id": "a10",
		"name": "+15%技能增强",
		"max_level": 6,
		"type": 1,
		"category": 1,
		"y": 2,
		"requires": {
			"a9": 1
		},
		"lock": 15
	},
	"a11": {
		"talent_id": "a11",
		"name": "+15%普通怪伤害",
		"max_level": 6,
		"type": 1,
		"category": 1,
		"y": 2,
		"requires": {
			"a10": 1
		},
		"lock": 20
	},
	"a13": {
		"talent_id": "a13",
		"name": "+1%攻击力",
		"max_level": 20,
		"type": 4,
		"category": 1,
		"requires": {
			"a0": 1,
			"a1": 6,
			"a2": 6,
			"a3": 1,
			"a4": 6,
			"a5": 6,
			"a6": 1,
			"a7": 6,
			"a8": 6,
			"a9": 1,
			"a10": 6,
			"a11": 6
		}
	},
	"b0": {
		"talent_id": "b0",
		"name": "+1复活次数",
		"max_level": 1,
		"type": 3,
		"category": 2,
		"y": 1,
		"lock": 0
	},
	"b1": {
		"talent_id": "b1",
		"name": "+10生命值",
		"max_level": 6,
		"type": 1,
		"category": 2,
		"y": 1,
		"requires": {
			"b0": 1
		},
		"lock": 3
	},
	"b2": {
		"talent_id": "b2",
		"name": "+10%额外获得护盾量",
		"max_level": 6,
		"type": 1,
		"category": 2,
		"y": 1,
		"requires": {
			"b1": 1
		},
		"lock": 6
	},
	"b3": {
		"talent_id": "b3",
		"name": "+50%复活生命值恢复",
		"max_level": 3,
		"type": 2,
		"category": 2,
		"y": 1,
		"requires": {
			"b2": 1
		},
		"lock": 10
	},
	"b4": {
		"talent_id": "b4",
		"name": "+5点移动速度",
		"max_level": 6,
		"type": 1,
		"category": 2,
		"y": 1,
		"requires": {
			"b3": 1
		},
		"lock": 15
	},
	"b5": {
		"talent_id": "b5",
		"name": "+5%闪避",
		"max_level": 6,
		"type": 1,
		"category": 2,
		"y": 1,
		"requires": {
			"b4": 1
		},
		"lock": 20
	},
	"b6": {
		"talent_id": "b6",
		"name": "遭遇战开始获得10%最大生命值的强效护盾",
		"max_level": 1,
		"type": 3,
		"category": 2,
		"y": 1,
		"requires": {
			"b5": 1
		},
		"lock": 25
	},
	"b7": {
		"talent_id": "b7",
		"name": "+5%破坏物掉落概率",
		"max_level": 6,
		"type": 1,
		"category": 2,
		"y": 2,
		"requires": {
			"b0": 1
		},
		"lock": 3
	},
	"b8": {
		"talent_id": "b8",
		"name": "+5%掉落物收益",
		"max_level": 6,
		"type": 1,
		"category": 2,
		"y": 2,
		"requires": {
			"b7": 1
		},
		"lock": 6
	},
	"b9": {
		"talent_id": "b9",
		"name": "+5点遭遇战恢复生命值",
		"max_level": 3,
		"type": 2,
		"category": 2,
		"y": 2,
		"requires": {
			"b8": 1
		},
		"lock": 10
	},
	"b10": {
		"talent_id": "b10",
		"name": "+2点遭遇战恢复怒气值",
		"max_level": 6,
		"type": 1,
		"category": 2,
		"y": 2,
		"requires": {
			"b9": 1
		},
		"lock": 15
	},
	"b11": {
		"talent_id": "b11",
		"name": "+1%伤害减免",
		"max_level": 6,
		"type": 1,
		"category": 2,
		"y": 2,
		"requires": {
			"b10": 1
		},
		"lock": 20
	},
	"b13": {
		"talent_id": "b13",
		"name": "+1%生命值",
		"max_level": 20,
		"type": 4,
		"category": 2,
		"requires": {
			"b0": 1,
			"b1": 6,
			"b2": 6,
			"b3": 1,
			"b4": 6,
			"b5": 6,
			"b6": 1,
			"b7": 6,
			"b8": 6,
			"b9": 1,
			"b10": 6,
			"b11": 6
		}
	},
	"c0": {
		"talent_id": "c0",
		"name": "+100初始金币",
		"max_level": 1,
		"type": 3,
		"category": 3,
		"y": 1,
		"lock": 0
	},
	"c1": {
		"talent_id": "c1",
		"name": "+5%商店折扣",
		"max_level": 6,
		"type": 1,
		"category": 3,
		"y": 1,
		"requires": {
			"c0": 1
		},
		"lock": 3
	},
	"c2": {
		"talent_id": "c2",
		"name": "+10%金币收益",
		"max_level": 6,
		"type": 1,
		"category": 3,
		"y": 1,
		"requires": {
			"c1": 1
		},
		"lock": 6
	},
	"c3": {
		"talent_id": "c3",
		"name": "+1祝福刷新次数",
		"max_level": 1,
		"type": 3,
		"category": 3,
		"y": 1,
		"requires": {
			"c2": 1
		},
		"lock": 10
	},
	"c4": {
		"talent_id": "c4",
		"name": "+5%商店稀有度提高",
		"max_level": 6,
		"type": 1,
		"category": 3,
		"y": 1,
		"requires": {
			"c3": 1
		},
		"lock": 15
	},
	"c5": {
		"talent_id": "c5",
		"name": "初始获得1个1级随机遗物，有20%概率升级",
		"max_level": 6,
		"type": 1,
		"category": 3,
		"y": 1,
		"requires": {
			"c4": 1
		},
		"lock": 20
	},
	"c6": {
		"talent_id": "c6",
		"name": "初始获得1次技能天赋",
		"max_level": 1,
		"type": 3,
		"category": 3,
		"y": 1,
		"requires": {
			"c5": 1
		},
		"lock": 25
	},
	"c7": {
		"talent_id": "c7",
		"name": "+2点遭遇战恢复英雄经验值",
		"max_level": 6,
		"type": 1,
		"category": 3,
		"y": 2,
		"requires": {
			"c0": 1
		},
		"lock": 3
	},
	"c8": {
		"talent_id": "c8",
		"name": "+10%英雄局内经验获取",
		"max_level": 6,
		"type": 1,
		"category": 3,
		"y": 2,
		"requires": {
			"c7": 1
		},
		"lock": 6
	},
	"c9": {
		"talent_id": "c9",
		"name": "+1技能天赋次数",
		"max_level": 1,
		"type": 3,
		"category": 3,
		"y": 2,
		"requires": {
			"c8": 1
		},
		"lock": 10
	},
	"c10": {
		"talent_id": "c10",
		"name": "+5%祝福稀有度提高",
		"max_level": 6,
		"type": 1,
		"category": 3,
		"y": 2,
		"requires": {
			"c9": 1
		},
		"lock": 15
	},
	"c11": {
		"talent_id": "c11",
		"name": "初始获得1个1级随机祝福，有20%概率升级",
		"max_level": 6,
		"type": 1,
		"category": 3,
		"y": 2,
		"requires": {
			"c10": 1
		},
		"lock": 20
	},
	"c13": {
		"talent_id": "c13",
		"name": "+0.5%伤害",
		"max_level": 20,
		"type": 4,
		"category": 3,
		"requires": {
			"c0": 1,
			"c1": 6,
			"c2": 6,
			"c3": 1,
			"c4": 6,
			"c5": 6,
			"c6": 1,
			"c7": 6,
			"c8": 6,
			"c9": 1,
			"c10": 6,
			"c11": 6
		}
	}
};