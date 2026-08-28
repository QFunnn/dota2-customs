--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 0b85d8d 
  ~ auto-generated — do not edit
]]


const HUD = {
	CONTEXT: $.GetContextPanel(),
	CUSTOM_CHAT_CONTAINER: $("#EG_ChatContainer"),

	EG_PHASE_1: $("#EG_Phase_1"),

	EG_PHASE_2: $("#EG_Phase_2"),
	EG_PHASE_2_STATS_CONTAINER: $("#EG_LocalStats"),
	EG_PHASE_2_LOCAL_BADGES: $("#EG_LocalMVPBadges"),
	EG_PHASE_2_LOCAL_HERO_MODEL_CONTAINER: $("#EG_LocalHero_Model_Container"),
	EG_PHASE_2_LOCAL_PLAYER_NAME: $("#EG_Local_PlayerName"),
	EG_PHASE_2_LOCAL_TEAM_KILLS_CONTAINER: $("#EG_Local_TeamKills_Container"),
	EG_PHASE_2_CHALLENGE: $("#EG_Challenge_Root"),
	EG_PHASE_2_CHALLENGE_REWARDS: $("#EG_C_RewardsContainer"),
	EG_PHASE_2_CHALLENGE_PFX_COMPLTED: $("#EG_C_Particle_Completed"),
	EG_PHASE_2_EXP_BAR: $("#EG_E_ProgressBar"),
	EG_PHASE_2_EXP_REWARDS_CONTAINER: $("#EG_E_LevelupRewards"),

	EG_PHASE_3: $("#EG_Phase_3"),
	EG_PHASE_3_MVP_HEROES: $("#EG_MVP_Heroes"),

	EG_PHASE_4: $("#EG_Phase_4"),
	EG_PHASE_4_BASIC_TEAMS_CONTAINER: $("#EG_TeamsAndPlayer"),
	EG_PHASE_4_FULL_ROWS_CONTAINER: $("#EG_FullStatsRows_Container"),
	EG_PHASE_4_HEADERS_ROOT: $("#EG_FullTable_Headers"),
	EG_PHASE_4_ERRORS_CONTAINER: $("#EG_AIC_ServerErrorsContainer"),
};

const MVP_CATEGORY = {
	HERO_DAMAGE_DEALT: 1,
	BUILDING_DAMAGE_DEALT: 2,
	KILLED_CREEPS: 3,
	DENIED_CREEPS: 4,
	DAMAGE_TAKEN: 5,
	ALLY_HEALING: 6,
	KILLS: 7,
	ASSISTS: 8,
	LEAST_DEATHS: 9,
	STUN_DURATION: 10,
	WARDS: 11,
	NEUTRAL_CAMPS_STACKED: 12,
};

const POSTFIXES_FOR_CATEGORIES = {
	[MVP_CATEGORY.STUN_DURATION]: "badge_seconds_postfix",
};

const IS_PROMO_ENABLED = false;