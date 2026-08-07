--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 16fdfbc · 2026-08-07 21:47:55 UTC
  ~ auto-generated — do not edit
]]


'use strict'; const exports = {}; GameUI.__loadModule('equip_details', exports); const require = GameUI.__require;

var libs = require('./libs.js');
var EOM_Loading = require('./EOM_Loading.js');
var solid_utils = require('./solid_utils.js');
var attribute_formatter = require('./attribute_formatter.js');
var equipment_utils = require('./equipment_utils.js');
var server_equipment = require('./server_equipment.js');
var drawing_attr_row = require('./drawing_attr_row.js');
var Player = require('./Player.js');

function ServerEquipDetail(props) {
  const [local, others] = libs.splitProps(props, ["data", "class"]);
  return (() => {
    const _el$ = libs.createElement("Panel", libs.mergeProps$1(others, {
      get ["class"]() {
        return libs.classNames("ServerEquipDetail", local.class);
      }
    }), null);
    libs.spread(_el$, libs.mergeProps$1(others, {
      get ["class"]() {
        return libs.classNames("ServerEquipDetail", local.class);
      }
    }), true);
    libs.insert(_el$, () => libs.createMemo(() => {
      let data = props.data;
      if (data) {
        return libs.createComponent(ServerEquipDetailLoaded, data);
      }
      return libs.createComponent(EOM_Loading.EOM_Loading, {});
    }));
    return _el$;
  })();
}
function parseEntries(v) {
  if (!v) return [];
  if (typeof v === "string") return JSON.parseSafe(v) ?? [];
  return v;
}
function ServerEquipDetailLoaded(props) {
  const partDatas = solid_utils.createServiceNetData("player_equipment_part_datas", {});
  const equipData = () => {
    return props.data;
  };
  const equippedData = () => {
    let sData = equipData().in_equip_suit;
    return sData.split(";").map(v => v.split(":").map(id => toFiniteNumber(id)));
  };
  const inlayGems = libs.createMemo(() => {
    const raw = equipData().inlay_gems_data;
    if (!raw) return [];
    return JSON.parseSafe(raw) ?? [];
  });
  const equipped = () => equipData().in_equip_suit && equipData().in_equip_suit != "";
  const getEnhancedEntries = (data, type) => {
    const entries = type == "Main" ? data.main_entry_data : data.adverb_entry_data;
    if (!data.in_equip_suit || data.in_equip_suit == "") return entries;
    const level = partDatas()[data.equip_part]?.level ?? 0;
    const levelSetting = KeyValues.equip_level_setting[level];
    const bonus = type == "Main" ? levelSetting?.main_bonus : levelSetting?.adverb_bonus;
    if (!bonus) return entries;
    return entries.map(entry => ({
      ...entry,
      value: equipment_utils.EquipAttributeRound(entry.id, entry.value + entry.base_value * bonus)
    }));
  };
  const displayedMainEntries = libs.createMemo(() => getEnhancedEntries(equipData(), "Main"));
  const displayedAdverbEntries = libs.createMemo(() => getEnhancedEntries(equipData(), "Adverb"));
  const canWear = () => {
    const heroLv = getServiceNetData("player_account_levels", Players.GetLocalPlayer())?.hero_level?.level ?? 1;
    return heroLv >= equipData().need_level;
  };
  const showMythEntry = () => equipData().myth_entry_data && equipData().myth_entry_data.length > 0;
  const showChaosEntry = () => equipData().chaos_entry_data && equipData().chaos_entry_data.length > 0;
  const suitEffectID = () => {
    if (equipData().ability_entry_data != undefined && equipData().ability_entry_data.length > 0) {
      return equipData().ability_entry_data[0].id;
    }
  };
  const compareMainMap = libs.createMemo(() => {
    const compare = props.compareData;
    if (!compare) return {};
    const map = {};
    getEnhancedEntries(compare, "Main").forEach(entry => {
      map[entry.id] = entry.value;
    });
    return map;
  });
  const compareAdverbMap = libs.createMemo(() => {
    const compare = props.compareData;
    if (!compare) return {};
    const map = {};
    getEnhancedEntries(compare, "Adverb").forEach(entry => {
      map[entry.id] = entry.value;
    });
    return map;
  });
  const featureText = libs.createMemo(() => {
    const data = equipData();
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
    if (data.myth_entry_data) data.myth_entry_data.forEach(entry => collectTags(entry.id));
    if (data.chaos_entry_data) data.chaos_entry_data.forEach(entry => collectTags(entry.id));
    if (data.ability_entry_data) data.ability_entry_data.forEach(entry => {
      const suitData = KeyValues.equipment_suit_effect[entry.id];
      if (suitData) {
        collectTags(suitData.lv2);
        collectTags(suitData.lv4);
        collectTags(suitData.lv6);
      }
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
    let nameStr = $.Localize("#" + equipData().equipment_item_id);
    if (equipData().level > 0) {
      nameStr = nameStr.concat(`+${equipData().level}`);
    }
    return nameStr;
  });
  const drawingCraftAccountID = libs.createMemo(() => {
    const creationDetails = equipData().creation_details;
    if (!creationDetails) return;
    const data = typeof creationDetails === "string" ? JSON.parseSafe(creationDetails) : creationDetails;
    const match = data?.origin?.match(/^drawing_craft_(\d+)$/);
    return match?.[1];
  });
  return (() => {
    const _el$2 = libs.createElement("Panel", {
        id: "ServerEquipDetailLoaded",
        get ["class"]() {
          return libs.classNames("TipsRarity" + equipData().rarity, {
            UnableWear: !canWear()
          });
        }
      }, null),
      _el$3 = libs.createElement("Panel", {
        id: "Top"
      }, _el$2),
      _el$4 = libs.createElement("Panel", {
        id: "OrnamentParticleRoot"
      }, _el$3);
      libs.createElement("DOTAParticleScenePanel", {
        id: "OrnamentParticle",
        particleName: "particles/ui/game/ui_game_equip_tooltip_02_fx.vpcf",
        cameraOrigin: "0 0 540",
        fov: 45,
        lookAt: "0 0 0",
        hittest: false,
        squarePixels: true
      }, _el$4);
      const _el$6 = libs.createElement("Panel", {
        id: "EquipmentInfo"
      }, _el$3),
      _el$7 = libs.createElement("Panel", {
        id: "TopLeft"
      }, _el$3),
      _el$8 = libs.createElement("Label", {
        id: "Name",
        get text() {
          return displayName();
        }
      }, _el$7),
      _el$9 = libs.createElement("Panel", {
        id: "Potential"
      }, _el$7),
      _el$0 = libs.createElement("Label", {
        get vars() {
          return {
            value: equipData().remaining_potential
          };
        },
        text: "#Equip_RemainingPotential"
      }, _el$9),
      _el$11 = libs.createElement("Panel", {
        id: "OtherInfo"
      }, _el$7),
      _el$12 = libs.createElement("Label", {
        id: "EquipClass",
        "class": "TopLabel",
        get vars() {
          return {
            value: equipData().class
          };
        },
        text: "#Equip_Class"
      }, _el$11),
      _el$13 = libs.createElement("Label", {
        id: "EquipNeedLevel",
        "class": "TopLabel",
        get vars() {
          return {
            value: canWear() ? equipData().need_level.toString() : ToColor(equipData().need_level.toString(), "#E55043")
          };
        },
        text: "#Equip_NeedLevel",
        html: true
      }, _el$11),
      _el$14 = libs.createElement("Panel", {
        id: "AttrList"
      }, _el$2),
      _el$20 = libs.createElement("Panel", {
        id: "Bottom"
      }, _el$2),
      _el$21 = libs.createElement("Panel", {
        id: "FeatureLabelContainer"
      }, _el$20),
      _el$23 = libs.createElement("Panel", {
        id: "EquipedInfoContainer"
      }, _el$20);
    libs.insert(_el$6, libs.createComponent(server_equipment.Equipment, libs.mergeProps$1(equipData)));
    libs.insert(_el$7, libs.createComponent(libs.Show, {
      get when() {
        return drawingCraftAccountID();
      },
      get children() {
        const _el$1 = libs.createElement("Panel", {
            id: "EquipPreviewCraftBy"
          }, null);
          libs.createElement("Label", {
            text: "#Equipment_Maker"
          }, _el$1);
        libs.insert(_el$1, libs.createComponent(Player.PlayerName, {
          get accountid() {
            return drawingCraftAccountID();
          }
        }), null);
        return _el$1;
      }
    }), _el$11);
    libs.insert(_el$14, libs.createComponent(libs.Show, {
      get when() {
        return displayedMainEntries().length > 0;
      },
      get children() {
        return [libs.createElement("Panel", {
          "class": "Separator"
        }, null), libs.createComponent(libs.Index, {
          get each() {
            return displayedMainEntries();
          },
          children: data => libs.createComponent(EquipmentAttrRow, {
            get data() {
              return data();
            },
            type: "Main",
            get compareMap() {
              return compareMainMap();
            }
          })
        })];
      }
    }), null);
    libs.insert(_el$14, libs.createComponent(libs.Show, {
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
          children: data => libs.createComponent(EquipmentAttrRow, {
            get data() {
              return data();
            },
            type: "Adverb",
            get compareMap() {
              return compareAdverbMap();
            }
          })
        })];
      }
    }), null);
    libs.insert(_el$14, libs.createComponent(libs.Show, {
      get when() {
        return equipData().drawing_entry_data.length > 0;
      },
      get children() {
        return [libs.createElement("Panel", {
          "class": "Separator"
        }, null), libs.createComponent(libs.Index, {
          get each() {
            return equipData().drawing_entry_data;
          },
          children: data => libs.createComponent(drawing_attr_row.DrawingAttrRow, {
            get data() {
              return data();
            }
          })
        })];
      }
    }), null);
    libs.insert(_el$14, libs.createComponent(libs.Show, {
      get when() {
        return showMythEntry() || showChaosEntry();
      },
      get children() {
        return [libs.createElement("Panel", {
          "class": "Separator"
        }, null), libs.createComponent(libs.Show, {
          get when() {
            return showMythEntry();
          },
          get children() {
            return libs.createComponent(libs.Index, {
              get each() {
                return equipData().myth_entry_data;
              },
              children: data => {
                const entryKv = KeyValues.equip_entry[data().id];
                return (() => {
                  const _el$32 = libs.createElement("Panel", {
                      "class": "MythEntry"
                    }, null);
                    libs.createElement("Image", {}, _el$32);
                    const _el$34 = libs.createElement("Label", {
                      get text() {
                        return GetPrivilegeDesc(data().id, 1, {
                          value: data().value,
                          min: entryKv?.value_min,
                          max: entryKv?.value_max
                        });
                      },
                      html: true
                    }, _el$32);
                  libs.effect(_$p => libs.setProp(_el$34, "text", GetPrivilegeDesc(data().id, 1, {
                    value: data().value,
                    min: entryKv?.value_min,
                    max: entryKv?.value_max
                  }), _$p));
                  return _el$32;
                })();
              }
            });
          }
        }), libs.createComponent(libs.Show, {
          get when() {
            return showChaosEntry();
          },
          get children() {
            return libs.createComponent(libs.Index, {
              get each() {
                return equipData().chaos_entry_data;
              },
              children: data => (() => {
                const _el$35 = libs.createElement("Panel", {
                    "class": `ChaosEntry`
                  }, null);
                  libs.createElement("Panel", {
                    id: "Point"
                  }, _el$35);
                  const _el$37 = libs.createElement("Label", {
                    id: "EntryText",
                    get text() {
                      return equipment_utils.GetChaosRowInfo(data());
                    },
                    html: true
                  }, _el$35);
                libs.setProp(_el$35, "class", `ChaosEntry`);
                libs.effect(_$p => libs.setProp(_el$37, "text", equipment_utils.GetChaosRowInfo(data()), _$p));
                return _el$35;
              })()
            });
          }
        })];
      }
    }), null);
    libs.insert(_el$14, libs.createComponent(libs.Show, {
      get when() {
        return inlayGems().length > 0;
      },
      get children() {
        return [libs.createElement("Panel", {
          "class": "Separator"
        }, null), libs.createComponent(libs.For, {
          get each() {
            return inlayGems();
          },
          children: slot => {
            const isEmpty = () => slot?.gem_item_id == undefined;
            const mainEntries = () => parseEntries(slot?.main_entry_data);
            const adverbEntries = () => parseEntries(slot?.adverb_entry_data);
            const mythEntries = () => parseEntries(slot?.myth_entry_data);
            const chaosEntries = () => parseEntries(slot?.chaos_entry_data);
            return (() => {
              const _el$38 = libs.createElement("Panel", {
                  "class": "GemDesc"
                }, null),
                _el$39 = libs.createElement("Panel", {
                  id: "Slot"
                }, _el$38);
              libs.insert(_el$39, libs.createComponent(libs.Show, {
                get when() {
                  return !isEmpty();
                },
                get children() {
                  const _el$40 = libs.createElement("Image", {
                    id: "GemIcon",
                    get src() {
                      return `file://{images}/custom_game/store_items/${slot.gem_item_id}.png`;
                    }
                  }, null);
                  libs.effect(_$p => libs.setProp(_el$40, "src", `file://{images}/custom_game/store_items/${slot.gem_item_id}.png`, _$p));
                  return _el$40;
                }
              }));
              libs.insert(_el$38, libs.createComponent(libs.Show, {
                get when() {
                  return isEmpty();
                },
                get fallback() {
                  return (() => {
                    const _el$42 = libs.createElement("Panel", {
                      "class": "GemEntries"
                    }, null);
                    libs.insert(_el$42, libs.createComponent(libs.For, {
                      get each() {
                        return mainEntries();
                      },
                      children: data => {
                        if (data.id.startsWith("privilege_")) {
                          return (() => {
                            const _el$43 = libs.createElement("Panel", {
                                "class": "PrivilegeEntry"
                              }, null),
                              _el$44 = libs.createElement("Label", {
                                get text() {
                                  return GetPrivilegeDesc(data.id, 1, {
                                    value: data.value
                                  });
                                },
                                html: true
                              }, _el$43);
                            libs.effect(_$p => libs.setProp(_el$44, "text", GetPrivilegeDesc(data.id, 1, {
                              value: data.value
                            }), _$p));
                            return _el$43;
                          })();
                        }
                        return libs.createComponent(EquipmentAttrRow, {
                          data: data,
                          type: "Main"
                        });
                      }
                    }), null);
                    libs.insert(_el$42, libs.createComponent(libs.For, {
                      get each() {
                        return adverbEntries();
                      },
                      children: data => libs.createComponent(EquipmentAttrRow, {
                        data: data,
                        type: "Adverb"
                      })
                    }), null);
                    libs.insert(_el$42, libs.createComponent(libs.For, {
                      get each() {
                        return mythEntries();
                      },
                      children: data => {
                        const entryKv = KeyValues.equip_entry[data.id];
                        return (() => {
                          const _el$45 = libs.createElement("Panel", {
                              "class": "MythEntry"
                            }, null);
                            libs.createElement("Image", {}, _el$45);
                            const _el$47 = libs.createElement("Label", {
                              get text() {
                                return GetPrivilegeDesc(data.id, 1, {
                                  value: data.value,
                                  min: entryKv?.value_min,
                                  max: entryKv?.value_max
                                });
                              },
                              html: true
                            }, _el$45);
                          libs.effect(_$p => libs.setProp(_el$47, "text", GetPrivilegeDesc(data.id, 1, {
                            value: data.value,
                            min: entryKv?.value_min,
                            max: entryKv?.value_max
                          }), _$p));
                          return _el$45;
                        })();
                      }
                    }), null);
                    libs.insert(_el$42, libs.createComponent(libs.For, {
                      get each() {
                        return chaosEntries();
                      },
                      children: data => (() => {
                        const _el$48 = libs.createElement("Panel", {
                            "class": `ChaosEntry`
                          }, null);
                          libs.createElement("Panel", {
                            id: "Point"
                          }, _el$48);
                          const _el$50 = libs.createElement("Label", {
                            id: "EntryText",
                            get text() {
                              return equipment_utils.GetChaosRowInfo(data);
                            },
                            html: true
                          }, _el$48);
                        libs.setProp(_el$48, "class", `ChaosEntry`);
                        libs.effect(_$p => libs.setProp(_el$50, "text", equipment_utils.GetChaosRowInfo(data), _$p));
                        return _el$48;
                      })()
                    }), null);
                    return _el$42;
                  })();
                },
                get children() {
                  return libs.createElement("Label", {
                    id: "EmptyTips",
                    text: "#Equipment_GemEmptyTips"
                  }, null);
                }
              }), null);
              return _el$38;
            })();
          }
        })];
      }
    }), null);
    libs.insert(_el$14, libs.createComponent(libs.Show, {
      get when() {
        return libs.memo(() => !!suitEffectID())() && KeyValues.equipment_suit_effect[suitEffectID()];
      },
      get children() {
        return libs.createComponent(EquipSuitList, {
          get suitEffectID() {
            return suitEffectID();
          },
          get hero_id() {
            return props.hero_id;
          }
        });
      }
    }), null);
    libs.insert(_el$21, libs.createComponent(libs.Show, {
      get when() {
        return libs.memo(() => !!featureText())() && featureText().length > 0;
      },
      get children() {
        return [libs.createElement("Panel", {
          "class": "Separator"
        }, null), libs.createComponent(libs.Index, {
          get each() {
            return featureText();
          },
          children: text => {
            return (() => {
              const _el$51 = libs.createElement("Label", {
                id: "FeatureLabel",
                get text() {
                  return text();
                },
                html: true
              }, null);
              libs.effect(_$p => libs.setProp(_el$51, "text", text(), _$p));
              return _el$51;
            })();
          }
        })];
      }
    }));
    libs.insert(_el$23, libs.createComponent(libs.Show, {
      get when() {
        return equipped();
      },
      get children() {
        return [libs.createElement("Panel", {
          "class": "Separator"
        }, null), libs.createElement("Label", {
          id: "EquipedTips",
          text: "#EquipedTips"
        }, null), (() => {
          const _el$26 = libs.createElement("Panel", {
            id: "EquipedInfo"
          }, null);
          libs.insert(_el$26, libs.createComponent(libs.For, {
            get each() {
              return equippedData();
            },
            children: data => {
              const [heroID, suitID] = data;
              return (() => {
                const _el$52 = libs.createElement("Panel", {
                    "class": "EquipState"
                  }, null),
                  _el$53 = libs.createElement("Image", {
                    "class": "HeroSmallAvatar",
                    get src() {
                      return `s2r://panorama/images/heroes/icons/${equipment_utils.HeroID2Name[heroID]}_png.vtex`;
                    }
                  }, _el$52),
                  _el$54 = libs.createElement("Label", {
                    id: "EquipSuit",
                    text: "#EquipmentSuitType",
                    dialogVariables: {
                      value: suitID
                    }
                  }, _el$52);
                libs.setProp(_el$54, "dialogVariables", {
                  value: suitID
                });
                libs.effect(_$p => libs.setProp(_el$53, "src", `s2r://panorama/images/heroes/icons/${equipment_utils.HeroID2Name[heroID]}_png.vtex`, _$p));
                return _el$52;
              })();
            }
          }));
          return _el$26;
        })()];
      }
    }));
    libs.insert(_el$20, libs.createComponent(libs.Show, {
      get when() {
        return featureText().length > 0;
      },
      get children() {
        const _el$27 = libs.createElement("Panel", {
            id: "ALTTipsContainer",
            width: "100%"
          }, null);
          libs.createElement("Panel", {
            "class": "Separator"
          }, _el$27);
          const _el$29 = libs.createElement("Panel", {
            id: "ModeDetailsTips"
          }, _el$27);
          libs.createElement("Label", {
            id: "Tips",
            text: "#EquipmentTips_Details"
          }, _el$29);
          libs.createElement("Label", {
            id: "Hotkey",
            text: "ALT"
          }, _el$29);
        libs.setProp(_el$27, "width", "100%");
        return _el$27;
      }
    }), null);
    libs.effect(_p$ => {
      const _v$ = libs.classNames("TipsRarity" + equipData().rarity, {
          UnableWear: !canWear()
        }),
        _v$2 = equipData().rarity == 7,
        _v$3 = displayName(),
        _v$4 = {
          value: equipData().remaining_potential
        },
        _v$5 = {
          value: equipData().class
        },
        _v$6 = {
          value: canWear() ? equipData().need_level.toString() : ToColor(equipData().need_level.toString(), "#E55043")
        };
      _v$ !== _p$._v$ && (_p$._v$ = libs.setProp(_el$2, "class", _v$, _p$._v$));
      _v$2 !== _p$._v$2 && (_p$._v$2 = libs.setProp(_el$4, "visible", _v$2, _p$._v$2));
      _v$3 !== _p$._v$3 && (_p$._v$3 = libs.setProp(_el$8, "text", _v$3, _p$._v$3));
      _v$4 !== _p$._v$4 && (_p$._v$4 = libs.setProp(_el$0, "vars", _v$4, _p$._v$4));
      _v$5 !== _p$._v$5 && (_p$._v$5 = libs.setProp(_el$12, "vars", _v$5, _p$._v$5));
      _v$6 !== _p$._v$6 && (_p$._v$6 = libs.setProp(_el$13, "vars", _v$6, _p$._v$6));
      return _p$;
    }, {
      _v$: undefined,
      _v$2: undefined,
      _v$3: undefined,
      _v$4: undefined,
      _v$5: undefined,
      _v$6: undefined
    });
    return _el$2;
  })();
}
function EquipSuitList(props) {
  const suitEffectData = () => KeyValues.equipment_suit_effect[props.suitEffectID];
  const heroid = props.hero_id && props.hero_id != -1 ? props.hero_id : Players.GetSelectedHeroID(Players.GetLocalPlayer());
  const playerHeroEquipSuit = getServiceNetData("player_hero_equip_suits", Players.GetLocalPlayer()) ?? {};
  const playerHeros = getServiceNetData("player_heroes", Players.GetLocalPlayer()) ?? {};
  const suitActivate = libs.createMemo(() => {
    const res = {};
    const hero = playerHeros[heroid];
    const equiped = hero ? playerHeroEquipSuit[heroid]?.[hero.equip_suit] : undefined;
    if (!equiped) return res;
    for (let part in equiped) {
      let equipID = equiped[part];
      if (equipID) {
        const equipData = equipment_utils.GetSimpleDataCache(equipID);
        if (equipData && equipData.ability_entry_data.length > 0) {
          const suitEffectID = equipData.ability_entry_data[0].id;
          if (res[suitEffectID] == undefined) {
            res[suitEffectID] = 0;
          }
          res[suitEffectID] += 1;
        }
      }
    }
    return res;
  });
  const curSuitEffectCount = () => suitActivate()[props.suitEffectID] ?? 0;
  const curMaxEffectStack = () => [2, 4, 6].filter(lv => curSuitEffectCount() >= lv).pop() ?? 2;
  return (() => {
    const _el$55 = libs.createElement("Panel", {
        "class": "EquipSuitList"
      }, null);
      libs.createElement("Panel", {
        "class": "Separator"
      }, _el$55);
      const _el$57 = libs.createElement("Panel", {
        "class": "AbilityEntry"
      }, _el$55),
      _el$58 = libs.createElement("Panel", {
        id: "Title",
        flowChildren: "right"
      }, _el$57),
      _el$59 = libs.createElement("Label", {
        get text() {
          return `${$.Localize("#" + props.suitEffectID)}(${curSuitEffectCount()}/${curMaxEffectStack()})`;
        }
      }, _el$58);
    libs.setProp(_el$58, "flowChildren", "right");
    libs.insert(_el$58, libs.createComponent(server_equipment.SuitIcon, {
      get suitName() {
        return props.suitEffectID;
      }
    }), _el$59);
    libs.insert(_el$57, libs.createComponent(libs.For, {
      get each() {
        return Array.from([2, 4, 6]);
      },
      children: (lv, idx) => {
        let privilegeID = () => suitEffectData()["lv" + lv];
        let active = () => curSuitEffectCount() >= lv;
        return (() => {
          const _el$60 = libs.createElement("Panel", {
              get ["class"]() {
                return libs.classNames("LvEffectItem", {
                  Active: active(),
                  Hide: !active() && props.onlyActivity
                });
              }
            }, null),
            _el$61 = libs.createElement("Label", {
              id: "LvLabel",
              get text() {
                return `[${curSuitEffectCount()}/${lv}]`;
              }
            }, _el$60),
            _el$62 = libs.createElement("Label", {
              id: "EffectLabel",
              get text() {
                return GetPrivilegeDesc(privilegeID(), curMaxEffectStack() / 2);
              },
              html: true
            }, _el$60);
          libs.effect(_p$ => {
            const _v$9 = libs.classNames("LvEffectItem", {
                Active: active(),
                Hide: !active() && props.onlyActivity
              }),
              _v$0 = `[${curSuitEffectCount()}/${lv}]`,
              _v$1 = GetPrivilegeDesc(privilegeID(), curMaxEffectStack() / 2);
            _v$9 !== _p$._v$9 && (_p$._v$9 = libs.setProp(_el$60, "class", _v$9, _p$._v$9));
            _v$0 !== _p$._v$0 && (_p$._v$0 = libs.setProp(_el$61, "text", _v$0, _p$._v$0));
            _v$1 !== _p$._v$1 && (_p$._v$1 = libs.setProp(_el$62, "text", _v$1, _p$._v$1));
            return _p$;
          }, {
            _v$9: undefined,
            _v$0: undefined,
            _v$1: undefined
          });
          return _el$60;
        })();
      }
    }), null);
    libs.effect(_p$ => {
      const _v$7 = {
          Active: curSuitEffectCount() >= 2
        },
        _v$8 = `${$.Localize("#" + props.suitEffectID)}(${curSuitEffectCount()}/${curMaxEffectStack()})`;
      _v$7 !== _p$._v$7 && (_p$._v$7 = libs.setProp(_el$58, "classList", _v$7, _p$._v$7));
      _v$8 !== _p$._v$8 && (_p$._v$8 = libs.setProp(_el$59, "text", _v$8, _p$._v$8));
      return _p$;
    }, {
      _v$7: undefined,
      _v$8: undefined
    });
    return _el$55;
  })();
}
function EquipmentAttrRow(props) {
  const info = libs.createMemo(() => GetAttrRowInfo(props.data, props.attributNameColor, props.showAttributeRange, props.hideZeroBaseValue));
  const isUp = () => {
    if (!props.compareMap) return undefined;
    const compareValue = props.compareMap[props.data.id];
    if (compareValue === undefined) return undefined;
    if (props.data.value === compareValue) return undefined;
    return props.data.value > compareValue;
  };
  return (() => {
    const _el$63 = libs.createElement("Panel", {
        get ["class"]() {
          return `EquipmentAttrRow ${props.type}  ${info()?.color}`;
        }
      }, null);
      libs.createElement("Panel", {
        id: "Point"
      }, _el$63);
      const _el$65 = libs.createElement("Label", {
        id: "AttrValue",
        get text() {
          return info()?.text ?? "";
        },
        html: true
      }, _el$63),
      _el$66 = libs.createElement("Label", {
        id: "AttrName",
        get text() {
          return info()?.attrName ?? "";
        },
        html: true
      }, _el$63);
    libs.insert(_el$63, libs.createComponent(libs.Show, {
      get when() {
        return isUp() !== undefined;
      },
      get children() {
        const _el$67 = libs.createElement("Panel", {
          id: "CompareTag",
          get ["class"]() {
            return libs.classNames({
              Up: isUp()
            });
          }
        }, null);
        libs.effect(_$p => libs.setProp(_el$67, "class", libs.classNames({
          Up: isUp()
        }), _$p));
        return _el$67;
      }
    }), null);
    libs.effect(_p$ => {
      const _v$10 = `EquipmentAttrRow ${props.type}  ${info()?.color}`,
        _v$11 = info()?.text ?? "",
        _v$12 = info()?.attrName ?? "";
      _v$10 !== _p$._v$10 && (_p$._v$10 = libs.setProp(_el$63, "class", _v$10, _p$._v$10));
      _v$11 !== _p$._v$11 && (_p$._v$11 = libs.setProp(_el$65, "text", _v$11, _p$._v$11));
      _v$12 !== _p$._v$12 && (_p$._v$12 = libs.setProp(_el$66, "text", _v$12, _p$._v$12));
      return _p$;
    }, {
      _v$10: undefined,
      _v$11: undefined,
      _v$12: undefined
    });
    return _el$63;
  })();
}
function GetAttrRowInfo(data, attributNameColor = "#BFAA82", showAttributeRange = true, hideZeroBaseValue = false) {
  const id = data.id;
  const kv = KeyValues.equip_entry[id];
  const info = attribute_formatter.formatAttributeDisplay(data, {
    config: {
      ratio: kv?.ratio ?? CustomUIConfig.EntryRatio[id] ?? 1,
      value_min: kv?.value_min,
      value_max: kv?.value_max
    },
    attributeNameColor: attributNameColor,
    showAttributeRange,
    hideZeroBaseValue
  });
  return {
    text: info.valueText,
    attrName: info.nameHtml,
    color: info.colorName
  };
}

exports.EquipSuitList = EquipSuitList;
exports.EquipmentAttrRow = EquipmentAttrRow;
exports.ServerEquipDetail = ServerEquipDetail;