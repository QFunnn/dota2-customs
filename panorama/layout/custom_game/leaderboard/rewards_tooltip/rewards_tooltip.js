--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


const CONTEXT = $.GetContextPanel();

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
	CONTEXT.RemoveAndDeleteChildren();

	let items = CONTEXT.GetAttributeString(`items`, {});
	if (items != undefined && items != "undefined" && items != "") {
		const items_parsed = JSON.parse(items);
		if (items_parsed) items = Object.entries(items_parsed);
	}
	for (const [item_name, count] of items) {
		const item = $.CreatePanel("Panel", CONTEXT, "");
		item.BLoadLayoutSnippet("CI_Item");

		item.SetDialogVariableLocString("reward_name", item_name);

		item.FindChildTraverse("CI_Item_Image").SetImage(GameUI.Inventory.GetItemImagePath(item_name));

		item.SwitchClass("ci_item_rarity", GameUI.Inventory.GetItemRarityName(item_name));
		item.SwitchClass("ci_item_slot", GameUI.Inventory.GetItemSlotName(item_name) || "slot_none");
		if (count > 1) {
			item.SetDialogVariableInt("count", count);
			item.AddClass("BManyItems");
		}
	}
}