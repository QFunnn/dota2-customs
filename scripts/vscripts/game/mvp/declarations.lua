--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build b9dc48c · 2026-08-02 17:42:46 UTC
  ~ auto-generated — do not edit
]]


MVP_REWARDS = {
	-- {items = {bp_reroll = 8}}, -- MVP
	-- {items = {bp_reroll = 4}}, -- runner up 1
	-- {items = {bp_reroll = 4}}, -- runner up 2
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
	HERO_DAMAGE_DEALT = 1,
	BUILDING_DAMAGE_DEALT = 2,
	KILLED_CREEPS = 3,
	DENIED_CREEPS = 4,
	DAMAGE_TAKEN = 5,
	ALLY_HEALING = 6,
	KILLS = 7,
	ASSISTS = 8,
	LEAST_DEATHS = 9,
	STUN_DURATION = 10,
	WARDS = 11,
	NEUTRAL_CAMPS_STACKED = 12,
}

-- categories mentioned here have their ranks multiplied by desired value
-- to tweak category impact on overall MVP result
MVP_WEIGHT_OVERRIDE = {
	[MVP_CATEGORY.KILLED_CREEPS] = 0.5,
	[MVP_CATEGORY.DENIED_CREEPS] = 0.5,
	[MVP_CATEGORY.DAMAGE_TAKEN] = 0.7,
	[MVP_CATEGORY.ASSISTS] = 0.8,
	[MVP_CATEGORY.LEAST_DEATHS] = 0.8,
	[MVP_CATEGORY.WARDS] = 0.3,
	[MVP_CATEGORY.NEUTRAL_CAMPS_STACKED] = 0.4,
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
MVP_LEADER_MULTIPLIER = 3

---@class MVP_ACCESSOR
---@type table<MVP_CATEGORY, function>
MVP_ACCESSOR = {
	[MVP_CATEGORY.WARDS] = function(player_id)
		local wards = EndGameStats:GetStats(player_id).wards
		return wards["npc_dota_observer_wards"] + wards["npc_dota_sentry_wards"]
	end,

	[MVP_CATEGORY.HERO_DAMAGE_DEALT] = function(player_id)
		return EndGameStats:GetStats(player_id).hero_damage or 0
	end,
	[MVP_CATEGORY.BUILDING_DAMAGE_DEALT] = function(player_id)
		return EndGameStats:GetStats(player_id).building_damage or 0
	end,
	[MVP_CATEGORY.KILLED_CREEPS] = function(player_id)
		return PlayerResource:GetLastHits(player_id)
	end,
	[MVP_CATEGORY.DENIED_CREEPS] = function(player_id)
		return PlayerResource:GetDenies(player_id)
	end,
	[MVP_CATEGORY.DAMAGE_TAKEN] = function(player_id)
		return EndGameStats:GetStats(player_id).damage_taken or 0
	end,
	[MVP_CATEGORY.ALLY_HEALING] = function(player_id)
		return EndGameStats:GetStats(player_id).total_healing or 0
	end,
	[MVP_CATEGORY.KILLS] = function(player_id)
		return PlayerResource:GetKills(player_id) or 0
	end,
	[MVP_CATEGORY.ASSISTS] = function(player_id)
		return PlayerResource:GetAssists(player_id) or 0
	end,
	[MVP_CATEGORY.LEAST_DEATHS] = function(player_id)
		return PlayerResource:GetDeaths(player_id)
	end,
	[MVP_CATEGORY.STUN_DURATION] = function(player_id)
		return PlayerResource:GetStuns(player_id) or 0
	end,
	[MVP_CATEGORY.NEUTRAL_CAMPS_STACKED] = function(player_id)
		return EndGameStats:GetStats(player_id).neutral_camps_stacked or 0
	end,

	-- deprecated
	-- [MVP_CATEGORY.KILLS_AND_ASSISTS] = function(player_id) return PlayerResource:GetAssists(player_id) + PlayerResource:GetKills(player_id) end,
}

MVP_EXCLUDED_CATEGORIES_PER_MAP = {
	-- healing excluded cause self-healing is discarded, and no other allies to heal
	-- ot3_necropolis_ffa = {MVP_CATEGORY.ALLY_HEALING},
}