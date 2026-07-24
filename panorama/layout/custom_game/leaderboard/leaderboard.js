--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


let CACHED_LEADERBOARD = {};
const HUD = {
	CONTEXT: $.GetContextPanel(),
	MAPS_CONTAINER: $("#LB_MapsContainer"),
	TABLES_CONTAINER: $("#LB_Tables_Container"),
	LOCAL_RATING_PROGRESS_BAR: $("#LB_LI_Progress"),
	LOCAL_INFO_REWARDS_CURRENT: $("#LB_LI_CurrentReward"),
	LOCAL_INFO_REWARDS_NEXT: $("#LB_LI_NextReward"),
	FULL_REWARDS_LIST: $("#LB_FRD_List"),
};

class LeaderboardMap {
	constructor(map_name) {
		this.state = LEADERBOARD_STATES.NONE;
		this.local_rating = 0;
		this.is_active = map_name == MAP_NAME;
		this.map_name = map_name;
		this.full_rewards_list_by_tiers = {};

		const tab = $.CreatePanel("Button", HUD.MAPS_CONTAINER, `LB_Map_${map_name}`);
		tab.BLoadLayoutSnippet("LB_MapOption");
		tab.SetDialogVariableLocString("map_name", map_name);

		const table = $.CreatePanel("Panel", HUD.TABLES_CONTAINER, `LB_Table _${map_name}`);
		table.BLoadLayoutSnippet("LB_Table");
		for (let i = 0; i < 100; i++) {
			const player = $.CreatePanel("Panel", table, "");
			player.BLoadLayoutSnippet("LB_Player");

			const rank = i + 1;
			player.SetDialogVariableInt("rank", rank);
			player.AddClass(`Rank_${rank}`);
			player.SetHasClass(`DarkBG`, i % 2);
			player.SetHasClass(`Top10`, i < 10);

			player.avatar = player.FindChildTraverse("LB_Player_Avatar");
			player.name = player.FindChildTraverse("LB_Player_Name");

			const rewards_by_top_button = player.FindChildTraverse("LB_Player_RewardsByPlace");

			rewards_by_top_button.SetPanelEvent("onmouseover", () => {
				$.DispatchEvent(
					"UIShowCustomLayoutParametersTooltip",
					rewards_by_top_button,
					"LB_CustomItem_Tooltip",
					"file://{resources}/layout/custom_game/leaderboard/rewards_tooltip/rewards_tooltip.xml",
					BuildTooltipParams({
						items: GetRewardsByTopPlace(rank),
					}),
				);
			});

			rewards_by_top_button.SetPanelEvent("onmouseout", () => {
				$.DispatchEvent("UIHideCustomLayoutTooltip", rewards_by_top_button, "LB_CustomItem_Tooltip");
			});
		}

		tab.SetPanelEvent("onactivate", () => {
			this.OpenLeaderboard();
		});

		const full_rewards_list = $.CreatePanel("Panel", HUD.FULL_REWARDS_LIST, `LB_RewardsList _${map_name}`);
		full_rewards_list.BLoadLayoutSnippet("LB_RewardsListForMap");

		const rewards = REWARDS_BY_MMR[map_name];
		rewards.forEach(([start, end, currency, items], idx) => {
			const rewards_line = $.CreatePanel("Panel", full_rewards_list, "");
			rewards_line.BLoadLayoutSnippet("LB_Rewards_Line");

			this.full_rewards_list_by_tiers[idx] = rewards_line;

			rewards_line.AddClass(`RewardRank_${idx}`);

			let mmr_value = `${start}${idx == rewards.length - 1 ? "+" : ` - ${end}`}`;

			rewards_line.SetDialogVariable("mmr_value", mmr_value);

			const items_container = rewards_line.FindChildTraverse("LB_RL_ItemsContainer");
			const create_item = (item_name, count) => {
				const item = $.CreatePanel("Panel", items_container, `BundleItem_${item_name}`);
				item.BLoadLayoutSnippet("CI_Item");

				item.SetHasClass("BManyItems", count > 1);
				item.SetDialogVariableInt("count", count);

				item.FindChildTraverse("CI_Item_Image").SetImage(GameUI.Inventory.GetItemImagePath(item_name));
				item.SwitchClass("ci_item_rarity", GameUI.Inventory.GetItemRarityName(item_name) || "COMMON");
				item.SwitchClass("ci_item_slot", GameUI.Inventory.GetItemSlotName(item_name) || "slot_none");

				item.SetPanelEvent("onmouseover", () => {
					$.DispatchEvent(
						"UIShowCustomLayoutParametersTooltip",
						item,
						"CustomItem_Tooltip",
						"file://{resources}/layout/custom_game/collection/item_tooltip/item_tooltip.xml",
						BuildTooltipParams({
							items: { [item_name]: count },
						}),
					);
				});

				item.SetPanelEvent("onmouseout", () => {
					$.DispatchEvent("UIHideCustomLayoutTooltip", item, "CustomItem_Tooltip");
				});
			};
			if (currency) create_item("currency", currency);
			if (items) for (const [_item, _count] of Object.entries(items)) create_item(_item, _count);
		});

		this.tab = tab;
		this.table = table;
		this.full_rewards_list = full_rewards_list;
	}
	OpenLeaderboard() {
		this.ActiveTab();
		this.ActiveRewards();
		for (const lb of Object.values(CACHED_LEADERBOARD)) lb.is_active = false;

		this.is_active = true;

		if (this.state == LEADERBOARD_STATES.NONE) {
			this.state = LEADERBOARD_STATES.FETCHED;
			GameEvents.SendToServerEnsured("WebLeaderboards:get_leaderboard", {
				map_name: this.map_name,
			});
			return;
		}

		if (this.state == LEADERBOARD_STATES.LOADED) this.ActiveTable();
		this.UpdateLocalPlayerInfo();
	}
	ActiveRewards() {
		$.DispatchEvent("RemoveStyleFromEachChild", HUD.FULL_REWARDS_LIST, "Activated");
		this.full_rewards_list.AddClass("Activated");
	}
	ActiveTab() {
		$.DispatchEvent("RemoveStyleFromEachChild", HUD.MAPS_CONTAINER, "Activated");
		this.tab.AddClass("Activated");
	}
	ActiveTable() {
		$.DispatchEvent("RemoveStyleFromEachChild", HUD.TABLES_CONTAINER, "Activated");
		this.table.AddClass("Activated");
	}
	SetState(state) {
		this.state = state;
	}
	SetLocalPlayerRating(rating) {
		this.local_rating = rating;
	}
	UpdateLocalPlayerInfo() {
		HUD.CONTEXT.SetDialogVariableInt("local_rating_by_map", this.local_rating);

		const current_rewards = GetRewardsByRating(this.map_name, this.local_rating);
		const next_rewards = GetRewardsByRating(this.map_name, current_rewards.end);

		$.DispatchEvent("RemoveStyleFromEachChild", this.full_rewards_list, "Activated");
		if (
			current_rewards &&
			current_rewards.rank != undefined &&
			this.full_rewards_list_by_tiers[current_rewards.rank]
		)
			this.full_rewards_list_by_tiers[current_rewards.rank].AddClass("Activated");

		HUD.CONTEXT.SetDialogVariableInt("next_rewards_rating", current_rewards.end);

		const create_rewards_tooltip = (info, button) => {
			button.SetPanelEvent("onmouseout", () => {
				$.DispatchEvent("UIHideCustomLayoutTooltip", button, "CustomItem_Tooltip");
			});

			if (!info.rewards) return;

			let items_for_tooltip = {};
			if (info.rewards.items)
				Object.entries(info.rewards.items).forEach(([name, count]) => {
					items_for_tooltip[name] = count || 1;
				});

			button.SetPanelEvent("onmouseover", () => {
				$.DispatchEvent(
					"UIShowCustomLayoutParametersTooltip",
					button,
					"CustomItem_Tooltip",
					"file://{resources}/layout/custom_game/collection/item_tooltip/item_tooltip.xml",

					BuildTooltipParams({
						currency: info.rewards.currency || 0,
						items: items_for_tooltip,
						custom_count: 1,
					}),
				);
			});
		};

		create_rewards_tooltip(current_rewards, HUD.LOCAL_INFO_REWARDS_CURRENT);
		create_rewards_tooltip(next_rewards, HUD.LOCAL_INFO_REWARDS_NEXT);

		HUD.CONTEXT.SetHasClass("BCurrentRewardsAvailable", current_rewards.rewards != undefined);
		HUD.CONTEXT.SetHasClass("BNextRewardsAvailable", next_rewards.rewards != undefined);
		HUD.CONTEXT.SwitchClass("local_player_rank", `LocalRank_${current_rewards.rank}`);

		const max_value = current_rewards.end - current_rewards.start;
		const current_value = max_value - (current_rewards.end - this.local_rating);
		let progress_value = current_value / max_value;
		if (!next_rewards.rewards) progress_value = 1;
		HUD.LOCAL_RATING_PROGRESS_BAR.value = progress_value;
	}
	IsActive() {
		return this.is_active;
	}
}

