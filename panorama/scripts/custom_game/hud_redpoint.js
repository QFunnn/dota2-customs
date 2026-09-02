--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 0b85d8d 
  ~ auto-generated — do not edit
]]


'use strict'; const require = GameUI.__require;

var libs = require('./libs.js');
var solid_utils = require('./solid_utils.js');
var equipment_utils = require('./equipment_utils.js');
var service_netdata_helper = require('./service_netdata_helper.js');
var dig_veins_logic = require('./dig_veins_logic.js');
var StoreTagPage = require('./StoreTagPage.js');
require('./EOM_MenuLayout.js');
require('./EOM_RedMark.js');
require('./EOM_Button.js');
require('./StoreItem.js');
require('./EOM_Countdown.js');
require('./EOM_ImageNumber.js');
require('./Player.js');
require('./EOM_TextEntry.js');

function defineRedPointRule(name, setup) {
  CustomUIConfig.__redPointRuleRegistry ??= {};
  if (CustomUIConfig.__redPointRuleRegistry[name] === true) {
    return;
  }
  CustomUIConfig.__redPointRuleRegistry[name] = true;
  setup();
}
function setRedPoint(path, value) {
  const [rootKey, ...keys] = path;
  CustomUIConfig.SetRedPoint(value, rootKey, ...keys.map(String));
}
function setRedPointBatch(updates) {
  for (const update of updates) {
    setRedPoint(update.path, update.value);
  }
}
function createRedPointServiceData(key, defaultVar) {
  return defaultVar == undefined ? solid_utils.createServiceNetData(key) : solid_utils.createServiceNetData(key, defaultVar);
}

const [savingPotRedPointViewed, setSavingPotRedPointViewed] = libs.createSignal(false);
const [footballRedPointViewed, setFootballRedPointViewed] = libs.createSignal(false);
const getFootballActivityID = () => {
  const now = Math.floor(Date.now() / 1000);
  for (const activity of Object.values(KeyValues.activity_data)) {
    if (activity.name == "football" && now > activity.start_time && now < activity.end_time) return activity.activity_id;
  }
  return 501;
};
CustomUIConfig.__activityRedPointState = {
  markSavingPotRedPointViewed: () => setSavingPotRedPointViewed(true)
};
function useActivityRedPoints() {
  defineRedPointRule("activity", () => {
    const playerCounters = createRedPointServiceData("player_counters", {});
    const footballActivityData = createRedPointServiceData("player_dragonboat_activity_data", {});
    libs.createEffect(() => {
      if ((playerCounters()["daily_login_count"]?.count ?? 0) != 1) {
        setSavingPotRedPointViewed(false);
      }
    });
    libs.createEffect(() => {
      const dailyLoginCount = playerCounters()["daily_login_count"]?.count ?? 0;
      setRedPoint(["activity", "saving_pot"], !savingPotRedPointViewed() && dailyLoginCount == 1);
    });
    libs.createEffect(() => {
      const activityData = footballActivityData()[getFootballActivityID()];
      const status = activityData?.status ?? 0;
      const canJoin = activityData != undefined && status == 0 && (playerCounters()["dragonboat_daily_join"]?.count ?? 0) < 1;
      setRedPoint(["activity", "football"], !footballRedPointViewed() && (status == 3 || canJoin));
    });
  });
}

const cosmeticPreviewType = [COSMETIC_TYPE.HEAD, COSMETIC_TYPE.SHOULDER, COSMETIC_TYPE.BACK, COSMETIC_TYPE.TAIL, COSMETIC_TYPE.WING, COSMETIC_TYPE.MISC, COSMETIC_TYPE.FOOTPRINT_EFFECT, COSMETIC_TYPE.AURA_EFFECT];
const fakePreviewType = [COSMETIC_TYPE.ATTACK_EFFECT, COSMETIC_TYPE.SPECIAL_SKILL_EFFECT, COSMETIC_TYPE.DASH_SKILL_EFFECT, COSMETIC_TYPE.DEFENSE_SKILL_EFFECT, COSMETIC_TYPE.ULTIMATE_SKILL_EFFECT];
const cosmeticRedPointTypes = [...cosmeticPreviewType, ...fakePreviewType, COSMETIC_TYPE.BORDER, COSMETIC_TYPE.TITLE];
function getCosmeticMenuByType(type) {
  return type == COSMETIC_TYPE.BORDER || type == COSMETIC_TYPE.TITLE ? "Cosmetic_Player" : "Cosmetic_Hero";
}
function useCosmeticRedPoints() {
  defineRedPointRule("cosmetic", () => {
    const playerProps = createRedPointServiceData("player_props", {});
    const propUnreadIds = solid_utils.createPlayerUnreadIds("prop");
    const playerCosmetics = createRedPointServiceData("player_cosmetics", {});
    const cosmeticUnreadIds = solid_utils.createPlayerUnreadIds("cosmetic");
    libs.createEffect(() => {
      const props = playerProps();
      const unreads = propUnreadIds.unreadIds();
      const hasUnread = Object.keys(unreads).some(id => props[id]?.amounts > 0 && propUnreadIds.isUnread(id));
      setRedPoint(["cosmetic", "Props_Menu"], hasUnread);
    });
    libs.createEffect(() => {
      const cosmetics = playerCosmetics();
      const unreads = cosmeticUnreadIds.unreadIds();
      const hasUnreadByType = {};
      for (const id in unreads) {
        if (cosmetics[id] == undefined || !cosmeticUnreadIds.isUnread(id)) continue;
        const cosmeticInfo = KeyValues.info_item_cosmetic[id];
        if (cosmeticInfo == undefined) continue;
        hasUnreadByType[cosmeticInfo.type] = true;
      }
      setRedPointBatch(cosmeticRedPointTypes.map(type => ({
        path: ["cosmetic", getCosmeticMenuByType(type), type],
        value: !!hasUnreadByType[type]
      })));
    });
  });
}

