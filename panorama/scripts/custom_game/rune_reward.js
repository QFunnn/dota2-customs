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
var EOM_Image = require('./EOM_Image.js');
var EOM_Label = require('./EOM_Label.js');
var GenericPanel = require('./GenericPanel.js');
var ItemImage = require('./ItemImage.js');
var Player = require('./Player.js');
var SectIcon = require('./SectIcon.js');
require('./EOM_Button.js');
require('./EOM_Icon.js');

let pTooltipPanel = $.GetContextPanel();
pTooltipPanel.style.minHeight = "0px";
pTooltipPanel.FindAncestor("rune_reward").FindChildTraverse("LeftArrow").style.opacity = "0";
pTooltipPanel.FindAncestor("rune_reward").FindChildTraverse("RightArrow").style.opacity = "0";
pTooltipPanel.FindAncestor("rune_reward").FindChildTraverse("TopArrow").style.opacity = "0";
pTooltipPanel.FindAncestor("rune_reward").FindChildTraverse("BottomArrow").style.opacity = "0";
var KeywordListTooltipTypes = function (KeywordListTooltipTypes) {
  KeywordListTooltipTypes["keyword"] = "KeyWord";
  KeywordListTooltipTypes["info"] = "Info";
  KeywordListTooltipTypes["ability"] = "Ability";
  return KeywordListTooltipTypes;
}(KeywordListTooltipTypes || {});
let bAltDown = GameUI.IsAltDown();
function Update() {
  if (GameUI.IsAltDown() != bAltDown) {
    bAltDown = GameUI.IsAltDown();
    SetupTooltip();
  }
  if (pTooltipPanel.IsValid()) {
    $.Schedule(Game.GetGameFrameTime(), Update);
  }
}
function TooltipContents({
  playerID,
  trait_1,
  trait_2
}) {
  let trait1_lv = 1;
  let trait2_lv = 1;
  let trait1 = trait_1 == "" ? undefined : trait_1;
  let trait2 = trait_2 == "" ? undefined : trait_2;
  let abilityUpgradeList = {
    "1": [],
    "2": []
  };
  let abilityUpgradeAmounts = {
    "1": 0,
    "2": 0
  };
  let abilityExtraDataList = {
    "1": {},
    "2": {}
  };
  let abilityExtraStringDataList = {
    "1": {},
    "2": {}
  };
  const limitCount = 5;
  if (playerID != -1) {
    trait1 = getPlayerData(playerID, "trait");
    trait2 = getPlayerData(playerID, "trait2");
    const showDetail = Players.GetLocalPlayer() == playerID;
    if (showDetail) {
      let ent1 = -1;
      let ent2 = -1;
      const unitEnt = Players.GetPlayerHeroEntityIndex(Players.GetLocalPlayer());
      ent1 = Entities.GetAbilityByName(unitEnt, trait1);
      ent2 = Entities.GetAbilityByName(unitEnt, trait2);
      trait1_lv = Abilities.GetLevel(ent1) ?? 1;
      trait2_lv = Abilities.GetLevel(ent2) ?? 1;
      const abilityCached = getNetDataCache("artifact_abilities", Players.GetLocalPlayer());
      if (abilityCached) {
        if (abilityCached[ent1]) {
          abilityUpgradeAmounts["1"] = abilityCached[ent1].length;
          const limitAbilitiesList = abilityCached[ent1].filter((v, i) => abilityCached[ent1].length - i <= limitCount);
          abilityUpgradeList["1"] = limitAbilitiesList;
        }
        if (abilityCached[ent2]) {
          abilityUpgradeAmounts["2"] = abilityCached[ent2].length;
          const limitAbilitiesList = abilityCached[ent2].filter((v, i) => abilityCached[ent2].length - i <= limitCount);
          abilityUpgradeList["2"] = limitAbilitiesList;
        }
      }
      const extraDataCached = getNetDataCache("artifact_extra_data", Players.GetLocalPlayer());
      if (extraDataCached) {
        if (extraDataCached[ent1]) {
          abilityExtraDataList["1"] = extraDataCached[ent1];
        }
        if (extraDataCached[ent2]) {
          abilityExtraDataList["2"] = extraDataCached[ent2];
        }
      }
      const extraStringDataCached = getNetDataCache("artifact_extra_string_data", Players.GetLocalPlayer());
      if (extraStringDataCached) {
        if (extraStringDataCached[ent1]) {
          abilityExtraStringDataList["1"] = extraStringDataCached[ent1];
        }
        if (extraStringDataCached[ent2]) {
          abilityExtraStringDataList["2"] = extraStringDataCached[ent2];
        }
      }
      libs.onMount(() => {
        const eventIDList = [];
        eventIDList.push(useNetData("artifact_abilities", data => {}, Players.GetLocalPlayer()));
        eventIDList.push(useNetData("artifact_extra_data", data => {}, Players.GetLocalPlayer()));
        eventIDList.push(useNetData("artifact_extra_string_data", data => {}, Players.GetLocalPlayer()));
        libs.onCleanup(() => {
          eventIDList.forEach(id => {
            GameEvents.Unsubscribe(id);
          });
        });
      });
    }
  }
  const RuneDamageReduce = CustomNetTables.GetTableValue("common", "constant")?.BUFF_VALUE?.RuneDamageReduce ?? 0;
  const runeRewardLv = (trait1 == undefined ? 0 : 1) + (trait2 == undefined ? 0 : 1);
  let keywordList = getKeyWordList($.Localize("#DOTA_Tooltip_ability_" + trait1 + "_description") + $.Localize("#DOTA_Tooltip_ability_" + trait2 + "_description"));
  keywordList = keywordList.sort((a, b) => Number(b.type == "Ability") - Number(a.type == "Ability"));
  const RuneDescription = getKeyValueDescription({
    value: RuneDamageReduce * runeRewardLv
  }, $.Localize("#RuneRewardAttribute_Description"), {
    level: 1,
    onlyShowNowLevel: true
  });
  return libs.createComponent(EOM_Panel.EOM_Panel, {
    flowChildren: "down",
    get children() {
      return [libs.createComponent(EOM_Tooltip.EOM_Tooltip, {
        width: "380px",
        flowChildren: 'down',
        get children() {
          return [libs.createComponent(EOM_Panel.EOM_Panel, {
            get className() {
              return libs.classNames("RuneRewardTitle", "LV" + runeRewardLv);
            },
            get children() {
              return [libs.createComponent(EOM_Image.EOM_Image, {
                get className() {
                  return libs.classNames("RuneRewardIcon", "LV" + runeRewardLv);
                }
              }), libs.createComponent(GenericPanel.CLabel, {
                get className() {
                  return libs.classNames("RuneRewardTitleLevel", "LV" + runeRewardLv);
                },
                text: "Lv." + runeRewardLv
              }), libs.createComponent(EOM_Label.EOM_Label, {
                id: "RuneRewardTitleLabel",
                text: "#RuneReward"
              })];
            }
          }), libs.createComponent(EOM_Panel.EOM_Panel, {
            get className() {
              return libs.classNames("RuneRewardAttribute", "LV" + runeRewardLv);
            },
            get children() {
              return runeRewardLv == 0 ? libs.createComponent(GenericPanel.CLabel, {
                className: "RuneRewardDescription",
                text: "#RuneReward_NoEffect",
                html: true
              }) : [libs.createComponent(GenericPanel.CLabel, {
                className: "RuneRewardDescription",
                text: RuneDescription,
                html: true
              }), libs.createComponent(GenericPanel.CLabel, {
                className: "RuneRewardLore",
                text: "#RuneTaskDamageReduce",
                html: true
              })];
            }
          }), libs.memo(() => trait1 && libs.createComponent(EOM_Panel.EOM_Panel, {
            className: "RuneReward",
            get children() {
              return [libs.createComponent(EOM_Tooltip.EOM_TooltipHeader, {
                id: "RuneAbilityTitle",
                flowChildren: "right",
                get children() {
                  return libs.createComponent(EOM_Panel.EOM_Panel, {
                    width: "100%",
                    height: "30px",
                    get children() {
                      return [libs.createComponent(GenericPanel.CLabel, {
                        id: "CityNameHeader",
                        html: true,
                        text: "#DOTA_Tooltip_ability_" + trait1
                      }), libs.createComponent(EOM_Panel.EOM_Panel, {
                        className: "RuneLevelTag",
                        get children() {
                          return libs.createComponent(GenericPanel.CLabel, {
                            text: "I"
                          });
                        }
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
                    abilityName: trait1,
                    level: trait1_lv
                  });
                }
              }), libs.memo(() => (() => {
                let arr1 = Object.keys(abilityExtraDataList["1"]);
                if (arr1.length > 0) {
                  return Object.keys(abilityExtraDataList["1"]).map((key, index) => {
                    const value = abilityExtraDataList["1"][key];
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
                let arr1 = Object.keys(abilityExtraStringDataList["1"]);
                if (arr1.length > 0) {
                  return Object.keys(abilityExtraStringDataList["1"]).map((key, index) => {
                    const value = abilityExtraStringDataList["1"][key];
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
                  return abilityUpgradeList["1"].length > 0;
                },
                get children() {
                  return [libs.createComponent(libs.Show, {
                    get when() {
                      return abilityUpgradeList["1"].length >= limitCount;
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
                        OverFlow: abilityUpgradeList["1"].length >= limitCount
                      });
                    },
                    flowChildren: "down",
                    get children() {
                      return [libs.memo(() => abilityUpgradeList["1"].map((abilityUpgradeID, index) => {
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
                          return `${$.Localize("#has_num")} ${abilityUpgradeAmounts["1"]}`;
                        }
                      })];
                    }
                  })];
                }
              })];
            }
          })), libs.memo(() => trait2 && libs.createComponent(EOM_Panel.EOM_Panel, {
            className: "RuneReward",
            get children() {
              return [libs.createComponent(EOM_Tooltip.EOM_TooltipHeader, {
                id: "RuneAbilityTitle",
                flowChildren: "right",
                get children() {
                  return libs.createComponent(EOM_Panel.EOM_Panel, {
                    width: "100%",
                    height: "30px",
                    get children() {
                      return [libs.createComponent(GenericPanel.CLabel, {
                        id: "CityNameHeader",
                        html: true,
                        text: "#DOTA_Tooltip_ability_" + trait2
                      }), libs.createComponent(EOM_Panel.EOM_Panel, {
                        className: "RuneLevelTag",
                        get children() {
                          return libs.createComponent(GenericPanel.CLabel, {
                            text: "II"
                          });
                        }
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
                    abilityName: trait2,
                    level: trait2_lv
                  });
                }
              }), libs.memo(() => (() => {
                let arr2 = Object.keys(abilityExtraDataList["2"]);
                if (arr2.length > 0) {
                  return Object.keys(abilityExtraDataList["2"]).map((key, index) => {
                    const value = abilityExtraDataList["2"][key];
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
                let arr2 = Object.keys(abilityExtraStringDataList["2"]);
                if (arr2.length > 0) {
                  return Object.keys(abilityExtraStringDataList["2"]).map((key, index) => {
                    const value = abilityExtraStringDataList["2"][key];
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
                  return abilityUpgradeList["2"].length > 0;
                },
                get children() {
                  return [libs.createComponent(libs.Show, {
                    get when() {
                      return abilityUpgradeList["2"].length >= limitCount;
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
                        OverFlow: abilityUpgradeList["2"].length >= limitCount
                      });
                    },
                    flowChildren: "down",
                    get children() {
                      return [libs.memo(() => abilityUpgradeList["2"].map((abilityUpgradeID, index) => {
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
                          return `${$.Localize("#has_num")} ${abilityUpgradeAmounts["2"]}`;
                        }
                      })];
                    }
                  })];
                }
              })];
            }
          }))];
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
              const _el$ = libs.createElement("DOTAAbilityImage", {
                abilityname: abilityName
              }, null);
              libs.setProp(_el$, "className", "SectAbilityImage");
              libs.setProp(_el$, "abilityname", abilityName);
              return _el$;
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
                        const _el$2 = libs.createElement("Label", {
                          text: "#DOTA_SHOP_CATEGORY_UNIQUES"
                        }, null);
                        libs.setProp(_el$2, "className", "AbilityType");
                        return _el$2;
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
  let trait_1 = pTooltipPanel.GetAttributeString("trait_1", "");
  let trait_2 = pTooltipPanel.GetAttributeString("trait_2", "");
  if (trait_1 == "undefined") {
    trait_1 = "";
  }
  if (trait_2 == "undefined") {
    trait_2 = "";
  }
  let playerID = pTooltipPanel.GetAttributeInt("player_id", -1);
  libs.render(() => libs.createComponent(TooltipContents, {
    playerID: playerID,
    trait_1: trait_1,
    trait_2: trait_2
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
  pTooltipPanel.style.minHeight = "50px";
  Update();
})();