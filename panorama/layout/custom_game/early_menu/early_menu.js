--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 0b85d8d 
  ~ auto-generated — do not edit
]]


const HUD = {
	CONTEXT: $.GetContextPanel(),
	FOOTER: $("#EC_KL_Footer").GetChild(0),
	CHAT_WHEEL_HINT: $("#EC_I_ChatWheelHint"),
};

let mmr_token_already_used = false;
let current_items_count = {};

function DoubleRankRequest() {
	if (!HUD.CONTEXT.BHasClass("ShowItems") || mmr_token_already_used || HUD.CONTEXT.BHasClass("BPlayerUsedDoubleMMR"))
		return;
	if (!HUD.CONTEXT.BHasClass("BLocalPlayerHas_double_mmr_token")) return;

	GameUI.Inventory.ConsumeItem("double_mmr_token", 1);

	mmr_token_already_used = true;
}

function HideEarlyConsumablesMenu() {
	HUD.CONTEXT.SetHasClass("ShowItems", false);
}

function ShowEarlyConsumablesMenu() {
	HUD.CONTEXT.SetHasClass("ShowItems", true);
}

function FillConfig() {
	HUD.CONTEXT.SetDialogVariable("double_mmr_token_costs", DOUBLE_MMR_TOKEN_CONFIG.TOKEN_COSTS);
}

function _RegisterItem(item_name) {
	const panel = $.CreatePanel("Button", HUD.FOOTER, "");
	panel.BLoadLayoutSnippet("EC_Footer_Item");
	panel.SetPanelEvent("onactivate", () => {
		GameUI.Cosmetics.OpenSpecificCollectionTab("MISC", item_name);
	});

	panel.SetDialogVariableLocString("item_name", item_name);

	let items_count = GameUI.Inventory.GetItemCount(item_name);

	panel.FindChildTraverse("EC_FI_Image").SetImage(`file://{images}/custom_game/collection/${item_name}_icon.png`);
	panel.SetDialogVariable("items_count", Math.max(items_count, 0));

	HUD.CONTEXT.SetHasClass(`BLocalPlayerHas_${item_name}`, items_count > 0);
	current_items_count[item_name] = items_count;
}

function RegisterItemsCount() {
	HUD.FOOTER.RemoveAndDeleteChildren();

	_RegisterItem("double_mmr_token");
}

function CloseItemsMenu() {
	GameEvents.SendToServerEnsured("early_consumables:close_ui", {});
	HideEarlyConsumablesMenu();
}

let b_support_menu_closed_manually = false;
function HideSupportMenu(closed_manually = false) {
	if (closed_manually) b_support_menu_closed_manually = true;

	HUD.CONTEXT.SetHasClass("BHideSupport", true);
}

let time_limit;
function UpdateTimeLimit() {
	const time_now = Game.GetDOTATime(false, false);

	if (time_now < time_limit) return void $.Schedule(0.5, UpdateTimeLimit);

	HideSupportMenu();
	HideEarlyConsumablesMenu();
}

function UpdateEarlyConsumablesMenuState(data) {
	const is_player_used_double_mmr = data.is_player_used_double_mmr == 1;
	// const no_double_tokens = current_items_count?.double_mmr_token <= 0;

	HUD.CONTEXT.SetHasClass("BPlayerUsedDoubleMMR", is_player_used_double_mmr);

	if (time_limit == undefined) {
		time_limit = data.time_limit;
		UpdateTimeLimit();
	}

	HUD.CONTEXT.SetHasClass("ShowItems", !is_player_used_double_mmr);
}

function InjectChatWheelKeybind() {
	$.CreatePanel("Label", HUD.CHAT_WHEEL_HINT, "ChatWheelKeybind", {
		text: "L",
	});
}

function OpenCollection() {
	GameUI.Collection.OpenSpecificTab("subscription");
}

let is_has_supp_level = false;
function UpdateVisibleState() {
	const stats = CustomNetTables.GetTableValue("game_state", "player_stats");
	let games = (stats?.[LOCAL_PLAYER_ID]?.wins || 0) + (stats?.[LOCAL_PLAYER_ID]?.loses || 0);
	HUD.CONTEXT.SetHasClass("BProPlayer", games > 15);
	HUD.CONTEXT.SetHasClass("BHideSupport", is_has_supp_level || games < 15);

	if (Game.GameStateIsAfter(DOTA_GameState.DOTA_GAMERULES_STATE_PRE_GAME) || b_support_menu_closed_manually)
		HideSupportMenu();
}

(() => {
	HideEarlyConsumablesMenu();
	HideSupportMenu();

	if (IsSpectating()) return;
	if (MAP_NAME == "dota_tournament") return;

	FillConfig();

	const frame = GameEvents.NewProtectedFrame(HUD.CONTEXT);

	frame.SubscribeProtected("early_consumables:update_state", UpdateEarlyConsumablesMenuState);
	GameEvents.SendToServerEnsured("early_consumables:get_state", {});

	GameUI.Inventory.RegisterForInventoryChanges(RegisterItemsCount);

	GameUI.Player.RegisterForPlayerDataChanges(() => {
		const supp_level = GameUI.Player.GetSubscriptionTier();
		is_has_supp_level = supp_level > 0;
		UpdateVisibleState();

		GameEvents.Subscribe("game_rules_state_change", UpdateVisibleState);
	});

	InjectChatWheelKeybind();
})();