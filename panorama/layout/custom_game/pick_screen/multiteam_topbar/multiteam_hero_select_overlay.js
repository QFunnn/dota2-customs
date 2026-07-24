--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


"use strict";
let PLAYER_STATS = {};

function OnUpdateHeroSelection() {
	for (let team_id of Game.GetAllTeamIDs()) {
		UpdateTeam(team_id);
	}
}

function UpdateTeam(team_id) {
	const team_panel_id = "team_" + team_id;
	const team_panel = $("#" + team_panel_id);
	const team_players = Game.GetPlayerIDsOnTeam(team_id);
	team_panel.SetHasClass("no_players", team_players.length == 0);
	for (let player_id of team_players) {
		UpdatePlayer(team_panel, player_id, team_id);
	}
}

function UpdatePlayer(team_panel, player_id, team_id) {
	const is_large_game = Game.GetAllPlayerIDs().length > 16;
	const player_container = team_panel.FindChildInLayoutFile("PlayersContainer");
	const player_panel_id = "player_" + player_id;

	let player_panel = player_container.FindChild(player_panel_id);
	if (!player_panel) {
		player_panel = $.CreatePanel("Image", player_container, player_panel_id);
		player_panel.BLoadLayout(
			"file://{resources}/layout/custom_game/pick_screen/multiteam_topbar/multiteam_hero_select_overlay_player.xml",
			false,
			false,
		);
		player_panel.AddClass("PlayerPanel");
	}

	if (is_large_game) {
		player_panel.style.width = "76px;";
		player_panel.style.margin = "0px -4px 0px -4px;";
		// playerPanel.style.backgroundSize = "90px 100%;"
	}

	const player_info = Game.GetPlayerInfo(player_id);
	if (!player_info) return;

	const local_player_info = Game.GetLocalPlayerInfo();
	if (!local_player_info) return;

	const local_player_team_id = local_player_info.player_team_id;
	const player_portrait = player_panel.FindChildInLayoutFile("PlayerPortrait");
	const portrait_overlay = player_portrait.FindChild("PlayerPortraitOverlay");
	player_panel.SetHasClass("is_local_player", player_id == Game.GetLocalPlayerID());
	portrait_overlay.style.borderBottom = `5px solid ${GameUI.GetTeamColor(team_id)}`;

	if (player_id == local_player_info.player_id) {
		player_panel.AddClass("is_local_player");
	}

	if (player_info.player_selected_hero !== "") {
		player_portrait.SetImage(GetPortraitImage(player_id, player_info.player_selected_hero));
		player_panel.SetHasClass("hero_selected", true);
		player_panel.SetHasClass("hero_highlighted", false);
	} else if (player_info.possible_hero_selection !== "" && player_info.player_team_id == local_player_team_id) {
		player_portrait.SetImage(
			"file://{images}/heroes/npc_dota_hero_" + player_info.possible_hero_selection + ".png",
		);
		player_panel.SetHasClass("hero_selected", false);
		player_panel.SetHasClass("hero_highlighted", true);
	} else {
		player_portrait.SetImage("file://{images}/custom_game/unassigned.png");
	}

	const player_name_label = player_panel.FindChildInLayoutFile("PlayerName");
	player_name_label.text = player_info.player_name;
	HighlightByParty(player_id, player_name_label);

	const stats = PLAYER_STATS[player_id];
	const has_stats = stats != null;

	player_panel.SetHasClass("has_stats", has_stats);

	// hide own streaks to other heroes - but you
	// worth noting that streaks are stored in nettable, so if someone would REALLY want to know - they could
	// we could switch to event-based storage to prevent that but it's a bit annoying in many ways
	const hide_streak = stats && stats.streak_hidden && player_id != Game.GetLocalPlayerID();

	player_panel.SetDialogVariableInt("streak_current", stats && !hide_streak ? stats.streak_current : 0);
	player_panel.SetDialogVariableInt("streak_max", stats && !hide_streak ? stats.streak_max : 0);
}

function UpdateTimer() {
	const game_time = Game.GetGameTime();
	const state_transition_time = Game.GetStateTransitionTime();

	let timer_value = Math.max(0, Math.floor(state_transition_time - game_time));

	if (Game.GameStateIsAfter(DOTA_GameState.DOTA_GAMERULES_STATE_HERO_SELECTION)) timer_value = 0;

	$("#TimerPanel").SetDialogVariableInt("timer_seconds", timer_value);

	const is_in_ban_phase = Game.IsInBanPhase();
	$("#TimerLabel").text = $.Localize(is_in_ban_phase ? "#DOTA_LoadingBanPhase" : "#DOTA_LoadingPickPhase");

	if (Game.GameStateIsAfter(DOTA_GameState.DOTA_GAMERULES_STATE_STRATEGY_TIME)) return;

	$.Schedule(0.1, UpdateTimer);
}

function OverrideBackground() {
	const pregame_bg = FindDotaHudElement("PregameBG");
	if (!pregame_bg) return;
	pregame_bg.ClearScene(true);
	pregame_bg.style.width = "100%";
	pregame_bg.style.height = "100%";
	pregame_bg.style.align = "center center";
	pregame_bg.style.opacity = "1.0";
	pregame_bg.style.preTransformScale2d = "1.0";

	const otBG = $.CreatePanel(`DOTAScenePanel`, pregame_bg, "OT3BG", {
		camera: `hero_camera_post`,
		particleonly: `false`,
		map: `backgrounds/hero_showcase_primal_beast`,
		hittest: `false`,
	});
	otBG.style.width = "100%";
	otBG.style.height = "100%";

	const overlay = $.CreatePanel("Panel", otBG, "");
	overlay.style.width = "100%";
	overlay.style.height = "100%";
	overlay.style.backgroundColor =
		"gradient( linear, 0% 0%, 0% 100%, from( rgba(0, 0, 0, 0.82) ), to( rgba(0, 0, 0, 0.95) ) )";
}

