--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 0b85d8d 
  ~ auto-generated — do not edit
]]


const HUD = {
	CONTEXT: $.GetContextPanel(),
	STATE_TRACKER: $("#CS_CB_StateTracker"),
	TEAMS_CONTAINER: $("#CS_TeamsList"),
	// SURRENDER_VOTE_BUTTON: $("#CS_VoteButton"),
};
const SCOREBOARD_TICKER = new CustomTicker("CustomScoreboardTicker", 0.5);
const SCOREBOARD_PERMANENT_TICKER = new CustomTicker("CustomScoreboardTicker_Permanent", 1);
const OVERRIDE_DESC = ["str_for_kill", "agi_for_kill", "int_for_kill", "delayed_damage", "all_stats_for_kill"];
const TIP_COOLDOWN = 30;
let last_tip_cooldown;
let CACHED_PLAYERS = [];

function ActiveScoreboardState(type) {
	HUD.CONTEXT.SwitchClass("CS_Type", `CS_Type_${type}`);
}

function MuteAll(type) {
	for (let [player_id, player_panel] of Object.entries(CACHED_PLAYERS)) {
		player_id = parseInt(player_id);
		if (player_id == LOCAL_PLAYER_ID) continue;
		if (player_panel.BHasClass("Kicked")) continue; // Kicked players can't be unmuted

		if (HUD[`MUTE_ALL_BUTTON_${type}`].checked) {
			player_panel.SetHasClass(`BPlayerMuted_${type}`, true);
			Game[`SetPlayerMuted${type}`](player_id, true);
		} else if (!player_panel[`custom_mute_${type}`]) {
			player_panel.SetHasClass(`BPlayerMuted_${type}`, false);
			Game[`SetPlayerMuted${type}`](player_id, false);
		}
	}
	UpdateMutedPlayers_Request(type);
}

function UpdateMutedPlayers_Request(type) {
	let mute_data = {};

	for (let player_id of Object.keys(CACHED_PLAYERS)) {
		player_id = parseInt(player_id);
		if (player_id == LOCAL_PLAYER_ID) continue;

		mute_data[player_id] = Game[`IsPlayerMuted${type}`](player_id);
	}

	GameEvents.SendToServerEnsured("GameMode:set_muted_players", { players: mute_data, type: type.toLowerCase() });
}

function SetScoreboardVisibleState(state) {
	SCOREBOARD_TICKER.SetPause(!state);
	HUD.CONTEXT.SetHasClass("Show", state);
}
function DisableHelpAll() {
	let disable_help_data = [];
	if (!HUD.DISABLE_HELP_ALL) return;

	for (const [player_id, player_panel] of Object.entries(CACHED_PLAYERS)) {
		if (player_id == LOCAL_PLAYER_ID) continue;

		if (HUD.DISABLE_HELP_ALL.checked) {
			player_panel.SetHasClass("BDisabledHelp", true);
		} else if (!player_panel.custom_disabled_help) {
			player_panel.SetHasClass("BDisabledHelp", false);
		}
		disable_help_data.push({
			disable: player_panel.BHasClass("BDisabledHelp"),
			to: player_id,
		});
	}

	GameEvents.SendToServerEnsured("set_disable_help_all", { disable_data: disable_help_data });
}

