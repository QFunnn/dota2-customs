--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build b9dc48c · 2026-08-02 17:42:46 UTC
  ~ auto-generated — do not edit
]]


'use strict'; const require = GameUI.__require;

var libs = require('./libs.js');
var BubbleBox = require('./BubbleBox.js');
var EOM_Panel = require('./EOM_Panel.js');
var EOM_Countdown = require('./EOM_Countdown.js');
var EOM_Icon = require('./EOM_Icon.js');
var EOM_Label = require('./EOM_Label.js');
var EOM_Button = require('./EOM_Button.js');
var GenericPanel = require('./GenericPanel.js');
var MenuMarkIcon = require('./MenuMarkIcon.js');

const [selectName, setSelectName] = libs.createSignal("");
const [paymentOpen, setPaymentOpen] = libs.createSignal(false);
const [markInfo, setMarkInfo] = libs.createStore({});
const [markNewInfo, setMarkNewInfo] = libs.createStore({});
if (!isSpectator()) {
  const updateNewMarkInfo = data => {
    if (data) {
      libs.batch(() => {
        for (const mid in data) {
          const state = data[mid];
          const kv = KeyValues.NewMarkInfoKv[mid];
          if (kv != undefined && kv.menu_button != undefined) {
            if (state && markNewInfo[kv.menu_button] === undefined) {
              setMarkNewInfo(kv.menu_button, kv.type);
            } else if (!state && markNewInfo[kv.menu_button]) {
              setMarkNewInfo(kv.menu_button, null);
            }
          }
        }
      });
    }
  };
  libs.onMount(() => {
    let netTableIDList = [];
    let gameEventIDList = [];
    netTableIDList.push(useServiceNetTable("player_new_mark", data => {
      updateNewMarkInfo(data);
    }, Players.GetLocalPlayer()));
    gameEventIDList.push(useClientSideEvent("create_new_mark_info", data => {
      updateNewMarkInfo(data);
    }));
    libs.onCleanup(() => {
      gameEventIDList.forEach(id => GameEvents.Unsubscribe(id));
      netTableIDList.forEach(id => CustomNetTables.UnsubscribeNetTableListener(id));
    });
  });
  {
    const [purchased_product, setPurchasedProduct] = libs.createSignal();
    const [customEventData, setCustomEventData] = libs.createSignal();
    const [playerOrnament, setPlayerOrnament] = libs.createSignal();
    const [player_hero, setPlayerHero] = libs.createSignal();
    const [storeItemData, setStoreItemData] = libs.createSignal();
    const date_now = Math.floor(Date.now() / 1000);
    const [initedMark, setInitedMark] = libs.createSignal(false);
    libs.createEffect(() => {
      if (initedMark()) return;
      const current_purchased_product = purchased_product();
      const current_customEventData = customEventData();
      const current_player_hero = player_hero();
      const current_playerOrnament = playerOrnament();
      const current_storeItemData = storeItemData();
      if (current_purchased_product != undefined && current_customEventData != undefined && current_player_hero != undefined && current_playerOrnament != undefined && current_storeItemData != undefined) {
        setInitedMark(true);
        const filteredStoreMids = [];
        const storeMids = {};
        const validMids = Object.keys(KeyValues.NewMarkInfoKv).filter(id => KeyValues.NewMarkInfoKv[id]?.hidden != 1);
        validMids.forEach(mid => {
          const kv = KeyValues.NewMarkInfoKv[mid];
          if (kv) {
            if (kv.benchmark && kv.benchmark.toString().startsWith("990")) {
              storeMids[Number(kv.benchmark)] = mid;
            }
          }
        });
        for (const tag in current_storeItemData) {
          current_storeItemData[tag].forEach(data => {
            if (storeMids[data.id] != undefined) {
              const purchased_num = current_purchased_product[data.id] ?? 0;
              const owned = getCosmeticByStoreItem(data, current_playerOrnament) || getHerobyStoreItem(data, current_player_hero);
              if (!(data.status == 1 && (data.limit_type == 1 ? finiteNumber(purchased_num) < data.limit_count : true) && !owned)) {
                filteredStoreMids.push(storeMids[data.id]);
              }
            }
          });
        }
        let mids = validMids.filter(id => !filteredStoreMids.includes(id));
        if (current_customEventData && current_customEventData.custom_events) {
          const arr = current_customEventData.custom_events;
          arr.forEach(info => {
            let index = mids.indexOf(info.custom_event_id);
            if (index > -1) {
              const kv = KeyValues.NewMarkInfoKv[info.custom_event_id];
              if (kv != undefined) {
                let remove = false;
                let time = finiteNumber(Number(kv.time), 0);
                let diffDays = dateDiff(info.update_time, date_now);
                if (time == -1) {
                  remove = true;
                } else if (diffDays < time) {
                  remove = true;
                }
                if (remove) {
                  mids.splice(index, 1);
                }
              }
            }
          });
        }
        if (mids.length > 0) {
          GameEvents.SendCustomEventToServer("init_player_new_mark", {
            data: mids
          });
          const netTableData = getServiceNetTable("player_new_mark", Players.GetLocalPlayer());
          const data = {};
          mids.forEach(id => {
            if (netTableData?.[id] == false) {
              return;
            }
            data[id] = true;
          });
          clientSideEvent("create_new_mark_info", data);
        }
      }
    });
    libs.onMount(() => {
      let gameEventIDList = [];
      gameEventIDList.push(useNetData('player_ornament', data => {
        setPlayerOrnament(data);
      }, Players.GetLocalPlayer()));
      gameEventIDList.push(useNetData("info_shop_product_group_by_tag", data => {
        setStoreItemData(data);
      }));
      gameEventIDList.push(useNetData('player_hero', data => {
        setPlayerHero(data);
      }, Players.GetLocalPlayer()));
      gameEventIDList.push(useNetData("player_purchased_products", data => {
        setPurchasedProduct(data.purchased_products);
      }, Players.GetLocalPlayer()));
      gameEventIDList.push(useNetData("player_custom_event", data => {
        setCustomEventData(data ?? {
          custom_events: []
        });
      }, Players.GetLocalPlayer()));
      libs.createEffect(() => {
        if (initedMark()) {
          gameEventIDList.forEach(id => GameEvents.Unsubscribe(id));
          gameEventIDList = [];
          setPurchasedProduct();
          setCustomEventData();
          setPlayerOrnament();
          setPlayerHero();
          setStoreItemData();
        }
      });
      libs.onCleanup(() => {
        gameEventIDList.forEach(id => GameEvents.Unsubscribe(id));
      });
    });
  }
}
const MenuBar = () => {
  const [bubbleActivityID, setBubbleActivityID] = libs.createSignal();
  const [seen, setSeen] = libs.createSignal(false);
  const [hidenBubble, setHidenBubble] = libs.createSignal(false);
  const [gameState, setGameState] = libs.createSignal();
  const game_state = () => gameState()?.state ?? 'GameState_None';
  const activityBubbleList = [];
  const showActivityBubble = () => {
    return game_state() != "GameState_CitySelection" && game_state() != "GameState_CityEnd" && game_state() != "GameState_None" && game_state() != "GameState_HeroSelection" && game_state() != "GameState_HeroBan";
  };
  const arenaActivityTime = libs.createMemo(() => {
    return getArenaActivityTime();
  });
  const [arenaCountDownShow, setArenaCountDownShow] = libs.createSignal(false);
  let arenaTimer;
  let dateNow = ServerTimestamp();
  if (arenaActivityTime().token_time - dateNow <= 60 * 30) {
    arenaTimer = setInterval(() => {
      let t = ServerTimestamp();
      if (t >= arenaActivityTime().end_time) {
        setArenaCountDownShow(false);
        setBubbleActivityID();
        clearInterval(arenaTimer);
        arenaTimer = undefined;
      } else if (t >= arenaActivityTime().token_time) {
        setBubbleActivityID(50001);
        setArenaCountDownShow(t < arenaActivityTime().start_time);
      }
    }, 1000);
  }
  libs.createEffect(libs.on(paymentOpen, v => {
    $.Schedule(0.1, () => {
      updateActivityBubbleX();
    });
  }));
  const [activityBubbleX, setActivityBubbleX] = libs.createSignal("-200px");
  const updateActivityBubbleX = () => {
    const p = $("#MenuButton_activity");
    if (p?.IsValid()) {
      if (Number.isFinite(p.GetPositionWithinWindow().x)) {
        let screenHeight = Game.GetScreenHeight();
        let screenWidth = Game.GetScreenWidth();
        const rate = Round(screenHeight / screenWidth, 2);
        let scalingRatio_x = 1;
        if (rate < 0.48) {
          scalingRatio_x = screenWidth / 2560;
        } else if (rate >= 0.6 && rate <= 0.65) {
          scalingRatio_x = screenWidth / 1760;
        } else if (rate > 0.54 && rate < 0.6) {
          scalingRatio_x = screenWidth / 1920;
        } else if (rate > 0.65) {
          scalingRatio_x = screenWidth / 1440;
        }
        let x = p.GetPositionWithinWindow().x - p.actuallayoutwidth * 0.5;
        x *= 1 / scalingRatio_x;
        setActivityBubbleX(`${x}px`);
      }
    }
  };
  libs.onMount(() => {
    let gameEventListeners = [];
    let NetTableListenerList = [];
    gameEventListeners.push(GameEvents.Subscribe("custom_ui_toggle_windows", eventData => {
      const name = eventData.window_name.replace("MenuButton_", "");
      if (eventData.state == undefined) {
        if (selectName() == name) {
          setSelectName("");
        } else {
          setSelectName(name);
        }
      } else {
        if (eventData.state == 1) {
          setSelectName(name);
        } else {
          setSelectName("");
        }
      }
    }));
    if (!isSpectator()) {
      gameEventListeners.push(useClientSideEvent("poficiency_reward_state", data => {
        setMarkInfo("hero", data?.state ?? false);
      }));
      gameEventListeners.push(useNetData("open_payment", data => {
        setPaymentOpen(data.open);
      }, Players.GetLocalPlayer()));
      gameEventListeners.push(useNetData("mark_info", data => {
        if (data) {
          for (const menu in data) {
            setMarkInfo(menu, data[menu]);
          }
        }
      }, Players.GetLocalPlayer()));
      NetTableListenerList.push(useNetTableKeyHasDefaultValue("common", "game_state", data => {
        setGameState(data);
      }));
      let login_activity_data_list = [1001];
      gameEventListeners.push(useNetData("login_activity_data", data => {
        let hasReward = Object.values(data).some(activityData => {
          return login_activity_data_list.includes(activityData.activity_id) && activityData.active == true && Object.values(activityData.rewards).some(v => v == 0);
        });
        if (hasReward) {
          setMarkInfo("activity", true);
        }
      }, Players.GetLocalPlayer()));
      gameEventListeners.push(GameEvents.Subscribe("custom_ui_toggle_windows", eventData => {
        if (eventData.state && eventData.state == 1) {
          if (eventData.window_name == "MenuButton_activity") {
            if (!seen() && showActivityBubble()) {
              setSeen(true);
            }
          }
          setHidenBubble(true);
        } else {
          setHidenBubble(false);
        }
      }));
      gameEventListeners.push(useNetData("info_activity_data", data => {
        let now = ServerTimestamp();
        for (const activityInfo of data) {
          if (now < activityInfo.start_time) {
            continue;
          }
          if (activityInfo.end_time > now || activityInfo.end_time == 0) {
            if (activityBubbleList.indexOf(activityInfo.activity_id) != -1) {
              setBubbleActivityID(activityInfo.activity_id);
              break;
            }
          }
        }
      }));
      NetTableListenerList.push(useServiceNetTable("player_medal", data => {
        if ((data?.now_medal ?? 0) <= 200) {
          setMarkInfo("handbook", true);
        }
      }, Players.GetLocalPlayer()));
    }
    libs.onCleanup(() => {
      for (const id of gameEventListeners) {
        GameEvents.Unsubscribe(id);
      }
      NetTableListenerList.forEach(id => CustomNetTables.UnsubscribeNetTableListener(id));
      if (arenaTimer != undefined) {
        clearInterval(arenaTimer);
        arenaTimer = undefined;
      }
    });
  });
  return [(() => {
    const _el$ = libs.createElement("Panel", {
      id: "MenuBar",
      hittest: false
    }, null);
    libs.insert(_el$, libs.createComponent(MenuButton, {
      name: "Return",
      onactivate: self => $.DispatchEvent("DOTAHUDShowDashboard", self)
    }), null);
    libs.insert(_el$, libs.createComponent(MenuButton, {
      name: "Option",
      onactivate: self => $.DispatchEvent("DOTAShowSettingsPopup", self)
    }), null);
    libs.insert(_el$, libs.createComponent(libs.Show, {
      get when() {
        return !isSpectator();
      },
      get children() {
        return [libs.createComponent(MenuButton, {
          name: "setting"
        }), libs.createComponent(MenuButton, {
          name: "rank"
        }), libs.createComponent(MenuButton, {
          name: "mail"
        }), libs.createComponent(libs.Show, {
          get when() {
            return paymentOpen();
          },
          get children() {
            return [libs.createComponent(MenuButton, {
              name: "store"
            }), libs.createComponent(MenuButton, {
              name: "ladderpass"
            }), libs.createComponent(MenuButton, {
              name: "draw"
            })];
          }
        }), libs.createComponent(MenuButton, {
          name: "activity",
          onload: self => {
            updateActivityBubbleX();
          }
        }), libs.createComponent(MenuButton, {
          name: "hero"
        }), libs.createComponent(MenuButton, {
          name: "cosmetics"
        }), libs.createComponent(MenuButton, {
          name: "profile"
        }), libs.createComponent(MenuButton, {
          name: "backpack"
        })];
      }
    }), null);
    libs.insert(_el$, libs.createComponent(MenuButton, {
      name: "handbook"
    }), null);
    libs.insert(_el$, libs.createComponent(MenuButton, {
      name: "scoreboard"
    }), null);
    return _el$;
  })(), (() => {
    const _el$2 = libs.createElement("Panel", {
      id: "MenuBarExtraBar",
      hittest: false
    }, null);
    libs.insert(_el$2, libs.createComponent(libs.Show, {
      get when() {
        return libs.memo(() => !!(showActivityBubble() && bubbleActivityID() != undefined))() && !seen();
      },
      get children() {
        return libs.createComponent(EOM_Panel.EOM_Panel, {
          get className() {
            return libs.classNames("ActivityBubble");
          },
          get visible() {
            return !hidenBubble();
          },
          get x() {
            return activityBubbleX();
          },
          onload: self => {
            updateActivityBubbleX();
          },
          get children() {
            return [libs.createComponent(EOM_Panel.EOM_Panel, {
              className: "ActivityBubbleArrow"
            }), libs.createComponent(BubbleBox.EOMBubbleBox, {
              onactivate: () => {
                setSeen(true);
                ToggleWindows("MenuButton_activity", true);
                if (bubbleActivityID() == 50001) {
                  clientSideEvent("switchActivityTag", {
                    id: "Activity_arena"
                  });
                } else {
                  clientSideEvent("switchActivityTag", {
                    id: "Activity_Anniversary"
                  });
                }
              },
              get children() {
                return libs.createComponent(libs.Switch, {
                  get fallback() {
                    return [libs.createComponent(EOM_Panel.EOM_Panel, {
                      get className() {
                        return libs.classNames("ActivityBubbleTitle", "AID" + bubbleActivityID(), $.Language().toLowerCase());
                      },
                      hittest: false
                    }), libs.createComponent(EOM_Button.EOM_IconButton, {
                      get icon() {
                        return libs.createComponent(EOM_Icon.EOM_Icon, {
                          size: "16",
                          className: "ActivityBubbleCloseIcon",
                          get src() {
                            return getSrcPath("eom_design/icon/c4/btn_store_close.png");
                          }
                        });
                      },
                      className: "ActivityBubbleCloseIcon",
                      onactivate: () => {
                        setSeen(true);
                      }
                    })];
                  },
                  get children() {
                    return libs.createComponent(libs.Match, {
                      get when() {
                        return bubbleActivityID() == 50001;
                      },
                      get children() {
                        return [libs.createComponent(EOM_Panel.EOM_Panel, {
                          id: "ArenaBubble",
                          get children() {
                            return libs.createComponent(libs.Show, {
                              get when() {
                                return arenaCountDownShow();
                              },
                              get fallback() {
                                return libs.createComponent(EOM_Label.EOM_Label, {
                                  className: "ArenaLabel",
                                  id: "ArenaLabel2",
                                  text: "#Activity_arena_Bubble1",
                                  html: true
                                });
                              },
                              get children() {
                                return [libs.createComponent(EOM_Label.EOM_Label, {
                                  className: "ArenaLabel",
                                  id: "ArenaLabel1",
                                  text: "#Activity_arena_Bubble2",
                                  html: true
                                }), libs.createComponent(EOM_Countdown.EOM_Countdown, {
                                  get endTime() {
                                    return arenaActivityTime().start_time;
                                  },
                                  text: "#countdown_min",
                                  server_time: true
                                })];
                              }
                            });
                          }
                        }), libs.createComponent(EOM_Button.EOM_IconButton, {
                          get icon() {
                            return libs.createComponent(EOM_Icon.EOM_Icon, {
                              size: "16",
                              className: "ActivityBubbleCloseIcon",
                              get src() {
                                return getSrcPath("eom_design/icon/c4/btn_store_close.png");
                              }
                            });
                          },
                          className: "ActivityBubbleCloseIcon",
                          onactivate: () => {
                            setSeen(true);
                          }
                        })];
                      }
                    });
                  }
                });
              }
            })];
          }
        });
      }
    }));
    return _el$2;
  })()];
};
const MenuButton = props => {
  const [local, other] = libs.splitProps(props, ["name"]);
  const selected = () => selectName() == local.name;
  const marktype = () => {
    if (markInfo[local.name] ?? false) {
      return "default";
    }
    if (markNewInfo[local.name] ?? false) {
      return markNewInfo[local.name];
    }
  };
  libs.onMount(() => {
    const id = GameEvents.Subscribe("custom_ui_exclamation", event => {
      if (event.name == props.name) {
        setMarkInfo(local.name, true);
      }
    });
    libs.onCleanup(() => {
      GameEvents.Unsubscribe(id);
    });
  });
  return libs.createComponent(EOM_Button.EOM_BaseButton, libs.mergeProps({
    get id() {
      return "MenuButton_" + local.name;
    },
    get className() {
      return $.Language().toLowerCase();
    },
    onactivate: self => {
      GameEvents.SendEventClientSide("custom_ui_toggle_windows", {
        window_name: "MenuButton_" + local.name,
        state: selected() ? 0 : 1
      });
      if (local.name != "mail") {
        setMarkInfo(local.name, false);
      }
      if (markNewInfo[local.name]) {
        setMarkNewInfo({
          [local.name]: null
        });
        clickNewMark({
          menu: local.name
        }, self);
      }
      if (local.name == "profile") {
        GameUI.SetProfilePlayerId(Players.GetLocalPlayer());
      }
    }
  }, other, {
    get children() {
      return [libs.createComponent(GenericPanel.CImage, {
        get className() {
          return libs.classNames("Front", local.name, {
            Selected: selected()
          });
        }
      }), libs.createComponent(GenericPanel.CImage, {
        get className() {
          return libs.classNames("Hover", local.name, {
            Selected: selected()
          });
        }
      }), libs.createComponent(GenericPanel.CLabel, {
        get className() {
          return libs.classNames("MenuLabel", local.name, {
            Selected: selected()
          });
        },
        get text() {
          return "#MenuButton_" + local.name;
        }
      }), libs.createComponent(libs.Show, {
        get when() {
          return marktype() != undefined;
        },
        get children() {
          return libs.createComponent(MenuMarkIcon.MenuMarkIcon, {
            get type() {
              return marktype();
            }
          });
        }
      })];
    }
  }));
};
libs.render(() => libs.createComponent(MenuBar, {}), $.GetContextPanel());