function OverrideStrategyMap() {
	const friends_and_foes = FindDotaHudElement("StrategyFriendsAndFoes");
	if (friends_and_foes) {
		friends_and_foes.style.width = "fill-parent-flow(1.0)";
	}

	const strategy_map = FindDotaHudElement("StrategyMap");
	if (strategy_map) {
		strategy_map.style.width = "fit-children";
	}

	const strategy_controls = FindDotaHudElement("StrategyMapControls");
	if (strategy_controls) {
		strategy_controls.visible = false;
	}

	const strategy_minimap = FindDotaHudElement("StrategyMinimap");
	if (strategy_minimap) {
		strategy_minimap.visible = false;
		const map = $.CreatePanel("Image", strategy_minimap.GetParent(), "OT3Map");
		map.style.width = "276px";
		map.style.height = "276px";
		strategy_minimap.GetParent().MoveChildBefore(map, strategy_minimap);
		map.SetImage(`file://{images}/custom_game/maps/${Game.GetMapInfo().map_display_name}.png`);
	}
}

function UpdatePreGameTimerPosition() {
	const pre_game_timer = FindDotaHudElement("HeaderCenter");
	if (Game.GameStateIsAfter(DOTA_GameState.DOTA_GAMERULES_STATE_STRATEGY_TIME)) {
		pre_game_timer.visible = false;
		return;
	}
	const pre_game_timer_parent = pre_game_timer.GetParent();
	const is_strategy_time = Game.GameStateIs(DOTA_GameState.DOTA_GAMERULES_STATE_STRATEGY_TIME);

	if (is_strategy_time) $("#TimerPanel").visible = false;

	if (is_strategy_time && pre_game_timer_parent && pre_game_timer_parent.id == "Header") {
		pre_game_timer.SetParent(pre_game_timer_parent.GetParent());
		pre_game_timer.style.align = "center bottom";
		pre_game_timer.style.margin = "0 0 26px 26px";
		pre_game_timer.style.position = "0px 0px 0px";
	}
	$.Schedule(0, UpdatePreGameTimerPosition);
}

function OverrideBottomHUD() {
	const friends_and_foes = FindDotaHudElement("FriendsAndFoes");
	if (friends_and_foes) {
		friends_and_foes.style.visibility = "collapse";
	}
}

function CreateTeams() {
	let local_player_team_id = -1;
	if (Game.GetLocalPlayerInfo() && Game.GetLocalPlayerInfo().player_team_id)
		local_player_team_id = Game.GetLocalPlayerInfo().player_team_id;
	let teams_container = $("#HeroSelectTeamsContainer");

	//	var teams = 0;
	//	var teamsTotal = Game.GetAllTeamIDs().length;
	for (let team_id of Game.GetAllTeamIDs()) {
		//		teams += 1;
		const container_root = teams_container.GetChild(0);
		// var containerRoot = teamsContainer.GetChild(!largeGame || teams <= Math.ceil(teamsTotal / 2) ? 0 : 1);
		const team_panel_id = "team_" + team_id;
		const team_panel = $.CreatePanel("Panel", container_root, team_panel_id);
		container_root.MoveChildBefore(team_panel, container_root.GetChild(container_root.GetChildCount() - 2));
		team_panel.BLoadLayout(
			"file://{resources}/layout/custom_game/pick_screen/multiteam_topbar/multiteam_hero_select_overlay_team.xml",
			false,
			false,
		);

		const team_name = team_panel.FindChildInLayoutFile("TeamName");
		if (team_name) {
			team_name.text = $.Localize("#" + Game.GetTeamDetails(team_id).team_name);
		}

		const logo_xml = GameUI.CustomUIConfig().team_logo_xml;
		if (logo_xml) {
			const team_logo_panel = team_panel.FindChildInLayoutFile("TeamLogo");
			team_logo_panel.SetAttributeInt("team_id", team_id);
			team_logo_panel.BLoadLayout(logo_xml, false, false);
		}

		if (team_name) {
			team_name.text = $.Localize("#" + Game.GetTeamDetails(team_id).team_name);
		}

		team_panel.AddClass("TeamPanel");
		team_panel.AddClass(team_id === local_player_team_id ? "local_player_team" : "not_local_player_team");
	}
}

(function () {
	if ($.GetContextPanel().GetParent().id == "CustomUIContainer_HeroSelection") {
		OverrideBackground();
		OverrideStrategyMap();
		OverrideBottomHUD();
		UpdateTimer();
	}
	CreateTeams();

	const pre_map_container = FindDotaHudElement("PreMinimapContainer");
	pre_map_container.visible = false;

	SubscribeToNetTableKey("game_state", "player_stats", function (value) {
		PLAYER_STATS = value;
		OnUpdateHeroSelection();
	});

	GameEvents.Subscribe("dota_player_hero_selection_dirty", OnUpdateHeroSelection);
	GameEvents.Subscribe("dota_player_update_hero_selection", OnUpdateHeroSelection);

	UpdatePreGameTimerPosition();
})();