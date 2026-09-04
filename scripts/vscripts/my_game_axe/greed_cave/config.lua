--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build ec5ff63 
  ~ auto-generated — do not edit
]]


--[[ Generated with https://github.com/TypeScriptToLua/TypeScriptToLua ]]
local ____exports = {}
--- 贪婪洞窟房间 ID，需要与房间注册和传送入口保持一致。
____exports.GREED_CAVE_ROOM_ID = "G001"
--- 判断房间是否为贪婪洞窟 G001（标准秘境与无尽共用同一间房）。
function ____exports.IsGreedCaveRoomId(self, roomId)
	return roomId == ____exports.GREED_CAVE_ROOM_ID
end
--- 地图中用于定位洞窟战斗区域中心点的实体名。
____exports.GREED_CAVE_POINT_ENTITY_NAME = "test_boos_point"
--- 每名玩家每日最多使用贪婪罗盘进入洞窟的次数。
____exports.GREED_CAVE_DAILY_COMPASS_LIMIT = 3
--- 无尽邀请函使用独立的每日次数池。
____exports.GREED_CAVE_ENDLESS_DAILY_COMPASS_LIMIT = 3
--- 无尽邀请函沿用物品阶数字段传递的内部标识。
____exports.GREED_CAVE_ENDLESS_COMPASS_TIER = 4
--- 房间传送点与邀请函物品的阶数对应：1~3 为标准秘境，4 为无尽。
____exports.GREED_CAVE_COMPASS_ITEM_BY_TIER =
	{ [1] = "item_5001", [2] = "item_5002", [3] = "item_5003", [4] = "item_5101" }
--- 获取指定阶数对应的秘境邀请函物品名。
function ____exports.GetGreedCaveCompassItemName(self, tier)
	return ____exports.GREED_CAVE_COMPASS_ITEM_BY_TIER[tier]
end
--- 无尽会话沿用三阶宝箱与通用阶数语义；怪物池和怪物属性均使用无尽独立配置。
____exports.GREED_CAVE_ENDLESS_COMBAT_TIER = 3
--- 无尽怪物配置在 CSV 中使用的独立阶数，避免编辑无尽时影响标准三阶洞窟。
____exports.GREED_CAVE_ENDLESS_MONSTER_DATA_TIER = 4
--- 无尽第十六层及之后统一读取该数据层，编辑器中显示为“16+”。
____exports.GREED_CAVE_ENDLESS_DEEP_MONSTER_DATA_FLOOR = 16
--- 无尽只允许在首层开战前加入，避免中途补票直接进入高层。
____exports.GREED_CAVE_ENDLESS_JOIN_MAX_FLOOR = 1
--- 无尽个人背包初始格数。
____exports.GREED_CAVE_ENDLESS_BASE_BAG_CAPACITY = 3
--- 天赋或其他永久系统提供的个人背包额外格数。
____exports.GREED_CAVE_ENDLESS_BAG_SLOT_CUSTOM_VALUE_KEY = "greed_cave_endless_bag_slots"
--- 无尽进入后十五层的缓和成长曲线起点。
____exports.GREED_CAVE_ENDLESS_SOFT_SCALING_START_FLOOR = 16
--- 无尽十五层后生命值每层增长倍率。
____exports.GREED_CAVE_ENDLESS_HEALTH_GROWTH_RATE = 1.15
--- 无尽十五层后攻击力每层增长倍率。
____exports.GREED_CAVE_ENDLESS_ATTACK_GROWTH_RATE = 1.1
--- 无尽十五层后每三层增加的护甲。
____exports.GREED_CAVE_ENDLESS_ARMOR_PER_THREE_FLOORS = 3
--- 无尽十五层后每三层增加的魔抗。
____exports.GREED_CAVE_ENDLESS_MAGIC_RESISTANCE_PER_THREE_FLOORS = 1
--- 无尽魔抗上限。
____exports.GREED_CAVE_ENDLESS_MAGIC_RESISTANCE_CAP = 95
--- 防止极深层数值超过引擎安全整数范围。
____exports.GREED_CAVE_ENDLESS_ATTRIBUTE_VALUE_CAP = 2000000000
--- 普通怪与精英怪的生命值倍率，Boss 不受影响。
____exports.GREED_CAVE_NORMAL_ELITE_HEALTH_MULTIPLIER = 2
--- 普通怪与精英怪的攻击力倍率，Boss 不受影响。
____exports.GREED_CAVE_NORMAL_ELITE_ATTACK_MULTIPLIER = 0.7
--- 当前每名玩家进入洞窟后默认拥有的复活次数。
____exports.GREED_CAVE_DEFAULT_REVIVE_COUNT = 1
--- 天赋写入玩家自定义值后，为洞窟入场初始复活次数提供的额外加成。
____exports.GREED_CAVE_REVIVE_BONUS_CUSTOM_VALUE_KEY = "greed_cave_revive_bonus"
--- 天赋写入玩家自定义值后，为洞窟秘晶入账提供的百分比收益加成。
____exports.GREED_CAVE_COIN_GAIN_PCT_CUSTOM_VALUE_KEY = "greed_cave_coin_gain_pct"
--- 天赋写入玩家自定义值后，为洞窟开箱远古币提供的百分比收益加成。
____exports.GREED_CAVE_ANCIENT_COIN_GAIN_PCT_CUSTOM_VALUE_KEY = "greed_cave_ancient_coin_gain_pct"
--- 洞窟复活进入假死演出的持续时间。
____exports.GREED_CAVE_REVIVE_DELAY_SEC = 1.5
--- 洞窟复活完成后恢复的最大生命与魔法百分比。
____exports.GREED_CAVE_REVIVE_RESTORE_PCT = 100
--- 无尽洞窟复活完成后的保护持续时间。
____exports.GREED_CAVE_ENDLESS_REVIVE_PROTECTION_DURATION_SEC = 5
--- 无尽洞窟复活保护提供的伤害减免百分比。
____exports.GREED_CAVE_ENDLESS_REVIVE_DAMAGE_REDUCTION_PCT = 100
--- 贪婪洞窟每日次数按北京时间自然日刷新。
____exports.GREED_CAVE_DAILY_COMPASS_DAY_OFFSET_SECONDS = 8 * 3600
--- 自然日秒数，用于每日次数刷新计算。
____exports.GREED_CAVE_DAY_SECONDS = 24 * 3600
--- 普通怪掉落 30 分洞窟币的概率。
____exports.GREED_CAVE_NORMAL_MONSTER_BOSS_COIN_REWARD_CHANCE_PCT = 1
--- 普通怪掉落 6 分洞窟币的概率。
____exports.GREED_CAVE_NORMAL_MONSTER_ELITE_COIN_REWARD_CHANCE_PCT = 6
--- 精英怪掉落 30 分洞窟币的概率。
____exports.GREED_CAVE_ELITE_MONSTER_BOSS_COIN_REWARD_CHANCE_PCT = 15
--- 各阶洞窟开放的最大楼层数，0 表示该阶暂未开放。
____exports.GREED_CAVE_MAX_FLOOR_BY_TIER = { [1] = 9, [2] = 12, [3] = 15 }
--- 一阶洞窟第 1 层的基础属性锚点，三类怪物共用相同成长率以便直接比较。
local GREED_CAVE_MONSTER_BASE_ATTRIBUTE_TARGETS = {
	normal = { anchorFloor = 1, health = 2999, attack = 475, growthRate = 1.25 },
	elite = { anchorFloor = 1, health = 41447, attack = 771, growthRate = 1.25 },
	boss = { anchorFloor = 1, health = 97381, attack = 759, growthRate = 1.25 },
}
--- 各阶洞窟共用一阶成长曲线，并按阶数配置生命、攻击、移速和攻速难度增幅。
____exports.GREED_CAVE_MONSTER_ATTRIBUTE_BY_TIER = {
	[1] = {
		difficultyMultiplier = 1,
		movementSpeedBonusPct = 0,
		attackSpeedBonusPct = 0,
		normal = GREED_CAVE_MONSTER_BASE_ATTRIBUTE_TARGETS.normal,
		elite = GREED_CAVE_MONSTER_BASE_ATTRIBUTE_TARGETS.elite,
		boss = GREED_CAVE_MONSTER_BASE_ATTRIBUTE_TARGETS.boss,
		armor = 185,
		magicResistance = 88,
	},
	[2] = {
		difficultyMultiplier = 1.25,
		movementSpeedBonusPct = 8,
		attackSpeedBonusPct = 15,
		normal = GREED_CAVE_MONSTER_BASE_ATTRIBUTE_TARGETS.normal,
		elite = GREED_CAVE_MONSTER_BASE_ATTRIBUTE_TARGETS.elite,
		boss = GREED_CAVE_MONSTER_BASE_ATTRIBUTE_TARGETS.boss,
		armor = 185,
		magicResistance = 90,
	},
	[3] = {
		difficultyMultiplier = 1.6,
		movementSpeedBonusPct = 15,
		attackSpeedBonusPct = 25,
		normal = GREED_CAVE_MONSTER_BASE_ATTRIBUTE_TARGETS.normal,
		elite = GREED_CAVE_MONSTER_BASE_ATTRIBUTE_TARGETS.elite,
		boss = GREED_CAVE_MONSTER_BASE_ATTRIBUTE_TARGETS.boss,
		armor = 185,
		magicResistance = 90,
	},
}
--- 各阶洞窟按楼层绑定的怪物池 ID，普通层同时需要普通怪和精英怪池。
____exports.GREED_CAVE_MONSTER_POOL_BY_TIER_FLOOR = {
	[1] = {
		[1] = { normal = "GCM_T1_NORMAL", elite = "GCM_T1_ELITE" },
		[2] = { normal = "GCM_T1_NORMAL", elite = "GCM_T1_ELITE" },
		[3] = { boss = "GCM_T1_BOSS" },
		[4] = { normal = "GCM_T1_NORMAL_2", elite = "GCM_T1_ELITE_2" },
		[5] = { normal = "GCM_T1_NORMAL_2", elite = "GCM_T1_ELITE_2" },
		[6] = { boss = "GCM_T1_BOSS_2" },
		[7] = { normal = "GCM_T1_NORMAL_3", elite = "GCM_T1_ELITE_3" },
		[8] = { normal = "GCM_T1_NORMAL_3", elite = "GCM_T1_ELITE_3" },
		[9] = { boss = "GCM_T1_BOSS_3" },
	},
	[2] = {
		[1] = { normal = "GCM_T2_NORMAL", elite = "GCM_T2_ELITE" },
		[2] = { normal = "GCM_T2_NORMAL", elite = "GCM_T2_ELITE" },
		[3] = { boss = "GCM_T2_BOSS" },
		[4] = { normal = "GCM_T2_NORMAL_2", elite = "GCM_T2_ELITE_2" },
		[5] = { normal = "GCM_T2_NORMAL_2", elite = "GCM_T2_ELITE_2" },
		[6] = { boss = "GCM_T2_BOSS_2" },
		[7] = { normal = "GCM_T2_NORMAL_3", elite = "GCM_T2_ELITE_3" },
		[8] = { normal = "GCM_T2_NORMAL_3", elite = "GCM_T2_ELITE_3" },
		[9] = { boss = "GCM_T2_BOSS_3" },
		[10] = { normal = "GCM_T2_NORMAL_4", elite = "GCM_T2_ELITE_4" },
		[11] = { normal = "GCM_T2_NORMAL_4", elite = "GCM_T2_ELITE_4" },
		[12] = { boss = "GCM_T2_BOSS_4" },
	},
	[3] = {
		[1] = { normal = "GCM_T3_NORMAL", elite = "GCM_T3_ELITE" },
		[2] = { normal = "GCM_T3_NORMAL", elite = "GCM_T3_ELITE" },
		[3] = { boss = "GCM_T3_BOSS" },
		[4] = { normal = "GCM_T3_NORMAL_2", elite = "GCM_T3_ELITE_2" },
		[5] = { normal = "GCM_T3_NORMAL_2", elite = "GCM_T3_ELITE_2" },
		[6] = { boss = "GCM_T3_BOSS_2" },
		[7] = { normal = "GCM_T3_NORMAL_3", elite = "GCM_T3_ELITE_3" },
		[8] = { normal = "GCM_T3_NORMAL_3", elite = "GCM_T3_ELITE_3" },
		[9] = { boss = "GCM_T3_BOSS_3" },
		[10] = { normal = "GCM_T3_NORMAL_4", elite = "GCM_T3_ELITE_4" },
		[11] = { normal = "GCM_T3_NORMAL_4", elite = "GCM_T3_ELITE_4" },
		[12] = { boss = "GCM_T3_BOSS_4" },
		[13] = { normal = "GCM_T3_NORMAL_5", elite = "GCM_T3_ELITE_5" },
		[14] = { normal = "GCM_T3_NORMAL_5", elite = "GCM_T3_ELITE_5" },
		[15] = { boss = "GCM_T3_BOSS_5" },
	},
	[4] = {
		[1] = { normal = "GCM_ENDLESS_NORMAL_01" },
		[2] = { normal = "GCM_ENDLESS_NORMAL_01" },
		[4] = { normal = "GCM_ENDLESS_NORMAL_04" },
		[5] = { normal = "GCM_ENDLESS_NORMAL_04" },
		[7] = { normal = "GCM_ENDLESS_NORMAL_07" },
		[8] = { normal = "GCM_ENDLESS_NORMAL_07" },
		[10] = { normal = "GCM_ENDLESS_NORMAL_10" },
		[11] = { normal = "GCM_ENDLESS_NORMAL_10" },
		[13] = { normal = "GCM_ENDLESS_NORMAL_13" },
		[14] = { normal = "GCM_ENDLESS_NORMAL_13" },
		[16] = { normal = "GCM_ENDLESS_NORMAL_DEEP" },
	},
}
--- 判断指定阶数是否已经开放。
function ____exports.IsGreedCaveTierOpen(self, tier)
	return (____exports.GREED_CAVE_MAX_FLOOR_BY_TIER[tier] or 0) > 0
end
--- 判断传入的邀请函阶数是否代表无尽玩法。
function ____exports.IsGreedCaveEndlessTier(self, tier)
	return tier == ____exports.GREED_CAVE_ENDLESS_COMPASS_TIER
end
--- 获取当前阶数、楼层和怪物类型对应的怪物池 ID。
function ____exports.GetGreedCaveMonsterPoolId(self, tier, floor, kind)
	local ____opt_2 = ____exports.GREED_CAVE_MONSTER_POOL_BY_TIER_FLOOR[tier]
	local ____opt_0 = ____opt_2 and ____opt_2[floor]
	return ____opt_0 and ____opt_0[kind]
end
--- 获取当前阶数的洞窟怪物属性配置，缺失时回退到 1 阶。
function ____exports.GetGreedCaveMonsterTierAttributeConfig(self, tier)
	return ____exports.GREED_CAVE_MONSTER_ATTRIBUTE_BY_TIER[tier] or ____exports.GREED_CAVE_MONSTER_ATTRIBUTE_BY_TIER[1]
end
--- 死亡后统一保留 50% 洞窟币。
function ____exports.GetGreedCaveDeathCoinRetainMultiplier(self, floor)
	return 0.5
end
--- 楼层选择阶段的等待时长，超时会默认继续挑战。
____exports.GREED_CAVE_CHOICE_DURATION_SEC = 20
--- 楼层选择结果展示多久后真正生效。
____exports.GREED_CAVE_CHOICE_RESULT_DELAY_SEC = 2
--- 继续挑战后选择本局后续负面词条的等待时长。
____exports.GREED_CAVE_RUN_MODIFIER_CHOICE_DURATION_SEC = 18
--- 临时关闭每层结束后的肉鸽词条三选一。
____exports.GREED_CAVE_RUN_MODIFIER_CHOICE_ENABLED = false
--- 首名玩家进入洞窟后的开战倒计时。
____exports.GREED_CAVE_ENTRY_COUNTDOWN_SEC = 15
--- 楼层选择继续后的下一层开战倒计时。
____exports.GREED_CAVE_NEXT_FLOOR_COUNTDOWN_SEC = 3
--- 普通波总普通怪数量。
____exports.GREED_CAVE_NORMAL_TOTAL = 50
--- 普通波场上最多同时存在的普通怪数量。
____exports.GREED_CAVE_NORMAL_MAX_ALIVE = 15
--- 普通波中精英段的精英怪数量。
____exports.GREED_CAVE_ELITE_TOTAL = 5
--- 首个 Boss 血量低于该比例时，提前触发后续 Boss 入场。
____exports.GREED_CAVE_BOSS_FOLLOWUP_HEALTH_TRIGGER_PCT = 0.7
--- 双 Boss 波检查首个 Boss 血量的间隔。
____exports.GREED_CAVE_BOSS_FOLLOWUP_CHECK_INTERVAL_SEC = 0.2
--- 每名玩家结算商店展示的商品数量。
____exports.GREED_CAVE_SHOP_OFFER_COUNT = 5
return ____exports