--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


-- default player rating in case for some reason backend haven't supplied any
DEFAULT_RATING = 1500

-- Poll match events from backend every 240 seconds by default, every 10 seconds when polling is active
-- (i.e. when payment was initiated and we expect purchase result)
-- is always at 10 seconds in tools
MATCH_EVENT_DEFAULT_POLL_DELAY = IsInToolsMode() and 10 or 240
MATCH_EVENT_ACTIVE_POLL_DELAY = 10

-- send errors (if any) to backend server every 120 seconds
ERROR_TRACKING_REQUEST_DELAY = 120

-- send settings update if 120 seconds have passed since last modification from any player
SETTINGS_REQUEST_DELAY = IsInToolsMode() and 5 or 60

-- send equipment update changes (if any) to backend server every 1 minute (5 seconds in tools)
EQUIPMENT_UPDATE_DELAY = IsInToolsMode() and 5 or 60

-- custom attachment to indicate that particle is using status effect
-- which can only be created as a part of modifier
PATTACH_SPECIAL_STATUS_FX = "STATUS_FX"

-- equipment slots enum to send to backend
-- UNDER ANY CIRCUMSTANCES, DO NOT CHANGE IDS OF SLOTS IN USE
INVENTORY_SLOTS = {
	SPRAY = "1",
	AURA = "2",
	HERO_EFFECT = "3",
	KILL_EFFECT = "4",
	PET = "5",
	COSMETIC_SKILL = "6",
	HIGH_FIVE = "7",

	TREASURES = "98",
	MISC = "99",
	-- unused, for future work
	VOICE_LINE = "100"
}

-- item types, describes possible actions done to item
ITEM_TYPES = {
	EQUIPMENT = 1,
	CONSUMABLE = 2,
	-- passive items don't cannot be used directly in any way
	-- instead, their presense (usually) enables other systems/mechanics
	PASSIVE = 3,
}

-- WARNING: integer values used must ascend, since some places are using rarity as a threshold
-- discarding lower or higher values
-- breaking the order WILL break the logic in said places
ITEM_RARITIES = {
	COMMON = 1,
	UNCOMMON = 2,
	RARE = 3,
	MYTHICAL = 4,
	LEGENDARY = 5,
	IMMORTAL = 6,
	ARCANA = 7,

	UNIQUE = 99,
}


-- random weights for treasure roll
-- higher weight = higher chance to drop
TREASURE_CHANCE_FROM_RARITY = {
	[ITEM_RARITIES.COMMON] = 50,
	[ITEM_RARITIES.UNCOMMON] = 30,
	[ITEM_RARITIES.RARE] = 10,
	[ITEM_RARITIES.MYTHICAL] = 5,
	[ITEM_RARITIES.LEGENDARY] = 3,
	[ITEM_RARITIES.IMMORTAL] = 1,
	[ITEM_RARITIES.ARCANA] = 1,
	[ITEM_RARITIES.UNIQUE] = 1,
}

-- items with rarities below this will drop without duplicates from treasures
-- meaning, that you won't ever get common or uncommon items twice from same treasure
TREASURE_DUPLICATE_THRESHOLD = ITEM_RARITIES.COMMON

-- currency given when you roll duplicate item from treasure (that won't be granted)
-- NOTE: common and uncommon are mentioned for convenience, however check THRESHOLD above
TREASURE_CURRENCY_FOR_DUPLICATE = {
	[ITEM_RARITIES.COMMON] = 50,
	[ITEM_RARITIES.UNCOMMON] = 100,
	[ITEM_RARITIES.RARE] = 200,
	[ITEM_RARITIES.MYTHICAL] = 400,
	[ITEM_RARITIES.LEGENDARY] = 1000,
	[ITEM_RARITIES.IMMORTAL] = 1000,
	[ITEM_RARITIES.ARCANA] = 2000,
	[ITEM_RARITIES.UNIQUE] = 2000,
}

-- equipment policies for item slots
EQUIPMENT_POLICY = {
	-- previously equipped item is unequipped automatically
	-- particles, modifiers and units returned from special callback (if any, otherwise from default creation) are saved and destroyed automatically
	-- allows exactly one equipped item per slot
	AUTO = 0,
	-- same as above, but skips default effect creation on equip
	-- this allows items with playable particles (such as kill effect / deny effect) to use default equip flow
	AUTO_SKIP_EFFECT_ON_EQUIP = 1,
	-- unequipping and assets lifetime should be managed manually in equip callback
	-- used if you want to have multiple equipped items in slot
	-- or some complex interaction with previous equipped items
	MANUAL = 10,
}

-- unspecified slots default to AUTO
SLOT_EQUIPMENT_POLICY = {
	[INVENTORY_SLOTS.VOICE_LINE] = EQUIPMENT_POLICY.MANUAL,
	-- all of these are using default flow, with particles being created externally (either triggered from events or from abilities)
	[INVENTORY_SLOTS.SPRAY] = EQUIPMENT_POLICY.AUTO_SKIP_EFFECT_ON_EQUIP,
	[INVENTORY_SLOTS.KILL_EFFECT] = EQUIPMENT_POLICY.AUTO_SKIP_EFFECT_ON_EQUIP,
	[INVENTORY_SLOTS.COSMETIC_SKILL] = EQUIPMENT_POLICY.AUTO_SKIP_EFFECT_ON_EQUIP,
	[INVENTORY_SLOTS.HIGH_FIVE] = EQUIPMENT_POLICY.AUTO_SKIP_EFFECT_ON_EQUIP,
}

ITEM_DEFINITIONS = {}


-- maximum amount of tips player can use in a single game
TIPS_PER_GAME_MAX = 3
-- maximum amount of tips player can use a day (total) having Tipping Hand
TIPS_MAX_FROM_TIPPING_HAND = 6
-- maximum amount of tips player can use a day (total) having Golden Hand
TIPS_MAX_FROM_GOLDEN_HAND = 12
-- currency given to target player per tip used
TIPS_CURRENCY_PER_TIP = 5
-- cooldown of tip per player (on the one who tips)
TIPS_COOLDOWN = 30


TIPS_FROM_SUBSCRIPTION_TIER = {
	[2] = 12,
	[1] = 9,
	[0] = 6,
}


PRODUCTS_CURRENCY_PRICES = {
	subscription_tier_1 = 8000,
	subscription_tier_2 = 30000,
}

SUBSCRIPTION_DURATION_MIN = 1
SUBSCRIPTION_DURATION_MAX = 30
SUBSCRIPTION_STEP = 0.9
SUBSCRIPTION_MAX_MULTIPLIER = 1.5