--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


-- Update interval for internal update timer
CHALLENGES_UPDATE_INTERVAL = 1
CHALLENGES_WINRATE_BRACKET_SIZE = 12 -- divide winrate table into brackets of N size for weights
CHALLENGES_WINRATE_WEIGHT_STEP = 4

-- 20% bonus reward from each winrate bracket step
-- starting from second bracket
CHALLENGE_REWARD_BONUS_FROM_BRACKET = 0.25
CURRENCY_REWARD_BOUNDARY = 5 -- round currency reward to nearest 5 (cause fancy!)


---@class CHALLENGE_TYPE @ Possible challenge types to roll
--- NEVER, EVER, UNDER ANY CIRCUMSTANCE REMOVE OPTIONS WITHOUT DISCUSSION - THIS INVALIDATES ALL ONGOING CHALLENGES OF THAT TYPE
---@type table<string, number>
CHALLENGE_TYPE = {
	DEAL_DAMAGE = 1,
	TAKE_DAMAGE = 2,
	HEAL = 3,
	STUN = 4,
	CAPTURE_TIME = 5,
	-- BREAK_WARD = 6,
	KILL = 7,
	ASSIST = 8,
	DEAL_DAMAGE_WITH_SUMMONS = 9,
}


CHALLENGE_TYPE_LOOKUP = table.swap(CHALLENGE_TYPE)


---@class HERO_PRESETS @ Common available challenges configurations to mix and match for easier definitions
HERO_PRESETS = {
	BASIC = {CHALLENGE_TYPE.DEAL_DAMAGE, CHALLENGE_TYPE.CAPTURE_TIME, CHALLENGE_TYPE.KILL, CHALLENGE_TYPE.ASSIST},
	HEAL = {CHALLENGE_TYPE.HEAL, CHALLENGE_TYPE.DEAL_DAMAGE, CHALLENGE_TYPE.CAPTURE_TIME, CHALLENGE_TYPE.KILL, CHALLENGE_TYPE.ASSIST},
	STUN = {CHALLENGE_TYPE.STUN, CHALLENGE_TYPE.DEAL_DAMAGE, CHALLENGE_TYPE.CAPTURE_TIME, CHALLENGE_TYPE.KILL, CHALLENGE_TYPE.ASSIST},
	SUMMON = {CHALLENGE_TYPE.DEAL_DAMAGE_WITH_SUMMONS, CHALLENGE_TYPE.DEAL_DAMAGE, CHALLENGE_TYPE.CAPTURE_TIME, CHALLENGE_TYPE.KILL, CHALLENGE_TYPE.ASSIST},
	TANK = {CHALLENGE_TYPE.TAKE_DAMAGE, CHALLENGE_TYPE.DEAL_DAMAGE, CHALLENGE_TYPE.CAPTURE_TIME, CHALLENGE_TYPE.KILL, CHALLENGE_TYPE.ASSIST},

	HEAL_STUN = {CHALLENGE_TYPE.HEAL, CHALLENGE_TYPE.STUN, CHALLENGE_TYPE.DEAL_DAMAGE, CHALLENGE_TYPE.CAPTURE_TIME, CHALLENGE_TYPE.KILL, CHALLENGE_TYPE.ASSIST},
	HEAL_SUMMON = {CHALLENGE_TYPE.HEAL, CHALLENGE_TYPE.DEAL_DAMAGE_WITH_SUMMONS, CHALLENGE_TYPE.DEAL_DAMAGE, CHALLENGE_TYPE.CAPTURE_TIME, CHALLENGE_TYPE.KILL, CHALLENGE_TYPE.ASSIST},
	HEAL_TANK = {CHALLENGE_TYPE.HEAL, CHALLENGE_TYPE.TAKE_DAMAGE, CHALLENGE_TYPE.DEAL_DAMAGE, CHALLENGE_TYPE.CAPTURE_TIME, CHALLENGE_TYPE.KILL, CHALLENGE_TYPE.ASSIST},
	STUN_SUMMON = {CHALLENGE_TYPE.STUN, CHALLENGE_TYPE.DEAL_DAMAGE_WITH_SUMMONS, CHALLENGE_TYPE.DEAL_DAMAGE, CHALLENGE_TYPE.CAPTURE_TIME, CHALLENGE_TYPE.KILL, CHALLENGE_TYPE.ASSIST},
	STUN_TANK = {CHALLENGE_TYPE.STUN, CHALLENGE_TYPE.TAKE_DAMAGE, CHALLENGE_TYPE.DEAL_DAMAGE, CHALLENGE_TYPE.CAPTURE_TIME, CHALLENGE_TYPE.KILL, CHALLENGE_TYPE.ASSIST},
	SUMMON_TANK = {CHALLENGE_TYPE.DEAL_DAMAGE_WITH_SUMMONS, CHALLENGE_TYPE.TAKE_DAMAGE, CHALLENGE_TYPE.DEAL_DAMAGE, CHALLENGE_TYPE.CAPTURE_TIME, CHALLENGE_TYPE.KILL, CHALLENGE_TYPE.ASSIST},

	HEAL_STUN_SUMMON = {CHALLENGE_TYPE.HEAL, CHALLENGE_TYPE.STUN, CHALLENGE_TYPE.DEAL_DAMAGE_WITH_SUMMONS, CHALLENGE_TYPE.DEAL_DAMAGE, CHALLENGE_TYPE.CAPTURE_TIME, CHALLENGE_TYPE.KILL, CHALLENGE_TYPE.ASSIST},
	HEAL_STUN_TANK = {CHALLENGE_TYPE.HEAL, CHALLENGE_TYPE.STUN, CHALLENGE_TYPE.TAKE_DAMAGE, CHALLENGE_TYPE.DEAL_DAMAGE, CHALLENGE_TYPE.CAPTURE_TIME, CHALLENGE_TYPE.KILL, CHALLENGE_TYPE.ASSIST},
	HEAL_SUMMON_TANK = {CHALLENGE_TYPE.HEAL, CHALLENGE_TYPE.DEAL_DAMAGE_WITH_SUMMONS, CHALLENGE_TYPE.TAKE_DAMAGE, CHALLENGE_TYPE.DEAL_DAMAGE, CHALLENGE_TYPE.CAPTURE_TIME, CHALLENGE_TYPE.KILL, CHALLENGE_TYPE.ASSIST},
	STUN_SUMMON_TANK = {CHALLENGE_TYPE.STUN, CHALLENGE_TYPE.DEAL_DAMAGE_WITH_SUMMONS, CHALLENGE_TYPE.TAKE_DAMAGE, CHALLENGE_TYPE.DEAL_DAMAGE, CHALLENGE_TYPE.CAPTURE_TIME, CHALLENGE_TYPE.KILL, CHALLENGE_TYPE.ASSIST},
	ALL = {CHALLENGE_TYPE.HEAL, CHALLENGE_TYPE.STUN, CHALLENGE_TYPE.DEAL_DAMAGE_WITH_SUMMONS, CHALLENGE_TYPE.TAKE_DAMAGE, CHALLENGE_TYPE.DEAL_DAMAGE, CHALLENGE_TYPE.CAPTURE_TIME, CHALLENGE_TYPE.KILL, CHALLENGE_TYPE.ASSIST},
}


