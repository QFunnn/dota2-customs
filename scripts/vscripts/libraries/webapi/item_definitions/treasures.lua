--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


ITEM_DEFINITIONS["treasure_1"] = {
	slot = INVENTORY_SLOTS.TREASURES,
	type = ITEM_TYPES.CONSUMABLE,
	rarity = ITEM_RARITIES.UNCOMMON,

	unlocked_with = {
		currency = 150
	},

	on_consume = Resolve("OnTreasureUsed", "WebTreasure"),
}
ITEM_DEFINITIONS["treasure_2"] = {
	slot = INVENTORY_SLOTS.TREASURES,
	type = ITEM_TYPES.CONSUMABLE,
	rarity = ITEM_RARITIES.RARE,

	unlocked_with = {
		currency = 300
	},

	on_consume = Resolve("OnTreasureUsed", "WebTreasure"),
}

ITEM_DEFINITIONS["treasure_3"] = {
	slot = INVENTORY_SLOTS.TREASURES,
	type = ITEM_TYPES.CONSUMABLE,
	rarity = ITEM_RARITIES.MYTHICAL,

	unlocked_with = {
		currency = 800
	},

	on_consume = Resolve("OnTreasureUsed", "WebTreasure"),
}
ITEM_DEFINITIONS["treasure_chat_wheel_1"] = {
	slot = INVENTORY_SLOTS.TREASURES,
	type = ITEM_TYPES.CONSUMABLE,
	rarity = ITEM_RARITIES.UNCOMMON,
	unlocked_with = {
		currency = 499,
	},
	on_consume = Resolve("OnTreasureUsed", "WebTreasure"),
}

ITEM_DEFINITIONS["treasure_chat_wheel_2"] = {
	slot = INVENTORY_SLOTS.TREASURES,
	type = ITEM_TYPES.CONSUMABLE,
	rarity = ITEM_RARITIES.RARE,
	unlocked_with = {
		currency = 699,
	},
	on_consume = Resolve("OnTreasureUsed", "WebTreasure"),
}

ITEM_DEFINITIONS["treasure_chat_wheel_dc"] = {
	slot = INVENTORY_SLOTS.TREASURES,
	type = ITEM_TYPES.CONSUMABLE,
	rarity = ITEM_RARITIES.MYTHICAL,
	unlocked_with = {
		currency = 499,
	},
	on_consume = Resolve("OnTreasureUsed", "WebTreasure"),
}