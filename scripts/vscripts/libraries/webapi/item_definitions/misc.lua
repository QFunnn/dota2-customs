--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]



BP_REWARD_DEFINITION_UNIQUE = {
	slot = INVENTORY_SLOTS.MISC,
	type = ITEM_TYPES.PASSIVE,
	rarity = ITEM_RARITIES.UNIQUE,
	is_hidden = true,
}

BP_REWARD_DEFINITION_COMMON = {
	slot = INVENTORY_SLOTS.MISC,
	type = ITEM_TYPES.PASSIVE,
	rarity = ITEM_RARITIES.COMMON,
	is_hidden = true,
}

ITEM_DEFINITIONS["battle_pass_tier_2"] = BP_REWARD_DEFINITION_UNIQUE
ITEM_DEFINITIONS["battle_pass_extra_rewards_bundle"] = BP_REWARD_DEFINITION_UNIQUE

-- this item signifies amount of bonus rerolls available to player
-- which can be accessed via WebInventory:GetItemCount(player_id, "bp_reroll")
ITEM_DEFINITIONS["bp_reroll"] = {
	slot = INVENTORY_SLOTS.MISC,
	type = ITEM_TYPES.PASSIVE,
	rarity = ITEM_RARITIES.COMMON,

	unlocked_with = {
		currency = 10
	},
}


ITEM_DEFINITIONS["bp_tipping_hand"] = BP_REWARD_DEFINITION_COMMON
ITEM_DEFINITIONS["bp_golden_hand"] = {
	slot = INVENTORY_SLOTS.MISC,
	type = ITEM_TYPES.PASSIVE,
	rarity = ITEM_RARITIES.UNCOMMON,
	is_hidden = true,
}

ITEM_DEFINITIONS["bp_power_crystal"] = BP_REWARD_DEFINITION_COMMON

ITEM_DEFINITIONS["bp_conqueror_presence"] = BP_REWARD_DEFINITION_COMMON

ITEM_DEFINITIONS["bp_lucky_trinket_common"] = BP_REWARD_DEFINITION_COMMON

ITEM_DEFINITIONS["bp_lucky_trinket_rare"] = {
	slot = INVENTORY_SLOTS.MISC,
	type = ITEM_TYPES.PASSIVE,
	rarity = ITEM_RARITIES.RARE,
	is_hidden = true,
}
ITEM_DEFINITIONS["bp_lucky_trinket_epic"] = {
	slot = INVENTORY_SLOTS.MISC,
	type = ITEM_TYPES.PASSIVE,
	rarity = ITEM_RARITIES.MYTHICAL,
	is_hidden = true,
}

ITEM_DEFINITIONS["bp_teamwork_enhancer"] = BP_REWARD_DEFINITION_COMMON

ITEM_DEFINITIONS["bp_gg_token"] = {
	slot = INVENTORY_SLOTS.MISC,
	type = ITEM_TYPES.PASSIVE,
	rarity = ITEM_RARITIES.UNCOMMON,

	unlocked_with = {
		currency = 150
	},

	on_consume = Resolve("OnGGTokenConsumed", "BattlePass")
}

ITEM_DEFINITIONS["bp_legendary_lagresse"] = {
	slot = INVENTORY_SLOTS.MISC,
	type = ITEM_TYPES.CONSUMABLE,
	rarity = ITEM_RARITIES.LEGENDARY,
	unlocked_with = {
		currency = 350
	},

	on_consume = Resolve("OnLegendaryLagresseConsumed", "BattlePass"),
}

ITEM_DEFINITIONS["bp_breathtaking_benefaction"] = {
	slot = INVENTORY_SLOTS.MISC,
	type = ITEM_TYPES.CONSUMABLE,
	rarity = ITEM_RARITIES.ARCANA,

	unlocked_with = {
		currency = 700
	},

	on_consume = Resolve("OnBreathtakingBenefactionUsed", "BattlePass"),
}

ITEM_DEFINITIONS["bp_early_bird_charm"] = {
	slot = INVENTORY_SLOTS.MISC,
	type = ITEM_TYPES.PASSIVE,
	rarity = ITEM_RARITIES.UNCOMMON,
	is_hidden = true,
}


ITEM_DEFINITIONS["bp_sub_tier_2_consumable"] = {
	slot = INVENTORY_SLOTS.MISC,
	type = ITEM_TYPES.CONSUMABLE,
	rarity = ITEM_RARITIES.RARE,
	is_hidden = true,

	compensation_value = 2000,

	on_consume = Resolve("OnSubTierConsumableUsed", "BattlePass")
}

ITEM_DEFINITIONS["double_mmr_token"] = {
	slot = INVENTORY_SLOTS.MISC,
	type = ITEM_TYPES.PASSIVE,
	rarity = ITEM_RARITIES.UNCOMMON,

	unlocked_with = {
		currency = 250
	},

	on_consume = Resolve("OnDoubleMMRTokenConsumed", "BattlePass")
}