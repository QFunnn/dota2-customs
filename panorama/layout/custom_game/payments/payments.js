--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


const CONTEXT = $.GetContextPanel();
const PAYMENT_WINDOW = $("#PaymentWindow");
const PAYMENT_BUTTON_DEC_COUNT = $("#Dec");
const PAYMENT_BUTTON_INC_COUNT = $("#Inc");

const HTML_VIEWER = $("#HTMLViewer");
const HTML_CONTENT = $("#HTML_Content");

const ITEM_IMAGE = $("#ItemImage");
const GIFT_CODE_CHECKBOX = $("#GiftCodeCheckbox");
const PRICE_LABEL = $("#ItemPrice");
const BONUS_ITEMS_CONTAINER = $("#BonusItemsByPurchase");
const CURRENCY_SLOTTED_SLIDER = $("#ItemCountSlider");

let CURRENT_REGION = GetRegion();
let CURRENT_PRODUCT_NAME;
let CURRENT_PAYMENT_MODE = "payment";
let CURRENT_GIFT_CODE_STATUS;
let CURRENT_QUANTITY = 1;
let IS_AUTOMATIC_UPGRADE_ACTIVE = false;
let LOADING_SCHEDULE;
let CACHED_REWARDS;

function GetRegion() {
	return LANGUAGE_TO_REGION[$.Language()] ? LANGUAGE_TO_REGION[$.Language()] : "default";
}

function ClosePaymentWindow() {
	PAYMENT_WINDOW.SetHasClass("visible", false);
	CONTEXT.SetHasClass("fade", false);
	CONTEXT.SetHasClass("show_payment_type", false);
	CONTEXT.SetHasClass("show_sub_bonus_items", false);
	CURRENT_PAYMENT_MODE = "payment";
}

let current_currency_type;
function SetQuantity(value) {
	let max_stock = Infinity;

	let total_price = 0;
	if (GameUI.IsProductHasPrice(CURRENT_PRODUCT_NAME))
		total_price = Math.floor(GameUI.GetProductPrice(CURRENT_PRODUCT_NAME) * value * 100) / 100;

	for (const [_name, _count] of Object.entries(CACHED_REWARDS || {}))
		PAYMENT_WINDOW.SetDialogVariable(_name, FormatBigNumber(_count * value));

	if (current_currency_type == "Currency") {
		const currency_price = GameUI.GetProductCurrencyPrice(CURRENT_PRODUCT_NAME);
		max_stock = Math.floor(GameUI.Player.GetCurrency() / currency_price);
		value = Math.min(value, max_stock);
		total_price = currency_price * value;
	}

	CURRENT_QUANTITY = value;
	PAYMENT_BUTTON_DEC_COUNT.SetHasClass("blocked", CURRENT_QUANTITY == 1);
	PAYMENT_BUTTON_INC_COUNT.SetHasClass("blocked", value == max_stock);
	PAYMENT_WINDOW.SetDialogVariableInt("quantity", value);

	PRICE_LABEL.SetDialogVariable("price", total_price.toFixed(2));

	PAYMENT_WINDOW.SetDialogVariableInt(
		"current_currency_price",
		GetPrice(1, GameUI.GetProductCurrencyPrice(CURRENT_PRODUCT_NAME)),
	);

	if (CURRENT_QUANTITY > 1) {
		const header = $.Localize(`#${CURRENT_PRODUCT_NAME}`);
		PAYMENT_WINDOW.SetDialogVariable("item_name", `${header} - x${CURRENT_QUANTITY}`);
	} else PAYMENT_WINDOW.SetDialogVariableLocString("item_name", CURRENT_PRODUCT_NAME);
	ChangeBonusItemsQuantity(value);
}

function ModifyQuantity(value) {
	if (GameUI.IsShiftDown()) value *= 5;
	if (GameUI.IsAltDown()) value *= 10;
	if (GameUI.IsControlDown()) value *= 50;
	if (!CURRENT_PRODUCT_NAME || GameUI.IsQuantityDisabledForProduct(CURRENT_PRODUCT_NAME)) return;
	CURRENT_QUANTITY = Math.max(CURRENT_QUANTITY + value, 1);

	SetQuantity(CURRENT_QUANTITY);
}

