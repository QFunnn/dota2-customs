--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


const team_root_name = (team_id) => {
	return `TopBar_Team_${team_id}`;
};
const player_root_name = (player_id) => {
	return `TopBar_Player_${player_id}`;
};
const HUD = {
	CONTEXT: $.GetContextPanel(),
	TEAMS_ROOT: $("#TopBar_TeamsList"),
	GOAL_ADDITIOANL_FLAG: $("#SecondFlag"),
	UNDER_PANEL: $("#ScoreGoal"),
};

let interval_funcs = {};
HUD.TEAMS_ROOT.SetHasClass("hideTop", false);
HUD.UNDER_PANEL.SetHasClass("hideTop", false);

function TopBarUpdater() {
	Object.values(interval_funcs).forEach((func) => {
		func();
	});

	$.Schedule(0.5, TopBarUpdater);
}
function UpdateTeamScore(team_id) {
	if (!$("#TopBar_Team_" + team_id)) return;

	const root = $("#TopBar_Team_" + team_id);
	const team_score = Game.GetTeamScore(team_id);
	const goal_diff = current_goal - team_score;

	root.FindChildTraverse("TeamScore").SetDialogVariable("team_score", team_score);
	root.FindChildTraverse("KillsToWin").SetDialogVariableInt("points_to_win", goal_diff || 0);

	root.score = team_score;
	root.team_id = team_id;

	root.SetHasClass("NearToWin", goal_diff <= 5);
}
function ShowTimeLimit() {
	if (Game.GetMapInfo().map_display_name != "ot3_demo") {
		PLAYER_MOUSE_OVER_GAME_TIME = true;
	}

	UpdateGameTime();
}
function HideTimeLimit() {
	if (Game.GetMapInfo().map_display_name != "ot3_demo") {
		PLAYER_MOUSE_OVER_GAME_TIME = false;
	}

	UpdateGameTime();
}
function CreateTopTeamBar(team_id) {
	if (
		team_id < DOTATeam_t.DOTA_TEAM_FIRST ||
		team_id >= DOTATeam_t.DOTA_TEAM_CUSTOM_MAX ||
		team_id == DOTATeam_t.DOTA_TEAM_NOTEAM ||
		team_id == DOTATeam_t.DOTA_TEAM_NEUTRALS
	)
		return;

	const team_root = $.CreatePanel("Panel", HUD.TEAMS_ROOT, team_root_name(team_id));
	team_root.BLoadLayoutSnippet("TopBar_Team");
	team_root.SetHasClass("LocalTeam", team_id == Players.GetTeam(LOCAL_PLAYER_ID));

	team_root.FindChildTraverse("TeamLogo_Icon").SetImage(GameUI.GetTeamIcon(team_id));
	team_root.FindChildTraverse("TeamLogo_Color").style.washColor = GameUI.GetTeamColor(team_id);
	team_root.FindChildTraverse("TeamColor").style.backgroundColor = GameUI.GetTeamColor(team_id);

	team_root.players_root = team_root.FindChildTraverse("PlayersList");

	interval_funcs[`UpdateTeamInfo_${team_id}`] = () => {
		UpdateTeamScore(team_id);

		((players_root) => {
			let b_any_player_died = false;
			players_root.Children().forEach((p) => {
				if (p.BHasClass("HeroDied")) b_any_player_died = true;
			});
			team_root.SetHasClass("BTeamHasDiedHero", b_any_player_died);
		})(team_root.players_root);
	};

	return team_root;
}