function SeasonTimer() {
	let today = new Date();
	today.setMinutes(today.getMinutes() + today.getTimezoneOffset());
	let diff = Math.max(0, END_DATE - today);

	const set_time = (format_name, format) => {
		let v = Math.floor(diff / format);
		HUD.CONTEXT.SetDialogVariable(`season_reset_${format_name}`, v.toString().padStart(2, 0));
		diff = diff - format * v;
	};
	set_time("days", 8.64e7);
	set_time("hours", 3.6e6);
	set_time("mins", 60000);

	$.Schedule(10, SeasonTimer);
}
function InitSeasons() {
	const modified_seasons = {
		//7: 11,
	};

	let seasons_data = {};

	let first_season_date = new Date("2022-10-01T00:00:00.520Z");
	let _iteration_season_counter = 1;
	let now = new Date();

	let current_season = 0;

	while (now > first_season_date) {
		let start_shift = modified_seasons[_iteration_season_counter - 1];
		let end_shift = modified_seasons[_iteration_season_counter];

		let _start_date = new Date(first_season_date);
		_start_date.setDate(_start_date.getDate() + (start_shift || 0));

		let _end_date = new Date(first_season_date);
		_end_date.setMonth(_end_date.getMonth() + 3);
		_end_date.setDate(_end_date.getDate() + (end_shift || 0));

		if (now > _start_date) current_season++;

		seasons_data[_iteration_season_counter] = {
			start: _start_date,
			end: _end_date,
		};

		first_season_date.setMonth(first_season_date.getMonth() + 3);

		_iteration_season_counter++;
	}

	// const set_date = (child_index, base_line, date) => {
	// 	root_season_dates.GetChild(child_index).text = LocalizeWithValues(base_line, {
	// 		day: date.getDate().toString().padStart(2, 0),
	// 		month: (date.getMonth() + 1).toString().padStart(2, 0),
	// 		year: date.getFullYear(),
	// 	});
	// };
	//
	// const start_date = seasons_data[current_season].start;
	// const end_date = seasons_data[current_season].end;
	//
	// set_date(1, "current_season_begin_date", start_date);
	// set_date(2, "current_season_end_date", end_date);

	HUD.CONTEXT.SetDialogVariableInt("season_number", current_season);
	// root_season_dates.GetChild(0).text = LocalizeWithValues("current_season_number", { number: current_season });
	// HUD.SEASON_RESULT_HEADER.text = LocalizeWithValues("season_result_header", { number: current_season });

	END_DATE = seasons_data[current_season].end;

	SeasonTimer();
}
function InitLeaderboard() {
	HUD.MAPS_CONTAINER.RemoveAndDeleteChildren();
	HUD.TABLES_CONTAINER.RemoveAndDeleteChildren();
	HUD.FULL_REWARDS_LIST.RemoveAndDeleteChildren();

	for (const map_name of MAPS) CACHED_LEADERBOARD[map_name] = new LeaderboardMap(map_name);

	InitSeasons();
}

