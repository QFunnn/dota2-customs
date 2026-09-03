--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 0b85d8d 
  ~ auto-generated — do not edit
]]


'use strict'; const require = GameUI.__require;

var libs = require('./libs.js');
var EOM_Popup = require('./EOM_Popup.js');
var EOM_Countdown = require('./EOM_Countdown.js');
var EOM_Loading = require('./EOM_Loading.js');
var EOM_Button = require('./EOM_Button.js');
var EOM_TextEntry = require('./EOM_TextEntry.js');
var solid_utils = require('./solid_utils.js');

const LOGIN_FLOW_STEPS = [{
  key: "login",
  label: "#LoginStep_login"
}, {
  key: "setting",
  label: "#LoginStep_setting"
}, {
  key: "equipment",
  label: "#LoginStep_equipment"
}, {
  key: "attributes",
  label: "#LoginStep_attributes"
}];
const gameState = solid_utils.createNetDataSignal("common", "game_state", {
  state: "GameState_Login",
  start_time: -1,
  end_time: -1
});
const loginState = solid_utils.createNetDataSignal("common", "login_state", {});
const settings = solid_utils.createNetDataSignal("common", "settings", {
  is_local_host: false,
  is_in_tools_mode: false,
  is_cheat_mode: false
});
libs.createEffect(libs.on([gameState], () => {
  $.GetContextPanel().SwitchClass("GameState_Login", gameState().state);
}));
function Root() {
  const [inviteKey, setInviteKey] = libs.createSignal("");
  const [submittingInviteKey, setSubmittingInviteKey] = libs.createSignal(false);
  const [authPassword, setAuthPassword] = libs.createSignal("");
  const [submittingAuth, setSubmittingAuth] = libs.createSignal(false);
  const localPlayerLoginState = libs.createMemo(() => loginState()?.[Players.GetLocalPlayer()]?.state ?? PlayerLoginState.None);
  const localPlayerSteps = libs.createMemo(() => loginState()?.[Players.GetLocalPlayer()]?.steps);
  const isLocalHost = libs.createMemo(() => settings()?.is_local_host == true || settings()?.is_local_host);
  libs.createEffect(libs.on(localPlayerLoginState, state => {
    print(localPlayerLoginState());
    if (state != PlayerLoginState.NoPermission) {
      setSubmittingInviteKey(false);
    }
    if (state != PlayerLoginState.NeedAuth) {
      setSubmittingAuth(false);
    }
  }));
  const submitInviteKey = () => {
    let key = inviteKey().trim();
    if (key === "") return;
    setSubmittingInviteKey(true);
    CallAction("/v1/white_list/add", {
      key
    });
    GameEvents.SendCustomEventToServer("login_retry_white_list", {});
  };
  const submitAuthPassword = () => {
    let password = authPassword().trim();
    if (password === "") return;
    setSubmittingAuth(true);
    ServerRequest("player_auth_login", {
      password
    }, result => {
      if (result.code !== 0 && result.code !== 200) {
        setSubmittingAuth(false);
      }
    }, undefined, () => setSubmittingAuth(false));
  };
  return [libs.createComponent(EOM_Button.EOM_BaseButton, {
    id: "Return",
    "class": "MenuButton",
    onactivate: self => $.DispatchEvent("DOTAHUDShowDashboard", self),
    get children() {
      return [libs.createElement("Panel", {
        id: "SelectedHover"
      }, null), (() => {
        const _el$2 = libs.createElement("Panel", {
            id: "SelectParticleRoot"
          }, null);
          libs.createElement("DOTAParticleScenePanel", {
            id: "SelectParticle",
            particleName: "particles/ui/game/ui_game_general_special_effects_02_fx.vpcf",
            cameraOrigin: "0 0 60",
            fov: 40,
            lookAt: "0 0 0",
            hittest: false,
            squarePixels: true
          }, _el$2);
        return _el$2;
      })(), (() => {
        const _el$4 = libs.createElement("Panel", {
          get ["class"]() {
            return libs.classNames("BGImage", "Return");
          }
        }, null);
        libs.effect(_$p => libs.setProp(_el$4, "class", libs.classNames("BGImage", "Return"), _$p));
        return _el$4;
      })(), (() => {
        const _el$5 = libs.createElement("Label", {
          get ["class"]() {
            return libs.classNames("MenuLabel", "Return");
          },
          text: "#MenuButton_Return"
        }, null);
        libs.effect(_$p => libs.setProp(_el$5, "class", libs.classNames("MenuLabel", "Return"), _$p));
        return _el$5;
      })()];
    }
  }), (() => {
    const _el$6 = libs.createElement("Panel", {
      id: "PlayerReadyUp"
    }, null);
    libs.insert(_el$6, libs.createComponent(libs.For, {
      get each() {
        return Object.keys(loginState());
      },
      children: (_, index) => {
        const playerID = () => toFiniteNumber(_);
        const playerSteamID = () => {
          return Game.GetPlayerInfo(playerID())?.player_steamid;
        };
        const state = () => {
          return loginState()?.[playerID()]?.state ?? PlayerLoginState.None;
        };
        return (() => {
          const _el$23 = libs.createElement("Panel", {
              get ["class"]() {
                return libs.classNames("PlayerReadySlot", {
                  Accepted: state() == PlayerLoginState.Success,
                  Declined: state() != PlayerLoginState.Success
                });
              }
            }, null),
            _el$24 = libs.createElement("DOTAAvatarImage", {
              id: "AvatarImage",
              get steamid() {
                return playerSteamID();
              },
              width: "100%",
              height: "100%",
              hittest: false
            }, _el$23);
            libs.createElement("Panel", {
              "class": "AcceptedMatch",
              hittest: false
            }, _el$23);
            libs.createElement("Panel", {
              "class": "DeclinedMatch",
              hittest: false
            }, _el$23);
          libs.setProp(_el$24, "width", "100%");
          libs.setProp(_el$24, "height", "100%");
          libs.effect(_p$ => {
            const _v$ = libs.classNames("PlayerReadySlot", {
                Accepted: state() == PlayerLoginState.Success,
                Declined: state() != PlayerLoginState.Success
              }),
              _v$2 = playerSteamID();
            _v$ !== _p$._v$ && (_p$._v$ = libs.setProp(_el$23, "class", _v$, _p$._v$));
            _v$2 !== _p$._v$2 && (_p$._v$2 = libs.setProp(_el$24, "steamid", _v$2, _p$._v$2));
            return _p$;
          }, {
            _v$: undefined,
            _v$2: undefined
          });
          return _el$23;
        })();
      }
    }));
    return _el$6;
  })(), libs.createComponent(libs.Show, {
    get when() {
      return localPlayerSteps();
    },
    children: () => (() => {
      const _el$27 = libs.createElement("Panel", {
        id: "LoginStepsContainer"
      }, null);
      libs.insert(_el$27, libs.createComponent(libs.For, {
        each: LOGIN_FLOW_STEPS,
        children: (step, index) => {
          const completed = () => localPlayerSteps()?.[step.key] ?? false;
          return (() => {
            const _el$28 = libs.createElement("Panel", {
                get ["class"]() {
                  return libs.classNames("LoginStepItem", {
                    Completed: completed()
                  });
                }
              }, null);
              libs.createElement("Panel", {
                "class": "LoginStepIndicator"
              }, _el$28);
              const _el$30 = libs.createElement("Label", {
                "class": "LoginStepLabel",
                color: "white",
                get text() {
                  return `${index() + 1}. ${GetLocalization(step.label)}`;
                }
              }, _el$28);
            libs.effect(_p$ => {
              const _v$3 = libs.classNames("LoginStepItem", {
                  Completed: completed()
                }),
                _v$4 = `${index() + 1}. ${GetLocalization(step.label)}`;
              _v$3 !== _p$._v$3 && (_p$._v$3 = libs.setProp(_el$28, "class", _v$3, _p$._v$3));
              _v$4 !== _p$._v$4 && (_p$._v$4 = libs.setProp(_el$30, "text", _v$4, _p$._v$4));
              return _p$;
            }, {
              _v$3: undefined,
              _v$4: undefined
            });
            return _el$28;
          })();
        }
      }));
      return _el$27;
    })()
  }), libs.createComponent(libs.Show, {
    get when() {
      return localPlayerLoginState() == PlayerLoginState.None;
    },
    get children() {
      const _el$7 = libs.createElement("Panel", {
          id: "LoadingContainer"
        }, null),
        _el$8 = libs.createElement("Label", {
          color: "white",
          text: "#Login_Loading",
          horizontalAlign: "center",
          marginTop: "20px"
        }, _el$7);
      libs.insert(_el$7, libs.createComponent(EOM_Loading.EOM_Loading, {
        id: "Loading"
      }), _el$8);
      libs.setProp(_el$8, "horizontalAlign", "center");
      libs.setProp(_el$8, "marginTop", "20px");
      return _el$7;
    }
  }), libs.createComponent(libs.Show, {
    get when() {
      return libs.memo(() => !!isLocalHost())() && localPlayerLoginState() == PlayerLoginState.NeedAuth;
    },
    get children() {
      const _el$9 = libs.createElement("Panel", {
          id: "InviteKey"
        }, null),
        _el$0 = libs.createElement("Panel", {
          id: "InviteKeyContainer"
        }, _el$9);
        libs.createElement("Label", {
          id: "InviteKeyTitle",
          text: "#Login_LocalAuth_Title"
        }, _el$0);
        libs.createElement("Label", {
          id: "InviteKeyDesc",
          html: true,
          text: "#Login_LocalAuth_Desc"
        }, _el$0);
        const _el$11 = libs.createElement("Panel", {
          id: "InviteKeyForm"
        }, _el$0);
      libs.insert(_el$11, libs.createComponent(EOM_TextEntry.EOM_TextEntry, {
        id: "InviteKeyEntry",
        textmode: "password",
        get text() {
          return authPassword();
        },
        placeholder: "#Login_LocalAuth_Placeholder",
        onChange: (self, _, text) => setAuthPassword(text),
        oninputsubmit: submitAuthPassword
      }), null);
      libs.insert(_el$11, libs.createComponent(EOM_Button.EOM_Button, {
        id: "InviteKeyConfirm",
        get enabled() {
          return libs.memo(() => !!!submittingAuth())() && authPassword().trim() !== "";
        },
        size: "Small",
        get text() {
          return libs.memo(() => !!submittingAuth())() ? GetLocalization("#Login_Submitting") : GetLocalization("#Login_Unlock");
        },
        onactivate: submitAuthPassword
      }), null);
      return _el$9;
    }
  }), libs.createComponent(libs.Show, {
    get when() {
      return localPlayerLoginState() == PlayerLoginState.NoPermission;
    },
    get children() {
      const _el$12 = libs.createElement("Panel", {
          id: "InviteKey"
        }, null),
        _el$13 = libs.createElement("Panel", {
          id: "InviteKeyContainer"
        }, _el$12);
        libs.createElement("Label", {
          id: "InviteKeyTitle",
          text: "#Login_NoPermission_Title"
        }, _el$13);
        libs.createElement("Label", {
          id: "InviteKeyDesc",
          text: "#Login_NoPermission_Desc"
        }, _el$13);
        const _el$16 = libs.createElement("Panel", {
          id: "InviteKeyForm"
        }, _el$13);
      libs.insert(_el$16, libs.createComponent(EOM_TextEntry.EOM_TextEntry, {
        id: "InviteKeyEntry",
        get text() {
          return inviteKey();
        },
        placeholder: "#Login_InviteKey_Placeholder",
        onChange: (self, _, text) => setInviteKey(text),
        oninputsubmit: submitInviteKey
      }), null);
      libs.insert(_el$16, libs.createComponent(EOM_Button.EOM_Button, {
        id: "InviteKeyConfirm",
        get enabled() {
          return libs.memo(() => !!!submittingInviteKey())() && inviteKey().trim() !== "";
        },
        size: "Small",
        get text() {
          return libs.memo(() => !!submittingInviteKey())() ? GetLocalization("#Login_Submitting") : GetLocalization("#Login_Unlock");
        },
        onactivate: submitInviteKey
      }), null);
      return _el$12;
    }
  }), libs.createComponent(libs.Show, {
    get when() {
      return loginState()?.[Players.GetLocalPlayer()]?.state == PlayerLoginState.Banned;
    },
    get children() {
      return libs.createComponent(EOM_Popup.EOM_Popup, {
        id: "BannedContainer",
        size: "normal",
        "class": "EOM_PopupMainShow",
        hideClose: true,
        title: "Login_Banned",
        get children() {
          return [libs.createElement("Label", {
            id: "BannedContent",
            text: "#Login_Banned_Content",
            html: true
          }, null), (() => {
            const _el$18 = libs.createElement("Panel", {
                id: "BanCountdownContainer"
              }, null);
              libs.createElement("Label", {
                text: "#Login_Banned_Endtime"
              }, _el$18);
            libs.insert(_el$18, libs.createComponent(EOM_Countdown.EOM_Countdown, {
              id: "BanCountdown",
              get endTime() {
                return loginState()?.[Players.GetLocalPlayer()]?.ban_end_time ?? 0;
              }
            }), null);
            return _el$18;
          })(), (() => {
            const _el$20 = libs.createElement("Panel", {
                flowChildren: "down",
                align: "right bottom",
                marginBottom: "20px"
              }, null),
              _el$21 = libs.createElement("Panel", {
                id: "BanQrCode",
                get ["class"]() {
                  return Language();
                }
              }, _el$20);
              libs.createElement("Label", {
                id: "BanContact",
                text: "#BanContact"
              }, _el$20);
            libs.setProp(_el$20, "flowChildren", "down");
            libs.setProp(_el$20, "align", "right bottom");
            libs.setProp(_el$20, "marginBottom", "20px");
            libs.effect(_$p => libs.setProp(_el$21, "class", Language(), _$p));
            return _el$20;
          })()];
        }
      });
    }
  })];
}
(() => {
  $.GetContextPanel().SetPanelEvent("onactivate", () => {});
  libs.render(() => libs.createComponent(Root, {}), $.GetContextPanel());
})();