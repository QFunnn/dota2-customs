--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


let PLAYER_INVENTORY = {};
let EQUIPPED_ITEMS = {};
let DEFINITIONS;
let INVENTORY_CHANGED_LISTENERS = [];
let EQUIPMENT_CHANGED_LISTENERS = [];
let DEFINITIONS_CHANGED_LISTENERS = [];
let _DEFINITIONS_REQUESTED = false;

/**
 * Enum for inventory slots
 * @readonly
 * @enum {string}
 */
const INVENTORY_SLOT = {
	TREASURES: "98",
	AURA: "2",
	PET: "5",
	KILL_EFFECT: "4",
	COSMETIC_SKILL: "6",
	HIGH_FIVE: "7",
	SPRAY: "1",
	HERO_EFFECT: "3",
	MISC: "99",
	//  unused, for future work
	// VOICE_LINE: "100",
};
const _INVENTORY_SLOT_NAMES = Object.fromEntries(Object.entries(INVENTORY_SLOT).map((a) => a.reverse()));

/**
 * Enum for items rarities
 * @readonly
 * @enum {Number}
 */
const ITEM_RARITY = {
	COMMON: 1,
	UNCOMMON: 2,
	RARE: 3,
	MYTHICAL: 4,
	LEGENDARY: 5,
	IMMORTAL: 6,
	ARCANA: 7,

	UNIQUE: 99,
};
const ITEM_RARITY_NAMES = Object.fromEntries(Object.entries(ITEM_RARITY).map((a) => a.reverse()));

/**
 * Enum for items types
 * @readonly
 * @enum {Number}
 */
const ITEM_TYPE = {
	EQUIPMENT: 1,
	CONSUMABLE: 2,
	PASSIVE: 3,
};

function UpdateInventory(event) {
	PLAYER_INVENTORY = event.items || {};

	_Notify(INVENTORY_CHANGED_LISTENERS, PLAYER_INVENTORY);
}

function SetDefinitions(event) {
	DEFINITIONS = ITEM_DATA;

	_Notify(DEFINITIONS_CHANGED_LISTENERS, DEFINITIONS);
}

function UpdateEquipped(event) {
	EQUIPPED_ITEMS = event.equipped_items || {};
	_Notify(EQUIPMENT_CHANGED_LISTENERS, EQUIPPED_ITEMS);
}

GameUI.Inventory = {};

/**
 * Checks if local player has item.
 * @param {String} item_name
 * @returns {boolean}
 */
GameUI.Inventory.HasItem = function (item_name) {
	return PLAYER_INVENTORY[item_name] !== undefined;
};

/**
 * Returns count of passed item name in player's inventory.
 *
 * Returns -1 if player doesn't have item in inventory.
 * @param {String} item_name
 * @returns {Number} count
 */
GameUI.Inventory.GetItemCount = function (item_name) {
	return PLAYER_INVENTORY[item_name] ? PLAYER_INVENTORY[item_name].count : -1;
};

/**
 * Returns path for item image from battle pass.
 *
 * @param {String} item_name
 * @returns {String} Path format "file://{...}.png"
 */
GameUI.Inventory.GetItemImagePath = function (item_name) {
	return `file://{images}/custom_game/collection/cosmetics/items/${GameUI.Inventory.GetItemSlotName(
		item_name,
	)}/${item_name}.png`;
};

/**
 *
 * @param {INVENTORY_SLOT} slot
 * @returns {Object}
 */
GameUI.Inventory.GetEquippedItemInSlot = function (slot) {
	return EQUIPPED_ITEMS[slot];
};

/**
 * Returns item definition (`slot`, `type`, `rarity`, `unlocked_with`).
 * @param {String} item_name
 * @returns {Object}
 */
GameUI.Inventory.GetItemDefinition = function (item_name) {
	if (DEFINITIONS) return DEFINITIONS[item_name];
};

/**
 * Returns item slot (if item exists)
 * @param {String} item_name
 * @returns
 */
GameUI.Inventory.GetItemSlot = function (item_name) {
	if (DEFINITIONS && DEFINITIONS[item_name]) return DEFINITIONS[item_name].slot;
};

/**
 * Returns item slot name (if item exists)
 * @param {String} item_name
 * @returns
 */
GameUI.Inventory.GetItemSlotName = function (item_name) {
	if (DEFINITIONS && DEFINITIONS[item_name]) return _INVENTORY_SLOT_NAMES[DEFINITIONS[item_name].slot];
};

/**
 * Returns item type (if item exists)
 * @param {String} item_name
 * @returns
 */
GameUI.Inventory.GetItemType = function (item_name) {
	if (DEFINITIONS) return DEFINITIONS[item_name].type;
};

/**
 * Returns item rarity (if item exists)
 * @param {String} item_name
 * @returns
 */
GameUI.Inventory.GetItemRarity = function (item_name) {
	if (DEFINITIONS && DEFINITIONS[item_name]) return DEFINITIONS[item_name].rarity;
};

/**
 * Returns item rarity (if item exists)
 * @param {String} item_name
 * @returns
 */