CHALLENGES_COUNT = {
	[0] = 4,
	[1] = 4,
	[2] = 4,
}

---@class CHALLENGE_DIFFICULTY @ difficulty of a challenge
CHALLENGE_DIFFICULTY = {
	COMMON = 1,
	RARE = 2,
	EPIC = 3,
}


---@class CHALLENGE_DIFFICULTY_MULTIPLIER @ difficulty multiplier for challenge target and reward
---@type table<CHALLENGE_DIFFICULTY, number>
CHALLENGE_DIFFICULTY_MULTIPLIER = {
	[CHALLENGE_DIFFICULTY.COMMON] = 1,
	[CHALLENGE_DIFFICULTY.RARE] = 1.5,
	[CHALLENGE_DIFFICULTY.EPIC] = 2,
}

---@class CHALLENGE_DIFFICULTY_MULTIPLIER_KILLS @ difficulty multiplier for challenge target override for kill challenges since they get much harder/impossible
---@type table<CHALLENGE_DIFFICULTY, number>
CHALLENGE_DIFFICULTY_MULTIPLIER_KILLS_OVERRIDE = {
	[CHALLENGE_DIFFICULTY.COMMON] = 1,
	[CHALLENGE_DIFFICULTY.RARE] = 1.25,
	[CHALLENGE_DIFFICULTY.EPIC] = 1.5,
}


CHALLENGE_DIFFICULTY_LOOKUP = table.swap(CHALLENGE_DIFFICULTY)