function CreateScoreboardTeamPanel(team_id) {
	if (
		team_id < DOTATeam_t.DOTA_TEAM_FIRST ||
		team_id >= DOTATeam_t.DOTA_TEAM_CUSTOM_MAX ||
		team_id == DOTATeam_t.DOTA_TEAM_NOTEAM ||
		team_id == DOTATeam_t.DOTA_TEAM_NEUTRALS
	)
		return;

	const team_root = $.CreatePanel("Panel", HUD.TEAMS_CONTAINER, `CS_Team_${team_id}`);
	team_root.team_id = team_id;
	team_root.BLoadLayoutSnippet("CS_Team");
	team_root.SetDialogVariableLocString("team_name", Game.GetTeamDetails(team_id).team_name);
	team_root.AddClass(`Team_${team_id}`);
	team_root.SetDialogVariableInt("team_avg_rank", 0);
	team_root.rank_info = {
		players_count: 0,
		rating: 0,
	};

	team_root.mute_all_voice = team_root.FindChildTraverse("CS_T_Header_MuteAll_Voice");
	team_root.mute_all_text = team_root.FindChildTraverse("CS_T_Header_MuteAll_Text");
	team_root.disable_help_all = team_root.FindChildTraverse("CS_T_Header_DisableHelpAll");

	team_root.players_list = team_root.FindChildTraverse("CS_T_PlayersList");

	SCOREBOARD_TICKER.Add(`UpdateTeamInfo_${team_id}`, () => {
		const team_info = Game.GetTeamDetails(team_id);
		team_root.SetDialogVariable("team_score", team_info?.team_score || 0);
	});

	DefaultChildrenSort(HUD.TEAMS_CONTAINER, "team_id", true);

	team_root.AddRatingEntity = (rating) => {
		team_root.rank_info.players_count++;
		team_root.rank_info.rating += rating;
		team_root.RecalculateRating();
	};
	team_root.RemoveRatingEntity = (rating) => {
		team_root.rank_info.players_count--;
		team_root.rank_info.rating -= rating;
		team_root.RecalculateRating();
	};
	team_root.RecalculateRating = () => {
		team_root.SetDialogVariableInt(
			"team_avg_rank",
			team_root.rank_info.rating / Math.max(1, team_root.rank_info.players_count),
		);
	};
	return team_root;
}

function TrackHeroTalents(player_id, talent_panel) {
	if (!talent_panel || !talent_panel.IsValid()) return;

	const player_info = Game.GetPlayerInfo(player_id);
	const hero_idx = player_info.player_selected_hero_entity_index;
	const reset = () => {
		talent_panel.SetPanelEvent("onmouseover", () => {
			$.DispatchEvent("DOTAHUDShowHeroStatBranchTooltip", talent_panel, player_info.player_selected_hero_id, -1);
		});

		$.Schedule(0.1, TrackHeroTalents.bind(undefined, player_id, talent_panel));
		return undefined;
	};
	if (hero_idx < 0) return reset();

	let hero_talents = {};
	let _talents_counter = 0;
	for (let index = 0; index < Entities.GetAbilityCount(hero_idx); index++) {
		const ability = Entities.GetAbility(hero_idx, index);
		if (!ability || ability == -1) continue;

		const ability_name = Abilities.GetAbilityName(ability);
		if (!ability_name || !GameUI.IsAbilityDOTATalent(ability_name)) continue;

		hero_talents[_talents_counter++] = ability_name;
	}
	if (_talents_counter == 0) return reset();

	talent_panel.hero_talents = hero_talents;
	talent_panel.SetPanelEvent("onmouseover", () => {
		$.DispatchEvent("DOTAHUDShowHeroStatBranchTooltip", talent_panel, player_info.player_selected_hero_id, -1);
		$.Schedule(0, () => {
			const defailt_talents_container = FindDotaHudElement("DOTAHUDStatBranchTooltip")?.FindChildTraverse(
				"MainBranchContainer",
			);
			if (!defailt_talents_container) return;

			let localized_talents = [];
			for (let talent_idx = 1; talent_idx <= 8; talent_idx++) {
				const loc_talent_text = defailt_talents_container.FindChildTraverse(`UpgradeName${talent_idx}`)?.text;
				if (loc_talent_text) localized_talents.push(loc_talent_text);
			}

			$.DispatchEvent(
				"UIShowCustomLayoutParametersTooltip",
				talent_panel,
				"CS_P_Talents",
				"file://{resources}/layout/custom_game/scoreboard/custom_talents_tooltip/custom_talents_tooltip.xml",
				BuildTooltipParams({}),
			);
			GameUI.UpdateCustomScoreboardTalents(hero_talents, hero_idx, localized_talents);
		});
	});
}

