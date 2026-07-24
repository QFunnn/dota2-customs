--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


const HUD = {
	CONTEXT: $.GetContextPanel(),
	CUSTOM_CHAT_CONTAINER: $("#EG_ChatContainer"),

	EG_PHASE_1: $("#EG_Phase_1"),
	EG_PHASE_1_VICTORY_TOP_TEAMS_ROOT: $("#EG_TopTeamsPreviews_Root"),

	EG_PHASE_2: $("#EG_Phase_2"),
	EG_PHASE_2_STATS_CONTAINER: $("#EG_LocalStats"),
	EG_PHASE_2_LOCAL_BADGES: $("#EG_LocalMVPBadges"),
	EG_PHASE_2_LOCAL_HERO_MODEL_CONTAINER: $("#EG_LocalHero_Model_Container"),
	EG_PHASE_2_LOCAL_PLAYER_NAME: $("#EG_Local_PlayerName"),
	EG_PHASE_2_LOCAL_TEAM_KILLS_CONTAINER: $("#EG_Local_TeamKills_Container"),
	EG_PHASE_2_CHALLENGE: $("#EG_Challenge_Root"),
	EG_PHASE_2_CHALLENGE_REWARDS: $("#EG_C_RewardsContainer"),
	EG_PHASE_2_CHALLENGE_PFX_COMPLTED: $("#EG_C_Particle_Completed"),

	EG_PHASE_3: $("#EG_Phase_3"),
	EG_PHASE_3_MVP_HEROES: $("#EG_MVP_Heroes"),

	EG_PHASE_4: $("#EG_Phase_4"),
	EG_PHASE_4_BASIC_TEAMS_CONTAINER: $("#EG_TeamsAndPlayer"),
	EG_PHASE_4_FULL_ROWS_CONTAINER: $("#EG_FullStatsRows_Container"),
	EG_PHASE_4_HEADERS_ROOT: $("#EG_FullTable_Headers"),
	EG_PHASE_4_ERRORS_CONTAINER: $("#EG_AIC_ServerErrorsContainer"),
};

const MVP_CATEGORY = {
	// WARDS: 1,
	// KILLS_AND_ASSISTS: 2,
	DAMAGE_DEALT: 3,
	DAMAGE_TAKEN: 4,
	ALLY_HEALING: 5,
	ORBS_CAPTURED: 6,
	UPGRADES_VARIETY: 7,
	STUN_DURATION: 8,

	KILLS: 9,
	ASSISTS: 10,
	LEAST_DEATHS: 11,
	UNITS_SUMMONED: 12,

	WARDS_REVEAL_TIME: 13,
};

const POSTFIXES_FOR_CATEGORIES = {
	[MVP_CATEGORY.ORBS_CAPTURED]: "badge_orbs_captured_seconds_postfix",
	[MVP_CATEGORY.STUN_DURATION]: "badge_orbs_captured_seconds_postfix",
};

const END_GAME_EFFECTS_CONFIG = [
	{
		stat_name: "desolator_stacks",
		panel_type: "DOTAItemImage",
		item_name: "item_desolator",
	},
	{
		stat_name: "legion_duel_damage",
		panel_type: "DOTAAbilityImage",
		ability_name: "legion_commander_duel",
		modifier_name: "modifier_legion_commander_duel_damage_boost",
	},
	{
		stat_name: "slark_permanent_agi",
		panel_type: "DOTAAbilityImage",
		ability_name: "slark_essence_shift",
		modifier_name: "modifier_slark_essence_shift_permanent_buff",
	},
	{
		stat_name: "lion_finger_stacks",
		panel_type: "DOTAAbilityImage",
		ability_name: "lion_finger_of_death",
		modifier_name: "modifier_lion_finger_of_death_kill_counter",
	},
	{
		stat_name: "silencer_int",
		panel_type: "Image",
		hero_image: "npc_dota_hero_silencer",
		modifier_name: "modifier_silencer_brain_drain",
	},
	{
		stat_name: "pudge_str",
		panel_type: "Image",
		hero_image: "npc_dota_hero_pudge",
		modifier_name: "modifier_pudge_innate_graft_flesh",
	},
	{
		stat_name: "necrolyte_reapers_stacks",
		panel_type: "DOTAAbilityImage",
		ability_name: "necrolyte_reapers_scythe",
		modifier_name: "modifier_necrolyte_reapers_scythe_respawn_time",
	},
	{
		stat_name: "axe_coat_of_blood",
		panel_type: "Image",
		hero_image: "npc_dota_hero_axe",
		modifier_name: "modifier_axe_coat_of_blood",
	},
	{
		stat_name1: "tide_kraken_swell_stacks",
		panel_type: "DOTAAbilityImage",
		ability_name: "tidehunter_kraken_shell",
		modifier_name: "modifier_tidehunter_kraken_shell",
	},
	{
		stat_name: "shadow_fiend_souls_stacks",
		panel_type: "Image",
		hero_image: "npc_dota_hero_nevermore",
		modifier_name: "modifier_nevermore_necromastery",
	},
	{
		stat_name1: "muerta_smell_amp_stacks",
		panel_type: "DOTAAbilityImage",
		ability_name: "muerta_pierce_the_veil",
		modifier_name: "modifier_muerta_pierce_the_veil_spell_amp_boost",
	},
	{
		stat_name: "storm_spirit_facet_galvanized_stacks",
		panel_type: "Image",
		hero_image: "npc_dota_hero_storm_spirit",
		modifier_name: "modifier_storm_spirit_galvanized",
	},
	{
		stat_name: "power_capture_stacks",
		panel_type: "Image",
		hero_image: "npc_dota_hero_arc_warden",
		modifier_name: "modifier_arc_warden_runic_infusion",
	},
	{
		stat_name: "rattletrap_armor_stacks",
		panel_type: "Image",
		hero_image: "npc_dota_hero_rattletrap",
		modifier_name: "modifier_rattletrap_junk_mail",
	},
	{
		stat_name: "life_stealer_feast_stacks",
		panel_type: "Image",
		hero_image: "npc_dota_hero_life_stealer",
		modifier_name: "modifier_life_stealer_feast",
	},
];

const IS_PROMO_ENABLED = false;
const PROMO_GAME_LINKS = {
	angel_arena_classic: 3295624094,
	"12v12": 1576297063,
};
const CURRENT_PROMO_GAME = "angel_arena_classic";