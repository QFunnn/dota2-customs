--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


const NON_BREAKING_SPACE = "\u00A0";
const BASE_MESSAGE_INDENT = "<child id='CustomChatFiller'>\u00A0";
const CONTEXT = $.GetContextPanel();
const FILLER_LENGTH = 72;

const GUILD_TAG_COLORS = {
	[DOTATeam_t.DOTA_TEAM_GOODGUYS]: ["#3375FF", "#66FFBF", "#BF00BF", "#F3F00B", "#FF6B00"],
	[DOTATeam_t.DOTA_TEAM_BADGUYS]: ["#FE86C2", "#A1B447", "#65D9F7", "#008321", "#A46900"],
};
const DEFAULT_GUILD_TAG_COLOR = "#ffffff";

const rank_classes = ["BronzeTier", "SilverTier", "GoldTier", "PlatinumTier", "MasterTier", "GrandmasterTier"];

const C_CHAT_ENUM = {
	PLAYER_NAME: 0,
	PLAYER_COLOR: 1,
	HERO_NAME: 2,
};
const PLAYER_COLOR_MAPS = ["dota", "dota_tournament", "aa_map_5v5", "aa_map_3v3"];
const C_CHAT_ACTIONS = {
	[C_CHAT_ENUM.PLAYER_NAME]: (player_id) => {
		return Players.GetPlayerName(player_id);
	},
	[C_CHAT_ENUM.PLAYER_COLOR]: (player_id) => {
		if (PLAYER_COLOR_MAPS.includes(MAP_NAME)) return GetHEXPlayerColor(player_id);
		else return GameUI.GetTeamColor(Players.GetTeam(player_id));
	},
	[C_CHAT_ENUM.HERO_NAME]: (player_id) => {
		const hero_id = Players.GetPlayerHeroEntityIndex(player_id);
		if (!hero_id) return "";

		return $.Localize(Entities.GetUnitName(hero_id));
	},
};
const MAX_CHAT_SIZE = 15;