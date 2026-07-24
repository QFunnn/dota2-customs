--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


const CONTEXT = $.GetContextPanel();
const DEFAULT_DURATION = 30;

// overrides for toast snippets
// for cases when specific snippet needs different panel
const TOAST_SNIPPETS_OVERRIDE = {
	player_tip: "player_tip",
	sub_trial_available: "sub_trial_available",
};

let current_toasts_schedules = {};
let current_toast_id = 0;

function RemoveToast(toast, id) {
	if (current_toasts_schedules[id]) {
		current_toasts_schedules[id] = $.CancelScheduled(current_toasts_schedules[id]);
	}
	if (toast) {
		toast.SetHasClass("Active", false);
		toast.DeleteAsync(0.35);
	}
}

function PrepareToast(toast, event, toast_id) {
	const image = toast.FindChildTraverse("ToastImage");
	let duration = DEFAULT_DURATION;
	let toast_image_src;

	switch (event.toast_type) {
		case "mail_incoming": {
			toast.SetDialogVariable("topic", $.Localize(event.data.topic));
			toast.SetDialogVariable("source", $.Localize(event.data.source));

			Game.EmitSound("WeeklyQuest.StarGranted");

			toast.SetPanelEvent("onactivate", () => {
				GameUI.OpenMailWithId(event.data.id);
				RemoveToast(toast, toast_id);
			});
			toast_image_src = "file://{images}/custom_game/mail/mail_gold.png";
			break;
		}
		case "payment_success": {
			Game.EmitSound("WeeklyQuest.ClaimReward");
			const product_name = event.data.product_name;
			let product_name_localized = $.Localize(`#${product_name}`);
			if (event.data.quantity > 1) {
				product_name_localized = `${product_name_localized} - x${event.data.quantity}`;
			}
			if (event.data.gift_codes) {
				const gift_code_prefix_localized = $.Localize("#toast_gift_code_prefix");
				product_name_localized = `${gift_code_prefix_localized} ${product_name_localized}`;
			}
			toast.SetDialogVariable("product_name", product_name_localized);
			toast_image_src = GameUI.GetProductIcon(product_name);
			toast.SetPanelEvent("onactivate", () => {
				GameUI.Collection.OpenSpecificTab("gift_codes");
				RemoveToast(toast, toast_id);
			});
			break;
		}
		case "payment_fail": {
			const product_name = event.data.product_name;
			toast.SetDialogVariable("product_name", $.Localize(`#${product_name}`));
			toast.SetPanelEvent("onactivate", () => {
				$.DispatchEvent("ExternalBrowserGoToURL", event.data.hosted_invoice_url);
				RemoveToast(toast, toast_id);
			});
			toast_image_src = GameUI.GetProductIcon(product_name);
			break;
		}
		case "player_tip": {
			Game.EmitSound("General.Coins");
			toast.SetDialogVariableInt("value", event.data.currency);

			const source_player_info = Game.GetPlayerInfo(event.data.source_player_id);
			const target_player_info = Game.GetPlayerInfo(event.data.target_player_id);

			const source_container = toast.GetChild(0);
			source_container
				.GetChild(0)
				.SetImage(GetPortraitImage(event.data.source_player_id, source_player_info.player_selected_hero));
			source_container.GetChild(1).steamid = source_player_info.player_steamid;

			const target_container = toast.GetChild(2);
			target_container
				.GetChild(0)
				.SetImage(GetPortraitImage(event.data.target_player_id, target_player_info.player_selected_hero));
			target_container.GetChild(1).steamid = target_player_info.player_steamid;

			// override max duration to avoid screen clutter
			duration = 6;
			break;
		}
		case "gift_code_sent": {
			Game.EmitSound("WeeklyQuest.ClaimReward");

			const product_name = event.data.gift_code.product_name;
			toast.SetDialogVariable("product_name", $.Localize(`#${product_name}`));

			const gifter = Game.GetPlayerInfo(event.data.gifter);
			toast.SetDialogVariable("gifter_name", gifter.player_name);

			toast_image_src = GameUI.GetProductIcon(product_name);

			toast.SetPanelEvent("onactivate", () => {
				GameUI.Collection.OpenSpecificTab("cosmetics");
				RemoveToast(toast, toast_id);
			});
			break;
		}
		case "sub_trial_available": {
			toast_image_src = GameUI.Inventory.GetItemImagePath("bp_sub_tier_2_consumable");

			const accept_button = toast.FindChildTraverse("AcceptButton");
			const decline_button = toast.FindChildTraverse("DeclineButton");

			accept_button.SetPanelEvent("onactivate", () => {
				GameUI.Inventory.ConsumeItem("bp_sub_tier_2_consumable");
				RemoveToast(toast, toast_id);
			});

			decline_button.SetPanelEvent("onactivate", () => {
				RemoveToast(toast, toast_id);
			});

			break;
		}
		case "sub_trial_started": {
			toast_image_src = GameUI.Inventory.GetItemImagePath("bp_sub_tier_2_consumable");

			toast.SetPanelEvent("onactivate", () => {
				GameUI.Collection.OpenSpecificTab("subscription");
				RemoveToast(toast, toast_id);
			});
			break;
		}
		case "promo_claim_available": {
			toast_image_src = "file://{images}/custom_game/promo_events/button_with_bg.png";

			toast.SetPanelEvent("onactivate", () => {
				GameUI.ToggleCustomPromoEvents(true);
			});
			break;
		}
	}

	if (image) {
		image.SetImage(toast_image_src);
	}

	toast.SetDialogVariable("toast_header", $.Localize(`#toast_${event.toast_type}`, toast));
	toast.SetDialogVariable("toast_description", $.Localize(`#toast_${event.toast_type}_description`, toast));

	toast.SetHasClass("Active", true);
	toast.AddClass(event.toast_type);

	current_toasts_schedules[current_toast_id] = $.Schedule(duration, () => {
		RemoveToast(toast, current_toast_id);
	});
}

function GetToastSnippet(toast_type) {
	const snippet_override = TOAST_SNIPPETS_OVERRIDE[toast_type];
	return snippet_override ? snippet_override : "toast";
}

function NewToast(event) {
	// $.Msg("NewToast");
	// JSON.print(event);
	if (!event.toast_type) return;

	const toast = $.CreatePanel("Panel", CONTEXT, `${current_toast_id}`);
	toast.BLoadLayoutSnippet(GetToastSnippet(event.toast_type));

	// bind to local variable so that anon function later can capture it in current state
	// otherwise it will use future ongoing id instead of this one
	let toast_id = current_toast_id;

	const close_button = toast.FindChild("CloseButton");
	if (close_button) {
		close_button.SetPanelEvent("onactivate", () => {
			RemoveToast(toast, toast_id);
		});
	}

	PrepareToast(toast, event, current_toast_id);

	current_toast_id++;
}

(() => {
	const frame = GameEvents.NewProtectedFrame("toast_notifications");
	frame.SubscribeProtected("Toasts:new", NewToast);

	CONTEXT.RemoveAndDeleteChildren();
})();