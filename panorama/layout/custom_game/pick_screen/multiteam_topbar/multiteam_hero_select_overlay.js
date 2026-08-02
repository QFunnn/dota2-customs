--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build b9dc48c · 2026-08-02 17:42:46 UTC
  ~ auto-generated — do not edit
]]


let PLAYER_STATS = {};
const LOCAL_PID = Game.GetLocalPlayerID();
const HUD = {
	CONTEXT: $.GetContextPanel(),
	TEMP_CONTAINER: $("#TempContainer"),
	PLAYER_STATS: $("#PlayerStats_StrategyTime"),
};
let first_message = false;
function PenaltyFixDisonnect(players) {
	if (HUD.CONTEXT.GetParent().id != "CustomUIContainer_HeroSelection") return;

	if (players?.[LOCAL_PID] && !first_message) {
		first_message = true;
		HUD.CONTEXT.AddClass("BShowDisconnectMessage");
	}
}

function HidePenaltyDisconnectMessage() {
	HUD.CONTEXT.RemoveClass("BShowDisconnectMessage");
}

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
	portrait_overlay.style.borderBottom = `5px solid ${GetHEXPlayerColor(player_id)}`;

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

	player_panel.SetDialogVariableInt("rating", stats?.rating || 0);
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
function InitChatFilter() {
	const chat = FindDotaHudElement("Chat");
	if (!chat) return void $.Schedule(1, InitChatFilter);

	const chat_lines_container = chat.FindChildTraverse("ChatLinesPanel");
	if (!chat_lines_container) return void $.Schedule(1, InitChatFilter);

	const filter_messages_basic = [
		"DOTA_Chat_Disconnect",
		"DOTA_Chat_PlayerLeft",
		"DOTA_Chat_DisconnectWaitForReconnect",
		"DOTA_Chat_DisconnectTimeRemaining",
		"DOTA_Chat_DisconnectTimeRemainingPlural",
	];
	let filter_values = [];
	filter_messages_basic.forEach((loc_token) => {
		let text = $.Localize(loc_token);
		text = text
			.replace(/.*%s2/, "")
			.replace("%s1", "")
			.replace(/ +(?= )/g, "");
		text = text.replace(/<[^>]+>/g, "").trim();
		filter_values.push(text);
	});

	const chat_filter = () => {
		if (Game.GameStateIsAfter(DOTA_GameState.DOTA_GAMERULES_STATE_TEAM_SHOWCASE)) return;

		const chat_lines = chat_lines_container.Children();
		for (const message_line of chat_lines) {
			if (message_line.type != "Label") continue;
			filter_values.forEach((check_text) => {
				if (message_line.text.includes(check_text)) message_line.visible = false;
			});
		}
		$.Schedule(0, chat_filter);
	};
	chat_filter();
}

function ApplyGoldBonuses(winrates) {
	if (!winrates) return;

	const pre_game_root = FindDotaHudElement("PreGame");
	if (!pre_game_root) return void $.Schedule(0.5, ApplyGoldBonuses.bind(undefined, winrates));

	const categories = pre_game_root.FindChildTraverse("GridCategories");
	if (!categories || categories.Children().length == 0)
		return void $.Schedule(0.5, ApplyGoldBonuses.bind(undefined, winrates));

	let heroes_without_bonus = [];
	let players_stats = CustomNetTables.GetTableValue("game_state", "player_stats");
	if (players_stats && players_stats[LOCAL_PID] && players_stats[LOCAL_PID].lastWinnerHeroes)
		heroes_without_bonus = Object.values(players_stats[LOCAL_PID].lastWinnerHeroes);

	for (const stat_root of categories.Children()) {
		const heroes = stat_root.FindChildTraverse("HeroList");
		for (const hero of heroes.Children()) {
			const hero_image = hero.FindChildTraverse("HeroImage");
			if (!hero_image) continue;

			const hero_name = `npc_dota_hero_${hero_image.heroname}`;

			if (heroes_without_bonus.indexOf(hero_name) > -1) continue;

			const winrate = winrates[hero_name];
			if (!winrate) continue;

			const ex_bonus = hero_image.FindChild(`CustomChallenge_${hero_name}`);
			if (ex_bonus) ex_bonus.DeleteAsync(0);

			const bonus_overlay = $.CreatePanel("Panel", HUD.TEMP_CONTAINER, `CustomChallenge_${hero_name}`);
			bonus_overlay.BLoadLayoutSnippet("BonusLowWinrate");

			// formula for display text only, actual gold given is calculated in addon_game_mode.lua in OnNPCSpawned
			const fixed_winrate = Math.min(winrate * 100.0, 49.99);
			const bonus_gold = Math.floor((-100 * fixed_winrate + 5100) / 5.0) * 5;

			bonus_overlay.SetDialogVariableInt("winrate_gold_bonus", bonus_gold);

			bonus_overlay.SetParent(hero_image);
		}
	}
}

function UpdateLocalStats() {
	const local_stats = PLAYER_STATS[LOCAL_PID];
	if (!local_stats) return;

	["wins", "loses", "kills", "deaths", "assists", "streak_current", "streak_max"].forEach((s) => {
		HUD.CONTEXT.SetDialogVariable(s, Math.round(local_stats[s]));
	});

	if (HUD.CONTEXT.GetParent().id == "CustomUIContainer_HeroSelection") return;

	const map_content = FindDotaHudElement("StrategyMapContents");
	if (!map_content) return void $.Schedule(0.1, UpdateLocalStats);

	const map_controls = map_content.FindChild("StrategyMapControls");
	if (!map_controls) return void $.Schedule(0.1, UpdateLocalStats);

	const ex_injected_stats = map_content.FindChild(HUD.PLAYER_STATS.id);
	if (ex_injected_stats) ex_injected_stats.DeleteAsync(0);

	$.Schedule(0.1, () => {
		HUD.PLAYER_STATS.SetParent(map_content);
	});

	map_controls.visible = false;
}

(function () {
	InitChatFilter();

	if ($.GetContextPanel().GetParent().id == "CustomUIContainer_HeroSelection") {
		// OverrideBackground();
		// OverrideStrategyMap();
		OverrideBottomHUD();
		UpdateTimer();
	}
	CreateTeams();

	const pre_map_container = FindDotaHudElement("PreMinimapContainer");
	pre_map_container.visible = false;

	SubscribeToNetTableKey("game_state", "player_stats", function (value) {
		PLAYER_STATS = value;
		OnUpdateHeroSelection();
		UpdateLocalStats();
	});

	GameEvents.Subscribe("dota_player_hero_selection_dirty", OnUpdateHeroSelection);
	GameEvents.Subscribe("dota_player_update_hero_selection", OnUpdateHeroSelection);

	UpdatePreGameTimerPosition();

	SubscribeToNetTableKey("heroes_winrate", "heroes", ApplyGoldBonuses);
	SubscribeToNetTableKey("game_state", "penalty_fix_disconnect", PenaltyFixDisonnect);
})();