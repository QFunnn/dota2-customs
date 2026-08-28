--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 0b85d8d 
  ~ auto-generated — do not edit
]]


LinkLuaModifier(
	"modifier_ability_upgrades_controller",
	"game/upgrades/modifier_ability_upgrades_controller",
	LUA_MODIFIER_MOTION_NONE
)

RARITY_TEXT_TO_ENUM = {
	common = UPGRADE_RARITY_COMMON,
	rare = UPGRADE_RARITY_RARE,
	epic = UPGRADE_RARITY_EPIC,
}

RARITY_ENUM_TO_TEXT = {
	[UPGRADE_RARITY_COMMON] = "common",
	[UPGRADE_RARITY_RARE] = "rare",
	[UPGRADE_RARITY_EPIC] = "epic",
}

---@class UPGRADE_TYPE
---@field ABILITY number
---@field GENERIC number
UPGRADE_TYPE = {
	ABILITY = 1,
	GENERIC = 2,
}

---@type table<UPGRADE_TYPE, number>
UPGRADE_COUNT_PER_SELECTION = {
	[UPGRADE_TYPE.ABILITY] = 3,
	[UPGRADE_TYPE.GENERIC] = 1,
}

---@class UPGRADE_OPERATOR
---@field ADD number
---@field MULTIPLY number
UPGRADE_OPERATOR = {
	ADD = 1,
	MULTIPLY = 2,
}

---@type table<string, UPGRADE_OPERATOR>
OPERATOR_TEXT_TO_ENUM = {
	OP_ADD = UPGRADE_OPERATOR.ADD,
	OP_MULTIPLY = UPGRADE_OPERATOR.MULTIPLY,
}

BUILD_MAX_PER_SUB_TIER = {
	[0] = 2,
	[1] = 4,
	[2] = 8,
}

DEFAULT_MULTIPLICATION_TARGET = 90

TOURNAMENT_REROLLS = 8