function FillLeaderboardTable(event) {
	const map_name = event.map_name;
	if (!map_name) return;

	const leaderboard = CACHED_LEADERBOARD[map_name];
	leaderboard.SetLocalPlayerRating(event.requester_rating || -1);

	const table = leaderboard.table;
	Object.values(event.leaderboard).forEach((player, index) => {
		const panel = table.GetChild(index);
		if (!panel) return;

		const steam_id = player[1];
		const rating = player[2];

		panel.SetDialogVariableInt("rating", rating);
		panel.avatar.steamid = steam_id;
		panel.name.steamid = steam_id;

		panel.AddClass("BPlayerLoaded");
		if (player.steamId == LOCAL_STEAM_ID) panel.AddClass("LocalPlayer");
	});

	leaderboard.SetState(LEADERBOARD_STATES.LOADED);
	if (leaderboard.IsActive()) leaderboard.OpenLeaderboard();
}

let first_open;
GameUI.ToggleLeaderboard = () => {
	HUD.CONTEXT.ToggleClass("Show");
	if (!HUD.CONTEXT.BHasClass("Show")) HUD.CONTEXT.RemoveClass("BShowFullRewardsDetails");

	if (!first_open && CACHED_LEADERBOARD[MAP_NAME]) CACHED_LEADERBOARD[MAP_NAME].OpenLeaderboard();
};

function CloseLeaderboard() {
	HUD.CONTEXT.RemoveClass("Show");
}

function ToggleRewardsDetails() {
	HUD.CONTEXT.ToggleClass("BShowFullRewardsDetails");
}

(function () {
	CloseLeaderboard();
	HUD.CONTEXT.SetDialogVariableInt("local_rating_by_map", 0);
	HUD.CONTEXT.SetDialogVariableInt("season_number", 0);
	InitLeaderboard();
	const frame = GameEvents.NewProtectedFrame($.GetContextPanel());
	frame.SubscribeProtected("WebLeaderboards:set_leaderboard", FillLeaderboardTable);
})();