function ReCreatePanelForPlayer(player_root, player_id) {
	SCOREBOARD_PERMANENT_TICKER.Remove(`UpdateLearnStateTalentsForPlayer_${player_id}`);
	SCOREBOARD_PERMANENT_TICKER.Remove(`UpdateBasicPlayerInfo_Permanent_${player_id}`);
	SCOREBOARD_TICKER.Remove(`UpdateBasicPlayerInfo_${player_id}`);
	delete CACHED_PLAYERS[player_id];

	$.DispatchEvent("RemoveStyleFromEachChild", HUD.TEAMS_CONTAINER, "LocalTeam");

	player_root.DeleteAsync(0);

	$.Schedule(1, () => {
		CreatePanelForPlayer(player_id);
	});
}

function CreatePanelForPlayer(player_id) {
	const player_info = Game.GetPlayerInfo(player_id);
	if (!player_info)
		return void SCOREBOARD_TICKER.Add(
			`CreatePanelForPlayer_${player_id}`,
			CreatePanelForPlayer.bind(undefined, player_id),
		);

	SCOREBOARD_TICKER.Remove(`CreatePanelForPlayer_${player_id}`);

	let player_root = $(`#CS_Player_${player_id}`);
	if (player_root && player_root.IsValid()) return;

	const team_id = Players.GetTeam(player_id);
	const team_root = $(`#CS_Team_${team_id}`) || CreateScoreboardTeamPanel(team_id);
	if (!team_root) return;

	if (player_id == LOCAL_PLAYER_ID) {
		HUD.MUTE_ALL_BUTTON_Voice = team_root.mute_all_voice;
		HUD.MUTE_ALL_BUTTON_Text = team_root.mute_all_text;
		HUD.DISABLE_HELP_ALL = team_root.disable_help_all;
		team_root.AddClass("LocalTeam");
	}

	player_root = $.CreatePanel("Panel", team_root.players_list, `CS_Player_${player_id}`);
	player_root.BLoadLayoutSnippet("CS_Player");
	player_root.team_id = team_id;

	CACHED_PLAYERS[player_id] = player_root;

	player_root.player_id = player_id;

	DefaultChildrenSort(team_root.players_list, "player_id", team_id == DOTATeam_t.DOTA_TEAM_GOODGUYS);

	player_root.SetHasClass("LocalPlayer", player_id == LOCAL_PLAYER_ID);
	player_root.SetHasClass("BPlayerMuted_Voice", Game.IsPlayerMutedVoice(player_id));
	player_root.SetHasClass("BPlayerMuted_Text", Game.IsPlayerMutedText(player_id));

	if (player_id != LOCAL_PLAYER_ID)
		player_root.FindChildTraverse("CS_PC_Tips").SetPanelEvent("onactivate", () => {
			if (dotaHud.BHasClass("BTipsBlocked")) return;
			GameEvents.SendToServerEnsured("Tips:tip", { target_player_id: player_id });
		});

	const mute = (type, force_state) => {
		let is_muted = !Game[`IsPlayerMuted${type}`](player_id);
		if (force_state != undefined) is_muted = force_state;

		// Kicked players can't be unmuted
		if (player_root.BHasClass("Kicked") && is_muted == false) return;

		Game[`SetPlayerMuted${type}`](player_id, is_muted);

		player_root.SetHasClass(`BPlayerMuted_${type}`, is_muted);
		player_root[`custom_mute_${type}`] = is_muted;

		UpdateMutedPlayers_Request(type);
	};

	player_root.mute = mute;

	player_root.FindChildTraverse("CS_PC_Mute_Voice").SetPanelEvent("onactivate", () => {
		mute("Voice");
	});
	player_root.FindChildTraverse("CS_PC_Mute_Text").SetPanelEvent("onactivate", () => {
		mute("Text");
	});

	const kick_button = player_root.FindChildTraverse("CS_PC_Kick");
	kick_button.SetPanelEvent("onactivate", () => {
		if (HUD.CONTEXT.BHasClass("BKickVotingEnabled") && player_id != LOCAL_PLAYER_ID) {
			GameEvents.SendToServerEnsured("voting_for_kick:kick_player", { target_id: player_id });
		}
	});
	kick_button.SetPanelEvent("onmouseover", () => {
		$.DispatchEvent("DOTAShowTextTooltip", kick_button, $.Localize(`scoreboard_kick_hint`, player_root));
	});

	const player_color = GetHEXPlayerColor(player_id);

	const hero_image = player_root.FindChildTraverse("CS_PC_HeroImage");

	const neutral_item = player_root.FindChildTraverse("CS_PC_NeutralItem");
	const talents = player_root.FindChildTraverse("CS_PC_Talents");

	talents.SetPanelEvent("onmouseout", () => {
		$.DispatchEvent("UIHideCustomLayoutTooltip", talents, "CS_P_Talents");
		$.DispatchEvent("DOTAHUDHideStatBranchTooltip");
	});

	const game_stat = CustomNetTables.GetTableValue("game_state", "player_stats");
	const custom_player_info = game_stat ? game_stat[player_id] : {};
	const rating = custom_player_info ? custom_player_info.rating || 1500 : 1500;

	player_root.SetDialogVariable("player_color", player_color);
	player_root.SetDialogVariable("player_name", player_info.player_name);
	player_root.SetDialogVariableInt("rank", rating);
	player_root.SetDialogVariableLocString("hero_name", player_info.player_selected_hero);

	player_root.FindChildTraverse("CS_PC_PlayerName").steamid = player_info.player_steamid;
	player_root.FindChildTraverse("CS_PlayerColor").style.backgroundColor = player_color;

	team_root.AddRatingEntity(rating);

	TrackHeroTalents(player_id, talents);
	SCOREBOARD_PERMANENT_TICKER.Add(`UpdateLearnStateTalentsForPlayer_${player_id}`, () => {
		let _player_info_tracking = Game.GetPlayerInfo(player_id);
		const _hero_idx_tracking = _player_info_tracking.player_selected_hero_entity_index;

		if (talents.hero_talents)
			for (const [talent_idx, talent_name] of Object.entries(talents.hero_talents)) {
				const ability = Entities.GetAbilityByName(_hero_idx_tracking, talent_name);
				if (ability) player_root.SetHasClass(`BTalentLearned_${talent_idx}`, Abilities.GetLevel(ability) > 0);
			}

		let hero_class = "";
		const hero_level = _player_info_tracking.player_level;
		if (hero_level >= 10 && hero_level < 15) hero_class = "HeroLevel10";
		else if (hero_level >= 15 && hero_level < 20) hero_class = "HeroLevel15";
		else if (hero_level >= 20 && hero_level < 25) hero_class = "HeroLevel20";
		else if (hero_level >= 25 && hero_level <= 30) hero_class = "HeroLevel25";

		player_root.SwitchClass("hero_level_talent_progress", hero_class);
	});

	if (team_id == Players.GetTeam(LOCAL_PLAYER_ID)) {
		const disable_help_data = CustomNetTables.GetTableValue("disable_help", LOCAL_PLAYER_ID.toString());
		player_root.update_disable_help = (dh_table) => {
			if (dh_table && dh_table[player_id]) {
				player_root.custom_disabled_help = true;
				player_root.AddClass("BDisabledHelp");
			}
		};

		player_root.update_disable_help(disable_help_data);

		player_root.FindChildTraverse("CS_PC_DisableHelp").SetPanelEvent("onactivate", () => {
			player_root.ToggleClass("BDisabledHelp");
			player_root.custom_disabled_help = player_root.BHasClass("BDisabledHelp");
			GameEvents.SendToServerEnsured("set_disable_help", {
				disable: player_root.BHasClass("BDisabledHelp"),
				to: player_id,
			});
		});
	}

	HighlightByParty(player_id, player_root.FindChildTraverse("CS_PC_PlayerName"));

	SCOREBOARD_PERMANENT_TICKER.Add(`UpdateBasicPlayerInfo_Permanent_${player_id}`, () => {
		let _player_info_tracking = Game.GetPlayerInfo(player_id);
		const _hero_idx_tracking = _player_info_tracking.player_selected_hero_entity_index;

		player_root.SetDialogVariableInt("hero_level", _player_info_tracking.player_level);
		player_root.SetDialogVariableInt("kills", _player_info_tracking.player_kills);
		player_root.SetDialogVariableInt("deaths", _player_info_tracking.player_deaths);
		player_root.SetDialogVariableInt("assists", _player_info_tracking.player_assists);

		const neutral_item_ent = Entities.GetItemInSlot(_hero_idx_tracking, 16);
		if (neutral_item_ent) neutral_item.itemname = Abilities.GetAbilityName(neutral_item_ent);

		if (player_root.team_id != Players.GetTeam(player_id)) {
			team_root.RemoveRatingEntity(rating);
			ReCreatePanelForPlayer(player_root, player_id);
		}
	});

	SCOREBOARD_TICKER.Add(`UpdateBasicPlayerInfo_${player_id}`, () => {
		let _player_info_tracking = Game.GetPlayerInfo(player_id);
		hero_image.SetImage(
			player_info.player_selected_hero !== ""
				? GetPortraitImage(player_id, _player_info_tracking.player_selected_hero)
				: "file://{images}/custom_game/unassigned.png",
		);

		const connection_state = _player_info_tracking.player_connection_state;
		player_root.SetHasClass(
			"Disconnected",
			connection_state == DOTAConnectionState_t.DOTA_CONNECTION_STATE_DISCONNECTED,
		);
		player_root.SetHasClass(
			"Abandoneded",
			connection_state == DOTAConnectionState_t.DOTA_CONNECTION_STATE_ABANDONED,
		);

		if (HUD.CONTEXT.BHasClass("CS_State_Short")) return;
		player_root.SetDialogVariable("networth", FormatBigNumber(_player_info_tracking.player_gold));
	});
}
function InitPlayers() {
	for (let player_id = 0; player_id <= 23; player_id++) {
		CreatePanelForPlayer(player_id);
	}
}

