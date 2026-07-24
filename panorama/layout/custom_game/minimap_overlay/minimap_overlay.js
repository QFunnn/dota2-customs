--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


const MAP_ITEMS = {
	bp_conqueror_presence: "{count}%",
	bp_lucky_trinket_common: "{count}%",
	bp_lucky_trinket_rare: "{count}%",
	bp_lucky_trinket_epic: "{count}%",
	bp_teamwork_enhancer: "{count}%",
	bp_early_bird_charm: "x{count}",
	bp_power_crystal: "{count}%",
};
const CONTEXT = $.GetContextPanel();
const MAP_ITEMS_LIST = $("#Map_BPC_List");
const MAP_BUFFS = MAP_ITEMS_LIST.GetParent();
const MAP_OVERLAY = $("#MapOverlay");

let timeout = 0;
function UpdateMinimapOverlay() {
	const minimap_buttons = FindDotaHudElement("GlyphScanContainer");
	const glyph_button = FindDotaHudElement("GlyphButton");

	if ((!minimap_buttons || !glyph_button) && timeout++ < 30) $.Schedule(1, UpdateMinimapOverlay);

	if (IsSpectating()) minimap_buttons.visible = false;

	minimap_buttons.style.backgroundImage = `url('s2r://panorama/images/custom_game/minimap_side_container_bg.png');`;
	glyph_button.style.marginTop = "-1px";

	const roshan_button = FindDotaHudElement("RoshanTimer");
	if (roshan_button) roshan_button.visible = false;
}

function CreateMapBPItems() {
	SetOrbsCount("rare", Math.max(0, GameUI.Inventory.GetItemCount("bp_legendary_lagresse")));
	SetOrbsCount("epic", Math.max(0, GameUI.Inventory.GetItemCount("bp_breathtaking_benefaction")));

	if (CONTEXT.BHasClass("BItemsHiddenManually")) return;

	MAP_ITEMS_LIST.RemoveAndDeleteChildren();

	Object.entries(MAP_ITEMS).forEach(([item, count_format]) => {
		const count = GameUI.Inventory.GetItemCount(item);
		if (count <= 0) return;
		MAP_BUFFS.AddClass("BHasItems");

		const panel = $.CreatePanel("Panel", MAP_ITEMS_LIST, "");
		panel.BLoadLayoutSnippet("Map_BP_Item");

		panel.SwitchClass("rarity", GameUI.Inventory.GetItemRarityName(item));
		panel.SetDialogVariable("item_count_and_name", `${count_format.replace("{count}", count)} ${$.Localize(item)}`);

		const image = panel.FindChildTraverse("Map_BP_I_Image");
		image.SetImage(GameUI.Inventory.GetItemImagePath(item));

		image.SetPanelEvent("onmouseover", () => {
			$.DispatchEvent(
				"UIShowCustomLayoutParametersTooltip",
				image,
				"CustomItem_Tooltip",
				"file://{resources}/layout/custom_game/collection/item_tooltip/item_tooltip.xml",
				BuildTooltipParams({
					items: { [item]: count },
				}),
			);
		});
		image.SetPanelEvent("onmouseout", () => {
			$.DispatchEvent("UIHideCustomLayoutTooltip", image, "CustomItem_Tooltip");
		});
		image.SetPanelEvent("onactivate", () => {
			GameUI.Collection.OpenSpecificTab("battle_pass");
		});
	});
}

function IsGameStarted() {
	return Game.GameStateIsAfter(DOTA_GameState.DOTA_GAMERULES_STATE_PRE_GAME);
}

function HideMapBPItems() {
	CONTEXT.AddClass("BItemsHiddenManually");
}

function SetOrbsCount(type, count) {
	const b_has_orbs = count > 0;
	CONTEXT.SetHasClass(`BHasOrbs_${type}`, b_has_orbs);
	CONTEXT.SetDialogVariable(`${type}_orbs_count`, count);
	CONTEXT.SetDialogVariableLocString(
		`map_orb_${type}_action_button_text`,
		b_has_orbs ? "map_orb_gift_to_teams" : "map_bp_open_bp",
	);
}
function GiftOrbToTeams(type) {
	if (!CONTEXT.BHasClass(`BHasOrbs_${type}`)) {
		GameUI.Collection.OpenSpecificTab("battle_pass");
	} else {
		if (type == "rare") GameUI.Inventory.ConsumeItem("bp_legendary_lagresse");
		else if (type == "epic") GameUI.Inventory.ConsumeItem("bp_breathtaking_benefaction");
	}
}

