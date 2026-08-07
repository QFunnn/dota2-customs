--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 16fdfbc · 2026-08-07 21:47:55 UTC
  ~ auto-generated — do not edit
]]


'use strict'; const require = GameUI.__require;

var libs = require('./libs.js');
var EOM_Loading = require('./EOM_Loading.js');
var equipment_utils = require('./equipment_utils.js');
var rune_components = require('./rune_components.js');
var rune_data = require('./rune_data.js');
require('./solid_utils.js');
require('./Player.js');
require('./service_netdata_helper.js');
require('./EOM_Button.js');
require('./EOM_TextEntry.js');
require('./attribute_formatter.js');

function ServerRuneDetail(props) {
  const [local, others] = libs.splitProps(props, ["data", "class"]);
  return (() => {
    const _el$ = libs.createElement("Panel", libs.mergeProps$1(others, {
      get ["class"]() {
        return libs.classNames("ServerRuneDetail", local.class);
      }
    }), null);
    libs.spread(_el$, libs.mergeProps$1(others, {
      get ["class"]() {
        return libs.classNames("ServerRuneDetail", local.class);
      }
    }), true);
    libs.insert(_el$, libs.createComponent(libs.Show, {
      get when() {
        return local.data;
      },
      get fallback() {
        return libs.createComponent(EOM_Loading.EOM_Loading, {});
      },
      children: () => libs.createComponent(ServerEquipDetailLoaded, libs.mergeProps$1(() => local.data))
    }));
    return _el$;
  })();
}
function ServerEquipDetailLoaded(props) {
  const runeData = () => {
    return props.data;
  };
  libs.createMemo(() => {
    return KeyValues.info_item_rune[runeData().rune_item_id];
  });
  const runeRaritySetting = libs.createMemo(() => {
    return KeyValues.rune_rarity_setting[runeData().rarity];
  });
  const equippedData = () => {
    let sData = runeData().in_rune_equip_suit;
    return sData.split(";").map(v => v.split(":").map(id => toFiniteNumber(id)));
  };
  const equipped = () => runeData().in_rune_equip_suit && runeData().in_rune_equip_suit != "";
  const canWear = () => {
    const heroLv = getServiceNetData("player_account_levels", Players.GetLocalPlayer())?.hero_level?.level ?? 1;
    return heroLv >= runeRaritySetting().need_level;
  };
  const featureText = libs.createMemo(() => {
    const data = runeData();
    const tags = new Set();
    const lines = [];
    const collectTags = id => {
      const propText = $.Localize("#property_" + id, $.GetContextPanel());
      GetTagsFromString(propText).forEach(tag => tags.add(tag));
      const privText = $.Localize("#DOTA_Tooltip_ability_" + id, $.GetContextPanel());
      GetTagsFromString(privText).forEach(tag => tags.add(tag));
      const propDesc = GetLocalization("#property_" + id + "_description", "");
      if (propDesc) {
        const propName = Localize("#property_" + id).replace("%", "");
        lines.push(`${propName}:${propDesc}`);
      }
    };
    data.main_entry_data.forEach(entry => collectTags(entry.id));
    data.adverb_entry_data.forEach(entry => collectTags(entry.id));
    data.rune_suit_data.forEach(suit => {
      const suitText = $.Localize("#RuneSuit_" + suit.id, $.GetContextPanel());
      GetTagsFromString(suitText).forEach(tag => tags.add(tag));
    });
    tags.forEach(tag => {
      const tagDesc = $.Localize("#feature_" + tag + "_description", $.GetContextPanel());
      GetTagsFromString(tagDesc).forEach(nestedTag => tags.add(nestedTag));
    });
    const featureLines = Array.from(tags).map(tag => {
      const name = Localize("#feature_" + tag);
      const desc = GetLocalization("#feature_" + tag + "_description");
      return `${name}:${desc}`;
    });
    const allLines = [...featureLines, ...lines];
    return allLines;
  });
  const displayName = libs.createMemo(() => {
    const nameStr = $.Localize("#" + runeData().rune_item_id);
    return nameStr;
  });
  return (() => {
    const _el$2 = libs.createElement("Panel", {
        id: "ServerRuneDetailLoaded",
        get ["class"]() {
          return libs.classNames("TipsRarity" + runeData().rarity, {
            UnableWear: !canWear()
          });
        }
      }, null),
      _el$3 = libs.createElement("Panel", {
        id: "RuneTop"
      }, _el$2),
      _el$4 = libs.createElement("Panel", {
        id: "RuneTopLeft"
      }, _el$3),
      _el$5 = libs.createElement("Label", {
        id: "RuneName",
        get text() {
          return displayName();
        }
      }, _el$4),
      _el$6 = libs.createElement("Panel", {
        id: "RuneOtherInfo"
      }, _el$4),
      _el$7 = libs.createElement("Label", {
        id: "EquipNeedLevel",
        "class": "TopLabel",
        get vars() {
          return {
            value: canWear() ? runeRaritySetting().need_level.toString() : ToColor(runeRaritySetting().need_level.toString(), "#E55043")
          };
        },
        text: "#RuneEquipNeedLevel",
        html: true
      }, _el$6),
      _el$8 = libs.createElement("Panel", {
        id: "RuneAttrList"
      }, _el$2),
      _el$11 = libs.createElement("Panel", {
        id: "RuneBottom"
      }, _el$2),
      _el$12 = libs.createElement("Panel", {
        id: "RuneFeatureLabelContainer",
        width: "100%",
        flowChildren: "down"
      }, _el$11),
      _el$14 = libs.createElement("Panel", {
        id: "EquipedInfoContainer",
        width: "100%",
        flowChildren: "down"
      }, _el$11);
    libs.insert(_el$8, libs.createComponent(libs.Show, {
      get when() {
        return runeData().main_entry_data.length > 0;
      },
      get children() {
        return [libs.createElement("Panel", {
          "class": "RuneSeparator"
        }, null), libs.createComponent(libs.Index, {
          get each() {
            return rune_data.buildRuneAttributeDisplays(runeData().main_entry_data, 1);
          },
          children: data => libs.createComponent(rune_components.RuneAttributeRow, {
            get attr_name_html() {
              return data().nameHtml;
            },
            get attr_value_html() {
              return data().valueText;
            },
            entry_type: "Main",
            get color_name() {
              return data().colorName;
            }
          })
        })];
      }
    }), null);
    libs.insert(_el$8, libs.createComponent(libs.Show, {
      get when() {
        return runeData().adverb_entry_data.length > 0;
      },
      get children() {
        return [libs.createElement("Panel", {
          "class": "RuneSeparator"
        }, null), libs.createComponent(libs.Index, {
          get each() {
            return rune_data.buildRuneAttributeDisplays(runeData().adverb_entry_data, 2);
          },
          children: data => libs.createComponent(rune_components.RuneAttributeRow, {
            get attr_name_html() {
              return data().nameHtml;
            },
            get attr_value_html() {
              return data().valueText;
            },
            entry_type: "Adverb",
            get color_name() {
              return data().colorName;
            }
          })
        })];
      }
    }), null);
    libs.insert(_el$8, libs.createComponent(libs.Show, {
      get when() {
        return runeData().rune_suit_data.length > 0;
      },
      get children() {
        return [libs.createElement("Panel", {
          "class": "RuneSeparator"
        }, null), (() => {
          const _el$10 = libs.createElement("Panel", {
            id: "RuneSuitContainer",
            width: "100%",
            flowChildren: "right"
          }, null);
          libs.setProp(_el$10, "width", "100%");
          libs.setProp(_el$10, "flowChildren", "right");
          libs.insert(_el$10, libs.createComponent(libs.Index, {
            get each() {
              return rune_data.buildRuneSuitDisplays(runeData().rune_suit_data);
            },
            children: data => libs.createComponent(rune_components.RuneBondItem, {
              get suitKey() {
                return data().suitKey;
              },
              get currentPoint() {
                return data().currentPoint;
              },
              get suitPoint() {
                return data().currentPoint;
              },
              showTooltip: true
            })
          }));
          return _el$10;
        })()];
      }
    }), null);
    libs.setProp(_el$12, "width", "100%");
    libs.setProp(_el$12, "flowChildren", "down");
    libs.insert(_el$12, libs.createComponent(libs.Show, {
      get when() {
        return libs.memo(() => !!featureText())() && featureText().length > 0;
      },
      get children() {
        return [libs.createElement("Panel", {
          "class": "RuneSeparator"
        }, null), libs.createComponent(libs.Index, {
          get each() {
            return featureText();
          },
          children: text => {
            return (() => {
              const _el$23 = libs.createElement("Label", {
                id: "RuneFeatureLabel",
                get text() {
                  return text();
                },
                html: true
              }, null);
              libs.effect(_$p => libs.setProp(_el$23, "text", text(), _$p));
              return _el$23;
            })();
          }
        })];
      }
    }));
    libs.setProp(_el$14, "width", "100%");
    libs.setProp(_el$14, "flowChildren", "down");
    libs.insert(_el$14, libs.createComponent(libs.Show, {
      get when() {
        return equipped();
      },
      get children() {
        return [libs.createElement("Panel", {
          "class": "RuneSeparator"
        }, null), libs.createElement("Label", {
          id: "RuneEquipedTips",
          text: "#EquipedTips"
        }, null), (() => {
          const _el$17 = libs.createElement("Panel", {
            id: "RuneEquipedInfo"
          }, null);
          libs.insert(_el$17, libs.createComponent(libs.For, {
            get each() {
              return equippedData();
            },
            children: data => {
              const [heroID, suitID] = data;
              return (() => {
                const _el$24 = libs.createElement("Panel", {
                    "class": "RuneEquipState"
                  }, null),
                  _el$25 = libs.createElement("Image", {
                    "class": "HeroSmallAvatar",
                    get src() {
                      return `s2r://panorama/images/heroes/icons/${equipment_utils.HeroID2Name[heroID]}_png.vtex`;
                    }
                  }, _el$24),
                  _el$26 = libs.createElement("Label", {
                    id: "RuneEquipSuit",
                    text: "#EquipmentSuitType",
                    dialogVariables: {
                      value: suitID
                    }
                  }, _el$24);
                libs.setProp(_el$26, "dialogVariables", {
                  value: suitID
                });
                libs.effect(_$p => libs.setProp(_el$25, "src", `s2r://panorama/images/heroes/icons/${equipment_utils.HeroID2Name[heroID]}_png.vtex`, _$p));
                return _el$24;
              })();
            }
          }));
          return _el$17;
        })()];
      }
    }));
    libs.insert(_el$11, libs.createComponent(libs.Show, {
      get when() {
        return libs.memo(() => !!featureText())() && featureText().length > 0;
      },
      get children() {
        const _el$18 = libs.createElement("Panel", {
            id: "RuneALTTipsContainer",
            width: "100%"
          }, null);
          libs.createElement("Panel", {
            "class": "RuneSeparator"
          }, _el$18);
          const _el$20 = libs.createElement("Panel", {
            id: "RuneModeDetailsTips"
          }, _el$18);
          libs.createElement("Label", {
            id: "RuneTips",
            text: "#EquipmentTips_Details"
          }, _el$20);
          libs.createElement("Label", {
            id: "RuneHotkey",
            text: "ALT"
          }, _el$20);
        libs.setProp(_el$18, "width", "100%");
        return _el$18;
      }
    }), null);
    libs.effect(_p$ => {
      const _v$ = libs.classNames("TipsRarity" + runeData().rarity, {
          UnableWear: !canWear()
        }),
        _v$2 = displayName(),
        _v$3 = {
          value: canWear() ? runeRaritySetting().need_level.toString() : ToColor(runeRaritySetting().need_level.toString(), "#E55043")
        };
      _v$ !== _p$._v$ && (_p$._v$ = libs.setProp(_el$2, "class", _v$, _p$._v$));
      _v$2 !== _p$._v$2 && (_p$._v$2 = libs.setProp(_el$5, "text", _v$2, _p$._v$2));
      _v$3 !== _p$._v$3 && (_p$._v$3 = libs.setProp(_el$7, "vars", _v$3, _p$._v$3));
      return _p$;
    }, {
      _v$: undefined,
      _v$2: undefined,
      _v$3: undefined
    });
    return _el$2;
  })();
}
let root = $.GetContextPanel();
const [equipData, setEquipData] = libs.createSignal();
function TooltipContents() {
  return (() => {
    const _el$27 = libs.createElement("Panel", {
        get ["class"]() {
          return libs.classNames("RuneDetailContainer", {
            ShowOrnament: equipData() != undefined && equipData().data.rarity >= 7
          });
        }
      }, null);
      libs.createElement("Panel", {
        "class": "RuneBGImg"
      }, _el$27);
      const _el$29 = libs.createElement("Panel", {
        "class": "RuneOrnamentPanel"
      }, _el$27);
    libs.insert(_el$27, libs.createComponent(ServerRuneDetail, {
      get data() {
        return equipData();
      }
    }), _el$29);
    libs.effect(_$p => libs.setProp(_el$27, "class", libs.classNames("RuneDetailContainer", {
      ShowOrnament: equipData() != undefined && equipData().data.rarity >= 7
    }), _$p));
    return _el$27;
  })();
}
function SetupTooltip() {
  (async () => {
    setEquipData();
    let id1 = root.GetAttributeString("id1", "");
    equipment_utils.GetRuneDetail(id1, data => {
      setEquipData({
        data: data
      });
    });
  })();
}
(function () {
  libs.render(() => libs.createComponent(TooltipContents, {}), root);
  root.style.overflow = "noclip";
  root.GetParent().style.overflow = "noclip";
  root.GetParent().GetParent().style.overflow = "noclip";
  root.SetPanelEvent("ontooltiploaded", SetupTooltip);
})();