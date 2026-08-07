--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 16fdfbc · 2026-08-07 21:47:55 UTC
  ~ auto-generated — do not edit
]]


'use strict'; const require = GameUI.__require;

var libs = require('./libs.js');
var EOM_Panel = require('./EOM_Panel.js');
var EOM_Label = require('./EOM_Label.js');
var EOM_Button = require('./EOM_Button.js');
var Heroes = require('./Heroes.js');
var SectIcon = require('./SectIcon.js');
require('./GenericPanel.js');
require('./EOM_Icon.js');
require('./EOM_Image.js');

$.GetContextPanel().AddClass("CosmeticPreviewLiveHidden");
const [rookieV2Enable, setRookieV2Enable] = libs.createSignal(false);
const COUNTDOWN_DEFUALT = 20;
const useRookieV2Nomal = () => {
  const [rookieV2TempHideKey, setRookieV2TempHideKey] = libs.createSignal();
  const rookieV2TempHide = () => {
    if (rookieV2DataNormal() && rookieV2TempHideKey() && rookieV2DataNormal().key == rookieV2TempHideKey()) {
      return true;
    }
    return false;
  };
  const [rookieV2NormalCountDown, setRookieV2NormalCountDown] = libs.createSignal(-1);
  const [rookieV2DataNormal, setRookieV2DataNormal] = libs.createSignal();
  libs.createEffect(() => {
    if (rookieV2NormalCountDown() <= 0 && rookieV2DataNormal() && rookieV2DataNormal().key) {
      let key = rookieV2DataNormal().key;
      setRookieV2DataNormal();
      setRookieV2Lighting([]);
      closeRookieV2Tip(key);
    }
  });
  const [rookieV2LightingNormal, setRookieV2Lighting] = libs.createSignal([]);
  libs.createEffect(libs.on(rookieV2Enable, v => {
    if (!v) {
      setRookieV2TempHideKey();
      setRookieV2DataNormal();
      setRookieV2NormalCountDown(-1);
      setRookieV2Lighting([]);
    }
  }));
  const updateLightData = () => {
    const lightning_data = getClientGlobalData("rookie_v2_lightings");
    let list = [];
    let rookie_v2_progress = rookieV2DataNormal();
    if (lightning_data && rookie_v2_progress && lightning_data[rookie_v2_progress.key]) {
      list = lightning_data[rookie_v2_progress.key];
    }
    setRookieV2Lighting(list);
  };
  libs.onMount(() => {
    const timer = setInterval(() => {
      if (rookieV2NormalCountDown() > 0) {
        setRookieV2NormalCountDown(rookieV2NormalCountDown() - 0.25);
      } else {
        setRookieV2NormalCountDown(0);
      }
    }, 250);
    const eventIDList = [];
    const netTableListenerIDs = [];
    eventIDList.push(useClientSideEvent("rookieV2_close", data => {
      let stage = -1;
      if (KeyValues.RookieGuideKV[data.key] && KeyValues.RookieGuideKV[data.key].hidden != 1 && typeof KeyValues.RookieGuideKV[data.key].orderby == "number") {
        stage = KeyValues.RookieGuideKV[data.key].orderby;
      }
      if (stage == -1) return;
      const progress = getClientGlobalData("rookie_v2_progress");
      if (progress && (progress.stage != 0 || stage == progress.stage + 1) && stage >= progress.stage) {
        let _param = {
          stage: stage,
          key: "",
          params: {},
          state: false
        };
        if (stage == progress.stage) {
          _param.params = progress.params;
        }
        setClientGlobalData("rookie_v2_progress", _param, true);
        setClientGlobalData("rookie_v2_lightings", {
          [stage]: "DELETE"
        });
      }
    }));
    eventIDList.push(useClientSideEvent("rookieV2_hide", data => {
      if (data.state) {
        setRookieV2TempHideKey(data.key);
      } else {
        setRookieV2TempHideKey();
      }
    }));
    eventIDList.push(useClientGlobalData("rookie_v2_progress", data => {
      const {
        state,
        ...other
      } = data;
      libs.batch(() => {
        if (state) {
          setRookieV2DataNormal(other);
          setRookieV2NormalCountDown(COUNTDOWN_DEFUALT);
        } else if (rookieV2DataNormal() && rookieV2DataNormal()?.stage == other.stage) {
          setRookieV2DataNormal();
          setRookieV2NormalCountDown(-1);
        }
      });
      GameEvents.SendCustomEventToServer("rookie_v2_progress", data);
    }));
    eventIDList.push(useClientGlobalData("rookie_v2_lightings", data => {
      updateLightData();
    }));
    libs.onCleanup(() => {
      eventIDList.forEach(id => GameEvents.Unsubscribe(id));
      netTableListenerIDs.forEach(id => CustomNetTables.UnsubscribeNetTableListener(id));
      clearInterval(timer);
    });
  });
  return {
    setRookieV2DataNormal,
    rookieV2TempHide,
    rookieV2DataNormal,
    rookieV2LightingNormal,
    rookieV2NormalCountDown
  };
};
const useRookieV2Override = () => {
  const [rookieV2OverrideData, setRookieV2OverrideData] = libs.createSignal();
  const overrideGroupInfo = libs.createMemo(() => {
    let data = rookieV2OverrideData();
    if (data && KeyValues.RookieGuideKV[data.key] && KeyValues.RookieGuideKV[data.key].hidden != 1 && KeyValues.RookieGuideKV[data.key].group) {
      return {
        group: KeyValues.RookieGuideKV[data.key].group,
        group_orderby: KeyValues.RookieGuideKV[data.key].group_orderby
      };
    }
  });
  const [rookieV2OverrideCountDown, setRookieV2OverrideCountDown] = libs.createSignal(-1);
  libs.createEffect(() => {
    if (rookieV2OverrideCountDown() <= 0 && rookieV2OverrideData() && rookieV2OverrideData().key) {
      let key = rookieV2OverrideData().key;
      setRookieV2OverrideData();
      closeRookieV2Tip(key);
      let info = overrideGroupInfo();
      if (info && info?.group && info?.group_orderby) {
        setClientGlobalData("rookie_v2_override_group", {
          [info.group]: info.group_orderby
        });
      }
    }
  });
  libs.createEffect(libs.on(rookieV2Enable, v => {
    if (!v) {
      setRookieV2OverrideData();
      setRookieV2OverrideCountDown(-1);
    }
  }));
  libs.onMount(() => {
    const timer = setInterval(() => {
      if (rookieV2OverrideCountDown() > 0) {
        setRookieV2OverrideCountDown(rookieV2OverrideCountDown() - 0.25);
      } else {
        setRookieV2OverrideCountDown(0);
      }
    }, 250);
    const eventIDList = [];
    const netTableListenerIDs = [];
    eventIDList.push(useClientGlobalData("rookie_v2_override_data", data => {
      if (data.state) {
        if (data.params && data.lighting) {
          setRookieV2OverrideCountDown(COUNTDOWN_DEFUALT);
          setRookieV2OverrideData({
            key: data.key,
            params: data.params,
            lighting: data.lighting
          });
        } else {
          setRookieV2OverrideCountDown(-1);
          setRookieV2OverrideData();
        }
      } else if (data.key == "" || data.key == rookieV2OverrideData()?.key) {
        setRookieV2OverrideData();
      }
    }));
    eventIDList.push(useClientSideEvent("rookieV2_override_close", data => {
      if (rookieV2OverrideData() && data.key == rookieV2OverrideData().key) {
        setClientGlobalData("rookie_v2_override_data", {
          state: false,
          key: data.key
        }, true);
      }
      if (data.key && KeyValues.RookieGuideKV[data.key] && KeyValues.RookieGuideKV[data.key].hidden != 1 && KeyValues.RookieGuideKV[data.key].group) {
        let groupData = getClientGlobalData("rookie_v2_override_group");
        if (groupData?.[KeyValues.RookieGuideKV[data.key].group]) {
          setClientGlobalData("rookie_v2_override_group", {
            [KeyValues.RookieGuideKV[data.key].group]: "DELETE"
          });
        }
      }
    }));
    libs.onCleanup(() => {
      eventIDList.forEach(id => GameEvents.Unsubscribe(id));
      netTableListenerIDs.forEach(id => CustomNetTables.UnsubscribeNetTableListener(id));
      clearInterval(timer);
    });
  });
  return {
    setRookieV2OverrideData,
    rookieV2OverrideData,
    overrideGroupInfo,
    rookieV2OverrideCountDown
  };
};
const RookieRoot = () => {
  const {
    setRookieV2DataNormal,
    rookieV2DataNormal,
    rookieV2TempHide,
    rookieV2LightingNormal,
    rookieV2NormalCountDown
  } = useRookieV2Nomal();
  const {
    setRookieV2OverrideData,
    rookieV2OverrideData,
    overrideGroupInfo,
    rookieV2OverrideCountDown
  } = useRookieV2Override();
  const rookieV2Lighting = libs.createMemo(() => {
    if (rookieV2OverrideData() != undefined) {
      return rookieV2OverrideData().lighting;
    }
    return rookieV2LightingNormal();
  });
  const rookieV2CountDown = () => {
    if (rookieV2OverrideData() != undefined) {
      return rookieV2OverrideCountDown();
    }
    return rookieV2NormalCountDown();
  };
  const rookieV2Data = libs.createMemo(() => {
    if (rookieV2OverrideData() != undefined) {
      return {
        key: rookieV2OverrideData().key,
        params: rookieV2OverrideData().params
      };
    }
    if (rookieV2DataNormal() != undefined) {
      return {
        key: rookieV2DataNormal().key,
        params: rookieV2DataNormal().params
      };
    }
  });
  const rookieLightEdges = libs.createMemo(() => {
    if (rookieV2Lighting().length > 0) {
      let x = [0, 0];
      let y = [0, 0];
      for (let i = 0; i < rookieV2Lighting().length; i++) {
        const element = rookieV2Lighting()[i];
        let x0 = element.x;
        let x1 = element.x + element.width;
        let y0 = element.y;
        let y1 = element.y + element.height;
        if (x[0] == 0 || x[0] > x0) {
          x[0] = x0;
        }
        if (x[1] < x1) {
          x[1] = x1;
        }
        if (y[0] == 0 || y[0] > y0) {
          y[0] = y0;
        }
        if (y[1] < y1) {
          y[1] = y1;
        }
      }
      return {
        x,
        y
      };
    }
    return;
  });
  const updateRookieV2 = () => {
    const d1 = getNetDataCache("player_rookie_data", Players.GetLocalPlayer());
    const d2 = CustomNetTables.GetTableValue("common", "is_rookie_match");
    let state = false;
    if (d1 && d2) {
      state = d1?.is_first_game && d2?.state == 1;
    }
    setRookieV2Enable(state);
    setClientGlobalData("rookie_v2", {
      state
    });
  };
  const updateUiScale = () => {
    let pMain = $("#RookieMain");
    let pRookieV2 = $("#RookieV2Container");
    if (pRookieV2?.IsValid() && pMain?.IsValid()) {
      pRookieV2.style.uiScaleX = `${1 / pMain.actualuiscale_x * 100}%`;
      pRookieV2.style.uiScaleY = `${1 / pMain.actualuiscale_y * 100}%`;
    }
  };
  libs.onMount(() => {
    const timer = setInterval(() => {
      updateUiScale();
    }, 5000);
    let playerID = Players.GetLocalPlayer();
    const eventIDList = [];
    const netTableListenerIDs = [];
    eventIDList.push(useNetData("player_rookie_data", data => {
      updateRookieV2();
    }, playerID));
    netTableListenerIDs.push(useNetTableKey("common", "is_rookie_match", data => {
      updateRookieV2();
    }));
    let lastGameState = CustomNetTables.GetTableValue("common", "game_state")?.state ?? "";
    netTableListenerIDs.push(useNetTableKey("common", "game_state", data => {
      if (data.state != lastGameState) {
        if (lastGameState == "GameState_None") {
          setClientGlobalData("rookie_v2_progress", {
            stage: 0,
            key: "",
            params: {},
            state: false
          }, true);
          setClientGlobalData("rookie_v2_lightings", {}, true);
          setClientGlobalData("rookie_v2_override_data", {
            state: false,
            key: ""
          }, true);
          setClientGlobalData("rookie_v2_override_group", {}, true);
        }
        lastGameState = data.state;
      }
    }));
    libs.onCleanup(() => {
      clearInterval(timer);
      eventIDList.forEach(id => GameEvents.Unsubscribe(id));
      netTableListenerIDs.forEach(id => CustomNetTables.UnsubscribeNetTableListener(id));
    });
  });
  const rookieV2Show = () => rookieV2Data() != undefined;
  return (() => {
    const _el$ = libs.createElement("Panel", {
      id: "RookieMain",
      hittest: false
    }, null);
    libs.insert(_el$, libs.createComponent(EOM_Panel.EOM_Panel, {
      id: "RookieV2Container",
      hittest: false,
      onload: () => {
        updateUiScale();
      },
      get children() {
        return libs.createComponent(EOM_Panel.EOM_Panel, {
          id: "RookieV2Tips",
          hittest: false,
          get children() {
            return libs.createComponent(libs.Show, {
              get when() {
                return libs.memo(() => !!(rookieV2Show() && !rookieV2TempHide()))() && rookieV2Data() != undefined;
              },
              get children() {
                return libs.createComponent(libs.Switch, {
                  get children() {
                    return [libs.createComponent(libs.Match, {
                      get when() {
                        return rookieV2Data().key == "hero_ban";
                      },
                      get children() {
                        return libs.createComponent(EOM_Button.EOM_BaseButton, {
                          get className() {
                            return libs.classNames("RookieV2Tip", "Stage_" + rookieV2Data().key, "left");
                          },
                          onactivate: () => {
                            let key = rookieV2Data().key;
                            if (rookieV2OverrideData() != undefined) {
                              setRookieV2OverrideData();
                            } else if (rookieV2DataNormal() != undefined) {
                              setRookieV2DataNormal();
                            }
                            closeRookieV2Tip(key);
                          },
                          get children() {
                            return [libs.createElement("Image", {
                              id: "EmojiIcon",
                              hittest: false
                            }, null), (() => {
                              const _el$3 = libs.createElement("Panel", {
                                id: "TipContent"
                              }, null);
                              libs.insert(_el$3, libs.createComponent(EOM_Label.EOM_Label, {
                                id: "TipLabel",
                                hittest: false,
                                html: true,
                                get text() {
                                  return replaceEnum($.Localize("#RookieV2_" + rookieV2Data().key));
                                }
                              }), null);
                              libs.insert(_el$3, libs.createComponent(EOM_Label.EOM_Label, {
                                id: "TipCountdown",
                                text: "#RookieCountdown",
                                get dialogVariables() {
                                  return {
                                    time: Math.ceil(rookieV2CountDown())
                                  };
                                },
                                html: true
                              }), null);
                              return _el$3;
                            })()];
                          }
                        });
                      }
                    }), libs.createComponent(libs.Match, {
                      get when() {
                        return rookieLightEdges();
                      },
                      children: () => {
                        let ref;
                        const [offset, setOffset] = libs.createSignal({
                          x: 0,
                          y: 0
                        });
                        const updateSelfPanelScale = self => {
                          setOffset({
                            x: 0,
                            y: 0
                          });
                          let timeOut = 1;
                          let tick = 0.03333;
                          let timer = () => {
                            timeOut = timeOut - tick;
                            if (timeOut > 0) {
                              if (self?.IsValid() && self.actuallayoutwidth > 0) {
                                setOffset({
                                  x: self.actuallayoutwidth,
                                  y: self.actuallayoutheight
                                });
                                return;
                              }
                            } else {
                              return;
                            }
                            $.Schedule(tick, timer);
                          };
                          timer();
                        };
                        const edgeParam = libs.createMemo(() => {
                          let params = rookieV2Data()?.params;
                          let tooltip_position = params?.tooltip_position ?? "right";
                          let edges = rookieLightEdges();
                          let result = {
                            tooltip_position: tooltip_position,
                            x: 0,
                            y: 0
                          };
                          const screenWidth = Game.GetScreenWidth();
                          const screenHeight = Game.GetScreenHeight();
                          switch (tooltip_position) {
                            case "left":
                              {
                                result.x = screenWidth - edges.x[0];
                                result.y = edges.y[0] + (edges.y[1] - edges.y[0]) / 2;
                                break;
                              }
                            case "top":
                              {
                                result.x = edges.x[0] + (edges.x[1] - edges.x[0]) / 2;
                                result.y = edges.y[0] - screenHeight;
                                break;
                              }
                            case "bottom":
                              {
                                result.x = edges.x[0] + (edges.x[1] - edges.x[0]) / 2;
                                result.y = edges.y[1];
                                break;
                              }
                            default:
                              {
                                result.x = edges.x[1];
                                result.y = edges.y[0] + (edges.y[1] - edges.y[0]) / 2;
                                break;
                              }
                          }
                          return result;
                        });
                        const styleParams = () => {
                          let params = {
                            align: "left top"
                          };
                          switch (edgeParam().tooltip_position) {
                            case "left":
                              {
                                params.align = "right top";
                                params.y = `${edgeParam().y - offset().y / 2}px`;
                                params.x = `${-edgeParam().x}px`;
                                break;
                              }
                            case "top":
                              {
                                params.align = "left bottom";
                                params.y = `${edgeParam().y}px`;
                                params.x = `${edgeParam().x - offset().x / 2}px`;
                                break;
                              }
                            case "bottom":
                              {
                                params.align = "left top";
                                params.y = `${edgeParam().y}px`;
                                params.x = `${edgeParam().x - offset().x / 2}px`;
                                break;
                              }
                            default:
                              {
                                params.y = `${edgeParam().y - offset().y / 2}px`;
                                params.x = `${edgeParam().x}px`;
                                break;
                              }
                          }
                          return params;
                        };
                        return libs.createComponent(EOM_Button.EOM_BaseButton, {
                          ref(r$) {
                            const _ref$ = ref;
                            typeof _ref$ === "function" ? _ref$(r$) : ref = r$;
                          },
                          get className() {
                            return libs.classNames("RookieV2Tip", "Stage_" + rookieV2Data().key, edgeParam().tooltip_position);
                          },
                          get style() {
                            return styleParams();
                          },
                          onload: updateSelfPanelScale,
                          onactivate: () => {
                            let key = rookieV2Data().key;
                            if (rookieV2OverrideData() != undefined) {
                              setRookieV2OverrideData();
                            } else if (rookieV2DataNormal() != undefined) {
                              setRookieV2DataNormal();
                            }
                            closeRookieV2Tip(key);
                            let info = overrideGroupInfo();
                            if (info && info?.group && info?.group_orderby) {
                              setClientGlobalData("rookie_v2_override_group", {
                                [info.group]: info.group_orderby
                              });
                            }
                          },
                          get children() {
                            return [libs.createElement("Image", {
                              id: "EmojiIcon",
                              hittest: false
                            }, null), (() => {
                              const _el$5 = libs.createElement("Panel", {
                                id: "TipContent"
                              }, null);
                              libs.insert(_el$5, libs.createComponent(EOM_Label.EOM_Label, {
                                id: "TipLabel",
                                hittest: false,
                                html: true,
                                get text() {
                                  return replaceEnum($.Localize("#RookieV2_" + rookieV2Data().key));
                                }
                              }), null);
                              libs.insert(_el$5, libs.createComponent(EOM_Label.EOM_Label, {
                                id: "TipCountdown",
                                text: "#RookieCountdown",
                                get dialogVariables() {
                                  return {
                                    time: Math.ceil(rookieV2CountDown())
                                  };
                                },
                                html: true
                              }), null);
                              return _el$5;
                            })(), libs.createElement("Image", {
                              id: "ArrowTip",
                              hittest: false
                            }, null)];
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
    }), null);
    libs.insert(_el$, libs.createComponent(RookieV1, {
      get rookieV2() {
        return rookieV2Enable();
      }
    }), null);
    return _el$;
  })();
};
const RookieV1 = props => {
  const [rookie, setRookie] = libs.createSignal({});
  const [closeRookie, setCloseRookie] = libs.createSignal(false);
  const [playerData, setPlayerData] = libs.createSignal(CustomNetTables.GetTableValue("player_data", Players.GetLocalPlayer()));
  const rookieConfig = () => playerData()?.service_config?.rookie;
  const rookiteList = () => keyof(rookie());
  const [rookieV1Show, setRookieV1Show] = libs.createSignal(!props.rookieV2);
  let old_rookieV2 = props.rookieV2;
  let rookieV1ShowTimer;
  const Update = () => {
    if (props.rookieV2) {
      setRookieV1Show(true);
      old_rookieV2 = props.rookieV2;
      if (rookieV1ShowTimer != undefined) {
        $.CancelScheduled(rookieV1ShowTimer);
        rookieV1ShowTimer = undefined;
        return;
      }
      return;
    }
    if (!props.rookieV2 && old_rookieV2) {
      rookieV1ShowTimer = $.Schedule(1, () => {
        setRookieV1Show(true);
        rookieV1ShowTimer = undefined;
      });
    }
    old_rookieV2 = props.rookieV2;
    if (rookieV1ShowTimer != undefined) {
      return;
    }
    let rookieList = {};
    rookiteList().forEach((key, index) => {
      let data = rookie()[key];
      if (data.duration > 0) {
        data.duration -= Game.GetGameFrameTime();
        rookieList[key] = data;
      } else {
        if (data.type == "sect") {
          clientSideEvent("openTipShop", {});
        }
      }
    });
    setRookie(rookieList);
  };
  const onRookie = data => {
    if (data.type == "clear") {
      if (data.id == undefined) {
        setRookie({});
      } else {
        let newRookie = {
          ...rookie()
        };
        for (const _id of data.id) {
          delete newRookie[data.id];
        }
        setRookie(newRookie);
      }
    } else {
      if (rookieConfig() == "1" && !closeRookie()) {
        setRookie({
          ...rookie(),
          ...{
            [data.id ?? data.type]: {
              type: data.type,
              id: data.id,
              duration: data.duration ?? 20,
              dialog: data.dialog,
              position: data.position,
              extra: data.extra
            }
          }
        });
      }
    }
  };
  libs.onMount(() => {
    const timer = setInterval(Update, Game.GetGameFrameTime());
    const eventIDList = [];
    const netTableListenerIDs = [];
    eventIDList.push(useClientSideEvent("rookie", onRookie));
    eventIDList.push(useClientSideEvent("rookie_close", () => setCloseRookie(true)));
    netTableListenerIDs.push(useNetTableKey("player_data", Players.GetLocalPlayer(), data => {
      setPlayerData(data);
    }));
    libs.onCleanup(() => {
      eventIDList.forEach(id => {
        GameEvents.Unsubscribe(id);
      });
      netTableListenerIDs.forEach(id => CustomNetTables.UnsubscribeNetTableListener(id));
      clearInterval(timer);
    });
  });
  return ((() => {
      const _el$7 = libs.createElement("Panel", {
        id: "RookieV1Container",
        hittest: false
      }, null);
      libs.insert(_el$7, libs.createComponent(libs.Show, {
        get when() {
          return !props.rookieV2;
        },
        get children() {
          return libs.createComponent(libs.Index, {
            get each() {
              return rookiteList();
            },
            children: (v, index) => {
              let data = () => rookie()[v()];
              let dialog = data()?.dialog ?? "";
              if (data().type == "sect") {
                let sect1 = data().extra?.sect1?.replace("sect_", "") ?? "";
                sect1 = sect1.charAt(0).toUpperCase() + sect1.slice(1);
                let sect2 = data().extra?.sect2?.replace("sect_", "") ?? "";
                sect2 = sect2.charAt(0).toUpperCase() + sect2.slice(1);
                dialog = $.Localize(dialog);
                dialog = dialog.replace("%sect1%", `{KeyWord:${sect1}}`);
                dialog = dialog.replace("%sect2%", `{KeyWord:${sect2}}`);
                dialog = replaceKeyword(dialog);
              }
              if (data().type == "level") {
                let sect = data().extra?.sect?.replace("sect_", "") ?? "";
                sect = sect.charAt(0).toUpperCase() + sect.slice(1);
                dialog = $.Localize(dialog);
                dialog = dialog.replace("%sect%", `{KeyWord:${sect}}`);
                dialog = replaceKeyword(dialog);
              }
              return libs.createComponent(libs.Switch, {
                get children() {
                  return [libs.createComponent(libs.Match, {
                    get when() {
                      return data().type == "hero_selection";
                    },
                    get children() {
                      return libs.createComponent(EOM_Button.EOM_BaseButton, {
                        get ["class"]() {
                          return "RookieTip Tip" + data().type + " Index" + data().extra?.index + " MaxCount" + data().extra?.max_index;
                        },
                        onactivate: () => {
                          clearRookieTip("hero_selection");
                        },
                        get children() {
                          return [libs.createElement("Image", {
                            id: "EmojiIcon",
                            hittest: false
                          }, null), (() => {
                            const _el$9 = libs.createElement("Panel", {
                              id: "TipContent"
                            }, null);
                            libs.insert(_el$9, libs.createComponent(EOM_Label.EOM_Label, {
                              id: "TipLabel",
                              hittest: false,
                              html: true,
                              text: dialog
                            }));
                            return _el$9;
                          })(), libs.createComponent(EOM_Button.EOM_BaseButton, {
                            id: "NoMore",
                            onactivate: () => {
                              showPopup("CloseRookie", {});
                              clearRookieTip("hero_selection");
                            },
                            get children() {
                              return libs.createElement("Label", {
                                id: "NoMoreTip",
                                text: "#NoMoreTip"
                              }, null);
                            }
                          })];
                        }
                      });
                    }
                  }), libs.createComponent(libs.Match, {
                    get when() {
                      return data().type == "shop";
                    },
                    get children() {
                      return libs.createComponent(EOM_Button.EOM_BaseButton, {
                        get ["class"]() {
                          return "RookieTip Tip" + data().type + " Index" + data().extra?.index + " Length" + data().extra?.length;
                        },
                        onactivate: () => {
                          clearRookieTip(data().type);
                        },
                        get children() {
                          return [libs.createElement("Image", {
                            id: "EmojiIcon",
                            hittest: false
                          }, null), (() => {
                            const _el$10 = libs.createElement("Panel", {
                              id: "TipContent"
                            }, null);
                            libs.insert(_el$10, libs.createComponent(EOM_Label.EOM_Label, {
                              id: "TipLabel",
                              hittest: false,
                              html: true,
                              get text() {
                                return replaceEnum($.Localize(dialog));
                              }
                            }));
                            return _el$10;
                          })(), libs.createComponent(EOM_Button.EOM_BaseButton, {
                            id: "NoMore",
                            onactivate: () => {
                              showPopup("CloseRookie", {});
                              clearRookieTip(data().type);
                            },
                            get children() {
                              return libs.createElement("Label", {
                                id: "NoMoreTip",
                                text: "#NoMoreTip"
                              }, null);
                            }
                          })];
                        }
                      });
                    }
                  }), libs.createComponent(libs.Match, {
                    get when() {
                      return data().type == "talent" || data().type == "equipment" || data().type == "artifact";
                    },
                    get children() {
                      return libs.createComponent(EOM_Button.EOM_BaseButton, {
                        get ["class"]() {
                          return "RookieTip Tip" + data().type + " Index" + data().extra?.index;
                        },
                        onactivate: () => {
                          clearRookieTip(data().type);
                        },
                        get children() {
                          return [libs.createElement("Image", {
                            id: "EmojiIcon",
                            hittest: false
                          }, null), (() => {
                            const _el$13 = libs.createElement("Panel", {
                              id: "TipContent"
                            }, null);
                            libs.insert(_el$13, libs.createComponent(EOM_Label.EOM_Label, {
                              id: "TipLabel",
                              hittest: false,
                              html: true,
                              get text() {
                                return replaceEnum($.Localize(dialog));
                              }
                            }));
                            return _el$13;
                          })(), libs.createComponent(EOM_Button.EOM_BaseButton, {
                            id: "NoMore",
                            onactivate: () => {
                              showPopup("CloseRookie", {});
                              clearRookieTip(data().type);
                            },
                            get children() {
                              return libs.createElement("Label", {
                                id: "NoMoreTip",
                                text: "#NoMoreTip"
                              }, null);
                            }
                          })];
                        }
                      });
                    }
                  }), libs.createComponent(libs.Match, {
                    get when() {
                      return data().type == "sect";
                    },
                    get children() {
                      return libs.createComponent(EOM_Button.EOM_BaseButton, {
                        "class": "RookieTip TipSect",
                        horizontalAlign: "right",
                        marginTop: "200px",
                        marginRight: "200px",
                        onactivate: () => {
                          clearRookieTip(data().type);
                          clientSideEvent("openTipShop", {});
                        },
                        get children() {
                          return [libs.createElement("Image", {
                            id: "EmojiIcon",
                            hittest: false
                          }, null), (() => {
                            const _el$16 = libs.createElement("Panel", {
                              id: "TipContent"
                            }, null);
                            libs.insert(_el$16, libs.createComponent(EOM_Panel.EOM_Panel, {
                              flowChildren: "right",
                              marginBottom: "10px",
                              get children() {
                                return [libs.createComponent(Heroes.HeroImage, {
                                  get hero_name() {
                                    return getPlayerData(Players.GetLocalPlayer(), "heroName");
                                  }
                                }), libs.createComponent(SectIcon.SectIcon, {
                                  verticalAlign: "center",
                                  get sectName() {
                                    return data().extra?.sect1;
                                  }
                                }), libs.createComponent(SectIcon.SectIcon, {
                                  verticalAlign: "center",
                                  get sectName() {
                                    return data().extra?.sect2;
                                  }
                                }), libs.createElement("Image", {
                                  id: "SectHot"
                                }, null)];
                              }
                            }), null);
                            libs.insert(_el$16, libs.createComponent(EOM_Label.EOM_Label, {
                              id: "TipLabel",
                              hittest: false,
                              html: true,
                              text: dialog
                            }), null);
                            return _el$16;
                          })(), libs.createComponent(EOM_Button.EOM_BaseButton, {
                            id: "NoMore",
                            onactivate: () => {
                              showPopup("CloseRookie", {});
                              clearRookieTip(data().type);
                            },
                            get children() {
                              return libs.createElement("Label", {
                                id: "NoMoreTip",
                                text: "#NoMoreTip"
                              }, null);
                            }
                          })];
                        }
                      });
                    }
                  }), libs.createComponent(libs.Match, {
                    get when() {
                      return data().type == "gold";
                    },
                    get children() {
                      return libs.createComponent(EOM_Button.EOM_BaseButton, {
                        "class": "RookieTip TipGold",
                        horizontalAlign: "center",
                        onactivate: () => {
                          clearRookieTip(data().type);
                        },
                        get children() {
                          return [libs.createElement("Image", {
                            id: "EmojiIcon",
                            hittest: false
                          }, null), (() => {
                            const _el$20 = libs.createElement("Panel", {
                              id: "TipContent"
                            }, null);
                            libs.insert(_el$20, libs.createComponent(EOM_Label.EOM_Label, {
                              id: "TipLabel",
                              hittest: false,
                              html: true,
                              get text() {
                                return replaceEnum($.Localize(dialog));
                              }
                            }));
                            return _el$20;
                          })(), libs.createComponent(EOM_Button.EOM_BaseButton, {
                            id: "NoMore",
                            onactivate: () => {
                              showPopup("CloseRookie", {});
                              clearRookieTip(data().type);
                            },
                            get children() {
                              return libs.createElement("Label", {
                                id: "NoMoreTip",
                                text: "#NoMoreTip"
                              }, null);
                            }
                          }), libs.createElement("Image", {
                            id: "ArrowTip"
                          }, null)];
                        }
                      });
                    }
                  }), libs.createComponent(libs.Match, {
                    get when() {
                      return data().type == "level";
                    },
                    get children() {
                      return libs.createComponent(EOM_Button.EOM_BaseButton, {
                        "class": "RookieTip TipLevel",
                        onactivate: () => {
                          clearRookieTip(data().type);
                        },
                        get children() {
                          return [libs.createComponent(EOM_Button.EOM_Button, {
                            color: "Blue",
                            id: "JumpButton",
                            text: "#RookieLevelJump",
                            onactivate: () => {
                              clearRookieTip(data().type);
                              ToggleWindows("MenuButton_handbook", true);
                              clientSideEvent("jump_handbook", {
                                index: "FAQ"
                              });
                            }
                          }), libs.createElement("Image", {
                            id: "EmojiIcon",
                            hittest: false
                          }, null), (() => {
                            const _el$24 = libs.createElement("Panel", {
                              id: "TipContent"
                            }, null);
                            libs.insert(_el$24, libs.createComponent(EOM_Label.EOM_Label, {
                              id: "TipLabel",
                              hittest: false,
                              html: true,
                              get text() {
                                return replaceEnum($.Localize(dialog));
                              }
                            }));
                            return _el$24;
                          })(), libs.createComponent(EOM_Button.EOM_BaseButton, {
                            id: "NoMore",
                            onactivate: () => {
                              showPopup("CloseRookie", {});
                              clearRookieTip(data().type);
                            },
                            get children() {
                              return libs.createElement("Label", {
                                id: "NoMoreTip",
                                text: "#NoMoreTip"
                              }, null);
                            }
                          })];
                        }
                      });
                    }
                  }), libs.createComponent(libs.Match, {
                    get when() {
                      return data().type == "prepare";
                    },
                    get children() {
                      return libs.createComponent(EOM_Button.EOM_BaseButton, {
                        get ["class"]() {
                          return "RookieTip TipPrepare " + data().extra.layout4;
                        },
                        onactivate: () => {
                          clearRookieTip(data().type);
                        },
                        get children() {
                          return [libs.createElement("Image", {
                            id: "EmojiIcon",
                            hittest: false
                          }, null), (() => {
                            const _el$27 = libs.createElement("Panel", {
                              id: "TipContent"
                            }, null);
                            libs.insert(_el$27, libs.createComponent(EOM_Label.EOM_Label, {
                              id: "TipLabel",
                              hittest: false,
                              html: true,
                              get text() {
                                return replaceEnum($.Localize(dialog));
                              }
                            }));
                            return _el$27;
                          })(), libs.createComponent(EOM_Button.EOM_BaseButton, {
                            id: "NoMore",
                            onactivate: () => {
                              showPopup("CloseRookie", {});
                              clearRookieTip(data().type);
                            },
                            get children() {
                              return libs.createElement("Label", {
                                id: "NoMoreTip",
                                text: "#NoMoreTip"
                              }, null);
                            }
                          }), libs.createElement("Image", {
                            id: "ArrowTip"
                          }, null)];
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
      return _el$7;
    })()
  );
};
if (!isSpectator()) {
  libs.render(() => libs.createComponent(RookieRoot, {}), $.GetContextPanel());
}