const [dismissedEquipmentUnreadIDs, setDismissedEquipmentUnreadIDs] = libs.createSignal({});
const markEquipmentUnreadViewed = ids => {
  if (ids.length <= 0) return;
  setDismissedEquipmentUnreadIDs(previous => {
    let changed = false;
    const next = {
      ...previous
    };
    for (const id of ids) {
      const key = String(id);
      if (next[key] === true) continue;
      next[key] = true;
      changed = true;
    }
    return changed ? next : previous;
  });
};
CustomUIConfig.__equipmentRedPointState = {
  markEquipmentUnreadViewed
};
function useEquipmentRedPoints() {
  defineRedPointRule("equipment", () => {
    const newItems = createRedPointServiceData("player_unread_ids", {});
    const newEquips = libs.createMemo(() => newItems()["equipment"] ?? {});
    const playerEquipments = equipment_utils.GetSimplifyEquipment();
    const playerKeys = createRedPointServiceData("player_keys", {});
    const keyUnreadIds = solid_utils.createPlayerUnreadIds("key");
    const playerDrawings = createRedPointServiceData("player_drawings", {});
    const drawingUnreadIds = solid_utils.createPlayerUnreadIds("drawing");
    libs.createEffect(() => {
      const unreads = newEquips();
      setDismissedEquipmentUnreadIDs(previous => {
        let changed = false;
        const next = {};
        for (const id in previous) {
          if (unreads[id] === true) {
            next[id] = true;
          } else {
            changed = true;
          }
        }
        return changed ? next : previous;
      });
    });
    libs.createEffect(() => {
      const unreads = newEquips();
      const dismissed = dismissedEquipmentUnreadIDs();
      const playerEquips = playerEquipments();
      const hasUnread = Object.keys(unreads).some(id => playerEquips[id] != undefined && unreads[id] === true && dismissed[id] !== true);
      setRedPoint(["equipment", "EquipmentTab_equip"], hasUnread);
    });
    libs.createEffect(() => {
      const unreads = keyUnreadIds.unreadIds();
      const keys = playerKeys();
      const hasUnread = Object.keys(unreads).some(id => keys[id] != undefined && keyUnreadIds.isUnread(id));
      setRedPoint(["equipment", "EquipmentTab_key"], hasUnread);
    });
    libs.createEffect(() => {
      const unreads = drawingUnreadIds.unreadIds();
      const drawings = playerDrawings();
      const hasUnread = Object.keys(unreads).some(id => drawings[id] != undefined && drawingUnreadIds.isUnread(id));
      setRedPoint(["equipment", "EquipmentTab_drawing"], hasUnread);
    });
  });
}