function SetPortraitForPlayer(image, player_id) {
	const player_info = Game.GetPlayerInfo(player_id);
	image.SetImage(
		player_info.player_selected_hero !== ""
			? GetPortraitImage(player_id, player_info.player_selected_hero)
			: "file://{images}/custom_game/unassigned.png",
	);
}
function UpdateDisconnectStateForPlayer(root, player_id) {
	const player_info = Game.GetPlayerInfo(player_id);
	const connection_state = player_info.player_connection_state;
	root.SetHasClass("Disconnected", connection_state == DOTAConnectionState_t.DOTA_CONNECTION_STATE_DISCONNECTED);
	root.SetHasClass("Abandoneded", connection_state == DOTAConnectionState_t.DOTA_CONNECTION_STATE_ABANDONED);
}
function UpdatePlayerAliveState(root, player_id) {
	const player_info = Game.GetPlayerInfo(player_id);
	if (player_info.player_respawn_seconds != undefined) {
		const time = player_info.player_respawn_seconds + 1;
		const b_died = time > 0;
		root.SetDialogVariable("respawn_time", time);
		root.SetHasClass("HeroDied", b_died);
	}
}
function CreatePanelForPlayer(player_id) {
	const player_info = Game.GetPlayerInfo(player_id);
	if (!player_info) {
		if (!interval_funcs[`CreatePanelForPlayer_${player_id}`])
			interval_funcs[`CreatePanelForPlayer_${player_id}`] = CreatePanelForPlayer.bind(undefined, player_id);
		return;
	}
	delete interval_funcs[`CreatePanelForPlayer_${player_id}`];

	let player_root = $(`#${player_root_name(player_id)}`);
	if (player_root) return;

	const team_id = Players.GetTeam(player_id);
	const team_root = $(`#${team_root_name(team_id)}`) || CreateTopTeamBar(team_id);
	if (!team_root) return;

	player_root = $.CreatePanel("Panel", team_root.players_root, player_root_name(player_id));
	player_root.BLoadLayoutSnippet("TopBar_Player");
	player_root.SetHasClass("LocalPlayer", player_id == LOCAL_PLAYER_ID);

	player_root.SetPanelEvent("onactivate", () => {
		Players.PlayerPortraitClicked(player_id, GameUI.IsControlDown(), GameUI.IsAltDown());
	});

	player_root.SetPanelEvent("ondblclick", function () {
		Players.PlayerPortraitDoubleClicked(player_id, GameUI.IsControlDown(), GameUI.IsAltDown());
	});

	interval_funcs[`UpdateDynamicInfoForPlayer_${player_id}`] = () => {
		SetPortraitForPlayer(player_root.FindChildTraverse("HeroImage"), player_id);
		UpdateDisconnectStateForPlayer(player_root, player_id);
		UpdatePlayerAliveState(player_root, player_id);
	};

	if (player_id != LOCAL_PLAYER_ID) {
		player_root.FindChildTraverse("TopBar_Tip").SetPanelEvent("onactivate", () => {
			if (dotaHud.BHasClass("TipsBlock")) return;
			GameEvents.SendToServerEnsured("Tips:tip", { target_player_id: player_id });
		});
	}

	SortTeams();
}

let alert_game_near_to_end = 120; //seconds
function UpdateGameTime() {
	let game_time = Game.GetDOTATime(false, false);

	if (Game.GetMapInfo().map_display_name == "ot3_demo") {
		HUD.CONTEXT.SetDialogVariable("game_time", FormatSeconds(game_time));
		return;
	}

	if (Game.GameStateIs(DOTA_GameState.DOTA_GAMERULES_STATE_PRE_GAME)) {
		const time = Math.max(Game.GetStateTransitionTime() - Game.GetGameTime(), 0);
		HUD.CONTEXT.SetDialogVariable("game_time", FormatSeconds(time));
		return;
	}

	const time_to_end = current_time_limit - game_time;

	if (GameUI.Player.GetSettingValue("ui_show_game_time")) {
		HUD.CONTEXT.SetDialogVariable(
			"game_time",
			FormatSeconds(PLAYER_MOUSE_OVER_GAME_TIME ? time_to_end : game_time),
		);
	} else {
		HUD.CONTEXT.SetDialogVariable(
			"game_time",
			FormatSeconds(PLAYER_MOUSE_OVER_GAME_TIME ? game_time : time_to_end),
		);
	}

	if (time_to_end <= 0) return;
	if (time_to_end <= alert_game_near_to_end) {
		GameUI.OT3_Alert("game_end_2mins");
		alert_game_near_to_end = -1;
	} else if (time_to_end <= 10) {
		GameUI.OT3_Alert("countdown", {
			time_to_end: FormatSeconds(time_to_end),
		});
	}
}

function CheckLeaderTeam() {
	let leader;
	let b_same_score;
	HUD.TEAMS_ROOT.Children().forEach((team_root) => {
		team_root.RemoveClass("BLeader");
		if (!leader || leader.score < team_root.score) {
			b_same_score = false;
			leader = team_root;
		} else if (leader.score == team_root.score) b_same_score = true;
	});
	if (!b_same_score && leader) leader.AddClass("BLeader");
}