function ShowPlayersPerk(event) {
	for (const [player_id, perk_data] of Object.entries(event)) {
		const player_root = CACHED_PLAYERS[player_id];
		if (!player_root) continue;

		const perk_image = player_root.FindChildTraverse("CS_PC_Perk");
		perk_image.SetImage(`file://{images}/custom_game/perks/icons/${perk_data.base_perk}_t0.png`);

		const is_family_perk = perk_data.perk_name == "family";
		player_root.SetHasClass("BGrantedByFamily", is_family_perk);
		perk_image.SetDialogVariableLocString("perk_name", GetPerkLocName(perk_data.base_perk, 2));
		perk_image.SetDialogVariableLocString(
			"perk_desc",
			OVERRIDE_DESC.includes(perk_data.base_perk)
				? `${perk_data.base_perk}_override_Description`
				: `DOTA_Tooltip_${perk_data.base_perk}_Description`,
		);
		perk_image.SetDialogVariable("granted_by_family", is_family_perk ? $.Localize("perk_granted_by_family") : "");

		perk_image.SetPanelEvent("onmouseover", () => {
			$.DispatchEvent(
				"DOTAShowTitleTextTooltip",
				perk_image,
				"{s:perk_name}",
				"{s:perk_desc}{s:granted_by_family}",
			);
		});
	}
}