function SetGiftCodeCheckboxStatus(status) {
	if (CONTEXT.BHasClass("forced_gift_code")) status = true;
	// if no status is passed, toggle current or default to true (since this is triggered from button) if no current is found
	if (status === undefined) status = CURRENT_GIFT_CODE_STATUS !== undefined ? !CURRENT_GIFT_CODE_STATUS : true;

	if (!CONTEXT.BHasClass("forced_gift_code")) CONTEXT.SetHasClass("gift_code_selected_manually", status);

	CURRENT_GIFT_CODE_STATUS = status;
	GIFT_CODE_CHECKBOX.selected = status;
	GIFT_CODE_CHECKBOX.SetSelected(status);
}

/**
 *
 * @param {"recurring" | "payment"} payment_mode
 */
function SetPaymentMode(payment_mode) {
	if (payment_mode == "subscription") ChangeCurrencyType("Money");
	if (CONTEXT.BHasClass("forced_payment")) return;
	SetQuantity(1);
	CONTEXT.SwitchClass("type_of_payment", `PaymentType_${payment_mode}`);
	CURRENT_PAYMENT_MODE = payment_mode;

	ProcessSubscriptionRestrictions();
}

function ProcessSubscriptionRestrictions() {
	if (CURRENT_PRODUCT_NAME.indexOf("subscription_tier") <= -1) return;
	const subscription_data = GameUI.Player.GetSubscriptionData();
	// payment restrictions are only applicable for ongoing subs
	if (!subscription_data || !subscription_data.type || subscription_data.tier == 0) return;

	const purchased_tier = Number(CURRENT_PRODUCT_NAME.slice(-1));
	const is_same_tier_purchased = subscription_data.tier == purchased_tier;
	const is_current_sub_automatic = subscription_data.type == "automatic";

	CONTEXT.SwitchClass("payment_restriction", `no_restriction`);
	IS_AUTOMATIC_UPGRADE_ACTIVE = false;

	const is_trial = subscription_data.metadata && subscription_data.metadata.source == "Trial";

	// purchasing same automatic tier or tier lower (regardless of type)
	// allow only gifting of one-time subs
	if ((is_same_tier_purchased && is_current_sub_automatic) || subscription_data.tier > purchased_tier || is_trial) {
		CONTEXT.SetHasClass("forced_payment", true);
		CONTEXT.SetHasClass("forced_gift_code", true);
		CONTEXT.SetHasClass("show_payment_type", false);
		SetGiftCodeCheckboxStatus(true);
		SetPaymentMode("payment");
	} else if (purchased_tier > subscription_data.tier && is_current_sub_automatic) {
		// upgrading automatic subscription
		// - if one-time is selected, allow only gift codes
		// - if recurring is selected, allow only previous payment method
		if (CURRENT_PAYMENT_MODE == "payment") {
			CONTEXT.SetHasClass("forced_gift_code", true);
			SetGiftCodeCheckboxStatus(true);
		} else {
			CONTEXT.SwitchClass("payment_restriction", `only_${subscription_data.metadata.source}`);
			IS_AUTOMATIC_UPGRADE_ACTIVE = true;
		}
	}
}

