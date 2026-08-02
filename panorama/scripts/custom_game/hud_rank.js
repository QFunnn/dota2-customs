--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build b9dc48c · 2026-08-02 17:42:46 UTC
  ~ auto-generated — do not edit
]]


'use strict'; const require = GameUI.__require;

var libs = require('./libs.js');
var CosmeticCard = require('./CosmeticCard.js');
var EOM_Panel = require('./EOM_Panel.js');
var EOM_Icon = require('./EOM_Icon.js');
var EOM_Image = require('./EOM_Image.js');
var EOM_Label = require('./EOM_Label.js');
var EOM_Loading = require('./EOM_Loading.js');
var EOM_Button = require('./EOM_Button.js');
var EOM_DropDown = require('./EOM_DropDown.js');
var EOM_MenuLayout = require('./EOM_MenuLayout.js');
var GenericPanel = require('./GenericPanel.js');
var Heroes = require('./Heroes.js');
var MedalBadgeIcon = require('./MedalBadgeIcon.js');
var MenuMarkIcon = require('./MenuMarkIcon.js');
var Player = require('./Player.js');
var RankTierIcon = require('./RankTierIcon.js');
var game_utils = require('./game_utils.js');
require('./EOM_Countdown.js');
require('./netdata_utils.js');

if (!isSpectator()) {
  const RegionSelectEnable = (() => {
    let enable = false;
    let _time = getPeakScoreRegionTime();
    let server_time = ServerTimestamp();
    if (server_time >= _time.start_time && server_time < _time.end_time) {
      enable = true;
    }
    return enable;
  })();
  function getDefaultRankInfo() {
    return {
      rank: -1,
      uid: Number(getPlayerData(Players.GetLocalPlayer()).steamID ?? 1),
      value: 1,
      extra: {
        win_percent: 0.5,
        main_heroes: []
      },
      ban: {}
    };
  }
  const [peakSignUpMark, setPeakSignUpMark] = libs.createSignal();
  const updateNewMarkInfo = data => {
    if (data) {
      for (const mid in data) {
        const state = data[mid];
        const kv = KeyValues.NewMarkInfoKv[mid];
        if (kv != undefined) {
          if (kv.menu_button == "rank") {
            if (kv.tag_id == "leaderboard_7") {
              if (kv.benchmark == "sign_up") {
                if (state && peakSignUpMark() === undefined) {
                  setPeakSignUpMark(kv.type);
                }
              }
            }
          }
        }
      }
    }
  };
  const peakArenaKingsData = game_utils.GetPeakArenaKingsData();
  const selfRegion = () => peakArenaKingsData().region;
  function Rank() {
    const [show, setShow] = libs.createSignal(false);
    const gameSeason = game_utils.GetGameSeason();
    const [seleted_menu, setSelectedMenu] = libs.createSignal("leaderboard_1");
    const [selfRank1, setSelfRank1] = libs.createSignal(getDefaultRankInfo());
    const [leaderboard1, setLeaderBoard1] = libs.createSignal({});
    const [selfRank2, setSelfRank2] = libs.createSignal(getDefaultRankInfo());
    const [leaderboard2, setLeaderBoard2] = libs.createSignal({});
    const [selfRank3, setSelfRank3] = libs.createSignal(getDefaultRankInfo());
    const [leaderboard3, setLeaderBoard3] = libs.createSignal({});
    const [selfRank4, setSelfRank4] = libs.createSignal(getDefaultRankInfo());
    const [leaderboard4, setLeaderBoard4] = libs.createSignal({});
    const [selfRank5, setSelfRank5] = libs.createSignal(getDefaultRankInfo());
    const [leaderboard5, setLeaderBoard5] = libs.createSignal({});
    const [leaderboard6, setLeaderBoard6] = libs.createSignal({});
    const [leaderboard7, setLeaderBoard7] = libs.createSignal({});
    const [selfRank7, setSelfRank7] = libs.createSignal(getDefaultRankInfo());
    const [page7, setPage7] = libs.createSignal(1);
    const [loading7, setLoading7] = libs.createSignal(false);
    let rankList7;
    const leaderboardList7 = libs.createMemo(() => {
      const page = page7();
      const leaderboard = leaderboard7();
      if (Object.keys(leaderboard).length > 0) {
        return Object.keys(leaderboard).filter(rank => Number(rank) > (page - 1) * 50 && Number(rank) <= page * 50);
      }
      return [];
    });
    const peakRankFilterList = ["default", "1", "2"];
    const [peakRankFilted, setPeakRankFilted] = libs.createSignal(selfRegion() ?? peakRankFilterList[0]);
    function updateLadderData7(data = getNetDataCache("leaderboard_data_7", Players.GetLocalPlayer())) {
      if (data) {
        let d = data[peakRankFilted() + "_" + 9];
        if (d) {
          setLeaderBoard7(d?.leaderboard ?? {});
          setSelfRank7({
            rank: d.self_rank ?? -1,
            uid: Number(getPlayerData(Players.GetLocalPlayer()).steamID ?? 1),
            value: d.self_value ?? 0,
            extra: d.extra,
            ban: {}
          });
        } else {
          setLeaderBoard7({});
          setSelfRank7(getDefaultRankInfo());
        }
      }
    }
    libs.createEffect(libs.on(peakRankFilted, () => {
      setPage7(1);
      updateLadderData7();
    }));
    const [page1, setPage1] = libs.createSignal(1);
    const [page2, setPage2] = libs.createSignal(1);
    const [page3, setPage3] = libs.createSignal(1);
    const [page4, setPage4] = libs.createSignal(1);
    const [page5, setPage5] = libs.createSignal(1);
    const [loading1, setLoading1] = libs.createSignal(false);
    const [loading2, setLoading2] = libs.createSignal(false);
    const [loading3, setLoading3] = libs.createSignal(false);
    const [loading4, setLoading4] = libs.createSignal(false);
    const [loading5, setLoading5] = libs.createSignal(false);
    const [loading6, setLoading6] = libs.createSignal(false);
    let rankList1;
    let rankList2;
    let rankList3;
    let rankList4;
    let rankList5;
    const leaderboardList1 = libs.createMemo(() => {
      const page = page1();
      const leaderboard = leaderboard1();
      if (Object.keys(leaderboard).length > 0) {
        return Object.keys(leaderboard).filter(rank => Number(rank) > (page - 1) * 50 && Number(rank) <= page * 50);
      }
      return [];
    });
    const leaderboardList2 = libs.createMemo(() => {
      const page = page2();
      const leaderboard = leaderboard2();
      if (Object.keys(leaderboard).length > 0) {
        return Object.keys(leaderboard).filter(rank => Number(rank) > (page - 1) * 50 && Number(rank) <= page * 50);
      }
      return [];
    });
    const leaderboardList3 = libs.createMemo(() => {
      const page = page3();
      const leaderboard = leaderboard3();
      if (Object.keys(leaderboard).length > 0) {
        return Object.keys(leaderboard).filter(rank => Number(rank) > (page - 1) * 50 && Number(rank) <= page * 50);
      }
      return [];
    });
    const leaderboardList4 = libs.createMemo(() => {
      const page = page4();
      const leaderboard = leaderboard4();
      if (Object.keys(leaderboard).length > 0) {
        const result = Object.keys(leaderboard).filter(rank => Number(rank) > (page - 1) * 50 && Number(rank) <= page * 50);
        return result;
      }
      return [];
    });
    const leaderboardList5 = libs.createMemo(() => {
      const page = page5();
      const leaderboard = leaderboard5();
      if (Object.keys(leaderboard).length > 0) {
        const result = Object.keys(leaderboard).filter(rank => Number(rank) > (page - 1) * 50 && Number(rank) <= page * 50);
        return result;
      }
      return [];
    });
    libs.createMemo(() => {
      const leaderboard = leaderboard6();
      if (Object.keys(leaderboard).length > 0) {
        const result = Object.keys(leaderboard);
        return result;
      }
      return [];
    });
    libs.createEffect(libs.on([selfRegion, gameSeason], v => {
      leaderRefresh7 = {};
      if (gameSeason() != 1) {
        requestLeaderData({
          leaderboard_id: 7,
          page: page7(),
          callback: () => {
            setLoading7(true);
          },
          extra: peakRankFilted(),
          season_id: gameSeason()
        });
        if (rankList7 != undefined) {
          rankList7.ScrollToTop();
        }
      }
      setPeakRankFilted(selfRegion() ?? "default");
    }));
    libs.onMount(() => {
      const eventId = useToggleWindow('MenuButton_rank', show, setShow);
      libs.onCleanup(() => GameEvents.Unsubscribe(eventId));
    });
    EOM_MenuLayout.useEOM_MenuLayoutData(show, () => {
      const netTableListenerIDs = [];
      const gameEventListeners = [];
      netTableListenerIDs.push(useServiceNetTable("player_new_mark", data => {
        updateNewMarkInfo(data);
      }, Players.GetLocalPlayer()));
      gameEventListeners.push(useClientSideEvent("create_new_mark_info", data => {
        updateNewMarkInfo(data);
      }));
      gameEventListeners.push(useNetData("leaderboard_data_1", data => {
        setLoading1(false);
        setLeaderBoard1(data.leaderboard);
        setSelfRank1({
          rank: data.self_rank ?? -1,
          uid: Number(getPlayerData(Players.GetLocalPlayer()).steamID ?? 1),
          value: data.self_value ?? 0,
          extra: data.extra,
          ban: {}
        });
      }, Players.GetLocalPlayer()));
      gameEventListeners.push(useNetData("leaderboard_data_2", data => {
        setLoading2(false);
        setLeaderBoard2(data.leaderboard);
        setSelfRank2({
          rank: data.self_rank ?? -1,
          uid: Number(getPlayerData(Players.GetLocalPlayer()).steamID ?? 1),
          value: data.self_value ?? 0,
          extra: data.extra,
          ban: {}
        });
      }, Players.GetLocalPlayer()));
      gameEventListeners.push(useNetData("leaderboard_data_3", data => {
        setLoading3(false);
        setLeaderBoard3(data.leaderboard);
        setSelfRank3({
          rank: data.self_rank ?? -1,
          uid: Number(getPlayerData(Players.GetLocalPlayer()).steamID ?? 1),
          value: data.self_value ?? 0,
          extra: data.extra,
          ban: {}
        });
      }, Players.GetLocalPlayer()));
      gameEventListeners.push(useNetData("leaderboard_data_4", data => {
        setLoading4(false);
        setLeaderBoard4(data.leaderboard);
        setSelfRank4({
          rank: data.self_rank ?? -1,
          uid: Number(getPlayerData(Players.GetLocalPlayer()).steamID ?? 1),
          value: data.self_value ?? 0,
          extra: data.extra,
          ban: {}
        });
      }, Players.GetLocalPlayer()));
      gameEventListeners.push(useNetData("leaderboard_data_5", data => {
        setLoading5(false);
        setLeaderBoard5(data.leaderboard);
        setSelfRank5({
          rank: data.self_rank ?? -1,
          uid: Number(getPlayerData(Players.GetLocalPlayer()).steamID ?? 1),
          value: data.self_value ?? 0,
          extra: data.extra,
          ban: {}
        });
      }, Players.GetLocalPlayer()));
      gameEventListeners.push(useNetData("leaderboard_data_6", data => {
        setLoading6(false);
        setLeaderBoard6(data.leaderboard);
      }, Players.GetLocalPlayer()));
      let initedPeakSignUpMark = false;
      gameEventListeners.push(useNetData("leaderboard_data_7", data => {
        setLoading7(false);
        updateLadderData7(data);
        if (data) {
          const selfData = Object.values(data).find(v => {
            return v.extra?.total_count != undefined;
          });
          if (selfData && selfData.self_rank > 0) {
            let selfMatchCount = selfData?.extra?.total_count ?? 0;
            let selfRegion = selfData?.extra?.kings_score_region ?? "default";
            if (!initedPeakSignUpMark) {
              initedPeakSignUpMark = true;
              let _time = getPeakScoreRegionTime();
              let server_time = ServerTimestamp();
              if (server_time >= _time.start_time && server_time < _time.end_time) {
                setClientGlobalData("peak_sign_up_info", {
                  region: selfRegion,
                  count: selfMatchCount
                });
                if (selfRegion == "default") {
                  GameEvents.SendCustomEventToServer("init_player_new_mark", {
                    data: ["1072", "1073"]
                  });
                  clientSideEvent("create_new_mark_info", {
                    ["1072"]: true,
                    ["1073"]: true
                  });
                }
              }
            }
          }
        }
      }, Players.GetLocalPlayer()));
      if (isKingsRankMode()) {
        gameEventListeners.push(useNetData("rank_score_change", data => {
          if (data && data.now_kings_score && data.origin_kings_score && data.now_kings_score != data.origin_kings_score) {
            leaderRefresh7 = {};
          }
        }, Players.GetLocalPlayer()));
      }
      return () => {
        gameEventListeners.forEach(id => GameEvents.Unsubscribe(id));
        netTableListenerIDs.forEach(id => CustomNetTables.UnsubscribeNetTableListener(id));
      };
    });
    let cooldowning = false;
    let cdTimer = -1;
    let leaderRefresh = {};
    let leaderRefresh7 = {};
    const startCooldown = () => {
      if (!cooldowning) {
        cooldowning = true;
        cdTimer = $.Schedule(300, () => {
          leaderRefresh = {};
          leaderRefresh7 = {};
          cdTimer = -1;
        });
      }
    };
    libs.onCleanup(() => {
      if (cdTimer != -1) {
        $.CancelScheduled(cdTimer);
      }
    });
    const requestLeaderData = ({
      callback,
      leaderboard_id,
      page,
      season_id,
      extra
    }) => {
      let request = false;
      if (leaderboard_id == 7 && extra != undefined) {
        if (leaderRefresh7[leaderboard_id] == undefined) {
          leaderRefresh7[leaderboard_id] = {};
        }
        if (leaderRefresh7[leaderboard_id][extra] == undefined) {
          leaderRefresh7[leaderboard_id][extra] = [];
        }
        if (!leaderRefresh7[leaderboard_id][extra][page]) {
          request = true;
          leaderRefresh7[leaderboard_id][extra][page] = true;
        }
      } else {
        if (leaderRefresh[leaderboard_id] == undefined) {
          leaderRefresh[leaderboard_id] = [];
        }
        if (!leaderRefresh[leaderboard_id][page]) {
          request = true;
          leaderRefresh[leaderboard_id][page] = true;
        }
      }
      if (request) {
        callback();
        startCooldown();
        if (leaderboard_id == 6) {
          GameEvents.SendCustomEventToServer("request_leaderboard_data", {
            leaderboard_id,
            begin_rank: 1,
            end_rank: 100,
            season_id
          });
        } else if (leaderboard_id == 7) {
          GameEvents.SendCustomEventToServer("request_leaderboard_data", {
            leaderboard_id,
            begin_rank: (page - 1) * 50 + 1,
            end_rank: page * 50,
            season_id,
            extra,
            extra2: 9
          });
        } else {
          GameEvents.SendCustomEventToServer("request_leaderboard_data", {
            leaderboard_id,
            begin_rank: (page - 1) * 50 + 1,
            end_rank: page * 50,
            season_id,
            extra
          });
        }
      }
    };
    libs.createEffect(() => {
      if (show()) {
        requestLeaderData({
          leaderboard_id: 1,
          page: page1(),
          callback: () => {
            setLoading1(true);
          }
        });
        if (rankList1 != undefined) {
          rankList1.ScrollToTop();
        }
      }
    });
    libs.createEffect(() => {
      if (show()) {
        requestLeaderData({
          leaderboard_id: 2,
          page: page2(),
          callback: () => {
            setLoading2(true);
          }
        });
        if (rankList2 != undefined) {
          rankList2.ScrollToTop();
        }
      }
    });
    libs.createEffect(() => {
      if (show()) {
        requestLeaderData({
          leaderboard_id: 3,
          page: page3(),
          callback: () => {
            setLoading3(true);
          }
        });
        if (rankList3 != undefined) {
          rankList3.ScrollToTop();
        }
      }
    });
    libs.createEffect(() => {
      if (show()) {
        requestLeaderData({
          leaderboard_id: 4,
          page: page4(),
          season_id: gameSeason(),
          callback: () => {
            setLoading4(true);
          }
        });
        if (rankList4 != undefined) {
          rankList4.ScrollToTop();
        }
      }
    });
    libs.createEffect(() => {
      if (show()) {
        requestLeaderData({
          leaderboard_id: 5,
          page: page5(),
          season_id: gameSeason(),
          callback: () => {
            setLoading5(true);
          }
        });
        if (rankList5 != undefined) {
          rankList5.ScrollToTop();
        }
      }
    });
    libs.createEffect(() => {
      if (show()) {
        requestLeaderData({
          leaderboard_id: 6,
          page: 1,
          season_id: 106,
          callback: () => {
            setLoading6(true);
          }
        });
      }
    });
    libs.createEffect(() => {
      if (show()) {
        requestLeaderData({
          leaderboard_id: 7,
          page: page7(),
          callback: () => {
            setLoading7(true);
          },
          extra: peakRankFilted(),
          season_id: gameSeason()
        });
        if (rankList7 != undefined) {
          rankList7.ScrollToTop();
        }
      }
    });
    libs.createEffect(libs.on(gameSeason, season => {
      if (season != 1) {
        requestLeaderData({
          leaderboard_id: 7,
          page: 1,
          callback: () => {},
          extra: "default",
          season_id: season
        });
      }
    }));
    return libs.createComponent(EOM_MenuLayout.EOM_MenuLayout, {
      renderOnShow: true,
      get show() {
        return show();
      },
      name: "MenuButton_rank",
      get children() {
        return [libs.createElement("DOTAParticleScenePanel", {
          hittest: false,
          id: "BGScene",
          particleName: "particles/eom/ui/ui_fx/ui_fx_ranking_list.vpcf",
          cameraOrigin: "180 0 -600",
          lookAt: "180 0 0",
          fov: 30
        }, null), libs.createComponent(EOM_MenuLayout.EOM_MenuLayout_Menu, {
          menuList: {
            "leaderboard_4": [],
            "leaderboard_1": [],
            "leaderboard_2": [],
            "leaderboard_5": [],
            "leaderboard_3": [],
            "leaderboard_7": []
          },
          menuName: "rank",
          onToggleMenu: (menu, menu2) => {
            setSelectedMenu(menu);
          }
        }), libs.createComponent(EOM_MenuLayout.EOM_MenuLayout_Content, {
          get show() {
            return seleted_menu() == "leaderboard_1";
          },
          get children() {
            return ["\u3001", libs.createComponent(libs.Switch, {
              get fallback() {
                return libs.createComponent(EOM_Loading.EOM_Loading, {
                  align: "center center",
                  type: "PointSpin"
                });
              },
              get children() {
                return libs.createComponent(libs.Match, {
                  get when() {
                    return leaderboard1() != undefined;
                  },
                  get children() {
                    return [libs.createComponent(EOM_Panel.EOM_Panel, {
                      horizontalAlign: "center",
                      flowChildren: "down",
                      get children() {
                        return [(() => {
                          const _el$2 = libs.createElement("Panel", {
                            id: "RankTitleContainer"
                          }, null);
                          libs.insert(_el$2, libs.createComponent(GenericPanel.CLabel, {
                            text: "#leaderboard_1_title"
                          }), null);
                          libs.insert(_el$2, libs.createComponent(EOM_Image.EOM_Image, {
                            className: "RankInfoIcon",
                            tooltip: "#leaderboard_1_desc"
                          }), null);
                          return _el$2;
                        })(), (() => {
                          const _el$3 = libs.createElement("Panel", {
                            id: "TabContainer"
                          }, null);
                          libs.insert(_el$3, libs.createComponent(EOM_Label.EOM_Label, {
                            width: "170px",
                            text: "#Rank_rank"
                          }), null);
                          libs.insert(_el$3, libs.createComponent(EOM_Label.EOM_Label, {
                            width: "480px",
                            text: "#Rank_info"
                          }), null);
                          libs.insert(_el$3, libs.createComponent(EOM_Label.EOM_Label, {
                            width: "220px",
                            text: "#Rank_medal"
                          }), null);
                          libs.insert(_el$3, libs.createComponent(EOM_Label.EOM_Label, {
                            width: "360px",
                            text: "#Rank_win"
                          }), null);
                          libs.insert(_el$3, libs.createComponent(EOM_Label.EOM_Label, {
                            width: "fill-parent-flow(1)",
                            text: "#Rank_hero"
                          }), null);
                          return _el$3;
                        })(), libs.createComponent(EOM_Panel.EOM_Panel, {
                          ref(r$) {
                            const _ref$ = rankList1;
                            typeof _ref$ === "function" ? _ref$(r$) : rankList1 = r$;
                          },
                          scroll: "y",
                          id: "RankList",
                          get className() {
                            return libs.classNames({
                              Show: !loading1()
                            });
                          },
                          flowChildren: "down",
                          paddingRight: "23px",
                          height: "740px",
                          get children() {
                            return libs.createComponent(libs.Index, {
                              get each() {
                                return leaderboardList1();
                              },
                              children: (rank, index) => {
                                const rankData = () => leaderboard1()[Number(rank())];
                                return libs.createComponent(RankRowMedal, {
                                  get rankData() {
                                    return rankData();
                                  },
                                  index: index
                                });
                              }
                            });
                          }
                        }), libs.createComponent(RankRowMedal, {
                          get rankData() {
                            return selfRank1();
                          },
                          self: true
                        }), libs.createComponent(EOM_Panel.EOM_Panel, {
                          flowChildren: "right",
                          horizontalAlign: "center",
                          marginTop: "10px",
                          get children() {
                            return [libs.createComponent(EOM_Button.EOM_BaseButton, {
                              get enabled() {
                                return page1() != 1;
                              },
                              onactivate: () => setPage1(page1() - 1),
                              className: "PageButton PageLeft",
                              get children() {
                                return [(() => {
                                  const _el$4 = libs.createElement("Image", {}, null);
                                  libs.setProp(_el$4, "className", "BG");
                                  return _el$4;
                                })(), (() => {
                                  const _el$5 = libs.createElement("Image", {}, null);
                                  libs.setProp(_el$5, "className", "PageArrow");
                                  return _el$5;
                                })()];
                              }
                            }), libs.createComponent(libs.For, {
                              each: [1, 2, 3, 4, 5, 6, 7, 8, 9, 10],
                              children: i => {
                                return libs.createComponent(EOM_Button.EOM_BaseButton, {
                                  onactivate: () => setPage1(i),
                                  get className() {
                                    return libs.classNames("PageButton", {
                                      Selected: page1() == i
                                    });
                                  },
                                  get children() {
                                    return [(() => {
                                      const _el$30 = libs.createElement("Image", {}, null);
                                      libs.setProp(_el$30, "className", "BG");
                                      return _el$30;
                                    })(), libs.createComponent(GenericPanel.CLabel, {
                                      text: i
                                    })];
                                  }
                                });
                              }
                            }), libs.createComponent(EOM_Button.EOM_BaseButton, {
                              get enabled() {
                                return page1() != 10;
                              },
                              onactivate: () => setPage1(page1() + 1),
                              className: "PageButton PageRight",
                              get children() {
                                return [(() => {
                                  const _el$6 = libs.createElement("Image", {}, null);
                                  libs.setProp(_el$6, "className", "BG");
                                  return _el$6;
                                })(), (() => {
                                  const _el$7 = libs.createElement("Image", {}, null);
                                  libs.setProp(_el$7, "className", "PageArrow");
                                  return _el$7;
                                })()];
                              }
                            })];
                          }
                        })];
                      }
                    }), libs.createComponent(libs.Show, {
                      get when() {
                        return loading1();
                      },
                      get children() {
                        return libs.createComponent(EOM_Loading.EOM_Loading, {
                          align: "center center",
                          type: "PointSpin"
                        });
                      }
                    })];
                  }
                });
              }
            })];
          }
        }), libs.createComponent(EOM_MenuLayout.EOM_MenuLayout_Content, {
          get show() {
            return seleted_menu() == "leaderboard_2";
          },
          get children() {
            return libs.createComponent(libs.Switch, {
              get fallback() {
                return libs.createComponent(EOM_Loading.EOM_Loading, {
                  align: "center center",
                  type: "PointSpin"
                });
              },
              get children() {
                return libs.createComponent(libs.Match, {
                  get when() {
                    return leaderboard2() != undefined;
                  },
                  get children() {
                    return [libs.createComponent(EOM_Panel.EOM_Panel, {
                      horizontalAlign: "center",
                      flowChildren: "down",
                      get children() {
                        return [(() => {
                          const _el$8 = libs.createElement("Panel", {
                            id: "RankTitleContainer"
                          }, null);
                          libs.insert(_el$8, libs.createComponent(GenericPanel.CLabel, {
                            text: "#leaderboard_2_title"
                          }), null);
                          libs.insert(_el$8, libs.createComponent(EOM_Image.EOM_Image, {
                            className: "RankInfoIcon",
                            tooltip: "#leaderboard_2_desc"
                          }), null);
                          return _el$8;
                        })(), (() => {
                          const _el$9 = libs.createElement("Panel", {
                            id: "TabContainer"
                          }, null);
                          libs.insert(_el$9, libs.createComponent(EOM_Label.EOM_Label, {
                            width: "170px",
                            text: "#Rank_rank"
                          }), null);
                          libs.insert(_el$9, libs.createComponent(EOM_Label.EOM_Label, {
                            width: "460px",
                            text: "#Rank_info"
                          }), null);
                          libs.insert(_el$9, libs.createComponent(EOM_Label.EOM_Label, {
                            width: "600px",
                            text: "#Rank_chicken"
                          }), null);
                          libs.insert(_el$9, libs.createComponent(EOM_Label.EOM_Label, {
                            width: "fill-parent-flow(1)",
                            text: "#Rank_hero"
                          }), null);
                          return _el$9;
                        })(), libs.createComponent(EOM_Panel.EOM_Panel, {
                          ref(r$) {
                            const _ref$2 = rankList2;
                            typeof _ref$2 === "function" ? _ref$2(r$) : rankList2 = r$;
                          },
                          scroll: "y",
                          id: "RankList",
                          get className() {
                            return libs.classNames({
                              Show: !loading2()
                            });
                          },
                          flowChildren: "down",
                          paddingRight: "23px",
                          height: "740px",
                          get children() {
                            return libs.createComponent(libs.Index, {
                              get each() {
                                return leaderboardList2();
                              },
                              children: (rank, index) => {
                                const rankData = () => leaderboard2()[Number(rank())];
                                return libs.createComponent(RankRowWin, {
                                  get rankData() {
                                    return rankData();
                                  },
                                  index: index
                                });
                              }
                            });
                          }
                        }), libs.createComponent(RankRowWin, {
                          get rankData() {
                            return selfRank2();
                          },
                          self: true
                        }), libs.createComponent(EOM_Panel.EOM_Panel, {
                          flowChildren: "right",
                          horizontalAlign: "center",
                          marginTop: "10px",
                          get children() {
                            return [libs.createComponent(EOM_Button.EOM_BaseButton, {
                              get enabled() {
                                return page2() != 1;
                              },
                              onactivate: () => setPage2(page2() - 1),
                              className: "PageButton PageLeft",
                              get children() {
                                return [(() => {
                                  const _el$0 = libs.createElement("Image", {}, null);
                                  libs.setProp(_el$0, "className", "BG");
                                  return _el$0;
                                })(), (() => {
                                  const _el$1 = libs.createElement("Image", {}, null);
                                  libs.setProp(_el$1, "className", "PageArrow");
                                  return _el$1;
                                })()];
                              }
                            }), libs.createComponent(libs.For, {
                              each: [1, 2, 3, 4, 5, 6, 7, 8, 9, 10],
                              children: i => {
                                return libs.createComponent(EOM_Button.EOM_BaseButton, {
                                  onactivate: () => setPage2(i),
                                  get className() {
                                    return libs.classNames("PageButton", {
                                      Selected: page2() == i
                                    });
                                  },
                                  get children() {
                                    return [(() => {
                                      const _el$31 = libs.createElement("Image", {}, null);
                                      libs.setProp(_el$31, "className", "BG");
                                      return _el$31;
                                    })(), libs.createComponent(GenericPanel.CLabel, {
                                      text: i
                                    })];
                                  }
                                });
                              }
                            }), libs.createComponent(EOM_Button.EOM_BaseButton, {
                              get enabled() {
                                return page2() != 10;
                              },
                              onactivate: () => setPage2(page2() + 1),
                              className: "PageButton PageRight",
                              get children() {
                                return [(() => {
                                  const _el$10 = libs.createElement("Image", {}, null);
                                  libs.setProp(_el$10, "className", "BG");
                                  return _el$10;
                                })(), (() => {
                                  const _el$11 = libs.createElement("Image", {}, null);
                                  libs.setProp(_el$11, "className", "PageArrow");
                                  return _el$11;
                                })()];
                              }
                            })];
                          }
                        })];
                      }
                    }), libs.createComponent(libs.Show, {
                      get when() {
                        return loading2();
                      },
                      get children() {
                        return libs.createComponent(EOM_Loading.EOM_Loading, {
                          align: "center center",
                          type: "PointSpin"
                        });
                      }
                    })];
                  }
                });
              }
            });
          }
        }), libs.createComponent(EOM_MenuLayout.EOM_MenuLayout_Content, {
          get show() {
            return seleted_menu() == "leaderboard_3";
          },
          get children() {
            return libs.createComponent(libs.Switch, {
              get fallback() {
                return libs.createComponent(EOM_Loading.EOM_Loading, {
                  align: "center center",
                  type: "PointSpin"
                });
              },
              get children() {
                return libs.createComponent(libs.Match, {
                  get when() {
                    return leaderboard3() != undefined;
                  },
                  get children() {
                    return [libs.createComponent(EOM_Panel.EOM_Panel, {
                      horizontalAlign: "center",
                      flowChildren: "down",
                      get children() {
                        return [(() => {
                          const _el$12 = libs.createElement("Panel", {
                            id: "RankTitleContainer"
                          }, null);
                          libs.insert(_el$12, libs.createComponent(GenericPanel.CLabel, {
                            text: "#leaderboard_3_title"
                          }), null);
                          libs.insert(_el$12, libs.createComponent(EOM_Image.EOM_Image, {
                            className: "RankInfoIcon",
                            tooltip: "#leaderboard_3_desc"
                          }), null);
                          return _el$12;
                        })(), (() => {
                          const _el$13 = libs.createElement("Panel", {
                            id: "TabContainer"
                          }, null);
                          libs.insert(_el$13, libs.createComponent(EOM_Label.EOM_Label, {
                            width: "170px",
                            text: "#Rank_rank"
                          }), null);
                          libs.insert(_el$13, libs.createComponent(EOM_Label.EOM_Label, {
                            width: "800px",
                            text: "#Rank_info"
                          }), null);
                          libs.insert(_el$13, libs.createComponent(EOM_Label.EOM_Label, {
                            width: "fill-parent-flow(1)",
                            text: "#Rank_item"
                          }), null);
                          return _el$13;
                        })(), libs.createComponent(EOM_Panel.EOM_Panel, {
                          ref(r$) {
                            const _ref$3 = rankList3;
                            typeof _ref$3 === "function" ? _ref$3(r$) : rankList3 = r$;
                          },
                          scroll: "y",
                          id: "RankList",
                          get className() {
                            return libs.classNames({
                              Show: !loading3()
                            });
                          },
                          flowChildren: "down",
                          paddingRight: "23px",
                          height: "740px",
                          get children() {
                            return libs.createComponent(libs.Index, {
                              get each() {
                                return leaderboardList3();
                              },
                              children: (rank, index) => {
                                const rankData = () => leaderboard3()[Number(rank())];
                                return libs.createComponent(RankRowItem, {
                                  get rankData() {
                                    return rankData();
                                  },
                                  index: index
                                });
                              }
                            });
                          }
                        }), libs.createComponent(RankRowItem, {
                          get rankData() {
                            return selfRank3();
                          },
                          self: true
                        }), libs.createComponent(EOM_Panel.EOM_Panel, {
                          flowChildren: "right",
                          horizontalAlign: "center",
                          marginTop: "10px",
                          get children() {
                            return [libs.createComponent(EOM_Button.EOM_BaseButton, {
                              get enabled() {
                                return page3() != 1;
                              },
                              onactivate: () => setPage3(page3() - 1),
                              className: "PageButton PageLeft",
                              get children() {
                                return [(() => {
                                  const _el$14 = libs.createElement("Image", {}, null);
                                  libs.setProp(_el$14, "className", "BG");
                                  return _el$14;
                                })(), (() => {
                                  const _el$15 = libs.createElement("Image", {}, null);
                                  libs.setProp(_el$15, "className", "PageArrow");
                                  return _el$15;
                                })()];
                              }
                            }), libs.createComponent(libs.For, {
                              each: [1, 2, 3, 4, 5, 6, 7, 8, 9, 10],
                              children: i => {
                                return libs.createComponent(EOM_Button.EOM_BaseButton, {
                                  onactivate: () => setPage3(i),
                                  get className() {
                                    return libs.classNames("PageButton", {
                                      Selected: page3() == i
                                    });
                                  },
                                  get children() {
                                    return [(() => {
                                      const _el$32 = libs.createElement("Image", {}, null);
                                      libs.setProp(_el$32, "className", "BG");
                                      return _el$32;
                                    })(), libs.createComponent(GenericPanel.CLabel, {
                                      text: i
                                    })];
                                  }
                                });
                              }
                            }), libs.createComponent(EOM_Button.EOM_BaseButton, {
                              get enabled() {
                                return page3() != 10;
                              },
                              onactivate: () => setPage3(page3() + 1),
                              className: "PageButton PageRight",
                              get children() {
                                return [(() => {
                                  const _el$16 = libs.createElement("Image", {}, null);
                                  libs.setProp(_el$16, "className", "BG");
                                  return _el$16;
                                })(), (() => {
                                  const _el$17 = libs.createElement("Image", {}, null);
                                  libs.setProp(_el$17, "className", "PageArrow");
                                  return _el$17;
                                })()];
                              }
                            })];
                          }
                        })];
                      }
                    }), libs.createComponent(libs.Show, {
                      get when() {
                        return loading3();
                      },
                      get children() {
                        return libs.createComponent(EOM_Loading.EOM_Loading, {
                          align: "center center",
                          type: "PointSpin"
                        });
                      }
                    })];
                  }
                });
              }
            });
          }
        }), libs.createComponent(EOM_MenuLayout.EOM_MenuLayout_Content, {
          get show() {
            return seleted_menu() == "leaderboard_4";
          },
          get children() {
            return libs.createComponent(libs.Switch, {
              get fallback() {
                return libs.createComponent(EOM_Loading.EOM_Loading, {
                  align: "center center",
                  type: "PointSpin"
                });
              },
              get children() {
                return libs.createComponent(libs.Match, {
                  get when() {
                    return leaderboard4() != undefined;
                  },
                  get children() {
                    return [libs.createComponent(EOM_Panel.EOM_Panel, {
                      horizontalAlign: "center",
                      flowChildren: "down",
                      get children() {
                        return [(() => {
                          const _el$18 = libs.createElement("Panel", {
                            id: "RankTitleContainer"
                          }, null);
                          libs.insert(_el$18, libs.createComponent(EOM_Image.EOM_Image, {
                            get className() {
                              return "RankTitle " + $.Language().toLowerCase();
                            }
                          }), null);
                          libs.insert(_el$18, libs.createComponent(EOM_Image.EOM_Image, {
                            get className() {
                              return "RankInfoIcon Ladder " + $.Language().toLowerCase();
                            },
                            tooltip: "#leaderboard_4_desc"
                          }), null);
                          return _el$18;
                        })(), (() => {
                          const _el$19 = libs.createElement("Panel", {
                            id: "TabContainer",
                            get ["class"]() {
                              return $.Language().toLowerCase();
                            }
                          }, null);
                          libs.insert(_el$19, libs.createComponent(EOM_Label.EOM_Label, {
                            width: "170px",
                            text: "#Rank_rank"
                          }), null);
                          libs.insert(_el$19, libs.createComponent(EOM_Label.EOM_Label, {
                            width: "480px",
                            text: "#Rank_info"
                          }), null);
                          libs.insert(_el$19, libs.createComponent(EOM_Label.EOM_Label, {
                            width: "220px",
                            text: "#Rank_ladder"
                          }), null);
                          libs.insert(_el$19, libs.createComponent(EOM_Label.EOM_Label, {
                            width: "360px",
                            text: "#Rank_win"
                          }), null);
                          libs.insert(_el$19, libs.createComponent(EOM_Label.EOM_Label, {
                            width: "fill-parent-flow(1)",
                            text: "#Rank_hero"
                          }), null);
                          libs.effect(_$p => libs.setProp(_el$19, "class", $.Language().toLowerCase(), _$p));
                          return _el$19;
                        })(), libs.createComponent(EOM_Panel.EOM_Panel, {
                          ref(r$) {
                            const _ref$4 = rankList4;
                            typeof _ref$4 === "function" ? _ref$4(r$) : rankList4 = r$;
                          },
                          scroll: "y",
                          id: "RankList",
                          get className() {
                            return libs.classNames({
                              Show: !loading4()
                            });
                          },
                          flowChildren: "down",
                          paddingRight: "23px",
                          height: "700px",
                          get children() {
                            return libs.createComponent(libs.Index, {
                              get each() {
                                return leaderboardList4();
                              },
                              children: (rank, index) => {
                                const rankData = libs.createMemo(() => leaderboard4()?.[rank()]);
                                return libs.createComponent(libs.Show, {
                                  get when() {
                                    return rankData() != undefined;
                                  },
                                  get children() {
                                    return libs.createComponent(RankRowLadder, {
                                      get rankData() {
                                        return rankData();
                                      },
                                      index: index
                                    });
                                  }
                                });
                              }
                            });
                          }
                        }), libs.createComponent(RankRowLadder, {
                          get rankData() {
                            return selfRank4();
                          },
                          self: true
                        }), libs.createComponent(EOM_Panel.EOM_Panel, {
                          flowChildren: "right",
                          horizontalAlign: "center",
                          marginTop: "10px",
                          get children() {
                            return [libs.createComponent(EOM_Button.EOM_BaseButton, {
                              get enabled() {
                                return page4() != 1;
                              },
                              onactivate: () => setPage4(page4() - 1),
                              className: "PageButton PageLeft",
                              get children() {
                                return [(() => {
                                  const _el$20 = libs.createElement("Image", {}, null);
                                  libs.setProp(_el$20, "className", "BG");
                                  return _el$20;
                                })(), (() => {
                                  const _el$21 = libs.createElement("Image", {}, null);
                                  libs.setProp(_el$21, "className", "PageArrow");
                                  return _el$21;
                                })()];
                              }
                            }), libs.createComponent(libs.For, {
                              each: [1, 2, 3, 4, 5, 6, 7, 8, 9, 10],
                              children: i => {
                                return libs.createComponent(EOM_Button.EOM_BaseButton, {
                                  onactivate: () => setPage4(i),
                                  get className() {
                                    return libs.classNames("PageButton", {
                                      Selected: page4() == i
                                    });
                                  },
                                  get children() {
                                    return [(() => {
                                      const _el$33 = libs.createElement("Image", {}, null);
                                      libs.setProp(_el$33, "className", "BG");
                                      return _el$33;
                                    })(), libs.createComponent(GenericPanel.CLabel, {
                                      text: i
                                    })];
                                  }
                                });
                              }
                            }), libs.createComponent(EOM_Button.EOM_BaseButton, {
                              get enabled() {
                                return page4() != 10;
                              },
                              onactivate: () => setPage4(page4() + 1),
                              className: "PageButton PageRight",
                              get children() {
                                return [(() => {
                                  const _el$22 = libs.createElement("Image", {}, null);
                                  libs.setProp(_el$22, "className", "BG");
                                  return _el$22;
                                })(), (() => {
                                  const _el$23 = libs.createElement("Image", {}, null);
                                  libs.setProp(_el$23, "className", "PageArrow");
                                  return _el$23;
                                })()];
                              }
                            })];
                          }
                        })];
                      }
                    }), libs.createComponent(libs.Show, {
                      get when() {
                        return loading4();
                      },
                      get children() {
                        return libs.createComponent(EOM_Loading.EOM_Loading, {
                          align: "center center",
                          type: "PointSpin"
                        });
                      }
                    })];
                  }
                });
              }
            });
          }
        }), libs.createComponent(EOM_MenuLayout.EOM_MenuLayout_Content, {
          get show() {
            return seleted_menu() == "leaderboard_5";
          },
          get children() {
            return libs.createComponent(libs.Switch, {
              get fallback() {
                return libs.createComponent(EOM_Loading.EOM_Loading, {
                  align: "center center",
                  type: "PointSpin"
                });
              },
              get children() {
                return libs.createComponent(libs.Match, {
                  get when() {
                    return leaderboard4() != undefined;
                  },
                  get children() {
                    return [libs.createComponent(EOM_Panel.EOM_Panel, {
                      horizontalAlign: "center",
                      flowChildren: "down",
                      get children() {
                        return [(() => {
                          const _el$24 = libs.createElement("Panel", {
                            id: "RankTitleContainer"
                          }, null);
                          libs.insert(_el$24, libs.createComponent(GenericPanel.CLabel, {
                            text: "#leaderboard_5_title"
                          }), null);
                          libs.insert(_el$24, libs.createComponent(EOM_Image.EOM_Image, {
                            className: "RankInfoIcon",
                            tooltip: "#leaderboard_5_desc"
                          }), null);
                          return _el$24;
                        })(), (() => {
                          const _el$25 = libs.createElement("Panel", {
                            id: "TabContainer",
                            get ["class"]() {
                              return $.Language().toLowerCase();
                            }
                          }, null);
                          libs.insert(_el$25, libs.createComponent(EOM_Label.EOM_Label, {
                            width: "170px",
                            text: "#Rank_rank"
                          }), null);
                          libs.insert(_el$25, libs.createComponent(EOM_Label.EOM_Label, {
                            width: "460px",
                            text: "#Rank_info"
                          }), null);
                          libs.insert(_el$25, libs.createComponent(EOM_Label.EOM_Label, {
                            width: "600px",
                            text: "#Rank_ornament"
                          }), null);
                          libs.insert(_el$25, libs.createComponent(EOM_Label.EOM_Label, {
                            width: "fill-parent-flow(1)",
                            text: "#Collections"
                          }), null);
                          libs.effect(_$p => libs.setProp(_el$25, "class", $.Language().toLowerCase(), _$p));
                          return _el$25;
                        })(), libs.createComponent(EOM_Panel.EOM_Panel, {
                          ref(r$) {
                            const _ref$5 = rankList5;
                            typeof _ref$5 === "function" ? _ref$5(r$) : rankList5 = r$;
                          },
                          scroll: "y",
                          id: "RankList",
                          get className() {
                            return libs.classNames({
                              Show: !loading5()
                            });
                          },
                          flowChildren: "down",
                          paddingRight: "23px",
                          height: "740px",
                          get children() {
                            return libs.createComponent(libs.Index, {
                              get each() {
                                return leaderboardList5();
                              },
                              children: (rank, index) => {
                                const rankData = libs.createMemo(() => leaderboard5()?.[rank()]);
                                return libs.createComponent(libs.Show, {
                                  get when() {
                                    return rankData() != undefined;
                                  },
                                  get children() {
                                    return libs.createComponent(OrnamentRowLadder, {
                                      get rankData() {
                                        return rankData();
                                      },
                                      index: index
                                    });
                                  }
                                });
                              }
                            });
                          }
                        }), libs.createComponent(OrnamentRowLadder, {
                          get rankData() {
                            return selfRank5();
                          },
                          self: true
                        }), libs.createComponent(EOM_Panel.EOM_Panel, {
                          flowChildren: "right",
                          horizontalAlign: "center",
                          marginTop: "10px",
                          get children() {
                            return [libs.createComponent(EOM_Button.EOM_BaseButton, {
                              get enabled() {
                                return page5() != 1;
                              },
                              onactivate: () => setPage5(page5() - 1),
                              className: "PageButton PageLeft",
                              get children() {
                                return [(() => {
                                  const _el$26 = libs.createElement("Image", {}, null);
                                  libs.setProp(_el$26, "className", "BG");
                                  return _el$26;
                                })(), (() => {
                                  const _el$27 = libs.createElement("Image", {}, null);
                                  libs.setProp(_el$27, "className", "PageArrow");
                                  return _el$27;
                                })()];
                              }
                            }), libs.createComponent(libs.For, {
                              each: [1, 2, 3, 4, 5, 6, 7, 8, 9, 10],
                              children: i => {
                                return libs.createComponent(EOM_Button.EOM_BaseButton, {
                                  onactivate: () => setPage5(i),
                                  get className() {
                                    return libs.classNames("PageButton", {
                                      Selected: page5() == i
                                    });
                                  },
                                  get children() {
                                    return [(() => {
                                      const _el$34 = libs.createElement("Image", {}, null);
                                      libs.setProp(_el$34, "className", "BG");
                                      return _el$34;
                                    })(), libs.createComponent(GenericPanel.CLabel, {
                                      text: i
                                    })];
                                  }
                                });
                              }
                            }), libs.createComponent(EOM_Button.EOM_BaseButton, {
                              get enabled() {
                                return page5() != 10;
                              },
                              onactivate: () => setPage5(page5() + 1),
                              className: "PageButton PageRight",
                              get children() {
                                return [(() => {
                                  const _el$28 = libs.createElement("Image", {}, null);
                                  libs.setProp(_el$28, "className", "BG");
                                  return _el$28;
                                })(), (() => {
                                  const _el$29 = libs.createElement("Image", {}, null);
                                  libs.setProp(_el$29, "className", "PageArrow");
                                  return _el$29;
                                })()];
                              }
                            })];
                          }
                        })];
                      }
                    }), libs.createComponent(libs.Show, {
                      get when() {
                        return loading5();
                      },
                      get children() {
                        return libs.createComponent(EOM_Loading.EOM_Loading, {
                          align: "center center",
                          type: "PointSpin"
                        });
                      }
                    })];
                  }
                });
              }
            });
          }
        }), libs.memo(() => libs.createComponent(EOM_MenuLayout.EOM_MenuLayout_Content, {
          get show() {
            return seleted_menu() == "leaderboard_7";
          },
          get children() {
            return libs.createComponent(libs.Switch, {
              get fallback() {
                return libs.createComponent(EOM_Loading.EOM_Loading, {
                  align: "center center",
                  type: "PointSpin"
                });
              },
              get children() {
                return libs.createComponent(libs.Match, {
                  get when() {
                    return leaderboard7() != undefined;
                  },
                  get children() {
                    return [libs.createComponent(EOM_Panel.EOM_Panel, {
                      horizontalAlign: "center",
                      flowChildren: "down",
                      get children() {
                        return [libs.createComponent(EOM_Panel.EOM_Panel, {
                          id: "RankTitleContainer",
                          height: "80px",
                          width: "100%",
                          flowChildren: "none",
                          get children() {
                            return [libs.createComponent(EOM_Panel.EOM_Panel, {
                              align: "center center",
                              flowChildren: "right",
                              get children() {
                                return [libs.createComponent(GenericPanel.CLabel, {
                                  text: "#leaderboard_7_title"
                                }), libs.createComponent(EOM_Image.EOM_Image, {
                                  className: "RankInfoIcon",
                                  tooltip: "#PeakScore_description"
                                })];
                              }
                            }), libs.createComponent(EOM_Panel.EOM_Panel, {
                              id: "TitleFilters",
                              get children() {
                                return libs.createComponent(EOM_Panel.EOM_Panel, {
                                  className: "TitleFilter",
                                  get children() {
                                    return [libs.createComponent(EOM_Label.EOM_Label, {
                                      id: "TitleFilterLabel",
                                      text: "#PeakCup_SelectRegion"
                                    }), libs.createComponent(EOM_DropDown.EOM_DropDown, {
                                      id: "RankFilterDropDown",
                                      get index() {
                                        return (() => Math.max(0, peakRankFilterList.indexOf(peakRankFilted())))();
                                      },
                                      menuPosition: "bottom",
                                      onChange: (index, item) => {
                                        setPeakRankFilted(peakRankFilterList[index]);
                                      },
                                      get children() {
                                        return peakRankFilterList.map((type, index) => libs.createComponent(GenericPanel.CLabel, {
                                          get className() {
                                            return libs.classNames("TitleFilterType");
                                          },
                                          text: "#PeakScoreRegion_" + (type == "default" ? "0" : type)
                                        }));
                                      }
                                    })];
                                  }
                                });
                              }
                            })];
                          }
                        }), (() => {
                          const _el$35 = libs.createElement("Panel", {
                            id: "TabContainer"
                          }, null);
                          libs.insert(_el$35, libs.createComponent(EOM_Label.EOM_Label, {
                            width: "170px",
                            text: "#Rank_rank"
                          }), null);
                          libs.insert(_el$35, libs.createComponent(EOM_Label.EOM_Label, {
                            width: "380px",
                            text: "#Rank_info"
                          }), null);
                          libs.insert(_el$35, libs.createComponent(EOM_Label.EOM_Label, {
                            width: "250px",
                            text: "#Rank_medal"
                          }), null);
                          libs.insert(_el$35, libs.createComponent(EOM_Label.EOM_Label, {
                            width: "250px",
                            text: "#Rank_ChickRate"
                          }), null);
                          libs.insert(_el$35, libs.createComponent(EOM_Label.EOM_Label, {
                            width: "280px",
                            text: "#allCount"
                          }), null);
                          libs.insert(_el$35, libs.createComponent(EOM_Label.EOM_Label, {
                            width: "fill-parent-flow(1)",
                            text: "#Rank_Region"
                          }), null);
                          return _el$35;
                        })(), libs.createComponent(EOM_Panel.EOM_Panel, {
                          ref(r$) {
                            const _ref$6 = rankList7;
                            typeof _ref$6 === "function" ? _ref$6(r$) : rankList7 = r$;
                          },
                          scroll: "y",
                          id: "RankList",
                          get className() {
                            return libs.classNames({
                              Show: !loading7()
                            });
                          },
                          flowChildren: "down",
                          paddingRight: "23px",
                          height: "740px",
                          get children() {
                            return libs.createComponent(libs.Index, {
                              get each() {
                                return leaderboardList7();
                              },
                              children: (rank, index) => {
                                const rankData = () => leaderboard7()[Number(rank())];
                                return libs.createComponent(PeakScoreRankRowWin, {
                                  get rankData() {
                                    return rankData();
                                  },
                                  index: index,
                                  get region() {
                                    return peakRankFilted();
                                  }
                                });
                              }
                            });
                          }
                        }), libs.createComponent(PeakScoreRankRowWin, {
                          get rankData() {
                            return selfRank7();
                          },
                          self: true
                        }), libs.createComponent(EOM_Panel.EOM_Panel, {
                          flowChildren: "right",
                          horizontalAlign: "center",
                          marginTop: "10px",
                          get children() {
                            return [libs.createComponent(EOM_Button.EOM_BaseButton, {
                              get enabled() {
                                return page7() != 1;
                              },
                              onactivate: () => setPage7(page7() - 1),
                              className: "PageButton PageLeft",
                              get children() {
                                return [(() => {
                                  const _el$36 = libs.createElement("Image", {}, null);
                                  libs.setProp(_el$36, "className", "BG");
                                  return _el$36;
                                })(), (() => {
                                  const _el$37 = libs.createElement("Image", {}, null);
                                  libs.setProp(_el$37, "className", "PageArrow");
                                  return _el$37;
                                })()];
                              }
                            }), libs.createComponent(libs.For, {
                              each: [1, 2, 3, 4, 5, 6, 7, 8, 9, 10],
                              children: i => {
                                return libs.createComponent(EOM_Button.EOM_BaseButton, {
                                  onactivate: () => setPage7(i),
                                  get className() {
                                    return libs.classNames("PageButton", {
                                      Selected: page7() == i
                                    });
                                  },
                                  get children() {
                                    return [(() => {
                                      const _el$40 = libs.createElement("Image", {}, null);
                                      libs.setProp(_el$40, "className", "BG");
                                      return _el$40;
                                    })(), libs.createComponent(GenericPanel.CLabel, {
                                      text: i
                                    })];
                                  }
                                });
                              }
                            }), libs.createComponent(EOM_Button.EOM_BaseButton, {
                              get enabled() {
                                return page7() != 10;
                              },
                              onactivate: () => setPage7(page7() + 1),
                              className: "PageButton PageRight",
                              get children() {
                                return [(() => {
                                  const _el$38 = libs.createElement("Image", {}, null);
                                  libs.setProp(_el$38, "className", "BG");
                                  return _el$38;
                                })(), (() => {
                                  const _el$39 = libs.createElement("Image", {}, null);
                                  libs.setProp(_el$39, "className", "PageArrow");
                                  return _el$39;
                                })()];
                              }
                            })];
                          }
                        })];
                      }
                    }), libs.createComponent(libs.Show, {
                      get when() {
                        return loading7();
                      },
                      get children() {
                        return libs.createComponent(EOM_Loading.EOM_Loading, {
                          align: "center center",
                          type: "PointSpin"
                        });
                      }
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
  const RankRowMedal = props => {
    const avatarBorder = () => {
      if (props.self) return;
      return props.rankData.oid ?? 5710000;
    };
    const avatarBG = () => {
      if (props.self) return;
      return props.rankData.oid2 ?? 5720000;
    };
    const avatarDecoration = () => {
      if (props.self) return;
      return props.rankData.oid3 ?? 5730000;
    };
    return (() => {
      const _el$41 = libs.createElement("Panel", {}, null),
        _el$42 = libs.createElement("Image", {}, _el$41),
        _el$43 = libs.createElement("Image", {}, _el$41),
        _el$44 = libs.createElement("Image", {}, _el$41);
      libs.setProp(_el$42, "className", "RankBGLeft");
      libs.setProp(_el$43, "className", "RankBGRight");
      libs.setProp(_el$44, "className", "RankBG");
      libs.insert(_el$41, libs.createComponent(EOM_Panel.EOM_Panel, {
        flowChildren: "right",
        width: "100%",
        height: "100%",
        get children() {
          return [(() => {
            const _el$45 = libs.createElement("Panel", {
              id: "Tab_Rank"
            }, null);
            libs.setProp(_el$45, "className", "RankRowTab");
            libs.insert(_el$45, libs.createComponent(libs.Switch, {
              get children() {
                return [libs.createComponent(libs.Match, {
                  get when() {
                    return props.rankData.rank == -1;
                  },
                  get children() {
                    return libs.createComponent(GenericPanel.CLabel, {
                      className: "NoRank",
                      text: "#SnowRankLabel1"
                    });
                  }
                }), libs.createComponent(libs.Match, {
                  get when() {
                    return props.rankData.rank <= 3;
                  },
                  get children() {
                    const _el$46 = libs.createElement("Image", {}, null);
                    libs.effect(_$p => libs.setProp(_el$46, "className", "RankIcon Rank" + props.rankData.rank, _$p));
                    return _el$46;
                  }
                }), libs.createComponent(libs.Match, {
                  get when() {
                    return props.rankData.rank > 3;
                  },
                  get children() {
                    return libs.createComponent(GenericPanel.CLabel, {
                      get text() {
                        return props.rankData.rank;
                      }
                    });
                  }
                })];
              }
            }));
            return _el$45;
          })(), libs.createComponent(EOM_Panel.EOM_Panel, {
            id: "Tab_Info",
            className: "RankRowTab",
            get children() {
              return libs.createComponent(EOM_Panel.EOM_Panel, {
                flowChildren: "right",
                get customTooltip() {
                  return {
                    name: "ladder_player_profile",
                    steamID: props.rankData.uid,
                    avatarBorder: avatarBorder(),
                    avatarBG: avatarBG(),
                    avatarDecoration: avatarDecoration(),
                    ban: props.rankData.ban?.name ? 1 : 0
                  };
                },
                onactivate: () => {
                  showPopup("PlayerProfile", {
                    uid: props.rankData.uid,
                    ornament_equipted: {
                      [OrnamentType.AVATAR_BORDER]: avatarBorder(),
                      [OrnamentType.AVATAR_BACKGROUND]: avatarBG(),
                      [OrnamentType.AVATAR_DECORATION]: avatarDecoration()
                    },
                    ban: props.rankData.ban?.name
                  });
                },
                get children() {
                  return [libs.createComponent(Player.PlayerAvatar, {
                    get steamID() {
                      return props.rankData.uid.toString();
                    },
                    get ban() {
                      return props.rankData.ban?.name == true;
                    },
                    get playerID() {
                      return Players.GetLocalPlayer();
                    },
                    get avatar_border() {
                      return avatarBorder();
                    }
                  }), libs.createComponent(Player.PlayerName, {
                    get steamID() {
                      return props.rankData.uid.toString();
                    },
                    get ban() {
                      return props.rankData.ban?.name == true;
                    }
                  })];
                }
              });
            }
          }), (() => {
            const _el$47 = libs.createElement("Panel", {
              id: "Tab_Medal"
            }, null);
            libs.setProp(_el$47, "className", "RankRowTab");
            libs.insert(_el$47, libs.createComponent(MedalBadgeIcon.MedalBadgeIcon, {
              get medal_count() {
                return props.rankData.value ?? 0;
              }
            }), null);
            libs.insert(_el$47, libs.createComponent(GenericPanel.CLabel, {
              get text() {
                return props.rankData.value ?? 0;
              }
            }), null);
            return _el$47;
          })(), libs.createComponent(GenericPanel.CLabel, {
            id: "Tab_Win",
            className: "RankRowTab",
            get text() {
              return ((props.rankData.extra.win_percent ?? 0) * 100).toFixed(2) + "%";
            }
          }), (() => {
            const _el$48 = libs.createElement("Panel", {
              id: "Tab_Hero"
            }, null);
            libs.setProp(_el$48, "className", "RankRowTab");
            libs.insert(_el$48, libs.createComponent(libs.Index, {
              get each() {
                return props.rankData.extra.main_heroes;
              },
              children: hid => {
                return libs.createComponent(Heroes.HeroImage, {
                  get hero_name() {
                    return GetHeroNameByGoodID(hid());
                  }
                });
              }
            }));
            return _el$48;
          })()];
        }
      }), null);
      libs.effect(_$p => libs.setProp(_el$41, "className", libs.classNames("RankRow", "Rank" + props.rankData.rank, "Index" + (props.index ?? 0) % 2, {
        Self: props.self
      }), _$p));
      return _el$41;
    })();
  };
  const RankRowWin = props => {
    const avatarBorder = () => {
      if (props.self) return;
      return props.rankData.oid ?? 5710000;
    };
    const avatarBG = () => {
      if (props.self) return;
      return props.rankData.oid2 ?? 5720000;
    };
    const avatarDecoration = () => {
      if (props.self) return;
      return props.rankData.oid3 ?? 5730000;
    };
    return (() => {
      const _el$49 = libs.createElement("Panel", {}, null),
        _el$50 = libs.createElement("Image", {}, _el$49),
        _el$51 = libs.createElement("Image", {}, _el$49),
        _el$52 = libs.createElement("Image", {}, _el$49);
      libs.setProp(_el$50, "className", "RankBGLeft");
      libs.setProp(_el$51, "className", "RankBGRight");
      libs.setProp(_el$52, "className", "RankBG");
      libs.insert(_el$49, libs.createComponent(EOM_Panel.EOM_Panel, {
        flowChildren: "right",
        width: "100%",
        height: "100%",
        get children() {
          return [(() => {
            const _el$53 = libs.createElement("Panel", {
              id: "Tab_Rank"
            }, null);
            libs.setProp(_el$53, "className", "RankRowTab");
            libs.insert(_el$53, libs.createComponent(libs.Switch, {
              get children() {
                return [libs.createComponent(libs.Match, {
                  get when() {
                    return props.rankData.rank == -1;
                  },
                  get children() {
                    return libs.createComponent(GenericPanel.CLabel, {
                      className: "NoRank",
                      text: "#SnowRankLabel1"
                    });
                  }
                }), libs.createComponent(libs.Match, {
                  get when() {
                    return props.rankData.rank <= 3;
                  },
                  get children() {
                    const _el$54 = libs.createElement("Image", {}, null);
                    libs.effect(_$p => libs.setProp(_el$54, "className", "RankIcon Rank" + props.rankData.rank, _$p));
                    return _el$54;
                  }
                }), libs.createComponent(libs.Match, {
                  get when() {
                    return props.rankData.rank > 3;
                  },
                  get children() {
                    return libs.createComponent(GenericPanel.CLabel, {
                      get text() {
                        return props.rankData.rank;
                      }
                    });
                  }
                })];
              }
            }));
            return _el$53;
          })(), libs.createComponent(EOM_Panel.EOM_Panel, {
            id: "Tab_Info",
            className: "RankRowTab",
            get children() {
              return libs.createComponent(EOM_Panel.EOM_Panel, {
                flowChildren: "right",
                get customTooltip() {
                  return {
                    name: "ladder_player_profile",
                    steamID: props.rankData.uid,
                    avatarBorder: avatarBorder(),
                    avatarBG: avatarBG(),
                    avatarDecoration: avatarDecoration(),
                    ban: props.rankData.ban?.name ? 1 : 0
                  };
                },
                onactivate: () => {
                  showPopup("PlayerProfile", {
                    uid: props.rankData.uid,
                    ornament_equipted: {
                      [OrnamentType.AVATAR_BORDER]: avatarBorder(),
                      [OrnamentType.AVATAR_BACKGROUND]: avatarBG(),
                      [OrnamentType.AVATAR_DECORATION]: avatarDecoration()
                    },
                    ban: props.rankData.ban?.name
                  });
                },
                get children() {
                  return [libs.createComponent(Player.PlayerAvatar, {
                    get steamID() {
                      return props.rankData.uid.toString();
                    },
                    get ban() {
                      return props.rankData.ban?.name == true;
                    },
                    get playerID() {
                      return Players.GetLocalPlayer();
                    },
                    get avatar_border() {
                      return avatarBorder();
                    }
                  }), libs.createComponent(Player.PlayerName, {
                    get steamID() {
                      return props.rankData.uid.toString();
                    },
                    get ban() {
                      return props.rankData.ban?.name == true;
                    }
                  })];
                }
              });
            }
          }), (() => {
            const _el$55 = libs.createElement("Panel", {
                id: "Tab_Chicken"
              }, null);
              libs.createElement("Image", {}, _el$55);
            libs.setProp(_el$55, "className", "RankRowTab");
            libs.insert(_el$55, libs.createComponent(GenericPanel.CLabel, {
              get text() {
                return "x" + (props.rankData.value ?? 0);
              }
            }), null);
            return _el$55;
          })(), (() => {
            const _el$57 = libs.createElement("Panel", {
              id: "Tab_Hero"
            }, null);
            libs.setProp(_el$57, "className", "RankRowTab");
            libs.insert(_el$57, libs.createComponent(libs.Index, {
              get each() {
                return props.rankData.extra.main_heroes;
              },
              children: hid => {
                return libs.createComponent(Heroes.HeroImage, {
                  get hero_name() {
                    return GetHeroNameByGoodID(hid());
                  }
                });
              }
            }));
            return _el$57;
          })()];
        }
      }), null);
      libs.effect(_$p => libs.setProp(_el$49, "className", libs.classNames("RankRow", "Rank" + props.rankData.rank, "Index" + (props.index ?? 0) % 2, {
        Self: props.self
      }), _$p));
      return _el$49;
    })();
  };
  const RankRowItem = props => {
    const avatarBorder = () => {
      if (props.self) return;
      return props.rankData.oid ?? 5710000;
    };
    const avatarBG = () => {
      if (props.self) return;
      return props.rankData.oid2 ?? 5720000;
    };
    const avatarDecoration = () => {
      if (props.self) return;
      return props.rankData.oid3 ?? 5730000;
    };
    return (() => {
      const _el$58 = libs.createElement("Panel", {}, null),
        _el$59 = libs.createElement("Image", {}, _el$58),
        _el$60 = libs.createElement("Image", {}, _el$58),
        _el$61 = libs.createElement("Image", {}, _el$58);
      libs.setProp(_el$59, "className", "RankBGLeft");
      libs.setProp(_el$60, "className", "RankBGRight");
      libs.setProp(_el$61, "className", "RankBG");
      libs.insert(_el$58, libs.createComponent(EOM_Panel.EOM_Panel, {
        flowChildren: "right",
        width: "100%",
        height: "100%",
        get children() {
          return [(() => {
            const _el$62 = libs.createElement("Panel", {
              id: "Tab_Rank"
            }, null);
            libs.setProp(_el$62, "className", "RankRowTab");
            libs.insert(_el$62, libs.createComponent(libs.Switch, {
              get children() {
                return [libs.createComponent(libs.Match, {
                  get when() {
                    return props.rankData.rank == -1;
                  },
                  get children() {
                    return libs.createComponent(GenericPanel.CLabel, {
                      className: "NoRank",
                      text: "#SnowRankLabel1"
                    });
                  }
                }), libs.createComponent(libs.Match, {
                  get when() {
                    return props.rankData.rank <= 3;
                  },
                  get children() {
                    const _el$63 = libs.createElement("Image", {}, null);
                    libs.effect(_$p => libs.setProp(_el$63, "className", "RankIcon Rank" + props.rankData.rank, _$p));
                    return _el$63;
                  }
                }), libs.createComponent(libs.Match, {
                  get when() {
                    return props.rankData.rank > 3;
                  },
                  get children() {
                    return libs.createComponent(GenericPanel.CLabel, {
                      get text() {
                        return props.rankData.rank;
                      }
                    });
                  }
                })];
              }
            }));
            return _el$62;
          })(), libs.createComponent(EOM_Panel.EOM_Panel, {
            id: "Tab_Info",
            className: "RankRowTab",
            get children() {
              return libs.createComponent(EOM_Panel.EOM_Panel, {
                flowChildren: "right",
                get customTooltip() {
                  return {
                    name: "ladder_player_profile",
                    steamID: props.rankData.uid,
                    avatarBorder: avatarBorder(),
                    avatarBG: avatarBG(),
                    avatarDecoration: avatarDecoration(),
                    ban: props.rankData.ban?.name ? 1 : 0
                  };
                },
                onactivate: () => {
                  showPopup("PlayerProfile", {
                    uid: props.rankData.uid,
                    ornament_equipted: {
                      [OrnamentType.AVATAR_BORDER]: avatarBorder(),
                      [OrnamentType.AVATAR_BACKGROUND]: avatarBG(),
                      [OrnamentType.AVATAR_DECORATION]: avatarDecoration()
                    },
                    ban: props.rankData.ban?.name
                  });
                },
                get children() {
                  return [libs.createComponent(Player.PlayerAvatar, {
                    get steamID() {
                      return props.rankData.uid.toString();
                    },
                    get ban() {
                      return props.rankData.ban?.name == true;
                    },
                    get playerID() {
                      return Players.GetLocalPlayer();
                    },
                    get avatar_border() {
                      return avatarBorder();
                    }
                  }), libs.createComponent(Player.PlayerName, {
                    get steamID() {
                      return props.rankData.uid.toString();
                    },
                    get ban() {
                      return props.rankData.ban?.name == true;
                    }
                  })];
                }
              });
            }
          }), (() => {
            const _el$64 = libs.createElement("Panel", {
                id: "Tab_Item"
              }, null);
              libs.createElement("Image", {}, _el$64);
            libs.setProp(_el$64, "className", "RankRowTab");
            libs.insert(_el$64, libs.createComponent(GenericPanel.CLabel, {
              get text() {
                return "x" + (props.rankData.value ?? 0);
              }
            }), null);
            return _el$64;
          })()];
        }
      }), null);
      libs.effect(_$p => libs.setProp(_el$58, "className", libs.classNames("RankRow", "Rank" + props.rankData.rank, "Index" + (props.index ?? 0) % 2, {
        Self: props.self
      }), _$p));
      return _el$58;
    })();
  };
  const RankRowLadder = props => {
    const avatarBorder = () => {
      if (props.self) return;
      return props.rankData.oid ?? 5710000;
    };
    const avatarBG = () => {
      if (props.self) return;
      return props.rankData.oid2 ?? 5720000;
    };
    const avatarDecoration = () => {
      if (props.self) return;
      return props.rankData.oid3 ?? 5730000;
    };
    return (() => {
      const _el$66 = libs.createElement("Panel", {}, null),
        _el$67 = libs.createElement("Image", {}, _el$66),
        _el$68 = libs.createElement("Image", {}, _el$66),
        _el$69 = libs.createElement("Image", {}, _el$66);
      libs.setProp(_el$67, "className", "RankBGLeft");
      libs.setProp(_el$68, "className", "RankBGRight");
      libs.setProp(_el$69, "className", "RankBG");
      libs.insert(_el$66, libs.createComponent(EOM_Panel.EOM_Panel, {
        flowChildren: "right",
        width: "100%",
        height: "100%",
        get children() {
          return [(() => {
            const _el$70 = libs.createElement("Panel", {
              id: "Tab_Rank"
            }, null);
            libs.setProp(_el$70, "className", "RankRowTab");
            libs.insert(_el$70, libs.createComponent(libs.Switch, {
              get children() {
                return [libs.createComponent(libs.Match, {
                  get when() {
                    return props.rankData.rank == -1;
                  },
                  get children() {
                    return libs.createComponent(GenericPanel.CLabel, {
                      className: "NoRank",
                      text: "#SnowRankLabel1"
                    });
                  }
                }), libs.createComponent(libs.Match, {
                  get when() {
                    return props.rankData.rank <= 3;
                  },
                  get children() {
                    const _el$71 = libs.createElement("Image", {}, null);
                    libs.effect(_$p => libs.setProp(_el$71, "className", "RankIcon Rank" + props.rankData.rank, _$p));
                    return _el$71;
                  }
                }), libs.createComponent(libs.Match, {
                  get when() {
                    return props.rankData.rank > 3;
                  },
                  get children() {
                    return libs.createComponent(GenericPanel.CLabel, {
                      get text() {
                        return props.rankData.rank;
                      }
                    });
                  }
                })];
              }
            }));
            return _el$70;
          })(), libs.createComponent(EOM_Panel.EOM_Panel, {
            id: "Tab_Info",
            className: "RankRowTab",
            get children() {
              return libs.createComponent(EOM_Panel.EOM_Panel, {
                flowChildren: "right",
                get customTooltip() {
                  return {
                    name: "ladder_player_profile",
                    steamID: props.rankData.uid,
                    avatarBorder: avatarBorder(),
                    avatarBG: avatarBG(),
                    avatarDecoration: avatarDecoration(),
                    ban: props.rankData.ban?.name ? 1 : 0
                  };
                },
                onactivate: () => {
                  showPopup("PlayerProfile", {
                    uid: props.rankData.uid,
                    ornament_equipted: {
                      [OrnamentType.AVATAR_BORDER]: avatarBorder(),
                      [OrnamentType.AVATAR_BACKGROUND]: avatarBG(),
                      [OrnamentType.AVATAR_DECORATION]: avatarDecoration()
                    },
                    ban: props.rankData.ban?.name
                  });
                },
                get children() {
                  return [libs.createComponent(Player.PlayerAvatar, {
                    get steamID() {
                      return props.rankData.uid.toString();
                    },
                    get ban() {
                      return props.rankData.ban?.name == true;
                    },
                    get playerID() {
                      return Players.GetLocalPlayer();
                    },
                    get avatar_border() {
                      return avatarBorder();
                    }
                  }), libs.createComponent(Player.PlayerName, {
                    get steamID() {
                      return props.rankData.uid.toString();
                    },
                    get ban() {
                      return props.rankData.ban?.name == true;
                    }
                  })];
                }
              });
            }
          }), (() => {
            const _el$72 = libs.createElement("Panel", {
              id: "Tab_Ladder"
            }, null);
            libs.setProp(_el$72, "className", "RankRowTab");
            libs.insert(_el$72, libs.createComponent(RankTierIcon.RankTierIcon, {
              size: "150",
              get rank_score() {
                return props.rankData.value ?? 0;
              },
              get rank() {
                return props.rankData.rank;
              },
              showtooltip: true
            }), null);
            libs.insert(_el$72, libs.createComponent(GenericPanel.CLabel, {
              get text() {
                return props.rankData.value ?? 0;
              }
            }), null);
            return _el$72;
          })(), libs.createComponent(GenericPanel.CLabel, {
            id: "Tab_Win",
            className: "RankRowTab",
            get text() {
              return ((props.rankData.extra.win_percent ?? 0) * 100).toFixed(2) + "%";
            }
          }), (() => {
            const _el$73 = libs.createElement("Panel", {
              id: "Tab_Hero"
            }, null);
            libs.setProp(_el$73, "className", "RankRowTab");
            libs.insert(_el$73, libs.createComponent(libs.Index, {
              get each() {
                return props.rankData.extra.main_heroes;
              },
              children: hid => {
                return libs.createComponent(Heroes.HeroImage, {
                  get hero_name() {
                    return GetHeroNameByGoodID(hid());
                  }
                });
              }
            }));
            return _el$73;
          })()];
        }
      }), null);
      libs.effect(_$p => libs.setProp(_el$66, "className", libs.classNames("RankRow", "Rank" + props.rankData.rank, "Index" + (props.index ?? 0) % 2, {
        Self: props.self
      }), _$p));
      return _el$66;
    })();
  };
  const OrnamentRowLadder = props => {
    const avatarBorder = () => {
      if (props.self) return;
      return props.rankData.oid ?? 5710000;
    };
    const avatarBG = () => {
      if (props.self) return;
      return props.rankData.oid2 ?? 5720000;
    };
    const avatarDecoration = () => {
      if (props.self) return;
      return props.rankData.oid3 ?? 5730000;
    };
    return (() => {
      const _el$74 = libs.createElement("Panel", {}, null),
        _el$75 = libs.createElement("Image", {}, _el$74),
        _el$76 = libs.createElement("Image", {}, _el$74),
        _el$77 = libs.createElement("Image", {}, _el$74);
      libs.setProp(_el$75, "className", "RankBGLeft");
      libs.setProp(_el$76, "className", "RankBGRight");
      libs.setProp(_el$77, "className", "RankBG");
      libs.insert(_el$74, libs.createComponent(EOM_Panel.EOM_Panel, {
        flowChildren: "right",
        width: "100%",
        height: "100%",
        get children() {
          return [(() => {
            const _el$78 = libs.createElement("Panel", {
              id: "Tab_Rank"
            }, null);
            libs.setProp(_el$78, "className", "RankRowTab");
            libs.insert(_el$78, libs.createComponent(libs.Switch, {
              get children() {
                return [libs.createComponent(libs.Match, {
                  get when() {
                    return props.rankData.rank == -1;
                  },
                  get children() {
                    return libs.createComponent(GenericPanel.CLabel, {
                      className: "NoRank",
                      text: "#SnowRankLabel1"
                    });
                  }
                }), libs.createComponent(libs.Match, {
                  get when() {
                    return props.rankData.rank <= 3;
                  },
                  get children() {
                    const _el$79 = libs.createElement("Image", {}, null);
                    libs.effect(_$p => libs.setProp(_el$79, "className", "RankIcon Rank" + props.rankData.rank, _$p));
                    return _el$79;
                  }
                }), libs.createComponent(libs.Match, {
                  get when() {
                    return props.rankData.rank > 3;
                  },
                  get children() {
                    return libs.createComponent(GenericPanel.CLabel, {
                      get text() {
                        return props.rankData.rank;
                      }
                    });
                  }
                })];
              }
            }));
            return _el$78;
          })(), libs.createComponent(EOM_Panel.EOM_Panel, {
            id: "Tab_Info",
            className: "RankRowTab",
            get children() {
              return libs.createComponent(EOM_Panel.EOM_Panel, {
                flowChildren: "right",
                get customTooltip() {
                  return {
                    name: "ladder_player_profile",
                    steamID: props.rankData.uid,
                    avatarBorder: avatarBorder(),
                    avatarBG: avatarBG(),
                    avatarDecoration: avatarDecoration(),
                    ban: props.rankData.ban?.name ? 1 : 0
                  };
                },
                onactivate: () => {
                  showPopup("PlayerProfile", {
                    uid: props.rankData.uid,
                    ornament_equipted: {
                      [OrnamentType.AVATAR_BORDER]: avatarBorder(),
                      [OrnamentType.AVATAR_BACKGROUND]: avatarBG(),
                      [OrnamentType.AVATAR_DECORATION]: avatarDecoration()
                    },
                    ban: props.rankData.ban?.name
                  });
                },
                get children() {
                  return [libs.createComponent(Player.PlayerAvatar, {
                    get steamID() {
                      return props.rankData.uid.toString();
                    },
                    get ban() {
                      return props.rankData.ban?.name == true;
                    },
                    get playerID() {
                      return Players.GetLocalPlayer();
                    },
                    get avatar_border() {
                      return avatarBorder();
                    }
                  }), libs.createComponent(Player.PlayerName, {
                    get steamID() {
                      return props.rankData.uid.toString();
                    },
                    get ban() {
                      return props.rankData.ban?.name == true;
                    }
                  })];
                }
              });
            }
          }), (() => {
            const _el$80 = libs.createElement("Panel", {
              id: "Tab_Ornament"
            }, null);
            libs.setProp(_el$80, "className", "RankRowTab");
            libs.insert(_el$80, libs.createComponent(EOM_Icon.EOM_Icon, {
              width: "57px",
              height: "65px",
              get src() {
                return getSrcPath("rank/collect_icon.png");
              }
            }), null);
            libs.insert(_el$80, libs.createComponent(GenericPanel.CLabel, {
              get text() {
                return `x${props.rankData.value ?? 0}`;
              }
            }), null);
            return _el$80;
          })(), (() => {
            const _el$81 = libs.createElement("Panel", {
              id: "Tab_Collect"
            }, null);
            libs.setProp(_el$81, "className", "RankRowTab");
            libs.insert(_el$81, libs.createComponent(EOM_Panel.EOM_Panel, {
              align: "right center",
              marginRight: "80px",
              flowChildren: "right",
              get children() {
                return [...Array(3)].map((_, i) => {
                  const oid = () => (props.rankData.extra.ornament_slots ?? [])[i] ?? -1;
                  return libs.createComponent(EOM_Panel.EOM_Panel, {
                    get className() {
                      return libs.classNames("CollectContainer", "Rarity" + getCosmeticRarity(oid()));
                    },
                    get children() {
                      return libs.createComponent(libs.Show, {
                        get when() {
                          return oid() != -1;
                        },
                        get fallback() {
                          return libs.createComponent(EOM_Image.EOM_Image, {
                            className: "CosmeticImageNone",
                            get src() {
                              return getSrcPath("profile/d_icon_02.png");
                            }
                          });
                        },
                        get children() {
                          return libs.createComponent(CosmeticCard.CosmeticImage, {
                            get itemid() {
                              return oid();
                            },
                            onmouseover: self => {
                              $.DispatchEvent("DOTAShowTitleTextTooltip", self, "#" + oid(), "#" + oid() + "_description");
                            },
                            onmouseout: self => {
                              $.DispatchEvent("DOTAHideTitleTextTooltip", self);
                            }
                          });
                        }
                      });
                    }
                  });
                });
              }
            }));
            return _el$81;
          })()];
        }
      }), null);
      libs.effect(_$p => libs.setProp(_el$74, "className", libs.classNames("RankRow", "Rank" + props.rankData.rank, "Index" + (props.index ?? 0) % 2, {
        Self: props.self
      }), _$p));
      return _el$74;
    })();
  };
  const PeakCupOffset = {
    ["1"]: 0,
    ["2"]: 0
  };
  const PeakScoreRankRowWin = props => {
    const avatarBorder = () => {
      if (props.self) return;
      return props.rankData.oid ?? 5710000;
    };
    const avatarBG = () => {
      if (props.self) return;
      return props.rankData.oid2 ?? 5720000;
    };
    const avatarDecoration = () => {
      if (props.self) return;
      return props.rankData.oid3 ?? 5730000;
    };
    const region = () => {
      return props.rankData.extra.kings_score_region ?? "default";
    };
    const totalCount = () => {
      return props.rankData.extra.total_count;
    };
    const rank = () => {
      return props.rankData.rank ?? -1;
    };
    return (() => {
      const _el$92 = libs.createElement("Panel", {}, null),
        _el$93 = libs.createElement("Image", {}, _el$92),
        _el$94 = libs.createElement("Image", {}, _el$92),
        _el$95 = libs.createElement("Image", {}, _el$92),
        _el$96 = libs.createElement("Image", {}, _el$92);
      libs.setProp(_el$93, "className", "RankBGLeft");
      libs.setProp(_el$94, "className", "RankBGCenter");
      libs.setProp(_el$95, "className", "RankBGRight");
      libs.setProp(_el$96, "className", "RankBG");
      libs.insert(_el$92, libs.createComponent(EOM_Panel.EOM_Panel, {
        flowChildren: "right",
        width: "100%",
        height: "100%",
        get children() {
          return [(() => {
            const _el$97 = libs.createElement("Panel", {
              id: "Tab_Rank"
            }, null);
            libs.setProp(_el$97, "className", "RankRowTab");
            libs.insert(_el$97, libs.createComponent(libs.Switch, {
              get children() {
                return [libs.createComponent(libs.Match, {
                  get when() {
                    return props.rankData.rank == -1;
                  },
                  get children() {
                    return libs.createComponent(GenericPanel.CLabel, {
                      className: "NoRank",
                      text: "#SnowRankLabel1"
                    });
                  }
                }), libs.createComponent(libs.Match, {
                  get when() {
                    return props.rankData.rank <= 3;
                  },
                  get children() {
                    const _el$98 = libs.createElement("Image", {}, null);
                    libs.effect(_$p => libs.setProp(_el$98, "className", "RankIcon Rank" + props.rankData.rank, _$p));
                    return _el$98;
                  }
                }), libs.createComponent(libs.Match, {
                  get when() {
                    return props.rankData.rank > 3;
                  },
                  get children() {
                    return libs.createComponent(GenericPanel.CLabel, {
                      get text() {
                        return props.rankData.rank;
                      }
                    });
                  }
                })];
              }
            }));
            return _el$97;
          })(), libs.createComponent(EOM_Panel.EOM_Panel, {
            id: "Tab_Info",
            className: "RankRowTab",
            get children() {
              return libs.createComponent(EOM_Panel.EOM_Panel, {
                flowChildren: "right",
                get customTooltip() {
                  return {
                    name: "ladder_player_profile",
                    playerID: props.self ? Players.GetLocalPlayer() : undefined,
                    steamID: props.rankData.uid,
                    avatarBorder: avatarBorder(),
                    avatarBG: avatarBG(),
                    avatarDecoration: avatarDecoration(),
                    ban: props.rankData.ban?.name ? 1 : 0
                  };
                },
                onactivate: () => {
                  showPopup("PlayerProfile", {
                    uid: props.rankData.uid,
                    ornament_equipted: {
                      [OrnamentType.AVATAR_BORDER]: avatarBorder(),
                      [OrnamentType.AVATAR_BACKGROUND]: avatarBG(),
                      [OrnamentType.AVATAR_DECORATION]: avatarDecoration()
                    },
                    ban: props.rankData.ban?.name
                  });
                },
                get children() {
                  return [libs.createComponent(Player.PlayerAvatar, {
                    get steamID() {
                      return props.rankData.uid.toString();
                    },
                    get ban() {
                      return props.rankData.ban?.name == true;
                    },
                    get playerID() {
                      return Players.GetLocalPlayer();
                    },
                    get avatar_border() {
                      return avatarBorder();
                    }
                  }), libs.createComponent(Player.PlayerName, {
                    get steamID() {
                      return props.rankData.uid.toString();
                    },
                    get ban() {
                      return props.rankData.ban?.name == true;
                    }
                  })];
                }
              });
            }
          }), (() => {
            const _el$99 = libs.createElement("Panel", {
              id: "Tab_Score"
            }, null);
            libs.setProp(_el$99, "className", "RankRowTab");
            libs.insert(_el$99, libs.createComponent(EOM_Panel.EOM_Panel, {
              align: "center center",
              flowChildren: "right",
              get children() {
                return [libs.createComponent(EOM_Icon.EOM_Icon, {}), libs.createComponent(GenericPanel.CLabel, {
                  get text() {
                    return props.rankData.value ?? 0;
                  }
                })];
              }
            }));
            return _el$99;
          })(), (() => {
            const _el$100 = libs.createElement("Panel", {
              id: "Tab_ChickRate"
            }, null);
            libs.setProp(_el$100, "className", "RankRowTab");
            libs.insert(_el$100, libs.createComponent(EOM_Panel.EOM_Panel, {
              align: "center center",
              flowChildren: "right",
              get children() {
                return libs.createComponent(GenericPanel.CLabel, {
                  get text() {
                    return `${Clamp(Round((props.rankData.extra.rank1_count ?? 0) / (totalCount() ?? 1) * 100, 1), 0, 100)}%`;
                  }
                });
              }
            }));
            return _el$100;
          })(), (() => {
            const _el$101 = libs.createElement("Panel", {
              id: "Tab_MatchCount"
            }, null);
            libs.setProp(_el$101, "className", "RankRowTab");
            libs.insert(_el$101, libs.createComponent(EOM_Panel.EOM_Panel, {
              align: "center center",
              flowChildren: "right",
              get children() {
                return libs.createComponent(GenericPanel.CLabel, {
                  get text() {
                    return totalCount() ?? 0;
                  }
                });
              }
            }));
            return _el$101;
          })(), (() => {
            const _el$102 = libs.createElement("Panel", {
              id: "Tab_Region"
            }, null);
            libs.setProp(_el$102, "className", "RankRowTab");
            libs.insert(_el$102, libs.createComponent(EOM_Panel.EOM_Panel, {
              align: "center center",
              flowChildren: "right",
              get children() {
                return libs.createComponent(libs.Show, {
                  get when() {
                    return props.self && RegionSelectEnable;
                  },
                  get fallback() {
                    return libs.createComponent(GenericPanel.CLabel, {
                      get text() {
                        return `#PeakScoreRegion_${region()}`;
                      }
                    });
                  },
                  get children() {
                    return libs.createComponent(EOM_Panel.EOM_Panel, {
                      get children() {
                        return [libs.memo(() => (() => {
                          const text = () => {
                            return selfRegion() == "default" ? "#PeakCup_SelectRegion" : `#PeakScoreRegion_${selfRegion()}`;
                          };
                          return libs.createComponent(EOM_Button.EOM_Button, {
                            color: "Blue",
                            get text() {
                              return text();
                            },
                            onactivate: () => {
                              showPopup("PeakSignUp", {
                                count: totalCount() ?? 0,
                                region: selfRegion()
                              });
                              setPeakSignUpMark();
                            }
                          });
                        })()), libs.createComponent(libs.Show, {
                          get when() {
                            return peakSignUpMark() != undefined;
                          },
                          get children() {
                            return libs.createComponent(MenuMarkIcon.MenuMarkIcon, {
                              margin: "6px",
                              get type() {
                                return peakSignUpMark();
                              }
                            });
                          }
                        })];
                      }
                    });
                  }
                });
              }
            }));
            return _el$102;
          })()];
        }
      }), null);
      libs.effect(_$p => libs.setProp(_el$92, "className", libs.classNames("PeakScoreRankRow", "Rank" + props.rankData.rank, "Index" + (props.index ?? 0) % 2, "Region_" + region(), {
        Self: props.self,
        showColor: props.region != undefined && props.region != "default" && !props.self,
        Purple: rank() <= 48 + (PeakCupOffset[region()] ?? 0),
        Top3: rank() <= 3
      }), _$p));
      return _el$92;
    })();
  };
  libs.render(() => libs.createComponent(Rank, {}), $.GetContextPanel());
}