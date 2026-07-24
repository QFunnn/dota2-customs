--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


GameUI.Collection = GameUI.Collection || {};
GameUI.ToggleSingleClassInParent = (parent, child, class_name) => {
	parent.Children().forEach((upgrade) => {
		upgrade.RemoveClass(class_name);
	});
	if (child) child.AddClass(class_name);
};

function InitCurrencyButtons() {
	HUD.CURRENCY_BUTTONS_ROOT.RemoveAndDeleteChildren();
	Object.entries(CURRENCY_BUTTONS).forEach(([name, b_create]) => {
		if (!b_create) return;
		const button = $.CreatePanel("Button", HUD.CURRENCY_BUTTONS_ROOT, `Button_${name}`);
		button.BLoadLayoutSnippet("CurrencyButton");
		button.SetDialogVariable("value", 0);
		button.FindChild("Icon").SetImage(GetC_Image(`${name}_icon`));
		button.FindChild("ActiveButton").SetImage(GetC_Image(`plus_${name}`));
		button.AddClass(`Currency_${name}`);

		button.SetPanelEvent("onactivate", () => {
			GameUI.Collection.OpenSubPanel("C_PayCurrency");
		});
	});
}

function InitContent() {
	HUD.TABS_ROOT.RemoveAndDeleteChildren();
	HUD.CONTENT_ROOT.RemoveAndDeleteChildren();

	Object.entries(TABS).forEach(([tab_name, b_create], index) => {
		if (!b_create) return;
		const tab = $.CreatePanel("Button", HUD.TABS_ROOT, `Tab_${tab_name}`);
		tab.BLoadLayoutSnippet("Tab");
		tab.SetDialogVariable(`tab_name`, $.Localize(`#tab_${tab_name}`, tab));
		tab.FindChildTraverse("Icon").SetImage(GetC_Image(`tab_icon_${tab_name}`));

		const bp_panel = $.CreatePanel("Panel", HUD.CONTENT_ROOT, `CollectionContent_${tab_name}`);
		bp_panel.BLoadLayout(
			`file://{resources}/layout/custom_game/collection/${tab_name}/${tab_name}.xml`,
			false,
			false,
		);

		const activate_content = (b_skip_flag) => {
			if (tab.BHasClass("BActive")) return;

			Game.EmitSound("Item.PickUpRecipeShop");
			GameUI.ToggleSingleClassInParent(HUD.TABS_ROOT, tab, "BActive");
			GameUI.ToggleSingleClassInParent(HUD.CONTENT_ROOT, bp_panel, "BActive");

			if (!tab.b_oppened && TABS_FIRST_OPEN_CALLBACKS[tab_name]) {
				tab.b_oppened = true;
				TABS_FIRST_OPEN_CALLBACKS[tab_name]();
			}

			if (!b_skip_flag) tab.RemoveClass("BShowFlag");
		};

		if (index == 0) activate_content(true);

		tab.SetPanelEvent("onactivate", activate_content);
		tab.Open = activate_content;
	});
}

