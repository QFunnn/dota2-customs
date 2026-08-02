--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build b9dc48c · 2026-08-02 17:42:46 UTC
  ~ auto-generated — do not edit
]]


ITEM_DEFINITIONS["double_mmr_token"] = {
	slot = INVENTORY_SLOTS.MISC,
	type = ITEM_TYPES.PASSIVE,
	rarity = ITEM_RARITIES.RARE,

	unlocked_with = {
		currency = 250,
	},

	on_consume = Resolve("OnDoubleMMRTokenConsumed", "BattlePass"),
}

ITEM_DEFINITIONS["reset_mmr"] = {
	slot = INVENTORY_SLOTS.MISC,
	type = ITEM_TYPES.PASSIVE,
	rarity = ITEM_RARITIES.LEGENDARY,

	unlocked_with = {
		currency = 11250,
	},

	on_consume = Resolve("OnResetMMRUsed", "BattlePass"),
}

ITEM_DEFINITIONS["glory_pack_50"] = {
	slot = INVENTORY_SLOTS.MISC,
	type = ITEM_TYPES.EQUIPMENT,
	rarity = ITEM_RARITIES.COMMON,
	unlocked_with = {
		treasure = "gift_free_treasure",
	},
	on_consume = Resolve("OnGloryPackUsed", "BattlePass"),
	is_hidden = true,
}

ITEM_DEFINITIONS["glory_pack_100"] = {
	slot = INVENTORY_SLOTS.MISC,
	type = ITEM_TYPES.EQUIPMENT,
	rarity = ITEM_RARITIES.RARE,
	unlocked_with = {
		treasure = "gift_free_treasure",
	},
	on_consume = Resolve("OnGloryPackUsed", "BattlePass"),
	is_hidden = true,
}

ITEM_DEFINITIONS["glory_pack_150"] = {
	slot = INVENTORY_SLOTS.MISC,
	type = ITEM_TYPES.EQUIPMENT,
	rarity = ITEM_RARITIES.IMMORTAL,
	unlocked_with = {
		treasure = "gift_free_treasure",
	},
	on_consume = Resolve("OnGloryPackUsed", "BattlePass"),
	is_hidden = true,
}

ITEM_DEFINITIONS["glory_pack_200"] = {
	slot = INVENTORY_SLOTS.MISC,
	type = ITEM_TYPES.EQUIPMENT,
	rarity = ITEM_RARITIES.ARCANA,
	unlocked_with = {
		treasure = "gift_free_treasure",
	},
	on_consume = Resolve("OnGloryPackUsed", "BattlePass"),
	is_hidden = true,
}