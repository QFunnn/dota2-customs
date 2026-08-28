--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 0b85d8d 
  ~ auto-generated — do not edit
]]


const THINK = 0.01;
const PINGS_COUNT = 7;
const MIN_OFFSET = 18;
const MAX_OFFSET = 200;
const TRIGGER_TIME_FOR_WHEEL = 0.1;

// 80 - that's 1/2 of height/width from HUD_PING_WHEEL
const hud_wheel_half_width = 80;
const hud_wheel_half_height = 80;

// 80 - that's 1/2 of height/width from HUD_PING_WHEEL
const hud_ping_root_half_width = 25;
const hud_ping_root_half_height = 25;

// Game World width / height
const WORLD_Y = 9000;
const WORLD_X = 9000;

const C_PingsTypes = {
	DEFAULT: 0,
	DANGER: 1,
	WAYPOINT: 2,
	RETREAT: 3,
	ATTACK: 4,
	ENEMY_WARD: 5,
	FRIENDLY_WARD: 6,
};

const PINGS_DATA = {
	[C_PingsTypes.DEFAULT]: {
		image: "file://{resources}/images/custom_game/ping_icon_world_minimap.png",
		sound: "General.Ping",
	},
	[C_PingsTypes.DANGER]: {
		image: "file://{resources}/images/custom_game/import_dota/ping_danger_psd.png",
		sound: "General.PingWarning",
	},
	[C_PingsTypes.WAYPOINT]: {
		image: "file://{resources}/images/custom_game/ping_icon_waypoint_minimap.png",
		sound: "General.PingWaypoint",
	},
	[C_PingsTypes.RETREAT]: {
		image: "file://{resources}/images/custom_game/import_dota/ping_danger_psd.png",
		sound: "General.PingWarning",
	},
	[C_PingsTypes.ATTACK]: {
		image: "file://{resources}/images/custom_game/import_dota/ping_icon_attack_psd.png",
		sound: "General.PingAttack",
	},
	[C_PingsTypes.ENEMY_WARD]: {
		image: "file://{resources}/images/custom_game/import_dota/ping_icon_enemyward_psd.png",
		sound: "General.PingEnemyWard",
	},
	[C_PingsTypes.FRIENDLY_WARD]: {
		image: "file://{resources}/images/custom_game/import_dota/ping_icon_friendlyward_psd.png",
		sound: "General.PingFriendlyWard",
	},
};

/* HUD */
const HUD_ROOT_FOR_TRACKER = FindDotaHudElement("HeroRelicProgress");
const HUD_PING_WHEEL = $("#Custom_PingWheel");
const HUD_FOR_CUSTOM_PINGS = $("#CustomPings_Minimap");
const ROOT = $.GetContextPanel();

/* DOTA HUD */
const minimap = FindDotaHudElement("minimap_block");
const dota_hud = FindDotaHudElement("Hud");