function UpdatePlayerData(player_data) {
	Object.entries(CURRENCY_BUTTONS).forEach(([currency_name, b_active]) => {
		if (!b_active) return;

		const button = $(`#Button_${currency_name}`);
		if (!button) return;

		button.SetDialogVariable("value", FormatBigNumber(player_data[currency_name] || 0));
	});

	for (let tier = 0; tier <= MAX_TIER_SUB; tier++) HUD.CONTEXT.RemoveClass(`SubTier_${tier}`);

	if (player_data.subscription && player_data.subscription.tier != undefined) {
		const sub_tier = player_data.subscription.tier;
		const type = player_data.subscription.type || "payment";

		HUD.BOOST_CONF_ROOT.Children().forEach((panel, idx) => {
			panel.SetDialogVariableLocString("sub_unlock_state", sub_tier > idx ? "sub_extend" : "sub_unlock");
		});

		for (let tier = 0; tier <= sub_tier; tier++) {
			HUD.CONTEXT.AddClass(`SubTier_${tier}`);
		}

		const set_date = (date_name) => {
			const b_has_date = player_data.subscription[date_name] != undefined;

			HUD.CONTEXT.SetHasClass(`BSubDate_${date_name}`, b_has_date);
			if (b_has_date) {
				let date = new Date(player_data.subscription[date_name]);
				date.setMinutes(date.getMinutes() - date.getTimezoneOffset());
				HUD.CONTEXT.SetDialogVariableTime(`sub_${date_name}`, date.getTime() / 1000);
			}
		};
		set_date("end_date");
		set_date("start_date");

		HUD.CONTEXT.SetDialogVariable("sub_state_text", $.Localize(`#sub_${sub_tier}`, HUD.CONTEXT));

		let sub_duration_text = "";
		if (sub_tier > 0) {
			const sub_end_date = new Date(player_data.subscription.end_date);
			sub_end_date.setMinutes(sub_end_date.getMinutes() - sub_end_date.getTimezoneOffset());

			let sub_time_left = sub_end_date - new Date();
			let [time_left, format] = TimeLeftParse(sub_time_left);
			HUD.CONTEXT.SetDialogVariable("sub_time_left", time_left);

			sub_duration_text = $.Localize(`sub_time_left_${format}`, HUD.CONTEXT);
		}

		HUD.CONTEXT.SetDialogVariable("sub_state_duration", sub_duration_text);

		const b_automatic_sub = type == "automatic";
		HUD.CONTEXT.SetHasClass("BAutoSubscirption", b_automatic_sub && sub_tier > 0);

		const sub_source = player_data.subscription.metadata.source;
		if (b_automatic_sub) {
			HUD.CONTEXT.SetDialogVariable(
				"renew_price",
				GameUI.GetProductPriceTemplated(`subscription_tier_${sub_tier}`),
			);
			HUD.CONTEXT.SetDialogVariable("auto_sub_type", sub_source);
			HUD.CONTEXT.SetHasClass("BManagmentAvailable", sub_source == "stripe");
		}
		HUD.CONTEXT.SwitchClass("sub_source", `SubSource_${sub_source}`);
		HUD.CONTEXT.SetDialogVariable(
			"subsription_purchasing_type",
			$.Localize(`#subscription_type_${type}`, HUD.CONTEXT),
		);
		HUD.CONTEXT.SetHasClass("BErrorWithSubscription", player_data.subscription.metadata.fail_reason != undefined);
	}
}

function ToggleSubscriptionPurchasing(level) {
	// if (HUD.CONTEXT.BHasClass(`SubTier_${level}`)) return;
	GameUI.Collection.OpenSubPanel("PaySubscriptionConf_Root");
}