const FISHING_BAIT_SLOT_COUNT = 1;
const FISHING_HOOK_SLOT_COUNT = 2;
const FISHING_COURIER_SLOT_COUNT = 2;
const fishConsumeConfigs = KeyValues.fish_consume;
const fishBaits = Object.values(fishConsumeConfigs).filter(config => config.type == "bait");
const fishHooks = Object.values(fishConsumeConfigs).filter(config => config.type == "fishhook");
const fishRodConfigs = KeyValues.idle_game_fish_rod;
const COLLECTION_TYPE = "fish";
const collectionTypeList = {};
Object.entries(KeyValues.collection).forEach(([, data]) => {
  if (Number(data.hide ?? 0) === 1) return;
  const rarity = GetServiceItemRarity(data.id);
  collectionTypeList[data.type] ??= {};
  collectionTypeList[data.type][rarity] ??= [];
  collectionTypeList[data.type][rarity].push(data);
});
const fishGameData = createRedPointServiceData("player_idle_game_fish_data", {
  equipment_level: 0,
  rod_level: 0,
  fish_bait: 0,
  fish_hooks: [],
  fish_courier_ids: [],
  times: 1,
  auto_switch_tools: false,
  aquarium_level: 0
});
const tokenData = createRedPointServiceData("player_tokens", {});
const playerCouriers = createRedPointServiceData("player_couriers", {});
const playerUnreadIDs = createRedPointServiceData("player_unread_ids", {});
const playerPropertySystem = solid_utils.createPlayerPropertyData(() => Players.GetLocalPlayer());
const [viewedFishingNoticeKeys, setViewedFishingNoticeKeys] = libs.createSignal({});
const getFishingSlotUnlockNoticeKey = (type, index) => `slot_unlock_${type}_${index}`;
const getFishingSlotEquipableNoticeKey = type => `slot_equipable_${type}`;
const isFishingNoticeViewed = key => viewedFishingNoticeKeys()[key] === true;
const markFishingNoticeKeysViewed = keys => {
  if (keys.length <= 0) return;
  setViewedFishingNoticeKeys(previous => {
    let changed = false;
    const next = {
      ...previous
    };
    for (const key of keys) {
      if (next[key] === true) continue;
      next[key] = true;
      changed = true;
    }
    return changed ? next : previous;
  });
  refreshFishingItemEntryRedPoint();
};
const getFishingToolTypeByItemID = itemID => {
  const config = fishConsumeConfigs[String(itemID)];
  if (config?.type === "bait") return "bait";
  if (config?.type === "fishhook") return "hook";
  return undefined;
};
const hasFishingSkillCourier = courierID => {
  const courierConfig = KeyValues.service_courier[String(courierID)];
  if (courierConfig === undefined) return false;
  for (let star = 1; star <= 6; star++) {
    const skillKey = `fish_skill${star}`;
    const skillValue = courierConfig[skillKey];
    if (typeof skillValue === "string" && skillValue !== "") return true;
  }
  return false;
};
const getFishingUnreadMap = system => {
  return playerUnreadIDs()?.[system] ?? {};
};
const markFishingUnreadViewed = (system, ids) => {
  const unreadMap = getFishingUnreadMap(system);
  const unreadIDs = ids.map(id => String(id)).filter(id => unreadMap[id] === true);
  if (unreadIDs.length <= 0) return;
  ServerRequest("fishing_unread_read", {
    system,
    ids: unreadIDs.map(id => Number(id))
  });
};
const fishRodConfigList = libs.createMemo(() => Object.values(fishRodConfigs).filter(config => Number(config.hide ?? 0) !== 1));
const maxFishRodLevel = libs.createMemo(() => Math.max(fishRodConfigList().length - 1, 0));
const currentFishRodLevel = libs.createMemo(() => {
  const level = fishGameData()?.rod_level ?? 0;
  return Math.min(maxFishRodLevel(), Math.max(0, level));
});
const currentFishRodConfig = libs.createMemo(() => fishRodConfigs[String(currentFishRodLevel())]);
const unlockedFishingBaitSlotCount = libs.createMemo(() => Number(currentFishRodConfig()?.is_bait ?? 0));
const unlockedFishingHookSlotCount = libs.createMemo(() => Number(currentFishRodConfig()?.fishhook_slot ?? 0));
const equippedFishingBaitID = libs.createMemo(() => Number(fishGameData()?.fish_bait ?? 0) || 0);
const getFishingHookSlotItemID = index => Number(fishGameData()?.fish_hooks?.[index] ?? 0) || 0;
const getFishingCourierSlotItemID = index => Number(fishGameData()?.fish_courier_ids?.[index] ?? 0) || 0;
const extraFishingCourierSlotCount = libs.createMemo(() => Math.max(0, Number(playerPropertySystem().idle_fish_courier_slot ?? 0) || 0));
const isFishingCourierSlotUnlocked = index => index === 0 || index < extraFishingCourierSlotCount() + 1;
function getFishingToolSlotCount(type) {
  return type === "bait" ? FISHING_BAIT_SLOT_COUNT : FISHING_HOOK_SLOT_COUNT;
}
const isFishingToolSlotUnlocked = (type, index) => {
  return type === "bait" ? index < unlockedFishingBaitSlotCount() : index < unlockedFishingHookSlotCount();
};
const getFishingToolSlotItemID = (type, index) => {
  return type === "bait" ? equippedFishingBaitID() : getFishingHookSlotItemID(index);
};
const isFishingCourierEquipped = courierID => {
  const normalizedCourierID = Number(courierID) || 0;
  if (normalizedCourierID <= 0) return false;
  for (let index = 0; index < FISHING_COURIER_SLOT_COUNT; index++) {
    if (!isFishingCourierSlotUnlocked(index)) continue;
    if (getFishingCourierSlotItemID(index) === normalizedCourierID) return true;
  }
  return false;
};
const isOwnedFishingCourier = courierID => {
  const courier = playerCouriers()?.[String(courierID)];
  return courier != undefined && Number(courier.star ?? 0) > 0;
};
const hasOwnedFishingTool = type => {
  const fishItems = type === "hook" ? fishHooks : fishBaits;
  return fishItems.some(config => (tokenData()?.[config.id]?.amounts ?? 0) > 0);
};
const hasEmptyUnlockedFishingToolSlot = type => {
  const slotCount = getFishingToolSlotCount(type);
  for (let index = 0; index < slotCount; index++) {
    if (!isFishingToolSlotUnlocked(type, index)) continue;
    if (getFishingToolSlotItemID(type, index) <= 0) return true;
  }
  return false;
};
const collectOneTimeFishingToolNoticeKeys = () => {
  const keys = [];
  const slotTypes = ["bait", "hook"];
  for (const type of slotTypes) {
    const slotCount = getFishingToolSlotCount(type);
    for (let index = 0; index < slotCount; index++) {
      if (!isFishingToolSlotUnlocked(type, index)) continue;
      const unlockKey = getFishingSlotUnlockNoticeKey(type, index);
      if (!isFishingNoticeViewed(unlockKey)) keys.push(unlockKey);
    }
    const equipableKey = getFishingSlotEquipableNoticeKey(type);
    if (!isFishingNoticeViewed(equipableKey) && hasOwnedFishingTool(type) && hasEmptyUnlockedFishingToolSlot(type)) {
      keys.push(equipableKey);
    }
  }
  return keys;
};
const isFishingToolNew = itemID => getFishingUnreadMap("fishing_tool")[String(itemID)] === true;
const isFishingToolTypeNew = type => {
  for (const itemID of Object.keys(getFishingUnreadMap("fishing_tool"))) {
    if (getFishingToolTypeByItemID(itemID) === type) return true;
  }
  return false;
};
const markFishingToolNewViewed = itemID => markFishingUnreadViewed("fishing_tool", [itemID]);
const isFishingCourierNew = courierID => getFishingUnreadMap("fishing_courier")[String(courierID)] === true;
const hasNewFishingCourierNotice = () => {
  for (const courierID of Object.keys(getFishingUnreadMap("fishing_courier"))) {
    if (hasFishingSkillCourier(courierID)) return true;
  }
  return false;
};
const markFishingCourierNewViewed = courierID => markFishingUnreadViewed("fishing_courier", [courierID]);
const hasOneTimeFishingToolNotice = libs.createMemo(() => collectOneTimeFishingToolNoticeKeys().length > 0);
const hasNewFishingToolNotice = libs.createMemo(() => {
  for (const itemID of Object.keys(getFishingUnreadMap("fishing_tool"))) {
    const type = getFishingToolTypeByItemID(itemID);
    if (type === undefined) continue;
    const slotCount = getFishingToolSlotCount(type);
    for (let index = 0; index < slotCount; index++) {
      if (isFishingToolSlotUnlocked(type, index)) return true;
    }
  }
  return false;
});
const hasEquipableFishingCourierNotice = libs.createMemo(() => {
  let hasEmptyUnlockedCourierSlot = false;
  for (let index = 0; index < FISHING_COURIER_SLOT_COUNT; index++) {
    if (isFishingCourierSlotUnlocked(index) && getFishingCourierSlotItemID(index) <= 0) {
      hasEmptyUnlockedCourierSlot = true;
      break;
    }
  }
  if (!hasEmptyUnlockedCourierSlot) return false;
  return service_netdata_helper.getSortedCourierIDs(playerCouriers()).filter(courierID => isOwnedFishingCourier(courierID) && hasFishingSkillCourier(courierID)).some(courierID => !isFishingCourierEquipped(courierID));
});
const canRodLevelUp = libs.createMemo(() => {
  const rodLevel = fishGameData()?.rod_level ?? 0;
  const maxLevel = maxFishRodLevel();
  if (rodLevel >= maxLevel) return false;
  const currentCfg = fishRodConfigs[String(rodLevel)];
  const rawCost = currentCfg?.cost ?? "";
  const [tokenID, amount] = rawCost.split(":");
  const cost = Number(amount);
  if (!tokenID || Number.isNaN(cost) || cost <= 0) return false;
  const owned = tokenData()?.[Number(tokenID)]?.amounts ?? 0;
  return owned >= cost;
});
const hasFishingItemEntryRedPoint = () => {
  return canRodLevelUp() || hasOneTimeFishingToolNotice() || hasNewFishingToolNotice() || hasNewFishingCourierNotice() || hasEquipableFishingCourierNotice();
};
const refreshFishingItemEntryRedPoint = () => {
  setRedPoint(["fishingitem", "FishingItem"], hasFishingItemEntryRedPoint());
};
const fishingRedPointState = {
  getFishingSlotUnlockNoticeKey,
  getFishingSlotEquipableNoticeKey,
  isFishingNoticeViewed,
  markFishingNoticeKeysViewed,
  getFishingToolTypeByItemID,
  hasFishingSkillCourier,
  hasOwnedFishingTool,
  collectOneTimeFishingToolNoticeKeys,
  hasNewFishingCourierNotice,
  isFishingToolNew,
  isFishingToolTypeNew,
  markFishingToolNewViewed,
  isFishingCourierNew,
  markFishingCourierNewViewed
};
CustomUIConfig.__fishingItemRedPointState = fishingRedPointState;
function canAnyFishCollectionLevelUp(playerCollections) {
  const typeCollections = collectionTypeList[COLLECTION_TYPE];
  if (!typeCollections) return false;
  for (const rarity in typeCollections) {
    for (const collection of typeCollections[rarity]) {
      const collectionData = playerCollections[collection.id];
      if (!collectionData) continue;
      const rarityLevelConfig = KeyValues.collection_level_up[COLLECTION_TYPE]?.[String(rarity)] ?? {};
      const levelCost = rarityLevelConfig[String(collectionData.level)]?.level_cost;
      if (Boolean(levelCost) && collectionData.extra_exp >= levelCost) return true;
    }
  }
  return false;
}
function useFishingItemRedPoints() {
  defineRedPointRule("fishingitem", () => {
    const playerCollections = createRedPointServiceData("player_collections", {});
    libs.createEffect(libs.on([canRodLevelUp, hasOneTimeFishingToolNotice, hasNewFishingToolNotice, hasNewFishingCourierNotice, hasEquipableFishingCourierNotice], () => {
      refreshFishingItemEntryRedPoint();
    }));
    libs.createEffect(() => {
      setRedPoint(["fishingitem", "Collection_Menu_fish"], canAnyFishCollectionLevelUp(playerCollections()));
    });
  });
}

