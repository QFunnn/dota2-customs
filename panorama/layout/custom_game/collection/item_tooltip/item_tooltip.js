--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


const CONTEXT = $.GetContextPanel();
const ITEMS_ROOT = $("#CI_Items_List");
const _rarities = GameUI.Inventory.GetRaritiesDefinition();
const TIERS_COLORS = {
	[_rarities.COMMON]: "#a7b2ce",
	[_rarities.UNCOMMON]: "#5a92cd",
	[_rarities.RARE]: "#4867f1",
	[_rarities.MYTHICAL]: "#834af5",
	[_rarities.LEGENDARY]: "#d033e2",
	[_rarities.IMMORTAL]: "#cc9e35",
	[_rarities.ARCANA]: "#a3d857",
	[_rarities.UNIQUE]: "#d80f00",
};
const source_icons = {
	currency: "file://{images}/custom_game/collection/currency_icon_240.png",
	subscription_tier1: "file://{images}/custom_game/payments/products/subscription_tier_1.jpg",
	subscription_tier2: "file://{images}/custom_game/payments/products/subscription_tier_2.jpg",
	other: "file://{images}/custom_game/collection/cosmetics/other_source.png",
	christmas: "file://{images}/custom_game/collection/cosmetics/christmas_source.png",
};

function UpdateTooltip() {
	if (!CONTEXT.arrow_color_updated) {
		const parent = CONTEXT.GetParent().GetParent();
		const set_color = (name) => {
			parent.FindChildTraverse(name).style.washColor = "#131627";
		};
		set_color("TopArrow");
		set_color("RightArrow");
		set_color("BottomArrow");
		set_color("LeftArrow");
		CONTEXT.arrow_color_updated = true;
	}
	ITEMS_ROOT.RemoveAndDeleteChildren();
	CONTEXT.RemoveClass("BBundle");
	const currency = CONTEXT.GetAttributeString(`currency`, 0);
	const source_name = CONTEXT.GetAttributeString(`item_source_name`, "other");
	const source_value = CONTEXT.GetAttributeString(`item_source_value`, undefined);
	const custom_count = parseInt(CONTEXT.GetAttributeString(`custom_count`, 0));

	let items = CONTEXT.GetAttributeString(`items`, undefined);

	if (items != undefined && items != "undefined" && items != "") {
		const items_parsed = JSON.parse(items);
		if (items_parsed) items = Object.entries(items_parsed);
	}

	if (!items || items == "undefined") items = [];

	if (currency > 0) items.unshift(["currency", parseInt(currency)]);

	let b_bundle = items.length > 1;
	const first_item = items[0];

	let item_name = "no_item";
	if (b_bundle) item_name = "items_bundle";
	else if (first_item) item_name = first_item[0];
	else if (!first_item && currency > 0) item_name = "currency";
	CONTEXT.SetDialogVariableInt("count", custom_count || GameUI.Inventory.GetItemCount(item_name) || 0);

	let item_count = 0;
	if (first_item) item_count = first_item[1];

	let item_rarity = 1;

	let line_counter = 0;
	let bundle_description = $.Localize("#bundle_base_description");

	items.forEach(([_item_name, _item_count], index) => {
		let _item_rarity = GameUI.Inventory.GetItemRarity(_item_name) || 1;
		item_rarity = Math.max(_item_rarity, item_rarity);
		if (!b_bundle) return;

		if (index == 0 || index % 3 == 0) {
			line_counter++;
			$.CreatePanel("Panel", ITEMS_ROOT, `ItemsRootLine_${line_counter}`);
		}
		const item = $.CreatePanel("Panel", $(`#ItemsRootLine_${line_counter}`), `BundleItem_${_item_name}`);
		item.BLoadLayoutSnippet("CI_Item");

		item.SetHasClass("BManyItems", _item_count > 1);
		item.SetDialogVariableInt("count", _item_count);

		item.FindChildTraverse("CI_Item_Image").SetImage(GameUI.Inventory.GetItemImagePath(_item_name));
		item.SwitchClass("ci_item_rarity", GameUI.Inventory.GetRarityName(_item_rarity));
		item.SwitchClass("ci_item_slot", GameUI.Inventory.GetItemSlotName(_item_name) || "slot_none");
		bundle_description += `<br>• ${$.Localize(`#${_item_name}`)}${_item_count > 1 ? ` [x${_item_count}]` : ""}`;
	});
	CONTEXT.SetHasClass("BBundle", b_bundle);

	const rarity_color = TIERS_COLORS[item_rarity];
	const b_treasure = source_name == "treasure";
	const b_sub_source = source_name == "subscription_tier";

	CONTEXT.SetDialogVariable("item_name", LocalizeChatPhrase(item_name));
	CONTEXT.SetDialogVariableLocString("item_source_name", `item_source_${source_name}`);
	CONTEXT.SetDialogVariableLocString("source_value", `${b_sub_source ? "sub_" : ""}${source_value}`);

	const unique_desc_key = `#${item_name}_description`;
	let description = b_bundle ? bundle_description : $.Localize(unique_desc_key, CONTEXT);
	if (unique_desc_key == `#${description}`) {
		let slot = GameUI.Inventory.GetItemSlot(item_name);
		let default_desc_key = slot != undefined ? GameUI.Inventory.GetItemSlotName(item_name) : "none";

		if (item_name == "currency") default_desc_key = "currency";
		if (b_bundle) default_desc_key = "bundle";

		description = $.Localize(`#default_item_description_${default_desc_key}`, CONTEXT);

		if (item_name.startsWith("chat_wheel_")) description = $.Localize("default_item_description_chat_wheel_tab");
	}

	CONTEXT.SetDialogVariable("item_description", description);

	const b_has_source_value = source_value != undefined && source_value != "" && source_value != "undefined";
	CONTEXT.SetHasClass("BManyItems", !b_bundle && item_count > 0);
	CONTEXT.SetHasClass("BHasCurrency", currency > 0);
	CONTEXT.SetHasClass("BHasSource", b_has_source_value);

	CONTEXT.SwitchClass("source_class", source_name);
	CONTEXT.SetHasClass("TREASURES", b_treasure);
	$(`#CI_Name`).style.backgroundColor =
		`gradient(linear, 0% 0%, 100% 0%, ` + `from(${rarity_color}33), to (${rarity_color}03))`;
	$(`#CI_RarityOverlay`).style.backgroundColor =
		`gradient(linear, 0% 0%, 100% 0%, ` +
		`from(${rarity_color}14), color-stop(0.25, ${rarity_color}), color-stop(0.75, ${rarity_color}), to(transparent));`;
	$("#CI_MainInfo").style.backgroundColor =
		`gradient(linear, 0% 0%, 80% 250%, ` + `from(${rarity_color}26), to(${rarity_color}03))`;

	const rarity_name = GameUI.Inventory.GetRarityName(item_rarity);
	$("#CI_RarityName").text = $.Localize("#item_tooltip_rarity").replace(
		"##rarity_name##",
		`<font color='${rarity_color}'>${$.Localize(`#rarity_${rarity_name}`)}</font>`,
	);

	if (!b_has_source_value) return;

	if (b_sub_source) CONTEXT.SwitchClass("sub_tier", `SubTier_${source_value}`);

	const source_image = $("#CI_SourceImage");
	if (b_treasure) {
		CONTEXT.SwitchClass("rarity_source_name", GameUI.Inventory.GetItemRarityName(source_value));
		source_image.SetImage(GameUI.Inventory.GetItemImagePath(source_value));
	} else {
		let source_icon = source_icons[`${source_name}${b_sub_source ? source_value : ""}`] || source_icons.other;
		if (source_name == "other")
			source_icon = `file://{images}/custom_game/collection/cosmetics/other_source_icons/${source_value}.png`;

		source_image.SetImage(source_icon);
	}
}