--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 0b85d8d 
  ~ auto-generated — do not edit
]]


TEAM_COLORS = {
	[DOTA_TEAM_GOODGUYS] = { 61, 210, 150 },
	[DOTA_TEAM_BADGUYS] = { 243, 201, 9 },
}

PLAYER_COLORS = {
	[DOTA_TEAM_GOODGUYS] = {
		{ 70, 70, 255 },
		{ 0, 255, 255 },
		{ 255, 0, 255 },
		{ 255, 255, 0 },
		{ 255, 165, 0 },
		{ 0, 255, 0 },
		{ 255, 0, 0 },
		{ 75, 0, 130 },
		{ 109, 49, 19 },
		{ 255, 20, 147 },
		{ 128, 128, 0 },
		{ 255, 255, 255 },
	},
	[DOTA_TEAM_BADGUYS] = {
		{ 255, 135, 195 },
		{ 160, 180, 70 },
		{ 100, 220, 250 },
		{ 0, 128, 0 },
		{ 165, 105, 0 },
		{ 153, 50, 204 },
		{ 0, 128, 128 },
		{ 0, 0, 165 },
		{ 128, 0, 0 },
		{ 180, 255, 180 },
		{ 255, 127, 80 },
		{ 0, 0, 0 },
	},
}

TEAMS_LAYOUTS = {
	["dota"] = {
		player_count = 12,
		teamlist = {
			DOTA_TEAM_GOODGUYS,
			DOTA_TEAM_BADGUYS,
		},
		ring_bonuses = {
			gpm = 900,
			xpm = 1440,
		},
		ring_radius = 1400,
		overboss_throw_chance = 2,
		kill_goal = 125,
		abandon_kill_goal_reduction = 4,
		kills_by_vote = 2,
		time_by_vote = 12.5,
		game_base_duration = 1200,

		gg_token_kill_goal_bonus = 20,
		rating_changes = { 30, 0, -30 },

		min_connected_players = 4,
	},
}

PREGAME_TIME = 90

GAME_DURATION_OPTIONAL_EARLY_CONSUMABLES_TIME = 20

RANDOM_BONUS_ITEMS = { "item_faerie_fire", "item_enchanted_mango", "item_infused_raindrop" }

MAX_NEUTRAL_ITEMS_PER_PLAYER = 1

PRINT_EXTENDED_DEBUG = false
DEV_BOTS_ENABLED = false
DEV_RANDOM_WINRATES = false
DEV_ENABLE_SPECTATOR_TEAM = false
DEV_ORB_DROP_PINGS = false

RATING_MULTIPLIER = 0.0125
RATING_CHANGE_CAP = 20

-- 10 minutes for simulated end game, makes sure we won't hog dedicated servers with neverending games
SIMULATED_END_GAME_DELAY = 600

DEVELOPERS = {
	["76561198132422587"] = true, -- Sanctus Animus
	["76561198064622537"] = true, -- Sheodar
	["76561198007141460"] = true, -- Firetoad
	["76561198188258659"] = true, -- Luminance
	["76561199069138789"] = true, -- Dota 2 unofficial
	["76561198040469212"] = true, -- Draze22
	["76561198007063562"] = true, -- Daser27
}

KNOWN_LOCALE_ALIASES = {
	eng = "english",
	en = "english",
	ru = "russian",
	fr = "french",
}

END_GAME_PLAYER_COUNT_CHECK_ENABLED = not IsInToolsMode()

CUSTOM_GPM_INTERVAL = 0.2
CUSTOM_GPM_GOLD_PER_TICK = 12

RESPAWN_TIME_SCALE = 0.65
RESPAWN_REDUCTION_PER_MISSING_HERO = 5 -- Disadvantaged teams get 5 seconds less respawn time for every missing player

-- Rebalance the distribution of gold and XP to make for a better 12v12 game
GOLD_SCALE_FACTOR_INITIAL = 1.5
GOLD_SCALE_FACTOR_FINAL = 1.5
GOLD_SCALE_FACTOR_FADEIN_SECONDS = (60 * 60) -- 60 minutes
GOLD_MULTIPLIER_FOR_LANE_CREEPS = 1.5
XP_SCALE_FACTOR_INITIAL = 2
XP_SCALE_FACTOR_FINAL = 2
XP_SCALE_FACTOR_FADEIN_SECONDS = (60 * 60) -- 60 minutes

-- Event Proxies
_G.MODIFIER_EVENT_ON_TAKEDAMAGE_CUSTOM = 10001 -- OnTakeDamage(), runs for any damage on the map
_G.MODIFIER_PROPERTY_ON_DEALDAMAGE_CUSTOM = 10002 -- OnDealDamage(), runs for only parent dealing damage

RAPIER_CHECK_NETWORTH = 15000
RAPIER_CHECK_RESTRICTION_TIME = 40 * 60

REDISTRIBUTE_GOLD_INTERVAL = 30

BARRACKS_RESPAWN_TIMES = {
	npc_dota_goodguys_range_rax_top = 2,
	npc_dota_goodguys_melee_rax_top = 4,
	npc_dota_goodguys_range_rax_mid = 2,
	npc_dota_goodguys_melee_rax_mid = 4,
	npc_dota_goodguys_range_rax_bot = 2,
	npc_dota_goodguys_melee_rax_bot = 4,
	npc_dota_badguys_range_rax_top = 2,
	npc_dota_badguys_melee_rax_top = 4,
	npc_dota_badguys_range_rax_mid = 2,
	npc_dota_badguys_melee_rax_mid = 4,
	npc_dota_badguys_range_rax_bot = 2,
	npc_dota_badguys_melee_rax_bot = 4,
}

DOTA_ABILITY_BEHAVIOR_UNSWAPPABLE = 17592186044416 -- 2^44