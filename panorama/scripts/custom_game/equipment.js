--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build b9dc48c · 2026-08-02 17:42:46 UTC
  ~ auto-generated — do not edit
]]


'use strict'; const require = GameUI.__require;

var libs = require('./libs.js');
var AbilityDescription = require('./AbilityDescription.js');
var EOM_Panel = require('./EOM_Panel.js');
var EOM_Tooltip = require('./EOM_Tooltip.js');
var EOM_Label = require('./EOM_Label.js');
var GenericPanel = require('./GenericPanel.js');
var ItemImage = require('./ItemImage.js');
var Player = require('./Player.js');
var SectIcon = require('./SectIcon.js');
require('./EOM_Image.js');
require('./EOM_Button.js');
require('./EOM_Icon.js');

let pTooltipPanel = $.GetContextPanel();
pTooltipPanel.style.minHeight = "0px";
pTooltipPanel.FindAncestor("equipment").FindChildTraverse("LeftArrow").style.opacity = "0";
pTooltipPanel.FindAncestor("equipment").FindChildTraverse("RightArrow").style.opacity = "0";
pTooltipPanel.FindAncestor("equipment").FindChildTraverse("TopArrow").style.opacity = "0";
pTooltipPanel.FindAncestor("equipment").FindChildTraverse("BottomArrow").style.opacity = "0";
function TooltipContents({
  itemname,
  entindex,
  playerID,
  showOverrideWarning
}) {
  let localPlayerID = playerID == -1 ? Players.GetLocalPlayer() : playerID;
  const itemKV = GameUI.CustomUIConfig().ItemsKv[itemname];
  let sAttributes = getItemArrtibute(itemname);
  let text = getItemDescription(itemname);
  const lore = replaceBuffEnum($.Localize("#DOTA_Tooltip_ability_" + itemname + "_Lore"));
  const sectList = itemKV.Sect?.split("|") ?? [];
  itemKV.Repeat;
  let bHasDescription = $.Localize("#DOTA_Tooltip_ability_" + itemname + "_description") != "#DOTA_Tooltip_ability_" + itemname + "_description";
  const [abilityUpgradeList, setAbilityUpgradeList] = libs.createSignal([]);
  const [extraData, setExtraData] = libs.createSignal({});
  const [extraStrData, setExtraStrData] = libs.createSignal({});
  libs.onMount(() => {
    if (entindex != -1) {
      const eventIDList = [];
      eventIDList.push(useNetData("artifact_abilities", data => {
        setAbilityUpgradeList(data[entindex] ?? []);
      }, localPlayerID));
      eventIDList.push(useNetData("artifact_extra_data", data => {
        setExtraData(data[entindex] ?? {});
      }, localPlayerID));
      eventIDList.push(useNetData("artifact_extra_string_data", data => {
        setExtraStrData(data[entindex] ?? {});
      }, localPlayerID));
      libs.onCleanup(() => {
        eventIDList.forEach(id => {
          GameEvents.Unsubscribe(id);
        });
      });
    }
  });
  const limitCount = 10;
  const limitAbilitiesList = libs.createMemo(() => abilityUpgradeList().filter((v, i) => abilityUpgradeList().length - i <= limitCount + 1));
  let list = getKeyWordList($.Localize("#DOTA_Tooltip_ability_" + itemname + "_description"));
  const keywordList = [];
  const infoList = [];
  const abilityList = [];
  Object.keys(itemKV.AbilityValues ?? {}).filter(sValueName => {
    let sVariableLocalize = $.Localize("#dota_tooltip_item_variable_" + sValueName);
    if (sVariableLocalize != "#dota_tooltip_item_variable_" + sValueName) {
      return sValueName;
    }
  }).forEach(v => {
    list = list.concat(getKeyWordList($.Localize("#dota_tooltip_item_variable_" + v)));
  });
  list.forEach(v => {
    if (v.type == "KeyWord") {
      keywordList.push(v.value);
    } else if (v.type == "Ability") {
      abilityList.push(v.value);
    } else if (v.type == "Info") {
      infoList.push(v.value);
    }
  });
  return libs.createComponent(EOM_Panel.EOM_Panel, {
    flowChildren: "down",
    get children() {
      return [libs.createComponent(EOM_Tooltip.EOM_Tooltip, {
        width: "380px",
        flowChildren: "down",
        onload: () => {
          $.GetContextPanel().style.minHeight = "0px";
        },
        get children() {
          return [libs.createComponent(EOM_Tooltip.EOM_TooltipHeader, {
            flowChildren: "right",
            get children() {
              return [libs.createComponent(ItemImage.ItemImage, {
                width: "60px",
                height: "45px",
                align: "center center",
                itemName: itemname
              }), libs.createComponent(EOM_Panel.EOM_Panel, {
                flowChildren: "down",
                marginLeft: "8px",
                height: "100%",
                get children() {
                  return [libs.createComponent(GenericPanel.CLabel, {
                    id: "SectNameHeader",
                    html: true,
                    get text() {
                      return $.Localize("#DOTA_Tooltip_ability_" + itemname);
                    }
                  }), libs.createComponent(EOM_Panel.EOM_Panel, {
                    flowChildren: "right",
                    verticalAlign: "bottom",
                    get children() {
                      return [libs.memo(() => sectList.map((sectName, index) => {
                        return libs.createComponent(SectIcon.SectIcon, {
                          width: "28px",
                          height: "28px",
                          sectName: sectName
                        });
                      })), libs.createComponent(libs.Show, {
                        get when() {
                          return libs.memo(() => itemKV?.Repeat == undefined)() && itemname.indexOf("item_artifact_") != -1;
                        },
                        get children() {
                          const _el$ = libs.createElement("Label", {
                            text: "#DOTA_SHOP_CATEGORY_UNIQUES"
                          }, null);
                          libs.setProp(_el$, "className", "AbilityType");
                          return _el$;
                        }
                      })];
                    }
                  })];
                }
              })];
            }
          }), libs.createComponent(EOM_Panel.EOM_Panel, {
            className: "SectRow",
            flowChildren: "down",
            get children() {
              return [libs.memo(() => sAttributes != "" && libs.createComponent(GenericPanel.CLabel, {
                className: "Attribute",
                html: true,
                text: sAttributes
              })), libs.memo(() => bHasDescription && text != "" && libs.createComponent(GenericPanel.CLabel, {
                className: "SectDescription",
                html: true,
                text: text
              })), libs.createComponent(libs.Show, {
                get when() {
                  return extraData();
                },
                get children() {
                  return libs.createComponent(libs.Index, {
                    get each() {
                      return Object.keys(extraData());
                    },
                    children: key => {
                      return libs.createComponent(libs.Show, {
                        get when() {
                          return extraData()[key()] > 0;
                        },
                        get children() {
                          return libs.createComponent(GenericPanel.CLabel, {
                            id: "extraText",
                            html: true,
                            text: "#artifact_extra_data",
                            get vars() {
                              return {
                                key: ` ${$.Localize("#" + key())}`,
                                value: extraData()[key()]
                              };
                            }
                          });
                        }
                      });
                    }
                  });
                }
              }), libs.createComponent(libs.Show, {
                get when() {
                  return extraStrData();
                },
                get children() {
                  return libs.createComponent(libs.Index, {
                    get each() {
                      return Object.keys(extraStrData());
                    },
                    children: key => {
                      const designatedPlayerSteamID = () => {
                        if (key() == "DesignatedPlayer") {
                          return getPlayerData(Number(extraStrData()[key()]), "steamID");
                        }
                      };
                      return libs.createComponent(libs.Switch, {
                        get fallback() {
                          return libs.createComponent(GenericPanel.CLabel, {
                            id: "extraText",
                            html: true,
                            text: "#artifact_extra_string_data",
                            get vars() {
                              return {
                                key: ` ${$.Localize("#" + key())}`,
                                value: ` ${$.Localize(extraStrData()[key()]) == extraStrData()[key()] ? extraStrData()[key()] : $.Localize(extraStrData()[key()])}`
                              };
                            }
                          });
                        },
                        get children() {
                          return libs.createComponent(libs.Match, {
                            get when() {
                              return key() == "DesignatedPlayer";
                            },
                            get children() {
                              return libs.createComponent(EOM_Panel.EOM_Panel, {
                                id: "extraTextPlayer",
                                get children() {
                                  return [libs.createComponent(GenericPanel.CLabel, {
                                    id: "extraTextPlayerLabel",
                                    html: true,
                                    get text() {
                                      return $.Localize("#DesignatedPlayer") + ": ";
                                    }
                                  }), libs.createComponent(Player.PlayerAvatar, {
                                    get playerID() {
                                      return Number(extraStrData()[key()]);
                                    },
                                    get steamID() {
                                      return designatedPlayerSteamID();
                                    }
                                  }), libs.createComponent(Player.PlayerName, {
                                    get playerID() {
                                      return Number(extraStrData()[key()]);
                                    },
                                    get steamID() {
                                      return designatedPlayerSteamID();
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
              })];
            }
          }), libs.memo(() => lore != "" && lore != "#DOTA_Tooltip_ability_" + itemname + "_Lore" && libs.createComponent(EOM_Panel.EOM_Panel, {
            id: "LoreContainer",
            get children() {
              return libs.createComponent(GenericPanel.CLabel, {
                html: true,
                text: lore
              });
            }
          })), libs.createComponent(libs.Show, {
            when: showOverrideWarning == 1,
            get children() {
              return libs.createComponent(EOM_Tooltip.EOM_TooltipHeader, {
                margin: "4px",
                padding: "4px 8px",
                get children() {
                  return libs.createComponent(EOM_Label.EOM_Label, {
                    html: true,
                    fontSize: "14px",
                    marginTop: "2px",
                    color: "#da1616",
                    text: "#Greevil_EquipmentWarning"
                  });
                }
              });
            }
          })];
        }
      }), libs.memo(() => libs.memo(() => !!(keywordList.length > 0 || infoList.length > 0))() && libs.createComponent(EOM_Tooltip.EOM_Tooltip, {
        width: "380px",
        flowChildren: "down",
        get children() {
          return [libs.memo(() => libs.memo(() => abilityList.length > 0)() && libs.createComponent(AbilityList, {
            keywordList: abilityList,
            marginTop: "0px"
          })), libs.memo(() => libs.memo(() => keywordList.length > 0)() && libs.createComponent(KeyWordList, {
            keywordList: keywordList,
            get marginTop() {
              return abilityList.length > 0 ? "4px" : "0px";
            }
          })), libs.memo(() => libs.memo(() => infoList.length > 0)() && libs.createComponent(InfoList, {
            keywordList: infoList,
            get marginTop() {
              return keywordList.length > 0 ? "4px" : "0px";
            }
          }))];
        }
      })), libs.createComponent(libs.Show, {
        get when() {
          return limitAbilitiesList().length > 0;
        },
        get children() {
          return libs.createComponent(EOM_Tooltip.EOM_Tooltip, {
            width: "380px",
            flowChildren: "down",
            get children() {
              return [libs.createComponent(libs.Show, {
                get when() {
                  return limitAbilitiesList().length > limitCount;
                },
                get children() {
                  return libs.createComponent(EOM_Label.EOM_Label, {
                    horizontalAlign: 'center',
                    marginTop: '6px',
                    fontSize: '16px',
                    textShadow: '0 0 2px 2 #000000',
                    color: 'white',
                    style: {
                      textAlign: "center"
                    },
                    text: "#landEffect_AbilityMaxCount",
                    dialogVariables: {
                      count: limitCount
                    }
                  });
                }
              }), libs.createComponent(EOM_Panel.EOM_Panel, {
                get className() {
                  return libs.classNames("AbilityList", {
                    OverFlow: limitAbilitiesList().length > limitCount
                  });
                },
                flowChildren: "down",
                get children() {
                  return [libs.memo(() => limitAbilitiesList().map((abilityUpgradeID, index) => {
                    const abilityUpgradeInfo = GameUI.CustomUIConfig().AbilityUpgradesKv[abilityUpgradeID];
                    const rarity = abilityUpgradeInfo.rarity;
                    return libs.createComponent(EOM_Panel.EOM_Panel, {
                      className: "AbilityRow",
                      flowChildren: "right",
                      get children() {
                        return [libs.createComponent(GenericPanel.CImage, {
                          className: "AbilityImage",
                          get src() {
                            return `file://{images}/spellicons/${abilityUpgradeInfo.Texture}.png`;
                          }
                        }), libs.createComponent(EOM_Panel.EOM_Panel, {
                          flowChildren: "down",
                          marginLeft: "8px",
                          get children() {
                            return [libs.createComponent(GenericPanel.CLabel, {
                              get className() {
                                return libs.classNames("SectName", {
                                  Rare: rarity == "r",
                                  SuperRare: rarity == "sr"
                                });
                              },
                              html: true,
                              get text() {
                                return $.Localize("#DOTA_Tooltip_ability_mechanics_" + abilityUpgradeID);
                              }
                            }), libs.createComponent(GenericPanel.CLabel, {
                              className: "AbilityDescription",
                              html: true,
                              get text() {
                                return getSectDescription(abilityUpgradeID, 1, true);
                              }
                            })];
                          }
                        })];
                      }
                    });
                  })), libs.createComponent(EOM_Label.EOM_Label, {
                    id: "ExtraAbilityCount",
                    get text() {
                      return `${$.Localize("#has_num")} ${abilityUpgradeList().length}`;
                    }
                  })];
                }
              })];
            }
          });
        }
      })];
    }
  });
}
function removeRepeatKeyword(keywordList) {
  var newList = [];
  for (const keyword of keywordList) {
    if (newList.indexOf(keyword) == -1) {
      newList.push(keyword);
    }
  }
  return newList;
}
function KeyWordList({
  keywordList,
  marginTop
}) {
  keywordList = removeRepeatKeyword(keywordList);
  return libs.createComponent(EOM_Panel.EOM_Panel, {
    width: "380px",
    flowChildren: "down",
    get children() {
      return keywordList.map((keyword, index) => {
        return libs.createComponent(EOM_Tooltip.EOM_TooltipHeader, {
          flowChildren: "down",
          marginTop: index == 0 ? marginTop : "4px",
          get children() {
            return [libs.createComponent(EOM_Label.EOM_Label, {
              html: true,
              fontSize: "18px",
              get text() {
                return replaceKeyword(`{KeyWord:${keyword}}`);
              }
            }), libs.createComponent(EOM_Label.EOM_Label, {
              html: true,
              fontSize: "16px",
              marginTop: "2px",
              get text() {
                return replaceAll($.Localize("#KeyWord_" + keyword + "_description"));
              }
            })];
          }
        });
      });
    }
  });
}
function InfoList({
  keywordList,
  marginTop
}) {
  keywordList = removeRepeatKeyword(keywordList);
  return libs.createComponent(EOM_Panel.EOM_Panel, {
    width: "380px",
    flowChildren: "down",
    get children() {
      return keywordList.map((keyword, index) => {
        return libs.createComponent(EOM_Tooltip.EOM_TooltipHeader, {
          flowChildren: "down",
          marginTop: index == 0 ? marginTop : "4px",
          get children() {
            return [libs.createComponent(EOM_Label.EOM_Label, {
              html: true,
              fontSize: "18px",
              text: "#" + keyword
            }), libs.createComponent(EOM_Label.EOM_Label, {
              html: true,
              fontSize: "16px",
              marginTop: "2px",
              get text() {
                return replaceAll($.Localize("#" + keyword + "_description"));
              }
            })];
          }
        });
      });
    }
  });
}
function AbilityList({
  keywordList,
  marginTop
}) {
  keywordList = removeRepeatKeyword(keywordList);
  return libs.createComponent(EOM_Panel.EOM_Panel, {
    width: "380px",
    flowChildren: "down",
    get children() {
      return keywordList.map((keyword, index) => {
        return libs.createComponent(EOM_Tooltip.EOM_TooltipHeader, {
          padding: '0px',
          flowChildren: "down",
          marginTop: index == 0 ? marginTop : "4px",
          get children() {
            return libs.createComponent(AbilityKeyWordContainer, {
              abilityName: keyword,
              index: index
            });
          }
        });
      });
    }
  });
}
const AbilityKeyWordContainer = props => {
  const {
    abilityName,
    index
  } = props;
  const abilityUpgradeInfo = KeyValues.AbilityUpgradesKv[abilityName];
  const abilityKV = KeyValues.AbilitiesKv[abilityName];
  const itemKV = KeyValues.ItemsKv[abilityName];
  if (abilityUpgradeInfo != undefined) {
    const sectList = abilityUpgradeInfo.sect.split("|");
    const lore = replaceBuffEnum($.Localize("#DOTA_Tooltip_ability_mechanics_" + abilityName + "_Lore"));
    return libs.createComponent(EOM_Panel.EOM_Panel, {
      className: "AbilityKeyWordContainer Sect",
      marginTop: index == 0 ? "0px" : "4px",
      flowChildren: 'down',
      get children() {
        return [libs.createComponent(EOM_Tooltip.EOM_TooltipHeader, {
          flowChildren: "right",
          get children() {
            return [libs.createComponent(GenericPanel.CImage, {
              className: "SectAbilityImage",
              get src() {
                return `file://{images}/spellicons/${abilityUpgradeInfo.Texture}.png`;
              }
            }), libs.createComponent(EOM_Panel.EOM_Panel, {
              flowChildren: "down",
              marginLeft: "8px",
              height: "100%",
              get children() {
                return [libs.createComponent(GenericPanel.CLabel, {
                  id: "SectNameHeader",
                  html: true,
                  get text() {
                    return $.Localize("#DOTA_Tooltip_ability_mechanics_" + abilityName);
                  }
                }), libs.createComponent(EOM_Panel.EOM_Panel, {
                  flowChildren: "right",
                  verticalAlign: "bottom",
                  get children() {
                    return sectList.map((sectName, index) => {
                      return libs.createComponent(SectIcon.SectIcon, {
                        width: "28px",
                        height: "28px",
                        sectName: sectName
                      });
                    });
                  }
                })];
              }
            })];
          }
        }), libs.createComponent(EOM_Panel.EOM_Panel, {
          className: "SectRow",
          flowChildren: "right",
          get children() {
            return libs.createComponent(GenericPanel.CLabel, {
              className: "SectDescription",
              html: true,
              get text() {
                return getAbilityDescription(abilityName, undefined, -1);
              }
            });
          }
        }), libs.memo(() => lore != "#DOTA_Tooltip_ability_mechanics_" + abilityName + "_Lore" && libs.createComponent(EOM_Panel.EOM_Panel, {
          id: "LoreContainer",
          get children() {
            return libs.createComponent(GenericPanel.CLabel, {
              html: true,
              text: lore
            });
          }
        }))];
      }
    });
  } else if (abilityKV) {
    return libs.createComponent(EOM_Panel.EOM_Panel, {
      className: "AbilityKeyWordContainer Ability",
      marginTop: index == 0 ? "0px" : "4px",
      flowChildren: 'down',
      get children() {
        return [libs.createComponent(EOM_Tooltip.EOM_TooltipHeader, {
          flowChildren: "right",
          get children() {
            return [(() => {
              const _el$2 = libs.createElement("DOTAAbilityImage", {
                abilityname: abilityName
              }, null);
              libs.setProp(_el$2, "className", "SectAbilityImage");
              libs.setProp(_el$2, "abilityname", abilityName);
              return _el$2;
            })(), libs.createComponent(EOM_Panel.EOM_Panel, {
              flowChildren: "down",
              marginLeft: "8px",
              height: "100%",
              get children() {
                return [libs.createComponent(GenericPanel.CLabel, {
                  id: "SectNameHeader",
                  html: true,
                  text: "#DOTA_Tooltip_ability_" + abilityName
                }), libs.createComponent(libs.Show, {
                  get when() {
                    return abilityKV.AbilityType != undefined;
                  },
                  get children() {
                    return libs.createComponent(GenericPanel.CLabel, {
                      className: "AbilityType",
                      get text() {
                        return "#" + abilityKV.AbilityType;
                      }
                    });
                  }
                })];
              }
            })];
          }
        }), libs.createComponent(EOM_Panel.EOM_Panel, {
          className: "SectRow",
          flowChildren: "right",
          get children() {
            return libs.createComponent(AbilityDescription.AbilityDescription, {
              className: "AbilityDescription",
              abilityName: abilityName
            });
          }
        })];
      }
    });
  } else if (itemKV) {
    const itemname = abilityName;
    const lore = replaceBuffEnum($.Localize("#DOTA_Tooltip_ability_" + itemname + "_Lore"));
    const sectList = itemKV.Sect?.split("|") ?? [];
    let bHasDescription = $.Localize("#DOTA_Tooltip_ability_" + itemname + "_description") != "#DOTA_Tooltip_ability_" + itemname + "_description";
    let sAttributes = getItemArrtibute(itemname);
    const text = getItemDescription(itemname);
    return libs.createComponent(EOM_Panel.EOM_Panel, {
      className: "AbilityKeyWordContainer Item",
      marginTop: index == 0 ? "0px" : "4px",
      flowChildren: 'down',
      get children() {
        return [libs.createComponent(EOM_Tooltip.EOM_TooltipHeader, {
          flowChildren: "right",
          get children() {
            return [libs.createComponent(ItemImage.ItemImage, {
              width: "60px",
              height: "45px",
              align: "center center",
              itemName: itemname
            }), libs.createComponent(EOM_Panel.EOM_Panel, {
              flowChildren: "down",
              marginLeft: "8px",
              height: "100%",
              get children() {
                return [libs.createComponent(GenericPanel.CLabel, {
                  id: "SectNameHeader",
                  html: true,
                  get text() {
                    return $.Localize("#DOTA_Tooltip_ability_" + itemname);
                  }
                }), libs.createComponent(EOM_Panel.EOM_Panel, {
                  flowChildren: "right",
                  verticalAlign: "bottom",
                  get children() {
                    return [libs.memo(() => sectList.map((sectName, index) => {
                      return libs.createComponent(SectIcon.SectIcon, {
                        width: "28px",
                        height: "28px",
                        sectName: sectName
                      });
                    })), libs.createComponent(libs.Show, {
                      get when() {
                        return libs.memo(() => itemKV?.Repeat == undefined)() && itemname.indexOf("item_artifact_") != -1;
                      },
                      get children() {
                        const _el$3 = libs.createElement("Label", {
                          text: "#DOTA_SHOP_CATEGORY_UNIQUES"
                        }, null);
                        libs.setProp(_el$3, "className", "AbilityType");
                        return _el$3;
                      }
                    })];
                  }
                })];
              }
            })];
          }
        }), libs.createComponent(EOM_Panel.EOM_Panel, {
          className: "SectRow",
          flowChildren: "down",
          get children() {
            return [libs.memo(() => sAttributes != "" && libs.createComponent(GenericPanel.CLabel, {
              className: "Attribute",
              html: true,
              text: sAttributes
            })), libs.memo(() => bHasDescription && text != "" && libs.createComponent(GenericPanel.CLabel, {
              className: "SectDescription",
              html: true,
              text: text
            }))];
          }
        }), libs.memo(() => lore != "" && lore != "#DOTA_Tooltip_ability_" + itemname + "_Lore" && libs.createComponent(EOM_Panel.EOM_Panel, {
          id: "LoreContainer",
          get children() {
            return libs.createComponent(GenericPanel.CLabel, {
              html: true,
              text: lore
            });
          }
        }))];
      }
    });
  }
};
function SetupTooltip() {
  let itemname = pTooltipPanel.GetAttributeString("itemname", "");
  let entindex = pTooltipPanel.GetAttributeInt("entindex", -1);
  let playerID = pTooltipPanel.GetAttributeInt("player_id", -1);
  let showOverrideWarning = pTooltipPanel.GetAttributeInt("showOverrideWarning", -1);
  libs.render(() => libs.createComponent(TooltipContents, {
    itemname: itemname,
    entindex: entindex,
    playerID: playerID,
    showOverrideWarning: showOverrideWarning
  }), pTooltipPanel);
}
(function () {
  pTooltipPanel.SetPanelEvent("ontooltiploaded", SetupTooltip);
  {
    let pArrow = pTooltipPanel.GetParent()?.FindChildTraverse("LeftArrow");
    if (pArrow) {
      pArrow.style.washColor = "#12141a";
    }
    pArrow = pTooltipPanel.GetParent()?.FindChildTraverse("RightArrow");
    if (pArrow) {
      pArrow.style.washColor = "#12141a";
    }
  }
  {
    let pArrow = pTooltipPanel.GetParent()?.GetParent()?.FindChildTraverse("TopArrow");
    if (pArrow) {
      pArrow.style.washColor = "#12141a";
    }
    pArrow = pTooltipPanel.GetParent()?.GetParent()?.FindChildTraverse("BottomArrow");
    if (pArrow) {
      pArrow.style.washColor = "#12141a";
    }
  }
  pTooltipPanel.style.minHeight = "150px";
})();