--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 9d26fbd · 2026-08-07 04:51:43 UTC
  ~ auto-generated — do not edit
]]


'use strict'; const require = GameUI.__require;

var libs = require('./libs.js');
var EOM_Panel = require('./EOM_Panel.js');
var EOM_Image = require('./EOM_Image.js');
var EOM_Loading = require('./EOM_Loading.js');
var EOM_Button = require('./EOM_Button.js');
var GenericPanel = require('./GenericPanel.js');
var Player = require('./Player.js');
require('./EOM_Icon.js');
require('./EOM_Label.js');

$.GetContextPanel().AddClass("CosmeticPreviewLiveHidden");
function ReGame() {
  const defaultData = CustomNetTables.GetTableValue("common", "game_end_regame");
  const [endTime, setEndTime] = libs.createSignal(defaultData?.end_time ?? 0);
  const [startTime, setStartTime] = libs.createSignal(defaultData?.start_time ?? 0);
  const [regameData, setRegameData] = libs.createSignal(defaultData?.data ?? {});
  const [time, setTime] = libs.createSignal(0);
  const playerList = libs.createMemo(() => {
    const regame_data = regameData();
    return Object.keys(regame_data).sort().map((key, index) => {
      const playerID = Number(key);
      return {
        steamID: getPlayerData(playerID, "steamID") ?? "-1",
        regame: regame_data[Number(key)]?.regame ?? 3
      };
    });
  });
  let timer;
  libs.createEffect(() => {
    if (endTime() > 0 && endTime() - startTime() > 0) {
      timer = setInterval(() => {
        const remainingTime = endTime() - Game.GetGameTime();
        setTime(remainingTime);
        if (remainingTime <= 0) {
          if (timer) {
            clearInterval(timer);
          }
        }
      }, 10);
    } else {
      if (timer) {
        clearInterval(timer);
      }
      setTime(0);
    }
  });
  libs.onMount(() => {
    const NetTableListenerIDs = [];
    NetTableListenerIDs.push(useNetTableKey("common", "game_end_regame", data => {
      libs.batch(() => {
        setEndTime(data.end_time);
        setStartTime(data.start_time);
        setRegameData(data.data);
      });
    }));
    libs.onCleanup(() => NetTableListenerIDs.forEach(id => CustomNetTables.UnsubscribeNetTableListener(id)));
  });
  const [cooldown, setCooldown] = libs.createSignal(false);
  const onClick = (state, self) => {
    setCooldown(true);
    $.Schedule(0.5, () => setCooldown(false));
    GameEvents.SendCustomEventToServer("regame_decision", {
      state
    });
    if (!state) {
      $.DispatchEvent("DOTAHUDShowDashboard", self);
    }
  };
  return (() => {
    const _el$ = libs.createElement("Panel", {}, null);
    libs.insert(_el$, libs.createComponent(EOM_Panel.EOM_Panel, {
      get className() {
        return libs.classNames("ReGameContainer");
      },
      get children() {
        return [libs.createComponent(EOM_Panel.EOM_Panel, {
          id: "ReGameLabelContainer",
          get visible() {
            return time() > 0;
          },
          get children() {
            return [libs.createComponent(GenericPanel.CLabel, {
              id: "ReGameLabel",
              text: "#RegameInfo"
            }), libs.createComponent(GenericPanel.CLabel, {
              id: "CountDown",
              text: "#RemainingTime",
              get dialogVariables() {
                return {
                  time: Math.max(time(), 0)
                };
              }
            })];
          }
        }), libs.createComponent(EOM_Panel.EOM_Panel, {
          id: "ButtonContainer",
          get visible() {
            return time() > 0;
          },
          get children() {
            return [libs.createComponent(EOM_Button.EOM_Button, {
              get enabled() {
                return !cooldown();
              },
              marginLeft: "450px",
              text: "#Popup_Button_Confirm",
              color: "Blue",
              onactivate: self => onClick(true, self)
            }), libs.createComponent(EOM_Button.EOM_Button, {
              get enabled() {
                return !cooldown();
              },
              marginRight: "450px",
              text: "#Popup_Button_Cancel",
              color: "Red",
              onactivate: self => onClick(false, self)
            })];
          }
        }), libs.createComponent(EOM_Panel.EOM_Panel, {
          id: "ProgressBar",
          get visible() {
            return time() > 0;
          },
          get children() {
            return libs.createComponent(EOM_Panel.EOM_Panel, {
              id: "ProgressBarUpper",
              get children() {
                return libs.createComponent(EOM_Panel.EOM_Panel, {
                  backgroundColor: "#fff",
                  height: "100%",
                  get width() {
                    return `${Math.max(time(), 0) / Math.max(endTime() - startTime(), 1) * 100}%`;
                  }
                });
              }
            });
          }
        }), libs.createComponent(EOM_Panel.EOM_Panel, {
          id: "PlayerList",
          get children() {
            return libs.createComponent(libs.Index, {
              get each() {
                return playerList();
              },
              children: (playerInfo, index) => {
                return libs.createComponent(EOM_Panel.EOM_Panel, {
                  className: "PlayerInfo",
                  flowChildren: "down",
                  width: "150px",
                  get children() {
                    return [libs.createComponent(Player.PlayerName, {
                      id: "PlayerName",
                      get steamID() {
                        return playerInfo().steamID;
                      },
                      playerID: index
                    }), libs.createComponent(Player.PlayerAvatar, {
                      id: "PlayerAvatar",
                      get steamID() {
                        return playerInfo().steamID;
                      },
                      playerID: index
                    }), libs.createComponent(EOM_Panel.EOM_Panel, {
                      horizontalAlign: "center",
                      height: "35px",
                      width: "35px",
                      marginTop: "10px",
                      marginBottom: "20px",
                      get children() {
                        return libs.createComponent(libs.Dynamic, {
                          get component() {
                            return [() => libs.createComponent(EOM_Image.EOM_Image, {
                              className: "Check",
                              get backgroundImage() {
                                return getImagePath("icon/icon_party_reject_psd.png");
                              }
                            }), () => libs.createComponent(EOM_Image.EOM_Image, {
                              className: "Check",
                              get backgroundImage() {
                                return getImagePath("icon/icon_party_ready_psd.png");
                              }
                            }), () => libs.createComponent(EOM_Loading.EOM_Loading, {
                              type: "Wave"
                            })][playerInfo().regame - 1];
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
    }));
    libs.effect(_$p => libs.setProp(_el$, "className", libs.classNames("ReGameRoot", {
      Show: endTime() > 0
    }), _$p));
    return _el$;
  })();
}
libs.render(() => libs.createComponent(ReGame, {}), $.GetContextPanel());