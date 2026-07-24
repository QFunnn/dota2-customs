--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


const HUD = {
	CONTEXT: $.GetContextPanel(),
	TEAMS_ROOT: $("#TS_TeamsRoot"),
	UNASSIGNED_ROOT: $("#UnassignedPlayersContainer"),
	WEBM_ROOT: $("#TS_Tips_WebContainer"),
	HINT_MOVIE: $("#TS_VideoHint"),
	BULLETS_ROOT: $("#TS_Tips_Bullets"),
};
const multiline_selection_teams_per_line = {
	ot3_necropolis_ffa: 4,
	ot3_demo: 4,
};

function GetPlayerPanel(player_id) {
	if (!players_panels[player_id]) {
		const player_panel = $.CreatePanel("Panel", HUD.UNASSIGNED_ROOT, `TS_Player_${player_id}`);
		player_panel.BLoadLayoutSnippet("TS_Player");
		players_panels[player_id] = player_panel;
		player_panel.SetHasClass("BLocalPlayer", player_id == LOCAL_PLAYER_ID);

		const player_info = Game.GetPlayerInfo(player_id);
		if (player_info) {
			const player_info_root = player_panel.FindChild("TS_PlayerInfo");
			player_info_root.GetChild(0).steamid = player_info.player_steamid;
			player_info_root.GetChild(1).steamid = player_info.player_steamid;
		}
	}
	return players_panels[player_id];
}
function CreateEmptySlot(root, team_id) {
	const empty_slot = $.CreatePanel("Button", root, ``);
	empty_slot.BLoadLayoutSnippet("TS_Player");
	empty_slot.AddClass("Empty");
}

function OnLeaveTeamPressed() {
	Game.PlayerJoinTeam(DOTATeam_t.DOTA_TEAM_NOTEAM);
}
function UpdateTeamPanel(team_panel) {
	const team_id = team_panel.GetAttributeInt("team_id", -1);
	const team_players = Game.GetPlayerIDsOnTeam(team_id);
	team_panel.player_list.RemoveAndDeleteChildren();
	team_players.forEach((player_id) => {
		GetPlayerPanel(player_id).SetParent(team_panel.player_list);
	});
	const team_info = Game.GetTeamDetails(team_id);
	const team_max_players = team_info.team_max_players;
	for (var empty_idx = team_players.length; empty_idx < team_max_players; ++empty_idx) {
		CreateEmptySlot(team_panel.player_list, team_id);
	}
	team_panel.SetHasClass("BTeamFull", team_players.length == team_max_players);
}
function OnTeamPlayerListChanged() {
	players_panels.forEach((player_panel) => {
		player_panel.SetParent(HUD.UNASSIGNED_ROOT);
	});
	const unassigned_players = Game.GetUnassignedPlayerIDs();
	unassigned_players.forEach((unassigned_player_id) => {
		GetPlayerPanel(unassigned_player_id);
	});
	team_panels.forEach((team_panel) => {
		UpdateTeamPanel(team_panel);
	});
}
function OnPlayerSelectedTeam(player_id, team_id, b_success) {
	if (player_id != LOCAL_PLAYER_ID) return;

	Game.EmitSound(`ui_team_select_pick_team${b_success ? "" : "_failed"}`);
}
let team_panels = [];
let players_panels = [];
function CreateTeams() {
	var all_teams_ids = Game.GetAllTeamIDs();
	var spectator = CustomNetTables.GetTableValue("game_options", "spectator_slots");
	if (spectator && spectator[1] && spectator[1] == 1) all_teams_ids.push(1);

	let teams_line = $.CreatePanel("Panel", HUD.TEAMS_ROOT, "");
	let multilines = multiline_selection_teams_per_line[MAP_NAME];
	all_teams_ids.forEach((team_id, idx) => {
		if (multilines && idx > 0 && idx % multilines == 0) {
			teams_line = $.CreatePanel("Panel", HUD.TEAMS_ROOT, "");
		}
		const team_root = $.CreatePanel("Panel", teams_line, `TS_Team_${team_id}`);
		team_root.BLoadLayoutSnippet("TS_Team");
		team_root.player_list = team_root.FindChildTraverse("TS_Team_Players_List");
		team_root.SetAttributeInt("team_id", team_id);
		team_root.SetDialogVariable("team_name", $.Localize(Game.GetTeamDetails(team_id).team_name).toUpperCase());
		team_panels.push(team_root);

		team_root.SetPanelEvent("onactivate", () => {
			Game.PlayerJoinTeam(team_id);
		});
		team_root.AddClass(`Team_${team_id}`);
		team_root.FindChildTraverse(
			"TS_Team_Header_Overlay",
		).style.backgroundColor = `gradient(radial, 50% 100%, 0% 0%, 40% 75%, from(${GameUI.GetTeamColor(team_id).slice(
			0,
			-1,
		)}), to(transparent));`;
	});
}
function AutoAssign() {
	if (!Game.IsDemoMode()) return;

	Game.AutoAssignPlayersToTeams();
}
function ShuffleTeams() {
	Game.ShufflePlayerTeamAssignments();
}
function LockAndStart() {
	if (Game.GetUnassignedPlayerIDs().length > 0) return;
	Game.SetTeamSelectionLocked(true);
	Game.SetRemainingSetupTime(4);
}
function UnlockTeams() {
	Game.SetTeamSelectionLocked(false);
	Game.SetRemainingSetupTime(-1);
	Game.SetAutoLaunchEnabled(false);
}

