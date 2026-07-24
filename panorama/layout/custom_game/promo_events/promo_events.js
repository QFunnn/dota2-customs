--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


function TimeLeftFormate(panel, end_date) {
	const ms_per_minute = 60000;
	const ms_per_hour = 3600000;
	const ms_per_day = 86400000;

	const difference = new Date(parseInt(end_date)) - new Date();

	let remaining = { diff: difference };

	remaining.days = Math.floor(remaining.diff / ms_per_day);
	remaining.diff %= ms_per_day;
	remaining.hours = Math.floor(remaining.diff / ms_per_hour);
	remaining.diff %= ms_per_hour;
	remaining.mins = Math.floor(remaining.diff / ms_per_minute);

	let result = "";
	const set_date = (format) => {
		if (remaining[format] <= 0) return;

		panel.SetDialogVariable(format, remaining[format]);
		result += ` ${$.Localize(`promo_events_time_${format}`, panel)}`;
	};

	set_date("days");
	set_date("hours");
	set_date("mins");

	panel.SetDialogVariable("time_remaining", result.trim());
	panel.SetDialogVariable(
		"task_time_basic",
		$.Localize(`promo_events_time_${difference > 0 ? "remaining" : "expired"}`, panel),
	);
	panel.SetHasClass("BTimeExpired", difference <= 0);
}

function AddReward(container, reward_name, reward_amount) {
	const reward_panel = $.CreatePanel("Panel", container, `season_reset_${reward_name}`);
	reward_panel.BLoadLayoutSnippet("PromoReward");

	reward_panel.SetDialogVariableInt("reward_amount", reward_amount);
	if (reward_name == "currency") reward_panel.AddClass("Reward_currency");
	else reward_panel.FindChildTraverse("PR_Icon").SetImage(GameUI.Inventory.GetItemImagePath(reward_name));

	reward_panel.SwitchClass("rarity", GameUI.Inventory.GetItemRarityName(reward_name) || "COMMON");
	reward_panel.SwitchClass("slot", GameUI.Inventory.GetItemSlotName(reward_name) || "NONE");

	reward_panel.SetPanelEvent("onmouseover", () => {
		$.DispatchEvent("DOTAShowTextTooltip", reward_panel, $.Localize(reward_name));
	});
	reward_panel.SetPanelEvent("onmouseout", () => {
		$.DispatchEvent("DOTAHideTextTooltip");
	});
}
let GAMES_INITED = {};
let current_selected_game_filter;
let b_button_was_highlighted = false;

function CreateGameButton(game_name) {
	const panel = $.CreatePanel("Button", HUD.GAMES, "");
	panel.BLoadLayoutSnippet("PromoGame");
	panel.SetDialogVariableLocString("game_name", `promo_events_game_${game_name}`);
	panel.sort_weight = (games_order.indexOf(game_name) || 0) * 1000;

	panel.AddClass(`Game_${game_name}`);
	panel.FindChildTraverse("PG_Image").SetImage(`file://{images}/custom_game/promo_events/${game_name}.png`);
	panel.FindChildTraverse("PG_BG_Image").SetImage(`file://{images}/custom_game/promo_events/${game_name}.png`);

	panel.ActivateFilter = () => {
		$.DispatchEvent("RemoveStyleFromEachChild", HUD.GAMES, "Activated");

		if (HUD.CONTEXT.BHasClass(`BActiveGame_${game_name}`)) {
			current_selected_game_filter = undefined;
			HUD.CONTEXT.SetHasClass("BGameFilterActivated", false);
			HUD.CONTEXT.SwitchClass("active_game", "");
		} else {
			current_selected_game_filter = game_name;
			panel.AddClass("Activated");
			HUD.CONTEXT.SetHasClass("BGameFilterActivated", true);
			HUD.CONTEXT.SwitchClass("active_game", `BActiveGame_${game_name}`);
		}
	};
	panel.SetPanelEvent("onactivate", panel.ActivateFilter);

	const link = games_workshop_pages[game_name];
	if (link) {
		panel.AddClass("BGameHasLink");
		panel.FindChildTraverse("PG_LinkButton").SetPanelEvent("onactivate", () => {
			$.DispatchEvent("DOTAShowCustomGamePage", link);
		});
	}

	GAMES_INITED[game_name] = panel;

	panel.claimed_tasks = 0;
	panel.total_tasks = 0;
	panel.UpdateProgress = () => {
		panel.SetDialogVariable("claimed_tasks", panel.claimed_tasks);
		panel.SetDialogVariable("total_tasks", panel.total_tasks);
	};

	DefaultChildrenSort(HUD.GAMES, "sort_weight");

	return panel;
}

