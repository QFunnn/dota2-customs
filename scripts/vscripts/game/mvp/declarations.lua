--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


MVP_REWARDS = {
	ot3_necropolis_ffa = {
		{items = {bp_reroll = 8}}, -- MVP
		{items = {bp_reroll = 4}}, -- runner up 1
		{items = {bp_reroll = 4}}, -- runner up 2
	},
	ot3_gardens_duo = {
		{items = {bp_reroll = 8}}, -- MVP
		{items = {bp_reroll = 4}}, -- runner up 1
		{items = {bp_reroll = 4}}, -- runner up 2
	},
	ot3_jungle_quintet = {
		{items = {bp_reroll = 12}}, -- MVP
		{items = {bp_reroll = 6}}, -- runner up 1
		{items = {bp_reroll = 6}}, -- runner up 2
	},
	ot3_desert_octet = {
		{items = {bp_reroll = 14}}, -- MVP
		{items = {bp_reroll = 7}}, -- runner up 1
		{items = {bp_reroll = 7}}, -- runner up 2
	},
}


---@class MVP_TYPE
---@type table<string, number>
MVP_TYPE = {
	NONE = 0,
	WINNER = 1,
	RUNNER_UP_1 = 2,
	RUNNER_UP_2 = 3,
}


---@class MVP_CATEGORY
---@type table<string, number>
MVP_CATEGORY = {
	-- WARDS = 1, -- deprecated in favour of ward reveal time
	-- KILLS_AND_ASSISTS = 2, -- deprecated in favour of separate categories
	DAMAGE_DEALT = 3,
	DAMAGE_TAKEN = 4,
	ALLY_HEALING = 5,
	ORBS_CAPTURED = 6,
	UPGRADES_VARIETY = 7,
	STUN_DURATION = 8,

	KILLS = 9,
	ASSISTS = 10,
	LEAST_DEATHS = 11,
	UNITS_SUMMONED = 12,

	WARDS_REVEAL_TIME = 13,
}

-- categories mentioned here have their ranks multiplied by desired value
-- to tweak category impact on overall MVP result
MVP_WEIGHT_OVERRIDE = {
	[MVP_CATEGORY.UPGRADES_VARIETY] = 0.1, -- 5x less valuable
	[MVP_CATEGORY.UNITS_SUMMONED] = 0.1,
	--[MVP_CATEGORY.WARDS] = 0.2,
	[MVP_CATEGORY.DAMAGE_TAKEN] = 0.5,
	[MVP_CATEGORY.ASSISTS] = 0.5,
	[MVP_CATEGORY.STUN_DURATION] = 0.5,
	[MVP_CATEGORY.ALLY_HEALING] = 0.5,
	[MVP_CATEGORY.ORBS_CAPTURED] = 1.5,
	[MVP_CATEGORY.LEAST_DEATHS] = 0.75,

	[MVP_CATEGORY.DAMAGE_DEALT] = 0.9,
	[MVP_CATEGORY.KILLS] = 1.5,

	[MVP_CATEGORY.WARDS_REVEAL_TIME] = 0.2,
}


MVP_ASCENDING = false -- highest value = highest rank
MVP_DESCENDING = true -- lowest value = highest rank

-- Overrides category rank sorting (default is MVP_ASCENDING)
---@class MVP_RANK_ORDER
---@type table<MVP_CATEGORY, number>
MVP_RANK_ORDER = {
	[MVP_CATEGORY.LEAST_DEATHS] = MVP_DESCENDING,
}


-- being a leader in certain category grants more points towards total score
MVP_LEADER_MULTIPLIER = 1.3


---@class MVP_ACCESSOR
---@type table<MVP_CATEGORY, function>
MVP_ACCESSOR = {

	[MVP_CATEGORY.WARDS_REVEAL_TIME] = function(player_id) return MVPController.wards_score[player_id] or 0 end,
	[MVP_CATEGORY.DAMAGE_DEALT] = function(player_id) return EndGameStats:GetStats(player_id).hero_damage or 0 end,
	[MVP_CATEGORY.DAMAGE_TAKEN] = function(player_id) return EndGameStats:GetStats(player_id).damage_taken or 0 end,
	[MVP_CATEGORY.ALLY_HEALING] = function(player_id) return EndGameStats:GetStats(player_id).total_healing or 0 end,
	[MVP_CATEGORY.ORBS_CAPTURED] = function(player_id) return MVPController.orb_capture_score[player_id] or 0 end,
	[MVP_CATEGORY.UPGRADES_VARIETY] = function(player_id) return MVPController:GetUniqueUpgradesCount(player_id) or 0 end,
	[MVP_CATEGORY.STUN_DURATION] = function(player_id) return PlayerResource:GetStuns(player_id) or 0 end,
	[MVP_CATEGORY.KILLS] = function(player_id) return PlayerResource:GetKills(player_id) or 0 end,
	[MVP_CATEGORY.ASSISTS] = function(player_id) return PlayerResource:GetAssists(player_id) or 0 end,
	[MVP_CATEGORY.LEAST_DEATHS] = function(player_id) return PlayerResource:GetDeaths(player_id) end,
	[MVP_CATEGORY.UNITS_SUMMONED] = function(player_id) return MVPController:GetUnitsSummonedCount(player_id) end,

	-- deprecated
	-- [MVP_CATEGORY.KILLS_AND_ASSISTS] = function(player_id) return PlayerResource:GetAssists(player_id) + PlayerResource:GetKills(player_id) end,

	-- [MVP_CATEGORY.WARDS] = function(player_id)
	-- 	local wards = EndGameStats:GetStats(player_id).wards
	-- 	return wards["npc_dota_observer_wards"] + wards["npc_dota_sentry_wards"]
	-- end,
}


MVP_EXCLUDED_CATEGORIES_PER_MAP = {
	-- healing excluded cause self-healing is discarded, and no other allies to heal
	ot3_necropolis_ffa = {MVP_CATEGORY.ALLY_HEALING},
}

-- How much more points are awarded for detecting invis units with a sentry over seeing units with an observer
MVP_SENTRY_WARD_MULTIPLIER = 10

DOTA_ITEM_NEUTRAL_SLOT = 16
DOTA_ITEM_NEUTRAL_PASSIVE_SLOT = 17