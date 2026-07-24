--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


const CONTEXT = $.GetContextPanel();
const TABS_ROOT = $("#CC_Tabs");
const CONTENT_ROOT = $("#CC_ContentRoot");
const SORT_SELECTOR = $("#CC_SortingOptions");
const PURCHASING_BY_CURRENCY = $("#CI_PayByCurrency");
const ITEM_USE_CONFIRM = $("#CI_ItemUseCheckerConfirm");
const ITEM_USE_CONFIRM_IMAGE = $("#CI_ItemUseChecker_Item");

const PURCHASING_BY_CURRENCY_EMOJI_CONTAINER = $("#CI_ChatWheelContent_Emoji");
const PURCHASING_BY_CURRENCY_COLOR_LABEL = $("#CI_ChatWheelContent_ColorLabel");
const PURCHASING_BY_CURRENCY_DEC = PURCHASING_BY_CURRENCY.FindChildTraverse("Dec");
const PURCHASING_BY_CURRENCY_INC = PURCHASING_BY_CURRENCY.FindChildTraverse("Inc");

const TREASURES_PREVIEW = $("#CI_Treasure_Preview");
const TREASURES_PREVIEW_ROOT = $("#CI_Treasure_Preview_List");
const TREASURES_PREVIEW_CONF_BUTTON = $("#CI_Treasure_Preview_ConfirmButton");

const WHEEL_LIST = $("#CI_Wheel_List");

GameUI.Cosmetics = {};

let current_items_count = 0;
let current_item_for_purchaing;
function PurchasingByCurrencyUpdate(change) {
	if (GameUI.IsShiftDown()) change *= 5;
	if (GameUI.IsAltDown()) change *= 10;
	if (GameUI.IsControlDown()) change *= 50;
	const max_items = Math.floor(GameUI.Player.GetCurrency() / PURCHASING_BY_CURRENCY.price);

	current_items_count = Math.clamp(current_items_count + change, 1, max_items);
	PURCHASING_BY_CURRENCY.SetDialogVariableInt("items_count", current_items_count);
	PURCHASING_BY_CURRENCY.SetDialogVariable(
		"currency",
		FormatBigNumber(current_items_count * PURCHASING_BY_CURRENCY.price),
	);

	PURCHASING_BY_CURRENCY_DEC.SetHasClass("Block", current_items_count == 1);
	PURCHASING_BY_CURRENCY_INC.SetHasClass("Block", current_items_count == max_items);
}

const BASE_ACTIONS = {
	currency: (item) => {
		if (item.source_value > GameUI.Player.GetCurrency()) {
			GameUI.Collection.OpenSubPanel("C_PayCurrency");
			return;
		}

		PURCHASING_BY_CURRENCY.SwitchClass("slot_name", item.slot_name);
		PURCHASING_BY_CURRENCY.SwitchClass("rarity", item.rarity_name);
		PURCHASING_BY_CURRENCY.SwitchClass("item_name", item.item_name);

		PURCHASING_BY_CURRENCY.SetHasClass("BConsumables", item.BHasClass("BConsumables"));
		PURCHASING_BY_CURRENCY.FindChildTraverse("CI_PayByCurrency_Item").SetImage(item.image_path || "");

		PURCHASING_BY_CURRENCY.SwitchClass("chat_wheel_content", "BChatWheel_None");

		FillChatWheelBasedContent(
			PURCHASING_BY_CURRENCY,
			item.phrase_name,
			item.color_name,
			item.emoji_name ? W_TYPE_DEF_GETTERS[W_TYPE.EMOJIES](item.emoji_name) : undefined,
			item.phrase_name,
			item.color_name,
			PURCHASING_BY_CURRENCY_COLOR_LABEL,
			PURCHASING_BY_CURRENCY_EMOJI_CONTAINER,
		);

		PURCHASING_BY_CURRENCY.price = item.source_value;
		current_items_count = 1;
		current_item_for_purchaing = item.item_name;
		PurchasingByCurrencyUpdate(0);

		const loc_key_details = `${item.item_name}_detailed_description`;
		const loc_line_details = $.Localize(loc_key_details);

		PURCHASING_BY_CURRENCY.SetDialogVariable("detailed_desc", loc_line_details);
		PURCHASING_BY_CURRENCY.SetHasClass("BItemHasDetailedDescription", loc_key_details != loc_line_details);

		Game.EmitSound("collection.buy_currency");
		GameUI.Collection.OpenSubPanel("CI_PayByCurrency");
	},
	subscription_tier: (item) => {
		Game.EmitSound("Item.DropGemShop");
		GameUI.Collection.OpenSubPanel("PaySubscriptionConf_Root");
	},
	treasure: (item) => {
		GameUI.Collection.OpenSpecificTab("cosmetics");
		OpenTreasureTabWithGlow(item.source_value);
	},
};
GameUI.Collection.PurchaseCosmeticItem = (panel) => {
	const def = panel?.source_def;
	if (!def) return;

	["currency", "treasure"].some((type) => {
		if (!def?.[type]) return false;

		panel.source_value = def[type];
		BASE_ACTIONS[type](panel);
		return true;
	});
};

