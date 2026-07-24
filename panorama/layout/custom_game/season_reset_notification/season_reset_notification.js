--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


const CONTEXT = $.GetContextPanel();
const REWARDS_CONTAINER = $("#ResetRewardsContainer");
let INIT_FINISHED = false;
let DELAYED_INIT = undefined;

function SetStatus(status) {
	CONTEXT.SetHasClass("visible", status);
}

function GetRewardIcon(reward_name) {
	if (reward_name == "currency") return "file://{images}/custom_game/collection/currency_icon.png";

	return GameUI.Inventory.GetItemImagePath(reward_name);
}

function AddReward(reward_name, reward_amount) {
	const reward_panel = $.CreatePanel("Panel", REWARDS_CONTAINER, `season_reset_${reward_name}`);
	reward_panel.BLoadLayoutSnippet("reset_reward");

	reward_panel.SetDialogVariableInt("reward_amount", reward_amount);
	if (reward_name == "currency") reward_panel.AddClass("Reward_currency");
	else {
		reward_panel.FindChildTraverse("ResetRewardIcon").SetImage(GetRewardIcon(reward_name));
	}
	reward_panel.SwitchClass("rarity", GameUI.Inventory.GetItemRarityName(reward_name) || "COMMON");
	reward_panel.SwitchClass("slot", GameUI.Inventory.GetItemSlotName(reward_name) || "NONE");
	reward_panel.SetDialogVariableLocString("reward_name", reward_name);

	reward_panel.SetPanelEvent("onmouseover", () => {
		$.DispatchEvent("DOTAShowTextTooltip", reward_panel, $.Localize(reward_name));
	});
	reward_panel.SetPanelEvent("onmouseout", () => {
		$.DispatchEvent("DOTAHideTextTooltip");
	});
}

function SetSeasonResetStatus(event) {
	// $.Msg("SetSeasonResetStatus");
	// JSON.print(event);

	// if inventory has not initialized yet, delay season reset notification
	// as it relies on inventory to show rewards
	if (!INIT_FINISHED) {
		if (DELAYED_INIT !== undefined) DELAYED_INIT = $.CancelScheduled(DELAYED_INIT);
		DELAYED_INIT = $.Schedule(0.5, () => SetSeasonResetStatus(event));
		return;
	}

	const rewards = event.player_reset_rewards || {};
	const was_reset = rewards.currency !== undefined;

	SetStatus(was_reset);

	if (!was_reset) return;

	REWARDS_CONTAINER.RemoveAndDeleteChildren();

	if (rewards.currency > 0) {
		AddReward("currency", rewards.currency);
	}

	for (const [reward_name, reward_amount] of Object.entries(rewards.items || {})) {
		// $.Msg("adding reward", reward_name, " ", reward_amount);
		AddReward(reward_name, reward_amount);
	}

	CONTEXT.SetDialogVariableInt("season", event.season);
	CONTEXT.SetDialogVariableInt("new_rating", event.new_rating);
	CONTEXT.SetDialogVariableTime("next_reset_date", event.next_season_timestamp);

	CONTEXT.SetDialogVariable("map", $.Localize(Game.GetMapInfo().map_display_name));
}

(() => {
	SetStatus(false);

	const frame = GameEvents.NewProtectedFrame(CONTEXT);

	CONTEXT.AddClass(Game.GetMapInfo().map_display_name);

	frame.SubscribeProtected("SeasonReset:set_status", SetSeasonResetStatus);

	GameEvents.SendToServerEnsured("SeasonReset:get_status", {});

	GameUI.Inventory.RegisterForDefinitionsChanges(() => {
		INIT_FINISHED = true;
	});
})();