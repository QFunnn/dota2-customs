--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 0b85d8d 
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
var SectIcon = require('./SectIcon.js');

let pTooltipPanel = $.GetContextPanel();
pTooltipPanel.style.minHeight = "0px";
pTooltipPanel.FindAncestor("hero_ability").FindChildTraverse("LeftArrow").style.opacity = "0";
pTooltipPanel.FindAncestor("hero_ability").FindChildTraverse("RightArrow").style.opacity = "0";
pTooltipPanel.FindAncestor("hero_ability").FindChildTraverse("TopArrow").style.opacity = "0";
pTooltipPanel.FindAncestor("hero_ability").FindChildTraverse("BottomArrow").style.opacity = "0";
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
  abilityName,
  overrideLevel,
  entIndex,
  playerID
}) {
  let localPlayerID = playerID;
  let showExtraInfo = isSpectator() || playerID == Players.GetLocalPlayer();
  let list = [];
  let linkedMechanicsDataList = {};
  if (KeyValues.AbilityUpMechanicsLinked[abilityName]) {
    linkedMechanicsDataList = KeyValues.AbilityUpMechanicsLinked[abilityName];
  }
  let mechanicsRecord = {};
  let addedMechanicsList = [];
  if (playerID != -1) {
    let s = CustomNetTables.GetTableValue("ability_upgrades_list", playerID.toString())?.json;
    if (s) {
      s = s.replace(/\*/g, `"null"`);
      let ability_upgrades_list;
      try {
        ability_upgrades_list = JSON.parseSafe(s);
      } catch (error) {}
      if (ability_upgrades_list) {
        for (let index = 1; index < ability_upgrades_list.length; index++) {
          let aData = ability_upgrades_list[index];
          let tData = unzip(ability_upgrades_list[0], aData);
          if (tData.ability_name == abilityName && tData.type == AbilityUpgradeType.ABILITY_UPGRADES_TYPE_ABILITY_MECHANICS) {
            if (KeyValues.AbilityUpgradesMechenicsKv[tData.id]) {
              if (KeyValues.AbilityUpgradesMechenicsKv[tData.id].link_ability == abilityName) {
                addedMechanicsList.push(tData.id);
              } else {
                let title = "None";
                if (KeyValues.AbilityUpgradesMechenicsKv[tData.id].title) {
                  title = KeyValues.AbilityUpgradesMechenicsKv[tData.id].title;
                }
                if (mechanicsRecord[title] == undefined) {
                  mechanicsRecord[title] = {};
                }
                mechanicsRecord[title][tData.id] = tData;
              }
              if (KeyValues.AbilityUpgradesMechenicsKv[tData.id]?.description) {
                list = list.concat(getKeyWordList($.Localize("#" + KeyValues.AbilityUpgradesMechenicsKv[tData.id].description)));
              }
            }
          }
        }
      }
    }
  }
  const [abilityUpgradeList, setAbilityUpgradeList] = libs.createSignal([]);
  const [extraData, setExtraData] = libs.createSignal();
  const [extraStrData, setExtraStrData] = libs.createSignal();
  libs.onMount(() => {
    if (entIndex != -1) {
      const eventIDList = [];
      const netTableIDList = [];
      if (localPlayerID != -1 && showExtraInfo) {
        netTableIDList.push(useNetTableKeyHasDefaultValue("common", "hero_ability_extra_info_" + localPlayerID, data => {
          if (data && data[abilityName]) {
            setAbilityUpgradeList(Object.values(data[abilityName]?.abilities ?? {}));
            setExtraData(data[abilityName]?.extra_info);
            setExtraStrData(data[abilityName]?.extra_info_str);
          }
        }));
        libs.onCleanup(() => {
          eventIDList.forEach(id => GameEvents.Unsubscribe(id));
          netTableIDList.forEach(id => CustomNetTables.UnsubscribeNetTableListener(id));
        });
      }
    }
  });
  const limitCount = 10;
  const limitAbilitiesList = libs.createMemo(() => abilityUpgradeList().filter((v, i) => abilityUpgradeList().length - i <= limitCount + 1));
  list = list.concat(getKeyWordList($.Localize("#DOTA_Tooltip_ability_" + abilityName + "_description")));
  const keywordList = [];
  const infoList = [];
  const abilityList = [];
  list.forEach(v => {
    if (v.type == "KeyWord") {
      if (!keywordList.includes(v.value)) {
        keywordList.push(v.value);
      }
    } else if (v.type == "Ability") {
      if (!abilityList.includes(v.value)) {
        abilityList.push(v.value);
      }
    } else if (v.type == "Info") {
      if (!infoList.includes(v.value)) {
        infoList.push(v.value);
      }
    }
  });
  let abilityEntindex = -1;
  if (entIndex != undefined && entIndex != -1) {
    abilityEntindex = Entities.GetAbilityByName(entIndex, abilityName);
  }
  return libs.createComponent(EOM_Panel.EOM_Panel, {
    flowChildren: "down-wrap",
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
              return [(() => {
                const _el$ = libs.createElement("DOTAAbilityImage", {
                  abilityname: abilityName,
                  contextEntityIndex: abilityEntindex
                }, null);
                libs.setProp(_el$, "className", "SectImage");
                libs.setProp(_el$, "abilityname", abilityName);
                libs.setProp(_el$, "contextEntityIndex", abilityEntindex);
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
                      return KeyValues.AbilitiesKv[abilityName].AbilityType != undefined;
                    },
                    get children() {
                      return libs.createComponent(GenericPanel.CLabel, {
                        className: "AbilityType",
                        get text() {
                          return "#" + GameUI.CustomUIConfig().AbilitiesKv[abilityName].AbilityType;
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
                level: overrideLevel,
                abilityName: abilityName,
                entityIndex: entIndex
              });
            }
          }), libs.memo(() => libs.memo(() => !!(Object.keys(linkedMechanicsDataList).length > 0 || Object.keys(mechanicsRecord).length > 0))() && libs.createComponent(EOM_Panel.EOM_Panel, {
            className: "UpgradeMechanicsList",
            get children() {
              return [libs.createComponent(EOM_Panel.EOM_Panel, {
                id: "UpgradeMechanicsTitle",
                get children() {
                  return libs.createComponent(EOM_Label.EOM_Label, {
                    id: "UpgradeMechanicsTitle_Label",
                    text: "#ability_upgrades_mechanics_title"
                  });
                }
              }), libs.createComponent(EOM_Panel.EOM_Panel, {
                id: "UpgradeMechanicsRowList",
                get children() {
                  return [libs.memo(() => Object.keys(linkedMechanicsDataList).map(title => {
                    if (title == "None") {
                      return;
                    }
                    const src = () => {
                      if (linkedMechanicsDataList[title]) {
                        let id = linkedMechanicsDataList[title].find(v => KeyValues.AbilityUpgradesMechenicsKv[v]?.textrue != undefined);
                        if (id) {
                          let textrue = KeyValues.AbilityUpgradesMechenicsKv[id]?.textrue;
                          if (textrue) {
                            if ($.BImageFileExists(`file://{images}/spellicons/${textrue}.png`)) {
                              return `file://{images}/spellicons/${textrue}.png`;
                            }
                            return `raw://resource/flash3/images/spellicons/${textrue}.png`;
                          }
                        }
                      }
                      return `file://{images}/spellicons/empty.png`;
                    };
                    return libs.createComponent(EOM_Panel.EOM_Panel, {
                      className: "UpgradeMechanicsRow",
                      get children() {
                        return [libs.createComponent(EOM_Panel.EOM_Panel, {
                          className: "UpgradeMechanicsLinkTitle",
                          get children() {
                            return [libs.createComponent(EOM_Image.EOM_Image, {
                              className: "UpgradeMechanicsLinkTitleImage",
                              scaling: "stretch",
                              get src() {
                                return src();
                              }
                            }), libs.createComponent(EOM_Label.EOM_Label, {
                              html: true,
                              text: `#${title}`
                            })];
                          }
                        }), libs.createComponent(EOM_Panel.EOM_Panel, {
                          className: "UpgradeMechanicsDecriptions",
                          get children() {
                            return linkedMechanicsDataList[title].sort((a, b) => (addedMechanicsList.includes(a) ? 0 : 1) - (addedMechanicsList.includes(b) ? 0 : 1)).map(id => {
                              let added = addedMechanicsList.includes(id);
                              return libs.createComponent(EOM_Label.EOM_Label, {
                                classList: {
                                  NotAdd: !added
                                },
                                html: true,
                                get text() {
                                  return getAbilityUpgradeMechanicsDescriptionByID(id);
                                }
                              });
                            });
                          }
                        })];
                      }
                    });
                  })), libs.memo(() => libs.memo(() => Object.keys(mechanicsRecord).length > 0)() && Object.keys(mechanicsRecord).map(title => {
                    if (title == "None") {
                      return;
                    }
                    const src = () => {
                      if (mechanicsRecord[title]) {
                        let id = Object.keys(mechanicsRecord[title]).find(v => KeyValues.AbilityUpgradesMechenicsKv[v]?.textrue != undefined);
                        if (id) {
                          let textrue = KeyValues.AbilityUpgradesMechenicsKv[id]?.textrue;
                          if (textrue) {
                            if ($.BImageFileExists(`file://{images}/spellicons/${textrue}.png`)) {
                              return `file://{images}/spellicons/${textrue}.png`;
                            }
                            return `raw://resource/flash3/images/spellicons/${textrue}.png`;
                          }
                        }
                      }
                      return `file://{images}/spellicons/empty.png`;
                    };
                    return libs.createComponent(EOM_Panel.EOM_Panel, {
                      className: "UpgradeMechanicsRow",
                      get children() {
                        return [libs.createComponent(EOM_Panel.EOM_Panel, {
                          className: "UpgradeMechanicsLinkTitle",
                          get children() {
                            return [libs.createComponent(EOM_Image.EOM_Image, {
                              className: "UpgradeMechanicsLinkTitleImage",
                              scaling: "stretch",
                              get src() {
                                return src();
                              }
                            }), libs.createComponent(EOM_Label.EOM_Label, {
                              html: true,
                              text: `#${title}`
                            })];
                          }
                        }), libs.createComponent(EOM_Panel.EOM_Panel, {
                          className: "UpgradeMechanicsDecriptions",
                          get children() {
                            return Object.keys(mechanicsRecord[title]).map(id => {
                              return libs.createComponent(EOM_Label.EOM_Label, {
                                html: true,
                                get text() {
                                  return getAbilityUpgradeMechanicsDescriptionByID(id);
                                }
                              });
                            });
                          }
                        })];
                      }
                    });
                  })), libs.memo(() => libs.memo(() => linkedMechanicsDataList["None"] != undefined)() && linkedMechanicsDataList["None"].map(id => {
                    return libs.createComponent(EOM_Panel.EOM_Panel, {
                      className: "UpgradeMechanicsRow",
                      get children() {
                        return libs.createComponent(EOM_Label.EOM_Label, {
                          className: "UpgradeMechanicsDecription",
                          html: true,
                          get text() {
                            return getAbilityUpgradeMechanicsDescriptionByID(id);
                          }
                        });
                      }
                    });
                  })), libs.memo(() => libs.memo(() => mechanicsRecord["None"] != undefined)() && Object.keys(mechanicsRecord["None"]).map(id => {
                    return libs.createComponent(EOM_Panel.EOM_Panel, {
                      className: "UpgradeMechanicsRow",
                      get children() {
                        return libs.createComponent(EOM_Label.EOM_Label, {
                          className: "UpgradeMechanicsDecription",
                          html: true,
                          get text() {
                            return getAbilityUpgradeMechanicsDescriptionByID(id);
                          }
                        });
                      }
                    });
                  }))];
                }
              })];
            }
          }))];
        }
      }), libs.memo(() => libs.memo(() => !!(keywordList.length > 0 || infoList.length > 0 || abilityList.length > 0))() && libs.createComponent(EOM_Tooltip.EOM_Tooltip, {
        width: "380px",
        flowChildren: "down",
        get children() {
          return [libs.memo(() => libs.memo(() => abilityList.length > 0)() && libs.createComponent(AbilityList, {
            keywordList: abilityList,
            marginTop: "0px",
            entityIndex: entIndex
          })), libs.memo(() => libs.memo(() => keywordList.length > 0)() && libs.createComponent(KeyWordList, {
            keywordList: keywordList,
            get marginTop() {
              return abilityList.length > 0 ? "4px" : "0px";
            }
          })), libs.memo(() => libs.memo(() => infoList.length > 0)() && libs.createComponent(InfoList, {
            keywordList: infoList,
            get marginTop() {
              return abilityList.length > 0 || keywordList.length > 0 ? "4px" : "0px";
            }
          }))];
        }
      })), libs.createComponent(libs.Show, {
        get when() {
          return extraData() || extraStrData() || limitAbilitiesList().length > 0;
        },
        get children() {
          return libs.createComponent(EOM_Tooltip.EOM_Tooltip, {
            width: "380px",
            flowChildren: "down",
            get children() {
              return [libs.createComponent(libs.Show, {
                get when() {
                  return extraData();
                },
                get children() {
                  return libs.createComponent(EOM_Panel.EOM_Panel, {
                    className: "ExtraInfo",
                    flowChildren: "down",
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
                  });
                }
              }), libs.createComponent(libs.Show, {
                get when() {
                  return extraStrData();
                },
                get children() {
                  return libs.createComponent(EOM_Panel.EOM_Panel, {
                    className: "ExtraInfo",
                    flowChildren: "down",
                    get children() {
                      return libs.createComponent(libs.Index, {
                        get each() {
                          return Object.keys(extraStrData());
                        },
                        children: key => {
                          return libs.createComponent(libs.Show, {
                            get when() {
                              return extraStrData()[key()] != "";
                            },
                            get children() {
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
                            }
                          });
                        }
                      });
                    }
                  });
                }
              }), libs.createComponent(libs.Show, {
                get when() {
                  return limitAbilitiesList().length > 0;
                },
                get children() {
                  return libs.createComponent(EOM_Panel.EOM_Panel, {
                    className: "ExtraInfo",
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
                                        return getSectDescription(abilityUpgradeID, 1, true, localPlayerID);
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
      })];
    }
  });
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
              fontSize: "16px",
              get text() {
                return replaceKeyword(`{KeyWord:${keyword}}`);
              }
            }), libs.createComponent(EOM_Label.EOM_Label, {
              html: true,
              fontSize: "14px",
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
              fontSize: "16px",
              text: "#" + keyword
            }), libs.createComponent(EOM_Label.EOM_Label, {
              html: true,
              fontSize: "14px",
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
  marginTop,
  entityIndex
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
              index: index,
              entityIndex: entityIndex
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
    index,
    entityIndex
  } = props;
  const abilityUpgradeInfo = KeyValues.AbilityUpgradesKv[abilityName];
  const abilityKV = KeyValues.AbilitiesKv[abilityName];
  const itemKV = KeyValues.ItemsKv[abilityName];
  if (abilityUpgradeInfo != undefined) {
    const sectList = abilityUpgradeInfo.sect.split("|");
    const lore = replaceBuffEnum($.Localize("#DOTA_Tooltip_ability_mechanics_" + abilityName + "_Lore"));
    return libs.createComponent(EOM_Panel.EOM_Panel, {
      className: "AbilityKeyWordContainer Sect",
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
      flowChildren: 'down',
      get children() {
        return [libs.createComponent(EOM_Tooltip.EOM_TooltipHeader, {
          flowChildren: "right",
          get children() {
            return [(() => {
              const _el$2 = libs.createElement("DOTAAbilityImage", {
                abilityname: abilityName,
                scaling: "stretch-to-cover-preserve-aspect"
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
              abilityName: abilityName,
              entityIndex: entityIndex
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
function removeRepeatKeyword(keywordList) {
  var newList = [];
  for (const keyword of keywordList) {
    if (newList.indexOf(keyword) == -1) {
      newList.push(keyword);
    }
  }
  return newList;
}
function SetupTooltip() {
  let abilityName = pTooltipPanel.GetAttributeString("abilityName", "");
  let overrideLevel = pTooltipPanel.GetAttributeInt("overrideLevel", -1);
  let entIndex = pTooltipPanel.GetAttributeInt("entIndex", 0);
  if (entIndex == 0) {
    entIndex = undefined;
  }
  let playerID = pTooltipPanel.GetAttributeInt("player_id", -1);
  libs.render(() => libs.createComponent(TooltipContents, {
    abilityName: abilityName,
    overrideLevel: overrideLevel >= 0 ? overrideLevel : undefined,
    entIndex: entIndex,
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
  Update();
})();