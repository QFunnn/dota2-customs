--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build b9dc48c · 2026-08-02 17:42:46 UTC
  ~ auto-generated — do not edit
]]


'use strict'; const require = GameUI.__require;

var libs = require('./libs.js');
var EOM_Panel = require('./EOM_Panel.js');
var EOM_Icon = require('./EOM_Icon.js');
var EOM_Image = require('./EOM_Image.js');
var EOM_Label = require('./EOM_Label.js');
var EOM_PortraitFullBody = require('./EOM_PortraitFullBody.js');
var EOM_Button = require('./EOM_Button.js');
var EOM_Separator = require('./EOM_Separator.js');
var GenericPanel = require('./GenericPanel.js');
var NewRegressionIcon = require('./NewRegressionIcon.js');
var ProductImage = require('./ProductImage.js');
var RankTierIcon = require('./RankTierIcon.js');
var profile_info = require('./profile_info.js');
var netdata_utils = require('./netdata_utils.js');
var game_utils = require('./game_utils.js');
require('./Player.js');

$.GetContextPanel().AddClass("CosmeticPreviewLiveHidden");
if (!isSpectator()) {
  const getHeroSkinID = (ornament_data, heroName) => {
    if (heroName) {
      const playerHid = GetGoodIDByHeroName(heroName);
      for (const sid in ornament_data) {
        const skinData = ornament_data[sid];
        if (skinData.hid == playerHid && skinData.equip == 1) {
          return sid;
        }
      }
    }
    return heroName;
  };
  const showRankScore = () => {
    return isRankMode() || isKingsRankMode();
  };
  const LeftHeroList = [3000020, 3000029, 3000030];
  const [show, setShow] = libs.createSignal(false);
  const [end, setEnd] = libs.createSignal((CustomNetTables.GetTableValue("common", "game_state")?.state ?? "GameState_None") == "GameState_End");
  const [doubleScoreProp, setDoubleScoreProp] = libs.createSignal([]);
  const [protectedScoreProp, setProtectedScoreProp] = libs.createSignal([]);
  const [rankAlarm, setRankAlarm] = libs.createSignal(1);
  const [scoreCardUsed, setScoreCardUsed] = libs.createSignal(false);
  const [scoreCardUsing, setScoreCardUsing] = libs.createSignal(false);
  const [showPlayerQuestionnaire, setShowPlayerQuestionnaire] = libs.createSignal(false);
  const EndScreen = () => {
    const playerID = Players.GetLocalPlayer();
    const [settlement_reward, setSettlementReward] = libs.createSignal({});
    const [medal_reward, setMedalReward] = libs.createSignal(-1);
    const [playerPrivilege, setPlayerPrivilege] = libs.createSignal(CustomNetTables.GetTableValue("common", "player_privilege")?.[playerID]);
    const [playerRank, setPlayerRank] = libs.createSignal();
    const goldCoinBonus = () => (playerPrivilege()?.settlement_gold_bonus ?? 0) > 0;
    const [courierName, setCourierName] = libs.createSignal("5200000");
    const [heroName, setHeroName] = libs.createSignal();
    const [playerOrnamentHero, setPlayerOrnamentHero] = libs.createSignal({});
    const [heroSkinID, setHeroSkinID] = libs.createSignal((() => {
      const sid = getHeroSkinID(playerOrnamentHero(), heroName());
      if (sid) {
        return sid;
      } else {
        return "5100000";
      }
    })());
    const [settlementScoreData, setSettlementScoreData] = libs.createSignal();
    libs.createEffect(() => {
      const sid = getHeroSkinID(playerOrnamentHero(), heroName());
      if (sid) {
        setHeroSkinID(sid);
      } else {
        setHeroSkinID("5100000");
      }
    });
    libs.createEffect(() => {
      setShow(end() || playerRank() != undefined);
    });
    const updatePlayerDataInfo = data => {
      libs.batch(() => {
        setRankAlarm(data.rankAlarm);
        setHeroName(data.heroName);
      });
    };
    libs.onMount(() => {
      const GameEventIDs = [];
      const NetTableListenerIDs = [];
      GameEventIDs.push(useNetData("rank_score_change", data => {
        if (Object.keys(data).length > 0) {
          setSettlementScoreData(data);
          setDoubleScoreProp(data.double_prop);
          setProtectedScoreProp(data.projected_prop);
          setScoreCardUsed(data.use_prop == true);
        } else {
          setSettlementScoreData();
          setDoubleScoreProp([]);
          setProtectedScoreProp([]);
          setScoreCardUsed(false);
        }
      }, playerID));
      GameEventIDs.push(useNetData("player_questionnaire", data => {
        if (data?.questions && !showPlayerQuestionnaire()) {
          setShowPlayerQuestionnaire(true);
        } else {
          setShowPlayerQuestionnaire(false);
        }
      }, playerID));
      GameEventIDs.push(useNetData("settlement_rewards", data => {
        setSettlementReward(data?.add_item ?? {});
        setMedalReward(data?.medal_count ?? -1);
      }, playerID));
      NetTableListenerIDs.push(useNetTableKey("common", "game_state", data => {
        if (data.state == "GameState_None") {
          setSettlementScoreData();
          setDoubleScoreProp([]);
          setProtectedScoreProp([]);
        }
      }));
      GameEventIDs.push(useNetData("player_ornament", data => {
        libs.batch(() => {
          const courierList = getOrnamentWithType(data, OrnamentType.COURIER_SKIN);
          for (const courierID in courierList) {
            const courierData = courierList[courierID];
            if (courierData.equip == 1) {
              setCourierName(courierID);
              break;
            }
          }
          setPlayerOrnamentHero(getOrnamentWithType(data, OrnamentType.HERO_SKIN));
        });
      }, Players.GetLocalPlayer()));
      GameEventIDs.push(useNetData("player_active_box", data => {
        if (data.settlement_gain_count && data.settlement_gain_count > 0) {
          serverRequest("box_open", {
            bid: 2000098,
            pool: 93000001,
            amounts: data.settlement_gain_count
          }, data => {
            if (data.status == 0 && data?.data != undefined) {
              clientSideEvent("active_draw_box", data.data);
              GameEvents.SendEventClientSide("custom_ui_toggle_windows", {
                window_name: "MenuButton_active_star",
                state: 1
              });
            } else {
              console.log("fail");
            }
          });
        }
      }, Players.GetLocalPlayer()));
      NetTableListenerIDs.push(useNetTableKeyHasDefaultValue("player_data", playerID.toString(), data => {
        setPlayerRank(data.rank);
        if (show()) {
          updatePlayerDataInfo(data);
        }
      }));
      NetTableListenerIDs.push(useNetTableKey("common", "player_privilege", data => {
        if (data) {
          setPlayerPrivilege(data?.[playerID]);
        }
      }));
      NetTableListenerIDs.push(useNetTableKey("common", "game_state", data => {
        setEnd(data.state == "GameState_End");
        if (data.state == "GameState_None") {
          setShow(false);
        }
      }));
      libs.onCleanup(() => {
        GameEventIDs.forEach(id => {
          GameEvents.Unsubscribe(id);
        });
        NetTableListenerIDs.forEach(id => {
          CustomNetTables.UnsubscribeNetTableListener(id);
        });
      });
    });
    const [gradientShow, setGradientShow] = libs.createSignal(false);
    const [gradientShowClass, setGradientShowClass] = libs.createSignal("");
    libs.createEffect(() => {
      if (gradientShow() && showPlayerQuestionnaire()) {
        showPopup("PlayerQuestionnaire", {});
      }
    });
    libs.createEffect(libs.on(show, _show => {
      if (_show) {
        let duration = 1;
        if (end()) {
          setGradientShowClass("GameEnd");
          duration = 0.7;
        } else {
          setGradientShowClass("PlayerEnd");
        }
        $.Schedule(duration, () => {
          setGradientShow(true);
          setGradientShowClass("");
        });
        const player_data = CustomNetTables.GetTableValue("player_data", Players.GetLocalPlayer().toString());
        if (player_data) {
          updatePlayerDataInfo(player_data);
        }
      } else {
        setGradientShowClass("");
        setGradientShow(false);
      }
    }));
    return (() => {
      const _el$ = libs.createElement("Panel", {}, null);
      libs.setProp(_el$, "onactivate", () => {});
      libs.insert(_el$, libs.createComponent(libs.Show, {
        get when() {
          return gradientShow();
        },
        get children() {
          return [libs.createComponent(PlayerEndMain, {
            get rank_score_data() {
              return settlementScoreData();
            },
            get courierName() {
              return courierName();
            },
            get heroSkinID() {
              return heroSkinID();
            },
            get medal_reward() {
              return medal_reward();
            },
            get goldCoinBonus() {
              return goldCoinBonus();
            },
            get settlement_reward() {
              return settlement_reward();
            },
            get rank() {
              return playerRank();
            },
            get heroName() {
              return heroName();
            }
          }), libs.createComponent(RankChange, {
            get rank_score_data() {
              return settlementScoreData();
            }
          })];
        }
      }));
      libs.effect(_$p => libs.setProp(_el$, "className", libs.classNames("EndScreenRoot", gradientShowClass(), {
        EndScreenShow: show()
      }), _$p));
      return _el$;
    })();
  };
  const PlayerEndMain = props => {
    const gameSeason = game_utils.GetGameSeason();
    const hid = () => KeyValues.UnitsCommonKv[props?.heroName ?? ""]?.Hid ?? -1;
    const leaderRank = () => finiteNumber(Number(props.rank_score_data?.leaderboard_rank), -1);
    const rank = () => props?.rank ?? -1;
    const sLanguage = $.Language().toLowerCase();
    const settlementItemSortWeight = {
      ["9310017"]: 101,
      ["1100001"]: 100,
      ["6100001"]: 99
    };
    const settlementList = () => Object.keys(props.settlement_reward).sort((a, b) => {
      const weight_a = settlementItemSortWeight[a] ?? 0;
      const weight_b = settlementItemSortWeight[b] ?? 0;
      return weight_b - weight_a;
    });
    const [rankScore, setRankScore] = libs.createSignal(-1);
    const rankInfo = libs.createMemo(() => getRankInfo(rankScore()));
    libs.createEffect(libs.on(gameSeason, game_season => {
      const data = getServiceNetTable("player_rank_score", Players.GetLocalPlayer());
      if (data && data[game_season]) {
        setRankScore(data[game_season].now_rank_score);
      }
    }));
    const nowScore = () => finiteNumber(Number(props.rank_score_data?.now_rank_score));
    const originScore = () => finiteNumber(Number(props.rank_score_data?.origin_rank_score));
    const projected = () => finiteNumber(Number(props.rank_score_data?.projected)) == 1;
    const changedScore = () => nowScore() - originScore();
    const fixedInfoModifyScore = () => {
      return changedScore();
    };
    const getRegameAmounts = () => {
      let c = 0;
      const data = CustomNetTables.GetAllTableValues("player_data");
      if (data) {
        Object.values(data).forEach(v => {
          if (v.value.regame_state == 1) {
            c++;
          }
        });
      }
      return c;
    };
    const [regameAmounts, setRegameAmounts] = libs.createSignal(getRegameAmounts());
    const [matchPlayerAmounts, setMatchPlayerAmounts] = libs.createSignal(8);
    const restartGameText = () => {
      return $.Localize("#EndScreen_RestartGame") + `(<font color='#6cd4b1'>${regameAmounts()}</font>/${Math.max(1, Math.floor(matchPlayerAmounts() / 2))})`;
    };
    const showPeakScore = libs.createMemo(() => {
      return props.rank_score_data?.origin_kings_score != undefined && props.rank_score_data?.now_kings_score != undefined;
    });
    libs.createEffect(() => {
      console.log("showPeakScore", props.rank_score_data);
    });
    const [peakScoreCount, setPeakScoreCount] = libs.createSignal(0);
    const [kingsRankState, setKingRankState] = libs.createSignal(true);
    const peakScore = () => props.rank_score_data?.now_kings_score ?? -1;
    const [activityList, setActivityList] = libs.createSignal([]);
    libs.onMount(() => {
      const GameEventListenerIDs = [];
      const NetTableListenerIDs = [];
      NetTableListenerIDs.push(useSyncDataKey("common", "bounty_competition_mode", data => {
        setKingRankState(data?.state == true);
      }));
      NetTableListenerIDs.push(useServiceNetTable("player_rank_score", data => {
        if (data && data[gameSeason()]) {
          setRankScore(data[gameSeason()].now_rank_score);
        }
      }, Players.GetLocalPlayer()));
      NetTableListenerIDs.push(CustomNetTables.SubscribeNetTableListener("player_data", (_, playerID, data) => {
        setRegameAmounts(getRegameAmounts());
      }));
      NetTableListenerIDs.push(useNetTableKeyHasDefaultValue("common", "match_player_amounts", data => {
        setMatchPlayerAmounts(data?.count ?? 8);
      }));
      GameEventListenerIDs.push(useClientGlobalData("peak_sign_up_info", data => {
        if (data.count != undefined) {
          setPeakScoreCount(data.count);
        }
      }));
      GameEventListenerIDs.push(useNetData("info_activity_data", data => {
        let now = Math.floor(Date.now() / 1000);
        let filterList = [];
        for (const activityInfo of data) {
          if (now < activityInfo.start_time) {
            continue;
          }
          if (activityInfo.end_time > now || activityInfo.end_time == 0) {
            filterList.push(activityInfo.activity_id);
          }
        }
        setActivityList(filterList);
      }));
      libs.onCleanup(() => {
        GameEventListenerIDs.forEach(id => GameEvents.Unsubscribe(id));
        NetTableListenerIDs.forEach(id => CustomNetTables.UnsubscribeNetTableListener(id));
      });
    });
    const GainMedalShow = () => {
      return props.rank_score_data != undefined;
    };
    const [HasNewRegressionPlayer, setHasNewRegressionPlayer] = libs.createSignal(false);
    netdata_utils.createNetDataEffect("match_new_regression_players", data => {
      if (data && (data?.new_players != undefined || data?.regression_players != undefined)) {
        setHasNewRegressionPlayer(true);
      } else {
        setHasNewRegressionPlayer(false);
      }
    });
    let _time = getPeakScoreRegionTime();
    let PeakScoreEnable = false;
    let server_time = ServerTimestamp();
    if (server_time >= _time.start_time && server_time < _time.end_time) {
      PeakScoreEnable = true;
    }
    return (() => {
      const _el$2 = libs.createElement("Panel", {}, null);
      libs.insert(_el$2, libs.createComponent(EOM_Panel.EOM_Panel, {
        id: "RankAndRewards",
        get children() {
          return [libs.createComponent(EOM_Panel.EOM_Panel, {
            id: "RankInfo",
            get children() {
              return [libs.createComponent(EOM_Panel.EOM_Panel, {
                get className() {
                  return libs.classNames("RankIcon", {
                    Higher: rank() <= 3
                  });
                },
                get children() {
                  return libs.createComponent(GenericPanel.CLabel, {
                    get text() {
                      return rank();
                    }
                  });
                }
              }), libs.createComponent(EOM_Panel.EOM_Panel, {
                id: "RankLabels",
                get children() {
                  return [libs.createComponent(GenericPanel.CLabel, {
                    id: "RankTitle",
                    text: "#player_rank",
                    get dialogVariables() {
                      return {
                        rank: rank()
                      };
                    }
                  }), libs.createComponent(libs.Switch, {
                    fallback: () => libs.createComponent(GenericPanel.CLabel, {
                      id: "EncouragementText",
                      className: sLanguage,
                      text: "#EndScreen_PlayerEnd4",
                      html: true
                    }),
                    get children() {
                      return [libs.createComponent(libs.Match, {
                        get when() {
                          return rank() == 1;
                        },
                        get children() {
                          return libs.createComponent(GenericPanel.CLabel, {
                            id: "EncouragementText",
                            className: sLanguage,
                            text: "#EndScreen_PlayerEnd1",
                            html: true
                          });
                        }
                      }), libs.createComponent(libs.Match, {
                        get when() {
                          return rank() == 2;
                        },
                        get children() {
                          return libs.createComponent(GenericPanel.CLabel, {
                            id: "EncouragementText",
                            className: sLanguage,
                            text: "#EndScreen_PlayerEnd2",
                            html: true
                          });
                        }
                      }), libs.createComponent(libs.Match, {
                        get when() {
                          return rank() == 3;
                        },
                        get children() {
                          return libs.createComponent(GenericPanel.CLabel, {
                            id: "EncouragementText",
                            className: sLanguage,
                            text: "#EndScreen_PlayerEnd3",
                            html: true
                          });
                        }
                      })];
                    }
                  })];
                }
              }), libs.memo(() => libs.memo(() => !!showRankScore())() ? libs.createComponent(EOM_Panel.EOM_Panel, {
                className: "GainMedalContainer",
                get visible() {
                  return GainMedalShow();
                },
                get children() {
                  return [libs.createComponent(EOM_Icon.EOM_Icon, {
                    size: "96",
                    get src() {
                      return getSrcPath("icon/icon_rank_cup.png");
                    }
                  }), libs.createComponent(libs.Show, {
                    get when() {
                      return fixedInfoModifyScore() != undefined;
                    },
                    get children() {
                      return [libs.createComponent(EOM_Panel.EOM_Panel, {
                        id: "MedalAmounts",
                        get children() {
                          return libs.createComponent(GenericPanel.CLabel, {
                            get className() {
                              return libs.classNames({
                                Up: fixedInfoModifyScore() > 0,
                                Down: fixedInfoModifyScore() < 0
                              });
                            },
                            get text() {
                              return libs.memo(() => fixedInfoModifyScore() == 0)() ? `-${fixedInfoModifyScore()}` : libs.memo(() => fixedInfoModifyScore() > 0)() ? `+${fixedInfoModifyScore()}` : fixedInfoModifyScore();
                            }
                          });
                        }
                      }), libs.createComponent(EOM_Panel.EOM_Panel, {
                        get visible() {
                          return projected();
                        },
                        className: "TierProtect",
                        get children() {
                          return libs.createComponent(GenericPanel.CLabel, {
                            text: "#RankProtected"
                          });
                        }
                      })];
                    }
                  })];
                }
              }) : libs.createComponent(EOM_Panel.EOM_Panel, {
                className: "GainMedalContainer",
                id: "Medal",
                get visible() {
                  return props.medal_reward > 0;
                },
                get children() {
                  return [libs.createComponent(EOM_Icon.EOM_Icon, {
                    size: "128",
                    get src() {
                      return getSrcPath("icon/medal_larger.png");
                    }
                  }), libs.createComponent(EOM_Panel.EOM_Panel, {
                    id: "MedalAmounts",
                    get children() {
                      return libs.createComponent(GenericPanel.CLabel, {
                        get text() {
                          return `+${props.medal_reward}`;
                        }
                      });
                    }
                  })];
                }
              }))];
            }
          }), libs.createComponent(profile_info.ProfileInfo, {
            get player_id() {
              return Players.GetLocalPlayer();
            }
          }), libs.createComponent(EOM_Panel.EOM_Panel, {
            get visible() {
              return settlementList().length > 0 || props.medal_reward > 0;
            },
            id: "RewardInfo",
            get children() {
              return [libs.createComponent(GenericPanel.CLabel, {
                id: "RewardTitle",
                text: "#EndScreen_Rewards"
              }), libs.createComponent(EOM_Separator.EOM_Separator, {}), libs.createComponent(EOM_Panel.EOM_Panel, {
                id: "RewardList",
                scroll: "y",
                get children() {
                  return [libs.createComponent(libs.Show, {
                    get when() {
                      return props.medal_reward && props.medal_reward > 0;
                    },
                    get children() {
                      return libs.createComponent(EOM_Panel.EOM_Panel, {
                        get className() {
                          return libs.classNames("RewardRow");
                        },
                        get children() {
                          return [libs.createComponent(EOM_Panel.EOM_Panel, {
                            className: "ProductImage",
                            get backgroundImage() {
                              return getImagePath("icon/medal.png");
                            },
                            onmouseover: self => {
                              $.DispatchEvent("DOTAShowTitleTextTooltip", self, "#SummaryMedal", "#SummaryMedal_description");
                            },
                            onmouseout: self => {
                              $.DispatchEvent("DOTAHideTitleTextTooltip", self);
                            }
                          }), libs.createComponent(GenericPanel.CLabel, {
                            className: "ProductCount",
                            get text() {
                              return "×" + props.medal_reward;
                            }
                          })];
                        }
                      });
                    }
                  }), libs.createComponent(libs.For, {
                    get each() {
                      return settlementList();
                    },
                    children: (itemID, index) => {
                      const count = () => props.settlement_reward?.[Number(itemID)] ?? 0;
                      const isGoldCoin = itemID == "1100001";
                      return libs.createComponent(EOM_Panel.EOM_Panel, {
                        get className() {
                          return libs.classNames("RewardRow");
                        },
                        get children() {
                          return [libs.createComponent(EOM_Image.EOM_Image, {
                            className: "ProductImage",
                            get src() {
                              return getProductSrc(itemID);
                            },
                            onmouseover: self => {
                              $.DispatchEvent("DOTAShowTitleTextTooltip", self, "#" + itemID, "#" + itemID + "_description");
                            },
                            onmouseout: self => {
                              $.DispatchEvent("DOTAHideTitleTextTooltip", self);
                            }
                          }), libs.createComponent(GenericPanel.CLabel, {
                            className: "ProductCount",
                            get text() {
                              return "×" + count();
                            }
                          }), libs.createComponent(libs.Switch, {
                            get children() {
                              return [libs.createComponent(libs.Match, {
                                get when() {
                                  return isGoldCoin && props.goldCoinBonus;
                                },
                                get children() {
                                  return libs.createComponent(EOM_Panel.EOM_Panel, {
                                    className: "VipBonusLabel",
                                    get children() {
                                      return [libs.createComponent(EOM_Icon.EOM_Icon, {
                                        size: "16",
                                        get src() {
                                          return getSrcPath("icon/icon_arrow_vip.png");
                                        }
                                      }), libs.createComponent(GenericPanel.CLabel, {
                                        text: "20%"
                                      }), libs.createComponent(EOM_Icon.EOM_Icon, {
                                        size: "24",
                                        get src() {
                                          return getSrcPath("icon/vip_icon_smallest.png");
                                        }
                                      })];
                                    }
                                  });
                                }
                              }), libs.createComponent(libs.Match, {
                                when: itemID == "1100083",
                                get children() {
                                  return [libs.createComponent(libs.Show, {
                                    get when() {
                                      return HasNewRegressionPlayer();
                                    },
                                    get children() {
                                      return libs.createComponent(NewRegressionIcon.NewRegressionIcon, {
                                        tooltip_text: "#Activity_PDD_extra_drop",
                                        marginLeft: "10px",
                                        verticalAlign: "center"
                                      });
                                    }
                                  }), libs.createComponent(EOM_Button.EOM_Button, {
                                    id: "Activity_PDDJumpButton",
                                    text: "#Activity_PDD_Jump",
                                    onactivate: () => {
                                      clientSideEvent("switchActivityTag", {
                                        id: "20001"
                                      });
                                      ToggleWindows('MenuButton_activity', true);
                                    }
                                  })];
                                }
                              })];
                            }
                          })];
                        }
                      });
                    }
                  })];
                }
              })];
            }
          })];
        }
      }), null);
      libs.insert(_el$2, libs.createComponent(EOM_Panel.EOM_Panel, {
        id: "HeroAndCourier",
        hittest: false,
        get children() {
          return [libs.createComponent(libs.Show, {
            get when() {
              return props.heroSkinID;
            },
            get children() {
              return libs.createComponent(EOM_PortraitFullBody.EOM_PortraitFullBody, {
                get className() {
                  return libs.classNames({
                    HorizontalMirror: !LeftHeroList.includes(hid())
                  });
                },
                id: "Hero",
                showPedestal: false,
                allowrotation: false,
                get unitname() {
                  return props.heroSkinID;
                }
              });
            }
          }), libs.createComponent(libs.Show, {
            get when() {
              return props.courierName;
            },
            get children() {
              return libs.createComponent(EOM_PortraitFullBody.EOM_PortraitFullBody, {
                id: "Courier",
                showPedestal: false,
                allowrotation: false,
                get unitname() {
                  return props.courierName;
                }
              });
            }
          })];
        }
      }), null);
      libs.insert(_el$2, libs.createComponent(EOM_Panel.EOM_Panel, {
        id: "PlayerRankScore",
        get children() {
          return [libs.createComponent(libs.Show, {
            get when() {
              return showRankScore();
            },
            get children() {
              return [libs.createComponent(RankTierIcon.RankTierIcon, {
                get rank_score() {
                  return rankScore();
                },
                get rank() {
                  return leaderRank();
                },
                show_title: true,
                size: "300"
              }), libs.createComponent(EOM_Panel.EOM_Panel, {
                id: "RankScoreMedal",
                get children() {
                  return [libs.createComponent(EOM_Icon.EOM_Icon, {
                    size: "48",
                    get src() {
                      return getSrcPath("icon/icon_rank_cup.png");
                    }
                  }), libs.createComponent(libs.Show, {
                    get when() {
                      return rankInfo().score_up == 0;
                    },
                    fallback: () => libs.createComponent(EOM_Panel.EOM_Panel, {
                      id: "RankScoreProgressBar",
                      get children() {
                        return [libs.createComponent(EOM_Panel.EOM_Panel, {
                          id: "RankScoreProgressBarUpper",
                          get children() {
                            return libs.createComponent(EOM_Panel.EOM_Panel, {
                              backgroundColor: "#fff",
                              height: "100%",
                              get width() {
                                return `${rankInfo().rela_score / Math.max(rankInfo().score_up, 1) * 100}%`;
                              }
                            });
                          }
                        }), libs.createComponent(GenericPanel.CLabel, {
                          get text() {
                            return `${rankInfo().rela_score}/${rankInfo().score_up}`;
                          }
                        })];
                      }
                    }),
                    get children() {
                      return libs.createComponent(EOM_Panel.EOM_Panel, {
                        id: "RankScoreMedalInfo",
                        get children() {
                          return libs.createComponent(GenericPanel.CLabel, {
                            get text() {
                              return rankInfo().rela_score;
                            }
                          });
                        }
                      });
                    }
                  }), libs.createComponent(EOM_Panel.EOM_Panel, {
                    id: "PropEffect",
                    get children() {
                      return libs.createComponent(libs.Switch, {
                        get children() {
                          return [libs.createComponent(libs.Match, {
                            get when() {
                              return doubleScoreProp().length > 0;
                            },
                            get children() {
                              return libs.createComponent(libs.Index, {
                                get each() {
                                  return doubleScoreProp();
                                },
                                children: (id, i) => libs.createComponent(ProductImage.ProductImage, {
                                  get itemid() {
                                    return id();
                                  },
                                  count: 1
                                })
                              });
                            }
                          }), libs.createComponent(libs.Match, {
                            get when() {
                              return protectedScoreProp().length > 0;
                            },
                            get children() {
                              return libs.createComponent(libs.Index, {
                                get each() {
                                  return protectedScoreProp();
                                },
                                children: (id, i) => libs.createComponent(ProductImage.ProductImage, {
                                  get itemid() {
                                    return id();
                                  },
                                  count: 1
                                })
                              });
                            }
                          })];
                        }
                      });
                    }
                  })];
                }
              }), libs.createComponent(libs.Show, {
                get when() {
                  return rankAlarm() < 1;
                },
                get children() {
                  return libs.createComponent(EOM_Panel.EOM_Panel, {
                    id: "RankAlarm",
                    tooltip_text: "#RankAlarm",
                    get dialogVariables() {
                      return {
                        value: (1 - rankAlarm()) * 100
                      };
                    },
                    get children() {
                      return [libs.createElement("Image", {
                        "class": "Alarm"
                      }, null), libs.createComponent(EOM_Panel.EOM_Panel, {
                        id: "AlarmLabel",
                        get children() {
                          return libs.createComponent(GenericPanel.CLabel, {
                            text: "#RankDifference"
                          });
                        }
                      })];
                    }
                  });
                }
              })];
            }
          }), libs.createComponent(libs.Show, {
            get when() {
              return libs.memo(() => !!kingsRankState())() && showPeakScore();
            },
            get children() {
              return libs.createComponent(EOM_Panel.EOM_Panel, {
                get className() {
                  return libs.classNames("PeakScore", {
                    NoRankScore: !showRankScore()
                  });
                },
                get children() {
                  return [libs.createComponent(EOM_Icon.EOM_Icon, {
                    id: "PeakScoreIcon",
                    get src() {
                      return getSrcPath("bountyentry/s14_bounty_icon_large.png");
                    },
                    onmouseover: self => {
                      $.DispatchEvent("DOTAShowTitleTextTooltip", self, "#BountyScore", "#BountyScore_description");
                    },
                    onmouseout: self => {
                      $.DispatchEvent("DOTAHideTitleTextTooltip", self);
                    }
                  }), libs.createComponent(EOM_Panel.EOM_Panel, {
                    className: "PeakScoreLabel",
                    get children() {
                      return libs.createComponent(EOM_Label.EOM_Label, {
                        get text() {
                          return libs.memo(() => peakScore() == -1)() ? "???" : peakScore();
                        }
                      });
                    }
                  })];
                }
              });
            }
          }), libs.createComponent(libs.Show, {
            get when() {
              return libs.memo(() => !!isKingsRankMode())() && showPeakScore();
            },
            get children() {
              return libs.createComponent(EOM_Panel.EOM_Panel, {
                className: "PeakScore",
                get children() {
                  return [libs.createComponent(EOM_Icon.EOM_Icon, {
                    id: "PeakScoreIcon",
                    get src() {
                      return getSrcPath("icon/peak_score_icon.png");
                    },
                    onmouseover: self => {
                      $.DispatchEvent("DOTAShowTitleTextTooltip", self, "#PeakScore", "#PeakScore_description");
                    },
                    onmouseout: self => {
                      $.DispatchEvent("DOTAHideTitleTextTooltip", self);
                    }
                  }), libs.createComponent(EOM_Panel.EOM_Panel, {
                    className: "PeakScoreLabel",
                    get children() {
                      return libs.createComponent(EOM_Label.EOM_Label, {
                        get text() {
                          return libs.memo(() => peakScore() == -1)() ? "???" : peakScore();
                        }
                      });
                    }
                  })];
                }
              });
            }
          })];
        }
      }), null);
      libs.insert(_el$2, libs.createComponent(EOM_Panel.EOM_Panel, {
        id: "EndScreenButtons",
        get children() {
          return [libs.createComponent(EOM_Button.EOM_BaseButton, {
            id: "FeedBackButton",
            onactivate: () => showPopup("Feedback", {}),
            tooltip_text: "#Feedback_Title"
          }), libs.createComponent(EOM_Button.EOM_Button, {
            color: "Blue",
            onactivate: () => {
              GameEvents.SendCustomEventToServer("regame_request", {});
              setShow(false);
            },
            get text() {
              return restartGameText();
            }
          }), libs.createComponent(EOM_Button.EOM_Button, {
            color: "Gold",
            onactivate: () => {
              if (getPlayerData(Players.GetLocalPlayer(), "regame_state") == 1) {
                GameEvents.SendCustomEventToServer("regame_request", {});
              }
              setShow(false);
            },
            text: "#Popup_Button_Confirm",
            html: true
          })];
        }
      }), null);
      libs.insert(_el$2, libs.createComponent(EOM_Panel.EOM_Panel, {
        id: "Advertisements",
        get children() {
          return [libs.createComponent(libs.Show, {
            when: T11LinkageEnable,
            get children() {
              return libs.createComponent(EOM_Button.EOM_BaseButton, {
                id: "ToT11Btn",
                "class": sLanguage,
                onactivate: () => {
                  $.DispatchEvent('DOTAShowCustomGamePage', 3591915450);
                  $.DispatchEvent('DOTASubscribeToCustomGame', 3591915450);
                }
              });
            }
          }), libs.createComponent(libs.Show, {
            when: T12LinkageEnable,
            get children() {
              return libs.createComponent(EOM_Button.EOM_Button, {
                id: "ToT12Btn",
                text: "#ToT12BtnText",
                onactivate: () => {
                  $.DispatchEvent('DOTAShowCustomGamePage', 3516074756);
                  $.DispatchEvent('DOTASubscribeToCustomGame', 3516074756);
                }
              });
            }
          }), libs.createComponent(libs.Show, {
            when: C1LinkageEnable,
            get children() {
              return libs.createComponent(EOM_Button.EOM_Button, {
                id: "ToC1Btn",
                text: "#ToC1BtnTextEnd",
                onactivate: () => {
                  $.DispatchEvent('DOTAShowCustomGamePage', 2331812965);
                  $.DispatchEvent('DOTASubscribeToCustomGame', 2331812965);
                }
              });
            }
          }), libs.createComponent(libs.Switch, {
            get children() {
              return [libs.createComponent(libs.Match, {
                get when() {
                  return libs.memo(() => !!isKingsRankMode())() && peakScoreCount() >= 5;
                },
                get children() {
                  return libs.createComponent(EOM_Button.EOM_BaseButton, {
                    id: "PeakCupRegion",
                    onactivate: () => {},
                    get children() {
                      return libs.createComponent(EOM_Label.EOM_Label, {
                        id: "PeakCupRegionLabel",
                        text: "#SelectRegion"
                      });
                    }
                  });
                }
              }), libs.createComponent(libs.Match, {
                get when() {
                  return libs.memo(() => !!(PeakScoreEnable && isRankMode()))() && rankScore() >= 15200;
                },
                get children() {
                  return libs.createComponent(EOM_Panel.EOM_Panel, {
                    id: "PeakCupInvitationContainer",
                    hittest: false,
                    get children() {
                      return [libs.createElement("DOTAParticleScenePanel", {
                        id: "PeakCupInvitationParticle2",
                        hittest: false,
                        particleName: "particles/eom/ui/ui_fx/ui_fx_s2_start_game.vpcf",
                        cameraOrigin: "-2 0 400",
                        lookAt: "-2 0 0",
                        fov: 45,
                        particleonly: true
                      }, null), libs.createComponent(EOM_Button.EOM_BaseButton, {
                        id: "PeakCupInvitation",
                        onactivate: () => {
                          showPopup("PeakArena", {});
                        },
                        get children() {
                          return [libs.createComponent(EOM_Image.EOM_Image, {
                            id: "PeakCupInvitationBG"
                          }), libs.createComponent(EOM_Label.EOM_Label, {
                            id: "PeakCupInvitationLabel",
                            text: "#Activity_Dianfengsai_Invitation"
                          })];
                        }
                      }), libs.createElement("DOTAParticleScenePanel", {
                        id: "PeakCupInvitationParticle",
                        hittest: false,
                        particleName: "particles/eom/ui/ui_fx/ui_fx_s2_start_game_03.vpcf",
                        cameraOrigin: "-2 0 400",
                        lookAt: "-2 0 0",
                        fov: 45,
                        particleonly: true
                      }, null)];
                    }
                  });
                }
              })];
            }
          })];
        }
      }), null);
      libs.effect(_$p => libs.setProp(_el$2, "className", libs.classNames("PlayerEndMain"), _$p));
      return _el$2;
    })();
  };
  const animationDuration = 1;
  const RankChange = props => {
    const [changing, setChanging] = libs.createSignal(false);
    const nowScore = () => finiteNumber(Number(props.rank_score_data?.now_rank_score));
    const originScore = () => finiteNumber(Number(props.rank_score_data?.origin_rank_score));
    const leaderRank = () => finiteNumber(Number(props.rank_score_data?.leaderboard_rank), -1);
    const nowTier = () => getRankInfo(nowScore()).tier;
    const oldTier = () => getRankInfo(originScore()).tier;
    const nowNum = () => getRankInfo(nowScore()).num;
    const oldNum = () => getRankInfo(originScore()).num;
    const [currentScore, setCurrentScore] = libs.createSignal(originScore());
    const scoreDiff = () => nowScore() - originScore();
    const [upgrading, setUpgrading] = libs.createSignal(false);
    const projected = () => finiteNumber(Number(props.rank_score_data?.projected)) == 1;
    const rankShow = () => showRankScore() && props.rank_score_data != undefined && (originScore() != nowScore() || projected());
    const kingScoreShow = () => (props.rank_score_data?.now_kings_score ?? 0) != (props.rank_score_data?.origin_kings_score ?? 0);
    const [scoreChangeeShow, setScoreChangeShow] = libs.createSignal(rankShow() || kingScoreShow());
    const showPeakScore = libs.createMemo(() => {
      return props.rank_score_data?.origin_kings_score != undefined && props.rank_score_data?.now_kings_score != undefined;
    });
    const peakScore = () => props.rank_score_data?.now_kings_score ?? -1;
    const peakScoreDiff = libs.createMemo(() => {
      if (showPeakScore()) {
        return (props.rank_score_data?.now_kings_score ?? 0) - Math.max(0, props.rank_score_data?.origin_kings_score ?? 0);
      }
      return 0;
    });
    const [scoreCardInfo, setScoreCardInfo] = libs.createSignal({});
    const canUseScoreCard = () => {
      return !scoreCardUsed() && scoreDiff() != 0;
    };
    const updateScoreCardInfo = data => {
      const info = {};
      if (data) {
        Object.entries(data).map(([id, v], index) => {
          if (info[v.prop_id] == undefined) {
            if (v.prop_id == 9310015) {
              info[v.prop_id] = id;
            } else if (v.prop_id == 9310016) {
              info[v.prop_id] = id;
            }
          }
        });
      }
      setScoreCardInfo(info);
    };
    let rankChangeRoot;
    libs.createEffect(libs.on(currentScore, current_score => {
      if (rankShow() && !upgrading()) Game.EmitSound("Item.PickUpGemShop");
    }));
    libs.createEffect(libs.on(() => props.rank_score_data, data => {
      setScoreChangeShow(rankShow() || kingScoreShow());
    }));
    const upgrade = () => {
      if (nowNum() == oldNum() && oldTier() == nowTier()) return;
      const current_originScore = originScore();
      const current_nowScore = nowScore();
      const up = current_nowScore > current_originScore;
      if (rankChangeRoot && rankChangeRoot?.IsValid()) {
        let animationRoot = rankChangeRoot.FindChild("AnimationRoot");
        let particleRoot = rankChangeRoot.FindChild("ParticleRoot");
        if (animationRoot && animationRoot?.IsValid()) {
          let soundIndex = -1;
          let seq = new RunSequentialActions();
          if (up) {
            setUpgrading(true);
            let rep_1 = [];
            let rep_2;
            seq.actions.push(new RunFunctionAction(() => {
              soundIndex = Game.EmitSound("ui.treasure.underscore");
              if (animationRoot && animationRoot?.IsValid()) {
                animationRoot.RemoveAndDeleteChildren();
                if (animationRoot && animationRoot?.IsValid()) {
                  rep_2 = $.CreatePanel("Panel", animationRoot, "");
                  rep_2.style.width = "100%";
                  rep_2.style.height = "100%";
                  libs.render(() => libs.createComponent(RankTierIcon.RankTierIcon, {
                    className: "UpgradeUpNewInit",
                    rank_score: current_nowScore,
                    get rank() {
                      return leaderRank();
                    }
                  }), rep_2);
                }
                for (let i = 0; i < 10; i++) {
                  let p = $.CreatePanel("Panel", animationRoot, "");
                  rep_1.push(p);
                  p.style.width = "100%";
                  p.style.height = "100%";
                  libs.render(() => libs.createComponent(RankTierIcon.RankTierIcon, {
                    className: "UpgradeUpOldInit",
                    rank_score: current_originScore,
                    get rank() {
                      return leaderRank();
                    }
                  }), p);
                }
              }
            }));
            seq.actions.push(new WaitAction(0.5));
            seq.actions.push(new RunFunctionAction(() => {
              if (particleRoot && particleRoot?.IsValid()) {
                libs.render(() => libs.createElement("DOTAParticleScenePanel", {
                  id: "ScenePanel",
                  particleName: "particles/eom/ui/settlement_fx/settlement_fx_1.vpcf",
                  cameraOrigin: "0 0 800",
                  lookAt: "0 0 0",
                  fov: "60",
                  hittest: false
                }, null), particleRoot);
              }
            }));
            seq.actions.push(new WaitAction(0.1));
            seq.actions.push(new RunFunctionAction(() => {
              rep_1.forEach((p, i) => {
                if (p && p?.IsValid()) {
                  let icon = p.GetChild(0);
                  if (icon && icon?.IsValid()) {
                    icon.AddClass("UpgradeUpOldSplitOut" + i);
                  }
                }
              });
              if (soundIndex != -1) {
                Game.StopSound(soundIndex);
              }
              if (rep_2 && rep_2?.IsValid()) {
                let icon = rep_2.FindChildrenWithClassTraverse("RankTierIcon")[0];
                if (icon) {
                  icon.AddClass("UpgradeUpNewShow");
                  Game.EmitSound("ui.badge_levelup");
                }
              }
            }));
            seq.actions.push(new WaitAction(0.4));
            seq.actions.push(new RunFunctionAction(() => {
              if (rep_2 && rep_2?.IsValid()) {
                let icon2 = rep_2.FindChildrenWithClassTraverse("RankTierIcon")[0];
                if (icon2) {
                  icon2.AddClass("UpgradeUpNewShining");
                }
              }
            }));
            seq.actions.push(new WaitAction(0.7));
            seq.actions.push(new RunFunctionAction(() => {
              setUpgrading(false);
            }));
            seq.actions.push(new WaitAction(0.3));
            seq.actions.push(new RunFunctionAction(() => {
              if (rep_2 && rep_2?.IsValid()) {
                let icon2 = rep_2.FindChildrenWithClassTraverse("RankTierIcon")[0];
                if (icon2) {
                  icon2.RemoveClass("UpgradeUpNewShow");
                }
              }
            }));
            seq.actions.push(new WaitAction(0.2));
            seq.actions.push(new RunFunctionAction(() => {
              if (animationRoot && animationRoot?.IsValid()) {
                animationRoot.RemoveAndDeleteChildren();
              }
            }));
            RunSingleAction(seq);
          } else {
            setUpgrading(true);
            let rep_1;
            let rep_2;
            seq.actions.push(new RunFunctionAction(() => {
              soundIndex = Game.EmitSound("ui.treasure.underscore");
              if (animationRoot && animationRoot?.IsValid()) {
                animationRoot.RemoveAndDeleteChildren();
                if (animationRoot && animationRoot?.IsValid()) {
                  rep_2 = $.CreatePanel("Panel", animationRoot, "");
                  rep_2.style.width = "100%";
                  rep_2.style.height = "100%";
                  libs.render(() => libs.createComponent(RankTierIcon.RankTierIcon, {
                    className: "UpgradeUpNewInit",
                    rank_score: current_nowScore,
                    get rank() {
                      return leaderRank();
                    }
                  }), rep_2);
                  rep_1 = $.CreatePanel("Panel", animationRoot, "");
                  rep_1.style.width = "100%";
                  rep_1.style.height = "100%";
                  libs.render(() => libs.createComponent(RankTierIcon.RankTierIcon, {
                    className: "UpgradeDownOldInit",
                    rank_score: current_originScore,
                    get rank() {
                      return leaderRank();
                    }
                  }), rep_1);
                }
              }
            }));
            seq.actions.push(new WaitAction(0.2));
            seq.actions.push(new RunFunctionAction(() => {
              if (soundIndex != -1) {
                Game.StopSound(soundIndex);
              }
              if (rep_1 && rep_1?.IsValid()) {
                let icon = rep_1.FindChildrenWithClassTraverse("RankTierIcon")[0];
                if (icon) {
                  icon.AddClass("UpgradeUpOldOut");
                }
              }
              if (rep_2 && rep_2?.IsValid()) {
                let icon = rep_2.FindChildrenWithClassTraverse("RankTierIcon")[0];
                if (icon) {
                  icon.AddClass("UpgradeUpNewShow");
                  Game.EmitSound("Game_End_Scoreboard_Appear");
                }
              }
              if (particleRoot && particleRoot?.IsValid()) {
                particleRoot.AddClass("Down");
                libs.render(() => [libs.createElement("DOTAParticleScenePanel", {
                  id: "ScenePanel3",
                  particleName: "particles/eom/ui/settlement_fx/settlement_fx_1a.vpcf",
                  cameraOrigin: "0 0 800",
                  lookAt: "0 0 0",
                  fov: "85",
                  hittest: false
                }, null), libs.createElement("DOTAParticleScenePanel", {
                  id: "ScenePanel",
                  particleName: "particles/eom/ui/settlement_fx/downgrade_arrow.vpcf",
                  cameraOrigin: "600 0 0",
                  lookAt: "0 0 0",
                  fov: "25",
                  hittest: false
                }, null), libs.createElement("DOTAParticleScenePanel", {
                  id: "ScenePanel2",
                  particleName: "particles/econ/items/lina/lina_ti6/lina_ti6_laguna_blade_startpoint_halo.vpcf",
                  cameraOrigin: "0 0 900",
                  lookAt: "0 0 -1",
                  fov: "60",
                  hittest: false
                }, null)], particleRoot);
              }
            }));
            seq.actions.push(new WaitAction(0.2));
            seq.actions.push(new RunFunctionAction(() => {
              setUpgrading(false);
            }));
            seq.actions.push(new WaitAction(0.2));
            seq.actions.push(new RunFunctionAction(() => {
              if (animationRoot && animationRoot?.IsValid()) {
                animationRoot.RemoveAndDeleteChildren();
              }
            }));
            RunSingleAction(seq);
          }
        }
      }
    };
    let timer = -1;
    const clearTimers = newScore => {
      if (timer != -1) {
        setChanging(false);
        clearInterval(timer);
        timer = -1;
        upgrade();
        if (newScore) {
          setCurrentScore(newScore);
        }
      }
    };
    const startAnim = () => {
      clearTimers();
      const current_oldScore = originScore();
      const current_newScore = nowScore();
      if (current_newScore == current_oldScore) {
        setCurrentScore(current_newScore);
        return;
      }
      setChanging(true);
      let tickTimer = 10;
      let tick = 0;
      let duration = 0;
      const tickModifyScore = scoreDiff() / (animationDuration / (tickTimer * 0.001));
      timer = setInterval(() => {
        tick += 1;
        duration += tickTimer;
        if (duration >= animationDuration * 1000) {
          clearTimers(current_newScore);
        } else {
          setCurrentScore(Round(current_oldScore + tickModifyScore * tick));
        }
      }, tickTimer);
    };
    libs.onMount(() => {
      const eventIdList = [];
      eventIdList.push(useNetData("player_props", data => {
        updateScoreCardInfo(data);
      }, Players.GetLocalPlayer()));
      libs.onCleanup(() => {
        eventIdList.forEach(id => GameEvents.Unsubscribe(id));
        clearTimers();
      });
    });
    libs.createEffect(libs.on(rankShow, _show => {
      if (!_show) {
        if (rankChangeRoot && rankChangeRoot?.IsValid()) {
          let animationRoot = rankChangeRoot.FindChild("AnimationRoot");
          let particleRoot = rankChangeRoot.FindChild("ParticleRoot");
          if (animationRoot && animationRoot?.IsValid()) {
            animationRoot.RemoveAndDeleteChildren();
          }
          if (particleRoot && particleRoot?.IsValid()) {
            particleRoot.RemoveAndDeleteChildren();
          }
        }
      } else {
        $.Schedule(0.5, () => {
          startAnim();
        });
      }
    }));
    libs.createEffect(libs.on(scoreCardUsed, v => {
      startAnim();
    }));
    const currentRankScoreInfo = libs.createMemo(() => getRankInfo(currentScore()));
    const rankScore = () => changing() ? originScore() : nowScore();
    return (() => {
      const _el$0 = libs.createElement("Panel", {}, null);
      const _ref$ = rankChangeRoot;
      typeof _ref$ === "function" ? libs.use(_ref$, _el$0) : rankChangeRoot = _el$0;
      libs.setProp(_el$0, "onactivate", () => {});
      libs.insert(_el$0, libs.createComponent(EOM_Panel.EOM_Panel, {
        id: "ParticleRoot",
        hittest: false
      }), null);
      libs.insert(_el$0, libs.createComponent(RankTierIcon.RankTierIcon, {
        get className() {
          return libs.classNames({
            Upgrading: upgrading()
          });
        },
        get rank_score() {
          return rankScore();
        },
        get rank() {
          return leaderRank();
        },
        show_title: true
      }), null);
      libs.insert(_el$0, libs.createComponent(EOM_Panel.EOM_Panel, {
        id: "RankScoreMedal",
        get children() {
          return [libs.createComponent(EOM_Icon.EOM_Icon, {
            size: "48",
            get src() {
              return getSrcPath("icon/icon_rank_cup.png");
            }
          }), libs.createComponent(libs.Show, {
            get when() {
              return currentRankScoreInfo().score_up == 0;
            },
            fallback: () => libs.createComponent(EOM_Panel.EOM_Panel, {
              id: "RankScoreProgressBar",
              get children() {
                return [libs.createComponent(EOM_Panel.EOM_Panel, {
                  id: "RankScoreProgressBarUpper",
                  get children() {
                    return libs.createComponent(EOM_Panel.EOM_Panel, {
                      backgroundColor: "#fff",
                      height: "100%",
                      get width() {
                        return `${currentRankScoreInfo().rela_score / Math.max(currentRankScoreInfo().score_up, 1) * 100}%`;
                      }
                    });
                  }
                }), libs.createComponent(GenericPanel.CLabel, {
                  get text() {
                    return `${currentRankScoreInfo().rela_score}/${currentRankScoreInfo().score_up}`;
                  }
                })];
              }
            }),
            get children() {
              return libs.createComponent(EOM_Panel.EOM_Panel, {
                id: "RankScoreMedalInfo",
                get children() {
                  return libs.createComponent(GenericPanel.CLabel, {
                    id: "RankScoreMedalLabel",
                    get text() {
                      return currentRankScoreInfo().rela_score;
                    }
                  });
                }
              });
            }
          }), libs.createComponent(EOM_Panel.EOM_Panel, {
            id: "PropEffect",
            get children() {
              return libs.createComponent(libs.Switch, {
                get children() {
                  return [libs.createComponent(libs.Match, {
                    get when() {
                      return doubleScoreProp().length > 0;
                    },
                    get children() {
                      return libs.createComponent(libs.Index, {
                        get each() {
                          return doubleScoreProp();
                        },
                        children: (id, i) => libs.createComponent(ProductImage.ProductImage, {
                          get itemid() {
                            return id();
                          },
                          count: 1
                        })
                      });
                    }
                  }), libs.createComponent(libs.Match, {
                    get when() {
                      return protectedScoreProp().length > 0;
                    },
                    get children() {
                      return libs.createComponent(libs.Index, {
                        get each() {
                          return protectedScoreProp();
                        },
                        children: (id, i) => libs.createComponent(ProductImage.ProductImage, {
                          get itemid() {
                            return id();
                          },
                          count: 1
                        })
                      });
                    }
                  })];
                }
              });
            }
          })];
        }
      }), null);
      libs.insert(_el$0, libs.createComponent(EOM_Panel.EOM_Panel, {
        get visible() {
          return libs.memo(() => !!(projected() && !changing()))() && !upgrading();
        },
        className: "TierProtect",
        get children() {
          return libs.createComponent(GenericPanel.CLabel, {
            text: "#RankProtected"
          });
        }
      }), null);
      libs.insert(_el$0, libs.createComponent(EOM_Panel.EOM_Panel, {
        get className() {
          return libs.classNames("ScoreChange");
        },
        get children() {
          return libs.createComponent(GenericPanel.CLabel, {
            get ["class"]() {
              return libs.classNames("ScoreChangeLabel", {
                Add: scoreDiff() > 0,
                Keep: scoreDiff() == 0
              });
            },
            get text() {
              return libs.memo(() => scoreDiff() == 0)() ? `-${scoreDiff()}` : libs.memo(() => scoreDiff() >= 0)() ? `+${scoreDiff()}` : scoreDiff();
            }
          });
        }
      }), null);
      libs.insert(_el$0, libs.createComponent(libs.Show, {
        get when() {
          return showPeakScore();
        },
        get children() {
          return [libs.createComponent(EOM_Panel.EOM_Panel, {
            className: "PeakScore",
            get children() {
              return [libs.createComponent(EOM_Icon.EOM_Icon, {
                id: "PeakScoreIcon",
                get src() {
                  return getSrcPath("bountyentry/s14_bounty_icon_large.png");
                },
                onmouseover: self => {
                  $.DispatchEvent("DOTAShowTitleTextTooltip", self, "#BountyScore", "#BountyScore_description");
                },
                onmouseout: self => {
                  $.DispatchEvent("DOTAHideTitleTextTooltip", self);
                }
              }), libs.createComponent(EOM_Panel.EOM_Panel, {
                className: "PeakScoreLabel",
                get children() {
                  return libs.createComponent(EOM_Label.EOM_Label, {
                    get text() {
                      return libs.memo(() => peakScore() == -1)() ? "???" : peakScore();
                    }
                  });
                }
              })];
            }
          }), libs.createComponent(EOM_Panel.EOM_Panel, {
            id: "PeakScoreChange",
            get children() {
              return libs.createComponent(GenericPanel.CLabel, {
                get ["class"]() {
                  return libs.classNames("PeakScoreChangeLabel", {
                    Add: peakScoreDiff() > 0,
                    Keep: peakScoreDiff() == 0
                  });
                },
                get text() {
                  return libs.memo(() => peakScoreDiff() == 0)() ? `-${peakScoreDiff()}` : libs.memo(() => peakScoreDiff() >= 0)() ? `+${peakScoreDiff()}` : peakScoreDiff();
                }
              });
            }
          })];
        }
      }), null);
      libs.insert(_el$0, libs.createComponent(EOM_Button.EOM_Button, {
        align: "center bottom",
        get marginRight() {
          return canUseScoreCard() ? "350px" : "0px";
        },
        marginBottom: "80px",
        color: "Blue",
        onactivate: () => setScoreChangeShow(false),
        text: "#Popup_Button_Confirm"
      }), null);
      libs.insert(_el$0, libs.createComponent(libs.Show, {
        get when() {
          return canUseScoreCard();
        },
        get children() {
          return libs.createComponent(libs.Switch, {
            get children() {
              return [libs.createComponent(libs.Match, {
                get when() {
                  return libs.memo(() => scoreDiff() > 0)() && scoreCardInfo()[9310016];
                },
                get children() {
                  return libs.createComponent(EOM_Button.EOM_Button, {
                    align: "center bottom",
                    get enabled() {
                      return !scoreCardUsing();
                    },
                    get marginLeft() {
                      return canUseScoreCard() ? "350px" : "0px";
                    },
                    marginBottom: "80px",
                    color: "Gold",
                    onactivate: () => {
                      setScoreCardUsing(true);
                      serverRequest("double_and_project", {
                        id: Number(scoreCardInfo()[9310016]),
                        prop_id: 9310016
                      }, data => {
                        setScoreCardUsing(false);
                      });
                    },
                    get text() {
                      return $.Localize("#use") + $.Localize("#9310016");
                    }
                  });
                }
              }), libs.createComponent(libs.Match, {
                get when() {
                  return libs.memo(() => scoreDiff() < 0)() && scoreCardInfo()[9310015];
                },
                get children() {
                  return libs.createComponent(EOM_Button.EOM_Button, {
                    align: "center bottom",
                    get enabled() {
                      return !scoreCardUsing();
                    },
                    get marginLeft() {
                      return canUseScoreCard() ? "350px" : "0px";
                    },
                    marginBottom: "80px",
                    color: "Gold",
                    onactivate: () => {
                      setScoreCardUsing(true);
                      serverRequest("double_and_project", {
                        id: Number(scoreCardInfo()[9310015]),
                        prop_id: 9310015
                      }, data => {
                        setScoreCardUsing(false);
                      });
                    },
                    get text() {
                      return $.Localize("#use") + $.Localize("#9310015");
                    }
                  });
                }
              })];
            }
          });
        }
      }), null);
      libs.insert(_el$0, libs.createComponent(EOM_Panel.EOM_Panel, {
        id: "AnimationRoot",
        hittest: false
      }), null);
      libs.effect(_$p => libs.setProp(_el$0, "className", libs.classNames("RankChange", {
        EndScreenShow: scoreChangeeShow(),
        RankShow: rankShow()
      }), _$p));
      return _el$0;
    })();
  };
  libs.render(() => libs.createComponent(EndScreen, {}), $.GetContextPanel());
}