--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 9d26fbd · 2026-08-07 04:51:43 UTC
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
var red_point_utils = require('./red_point_utils.js');

const [selectName, setSelectName] = libs.createSignal("");
const [paymentOpen, setPaymentOpen] = libs.createSignal(false);
const [redPoints, setRedPoints] = libs.createSignal(getClientGlobalData("red_points") ?? []);
const MenuBar = () => {
  const [dropdownItems, setDropdownItems] = libs.createSignal([]);
  const [storeTags, setStoreTags] = libs.createSignal(getClientGlobalData("menu_bar_store_tabs") ?? []);
  const [drawPools, setDrawPools] = libs.createSignal(getClientGlobalData("menu_bar_draw_pools") ?? []);
  const [activityTabs, setActivityTabs] = libs.createSignal(getClientGlobalData("menu_bar_activity_tabs") ?? []);
  const [cosmeticTabs, setCosmeticTabs] = libs.createSignal(getClientGlobalData("menu_bar_cosmetic_tabs") ?? []);
  const [profileTabs, setProfileTabs] = libs.createSignal(getClientGlobalData("menu_bar_profile_tabs") ?? []);
  let dropContainer;
  let dropTargetPanel;
  const hideDropDown = () => {
    if (!dropContainer?.IsValid()) return;
    dropTargetPanel?.RemoveClass('ShowDropDown');
    dropContainer.RemoveClass('Show');
  };
  const showDropDown = (panel, name) => {
    if (!dropContainer?.IsValid()) return;
    const dropdownMenus = {
      store: () => storeTags().map(tag => ({
        label: tag,
        action: () => clientSideEvent("toggle_store_tag", {
          menu: tag
        }),
        redPoint: () => red_point_utils.hasRedPoint(redPoints(), "store", tag)
      })),
      draw: () => drawPools().map(pool => ({
        label: pool.label,
        action: () => {
          ToggleWindows("MenuButton_draw", true);
          clientSideEvent("switchDrawPool", {
            pid: pool.id
          });
        }
      })),
      activity: () => activityTabs().map(tag => ({
        label: tag,
        action: () => {
          ToggleWindows("MenuButton_activity", true);
          clientSideEvent("switchActivityTag", {
            id: tag
          });
        },
        redPoint: () => red_point_utils.hasRedPoint(redPoints(), "activity", tag)
      })),
      cosmetics: () => cosmeticTabs().map(tag => ({
        label: tag,
        action: () => {
          ToggleWindows("MenuButton_cosmetics", true);
          clientSideEvent("menu_bar_cosmetic_tab", {
            tag
          });
        }
      })),
      profile: () => profileTabs().map(tag => ({
        label: tag,
        action: () => {
          GameUI.SetProfilePlayerId(Players.GetLocalPlayer());
          ToggleWindows("MenuButton_profile", true);
          clientSideEvent("menu_bar_profile_tab", {
            tag
          });
        }
      }))
    };
    if (panel != undefined) {
      if (name == undefined || dropdownMenus[name] == undefined) {
        hideDropDown();
        return;
      }
      const items = dropdownMenus[name]();
      if (items.length == 0) {
        hideDropDown();
        return;
      }
      const position = panel.GetPositionWithinWindow();
      const dropX = position.x / dropContainer.actualuiscale_x - 80 + 23;
      dropContainer.SetPositionInPixels(Math.max(0, dropX), 0, 0);
      const marginTop = dropContainer.FindChild('MarginTop');
      if (marginTop?.IsValid()) {
        marginTop.style.transform = `translateX(${Math.min(0, dropX)}px)`;
      }
      setDropdownItems(items);
      dropTargetPanel?.RemoveClass('ShowDropDown');
      dropTargetPanel = panel;
    }
    dropTargetPanel?.AddClass('ShowDropDown');
    dropContainer.AddClass('Show');
  };
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
    gameEventListeners.push(useClientGlobalData("menu_bar_store_tabs", data => {
      setStoreTags(data);
    }));
    gameEventListeners.push(useClientGlobalData("menu_bar_draw_pools", data => {
      setDrawPools(data);
    }));
    gameEventListeners.push(useClientGlobalData("menu_bar_activity_tabs", data => {
      setActivityTabs(data);
    }));
    gameEventListeners.push(useClientGlobalData("menu_bar_cosmetic_tabs", data => {
      setCosmeticTabs(data);
    }));
    gameEventListeners.push(useClientGlobalData("menu_bar_profile_tabs", data => {
      setProfileTabs(data);
    }));
    gameEventListeners.push(useClientGlobalData("red_points", setRedPoints));
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
      gameEventListeners.push(useNetData("open_payment", data => {
        setPaymentOpen(data.open);
      }, Players.GetLocalPlayer()));
      NetTableListenerList.push(useNetTableKeyHasDefaultValue("common", "game_state", data => {
        setGameState(data);
      }));
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
          name: "setting",
          onDropDown: showDropDown,
          onHideDropDown: hideDropDown
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
              name: "store",
              onDropDown: showDropDown,
              onHideDropDown: hideDropDown
            }), libs.createComponent(MenuButton, {
              name: "ladderpass"
            }), libs.createComponent(MenuButton, {
              name: "draw",
              onDropDown: showDropDown,
              onHideDropDown: hideDropDown
            })];
          }
        }), libs.createComponent(MenuButton, {
          name: "activity",
          onDropDown: showDropDown,
          onHideDropDown: hideDropDown,
          onload: self => {
            updateActivityBubbleX();
          }
        }), libs.createComponent(MenuButton, {
          name: "hero"
        }), libs.createComponent(MenuButton, {
          name: "cosmetics",
          onDropDown: showDropDown,
          onHideDropDown: hideDropDown
        }), libs.createComponent(MenuButton, {
          name: "profile",
          onDropDown: showDropDown,
          onHideDropDown: hideDropDown
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
        id: "DropContainer",
        hittest: false
      }, null),
      _el$3 = libs.createElement("Panel", {
        id: "MarginTop",
        hittest: true
      }, _el$2),
      _el$4 = libs.createElement("Panel", {
        id: "DropMain"
      }, _el$2);
    const _ref$ = dropContainer;
    typeof _ref$ === "function" ? libs.use(_ref$, _el$2) : dropContainer = _el$2;
    libs.setProp(_el$3, "onmouseover", () => showDropDown());
    libs.setProp(_el$3, "onmouseout", hideDropDown);
    libs.setProp(_el$4, "onmouseover", () => showDropDown());
    libs.setProp(_el$4, "onmouseout", hideDropDown);
    libs.insert(_el$4, libs.createComponent(libs.For, {
      get each() {
        return dropdownItems();
      },
      children: item => libs.createComponent(EOM_Button.EOM_BaseButton, {
        className: "DropdownItem",
        onactivate: () => {
          item.action();
          hideDropDown();
        },
        get children() {
          return [libs.createComponent(EOM_Label.EOM_Label, {
            get text() {
              return `#${item.label}`;
            }
          }), libs.createComponent(libs.Show, {
            get when() {
              return item.redPoint?.();
            },
            get children() {
              return libs.createComponent(MenuMarkIcon.MenuMarkIcon, {
                className: "DropdownRedPoint",
                type: "default",
                hittest: false
              });
            }
          })];
        }
      })
    }));
    return _el$2;
  })(), (() => {
    const _el$5 = libs.createElement("Panel", {
      id: "MenuBarExtraBar",
      hittest: false
    }, null);
    libs.insert(_el$5, libs.createComponent(libs.Show, {
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
    return _el$5;
  })()];
};
const MenuButton = props => {
  const [local, other] = libs.splitProps(props, ["name", "onDropDown", "onHideDropDown"]);
  const selected = () => selectName() == local.name;
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
      if (local.name == "profile") {
        GameUI.SetProfilePlayerId(Players.GetLocalPlayer());
      }
    },
    onmouseover: self => local.onDropDown?.(self, local.name),
    onmouseout: () => local.onHideDropDown?.()
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
          return libs.memo(() => !!local.name)() && red_point_utils.hasRedPoint(redPoints(), local.name);
        },
        get children() {
          return libs.createComponent(MenuMarkIcon.MenuMarkIcon, {
            type: "default",
            hittest: false
          });
        }
      })];
    }
  }));
};
libs.render(() => libs.createComponent(MenuBar, {}), $.GetContextPanel());