let soulRedPoints = () => ({});
let storyRewardRedPoints = () => ({});
let upgradableTalentSignatures = () => ({});
let weaponRedPoints = () => ({});
let courierRedPoints = () => ({});
const [talentRedPoints, setTalentRedPoints] = libs.createSignal({});
const HERO_TALENT_RED_POINT_VIEWED_SETTING_KEY = "hero_talent_redpoint_viewed_signatures";
function parseViewedTalentSignatures(value) {
  const parsed = typeof value === "string" ? JSON.parseSafe(value) : value;
  if (parsed == undefined || typeof parsed !== "object") {
    return {};
  }
  const result = {};
  for (const [heroID, signature] of Object.entries(parsed)) {
    if (typeof signature === "string") {
      result[heroID] = signature;
    }
  }
  return result;
}
const [viewedTalentSignatures, setViewedTalentSignatures] = libs.createSignal(parseViewedTalentSignatures(Players.GetPlayerSetting(HERO_TALENT_RED_POINT_VIEWED_SETTING_KEY, "{}")));
function hasHeroStoryReward(heroID, star, receiveRecords) {
  const effectConfig = KeyValues.hero_soul_infusion_effect[heroID] ?? {};
  return Object.values(effectConfig).some(effect => {
    return !!effect.reward && star >= effect.soul_level && receiveRecords[heroID]?.[String(effect.soul_level)] !== true;
  });
}
function getHeroTalentTokenCost(talents) {
  const costMap = {};
  for (const talentID in talents) {
    const savedLevel = toFiniteNumber(talents[talentID]);
    for (let i = 0; i < savedLevel; i++) {
      const effectCfg = KeyValues.hero_talent_effect?.[talentID]?.[String(i)];
      if (effectCfg?.talent_cost) {
        for (const cost of solid_utils.parseTokenCosts(effectCfg.talent_cost)) {
          costMap[cost.name] = (costMap[cost.name] ?? 0) + cost.value;
        }
      }
    }
  }
  return costMap;
}
const heroSoulRedPoints = () => soulRedPoints();
const heroTalentRedPoints = talentRedPoints;
const heroStoryRewardRedPoints = () => storyRewardRedPoints();
const heroWeaponRedPoints = () => weaponRedPoints();
const heroCourierRedPoints = () => courierRedPoints();
const clearHeroTalentRedPoints = () => {
  const signatures = upgradableTalentSignatures();
  const nextViewed = {
    ...viewedTalentSignatures()
  };
  for (const heroID in signatures) {
    nextViewed[heroID] = signatures[heroID];
  }
  setViewedTalentSignatures(nextViewed);
  Players.SetPlayerSetting(HERO_TALENT_RED_POINT_VIEWED_SETTING_KEY, JSON.stringify(nextViewed));
  setTalentRedPoints({});
  setRedPointBatch(Object.values(KeyValues.heroes).map(hero => ({
    path: ["hero", "Hero_Menu", String(hero.HeroID), "Talent"],
    value: false
  })));
};
CustomUIConfig.__heroRedPointState = {
  heroSoulRedPoints,
  heroTalentRedPoints,
  heroStoryRewardRedPoints,
  heroWeaponRedPoints,
  heroCourierRedPoints,
  clearHeroTalentRedPoints
};
function useHeroRedPoints() {
  defineRedPointRule("hero", () => {
    const playerHeroes = createRedPointServiceData("player_heroes", {});
    const playerTokens = createRedPointServiceData("player_tokens", {});
    const playerKeyValues = createRedPointServiceData("player_key_values", {});
    const playerHeroStarRewardsReceiveRecords = createRedPointServiceData("player_hero_star_rewards_receive_records", {});
    const playerAccountLevel = service_netdata_helper.usePlayerAccountLevel("hero_level");
    const heroLevel = () => playerAccountLevel().level ?? 0;
    soulRedPoints = libs.createMemo(() => {
      const heroes = playerHeroes();
      const result = {};
      for (const heroName in KeyValues.heroes) {
        const heroID = String(KeyValues.heroes[heroName].HeroID);
        const heroData = heroes[heroID];
        if (!heroData) continue;
        const star = heroData.star ?? 0;
        const maxStar = Object.keys(KeyValues.hero_soul_infusion_effect[heroID] ?? {}).length;
        if (star >= maxStar) continue;
        const cost = KeyValues.hero_soul_infusion[String(star)]?.soul_infusion_cost;
        if (cost && (heroData.extra_star_exp ?? 0) >= cost) {
          result[heroID] = true;
        }
      }
      return result;
    });
    storyRewardRedPoints = libs.createMemo(() => {
      const heroes = playerHeroes();
      const receiveRecords = playerHeroStarRewardsReceiveRecords();
      const result = {};
      for (const heroName in KeyValues.heroes) {
        const heroID = String(KeyValues.heroes[heroName].HeroID);
        const heroData = heroes[heroID];
        if (!heroData) continue;
        if (hasHeroStoryReward(heroID, heroData.star ?? 0, receiveRecords)) {
          result[heroID] = true;
        }
      }
      return result;
    });
    upgradableTalentSignatures = libs.createMemo(() => {
      const heroes = playerHeroes();
      const tokens = playerTokens();
      const level = heroLevel();
      const result = {};
      for (const heroName in KeyValues.heroes) {
        const heroID = String(KeyValues.heroes[heroName].HeroID);
        const heroData = heroes[heroID];
        if (!heroData) continue;
        const savedTalents = JSON.parseSafe(heroData?.talents ?? "") ?? {};
        const savedCost = getHeroTalentTokenCost(savedTalents);
        const heroTalents = Object.values(KeyValues.hero_talent).filter(cfg => String(cfg.hero) === heroID);
        if (heroTalents.length === 0) continue;
        const upgradableTalents = [];
        for (const talentCfg of heroTalents) {
          const talentID = talentCfg.talent_id;
          const currentLevel = toFiniteNumber(savedTalents[talentID]);
          const prerequisitesMet = !talentCfg.requires || talentCfg.requires.split("|").every(requirement => {
            const [requiredTalentID, requiredLevel] = requirement.split(":");
            return toFiniteNumber(savedTalents[requiredTalentID]) >= toFiniteNumber(requiredLevel);
          });
          if (!prerequisitesMet) continue;
          const nextLevel = currentLevel + 1;
          const nextEffectCfg = KeyValues.hero_talent_effect?.[talentID]?.[String(nextLevel)];
          if (!nextEffectCfg) continue;
          if (toFiniteNumber(nextEffectCfg.lock) > 0 && level < nextEffectCfg.lock) continue;
          const curEffectCfg = KeyValues.hero_talent_effect?.[talentID]?.[String(currentLevel)];
          if (!curEffectCfg?.talent_cost) {
            upgradableTalents.push(`${talentID}:${nextLevel}`);
            continue;
          }
          const costs = solid_utils.parseTokenCosts(curEffectCfg.talent_cost);
          const canAfford = costs.length > 0 && costs.every(cost => {
            const actualAmount = tokens[cost.name]?.amounts ?? 0;
            const totalCost = savedCost[cost.name] ?? 0;
            return actualAmount - totalCost - cost.value >= 0;
          });
          if (canAfford) {
            upgradableTalents.push(`${talentID}:${nextLevel}`);
          }
        }
        if (upgradableTalents.length > 0) {
          result[heroID] = upgradableTalents.sort().join("|");
        }
      }
      return result;
    });
    libs.createMemo(() => {
      const result = {};
      for (const heroID in upgradableTalentSignatures()) {
        result[heroID] = true;
      }
      return result;
    });
    const visibleTalentRedPoints = libs.createMemo(() => {
      const viewed = viewedTalentSignatures();
      const result = {};
      for (const heroID in upgradableTalentSignatures()) {
        if (viewed[heroID] === upgradableTalentSignatures()[heroID]) continue;
        result[heroID] = true;
      }
      return result;
    });
    libs.createEffect(() => {
      const value = playerKeyValues()[HERO_TALENT_RED_POINT_VIEWED_SETTING_KEY]?.value;
      if (value != undefined) {
        setViewedTalentSignatures(parseViewedTalentSignatures(value));
      }
    });
    libs.createEffect(() => {
      setTalentRedPoints(visibleTalentRedPoints());
    });
    const playerWeapons = createRedPointServiceData("player_weapons", {});
    weaponRedPoints = libs.createMemo(() => {
      const weapons = playerWeapons();
      const result = {};
      for (const weaponID in weapons) {
        const wData = weapons[weaponID];
        if ((wData?.star ?? 0) <= 0) continue;
        if ((wData?.star ?? 0) >= 6) continue;
        if ((wData?.extra_star_exp ?? 0) >= 1) {
          result[weaponID] = true;
        }
      }
      return result;
    });
    const playerCouriers = createRedPointServiceData("player_couriers", {});
    courierRedPoints = libs.createMemo(() => {
      const couriers = playerCouriers();
      const result = {};
      for (const courierID in couriers) {
        const cData = couriers[courierID];
        if ((cData?.star ?? 0) <= 0) continue;
        if ((cData?.star ?? 0) >= 6) continue;
        if ((cData?.extra_star_exp ?? 0) >= 1) {
          result[courierID] = true;
        }
      }
      return result;
    });
    libs.createEffect(libs.on([soulRedPoints, talentRedPoints, storyRewardRedPoints, weaponRedPoints, courierRedPoints], ([soulRed, talentRed, storyRewardRed, weaponRed, courierRed]) => {
      const updates = [];
      const allHeroIDs = new Set();
      for (const heroName in KeyValues.heroes) {
        allHeroIDs.add(String(KeyValues.heroes[heroName].HeroID));
      }
      for (const heroID of allHeroIDs) {
        updates.push({
          path: ["hero", "Hero_Menu", heroID, "Soul"],
          value: !!soulRed[heroID]
        });
        updates.push({
          path: ["hero", "Hero_Menu", heroID, "Talent"],
          value: !!talentRed[heroID]
        });
        updates.push({
          path: ["hero", "Hero_Menu", heroID, "StoryReward"],
          value: !!storyRewardRed[heroID]
        });
      }
      for (const weaponID in playerWeapons()) {
        updates.push({
          path: ["hero", "Weapon_Menu", weaponID, "Upgrade"],
          value: !!weaponRed[weaponID]
        });
      }
      for (const courierID in playerCouriers()) {
        updates.push({
          path: ["hero", "Courier_Menu", courierID, "Upgrade"],
          value: !!courierRed[courierID]
        });
      }
      setRedPointBatch(updates);
    }));
  });
}

