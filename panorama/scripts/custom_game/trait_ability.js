--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 16fdfbc · 2026-08-07 21:47:55 UTC
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
pTooltipPanel.FindAncestor("trait_ability").FindChildTraverse("LeftArrow").style.opacity = "0";
pTooltipPanel.FindAncestor("trait_ability").FindChildTraverse("RightArrow").style.opacity = "0";
pTooltipPanel.FindAncestor("trait_ability").FindChildTraverse("TopArrow").style.opacity = "0";
pTooltipPanel.FindAncestor("trait_ability").FindChildTraverse("BottomArrow").style.opacity = "0";
var KeywordListTooltipTypes = function (KeywordListTooltipTypes) {
  KeywordListTooltipTypes["keyword"] = "KeyWord";
  KeywordListTooltipTypes["info"] = "Info";
  KeywordListTooltipTypes["ability"] = "Ability";
  return KeywordListTooltipTypes;
}(KeywordListTooltipTypes || {});
function TooltipContents(props) {
  let ability_name = props.ability_name;
  const playerID = props.playerID;
  let tag = "EX";
  if (KeyValues.TraitKv[ability_name]) {
    if (KeyValues.TraitKv[ability_name].Round == 1) {
      tag = "I";
    } else if (KeyValues.TraitKv[ability_name].Round == 11) {
      tag = "II";
    }
  }
  let abilityUpgradeList = [];
  let abilityUpgradeAmounts = 0;
  let abilityExtraDataList = {};
  let abilityExtraStringDataList = {};
  const limitCount = 5;
  if (playerID != -1) {
    const showDetail = Players.GetLocalPlayer() == playerID;
    if (showDetail) {
      let abilityEnt = -1;
      const unitEnt = Players.GetPlayerHeroEntityIndex(Players.GetLocalPlayer());
      abilityEnt = Entities.GetAbilityByName(unitEnt, ability_name);
      const abilityCached = getNetDataCache("artifact_abilities", Players.GetLocalPlayer());
      if (abilityCached) {
        if (abilityCached[abilityEnt]) {
          abilityUpgradeAmounts = abilityCached[abilityEnt].length;
          const limitAbilitiesList = abilityCached[abilityEnt].filter((v, i) => abilityCached[abilityEnt].length - i <= limitCount);
          abilityUpgradeList = limitAbilitiesList;
        }
      }
      const extraDataCached = getNetDataCache("artifact_extra_data", Players.GetLocalPlayer());
      if (extraDataCached) {
        if (extraDataCached[abilityEnt]) {
          abilityExtraDataList = extraDataCached[abilityEnt];
        }
      }
      const extraStringDataCached = getNetDataCache("artifact_extra_string_data", Players.GetLocalPlayer());
      if (extraStringDataCached) {
        if (extraStringDataCached[abilityEnt]) {
          abilityExtraStringDataList = extraStringDataCached[abilityEnt];
        }
      }
    }
  }
  let keywordList = getKeyWordList($.Localize("#DOTA_Tooltip_ability_" + ability_name + "_description"));
  keywordList = keywordList.sort((a, b) => Number(b.type == "Ability") - Number(a.type == "Ability"));
  let TreasureType = KeyValues.treasure_abilities[ability_name]?.TreasureType ?? 0;
  return libs.createComponent(EOM_Panel.EOM_Panel, {
    flowChildren: "down",
    get children() {
      return [libs.createComponent(EOM_Tooltip.EOM_Tooltip, {
        width: "380px",
        flowChildren: 'down',
        get children() {
          return ability_name && libs.createComponent(EOM_Panel.EOM_Panel, {
            className: "RuneReward",
            get children() {
              return [libs.createComponent(EOM_Tooltip.EOM_TooltipHeader, {
                id: "RuneAbilityTitle",
                classList: {
                  ["TitleTreasureType_" + TreasureType]: true
                },
                flowChildren: "right",
                get children() {
                  return libs.createComponent(EOM_Panel.EOM_Panel, {
                    width: "100%",
                    height: "30px",
                    flowChildren: "right",
                    get children() {
                      return [libs.createComponent(libs.Show, {
                        when: tag == "EX",
                        get fallback() {
                          return libs.createComponent(EOM_Panel.EOM_Panel, {
                            className: "RuneLevelTag",
                            get children() {
                              return libs.createComponent(GenericPanel.CLabel, {
                                text: tag
                              });
                            }
                          });
                        },
                        get children() {
                          const _el$ = libs.createElement("Image", {}, null);
                          libs.effect(_$p => libs.setProp(_el$, "className", libs.classNames("TreasureAbilityImage", "Type_" + (KeyValues.treasure_abilities[ability_name]?.TreasureType ?? 1)), _$p));
                          return _el$;
                        }
                      }), libs.createComponent(GenericPanel.CLabel, {
                        id: "CityNameHeader",
                        html: true,
                        text: "#DOTA_Tooltip_ability_" + ability_name
                      })];
                    }
                  });
                }
              }), libs.createComponent(EOM_Panel.EOM_Panel, {
                className: "SectRow RuneReward",
                flowChildren: "right",
                get children() {
                  return libs.createComponent(AbilityDescription.AbilityDescription, {
                    className: "RuneRewardDescription",
                    abilityName: ability_name,
                    level: 1
                  });
                }
              }), libs.memo(() => (() => {
                let arr1 = Object.keys(abilityExtraDataList);
                if (arr1.length > 0) {
                  return Object.keys(abilityExtraDataList).map((key, index) => {
                    const value = abilityExtraDataList[key];
                    if (value > 0) {
                      return libs.createComponent(GenericPanel.CLabel, {
                        id: "extraText",
                        html: true,
                        text: "#artifact_extra_data",
                        get vars() {
                          return {
                            key: ` ${$.Localize("#" + key)}`,
                            value: value
                          };
                        }
                      });
                    }
                  });
                }
              })()), libs.memo(() => (() => {
                let arr1 = Object.keys(abilityExtraStringDataList);
                if (arr1.length > 0) {
                  return Object.keys(abilityExtraStringDataList).map((key, index) => {
                    const value = abilityExtraStringDataList[key];
                    return libs.createComponent(libs.Switch, {
                      get fallback() {
                        return libs.createComponent(GenericPanel.CLabel, {
                          id: "extraText",
                          html: true,
                          text: "#artifact_extra_string_data",
                          get vars() {
                            return {
                              key: `${$.Localize("#" + key)}`,
                              value: ` ${$.Localize(value) == value ? value : $.Localize(value)}`
                            };
                          }
                        });
                      },
                      get children() {
                        return libs.createComponent(libs.Match, {
                          when: key == "DesignatedPlayer",
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
                                    return Number(value);
                                  },
                                  get steamID() {
                                    return getPlayerData(Number(value), "steamID");
                                  }
                                }), libs.createComponent(Player.PlayerName, {
                                  get playerID() {
                                    return Number(value);
                                  },
                                  get steamID() {
                                    return getPlayerData(Number(value), "steamID");
                                  }
                                })];
                              }
                            });
                          }
                        });
                      }
                    });
                  });
                }
              })()), libs.createComponent(libs.Show, {
                get when() {
                  return abilityUpgradeList.length > 0;
                },
                get children() {
                  return [libs.createComponent(libs.Show, {
                    get when() {
                      return abilityUpgradeList.length >= limitCount;
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
                        OverFlow: abilityUpgradeList.length >= limitCount
                      });
                    },
                    flowChildren: "down",
                    get children() {
                      return [libs.memo(() => abilityUpgradeList.map((abilityUpgradeID, index) => {
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
                          return `${$.Localize("#has_num")} ${abilityUpgradeAmounts}`;
                        }
                      })];
                    }
                  })];
                }
              })];
            }
          });
        }
      }), libs.memo(() => libs.memo(() => keywordList.length > 0)() && libs.createComponent(EOM_Tooltip.EOM_Tooltip, {
        width: "380px",
        flowChildren: "down",
        get children() {
          return keywordList.map((keywordInfo, index) => {
            let keyword = keywordInfo.value;
            let title = "";
            let description = "";
            if (keywordInfo.type == KeywordListTooltipTypes.ability) {
              return libs.createComponent(AbilityKeyWordContainer, {
                get abilityName() {
                  return keywordInfo.value;
                },
                index: index
              });
            } else {
              if (keywordInfo.type == KeywordListTooltipTypes.keyword) {
                title = replaceAll(`{KeyWord:${keyword}}`);
                description = replaceAll($.Localize("#KeyWord_" + keyword + "_description"));
              } else if (keywordInfo.type == KeywordListTooltipTypes.info) {
                title = $.Localize(`#${keyword}`);
                description = replaceAll($.Localize("#" + keyword + "_description"));
              }
              return libs.createComponent(EOM_Tooltip.EOM_TooltipHeader, {
                flowChildren: "down",
                marginTop: index == 0 ? "0px" : "4px",
                get children() {
                  return [libs.createComponent(EOM_Label.EOM_Label, {
                    html: true,
                    fontSize: "18px",
                    text: title
                  }), libs.createComponent(EOM_Label.EOM_Label, {
                    html: true,
                    fontSize: "16px",
                    marginTop: "2px",
                    text: description
                  })];
                }
              });
            }
          });
        }
      }))];
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
                return getSectDescription(abilityName, -1, false);
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
  let ability_name = pTooltipPanel.GetAttributeString("ability_name", "");
  let playerID = pTooltipPanel.GetAttributeInt("playerID", -1);
  libs.render(() => libs.createComponent(TooltipContents, {
    ability_name: ability_name,
    playerID: playerID
  }), pTooltipPanel);
}
(function () {
  pTooltipPanel.SetPanelEvent("ontooltiploaded", SetupTooltip);
  {
    let pArrow = pTooltipPanel.GetParent()?.FindChildTraverse("LeftArrow");
    if (pArrow) {
      pArrow.style.washColor = "#12141a";
      pArrow.style.height = "1px";
      pArrow.style.width = "1px";
    }
    pArrow = pTooltipPanel.GetParent()?.FindChildTraverse("RightArrow");
    if (pArrow) {
      pArrow.style.washColor = "#12141a";
      pArrow.style.height = "1px";
      pArrow.style.width = "1px";
    }
  }
  {
    let pArrow = pTooltipPanel.GetParent()?.GetParent()?.FindChildTraverse("TopArrow");
    if (pArrow) {
      pArrow.style.washColor = "#12141a";
      pArrow.style.height = "1px";
      pArrow.style.width = "1px";
    }
    pArrow = pTooltipPanel.GetParent()?.GetParent()?.FindChildTraverse("BottomArrow");
    if (pArrow) {
      pArrow.style.washColor = "#12141a";
      pArrow.style.height = "1px";
      pArrow.style.width = "1px";
    }
  }
  pTooltipPanel.style.minHeight = "50px";
})();