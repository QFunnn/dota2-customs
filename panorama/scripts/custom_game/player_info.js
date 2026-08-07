--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 9d26fbd · 2026-08-07 04:51:43 UTC
  ~ auto-generated — do not edit
]]


'use strict'; const require = GameUI.__require;

var libs = require('./libs.js');
var EOM_Panel = require('./EOM_Panel.js');
var EOM_Tooltip = require('./EOM_Tooltip.js');
var EOM_Icon = require('./EOM_Icon.js');
var EOM_Label = require('./EOM_Label.js');
var GenericPanel = require('./GenericPanel.js');
var HeroPortrait = require('./HeroPortrait.js');
var ItemImage = require('./ItemImage.js');
var SectIcon = require('./SectIcon.js');
require('./EOM_Image.js');

let pTooltipPanel = $.GetContextPanel();
pTooltipPanel.FindAncestor("player_info").FindChildTraverse("LeftArrow").style.opacity = "0";
pTooltipPanel.FindAncestor("player_info").FindChildTraverse("RightArrow").style.opacity = "0";
pTooltipPanel.FindAncestor("player_info").FindChildTraverse("TopArrow").style.opacity = "0";
pTooltipPanel.FindAncestor("player_info").FindChildTraverse("BottomArrow").style.opacity = "0";
const DOTA_ITEM_INVENTORY_MIN = 0;
const DOTA_ITEM_INVENTORY_MAX = 7;
function TooltipContents(props) {
  const {
    playerID
  } = props;
  const playerData = CustomNetTables.GetTableValue("player_data", String(playerID));
  const heroLevel = getPlayerData(playerID, "heroLevel") ?? 1;
  const sectData = CustomNetTables.GetTableValue("sect_data", "sect_data_" + playerID) ?? {};
  const heroEntIndex = Players.GetPlayerHeroEntityIndex(playerID);
  let sectNameList = Object.keys(sectData).sort((a, b) => {
    return sectData[b].level - sectData[a].level;
  });
  const heroName = playerData?.heroName ?? "";
  const heroData = GameUI.CustomUIConfig().UnitsCommonKv[heroName];
  const abliityList = [].concat(KeyValues.HeroAbilityDisplayList[heroName]);
  if (abliityList != undefined && typeof heroData.InteractiveAbilityName == "string") {
    abliityList.push(heroData.InteractiveAbilityName);
  }
  const runeTaskData = CustomNetTables.GetTableValue("common", "rune_task_" + playerID);
  let showRuneTaskProgess = Players.GetLocalPlayer() == playerID || isSpectator();
  const runeTaskList = (() => {
    let list = [];
    const data = runeTaskData;
    if (data) {
      for (const key in data) {
        const v = data[key];
        list.push({
          id: v.id,
          progress: v.progress,
          finish: v.finish == 1
        });
      }
    }
    return list;
  })();
  const artifactList = Object.values(CustomNetTables.GetTableValue("common", "artifact_list_" + playerID) ?? {});
  const skinID = (() => {
    const netTableData = getServiceNetTable("player_equipped_ornament", playerID)?.[OrnamentType.HERO_SKIN];
    let _skinID;
    if (netTableData) {
      for (const oid in netTableData) {
        const kv = KeyValues.CosmeticsKv[oid];
        if (kv && kv.hero && GetHeroNameByGoodID(finiteNumber(Number(kv.hero))) == heroName) {
          _skinID = oid;
        }
      }
    }
    return _skinID;
  })();
  let model;
  if (playerData && playerData.heroName) {
    model = KeyValues.UnitsKv[playerData.heroName]?.Model;
  }
  const updateSlots = () => {
    let aSlots = [];
    for (let index = DOTA_ITEM_INVENTORY_MIN; index <= DOTA_ITEM_INVENTORY_MAX; index++) {
      let iItemIndex = Entities.GetItemInSlot(playerData?.heroEntIndex ?? -1, index);
      if (iItemIndex != -1) {
        let itemName = Abilities.GetAbilityName(iItemIndex);
        aSlots.push({
          overrideentityindex: iItemIndex,
          itemName: itemName,
          slot: index
        });
      }
    }
    return aSlots.sort((a, b) => (KeyValues.ItemsKv[a.itemName]?.ItemLevel ?? 0) - (KeyValues.ItemsKv[b.itemName]?.ItemLevel ?? 0));
  };
  let slots = updateSlots();
  const roundNow = CustomNetTables.GetTableValue("common", "round_data")?.round_number ?? -1;
  const roundCardEffect = CustomNetTables.GetTableValue("common", "card_effect_" + props.playerID)?.round_record?.[roundNow];
  return libs.createComponent(EOM_Panel.EOM_Panel, {
    flowChildren: "right",
    get children() {
      return [libs.createComponent(EOM_Panel.EOM_Panel, {
        width: "500px",
        flowChildren: "down",
        get children() {
          return [libs.createComponent(EOM_Panel.EOM_Panel, {
            className: "TooltipColumn",
            width: "500px",
            flowChildren: "down",
            get children() {
              return [libs.createComponent(EOM_Tooltip.EOM_TooltipHeader, {
                flowChildren: "right",
                get children() {
                  return libs.createComponent(GenericPanel.CLabel, {
                    text: "#PlayerInfoTitle_Hero"
                  });
                }
              }), libs.createComponent(EOM_Panel.EOM_Panel, {
                className: "AbilityRow",
                flowChildren: "right",
                get children() {
                  return [libs.createComponent(EOM_Panel.EOM_Panel, {
                    flowChildren: "down",
                    get children() {
                      return [libs.createComponent(EOM_Label.EOM_Label, {
                        align: "center top",
                        marginTop: "6px",
                        width: "100%",
                        height: "22px",
                        color: "#fff",
                        fontSize: "18px",
                        textOverflow: "shrink",
                        style: {
                          textAlign: "center"
                        },
                        text: heroName ? "#" + heroName : ""
                      }), libs.createComponent(HeroPortrait.HeroPortrait, {
                        width: "180px",
                        height: "180px",
                        unitname: skinID ?? heroName,
                        model: model,
                        player_id: playerID,
                        get children() {
                          return [libs.createComponent(EOM_Panel.EOM_Panel, {
                            flowChildren: "down",
                            marginTop: "-6px",
                            marginLeft: "-6px",
                            get children() {
                              return (heroData?.Sect ?? "").split("|").map((sectName, index) => {
                                if (sectName != "") {
                                  return libs.createComponent(SectIcon.SectIcon, {
                                    sectName: sectName,
                                    style: {
                                      uiScale: "80%"
                                    },
                                    marginBottom: "-10px",
                                    tooltip: "#DOTA_Tooltip_ability_" + sectName
                                  });
                                }
                              });
                            }
                          }), libs.memo(() => libs.memo(() => slots.length > 0)() && libs.createComponent(EOM_Panel.EOM_Panel, {
                            height: "100%",
                            width: "100%",
                            backgroundColor: "gradient( linear, 0% 0%, 0% 100%, from( #00000000 ), color-stop( .4, #00000000 ), color-stop( .6, #00000088 ), color-stop( .7, #000000c8 ), color-stop( .8, #000000e8 ), to( #000000ff ) )",
                            get children() {
                              return libs.createComponent(EOM_Panel.EOM_Panel, {
                                get className() {
                                  return libs.classNames("inventory", "slot_" + slots.length);
                                },
                                flowChildren: "right",
                                marginBottom: "5px",
                                verticalAlign: "bottom",
                                horizontalAlign: "left",
                                get children() {
                                  return slots.map((data, index) => {
                                    if (data.overrideentityindex != -1) {
                                      return libs.createComponent(ItemImage.ItemImage, {
                                        className: "equipment",
                                        id: "inventory_slot_" + index,
                                        get itemEntIndex() {
                                          return data.overrideentityindex;
                                        }
                                      });
                                    }
                                  });
                                }
                              });
                            }
                          }))];
                        }
                      })];
                    }
                  }), libs.createComponent(EOM_Panel.EOM_Panel, {
                    flowChildren: "down",
                    marginTop: "24px",
                    get children() {
                      return [libs.createComponent(GenericPanel.CLabel, {
                        className: "AttributeName",
                        text: "#PlayerInfo_Level",
                        dialogVariables: {
                          value: heroLevel
                        }
                      }), libs.createComponent(GenericPanel.CLabel, {
                        className: "AttributeDescription",
                        text: "#PlayerInfo_Level_Description"
                      }), libs.createComponent(GenericPanel.CLabel, {
                        className: "AttributeName",
                        text: "#PlayerInfo_Win",
                        get dialogVariables() {
                          return {
                            value: playerData?.winStack ?? 0
                          };
                        }
                      }), libs.createComponent(GenericPanel.CLabel, {
                        className: "AttributeDescription",
                        text: "#PlayerInfo_Win_Description"
                      }), libs.createComponent(GenericPanel.CLabel, {
                        className: "AttributeName",
                        text: "#PlayerInfo_Damage",
                        get dialogVariables() {
                          return {
                            value: playerData?.damage ?? 0
                          };
                        }
                      }), libs.createComponent(GenericPanel.CLabel, {
                        className: "AttributeDescription",
                        text: "#PlayerInfo_Damage_Description"
                      })];
                    }
                  })];
                }
              }), libs.createComponent(libs.Show, {
                get when() {
                  return Entities.GetItemInSlot(heroEntIndex, 0) > -1;
                },
                get children() {
                  return [libs.createComponent(EOM_Tooltip.EOM_TooltipHeader, {
                    flowChildren: "right",
                    get children() {
                      return libs.createComponent(GenericPanel.CLabel, {
                        text: "#PlayerInfoTitle_Artifact"
                      });
                    }
                  }), libs.memo(() => [...Array(3)].map((_, index) => {
                    const itemName = artifactList?.[index] ?? "";
                    if (itemName != "") {
                      return libs.createComponent(EOM_Panel.EOM_Panel, {
                        className: "AbilityRow",
                        flowChildren: "right",
                        get children() {
                          return [(() => {
                            const _el$ = libs.createElement("DOTAItemImage", {
                              itemname: itemName
                            }, null);
                            libs.setProp(_el$, "itemname", itemName);
                            return _el$;
                          })(), libs.createComponent(EOM_Panel.EOM_Panel, {
                            flowChildren: "down",
                            marginLeft: "6px",
                            get children() {
                              return [libs.createComponent(GenericPanel.CLabel, {
                                className: "AbilityName",
                                get text() {
                                  return $.Localize("#DOTA_Tooltip_ability_" + itemName);
                                }
                              }), libs.createComponent(GenericPanel.CLabel, {
                                className: "AbilityDescription",
                                html: true,
                                get text() {
                                  return getItemDescription(itemName);
                                }
                              })];
                            }
                          })];
                        }
                      });
                    }
                  }))];
                }
              }), libs.createComponent(libs.Show, {
                get when() {
                  return sectNameList.length > 0;
                },
                get children() {
                  return [libs.createComponent(EOM_Tooltip.EOM_TooltipHeader, {
                    flowChildren: "right",
                    get children() {
                      return libs.createComponent(GenericPanel.CLabel, {
                        text: "#PlayerInfoTitle_Sect"
                      });
                    }
                  }), libs.createComponent(EOM_Panel.EOM_Panel, {
                    flowChildren: "right-wrap",
                    style: {
                      maxHeight: "265px"
                    },
                    width: "100%",
                    get children() {
                      return sectNameList.sort((a, b) => {
                        return sectData[b].exp - sectData[a].exp;
                      }).map((sectName, index) => {
                        const sectInfo = sectData[sectName];
                        if (sectInfo.exp > 0) {
                          return libs.createComponent(EOM_Panel.EOM_Panel, {
                            "class": "AbilityRow",
                            flowChildren: "down",
                            get children() {
                              return [libs.createComponent(SectIcon.SectIcon, {
                                sectName: sectName,
                                marginBottom: "-6px"
                              }), libs.createComponent(EOM_Label.EOM_Label, {
                                horizontalAlign: "center",
                                className: "AbilityName",
                                get text() {
                                  return `${sectInfo.exp}/${sectInfo.maxExp}`;
                                }
                              }), libs.createComponent(libs.Show, {
                                get when() {
                                  return sectInfo.level > 0;
                                },
                                get children() {
                                  return libs.createComponent(EOM_Label.EOM_Label, {
                                    horizontalAlign: "center",
                                    className: "AbilityName",
                                    get text() {
                                      return [...Array(sectInfo.level)].map(() => {
                                        return "★";
                                      }).join("");
                                    }
                                  });
                                }
                              })];
                            }
                          });
                        }
                      });
                    }
                  })];
                }
              }), libs.createComponent(libs.Show, {
                get when() {
                  return runeTaskList.length > 0;
                },
                get children() {
                  return [libs.createComponent(EOM_Tooltip.EOM_TooltipHeader, {
                    flowChildren: "right",
                    get children() {
                      return libs.createComponent(GenericPanel.CLabel, {
                        text: "#GameState_RuneTask"
                      });
                    }
                  }), libs.createComponent(EOM_Panel.EOM_Panel, {
                    flowChildren: "right-wrap",
                    width: "100%",
                    get children() {
                      return runeTaskList.map((data, i) => {
                        const taskType = KeyValues.RuneTaskKV[data.id]?.type ?? "none";
                        const target = KeyValues.RuneTaskKV[data.id]?.target ?? -1;
                        return libs.createComponent(EOM_Panel.EOM_Panel, {
                          get className() {
                            return libs.classNames("RuneTaskInfo", {
                              finish: showRuneTaskProgess && data.finish
                            });
                          },
                          get children() {
                            return [libs.createComponent(EOM_Panel.EOM_Panel, {
                              id: "RuneTaskDesc",
                              get children() {
                                return [libs.createComponent(libs.Show, {
                                  when: showRuneTaskProgess,
                                  get children() {
                                    return libs.createComponent(EOM_Label.EOM_Label, {
                                      id: "RuneTaskProgress",
                                      get text() {
                                        return `(${data.progress}/${target})`;
                                      }
                                    });
                                  }
                                }), libs.createComponent(EOM_Label.EOM_Label, {
                                  id: "RuneTaskDescription",
                                  text: "#RuneTask_" + taskType + "_description",
                                  dialogVariables: {
                                    target: target
                                  },
                                  html: true
                                })];
                              }
                            }), libs.createComponent(libs.Show, {
                              get when() {
                                return showRuneTaskProgess && data.finish;
                              },
                              get children() {
                                return libs.createComponent(EOM_Icon.EOM_Icon, {
                                  id: "finishIcon",
                                  size: "32",
                                  get src() {
                                    return getSrcPath("icon/selected.png");
                                  }
                                });
                              }
                            })];
                          }
                        });
                      });
                    }
                  })];
                }
              })];
            }
          }), libs.createComponent(libs.Show, {
            when: roundCardEffect != undefined,
            get children() {
              return libs.createComponent(EOM_Panel.EOM_Panel, {
                className: "TooltipColumn RoundCardEffect",
                get children() {
                  return [libs.createComponent(EOM_Tooltip.EOM_TooltipHeader, {
                    get children() {
                      return libs.createComponent(GenericPanel.CLabel, {
                        get text() {
                          return isGroupMode() ? "#TeamCardRound" : "#CardEffectRound";
                        }
                      });
                    }
                  }), libs.memo(() => (() => {
                    const infoKeys = () => {
                      let arr = [];
                      const str = $.Localize("#DOTA_Tooltip_ability_" + roundCardEffect + "_description");
                      str.replace(/{Info:(\w+?)}/g, (a, b, c) => {
                        arr.push(b);
                      });
                      return arr;
                    };
                    return libs.createComponent(EOM_Panel.EOM_Panel, {
                      width: "100%",
                      flowChildren: "right",
                      padding: '4px 6px',
                      get children() {
                        return [libs.createComponent(GenericPanel.CImage, {
                          className: "CardEffectImage"
                        }), libs.createComponent(EOM_Panel.EOM_Panel, {
                          width: "100%",
                          "max-height": '100px',
                          flowChildren: "down",
                          marginLeft: "8px",
                          get children() {
                            return [libs.createComponent(GenericPanel.CLabel, {
                              get className() {
                                return libs.classNames("SectName");
                              },
                              html: true,
                              text: "#DOTA_Tooltip_ability_" + roundCardEffect
                            }), libs.createComponent(GenericPanel.CLabel, {
                              className: "SectDescription",
                              html: true,
                              get text() {
                                return getCardDescription(roundCardEffect);
                              }
                            }), libs.createComponent(libs.Show, {
                              get when() {
                                return infoKeys().length > 0;
                              },
                              get children() {
                                return libs.createComponent(libs.Index, {
                                  get each() {
                                    return infoKeys();
                                  },
                                  children: (info, i) => [libs.createComponent(EOM_Panel.EOM_Panel, {
                                    className: "InfoTitle",
                                    get children() {
                                      return libs.createComponent(EOM_Label.EOM_Label, {
                                        className: "InfoTitleLabel",
                                        get text() {
                                          return $.Localize(`#${info()}`);
                                        },
                                        html: true
                                      });
                                    }
                                  }), libs.createComponent(EOM_Panel.EOM_Panel, {
                                    className: "InfoDescription",
                                    get children() {
                                      return libs.createComponent(EOM_Label.EOM_Label, {
                                        className: "InfoDescriptionLabel",
                                        get text() {
                                          return replaceAll($.Localize(`#${info()}_description`));
                                        },
                                        html: true
                                      });
                                    }
                                  })]
                                });
                              }
                            })];
                          }
                        })];
                      }
                    });
                  })())];
                }
              });
            }
          })];
        }
      }), libs.createComponent(EOM_Panel.EOM_Panel, {
        className: "TooltipColumn HeroAbility",
        width: "480px",
        get children() {
          return [libs.createComponent(EOM_Tooltip.EOM_TooltipHeader, {
            flowChildren: "right",
            get children() {
              return libs.createComponent(GenericPanel.CLabel, {
                text: "#PlayerInfoTitle_HeroAbility"
              });
            }
          }), libs.memo(() => abliityList != undefined && abliityList.map((name, i) => {
            return libs.createComponent(EOM_Panel.EOM_Panel, {
              className: "AbilityRow",
              flowChildren: "right",
              get children() {
                return [(() => {
                  const _el$2 = libs.createElement("DOTAAbilityImage", {
                    abilityname: name
                  }, null);
                  libs.setProp(_el$2, "abilityname", name);
                  return _el$2;
                })(), libs.createComponent(EOM_Panel.EOM_Panel, {
                  flowChildren: "down",
                  marginLeft: "6px",
                  get children() {
                    return [libs.createComponent(GenericPanel.CLabel, {
                      className: "AbilityName",
                      get text() {
                        return $.Localize("#DOTA_Tooltip_ability_" + name);
                      }
                    }), libs.createComponent(GenericPanel.CLabel, {
                      className: "AbilityType",
                      get text() {
                        return $.Localize("#" + (GameUI.CustomUIConfig().AbilitiesKv[name]?.AbilityType ?? ""));
                      }
                    }), libs.createComponent(GenericPanel.CLabel, {
                      html: true,
                      className: "AbilityDescription",
                      get text() {
                        return getAbilityDescription(name);
                      }
                    })];
                  }
                })];
              }
            });
          }))];
        }
      })];
    }
  });
}
function SetupTooltip() {
  let playerID = pTooltipPanel.GetAttributeInt("playerID", -1);
  libs.render(() => libs.createComponent(TooltipContents, {
    playerID: playerID
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