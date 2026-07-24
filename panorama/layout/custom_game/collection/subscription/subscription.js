--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


GameUI.Subscriptions = GameUI.Subscriptions || {};
const CS_LIST = $("#CS_SubscriptionPanels");

GameUI.Subscriptions.CreateSubsciption = () => {
	const sub_panel = $.CreatePanel("Panel", CS_LIST, "");
	sub_panel.BLoadLayoutSnippet("C_Subscription");
	sub_panel.SetDialogVariableLocString("sub_unlock_state", "sub_unlock");

	sub_panel.FindChildTraverse("CS_MainPanel").SetPanelEvent("onactivate", function () {
		sub_panel.ToggleClass("BShowBonuses");
		Game.EmitSound("collection.flip");
	});
	return sub_panel;
};

GameUI.Subscriptions.OpenAllSubscriptionBonuses = () => {
	CS_LIST.Children().forEach((s) => {
		s.AddClass("BShowBonuses");
	});
};

function OpenManageSubscription() {
	GameEvents.SendToServerEnsured("WebPayments:get_customer_portal_url", {});
}

function OpenResolveErrorsSubscription() {
	const subscription_data = GameUI.Player.GetSubscriptionData() || {};
	if (!subscription_data.metadata || !subscription_data.metadata.fail_reason) return;

	const fail_details = subscription_data.metadata.fail_reason;
	if (!fail_details.hosted_invoice_url) return;

	$.DispatchEvent("ExternalBrowserGoToURL", fail_details.hosted_invoice_url);
}

function CancelSubscription() {
	GameEvents.SendToServerEnsured("WebPayments:cancel_subscription", {});
}

function UpdateSubscriptionLabels(player_data) {
	let sub_tier = 0;
	if (player_data.subscription && player_data.subscription.tier != undefined)
		sub_tier = player_data.subscription.tier;

	CS_LIST.Children().forEach((panel, idx) => {
		panel.SetDialogVariableLocString("sub_unlock_state", sub_tier > idx ? "sub_extend" : "sub_unlock");
	});
}

(() => {
	CS_LIST.RemoveAndDeleteChildren();
	GameUI.Collection.InitSubscriptionConf();
	GameUI.Player.RegisterForPlayerDataChanges(UpdateSubscriptionLabels);
})();