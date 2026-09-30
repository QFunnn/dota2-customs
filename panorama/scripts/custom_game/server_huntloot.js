--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1a5b3bb 
  ~ auto-generated — do not edit
]]


'use strict'; const require = GameUI.__require;

var libs = require('./libs.js');
var EOM_Loading = require('./EOM_Loading.js');
var solid_utils = require('./solid_utils.js');
var server_huntloot = require('./server_huntloot2.js');
require('./attribute_formatter.js');
require('./equipment_utils.js');

function ServerHuntlootDetail(props) {
  const [local, others] = libs.splitProps(props, ["data", "class"]);
  return (() => {
    const _el$ = libs.createElement("Panel", libs.mergeProps$1(others, {
      get ["class"]() {
        return libs.classNames("ServerHuntlootDetail", "ServerEquipDetail", local.class);
      }
    }), null);
    libs.spread(_el$, libs.mergeProps$1(others, {
      get ["class"]() {
        return libs.classNames("ServerHuntlootDetail", "ServerEquipDetail", local.class);
      }
    }), true);
    libs.insert(_el$, () => libs.createMemo(() => {
      let data = props.data;
      if (data) {
        return libs.createComponent(ServerHuntlootDetailLoaded, data);
      }
      return libs.createComponent(EOM_Loading.EOM_Loading, {});
    }));
    return _el$;
  })();
}
function ServerHuntlootDetailLoaded(props) {
  const partDatas = solid_utils.createServiceNetData("player_huntloot_part_datas", {});
  const huntlootData = () => props.data;
  const equipped = () => huntlootData().in_equip_suit && huntlootData().in_equip_suit != "";
  const displayedAdverbEntries = libs.createMemo(() => {
    const entries = huntlootData().adverb_entry_data;
    if (!equipped()) return entries;
    const level = partDatas()[huntlootData().huntloot_part]?.level ?? 0;
    const bonus = KeyValues.huntloot_level_setting[level]?.adverb_bonus;
    if (!bonus) return entries;
    return entries.map(entry => ({
      ...entry,
      value: server_huntloot.HuntlootAttributeRound(entry.id, (entry.base_value ?? entry.value) + (entry.base_value ?? entry.value) * bonus)
    }));
  });
  const canWear = () => {
    const heroLv = getServiceNetData("player_account_levels", Players.GetLocalPlayer())?.hero_level?.level ?? 1;
    return heroLv >= huntlootData().need_level;
  };
  const compareAdverbMap = libs.createMemo(() => {
    const compare = props.compareData;
    if (!compare) return undefined;
    const map = {};
    compare.adverb_entry_data.forEach(entry => {
      map[entry.id] = entry.base_value ?? entry.value;
    });
    return map;
  });
  const displayName = libs.createMemo(() => {
    let nameStr = server_huntloot.GetHuntlootName(huntlootData());
    if (huntlootData().level > 0) {
      nameStr = nameStr.concat(`+${huntlootData().level}`);
    }
    return nameStr;
  });
  return (() => {
    const _el$2 = libs.createElement("Panel", {
        id: "ServerEquipDetailLoaded",
        get ["class"]() {
          return libs.classNames("TipsRarity" + huntlootData().rarity, {
            UnableWear: !canWear()
          });
        }
      }, null),
      _el$3 = libs.createElement("Panel", {
        id: "Top"
      }, _el$2),
      _el$4 = libs.createElement("Panel", {
        id: "EquipmentInfo"
      }, _el$3),
      _el$5 = libs.createElement("Panel", {
        id: "TopLeft"
      }, _el$3),
      _el$6 = libs.createElement("Label", {
        id: "Name",
        get text() {
          return displayName();
        }
      }, _el$5),
      _el$7 = libs.createElement("Panel", {
        id: "OtherInfo"
      }, _el$5),
      _el$8 = libs.createElement("Label", {
        id: "EquipNeedLevel",
        "class": "TopLabel",
        get vars() {
          return {
            value: canWear() ? huntlootData().need_level.toString() : ToColor(huntlootData().need_level.toString(), "#E55043")
          };
        },
        text: "#Equip_NeedLevel",
        html: true
      }, _el$7),
      _el$9 = libs.createElement("Panel", {
        id: "AttrList"
      }, _el$2);
    libs.insert(_el$4, libs.createComponent(server_huntloot.Huntloot, libs.mergeProps$1(huntlootData)));
    libs.insert(_el$9, libs.createComponent(libs.Show, {
      get when() {
        return displayedAdverbEntries().length > 0;
      },
      get children() {
        return [libs.createElement("Panel", {
          "class": "Separator"
        }, null), libs.createComponent(libs.Index, {
          get each() {
            return displayedAdverbEntries();
          },
          children: data => libs.createComponent(HuntlootAttrRow, {
            get data() {
              return data();
            },
            get compareMap() {
              return compareAdverbMap();
            },
            get hideExtraValue() {
              return props.hideExtraValue;
            }
          })
        })];
      }
    }), null);
    libs.insert(_el$9, libs.createComponent(libs.Show, {
      get when() {
        return huntlootData().spell_entry_data.length > 0;
      },
      get children() {
        return [libs.createElement("Panel", {
          "class": "Separator"
        }, null), libs.createComponent(libs.Index, {
          get each() {
            return huntlootData().spell_entry_data;
          },
          children: data => libs.createComponent(HuntlootSpellRow, {
            get data() {
              return data();
            }
          })
        })];
      }
    }), null);
    libs.effect(_p$ => {
      const _v$ = libs.classNames("TipsRarity" + huntlootData().rarity, {
          UnableWear: !canWear()
        }),
        _v$2 = displayName(),
        _v$3 = {
          value: canWear() ? huntlootData().need_level.toString() : ToColor(huntlootData().need_level.toString(), "#E55043")
        };
      _v$ !== _p$._v$ && (_p$._v$ = libs.setProp(_el$2, "class", _v$, _p$._v$));
      _v$2 !== _p$._v$2 && (_p$._v$2 = libs.setProp(_el$6, "text", _v$2, _p$._v$2));
      _v$3 !== _p$._v$3 && (_p$._v$3 = libs.setProp(_el$8, "vars", _v$3, _p$._v$3));
      return _p$;
    }, {
      _v$: undefined,
      _v$2: undefined,
      _v$3: undefined
    });
    return _el$2;
  })();
}
function HuntlootAttrRow(props) {
  const info = libs.createMemo(() => server_huntloot.GetHuntlootAttrDisplay(props.data, 2, {
    showAttributeRange: props.showAttributeRange,
    hideExtraValue: props.compareMap != undefined || props.hideExtraValue
  }));
  const isUp = () => {
    if (!props.compareMap) return undefined;
    const compareValue = props.compareMap[props.data.id];
    if (compareValue === undefined) return undefined;
    const baseValue = props.data.base_value ?? props.data.value;
    if (baseValue === compareValue) return undefined;
    return baseValue > compareValue;
  };
  return (() => {
    const _el$10 = libs.createElement("Panel", {
        get ["class"]() {
          return `EquipmentAttrRow Adverb ${info()?.colorName ?? ""}`;
        }
      }, null);
      libs.createElement("Panel", {
        id: "Point"
      }, _el$10);
      const _el$12 = libs.createElement("Label", {
        id: "AttrValue",
        get text() {
          return info()?.valueText ?? "";
        },
        html: true
      }, _el$10),
      _el$13 = libs.createElement("Label", {
        id: "AttrName",
        get text() {
          return info()?.nameHtml ?? "";
        },
        html: true
      }, _el$10);
    libs.insert(_el$10, libs.createComponent(libs.Show, {
      get when() {
        return isUp() !== undefined;
      },
      get children() {
        const _el$14 = libs.createElement("Panel", {
          id: "CompareTag",
          get ["class"]() {
            return libs.classNames({
              Up: isUp()
            });
          }
        }, null);
        libs.effect(_$p => libs.setProp(_el$14, "class", libs.classNames({
          Up: isUp()
        }), _$p));
        return _el$14;
      }
    }), null);
    libs.effect(_p$ => {
      const _v$4 = `EquipmentAttrRow Adverb ${info()?.colorName ?? ""}`,
        _v$5 = info()?.valueText ?? "",
        _v$6 = info()?.nameHtml ?? "";
      _v$4 !== _p$._v$4 && (_p$._v$4 = libs.setProp(_el$10, "class", _v$4, _p$._v$4));
      _v$5 !== _p$._v$5 && (_p$._v$5 = libs.setProp(_el$12, "text", _v$5, _p$._v$5));
      _v$6 !== _p$._v$6 && (_p$._v$6 = libs.setProp(_el$13, "text", _v$6, _p$._v$6));
      return _p$;
    }, {
      _v$4: undefined,
      _v$5: undefined,
      _v$6: undefined
    });
    return _el$10;
  })();
}
function HuntlootSpellRow(props) {
  const info = libs.createMemo(() => server_huntloot.GetHuntlootAttrDisplay(props.data, 3, {
    showAttributeRange: props.showAttributeRange
  }));
  return (() => {
    const _el$15 = libs.createElement("Panel", {
        get ["class"]() {
          return `DrawingAttrRow EquipmentAttrRow Adverb ${info()?.colorName ?? ""}`;
        }
      }, null);
      libs.createElement("Panel", {
        id: "Point"
      }, _el$15);
      const _el$17 = libs.createElement("Label", {
        id: "AttrValue",
        get text() {
          return info()?.valueText ?? "";
        },
        html: true
      }, _el$15),
      _el$18 = libs.createElement("Label", {
        id: "AttrName",
        get text() {
          return info()?.nameHtml ?? "";
        },
        html: true
      }, _el$15);
    libs.effect(_p$ => {
      const _v$7 = `DrawingAttrRow EquipmentAttrRow Adverb ${info()?.colorName ?? ""}`,
        _v$8 = info()?.valueText ?? "",
        _v$9 = info()?.nameHtml ?? "";
      _v$7 !== _p$._v$7 && (_p$._v$7 = libs.setProp(_el$15, "class", _v$7, _p$._v$7));
      _v$8 !== _p$._v$8 && (_p$._v$8 = libs.setProp(_el$17, "text", _v$8, _p$._v$8));
      _v$9 !== _p$._v$9 && (_p$._v$9 = libs.setProp(_el$18, "text", _v$9, _p$._v$9));
      return _p$;
    }, {
      _v$7: undefined,
      _v$8: undefined,
      _v$9: undefined
    });
    return _el$15;
  })();
}