function CreatePromoEvents(events) {
	GAMES_INITED = {};
	HUD.TASKS.RemoveAndDeleteChildren();
	HUD.GAMES.RemoveAndDeleteChildren();

	HUD.CONTEXT.SwitchClass("active_game", "");
	HUD.CONTEXT.RemoveClass("BGameFilterActivated");
	HUD.CONTEXT.RemoveClass("BHaveAvailableTasks");
	for (const [event_id, event] of Object.entries(events.active_events)) {
		HUD.CONTEXT.AddClass("BHaveAvailableTasks");

		const game_button = GAMES_INITED[event.custom_game] || CreateGameButton(event.custom_game);

		for (const [task_name, definition] of Object.entries(event.tasks)) {
			const task_panel = $.CreatePanel("Button", HUD.TASKS, "");
			task_panel.BLoadLayoutSnippet("PromoTask");
			task_panel
				.FindChildTraverse("PT_Icon")
				.SetImage(`file://{images}/custom_game/promo_events/${event.custom_game}_small.png`);

			task_panel.sort_weight = (games_order.indexOf(event.custom_game) || 0) * 1000;
			task_panel.AddClass(`Game_${event.custom_game}`);

			task_panel.SetDialogVariableLocString("game_name", `promo_events_game_${event.custom_game}`);
			task_panel.SetDialogVariableLocString("objective", `promo_events_${task_name}`);

			const progress = events?.player_event_data?.[event_id]?.[task_name]?.progress || 0;
			const claimed = !!events?.player_event_data?.[event_id]?.[task_name]?.claimed;
			task_panel.SetDialogVariable("progress", progress);
			task_panel.SetDialogVariable("goal", definition.target);
			task_panel.SetDialogVariable("claim_state", "");

			if (claimed) {
				task_panel.SetDialogVariable("progress", definition.target);
				task_panel.AddClass("BTaskDone");
				task_panel.AddClass("BTaskClaimed");
				task_panel.SetDialogVariableLocString("claim_state", "promo_events_claimed");
				task_panel.sort_weight = task_panel.sort_weight / 100;
				game_button.claimed_tasks++;
			} else if (progress >= definition.target && !claimed) {
				task_panel.sort_weight = task_panel.sort_weight * 100;
				task_panel.SetDialogVariable("progress", definition.target);
				task_panel.AddClass("BTaskDone");
				task_panel.SetDialogVariableLocString("claim_state", "promo_events_claim");

				task_panel.SetPanelEvent("onactivate", () => {
					GameEvents.SendToServerEnsured("WebPromoEvents:claim", {
						promo_event_id: event_id,
						task_id: task_name,
					});
				});
			} else if (!b_button_was_highlighted) {
				dotaHud.SetHasClass("BNeedClaimPromoTask", true);
				b_button_was_highlighted = true;
			}

			const parse_date = (date) => {
				const y = date.slice(-2);
				date = date.slice(0, -3).split("/").reverse().join("/");

				return `${date}/${y}`;
			};

			task_panel.SetDialogVariable(
				"task_time_basic",
				`${parse_date(event.started_at)} - ${parse_date(event.ends_at)}`,
			);

			const rewards_container = task_panel.FindChildTraverse("PT_Rewards");

			if (definition?.rewards.currency) AddReward(rewards_container, "currency", definition.rewards.currency);

			if (definition?.rewards.items)
				for (const [reward_name, reward_count] of Object.entries(definition.rewards.items))
					AddReward(rewards_container, reward_name, reward_count);

			game_button.total_tasks++;
			game_button.UpdateProgress();
		}
	}
	DefaultChildrenSort(HUD.TASKS, "sort_weight");

	if (current_selected_game_filter) GAMES_INITED?.[current_selected_game_filter]?.ActivateFilter();
}

GameUI.ToggleCustomPromoEvents = (manually) => {
	if (manually) dotaHud.SetHasClass("BNeedClaimPromoTask", false);

	if (HUD.CONTEXT.BHasClass("Show")) {
		$.DispatchEvent("RemoveStyleFromEachChild", HUD.GAMES, "Activated");

		HUD.CONTEXT.SetHasClass("BGameFilterActivated", false);
		HUD.CONTEXT.SwitchClass("active_game", "");
	}

	HUD.CONTEXT.ToggleClass("Show");
};

(function () {
	const frame = GameEvents.NewProtectedFrame(HUD.CONTEXT);
	frame.SubscribeProtected("WebPromoEvents:update", CreatePromoEvents);

	GameUI.Inventory.RegisterForDefinitionsChanges(() => {
		GameEvents.SendToServerEnsured("WebPromoEvents:get_data", {});
	});
})();