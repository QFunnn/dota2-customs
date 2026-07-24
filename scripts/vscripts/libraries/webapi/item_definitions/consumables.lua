--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


ITEM_DEFINITIONS["test_consumable"] = {
	slot = INVENTORY_SLOTS.MISC,
	type = ITEM_TYPES.CONSUMABLE,
	rarity = ITEM_RARITIES.UNIQUE,

	-- using Resolve since item definitions are created before relevant module is loaded
	-- alternatively, anonymous function or global function could be used
	-- i.e. on_use = function(item_name, item_data, definition) ... end
	on_use = Resolve("OnTestUse", "Equipment")
}

CONSUMABLE_TEST_FILLER = {
	slot = INVENTORY_SLOTS.MISC,
	type = ITEM_TYPES.CONSUMABLE,
	rarity = ITEM_RARITIES.COMMON,
	on_use = Resolve("OnTestUse", "Equipment"),
}