function InitiatePaymentFor(product_name) {
	if (!PRODUCTS[product_name]) {
		$.Msg(`>> UNRECOGNIZED PRODUCT NAME: [${product_name}]`);
		return;
	}
	CACHED_REWARDS = GameUI.GetProductRewards(product_name);
	CURRENT_PRODUCT_NAME = product_name;

	CONTEXT.SetHasClass("forced_payment", false);
	CONTEXT.SetHasClass("forced_gift_code", false);
	CONTEXT.SwitchClass("payment_restriction", `no_restriction`);
	IS_AUTOMATIC_UPGRADE_ACTIVE = false;

	ChangeCurrencyType(GameUI.IsProductHasPrice(product_name) ? "Money" : "Currency");
	SetQuantity(1);

	PAYMENT_WINDOW.SetHasClass("gift_codes_disabled", GameUI.AreGiftCodesDisabledForProduct(product_name));
	PAYMENT_WINDOW.SetHasClass("count_disabled", GameUI.IsQuantityDisabledForProduct(product_name));

	PAYMENT_WINDOW.SetDialogVariableLocString("item_name", product_name);
	PAYMENT_WINDOW.SetDialogVariableLocString("item_description", `${product_name}_description`);

	const b_has_price = GameUI.IsProductHasPrice(CURRENT_PRODUCT_NAME);
	if (b_has_price) PAYMENT_WINDOW.SetDialogVariable("price", GameUI.GetProductPrice(product_name));

	PAYMENT_WINDOW.SetHasClass("BHasPrice", b_has_price);

	ITEM_IMAGE.SetImage(GameUI.GetProductIcon(product_name));

	SetGiftCodeCheckboxStatus(false);
	PAYMENT_WINDOW.SetHasClass("visible", true);
	CONTEXT.SetHasClass("fade", true);

	const is_subscription_purchased = product_name.indexOf("subscription_tier") > -1;

	CONTEXT.SwitchClass("type_of_payment", "PaymentType_payment");
	CONTEXT.SwitchClass("product", `Product_${product_name}`);
	CONTEXT.SetHasClass("show_payment_type", is_subscription_purchased);
	CONTEXT.SetHasClass("show_sub_bonus_items", is_subscription_purchased);
	if (is_subscription_purchased) CONTEXT.SetDialogVariableLocString("boost_duration_name", product_name);

	const currency_price = GameUI.GetProductCurrencyPrice(product_name);
	const is_valid_currency_price = currency_price != "UNSET";
	const is_valid_supp = product_name == "subscription_tier_1" ? GameUI.Player.GetSubscriptionTier() < 2 : true;

	PAYMENT_WINDOW.SetHasClass("show_currency_type", is_valid_currency_price && is_valid_supp);

	if (is_subscription_purchased) {
		ProcessSubscriptionRestrictions();
	}
	OnCurrencySubDurationChanged();
}

function ChangeCurrencyType(type) {
	if (type == "Currency") {
		SetPaymentMode("payment");
		CURRENCY_SLOTTED_SLIDER.value = 0;
	} else CURRENCY_SLOTTED_SLIDER.value = 1;

	InitBonusItems();

	current_currency_type = type;
	PAYMENT_WINDOW.SwitchClass("payment_currency_type", `CurrencyType_${type}`);
	SetQuantity(1);
	OnCurrencySubDurationChanged();
}

function RequestPaymentUrlWithMethod(method, payment_system) {
	if (!CURRENT_PRODUCT_NAME) return;

	Game.EmitSound("General.Buy");
	const event_name = IS_AUTOMATIC_UPGRADE_ACTIVE
		? "WebPayments:get_subscription_upgrade_url"
		: "WebPayments:get_payment_url";
	GameEvents.SendToServerEnsured(event_name, {
		payment_mode: CURRENT_PAYMENT_MODE,
		payment_method: method,
		product_name: CURRENT_PRODUCT_NAME,
		payment_system: payment_system || "stripe",
		region: CURRENT_REGION,
		quantity: CURRENT_QUANTITY || 1,
		as_gift_code: CURRENT_GIFT_CODE_STATUS,
	});
	CURRENT_PRODUCT_NAME = undefined;

	ClosePaymentWindow();
	$.Msg(`Creating ${method} ${PAYMENT_METHOD_TO_MODE[method]}`);
	if (PAYMENT_METHOD_TO_MODE?.[method] != PAYMENT_MODES.EXTERNAL) SetHTMLViewerStatus("loading");
}

function PurchaseItemByCurrency() {
	if (!CURRENT_PRODUCT_NAME) return;
	if (current_currency_price > GameUI.Player.GetCurrency()) {
		OpenGloryShop();
		return;
	}

	let item_data = { product_name: CURRENT_PRODUCT_NAME };

	if (CURRENT_PRODUCT_NAME.indexOf("subscription_tier") > -1 && current_currency_type == "Currency")
		item_data.duration_override = sub_duration;

	GameEvents.SendToServerEnsured("Payments:purchase_with_currency", item_data);
	ClosePaymentWindow();
}

function OpenPatreonURL() {
	$.DispatchEvent("ExternalBrowserGoToURL", PATREON_URL);
	ClosePaymentWindow();
}

function SetHTMLViewerStatus(status) {
	HTML_VIEWER.SwitchClass("status", status);

	if (status == "closed" && LOADING_SCHEDULE !== undefined) {
		LOADING_SCHEDULE = $.CancelScheduled(LOADING_SCHEDULE);
	}
}