let consume_item_with_confirm;
const OWNED_ACTIONS = {
	[GameUI.Inventory.GetTypesDefinition().EQUIPMENT]: (item) => {
		if (HUD.CONTEXT.BHasClass("EquipCooldown")) return;
		HUD.CONTEXT.AddClass("EquipCooldown");
		$.Schedule(0.15, () => {
			HUD.CONTEXT.RemoveClass("EquipCooldown");
		});

		if (item.BHasClass("BEquipped")) GameUI.Inventory.UnequipItem(item.item_name);
		else GameUI.Inventory.EquipItem(item.item_name);
	},
	[GameUI.Inventory.GetTypesDefinition().CONSUMABLE]: (item) => {
		const item_name = item.item_name;
		if (!item_name) return;

		if (CONSUMABLE_NEED_CONFIRM[item_name]) {
			consume_item_with_confirm = item;

			ITEM_USE_CONFIRM.SetDialogVariableLocString(
				"item_use_checker_text",
				`${item_name}_confirm_${CONSUMABLE_NEED_CONFIRM[item_name]() ? 1 : 0}`,
			);

			ITEM_USE_CONFIRM.SwitchClass("rarity", item.rarity_name);
			ITEM_USE_CONFIRM_IMAGE.SetImage(item.image_path);

			GameUI.Collection.OpenSubPanel("CI_ItemUseCheckerConfirm");
		} else GameUI.Inventory.ConsumeItem(item_name);
	},
};
function ConfirmConsumeItem() {
	if (consume_item_with_confirm) GameUI.Inventory.ConsumeItem(consume_item_with_confirm.item_name);
	CancelConsumeItem();
}
function CancelConsumeItem() {
	consume_item_with_confirm = undefined;
	GameUI.Collection.CloseSubPanels();
}

function UpdateActionButtonForItem(item) {
	const button = item.FindChild("CI_ActionButton");
	const b_item_owned = item.BHasClass("BOwned");
	const b_equipped = item.BHasClass("BEquipped");
	const label = button.GetChild(2);
	button.AddClass(`BUnlockBy_${item.source}`);
	const b_item_treasure = item.slot == GameUI.Inventory.GetSlotsDefinition().TREASURES;

	let base_text = "";
	if (item.source == "currency") {
		base_text = FormatBigNumber(item.source_value);
	} else if (item.source == "subscription_tier") {
		button.AddClass(`SubTier_${item.source_value}`);
		base_text = $.Localize(`#sub_${item.source_value}`);
	} else if (item.source == "treasure") {
		item.AddClass("BAvailable");
		base_text = $.Localize(`#item_in_treasure`);
	}

	label.text = b_item_owned
		? $.Localize(b_item_treasure ? "#open_treasure" : `#action_${item.type_name}${b_equipped ? "_TAKE_OFF" : ""}`)
		: base_text;

	if (RE_PURCHASEBLE_ITEMS.includes(item.item_name)) {
		item.AddClass("CONSUMABLE");
		label.text = base_text;
	} else item.AddClass(item.type_name);

	button.SetPanelEvent("onactivate", () => {
		if (RE_PURCHASEBLE_ITEMS.includes(item.item_name) && BASE_ACTIONS[item.source])
			return void BASE_ACTIONS[item.source](item);

		if (b_item_owned) {
			if (b_item_treasure) OpenTreasurePreview(item);
			else if (OWNED_ACTIONS[item.def_type]) OWNED_ACTIONS[item.def_type](item);
		} else if (BASE_ACTIONS[item.source]) BASE_ACTIONS[item.source](item);
	});
}

