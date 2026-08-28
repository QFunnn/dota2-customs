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
var GenericPanel = require('./GenericPanel.js');

let pTooltipPanel = $.GetContextPanel();
pTooltipPanel.style.minHeight = "0px";
pTooltipPanel.FindAncestor("card_effect").FindChildTraverse("LeftArrow").style.opacity = "0";
pTooltipPanel.FindAncestor("card_effect").FindChildTraverse("RightArrow").style.opacity = "0";
pTooltipPanel.FindAncestor("card_effect").FindChildTraverse("TopArrow").style.opacity = "0";
pTooltipPanel.FindAncestor("card_effect").FindChildTraverse("BottomArrow").style.opacity = "0";
function TooltipContents(props) {
  let isTeamMode = () => props.team_mode;
  let list = [];
  const reconstructList = {};
  let keyList = [];
  let showList = props.battle_detail || !props.concise;
  let showTitle = !props.battle_detail;
  if (showList) {
    if (props.battle_detail) {
      props.override_list.forEach((v, index) => {
        if (typeof v == "string") {
          list.push(...v.split("|").map(v => ({
            cardName: "card_effect_" + v,
            round: index + 1
          })));
        }
      });
    } else {
      list = Object.values(CustomNetTables.GetTableValue("common", "card_effect_list_" + props.playerID) ?? {});
    }
    list.forEach(data => {
      if (reconstructList[data.cardName] == undefined) {
        reconstructList[data.cardName] = [];
      }
      reconstructList[data.cardName].push(data.round);
    });
    keyList = Object.keys(reconstructList).sort((a, b) => multiCompare(reconstructList[a][reconstructList[a].length - 1] - reconstructList[b][reconstructList[b].length - 1], reconstructList[a].length - reconstructList[b].length));
  }
  let roundCardEffect;
  if (showTitle) {
    const roundNow = CustomNetTables.GetTableValue("common", "round_data")?.round_number ?? -1;
    roundCardEffect = CustomNetTables.GetTableValue("common", "card_effect_" + props.playerID)?.round_record?.[roundNow];
  }
  return libs.createComponent(EOM_Panel.EOM_Panel, {
    style: {
      minWidth: "350px",
      maxHeight: "100%"
    },
    flowChildren: "down",
    get children() {
      return [libs.memo(() => showTitle ? libs.createComponent(EOM_Tooltip.EOM_Tooltip, {
        get className() {
          return libs.classNames("RoundCardEffectContainer", {
            NoneRound: roundCardEffect == undefined
          });
        },
        flowChildren: "down",
        get children() {
          return [libs.createComponent(EOM_Tooltip.EOM_TooltipHeader, {
            get children() {
              const _el$ = libs.createElement("Label", {
                html: true,
                get text() {
                  return isTeamMode() ? "#TeamCardRound" : "#CardEffectRound";
                }
              }, null);
              libs.effect(_$p => libs.setProp(_el$, "text", isTeamMode() ? "#TeamCardRound" : "#CardEffectRound", _$p));
              return _el$;
            }
          }), libs.createComponent(EOM_Panel.EOM_Panel, {
            width: '100%',
            height: 'fit-children',
            padding: '4px 6px',
            get children() {
              return (() => {
                if (roundCardEffect == undefined) {
                  return libs.createComponent(EOM_Label.EOM_Label, {
                    id: "RoundNoneLabel",
                    get text() {
                      return isTeamMode() ? "#TeamCard_RoundNone" : "#CardEffect_RoundNone";
                    }
                  });
                }
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
                  get children() {
                    return [libs.createComponent(GenericPanel.CImage, {
                      className: "AbilityImage"
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
              })();
            }
          })];
        }
      }) : []), libs.memo(() => showList ? libs.createComponent(EOM_Panel.EOM_Panel, {
        id: "CardEffectListContainer",
        "min-width": "350px",
        flowChildren: "down",
        get children() {
          return [libs.createComponent(EOM_Tooltip.EOM_TooltipHeader, {
            id: "CardEffectListTittle",
            get children() {
              return libs.createElement("Label", {
                html: true,
                text: "#TeamCardOverview"
              }, null);
            }
          }), libs.createComponent(libs.Show, {
            get when() {
              return list.length == 0;
            },
            get children() {
              return libs.createComponent(libs.Show, {
                get when() {
                  return isTeamMode();
                },
                get fallback() {
                  return libs.createElement("Label", {
                    id: "NoCardEffect",
                    text: "#NoCardEffect"
                  }, null);
                },
                get children() {
                  return libs.createElement("Label", {
                    id: "NoCardEffect",
                    text: "#NoTeamCard"
                  }, null);
                }
              });
            }
          }), libs.createComponent(EOM_Panel.EOM_Panel, {
            id: "SectRowList",
            flowChildren: "down-wrap",
            onload: self => {
              if (self?.IsValid()) {
                self.actualyoffset;
                const screenHeight = Game.GetScreenHeight();
                $.Schedule(0.1, () => {
                  if (self?.IsValid()) {
                    let parent = self.GetParent();
                    let yOffset = self.actualyoffset;
                    if (parent && parent.IsValid()) {
                      yOffset += parent.actualyoffset;
                    }
                    let value = screenHeight * self.actualuiscale_y - yOffset;
                    if (self.actualuiscale_y >= 1) {
                      value = Math.min(800, value);
                    } else {
                      value = Math.max(800, value);
                    }
                    if (isFinite(value)) {
                      self.style.maxHeight = `${value}px`;
                    }
                  }
                });
              }
            },
            style: {
              minWidth: "350px"
            },
            get children() {
              return libs.createComponent(libs.For, {
                each: keyList,
                children: (cardName, index) => {
                  const infoKeys = () => {
                    let arr = [];
                    const str = $.Localize("#DOTA_Tooltip_ability_" + cardName + "_description");
                    str.replace(/{Info:(\w+?)}/g, (a, b, c) => {
                      arr.push(b);
                    });
                    return arr;
                  };
                  return libs.createComponent(EOM_Panel.EOM_Panel, {
                    className: "SectRow",
                    flowChildren: 'down',
                    get children() {
                      return [libs.createComponent(EOM_Panel.EOM_Panel, {
                        width: "100%",
                        flowChildren: "right",
                        get children() {
                          return [libs.createComponent(GenericPanel.CImage, {
                            className: "AbilityImage"
                          }), libs.createComponent(EOM_Panel.EOM_Panel, {
                            width: "100%",
                            flowChildren: "down",
                            marginLeft: "4px",
                            get children() {
                              return [libs.createComponent(GenericPanel.CLabel, {
                                get className() {
                                  return libs.classNames("SectName");
                                },
                                html: true,
                                text: "#DOTA_Tooltip_ability_" + cardName
                              }), libs.createComponent(GenericPanel.CLabel, {
                                className: "SectDescription",
                                html: true,
                                get text() {
                                  return getCardDescription(cardName);
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
                      }), libs.createComponent(EOM_Panel.EOM_Panel, {
                        flowChildren: 'right',
                        marginTop: '4px',
                        backgroundColor: 'gradient(linear, 0 0, 100% 0, from(#00000088), to(#00000000))',
                        width: '100%',
                        padding: '2px',
                        get children() {
                          return [libs.createComponent(EOM_Label.EOM_Label, {
                            className: "RuneRound",
                            text: "#Round_ButtonCategory"
                          }), libs.createComponent(EOM_Panel.EOM_Panel, {
                            marginLeft: '4px',
                            flowChildren: 'right-wrap',
                            get children() {
                              return libs.createComponent(libs.For, {
                                get each() {
                                  return reconstructList[cardName];
                                },
                                children: (roundNumber, i) => libs.createComponent(GenericPanel.CLabel, {
                                  className: "RuneRoundNumber",
                                  text: roundNumber
                                })
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
          })];
        }
      }) : [])];
    }
  });
}
function SetupTooltip() {
  let playerID = pTooltipPanel.GetAttributeInt("playerID", -1);
  let concise = pTooltipPanel.GetAttributeInt("concise", 0) == 1;
  let team_mode = pTooltipPanel.GetAttributeInt("team_mode", 0) == 1;
  let battle_detail = pTooltipPanel.GetAttributeInt("battle_detail", 0) == 1;
  let rune_list = pTooltipPanel.GetAttributeString("rune_list", "[]");
  let parsedRuneList = [];
  if (battle_detail) {
    parsedRuneList = JSON.parseSafe(rune_list);
    if (!Array.isArray(parsedRuneList)) {
      parsedRuneList = [];
    }
  }
  libs.render(() => libs.createComponent(TooltipContents, {
    playerID: playerID,
    concise: concise,
    team_mode: team_mode,
    battle_detail: battle_detail,
    override_list: parsedRuneList
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
})();