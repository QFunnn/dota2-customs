--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build b9dc48c · 2026-08-02 17:42:46 UTC
  ~ auto-generated — do not edit
]]


const HUD = {
	CONTEXT: $.GetContextPanel(),
	AU_BUTTONS_CONTAINER: $("#AvailableUpgrades_List"),
	AU_LIST_1: $("#AU_List_Line1"),
	AU_LIST_2: $("#AU_List_Line2"),
	UPGRADE_LIST: $("#Upgrades_List_Details"),
	UPGRADE_BUTTON: $("#Upgrades_Button"),
	FAVORITE_BUILDS_ROOT: $("#FavoriteBuilds"),
	BUILDS_LIST: $("#F_Builds_List"),
	BUILDS_LIST_TOGGLE_BUTTON: $("#ToggleFavoritesBuilds"),
};

const RARITIES_NAMES = {
	1: "common",
	2: "rare",
	4: "epic",
};

REQUEST_BUTTON_COOLDOWN = 1;