let ITEMS_SOURCE_CACHE = {};
let b_items_filled = false;
function FillCosmeticItems(items) {
	TREASURES_PREVIEW_ROOT.RemoveAndDeleteChildren();
	const types_names_by_enum = Object.fromEntries(
		Object.entries(GameUI.Inventory.GetTypesDefinition()).map((a) => a.reverse()),
	);
	Object.entries(items).forEach(([name, definition]) => {
		const slot_name = GameUI.Inventory.GetItemSlotName(name);
		if (!slot_name) return;

		const root_for_item = $(`#CC_Content_${slot_name}`);
		if (!root_for_item) return;

		const item = $.CreatePanel("Panel", root_for_item, `Cosmetic_Item_${name}`);
		item.BLoadLayoutSnippet("Cosmetic_Item");
		item.AddClass(name);
		item.AddClass(slot_name);

		const loc_name = LocalizeChatPhrase(name);
		item.loc_name = loc_name;

		item.SetDialogVariable("item_name", loc_name);
		item.SetDialogVariableInt("item_count", 0);

		const type = definition && definition.type && definition.type;
		if (type) {
			item.SetHasClass("BConsumables", type == GameUI.Inventory.GetTypesDefinition().CONSUMABLE);
			item.SetHasClass("BEquipable", type == GameUI.Inventory.GetTypesDefinition().EQUIPMENT);

			item.def_type = type;
			item.type_name = types_names_by_enum[type];
		}

		if (definition.is_hidden != undefined) item.SetHasClass("BHidden", definition.is_hidden == 1);
		if (definition.is_hidden_owned != undefined) {
			item.SetHasClass("BHidden", definition.is_hidden_owned == 1);
			item.SetHasClass("BHiddenOwned", definition.is_hidden_owned == 1);
		}

		item.slot = definition.slot;
		item.slot_name = slot_name;
		item.rarity = definition.rarity;
		item.rarity_name = GameUI.Inventory.GetRarityName(definition.rarity);
		item.image_path = GameUI.Inventory.GetItemImagePath(name);
		item.item_name = name;
		item.tab = $(`#CC_Tab_${slot_name}`);
		item.chat_wheel_details = definition.chat_wheel_details;

		item.AddClass(item.rarity_name);

		const item_image = item.FindChildTraverse("CI_Image");
		item_image.SetImage(item.image_path);

		let source = "other";

		if (definition.unlocked_with) {
			source = Object.keys(definition.unlocked_with)[0];
			const source_value = definition.unlocked_with[source];
			item.source = source;
			item.source_value = source_value;
			UpdateActionButtonForItem(item);
		} else item.AddClass("NoSource");

		ITEMS_SOURCE_CACHE[source] = ITEMS_SOURCE_CACHE[source] || [];
		if (source == "treasure") {
			ITEMS_SOURCE_CACHE[source][item.source_value] = ITEMS_SOURCE_CACHE[source][item.source_value] || [];
			ITEMS_SOURCE_CACHE[source][item.source_value].push(item);
		} else ITEMS_SOURCE_CACHE[source].push(item);

		const is_treasure = definition.slot == GameUI.Inventory.GetSlotsDefinition().TREASURES;
		if (is_treasure) {
			item.FindChildTraverse("CI_Details").SetPanelEvent("onactivate", () => {
				OpenTreasurePreview(item);
			});
			CreateTreasurePreview(item);
		}
		item.SetPanelEvent("onmouseover", () => {
			$.Schedule(is_treasure ? 0.5 : 0, () => {
				item.RemoveClass("RedGlow");
			});
			item.RemoveClass("BNewItem");
			item.RemoveClass("HighlightFocus");
			CheckNewItemsInTab(item.tab, root_for_item);
			$.DispatchEvent(
				"UIShowCustomLayoutParametersTooltip",
				item_image,
				"CustomItem_Tooltip",
				"file://{resources}/layout/custom_game/collection/item_tooltip/item_tooltip.xml",
				BuildTooltipParams({
					items: { [name]: GameUI.Inventory.GetItemCount(name) },
					item_source_name: item.source,
					item_source_value: item.source_value,
				}),
			);
		});

		item.SetPanelEvent("onmouseout", () => {
			$.DispatchEvent("UIHideCustomLayoutTooltip", item, "CustomItem_Tooltip");
		});
	});
	SortItems("default");
	b_items_filled = true;
}
GameUI.Cosmetics.OpenTab = {};
function InitTabs() {
	TABS_ROOT.RemoveAndDeleteChildren();
	CONTENT_ROOT.RemoveAndDeleteChildren();
	let cosmetic_tabs = Object.keys(GameUI.Inventory.GetSlotsDefinition());
	cosmetic_tabs.forEach((tab_name, index) => {
		const tab = $.CreatePanel("Button", TABS_ROOT, `CC_Tab_${tab_name}`);
		tab.BLoadLayoutSnippet("Cosmetic_Tab");
		tab.SetDialogVariableLocString("tab_name", tab_name);

		const content = $.CreatePanel("Panel", CONTENT_ROOT, `CC_Content_${tab_name}`);
		content.BLoadLayoutSnippet("Cosmetic_Content");
		content.AddClass(tab_name);

		const activate_content = () => {
			if (tab.BHasClass("BActive")) return;

			Game.EmitSound("General.ButtonClick");

			GameUI.ToggleSingleClassInParent(TABS_ROOT, tab, "BActive");
			GameUI.ToggleSingleClassInParent(CONTENT_ROOT, content, "BActive");
		};
		if (index == 0) activate_content();

		GameUI.Cosmetics.OpenTab[tab_name] = activate_content;
		tab.SetPanelEvent("onactivate", activate_content);
	});
}
function UpdatePlayerData(player_data) {
	// $.Msg("comsetics UpdatePlayerData2");
	if (!b_items_filled) {
		$.Schedule(0.1, () => {
			UpdatePlayerData(player_data);
		});
		return;
	}
	ITEMS_SOURCE_CACHE.currency.forEach((item) => {
		item.SetHasClass("BAvailable", item.source_value <= GameUI.Player.GetCurrency());
	});
	ITEMS_SOURCE_CACHE.subscription_tier.forEach((item) => {
		item.SetHasClass("BAvailable", item.source_value <= GameUI.Player.GetSubscriptionTier());
		item.SetHasClass("BOwned", item.source_value <= GameUI.Player.GetSubscriptionTier());
		UpdateActionButtonForItem(item);
	});
}
GameUI.Cosmetics.BuyItems = () => {
	if (!current_item_for_purchaing) return;
	GameUI.Collection.CloseSubPanels();
	GameUI.Inventory.BuyItem(current_item_for_purchaing, current_items_count);
};
function CreateTreasurePreview(treasure) {
	if (!b_items_filled) {
		$.Schedule(0.1, () => {
			CreateTreasurePreview(treasure);
		});
		return;
	}
	if (!ITEMS_SOURCE_CACHE.treasure || !ITEMS_SOURCE_CACHE.treasure[treasure.item_name]) return;

	const preview_list = $.CreatePanel("Panel", TREASURES_PREVIEW_ROOT, `TreasurePreview_${treasure.item_name}`);
	preview_list.treasure_name = treasure.item_name;

	const pre_sorted_names = ITEMS_SOURCE_CACHE.treasure[treasure.item_name].map((i) => i.item_name).sort();
	const items_list = {};

	ITEMS_SOURCE_CACHE.treasure[treasure.item_name].forEach((item) => {
		items_list[item.item_name] = item;
	});

	for (const item_name of pre_sorted_names) {
		const cached_item = items_list[item_name];
		if (!cached_item) continue;

		const preview_item = $.CreatePanel("Panel", preview_list, "");
		preview_item.BLoadLayoutSnippet("Cosmetic_Item");
		preview_item.AddClass(cached_item.rarity_name);
		preview_item.FindChildTraverse("CI_Image").SetImage(cached_item.image_path);

		preview_item.SetHasClass("BOwned", cached_item.BHasClass("BOwned"));
		cached_item.preview_item = preview_item;
		preview_item.rarity = cached_item.rarity;

		preview_item.SetPanelEvent("onmouseover", () => {
			$.DispatchEvent(
				"UIShowCustomLayoutParametersTooltip",
				preview_item.FindChildTraverse("CI_Image"),
				"CustomItem_Tooltip",
				"file://{resources}/layout/custom_game/collection/item_tooltip/item_tooltip.xml",
				BuildTooltipParams({
					items: { [item_name]: 1 },
				}),
			);
		});

		preview_item.SetPanelEvent("onmouseout", () => {
			$.DispatchEvent("UIHideCustomLayoutTooltip", preview_item, "CustomItem_Tooltip");
		});

		FillChatWheelBasedContentByCachedItem(preview_item, cached_item);
	}

	for (const _p_item of preview_list.Children().sort(SORT_FUNCTIONS["rarity_down"]))
		preview_list.MoveChildBefore(_p_item, preview_list.GetChild(0));
}
function OpenTreasureTabWithGlow(item_name) {
	GameUI.Cosmetics.OpenTab.TREASURES();
	const cached_item = $(`#Cosmetic_Item_${item_name}`);
	cached_item.AddClass("RedGlow");
}
let current_preview_treasure;
function UpdateTreasurePreviewButton() {
	const b_item_owned = current_preview_treasure.BHasClass("BOwned");
	TREASURES_PREVIEW_CONF_BUTTON.GetChild(0).text = $.Localize(b_item_owned ? `#open_treasure` : `#buy_treasure`);
	TREASURES_PREVIEW_CONF_BUTTON.SetPanelEvent("onactivate", () => {
		if (b_item_owned) {
			GameUI.Inventory.ConsumeItem(current_preview_treasure.item_name);
		} else if (BASE_ACTIONS[current_preview_treasure.source]) {
			if (current_preview_treasure.BHasClass("BAvailable"))
				BASE_ACTIONS[current_preview_treasure.source](current_preview_treasure);
			else {
				GameUI.Collection.CloseSubPanels();
				OpenTreasureTabWithGlow(current_preview_treasure.item_name);
			}
		}
	});
}
function OpenTreasurePreview(item) {
	TREASURES_PREVIEW.RemoveClass("BWheelGame");
	TREASURES_PREVIEW.RemoveClass("BWheelGameProcess");
	TREASURES_PREVIEW.RemoveClass("BWheelGameEnd");
	TREASURES_PREVIEW.RemoveClass("BWheelGameDuplicate");

	TREASURES_PREVIEW_ROOT.Children().forEach((preview_list) => {
		preview_list.SetHasClass("Show", item.item_name == preview_list.treasure_name);
	});

	current_preview_treasure = item;
	TREASURES_PREVIEW.FindChildTraverse("CI_Treasure_Preview_Item").SetImage(item.image_path);
	TREASURES_PREVIEW.GetChild(1).SwitchClass("rarity", item.rarity_name);
	TREASURES_PREVIEW.SetDialogVariable("treasure_name", $.Localize(`#${item.item_name}`), TREASURES_PREVIEW);
	UpdateTreasurePreviewButton();
	GameUI.Collection.OpenSubPanel("CI_Treasure_Preview");
}

