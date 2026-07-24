--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


const LOADING_HUD = {
	CONTEXT: $.GetContextPanel(),
	PLAYERS_LIST: $("#LoadingPlayers_List"),
	BULLETS_ROOT: $("#LS_Tips_Bullets"),
	HINT_MOVIE: $("#LS_VideoHint"),
	MOVIE_CONTAINER: $("#LS_Tips_WebContainer"),
	LS_HINT_TIMER_HEADER: $("#LS_StartTimer_Header"),
	LS_HINT_TIMER_TEXT: $("#LS_StartTimer_Timer"),
	CHAT: FindDotaHudElementInLS("LoadingScreenChat"),
	OPTIONS_CONTAINER: $("#HostOptions"),
	BANNER_TOURNAMENT_FFA: $("#Banner_Tournament_FFA"),
};

const LOADING_STATES_DATA = {
	[DOTAConnectionState_t.DOTA_CONNECTION_STATE_CONNECTED]: "BState_Loaded",
	[DOTAConnectionState_t.DOTA_CONNECTION_STATE_ABANDONED]: "BState_Failed",
	[DOTAConnectionState_t.DOTA_CONNECTION_STATE_FAILED]: "BState_Failed",
};

const hints = [
	// ["tournament", 25],
	["orbs", 12],
	["progress", 7],
	["epic", 8],
	["collection", 11],
];
const additional_hints_config = {
	tournament: {
		b_image: true,
		b_hide_desc: true,
		b_ignore_hover: true,
		click_callback: () => {
			$.DispatchEvent("ExternalBrowserGoToURL", "https://discord.gg/hZyjvskZvM");
		},
	},
};
let current_hint;
let auto_hint_schedule;
let players = {};

let players_in_lobby = 0;
let players_loaded = {};

let host_options_enabled = false;

function InitHints() {
	LOADING_HUD.BULLETS_ROOT.RemoveAndDeleteChildren();
	hints.forEach((hint_name, idx) => {
		const bullet = $.CreatePanel("Panel", LOADING_HUD.BULLETS_ROOT, `Bullet_${idx}`);
		bullet.BLoadLayoutSnippet("LS_Bullet");
	});
	current_hint = 0;
	SetHint(current_hint);
}

function CheckCurrentHint() {
	LOADING_HUD.CONTEXT.SetHasClass("BFirstHint", current_hint == 0);
	LOADING_HUD.CONTEXT.SetHasClass("BLastHint", current_hint == hints.length - 1);
}

function SetHint(idx) {
	if (auto_hint_schedule) auto_hint_schedule = $.CancelScheduled(auto_hint_schedule);
	idx = Math.clamp(idx, 0, hints.length - 1);

	const hint_name = hints[idx][0];
	const hint_config = additional_hints_config[hint_name];
	const b_image = !!hint_config && hint_config.b_image;
	const b_hide_desc = !!hint_config && hint_config.b_hide_desc;
	const b_ignore_hover = !!hint_config && hint_config.b_ignore_hover;
	const click_callback = !!hint_config && hint_config.click_callback;

	LOADING_HUD.MOVIE_CONTAINER.SetHasClass("BImage", b_image);
	LOADING_HUD.MOVIE_CONTAINER.SetHasClass("BHideDescription", b_hide_desc);
	LOADING_HUD.MOVIE_CONTAINER.SetHasClass("BIgnoreHover", b_ignore_hover);
	LOADING_HUD.MOVIE_CONTAINER.ClearPanelEvent("onactivate");
	LOADING_HUD.MOVIE_CONTAINER.SetHasClass("BClickable", click_callback != undefined);
	if (click_callback) LOADING_HUD.MOVIE_CONTAINER.SetPanelEvent("onactivate", click_callback);

	LOADING_HUD.HINT_MOVIE.SetMovie(b_image ? "" : `file://{resources}/videos/custom_game/${hint_name}.webm`);
	LOADING_HUD.MOVIE_CONTAINER.SwitchClass("content", `Content_${b_image ? hint_name : "none"}`);

	$(`#Bullet_${current_hint}`).RemoveClass("Active");
	$(`#Bullet_${idx}`).AddClass("Active");

	LOADING_HUD.CONTEXT.SetDialogVariable(
		"hint_desc_header",
		$.Localize(`#ls_hint_desc_${hint_name}_header`),
		LOADING_HUD.CONTEXT,
	);
	LOADING_HUD.CONTEXT.SetDialogVariable(
		"hint_desc_text",
		$.Localize(`#ls_hint_desc_${hint_name}`),
		LOADING_HUD.CONTEXT,
	);

	current_hint = idx;
	CheckCurrentHint();
	auto_hint_schedule = $.Schedule(hints[idx][1], () => {
		auto_hint_schedule = undefined;
		if (idx < hints.length - 1) NextHint();
		else SetHint(0);
	});
}

