--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


const team_root_name = (team_id) => {
	return `Scoreboard_Team_${team_id}`;
};
const player_root_name = (player_id) => {
	return `Scoreboard_Player_${player_id}`;
};
const HUD = {
	CONTEXT: $.GetContextPanel(),
	TEAMS_ROOT: $("#Scoreboard_TeamsList"),
	MUTE_ALL_BUTTON: $("#MuteAllButton"),
};
let interval_funcs = {};
let CACHED_PLAYERS = {};

function UpdateMutedPlayers_Request() {
	let mute_data = { voice: {}, text: {} };

	for (let player_id of Object.keys(CACHED_PLAYERS)) {
		player_id = parseInt(player_id);
		if (player_id == LOCAL_PLAYER_ID) continue;
		mute_data.voice[player_id] = Game[`IsPlayerMutedVoice`](player_id);
		mute_data.text[player_id] = Game[`IsPlayerMutedText`](player_id);
	}

	GameEvents.SendToServerEnsured("GameMode:set_muted_players", { mute_data: mute_data });
}

function ScoreboardUpdater() {
	Object.values(interval_funcs).forEach((func) => {
		func();
	});
	$.Schedule(0.5, ScoreboardUpdater);
}

function SetPortraitForPlayer(image, player_id) {
	const player_info = Game.GetPlayerInfo(player_id);
	image.SetImage(
		player_info.player_selected_hero !== ""
			? GetPortraitImage(player_id, player_info.player_selected_hero)
			: "file://{images}/custom_game/unassigned.png",
	);
}
function UpdateTeamScore(root, team_id) {
	const team_info = Game.GetTeamDetails(team_id);
	root.SetDialogVariableInt("team_score", team_info.team_score || 0);

	let orbs_collected = CustomNetTables.GetTableValue("game_state", "orbs_collected");
	let orbs_count = Object.values(orbs_collected?.[team_id] || {}).reduce((a, b) => a + b, 0);

	for (let type = 1; type <= 5; type++)
		root.SetDialogVariableInt(`type_${type}`, orbs_collected?.[team_id]?.[type] || 0);

	root.SetDialogVariableInt("orbs_count", orbs_count || 0);
}
function CreateScoreboardTeamPanel(team_id) {
	if (
		team_id < DOTATeam_t.DOTA_TEAM_FIRST ||
		team_id >= DOTATeam_t.DOTA_TEAM_CUSTOM_MAX ||
		team_id == DOTATeam_t.DOTA_TEAM_NOTEAM ||
		team_id == DOTATeam_t.DOTA_TEAM_NEUTRALS
	)
		return;

	const team_root = $.CreatePanel("Panel", HUD.TEAMS_ROOT, team_root_name(team_id));
	team_root.BLoadLayoutSnippet("Scoreboard_Team");
	team_root.SetHasClass("LocalTeam", team_id == Players.GetTeam(LOCAL_PLAYER_ID));

	team_root.FindChildTraverse("TeamLogo_Icon").SetImage(GameUI.GetTeamIcon(team_id));
	team_root.FindChildTraverse("TeamLogo_Color").style.washColor = GameUI.GetTeamColor(team_id);
	team_root.FindChildTraverse("TeamColor").style.backgroundColor = GameUI.GetTeamColor(team_id);

	team_root.FindChildTraverse(
		"TeamStats",
	).style.backgroundColor = `gradient(linear, 100% 0%, 0% 0%, from(${GameUI.GetTeamColor(team_id).slice(
		0,
		-1,
	)}40), color-stop(0.8, transparent), to(transparent))`;

	team_root.players_root = team_root.FindChildTraverse("PlayersList");
	team_root.players_count = 0;

	interval_funcs[`UpdateTeamInfo_${team_id}`] = () => {
		UpdateTeamScore(team_root, team_id);
	};

	return team_root;
}

function UpdatePlayerStats(root, player_id) {
	const player_info = Game.GetPlayerInfo(player_id);
	if (!player_info) return;
	root.SetDialogVariable("player_name", player_info.player_name);
	root.SetDialogVariable("hero_name", $.Localize(`#${player_info.player_selected_hero}`));
	root.SetDialogVariableInt("hero_level", player_info.player_level);
	root.SetDialogVariableInt("kills", player_info.player_kills);
	root.SetDialogVariableInt("deaths", player_info.player_deaths);
	root.SetDialogVariableInt("assists", player_info.player_assists);
	root.SetDialogVariable("player_gold", FormatBigNumber(player_info.player_gold));

	const game_stat = CustomNetTables.GetTableValue("game_state", "player_stats");
	const custom_player_info = game_stat ? game_stat[player_id] : {};
	root.SetDialogVariableInt("rank", custom_player_info ? custom_player_info.rating || 1500 : 1500);
}

