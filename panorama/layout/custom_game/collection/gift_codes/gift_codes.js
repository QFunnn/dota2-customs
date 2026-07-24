--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


const GC_UNWRAP_ROOT = $("#GC_Unwrap");
const GC_LIST = $("#GC_List");
const GC_INPUT = $("#GC_R_TextEntry");
const GC_INPUT_STATE = $("#GC_R_State");
const GC_PLAYERS_ROOT = $("#GC_SendPlayers_Root");
const GC_PLAYERS = $("#GC_SP_List");
const GC_PLAYERS_ARROW = $("#GC_SendPlayers_Arrow");
const GC_UNWRAP_LIST = $("#GC_U_Content_List");
const CONTEXT = $.GetContextPanel();
const GC_USED_SUCCESSFUL = 0;
const GC_USED_INCORRECT = 1;
const GC_USED_DUPLICATE = 2;

let focus_code_for_send;

function ConfirmUnwrap() {
	$.Msg("ConfirmUnwrap");
}

function HideSendingRootSchedule(b_forse_hide) {
	if ((GC_PLAYERS_ROOT.BHasHoverStyle() || GC_PLAYERS_ARROW.BHasHoverStyle()) && !b_forse_hide)
		$.Schedule(0, HideSendingRootSchedule);
	else {
		GameUI.ToggleSingleClassInParent(GC_PLAYERS, null, "BActive");
		GC_PLAYERS_ARROW.RemoveClass("Show");
		GC_PLAYERS_ROOT.RemoveClass("Show");
		GC_PLAYERS_ROOT.RemoveClass("BPlayerSelectedForGift");
	}
}

let hide_sending_panel_schedule;
function SetGiftCodes(data) {
	GC_LIST.RemoveAndDeleteChildren();
	Object.values(data.gift_codes).forEach((code_def) => {
		const code = $.CreatePanel("Panel", GC_LIST, "");
		code.BLoadLayoutSnippet("GiftCodeEntity");
		code.SetHasClass("BCodeRedeemed", !!code_def.is_redeemed);

		code_def.product = code_def.product || code_def.itemName;

		code.code_ent = code_def.code;
		code.sort_weight = Object.keys(GameUI.GetProducts()).indexOf(code_def.product) + code_def.is_redeemed * 1000;
		code.code = code_def.code
			.match(/\w{1,4}/g)
			.join("-")
			.toUpperCase();

		if (code_def.product.indexOf("subscription_tier_") > -1) code.AddClass(`SubTier_${code_def.product.slice(-1)}`);
		if (code_def.is_redeemed) code.FindChildTraverse("GCE_Redeemer").steamid = code_def.redeemer;

		code.SetDialogVariable("code", code.code.replace(/.{4}$/, "****"));
		code.SetDialogVariable("product_name", $.Localize(`#${code_def.product}`));

		const toggle_reveal = () => {
			code.ToggleClass("BCodeRevealed");
			code.SetDialogVariable(
				"code",
				code.BHasClass("BCodeRevealed") ? code.code : code.code.replace(/.{4}$/, "****"),
			);
		};
		code.FindChildTraverse("GCE_Reveal").SetPanelEvent("onactivate", toggle_reveal);
		code.FindChildTraverse("GCE_Hide").SetPanelEvent("onactivate", toggle_reveal);

		const code_value = code.FindChildTraverse("GCE_Code_Value");
		code_value.SetPanelEvent("onactivate", () => {
			if (code_def.is_redeemed) return;

			$.DispatchEvent("CopyStringToClipboard", code.code, null);
			$.DispatchEvent("DOTAShowTextTooltip", code_value, $.Localize("#gift_code_copied"));
			$.Schedule(0.45, () => {
				$.DispatchEvent("DOTAHideTextTooltip");
			});
		});
		code.FindChildTraverse("GCE_Reclaim").SetPanelEvent("onactivate", () => {
			if (code_def.is_redeemed) return;
			GameEvents.SendToServerEnsured("GiftCodes:redeem", {
				gift_code: code.code_ent,
			});
		});

		const send_buton = code.FindChildTraverse("GCE_Send");
		send_buton.SetPanelEvent("onactivate", () => {
			if (code_def.is_redeemed) return;
			if (hide_sending_panel_schedule) $.CancelScheduled(hide_sending_panel_schedule);

			focus_code_for_send = code;
			GC_PLAYERS_ROOT.AddClass("Show");
			GC_PLAYERS_ARROW.AddClass("Show");

			const update_sending_panel_pos = () => {
				if (GC_PLAYERS_ROOT.actuallayoutheight == 0) $.Schedule(0, update_sending_panel_pos);
				const pos = send_buton.GetPositionWithinWindow();
				const x_scale = send_buton.actualuiscale_x;
				const y_scale = send_buton.actualuiscale_y;

				const send_x_pos = Math.round(pos.x + send_buton.actuallayoutwidth / x_scale);

				const root_pos_x = send_x_pos + GC_PLAYERS_ARROW.actuallayoutwidth / x_scale;
				let root_pos_y = Math.round(pos.y - 30);

				const y_off_screen = Game.GetScreenHeight() - GC_PLAYERS_ROOT.actuallayoutheight - root_pos_y - 10;
				root_pos_y += Math.min(y_off_screen, 0);

				GC_PLAYERS_ROOT.style.position = `${root_pos_x}px ${root_pos_y}px 0px`;

				GC_PLAYERS_ARROW.style.position = `${send_x_pos}px ${Math.round(
					pos.y - (GC_PLAYERS_ARROW.actuallayoutheight - send_buton.actuallayoutheight) / 2 / y_scale,
				)}px 0px`;
			};
			update_sending_panel_pos();
		});
		send_buton.SetPanelEvent("onmouseout", () => {
			hide_sending_panel_schedule = $.Schedule(0.35, () => {
				hide_sending_panel_schedule = undefined;
				HideSendingRootSchedule();
			});
		});
	});

	for (const item of GC_LIST.Children().sort((a, b) => {
		return b.sort_weight - a.sort_weight;
	})) {
		GC_LIST.MoveChildBefore(item, GC_LIST.GetChild(0));
	}
}
function ToggleHint(name) {
	CONTEXT.ToggleClass(`BShowHint_${name}`);
}