function NextHint() {
	SetHint(current_hint + 1);
}

function PrevHint() {
	SetHint(current_hint - 1);
}

function UpdatePlayersLoadState() {
	Object.entries(players).forEach(([player_id, panel]) => {
		const player_info = Game.GetPlayerInfo(parseInt(player_id));
		panel.SwitchClass("loading_state", LOADING_STATES_DATA[player_info.player_connection_state] || "BState_None");

		players_loaded[player_id] =
			player_info.player_connection_state == DOTAConnectionState_t.DOTA_CONNECTION_STATE_CONNECTED || null;
	});

	const player_loaded_count = Object.values(players_loaded).filter((v) => v).length;

	LOADING_HUD.CONTEXT.SetDialogVariableInt("players_loaded", player_loaded_count);

	$.Schedule(0.1, () => {
		if (player_loaded_count < players_in_lobby) UpdatePlayersLoadState();
		else LOADING_HUD.CONTEXT.RemoveClass("BLoadingState");
	});
}

function CreateLoadingPlayersPanel() {
	LOADING_HUD.CONTEXT.SetHasClass("BLoadingState", true);
	LOADING_HUD.CONTEXT.AddClass(Game.GetMapInfo().map_display_name);

	LOADING_HUD.PLAYERS_LIST.RemoveAndDeleteChildren();

	for (let player_id = 0; player_id < DOTALimits_t.DOTA_MAX_TEAM_PLAYERS; player_id++) {
		const player_info = Game.GetPlayerInfo(player_id);
		if (!player_info) continue;

		players_in_lobby++;

		const player_panel = $.CreatePanel("Panel", LOADING_HUD.PLAYERS_LIST, `LS_PlayerLoading_${player_id}`);
		player_panel.BLoadLayoutSnippet("LS_Player");
		player_panel.SetHasClass("BLocalPlayer", player_id == Game.GetLocalPlayerID());
		players[player_id] = player_panel;

		const player_root_info = player_panel.FindChild("LS_PlayerInfo");
		player_root_info.GetChild(0).steamid = player_info.player_steamid;
		player_root_info.GetChild(1).steamid = player_info.player_steamid;
	}
	LOADING_HUD.CONTEXT.SetDialogVariableInt("players_total", players_in_lobby);

	UpdatePlayersLoadState();
}

function UpdateLoadingScreen() {
	const player_info = Game.GetPlayerInfo(Game.GetLocalPlayerID());
	if (!player_info || player_info.player_connection_state != DOTAConnectionState_t.DOTA_CONNECTION_STATE_CONNECTED)
		return void $.Schedule(0.1, UpdateLoadingScreen);

	CreateLoadingPlayersPanel();
	UpdateTimer();
}

function UpdateTimer() {
	var game_time = Game.GetGameTime();
	var transition_time = Game.GetStateTransitionTime();
	if (transition_time >= 0)
		LOADING_HUD.CONTEXT.SetDialogVariable(
			"ls_hints_timer",
			FormatSeconds(Math.max(transition_time - game_time, 0)),
		);

	LOADING_HUD.CONTEXT.SetHasClass("BGameLaunch", transition_time >= 0);
	LOADING_HUD.CONTEXT.SetHasClass(
		"BGameLoading",
		Game.GameStateIs(DOTA_GameState.DOTA_GAMERULES_STATE_WAIT_FOR_PLAYERS_TO_LOAD),
	);

	if (Game.GameStateIsAfter(DOTA_GameState.DOTA_GAMERULES_STATE_WAIT_FOR_PLAYERS_TO_LOAD))
		LOADING_HUD.LS_HINT_TIMER_HEADER.text = $.Localize("#ls_hint_text_header_game_start");

	if (LOADING_HUD.CHAT.BHasClass("ChatExpanded") && !LOADING_HUD.CHAT.b_custom_change_color) {
		FindDotaHudElementInLS("ChatLinesContainer").style.backgroundColor = "rgba(0,0,0,0.85)";
		LOADING_HUD.CHAT.b_custom_change_color = true;
	}
	if (Game.GameStateIsAfter(DOTA_GameState.DOTA_GAMERULES_STATE_CUSTOM_GAME_SETUP)) return;
	$.Schedule(0.1, UpdateTimer);
}