function ToggleCollectionShow() {
	HUD.CONTEXT.ToggleClass("Show");
	if (!HUD.CONTEXT.BHasClass("Show")) $.DispatchEvent("DropInputFocus");
	GameUI.Collection.CloseSubPanels();
	dotaHud.RemoveClass("BShowCustomMatchDetailsOT3");
}
GameUI.Collection.InitSubscriptionConf = InitSubscriptionConf;
function InitSubscriptionConf() {
	HUD.BOOST_CONF_ROOT.RemoveAndDeleteChildren();
	GameUI.Collection.CloseSubPanels();

	for (let sub_level = 1; sub_level < MAX_TIER_SUB; sub_level++) {
		let sub_panel;
		if (GameUI.Subscriptions) sub_panel = GameUI.Subscriptions.CreateSubsciption();

		const bc_root = $.CreatePanel("Panel", HUD.BOOST_CONF_ROOT, `SubscriptionConfRoot_${sub_level}`);
		bc_root.BLoadLayoutSnippet("C_SubscriptionConf");

		const sub_action = (func) => {
			func(bc_root);
			if (sub_panel) func(sub_panel);
		};

		sub_action((root) => {
			root.AddClass(`BC_Tier_${sub_level}`);
			root.SetDialogVariableLocString("sub_name", `#sub_${sub_level}`);
		});

		bc_root.SetDialogVariableLocString("sub_unlock_state", "sub_unlock");

		const bonuses = BOOST_BONUSES[sub_level];
		if (bonuses)
			sub_action((root) => {
				Object.entries(bonuses).forEach(([bonus_name, value]) => {
					const line = $.CreatePanel(
						"Label",
						root.FindChildTraverse("BC_Content"),
						`BC_Content_${bonus_name}_${sub_level}`,
						{
							class: `Content_${bonus_name}`,
							html: true,
						},
					);
					if (value) line.SetDialogVariableInt("value", value);
					line.text = $.Localize(`#payment_sub_content_line_${bonus_name}`, line);
				});
			});

		sub_action((root) => {
			root.FindChildTraverse("BC_ConfPurchaseButton").SetPanelEvent("onactivate", function () {
				// if (HUD.CONTEXT.BHasClass(`SubTier_${sub_level}`)) return;
				HUD.CONTEXT.RemoveClass("BShowSubscriptionPurchasingConf");
				GameUI.InitiatePaymentFor(`subscription_tier_${sub_level}`);
				GameUI.Collection.CloseSubPanels();
			});
		});
	}
}

function GetCurrencyShopLineForOffer() {
	let line = HUD.CURRENCY_BUNDLES_ROOT.Children().find((line) => {
		return line.Children().length < CURRENCY_SHOP_OFFERS_IN_LINE;
	});
	if (!line) line = $.CreatePanel("Panel", HUD.CURRENCY_BUNDLES_ROOT, "");
	return line;
}
function CreateCurrencyBundle(name, definition, button_text, image_extention, additional_class) {
	const button = $.CreatePanel("Button", GetCurrencyShopLineForOffer(), "");
	button.BLoadLayoutSnippet("C_CurrencyBundle");
	button.FindChildTraverse("CB_Image").SetImage(GetC_Image(`currency_shop/${name}${image_extention || ""}`));

	const is_halloween = GameUI.Events.IsHalloween();

	if (definition.rewards) {
		const currency_list = button.FindChildTraverse("CB_List");
		Object.entries(definition.rewards).forEach(([currency_name, currency_value]) => {
			currency_value = currency_value || 0;
			let default_line;
			const create_currency_line = (_value, additional_class) => {
				const currency = $.CreatePanel("Label", currency_list, "", {
					class: `CB_Currency_${currency_name}`,
					html: true,
				});
				currency.text = FormatBigNumber(_value);
				if (additional_class) currency.AddClass(additional_class);
				return currency;
			};
			default_line = create_currency_line(currency_value);

			if (is_halloween) {
				create_currency_line(
					currency_value + (currency_value * GameUI.Events.GetHalloweenDefinition().bundle_bonus_pct) / 100,
					"HalloweenLine",
				);
				$.CreatePanel("Panel", default_line, "", {
					class: `CB_Currency_Overline`,
				});
			}
		});
	}
	if (definition.bonus) {
		button.AddClass("BHasBonus");
		button.SetDialogVariableInt("bonus", definition.bonus);
	}
	button.SetHasClass("BPopular", definition.popular != undefined);
	button.SetDialogVariable("cb_button_text", button_text);
	if (additional_class) button.AddClass(additional_class);

	button.SetPanelEvent("onactivate", () => {
		if (definition.callback) definition.callback();
		else GameUI.InitiatePaymentFor(name);
		GameUI.Collection.CloseSubPanels();
	});
}

