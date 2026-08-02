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
var GenericPanel = require('./GenericPanel.js');
var EOM_Image = require('./EOM_Image.js');
var EOM_Label = require('./EOM_Label.js');
var Player = require('./Player.js');
require('./EOM_Button.js');
require('./EOM_Icon.js');

let LastTIP = 1;
for (let i = 1; i < 1000; i++) {
  const key = "#Custom_Tip_" + i;
  const sLoc = $.Localize(key);
  if (key == sLoc) {
    break;
  }
  LastTIP = i;
}
let tipQueue = Array(LastTIP).fill(1).map((a, i) => i + 1).sort(() => Math.random() - 0.5);
const CustomTip = props => {
  const merged = libs.mergeProps$1({
    tick: 5
  }, props);
  const [local, others] = libs.splitProps(merged, ["children", "tick"]);
  const [index, SetIndex] = libs.createSignal(0);
  const [id, setID] = libs.createSignal(-1);
  const PrevTip = () => {
    SetIndex(old => (old <= 0 ? old + LastTIP - 1 : old - 1) % LastTIP);
  };
  const nextTip = () => {
    SetIndex(old => (old + 1) % LastTIP);
  };
  libs.createEffect(libs.on(index, v => {
    if (id() != -1) {
      try {
        $.CancelScheduled(id());
      } catch (error) {}
    }
    setID($.Schedule(local.tick, () => {
      nextTip();
    }));
  }));
  libs.onCleanup(() => {
    if (id() != -1) {
      try {
        $.CancelScheduled(id());
        setID(-1);
      } catch (error) {}
    }
  });
  return libs.createComponent(EOM_Panel.EOM_Panel, libs.mergeProps(() => EOM_Panel.EOMProps(others, {
    className: "CustomTip"
  }), {
    get children() {
      return [(() => {
        const _el$ = libs.createElement("Button", {
          id: "PrevTip"
        }, null);
        libs.setProp(_el$, "onactivate", PrevTip);
        return _el$;
      })(), libs.createComponent(GenericPanel.CLabel, {
        id: "TipLabel",
        get text() {
          return "#Custom_Tip_" + tipQueue[index()];
        },
        hittest: false
      }), (() => {
        const _el$2 = libs.createElement("Button", {
          id: "NextTip"
        }, null);
        libs.setProp(_el$2, "onactivate", nextTip);
        return _el$2;
      })()];
    }
  }));
};

function Root() {
  const [show, setShow] = libs.createSignal($.GetContextPanel().BHasClass("Paused"));
  const [playerPauseData, setPlayerPauseData] = libs.createSignal({});
  const disconnectPlayerList = libs.createMemo(() => {
    return Object.keys(playerPauseData());
  });
  libs.onMount(() => {
    const netTableListenerList = [];
    netTableListenerList.push(useNetTableKeyHasDefaultValue("common", "custom_pause", data => {
      $.GetContextPanel().SetHasClass("Paused", data.pause == 1);
      setShow(data.pause == 1);
    }));
    netTableListenerList.push(useNetTableKeyHasDefaultValue("common", "peak_cup_pasue_data", data => {
      setPlayerPauseData(data);
    }));
    libs.onCleanup(() => {
      netTableListenerList.forEach(v => {
        CustomNetTables.UnsubscribeNetTableListener(v);
      });
    });
  });
  const [sPauseKey, setPauseKey] = libs.createSignal(Game.GetKeybindForCommand(DOTAKeybindCommand_t.DOTA_KEYBIND_PAUSE));
  libs.createEffect(() => {
    const id = GameEvents.Subscribe("keybind_changed", events => {
      setPauseKey(Game.GetKeybindForCommand(DOTAKeybindCommand_t.DOTA_KEYBIND_PAUSE));
    });
    libs.onCleanup(() => {
      GameEvents.Unsubscribe(id);
    });
  });
  libs.createEffect(libs.on(sPauseKey, value => {
    const sCommand = value + Date.now() / 1000;
    Game.CreateCustomKeyBind(value, "+" + sCommand);
    Game.AddCommand("+" + sCommand, () => {
      GameEvents.SendCustomEventToServer("CustomTogglePause", {});
    }, "", 1 << 26);
  }));
  const getTextLabel = count => {
    let hours = Math.max(0, Math.floor(count % 86400 / 3600));
    let minutes = Math.max(0, Math.floor(count % 3600 / 60));
    let seconds = Math.max(0, count % 60);
    let s = seconds.toString();
    if (s.length == 1) {
      s = "0" + s;
    }
    let m = minutes.toString();
    if (m.length == 1) {
      m = "0" + m;
    }
    let h = hours.toString();
    if (h.length == 1) {
      h = "0" + h;
    }
    return `${h}:${m}:${s}`;
  };
  return libs.createComponent(libs.Show, {
    get when() {
      return show();
    },
    get children() {
      return [libs.createComponent(GenericPanel.CLabel, {
        id: "CustomPausing",
        text: "#CustomPausing",
        hittest: false
      }), libs.createComponent(CustomTip, {
        id: "PauseCustomTip",
        hittest: false
      }), libs.createComponent(libs.Show, {
        get when() {
          return isCompetitionMode();
        },
        get children() {
          return libs.createComponent(EOM_Panel.EOM_Panel, {
            id: "PlayerDisconnectInfo",
            get children() {
              return libs.createComponent(libs.Index, {
                get each() {
                  return disconnectPlayerList();
                },
                children: (_playerID, index) => {
                  const playerID = () => Number(_playerID());
                  const playerDisconnectData = () => playerPauseData()[playerID()];
                  const disconnected = () => playerDisconnectData().state;
                  const time = () => playerDisconnectData().time;
                  const steamID = () => getPlayerData(playerID(), "steamID");
                  const isOverTime = () => time() > 300;
                  return libs.createComponent(EOM_Panel.EOM_Panel, {
                    get className() {
                      return libs.classNames("DisconnectInfo", {
                        disconnected: disconnected(),
                        overTime: isOverTime()
                      });
                    },
                    get children() {
                      return [libs.createComponent(EOM_Panel.EOM_Panel, {
                        get children() {
                          return [libs.createComponent(Player.PlayerAvatar, {
                            get playerID() {
                              return playerID();
                            },
                            get steamID() {
                              return steamID();
                            }
                          }), libs.createComponent(libs.Show, {
                            get when() {
                              return disconnected();
                            },
                            get children() {
                              return libs.createComponent(EOM_Image.EOM_Image, {
                                align: "center center",
                                width: "36px",
                                height: "36px",
                                get backgroundImage() {
                                  return getImagePath("hud/icon_disconnect.png");
                                },
                                hittest: false
                              });
                            }
                          })];
                        }
                      }), libs.createComponent(Player.PlayerName, {
                        get playerID() {
                          return playerID();
                        },
                        get steamID() {
                          return steamID();
                        }
                      }), libs.createComponent(EOM_Label.EOM_Label, {
                        id: "disconnectCount",
                        get text() {
                          return getTextLabel(time());
                        }
                      })];
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
}
libs.render(() => libs.createComponent(Root, {}), $.GetContextPanel());