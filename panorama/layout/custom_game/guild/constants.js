--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 0b85d8d 
  ~ auto-generated — do not edit
]]


const DotaHUD = GameUI.CustomUIConfig().DotaHUD

const NAV_TABS = [
	{ id: "main", 		icon: "🏠" },
	{ id: "talents", 	icon: "⭐" },
	{ id: "speedrun", 	icon: "⚡" },
	{ id: "quests", 	icon: "📋" },
	{ id: "events", 	icon: "🎟️" },
	{ id: "shop", 		icon: "🏪" },
]

const ICON = {
	MERITS: "guild/merits.png",
	GP: "guild/currency/gp.png",
	CRYSTAL: "guild/currency/crystal.png",
	CRYSTALS: "guild/currency/crystal.png",
	SHIELD: "guild/currency/shield.png",
	EXP: "guild/currency/exp.png",
	GOLD_ARROW: "guild/gold_arrow.png",
}

const CHECK_SYMBOL = {
	YES: "✔️",
	NO: "❌",
}

const QUEST_CATEGORY_ICON = {
	daily: "📅",
	weekly: "📆",
	guild: "🏛️",
}

const SPEEDRUN_PLACE_ICON = {
	[1]: "🥇",
	[2]: "🥈",
	[3]: "🥉",
}

const GUILDS_LIST_PLACE_ICON = {
	[1]: "🥇",
	[2]: "🥈",
	[3]: "🥉",
}

const SYSTEM_STEAM_ID = "76561198353453074"

/**
 * @readonly
 */
const SettingsFlags = {
	DisableJoinRequests: 1 << 0,
	AutoAcceptJoinRequests: 1 << 1,
	ShowLeaderInGuildsList: 1 << 2,
}

/**
 * @readonly
 */
const DeputyPermissionsFlags = {
	ManageJoinRequests: 1 << 0,
	KickMembers: 1 << 1,
	ChangeMembersRole: 1 << 2,
	DeleteMessages: 1 << 3,
	UpgradeTalentsForGP: 1 << 4,
	UpgradeTalentsForCrystals: 1 << 5,
	BuyServicesForGP: 1 << 6,
	BuyServicesForCrystals: 1 << 7,
	BuyEventTicketsForGP: 1 << 8,
	BuyEventTicketsForCrystals: 1 << 9,
}

const RoleSettingsFlags = {
	IsDefault: 1 << 0,
	IsDeputy: 1 << 1,
	IsLeader: 1 << 2,
}