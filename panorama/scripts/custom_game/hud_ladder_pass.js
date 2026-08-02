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
var CosmeticPreview = require('./CosmeticPreview.js');
var EOM_Panel = require('./EOM_Panel.js');
var EOM_Countdown = require('./EOM_Countdown.js');
var EOM_Icon = require('./EOM_Icon.js');
var EOM_Image = require('./EOM_Image.js');
var EOM_Label = require('./EOM_Label.js');
var EOM_Button = require('./EOM_Button.js');
var EOM_MenuLayout = require('./EOM_MenuLayout.js');
var EOM_Separator = require('./EOM_Separator.js');
var GenericPanel = require('./GenericPanel.js');
var InfoButton = require('./InfoButton.js');
var MenuMarkIcon = require('./MenuMarkIcon.js');
var Player = require('./Player.js');
var ProductImage = require('./ProductImage.js');
var ProductItem = require('./ProductItem.js');
var netdata_utils = require('./netdata_utils.js');
var game_utils = require('./game_utils.js');
require('./CourierTitle.js');
require('./EOM_PortraitFullBody.js');
require('./WinStreak.js');
require('./Heroes.js');
require('./profile_info.js');

if (!isSpectator()) {
  function isInfiniteLevel(level) {
    return level == 10001;
  }
  const bpPlusStoreID = 9900286;
  const bpRushStoreID = 9900287;
  const bpExpStoreID = 9900288;
  const BP_SEASON_CONFIG = {
    [11]: {
      plus: 9900407,
      rush: 9900408,
      exp: 9900409,
      preview: 5100008
    },
    [10]: {
      plus: 9900404,
      rush: 9900405,
      exp: 9900406,
      preview: 5100041
    },
    [9]: {
      plus: 9900401,
      rush: 9900402,
      exp: 9900403,
      preview: 5100032
    },
    [8]: {
      plus: 9900286,
      rush: 9900287,
      exp: 9900288,
      preview: 5100022
    },
    [7]: {
      plus: 9900281,
      rush: 9900282,
      exp: 9900283,
      preview: 5100008
    }
  };
  const language = $.Language().toLowerCase();
  const season = game_utils.GetBattlePassSeason();
  const [grandRewardIndex, setGrandRewardIndex] = libs.createSignal(10);
  const [rewardList, setRewardList] = libs.createSignal([]);
  const scrollListenerFunc = () => {
    let pList = $("#RewardList");
    if (pList?.IsValid()) {
      const listChildren = pList.Children();
      for (let index = listChildren.length - 1; index >= 0; index--) {
        const childPanel = listChildren[index];
        if (childPanel?.IsValid() && childPanel.BCanSeeInParentScroll()) {
          let grandIndex = Clamp(Math.ceil((index + 2) / 10) * 10, 0, rewardList().length - 1);
          if (grandRewardIndex() != grandIndex) {
            setGrandRewardIndex(grandIndex);
          }
          return;
        }
      }
    }
  };
  const receiveReward = (level, plus) => {
    callAction("bp_receive", {
      level,
      plus: plus ? 1 : 0,
      season: season()
    });
  };
  const receiveAllReward = () => {
    callAction("bp_receive_all", {
      season: season()
    });
  };
  let previewTimer = -1;
  let rewardWarned = false;
  const [taskRewardWarn, setTaskRewardWarn] = libs.createSignal(false);
  let taskRewardRecord = [];
  const [ladderTask, setLadderTask] = libs.createSignal({});
  function updateTaskRewardWarn() {
    const config = ladderTask();
    const progress = getNetDataCache("bp_task_progresses", Players.GetLocalPlayer());
    const timeNow = Date.now() / 1000;
    let flag = false;
    if (config && progress) {
      for (const taskid in progress) {
        const _progress = progress[taskid];
        if (config[_progress.task_id]) {
          if (timeNow >= _progress.start_time) {
            const target = config[_progress.task_id]?.target?.split("|").map(v => Number(v)) ?? [1, 2, 3];
            if (!target) continue;
            const progress = _progress.progress ?? 0;
            const step = target.findIndex(v => progress < v);
            const effectiveStep = step === -1 ? target.length : step;
            if (effectiveStep > (_progress.receive_progress ?? 0)) {
              if (!taskRewardRecord.includes(taskid)) {
                taskRewardRecord.push(taskid);
                flag = true;
              }
            }
          }
        }
      }
    }
    if (flag) {
      GameEvents.SendEventClientSide("custom_ui_exclamation", {
        name: "ladderpass"
      });
      setTaskRewardWarn(true);
    }
  }
  const [previewData, setPreviewData] = libs.createSignal({
    id: BP_SEASON_CONFIG[season()].preview ?? 5100022,
    plus: true
  });
  libs.createEffect(libs.on(season, v => {
    setPreviewData({
      id: BP_SEASON_CONFIG[v].preview ?? 5100022,
      plus: true
    });
  }));
  const previewID = () => previewData().id;
  const previewExtraInfo = () => {
    if (KeyValues.CosmeticsKv[previewID()] != undefined) {
      if (KeyValues.CosmeticsKv[previewID()]?.hero != undefined) {
        return `#${GetHeroNameByGoodID(KeyValues.CosmeticsKv[previewID()].hero)}`;
      }
    }
    return "";
  };
  const [showPlusReward, setShowPlusReward] = libs.createSignal(false);
  const [seasonRewardMark, setSeasonRewardMark] = libs.createSignal();
  const [playerBPInfo, setPlayerBPInfo] = libs.createSignal({
    season: season(),
    level: 1,
    xp: 0,
    totalXp: 100,
    plus: 0
  });
  const [seenBpHeroDetail, setSeenBpHeroDetail] = libs.createSignal(false);
  const isBpPlus = () => playerBPInfo().plus == 1;
  netdata_utils.createNetDataEffect("player_battle_passes", data => {
    for (const _season in data) {
      if (data[_season].season == season()) {
        data[_season].xp = data[_season].xp ?? 0;
        setPlayerBPInfo(Object.assign({
          ...playerBPInfo()
        }, data[_season]));
      }
    }
  }, Players.GetLocalPlayer(), [season]);
  const updateNewMarkInfo = data => {
    if (data) {
      for (const mid in data) {
        const state = data[mid];
        const kv = KeyValues.NewMarkInfoKv[mid];
        if (kv != undefined) {
          if (kv.menu_button == "ladderpass" && kv.tag_id != undefined) {
            if (kv.tag_id == "SeasonReward" && state && seasonRewardMark() === undefined) {
              setSeasonRewardMark(kv.type);
            }
          }
        }
      }
    }
  };
  libs.onMount(() => {
    let gameEventIDList = [];
    let NetTableIDList = [];
    NetTableIDList.push(useServiceNetTable("player_new_mark", data => {
      updateNewMarkInfo(data);
    }, Players.GetLocalPlayer()));
    gameEventIDList.push(useClientSideEvent("create_new_mark_info", data => {
      updateNewMarkInfo(data);
    }));
    libs.onCleanup(() => {
      gameEventIDList.forEach(id => GameEvents.Unsubscribe(id));
      NetTableIDList.forEach(id => CustomNetTables.UnsubscribeNetTableListener(id));
    });
  });
  const [infiniteInfo, setInfiniteInfo] = libs.createSignal({
    level: 90,
    receive: false,
    count: 0
  });
  const player_ornament = netdata_utils.createPlayerNetData("player_ornament", Players.GetLocalPlayer());
  const ownedOrnamentSet = libs.createMemo(() => {
    const list = new Set();
    const ornaments = player_ornament();
    if (ornaments) {
      for (const itemID in ornaments) {
        if (ornaments[itemID].permanent == 1) {
          list.add(itemID);
        }
      }
    }
    return list;
  });
  const repeatitem_exchange = netdata_utils.createNetData("info_repeatitem_exchange");
  const getRepeatConvertData = itemID => {
    if (repeatitem_exchange() && repeatitem_exchange()[itemID.toString()]) {
      return repeatitem_exchange()[itemID.toString()];
    }
    return;
  };
  function LadderPass() {
    const [show, setShow] = libs.createSignal(false);
    $.Language().toLowerCase();
    const hasPlus = () => playerBPInfo().plus == 1;
    libs.createSignal(false);
    const [bpSeason, setBpSeason] = libs.createSignal({
      sid: 1,
      start_time: 1692349200,
      end_time: 1694361599
    });
    const [bpLevelExp, setBpLevelExp] = libs.createSignal([]);
    const [receivedList, setReceivedList] = libs.createSignal({});
    const seasonDigits = libs.createMemo(() => String(season() - 1).split(""));
    const [purchased_product, setPurchasedProduct] = libs.createSignal({});
    libs.createEffect(libs.on(season, _season => {
      callAction("activity_task_progress", {
        task_type: 1,
        sid: _season,
        aid: 0,
        start_time: 1,
        end_time: Math.floor(Date.now() / 1000)
      });
    }));
    const grandRewardData = libs.createMemo(() => {
      if (grandRewardIndex() - 1 >= 0 && rewardList()[grandRewardIndex() - 1]) {
        return rewardList()[grandRewardIndex() - 1];
      }
    });
    let scrollListener;
    const openScrollLisnter = () => {
      closeScrollLisnter();
      scrollListener = setInterval(() => {
        scrollListenerFunc();
      }, 100);
    };
    const closeScrollLisnter = () => {
      if (scrollListener != undefined) {
        clearInterval(scrollListener);
        scrollListener = undefined;
      }
    };
    libs.onMount(() => {
      const eventId = useToggleWindow("MenuButton_ladderpass", show, setShow);
      libs.onCleanup(() => GameEvents.Unsubscribe(eventId));
    });
    EOM_MenuLayout.useEOM_MenuLayoutData(show, () => {
      const netID = [];
      const eventIDList = [];
      eventIDList.push(useNetData("info_bp_rewards", data => {
        const normalData = [];
        for (const rewardData of data) {
          if (playerBPInfo().season == rewardData.season) {
            normalData.push(rewardData);
          }
        }
        normalData.sort((a, b) => a.level - b.level);
        setRewardList(normalData);
      }));
      eventIDList.push(useNetData("player_purchased_products", data => {
        setPurchasedProduct(data.purchased_products);
      }, Players.GetLocalPlayer()));
      eventIDList.push(useNetData("info_bp_level_exp", data => {
        let result = {};
        for (const iterator of data) {
          if (iterator.season == playerBPInfo().season) {
            result[iterator.level] = iterator.exp;
          }
        }
        setBpLevelExp(result);
      }));
      eventIDList.push(useNetData("player_bp_received", data => {
        setReceivedList(data);
      }, Players.GetLocalPlayer()));
      eventIDList.push(useNetData("info_bp_season", data => {
        for (const seasonData of data) {
          if (seasonData.sid == playerBPInfo().season) {
            setBpSeason(seasonData);
          }
        }
      }));
      eventIDList.push(useNetData("info_bp_task", data => {
        const rebuild = {};
        for (const key in data) {
          const element = data[key];
          if (element.season_id == season()) {
            rebuild[key] = element;
          }
        }
        setLadderTask(rebuild);
      }));
      eventIDList.push(useNetData("bp_task_progresses", data => {
        updateTaskRewardWarn();
      }, Players.GetLocalPlayer()));
      eventIDList.push(useNetData("info_bp_task", data => {}));
      eventIDList.push(useNetData("bp_task_progresses", data => {}, Players.GetLocalPlayer()));
      return () => {
        eventIDList.forEach(id => GameEvents.Unsubscribe(id));
        netID.forEach(id => CustomNetTables.UnsubscribeNetTableListener(id));
        closeScrollLisnter();
        if (previewTimer != -1) {
          $.CancelScheduled(previewTimer);
          previewTimer = -1;
        }
        setRewardList([]);
      };
    });
    const [rewardCount, setRewardCount] = libs.createSignal(0);
    libs.createEffect(() => {
      const current_rewardList = rewardList();
      const current_receivedList = receivedList();
      const bpLevel = playerBPInfo().level;
      const isPlus = playerBPInfo().plus == 1;
      const current_season = season();
      let count = 0;
      let maxLv = 0;
      if (current_rewardList.length > 0) {
        for (let index = 0; index < current_rewardList.length; index++) {
          const data = current_rewardList[index];
          if (data.level != 10001 && maxLv < data.level) {
            maxLv = data.level;
          }
          if ((isPlus || data.plus != 1) && bpLevel >= data.level) {
            const key = `${data.level}-${data.plus}-${current_season}`;
            if (!current_receivedList[key]) {
              count++;
            }
          }
        }
      }
      if (bpLevel < maxLv) {
        setInfiniteInfo({
          level: maxLv,
          receive: false,
          count: 0
        });
      } else {
        let infiniteCount = 0;
        for (let i = maxLv + 1; i <= bpLevel; i++) {
          if (!current_receivedList[i + "-0-" + current_season]) {
            infiniteCount++;
          }
        }
        count += infiniteCount;
        setInfiniteInfo({
          level: playerBPInfo().level,
          receive: infiniteCount == 0,
          count: infiniteCount
        });
      }
      setRewardCount(count);
    });
    libs.createEffect(libs.on(rewardCount, v => {
      if (v == 0) {
        rewardWarned = false;
      } else {
        if (!show() && !rewardWarned) {
          rewardWarned = true;
          GameEvents.SendEventClientSide("custom_ui_exclamation", {
            name: "ladderpass"
          });
        }
      }
    }));
    const expNeed = () => {
      return bpLevelExp()[playerBPInfo().level] ?? bpLevelExp()[10001] ?? 100;
    };
    const BP_UI_CONFIG = [{
      particle_config: {
        path: "particles/eom/ui/ui_fx/ui_fx_season_background.vpcf",
        fov: 30
      }
    }, {
      particle_config: {
        path: "particles/eom/ui/ui_fx/ui_fx_season_background_s2_main.vpcf",
        fov: 30
      }
    }, {
      particle_config: {
        path: "particles/eom/ui/ui_fx/ui_s4_back_permit_fx.vpcf",
        fov: 30
      }
    }, {
      particle_config: {
        path: "particles/eom/ui/ui_fx/ui_s5_back_permit_fx.vpcf",
        fov: 30
      }
    }, {
      particle_config: {
        path: "particles/eom/ui/ui_fx/ui_s6_back_permit_fx.vpcf",
        fov: 30
      }
    }];
    const UIStyleIndex = () => (season() + 3) % BP_UI_CONFIG.length;
    const UIConfig = () => BP_UI_CONFIG[UIStyleIndex()];
    const BPBGparticle = () => UIConfig().particle_config.path;
    const fov = () => UIConfig().particle_config.fov ?? 30;
    return libs.createComponent(EOM_MenuLayout.EOM_MenuLayout, {
      renderOnShow: true,
      get show() {
        return show();
      },
      get className() {
        return "SeasonStyle" + UIStyleIndex();
      },
      name: "MenuButton_ladderpass",
      get children() {
        return [libs.createComponent(libs.Show, {
          get when() {
            return showPlusReward();
          },
          get children() {
            return libs.createComponent(PlusRewardPreview, {});
          }
        }), (() => {
          const _el$ = libs.createElement("DOTAParticleScenePanel", {
            hittest: false,
            id: "BGScene",
            get particleName() {
              return BPBGparticle();
            },
            cameraOrigin: "-50 0 -900",
            lookAt: "-50 0 0",
            get fov() {
              return fov();
            }
          }, null);
          libs.effect(_p$ => {
            const _v$ = !showPlusReward(),
              _v$2 = BPBGparticle(),
              _v$3 = fov();
            _v$ !== _p$._v$ && (_p$._v$ = libs.setProp(_el$, "visible", _v$, _p$._v$));
            _v$2 !== _p$._v$2 && (_p$._v$2 = libs.setProp(_el$, "particleName", _v$2, _p$._v$2));
            _v$3 !== _p$._v$3 && (_p$._v$3 = libs.setProp(_el$, "fov", _v$3, _p$._v$3));
            return _p$;
          }, {
            _v$: undefined,
            _v$2: undefined,
            _v$3: undefined
          });
          return _el$;
        })(), (() => {
          const _el$2 = libs.createElement("Image", {
            id: "Front"
          }, null);
          libs.effect(_$p => libs.setProp(_el$2, "visible", !showPlusReward(), _$p));
          return _el$2;
        })(), libs.createComponent(EOM_MenuLayout.EOM_MenuLayout_Content, {
          get visible() {
            return !showPlusReward();
          },
          get show() {
            return !showPlusReward();
          },
          renderOnShow: true,
          get children() {
            return [libs.createComponent(EOM_Panel.EOM_Panel, {
              marginTop: "47px",
              marginLeft: "90px",
              flowChildren: "right",
              hittest: false,
              zIndex: 1,
              get children() {
                return [libs.createComponent(EOM_Panel.EOM_Panel, {
                  id: "LadderPassSeasonIcons",
                  get children() {
                    return [libs.createComponent(EOM_Image.EOM_Image, {
                      get className() {
                        return libs.classNames("LadderPassSeasonIcon", "S");
                      }
                    }), libs.createComponent(libs.Index, {
                      get each() {
                        return seasonDigits();
                      },
                      children: num => libs.createComponent(EOM_Image.EOM_Image, {
                        get className() {
                          return libs.classNames("LadderPassSeasonIcon", "Number" + num());
                        }
                      })
                    })];
                  }
                }), libs.createComponent(EOM_Panel.EOM_Panel, {
                  verticalAlign: "center",
                  flowChildren: "down",
                  get children() {
                    return [libs.createComponent(GenericPanel.CLabel, {
                      id: "LadderPassSeasonTitle",
                      text: "#LadderPass"
                    }), libs.createComponent(EOM_Countdown.EOM_Countdown, {
                      get endTime() {
                        return bpSeason().end_time;
                      },
                      id: "LadderPassExp",
                      text: "#LadderPass_deadline"
                    })];
                  }
                }), libs.createComponent(EOM_Image.EOM_Image, {
                  tooltip: "#LadderPassDesc",
                  marginTop: "20px",
                  marginLeft: "5px",
                  width: "26px",
                  height: "26px",
                  get backgroundImage() {
                    return getImagePath("ladder/pass/z3_details.png");
                  }
                }), libs.createComponent(EOM_Panel.EOM_Panel, {
                  get className() {
                    return libs.classNames("SeasonHeightIcon", {
                      Active: isBpPlus()
                    });
                  },
                  get children() {
                    return [libs.createComponent(EOM_Panel.EOM_Panel, {
                      id: "SeasonHeight",
                      onmouseover: self => {
                        setSeenBpHeroDetail(true);
                        $.DispatchEvent("DOTAShowTextTooltip", self, "#Ladder_HeroDetail");
                      },
                      onmouseout: self => {
                        $.DispatchEvent("DOTAHideTextTooltip", self);
                      }
                    }), libs.createComponent(libs.Show, {
                      get when() {
                        return libs.memo(() => !!!isBpPlus())() && !seenBpHeroDetail();
                      },
                      get children() {
                        return libs.createComponent(MenuMarkIcon.MenuMarkIcon, {
                          hittest: false
                        });
                      }
                    }), libs.createComponent(GenericPanel.CLabel, {
                      id: "SeasonHeightTitle",
                      hittest: false,
                      text: "#BP_HeroTips"
                    })];
                  }
                })];
              }
            }), libs.createComponent(EOM_Panel.EOM_Panel, {
              marginTop: "211px",
              marginLeft: "90px",
              get children() {
                return [libs.createComponent(EOM_Button.EOM_Button, {
                  color: "Blue",
                  text: "#LadderPassTask",
                  onactivate: () => {
                    showPopup("RankTask", {
                      season: season()
                    });
                    setTaskRewardWarn(false);
                  }
                }), libs.createComponent(libs.Show, {
                  get when() {
                    return taskRewardWarn();
                  },
                  get children() {
                    return libs.createComponent(MenuMarkIcon.MenuMarkIcon, {
                      type: "default",
                      hittest: false
                    });
                  }
                })];
              }
            }), libs.createComponent(EOM_Panel.EOM_Panel, {
              marginTop: "60px",
              marginRight: "120px",
              horizontalAlign: "right",
              flowChildren: "down",
              hittest: false,
              get children() {
                return [libs.createComponent(GenericPanel.CLabel, {
                  id: "PreviewTitle",
                  get text() {
                    return `#${previewID()}`;
                  }
                }), libs.createComponent(GenericPanel.CLabel, {
                  id: "PreviewExtraInfo",
                  get text() {
                    return previewExtraInfo();
                  }
                }), libs.createComponent(EOM_Panel.EOM_Panel, {
                  get className() {
                    return libs.classNames("PreviewRewardVersion", {
                      Plus: previewData().plus
                    });
                  },
                  get children() {
                    return libs.createComponent(GenericPanel.CLabel, {
                      get text() {
                        return previewData().plus ? "#LadderPass_PlusReward" : "#LadderPass_NormalReward";
                      }
                    });
                  }
                })];
              }
            }), libs.createComponent(libs.Show, {
              when: true,
              get children() {
                return libs.createElement("Image", {
                  id: "PreviewMask",
                  hittest: false
                }, null);
              }
            }), libs.createComponent(libs.Switch, {
              get children() {
                return [libs.createComponent(libs.Match, {
                  get when() {
                    return KeyValues.CosmeticsKv[previewID()] != undefined;
                  },
                  get children() {
                    return libs.createComponent(CosmeticPreview.CosmeticPreview, {
                      get cosmetic_id() {
                        return previewID();
                      },
                      showPedestal: false,
                      showCourierPedestal: true
                    });
                  }
                }), libs.createComponent(libs.Match, {
                  get when() {
                    return KeyValues.CosmeticsKv[previewID()] == undefined;
                  },
                  get children() {
                    return [libs.createComponent(CosmeticCard.CosmeticImage, {
                      className: "CosmeticPreviewImage",
                      get itemid() {
                        return previewID().toString();
                      }
                    }), libs.createComponent(ProductImage.ProductImage, {
                      className: "CosmeticPreviewImage",
                      get itemid() {
                        return previewID();
                      }
                    })];
                  }
                })];
              }
            }), (() => {
              const _el$4 = libs.createElement("Panel", {
                id: "MainContainer",
                hittest: false
              }, null);
              libs.insert(_el$4, libs.createComponent(EOM_Panel.EOM_Panel, {
                width: "100%",
                get children() {
                  return [libs.createComponent(EOM_Panel.EOM_Panel, {
                    id: "ExpContainer",
                    verticalAlign: "bottom",
                    get children() {
                      return [(() => {
                        const _el$5 = libs.createElement("Image", {
                          id: "LevelCircle"
                        }, null);
                        libs.insert(_el$5, libs.createComponent(GenericPanel.CLabel, {
                          id: "LevelTitle",
                          text: "LV"
                        }), null);
                        libs.insert(_el$5, libs.createComponent(GenericPanel.CLabel, {
                          id: "LevelValue",
                          get text() {
                            return playerBPInfo().level;
                          }
                        }), null);
                        return _el$5;
                      })(), (() => {
                        const _el$6 = libs.createElement("Panel", {
                            id: "ExpBG"
                          }, null),
                          _el$7 = libs.createElement("ProgressBar", {
                            id: "ExpProgress",
                            get value() {
                              return playerBPInfo().xp / (bpLevelExp()[playerBPInfo().level] ?? 100);
                            }
                          }, _el$6);
                        libs.insert(_el$6, libs.createComponent(GenericPanel.CLabel, {
                          id: "ExpValue",
                          get text() {
                            return `${playerBPInfo().xp ?? 0} / ${expNeed()}`;
                          }
                        }), _el$7);
                        libs.insert(_el$6, libs.createComponent(EOM_Button.EOM_BaseButton, {
                          id: "ExpAdd",
                          onactivate: () => {
                            clientSideEvent("directly_purchase", {
                              itemid: BP_SEASON_CONFIG[season()]?.exp ?? bpExpStoreID
                            });
                          }
                        }), _el$7);
                        libs.effect(_$p => libs.setProp(_el$7, "value", playerBPInfo().xp / (bpLevelExp()[playerBPInfo().level] ?? 100), _$p));
                        return _el$6;
                      })()];
                    }
                  }), libs.createComponent(libs.Show, {
                    get when() {
                      return IsRankRewardShow();
                    },
                    get children() {
                      return libs.createComponent(InfoButton.InfoButton, {
                        verticalAlign: "bottom",
                        marginLeft: "506px",
                        marginBottom: "6px",
                        tooltipPosition: "right",
                        className: language,
                        info: "#RewardInfo",
                        tooltip: "#RewardInfoDetail",
                        get children() {
                          return libs.createComponent(libs.Show, {
                            get when() {
                              return seasonRewardMark();
                            },
                            get children() {
                              return libs.createComponent(EOM_Panel.EOM_Panel, {
                                width: "100%",
                                height: "100%",
                                onmouseover: self => {
                                  if (seasonRewardMark()) {
                                    setSeasonRewardMark(null);
                                    clickNewMark({
                                      menu: "ladderpass",
                                      tag: "SeasonReward"
                                    }, self);
                                  }
                                },
                                get children() {
                                  return libs.createComponent(MenuMarkIcon.MenuMarkIcon, {
                                    hittest: false,
                                    get type() {
                                      return seasonRewardMark();
                                    }
                                  });
                                }
                              });
                            }
                          });
                        }
                      });
                    }
                  }), libs.createComponent(EOM_Panel.EOM_Panel, {
                    id: "ActionList",
                    verticalAlign: "bottom",
                    get children() {
                      return [libs.createComponent(EOM_Panel.EOM_Panel, {
                        className: "ActionList",
                        marginTop: "20px",
                        get children() {
                          return [libs.createComponent(libs.Show, {
                            get when() {
                              return playerBPInfo()?.plus !== 1;
                            },
                            get children() {
                              return libs.createComponent(EOM_Panel.EOM_Panel, {
                                flowChildren: "up",
                                marginLeft: "32px",
                                get children() {
                                  return [libs.createComponent(EOM_Button.EOM_Button, {
                                    align: "center bottom",
                                    id: "BuyLadderPassButton",
                                    color: "Gold",
                                    text: "#BuyLadderPass",
                                    get dialogVariables() {
                                      return {
                                        season: season() - 1
                                      };
                                    },
                                    onactivate: () => {
                                      clientSideEvent("directly_purchase", {
                                        itemid: BP_SEASON_CONFIG[season()]?.plus ?? bpPlusStoreID
                                      });
                                    }
                                  }), libs.createComponent(EOM_Button.EOM_BaseButton, {
                                    id: "SeeRewardDetail",
                                    onactivate: () => setShowPlusReward(v => !v),
                                    get children() {
                                      return [libs.createComponent(EOM_Icon.EOM_Icon, {
                                        width: "34px",
                                        height: "34px",
                                        marginRight: "6px",
                                        get src() {
                                          return getSrcPath("ladder/pass/z3_eye.png");
                                        }
                                      }), libs.createComponent(GenericPanel.CLabel, {
                                        text: "#ShowRewardDetail"
                                      })];
                                    }
                                  })];
                                }
                              });
                            }
                          }), libs.createComponent(EOM_Button.EOM_Button, {
                            get visible() {
                              return rewardCount() > 0;
                            },
                            verticalAlign: "bottom",
                            color: "Blue",
                            text: "#HUD_BP_5",
                            onactivate: () => receiveAllReward()
                          })];
                        }
                      }), libs.createComponent(EOM_Panel.EOM_Panel, {
                        className: "ActionList",
                        get children() {
                          return libs.createComponent(libs.Show, {
                            get when() {
                              return (() => purchased_product()[BP_SEASON_CONFIG[season()]?.rush ?? bpRushStoreID] == undefined)();
                            },
                            get children() {
                              return libs.createComponent(EOM_Panel.EOM_Panel, {
                                id: "LadderRushPack",
                                flowChildren: "up",
                                get children() {
                                  return [libs.createComponent(EOM_Button.EOM_Button, {
                                    get backgroundImage() {
                                      return getImagePath("eom_design/common/C4/button_red_02.png");
                                    },
                                    align: "right bottom",
                                    id: "BuyLadderPassRushButton",
                                    color: "Red",
                                    text: "#LadderPass_RushPack",
                                    onactivate: () => {
                                      clientSideEvent("directly_purchase", {
                                        itemid: BP_SEASON_CONFIG[season()]?.rush ?? bpRushStoreID
                                      });
                                    }
                                  }), libs.createComponent(EOM_Label.EOM_Label, {
                                    width: "250px",
                                    marginRight: "-24px",
                                    style: {
                                      textAlign: "center",
                                      fontSize: "20px",
                                      color: "#fffbf4",
                                      textShadow: "0 0 3px 1.5 #00000088",
                                      lineHeight: "30px"
                                    },
                                    text: "#LadderPass_RushPackDescription",
                                    html: true,
                                    get dialogVariables() {
                                      return {
                                        season: `S${season() - 1}`,
                                        level: 20
                                      };
                                    }
                                  })];
                                }
                              });
                            }
                          });
                        }
                      })];
                    }
                  })];
                }
              }), null);
              libs.insert(_el$4, libs.createComponent(EOM_Panel.EOM_Panel, {
                id: "RewardListContainer",
                get children() {
                  return [libs.createComponent(EOM_Panel.EOM_Panel, {
                    id: "RewardList",
                    flowChildren: "right",
                    scroll: "x",
                    onload: selfRef => {
                      const currentLevelChild = selfRef?.GetChild(Clamp(playerBPInfo().level, 0, finiteNumber(Number(rewardList().length), 91) - 1));
                      if (currentLevelChild) {
                        currentLevelChild?.ScrollParentToMakePanelFit(3, false);
                      }
                      $.Schedule(0.1, () => {
                        scrollListenerFunc();
                      });
                    },
                    onmouseover: () => {
                      openScrollLisnter();
                    },
                    onmouseout: () => {
                      let temp = scrollListener;
                      $.Schedule(0.3, () => {
                        if (temp == scrollListener) {
                          closeScrollLisnter();
                        }
                      });
                    },
                    get children() {
                      return libs.createComponent(libs.Index, {
                        get each() {
                          return rewardList();
                        },
                        children: (rewardData, index) => {
                          return libs.createComponent(RewardItem, {
                            get level() {
                              return rewardData().level;
                            },
                            get currentLevel() {
                              return libs.memo(() => playerBPInfo().level > 90)() ? 10001 : playerBPInfo().level;
                            },
                            get itemID() {
                              return rewardData().item_id;
                            },
                            get count() {
                              return rewardData().amounts;
                            },
                            get rarity() {
                              return rewardData().values;
                            },
                            get plusLock() {
                              return libs.memo(() => rewardData().plus == 1)() && !hasPlus();
                            },
                            get isPlus() {
                              return rewardData().plus == 1;
                            },
                            get active() {
                              return libs.memo(() => !!isInfiniteLevel(rewardData().level))() ? infiniteInfo().count > 0 : playerBPInfo().level >= rewardData().level;
                            },
                            get receive() {
                              return libs.memo(() => !!isInfiniteLevel(rewardData().level))() ? infiniteInfo().receive : receivedList()[rewardData().level + "-" + rewardData().plus + "-" + playerBPInfo().season]?.state ?? false;
                            },
                            get receive_owned() {
                              return libs.memo(() => !!isInfiniteLevel(rewardData().level))() ? infiniteInfo().receive : receivedList()[rewardData().level + "-" + rewardData().plus + "-" + playerBPInfo().season]?.receive_owned ?? false;
                            }
                          });
                        }
                      });
                    }
                  }), libs.createComponent(EOM_Panel.EOM_Panel, {
                    id: "GrandRewardPreview",
                    get children() {
                      return libs.createComponent(libs.Show, {
                        get when() {
                          return grandRewardData() != undefined;
                        },
                        get children() {
                          return libs.createComponent(RewardItem, {
                            grandview: true,
                            get level() {
                              return grandRewardData().level;
                            },
                            get currentLevel() {
                              return playerBPInfo().level;
                            },
                            get itemID() {
                              return grandRewardData().item_id;
                            },
                            get count() {
                              return grandRewardData().amounts;
                            },
                            get rarity() {
                              return grandRewardData().values;
                            },
                            get plusLock() {
                              return libs.memo(() => grandRewardData().plus == 1)() && !hasPlus();
                            },
                            get isPlus() {
                              return grandRewardData().plus == 1;
                            },
                            get active() {
                              return playerBPInfo().level >= grandRewardData().level;
                            },
                            get receive() {
                              return receivedList()[grandRewardData().level + "-" + grandRewardData().plus + "-" + playerBPInfo().season]?.state ?? false;
                            },
                            get receive_owned() {
                              return receivedList()[grandRewardData().level + "-" + grandRewardData().plus + "-" + playerBPInfo().season]?.receive_owned ?? false;
                            }
                          });
                        }
                      });
                    }
                  })];
                }
              }), null);
              return _el$4;
            })()];
          }
        })];
      }
    });
  }
  function RewardItem(props) {
    const owned = libs.createMemo(() => {
      return ownedOrnamentSet().has(props.itemID.toString());
    });
    const repeatConvertData = () => getRepeatConvertData(props.itemID);
    return libs.createComponent(EOM_Panel.EOM_Panel, {
      get className() {
        return libs.classNames("RewardItem", {
          NoReceive: !props.receive,
          Active: props.active,
          Current: props.level == props.currentLevel,
          Previous: props.level == props.currentLevel - 1,
          isPlus: props.isPlus,
          plusLock: props.plusLock
        }, "Level" + props.level);
      },
      onactivate: () => {
        if (previewID() != props.itemID || previewData().plus != props.isPlus) {
          setPreviewData({
            id: props.itemID,
            plus: props.isPlus
          });
        }
        if (!props.grandview) {
          let isInfinite = isInfiniteLevel(props.level);
          if (isInfinite) {
            receiveAllReward();
          } else {
            receiveReward(props.level, props.isPlus);
          }
        } else {
          let index = grandRewardIndex() - 1;
          if (grandRewardIndex() + 1 == rewardList().length) {
            index = grandRewardIndex();
          }
          const currentLevelChild = $("#RewardList")?.GetChild(index);
          if (currentLevelChild) {
            currentLevelChild?.ScrollParentToMakePanelFit(2, false);
          }
          $.Schedule(0.1, () => {
            scrollListenerFunc();
          });
        }
      },
      onmouseover: self => {
        $.DispatchEvent("DOTAShowTitleTextTooltip", self, "#" + props.itemID, "#" + props.itemID + "_description");
        previewTimer = $.Schedule(0.3, () => {
          previewTimer = -1;
          if (previewID() != props.itemID || previewData().plus != props.isPlus) {
            setPreviewData({
              id: props.itemID,
              plus: props.isPlus
            });
          }
        });
      },
      onmouseout: self => {
        $.DispatchEvent("DOTAHideTitleTextTooltip", self);
        if (previewTimer != -1) {
          $.CancelScheduled(previewTimer);
          previewTimer = -1;
        }
      },
      get children() {
        return [libs.createComponent(EOM_Panel.EOM_Panel, {
          id: "RewardContainer",
          get className() {
            return libs.classNames("Rarity_" + props.rarity);
          },
          hittest: false,
          get children() {
            return [libs.createComponent(ProductImage.ProductImage, {
              id: "ItemImage",
              get itemid() {
                return props.itemID;
              },
              get count() {
                return props.count;
              },
              hittest: false
            }), libs.createComponent(CosmeticCard.CosmeticImage, {
              id: "ItemImage",
              get itemid() {
                return props.itemID.toString();
              },
              hittest: false
            }), libs.createComponent(GenericPanel.CLabel, {
              id: "ItemName",
              get text() {
                return `#${props.itemID}`;
              },
              hittest: false
            }), libs.createComponent(libs.Show, {
              get when() {
                return !props.isPlus;
              },
              get children() {
                return libs.createComponent(EOM_Panel.EOM_Panel, {
                  marginTop: "242px",
                  marginLeft: "12px",
                  marginRight: "12px",
                  height: "22px",
                  width: "100%",
                  backgroundColor: "#291E3470",
                  hittest: false,
                  get children() {
                    return libs.createComponent(EOM_Label.EOM_Label, {
                      align: "center center",
                      textOverflow: "shrink",
                      fontSize: "16px",
                      color: "#ffffff",
                      text: "#Free",
                      hittest: false
                    });
                  }
                });
              }
            }), libs.createComponent(libs.Show, {
              get when() {
                return libs.memo(() => !!props.receive)() ? props.receive_owned : owned();
              },
              get children() {
                return libs.createComponent(libs.Show, {
                  get when() {
                    return repeatConvertData();
                  },
                  get children() {
                    return libs.createComponent(EOM_Panel.EOM_Panel, {
                      id: "RepeatConvertBanner",
                      hittest: false,
                      hittestchildren: false,
                      get children() {
                        return [libs.createComponent(EOM_Panel.EOM_Panel, {
                          id: "left",
                          get children() {
                            return libs.createComponent(EOM_Label.EOM_Label, {
                              text: "#ItemRepeatConvert"
                            });
                          }
                        }), libs.createComponent(EOM_Panel.EOM_Panel, {
                          id: "right",
                          flowChildren: "right",
                          get children() {
                            return [libs.createComponent(EOM_Icon.EOM_Icon, {
                              size: "32",
                              get src() {
                                return getTokenSrcPath(repeatConvertData().currency_id);
                              }
                            }), libs.createComponent(EOM_Label.EOM_Label, {
                              get text() {
                                return `x${repeatConvertData().currency_count}`;
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
        }), libs.createElement("Image", {
          id: "Hover"
        }, null), libs.createComponent(libs.Show, {
          get when() {
            return props.plusLock;
          },
          get children() {
            return libs.createElement("Image", {
              id: "PlusLock",
              hittest: false
            }, null);
          }
        }), libs.createComponent(libs.Show, {
          get when() {
            return props.receive;
          },
          get children() {
            return libs.createElement("Image", {
              id: "Receive",
              hittest: false
            }, null);
          }
        }), libs.createComponent(EOM_Panel.EOM_Panel, {
          id: "RewardProgress",
          get children() {
            return [libs.createComponent(libs.Show, {
              get when() {
                return !props.grandview;
              },
              get children() {
                return [libs.createElement("Panel", {
                  id: "ProgressBG"
                }, null), libs.createElement("Panel", {
                  id: "Progress"
                }, null)];
              }
            }), (() => {
              const _el$11 = libs.createElement("Panel", {
                id: "ProgressCircle"
              }, null);
              libs.insert(_el$11, libs.createComponent(libs.Show, {
                get when() {
                  return !isInfiniteLevel(props.level);
                },
                get fallback() {
                  return libs.createComponent(EOM_Image.EOM_Image, {
                    width: "26px",
                    height: "12px",
                    align: "center center",
                    get src() {
                      return getSrcPath("ladder/pass/z3_infinite.png");
                    }
                  });
                },
                get children() {
                  return libs.createComponent(GenericPanel.CLabel, {
                    get text() {
                      return props.level;
                    }
                  });
                }
              }));
              return _el$11;
            })()];
          }
        })];
      }
    });
  }
  const PlusRewardPreview = () => {
    let plusPreviewTimer = -1;
    libs.onCleanup(() => {
      if (plusPreviewTimer != -1) {
        $.CancelScheduled(plusPreviewTimer);
        plusPreviewTimer = -1;
      }
    });
    const [plusPreviewID, setPlusPreviewID] = libs.createSignal(-1);
    const plusRewardList = libs.createMemo(() => {
      const reconstructList = [];
      const record = {};
      rewardList().forEach(v => {
        if (!v.plus) return;
        if (record[v.item_id] == undefined) {
          record[v.item_id] = {
            values: v.values,
            amounts: v.amounts,
            level: v.level
          };
        } else {
          if (v.values > record[v.item_id].values) {
            record[v.item_id].values = v.values;
          }
          record[v.item_id].amounts += v.amounts;
          record[v.item_id].level == 0;
        }
      });
      for (const item_id in record) {
        const data = record[item_id];
        reconstructList.push({
          item_id: Number(item_id),
          values: data.values,
          amounts: data.amounts
        });
      }
      function isBoxToken(itemID) {
        return Math.floor(itemID / 1000000) == 2;
      }
      let _list = reconstructList.sort((a, b) => {
        return multiCompare((KeyValues.CosmeticsKv[b.item_id] != undefined ? 1 : 0) - (KeyValues.CosmeticsKv[a.item_id] != undefined ? 1 : 0), b.values - a.values, (isBoxToken(b.item_id) ? 1 : 0) - (isBoxToken(a.item_id) ? 1 : 0), (record[b.item_id]?.level ?? 0) - (record[a.item_id]?.level ?? 0), b.amounts - a.amounts);
      });
      return _list;
    });
    libs.createEffect(libs.on(plusRewardList, list => {
      if (list.length > 0) {
        setPlusPreviewID(list[0].item_id);
      }
    }));
    return libs.createComponent(EOM_Panel.EOM_Panel, {
      id: "PlusRewardPreview",
      get children() {
        return [(() => {
          const _el$12 = libs.createElement("Panel", {
            id: "TopBarBG"
          }, null);
          libs.insert(_el$12, libs.createComponent(Player.CurrencyGroup, {
            tokens: ["moonstone", "coin"]
          }));
          return _el$12;
        })(), (() => {
          const _el$13 = libs.createElement("Panel", {
              id: "ExchangeContainer"
            }, null),
            _el$14 = libs.createElement("Panel", {
              id: "ExchangeList"
            }, _el$13),
            _el$15 = libs.createElement("Panel", {
              id: "ExchangeContent"
            }, _el$14),
            _el$16 = libs.createElement("Panel", {
              id: "PackName"
            }, _el$15);
            libs.createElement("Image", {
              id: "Divider"
            }, _el$15);
            const _el$18 = libs.createElement("Panel", {
              id: "ExchangePreview"
            }, _el$13),
            _el$19 = libs.createElement("Panel", {
              id: "CosmeticDesc"
            }, _el$18);
          libs.setProp(_el$14, "onactivate", () => {});
          libs.insert(_el$14, libs.createComponent(EOM_Panel.EOM_Panel, {
            id: "ExchangeListTitle",
            get children() {
              return [libs.createComponent(GenericPanel.CLabel, {
                id: "ExchangeListTitleLabel",
                text: "#LadderPass_PreviewPlus",
                get dialogVariables() {
                  return {
                    season: season() - 1
                  };
                }
              }), libs.createComponent(EOM_Button.EOM_CloseButton, {
                onactivate: () => {
                  setShowPlusReward(false);
                }
              })];
            }
          }), _el$15);
          libs.insert(_el$16, libs.createComponent(EOM_Image.EOM_Image, {
            id: "PackImage"
          }), null);
          libs.insert(_el$16, libs.createComponent(GenericPanel.CLabel, {
            text: "#LadderPass_PreviewDescription"
          }), null);
          libs.insert(_el$15, libs.createComponent(EOM_Panel.EOM_Panel, {
            id: "PackItemListContainer",
            get children() {
              return libs.createComponent(EOM_Panel.EOM_Panel, {
                id: "PackItemList",
                flowChildren: "right-wrap",
                scroll: "y",
                get children() {
                  return libs.createComponent(libs.Index, {
                    get each() {
                      return plusRewardList();
                    },
                    children: (itemData, index) => {
                      const owned = libs.createMemo(() => {
                        return ownedOrnamentSet().has(itemData().item_id.toString());
                      });
                      const repeatConvertData = () => getRepeatConvertData(itemData().item_id);
                      return libs.createComponent(EOM_Panel.EOM_Panel, {
                        get className() {
                          return libs.classNames("ExchangeItem", {
                            CanPreview: true,
                            Previewing: plusPreviewID() != undefined && itemData().item_id == plusPreviewID()
                          });
                        },
                        onmouseover: self => {
                          plusPreviewTimer = $.Schedule(0.3, () => {
                            plusPreviewTimer = -1;
                            if (plusPreviewID() != itemData().item_id) {
                              setPlusPreviewID(itemData().item_id);
                            }
                          });
                        },
                        onmouseout: self => {
                          if (plusPreviewTimer != -1) {
                            $.CancelScheduled(plusPreviewTimer);
                            plusPreviewTimer = -1;
                          }
                        },
                        onactivate: () => {
                          if (plusPreviewID() != itemData().item_id) {
                            setPlusPreviewID(itemData().item_id);
                          }
                        },
                        get children() {
                          return libs.createComponent(EOM_Panel.EOM_Panel, {
                            id: "ProductItemContainer",
                            get children() {
                              return [libs.createComponent(ProductItem.ProductItem, {
                                get itemid() {
                                  return itemData().item_id;
                                },
                                get count() {
                                  return itemData().amounts;
                                },
                                get rarity() {
                                  return itemData().values;
                                }
                              }), libs.createComponent(CosmeticCard.CosmeticImage, {
                                get itemid() {
                                  return itemData().item_id;
                                },
                                hittest: false,
                                verticalAlign: "center"
                              }), libs.createComponent(libs.Show, {
                                get when() {
                                  return owned();
                                },
                                get children() {
                                  return libs.createComponent(libs.Show, {
                                    get when() {
                                      return repeatConvertData();
                                    },
                                    get children() {
                                      return libs.createComponent(EOM_Panel.EOM_Panel, {
                                        id: "RepeatConvertBanner",
                                        hittestchildren: false,
                                        get children() {
                                          return [libs.createComponent(EOM_Panel.EOM_Panel, {
                                            id: "left",
                                            get children() {
                                              return libs.createComponent(EOM_Label.EOM_Label, {
                                                text: "#ItemRepeatConvert"
                                              });
                                            }
                                          }), libs.createComponent(EOM_Panel.EOM_Panel, {
                                            id: "right",
                                            flowChildren: "right",
                                            get children() {
                                              return [libs.createComponent(EOM_Icon.EOM_Icon, {
                                                size: "32",
                                                get src() {
                                                  return getTokenSrcPath(repeatConvertData().currency_id);
                                                }
                                              }), libs.createComponent(EOM_Label.EOM_Label, {
                                                get text() {
                                                  return `x${repeatConvertData().currency_count}`;
                                                }
                                              })];
                                            }
                                          })];
                                        }
                                      });
                                    }
                                  });
                                }
                              }), libs.createElement("Panel", {
                                id: "HoverBorder",
                                hittest: false
                              }, null)];
                            }
                          });
                        }
                      });
                    }
                  });
                }
              });
            }
          }), null);
          libs.insert(_el$15, libs.createComponent(EOM_Button.EOM_Button, {
            id: "BuyLadderPassButton",
            align: "center bottom",
            marginBottom: "50px",
            color: "Gold",
            text: "#BuyLadderPass",
            get dialogVariables() {
              return {
                season: season() - 1
              };
            },
            get enabled() {
              return (playerBPInfo().plus ?? 0) == 0;
            },
            horizontalAlign: "center",
            onactivate: () => {
              clientSideEvent("directly_purchase", {
                itemid: BP_SEASON_CONFIG[season()]?.plus ?? bpPlusStoreID
              });
            }
          }), null);
          libs.insert(_el$18, libs.createComponent(libs.Switch, {
            get children() {
              return [libs.createComponent(libs.Match, {
                get when() {
                  return KeyValues.CosmeticsKv[plusPreviewID()] != undefined;
                },
                get children() {
                  return libs.createComponent(CosmeticPreview.CosmeticPreview, {
                    get cosmetic_id() {
                      return plusPreviewID();
                    },
                    showPedestal: true,
                    showCourierPedestal: true
                  });
                }
              }), libs.createComponent(libs.Match, {
                get when() {
                  return KeyValues.CosmeticsKv[plusPreviewID()] == undefined;
                },
                get children() {
                  return [libs.createComponent(CosmeticCard.CosmeticImage, {
                    className: "CosmeticPreviewImage",
                    get itemid() {
                      return plusPreviewID().toString();
                    }
                  }), libs.createComponent(ProductImage.ProductImage, {
                    className: "CosmeticPreviewImage",
                    get itemid() {
                      return plusPreviewID();
                    }
                  })];
                }
              })];
            }
          }), _el$19);
          libs.insert(_el$19, libs.createComponent(GenericPanel.CLabel, {
            id: "CosmeticName",
            get text() {
              return '#' + plusPreviewID();
            }
          }), null);
          libs.insert(_el$19, libs.createComponent(EOM_Separator.EOM_Separator, {
            size: "short"
          }), null);
          libs.insert(_el$19, libs.createComponent(GenericPanel.CLabel, {
            id: "CosmeticAccess",
            get text() {
              return GetCosmeticAccessDescription(plusPreviewID());
            }
          }), null);
          return _el$13;
        })()];
      }
    });
  };
  libs.render(() => libs.createComponent(LadderPass, {}), $.GetContextPanel());
}