--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


const HUD = {
	CONTEXT: $.GetContextPanel(),
	FOOTER: $("#EC_KL_Footer").GetChild(0),
};

let kl_already_voted = false;
let mmr_token_already_used = false;
let current_items_count = {};

function KL_Vote(type) {
	if (!HUD.CONTEXT.BHasClass("Show") || kl_already_voted || HUD.CONTEXT.BHasClass("BPlayerVotedKL")) return;
	if (type == KILL_VOTING_CONFIG.TYPE_TOKEN && !HUD.CONTEXT.BHasClass("BLocalPlayerHas_bp_gg_token")) return;

	switch (type) {
		case KILL_VOTING_CONFIG.TYPE_DEFAULT:
			GameEvents.SendToServerEnsured("early_consumables:vote_additional_kl_goal", {});
			break;
		case KILL_VOTING_CONFIG.TYPE_TOKEN:
			GameUI.Inventory.ConsumeItem("bp_gg_token", KILL_VOTING_CONFIG.TOKEN_COSTS);
			break;
	}

	kl_already_voted = true;
}

function DoubleRankRequest() {
	if (!HUD.CONTEXT.BHasClass("Show") || mmr_token_already_used || HUD.CONTEXT.BHasClass("BPlayerUsedDoubleMMR"))
		return;
	if (!HUD.CONTEXT.BHasClass("BLocalPlayerHas_double_mmr_token")) return;

	GameUI.Inventory.ConsumeItem("double_mmr_token", DOUBLE_MMR_TOKEN_CONFIG.TOKEN_COSTS);

	mmr_token_already_used = true;
}

function HideEarlyConsumablesMenu() {
	HUD.CONTEXT.SetHasClass("Show", false);
}

function ShowEarlyConsumablesMenu() {
	HUD.CONTEXT.SetHasClass("Show", true);
}

function FillConfig() {
	HUD.CONTEXT.SetDialogVariable("default_kl_value", KILL_VOTING_CONFIG.DEFAULT);
	HUD.CONTEXT.SetDialogVariable("token_kl_value", KILL_VOTING_CONFIG.TOKEN_KL);
	HUD.CONTEXT.SetDialogVariable("kl_token_costs", KILL_VOTING_CONFIG.TOKEN_COSTS);
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

	_RegisterItem("bp_gg_token");
	_RegisterItem("double_mmr_token");
}

function CloseMenu() {
	GameEvents.SendToServerEnsured("early_consumables:close_ui", {});
	HideEarlyConsumablesMenu();
}

let time_limit;
function UpdateTimeLimit() {
	const time_now = Game.GetDOTATime(false, false);

	if (time_now < time_limit) return void $.Schedule(0.5, UpdateTimeLimit);

	HideEarlyConsumablesMenu();
}

function UpdateEarlyConsumablesMenuState(data) {
	const is_player_voted_kl = data.player_vote_kl != 0;
	const is_player_used_double_mmr = data.is_player_used_double_mmr == 1;
	const no_double_tokens = current_items_count?.double_mmr_token <= 0;

	HUD.CONTEXT.SetHasClass("BPlayerVotedKL", is_player_voted_kl);
	HUD.CONTEXT.SetHasClass("BPlayerUsedDoubleMMR", is_player_used_double_mmr);
	HUD.CONTEXT.SwitchClass("PlayerKLVoteType", `PlayerKLVoteType_${data.player_vote_kl}`);

	if (time_limit == undefined) {
		time_limit = data.time_limit;
		UpdateTimeLimit();
	}

	if (is_player_voted_kl && (is_player_used_double_mmr || no_double_tokens)) HideEarlyConsumablesMenu();
	else ShowEarlyConsumablesMenu();
}

(() => {
	HideEarlyConsumablesMenu();

	if (IsSpectating()) return;
	if (Game.GetMapInfo().map_display_name === "ot3_demo") return;

	FillConfig();

	const frame = GameEvents.NewProtectedFrame(HUD.CONTEXT);

	frame.SubscribeProtected("early_consumables:update_state", UpdateEarlyConsumablesMenuState);
	GameEvents.SendToServerEnsured("early_consumables:get_state", {});

	GameUI.Inventory.RegisterForInventoryChanges(RegisterItemsCount);
})();