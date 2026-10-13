--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1a5b3bb 
  ~ auto-generated — do not edit
]]


'use strict'; const exports = {}; GameUI.__loadModule('huntloot_utils', exports); const require = GameUI.__require;

var libs = require('./libs.js');
var attribute_formatter = require('./attribute_formatter.js');
var solid_utils = require('./solid_utils.js');

const HUNTLOOT_PARTS = [1, 2, 3];
const MAX_HUNTLOOT_RARITY = 7;
const HuntlootSimplifyConfig = ["id", "huntloot_item_id", "level", "locked", "in_equip_suit", "in_check"];
let HuntlootEntryByName;
function GetHuntlootEntryConfig(entryID) {
  HuntlootEntryByName ??= Object.values(KeyValues.huntloot_entry ?? {}).reduce((res, row) => {
    res[row.entry_name] = row;
    return res;
  }, {});
  return HuntlootEntryByName[entryID];
}
function HuntlootAttributeRound(entryID, value) {
  const ratio = GetHuntlootEntryConfig(entryID)?.ratio ?? 1;
  return Round(value, ratio);
}
function GetHuntlootAttrDisplay(entry, entryType, options) {
  let id = entry.id;
  let displayData = entry;
  if (entryType === 3 && entry.id.startsWith("drawing_")) {
    id = entry.id.slice(8);
    displayData = {
      ...entry,
      id
    };
  }
  const kv = GetHuntlootEntryConfig(entry.id);
  return attribute_formatter.formatAttributeDisplay(displayData, {
    config: {
      ratio: kv?.ratio ?? 1,
      value_min: kv?.value_min,
      value_max: kv?.value_max
    },
    ...(entryType === 3 ? {
      attributeNameColor: "#958D83",
      attributeNameLocalize: "drawing_equip_attr"
    } : {}),
    showAttributeRange: options?.showAttributeRange,
    hideExtraValue: options?.hideExtraValue
  });
}
function FillHuntlootCfgData(data) {
  const kv = KeyValues.info_item_huntloot[data.huntloot_item_id];
  if (kv == undefined) return false;
  const classSetting = KeyValues.huntloot_class_setting[kv.class];
  data.class = kv.class;
  data.huntloot_part = kv.huntloot_part;
  data.rarity = kv.rarity;
  data.need_level = classSetting?.need_level ?? 0;
  return true;
}
function ParseHuntloot(serialized, copyData) {
  let result = {};
  HuntlootSimplifyConfig.forEach((k, i) => {
    result[k] = serialized[i];
    if (copyData) {
      copyData[k] = serialized[i];
    }
  });
  FillHuntlootCfgData(result);
  return result;
}
function GetSimplifyHuntloots(playerID = Game.GetLocalPlayerID()) {
  CustomUIConfig.HuntlootDetailCache ??= {};
  CustomUIConfig.HuntlootSimpleDataCache ??= {};
  const playerHuntloots = solid_utils.createServiceNetData("player_huntloots", {}, playerID);
  const equipSuits = solid_utils.createServiceNetData("player_hero_huntloot_equip_suits", {}, playerID);
  function Parse(huntloots, suits) {
    let res = {};
    for (const key in huntloots) {
      const data = huntloots[key];
      if (data == undefined || typeof data !== "object") continue;
      const cacheData = CustomUIConfig.HuntlootDetailCache[key];
      let parsed = ParseHuntloot(data, cacheData);
      if (parsed) {
        parsed.in_equip_suit = GetHuntlootEquippedSuits(parsed, suits).map(([heroID, suitID]) => `${heroID}:${suitID}`).join(";");
        if (cacheData) cacheData.in_equip_suit = parsed.in_equip_suit;
        res[key] = parsed;
      }
    }
    return res;
  }
  return libs.createMemo(() => {
    let simpleData = Parse(playerHuntloots(), equipSuits());
    CustomUIConfig.HuntlootSimpleDataCache = simpleData;
    return simpleData;
  });
}
function GetHuntlootDetail(ids, callback, force = false) {
  CustomUIConfig.HuntlootDetailCache ??= {};
  let result = {};
  let requestIDs = force ? ids : ids.filter(id => {
    if (CustomUIConfig.HuntlootDetailCache[id]) {
      result[id] = CustomUIConfig.HuntlootDetailCache[id];
      return false;
    }
    return true;
  });
  if (requestIDs.length > 0) {
    return ServerRequest("get_huntloot_detail", {
      id: requestIDs.map(i => String(i))
    }, data => {
      for (let [id, v] of Object.entries(data)) {
        if (FillHuntlootCfgData(v)) {
          result[id] = v;
          CustomUIConfig.HuntlootDetailCache[id] = v;
        }
      }
      callback(result);
    });
  } else {
    callback(result);
  }
}
function ShowServerHuntlootTooltip(p, props) {
  let ids = [props.id1];
  if (props.id2) {
    ids.push(props.id2);
  }
  GetHuntlootDetail(ids, () => {
    if (p.IsValid() && p.BHasHoverStyle()) {
      ShowCustomTooltip(p, "server_huntloot", {
        id1: props.id1,
        id2: props.id2,
        hero_id: props.hero_id
      });
    }
  }, props.force);
}
function GetHuntlootEquippedSuits(huntloot, equipSuits = getServiceNetData("player_hero_huntloot_equip_suits", Players.GetLocalPlayer()) ?? {}) {
  const result = [];
  if (huntloot.id <= 0) return result;
  for (const [heroID, suits] of Object.entries(equipSuits)) {
    for (const [suitID, parts] of Object.entries(suits)) {
      const equippedID = parts[huntloot.huntloot_part];
      if (equippedID != undefined && equippedID !== "nil" && String(equippedID) === String(huntloot.id)) {
        result.push([toFiniteNumber(heroID), toFiniteNumber(suitID)]);
      }
    }
  }
  return result;
}
function HuntlootIsEquiped(huntloot, heroID) {
  return GetHuntlootEquippedSuits(huntloot).some(([equippedHeroID]) => heroID == undefined || equippedHeroID === heroID);
}
function HuntlootHasStates(huntloot, showTips) {
  let state = "";
  if (HuntlootIsEquiped(huntloot)) {
    state = "#EquipmentError_1";
  }
  if (huntloot.locked) {
    state = "#EquipmentError_2";
  }
  if (huntloot.in_check && huntloot.in_check !== "") {
    state = "#EquipmentError_InCheck";
  }
  let hasState = state != "";
  if (showTips && hasState) {
    ErrorMessage(state);
  }
  return hasState;
}
function GetHuntlootName(huntloot) {
  const localizedName = GetLocalization(`#${huntloot.huntloot_item_id}`, "");
  if (localizedName != "") {
    return localizedName;
  }
  const kv = KeyValues.info_item_huntloot[huntloot.huntloot_item_id];
  const rarity = huntloot.rarity ?? kv?.rarity ?? 0;
  const part = huntloot.huntloot_part ?? kv?.huntloot_part ?? 0;
  return LocalizeWithVars("#Huntloot_DefaultName", {
    rarity,
    part: GetLocalization(`#Equipment_HuntlootPart_${part}`, "")
  });
}
function createHuntlootDetailSignal(id_signal) {
  const [huntlootData, setHuntlootData] = libs.createSignal();
  const [force, _forceFresh] = libs.createSignal(false);
  libs.createEffect(() => {
    force();
    let id = String(id_signal());
    setHuntlootData();
    if (id && id !== "undefined") {
      let request = GetHuntlootDetail([id], data => {
        setHuntlootData(data[id]);
      }, true);
      request && libs.onCleanup(() => CancelRequest(request));
    } else {
      setHuntlootData();
    }
  });
  return {
    huntlootData,
    forceFresh: () => {
      _forceFresh(b => !b);
    }
  };
}
function ParseHuntlootDevourCosts() {
  const rawValue = KeyValues.huntloot_common_setting?.huntloot_devour?.value ?? "";
  if (rawValue === "") {
    return [];
  }
  return rawValue.split("|").map(costText => {
    const [itemIDText, amountText] = costText.split(":");
    return {
      itemID: toFiniteNumber(itemIDText, 0),
      amount: toFiniteNumber(amountText, 0)
    };
  }).filter(cost => cost.itemID > 0 && cost.amount > 0);
}

exports.GetHuntlootAttrDisplay = GetHuntlootAttrDisplay;
exports.GetHuntlootDetail = GetHuntlootDetail;
exports.GetHuntlootEquippedSuits = GetHuntlootEquippedSuits;
exports.GetHuntlootName = GetHuntlootName;
exports.GetSimplifyHuntloots = GetSimplifyHuntloots;
exports.HUNTLOOT_PARTS = HUNTLOOT_PARTS;
exports.HuntlootAttributeRound = HuntlootAttributeRound;
exports.HuntlootHasStates = HuntlootHasStates;
exports.HuntlootIsEquiped = HuntlootIsEquiped;
exports.MAX_HUNTLOOT_RARITY = MAX_HUNTLOOT_RARITY;
exports.ParseHuntlootDevourCosts = ParseHuntlootDevourCosts;
exports.ShowServerHuntlootTooltip = ShowServerHuntlootTooltip;
exports.createHuntlootDetailSignal = createHuntlootDetailSignal;