function SortTeams() {
	const center_teams_ui = Math.floor(HUD.TEAMS_ROOT.Children().length / 2);

	HUD.TEAMS_ROOT.Children().forEach((panel, idx) => {
		panel.RemoveClass("CentralForSpectator");
		if (panel.BHasClass("LocalTeam")) {
			const focus_idx = MAP_NAME == "ot3_necropolis_ffa" ? 0 : center_teams_ui + 1;
			const focus_panel = HUD.TEAMS_ROOT.GetChild(focus_idx - (idx == focus_idx));
			if (focus_panel) HUD.TEAMS_ROOT.MoveChildBefore(panel, focus_panel);

			HUD.UNDER_PANEL.SetParent(panel);
		} else if (!IsSpectating()) {
			panel.FindChildTraverse("common_progress").RemoveAndDeleteChildren();
			panel.FindChildTraverse("rare_progress").RemoveAndDeleteChildren();
		}
	});
	if (IsSpectating()) {
		const middle_idx = Math.floor(HUD.TEAMS_ROOT.Children().length / 2);
		const middle_panel = HUD.TEAMS_ROOT.GetChild(middle_idx);
		if (middle_panel) {
			middle_panel.AddClass("CentralForSpectator");
			HUD.UNDER_PANEL.SetParent(middle_panel);
		}
	}
}

function InitPlayers() {
	for (let player_id = 0; player_id <= 23; player_id++) {
		CreatePanelForPlayer(player_id);
	}

	if (Game.GetMapInfo().map_display_name == "ot3_demo") {
		let game_time = Game.GetDOTATime(false, false);
		HUD.CONTEXT.SetDialogVariable("game_time", FormatSeconds(game_time));
	}

	interval_funcs[`UpdateGameTime`] = () => {
		UpdateGameTime();
	};

	interval_funcs[`CheckLeaderTeam`] = () => {
		CheckLeaderTeam();
	};

	TopBarUpdater();
}

function TriggerClassBySchedule(shedule, class_name) {
	if (shedule) shedule = $.CancelScheduled(shedule);

	HUD.CONTEXT.AddClass(class_name);
	shedule = $.Schedule(0.15, () => {
		shedule = undefined;
		HUD.CONTEXT.RemoveClass(class_name);
	});
}

let current_goal = 0;
let current_time_limit = 0;
let PLAYER_MOUSE_OVER_GAME_TIME = false;
let schedule_kl_animation;
function UpdateScoregoal(data) {
	current_goal = data.goal || 0;
	current_time_limit = data.limit || 0;

	HUD.CONTEXT.SetDialogVariable("kill_goal", data.goal);

	TriggerClassBySchedule(schedule_kl_animation, "UpdateKL");

	if (IsSpectating()) UpdateSpectatorTeamsScore();
}

function CheckSpectatorUI() {
	const is_spectating = IsSpectating();
	HUD.CONTEXT.SetHasClass("Spectator", is_spectating);
	FindDotaHudElement("RoshanTimer").style.opacity = is_spectating ? 0 : 1;
	FindDotaHudElement("SpectatorGoldDisplay").style.opacity = is_spectating ? 0 : 1;
	FindDotaHudElement("MinimapContainer").style.opacity = is_spectating ? 0 : 1;
}
function UpdateSpectatorTeamsScore() {
	const teams = Game.GetAllTeamIDs();

	for (var i in teams) {
		const team = teams[i];
		UpdateTeamScore(team);
	}
}

function CheckAltPress() {
	HUD.CONTEXT.SetHasClass("BAltPressed", GameUI.IsAltDown());
	$.Schedule(0, CheckAltPress);
}

(function () {
	HUD.TEAMS_ROOT.RemoveAndDeleteChildren();
	HUD.CONTEXT.SwitchClass("map_name", MAP_NAME);

	CheckSpectatorUI();

	GameUI.SetDefaultUIEnabled(DotaDefaultUIElement_t.DOTA_DEFAULT_UI_TOP_HEROES, false);
	GameUI.SetDefaultUIEnabled(DotaDefaultUIElement_t.DOTA_DEFAULT_UI_TOP_TIMEOFDAY, false);

	InitPlayers();
	CheckAltPress();

	SubscribeToNetTableKey("game_options", "score_goal", UpdateScoregoal);
})();