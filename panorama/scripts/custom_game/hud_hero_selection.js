--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 16fdfbc · 2026-08-07 21:47:55 UTC
  ~ auto-generated — do not edit
]]


'use strict'; const require = GameUI.__require;

var libs = require('./libs.js');
var CityDescription = require('./CityDescription.js');
var CityImage = require('./CityImage.js');
var EOM_Panel = require('./EOM_Panel.js');
var EOM_Icon = require('./EOM_Icon.js');
var EOM_Image = require('./EOM_Image.js');
var EOM_Label = require('./EOM_Label.js');
var EOM_Loading = require('./EOM_Loading.js');
var EOM_Portrait = require('./EOM_Portrait.js');
var EOM_Button = require('./EOM_Button.js');
var GenericPanel = require('./GenericPanel.js');
var HeroCard = require('./HeroCard.js');
var Heroes = require('./Heroes.js');
var Player = require('./Player.js');
var RankTierIcon = require('./RankTierIcon.js');
var SectIcon = require('./SectIcon.js');
var TeamSuggestionIcon = require('./TeamSuggestionIcon.js');
var netdata_utils = require('./netdata_utils.js');
var game_utils = require('./game_utils.js');
var rookie_utils = require('./rookie_utils.js');
var HeroProficiencyIcon = require('./HeroProficiencyIcon.js');
require('./TalentTree.js');