function UpdateNeutralItemForPlayer(root, player_id) {
	const hero_ent_index = Players.GetPlayerHeroEntityIndex(player_id);
	if (!hero_ent_index) return;

	const neutral_item = Entities.GetItemInSlot(hero_ent_index, 16);
	if (!neutral_item) return;

	root.itemname = Abilities.GetAbilityName(neutral_item);
}
function UpdateDisconnectStateForPlayer(root, player_id) {
	const player_info = Game.GetPlayerInfo(player_id);
	const connection_state = player_info.player_connection_state;
	root.SetHasClass("Disconnected", connection_state == DOTAConnectionState_t.DOTA_CONNECTION_STATE_DISCONNECTED);
	root.SetHasClass("Abandoneded", connection_state == DOTAConnectionState_t.DOTA_CONNECTION_STATE_ABANDONED);
}

function UpdateUltimateState(root, player_id) {
	const ultimate_state = Game.GetPlayerUltimateStateOrTime(player_id);
	if (ultimate_state == undefined) return;
	root.SetHasClass("UltReady", ultimate_state == PlayerUltimateStateOrTime_t.PLAYER_ULTIMATE_STATE_READY);
	root.SetHasClass("UltNoMana", ultimate_state == PlayerUltimateStateOrTime_t.PLAYER_ULTIMATE_STATE_NO_MANA);
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
	const team_root = $(`#${team_root_name(team_id)}`) || CreateScoreboardTeamPanel(team_id);
	if (!team_root) return;

	team_root.players_count++;

	player_root = $.CreatePanel("Panel", team_root.players_root, player_root_name(player_id));
	player_root.BLoadLayoutSnippet("Scoreboard_Player");

	player_root.SetHasClass("LocalPlayer", player_id == LOCAL_PLAYER_ID);
	player_root.SetHasClass("BPlayerMuted_Voice", Game.IsPlayerMutedVoice(player_id));
	player_root.SetHasClass("BPlayerMuted_Text", Game.IsPlayerMutedText(player_id));

	CACHED_PLAYERS[player_id] = player_root;
	player_root.player_id = player_id;

	const mute = (type, force_state) => {
		let is_muted = !Game[`IsPlayerMuted${type}`](player_id);
		if (force_state != undefined) is_muted = force_state;

		Game[`SetPlayerMuted${type}`](player_id, is_muted);

		player_root.SetHasClass(`BPlayerMuted_${type}`, is_muted);
		player_root[`custom_mute_${type}`] = is_muted;

		UpdateMutedPlayers_Request();
	};

	player_root.mute = mute;

	player_root.FindChildTraverse("MuteButton_Voice").SetPanelEvent("onactivate", () => {
		mute("Voice");
	});
	player_root.FindChildTraverse("MuteButton_Text").SetPanelEvent("onactivate", () => {
		mute("Text");
	});

	if (IsSpectating()) {
		const upgrades_button = player_root.FindChildTraverse("UpgradesForSpectators");

		upgrades_button.SetPanelEvent("onactivate", () => {
			GameUI.SelectedUpgrades.ShowForPlayerAndButton(player_id, upgrades_button);
		});
	}

	player_root.FindChildTraverse("Kick").SetPanelEvent("onactivate", () => {
		if (HUD.CONTEXT.BHasClass("BKickVotingEnabled") && player_id != LOCAL_PLAYER_ID)
			GameEvents.SendToServerEnsured("voting_for_kick:kick_player", { target_id: player_id });
	});

	interval_funcs[`UpdateDynamicInfo_Scoreboard_Player_${player_id}`] = () => {
		SetPortraitForPlayer(player_root.FindChildTraverse("HeroImage"), player_id);
		UpdatePlayerStats(player_root, player_id);
		UpdateNeutralItemForPlayer(player_root.FindChildTraverse("NeutralItem"), player_id);
		UpdateDisconnectStateForPlayer(player_root, player_id);
	};

	if (team_id == Players.GetTeam(LOCAL_PLAYER_ID)) {
		interval_funcs[`UpdateDynamicInfoTeammate_Scoreboard_Player_${player_id}`] = () => {
			UpdateUltimateState(player_root, player_id);
		};
		const disable_help_button = player_root.FindChildTraverse("DisableHelpButton");
		disable_help_button.SetPanelEvent("onactivate", () => {
			GameEvents.SendToServerEnsured("set_disable_help", {
				disable: disable_help_button.checked,
				to: player_id,
			});
		});
	}
	if (player_id != LOCAL_PLAYER_ID) {
		player_root.FindChildTraverse("Tip").SetPanelEvent("onactivate", () => {
			if (dotaHud.BHasClass("TipsBlock")) return;
			GameEvents.SendToServerEnsured("Tips:tip", { target_player_id: player_id });
		});
	}

	HighlightByParty(player_id, player_root.FindChildTraverse("PlayerName"));
	SortTeams();

	const min_players_count = Math.min(...HUD.TEAMS_ROOT.Children().map((c) => c.players_count));
	HUD.CONTEXT.SwitchClass("players_count", `PlayersCount${min_players_count}`);
}

