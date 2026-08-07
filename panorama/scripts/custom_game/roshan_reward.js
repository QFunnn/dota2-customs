--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 9d26fbd · 2026-08-07 04:51:43 UTC
  ~ auto-generated — do not edit
]]


'use strict'; const require = GameUI.__require;

var libs = require('./libs.js');
var AbilityDescription = require('./AbilityDescription.js');
var EOM_Panel = require('./EOM_Panel.js');
var EOM_Tooltip = require('./EOM_Tooltip.js');
var EOM_Label = require('./EOM_Label.js');
var GenericPanel = require('./GenericPanel.js');
var SectIcon = require('./SectIcon.js');
require('./EOM_Image.js');

let pTooltipPanel = $.GetContextPanel();
pTooltipPanel.style.minHeight = "0px";
pTooltipPanel.FindAncestor("roshan_reward").FindChildTraverse("LeftArrow").style.opacity = "0";
pTooltipPanel.FindAncestor("roshan_reward").FindChildTraverse("RightArrow").style.opacity = "0";
pTooltipPanel.FindAncestor("roshan_reward").FindChildTraverse("TopArrow").style.opacity = "0";
pTooltipPanel.FindAncestor("roshan_reward").FindChildTraverse("BottomArrow").style.opacity = "0";
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
function TooltipContents(props) {
  const {
    playerID,
    ability_list
  } = props;
  const sect_data = CustomNetTables.GetTableValue("sect_data", "ability_upgrade_" + playerID) ?? {};
  let _text = "";
  ability_list.forEach(aid => {
    _text += $.Localize("#DOTA_Tooltip_ability_mechanics_" + aid + "_description");
  });
  let keywordList = getKeyWordList(_text);
  keywordList = keywordList.sort((a, b) => Number(b.type == "Ability") - Number(a.type == "Ability"));
  const indexLv = {};
  {
    let cached = {};
    ability_list.forEach((aid, index) => {
      let maxLv = KeyValues.AbilityUpgradesKv[aid]?.MaxLevel ?? 0;
      let lv = cached[aid];
      if (cached[aid] == undefined) {
        lv = sect_data[aid]?.level ?? 0;
      }
      if (lv >= maxLv) {
        indexLv[index] = {
          lv: maxLv,
          isMax: true,
          add: 0
        };
      } else {
        indexLv[index] = {
          lv: lv,
          isMax: false,
          add: 1
        };
        lv++;
      }
      cached[aid] = lv;
    });
  }
  return libs.createComponent(EOM_Panel.EOM_Panel, {
    flowChildren: "down",
    get children() {
      return [libs.createComponent(EOM_Tooltip.EOM_Tooltip, {
        width: "380px",
        flowChildren: 'down',
        get children() {
          return [libs.createComponent(EOM_Tooltip.EOM_TooltipHeader, {
            get children() {
              return libs.createComponent(EOM_Label.EOM_Label, {
                id: "RoshanRewardTitle",
                get text() {
                  return getGameplayModuleState("treasure") ? "#GameState_Treasure" : "#RoshanChallenge";
                }
              });
            }
          }), libs.createComponent(EOM_Panel.EOM_Panel, {
            id: "RuneRewardMain",
            flowChildren: 'down',
            get children() {
              return ability_list.map((abilityUpgradeID, index) => {
                const abilityUpgradeInfo = GameUI.CustomUIConfig().AbilityUpgradesKv[abilityUpgradeID];
                const iLevel = indexLv[index].lv;
                const rarity = abilityUpgradeInfo.rarity;
                const starCount = abilityUpgradeInfo.MaxLevel ?? 1;
                let addStar = indexLv[index].add;
                return libs.createComponent(EOM_Panel.EOM_Panel, {
                  get className() {
                    return libs.classNames("SectAbilityRow", "Rarity_" + rarity, {
                      IsMax: indexLv[index].isMax,
                      maxLevel: iLevel == starCount
                    });
                  },
                  flowChildren: "right",
                  get children() {
                    return [libs.createComponent(GenericPanel.CImage, {
                      className: "AbilityImage",
                      get src() {
                        return `file://{images}/spellicons/${abilityUpgradeInfo.Texture}.png`;
                      },
                      get children() {
                        return libs.createComponent(EOM_Panel.EOM_Panel, {
                          id: "RewardAbilityMax"
                        });
                      }
                    }), libs.createComponent(EOM_Panel.EOM_Panel, {
                      flowChildren: "down",
                      marginLeft: "8px",
                      get children() {
                        return [libs.createComponent(EOM_Panel.EOM_Panel, {
                          className: "SectNameContainer",
                          get children() {
                            return [libs.createComponent(EOM_Panel.EOM_Panel, {
                              id: "StarList",
                              get children() {
                                return [...Array(starCount)].map((_, index) => {
                                  return libs.createComponent(EOM_Panel.EOM_Panel, {
                                    get className() {
                                      return libs.classNames("StarIcon", rarity, {
                                        Filled: iLevel + addStar >= index + 1,
                                        Plus: index + 1 > iLevel && index + 1 <= iLevel + addStar
                                      });
                                    }
                                  });
                                });
                              }
                            }), libs.createComponent(GenericPanel.CLabel, {
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
                            })];
                          }
                        }), libs.createComponent(GenericPanel.CLabel, {
                          className: "SectAbilityDescription",
                          html: true,
                          get text() {
                            return getSectDescription(abilityUpgradeID, iLevel, true);
                          }
                        })];
                      }
                    })];
                  }
                });
              });
            }
          })];
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
                    margin: '0 6px',
                    html: true,
                    fontSize: "18px",
                    text: title
                  }), libs.createComponent(EOM_Label.EOM_Label, {
                    margin: '0 6px',
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
  } else {
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
              abilityName: abilityName
            });
          }
        })];
      }
    });
  }
};
function SetupTooltip() {
  let playerID = pTooltipPanel.GetAttributeInt("playerID", Players.GetLocalPlayer());
  const abilityList = JSON.parseSafe(pTooltipPanel.GetAttributeString("ability_list", ""));
  libs.render(() => libs.createComponent(TooltipContents, {
    playerID: playerID,
    ability_list: abilityList
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