const ARENA_TASK_ID = 8001001;
const WEEKLY_PVP_TASK_VIEWED_DAY_KEY = "rank_weekly_pvp_task_viewed_day";
const BEIJING_TIME_OFFSET_SECONDS = 8 * 60 * 60;
function getBeijingDayStart(timestamp) {
  const seconds = Math.floor(timestamp);
  return seconds - (seconds + BEIJING_TIME_OFFSET_SECONDS) % 86400;
}
const [locallyViewedDay, setLocallyViewedDay] = libs.createSignal();
CustomUIConfig.__rankRedPointState = {
  markWeeklyPvpTaskViewed: () => {
    const today = getBeijingDayStart(CustomUIConfig.GetServerTimeStamp());
    setLocallyViewedDay(today);
    CallAction("/v1/key/save", {
      type: "setting",
      key: WEEKLY_PVP_TASK_VIEWED_DAY_KEY,
      value: String(today)
    });
  }
};
function useRankRedPoints() {
  defineRedPointRule("rank", () => {
    const playerWeeklyPvpTasks = createRedPointServiceData("player_weekly_pvp_tasks", {});
    const playerKeyValues = createRedPointServiceData("player_key_values", {});
    const [serverTime, setServerTime] = libs.createSignal(Math.floor(CustomUIConfig.GetServerTimeStamp()));
    const serverTimeInterval = setInterval(() => {
      setServerTime(Math.floor(CustomUIConfig.GetServerTimeStamp()));
    }, 60 * 1000);
    libs.onCleanup(() => clearInterval(serverTimeInterval));
    libs.createEffect(() => {
      const task = Object.values(playerWeeklyPvpTasks()).find(task => task.task_id === ARENA_TASK_ID);
      if (task === undefined) {
        setRedPoint(["rank", "Ladder", "ladder_lobby", "LadderLobbyButtonStore"], false);
        return;
      }
      const today = getBeijingDayStart(serverTime());
      const savedViewedDay = Number(playerKeyValues()[WEEKLY_PVP_TASK_VIEWED_DAY_KEY]?.value);
      const viewedToday = locallyViewedDay() === today || savedViewedDay === today;
      const canReceive = task.receive_progress != 1 && task.progress >= task.target;
      const needsGuide = task.receive_progress != 1 && task.progress < task.target && !viewedToday;
      setRedPoint(["rank", "Ladder", "ladder_lobby", "LadderLobbyButtonStore"], canReceive || needsGuide);
    });
  });
}