function HideMapOrbs() {
	CONTEXT.SwitchClass("map_bp_orbs", "");
}

function ToggleMapOrbs(type) {
	const class_name = `BShowMapOrbs_${type}`;
	if (CONTEXT.BHasClass(class_name)) HideMapOrbs();
	else CONTEXT.SwitchClass("map_bp_orbs", class_name);
}

function OpenCollection() {
	CONTEXT.AddClass("CollectionSeen");
	GameUI.Custom_ToggleCollection();
}

const DEFAULT_MAP_STYLES = {
	minimap_block: {
		width: ["244px", "280px"],
		height: ["244px", "280px"],
		backgroundImage: "url('s2r://panorama/images/hud/reborn/bg_minimap_psd.vtex')",
		verticalAlign: "bottom",
	},
	minimap: {
		width: ["260px", "296px"],
		height: ["260px", "296px"],
		verticalAlign: "middle",
		horizontalAlign: "center",
	},
	GlyphScanContainer: {
		marginLeft: ["244px", "280px"],
		height: "280px",
		width: "84px",
		verticalAlign: "bottom",
	},
};

function ResetMapStyleByDefault() {
	const is_large_map = FindDotaHudElement("Hud").BHasClass("MinimapExtraLarge");

	Object.entries(DEFAULT_MAP_STYLES).forEach(([element_name, json_style]) => {
		const reset_style_valid_check = () => {
			const element = FindDotaHudElement(element_name);
			if (!element || !element.IsValid()) return $.Schedule(1, reset_style_valid_check);

			Object.entries(json_style).forEach(([_name, _value]) => {
				let value = _value;
				if (typeof _value == "object") value = _value[is_large_map ? 1 : 0];

				element.style[_name] = value;
			});
		};
		reset_style_valid_check();
	});
}

function OpenSubscriptionsTabsForSupport() {
	GameUI.Collection.OpenSpecificTab("subscription");
	GameUI.Subscriptions.OpenAllSubscriptionBonuses();
}

function UpdatePlayerSubState(player_data) {
	if (player_data && player_data.subscription && player_data.subscription.tier != undefined)
		CONTEXT.AddClass(`PlayerSub_${player_data.subscription.tier}`);
}

(() => {
	CONTEXT.AddClass("BItemsHiddenManually");
	MAP_BUFFS.RemoveClass("BHasItems");
	UpdateMinimapOverlay();

	const remove_dota_hud_element = function (id) {
		const element = FindDotaHudElement(id);
		if (element) element.DeleteAsync(0);
	};
	remove_dota_hud_element("HUDSkinMinimap");
	remove_dota_hud_element("HUDSkinFXGlyph");
	remove_dota_hud_element("HUDSkinTopBarBG");

	ResetMapStyleByDefault();
	$.RegisterEventHandler("PanelStyleChanged", FindDotaHudElement("minimap_block"), ResetMapStyleByDefault);
	$.RegisterEventHandler("PanelStyleChanged", MAP_OVERLAY, ResetMapStyleByDefault);

	if (IsGameStarted()) HideMapBPItems();

	if (IsSpectating()) CONTEXT.AddClass("BSpectator");
	else {
		GameUI.Inventory.RegisterForInventoryChanges(CreateMapBPItems);

		GameEvents.Subscribe("game_rules_state_change", () => {
			if (IsGameStarted()) HideMapBPItems();
		});

		$.RegisterForUnhandledEvent("Cancelled", () => {
			HideMapOrbs();
		});
		GameUI.SetMouseCallback((event_name, arg) => {
			if (event_name == "pressed" && arg == 0) HideMapOrbs();
		});
	}

	const ability_hud_skin = FindDotaHudElement("HUDSkinAbilityContainerBG");
	ability_hud_skin.style.width = "100%";
	ability_hud_skin.style.marginRight = "200px";

	FindDotaHudElement("RadarButton").visible = false;
	FindDotaHudElement("glyph").visible = false;
	FindDotaHudElement("TormentorTimerContainer").visible = false;
	GameUI.Player.RegisterForPlayerDataChanges(UpdatePlayerSubState);
})();