function UpdateChatStyle() {
	FindDotaHudElementInLS("ChatLinesOverlay").visible = false;
	const is_4x3 = dotaLoadingScreen.BHasClass("AspectRatio4x3");
	const is_16x10 = dotaLoadingScreen.BHasClass("AspectRatio16x10");

	let chat_width = 600;
	if (is_4x3) chat_width = 282;
	else if (is_16x10) chat_width = 450;

	LOADING_HUD.CHAT.style.width = `${chat_width}px`;
	LOADING_HUD.CHAT.style.margin = "0 30px 582px 0px";
	FindDotaHudElementInLS("ChatLinesContainer").style.height = "130px";
	LOADING_HUD.CHAT.style.horizontalAlign = "right";
}

function ToggleHostOption(name) {
	if (!host_options_enabled) return;

	const checkbox = $(`#${name}`);
	const current_state = checkbox.selected || false;
	checkbox.selected = !current_state;
	checkbox.SetSelected(checkbox.selected);

	GameEvents.SendToServerEnsured("HostOptions:set_option_state", {
		name: name,
		state: checkbox.selected,
	});
}

function ShowHostOptions(event) {
	let data = event.event_data;
	host_options_enabled = true;
	LOADING_HUD.CONTEXT.SetHasClass("host_options_enabled", true);

	LOADING_HUD.OPTIONS_CONTAINER.Children().forEach((option) => {
		option.visible = data.available_options[option.id] === 1;
	});
}

GameUI.GetOption = (option_name) => {
	const table = CustomNetTables.GetTableValue("game_options", "host_options");
	return table ? table[option_name] || false : false;
};

function UdpateWeekendsDates(dates) {
	let weekends_event_info = CustomNetTables.GetTableValue("game_state", "weekends_event_info");
	if (!weekends_event_info) return;
	// weekends_event_info.is_event_active = 1;
	const is_event_active = weekends_event_info.is_event_active == 1;

	LOADING_HUD.CONTEXT.AddClass("BShowWeekendsEvent", is_event_active);
	LOADING_HUD.CONTEXT.SetHasClass("BWeekendsEventActive", is_event_active);
	const set_date = (_n) => {
		const date = weekends_event_info.dates[_n].replace(/-/g, ".");
		LOADING_HUD.CONTEXT.SetDialogVariable(`weekend_event_date_${_n}`, date);
	};
	LOADING_HUD.CONTEXT.SetDialogVariableLocString(
		"weekend_event_header",
		`ls_weekend_banner_header_event_${is_event_active ? "on" : "off"}`,
	);
	set_date(1);
	set_date(2);
}
CustomNetTables.SubscribeNetTableListener("game_state", UdpateWeekendsDates);

function UpdateTournamentDates() {
	LOADING_HUD.BANNER_TOURNAMENT_FFA.SetDialogVariableTime("t_ffa_signups_start", 1710583200);
	LOADING_HUD.BANNER_TOURNAMENT_FFA.SetDialogVariableTime("t_ffa_signups_end", 1711188000);
	LOADING_HUD.BANNER_TOURNAMENT_FFA.SetDialogVariableTime("t_ffa_start", 1711792800);
	LOADING_HUD.BANNER_TOURNAMENT_FFA.SetDialogVariableTime("t_ffa_end", 1711814400);
}
(() => {
	LOADING_HUD.CONTEXT.RemoveClass("BShowWeekendsEvent");
	UdpateWeekendsDates();
	UpdateLoadingScreen();
	InitHints();
	UpdateChatStyle();
	// UpdateTournamentDates();
	FindDotaHudElementInLS("SidebarAndBattleCupLayoutContainer").visible = false;

	GameEvents.Subscribe("HostOptions:show", ShowHostOptions);
})();