function useMiningActivityRedPoints() {
  defineRedPointRule("activity_mining", () => {
    const playerMiningActivityData = createRedPointServiceData("player_mining_activity_data", {});
    const playerActivityTasks = createRedPointServiceData("player_activity_tasks", {});
    const [serverTime, setServerTime] = libs.createSignal(Math.floor(CustomUIConfig.GetServerTimeStamp()));
    const serverTimeInterval = setInterval(() => {
      setServerTime(Math.floor(CustomUIConfig.GetServerTimeStamp()));
    }, 1000);
    libs.onCleanup(() => clearInterval(serverTimeInterval));
    libs.createEffect(() => {
      const hasClaimableReward = dig_veins_logic.hasClaimableDigVeinsTask(playerActivityTasks(), serverTime()) || dig_veins_logic.hasClaimableDigVeinsDepthReward(playerMiningActivityData()[dig_veins_logic.ACTIVITY_MINING_ID]);
      setRedPoint(["activity", "mining", "veins_game"], hasClaimableReward);
    });
  });
}

function useRuneRedPoints() {
  defineRedPointRule("rune", () => {
    const playerRunes = createRedPointServiceData("player_runes", {});
    const playerEngravings = createRedPointServiceData("player_engravings", {});
    const runeUnreadIds = solid_utils.createPlayerUnreadIds("rune");
    const engravingUnreadIds = solid_utils.createPlayerUnreadIds("engraving");
    libs.createEffect(() => {
      const unreads = runeUnreadIds.unreadIds();
      const runes = playerRunes();
      const hasUnread = Object.keys(unreads).some(id => runes[id] != undefined && runeUnreadIds.isUnread(id));
      setRedPoint(["rune", "RuneEmbed_Menu"], hasUnread);
    });
    libs.createEffect(() => {
      const unreads = engravingUnreadIds.unreadIds();
      const engravings = playerEngravings();
      const hasUnread = Object.keys(unreads).some(id => engravings[id] != undefined && engravingUnreadIds.isUnread(id));
      setRedPoint(["rune", "RuneInlay_Menu"], hasUnread);
    });
  });
}

