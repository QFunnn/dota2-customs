--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


const ITEM_TYPES = {
	EQUIPMENT: 1,
	CONSUMABLE: 2,
	PASSIVE: 3,
};
const _rarities = GameUI.Inventory.GetRaritiesDefinition();
const RARITIES_DROP_SOUND = {
	[_rarities.COMMON]: "Loot_Drop_Stinger_Uncommon",
	[_rarities.UNCOMMON]: "Loot_Drop_Stinger_Rare",
	[_rarities.RARE]: "Loot_Drop_Stinger_Mythical",
	[_rarities.MYTHICAL]: "ui.treasure_01",
	[_rarities.LEGENDARY]: "ui.treasure_02",
	[_rarities.IMMORTAL]: "ui.treasure_03",
	[_rarities.ARCANA]: "collection.drop_arcana",
	[_rarities.UNIQUE]: "Loot_Drop_Stinger_Uncommon",
};
const SORT_FUNCTIONS = {
	default: function (a, b) {
		return b.loc_name > a.loc_name ? 1 : b.loc_name == a.loc_name ? 0 : -1;
	},
	rarity_up: function (a, b) {
		return a.rarity - b.rarity || SORT_FUNCTIONS["default"](a, b);
	},
	rarity_down: function (a, b) {
		return b.rarity - a.rarity || SORT_FUNCTIONS["default"](a, b);
	},
};

const CONSUMABLE_NEED_CONFIRM = {
	bp_sub_tier_2_consumable: () => {
		return GameUI.Player.GetSubscriptionTier() > 0;
	},
};

const RE_PURCHASEBLE_ITEMS = [
	"bp_reroll",
	"bp_breathtaking_benefaction",
	"bp_legendary_lagresse",
	"bp_gg_token",
	"double_mmr_token",
];