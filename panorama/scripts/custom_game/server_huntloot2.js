--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1a5b3bb 
  ~ auto-generated — do not edit
]]


'use strict'; const exports = {}; GameUI.__loadModule('server_huntloot2', exports); const require = GameUI.__require;

var libs = require('./libs.js');
var attribute_formatter = require('./attribute_formatter.js');
var solid_utils = require('./solid_utils.js');

const HUNTLOOT_UI_ENABLED = false;
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
  function Parse(huntloots) {
    let res = {};
    for (const key in huntloots) {
      const data = huntloots[key];
      if (data == undefined || typeof data !== "object") continue;
      const cacheData = CustomUIConfig.HuntlootDetailCache[key];
      let parsed = ParseHuntloot(data, cacheData);
      if (parsed) {
        res[key] = parsed;
      }
    }
    return res;
  }
  return libs.createMemo(() => {
    let simpleData = Parse(playerHuntloots());
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
function HuntlootIsEquiped(huntloot, heroID) {
  if (huntloot.in_equip_suit == undefined || huntloot.in_equip_suit == "") {
    return false;
  }
  if (heroID == undefined) {
    return true;
  }
  const datas = huntloot.in_equip_suit.split(";");
  for (let i = 0; i < datas.length; i++) {
    const [hID] = datas[i].split(":");
    if (toFiniteNumber(hID) == heroID) {
      return true;
    }
  }
  return false;
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

function Huntloot(props) {
  const iconName = () => KeyValues.info_item_huntloot[props.huntloot_item_id]?.icon;
  return (() => {
    const _el$ = libs.createElement("Panel", {
        get ["class"]() {
          return "Huntloot Rarity" + props.rarity;
        },
        get onmouseover() {
          return props.onmouseover;
        },
        get onmouseout() {
          return props.onmouseout;
        }
      }, null),
      _el$2 = libs.createElement("Image", {
        id: "HuntlootIcon",
        get src() {
          return `file://{images}/custom_game/store_items/${iconName()}.png`;
        }
      }, _el$);
    libs.insert(_el$, libs.createComponent(libs.Show, {
      get when() {
        return props.locked;
      },
      get children() {
        return libs.createElement("Panel", {
          id: "Lock"
        }, null);
      }
    }), null);
    libs.insert(_el$, libs.createComponent(libs.Show, {
      get when() {
        return props.equipped;
      },
      get children() {
        return libs.createElement("Image", {
          id: "EquipedTag"
        }, null);
      }
    }), null);
    libs.insert(_el$, libs.createComponent(libs.Show, {
      get when() {
        return props.level > 0;
      },
      get children() {
        const _el$5 = libs.createElement("Label", {
          id: "LevelLabel",
          get text() {
            return "+" + props.level;
          }
        }, null);
        libs.effect(_$p => libs.setProp(_el$5, "text", "+" + props.level, _$p));
        return _el$5;
      }
    }), null);
    libs.effect(_p$ => {
      const _v$ = "Huntloot Rarity" + props.rarity,
        _v$2 = props.onmouseover,
        _v$3 = props.onmouseout,
        _v$4 = `file://{images}/custom_game/store_items/${iconName()}.png`;
      _v$ !== _p$._v$ && (_p$._v$ = libs.setProp(_el$, "class", _v$, _p$._v$));
      _v$2 !== _p$._v$2 && (_p$._v$2 = libs.setProp(_el$, "onmouseover", _v$2, _p$._v$2));
      _v$3 !== _p$._v$3 && (_p$._v$3 = libs.setProp(_el$, "onmouseout", _v$3, _p$._v$3));
      _v$4 !== _p$._v$4 && (_p$._v$4 = libs.setProp(_el$2, "src", _v$4, _p$._v$4));
      return _p$;
    }, {
      _v$: undefined,
      _v$2: undefined,
      _v$3: undefined,
      _v$4: undefined
    });
    return _el$;
  })();
}

exports.GetHuntlootAttrDisplay = GetHuntlootAttrDisplay;
exports.GetHuntlootDetail = GetHuntlootDetail;
exports.GetHuntlootName = GetHuntlootName;
exports.GetSimplifyHuntloots = GetSimplifyHuntloots;
exports.HUNTLOOT_PARTS = HUNTLOOT_PARTS;
exports.HUNTLOOT_UI_ENABLED = HUNTLOOT_UI_ENABLED;
exports.Huntloot = Huntloot;
exports.HuntlootAttributeRound = HuntlootAttributeRound;
exports.HuntlootHasStates = HuntlootHasStates;
exports.HuntlootIsEquiped = HuntlootIsEquiped;
exports.MAX_HUNTLOOT_RARITY = MAX_HUNTLOOT_RARITY;
exports.ParseHuntlootDevourCosts = ParseHuntlootDevourCosts;
exports.ShowServerHuntlootTooltip = ShowServerHuntlootTooltip;
exports.createHuntlootDetailSignal = createHuntlootDetailSignal;