const separatedStoreTags = new Set(["Fish", "Explore", "Flowers", "StarStone", "BoardSlotGift", "BoardSlot"]);
const staticStoreMenus = ["collection_vip", "collection_treasure", "Universe"];
const storeMenuOrder = ["Privilege", "Hot", "Gift", "Resource", "collection_vip", "collection_treasure", "Moon"];
const getStoreMenuOrder = tag => {
  const order = storeMenuOrder.indexOf(tag);
  return order == -1 ? storeMenuOrder.length : order;
};
function buildStoreItemData(infoProducts) {
  const result = {};
  const now = Date.now() / 1000;
  for (const itemname in KeyValues.info_shop_product) {
    const itemdata = KeyValues.info_shop_product[itemname];
    const infoProduct = infoProducts[itemdata.id];
    const effectiveStartTime = infoProduct ? infoProduct.start_time : itemdata.start_time;
    const effectiveEndTime = infoProduct ? infoProduct.end_time : itemdata.end_time;
    if ((effectiveStartTime < now || effectiveStartTime == 0) && (effectiveEndTime > now || effectiveEndTime == 0) && itemdata.hide == 0 || itemdata.tag == "Privilege") {
      const tags = itemdata.tag.split("|");
      tags.forEach(tag => {
        result[tag] = result[tag] || [];
        result[tag].push(itemdata);
      });
    }
  }
  return result;
}
function canAnyTreasureLevelUp(playerCollectionTreasures) {
  for (const [itemID, levelConfig] of Object.entries(KeyValues.collection_treasure ?? {})) {
    const levels = Object.entries(levelConfig ?? {}).map(([level, data]) => ({
      level: toFiniteNumber(level, 0),
      data: data
    })).filter(({
      level
    }) => level > 0).sort((a, b) => a.level - b.level);
    const maxLevel = levels[levels.length - 1]?.level ?? 0;
    if (maxLevel <= 0) continue;
    const treasureData = playerCollectionTreasures[itemID];
    const level = Math.min(Math.max(0, toFiniteNumber(treasureData?.level, 0)), maxLevel);
    if (level >= maxLevel) continue;
    const nextLevelConfig = levels.find(entry => entry.level == level + 1);
    const levelCost = toFiniteNumber(nextLevelConfig?.data.level_cost, 0);
    const extraExp = Math.max(0, toFiniteNumber(treasureData?.extra_exp, 0));
    if (levelCost > 0 && extraExp >= levelCost) {
      return true;
    }
  }
  return false;
}
function hasClaimableVipReward(playerAccountLevels, rewardReceiveRecordsRaw) {
  const playerLevel = Math.max(1, toFiniteNumber(playerAccountLevels.collection_treasure?.level, 1));
  const receivedRecords = rewardReceiveRecordsRaw.collection_treasure ?? {};
  return Object.values(KeyValues.collection_treasure_level_reward ?? {}).some(config => {
    const rewardConfig = config;
    const hasReward = Object.keys(rewardConfig.reward ?? {}).length > 0;
    return hasReward && rewardConfig.level <= playerLevel && receivedRecords[String(rewardConfig.level)] !== true;
  });
}
function useStoreRedPoints() {
  defineRedPointRule("store", () => {
    const infoProducts = createRedPointServiceData("info_products", {});
    const playerPrivileges = solid_utils.createPlayerNetDataSignal("common", "player_privileges", {});
    const purchasedProduct = createRedPointServiceData("player_shop_product_limits", {});
    const playerCollectionTreasures = createRedPointServiceData("player_collection_treasures", {});
    const playerAccountLevels = createRedPointServiceData("player_account_levels", {});
    const rewardReceiveRecordsRaw = createRedPointServiceData("player_account_level_rewards_receive_records", {});
    const playerMoonstoneActivityData = createRedPointServiceData("player_moonstone_activity_data", {});
    const storeItemData = libs.createMemo(() => buildStoreItemData(infoProducts()));
    const menuKeys = libs.createMemo(() => Array.from(new Set([...Object.keys(storeItemData()).filter(tag => !separatedStoreTags.has(tag)), ...staticStoreMenus])).sort((a, b) => getStoreMenuOrder(a) - getStoreMenuOrder(b)));
    libs.createEffect(libs.on([storeItemData, purchasedProduct, playerPrivileges], () => {
      const purchased = purchasedProduct();
      const updates = [];
      for (const tag of menuKeys()) {
        if (staticStoreMenus.includes(tag)) continue;
        const dataList = storeItemData()[tag] ?? [];
        updates.push({
          path: ["store", tag],
          value: StoreTagPage.hasFreeStoreTagItem(dataList, purchased, playerPrivileges())
        });
      }
      setRedPointBatch(updates);
    }));
    libs.createEffect(() => {
      setRedPoint(["store", "collection_treasure"], canAnyTreasureLevelUp(playerCollectionTreasures()));
    });
    libs.createEffect(() => {
      setRedPoint(["store", "collection_vip"], hasClaimableVipReward(playerAccountLevels(), rewardReceiveRecordsRaw()));
    });
    libs.createEffect(() => {
      const activityID = "901";
      const rewards = Object.values(KeyValues.activity_moonstone[activityID] ?? {});
      const activityData = playerMoonstoneActivityData()[activityID];
      const received = activityData?.received;
      const receivedRewardIDs = Array.isArray(received) ? received.map(Number) : String(received ?? "").split(",").filter(Boolean).map(Number);
      const progress = Number(activityData?.extra_num ?? 0);
      const hasClaimableReward = KeyValues.drawcards["3001"] != undefined && rewards.some(reward => !receivedRewardIDs.includes(reward.reward_id) && progress >= reward.num);
      setRedPoint(["store", "Universe", "SeaMysteryTask"], hasClaimableReward);
    });
  });
}

function RedPointCenter() {
  useActivityRedPoints();
  useCosmeticRedPoints();
  useEquipmentRedPoints();
  useFishingItemRedPoints();
  useHeroRedPoints();
  useRankRedPoints();
  useMiningActivityRedPoints();
  useRuneRedPoints();
  useStoreRedPoints();
  return libs.createElement("Panel", {
    id: "RedPointCenter",
    visible: false,
    hittest: false
  }, null);
}
libs.render(() => libs.createComponent(RedPointCenter, {}), $.GetContextPanel());