function RedeemNewCode() {
	const code = GC_INPUT.text;
	if (!code.search(/(\w{4}-){4}\w{4}/)) {
		GameEvents.SendToServerEnsured("GiftCodes:redeem", {
			gift_code: code.replace(/-/g, "").toLowerCase(),
			is_external_code: true,
		});
	} else GiftCodeUsed(GC_USED_INCORRECT);
}

let focus_player_id_for_send;
function FillPlayerForSending() {
	GC_PLAYERS.RemoveAndDeleteChildren();

	let b_first_player = false;
	for (let player_id = 0; player_id <= 24; player_id++) {
		const player_info = Game.GetPlayerInfo(player_id);
		if (!player_info) return;

		const player = $.CreatePanel("Button", GC_PLAYERS, "");
		player.BLoadLayoutSnippet("GC_Player");
		if (!b_first_player) {
			b_first_player = true;
			player.AddClass("BFirstPlayer");
		}

		if (player_info.player_steamid && player_info.player_steamid > 0) {
			player.FindChildTraverse("GC_P_Avatar").steamid = player_info.player_steamid;

			const player_name = player.FindChildTraverse("GC_P_Name");
			player_name.steamid = player_info.player_steamid;
			player_name.GetChild(0).hittest = false;
		} else player.AddClass("NoSteamID");

		player.SetDialogVariableLocString("hero_name", player_info.player_selected_hero);

		player.SetPanelEvent("onactivate", () => {
			GameUI.ToggleSingleClassInParent(GC_PLAYERS, player, "BActive");
			GC_PLAYERS_ROOT.AddClass("BPlayerSelectedForGift");

			focus_player_id_for_send = player_id;
		});
	}
}
function SendGiftCodeToPlayer() {
	if (!focus_code_for_send) return;
	if (focus_player_id_for_send == undefined) return;

	HideSendingRootSchedule(true);
	$.Msg(`Send: ${focus_code_for_send.code_ent} to player: [${focus_player_id_for_send}]`);

	GameEvents.SendToServerEnsured("GiftCodes:send", {
		gift_code: focus_code_for_send.code_ent,
		target_id: focus_player_id_for_send,
	});
}