function InitCurrencyBundles() {
	$.Msg("InitCurrencyBundles7");
	HUD.CURRENCY_BUNDLES_ROOT.RemoveAndDeleteChildren();
	HUD.CONTEXT.RemoveClass("BActivatedButton_currency");
	HUD.CONTEXT.SetHasClass("BHalloweenEvent", GameUI.Events.IsHalloween());

	Object.entries(additional_currency_packs).forEach(([product_name, product_definition]) => {
		CreateCurrencyBundle(product_name, product_definition, $.Localize(`#${product_name}`), "", product_name);
	});
	Object.entries(GameUI.GetProducts()).forEach(([product_name, product_definition]) => {
		if (product_name.indexOf("currency_bundle") < 0) return;
		CreateCurrencyBundle(
			product_name,
			product_definition,
			GameUI.GetProductPriceTemplated(product_name),
			CURRENCY_SHOP_IMAGE_PATH_EXT,
		);
	});
}

GameUI.Collection.CloseSubPanels = () => {
	HUD.CONTEXT.RemoveClass("BShowSubPanel");
	HUD.SUB_PANELS.Children().forEach((s_panel) => {
		s_panel.RemoveClass("Show");
	});
};
GameUI.Collection.OpenSubPanel = (name) => {
	GameUI.Collection.Show();

	const s_panel = $(`#${name}`);
	if (!s_panel) return;

	HUD.CONTEXT.AddClass("BShowSubPanel");
	s_panel.AddClass("Show");
};

function _AddPanelToParent(panel, parent) {
	parent.Children().forEach((p) => {
		if (p.id == panel.id) p.DeleteAsync(0);
	});
	panel.SetParent(parent);
	panel.SetPositionInPixels(0, 0, 0);
}

GameUI.Collection.AddSubPanel = (panel) => _AddPanelToParent(panel, HUD.SUB_PANELS);
GameUI.Collection.AddAdditionalPanel = (panel) => _AddPanelToParent(panel, HUD.ADDITIONAL_PANELS);
GameUI.Collection.OpenSpecificTab = (tab_name, b_skip_open_collection) => {
	const tab = $(`#Tab_${tab_name}`);
	if (!tab || !tab.Open) return;
	if (!b_skip_open_collection) HUD.CONTEXT.AddClass("Show");
	tab.Open();
};
GameUI.Collection.ShowTabFlag = (tab_name) => {
	const tab = $(`#Tab_${tab_name}`);
	if (!tab || tab.BHasClass("BActive")) return;
	tab.AddClass("BShowFlag");
};
GameUI.Collection.HideTab = (tab_name) => {
	const tab = $(`#Tab_${tab_name}`);
	if (!tab) return;
	tab.AddClass("Hide");
};

GameUI.Collection.Show = () => {
	HUD.CONTEXT.AddClass("Show");
	GameUI.Collection.CloseSubPanels();
};

function TrackSuppButtonsPressed() {
	$.Schedule(0, TrackSuppButtonsPressed);

	dotaHud.SetHasClass("ShiftPressed", GameUI.IsShiftDown());
	dotaHud.SetHasClass("AltPressed", GameUI.IsAltDown());
	dotaHud.SetHasClass("CtrlPressed", GameUI.IsControlDown());
}

function TimeLeftParse(ms) {
	const s = Math.floor(ms / 1000);
	if (s <= 0) return [0, "sec"];
	if (s >= 86400) return [Math.floor(s / 86400), "day"];
	if (s >= 3600) return [Math.floor(s / 3600), "hour"];
	if (s >= 60) return [Math.floor(s / 60), "min"];

	return [s, "sec"];
}

(() => {
	$.Msg("Collection Init");
	TrackSuppButtonsPressed();

	dotaHud.SetHasClass("CustomBPEnds", true);

	GameUI.Custom_ToggleCollection = ToggleCollectionShow;

	InitCurrencyButtons();
	InitContent();
	// InitSubscriptionConf();

	GameUI.Events.RegisterForEventsDataChanges(InitCurrencyBundles);

	GameUI.Player.RegisterForPlayerDataChanges(UpdatePlayerData);
	HUD.CONTEXT.SetHasClass("BProPlayer", true);
})();