function ClearItems(func) {
	Object.entries(ITEMS_SOURCE_CACHE).forEach(([group_name, cached_data]) => {
		if (group_name == "treasure")
			Object.values(cached_data).forEach((_treasure_cached_list) => {
				_treasure_cached_list.forEach((item_panel) => {
					func(item_panel);
					UpdateActionButtonForItem(item_panel);
				});
			});
		else
			cached_data.forEach((item_panel) => {
				func(item_panel);
				UpdateActionButtonForItem(item_panel);
			});
	});
}

function UpdateOwnedItems(items) {
	// $.Msg("UpdateOwnedItems");
	// JSON.print(items);
	ClearItems((item) => {
		item.RemoveClass("BOwned");
		item.SetDialogVariableInt("item_count", 0);
		UpdateActionButtonForItem(item);
	});
	Object.entries(items).forEach(([item_name, item_data]) => {
		const item_panel = $(`#Cosmetic_Item_${item_name}`);
		if (!item_panel || item_data.count <= 0) return;
		item_panel.AddClass("BOwned");
		item_panel.SetHasClass(
			"BManyItems",
			item_data.count > 1 || RE_PURCHASEBLE_ITEMS.includes(item_panel.item_name),
		);

		item_panel.SetDialogVariableInt("item_count", item_data.count);
		UpdateActionButtonForItem(item_panel);

		if (item_panel.preview_item) item_panel.preview_item.AddClass("BOwned");
	});
	UpdatePlayerData();
}
function UpdateEquippedItems(items) {
	// $.Msg("UpdateEquippedItems");
	// JSON.print(items);

	ClearItems((item) => {
		item.RemoveClass("BEquipped");
		UpdateActionButtonForItem(item);
	});

	Object.values(items).forEach((item_name) => {
		const item_panel = $(`#Cosmetic_Item_${item_name}`);
		if (!item_panel) return;
		item_panel.AddClass("BEquipped");
		UpdateActionButtonForItem(item_panel);
	});
}
function AddPreviewSubPanel() {
	if (!b_items_filled) {
		$.Schedule(0.1, () => {
			AddPreviewSubPanel();
		});
		return;
	}
	$.Schedule(1, () => {
		$.Msg("AddPreviewSubPanel");
		GameUI.Collection.AddSubPanel(TREASURES_PREVIEW);
	});
}

