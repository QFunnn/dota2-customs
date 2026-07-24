--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


const CURRENCY_BUTTONS = {
	// fortune: true,
	currency: true,
};

const TABS = {
	// battle_pass: true,
	// masteries: true,
	chat_wheel: true,
	cosmetics: true,
	gift_codes: true,
	subscription: true,
	profile: true,
};

const TABS_FIRST_OPEN_CALLBACKS = {
	gift_codes: () => {
		GameUI.GetGiftCodes();
	},
	profile: () => {
		GameUI.ProfileOpenCurrentMap();
	},
};

const BOOST_BONUSES = {
	1: {
		// currency: 300,
		fast_pick: null,
		instant_delivery: null,
		common_ability_choice: 1,
		rerolls: 4,
		consumable_rerolls: 40,
		legendary_lagresses: 5,
		// fortune: 15,
		// exp: 3000,

		// exp_boost: 100,
		// daily: 1,
		// supp_items: null,
		// dev_chat: null,
	},
	2: {
		// currency: 2000,
		fastest_pick: null,
		instant_delivery: null,
		ability_choice: 1,
		rerolls: 8,
		consumable_rerolls: 80,
		breathtaking_benefactions: 5,

		// fortune: 150,
		// exp: 10000,
		// exp_boost: 300,
		// daily: 2,
		// supp_items_2: null,
		// dev_chat: null,
	},
};

const CURRENCY_SHOP_IMAGE_PATH_EXT = "";
const CURRENCY_SHOP_OFFERS_IN_LINE = 3;
const additional_currency_packs = {
	// daily_fortune: {
	// 	rewards: { fortune: 1 },
	// 	callback: () => {
	// 		$.Msg(1);
	// 	},
	// },
};