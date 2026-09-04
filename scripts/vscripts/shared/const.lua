--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build ec5ff63 
  ~ auto-generated — do not edit
]]


--[[ Generated with https://github.com/TypeScriptToLua/TypeScriptToLua ]]
local ____exports = {}
____exports.GAME_NAME = "axe_king"
--- 英雄等级与职业经验限制配置，前后端共用同一套口径。
____exports.HERO_LEVEL_CONFIG = { maxLevel = 30, professionLevelStep = 5, firstTierInitialLevel = 5 }
--- 英雄低等级段累计总经验。
local HERO_LEVEL_BASE_TOTAL_EXP = {
	[1] = 0,
	[2] = 100,
	[3] = 300,
	[4] = 500,
	[5] = 800,
	[6] = 1300,
	[7] = 1800,
}
--- 返回达到目标英雄等级需要的累计总经验。
function ____exports.CalculateHeroTotalExperienceForLevel(self, level)
	local targetLevel = math.floor(level)
	if targetLevel <= 1 then
		return 0
	end
	local baseExp = HERO_LEVEL_BASE_TOTAL_EXP[targetLevel]
	if baseExp ~= nil then
		return baseExp
	end
	local exp = HERO_LEVEL_BASE_TOTAL_EXP[5]
	do
		local i = 6
		while i <= targetLevel do
			exp = math.floor(i * 300 + 240 * 1.26 ^ i - 300) + exp
			i = i + 1
		end
	end
	return exp
end
--- 构建引擎自定义英雄等级经验表。
function ____exports.BuildHeroTotalExperienceTable(self, maxLevel)
	if maxLevel == nil then
		maxLevel = ____exports.HERO_LEVEL_CONFIG.maxLevel
	end
	local safeMaxLevel = math.max(1, math.floor(maxLevel))
	local ____table = {}
	do
		local level = 1
		while level <= safeMaxLevel do
			____table[level] = ____exports.CalculateHeroTotalExperienceForLevel(nil, level)
			level = level + 1
		end
	end
	return ____table
end
--- 主属性（力量/敏捷/智力）每点提供的次级属性加成
____exports.ATTR_PRIMARY_BONUS = {
	strength_health = 6,
	strength_health_regen = 0.1,
	agility_attack_speed_decay = 500,
	agility_attack_speed_cap = 240,
	agility_armor = 0.075,
	intelligence_mana = 0.85,
	intelligence_mana_regen = 0.02,
	intelligence_magic_resistance_decay = 500,
	intelligence_magic_resistance_cap = 50,
	primary_attr_attack_damage = 0.8,
	universal_attr_attack_damage = 0.3,
}
--- 根据智力计算魔法抗性加成：x / (x + 10) * 60
function ____exports.CalculateIntelligenceMagicResistance(self, intelligence)
	local safeIntelligence = math.max(0, intelligence)
	if safeIntelligence <= 0 then
		return 0
	end
	return safeIntelligence
		/ (safeIntelligence + ____exports.ATTR_PRIMARY_BONUS.intelligence_magic_resistance_decay)
		* ____exports.ATTR_PRIMARY_BONUS.intelligence_magic_resistance_cap
end
--- 根据敏捷计算攻击速度加成：x / (x + 衰减常量) * 上限系数
function ____exports.CalculateAgilityAttackSpeed(self, agility)
	local safeAgility = math.max(0, agility)
	if safeAgility <= 0 then
		return 0
	end
	return safeAgility
		/ (safeAgility + ____exports.ATTR_PRIMARY_BONUS.agility_attack_speed_decay)
		* ____exports.ATTR_PRIMARY_BONUS.agility_attack_speed_cap
end
--- 宝箱类型枚举
-- 类型声明在 common_type.d.ts 的 declare global 中
____exports.TreasureType = { Treasure1 = "1", Treasure2 = "2", Treasure3 = "3" }
return ____exports