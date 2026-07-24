--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


const PROFILE_HUD = {
	CONTEXT: $.GetContextPanel(),
	BUTTONS_CONTAINER: $("#C_Profile_Buttons"),
	GLOBAL_STATS_CONTAINER: $("#C_Profile_GS_Container"),
	LATEST_MATCHES_CONTAINER: $("#C_Profile_LM_Container"),
	FULL_MATCHES_CONTAINER: $("#C_Profile_FullMatchesContainer"),
	TEMP_FULL_MATCHES_CONTAINER: $("#C_Profile_FullMatchesContainer_Temp"),
};
let CACHED_PROFILES = {};
let CACHED_MATCHES = {};

const prefix_for_places = {
	1: "st",
	2: "nd",
	3: "rd",
};

class Match extends BackendCacheEntity {
	constructor(match_def, root, map_name) {
		super(CACHED_MATCHES, "WebPlayerStats:get_match_data", { match_id: match_def.match_id });

		const match = $.CreatePanel("Panel", root, "");
		match.BLoadLayoutSnippet("C_Profile_Match");
		match.FindChildTraverse("C_Profile_M_HeroImage").heroname = match_def.hero_name;
		match.SetDialogVariableLocString("hero_name", match_def.hero_name);
		match.SetDialogVariableInt("kills", match_def.kills);
		match.SetDialogVariableInt("deaths", match_def.deaths);
		match.SetDialogVariableInt("assists", match_def.assists);
		match.SetDialogVariableInt("place", match_def.place);
		match.SetDialogVariable("place_prefix", prefix_for_places[match_def.place] || "th");
		match.AddClass(`Place_${match_def.place}`);

		const rating_change = match_def.rating_change;
		match.SetDialogVariable("rating_change", `${rating_change > -1 ? "+" : ""}${rating_change}`);
		match.SwitchClass("mvp_state", `MVP_State_${match_def.mvp_type}`);
		if (rating_change != 0) match.AddClass(rating_change > 0 ? "MmrInc" : "MmrDec");

		this.match_panel = match;

		const full_match = $.CreatePanel("Panel", PROFILE_HUD.TEMP_FULL_MATCHES_CONTAINER, "");
		full_match.BLoadLayoutSnippet("C_ProfileFullMatch");
		full_match.SetDialogVariable("match_id", match_def.match_id);
		full_match.AddClass(map_name);

		this.full_match = full_match;
		this.teams_root = full_match.FindChildTraverse("C_Profile_M_FI_Teams");
		this.teams_root_additional = full_match.FindChildTraverse("C_Profile_M_FI_Teams_PlayerDetails");

		full_match.SetParent(PROFILE_HUD.FULL_MATCHES_CONTAINER);
		match.GetChild(0).SetPanelEvent("onactivate", () => {
			dotaHud.AddClass("BShowCustomMatchDetailsOT3");
			this.Activate();
		});
	}
	OnLoad(event_table) {
		this.FillFullInfo(event_table.match);
		super.OnLoad();
	}
	Callback_OnLoaded() {
		this.ActiveMatch();
	}
	ActiveMatch() {
		$.DispatchEvent("RemoveStyleFromEachChild", PROFILE_HUD.FULL_MATCHES_CONTAINER, "Activated");
		PROFILE_HUD.FULL_MATCHES_CONTAINER.AddClass("Show");
		this.full_match.AddClass("Activated");
	}
	FillFullInfo(match_info) {
		this.full_match.SetParent(PROFILE_HUD.TEMP_FULL_MATCHES_CONTAINER);
		this.full_match.SetDialogVariableTime("started_at", new Date(match_info.started_at).getTime() / 1000);
		this.full_match.SetDialogVariable("duration", FormatSeconds(match_info.duration, false));

		for (const player_info of Object.values(match_info.players)) {
			let team_panel = this.teams_root.FindChildTraverse(`Team_${player_info.team_id}`);
			if (!team_panel) {
				team_panel = $.CreatePanel("Panel", this.teams_root, `Team_${player_info.team_id}`);
				team_panel.BLoadLayoutSnippet("C_Profile_Team");
				team_panel.players_container = team_panel.FindChildTraverse("C_Profile_Team_PlayersContainer");

				team_panel.FindChildTraverse("C_Profile_BTI_Logo").SetImage(GameUI.GetTeamIcon(player_info.team_id));

				team_panel.FindChildTraverse("C_Profile_BTI_Logo_Color").style.washColor = GameUI.GetTeamColor(
					player_info.team_id,
				);
				team_panel.score = 0;

				const details_rows = $.CreatePanel("Panel", this.teams_root_additional, "");
				team_panel.details_rows = details_rows;

				team_panel.AddClass(`TeamPlace_${player_info.place}`);
				details_rows.AddClass(`TeamPlace_${player_info.place}`);
			}

			const player = $.CreatePanel("Panel", team_panel.players_container, "");
			player.BLoadLayoutSnippet("C_Profile_Player_BasicInfo");
			player.FindChildTraverse("C_Profile_P_HeroImage").heroname = player_info.hero_name;
			player.SetDialogVariableLocString("hero_name", player_info.hero_name);

			player.FindChildTraverse("C_Profile_P_PlayerName").steamid = player_info.steam_id;
			player.SwitchClass("mvp_state", `MVP_Player_State_${player_info.mvp_type}`);

			const player_details = $.CreatePanel("Panel", team_panel.details_rows, "");
			player_details.BLoadLayoutSnippet("C_Profile_Player_DetailsInfo");
			team_panel.score += player_info.kills;
			player_details.SetDialogVariableInt("kills", player_info.kills);
			player_details.SetDialogVariableInt("deaths", player_info.deaths);
			player_details.SetDialogVariableInt("assists", player_info.assists);

			team_panel.SetDialogVariableInt("team_score", team_panel.score);

			const rating_change = player_info.rating_change;
			player_details.SetDialogVariable("rating_operator", rating_change > -1 ? "+" : "-");
			player_details.SetDialogVariableInt("rating_change", Math.abs(rating_change));
			if (rating_change != 0) player_details.AddClass(rating_change > 0 ? "MmrInc" : "MmrDec");

			player_details.SetDialogVariableInt("hero_damage", player_info.damage_dealt);
			player_details.SetDialogVariableInt("damage_taken", player_info.damage_taken);
			player_details.SetDialogVariableInt("healing", player_info.healing);

			player_details.SetDialogVariableInt("networth", player_info.networth);
			player_details.SetDialogVariable("total_stuns", player_info.stun_duration_total);

			player.steam_id = player_info.steam_id;
			player_details.steam_id = player_info.steam_id;

			player.SetHasClass("BLocalPlayer", LOCAL_STEAM_ID == player_info.steam_id);
			player_details.SetHasClass("BLocalPlayer", LOCAL_STEAM_ID == player_info.steam_id);

			const sort_players_by_steam_id = (root) => {
				for (const hero of root.Children().sort((a, b) => {
					return b.steam_id - a.steam_id;
				})) {
					root.MoveChildBefore(hero, root.GetChild(0));
				}
			};
			sort_players_by_steam_id(team_panel.players_container);
			sort_players_by_steam_id(team_panel.details_rows);
		}
		this.full_match.AddClass("BFullLoaded");
		this.full_match.SetParent(PROFILE_HUD.FULL_MATCHES_CONTAINER);
	}
}
class Profile extends BackendCacheEntity {
	constructor(map_name) {
		super(CACHED_PROFILES, "WebPlayerStats:get_map_stats", { map_name: map_name });
		this.map_name = map_name;
		this.matches_count = 0;

		const stats_cotnainer = $.CreatePanel("Panel", PROFILE_HUD.GLOBAL_STATS_CONTAINER, "");
		stats_cotnainer.BLoadLayoutSnippet("C_Profile_GS_Entity");

		const tab_button = $.CreatePanel("Button", PROFILE_HUD.BUTTONS_CONTAINER, "");
		tab_button.BLoadLayoutSnippet("C_Profile_Button");
		tab_button.SetDialogVariableLocString("map_name", map_name);

		tab_button.SetPanelEvent("onactivate", () => {
			this.Activate();
		});

		const matches_history = $.CreatePanel("Panel", PROFILE_HUD.LATEST_MATCHES_CONTAINER, "");
		matches_history.BLoadLayoutSnippet("C_Profile_LatestMatches_Entity");

		this.stats_cotnainer = stats_cotnainer;
		this.tab_button = tab_button;
		this.matches_history = matches_history;
	}
	FillLatestMatchesHistory(matches) {
		matches = Object.values(matches);
		for (const match_common_definition of matches)
			CACHED_MATCHES[match_common_definition.match_id] = new Match(
				match_common_definition,
				this.matches_history,
				this.map_name,
			);
		this.matches_count = matches.length;
	}
	FillStats(stats) {
		const total_matches = stats.victories + stats.defeats;
		let rating = stats.rating;
		this.stats_cotnainer.SetDialogVariableInt("total_matches", total_matches);
		this.stats_cotnainer.SetDialogVariableInt("victories", stats.victories);
		this.stats_cotnainer.SetDialogVariableInt("defeats", stats.defeats);
		this.stats_cotnainer.SetDialogVariableInt("rating", rating);
		this.stats_cotnainer.SetDialogVariableInt("streak_current", stats.streak_current);
		this.stats_cotnainer.SetDialogVariableInt("streak_max", stats.streak_max);
		this.stats_cotnainer.SetDialogVariableInt("kills", stats.kills);
		this.stats_cotnainer.SetDialogVariableInt("deaths", stats.deaths);
		this.stats_cotnainer.SetDialogVariableInt("assists", stats.assists);
		this.stats_cotnainer.SetDialogVariableInt("mvp_total", stats.mvp_total);
		this.stats_cotnainer.SetDialogVariableInt("runner_up_total", stats.runner_up_total);

		const set_avg_kda_stat = (type, name, value) => {
			this.stats_cotnainer
				.FindChildTraverse(`C_Profile_GS_E_KDA_${type}`)
				.SetDialogVariable(name, Math.round(value / total_matches));
		};
		set_avg_kda_stat("K", "average_kills", stats.kills);
		set_avg_kda_stat("D", "average_deaths", stats.deaths);
		set_avg_kda_stat("A", "average_assists", stats.assists);

		const current_rewards = GetRewardsByRating(this.map_name, rating);

		if (current_rewards && current_rewards.rank != undefined)
			this.stats_cotnainer.AddClass(`C_Profile_GS_E_Rank_${current_rewards.rank}`);
	}
	OnLoad(event_table) {
		this.FillStats(event_table.stats);
		this.FillLatestMatchesHistory(event_table.matches);
		super.OnLoad();
	}
	Callback_Default() {
		this.ActiveTabButton();
	}
	Callback_OnLoaded() {
		this.ActiveStats();
		this.ActiveMatchHistory();
		PROFILE_HUD.CONTEXT.SetDialogVariableInt("count_of_latest_matches", this.matches_count);
	}
	ActiveTabButton() {
		$.DispatchEvent("RemoveStyleFromEachChild", PROFILE_HUD.BUTTONS_CONTAINER, "Activated");
		this.tab_button.AddClass("Activated");
	}
	ActiveStats() {
		$.DispatchEvent("RemoveStyleFromEachChild", PROFILE_HUD.GLOBAL_STATS_CONTAINER, "Activated");
		this.stats_cotnainer.AddClass("Activated");
	}
	ActiveMatchHistory() {
		$.DispatchEvent("RemoveStyleFromEachChild", PROFILE_HUD.LATEST_MATCHES_CONTAINER, "Activated");
		this.matches_history.AddClass("Activated");
	}
}

