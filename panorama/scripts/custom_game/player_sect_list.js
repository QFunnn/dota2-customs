--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 0b85d8d 
  ~ auto-generated — do not edit
]]


'use strict'; const require = GameUI.__require;

var libs = require('./libs.js');
var EOM_Panel = require('./EOM_Panel.js');
var EOM_Tooltip = require('./EOM_Tooltip.js');
var EOM_Label = require('./EOM_Label.js');
var EOM_ProgressBar = require('./EOM_ProgressBar.js');
var GenericPanel = require('./GenericPanel.js');
var SectIcon = require('./SectIcon.js');
require('./EOM_Image.js');

let pTooltipPanel = $.GetContextPanel();
pTooltipPanel.FindAncestor("player_sect_list").FindChildTraverse("LeftArrow").style.opacity = "0";
pTooltipPanel.FindAncestor("player_sect_list").FindChildTraverse("RightArrow").style.opacity = "0";
pTooltipPanel.FindAncestor("player_sect_list").FindChildTraverse("TopArrow").style.opacity = "0";
pTooltipPanel.FindAncestor("player_sect_list").FindChildTraverse("BottomArrow").style.opacity = "0";
function TooltipContents(props) {
  let playerID = props.playerID == -1 ? Players.GetLocalPlayer() : props.playerID;
  const {
    sectName,
    isConcise
  } = props;
  const sectData = CustomNetTables.GetTableValue("sect_data", "sect_data_" + playerID) ?? {};
  const tData = CustomNetTables.GetTableValue("sect_data", "ability_upgrade_" + playerID) ?? {};
  const tTempData = CustomNetTables.GetTableValue("sect_data", "temp_ability_upgrade_" + playerID) ?? {};
  for (const aid in tTempData) {
    if (tTempData[aid].level > 0) {
      if (tData[aid] == undefined) {
        tData[aid] = {
          level: tTempData[aid].level
        };
      } else {
        tData[aid].level = Math.min(KeyValues.AbilityUpgradesKv[aid].MaxLevel, tData[aid].level + tTempData[aid].level);
      }
    }
  }
  const bannedSect = CustomNetTables.GetTableValue("player_data", Players.GetLocalPlayer().toString())?.bannedSect;
  const overload_data = CustomNetTables.GetTableValue("sect_data", "sect_overload") ?? {};
  const banList = Object.values(CustomNetTables.GetTableValue("common", "ban_list") ?? {});
  CustomNetTables.GetTableValue("common", "settings")?.SECT_ABILITY_LEVEL ?? {
    };
  let srCardlist = [];
  let revealList = [];
  if (props.sr_reveal) {
    srCardlist = Object.values(CustomNetTables.GetTableValue("common", "legend_card_list")?.[sectName] ?? {});
    const revealData = CustomNetTables.GetTableValue("common", "legend_card_reveal");
    if (revealData) {
      revealList = srCardlist.filter(v => revealData[v]);
    }
  }
  const sectInfo = sectData[sectName] ?? {
    level: 0,
    bonusLevel: 0,
    exp: 0,
    maxExp: 8
  };
  const sectOverload = overload_data[sectName] ?? 100;
  const abilityList = Object.keys(KeyValues.AbilityUpgradesKv).filter(v => {
    if (v == "sr") return false;
    const s = KeyValues.AbilityUpgradesKv[v].sect ?? "";
    if (!s.includes(sectName)) {
      return false;
    }
    if (banList.some(v => s.includes(v))) {
      return false;
    }
    return true;
  }).sort((a, b) => {
    const lv_a = tData[a]?.level ?? 0;
    const lv_b = tData[b]?.level ?? 0;
    return multiCompare((lv_a == 0 ? 1 : 0) - (lv_b == 0 ? 1 : 0), GameUI.CustomUIConfig().AbilityUpgradesKv[b].cost - GameUI.CustomUIConfig().AbilityUpgradesKv[a].cost, lv_b - lv_a);
  });
  return libs.createComponent(EOM_Panel.EOM_Panel, {
    className: "PlayerSectTooltipRoot",
    width: "380px",
    flowChildren: "down",
    get children() {
      return [libs.createComponent(EOM_Tooltip.EOM_TooltipHeader, {
        flowChildren: "right",
        get children() {
          return [libs.createComponent(SectIcon.SectIcon, {
            className: "SectImage",
            sectName: sectName
          }), libs.createComponent(EOM_Panel.EOM_Panel, {
            flowChildren: "down",
            marginLeft: "8px",
            get children() {
              return [libs.memo(() => isConcise ? libs.createComponent(GenericPanel.CLabel, {
                id: "SectNameHeader",
                html: true,
                get text() {
                  return $.Localize("#DOTA_Tooltip_ability_" + sectName);
                }
              }) : libs.createComponent(GenericPanel.CLabel, {
                id: "SectNameHeader",
                html: true,
                get text() {
                  return $.Localize("#DOTA_Tooltip_ability_" + sectName) + [...Array(sectInfo.level)].map(() => {
                    return "★";
                  }).join("") + ` (${sectInfo.exp}/${sectInfo.maxExp})`;
                }
              })), libs.createComponent(GenericPanel.CLabel, {
                id: "SectNameDescription",
                html: true,
                get text() {
                  return getAbilityDescription(sectName, Math.max(0, sectInfo.level) + sectInfo.bonusLevel);
                }
              })];
            }
          })];
        }
      }), libs.memo(() => !isConcise && libs.createComponent(EOM_ProgressBar.EOM_ProgressBar, {
        id: "RemainProgress",
        max: 100,
        value: sectOverload,
        get children() {
          return libs.createComponent(EOM_Label.EOM_Label, {
            align: "center center",
            text: "#SectRemaining",
            dialogVariables: {
              value: sectOverload
            }
          });
        }
      })), libs.memo(() => bannedSect == sectName && libs.createComponent(EOM_Panel.EOM_Panel, {
        className: "LoreContainer",
        get children() {
          return libs.createComponent(EOM_Label.EOM_Label, {
            html: true,
            color: "red",
            text: "#Sect_Banned"
          });
        }
      })), libs.memo(() => !isConcise && libs.createComponent(EOM_Panel.EOM_Panel, {
        get className() {
          return libs.classNames("SectList", {
            AltDown: true
          });
        },
        get children() {
          return [libs.memo(() => srCardlist.map((abilityUpgradeID, index) => {
            const abilityUpgradeInfo = GameUI.CustomUIConfig().AbilityUpgradesKv[abilityUpgradeID];
            const iLevel = tData[abilityUpgradeID]?.level ?? 0;
            const rarity = abilityUpgradeInfo.rarity;
            const starCount = abilityUpgradeInfo.MaxLevel ?? 1;
            const isReveal = revealList.includes(abilityUpgradeID);
            return libs.createComponent(EOM_Panel.EOM_Panel, {
              get className() {
                return libs.classNames("SectRow", "Rarity_" + rarity, {
                  NotLearn: iLevel == 0,
                  NotReveal: !isReveal,
                  maxLevel: iLevel == starCount
                });
              },
              flowChildren: "right",
              get children() {
                return libs.createComponent(libs.Show, {
                  when: isReveal,
                  get fallback() {
                    return [libs.createComponent(GenericPanel.CImage, {
                      className: "AbilityImage",
                      src: `file://{images}/spellicons/ringmaster_empty_souvenir.png`
                    }), libs.createComponent(EOM_Panel.EOM_Panel, {
                      flowChildren: "down",
                      marginLeft: "8px",
                      get children() {
                        return [libs.createComponent(EOM_Panel.EOM_Panel, {
                          className: "SectNameContainer",
                          get children() {
                            return libs.createComponent(GenericPanel.CLabel, {
                              get className() {
                                return libs.classNames("SectName", {
                                  Rare: rarity == "r",
                                  SuperRare: rarity == "sr"
                                });
                              },
                              html: true,
                              text: "???"
                            });
                          }
                        }), libs.createComponent(GenericPanel.CLabel, {
                          className: "SectDescription",
                          html: true,
                          text: "#SectReveal_Description"
                        })];
                      }
                    })];
                  },
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
                                        Filled: iLevel >= index + 1
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
                          className: "SectDescription",
                          html: true,
                          get text() {
                            return getSectDescription(abilityUpgradeID, iLevel, true, playerID);
                          }
                        })];
                      }
                    })];
                  }
                });
              }
            });
          })), libs.memo(() => abilityList.map((abilityUpgradeID, index) => {
            const abilityUpgradeInfo = GameUI.CustomUIConfig().AbilityUpgradesKv[abilityUpgradeID];
            if (abilityUpgradeInfo.sect.indexOf(sectName) != -1 && !srCardlist.includes(abilityUpgradeID)) {
              const iLevel = tData[abilityUpgradeID]?.level ?? 0;
              const rarity = abilityUpgradeInfo.rarity;
              const starCount = abilityUpgradeInfo.MaxLevel ?? 1;
              if (iLevel > 0) {
                return libs.createComponent(EOM_Panel.EOM_Panel, {
                  get className() {
                    return libs.classNames("SectRow", "Rarity_" + rarity, {
                      NotLearn: iLevel == 0,
                      maxLevel: iLevel == starCount
                    });
                  },
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
                                        Filled: iLevel >= index + 1
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
                          className: "SectDescription",
                          html: true,
                          get text() {
                            return getSectDescription(abilityUpgradeID, iLevel, true, playerID);
                          }
                        })];
                      }
                    })];
                  }
                });
              }
            }
          }))];
        }
      })), libs.createComponent(EOM_Panel.EOM_Panel, {
        className: "LoreContainer",
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
  });
}
function SetupTooltip() {
  let sectName = pTooltipPanel.GetAttributeString("sectName", "");
  let isConcise = pTooltipPanel.GetAttributeInt("concise", 0) == 1;
  let playerID = pTooltipPanel.GetAttributeInt("player_id", -1);
  let sr_reveal = pTooltipPanel.GetAttributeInt("sr_reveal", 0) == 1;
  libs.render(() => libs.createComponent(TooltipContents, {
    sectName: sectName,
    isConcise: isConcise,
    sr_reveal: sr_reveal,
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
  pTooltipPanel.style.minHeight = "100px";
})();