function GiftCodeUsed(type) {
	GC_INPUT_STATE.AddClass("Show");
	GC_INPUT_STATE.SwitchClass("type", `State_${type}`);
	GC_INPUT_STATE.SetDialogVariableLocString("gc_redeem_state", `gift_code_used_${type}`);
}
function UnwrapCode(data) {
	GiftCodeUsed(data.type);

	if (!data.redeemed_rewards) return;

	GameUI.Collection.OpenSubPanel("GC_Unwrap");
	GC_UNWRAP_LIST.Children().forEach((p) => {
		p.SetHasClass("Show", false);
	});

	if (data.redeemed_rewards.currency) {
		const currency_root = GC_UNWRAP_LIST.FindChild(`GC_UP_currency`);
		currency_root.SetHasClass("Show", true);
		currency_root.SetDialogVariable("gc_up_count", data.redeemed_rewards.currency);
		currency_root.AddClass("BManyItems");
	}
	if (data.redeemed_rewards.subscription) {
		const sub_tier = data.redeemed_rewards.subscription;
		const sub_root = GC_UNWRAP_LIST.FindChild(`GC_UP_sub_${sub_tier}`);
		sub_root.SetHasClass("Show", true);
	}
	if (data.redeemed_rewards.items) {
		Object.values(data.redeemed_rewards.items).forEach((item_data, idx) => {
			const item_root = GC_UNWRAP_LIST.FindChild(`GC_UP_Item_${idx}`);
			if (!item_root) return;

			item_root.SetDialogVariableLocString("filler_name", item_data.name);
			item_root.SetDialogVariable("gc_up_count", item_data.count || 0);
			item_root.FindChildTraverse("GC_UP_Image").SetImage(GameUI.Inventory.GetItemImagePath(item_data.name));

			const chat_wheel_details = GameUI.Inventory.GetItemDefinition(item_data.name)?.chat_wheel_details;
			if (chat_wheel_details) GameUI.FillChatWheelContent(item_data.name, item_root);

			const b_many_items = item_data.count && item_data.count > 1;

			item_root.SetHasClass("BManyItems", b_many_items);
			item_root.SetHasClass("Show", true);
			item_root.SwitchClass("rarity", GameUI.Inventory.GetItemRarityName(item_data.name));
		});
	}
}

function FillBasicUnwrapProducts() {
	GC_UNWRAP_LIST.RemoveAndDeleteChildren();

	let add_filler_product = (name, rarity) => {
		const currency_unwrap = $.CreatePanel("Panel", GC_UNWRAP_LIST, `GC_UP_${name}`);
		currency_unwrap.BLoadLayoutSnippet("GC_Unwrap_Product");
		currency_unwrap.SwitchClass("rarity", rarity || "COMMON");
		currency_unwrap.SetDialogVariableLocString("filler_name", name);
	};
	add_filler_product("currency");
	add_filler_product("sub_1", "RARE");
	add_filler_product("sub_2", "IMMORTAL");

	for (let filler_item_idx = 0; filler_item_idx <= 12; filler_item_idx++)
		add_filler_product(`Item_${filler_item_idx}`);

	GameUI.Collection.AddSubPanel(GC_UNWRAP_ROOT);
}
function HideIncorrectCode() {
	GC_INPUT_STATE.RemoveClass("Show");
}

GameUI.GetGiftCodes = () => {
	if (CONTEXT.BHasClass("BGetCodesCooldown")) return;

	CONTEXT.AddClass("BGetCodesCooldown");
	GameEvents.SendToServerEnsured("GiftCodes:get_data", {});

	$.Schedule(30, () => {
		CONTEXT.RemoveClass("BGetCodesCooldown");
	});
};

(() => {
	HideIncorrectCode();
	FillPlayerForSending();

	const frame = GameEvents.NewProtectedFrame($.GetContextPanel());
	frame.SubscribeProtected("GiftCodes:set_data", SetGiftCodes);
	frame.SubscribeProtected("GiftCodes:code_used", UnwrapCode);

	FillBasicUnwrapProducts();
	GameUI.Collection.AddAdditionalPanel(GC_PLAYERS_ROOT);
	GameUI.Collection.AddAdditionalPanel(GC_PLAYERS_ARROW);
})();