CHALLENGE_DIFFICULTY_ROLL_CHANCE = {
	[CHALLENGE_DIFFICULTY.COMMON] = 55,
	[CHALLENGE_DIFFICULTY.RARE] = 35,
	[CHALLENGE_DIFFICULTY.EPIC] = 10,
}


---@class CHALLENGE_BASE_REWARD @ base rewards given by completing a challenge (before difficulty application)
CHALLENGE_BASE_REWARD = {
	currency = 20,
	items = {bp_reroll = 1}
}


---@type table<CHALLENGE_TYPE, function>
CHALLENGE_ACCESSOR = {
	[CHALLENGE_TYPE.DEAL_DAMAGE] 				= function(player_id) return EndGameStats:GetStats(player_id).hero_damage or 0 end,
	[CHALLENGE_TYPE.TAKE_DAMAGE] 				= function(player_id) return EndGameStats:GetStats(player_id).damage_taken or 0 end,
	[CHALLENGE_TYPE.HEAL] 						= function(player_id) return EndGameStats:GetStats(player_id).total_healing or 0 end,
	[CHALLENGE_TYPE.STUN] 						= function(player_id) return PlayerResource:GetStuns(player_id) or 0 end,
	[CHALLENGE_TYPE.CAPTURE_TIME] 				= function(player_id) return MVPController.orb_capture_score[player_id] or 0 end,
	-- [CHALLENGE_TYPE.BREAK_WARD] 				= function(player_id)
	-- 	local wards_killed = EndGameStats:GetStats(player_id).wards_killed
	-- 	return wards_killed.npc_dota_observer_wards or 0
	-- end,
	[CHALLENGE_TYPE.KILL] 						= function(player_id) return PlayerResource:GetKills(player_id) or 0 end,
	[CHALLENGE_TYPE.ASSIST] 					= function(player_id) return PlayerResource:GetKills(player_id) + PlayerResource:GetAssists(player_id) or 0 end,
	[CHALLENGE_TYPE.DEAL_DAMAGE_WITH_SUMMONS] 	= function(player_id) return EndGameStats:GetStats(player_id).summon_damage end,
}


---@class CHALLENGE_TARGETS @ default targets for a given challenge type (base)
---@type table<CHALLENGE_TYPE, table>
CHALLENGE_TARGETS = {
	-- Targets are an array of values per map:	ffa => duos => quintet => octet
	[CHALLENGE_TYPE.DEAL_DAMAGE] 				= {55000, 65000, 65000, 60000},
	[CHALLENGE_TYPE.TAKE_DAMAGE] 				= {115000, 150000, 150000, 140000},
	[CHALLENGE_TYPE.HEAL] 						= {99999, 5500, 11000, 13000},
	[CHALLENGE_TYPE.STUN] 						= {75, 85, 80, 75},
	[CHALLENGE_TYPE.CAPTURE_TIME] 				= {75, 75, 75, 75},
	-- [CHALLENGE_TYPE.BREAK_WARD] 				= {2, 2, 2, 2},
	[CHALLENGE_TYPE.KILL] 						= {13, 15, 13, 12},
	[CHALLENGE_TYPE.ASSIST] 					= {33, 53, 62, 68}, -- total possible assists: 30 * 7 = 210, 5 * 4 = 200, 90 * 2 = 180, 125 * 2 = 250
	[CHALLENGE_TYPE.DEAL_DAMAGE_WITH_SUMMONS] 	= {13000, 17000, 16000, 14000},
}

---@class CHALLENGE_MAP_INDEX @ maps map name to index in challenge targets
---@type table<string, number>
-- If you need to add new map - just add it in, in any place - only have to make sure targets follow same order in CHALLENGE_TARGETS
CHALLENGE_MAP_INDEX = {
	ot3_necropolis_ffa = 1,
	ot3_gardens_duo = 2,
	ot3_jungle_quintet = 3,
	ot3_desert_octet = 4,
}

---@class BackendChallenge @ backend view of challenge
---@field id number
---@field hero_id number
---@field challenge_type CHALLENGE_TYPE
---@field difficulty number
---@field completed boolean @ is this challenge completed?


---@class Challenge @ hero challenge
---@field id number
---@field hero_name string
---@field challenge_type CHALLENGE_TYPE
---@field difficulty number
---@field progress number @ current challenge progress
---@field target number @ challenge target
---@field completed boolean @ is this challenge completed?