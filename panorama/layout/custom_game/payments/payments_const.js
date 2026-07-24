--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


const PATREON_URL = "https://www.patreon.com/CustomHeroClash";

const CURRENCIES = {
	CNY: "cny",
	USD: "usd",
};

const LANGUAGE_TO_CURRENCY = {
	schinese: CURRENCIES.CNY,
	tchinese: CURRENCIES.CNY,
};

const LANGUAGE_TO_REGION = {
	schinese: "china",
	tchinese: "china",
	russian: "russia",
};

const PAYMENT_MODES = {
	PAYMENT: "payment",
	SUBSCRIPTION: "subscription",
	EXTERNAL: "_",
};

const CURRENCY_TEMPLATE = {
	schinese: "{s:price}元",
	tchinese: "{s:price}元",
};

// wechat and alipay can't use recurring payments
const PAYMENT_METHOD_TO_MODE = {
	wechat_pay: PAYMENT_MODES.PAYMENT,
	alipay: PAYMENT_MODES.PAYMENT,
	card: PAYMENT_MODES.EXTERNAL,
	patreon: PAYMENT_MODES.EXTERNAL,
	sberpay_ru: PAYMENT_MODES.EXTERNAL,
	card_ru: PAYMENT_MODES.EXTERNAL,
	tbank_ru: PAYMENT_MODES.EXTERNAL,
	yoomoney_ru: PAYMENT_MODES.EXTERNAL,
};

const PRODUCTS = {
	/*
	SUPPORTED FIELDS:
	price - dict of currency => value of per-unit price
	icon - path to item image
	gift_codes_disabled - flag to disable gift coding entirely
	quantity_disabled - flag to disable variable quantity for item
	rewards - dict of item => value for certain previews to show rewards given from purchase
	bonus - bonus (in pct) of value per cent of cost this item has compared to predecessor
	*/
	subscription_tier_1: {
		// price: {
		// 	[CURRENCIES.CNY]: 48,
		// 	[CURRENCIES.USD]: 6.99,
		// },
		currency_price: 8000,
		icon: "file://{images}/custom_game/payments/products/subscription_tier_1.jpg",
		bonus_items_for_currency: {
			bp_reroll: 40,
			bp_legendary_lagresse: 5,
		},
	},
	subscription_tier_2: {
		// price: {
		// 	[CURRENCIES.CNY]: 168,
		// 	[CURRENCIES.USD]: 24.99,
		// },
		currency_price: 30000,
		icon: "file://{images}/custom_game/payments/products/subscription_tier_2.jpg",
		bonus_items_for_currency: {
			bp_reroll: 80,
			bp_breathtaking_benefaction: 5,
		},
	},
	battle_pass_tier_2: {
		// price: {
		// 	[CURRENCIES.CNY]: 58,
		// 	[CURRENCIES.USD]: 7.99,
		// },
		icon: "file://{images}/custom_game/collection/battle_pass/bp_logo_item.png",
		gift_codes_disabled: true,
		quantity_disabled: true,
	},
	battle_pass_extra_rewards_bundle: {
		// price: {
		// 	[CURRENCIES.CNY]: 168,
		// 	[CURRENCIES.USD]: 24.99,
		// },
		icon: "file://{images}/custom_game/collection/battle_pass/bp_extra_items.png",
		gift_codes_disabled: true,
		quantity_disabled: true,
	},
	currency_bundle_1: {
		price: {
			[CURRENCIES.CNY]: 7,
			[CURRENCIES.USD]: 1,
		},
		// rewards: { currency: 100, fortune: 2 },
		rewards: { currency: 1000, consumable_rerolls: 4 },
		icon: "file://{images}/custom_game/collection/currency_shop/currency_bundle_2.png",
	},
	currency_bundle_2: {
		price: {
			[CURRENCIES.CNY]: 35,
			[CURRENCIES.USD]: 5,
		},
		rewards: { currency: 5500, consumable_rerolls: 22 },
		// bonus: 10,
		icon: "file://{images}/custom_game/collection/currency_shop/currency_bundle_2.png",
	},
	currency_bundle_3: {
		price: {
			[CURRENCIES.CNY]: 68,
			[CURRENCIES.USD]: 10,
		},
		rewards: { currency: 11500, consumable_rerolls: 46 },
		// bonus: 15,
		// popular: true,
		icon: "file://{images}/custom_game/collection/currency_shop/currency_bundle_2.png",
	},
	currency_bundle_4: {
		price: {
			[CURRENCIES.CNY]: 138,
			[CURRENCIES.USD]: 20,
		},
		rewards: { currency: 25000, consumable_rerolls: 120 },
		// bonus: 20,
		icon: "file://{images}/custom_game/collection/currency_shop/currency_bundle_2.png",
	},
	currency_bundle_5: {
		price: {
			[CURRENCIES.CNY]: 348,
			[CURRENCIES.USD]: 50,
		},
		rewards: { currency: 65000, consumable_rerolls: 260 },
		// bonus: 30,
		icon: "file://{images}/custom_game/collection/currency_shop/currency_bundle_2.png",
	},
	currency_bundle_6: {
		price: {
			[CURRENCIES.CNY]: 688,
			[CURRENCIES.USD]: 100,
		},
		rewards: { currency: 150000, consumable_rerolls: 600 },
		// bonus: 50,
		icon: "file://{images}/custom_game/collection/currency_shop/currency_bundle_2.png",
	},
};

GameUI.GetPriceTemplate = function () {
	return CURRENCY_TEMPLATE[$.Language()] || "${s:price}";
};

GameUI.IsQuantityDisabledForProduct = function (product_name) {
	if (!PRODUCTS[product_name]) return true;
	return PRODUCTS[product_name].quantity_disabled === true;
};

GameUI.AreGiftCodesDisabledForProduct = function (product_name) {
	if (!PRODUCTS[product_name]) return true;
	return PRODUCTS[product_name].gift_codes_disabled === true;
};

GameUI.IsProductHasPrice = function (product_name) {
	const product = PRODUCTS[product_name];
	if (!product) return false;
	return product.price != undefined;
};
GameUI.GetProductPrice = function (product_name) {
	const currency = LANGUAGE_TO_CURRENCY[$.Language()] || CURRENCIES.USD;
	const product = PRODUCTS[product_name];
	if (!product) return -1;
	return product.price[currency] || -1;
};

GameUI.GetProductCurrencyPrice = function (product_name) {
	const product = PRODUCTS[product_name];
	if (!product) return "UNSET";
	return product.currency_price || "UNSET";
};

GameUI.GetProductPriceTemplated = function (product_name) {
	const price = GameUI.GetProductPrice(product_name);
	const template = GameUI.GetPriceTemplate();
	return template.replace("{s:price}", price);
};

GameUI.GetProductIcon = function (product_name) {
	const product = PRODUCTS[product_name];
	if (!product || !product.icon) return `file://{images}/custom_game/payments/products/${product_name}.png`;
	return product.icon;
};

GameUI.GetProducts = function () {
	return PRODUCTS;
};
GameUI.GetProductRewards = function (product_name) {
	return PRODUCTS[product_name]?.rewards;
};
let min_days = 1;
let max_days = 30;
let step_coefficient = 0.9;
let max_multiplier = 1.5;

function GetPrice(days, max_price) {
	let base_price = Math.ceil(max_price / max_days);

	const raw_price =
		base_price *
		(max_multiplier +
			(max_days - max_multiplier) * Math.pow((days - min_days) / (max_days - min_days), step_coefficient));

	return Math.min(Math.ceil(raw_price / 100) * 100, max_price);
}