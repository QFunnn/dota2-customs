--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build b9dc48c · 2026-08-02 17:42:46 UTC
  ~ auto-generated — do not edit
]]


ITEM_DEFINITIONS["treasure_starter"] = {
	slot = INVENTORY_SLOTS.TREASURES,
	type = ITEM_TYPES.CONSUMABLE,
	rarity = ITEM_RARITIES.COMMON,
	unlocked_with = {
		currency = 100,
	},
	on_consume = Resolve("OnTreasureUsed", "WebTreasure"),
}

ITEM_DEFINITIONS["treasure_collection_1"] = {
	slot = INVENTORY_SLOTS.TREASURES,
	type = ITEM_TYPES.CONSUMABLE,
	rarity = ITEM_RARITIES.UNCOMMON,
	unlocked_with = {
		currency = 200,
	},
	on_consume = Resolve("OnTreasureUsed", "WebTreasure"),
}

ITEM_DEFINITIONS["treasure_hallowed_shimmer"] = {
	slot = INVENTORY_SLOTS.TREASURES,
	type = ITEM_TYPES.CONSUMABLE,
	rarity = ITEM_RARITIES.MYTHICAL,
	unlocked_with = {
		currency = 150,
	},
	on_consume = Resolve("OnTreasureUsed", "WebTreasure"),
}

ITEM_DEFINITIONS["treasure_winter"] = {
	slot = INVENTORY_SLOTS.TREASURES,
	type = ITEM_TYPES.CONSUMABLE,
	rarity = ITEM_RARITIES.MYTHICAL,
	unlocked_with = {
		currency = 150,
	},
	on_consume = Resolve("OnTreasureUsed", "WebTreasure"),
}

ITEM_DEFINITIONS["treasure_international_2016"] = {
	slot = INVENTORY_SLOTS.TREASURES,
	type = ITEM_TYPES.CONSUMABLE,
	rarity = ITEM_RARITIES.IMMORTAL,
	unlocked_with = {
		currency = 5000,
	},
	on_consume = Resolve("OnTreasureUsed", "WebTreasure"),
	is_hidden = true,
}

ITEM_DEFINITIONS["treasure_international_2017"] = {
	slot = INVENTORY_SLOTS.TREASURES,
	type = ITEM_TYPES.CONSUMABLE,
	rarity = ITEM_RARITIES.IMMORTAL,
	unlocked_with = {
		currency = 5000,
	},
	on_consume = Resolve("OnTreasureUsed", "WebTreasure"),
	is_hidden = true,
}

ITEM_DEFINITIONS["treasure_international_2018"] = {
	slot = INVENTORY_SLOTS.TREASURES,
	type = ITEM_TYPES.CONSUMABLE,
	rarity = ITEM_RARITIES.IMMORTAL,
	unlocked_with = {
		currency = 5000,
	},
	on_consume = Resolve("OnTreasureUsed", "WebTreasure"),
	is_hidden = true,
}

ITEM_DEFINITIONS["treasure_international_2019"] = {
	slot = INVENTORY_SLOTS.TREASURES,
	type = ITEM_TYPES.CONSUMABLE,
	rarity = ITEM_RARITIES.IMMORTAL,
	unlocked_with = {
		currency = 5000,
	},
	on_consume = Resolve("OnTreasureUsed", "WebTreasure"),
	is_hidden = true,
}

ITEM_DEFINITIONS["treasure_newbloom"] = {
	slot = INVENTORY_SLOTS.TREASURES,
	type = ITEM_TYPES.CONSUMABLE,
	rarity = ITEM_RARITIES.MYTHICAL,
	unlocked_with = {
		currency = 150,
	},
	on_consume = Resolve("OnTreasureUsed", "WebTreasure"),
	is_hidden = true,
}

ITEM_DEFINITIONS["gift_free_treasure"] = {
	slot = INVENTORY_SLOTS.TREASURES,
	type = ITEM_TYPES.CONSUMABLE,
	rarity = ITEM_RARITIES.ARCANA,
	unlocked_with = {
		currency = 0,
	},
	on_consume = Resolve("OnTreasureUsed", "WebTreasure"),
	is_hidden = true,
}

ITEM_DEFINITIONS["treasure_emotes_basic"] = {
	slot = INVENTORY_SLOTS.TREASURES,
	type = ITEM_TYPES.CONSUMABLE,
	rarity = ITEM_RARITIES.COMMON,
	unlocked_with = {
		currency = 75,
	},
	on_consume = Resolve("OnTreasureUsed", "WebTreasure"),
}

ITEM_DEFINITIONS["treasure_emotes_deluxe"] = {
	slot = INVENTORY_SLOTS.TREASURES,
	type = ITEM_TYPES.CONSUMABLE,
	rarity = ITEM_RARITIES.UNCOMMON,
	unlocked_with = {
		currency = 125,
	},
	on_consume = Resolve("OnTreasureUsed", "WebTreasure"),
}

ITEM_DEFINITIONS["treasure_high_fives"] = {
	slot = INVENTORY_SLOTS.TREASURES,
	type = ITEM_TYPES.CONSUMABLE,
	rarity = ITEM_RARITIES.MYTHICAL,
	unlocked_with = {
		currency = 350,
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