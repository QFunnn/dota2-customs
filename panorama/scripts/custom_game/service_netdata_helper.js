--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build b9dc48c · 2026-08-02 17:42:46 UTC
  ~ auto-generated — do not edit
]]


'use strict'; const exports = {}; GameUI.__loadModule('service_netdata_helper', exports); const require = GameUI.__require;

var libs = require('./libs.js');
var solid_utils = require('./solid_utils.js');

const PLAYER_INFO_CACHE_INTERVAL = 180;
const EQUIPMENT_SIMPLIFY_KEYS = ["id", "equipment_item_id", "level", "remaining_potential", "total_potential", "locked", "in_equip_suit", "ability_entry_data", "inlay_gems_data", "in_check"];
function parseJSONSafe(jsonString, defaultValue) {
  if (!jsonString || jsonString === "null" || jsonString === "undefined") {
    return defaultValue;
  }
  try {
    const parsed = JSON.parse(jsonString);
    return parsed || defaultValue;
  } catch (e) {
    print(`[parseJSONSafe] Failed to parse JSON: ${e}`);
    return defaultValue;
  }
}
function getShopItemBaseCost(itemName, rarity, fallbackCost = 0) {
  let cost;
  const itemKV = KeyValues.npc_items_custom[itemName];
  if (itemKV != undefined && itemKV.GoldCost != undefined && String(itemKV.GoldCost) != "") {
    const costList = String(itemKV.GoldCost).split(" ").map(c => parseInt(c));
    cost = costList[Math.min(costList.length - 1, rarity - 1)];
  }
  return cost ?? SHOP_RARITY_COST[rarity] ?? fallbackCost;
}
function getShopDiscountPercent(heroIndex) {
  return Entities.IsValidEntity(heroIndex) ? Entities.GetPropertyValue(heroIndex, "shop_discount") : 0;
}
function getDiscountedShopItemCost(heroIndex, itemName, rarity, fallbackCost = 0) {
  const cost = getShopItemBaseCost(itemName, rarity, fallbackCost);
  if (cost <= 0) {
    return 0;
  }
  const discountPercent = getShopDiscountPercent(heroIndex);
  return Math.max(0, Math.ceil(cost * (1 - discountPercent * 0.01)));
}
function getShopItemUpgradeInfo(heroIndex, itemName) {
  const itemKV = KeyValues.npc_items_custom[itemName];
  const targetGroup = String(itemKV?.UpgradeGroup ?? "");
  const targetRank = Number(itemKV?.UpgradeRank ?? 0);
  if (targetGroup == "" || targetRank <= 0) {
    return undefined;
  }
  const unitData = getNetDataKey("unit", String(heroIndex)) ?? {
    items: []
  };
  let owned;
  for (const item of unitData.items ?? []) {
    const ownedKV = KeyValues.npc_items_custom[item.itemName];
    if (String(ownedKV?.UpgradeGroup ?? "") != targetGroup) {
      continue;
    }
    const rank = Number(ownedKV?.UpgradeRank ?? 0);
    if (owned == undefined || rank > owned.rank) {
      owned = {
        itemName: item.itemName,
        level: item.level,
        rank
      };
    }
  }
  if (owned == undefined) {
    return undefined;
  }
  return {
    owned,
    targetRank,
    isUpgrade: owned.rank < targetRank
  };
}
function getShopItemDisplayCost(heroIndex, itemName, rarity, fallbackCost = 0) {
  const upgradeInfo = getShopItemUpgradeInfo(heroIndex, itemName);
  if (upgradeInfo != undefined) {
    if (!upgradeInfo.isUpgrade) {
      return 0;
    }
    return Math.max(0, getDiscountedShopItemCost(heroIndex, itemName, rarity, fallbackCost) - getDiscountedShopItemCost(heroIndex, upgradeInfo.owned.itemName, upgradeInfo.owned.level, fallbackCost));
  }
  return getDiscountedShopItemCost(heroIndex, itemName, rarity, fallbackCost);
}
function getTalentLevel(talentId, talentLevels) {
  return talentLevels[talentId] ?? 0;
}
function useTalentLevels(playerID = Game.GetLocalPlayerID()) {
  function Parse(data) {
    const talentsStr = data?.talents;
    return parseJSONSafe(talentsStr, {});
  }
  const playerTalent = solid_utils.createServiceNetData("player_talent", playerID);
  return libs.createMemo(() => Parse(playerTalent()));
}
function usePlayerAccountLevel(levelType = "hero_level", playerID = Game.GetLocalPlayerID()) {
  function Parse(data) {
    return data?.[levelType] ?? {
      level: 1,
      extra_exp: 0
    };
  }
  const playerAccountLevels = solid_utils.createServiceNetData("player_account_levels", playerID);
  return libs.createMemo(() => Parse(playerAccountLevels()));
}
function usePlayerMaxDiff(playerID = Game.GetLocalPlayerID()) {
  function Parse(data) {
    return toFiniteNumber(data?.max_diff, 0);
  }
  const playerCommonMatchData = solid_utils.createServiceNetData("player_common_match_data", playerID);
  return libs.createMemo(() => Parse(playerCommonMatchData()));
}
function usePlayerMaxAbyssalDiff(playerID = Game.GetLocalPlayerID()) {
  function Parse(data) {
    let maxDiff = 0;
    for (const [diffText, info] of Object.entries(data ?? {})) {
      if ((info?.star ?? 0) <= 0) {
        continue;
      }
      const diff = toFiniteNumber(diffText, 0);
      if (diff > maxDiff) {
        maxDiff = diff;
      }
    }
    return maxDiff;
  }
  const playerAbyssalFirstPasses = solid_utils.createServiceNetData("player_abyssal_first_passes", playerID);
  return libs.createMemo(() => Parse(playerAbyssalFirstPasses()));
}
function usePlayerCouriers(playerID = Game.GetLocalPlayerID()) {
  function Parse(data) {
    return data ?? {};
  }
  const playerCouriers = solid_utils.createServiceNetData("player_couriers", playerID);
  return libs.createMemo(() => Parse(playerCouriers()));
}
function getCourierCategories() {
  const categories = [0];
  for (const id of Object.keys(KeyValues.service_courier || {})) {
    const category = KeyValues.service_courier[id]?.category;
    if (category !== undefined && category !== null && !categories.includes(category)) {
      categories.push(category);
    }
  }
  return categories.sort((a, b) => a - b);
}
function getSortedCourierIDs(playerCouriers, categoryID = 0) {
  const courierIDList = Object.keys(KeyValues.courier);
  return courierIDList.filter(id => {
    if (categoryID === 0) return true;
    return KeyValues.service_courier[id]?.category === categoryID;
  }).map(id => ({
    id,
    data: playerCouriers[id] ?? {
      courier_id: id,
      star: 0,
      exp: 0,
      extra_star_exp: 0,
      equipped: 0,
      assist_slot: 0
    }
  })).sort((a, b) => {
    const aEquipped = Boolean(a.data.equipped);
    const bEquipped = Boolean(b.data.equipped);
    if (aEquipped !== bEquipped) {
      return bEquipped ? 1 : -1;
    }
    const starDiff = b.data.star - a.data.star;
    if (starDiff !== 0) {
      return starDiff;
    }
    const aQuality = KeyValues.service_courier[a.id]?.quality ?? 0;
    const bQuality = KeyValues.service_courier[b.id]?.quality ?? 0;
    return bQuality - aQuality;
  }).map(item => toFiniteString(item.data.courier_id));
}
function usePlayerAchievements(playerID = Game.GetLocalPlayerID()) {
  function Parse(data) {
    return data ?? {};
  }
  const playerAchievements = solid_utils.createServiceNetData("player_achievements", playerID);
  return libs.createMemo(() => Parse(playerAchievements()));
}
function resolveMaybeAccessor(value) {
  if (typeof value === "function") {
    return value();
  }
  return value;
}
function normalizeSteamID(raw) {
  if (raw == undefined) return undefined;
  const text = String(raw);
  if (!/^\d+$/.test(text)) return undefined;
  const value = Number(text);
  return value > 0 ? value : undefined;
}
function normalizeSteam64ID(raw) {
  if (raw == undefined) return undefined;
  return normalizeSteamID(Steam_64_3(String(raw)));
}
function getPlayerSteamID(props) {
  const directSteamID = normalizeSteamID(resolveMaybeAccessor(props.steamID));
  if (directSteamID != undefined) return directSteamID;
  const steam64ID = normalizeSteam64ID(resolveMaybeAccessor(props.steam64ID));
  if (steam64ID != undefined) return steam64ID;
  const playerID = resolveMaybeAccessor(props.playerID);
  if (playerID == undefined) return undefined;
  const playerSteam64ID = Game.GetPlayerInfo(playerID)?.player_steamid;
  return normalizeSteam64ID(playerSteam64ID);
}
function reconstructByKey(data, key) {
  const result = {};
  if (data == undefined) return result;
  for (const value of Object.values(data)) {
    if (value == undefined || typeof value !== "object") continue;
    const id = value[key];
    if (id == undefined) continue;
    result[String(id)] = value;
  }
  return result;
}
function reconstructByCombineKey(data, keys) {
  const result = {};
  if (data == undefined) return result;
  for (const value of Object.values(data)) {
    if (value == undefined || typeof value !== "object") continue;
    const id = keys.map(key => value[key]).join("-");
    if (id == "") continue;
    result[id] = value;
  }
  return result;
}
function normalizeShowRoomData(data) {
  const result = {};
  if (data == undefined) return result;
  for (const value of Object.values(data)) {
    if (value == undefined || typeof value !== "object") continue;
    const showType = value.show_type;
    const slot = value.slot;
    if (showType == undefined || slot == undefined) continue;
    const key = `${showType}-${slot}`;
    if (value.id === 0) {
      result[key] = "nil";
      continue;
    }
    let parsed = {};
    if (typeof value.details === "string") {
      const decoded = JSON.parseSafe(value.details);
      parsed = Array.isArray(decoded) ? decoded[0] ?? {} : decoded ?? {};
    } else if (value[showType] != undefined) {
      parsed = value[showType];
    }
    result[key] = {
      show_type: showType,
      slot,
      id: value.id,
      [showType]: parsed
    };
  }
  return result;
}
function extractShowRoomData(data) {
  if (data?.player_show_rooms != undefined) return data.player_show_rooms;
  if (data?.show_room != undefined) return data.show_room;
  if (data?.show_rooms != undefined) return data.show_rooms;
  if (data == undefined || typeof data !== "object") return undefined;
  const rows = Object.values(data).filter(value => {
    return value != undefined && typeof value === "object" && value.show_type != undefined && value.slot != undefined;
  });
  return rows.length > 0 ? rows : undefined;
}
function normalizeEquipments(data) {
  const result = {};
  if (data == undefined) return result;
  for (const value of Object.values(data)) {
    if (value == undefined) continue;
    if (value == "nil") continue;
    if (Array.isArray(value)) {
      const id = value[0];
      if (id != undefined) {
        result[String(id)] = value;
      }
      continue;
    }
    if (typeof value !== "object") continue;
    const id = value.id;
    if (id == undefined) continue;
    result[String(id)] = EQUIPMENT_SIMPLIFY_KEYS.map(key => value[key]);
  }
  return result;
}
function normalizePlayerInfoData(rawData, steamID) {
  const data = rawData ?? {};
  const showRoomData = extractShowRoomData(data);
  return {
    ...data,
    steamID,
    player_account_levels: data.player_account_levels != undefined ? reconstructByKey(data.player_account_levels, "account_type") : data.player_account_levels,
    player_heroes: data.player_heroes != undefined ? reconstructByKey(data.player_heroes, "hero_id") : data.player_heroes,
    player_achievements: data.player_achievements != undefined ? reconstructByKey(data.player_achievements, "task_id") : data.player_achievements,
    player_cosmetic_equips: data.player_cosmetic_equips != undefined ? reconstructByCombineKey(data.player_cosmetic_equips, ["hero_id", "slot_id"]) : data.player_cosmetic_equips,
    player_idle_game_fishes: data.player_idle_game_fishes != undefined ? reconstructByKey(data.player_idle_game_fishes, "id") : data.player_idle_game_fishes,
    player_weapons: data.player_weapons != undefined ? reconstructByKey(data.player_weapons, "weapon_id") : data.player_weapons,
    player_couriers: data.player_couriers != undefined ? reconstructByKey(data.player_couriers, "courier_id") : data.player_couriers,
    player_equipments: data.player_equipments != undefined ? normalizeEquipments(data.player_equipments) : data.player_equipments,
    player_counters: data.player_counters != undefined ? reconstructByKey(data.player_counters, "counter_type") : data.player_counters,
    player_show_rooms: normalizeShowRoomData(showRoomData ?? {})
  };
}
function notifyPlayerInfoCache(entry) {
  for (const listener of entry.listeners) {
    listener();
  }
}
function requestPlayerInfo(steamID, force = false) {
  CustomUIConfig.PlayerInfoCache ??= {};
  const now = Game.Time();
  const entry = CustomUIConfig.PlayerInfoCache[steamID] ??= {
    lastFetchTime: -PLAYER_INFO_CACHE_INTERVAL,
    requesting: false,
    listeners: []
  };
  if (!force && entry.data != undefined && entry.lastFetchTime + PLAYER_INFO_CACHE_INTERVAL > now) {
    notifyPlayerInfoCache(entry);
    return;
  }
  if (entry.requesting) {
    notifyPlayerInfoCache(entry);
    return;
  }
  entry.requesting = true;
  notifyPlayerInfoCache(entry);
  ServerRequest("get_player_info", {
    steamID
  }, result => {
    entry.requesting = false;
    if ((result.code == 0 || result.code == 200) && result.data != undefined) {
      const resultSteamID = normalizeSteamID(result.steamID) ?? steamID;
      const resultEntry = CustomUIConfig.PlayerInfoCache[resultSteamID] ??= entry;
      resultEntry.data = normalizePlayerInfoData(result.data, resultSteamID);
      resultEntry.lastFetchTime = Game.Time();
      resultEntry.requesting = false;
      notifyPlayerInfoCache(resultEntry);
      if (resultSteamID !== steamID) {
        notifyPlayerInfoCache(entry);
      }
      return;
    }
    notifyPlayerInfoCache(entry);
  }, undefined, () => {
    entry.requesting = false;
    notifyPlayerInfoCache(entry);
  });
}
function GetPlayerInfo(props) {
  CustomUIConfig.PlayerInfoCache ??= {};
  const [steamID, setSteamID] = libs.createSignal();
  const [data, setData] = libs.createSignal();
  const [loading, setLoading] = libs.createSignal(false);
  const applyEntry = targetSteamID => {
    const entry = targetSteamID != undefined ? CustomUIConfig.PlayerInfoCache[targetSteamID] : undefined;
    setData(entry?.data);
    setLoading(targetSteamID != undefined && entry?.data == undefined && entry?.requesting == true);
  };
  libs.createEffect(() => {
    const targetSteamID = getPlayerSteamID(props);
    setSteamID(targetSteamID);
    if (targetSteamID == undefined) {
      setData(undefined);
      setLoading(false);
      return;
    }
    const entry = CustomUIConfig.PlayerInfoCache[targetSteamID] ??= {
      lastFetchTime: -PLAYER_INFO_CACHE_INTERVAL,
      requesting: false,
      listeners: []
    };
    const listener = () => {
      if (steamID() === targetSteamID) {
        applyEntry(targetSteamID);
      }
    };
    entry.listeners.push(listener);
    libs.onCleanup(() => {
      const index = entry.listeners.indexOf(listener);
      if (index >= 0) {
        entry.listeners.splice(index, 1);
      }
    });
    applyEntry(targetSteamID);
    requestPlayerInfo(targetSteamID);
  });
  return {
    data,
    loading,
    steamID,
    refresh: () => {
      const targetSteamID = steamID();
      if (targetSteamID != undefined) {
        requestPlayerInfo(targetSteamID, true);
      }
    }
  };
}

exports.GetPlayerInfo = GetPlayerInfo;
exports.getCourierCategories = getCourierCategories;
exports.getPlayerSteamID = getPlayerSteamID;
exports.getShopItemDisplayCost = getShopItemDisplayCost;
exports.getShopItemUpgradeInfo = getShopItemUpgradeInfo;
exports.getSortedCourierIDs = getSortedCourierIDs;
exports.getTalentLevel = getTalentLevel;
exports.usePlayerAccountLevel = usePlayerAccountLevel;
exports.usePlayerAchievements = usePlayerAchievements;
exports.usePlayerCouriers = usePlayerCouriers;
exports.usePlayerMaxAbyssalDiff = usePlayerMaxAbyssalDiff;
exports.usePlayerMaxDiff = usePlayerMaxDiff;
exports.useTalentLevels = useTalentLevels;