function UpdateTips(data) {
	const is_max_tips_for_this_game = data.used_this_game >= data.max_this_game;
	dotaHud.SetHasClass("BTipsBlocked", is_max_tips_for_this_game || data.used_total >= data.max_total);
	if (is_max_tips_for_this_game) return;

	if (data.cooldown > 0) {
		last_tip_cooldown = data.cooldown;
		const check_tip_cooldown = () => {
			dotaHud.SetHasClass("BTipsBlocked", Game.GetGameTime() < last_tip_cooldown + TIP_COOLDOWN);
			if (Game.GetGameTime() >= last_tip_cooldown + TIP_COOLDOWN) {
				return;
			}
			$.Schedule(0.5, check_tip_cooldown);
		};
		check_tip_cooldown();
	}
}

function RefreshDisableHelpList() {
	const disable_help = CustomNetTables.GetTableValue("disable_help", Players.GetLocalPlayer());
	if (!disable_help) return;

	for (const player_root of Object.values(CACHED_PLAYERS))
		if (player_root.update_disable_help) player_root.update_disable_help(disable_help);
}
function FullMutePlayer(player_id, repeat = false) {
	const player_root = CACHED_PLAYERS[player_id];
	if (!player_root) {
		if (repeat) return void $.Schedule(1, FullMutePlayer.bind(undefined, player_id, repeat));
		return;
	}

	player_root.mute("Voice", true);
	player_root.mute("Text", true);
}
function MutePlayerByItem(data) {
	const target_id = data.target_id;
	if (!target_id) return;

	FullMutePlayer(target_id);
}
function UpdateMutedPlayerByPunishments(event) {
	const muted_players = event.muted_players;
	if (!muted_players) return;

	for (const player_id of Object.values(muted_players)) FullMutePlayer(player_id, true);
}
function EnableKickVoting() {
	HUD.CONTEXT.SetHasClass("BKickVotingEnabled", true);
}
// function UpdateSurrenderState(data) {
// 	const players_voted_yes = Object.values(data.current_players_voted);
//
// 	HUD.SURRENDER_VOTE_BUTTON.SetDialogVariable("current_players_voted", players_voted_yes.length);
// 	HUD.SURRENDER_VOTE_BUTTON.SetDialogVariable("total_player_count", data.total_player_count);
// 	HUD.CONTEXT.SetHasClass("BLocalPlayerSurrenders", players_voted_yes.includes(LOCAL_PLAYER_ID));
// 	HUD.CONTEXT.SetHasClass("BSurrenderCountdown", data.surrender_countdown != undefined);
// }
//
// function ChangeSurrenderState() {
// 	GameEvents.SendToServerEnsured("game_surrender:vote", {});
// }

