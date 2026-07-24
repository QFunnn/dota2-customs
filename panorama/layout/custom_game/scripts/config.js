--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


let PICK_SCREEN_HIDDEN = false;

GameUI.CustomUIConfig().team_icons = {
	[DOTATeam_t.DOTA_TEAM_GOODGUYS]: "file://{images}/custom_game/team_icons/team_icon_tiger_01.png",
	[DOTATeam_t.DOTA_TEAM_BADGUYS]: "file://{images}/custom_game/team_icons/team_icon_monkey_01.png",
	[DOTATeam_t.DOTA_TEAM_CUSTOM_1]: "file://{images}/custom_game/team_icons/team_icon_dragon_01.png",
	[DOTATeam_t.DOTA_TEAM_CUSTOM_2]: "file://{images}/custom_game/team_icons/team_icon_dog_01.png",
	[DOTATeam_t.DOTA_TEAM_CUSTOM_3]: "file://{images}/custom_game/team_icons/team_icon_rooster_01.png",
	[DOTATeam_t.DOTA_TEAM_CUSTOM_4]: "file://{images}/custom_game/team_icons/team_icon_ram_01.png",
	[DOTATeam_t.DOTA_TEAM_CUSTOM_5]: "file://{images}/custom_game/team_icons/team_icon_rat_01.png",
	[DOTATeam_t.DOTA_TEAM_CUSTOM_6]: "file://{images}/custom_game/team_icons/team_icon_boar_01.png",
	[DOTATeam_t.DOTA_TEAM_CUSTOM_7]: "file://{images}/custom_game/team_icons/team_icon_snake_01.png",
	[DOTATeam_t.DOTA_TEAM_CUSTOM_8]: "file://{images}/custom_game/team_icons/team_icon_horse_01.png",
};

GameUI.CustomUIConfig().team_colors = {
	[1]: "#E0610E;", // Spectator team
	[DOTATeam_t.DOTA_TEAM_GOODGUYS]: "#3dd296;", // { 61, 210, 150 }	--		Teal
	[DOTATeam_t.DOTA_TEAM_BADGUYS]: "#F3C909;", // { 243, 201, 9 }		--		Yellow
	[DOTATeam_t.DOTA_TEAM_CUSTOM_1]: "#c54da8;", // { 197, 77, 168 }	--		Pink
	[DOTATeam_t.DOTA_TEAM_CUSTOM_2]: "#FF6C00;", // { 255, 108, 0 }		--		Orange
	[DOTATeam_t.DOTA_TEAM_CUSTOM_3]: "#3455FF;", // { 52, 85, 255 }		--		Blue
	[DOTATeam_t.DOTA_TEAM_CUSTOM_4]: "#65d413;", // { 101, 212, 19 }	--		Green
	[DOTATeam_t.DOTA_TEAM_CUSTOM_5]: "#815336;", // { 129, 83, 54 }		--		Brown
	[DOTATeam_t.DOTA_TEAM_CUSTOM_6]: "#1bc0d8;", // { 27, 192, 216 }	--		Cyan
	[DOTATeam_t.DOTA_TEAM_CUSTOM_7]: "#c7e40d;", // { 199, 228, 13 }	--		Olive
	[DOTATeam_t.DOTA_TEAM_CUSTOM_8]: "#8c2af4;", // { 140, 42, 244 }	--		Purple
};

GameUI.CustomUIConfig().team_colors_rgb = {
	[DOTATeam_t.DOTA_TEAM_GOODGUYS]: [61, 210, 150], // Teal
	[DOTATeam_t.DOTA_TEAM_BADGUYS]: [243, 201, 9], // Yellow
	[DOTATeam_t.DOTA_TEAM_CUSTOM_1]: [197, 77, 168], // Pink
	[DOTATeam_t.DOTA_TEAM_CUSTOM_2]: [255, 108, 0], // Orange
	[DOTATeam_t.DOTA_TEAM_CUSTOM_3]: [52, 85, 255], // Blue
	[DOTATeam_t.DOTA_TEAM_CUSTOM_4]: [101, 212, 19], // Green
	[DOTATeam_t.DOTA_TEAM_CUSTOM_5]: [129, 83, 54], // Brown
	[DOTATeam_t.DOTA_TEAM_CUSTOM_6]: [27, 192, 216], // Cyan
	[DOTATeam_t.DOTA_TEAM_CUSTOM_7]: [199, 228, 13], // Olive
	[DOTATeam_t.DOTA_TEAM_CUSTOM_8]: [140, 42, 244], // Purple
};

GameUI.GetTeamColor = (team_id) => {
	return GameUI.CustomUIConfig().team_colors[team_id] || "#ffffff";
};

GameUI.GetTeamIcon = (team_id, b_high_reso) => {
	let team_image = GameUI.CustomUIConfig().team_icons[team_id];
	if (team_image && b_high_reso) team_image = team_image.replace("/team_icons/", "/team_icons_hr/");

	return team_image || "";
};

function HidePickScreen() {
	var pregame_root = $.GetContextPanel().GetParent().GetParent().FindChildTraverse("PreGame");

	if (!Game.GameStateIsAfter(2)) {
		if (PICK_SCREEN_HIDDEN == false) {
			PICK_SCREEN_HIDDEN = true;
			pregame_root.style.opacity = "0";
		}

		$.Schedule(0.1, HidePickScreen);
	} else {
		pregame_root.style.opacity = "1";
		delete PICK_SCREEN_HIDDEN;
	}
}

(() => {
	$.Msg("Config JS executing");
	// Hero selection Radiant and Dire player lists.
	GameUI.SetDefaultUIEnabled(DotaDefaultUIElement_t.DOTA_DEFAULT_UI_HERO_SELECTION_TEAMS, false);
	// Hero selection game mode name display.
	GameUI.SetDefaultUIEnabled(DotaDefaultUIElement_t.DOTA_DEFAULT_UI_HERO_SELECTION_GAME_NAME, true);
	// Hero selection clock.
	GameUI.SetDefaultUIEnabled(DotaDefaultUIElement_t.DOTA_DEFAULT_UI_HERO_SELECTION_CLOCK, true);

	// Hide Pick Screen while players are loading
	HidePickScreen();

	const spectator = CustomNetTables.GetTableValue("game_options", "spectator_slots");
	if (spectator && spectator[1] && spectator[1] == 1) {
		// Spectator slots
		GameUI.CustomUIConfig().team_select = {
			bShowSpectatorTeam: true,
		};
	}
})();