function LoadingTimer() {
	// toggle window display when payment URL finishes loading in background
	if (HTML_CONTENT.BHasClass("HTMLContentLoaded")) {
		$.Schedule(5, () => {
			SetHTMLViewerStatus("ready");
		});
		LOADING_SCHEDULE = undefined;
		return;
	}
	LOADING_SCHEDULE = $.Schedule(1, LoadingTimer);
}

function OpenPaymentURL(event) {
	if (!event.url) return;
	$.Msg(`Opening ${event.method} ${PAYMENT_METHOD_TO_MODE[event.method]}`);
	// Stripe wechat / alipay are opened in in-game browser
	if (event.method && PAYMENT_METHOD_TO_MODE?.[event.method] != PAYMENT_MODES.EXTERNAL) {
		HTML_CONTENT.SetURL(event.url);
		LoadingTimer();
		return;
	}
	$.DispatchEvent("ExternalBrowserGoToURL", event.url);
}

function InitBonusItems() {
	BONUS_ITEMS_CONTAINER.RemoveAndDeleteChildren();

	const items_list = PRODUCTS[CURRENT_PRODUCT_NAME].bonus_items_for_currency;
	if (!items_list) return;

	Object.keys(items_list).forEach((item_name) => {
		const item = $.CreatePanel("Panel", BONUS_ITEMS_CONTAINER, `BonusItem_${item_name}`);
		item.BLoadLayoutSnippet("BonusItem");

		item.FindChildTraverse("BonusItem_Icon").SetImage(GameUI.Inventory.GetItemImagePath(item_name));

		item.SwitchClass("rarity", GameUI.Inventory.GetItemRarityName(item_name) || "COMMON");
		item.SwitchClass("slot", GameUI.Inventory.GetItemSlotName(item_name) || "NONE");

		item.SetDialogVariableLocString("item_name", item_name);
		item.SetDialogVariableInt("item_count", 0);
		item.item_name = item_name;
		item.count = 0;
	});
}

function ChangeBonusItemsQuantity(multiplier) {
	if (!PRODUCTS[CURRENT_PRODUCT_NAME] || !PRODUCTS[CURRENT_PRODUCT_NAME].bonus_items_for_currency) return;
	BONUS_ITEMS_CONTAINER.Children().forEach((item) => {
		item.SetDialogVariableInt(
			"item_count",
			Math.floor(PRODUCTS[CURRENT_PRODUCT_NAME].bonus_items_for_currency[item.item_name] * multiplier),
		);
	});
}

let sub_duration = 30;
let current_currency_price;
function OnCurrencySubDurationChanged() {
	sub_duration = Math.float_interpolate(1, 30, CURRENCY_SLOTTED_SLIDER.value);
	PAYMENT_WINDOW.SetDialogVariableInt("sub_duration", sub_duration);

	const duration_multiplier = sub_duration / 30.0;

	ChangeBonusItemsQuantity(duration_multiplier);

	current_currency_price = GetPrice(sub_duration, GameUI.GetProductCurrencyPrice(CURRENT_PRODUCT_NAME));

	PAYMENT_WINDOW.SetHasClass("BNotEnoughCurrencyForPurchase", current_currency_price > GameUI.Player.GetCurrency());

	PAYMENT_WINDOW.SetDialogVariableInt("current_currency_price", current_currency_price);
}

function ModifySubDuration(value) {
	CURRENCY_SLOTTED_SLIDER.value = (Math.clamp(sub_duration + value, 1, 30) - 1) / 29;
}

function OpenGloryShop() {
	ClosePaymentWindow();
	GameUI.Collection.OpenSubPanel("C_PayCurrency");
}

function UpdatePlayerData(player_data) {
	CONTEXT.SwitchClass("current_sub_tier", `CurrentSub_${player_data?.subscription?.tier}`);
}

(() => {
	GameUI.InitiatePaymentFor = InitiatePaymentFor;

	GameUI.RequestCustomerPortalURL = () => {
		GameEvents.SendToServerEnsured("WebPayments:get_customer_portal_url", {});
	};

	GameUI.RequestUpgradeURL = () => {
		GameEvents.SendToServerEnsured("WebPayments:get_subscription_upgrade_url", {});
	};

	const frame = GameEvents.NewProtectedFrame($.GetContextPanel());

	frame.SubscribeProtected("WebPayments:open_in_external_browser", OpenPaymentURL);

	SetHTMLViewerStatus("closed");
	GameUI.Player.RegisterForPlayerDataChanges(UpdatePlayerData);
})();