function SortTeams() {
	const center_teams_ui = Math.floor(HUD.TEAMS_ROOT.Children().length / 2);
	const local_team_panel = HUD.TEAMS_ROOT.FindChildrenWithClassTraverse("LocalTeam")[0];
	if (!local_team_panel) return;

	const local_team_idx = HUD.TEAMS_ROOT.GetChildIndex(local_team_panel);

	const focus_idx = MAP_NAME == "ot3_necropolis_ffa" ? 0 : center_teams_ui + 1;
	const focus_panel = HUD.TEAMS_ROOT.GetChild(focus_idx - (local_team_idx == focus_idx));

	if (focus_panel) HUD.TEAMS_ROOT.MoveChildBefore(local_team_panel, focus_panel);
}

function InitPlayers() {
	for (let player_id = 0; player_id <= 23; player_id++) CreatePanelForPlayer(player_id);

	ScoreboardUpdater();
}

function MuteAll() {
	let mute_data = {};
	for (const player_id of Game.GetAllPlayerIDs()) {
		const player_panel = $(`#${player_root_name(player_id)}`);
		if (!player_panel) continue;
		if (HUD.MUTE_ALL_BUTTON.checked) {
			player_panel.SetHasClass("PlayerMuted", true);
			Game.SetPlayerMuted(player_id, true);
		} else if (!player_panel.custom_mute) {
			player_panel.SetHasClass("PlayerMuted", false);
			Game.SetPlayerMuted(player_id, false);
		}
		mute_data[player_id] = Game.IsPlayerMuted(player_id);
	}
	GameEvents.SendToServerEnsured("update_mute_players", mute_data);
}

function SetScoreboardVisibleState(b_show) {
	HUD.CONTEXT.SetHasClass("Show", b_show);

	if (IsSpectating() && !HUD.CONTEXT.BHasClass("Show")) GameUI.SelectedUpgrades.CloseUpgrades(true);
}

GameUI.SetScoreboardVisibleState = SetScoreboardVisibleState;

const TIP_COOLDOWN = 30;
let last_tip_cooldown;
function UpdateTips(data) {
	dotaHud.SetHasClass("TipsBlock", data.used_this_game >= data.max_this_game || data.used_total >= data.max_total);

	if (data.cooldown > 0) {
		last_tip_cooldown = data.cooldown;
		const check_tip_cooldown = () => {
			dotaHud.SetHasClass("TipsBlock", Game.GetGameTime() < last_tip_cooldown + TIP_COOLDOWN);
			if (Game.GetGameTime() >= last_tip_cooldown + TIP_COOLDOWN) {
				return;
			}
			$.Schedule(0.5, check_tip_cooldown);
		};
		check_tip_cooldown();
	}
}
function EnableKickVoting() {
	HUD.CONTEXT.SetHasClass("BKickVotingEnabled", true);
}
function UpdateFirstMuteState() {
	const local_player_info = Game.GetPlayerInfo(LOCAL_PLAYER_ID);
	const selected_hero = local_player_info?.player_selected_hero_entity_index;
	if (!selected_hero || selected_hero < 0) return void $.Schedule(0.1, UpdateFirstMuteState);

	$.Schedule(2, UpdateMutedPlayers_Request);
}
(function () {
	HUD.TEAMS_ROOT.RemoveAndDeleteChildren();
	HUD.CONTEXT.SetHasClass("BKickVotingEnabled", false);

	GameUI.SetDefaultUIEnabled(DotaDefaultUIElement_t.DOTA_DEFAULT_UI_FLYOUT_SCOREBOARD, false);
	InitPlayers();
	UpdateFirstMuteState();
	SetScoreboardVisibleState(false);
	$.RegisterEventHandler("DOTACustomUI_SetFlyoutScoreboardVisible", HUD.CONTEXT, SetScoreboardVisibleState);

	GameEvents.SendToServerEnsured("Tips:get_data", {});
	GameEvents.SendToServerEnsured("voting_for_kick:get_enable_state", {});

	const frame = GameEvents.NewProtectedFrame(HUD.CONTEXT);
	frame.SubscribeProtected("Tips:update", UpdateTips);
	frame.SubscribeProtected("voting_for_kick:enable", EnableKickVoting);
})();