function CheckAutoAssign() {
	if (Game.GetTeamSelectionLocked()) AutoAssign();
}

function IsShowLobbyTools() {
	let players_in_lobby = 0;
	for (let player_id = 0; player_id < DOTALimits_t.DOTA_MAX_TEAM_PLAYERS; player_id++) {
		const player_info = Game.GetPlayerInfo(player_id);
		if (!player_info) continue;
		players_in_lobby++;
	}

	let max_player_in_map = 0;
	for (let h = DOTATeam_t.DOTA_TEAM_FIRST; h < DOTATeam_t.DOTA_TEAM_CUSTOM_MAX; h++) {
		max_player_in_map += Game.GetTeamDetails(h).team_max_players;
	}

	return players_in_lobby < max_player_in_map || Game.IsInToolsMode();
}

function CheckPrivileges() {
	var player_info = Game.GetLocalPlayerInfo();
	if (!player_info) return;
	HUD.CONTEXT.SetHasClass("BShowUnassigned", IsShowLobbyTools());
	HUD.CONTEXT.SetHasClass("BShowHostElements", player_info.player_has_host_privileges);
	HUD.CONTEXT.SetHasClass("BShowUnlock", player_info.player_has_host_privileges && IsShowLobbyTools());
}
function UpdateSchedule() {
	HUD.CONTEXT.SetHasClass("BTeamsLocked", Game.GetTeamSelectionLocked());

	if (Game.GameStateIsAfter(DOTA_GameState.DOTA_GAMERULES_STATE_CUSTOM_GAME_SETUP)) return;
	$.Schedule(0.1, UpdateSchedule);
}
(() => {
	HUD.CONTEXT.GetParent().style.margin = "0px";
	HUD.CONTEXT.AddClass(MAP_NAME);

	HUD.TEAMS_ROOT.RemoveAndDeleteChildren();
	HUD.UNASSIGNED_ROOT.RemoveAndDeleteChildren();

	CreateTeams();
	OnTeamPlayerListChanged();
	CheckAutoAssign();
	CheckPrivileges();
	UpdateSchedule();

	$.RegisterForUnhandledEvent("DOTAGame_TeamPlayerListChanged", OnTeamPlayerListChanged);
	$.RegisterForUnhandledEvent("DOTAGame_PlayerSelectedCustomTeam", OnPlayerSelectedTeam);
})();