let root = $.GetContextPanel();
const [huntlootData, setHuntlootData] = libs.createSignal();
const [id2, SetID2] = libs.createSignal();
const [huntlootData2, setHuntlootData2] = libs.createSignal();
let tooltipRequestVersion = 0;
function parseEntries(value) {
  if (!value) return [];
  if (typeof value === "string") {
    return JSON.parseSafe(value) ?? [];
  }
  return value;
}
function normalizeHuntlootData(rawData) {
  if (!rawData) return undefined;
  const result = {
    ...rawData,
    id: rawData.id ?? 0,
    adverb_entry_data: parseEntries(rawData.adverb_entry_data),
    spell_entry_data: parseEntries(rawData.spell_entry_data),
    in_equip_suit: rawData.in_equip_suit ?? "",
    locked: rawData.locked ?? false
  };
  const kv = KeyValues.info_item_huntloot[result.huntloot_item_id];
  if (kv != undefined) {
    const classSetting = KeyValues.huntloot_class_setting[kv.class];
    result.rarity = result.rarity ?? kv.rarity;
    result.huntloot_part = result.huntloot_part ?? kv.huntloot_part;
    result.class = result.class ?? kv.class;
    result.need_level = result.need_level ?? classSetting?.need_level ?? 1;
  }
  return result;
}
function SetupTooltip() {
  const requestVersion = ++tooltipRequestVersion;
  (async () => {
    setHuntlootData();
    setHuntlootData2();
    SetID2();
    const data = root.GetAttributeString("data", "");
    if (data !== "") {
      const parsedData = normalizeHuntlootData(JSON.parseSafe(data));
      if (parsedData != undefined) {
        setHuntlootData({
          data: parsedData
        });
      }
      return;
    }
    let id1 = root.GetAttributeString("id1", "");
    let id2 = root.GetAttributeString("id2", "");
    const hero_id = root.GetAttributeInt("hero_id", -1);
    let idList = [];
    id1 && idList.push(id1);
    id2 && idList.push(id2);
    if (idList.length > 0) {
      server_huntloot.GetHuntlootDetail(idList, list => {
        if (requestVersion !== tooltipRequestVersion || !root.IsValid()) return;
        libs.batch(() => {
          list[id1] && setHuntlootData({
            data: list[id1],
            hero_id: hero_id
          });
          SetID2(list[id2] ? id2 : undefined);
          list[id2] && setHuntlootData2({
            data: list[id2]
          });
        });
      });
    }
  })();
}
function TooltipContents() {
  return [libs.createComponent(libs.Show, {
    get when() {
      return id2();
    },
    get children() {
      const _el$ = libs.createElement("Panel", {
          id: "Detail2",
          get ["class"]() {
            return libs.classNames("DetailContainer", {
              ShowOrnament: huntlootData2() != undefined && huntlootData2().data.rarity >= 7
            });
          }
        }, null);
        libs.createElement("Panel", {
          "class": "BGImg"
        }, _el$);
        const _el$3 = libs.createElement("Panel", {
          "class": "OrnamentPanel"
        }, _el$);
      libs.insert(_el$, libs.createComponent(ServerHuntlootDetail, {
        get data() {
          return libs.memo(() => !!huntlootData2())() ? {
            ...huntlootData2(),
            hideExtraValue: huntlootData() != undefined
          } : undefined;
        }
      }), _el$3);
      libs.effect(_$p => libs.setProp(_el$, "class", libs.classNames("DetailContainer", {
        ShowOrnament: huntlootData2() != undefined && huntlootData2().data.rarity >= 7
      }), _$p));
      return _el$;
    }
  }), (() => {
    const _el$4 = libs.createElement("Panel", {
        get ["class"]() {
          return libs.classNames("DetailContainer", {
            ShowOrnament: huntlootData() != undefined && huntlootData().data.rarity >= 7
          });
        }
      }, null);
      libs.createElement("Panel", {
        "class": "BGImg"
      }, _el$4);
      const _el$6 = libs.createElement("Panel", {
        "class": "OrnamentPanel"
      }, _el$4);
    libs.insert(_el$4, libs.createComponent(ServerHuntlootDetail, {
      get data() {
        return (() => {
          const d = huntlootData();
          return d ? {
            ...d,
            compareData: huntlootData2()?.data
          } : undefined;
        })();
      }
    }), _el$6);
    libs.effect(_$p => libs.setProp(_el$4, "class", libs.classNames("DetailContainer", {
      ShowOrnament: huntlootData() != undefined && huntlootData().data.rarity >= 7
    }), _$p));
    return _el$4;
  })()];
}
(function () {
  libs.render(() => libs.createComponent(TooltipContents, {}), root);
  root.style.overflow = "noclip";
  root.GetParent().style.overflow = "noclip";
  root.GetParent().GetParent().style.overflow = "noclip";
  root.SetPanelEvent("ontooltiploaded", SetupTooltip);
})();