let treasure_opening_sound;
let treasure_opening_sound_end;
let end_treasure_opening_schedule;

function EndTreasureOpening(delay) {
	if (end_treasure_opening_schedule != undefined) $.CancelScheduled(end_treasure_opening_schedule);

	end_treasure_opening_schedule = $.Schedule(delay || 0, () => {
		if (treasure_opening_sound) Game.StopSound(treasure_opening_sound);
		end_treasure_opening_schedule = undefined;
		TREASURES_PREVIEW.RemoveClass("BWheelGameProcess");
		TREASURES_PREVIEW.AddClass("BWheelGameEnd");
		if (!TREASURES_PREVIEW.prize) return;

		TREASURES_PREVIEW.SetDialogVariable("prize_item_name", LocalizeChatPhrase(TREASURES_PREVIEW.prize.item_name));

		let sound_name = RARITIES_DROP_SOUND[GameUI.Inventory.GetItemRarity(TREASURES_PREVIEW.prize.item_name)];

		if (TREASURES_PREVIEW.prize.rolled_duplicate) {
			TREASURES_PREVIEW.AddClass("BWheelGameDuplicate");
			TREASURES_PREVIEW.SetDialogVariable(
				"prize_duplicate_currency",
				FormatBigNumber(TREASURES_PREVIEW.prize.currency),
			);
			sound_name = "collection.duplicate_item";
		}

		Game.EmitSound(sound_name);
		TREASURES_PREVIEW.prize = undefined;
	});
}
function SkipTreasureOpening() {
	if (!TREASURES_PREVIEW.BHasClass("BWheelGameProcess")) return;
	if (!TREASURES_PREVIEW.prize) return;

	SetItemInWheel(WHEEL_LIST.GetChild(3), $(`#Cosmetic_Item_${TREASURES_PREVIEW.prize.item_name}`), true);
	WHEEL_LIST.style.paddingLeft = "-14px";
	WHEEL_LIST.Children().forEach((_) => {
		_.style.transitionDuration = `0s`;
		_.style.transform = `translateX(-0px)`;
	});
	EndTreasureOpening();
}
function CheckNewItemsInTab(tab, items_list) {
	let new_items = 0;
	items_list.Children().forEach((item) => {
		if (item.BHasClass("BNewItem") && !item.BHasClass("BHiddenOwned")) new_items++;
	});
	tab.SetHasClass("BHasNewItems", new_items > 0);
	tab.SetDialogVariableInt("new_items_count", new_items);
}