function CreateMatches(event) {
	const map_name = event.map_name;
	if (!map_name) return;

	const profile = CACHED_PROFILES[map_name];
	if (!profile) return;

	profile.OnLoad(event);
}
function CreateMatchDetails(event) {
	const match_id = event.match_id;
	if (!match_id) return;

	const match = CACHED_MATCHES[match_id];
	if (!match) return;

	match.OnLoad(event);
}
function FillBasicProfile() {
	PROFILE_HUD.GLOBAL_STATS_CONTAINER.RemoveAndDeleteChildren();
	PROFILE_HUD.BUTTONS_CONTAINER.RemoveAndDeleteChildren();
	PROFILE_HUD.LATEST_MATCHES_CONTAINER.RemoveAndDeleteChildren();
	PROFILE_HUD.FULL_MATCHES_CONTAINER.RemoveAndDeleteChildren();
	PROFILE_HUD.TEMP_FULL_MATCHES_CONTAINER.RemoveAndDeleteChildren();

	for (const map_name of MAPS) CACHED_PROFILES[map_name] = new Profile(map_name);
}

GameUI.ProfileOpenCurrentMap = () => {
	CACHED_PROFILES[MAP_NAME].Activate();
};

function CloseCustomMatchDetails() {
	dotaHud.RemoveClass("BShowCustomMatchDetailsOT3");
	PROFILE_HUD.FULL_MATCHES_CONTAINER.RemoveClass("Show");
	$.DispatchEvent("RemoveStyleFromEachChild", PROFILE_HUD.FULL_MATCHES_CONTAINER, "Activated");
}

(() => {
	PROFILE_HUD.CONTEXT.SetDialogVariableInt("count_of_latest_matches", 0);
	GameUI.Collection.AddAdditionalPanel(PROFILE_HUD.FULL_MATCHES_CONTAINER);
	FillBasicProfile();
	const frame = GameEvents.NewProtectedFrame(PROFILE_HUD.CONTEXT);

	frame.SubscribeProtected("WebPlayerStats:map_stats_fetched", CreateMatches);
	frame.SubscribeProtected("WebPlayerStats:match_data_fetched", CreateMatchDetails);
})();