function OnPlayerKicked(event) {
	FullMutePlayer(event.target_id);
	const player_root = CACHED_PLAYERS[event.target_id];
	if (player_root) player_root.AddClass("Kicked");
}

(() => {
	HUD.CONTEXT.SwitchClass("map_name", MAP_NAME);
	HUD.CONTEXT.SwitchClass("CS_Type", `CS_Type_Long`);
	HUD.TEAMS_CONTAINER.RemoveAndDeleteChildren();
	GameUI.SetDefaultUIEnabled(DotaDefaultUIElement_t.DOTA_DEFAULT_UI_FLYOUT_SCOREBOARD, false);

	InitPlayers();
	SetScoreboardVisibleState(false);
	$.RegisterEventHandler("DOTACustomUI_SetFlyoutScoreboardVisible", HUD.CONTEXT, SetScoreboardVisibleState);

	const frame = GameEvents.NewProtectedFrame(HUD.CONTEXT);
	frame.SubscribeProtected("Tips:update", UpdateTips);
	GameEvents.SendToServerEnsured("voting_for_kick:get_enable_state", {});
	// GameEvents.SendToServerEnsured("game_surrender:get_state", {});
	GameEvents.SendToServerEnsured("Punishments:fetch_muted_players", {});
	GameEvents.SendToServerEnsured("Tips:get_data", {});

	frame.SubscribeProtected("set_disable_help_refresh", RefreshDisableHelpList);
	frame.SubscribeProtected("mute_player_item", MutePlayerByItem);
	frame.SubscribeProtected("voting_for_kick:enable", EnableKickVoting);
	frame.SubscribeProtected("voting_for_kick:open_scoreboard", () => {
		HUD.CONTEXT.AddClass("KickGlow");
		SetScoreboardVisibleState(true);
	});

	// frame.SubscribeProtected("game_surrender:update_state", UpdateSurrenderState);
	frame.SubscribeProtected("Punishments:set_muted_players", UpdateMutedPlayerByPunishments);
	frame.SubscribeProtected("voting_to_kick:player_kicked", OnPlayerKicked);

	const kicked_players = CustomNetTables.GetTableValue("game_state", "kicked_players");
	if (kicked_players) {
		for (player_id in kicked_players) {
			player_id = parseInt(player_id);
			FullMutePlayer(player_id);
			const player_root = CACHED_PLAYERS[player_id];
			if (player_root) player_root.AddClass("Kicked");
		}
	}

	SubscribeToNetTableKey("game_state", "game_perks", ShowPlayersPerk);
})();