GameUI.Cosmetics.AddNewItem = (item_name) => {
	const cached_item = $(`#Cosmetic_Item_${item_name}`);
	if (!cached_item) return;

	cached_item.AddClass("BNewItem");
	CheckNewItemsInTab(cached_item.tab, cached_item.GetParent());

	GameUI.Collection.ShowTabFlag("cosmetics");
};

function SetItemInWheel(focus_item, cached_item, b_prize) {
	if (!cached_item) return;

	// JSON.print(cached_item);

	focus_item.SwitchClass("rarity", cached_item.rarity_name);
	focus_item.FindChildTraverse("CI_Image").SetImage(cached_item.image_path);

	focus_item.SwitchClass("chat_wheel_content", "BChatWheel_None");
	FillChatWheelBasedContentByCachedItem(focus_item, cached_item);

	if (b_prize != undefined) focus_item.SetHasClass("BPrize", b_prize);
	if (b_prize && !TREASURES_PREVIEW.prize.rolled_duplicate) {
		GameUI.Cosmetics.AddNewItem(cached_item.item_name);
	}
	focus_item.SetPanelEvent("onmouseover", () => {
		if (TREASURES_PREVIEW.BHasClass("BWheelGameProcess")) return;
		$.DispatchEvent(
			"UIShowCustomLayoutParametersTooltip",
			focus_item,
			"CustomItem_Tooltip",
			"file://{resources}/layout/custom_game/collection/item_tooltip/item_tooltip.xml",
			BuildTooltipParams({
				items: { [cached_item.item_name]: 1 },
			}),
		);
	});
}
function OpenMoreTreasure() {
	GameUI.Inventory.ConsumeItem(current_preview_treasure.item_name);
}
function StartTreaureOpening(data) {
	treasure_opening_sound = Game.EmitSound("ui.treasure.spin_music");
	if (treasure_opening_sound_end) Game.StopSound(treasure_opening_sound_end);

	TREASURES_PREVIEW.AddClass("BWheelGame");
	TREASURES_PREVIEW.AddClass("BWheelGameProcess");
	TREASURES_PREVIEW.RemoveClass("BWheelGameEnd");
	TREASURES_PREVIEW.RemoveClass("BWheelGameDuplicate");
	const treasure_name = current_preview_treasure.item_name;

	const items = ITEMS_SOURCE_CACHE.treasure[treasure_name];
	const prize_item = data.item_name;
	let game_time = 3;
	let game_step = 0.06;
	const item_padding_left = 14;
	const item_width = 120 + item_padding_left;
	const default_padding = Math.round(-item_padding_left / WHEEL_LIST.actualuiscale_x);
	const max_game_steps = Math.round(game_time / game_step);
	const total_length_px = default_padding + max_game_steps * item_width;

	TREASURES_PREVIEW.SetHasClass("NoTreasures", GameUI.Inventory.GetItemCount(treasure_name) <= 0);

	WHEEL_LIST.style.paddingLeft = `${default_padding}px`;
	WHEEL_LIST.Children().forEach((_) => {
		_.RemoveClass("BPrize");
		_.style.transitionDuration = `0s`;
		_.style.transform = `translateX(-${item_width * 2}px)`;

		_.style.transitionDuration = `4s`;
		_.style.transform = `translateX(-${total_length_px}px)`;

		SetItemInWheel(_, items.random());
	});

	TREASURES_PREVIEW.prize = data;

	let c = 0;
	const step = () => {
		game_time -= game_step;
		const moved_item = WHEEL_LIST.GetChild(0);
		if (c++ >= 5) {
			const b_prize_place = c == max_game_steps - 2;
			WHEEL_LIST.style.paddingLeft = `${
				default_padding + (c - 5) * item_width - Math.round(item_padding_left / WHEEL_LIST.actualuiscale_x)
			}px`;
			WHEEL_LIST.MoveChildAfter(moved_item, WHEEL_LIST.GetChild(WHEEL_LIST.Children().length - 1));
			SetItemInWheel(moved_item, items.random());

			if (b_prize_place) SetItemInWheel(moved_item, $(`#Cosmetic_Item_${prize_item}`), true);
		}

		if (0 < game_time) {
			$.Schedule(game_step, () => {
				if (TREASURES_PREVIEW.BHasClass("BWheelGameProcess")) step();
			});
		} else EndTreasureOpening(1);
	};
	step();
}
function ShowOnlyOwnedItems() {
	CONTENT_ROOT.ToggleClass("BShowOwnedItemsOnly");
}

