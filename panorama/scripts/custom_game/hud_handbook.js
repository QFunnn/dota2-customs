--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build b9dc48c · 2026-08-02 17:42:46 UTC
  ~ auto-generated — do not edit
]]


'use strict'; const require = GameUI.__require;

var libs = require('./libs.js');
var CityImage = require('./CityImage.js');
var EOM_Panel = require('./EOM_Panel.js');
var EOM_Popup = require('./EOM_Popup.js');
var EOM_Image = require('./EOM_Image.js');
var EOM_Label = require('./EOM_Label.js');
var EOM_Button = require('./EOM_Button.js');
var rookie_sect = require('./rookie_sect.js');
var GenericPanel = require('./GenericPanel.js');
var ShopEffectCard = require('./ShopEffectCard.js');
var HeroCard = require('./HeroCard.js');
var ItemImage = require('./ItemImage.js');
var RuneRewardCard = require('./RuneRewardCard.js');
var SectIcon = require('./SectIcon.js');
require('./EOM_Icon.js');
require('./EOM_Portrait.js');
require('./TalentTree.js');

const HandBook = () => {
  const [show, setShow] = libs.createSignal(false);
  const handBookList = ["Ability", "Item", "Artifact", "Greevil_Shop", "CardEffect", "TeamCard", "RuneReward", "CityEffect", "Neutral", "SectFlow", "Wiki", "FAQ"];
  if (isGroupMode()) ;
  const [filteredList, setFilteredList] = libs.createSignal(handBookList.concat());
  const [selectedTag, setSelectedTag] = libs.createSignal(filteredList()[0]);
  libs.createEffect(libs.on(filteredList, v => {
    if (v.includes(selectedTag())) {
      setSelectedTag(v[0]);
      setSelectedIndex(1);
    }
  }));
  const [selectedIndex, setSelectedIndex] = libs.createSignal(1);
  libs.onMount(() => {
    const eventIDList = [];
    const nettableIDList = [];
    nettableIDList.push(useNetTableKeyHasDefaultValue("common", "constant", data => {
      if (data?.GAMEPLAY_MODULE_LIST) {
        let newList = handBookList.concat();
        newList = newList.filter(v => {
          if (isGroupMode()) {
            if (v == "CardEffect") {
              return false;
            }
          } else {
            if (v == "TeamCard") {
              return false;
            }
            if (v == "CardEffect" && data.GAMEPLAY_MODULE_LIST.card_effect != 1) {
              return false;
            }
          }
          if (v == "RuneReward" && data.GAMEPLAY_MODULE_LIST.rune_task != 1) {
            return false;
          }
          return true;
        });
        setFilteredList(newList);
      }
    }));
    eventIDList.push(useToggleWindow("MenuButton_handbook", show, setShow));
    libs.createEffect(() => {
      if (show()) GameEvents.SendCustomGameEventToServer('report_open_window', {
        window_type: 2
      });
    });
    eventIDList.push(useClientSideEvent("jump_handbook", data => {
      if (data.index && filteredList().includes(data.index)) {
        setSelectedTag(data.index);
      }
    }));
    eventIDList.push(useClientSideEvent("rookie_sect_flow", data => {
      if (data?.state) {
        let index = filteredList().indexOf("SectFlow");
        if (index > -1) {
          setSelectedIndex(index + 1);
          setSelectedTag("SectFlow");
        }
        ToggleWindows("MenuButton_handbook", true);
      } else {
        if (show()) {
          ToggleWindows("MenuButton_handbook", false);
        }
      }
    }));
    libs.onCleanup(() => {
      eventIDList.forEach(id => GameEvents.Unsubscribe(id));
    });
  });
  return libs.createComponent(EOM_Popup.EOM_Popup, {
    id: "HandBook",
    title: "#handbook",
    size: "large",
    get className() {
      return libs.classNames({
        EOM_PopupMainShow: show()
      });
    },
    verticalAlign: "top",
    marginTop: "80px",
    onClose: () => {
      ToggleWindows("MenuButton_handbook", false);
    },
    get children() {
      return [libs.createComponent(rookie_sect.EOM_Breadcrumb, {
        group: "handbook_Breadcrumb",
        get list() {
          return filteredList();
        },
        get selected() {
          return selectedIndex();
        },
        onChange: (index, item) => {
          setSelectedTag(item);
        }
      }), libs.createComponent(libs.Show, {
        get when() {
          return show();
        },
        get children() {
          return libs.createComponent(EOM_Panel.EOM_Panel, {
            width: "100%",
            height: "100%",
            get children() {
              return [libs.createComponent(libs.Show, {
                get when() {
                  return selectedTag() == "Ability";
                },
                get children() {
                  return libs.createComponent(HandBook_Sect, {
                    get show() {
                      return selectedTag() == "Ability";
                    }
                  });
                }
              }), libs.createComponent(libs.Show, {
                get when() {
                  return selectedTag() == "Greevil_Shop";
                },
                get children() {
                  return libs.createComponent(HandBook_Greevil, {
                    get show() {
                      return selectedTag() == "Greevil_Shop";
                    }
                  });
                }
              }), libs.createComponent(libs.Show, {
                get when() {
                  return selectedTag() == "Item";
                },
                get children() {
                  return libs.createComponent(HandBook_Equipment, {
                    get show() {
                      return selectedTag() == "Item";
                    }
                  });
                }
              }), libs.createComponent(libs.Show, {
                get when() {
                  return selectedTag() == "Artifact";
                },
                get children() {
                  return libs.createComponent(HandBook_Artifact, {
                    get show() {
                      return selectedTag() == "Artifact";
                    }
                  });
                }
              }), libs.createComponent(libs.Show, {
                get when() {
                  return selectedTag() == "RuneReward";
                },
                get children() {
                  return libs.createComponent(HandBook_RuneReward, {
                    get show() {
                      return selectedTag() == "RuneReward";
                    }
                  });
                }
              }), libs.createComponent(libs.Show, {
                get when() {
                  return selectedTag() == "CityEffect";
                },
                get children() {
                  return libs.createComponent(HandBook_City, {
                    get show() {
                      return selectedTag() == "CityEffect";
                    }
                  });
                }
              }), libs.createComponent(libs.Show, {
                get when() {
                  return selectedTag() == "CardEffect";
                },
                get children() {
                  return libs.createComponent(HandBook_CardEffect, {
                    get show() {
                      return selectedTag() == "CardEffect";
                    }
                  });
                }
              }), libs.createComponent(libs.Show, {
                get when() {
                  return selectedTag() == "TeamCard";
                },
                get children() {
                  return libs.createComponent(HandBook_TeamCard, {
                    get show() {
                      return selectedTag() == "TeamCard";
                    }
                  });
                }
              }), libs.createComponent(libs.Show, {
                get when() {
                  return selectedTag() == "Neutral";
                },
                get children() {
                  return libs.createComponent(HandBook_Neutral, {
                    get show() {
                      return selectedTag() == "Neutral";
                    }
                  });
                }
              }), libs.createComponent(libs.Show, {
                get when() {
                  return selectedTag() == "SectFlow";
                },
                get children() {
                  return libs.createComponent(HandBook_SectFlow, {
                    get show() {
                      return selectedTag() == "SectFlow";
                    }
                  });
                }
              }), libs.createComponent(libs.Show, {
                get when() {
                  return selectedTag() == "Wiki";
                },
                get children() {
                  return libs.createComponent(HandBook_Wiki, {
                    get show() {
                      return selectedTag() == "Wiki";
                    }
                  });
                }
              }), libs.createComponent(libs.Show, {
                get when() {
                  return selectedTag() == "FAQ";
                },
                get children() {
                  return libs.createComponent(HandBook_FAQ, {
                    get show() {
                      return selectedTag() == "FAQ";
                    }
                  });
                }
              })];
            }
          });
        }
      })];
    }
  });
};
function HandBook_Greevil(props) {
  let ref;
  const [GreevilRarityCost, setGreevilRarityCost] = libs.createSignal({});
  const greevilTypeOrder = ["greevil_gift", "greevil_effect", "card_effect", "equipment", "attribute"];
  const greevilTypeTitle = {
    card_effect: "#Greevil_Record_Rune",
    equipment: "#Item",
    attribute: "#AttributeTitle",
    greevil_effect: "#Greevil_Record_Effect",
    greevil_gift: "#GreevilGift"
  };
  const [selectedType, setSelectedType] = libs.createSignal("all");
  const [GreevilRounds, setGreevilRounds] = libs.createSignal({});
  const groupedItems = libs.createMemo(() => {
    const grouped = {};
    const _RoundRecord = {};
    const kv = KeyValues.GreevilShopKV;
    if (!kv) {
      return [];
    }
    for (const [id, item] of Object.entries(kv)) {
      if (!item || typeof item != "object") continue;
      const type = item.Type;
      if (!type) continue;
      const value = (item.Value ?? "").toString();
      if (value == "") continue;
      const rarity = finiteNumber(Number(item.Rarity), 1);
      let tagType = type;
      if (item.Round == 1) {
        tagType = "greevil_gift";
      } else {
        if (tagType == "trait") {
          tagType = "greevil_effect";
        }
      }
      if (item.AppearRound != undefined) {
        let round = item.AppearRound.toString();
        let rounds = round.split("-").map(v => finiteNumber(Number(v)));
        _RoundRecord[id] = [rounds[0] ?? 0, rounds[1] ?? 0];
      } else {
        _RoundRecord[id] = [0, 0];
      }
      if (grouped[tagType] == undefined) {
        grouped[tagType] = [];
      }
      grouped[tagType].push({
        id: finiteNumber(Number(id), 0),
        type,
        rarity,
        value,
        special: item.Special != undefined ? String(item.Special) : undefined
      });
    }
    setGreevilRounds(_RoundRecord);
    return greevilTypeOrder.filter(type => grouped[type] != undefined && grouped[type].length > 0).map(type => ({
      type,
      title: greevilTypeTitle[type] ?? type,
      list: grouped[type].sort((a, b) => multiCompare(a.rarity - b.rarity, a.id - b.id))
    }));
  });
  const filterList = libs.createMemo(() => {
    const list = groupedItems().map(v => v.type);
    return ["all", ...list];
  });
  const filteredGroups = libs.createMemo(() => {
    if (selectedType() == "all") {
      return groupedItems();
    }
    return groupedItems().filter(v => v.type == selectedType());
  });
  libs.onMount(() => {
    const id = useNetTableKeyHasDefaultValue("common", "greevil_setting", data => {
      setGreevilRarityCost(data?.GREEVIL_SHOP_RARITY_COST ?? {});
    });
    libs.onCleanup(() => {
      CustomNetTables.UnsubscribeNetTableListener(id);
    });
  });
  libs.createEffect(() => {
    const exists = selectedType() == "all" || groupedItems().some(v => v.type == selectedType());
    if (!exists) {
      setSelectedType("all");
    }
  });
  const roundTooltip = name => {
    let round_data = GreevilRounds();
    if (round_data[name.toString()]) {
      let roundList = round_data[name.toString()].map(v => v.toString());
      if (roundList[1] == "0") {
        if (roundList[0] == "0") {
          return $.Localize("#GreevilRound_Always");
        }
        return $.Localize("#CardRoundTooltip1").replace(/\$\{round1\}/g, roundList[0]);
      } else {
        return $.Localize("#CardRoundTooltip2").replace(/\$\{round1\}/g, roundList[0]).replace(/\$\{round2\}/g, roundList[1]);
      }
    }
  };
  return libs.createComponent(EOM_Panel.EOM_Panel, {
    id: "HandBookGreevilContainer",
    get className() {
      return libs.classNames("HandBookContainer", {
        Show: props.show
      });
    },
    get children() {
      return [libs.createComponent(EOM_Panel.EOM_Panel, {
        id: "GreevilTypeFilter",
        get children() {
          return libs.createComponent(libs.For, {
            get each() {
              return filterList();
            },
            children: type => libs.createComponent(EOM_Button.EOM_BaseButton, {
              get className() {
                return libs.classNames("GreevilTypeFilterButton", {
                  Active: selectedType() == type
                });
              },
              onactivate: () => {
                setSelectedType(type);
                if (ref?.IsValid()) {
                  ref.ScrollToTop();
                }
              },
              get children() {
                return libs.createComponent(libs.Show, {
                  when: type == "all",
                  get fallback() {
                    return libs.createComponent(EOM_Panel.EOM_Panel, {
                      get className() {
                        return libs.classNames("GreevilTypeFilterIcon", type);
                      }
                    });
                  },
                  get children() {
                    return libs.createComponent(GenericPanel.CLabel, {
                      className: "GreevilTypeFilterText",
                      text: "#Type_All"
                    });
                  }
                });
              }
            })
          });
        }
      }), libs.createComponent(EOM_Panel.EOM_Panel, {
        width: "100%",
        height: "100%",
        ref(r$) {
          const _ref$ = ref;
          typeof _ref$ === "function" ? _ref$(r$) : ref = r$;
        },
        flowChildren: "down",
        scroll: "y",
        get children() {
          return libs.createComponent(libs.For, {
            get each() {
              return filteredGroups();
            },
            children: group => libs.createComponent(EOM_Panel.EOM_Panel, {
              className: "HandBookSectDiv",
              get children() {
                return [libs.createComponent(EOM_Panel.EOM_Panel, {
                  id: "HandBookCityTitle",
                  get children() {
                    return [libs.createComponent(EOM_Panel.EOM_Panel, {
                      width: "100%",
                      flowChildren: "right",
                      get children() {
                        return [libs.createComponent(EOM_Panel.EOM_Panel, {
                          get children() {
                            return libs.createComponent(EOM_Panel.EOM_Panel, {
                              get className() {
                                return libs.classNames("GreevilTypeFilterIcon", group.type);
                              }
                            });
                          }
                        }), libs.createComponent(EOM_Label.EOM_Label, {
                          marginLeft: "8px",
                          verticalAlign: "center",
                          width: "100%",
                          fontSize: "24px",
                          color: "#f5f5f6",
                          textShadow: "0px 0px 4px 3 #000000;",
                          get text() {
                            return group.title;
                          }
                        })];
                      }
                    }), libs.createComponent(libs.Show, {
                      get when() {
                        return $.Localize(group.title + "_Description") != group.title + "_Description";
                      },
                      get children() {
                        return libs.createComponent(EOM_Label.EOM_Label, {
                          marginLeft: "8px",
                          marginTop: "6px",
                          horizontalAlign: "right",
                          verticalAlign: "bottom",
                          fontSize: "14px",
                          color: "#be1a1a",
                          textShadow: "0px 0px 2px 2 #000000;",
                          get text() {
                            return $.Localize(group.title + "_Description");
                          }
                        });
                      }
                    })];
                  }
                }), libs.createComponent(EOM_Panel.EOM_Panel, {
                  className: "HandBookGreevilCardList",
                  width: "100%",
                  flowChildren: "right-wrap",
                  get children() {
                    return libs.createComponent(libs.For, {
                      get each() {
                        return group.list;
                      },
                      children: item => libs.createComponent(EOM_Panel.EOM_Panel, {
                        className: "HandBookGreevilCardWrap",
                        get children() {
                          return [libs.createComponent(ShopEffectCard.GreevilShopCard, {
                            get Id() {
                              return item.id;
                            },
                            get type() {
                              return item.type;
                            },
                            get rarity() {
                              return item.rarity;
                            },
                            get value() {
                              return item.value;
                            },
                            get special() {
                              return item.special;
                            },
                            get cost() {
                              return (() => GreevilRarityCost()[item.rarity] ?? 0)();
                            },
                            playerGreevilEnergy: 999999
                          }), libs.createComponent(libs.Show, {
                            get when() {
                              return group.type != "greevil_gift";
                            },
                            get children() {
                              return libs.createComponent(EOM_Label.EOM_Label, {
                                "class": "AppearRoundLabel",
                                get text() {
                                  return roundTooltip(item.id);
                                }
                              });
                            }
                          })];
                        }
                      })
                    });
                  }
                })];
              }
            })
          });
        }
      })];
    }
  });
}
function HandBook_Sect(props) {
  const sectList = Object.keys(KeyValues.SectAbilitiesKv);
  const abilityUpgrades = {};
  let selfRef;
  for (const sectName of sectList) {
    abilityUpgrades[sectName] = [];
  }
  for (const abilityUpgradeID in KeyValues.AbilityUpgradesKv) {
    const abilityUpgradeInfo = KeyValues.AbilityUpgradesKv[abilityUpgradeID];
    const sectList = abilityUpgradeInfo.sect.split("|");
    for (const sectName of sectList) {
      abilityUpgrades[sectName].push(abilityUpgradeID);
    }
  }
  const is_tool = CustomNetTables.GetTableValue("common", "settings")?.is_in_tools_mode ?? false;
  const getSectSortWeight = (aid, sect_name) => {
    let weight = 10;
    const kv = KeyValues.AbilityUpgradesKv[aid];
    if (kv) {
      switch (kv.type) {
        case "gain":
          weight = 1;
          break;
        case "inhibit":
          weight = 2;
          break;
        default:
          {
            if (kv.type == sect_name) weight = 3;else weight = 4;
          }
      }
    }
    return weight;
  };
  return libs.createComponent(EOM_Panel.EOM_Panel, {
    id: "HandBookSectContainer",
    get className() {
      return libs.classNames("HandBookContainer", {
        Show: props.show
      });
    },
    get children() {
      return [libs.createComponent(EOM_Panel.EOM_Panel, {
        id: "SectMain",
        scroll: "y",
        ref(r$) {
          const _ref$2 = selfRef;
          typeof _ref$2 === "function" ? _ref$2(r$) : selfRef = r$;
        },
        get children() {
          return sectList.map((sectName, index) => {
            return (() => {
              const _el$ = libs.createElement("Panel", {}, null);
              libs.setProp(_el$, "className", "HandBookSectDiv");
              libs.insert(_el$, libs.createComponent(EOM_Panel.EOM_Panel, {
                id: "HandBookSectTitle",
                get children() {
                  return [libs.createComponent(SectIcon.SectIcon, {
                    width: "48px",
                    height: "48px",
                    sectName: sectName
                  }), libs.createComponent(EOM_Panel.EOM_Panel, {
                    flowChildren: "down",
                    style: {
                      maxWidth: "750px"
                    },
                    marginTop: "4px",
                    marginLeft: "52px",
                    get children() {
                      return [libs.createComponent(EOM_Label.EOM_Label, {
                        color: "white",
                        id: "HeaderUnLockLabel",
                        className: "HeaderLabel",
                        text: "#DOTA_Tooltip_ability_" + sectName
                      }), libs.createComponent(EOM_Label.EOM_Label, {
                        className: "SectDescription",
                        html: true,
                        get text() {
                          return getAbilityDescription(sectName, -1);
                        }
                      })];
                    }
                  }), libs.createComponent(EOM_Panel.EOM_Panel, {
                    id: "LoreContainer",
                    get children() {
                      return libs.createComponent(GenericPanel.CLabel, {
                        html: true,
                        get text() {
                          return replaceBuffEnum($.Localize("#DOTA_Tooltip_ability_" + sectName + "_Lore"));
                        }
                      });
                    }
                  })];
                }
              }), null);
              libs.insert(_el$, libs.createComponent(EOM_Panel.EOM_Panel, {
                className: "HandBookContentPicker",
                flowChildren: "right-wrap",
                width: "100%",
                get children() {
                  return abilityUpgrades[sectName].sort((a, b) => multiCompare(KeyValues.AbilityUpgradesKv[a].cost - KeyValues.AbilityUpgradesKv[b].cost, getSectSortWeight(a, sectName) - getSectSortWeight(b, sectName), Number(a) - Number(b))).map((abilityUpgradeID, index) => {
                    const abilityUpgradeInfo = KeyValues.AbilityUpgradesKv[abilityUpgradeID];
                    if (abilityUpgradeInfo != undefined) {
                      const rarety = abilityUpgradeInfo.rarity || "n";
                      const triggerable = abilityUpgradeInfo.Triggerable == 1;
                      return libs.createComponent(EOM_Button.EOM_BaseButton, {
                        get className() {
                          return libs.classNames("HandBookContentPickerItem", {
                            Triggerable: triggerable && is_tool
                          });
                        },
                        width: "88px",
                        flowChildren: "down",
                        customTooltip: {
                          name: "sect_ability",
                          abilityUpgradeID: abilityUpgradeID
                        },
                        get children() {
                          return [libs.createComponent(EOM_Image.EOM_Image, {
                            className: "DOTAAbilityImage",
                            get backgroundImage() {
                              return `url('file://{images}/spellicons/${abilityUpgradeInfo.Texture}.png')`;
                            }
                          }), libs.createComponent(GenericPanel.CLabel, {
                            get className() {
                              return libs.classNames("HandBookContentPickerItemName", rarety);
                            },
                            get text() {
                              return $.Localize("#DOTA_Tooltip_ability_mechanics_" + abilityUpgradeID);
                            }
                          })];
                        }
                      });
                    }
                  });
                }
              }), null);
              return _el$;
            })();
          });
        }
      }), libs.createComponent(EOM_Panel.EOM_Panel, {
        id: "SectBottom",
        get children() {
          return libs.createComponent(EOM_Panel.EOM_Panel, {
            id: "HeroFilter",
            get children() {
              return [libs.createComponent(GenericPanel.CLabel, {
                className: "TypeLabel",
                text: '#PlayerInfoTitle_Sect'
              }), libs.createComponent(libs.For, {
                each: sectList,
                children: sectName => {
                  return libs.createComponent(EOM_Button.EOM_BaseButton, {
                    get className() {
                      return libs.classNames('SectFilter');
                    },
                    onactivate: self => {
                      const currentLevelChild = selfRef?.GetChild(Math.min(sectList.findIndex(v => {
                        return v == sectName;
                      }), sectList.length - 1));
                      if (currentLevelChild) {
                        currentLevelChild?.ScrollParentToMakePanelFit(3, false);
                      }
                    },
                    get children() {
                      return libs.createComponent(SectIcon.SectIcon, {
                        sectName: sectName,
                        active: true
                      });
                    }
                  });
                }
              })];
            }
          });
        }
      })];
    }
  });
}
function HandBook_Equipment(props) {
  const getItemList = () => {
    let items = [];
    for (const sItemName in KeyValues.ItemsKv) {
      if (sItemName != "Version") {
        const tItemData = KeyValues.ItemsKv[sItemName];
        if (typeof tItemData != "object") continue;
        if (tItemData.ItemRecipe && Number(tItemData.ItemRecipe) == 1) continue;
        if (sItemName.indexOf("item_wearable") != -1) continue;
        if (tItemData.IsHidden == 1) continue;
        if (tItemData.ItemLevel == undefined) continue;
        items.push(sItemName);
      }
    }
    items.sort((a, b) => {
      if ($.Localize("#DOTA_Tooltip_ability_" + a) > $.Localize("#DOTA_Tooltip_ability_" + b)) {
        return 1;
      } else if ($.Localize("#DOTA_Tooltip_ability_" + a) < $.Localize("#DOTA_Tooltip_ability_" + b)) {
        return -1;
      }
      return 0;
    });
    return items;
  };
  const itemsNames = getItemList();
  return libs.createComponent(EOM_Panel.EOM_Panel, {
    id: "HandBookEquipmentContainer",
    get className() {
      return libs.classNames("HandBookContainer", {
        Show: props.show
      });
    },
    scroll: "y",
    paddingBottom: "70px",
    get children() {
      return [...Array(4)].map((_, level) => {
        return libs.createComponent(EOM_Panel.EOM_Panel, {
          className: "HandBookSectDiv",
          get children() {
            return libs.createComponent(EOM_Panel.EOM_Panel, {
              width: "100%",
              flowChildren: "right-wrap",
              className: "HandBookContentPicker",
              get children() {
                return [libs.createComponent(EOM_Label.EOM_Label, {
                  width: "100%",
                  text: "#HandBook_ItemLevelTitle",
                  dialogVariables: {
                    value: level + 1
                  }
                }), libs.memo(() => itemsNames.map((sItemName, index) => {
                  if (KeyValues.ItemsKv[sItemName].ItemLevel == String(level + 1)) {
                    return libs.createComponent(EOM_Button.EOM_BaseButton, {
                      className: "HandBookContentPickerItem",
                      flowChildren: "down",
                      get children() {
                        return [libs.createComponent(ItemImage.ItemImage, {
                          width: "88px",
                          height: "64px",
                          itemName: sItemName,
                          marginBottom: "8px"
                        }), libs.createComponent(GenericPanel.CLabel, {
                          className: "HandBookContentPickerItemName",
                          get text() {
                            return $.Localize("#DOTA_Tooltip_ability_" + sItemName);
                          }
                        })];
                      }
                    });
                  }
                }))];
              }
            });
          }
        });
      });
    }
  });
}
function HandBook_Artifact(props) {
  const getItemData = () => {
    let itemsNames = {};
    let appearRounds = [];
    for (const sItemName in KeyValues.ItemsKv) {
      if (sItemName != "Version") {
        const tItemData = KeyValues.ItemsKv[sItemName];
        if (typeof tItemData != "object") continue;
        if (tItemData.ItemRecipe && Number(tItemData.ItemRecipe) == 1) continue;
        if (sItemName.indexOf("item_wearable") != -1) continue;
        if (tItemData.IsHidden == 1) continue;
        if (isTurboMode()) {
          if (tItemData.TurboAppearRound == undefined || tItemData.TurboAppearRound == "") continue;
        } else {
          if (tItemData.AppearRound == undefined || tItemData.AppearRound == "") continue;
        }
        let rounds = String(isTurboMode() ? tItemData.TurboAppearRound : tItemData.AppearRound).split("|");
        for (const round of rounds) {
          if (appearRounds.indexOf(round) == -1) {
            appearRounds.push(round);
          }
          if (itemsNames[round] == undefined) {
            itemsNames[round] = [];
          }
          itemsNames[round].push(sItemName);
        }
      }
    }
    for (const round in itemsNames) {
      itemsNames[round].sort((a, b) => {
        if ($.Localize("#DOTA_Tooltip_ability_" + a) > $.Localize("#DOTA_Tooltip_ability_" + b)) {
          return 1;
        } else if ($.Localize("#DOTA_Tooltip_ability_" + a) < $.Localize("#DOTA_Tooltip_ability_" + b)) {
          return -1;
        }
        return 0;
      });
    }
    return {
      itemsNames,
      appearRounds
    };
  };
  const {
    itemsNames,
    appearRounds
  } = getItemData();
  return libs.createComponent(EOM_Panel.EOM_Panel, {
    id: "HandBookArtifactContainer",
    get className() {
      return libs.classNames("HandBookContainer", {
        Show: props.show
      });
    },
    scroll: "y",
    get children() {
      return appearRounds.sort((a, b) => {
        return Number(a) - Number(b);
      }).map((round, level) => {
        return libs.createComponent(EOM_Panel.EOM_Panel, {
          className: "HandBookSectDiv",
          get children() {
            return libs.createComponent(EOM_Panel.EOM_Panel, {
              width: "100%",
              flowChildren: "right-wrap",
              className: "HandBookContentPicker",
              get children() {
                return [libs.createComponent(EOM_Label.EOM_Label, {
                  width: "100%",
                  text: "#HandBook_ArtifactTitle",
                  dialogVariables: {
                    value: round
                  }
                }), libs.memo(() => itemsNames[round].map((sItemName, index) => {
                  return libs.createComponent(EOM_Button.EOM_BaseButton, {
                    className: "HandBookContentPickerItem",
                    flowChildren: "down",
                    customTooltip: {
                      name: "equipment",
                      itemname: sItemName,
                      entindex: -1
                    },
                    get children() {
                      return [(() => {
                        const _el$2 = libs.createElement("DOTAItemImage", {
                          itemname: sItemName,
                          showtooltip: false
                        }, null);
                        libs.setProp(_el$2, "className", "ArtifactImage");
                        libs.setProp(_el$2, "itemname", sItemName);
                        return _el$2;
                      })(), libs.createComponent(GenericPanel.CLabel, {
                        className: "HandBookContentPickerItemName",
                        get text() {
                          return $.Localize("#DOTA_Tooltip_ability_" + sItemName);
                        }
                      })];
                    }
                  });
                }))];
              }
            });
          }
        });
      });
    }
  });
}
function HandBook_RuneReward(props) {
  const runeRewardIDList = Object.keys(KeyValues.TraitKv).filter(v => KeyValues.TraitKv[v]?.IsHidden != 1);
  const handledList = (() => {
    const list = {};
    if (runeRewardIDList && runeRewardIDList.length > 0) {
      runeRewardIDList.forEach(name => {
        if (KeyValues.TraitKv[name] && typeof KeyValues.TraitKv[name]?.Round == "number") {
          const round = KeyValues.TraitKv[name].Round;
          if (list[round] == undefined) {
            list[round] = [];
          }
          list[round].push(name);
        }
      });
    }
    return list;
  })();
  return libs.createComponent(EOM_Panel.EOM_Panel, {
    id: "HandBookArtifactContainer",
    get className() {
      return libs.classNames("HandBookContainer", {
        Show: props.show
      });
    },
    scroll: "y",
    get children() {
      return Object.keys(handledList).map((round, _) => {
        const list = handledList[Number(round)];
        return libs.createComponent(EOM_Panel.EOM_Panel, {
          className: "HandBookSectDiv",
          get children() {
            return [libs.createComponent(EOM_Label.EOM_Label, {
              width: "100%",
              text: "#HandBook_ArtifactTitle",
              dialogVariables: {
                value: round
              }
            }), libs.createComponent(EOM_Panel.EOM_Panel, {
              width: "100%",
              flowChildren: "right-wrap",
              className: "HandBookContentPicker",
              get children() {
                return list.sort().map(traitName => {
                  return libs.createComponent(EOM_Button.EOM_BaseButton, {
                    get children() {
                      return libs.createComponent(RuneRewardCard.RuneRewardCard, {
                        trait: traitName
                      });
                    }
                  });
                });
              }
            })];
          }
        });
      });
    }
  });
}
function HandBook_City(props) {
  let landList = {};
  Object.keys(KeyValues.CityEffectKv).forEach(cityName => {
    const v = KeyValues.CityEffectKv[cityName];
    if (v?.IsHidden === 1) return;
    const landType = v?.LandType;
    if (landType) {
      if (landList[landType] == undefined) {
        landList[landType] = [];
      }
      landList[landType].push(cityName);
    }
  });
  return libs.createComponent(EOM_Panel.EOM_Panel, {
    id: "HandBookCityContainer",
    get className() {
      return libs.classNames("HandBookContainer", {
        Show: props.show
      });
    },
    scroll: "y",
    get children() {
      return libs.createComponent(EOM_Panel.EOM_Panel, {
        width: "100%",
        flowChildren: "right-wrap",
        className: "HandBookContentPicker",
        get children() {
          return libs.createComponent(libs.For, {
            get each() {
              return Object.keys(landList).sort();
            },
            children: (landType, _) => {
              return libs.createComponent(EOM_Panel.EOM_Panel, {
                className: "HandBookSectDiv",
                get children() {
                  return [libs.createComponent(EOM_Panel.EOM_Panel, {
                    id: "HandBookCityTitle",
                    get children() {
                      return libs.createComponent(EOM_Label.EOM_Label, {
                        width: "100%",
                        fontSize: "24px",
                        color: "#f5f5f6",
                        textShadow: "0px 0px 4px 3 #000000;",
                        text: `#LandType_${landType}`
                      });
                    }
                  }), libs.createComponent(EOM_Panel.EOM_Panel, {
                    width: "100%",
                    flowChildren: "right-wrap",
                    get children() {
                      return libs.createComponent(libs.Index, {
                        get each() {
                          return landList[landType];
                        },
                        children: (cityName, i) => {
                          return libs.createComponent(EOM_Panel.EOM_Panel, {
                            flowChildren: "down",
                            get children() {
                              return [libs.createComponent(CityImage.CityImage, {
                                horizontalAlign: "center",
                                get city_name() {
                                  return cityName();
                                },
                                get customTooltip() {
                                  return {
                                    name: "city_effect",
                                    abilityName: cityName()
                                  };
                                }
                              }), libs.createComponent(EOM_Label.EOM_Label, {
                                horizontalAlign: "center",
                                height: "18px",
                                width: "80px",
                                style: {
                                  textAlign: "center",
                                  textOverflow: "shrink"
                                },
                                color: "#ffffff",
                                fontSize: "16px",
                                html: true,
                                get text() {
                                  return "#DOTA_Tooltip_ability_" + cityName();
                                }
                              })];
                            }
                          });
                        }
                      });
                    }
                  })];
                }
              });
            }
          });
        }
      });
    }
  });
}
function HandBook_CardEffect(props) {
  let cardList = {};
  const cardRoundRecord = {};
  Object.keys(KeyValues.CardEffectKv).forEach(cardName => {
    const v = KeyValues.CardEffectKv[cardName];
    if (v?.IsHidden === 1) return;
    const cardType = v?.CardType ?? "";
    if (cardType != undefined) {
      if (cardList[cardType] == undefined) {
        cardList[cardType] = [];
      }
      cardList[cardType].push(cardName);
    }
    if (v.AppearRound == undefined) {
      cardRoundRecord[cardName] = [0, 0];
      return;
    }
    let round = v.AppearRound.toString();
    let rounds = round.split("-").map(v => finiteNumber(Number(v)));
    cardRoundRecord[cardName] = [rounds[0] ?? 0, rounds[1] ?? 0];
  });
  $.Localize("#CardRound");
  const roundTooltip = name => {
    if (KeyValues.CardEffectKv[name]) {
      const appearRound = (KeyValues.CardEffectKv[name]?.AppearRound ?? "").toString();
      if (typeof appearRound == "string" && appearRound != "") {
        let roundList = appearRound.split("-");
        if (roundList.length == 1) {
          return $.Localize("#CardRoundTooltip1").replace(/\$\{round1\}/g, roundList[0]);
        } else {
          return $.Localize("#CardRoundTooltip2").replace(/\$\{round1\}/g, roundList[0]).replace(/\$\{round2\}/g, roundList[1]);
        }
      }
    }
    return "";
  };
  const cardEffectTypeList = ["special", "economy", "battle"];
  return libs.createComponent(EOM_Panel.EOM_Panel, {
    id: "HandBookCardEffectContainer",
    get className() {
      return libs.classNames("HandBookContainer", {
        Show: props.show
      });
    },
    scroll: "y",
    get children() {
      return libs.createComponent(EOM_Panel.EOM_Panel, {
        width: "100%",
        flowChildren: "right-wrap",
        className: "HandBookContentPicker",
        get children() {
          return libs.createComponent(libs.For, {
            each: cardEffectTypeList,
            children: (type, _) => {
              let list = cardList[type] ?? [];
              return libs.createComponent(EOM_Panel.EOM_Panel, {
                className: "HandBookSectDiv",
                get visible() {
                  return cardList[type] != undefined;
                },
                get children() {
                  return [libs.createComponent(EOM_Panel.EOM_Panel, {
                    id: "HandBookCityTitle",
                    get children() {
                      return libs.createComponent(EOM_Label.EOM_Label, {
                        width: "100%",
                        fontSize: "24px",
                        color: "#f5f5f6",
                        textShadow: "0px 0px 4px 3 #000000;",
                        text: "#CardEffectType_" + type
                      });
                    }
                  }), libs.createComponent(EOM_Panel.EOM_Panel, {
                    width: "100%",
                    flowChildren: "right-wrap",
                    get children() {
                      return libs.createComponent(libs.Index, {
                        get each() {
                          return list.sort((a, b) => multiCompare(cardRoundRecord[a][0] - cardRoundRecord[b][0], cardRoundRecord[a][1] - cardRoundRecord[b][1], (KeyValues.CardEffectKv[a]?.GoldCost ?? 0) - (KeyValues.CardEffectKv[b]?.GoldCost ?? 0)));
                        },
                        children: (cardName, i) => {
                          return libs.createComponent(EOM_Panel.EOM_Panel, {
                            flowChildren: "down",
                            onmouseover: self => {
                              if (roundTooltip(cardName()) != undefined) {
                                $.DispatchEvent("DOTAShowTextTooltip", self, roundTooltip(cardName()));
                              }
                            },
                            onmouseout: self => {
                              $.DispatchEvent("DOTAHideTextTooltip", self);
                            },
                            get children() {
                              return libs.createComponent(ShopEffectCard.ShopEffectCard, {
                                get name() {
                                  return cardName();
                                },
                                handbook: true,
                                callback: () => {}
                              });
                            }
                          });
                        }
                      });
                    }
                  })];
                }
              });
            }
          });
        }
      });
    }
  });
}
function HandBook_TeamCard(props) {
  let cardList = [];
  const cardRoundRecord = {};
  Object.keys(KeyValues.TeamCardKv).forEach(cardName => {
    const v = KeyValues.TeamCardKv[cardName];
    if (v?.IsHidden === 1) return;
    cardList.push(cardName);
    if (v.AppearRound == undefined) {
      cardRoundRecord[cardName] = [0, 0];
      return;
    }
    let round = v.AppearRound.toString();
    let rounds = round.split("-").map(v => finiteNumber(Number(v)));
    cardRoundRecord[cardName] = [rounds[0] ?? 0, rounds[1] ?? 0];
  });
  $.Localize("#CardRound");
  const roundTooltip = name => {
    if (KeyValues.TeamCardKv[name]) {
      const appearRound = (KeyValues.TeamCardKv[name]?.AppearRound ?? "").toString();
      if (typeof appearRound == "string" && appearRound != "") {
        let roundList = appearRound.split("-");
        if (roundList.length == 1) {
          return $.Localize("#CardRoundTooltip1").replace(/\$\{round1\}/g, roundList[0]);
        } else {
          return $.Localize("#CardRoundTooltip2").replace(/\$\{round1\}/g, roundList[0]).replace(/\$\{round2\}/g, roundList[1]);
        }
      }
    }
    return "";
  };
  return libs.createComponent(EOM_Panel.EOM_Panel, {
    id: "HandBookTeamCardContainer",
    get className() {
      return libs.classNames("HandBookContainer", {
        Show: props.show
      });
    },
    scroll: "y",
    get children() {
      return libs.createComponent(EOM_Panel.EOM_Panel, {
        width: "100%",
        flowChildren: "right-wrap",
        className: "HandBookTeamCardList",
        get children() {
          return libs.createComponent(libs.Index, {
            get each() {
              return cardList.sort((a, b) => multiCompare(cardRoundRecord[a][0] - cardRoundRecord[b][0], cardRoundRecord[a][1] - cardRoundRecord[b][1], (KeyValues.TeamCardKv[a]?.GoldCost ?? 0) - (KeyValues.TeamCardKv[b]?.GoldCost ?? 0)));
            },
            children: (cardName, i) => {
              return libs.createComponent(EOM_Panel.EOM_Panel, {
                flowChildren: "down",
                onmouseover: self => {
                  if (roundTooltip(cardName()) != undefined) {
                    $.DispatchEvent("DOTAShowTextTooltip", self, roundTooltip(cardName()));
                  }
                },
                onmouseout: self => {
                  $.DispatchEvent("DOTAHideTextTooltip", self);
                },
                get children() {
                  return libs.createComponent(ShopEffectCard.ShopEffectCard, {
                    get name() {
                      return cardName();
                    },
                    team_card: true,
                    handbook: true,
                    callback: () => {}
                  });
                }
              });
            }
          });
        }
      });
    }
  });
}
function HandBook_Neutral(props) {
  const [neutral_level, setNeutralLevel] = libs.createSignal(CustomNetTables.GetTableValue("common", "constant")?.NEUTRAL_LEVEL);
  const neutralNames = libs.createMemo(() => {
    const current_neutral_level = neutral_level();
    const neutral_names = {};
    if (current_neutral_level) {
      const current_neutral_level_v = Object.values(current_neutral_level);
      const current_neutral_level_k = Object.keys(current_neutral_level);
      Object.keys(KeyValues.UnitsNeutralKv).forEach((name, _) => {
        const data = KeyValues.UnitsNeutralKv[name];
        const index = current_neutral_level_v.indexOf(Number(data.Level));
        if (data && index > -1) {
          const round = Number(current_neutral_level_k[index]);
          if (neutral_names[round] == undefined) {
            neutral_names[round] = [];
          }
          neutral_names[round].push(name);
        }
      });
    }
    return neutral_names;
  });
  const RoundList = () => Object.keys(neutralNames());
  libs.onMount(() => {
    const NetTableListenerIDs = [];
    useNetTableKey("common", "constant", data => {
      setNeutralLevel(data?.NEUTRAL_LEVEL);
    });
    libs.onCleanup(() => {
      NetTableListenerIDs.forEach(id => CustomNetTables.UnsubscribeNetTableListener(id));
    });
  });
  return libs.createComponent(EOM_Panel.EOM_Panel, {
    id: "HandBookNeutralContainer",
    get className() {
      return libs.classNames("HandBookContainer", {
        Show: props.show
      });
    },
    scroll: "y",
    get children() {
      return libs.createComponent(libs.Show, {
        get when() {
          return props.show;
        },
        get children() {
          return [libs.createComponent(libs.Index, {
            get each() {
              return RoundList();
            },
            children: (round, index) => {
              const neutralList = () => neutralNames()[Number(round())].sort();
              return libs.createComponent(EOM_Panel.EOM_Panel, {
                className: "HandBookSectDiv",
                get children() {
                  return [libs.createComponent(EOM_Label.EOM_Label, {
                    width: "100%",
                    text: "#HandBook_ArtifactTitle",
                    get dialogVariables() {
                      return {
                        value: round()
                      };
                    }
                  }), libs.createComponent(EOM_Panel.EOM_Panel, {
                    width: "100%",
                    flowChildren: "right-wrap",
                    get children() {
                      return libs.createComponent(libs.Index, {
                        get each() {
                          return neutralList();
                        },
                        children: (neutral_name, i) => {
                          return (libs.createComponent(HeroCard.HeroCard, {
                              get heroName() {
                                return neutral_name();
                              },
                              showTalent: false
                            })
                          );
                        }
                      });
                    }
                  })];
                }
              });
            }
          }), libs.createComponent(EOM_Panel.EOM_Panel, {
            className: "HandBookSectDiv",
            get children() {
              return [libs.createComponent(EOM_Label.EOM_Label, {
                width: "100%",
                text: "#HandBook_ArtifactTitle",
                dialogVariables: {
                  value: "20"
                }
              }), libs.createComponent(EOM_Panel.EOM_Panel, {
                width: "100%",
                flowChildren: "right-wrap",
                get children() {
                  return libs.createComponent(HeroCard.HeroCard, {
                    heroName: "neu_roshan",
                    showTalent: false
                  });
                }
              })];
            }
          })];
        }
      });
    }
  });
}
function HandBook_SectFlow(props) {
  return libs.createComponent(EOM_Panel.EOM_Panel, {
    id: "HandBookSectFlowContainer",
    get className() {
      return libs.classNames("HandBookContainer", {
        Show: props.show
      });
    },
    scroll: "y",
    get children() {
      return libs.createComponent(libs.Show, {
        get when() {
          return props.show;
        },
        get children() {
          return libs.createComponent(rookie_sect.RookieSect, {});
        }
      });
    }
  });
}
function HandBook_FAQ(props) {
  const GetQAACount = () => {
    let iCount = 1;
    for (let i = 1; i < 1000; i++) {
      let key = "#QAndA_Question_" + i;
      let sLoc = $.Localize(key);
      if (key == sLoc) {
        break;
      }
      key = "#QAndA_Answer_" + i;
      sLoc = $.Localize(key);
      if (key == sLoc) {
        break;
      }
      iCount = i;
    }
    return iCount;
  };
  return libs.createComponent(EOM_Panel.EOM_Panel, {
    id: "HandBookFAQContainer",
    get className() {
      return libs.classNames("HandBookContainer", {
        Show: props.show
      });
    },
    scroll: "y",
    get children() {
      return [...Array(GetQAACount())].map((_, index) => {
        return (() => {
          const _el$4 = libs.createElement("Panel", {}, null),
            _el$5 = libs.createElement("Panel", {}, _el$4),
            _el$6 = libs.createElement("Panel", {}, _el$4);
          libs.setProp(_el$4, "className", "HandBookFAQ");
          libs.setProp(_el$5, "className", "FAQTitle");
          libs.insert(_el$5, libs.createComponent(GenericPanel.CLabel, {
            get text() {
              return $.Localize("#QAndA_Question_" + (index + 1));
            },
            html: true
          }));
          libs.setProp(_el$6, "className", "FAQContent");
          libs.insert(_el$6, libs.createComponent(EOM_Image.EOM_Image, {
            className: "FAQImage",
            get backgroundImage() {
              return getImagePath(`newbie/x_picture_${index + 1}.png`);
            }
          }), null);
          libs.insert(_el$6, libs.createComponent(GenericPanel.CLabel, {
            className: "FAQAnswer",
            get text() {
              return replaceEnum($.Localize("#QAndA_Answer_" + (index + 1)));
            },
            html: true
          }), null);
          return _el$4;
        })();
      });
    }
  });
}
function HandBook_Wiki(props) {
  const getWikiData = () => {
    let navList = {};
    for (const subNav in KeyValues.WikiKv) {
      let data = KeyValues.WikiKv[subNav];
      let nav = data.nav;
      if (navList[nav] == undefined) {
        navList[nav] = [];
      }
      navList[nav].push(subNav);
    }
    return navList;
  };
  const navList = getWikiData();
  const wikiList = Object.keys(navList);
  const [select, setSelect] = libs.createSignal(0);
  const [content, setContent] = libs.createSignal("#HandBook_Sub_Nav_HeroLevel_Content");
  const [contentInfo, setContentInfo] = libs.createSignal(wikiList.map((tabName, index) => {
    return navList[tabName]?.[0] ?? "";
  }));
  libs.createEffect(() => {
    setContent("#HandBook_Sub_Nav_" + contentInfo()[select()] + "_Content");
  });
  const handledContent = () => {
    let text = content();
    if (text == "#HandBook_Sub_Nav_OtherBuff_Content") {
      let keywordList = getKeyWordList($.Localize(text));
      text = "";
      keywordList.forEach((info, i) => {
        if (i > 0) {
          text += "<br><br>";
        }
        let title = "";
        let content = "";
        if (info.type == "KeyWord") {
          title = $.Localize("#" + info.type + "_" + info.value);
          content = $.Localize("#" + info.type + "_" + info.value + "_Description");
        } else {
          title = $.Localize("#" + info.value);
          content = $.Localize("#" + info.value + "_Description");
        }
        title = removeHtmlTags(title);
        content = GeneratePeriod(content);
        text += `【${title}】<br>${content}`;
      });
      return replaceAll($.Localize(text));
    }
    return replaceEnum($.Localize(text));
  };
  return libs.createComponent(EOM_Panel.EOM_Panel, {
    id: "HandBookWikiContainer",
    get className() {
      return libs.classNames("HandBookContainer", {
        Show: props.show
      });
    },
    flowChildren: "right",
    get children() {
      return [libs.createComponent(EOM_Panel.EOM_Panel, {
        id: "WikiTreeMenu",
        className: "HandBookInnerBorder",
        width: "20%",
        height: "100%",
        flowChildren: "down",
        get children() {
          return wikiList.map((tabName, index) => {
            return libs.createComponent(GenericPanel.TabButton, {
              className: "NavTab",
              id: tabName,
              group: "NewbieNavTab",
              text: "#HandBook_Nav_" + tabName,
              selected: index == 0,
              onactivate: self => setSelect(index),
              get children() {
                return navList[tabName].map((subTabName, subindex) => {
                  return libs.createComponent(GenericPanel.TabButton, {
                    className: "NavSubTab",
                    id: subTabName,
                    group: tabName,
                    text: "#HandBook_Sub_Nav_" + subTabName,
                    selected: subindex == 0,
                    onactivate: self => {
                      setContent("#HandBook_Sub_Nav_" + subTabName + "_Content");
                      setContentInfo(info => {
                        info[index] = subTabName;
                        return info;
                      });
                    }
                  });
                });
              }
            });
          });
        }
      }), libs.createComponent(EOM_Panel.EOM_Panel, {
        id: "WikiContent",
        className: "HandBookInnerBorder",
        marginLeft: "10px",
        width: "fill-parent-flow(1)",
        height: "100%",
        flowChildren: "down",
        scroll: "y",
        get children() {
          return libs.createComponent(EOM_Label.EOM_Label, {
            className: "WikiContent",
            html: true,
            get text() {
              return handledContent();
            }
          });
        }
      })];
    }
  });
}
libs.render(() => libs.createComponent(HandBook, {}), $.GetContextPanel());