GameUI.Inventory.GetItemRarityName = function (item_name) {
	if (DEFINITIONS && DEFINITIONS[item_name]) return GameUI.Inventory.GetRarityName(DEFINITIONS[item_name].rarity);
};

/**
 * Attempts to use item (invoke `on_use`)
 *
 * WARNING: This method doesn't inform of any failures in usage and is provided for convenience.
 * @param {String} item_name
 */
GameUI.Inventory.UseItem = function (item_name) {
	GameEvents.SendToServerEnsured("WebInventory:use", {
		item_name: item_name,
	});
};

/**
 * Attempts to consume an item (reducing item count in player inventory).
 *
 * WARNING: this method makes permanent changes to player backend inventory
 * It also doesn't inform of any failures. Most of the time, using same API in lua is a better choice
 * @param {String} item_name
 * @param {Number} count
 */
GameUI.Inventory.ConsumeItem = function (item_name, count) {
	GameEvents.SendToServerEnsured("WebInventory:consume", {
		item_name: item_name,
		consumed_count: count,
	});
};

/**
 * Buys specified `count` of `item_name`/
 *
 * WARNING: this method makes permanent changes to player currency balance and inventory.
 * Performs HTTP request to backend from lua as soon as lua receives event.
 * @param {String} item_name
 * @param {Number} count
 */
GameUI.Inventory.BuyItem = function (item_name, count) {
	GameEvents.SendToServerEnsured("WebInventory:purchase", {
		item_name: item_name,
		count: count,
	});
};

/**
 * Equips item (if possible), creating all bound effects.
 * This callback will handle unequipping previous item with cleanup and all related mechanics, as long as that is defined on lua
 *
 * Invokes equipment update.
 * @param {String} item_name
 * @returns
 */
GameUI.Inventory.EquipItem = function (item_name) {
	GameEvents.SendToServerEnsured("WebInventory:equip", {
		item_name: item_name,
	});
};

/**
 * Unequips item (if equipped), destroying all bound effects.
 *
 * Invokes equipment update.
 * @param {String} item_name
 * @returns
 */
GameUI.Inventory.UnequipItem = function (item_name) {
	GameEvents.SendToServerEnsured("WebInventory:unequip", {
		item_name: item_name,
	});
};

/**
 * Register a `callback` to be called whenever inventory of local player changes
 * @param {CallableFunction} callback
 */
GameUI.Inventory.RegisterForInventoryChanges = function (callback) {
	INVENTORY_CHANGED_LISTENERS.push(callback);
	if (PLAYER_INVENTORY) callback(PLAYER_INVENTORY);
};

/**
 * Register a `callback` to be called whenever equipment of local player changes
 * @param {CallableFunction} callback
 */
GameUI.Inventory.RegisterForEquipmentChanges = function (callback) {
	EQUIPMENT_CHANGED_LISTENERS.push(callback);
	if (EQUIPPED_ITEMS) callback(EQUIPPED_ITEMS);
};

/**
 * Register a `callback` to be called whenever definitions of battle pass items update
 * @param {CallableFunction} callback
 */
GameUI.Inventory.RegisterForDefinitionsChanges = function (callback) {
	DEFINITIONS_CHANGED_LISTENERS.push(callback);
	if (DEFINITIONS) callback(DEFINITIONS);
};

/**
 * @returns {Object} Availabe slots Enum
 */
GameUI.Inventory.GetSlotsDefinition = function () {
	return INVENTORY_SLOT;
};

/**
 * Return item types Enum
 * @returns {Object}
 */
GameUI.Inventory.GetTypesDefinition = function () {
	return ITEM_TYPE;
};

/**
 * Return rarities Enum
 * @returns {Object}
 */
GameUI.Inventory.GetRaritiesDefinition = function () {
	return ITEM_RARITY;
};

/**
 * Return rarity name by rarity enum
 * @returns {String} rarity_name
 */
GameUI.Inventory.GetRarityName = function (rarity_enum) {
	return ITEM_RARITY_NAMES[rarity_enum || 1] || "COMMON";
};

(() => {
	SetDefinitions();
	GameEvents.SubscribeProtected("WebInventory:update", UpdateInventory);
	// GameEvents.SubscribeProtected("WebInventory:set_definitions", SetDefinitions);
	GameEvents.SubscribeProtected("WebInventory:update_equipped_items", UpdateEquipped);

	GameEvents.SendToServerEnsured("WebInventory:get_items", {});
	GameEvents.SendToServerEnsured("WebInventory:get_equipped_items", {});

	// definitions are sent very early, request a refresh update every now and then
	GameEvents.Subscribe("game_rules_state_change", () => {
		// request once we reach pregame (or later, if reconnected), but only once in client lifetime
		if (_DEFINITIONS_REQUESTED) return;
		_DEFINITIONS_REQUESTED = true;
		GameEvents.SendToServerEnsured("WebInventory:get_items", {});
		GameEvents.SendToServerEnsured("WebInventory:get_equipped_items", {});
	});
})();