function SortItems(sort_name) {
	CONTENT_ROOT.Children().forEach((items_root) => {
		for (const item of items_root.Children().sort(SORT_FUNCTIONS[sort_name])) {
			items_root.MoveChildBefore(item, items_root.GetChild(0));
		}
	});
	$.DispatchEvent("DropInputFocus");
	SORT_SELECTOR.SetSelected("sort_" + sort_name);
}

GameUI.Cosmetics.OpenSpecificCollectionTab = (tab_name, item_focus = "NONE") => {
	GameUI.Collection.OpenSpecificTab("cosmetics");
	GameUI.Cosmetics.OpenTab[tab_name]();

	const item_panel = $(`#Cosmetic_Item_${item_focus}`);
	if (!item_panel) return;

	ClearItems((item) => {
		item.RemoveClass("HighlightFocus");
	});

	item_panel.AddClass("HighlightFocus");
};
function FillChatWheelBasedContentByCachedItem(parent, cached_item) {
	FillChatWheelBasedContent(
		parent,
		cached_item?.chat_wheel_details?.sound,
		cached_item?.chat_wheel_details?.color,
		cached_item?.chat_wheel_details?.emoji_id,
		cached_item.item_name,
		cached_item.item_name,
		parent.FindChildTraverse("CI_ChatWheel_Color"),
		parent.FindChildTraverse("CI_ChatWheel_EmojiContainer"),
	);
}
GameUI.FillChatWheelContent = (item_name, parent) => {
	if (!b_items_filled)
		return void $.Schedule(0.1, () => {
			GameUI.FillChatWheelContent(item_name, parent);
		});

	const cached_item = $(`#Cosmetic_Item_${item_name}`);
	if (!cached_item) return;

	FillChatWheelBasedContentByCachedItem(parent, cached_item);
};
function FillChatWheelBasedContent(
	parent,
	phrase,
	color,
	emoji_id,
	phrase_name,
	color_name,
	color_line,
	emoji_container,
) {
	if (phrase) {
		parent.SetDialogVariable("chat_wheel_phrase", LocalizeChatPhrase(phrase_name));
		parent.SwitchClass("chat_wheel_content", "BChatWheel_Phrase");
		parent.AddClass("BChatWheelContent");

		parent.FindChildTraverse("CI_ChatWheel_SoundButton").SetPanelEvent("onactivate", () => {
			if (phrase_name == "") return;

			Game.EmitSound(W_TYPE_DEF_GETTERS[W_TYPE.NEW_SOUNDS](phrase_name));
		});
	}

	if (color) {
		const color_class = W_TYPE_DEF_GETTERS[W_TYPE.COLORS](color_name);
		parent.SetDialogVariableLocString("chat_wheel_color", color_name);
		color_line.SwitchClass("chat_wheel_color", color_class);
		parent.SwitchClass("chat_wheel_content", "BChatWheel_Color");
		parent.AddClass("BChatWheelContent");

		CreateSubChannelsCW(color_line, color_name);
	}

	if (emoji_id) {
		emoji_container.Children().forEach((c) => c.DeleteAsync(0));
		$.CreatePanel("DOTAEmoticon", emoji_container, "", {
			emoticonid: emoji_id,
			style: "height:64px;width:64px;",
		});
		parent.SwitchClass("chat_wheel_content", "BChatWheel_Emoji");
		parent.AddClass("BChatWheelContent");
	}
}

