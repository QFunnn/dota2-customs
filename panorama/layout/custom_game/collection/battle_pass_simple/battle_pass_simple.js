--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build b9dc48c · 2026-08-02 17:42:46 UTC
  ~ auto-generated — do not edit
]]


GameUI.Battlepass = GameUI.Battlepass || {};

const CONTEXT = $.GetContextPanel();
const EXP_PROGRESS = $("#BP_Levels_Progress_Container_BG_SimpleProgress");
const REWARDS_CONTAINER = $("#BP_SimpleRewards");
const BP_DEF = {
	EXP_PLAY: 500,
	EXP_WIN: 1000,
	REWARDS_PER_LEVEL: {
		currency: 1000,
		// aura_green_1: 1,
	},
};

function UpdatePlayerData(data) {
	UpdateExpProgress(data?.bp_player_data?.current_exp || 0, 10000);
	UpdateExpLimits(data?.bp_player_data?.earned_exp || 0, 10000);
	CONTEXT.SetDialogVariable("bp_level", data?.bp_player_data?.level || 0);
}

function UpdateExpProgress(current, target) {
	CONTEXT.SetDialogVariable("current_exp", FormatBigNumber(current));
	CONTEXT.SetDialogVariable("target_exp", FormatBigNumber(target));
	EXP_PROGRESS.value = current / target;
}
function UpdateExpLimits(earned, max) {
	CONTEXT.SetDialogVariable("daily_limit_earned", FormatBigNumber(earned));
	CONTEXT.SetDialogVariable("daily_limit_max", FormatBigNumber(max));
}

function CreateRewardsPerLevel() {
	REWARDS_CONTAINER.RemoveAndDeleteChildren();

	for (const [item_name, count] of Object.entries(BP_DEF.REWARDS_PER_LEVEL)) {
		const item = $.CreatePanel("Panel", REWARDS_CONTAINER, ``);
		item.BLoadLayoutSnippet("BP_Item");

		item.AddClass("BFilled");
		if (item_name == "currency") item.AddClass("BHasCurrencyRewards");

		const bp_image = item.FindChildTraverse("BP_ItemImage");

		let items_for_tooltip = {};

		if (item_name != "currency") {
			items_for_tooltip = { [item_name]: count || 0 };
			item.AddClass("BHasItemsRewards");
			bp_image.SetImage(GameUI.Inventory.GetItemImagePath(item_name));
		}

		item.SetHasClass("BManyItems", count > 1);
		item.SetDialogVariableInt("count", count);

		let rarity = GameUI.Inventory.GetItemRarity(item_name) || 1;

		item.SwitchClass("rarity", GameUI.Inventory.GetRarityName(rarity));
		item.SetPanelEvent("onmouseover", () => {
			$.DispatchEvent(
				"UIShowCustomLayoutParametersTooltip",
				item,
				"CustomItem_Tooltip",
				"file://{resources}/layout/custom_game/collection/item_tooltip/item_tooltip.xml",

				BuildTooltipParams({
					currency: item_name == "currency" ? count : 0,
					items: items_for_tooltip,
					custom_count: count,
				}),
			);
		});

		item.SetPanelEvent("onmouseout", () => {
			$.DispatchEvent("UIHideCustomLayoutTooltip", item, "CustomItem_Tooltip");
		});
	}
}

(() => {
	CreateRewardsPerLevel();
	UpdateExpProgress(0, 10000);
	CONTEXT.SetDialogVariable("bp_level", 0);
	CONTEXT.SetDialogVariable("exp_per_play", FormatBigNumber(BP_DEF.EXP_PLAY));
	CONTEXT.SetDialogVariable("exp_per_win", FormatBigNumber(BP_DEF.EXP_WIN));
	CONTEXT.SetDialogVariable("currency_per_level", FormatBigNumber(BP_DEF.REWARDS_PER_LEVEL.currency));

	CONTEXT.SetHasClass("BAvailableTier_1", true);

	GameUI.Inventory.RegisterForDefinitionsChanges(() => {
		GameEvents.SendToServerEnsured("BattlePass:get_player_data", {});
	});

	const frame = GameEvents.NewProtectedFrame(CONTEXT);

	frame.SubscribeProtected("BattlePass:update", UpdatePlayerData);
})();