function HeroBanList(props) {
  let _tooltipTimer;
  const stage1 = rookie_utils.useRookieV2Effect({
    key: "hero_ban",
    params: {}
  });
  const isSpectator = () => Players.GetLocalPlayer() < 0;
  return [libs.createComponent(EOM_Panel.EOM_Panel, {
    id: "HeroBanList",
    width: "100%",
    marginTop: "15px",
    get opacity() {
      return !props.aiHost() ? "1" : "0";
    },
    hittest: false,
    get children() {
      return [libs.memo(() => libs.memo(() => !!!isSpectator())() && libs.createComponent(EOM_Panel.EOM_Panel, {
        flowChildren: "right",
        horizontalAlign: "center",
        get children() {
          return libs.createComponent(libs.For, {
            get each() {
              return Array(props.heroBanSlotAmounts());
            },
            children: (_, index) => (() => {
              const _el$ = libs.createElement("Panel", {
                "class": "HeroImageButton"
              }, null);
              libs.insert(_el$, libs.createComponent(libs.Show, {
                get when() {
                  return props.banHero()[index()] != undefined;
                },
                get children() {
                  return libs.createComponent(Heroes.HeroImage, {
                    get hero_name() {
                      return props.banHero()[index()];
                    }
                  });
                }
              }));
              return _el$;
            })()
          });
        }
      })), libs.createComponent(EOM_Panel.EOM_Panel, {
        flowChildren: "right-wrap",
        horizontalAlign: "center",
        margin: "0px 100px",
        scroll: "y",
        onload: p => stage1.setRef(p),
        get children() {
          return libs.createComponent(libs.Index, {
            get each() {
              return props.banHeroList();
            },
            children: heroName => {
              const isWeekBan = () => props.sectNoneWeekBan() == heroName();
              const isRandomBan = () => props.sectNoneRandomBan()?.includes(heroName()) ?? false;
              const isDefaultBan = () => props.defaultBanList().includes(heroName());
              let isBanned = () => props.banHero().includes(heroName());
              if (isSpectator()) {
                isBanned = () => props.allBanVote()[heroName()] != undefined;
              }
              return libs.createComponent(EOM_Button.EOM_BaseButton, {
                get ["class"]() {
                  return libs.classNames("HeroImageButton", {
                    isBanned: isDefaultBan() || isBanned() || isWeekBan() || isRandomBan(),
                    isWeekBan: isWeekBan(),
                    isRandomBan: isRandomBan()
                  });
                },
                get enabled() {
                  return !(isWeekBan() || isRandomBan());
                },
                onactivate: () => {
                  if (props.banVote()?.[String(props.localPlayerID)] != undefined) return;
                  if (isWeekBan() || isRandomBan() || isDefaultBan()) return;
                  if (props.banHero().includes(heroName())) {
                    props.setBanHero(props.banHero().filter(v => v != heroName()));
                  } else {
                    props.setBanHero(props.banHero().concat(heroName()).slice(-props.heroBanSlotAmounts()));
                  }
                  if (props.banHero().length >= 4) {
                    if (stage1.state()) {
                      closeRookieV2Tip("hero_ban");
                    }
                  }
                },
                get children() {
                  return [libs.createComponent(Heroes.HeroImage, {
                    get hero_name() {
                      return heroName();
                    },
                    onmouseover: self => {
                      if (_tooltipTimer != undefined) {
                        $.CancelScheduled(_tooltipTimer);
                      }
                      _tooltipTimer = $.Schedule(0.2, () => {
                        _tooltipTimer = undefined;
                        if (self?.IsValid()) {
                          ShowCustomTooltip(self, "hero_detail", {
                            hero_name: heroName()
                          });
                        }
                      });
                    },
                    onmouseout: self => {
                      if (_tooltipTimer) {
                        $.CancelScheduled(_tooltipTimer);
                      }
                      _tooltipTimer = undefined;
                      HideCustomTooltip(self, "hero_detail");
                    }
                  }), libs.createElement("Image", {
                    "class": "Banned",
                    hittest: false
                  }, null), libs.createComponent(libs.Show, {
                    get when() {
                      return isWeekBan();
                    },
                    get children() {
                      return libs.createComponent(EOM_Icon.EOM_Icon, {
                        className: "NoneBanInfoIcon Week",
                        tooltip_text: "#SectWeekBan",
                        get src() {
                          return getSrcPath("eom_design/icon/C4/info.png");
                        }
                      });
                    }
                  }), libs.createComponent(libs.Show, {
                    get when() {
                      return isRandomBan();
                    },
                    get children() {
                      return libs.createComponent(EOM_Icon.EOM_Icon, {
                        className: "NoneBanInfoIcon Random",
                        tooltip_text: "#SectRandomBan",
                        get src() {
                          return getSrcPath("eom_design/icon/C4/info.png");
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
  }), libs.memo(() => {
    if (!isSpectator()) {
      const stage2 = rookie_utils.useRookieV2Effect({
        key: "hero_ban_confirm",
        params: {}
      }, 0.2);
      return libs.createComponent(EOM_Button.EOM_BaseButton, {
        id: "BanButton",
        onactivate: self => {
          if (isSpectator()) return;
          GameEvents.SendCustomEventToServer("ban_hero", {
            heroName: props.banHero()
          });
          self.enabled = false;
          $.Schedule(1, () => {
            if (self.IsValid() && props.banVote()?.[String(props.localPlayerID)] == undefined) {
              self.enabled = true;
            }
          });
          if (stage2.state()) {
            closeRookieV2Tip("hero_ban_confirm");
          }
        },
        onload: self => {
          stage2.setRef(self);
        },
        get children() {
          return libs.createElement("Label", {
            text: "#DOTA_Vote"
          }, null);
        }
      });
    }
  })];
}

function HeroSelectionList(props) {
  const heroStatistic = netdata_utils.createServiceNetTable("hero_statisitcs");
  const stage3 = rookie_utils.useRookieV2Effect({
    key: "hero_selection",
    params: {
      tooltip_position: "top"
    }
  });
  const recommendSlot = libs.createMemo(() => {
    let slot = "";
    if (props.recommendHeroName()) {
      slot = Object.entries(props.heroSelectionDataNew).find(v => v[1].hero_name == props.recommendHeroName())?.[0] ?? "";
    }
    if (slot == "") {
      slot = props.localHeroSlotList()[Round(Math.random() * (props.localHeroSlotList().length - 1))];
    }
    return slot;
  });
  return libs.createComponent(EOM_Panel.EOM_Panel, {
    flowChildren: "right",
    horizontalAlign: "center",
    hittest: false,
    get children() {
      return libs.createComponent(libs.Show, {
        get when() {
          return props.localHeroSlotList().length > 0;
        },
        get children() {
          return libs.createComponent(libs.Index, {
            get each() {
              return props.localHeroSlotList();
            },
            children: (slot, index) => {
              const selectionData = () => props.heroSelectionDataNew[slot()];
              const vipEnable = () => index >= 3 ? selectionData().type != "locked" : true;
              const hid = libs.createMemo(() => GetGoodIDByHeroName(selectionData().hero_name) ?? 0);
              const proficiency_level = () => props.hero_medal_level()?.[hid()] ?? 0;
              const [rookie, setRookie] = libs.createSignal(false);
              libs.createEffect(libs.on(selectionData, () => {
                setRookie(selectionData().hero_name == props.recommendHeroName());
              }));
              const statisticInfo = () => heroStatistic()?.[hid().toString()];
              const refreshing = () => props.refreshingSlotList[slot()] != undefined;
              const vipFreeRefreshAmounts = () => selectionData().vip_free;
              const allfreeRefreshAmounts = () => selectionData().all_free;
              const freeRefreshAmounts = () => vipFreeRefreshAmounts() + allfreeRefreshAmounts();
              const refreshButtonInfo = () => {
                if (allfreeRefreshAmounts() > 0) {
                  let button_text = $.Localize("#FreeRefresh");
                  if (allfreeRefreshAmounts() > 1) {
                    button_text += `(${allfreeRefreshAmounts()})`;
                  }
                  return {
                    button: button_text,
                    tooltip: $.Localize("#HeroSelectionFreeRefresh_tips")
                  };
                }
                if (vipFreeRefreshAmounts() > 0) {
                  let button_text = $.Localize("#VipRefresh");
                  if (vipFreeRefreshAmounts() > 1) {
                    button_text += `(${vipFreeRefreshAmounts()})`;
                  }
                  return {
                    button: button_text,
                    tooltip: $.Localize("#HeroSelectionVipRefresh_tips")
                  };
                }
                return {
                  button: $.Localize("#Refresh"),
                  tooltip: $.Localize("#HeroSelectionRefresh_tips")
                };
              };
              return libs.createComponent(EOM_Panel.EOM_Panel, {
                className: "HeroCardSelectContainer",
                hittest: false,
                get children() {
                  return [libs.createComponent(libs.Show, {
                    get when() {
                      return props.bpPlus();
                    },
                    get children() {
                      return libs.createComponent(libs.Show, {
                        get when() {
                          return statisticInfo() != undefined;
                        },
                        get fallback() {
                          return libs.createComponent(EOM_Panel.EOM_Panel, {
                            get className() {
                              return libs.classNames("HeroStatisticInfo");
                            },
                            hittest: false,
                            hittestchildren: false,
                            get children() {
                              return libs.createComponent(EOM_Label.EOM_Label, {
                                id: "HeroStatisticNilDataLabel",
                                text: "#HeroStatistic_NilData"
                              });
                            }
                          });
                        },
                        get children() {
                          return libs.createComponent(EOM_Panel.EOM_Panel, {
                            get className() {
                              return libs.classNames("HeroStatisticInfo", "Tier" + statisticInfo().win_tier);
                            },
                            hittest: false,
                            get children() {
                              return [libs.createComponent(EOM_Image.EOM_Image, {
                                get className() {
                                  return libs.classNames("SeasonHeightIcon");
                                },
                                tooltip_text: "#Ladder_HeroDetail"
                              }), libs.createComponent(EOM_Image.EOM_Image, {
                                id: "HeroStatisticTierImage",
                                hittest: false
                              }), libs.createComponent(EOM_Panel.EOM_Panel, {
                                id: "HeroStatisticInfoEntry",
                                hittest: false,
                                hittestchildren: false,
                                get children() {
                                  return [libs.createComponent(EOM_Label.EOM_Label, {
                                    id: "HeroStatisticAvgRank",
                                    text: "#HeroStatistic_AvgRank",
                                    get dialogVariables() {
                                      return {
                                        value: Round(statisticInfo().avg_ranking, 1).toString()
                                      };
                                    },
                                    html: true
                                  }), libs.createComponent(EOM_Label.EOM_Label, {
                                    id: "HeroStatisticPickRate",
                                    text: "#HeroStatistic_PickRate",
                                    get dialogVariables() {
                                      return {
                                        value: Round(statisticInfo().pick_rate * 100, 1).toString()
                                      };
                                    },
                                    html: true
                                  })];
                                }
                              })];
                            }
                          });
                        }
                      });
                    }
                  }), libs.createComponent(EOM_Button.EOM_BaseButton, {
                    get className() {
                      return libs.classNames("HeroCardSelect", {
                        Refreshing: refreshing()
                      });
                    },
                    get enabled() {
                      return libs.memo(() => !!isCompetitionMode())() ? true : vipEnable();
                    },
                    onactivate: () => {
                      if (refreshing()) return;
                      props.onPickHero(selectionData().slot.toString());
                      if (stage3.state()) {
                        closeRookieV2Tip("hero_selection");
                      }
                    },
                    onload: self => {
                      if (recommendSlot() == slot()) {
                        stage3.setRef(self);
                      }
                    },
                    get children() {
                      return [libs.createComponent(HeroCard.HeroCard, {
                        align: "center center",
                        get heroName() {
                          return selectionData().hero_name;
                        },
                        get skinID() {
                          return props.getHeroSkinID(selectionData().hero_name);
                        },
                        showCollection: true,
                        showAbilityTooltip: false,
                        get customTooltip() {
                          return {
                            name: "hero_detail",
                            hero_name: selectionData().hero_name,
                            skin_id: props.getHeroSkinID(selectionData().hero_name) ?? ""
                          };
                        }
                      }), libs.createComponent(HeroProficiencyIcon.HeroProficiencyIcon, {
                        className: "Proficiency",
                        size: "small",
                        get override_level() {
                          return proficiency_level();
                        },
                        hittest: false
                      }), libs.createComponent(libs.Show, {
                        get when() {
                          return !refreshing();
                        },
                        get children() {
                          return [libs.createComponent(libs.Show, {
                            get when() {
                              return libs.memo(() => !!!vipEnable())() && !isCompetitionMode();
                            },
                            get children() {
                              return libs.createComponent(EOM_Panel.EOM_Panel, {
                                className: "VipLabel",
                                hittest: false,
                                hittestchildren: false,
                                get children() {
                                  return libs.createComponent(EOM_Label.EOM_Label, {
                                    text: "#HeroSelection_VIP"
                                  });
                                }
                              });
                            }
                          }), libs.createComponent(libs.Show, {
                            get when() {
                              return libs.memo(() => !!(index >= 3 && !isCompetitionMode()))() && !isGroupMode();
                            },
                            get children() {
                              return libs.createComponent(EOM_Icon.EOM_Icon, {
                                className: "VipIcon",
                                width: "86px",
                                height: "86px",
                                get src() {
                                  return getSrcPath("icon/vip_icon.png");
                                },
                                hittest: false
                              });
                            }
                          })];
                        }
                      }), libs.createComponent(EOM_Panel.EOM_Panel, {
                        id: "HeroCardRefreshMask",
                        hittest: false,
                        hittestchildren: false,
                        get children() {
                          return libs.createComponent(EOM_Panel.EOM_Panel, {
                            align: "center center",
                            flowChildren: "down",
                            get children() {
                              return [libs.createComponent(EOM_Loading.EOM_Loading, {
                                horizontalAlign: "center",
                                type: "Wave"
                              }), libs.createComponent(EOM_Label.EOM_Label, {
                                color: "white",
                                marginTop: "4px",
                                horizontalAlign: "center",
                                text: "#C4_Loading"
                              })];
                            }
                          });
                        }
                      }), libs.createComponent(libs.Show, {
                        get when() {
                          return props.selectHero() == selectionData().hero_name;
                        },
                        get children() {
                          return libs.createElement("Image", {
                            "class": "HeroSelect",
                            hittest: false
                          }, null);
                        }
                      }), libs.createComponent(libs.Show, {
                        get when() {
                          return isGroupMode();
                        },
                        fallback: () => {
                          libs.createComponent(libs.Show, {
                            get when() {
                              return rookie();
                            },
                            get children() {
                              return libs.createElement("Image", {
                                id: "Rookie",
                                hittest: false
                              }, null);
                            }
                          });
                        },
                        get children() {
                          return libs.createComponent(libs.Show, {
                            get when() {
                              return props.heroTeamSuggestion == selectionData().hero_name;
                            },
                            get children() {
                              return libs.createComponent(TeamSuggestionIcon.TeamSuggestionIcon, {
                                get show() {
                                  return props.heroTeamSuggestion == selectionData().hero_name;
                                }
                              });
                            }
                          });
                        }
                      })];
                    }
                  }), libs.createComponent(libs.Show, {
                    get when() {
                      return !isCompetitionMode() || freeRefreshAmounts() > 0;
                    },
                    get children() {
                      return libs.createComponent(EOM_Button.EOM_BaseButton, {
                        get className() {
                          return libs.classNames("HeroCardSelectRefreshButton", {
                            FreeRefresh: allfreeRefreshAmounts() > 0,
                            VipRefresh: allfreeRefreshAmounts() == 0 && vipFreeRefreshAmounts() > 0
                          });
                        },
                        get enabled() {
                          return libs.memo(() => !!(selectionData().type != "locked" && (freeRefreshAmounts() > 0 || props.refreshIconEnough())))() && !refreshing();
                        },
                        onactivate: () => {
                          if (!((freeRefreshAmounts() > 0 || props.refreshIconEnough()) && !refreshing())) return;
                          props.onRefreshSlot(slot());
                        },
                        get tooltip_text() {
                          return refreshButtonInfo().tooltip;
                        },
                        get children() {
                          return [libs.createComponent(EOM_Panel.EOM_Panel, {
                            get visible() {
                              return !props.isHeroPunishment();
                            },
                            id: "HeroCardSelectRefreshButtonMain",
                            get children() {
                              return [libs.createComponent(EOM_Label.EOM_Label, {
                                id: "HeroCardSelectRefreshLabel",
                                get text() {
                                  return refreshButtonInfo().button;
                                }
                              }), libs.createComponent(EOM_Panel.EOM_Panel, {
                                id: "RefreshCoinAmounts",
                                hittest: false,
                                get children() {
                                  return [libs.createComponent(EOM_Icon.EOM_Icon, {
                                    className: "RefreshCoinIcon",
                                    get src() {
                                      return getTokenSrcPath(1100097);
                                    },
                                    hittest: false
                                  }), libs.createComponent(EOM_Label.EOM_Label, {
                                    text: `x${1}`,
                                    hittest: false
                                  })];
                                }
                              })];
                            }
                          }), libs.createComponent(libs.Show, {
                            get when() {
                              return libs.memo(() => allfreeRefreshAmounts() == 0)() && vipFreeRefreshAmounts() > 0;
                            },
                            get children() {
                              return libs.createComponent(EOM_Icon.EOM_Icon, {
                                className: "RefreshVipIcon",
                                size: "32",
                                get src() {
                                  return getSrcPath("icon/vip_icon_smallest.png");
                                },
                                hittest: false
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
          });
        }
      });
    }
  });
}

function PlayerInfoBar(props) {
  const isSpectator = () => Players.GetLocalPlayer() < 0;
  return libs.createComponent(EOM_Panel.EOM_Panel, {
    align: "center bottom",
    flowChildren: "right",
    hittest: false,
    get children() {
      return libs.createComponent(libs.Show, {
        get when() {
          return props.gameState() == "GameState_HeroBan" || !isSpectator();
        },
        get children() {
          return libs.createComponent(libs.Show, {
            get when() {
              return isGroupMode();
            },
            get fallback() {
              return libs.createComponent(libs.Index, {
                get each() {
                  return props.playerInfoList();
                },
                children: (effectPair, index) => {
                  const playerInfo = () => effectPair()?.[0];
                  const playerID = () => playerInfo().playerID;
                  const check = () => {
                    if (props.gameState() == "GameState_HeroBan") {
                      return props.banVote()?.[String(playerID())] != undefined;
                    } else {
                      return playerInfo().heroName != undefined;
                    }
                  };
                  return libs.createComponent(EOM_Panel.EOM_Panel, {
                    get className() {
                      return libs.classNames("PlayerInfo");
                    },
                    flowChildren: "down",
                    width: "150px",
                    height: "240px",
                    hittest: false,
                    get children() {
                      return [libs.createComponent(libs.Show, {
                        get when() {
                          return libs.memo(() => playerInfo().rankAlarm < 1)() && playerID() == Players.GetLocalPlayer();
                        },
                        get fallback() {
                          return libs.createComponent(EOM_Image.EOM_Image, {
                            "class": "Blank",
                            hittest: false
                          });
                        },
                        get children() {
                          const _el$ = libs.createElement("Image", {
                            "class": "Alarm",
                            get dialogVariables() {
                              return {
                                value: (1 - playerInfo().rankAlarm) * 100
                              };
                            }
                          }, null);
                          libs.setProp(_el$, "tooltip_text", "#RankAlarm");
                          libs.effect(_$p => libs.setProp(_el$, "dialogVariables", {
                            value: (1 - playerInfo().rankAlarm) * 100
                          }, _$p));
                          return _el$;
                        }
                      }), libs.createComponent(Player.PlayerName, {
                        id: "PlayerName",
                        get steamID() {
                          return playerInfo().steamID;
                        },
                        get playerID() {
                          return playerID();
                        },
                        get ban() {
                          return isNameBan(playerID());
                        }
                      }), libs.createComponent(Player.PlayerAvatar, {
                        id: "PlayerAvatar",
                        get steamID() {
                          return playerInfo().steamID;
                        },
                        get playerID() {
                          return playerID();
                        },
                        get customTooltip() {
                          return {
                            name: "player_profile",
                            playerID: playerID(),
                            steamID: playerInfo().steamID
                          };
                        }
                      }), libs.createComponent(EOM_Panel.EOM_Panel, {
                        className: "CheckAndWave",
                        hittest: false,
                        hittestchildren: false,
                        get children() {
                          return libs.createComponent(libs.Show, {
                            get when() {
                              return check();
                            },
                            get fallback() {
                              return libs.createComponent(EOM_Loading.EOM_Loading, {
                                type: "Wave"
                              });
                            },
                            get children() {
                              return libs.createComponent(EOM_Image.EOM_Image, {
                                className: "Check",
                                get backgroundImage() {
                                  return getImagePath("icon/icon_party_ready_psd.png");
                                },
                                width: "35px",
                                height: "34px"
                              });
                            }
                          });
                        }
                      }), libs.memo(() => libs.memo(() => !!(props.rankMode || props.isKingsRankMode))() && libs.createComponent(RankTierIcon.RankTierIcon, {
                        player_id: index,
                        size: "64",
                        showtooltip: true
                      }))];
                    }
                  });
                }
              });
            },
            get children() {
              return (() => {
                const sortedList = () => props.playerInfoList().sort((a, b) => (a[0].groupIndex ?? -1) - (b[0].groupIndex ?? -1));
                return libs.createComponent(libs.Index, {
                  get each() {
                    return sortedList();
                  },
                  children: (effectPair, index) => {
                    const playerInfo = () => effectPair()?.[0];
                    const playerID = () => playerInfo().playerID;
                    const check = () => {
                      if (props.gameState() == "GameState_HeroBan") {
                        return props.banVote()?.[String(playerID())] != undefined;
                      } else {
                        return playerInfo().heroName != undefined;
                      }
                    };
                    return libs.createComponent(EOM_Panel.EOM_Panel, {
                      get className() {
                        return libs.classNames("PlayerInfo", "TeamMode", "TeamPosition_" + (index % 2 == 0 ? "Left" : "Right"));
                      },
                      hittest: false,
                      get children() {
                        return [libs.createComponent(libs.Show, {
                          get when() {
                            return libs.memo(() => playerInfo().rankAlarm < 1)() && playerID() == Players.GetLocalPlayer();
                          },
                          get fallback() {
                            return libs.createComponent(EOM_Image.EOM_Image, {
                              "class": "Blank",
                              hittest: false
                            });
                          },
                          get children() {
                            const _el$2 = libs.createElement("Image", {
                              "class": "Alarm",
                              get dialogVariables() {
                                return {
                                  value: (1 - playerInfo().rankAlarm) * 100
                                };
                              }
                            }, null);
                            libs.setProp(_el$2, "tooltip_text", "#RankAlarm");
                            libs.effect(_$p => libs.setProp(_el$2, "dialogVariables", {
                              value: (1 - playerInfo().rankAlarm) * 100
                            }, _$p));
                            return _el$2;
                          }
                        }), libs.createComponent(Player.PlayerName, {
                          id: "PlayerName",
                          get steamID() {
                            return playerInfo().steamID;
                          },
                          get playerID() {
                            return playerID();
                          },
                          get ban() {
                            return isNameBan(playerID());
                          }
                        }), libs.createComponent(Player.PlayerAvatar, {
                          id: "PlayerAvatar",
                          get steamID() {
                            return playerInfo().steamID;
                          },
                          get playerID() {
                            return playerID();
                          },
                          get customTooltip() {
                            return {
                              name: "player_profile",
                              playerID: playerID(),
                              steamID: playerInfo().steamID
                            };
                          }
                        }), libs.createComponent(EOM_Panel.EOM_Panel, {
                          className: "CheckAndWave",
                          hittest: false,
                          hittestchildren: false,
                          get children() {
                            return libs.createComponent(libs.Show, {
                              get when() {
                                return check();
                              },
                              get fallback() {
                                return libs.createComponent(EOM_Loading.EOM_Loading, {
                                  type: "Wave"
                                });
                              },
                              get children() {
                                return libs.createComponent(EOM_Image.EOM_Image, {
                                  className: "Check",
                                  get backgroundImage() {
                                    return getImagePath("icon/icon_party_ready_psd.png");
                                  },
                                  width: "35px",
                                  height: "34px"
                                });
                              }
                            });
                          }
                        }), libs.memo(() => libs.memo(() => !!(props.rankMode || props.isKingsRankMode))() && libs.createComponent(RankTierIcon.RankTierIcon, {
                          player_id: index,
                          size: "64",
                          showtooltip: true
                        }))];
                      }
                    });
                  }
                });
              })();
            }
          });
        }
      });
    }
  });
}

function useHeroBan() {
  const [banHero, setBanHero] = libs.createSignal([]);
  const [banHeroResult, setBanHeroResult] = libs.createSignal([]);
  const [banVote, setBanVote] = libs.createSignal({});
  const [sectNoneWeekBan, setSectNoneWeekBan] = libs.createSignal();
  const [sectNoneRandomBan, setSectNoneRandomBan] = libs.createSignal();
  const [defaultBanList, setDefaultBanList] = libs.createSignal([]);
  const [banHeroList, setBanHeroList] = libs.createSignal([]);
  const [heroBanSlotAmounts, setHeroBanSlotAmounts] = libs.createSignal(3);
  libs.onMount(() => {
    const idList = [];
    idList.push(useNetTableKeyHasDefaultValue("common", "constant", v => {
      setDefaultBanList(Object.values(v?.DEFAULT_BANNED_HEROES ?? []));
      if (v && typeof v.HERO_BAN_SLOT_AMOUNTS == "number") {
        setHeroBanSlotAmounts(v.HERO_BAN_SLOT_AMOUNTS);
      }
    }));
    idList.push(useNetTableKeyHasDefaultValue("common", "hero_ban_list", data => {
      setBanHeroResult(Object.values(data));
    }));
    idList.push(useNetTableKeyHasDefaultValue("common", "ban_vote", data => {
      setBanVote(data);
    }));
    idList.push(useNetTableKeyHasDefaultValue("common", "sect_none_ban", data => {
      setSectNoneWeekBan(data.week);
      let random = Object.values(data?.random ?? []);
      if (random.length > 0) {
        setSectNoneRandomBan(random);
      } else {
        setSectNoneRandomBan();
      }
    }));
    netdata_utils.createNetTableEffect("common", "match_hero_list", v => {
      let keys = Object.keys(KeyValues.UnitsCommonKv);
      setBanHeroList(Object.values(v ?? {}).sort((a, b) => keys.indexOf(a) - keys.indexOf(b)));
    });
    libs.onCleanup(() => {
      idList.forEach(id => CustomNetTables.UnsubscribeNetTableListener(id));
    });
  });
  return {
    banHero,
    setBanHero,
    banHeroResult,
    banVote,
    sectNoneWeekBan,
    sectNoneRandomBan,
    defaultBanList,
    banHeroList,
    heroBanSlotAmounts
  };
}

function useHeroSelection(localPlayerID, customMatchType) {
  let recordRefreshState;
  const [localSelectedHero, setLocalSelectedHero] = libs.createSignal();
  const [localReady, setLocalReady] = libs.createSignal(false);
  const localSelected = () => localSelectedHero() != undefined;
  const [heroSelectionDataNew, setHeroSelectionDataNew] = libs.createStore({});
  const [heroSelectionSortStr, setHeroSelectionSortStr] = libs.createStore({
    normal: [],
    collection: []
  });
  const [heroSelectionOperate, setHeroSelectionOperate] = libs.createSignal("");
  const [teammatePlayerID, setTeammatePlayerID] = libs.createSignal(undefined);
  const [teammateSelectedHero, setTeammateSelectedHero] = libs.createSignal(undefined);
  const [teammateReady, setTeammateReady] = libs.createSignal(false);
  const [teammateHeroSelectionData, setTeammateHeroSelectionData] = libs.createStore({});
  const teammateHeroSlotList = libs.createMemo(() => Object.keys(teammateHeroSelectionData));
  let refreshIconInited = false;
  const [refreshIconAmounts, setRefreshIconAmounts] = libs.createSignal(0);
  let defaultUseRefreshIcon = 0;
  const refreshIconEnough = () => !isCompetitionMode() && refreshIconAmounts() > 0;
  const [refreshingSlotList, setRefreshingSlotList] = libs.createStore({});
  const early_exit_count_data = netdata_utils.createPlayerNetData("remaining_early_exit_count", localPlayerID, {
    remaining_early_exit_count: 0
  });
  const isHeroPunishment = () => {
    if (customMatchType() == 5 || customMatchType() == 9) {
      return (early_exit_count_data()?.remaining_early_exit_count ?? 0) > 0;
    }
    return false;
  };
  libs.onMount(() => {
    if (isGroupMode()) {
      netdata_utils.createNetTableEffect("player_data", localPlayerID.toString(), data => {
        const teammates = Object.values(data?.teammates ?? {});
        const teammate = teammates.find(id => id !== localPlayerID);
        setTeammatePlayerID(teammate);
      });
    }
    libs.createEffect(() => {
      const teammate = teammatePlayerID();
      if (teammate !== undefined) {
        netdata_utils.createNetTableEffect("common", "hero_selection_" + teammate, data => {
          libs.batch(() => {
            setTeammateSelectedHero(data.selected_hero);
            setTeammateReady(data.ready == 1);
            if (data.operate != "") {
              let copy_data = {};
              Object.values(data.slot_data).forEach(v => {
                copy_data[v.slot.toString()] = Object.assign({}, v);
              });
              if (data.sort) {
                let normal = Object.values(data.sort.normal);
                let collection = Object.values(data.sort.collection);
                data.operate.split("|").forEach(single => {
                  if (copy_data[single]) {
                    let list = normal;
                    if (copy_data[single].type == "collection") {
                      list = collection;
                    }
                    if (list.length > 0) {
                      copy_data[single].hero_name = list[0];
                      normal = normal.filter(v => v != copy_data[single].hero_name);
                      collection = collection.filter(v => v != copy_data[single].hero_name);
                    }
                  }
                });
                Object.values(copy_data).forEach(v => {
                  setTeammateHeroSelectionData(v.slot.toString(), v);
                });
              }
            } else {
              Object.values(data.slot_data).forEach(v => {
                setTeammateHeroSelectionData(v.slot.toString(), v);
              });
            }
          });
        });
      }
    });
    useNetData("player_props_amounts", v => {
      if (refreshIconInited) return;
      if (v?.[9310017] != undefined) {
        refreshIconInited = true;
        setRefreshIconAmounts(Math.max(0, v[9310017] - defaultUseRefreshIcon));
      } else {
        setRefreshIconAmounts(0);
      }
    }, localPlayerID);
    netdata_utils.createNetTableEffect("common", "hero_selection_" + localPlayerID, data => {
      libs.batch(() => {
        setLocalSelectedHero(data.selected_hero);
        setLocalReady(data.ready == 1);
        if (data.refresh != undefined && recordRefreshState != data.refresh) {
          let used_icon = data.icon_amounts ?? 0;
          if (data.operate != "") {
            let copy_data = {};
            Object.values(data.slot_data).forEach(v => {
              copy_data[v.slot.toString()] = Object.assign({}, v);
            });
            if (data.sort) {
              let normal = Object.values(data.sort.normal);
              let collection = Object.values(data.sort.collection);
              let new_operate = "";
              data.operate.split("|").forEach(single => {
                if (copy_data[single]) {
                  if (copy_data[single].all_free > 0) {
                    copy_data[single].all_free--;
                  } else if (copy_data[single].vip_free > 0) {
                    copy_data[single].vip_free--;
                  } else {
                    used_icon++;
                  }
                  let list = normal;
                  if (copy_data[single].type == "collection") {
                    list = collection;
                  }
                  if (list.length == 0) {
                    Object.values(refreshingSlotList).forEach(v => {
                      if (v.timer != undefined) {
                        $.CancelScheduled(v.timer);
                      }
                    });
                    Object.values(heroSelectionDataNew).forEach(v => {
                      let _slot = v.slot.toString();
                      setRefreshingSlotList(_slot, {
                        state: true,
                        timer: $.Schedule(3, () => {
                          setRefreshingSlotList(_slot, undefined);
                        })
                      });
                    });
                    GameEvents.SendCustomEventToServer("select_hero", {
                      heroName: "refresh",
                      operate_record: new_operate
                    });
                    return;
                  }
                  if (new_operate == "") {
                    new_operate += single;
                  } else {
                    new_operate += "|" + single;
                  }
                  copy_data[single].hero_name = list[0];
                  normal = normal.filter(v => v != copy_data[single].hero_name);
                  collection = collection.filter(v => v != copy_data[single].hero_name);
                }
              });
              Object.values(copy_data).forEach(v => {
                setHeroSelectionDataNew(v.slot.toString(), v);
              });
              setHeroSelectionSortStr({
                normal,
                collection
              });
            } else {
              setHeroSelectionSortStr({
                normal: [],
                collection: []
              });
            }
          } else {
            Object.values(data.slot_data).forEach(v => {
              setHeroSelectionDataNew(v.slot.toString(), v);
            });
            if (data.sort) {
              setHeroSelectionSortStr({
                normal: Object.values(data.sort.normal),
                collection: Object.values(data.sort.collection)
              });
            } else {
              setHeroSelectionSortStr({
                normal: [],
                collection: []
              });
            }
          }
          defaultUseRefreshIcon = used_icon;
          const _data = getNetDataCache("player_props_amounts", localPlayerID);
          if (_data) {
            if (_data?.[9310017] != undefined) {
              setRefreshIconAmounts(Math.max(0, _data[9310017] - defaultUseRefreshIcon));
            } else {
              setRefreshIconAmounts(0);
            }
          } else {
            setRefreshIconAmounts(0);
          }
          setHeroSelectionOperate(data.operate);
          Object.entries(refreshingSlotList).forEach(([key, v]) => {
            if (v.timer != undefined) {
              $.CancelScheduled(v.timer);
            }
            setRefreshingSlotList(key, undefined);
          });
          recordRefreshState = data.refresh;
        }
      });
    });
  });
  const localHeroSlotList = libs.createMemo(() => Object.keys(heroSelectionDataNew));
  const onRefreshSlot = slot => {
    if (isHeroPunishment()) return;
    if (!heroSelectionDataNew[slot]) return;
    if (refreshingSlotList[slot]) return;
    const data = heroSelectionDataNew[slot];
    if (data.type == "locked") return;
    libs.batch(() => {
      if (data.all_free > 0) {
        setHeroSelectionDataNew(slot, v => ({
          ...v,
          all_free: v.all_free - 1
        }));
      } else if (data.vip_free > 0) {
        setHeroSelectionDataNew(slot, v => ({
          ...v,
          vip_free: v.vip_free - 1
        }));
      } else if (refreshIconEnough()) {
        setRefreshIconAmounts(v => v - 1);
      } else {
        return;
      }
      let list = heroSelectionSortStr.normal;
      if (data.type == "collection") {
        list = heroSelectionSortStr.collection;
      }
      let new_operate = heroSelectionOperate();
      if (new_operate == "") {
        new_operate += slot;
      } else {
        new_operate += "|" + slot;
      }
      if (list.length == 0) {
        Object.values(refreshingSlotList).forEach(v => {
          if (v.timer != undefined) {
            $.CancelScheduled(v.timer);
          }
        });
        Object.values(heroSelectionDataNew).forEach(v => {
          let _slot = v.slot.toString();
          setRefreshingSlotList(_slot, {
            state: true,
            timer: $.Schedule(3, () => {
              setRefreshingSlotList(_slot, undefined);
            })
          });
        });
        GameEvents.SendCustomEventToServer("select_hero", {
          heroName: "refresh",
          operate_record: new_operate
        });
        return;
      }
      setRefreshingSlotList(slot, {
        state: true,
        timer: $.Schedule(0.1, () => {
          setRefreshingSlotList(slot, undefined);
        })
      });
      let hero_name = list[0];
      setHeroSelectionDataNew(slot, v => ({
        ...v,
        hero_name
      }));
      setHeroSelectionSortStr("normal", arr => arr.filter(el => el != hero_name));
      setHeroSelectionSortStr("collection", arr => arr.filter(el => el != hero_name));
      setHeroSelectionOperate(new_operate);
      GameEvents.SendCustomEventToServer("select_hero_operate", {
        operate: new_operate
      });
    });
  };
  const onRandomHero = () => {
    if (isHeroPunishment()) return;
    GameEvents.SendCustomEventToServer("select_hero", {
      heroName: "random",
      operate_record: heroSelectionOperate()
    });
  };
  const onPickHero = slot => {
    if (!heroSelectionDataNew[slot]) return;
    if (heroSelectionDataNew[slot].type == "locked") return;
    GameEvents.SendCustomEventToServer("select_hero", {
      heroName: heroSelectionDataNew[slot].hero_name,
      operate_record: heroSelectionOperate()
    });
  };
  return {
    localSelectedHero,
    localSelected,
    localReady,
    heroSelectionDataNew,
    heroSelectionSortStr,
    localHeroSlotList,
    refreshIconAmounts,
    refreshIconEnough,
    refreshingSlotList,
    setRefreshingSlotList,
    isHeroPunishment,
    onRefreshSlot,
    onRandomHero,
    onPickHero,
    teammatePlayerID,
    teammateHeroSelectionData,
    teammateHeroSlotList,
    teammateSelectedHero,
    teammateReady
  };
}

let notice$1 = true;
function usePlayerInfo(localPlayerID) {
  const getInitPlayerInfo = playerID => {
    const playerData = getPlayerData(playerID);
    if (playerData != undefined) {
      if (playerData.rankAlarm < 1 && playerID == Players.GetLocalPlayer() && notice$1) {
        notice$1 = false;
        showPopup("RankNotice", {
          PopupID: "RankNotice",
          rankAlarm: playerData?.rankAlarm
        });
      }
      return libs.createStore({
        heroName: playerData.heroName,
        trait: playerData.trait,
        steamID: playerData.steamID,
        rankAlarm: playerData.rankAlarm,
        rankWarningCount: playerData.rankWarningCount,
        playerID: playerID,
        groupIndex: playerData.groupIndex
      });
    }
  };
  const heroTeamSuggestion = game_utils.CreateTeammateSuggestActionSignal(TeamSuggestAction.HeroSelection, 30);
  const [playerInfosNew, setPlayerInfosNew] = libs.createSignal((() => {
    const data = {};
    const playerData = CustomNetTables.GetAllTableValues("player_data");
    Object.values(playerData).forEach(v => {
      let effectPair = getInitPlayerInfo(Number(v.key));
      if (effectPair) {
        data[Number(v.key)] = effectPair;
      }
    });
    return data;
  })());
  const [selectHero, setSelectHero] = libs.createSignal();
  const [aiHost, setAIHost] = libs.createSignal(false);
  libs.onMount(() => {
    const idList = [];
    idList.push(CustomNetTables.SubscribeNetTableListener("player_data", (tableName, key, data) => {
      if (data && Number(key) != undefined) {
        const playerID = Number(key);
        const effectPair = playerInfosNew()[playerID];
        if (effectPair == undefined) {
          let data = getInitPlayerInfo(Number(key));
          if (data) {
            setPlayerInfosNew(v => Object.assign({
              [playerID]: data
            }, v));
          }
        } else {
          effectPair[1]("heroName", data?.heroName);
          effectPair[1]("steamID", data.steamID);
          effectPair[1]("trait", data.trait);
          effectPair[1]("rankAlarm", data.rankAlarm);
          effectPair[1]("rankWarningCount", data.rankWarningCount);
          effectPair[1]("playerID", Number(key));
        }
      }
      if (Number(key) == localPlayerID) {
        if (data?.heroName != undefined) {
          setSelectHero(data.heroName);
        }
        setAIHost(data.ai_host == 1);
        if (data?.rankAlarm < 1 && notice$1) {
          notice$1 = false;
          showPopup("RankNotice", {
            PopupID: "RankNotice",
            rankAlarm: data?.rankAlarm
          });
        }
      }
    }));
    libs.onCleanup(() => {
      idList.forEach(id => CustomNetTables.UnsubscribeNetTableListener(id));
    });
  });
  const playerInfoList = () => Object.values(playerInfosNew());
  const selfPlayerInfo = libs.createMemo(() => playerInfosNew()[Players.GetLocalPlayer()]?.[0]);
  return {
    playerInfosNew,
    playerInfoList,
    selfPlayerInfo,
    selectHero,
    aiHost,
    heroTeamSuggestion
  };
}

$.GetContextPanel().AddClass("CosmeticPreviewLiveHidden");
let notice = true;
const language = $.Language().toLowerCase();
const HeroSelection = () => {
  const [game_state, setGameState] = libs.createSignal(getGameState());
  const [localHeroName, setLocalHeroName] = libs.createSignal();
  const [banListNet, _setBanListNet] = libs.createSignal(CustomNetTables.GetTableValue("common", "ban_list"));
  const banList = () => Object.values(banListNet() ?? {});
  const pickList = () => Object.keys(GameUI.CustomUIConfig().SectAbilitiesKv).filter(sectName => !banList().includes(sectName));
  libs.onMount(() => {
    const idList = [];
    const eventList = [];
    idList.push(useNetTableKey("common", "game_state", data => {
      setGameState(data.state);
    }));
    idList.push(useNetTableKeyHasDefaultValue("player_data", Players.GetLocalPlayer().toString(), data => {
      setLocalHeroName(data?.heroName);
    }));
    libs.onCleanup(() => {
      idList.forEach(id => {
        CustomNetTables.UnsubscribeNetTableListener(id);
      });
      eventList.forEach(id => GameEvents.Unsubscribe(id));
    });
  });
  const rankMode = isRankMode();
  const modeName = () => {
    let name = "#NormalMode";
    if (isTurboMode()) {
      name = "#TurboMode";
    } else if (isGroupMode()) {
      name = "#TeamGroupMode";
    } else if (isCompetitionMode()) {
      name = "#CompetitionMode";
    } else if (isKingsRankMode()) {
      name = "#SummitArenaMode";
    } else if (rankMode) {
      name = "#RankMode";
    }
    return name;
  };
  const HeroSelectionShow = () => game_state() == "GameState_HeroBan" || game_state() == "GameState_CityEnd" || game_state() == "GameState_HeroSelection" && localHeroName() == undefined;
  libs.createEffect(() => {
    const id = CustomNetTables.SubscribeNetTableListener("common", function (_, k, v) {
      if (k === "ban_list") {
        _setBanListNet(v);
      }
    });
    libs.onCleanup(() => {
      CustomNetTables.UnsubscribeNetTableListener(id);
    });
  });
  return (() => {
    const _el$ = libs.createElement("Panel", {
      id: "HeroSelection"
    }, null);
    libs.setProp(_el$, "onactivate", () => {});
    libs.insert(_el$, libs.createComponent(libs.Show, {
      get when() {
        return HeroSelectionShow();
      },
      get children() {
        return libs.createComponent(TeamSuggestionIcon.TopBar, {
          type: "hero_selection"
        });
      }
    }), null);
    libs.insert(_el$, libs.createComponent(EOM_Panel.EOM_Panel, {
      id: "BorderBG"
    }), null);
    libs.insert(_el$, libs.createComponent(EOM_Panel.EOM_Panel, {
      get className() {
        return libs.classNames("MatchTypeBoard", {
          Rank: rankMode
        });
      },
      get children() {
        return [libs.createComponent(EOM_Panel.EOM_Panel, {
          id: "MatchTypeBg",
          align: "center top",
          get className() {
            return libs.classNames({
              [GetMapName()]: true
            });
          }
        }), libs.createComponent(EOM_Panel.EOM_Panel, {
          id: "InfoIcon",
          className: language,
          onmouseover: p => $.DispatchEvent("DOTAShowTextTooltip", p, modeName() + "_description"),
          onmouseout: self => $.DispatchEvent("DOTAHideTextTooltip", self),
          get children() {
            return libs.createComponent(EOM_Image.EOM_Image, {
              width: "42px",
              height: "42px",
              get src() {
                return rankMode ? getSrcPath("icon/k_icon_02.png") : getSrcPath("icon/k_icon_01.png");
              }
            });
          }
        }), libs.createComponent(EOM_Panel.EOM_Panel, {
          id: "MatchTypeLabel",
          get children() {
            return libs.createComponent(GenericPanel.CLabel, {
              get text() {
                return $.Localize(modeName()).toUpperCase();
              }
            });
          }
        })];
      }
    }), null);
    libs.insert(_el$, libs.createComponent(EOM_Panel.EOM_Panel, {
      id: "SectList",
      className: "CityFadeIn",
      hittest: false,
      get children() {
        return [libs.createComponent(libs.Index, {
          get each() {
            return pickList();
          },
          children: (sectName, index) => {
            return libs.createComponent(EOM_Panel.EOM_Panel, {
              get customTooltip() {
                return {
                  name: "player_sect_list",
                  sectName: sectName(),
                  sr_reveal: 1,
                  concise: 0
                };
              },
              padding: "4px",
              tooltipPosition: "bottom",
              get children() {
                return libs.createComponent(SectIcon.SectIcon, {
                  large: true,
                  active: true,
                  get sectName() {
                    return sectName();
                  },
                  width: "56px",
                  height: "56px"
                });
              }
            });
          }
        }), libs.createComponent(libs.Index, {
          get each() {
            return banList();
          },
          children: (sectName, index) => {
            return libs.createComponent(EOM_Panel.EOM_Panel, {
              get customTooltip() {
                return {
                  name: "player_sect_list",
                  sectName: sectName(),
                  sr_reveal: 1,
                  concise: 1
                };
              },
              padding: "4px",
              tooltipPosition: "bottom",
              get children() {
                return [libs.createComponent(SectIcon.SectIcon, {
                  large: true,
                  active: false,
                  get sectName() {
                    return sectName();
                  },
                  width: "56px",
                  height: "56px"
                }), libs.createComponent(EOM_Image.EOM_Image, {
                  width: "56px",
                  height: "56px",
                  align: "center center",
                  get backgroundImage() {
                    return getImagePath("icon/s_ban.png");
                  },
                  hittest: false
                })];
              }
            });
          }
        })];
      }
    }), null);
    libs.insert(_el$, libs.createComponent(libs.Show, {
      get when() {
        return game_state() != "GameState_CityEnd";
      },
      get fallback() {
        return libs.createComponent(CityResult, {});
      },
      get children() {
        return libs.createComponent(HeroSelectAndBan, {
          get banList() {
            return banList();
          }
        });
      }
    }), null);
    libs.effect(_$p => libs.setProp(_el$, "className", libs.classNames({
      Show: HeroSelectionShow()
    }), _$p));
    return _el$;
  })();
};
const HeroSelectAndBan = props => {
  const localPlayerID = Players.GetLocalPlayer();
  const [game_state, setGameState] = libs.createSignal(getGameState());
  const [customMatchType, setCustomMatchType] = libs.createSignal(CustomNetTables.GetTableValue("common", "custom_match_type")?.type ?? 0);
  netdata_utils.createNetTableEffect("common", "custom_match_type", data => {
    if (data?.type != undefined) {
      setCustomMatchType(data.type);
    } else {
      setCustomMatchType(0);
    }
  });
  const heroBan = useHeroBan();
  const heroSelection = useHeroSelection(localPlayerID, customMatchType);
  const playerInfo = usePlayerInfo(localPlayerID);
  const allBanVote = libs.createMemo(() => {
    let data = {};
    const _vote = heroBan.banVote();
    Object.entries(_vote).forEach(([playerID, heroArr], index) => {
      for (const key in heroArr) {
        const name = heroArr[key];
        if (!data[name]) {
          data[name] = [];
        }
        data[name].push(playerID);
      }
    });
    return data;
  });
  const [playerHeroSkins, setPlayerHeroSkins] = libs.createSignal({});
  const getHeroSkinID = heroName => {
    return playerHeroSkins()[heroName];
  };
  const recommendHeroName = () => {
    const heroNameList = heroSelection.localHeroSlotList().map(v => heroSelection.heroSelectionDataNew[v].hero_name);
    heroNameList.sort((a, b) => {
      const recommendA = Number(rookieRecommend()?.heroes?.indexOf(Number(GetGoodIDByHeroName(a) ?? 0)));
      const recommendB = Number(rookieRecommend()?.heroes?.indexOf(Number(GetGoodIDByHeroName(b) ?? 0)));
      return recommendA - recommendB;
    });
    return heroNameList[0];
  };
  libs.createEffect(libs.on(game_state, v => {
    if (v == "GameState_None") {
      clearRookieTip();
      heroBan.setBanHero([]);
    }
    if (v != "GameState_HeroSelection") {
      clearRookieTip("hero_selection");
    }
  }));
  const [selectTrait, setSelectTrait] = libs.createSignal();
  const [rookieRecommend, setRookieRecommend] = libs.createSignal();
  const [earlyExitCount, setEarlyExitCount] = libs.createSignal(0);
  const punishment = () => earlyExitCount() > 0 && isRankMode() && isKingsRankMode();
  const [hero_medal_level, setHeroMedalLevel] = libs.createSignal();
  const [cityEffect, setCityEffect] = libs.createSignal();
  libs.createEffect(libs.on(game_state, _game_state => {
    if (_game_state == "GameState_None") {
      setSelectTrait();
      if (playerInfo.playerInfosNew()) {
        Object.values(playerInfo.playerInfosNew()).forEach((effectPair, index) => {
          effectPair[1]("heroName", undefined);
          effectPair[1]("trait", undefined);
        });
      }
    }
  }));
  libs.createEffect(libs.on([recommendHeroName, rookieRecommend, game_state], v => {
    if (game_state() == "GameState_HeroSelection" && rookieRecommend() != undefined) {
      const slot = heroSelection.localHeroSlotList().find(v => heroSelection.heroSelectionDataNew[v].hero_name == recommendHeroName());
      if (slot) {
        rookieTip("hero_selection", "#RookieTip1", {
          index: Number(slot) - 1,
          max_index: Object.values(heroSelection.heroSelectionDataNew).length
        });
      }
    }
  }));
  const [isReturnPlayer, setIsReturnPlayer] = libs.createSignal(false);
  const [pickCardAmounts, setPickCardAmounts] = libs.createSignal(0);
  libs.onMount(() => {
    const idList = [];
    const eventList = [];
    idList.push(useServiceNetTable("player_equipped_ornament", data => {
      let list = {};
      if (data?.[OrnamentType.HERO_SKIN] != undefined) {
        for (const oid in data[OrnamentType.HERO_SKIN]) {
          if (KeyValues.CosmeticsKv[oid] != undefined && typeof KeyValues.CosmeticsKv[oid].hero == "number" && GetHeroNameByGoodID(KeyValues.CosmeticsKv[oid].hero)) {
            list[GetHeroNameByGoodID(KeyValues.CosmeticsKv[oid].hero)] = oid;
          }
        }
      }
      setPlayerHeroSkins(list);
    }, Players.GetLocalPlayer()));
    eventList.push(useNetData("remaining_early_exit_count", data => {
      setEarlyExitCount(finiteNumber(Number(data?.remaining_early_exit_count)));
    }, Players.GetLocalPlayer()));
    eventList.push(useNetData("player_regression_data", data => {
      setIsReturnPlayer(data?.is_regression_player == true);
    }, Players.GetLocalPlayer()));
    eventList.push(useNetData("player_props", data => {
      setPickCardAmounts(finiteNumber(Number(Object.values(data).find(v => v.prop_id == 9310014)?.amounts ?? 0)));
    }, Players.GetLocalPlayer()));
    eventList.push(useNetData("rookie_recommend", data => {
      setRookieRecommend(data);
    }, Players.GetLocalPlayer()));
    idList.push(useServiceNetTable("player_hero_medal_level", data => {
      setHeroMedalLevel(data);
    }, Players.GetLocalPlayer()));
    idList.push(useNetTableKeyHasDefaultValue("common", "city_effect", data => {
      setCityEffect(data.name);
    }));
    idList.push(useNetTableKeyHasDefaultValue("common", "constant", data => {}));
    idList.push(CustomNetTables.SubscribeNetTableListener("player_data", (tableName, key, data) => {
      if (data && Number(key) != undefined) {
        const playerID = Number(key);
        const effectPair = playerInfo.playerInfosNew()[playerID];
        if (effectPair == undefined) ; else {
          effectPair[1]("heroName", data?.heroName);
          effectPair[1]("steamID", data.steamID);
          effectPair[1]("trait", data.trait);
          effectPair[1]("rankAlarm", data.rankAlarm);
          effectPair[1]("rankWarningCount", data.rankWarningCount);
          effectPair[1]("playerID", Number(key));
        }
      }
      if (Number(key) == localPlayerID) {
        if (data?.rankAlarm < 1 && notice) {
          notice = false;
          showPopup("RankNotice", {
            PopupID: "RankNotice",
            rankAlarm: data?.rankAlarm
          });
        }
      }
    }));
    idList.push(useNetTableKey("common", "game_state", data => {
      setGameState(data.state);
    }));
    libs.onCleanup(() => {
      idList.forEach(id => {
        CustomNetTables.UnsubscribeNetTableListener(id);
      });
      eventList.forEach(id => GameEvents.Unsubscribe(id));
    });
  });
  const rankMode = isRankMode();
  const competitionMode = isCompetitionMode();
  libs.createEffect(() => {
    if (game_state() == "GameState_HeroSelection") {
      closeRookieV2Tip("hero_ban");
      closeRookieV2Tip("hero_ban_confirm");
    }
  });
  const [bpPlus, setBpPlus] = libs.createSignal(false);
  netdata_utils.createServiceNetTable("hero_statisitcs");
  if (!isSpectator()) {
    const BpSeason = game_utils.GetBattlePassSeason();
    netdata_utils.createNetDataEffect("player_battle_passes", v => {
      if (v && v[BpSeason()] && v[BpSeason()]?.plus == 1) {
        setBpPlus(true);
      } else {
        setBpPlus(false);
      }
    }, Players.GetLocalPlayer(), [BpSeason]);
  } else {
    setBpPlus(true);
  }
  const [suggetedHero, setSuggestedHero] = libs.createSignal("");
  let suggestingCD = undefined;
  return [libs.createElement("DOTAParticleScenePanel", {
    id: "HeroSelectionBGParticle",
    hittest: false,
    particleName: "particles/eom/ui/ui_fx/ui_fx_t4_board_02.vpcf",
    cameraOrigin: "-2 0 400",
    lookAt: "-2 0 0",
    fov: 50,
    particleonly: true
  }, null), libs.createComponent(EOM_Panel.EOM_Panel, {
    id: "Main",
    marginTop: "178px",
    flowChildren: "down",
    get children() {
      return [libs.createComponent(libs.Show, {
        get when() {
          return getGameplayModuleState("city_effect");
        },
        get children() {
          return libs.createComponent(CityImage.CityImage, {
            align: "right top",
            tooltipPosition: "left",
            marginTop: "80px",
            marginRight: "16px",
            get city_name() {
              return cityEffect();
            },
            get customTooltip() {
              return {
                name: "city_effect",
                abilityName: cityEffect()
              };
            }
          });
        }
      }), libs.createComponent(EOM_Panel.EOM_Panel, {
        get className() {
          return libs.classNames("SubTitle", language);
        },
        marginTop: "104px",
        get children() {
          return [libs.createComponent(GenericPanel.CImage, {
            "class": "SubTitleDecoration"
          }), libs.createComponent(EOM_Label.EOM_Label, {
            get text() {
              return game_state() == "GameState_HeroBan" ? "#ban_hero_title" : "#select_hero_title";
            },
            horizontalAlign: "center"
          }), libs.createComponent(GenericPanel.CImage, {
            "class": "SubTitleDecoration1"
          })];
        }
      }), libs.createComponent(libs.Switch, {
        get children() {
          return [libs.createComponent(libs.Match, {
            get when() {
              return game_state() == "GameState_HeroBan";
            },
            get children() {
              return libs.createComponent(HeroBanList, {
                get banHero() {
                  return heroBan.banHero;
                },
                get setBanHero() {
                  return heroBan.setBanHero;
                },
                get banVote() {
                  return heroBan.banVote;
                },
                get banHeroList() {
                  return heroBan.banHeroList;
                },
                get sectNoneWeekBan() {
                  return heroBan.sectNoneWeekBan;
                },
                get sectNoneRandomBan() {
                  return heroBan.sectNoneRandomBan;
                },
                get defaultBanList() {
                  return heroBan.defaultBanList;
                },
                get heroBanSlotAmounts() {
                  return heroBan.heroBanSlotAmounts;
                },
                get aiHost() {
                  return playerInfo.aiHost;
                },
                localPlayerID: localPlayerID,
                allBanVote: allBanVote
              });
            }
          }), libs.createComponent(libs.Match, {
            get when() {
              return game_state() == "GameState_HeroSelection";
            },
            get children() {
              return [libs.memo(() => libs.memo(() => !!isSpectator())() ? libs.createComponent(EOM_Panel.EOM_Panel, {
                id: "SpectatorHeroSelectionMain",
                get children() {
                  return libs.createComponent(libs.Index, {
                    get each() {
                      return playerInfo.playerInfoList();
                    },
                    children: (effectPair, index) => {
                      const playerInfoData = () => effectPair()?.[0];
                      const playerID = () => playerInfoData().playerID;
                      const heroName = libs.createMemo(() => {
                        return playerInfoData().heroName;
                      });
                      const skinID = () => {
                        const _heroName = heroName();
                        if (_heroName != undefined) {
                          const playerOrnament = getServiceNetTable("player_equipped_ornament", playerID());
                          if (playerOrnament?.[OrnamentType.HERO_SKIN] != undefined) {
                            for (const oid in playerOrnament[OrnamentType.HERO_SKIN]) {
                              if (KeyValues.CosmeticsKv[oid] != undefined && typeof KeyValues.CosmeticsKv[oid].hero == "number" && GetHeroNameByGoodID(KeyValues.CosmeticsKv[oid].hero) == _heroName) {
                                return oid;
                              }
                            }
                          }
                        }
                        return;
                      };
                      return libs.createComponent(EOM_Panel.EOM_Panel, {
                        className: "SpectatorPlayerInfo",
                        hittest: false,
                        get children() {
                          return [libs.createComponent(Player.PlayerName, {
                            id: "PlayerName",
                            get steamID() {
                              return playerInfoData().steamID;
                            },
                            get playerID() {
                              return playerID();
                            },
                            get ban() {
                              return isNameBan(playerID());
                            }
                          }), libs.createComponent(Player.PlayerAvatar, {
                            id: "PlayerAvatar",
                            get steamID() {
                              return playerInfoData().steamID;
                            },
                            get playerID() {
                              return playerID();
                            },
                            get customTooltip() {
                              return {
                                name: "player_profile",
                                playerID: playerID(),
                                steamID: playerInfoData().steamID
                              };
                            }
                          }), libs.memo(() => rankMode && libs.createComponent(RankTierIcon.RankTierIcon, {
                            player_id: index,
                            size: "64",
                            hittest: false
                          })), libs.createComponent(libs.Switch, {
                            get fallback() {
                              return (() => {
                                const _el$5 = libs.createElement("Panel", {}, null),
                                  _el$6 = libs.createElement("Image", {
                                    hittest: false
                                  }, _el$5);
                                libs.setProp(_el$5, "className", "HeroCard Empty");
                                libs.setProp(_el$6, "className", "HeroCardBorder");
                                libs.insert(_el$5, libs.createComponent(EOM_Loading.EOM_Loading, {
                                  type: "Wave"
                                }), null);
                                return _el$5;
                              })();
                            },
                            get children() {
                              return libs.createComponent(libs.Match, {
                                get when() {
                                  return heroName() != undefined;
                                },
                                get children() {
                                  return [libs.createComponent(HeroCard.HeroCard, {
                                    hero_selection: true,
                                    get heroName() {
                                      return heroName();
                                    },
                                    get skinID() {
                                      return skinID();
                                    },
                                    showAbilityTooltip: false,
                                    get customTooltip() {
                                      return {
                                        name: "hero_detail",
                                        hero_name: heroName() ?? "",
                                        skin_id: skinID()
                                      };
                                    }
                                  }), libs.createComponent(EOM_Image.EOM_Image, {
                                    className: "Check",
                                    get backgroundImage() {
                                      return getImagePath("icon/icon_party_ready_psd.png");
                                    },
                                    width: "35px",
                                    height: "34px",
                                    hittest: false
                                  })];
                                }
                              });
                            }
                          })];
                        }
                      });
                    }
                  });
                }
              }) : [libs.createComponent(EOM_Panel.EOM_Panel, {
                id: "HeroSelectionList",
                width: "100%",
                get opacity() {
                  return !playerInfo.aiHost() ? "1" : "0";
                },
                hittest: false,
                get children() {
                  return [libs.createComponent(libs.Show, {
                    get when() {
                      return heroSelection.localSelectedHero() == undefined;
                    },
                    get fallback() {
                      return (() => {
                        let popupID;
                        let switchCD = false;
                        libs.onMount(() => {
                          const id = GameEvents.Subscribe("switch_hero_request", data => {
                            if (data.playerID == heroSelection.teammatePlayerID()) {
                              if (switchCD) return;
                              switchCD = true;
                              $.Schedule(3, () => {
                                switchCD = false;
                              });
                              if (popupID) {
                                closePopup(popupID, true);
                              }
                              console.log("showPopup", "TeamHeroSwitch", data.hero);
                              popupID = showPopup("TeamHeroSwitch", {
                                hero_name: data.hero
                              });
                            }
                          });
                          libs.onCleanup(() => {
                            if (popupID) {
                              closePopup(popupID, true);
                              popupID = undefined;
                            }
                            GameEvents.Unsubscribe(id);
                          });
                        });
                        return libs.createComponent(EOM_Panel.EOM_Panel, {
                          horizontalAlign: "center",
                          get visible() {
                            return isGroupMode();
                          },
                          get children() {
                            return [libs.createComponent(EOM_Panel.EOM_Panel, {
                              className: "HeroCardSelect",
                              get children() {
                                return libs.createComponent(HeroCard.HeroCard, {
                                  hero_selection: true,
                                  align: "center center",
                                  get heroName() {
                                    return heroSelection.localSelectedHero();
                                  },
                                  get skinID() {
                                    return getHeroSkinID(heroSelection.localSelectedHero());
                                  },
                                  showCollection: true,
                                  showAbilityTooltip: false,
                                  get customTooltip() {
                                    return {
                                      name: "hero_detail",
                                      hero_name: heroSelection.localSelectedHero(),
                                      skin_id: getHeroSkinID(heroSelection.localSelectedHero()) ?? ""
                                    };
                                  }
                                });
                              }
                            }), libs.createComponent(EOM_Button.EOM_BaseButton, {
                              align: "center top",
                              marginTop: "370px",
                              get enabled() {
                                return libs.memo(() => !!(!heroSelection.localReady() && !heroSelection.teammateReady()))() && heroSelection.teammateSelectedHero() != undefined;
                              },
                              onactivate: () => {
                                GameEvents.SendCustomEventToServer("switch_hero", {});
                              },
                              tooltip_text: "#TeamSwitchHero",
                              get children() {
                                return libs.createComponent(EOM_Image.EOM_Image, {
                                  width: "66px",
                                  height: "66px",
                                  get backgroundImage() {
                                    return getImagePath("icon/s11_icon_exchange.png");
                                  }
                                });
                              }
                            })];
                          }
                        });
                      })();
                    },
                    get children() {
                      return [libs.createComponent(libs.Show, {
                        get when() {
                          return !bpPlus();
                        },
                        get children() {
                          return libs.createComponent(EOM_Panel.EOM_Panel, {
                            get className() {
                              return libs.classNames("HeroStatisticTopLock");
                            },
                            hittest: false,
                            get children() {
                              return [libs.createComponent(EOM_Image.EOM_Image, {
                                get className() {
                                  return libs.classNames("SeasonHeightIcon");
                                },
                                tooltip_text: "#Ladder_HeroDetail",
                                onactivate: () => {
                                  clientSideEvent("directly_purchase", {
                                    itemid: 9900286
                                  });
                                }
                              }), libs.createComponent(EOM_Label.EOM_Label, {
                                id: "HeroStatisticLocked",
                                text: "#HeroStatistic_Locked",
                                hittest: false,
                                html: true
                              })];
                            }
                          });
                        }
                      }), libs.createComponent(HeroSelectionList, {
                        get heroSelectionDataNew() {
                          return heroSelection.heroSelectionDataNew;
                        },
                        get localHeroSlotList() {
                          return heroSelection.localHeroSlotList;
                        },
                        get refreshingSlotList() {
                          return heroSelection.refreshingSlotList;
                        },
                        get refreshIconAmounts() {
                          return heroSelection.refreshIconAmounts;
                        },
                        get refreshIconEnough() {
                          return heroSelection.refreshIconEnough;
                        },
                        get selectHero() {
                          return playerInfo.selectHero;
                        },
                        getHeroSkinID: getHeroSkinID,
                        hero_medal_level: hero_medal_level,
                        recommendHeroName: recommendHeroName,
                        get isHeroPunishment() {
                          return heroSelection.isHeroPunishment;
                        },
                        bpPlus: bpPlus,
                        get onRefreshSlot() {
                          return heroSelection.onRefreshSlot;
                        },
                        get onPickHero() {
                          return heroSelection.onPickHero;
                        },
                        get heroTeamSuggestion() {
                          return playerInfo.heroTeamSuggestion();
                        }
                      })];
                    }
                  }), libs.createComponent(libs.Show, {
                    get when() {
                      return isGroupMode();
                    },
                    get children() {
                      return [libs.createComponent(EOM_Panel.EOM_Panel, {
                        id: "GropModeContainer",
                        get children() {
                          return libs.createComponent(libs.Show, {
                            get when() {
                              return heroSelection.localSelectedHero() == undefined;
                            },
                            get fallback() {
                              return libs.createComponent(EOM_Button.EOM_Button, {
                                verticalAlign: "center",
                                marginRight: "100px",
                                color: "Gold",
                                horizontalAlign: "right",
                                enabled: true,
                                text: "#ConfirmCheck",
                                onactivate: () => {
                                  GameEvents.SendCustomEventToServer("hero_select_ready", {});
                                }
                              });
                            },
                            get children() {
                              return [libs.createComponent(EOM_Panel.EOM_Panel, {
                                get visible() {
                                  return !isCompetitionMode();
                                },
                                id: "RefreshCoinContainer",
                                get children() {
                                  return [libs.createComponent(EOM_Icon.EOM_Icon, {
                                    verticalAlign: "center",
                                    get src() {
                                      return getProductSrc(9310017);
                                    },
                                    onmouseover: self => {
                                      $.DispatchEvent("DOTAShowTitleTextTooltip", self, "#" + 9310017, "#" + 9310017 + "_description");
                                    },
                                    onmouseout: self => {
                                      $.DispatchEvent("DOTAHideTitleTextTooltip", self);
                                    }
                                  }), libs.createComponent(EOM_Panel.EOM_Panel, {
                                    id: "RefreshCoinNum",
                                    get children() {
                                      return libs.createComponent(EOM_Label.EOM_Label, {
                                        get text() {
                                          return `${heroSelection.refreshIconAmounts()}`;
                                        }
                                      });
                                    }
                                  })];
                                }
                              }), libs.createComponent(EOM_Button.EOM_Button, {
                                id: "GropModeRandom",
                                color: "Blue",
                                horizontalAlign: "right",
                                get enabled() {
                                  return libs.memo(() => !!!punishment())() && playerInfo.selfPlayerInfo()?.heroName == undefined;
                                },
                                text: "#Random",
                                onactivate: () => {
                                  Object.values(heroSelection.refreshingSlotList).forEach(v => {
                                    if (v.timer != undefined) {
                                      $.CancelScheduled(v.timer);
                                    }
                                  });
                                  if (heroSelection.localHeroSlotList().length > 0) {
                                    libs.batch(() => {
                                      heroSelection.localHeroSlotList().forEach(v => {
                                        heroSelection.setRefreshingSlotList(v, {
                                          state: true,
                                          timer: $.Schedule(1, () => {
                                            heroSelection.setRefreshingSlotList(v, undefined);
                                          })
                                        });
                                      });
                                    });
                                  }
                                  heroSelection.onRandomHero();
                                }
                              }), libs.createComponent(EOM_Button.EOM_Button, {
                                get visible() {
                                  return !isCompetitionMode();
                                },
                                id: "GropModeChoose",
                                text: "#CustomPickHero",
                                get enabled() {
                                  return libs.memo(() => !!!punishment())() && playerInfo.selfPlayerInfo()?.heroName == undefined;
                                },
                                horizontalAlign: "center",
                                color: "Green",
                                onactivate: () => {
                                  showPopup("HeroSelectCard", {});
                                }
                              })];
                            }
                          });
                        }
                      }), libs.createComponent(EOM_Panel.EOM_Panel, {
                        id: "GropModeTeammeatHero",
                        get children() {
                          return [libs.createComponent(EOM_Panel.EOM_Panel, {
                            flowChildren: "right",
                            horizontalAlign: "center",
                            get children() {
                              return [libs.createElement("Panel", {
                                id: "GropModeTeammeatTagLeft"
                              }, null), libs.createComponent(GenericPanel.CLabel, {
                                id: "GropModeTeammeatTagLabel",
                                text: "#Teammate_Hero"
                              }), libs.createElement("Panel", {
                                id: "GropModeTeammeatTagRight"
                              }, null)];
                            }
                          }), (() => {
                            const _el$9 = libs.createElement("Panel", {
                              id: "TeammateHeros"
                            }, null);
                            libs.insert(_el$9, libs.createComponent(libs.Show, {
                              get when() {
                                return heroSelection.teammateSelectedHero() == undefined;
                              },
                              get fallback() {
                                return libs.createComponent(EOM_Panel.EOM_Panel, {
                                  id: "TeammateHero",
                                  get customTooltip() {
                                    return {
                                      name: "hero_detail",
                                      hero_name: heroSelection.teammateSelectedHero()
                                    };
                                  },
                                  get children() {
                                    return libs.createComponent(EOM_Panel.EOM_Panel, {
                                      id: "TeammateHeroBox",
                                      get children() {
                                        return [libs.createComponent(EOM_Portrait.EOM_Portrait, {
                                          id: "TeammateHeroPortrait",
                                          get unitname() {
                                            return heroSelection.teammateSelectedHero();
                                          }
                                        }), libs.createComponent(EOM_Panel.EOM_Panel, {
                                          id: "TeammateHeroPortraitBorder",
                                          hittest: false
                                        }), libs.createComponent(EOM_Image.EOM_Image, {
                                          get visible() {
                                            return heroSelection.teammateReady();
                                          },
                                          get backgroundImage() {
                                            return getImagePath("icon/icon_party_ready_psd.png");
                                          },
                                          width: "26px",
                                          height: "26px",
                                          align: "right top"
                                        })];
                                      }
                                    });
                                  }
                                });
                              },
                              get children() {
                                return libs.createComponent(libs.Index, {
                                  get each() {
                                    return heroSelection.teammateHeroSlotList().filter(v => heroSelection.teammateHeroSelectionData[v]?.type != "locked");
                                  },
                                  children: (slot, index) => {
                                    const heroName = libs.createMemo(() => {
                                      return heroSelection.teammateHeroSelectionData[slot()]?.hero_name ?? "";
                                    });
                                    const locked = libs.createMemo(() => {
                                      return heroSelection.teammateHeroSelectionData[slot()]?.type == "locked";
                                    });
                                    const suggested = () => suggetedHero() == heroName();
                                    return libs.createComponent(EOM_Button.EOM_BaseButton, {
                                      id: "TeammateHero",
                                      get visible() {
                                        return !locked();
                                      },
                                      get customTooltip() {
                                        return {
                                          name: "hero_detail",
                                          hero_name: heroName()
                                        };
                                      },
                                      onactivate: self => {
                                        if (heroName() != "") {
                                          if (suggestingCD) {
                                            return;
                                          }
                                          suggestingCD = true;
                                          SendTeammateSuggestAction(TeamSuggestAction.HeroSelection, heroName());
                                          console.log("setSuggestedHero", heroName());
                                          setSuggestedHero(heroName());
                                          $.Schedule(1, () => {
                                            suggestingCD = undefined;
                                          });
                                        }
                                      },
                                      get children() {
                                        return [libs.createComponent(EOM_Panel.EOM_Panel, {
                                          id: "TeammateHeroBox",
                                          get children() {
                                            return [libs.createComponent(EOM_Portrait.EOM_Portrait, {
                                              id: "TeammateHeroPortrait",
                                              get unitname() {
                                                return heroName();
                                              }
                                            }), libs.createComponent(EOM_Panel.EOM_Panel, {
                                              id: "TeammateHeroPortraitBorder",
                                              hittest: false
                                            })];
                                          }
                                        }), (() => {
                                          const _el$0 = libs.createElement("Panel", {
                                            id: "TeammateRecommendIcon",
                                            hittest: false
                                          }, null);
                                          libs.effect(_$p => libs.setProp(_el$0, "visible", suggested(), _$p));
                                          return _el$0;
                                        })()];
                                      }
                                    });
                                  }
                                });
                              }
                            }));
                            return _el$9;
                          })()];
                        }
                      })];
                    }
                  })];
                }
              }), libs.createComponent(EOM_Panel.EOM_Panel, {
                get visible() {
                  return !heroSelection.isHeroPunishment();
                },
                horizontalAlign: "center",
                width: "90%",
                height: "250px",
                marginTop: "10px",
                get children() {
                  return libs.createComponent(EOM_Panel.EOM_Panel, {
                    id: "BottomButton",
                    get children() {
                      return [libs.createComponent(libs.Show, {
                        get when() {
                          return !isCompetitionMode();
                        },
                        get children() {
                          return libs.createComponent(EOM_Panel.EOM_Panel, {
                            id: "RefreshCoinContainer",
                            get children() {
                              return [libs.createComponent(EOM_Icon.EOM_Icon, {
                                verticalAlign: "center",
                                get src() {
                                  return getProductSrc(9310017);
                                },
                                onmouseover: self => {
                                  $.DispatchEvent("DOTAShowTitleTextTooltip", self, "#" + 9310017, "#" + 9310017 + "_description");
                                },
                                onmouseout: self => {
                                  $.DispatchEvent("DOTAHideTitleTextTooltip", self);
                                }
                              }), libs.createComponent(EOM_Panel.EOM_Panel, {
                                id: "RefreshCoinNum",
                                get children() {
                                  return libs.createComponent(EOM_Label.EOM_Label, {
                                    get text() {
                                      return `${heroSelection.refreshIconAmounts()}`;
                                    }
                                  });
                                }
                              })];
                            }
                          });
                        }
                      }), libs.createComponent(EOM_Button.EOM_Button, {
                        color: "Blue",
                        horizontalAlign: "right",
                        get enabled() {
                          return libs.memo(() => !!!punishment())() && playerInfo.selfPlayerInfo()?.heroName == undefined;
                        },
                        text: "#Random",
                        onactivate: () => {
                          Object.values(heroSelection.refreshingSlotList).forEach(v => {
                            if (v.timer != undefined) {
                              $.CancelScheduled(v.timer);
                            }
                          });
                          if (heroSelection.localHeroSlotList().length > 0) {
                            libs.batch(() => {
                              heroSelection.localHeroSlotList().forEach(v => {
                                heroSelection.setRefreshingSlotList(v, {
                                  state: true,
                                  timer: $.Schedule(1, () => {
                                    heroSelection.setRefreshingSlotList(v, undefined);
                                  })
                                });
                              });
                            });
                          }
                          heroSelection.onRandomHero();
                        }
                      }), libs.createComponent(libs.Show, {
                        get when() {
                          return !rankMode && !competitionMode && !isKingsRankMode();
                        },
                        get children() {
                          return libs.createComponent(EOM_Button.EOM_Button, {
                            text: "#CustomPickHero",
                            get enabled() {
                              return libs.memo(() => !!!punishment())() && playerInfo.selfPlayerInfo()?.heroName == undefined;
                            },
                            horizontalAlign: "center",
                            color: "Green",
                            onactivate: () => {
                              showPopup("HeroSelectCard", {});
                            }
                          });
                        }
                      })];
                    }
                  });
                }
              })]), libs.createComponent(EOM_Panel.EOM_Panel, {
                id: "BanHeroList",
                flowChildren: "right",
                get children() {
                  return [libs.createComponent(libs.Show, {
                    get when() {
                      return heroBan.sectNoneWeekBan();
                    },
                    get children() {
                      const _el$3 = libs.createElement("Panel", {
                          "class": "HeroImageButton SelectionState isWeekBan"
                        }, null),
                        _el$4 = libs.createElement("Image", {
                          "class": "Banned"
                        }, _el$3);
                      libs.insert(_el$3, libs.createComponent(Heroes.HeroImage, {
                        get hero_name() {
                          return heroBan.sectNoneWeekBan();
                        }
                      }), _el$4);
                      libs.insert(_el$3, libs.createComponent(EOM_Icon.EOM_Icon, {
                        className: "NoneBanInfoIcon Week",
                        tooltip_text: "#SectWeekBan",
                        get src() {
                          return getSrcPath("eom_design/icon/C4/info.png");
                        }
                      }), null);
                      return _el$3;
                    }
                  }), libs.createComponent(libs.Show, {
                    get when() {
                      return heroBan.sectNoneRandomBan();
                    },
                    get children() {
                      return libs.createComponent(libs.Index, {
                        get each() {
                          return heroBan.sectNoneRandomBan();
                        },
                        children: (heroName, index) => (() => {
                          const _el$1 = libs.createElement("Panel", {
                              "class": "HeroImageButton SelectionState isRandomBan"
                            }, null),
                            _el$10 = libs.createElement("Image", {
                              "class": "Banned"
                            }, _el$1);
                          libs.insert(_el$1, libs.createComponent(Heroes.HeroImage, {
                            get hero_name() {
                              return heroName();
                            }
                          }), _el$10);
                          libs.insert(_el$1, libs.createComponent(EOM_Icon.EOM_Icon, {
                            className: "NoneBanInfoIcon Random",
                            tooltip_text: "#SectRandomBan",
                            get src() {
                              return getSrcPath("eom_design/icon/C4/info.png");
                            }
                          }), null);
                          return _el$1;
                        })()
                      });
                    }
                  }), libs.createComponent(libs.Show, {
                    get when() {
                      return heroBan.banHeroResult().length > 0;
                    },
                    get children() {
                      return [libs.createComponent(libs.Index, {
                        get each() {
                          return heroBan.banHeroResult();
                        },
                        children: (heroName, index) => (() => {
                          const _el$11 = libs.createElement("Panel", {
                              "class": "HeroImageButton SelectionState"
                            }, null),
                            _el$12 = libs.createElement("Image", {
                              "class": "Banned"
                            }, _el$11);
                          libs.insert(_el$11, libs.createComponent(Heroes.HeroImage, {
                            get hero_name() {
                              return heroName();
                            }
                          }), _el$12);
                          return _el$11;
                        })()
                      }), libs.createComponent(EOM_Icon.EOM_Icon, {
                        id: "HeroBanInfoIcon",
                        washColor: "#a5ffff",
                        marginTop: "8px",
                        size: "24",
                        get src() {
                          return getSrcPath("eom_design/icon/C4/info.png");
                        },
                        customTooltip: {
                          name: "hero_ban"
                        }
                      })];
                    }
                  })];
                }
              })];
            }
          })];
        }
      })];
    }
  }), libs.createComponent(PlayerInfoBar, {
    get playerInfoList() {
      return playerInfo.playerInfoList;
    },
    gameState: game_state,
    get banVote() {
      return heroBan.banVote;
    },
    rankMode: rankMode,
    get isKingsRankMode() {
      return isKingsRankMode();
    }
  })];
};
const CityResult = () => {
  const [cityResult, setCityResult] = libs.createSignal();
  Game.EmitSound("Muerta_ReleaseEvent.UI_InitialSlideIn_Feedback");
  libs.onMount(() => {
    const id = useNetTableKeyHasDefaultValue("common", "city_effect", data => {
      setCityResult(data?.name);
    });
    libs.onCleanup(() => CustomNetTables.UnsubscribeNetTableListener(id));
  });
  return libs.createComponent(EOM_Panel.EOM_Panel, {
    id: "CityResultMain",
    hittest: false,
    get children() {
      return [libs.createComponent(EOM_Panel.EOM_Panel, {
        id: "CityResultTitle",
        className: "CityFadeIn",
        hittest: false,
        get children() {
          return [libs.createComponent(GenericPanel.CImage, {
            "class": "SubTitleDecoration"
          }), libs.createComponent(EOM_Label.EOM_Label, {
            text: "#match_land_title"
          }), libs.createComponent(GenericPanel.CImage, {
            "class": "SubTitleDecoration1"
          })];
        }
      }), libs.createComponent(libs.Show, {
        get when() {
          return cityResult();
        },
        get children() {
          return libs.createComponent(EOM_Panel.EOM_Panel, {
            id: "CityResultSubTitle",
            className: "CityFadeIn",
            hittest: false,
            get children() {
              return [libs.createComponent(CityImage.CityImage, {
                get city_name() {
                  return cityResult();
                },
                get customTooltip() {
                  return {
                    name: "city_effect",
                    abilityName: cityResult()
                  };
                }
              }), libs.createComponent(EOM_Label.EOM_Label, {
                id: "CityResultLabel",
                get text() {
                  return `#DOTA_Tooltip_ability_${cityResult()}`;
                },
                hittest: false
              })];
            }
          });
        }
      }), libs.createComponent(EOM_Panel.EOM_Panel, {
        get className() {
          return libs.classNames("CityResultContainer");
        },
        hittest: false,
        hittestchildren: false,
        get children() {
          return libs.createComponent(EOM_Panel.EOM_Panel, {
            id: "CityResultBG",
            get children() {
              return libs.createComponent(EOM_Panel.EOM_Panel, {
                id: "CityResultDescription",
                get children() {
                  return libs.createComponent(CityDescription.CityDescription, {
                    className: "CityDescription",
                    get abilityName() {
                      return cityResult() ?? "";
                    }
                  });
                }
              });
            }
          });
        }
      })];
    }
  });
};
libs.render(() => libs.createComponent(HeroSelection, {}), $.GetContextPanel());