(() => {
	WHEEL_LIST.RemoveAndDeleteChildren();
	for (let idx = 1; idx <= 11; idx++) {
		const item = $.CreatePanel("Panel", WHEEL_LIST, "");
		item.BLoadLayoutSnippet("Cosmetic_Item");
		item.SetPanelEvent("onmouseout", () => {
			$.DispatchEvent("UIHideCustomLayoutTooltip", item, "CustomItem_Tooltip");
		});
	}

	InitTabs();

	GameUI.Collection.CloseSubPanels();
	GameUI.Inventory.RegisterForDefinitionsChanges(FillCosmeticItems);
	GameUI.Inventory.RegisterForInventoryChanges(UpdateOwnedItems);
	GameUI.Inventory.RegisterForEquipmentChanges(UpdateEquippedItems);

	GameUI.Collection.AddSubPanel(PURCHASING_BY_CURRENCY);
	GameUI.Collection.AddSubPanel(ITEM_USE_CONFIRM);
	GameUI.Collection.CloseSubPanels();

	AddPreviewSubPanel();
	GameUI.Player.RegisterForPlayerDataChanges(UpdatePlayerData);

	const frame = GameEvents.NewProtectedFrame($.GetContextPanel());
	frame.SubscribeProtected("WebTreasure:roll_result", StartTreaureOpening);
})();