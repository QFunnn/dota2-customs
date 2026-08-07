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
var EOM_Popup = require('./EOM_Popup.js');
var EOM_Icon = require('./EOM_Icon.js');
var EOM_Label = require('./EOM_Label.js');
var EOM_Button = require('./EOM_Button.js');
var GenericPanel = require('./GenericPanel.js');

const Key2Command = {
  key_Backquote: "`",
  key_Tab: "TAB",
  key_Capslock: "CAPSLOCK",
  key_Space: "SPACE",
  key_Minus: "-",
  key_Equal: "=",
  key_Backspace: "BACKSPACE",
  key_Backslash: "\\",
  key_Semicolon: ";",
  key_Comma: ",",
  key_Period: ".",
  key_Slash: "/",
  key_Enter: "RETURN",
  key_1: "1",
  key_2: "2",
  key_3: "3",
  key_4: "4",
  key_5: "5",
  key_6: "6",
  key_7: "7",
  key_8: "8",
  key_9: "9",
  key_0: "0",
  key_F1: "F1",
  key_F2: "F2",
  key_F3: "F3",
  key_F4: "F4",
  key_F5: "F5",
  key_F6: "F6",
  key_F7: "F7",
  key_F8: "F8",
  key_F9: "F9",
  key_F10: "F10",
  key_F11: "F11",
  key_F12: "F12",
  key_Q: "Q",
  key_W: "W",
  key_E: "E",
  key_R: "R",
  key_T: "T",
  key_Y: "Y",
  key_U: "U",
  key_I: "I",
  key_O: "O",
  key_P: "P",
  key_A: "A",
  key_S: "S",
  key_D: "D",
  key_F: "F",
  key_G: "G",
  key_H: "H",
  key_J: "J",
  key_K: "K",
  key_L: "L",
  key_Z: "Z",
  key_X: "X",
  key_C: "C",
  key_V: "V",
  key_B: "B",
  key_N: "N",
  key_M: "M"
};
let KeyBinderType = function (KeyBinderType) {
  KeyBinderType[KeyBinderType["Normal"] = 0] = "Normal";
  KeyBinderType[KeyBinderType["Ability"] = 1] = "Ability";
  KeyBinderType[KeyBinderType["Item"] = 2] = "Item";
  return KeyBinderType;
}({});
const EOM_KeyBinder = props => {
  const merged = libs.mergeProps$1({
    type: KeyBinderType.Normal,
    text: "",
    initKey: "",
    initDropIndex: 0
  }, props);
  const [local, others] = libs.splitProps(merged, ["children", "callback", "initKey", "initDropIndex", "text", "tooltip", "type"]);
  let panel;
  const initKey = () => local.initKey;
  const [keyName, setKeyName] = libs.createSignal(Key2Command[initKey()] ?? "");
  const dropIndex = () => local.initDropIndex;
  const OnActivate = self => {
    $.DispatchEvent("SetInputFocus", self);
  };
  const OnFocus = self => {
    SaveData(self, "keybind", keyName());
    setKeyName("");
    self.AddClass("selected");
    self.FindChildTraverse("BindingLabelContainer")?.SetHasClass("ActiveBindButton", self.BHasClass("selected"));
  };
  const OnBlur = self => {
    setKeyName(LoadData(self, "keybind"));
    self.RemoveClass("selected");
    self.FindChildTraverse("BindingLabelContainer")?.SetHasClass("ActiveBindButton", self.BHasClass("selected"));
  };
  const OnCancel = self => {
    $.DispatchEvent("DropInputFocus", self);
  };
  libs.createEffect(() => {
    if (panel && panel.IsValid()) {
      const current_initKey = initKey();
      setKeyName(Key2Command[current_initKey] ?? "");
      if (LoadData(panel, "keybind") != current_initKey && current_initKey != "") {
        local.callback(current_initKey, true, local.initDropIndex ? local.initDropIndex - 1 : 0);
      }
      SaveData(panel, "keybind", current_initKey);
    }
  });
  const OnLoad = self => {
    if (LoadData(self, "keybind") != initKey() && initKey() != "") {
      local.callback(initKey(), true, local.initDropIndex ? local.initDropIndex - 1 : 0);
    }
    SaveData(self, "keybind", initKey());
    for (const key in Key2Command) {
      let command = Key2Command[key];
      $.RegisterKeyBind(self, key, () => {
        if (self.IsValid()) {
          setKeyName(command);
          SaveData(self, "keybind", command);
          OnCancel(self);
          if (typeof local.text == "string") {
            local.callback(key, false, dropIndex());
          }
          if (Array.isArray(local.text)) {
            const childList = self.FindChildTraverse("title")?.Children();
            if (childList) {
              for (let index = 0; index < childList.length; index++) {
                const element = childList[index];
                if (element.IsValid() && element.visible && element.BHasClass("EOM_DropDownChild")) {
                  local.callback(key, false, index);
                }
              }
            }
          }
        }
      });
    }
  };
  const OnClear = self => {
    let pSelf = self.FindAncestor("LabelFXContainer")?.GetParent();
    if (pSelf) {
      SaveData(pSelf, "keybind", "");
      setKeyName("");
      local.callback("", false, dropIndex());
      OnCancel(pSelf);
    }
  };
  return libs.createComponent(EOM_Panel.EOM_Panel, libs.mergeProps({
    id: "EOM_KeyBinder",
    ref(r$) {
      const _ref$ = panel;
      typeof _ref$ === "function" ? _ref$(r$) : panel = r$;
    }
  }, () => EOM_Panel.EOMProps(others, {
    className: libs.classNames("SettingsKeyBinder", "BindingRow", {
      HeroAbilityBindAbilityButton: local.type == KeyBinderType.Ability,
      ItemBindButton: local.type == KeyBinderType.Item
    })
  }), {
    onactivate: self => OnActivate(self),
    onfocus: self => OnFocus(self),
    onblur: self => OnBlur(self),
    oncancel: self => OnCancel(self),
    onload: self => OnLoad(self),
    get tooltip() {
      return local.tooltip;
    },
    get children() {
      return [libs.createComponent(libs.Show, {
        get when() {
          return typeof local.text == "string";
        },
        get children() {
          return libs.createComponent(GenericPanel.CLabel, {
            id: "title",
            get text() {
              return local.text;
            },
            className: "BindingRowLabel",
            html: true
          });
        }
      }), (() => {
        const _el$ = libs.createElement("Panel", {
            id: "LabelFXContainer"
          }, null),
          _el$2 = libs.createElement("Panel", {
            id: "BindingLabelContainer"
          }, _el$),
          _el$3 = libs.createElement("Button", {}, _el$);
        libs.insert(_el$2, libs.createComponent(GenericPanel.CLabel, {
          id: "mod",
          text: "",
          className: "BindingRowButton"
        }), null);
        libs.insert(_el$2, libs.createComponent(GenericPanel.CLabel, {
          id: "dash",
          text: "-",
          className: "BindingRowButton"
        }), null);
        libs.insert(_el$2, libs.createComponent(GenericPanel.CLabel, {
          id: "value",
          get text() {
            return libs.memo(() => $.Localize("#" + keyName()) == "#" + keyName())() ? keyName() : "#" + keyName();
          },
          className: "BindingRowButton"
        }), null);
        libs.setProp(_el$3, "className", "ClearKeybinding");
        libs.setProp(_el$3, "onactivate", self => OnClear(self));
        return _el$;
      })()];
    }
  }));
};

function Setting() {
  const language = $.Language().toLowerCase();
  const localPlayerID = String(Players.GetLocalPlayer());
  const [show, setShow] = libs.createSignal(false);
  const [showScoreBoard, setShowScoreBoard] = libs.createSignal(false);
  const [playerData, setPlayerData] = libs.createSignal(CustomNetTables.GetTableValue("player_data", localPlayerID));
  const [showWheel] = libs.createSignal(false);
  const refreshShop = () => {
    clientSideEvent("listener_Hotkey", {
      event: "refresh_ability_shop"
    });
  };
  const randomShop = () => {
    clientSideEvent("listener_Hotkey", {
      event: "random_ability_shop"
    });
  };
  const lockShop = () => {
    clientSideEvent("listener_Hotkey", {
      event: "lock_ability_shop"
    });
  };
  const prepare = () => {
    clientSideEvent("listener_Hotkey", {
      event: "prepare_ready"
    });
  };
  const showScoreboard = () => {
    ToggleWindows("MenuButton_scoreboard", !showScoreBoard());
  };
  const toggleTalent = () => {
    clientSideEvent("listener_Hotkey", {
      event: "toggle_talent"
    });
  };
  const select1 = () => {
    clientSideEvent("listener_Hotkey", {
      event: "slot_1"
    });
  };
  const select2 = () => {
    clientSideEvent("listener_Hotkey", {
      event: "slot_2"
    });
  };
  const select3 = () => {
    clientSideEvent("listener_Hotkey", {
      event: "slot_3"
    });
  };
  const select4 = () => {
    clientSideEvent("listener_Hotkey", {
      event: "slot_4"
    });
  };
  const serviceConfig = () => playerData()?.service_config;
  const [initConfig, setInitConfig] = libs.createSignal(false);
  const [keyBinds, setKeyBinds] = libs.createStore({
    "toggle_shop": "",
    "refresh_shop": "",
    "random_shop": "",
    "lock": "",
    "prepare": "",
    "scoreboard": "",
    "toggle_talent": "",
    "shop_1": "",
    "shop_2": "",
    "shop_3": "",
    "shop_4": "",
    "team_portal": ""
  });
  libs.createEffect(libs.on(serviceConfig, service_config => {
    if (!initConfig() && service_config) {
      Object.keys(keyBinds).forEach((name, _) => {
        if (name != "" && (keyBinds[name] == undefined || keyBinds[name] == "") && service_config?.[name] != undefined) {
          setKeyBinds(name, service_config?.[name] ?? "");
          if (!initConfig()) {
            setInitConfig(true);
          }
        }
      });
    }
  }));
  let reconfiging = false;
  const reconfigKeyBind = () => {
    if (reconfiging) return;
    reconfiging = true;
    const cache = Object.assign({}, keyBinds);
    libs.batch(() => {
      Object.entries(cache).forEach(([key, value], _) => {
        setKeyBinds(key, "");
      });
    });
    $.Schedule(0.1, () => {
      libs.batch(() => {
        Object.entries(cache).forEach(([key, value], _) => {
          setKeyBinds(key, value);
        });
      });
      reconfiging = false;
    });
  };
  const useKeyBind = (event, key, callback, bInit = false) => {
    if (key === undefined || callback === undefined) return;
    const time = Math.floor(Game.Time());
    const command = `c4_keybind_setting_${time}`;
    if (!GameUI.CustomUIConfig().key_router) {
      GameUI.CustomUIConfig().key_router = {};
    }
    if (key == '' && !bInit) {
      const prekey = GameUI.CustomUIConfig().key_router[event][1];
      if (prekey) {
        Game.CreateCustomKeyBind(prekey.replace('key_', ''), ``);
      }
    } else {
      Game.CreateCustomKeyBind(key.replace('key_', ''), `${command} ${event}`);
    }
    setKeyBinds(event, key);
    GameUI.CustomUIConfig().key_router[event] = [callback, key];
    if (!GameUI.CustomUIConfig().key_router[command]) {
      GameUI.CustomUIConfig().key_router[command] = [true, ""];
      $.Schedule(0.1, () => {
        Game.AddCommand(command, (cmd, event) => {
          if (GameUI.CustomUIConfig().key_router[event]) GameUI.CustomUIConfig().key_router[event][0]();
        }, '', 67108864);
      });
    }
    if (!bInit) {
      GameEvents.SendCustomEventToServer("PlayerSetKeyBind", {
        event_name: event,
        key: key
      });
    }
  };
  libs.onMount(() => {
    let gameEventListeners = [];
    gameEventListeners.push(useToggleWindow('MenuButton_setting', show, setShow));
    gameEventListeners.push(GameEvents.Subscribe("custom_ui_toggle_windows", eventData => {
      if (eventData.state == 1 && eventData.window_name == "MenuButton_scoreboard") {
        setShowScoreBoard(true);
      } else {
        setShowScoreBoard(false);
      }
    }));
    const NetTableListenerIDs = [];
    NetTableListenerIDs.push(useNetTableKey("player_data", localPlayerID, data => {
      setPlayerData(data);
    }));
    let gameStateListenter = useNetTableKey("common", "game_state", data => {
      if (data.state == "GameState_HeroShow") {
        reconfigKeyBind();
        CustomNetTables.UnsubscribeNetTableListener(gameStateListenter);
        gameStateListenter = -1;
      }
    });
    libs.onCleanup(() => {
      gameEventListeners.forEach(id => GameEvents.Unsubscribe(id));
      NetTableListenerIDs.forEach(id => CustomNetTables.UnsubscribeNetTableListener(id));
      if (gameStateListenter != -1) {
        CustomNetTables.UnsubscribeNetTableListener(gameStateListenter);
      }
    });
  });
  return libs.createComponent(EOM_Popup.EOM_Popup, {
    id: "Setting",
    title: "#Setting",
    size: "large",
    get className() {
      return libs.classNames({
        EOM_PopupMainShow: show()
      });
    },
    align: "center center",
    onClose: () => ToggleWindows('MenuButton_setting', false),
    get children() {
      return libs.createComponent(EOM_Panel.EOM_Panel, {
        get className() {
          return libs.classNames('EOM_PopupContent', {
            ShowWheel: showWheel()
          });
        },
        flowChildren: "none",
        width: "100%",
        height: "100%",
        margin: "20px",
        get children() {
          return libs.createComponent(EOM_Panel.EOM_Panel, {
            id: "Normal",
            width: "100%",
            height: "100%",
            get children() {
              return [(() => {
                const _el$ = libs.createElement("Panel", {
                    id: "LeftContainer"
                  }, null),
                  _el$2 = libs.createElement("Panel", {}, _el$),
                  _el$3 = libs.createElement("Panel", {}, _el$);
                libs.setProp(_el$2, "className", "TitleRow");
                libs.insert(_el$2, libs.createComponent(GenericPanel.CLabel, {
                  style: {
                    align: "left bottom"
                  },
                  text: "#dota_settings_hotkeys",
                  className: "SectionHeader"
                }), null);
                libs.insert(_el$2, libs.createComponent(EOM_Panel.EOM_Panel, {
                  className: "ReconfigKeyBindContainer",
                  get children() {
                    return [libs.createComponent(GenericPanel.CLabel, {
                      text: "#Setting_KeyBindWarning"
                    }), libs.createComponent(EOM_Button.EOM_BaseButton, {
                      id: "ReconfigKeyBind",
                      onactivate: () => reconfigKeyBind(),
                      tooltip: "#Setting_ReconfigKeyBind",
                      get children() {
                        return libs.createComponent(EOM_Icon.EOM_Icon, {
                          size: '24',
                          get src() {
                            return getSrcPath("icon/icon_refresh.png");
                          }
                        });
                      }
                    })];
                  }
                }), null);
                libs.setProp(_el$3, "className", "SectionHeaderLine");
                libs.insert(_el$, libs.createComponent(EOM_KeyBinder, {
                  get initKey() {
                    return keyBinds['toggle_shop'];
                  },
                  text: "#DOTA_Shop",
                  callback: (key, bInit) => {
                    useKeyBind('toggle_shop', key, () => {
                      clientSideEvent('toggle_shop', {});
                    }, bInit);
                  }
                }), null);
                libs.insert(_el$, libs.createComponent(EOM_KeyBinder, {
                  get initKey() {
                    return keyBinds['refresh_shop'];
                  },
                  text: "#Refresh",
                  tooltip: "#Refresh_Description",
                  callback: (key, bInit) => {
                    useKeyBind('refresh_shop', key, refreshShop, bInit);
                  }
                }), null);
                libs.insert(_el$, libs.createComponent(EOM_KeyBinder, {
                  get initKey() {
                    return keyBinds['random_shop'];
                  },
                  text: "#Random",
                  tooltip: "#Tooltip_AbilityShop_Random",
                  callback: (key, bInit) => {
                    useKeyBind('random_shop', key, randomShop, bInit);
                  }
                }), null);
                libs.insert(_el$, libs.createComponent(EOM_KeyBinder, {
                  get initKey() {
                    return keyBinds['lock'];
                  },
                  text: "#Lock",
                  tooltip: "#LockTooltip",
                  callback: (key, bInit) => {
                    useKeyBind('lock', key, lockShop, bInit);
                  }
                }), null);
                libs.insert(_el$, libs.createComponent(EOM_KeyBinder, {
                  get initKey() {
                    return keyBinds['prepare'];
                  },
                  text: "#Setting_PrepareReady",
                  callback: (key, bInit) => {
                    useKeyBind('prepare', key, prepare, bInit);
                  }
                }), null);
                libs.insert(_el$, libs.createComponent(EOM_KeyBinder, {
                  get initKey() {
                    return keyBinds['scoreboard'];
                  },
                  text: "#MenuButton_scoreboard",
                  callback: (key, bInit) => {
                    useKeyBind('scoreboard', key, showScoreboard, bInit);
                  }
                }), null);
                libs.insert(_el$, libs.createComponent(EOM_KeyBinder, {
                  get initKey() {
                    return keyBinds['toggle_talent'];
                  },
                  text: "#MenuButton_toggle_talent",
                  callback: (key, bInit) => {
                    useKeyBind('toggle_talent', key, toggleTalent, bInit);
                  }
                }), null);
                libs.insert(_el$, libs.createComponent(EOM_KeyBinder, {
                  get initKey() {
                    return keyBinds['shop_1'];
                  },
                  text: "#MenuButton_shop_1",
                  callback: (key, bInit) => {
                    useKeyBind('shop_1', key, select1, bInit);
                  }
                }), null);
                libs.insert(_el$, libs.createComponent(EOM_KeyBinder, {
                  get initKey() {
                    return keyBinds['shop_2'];
                  },
                  text: "#MenuButton_shop_2",
                  callback: (key, bInit) => {
                    useKeyBind('shop_2', key, select2, bInit);
                  }
                }), null);
                libs.insert(_el$, libs.createComponent(EOM_KeyBinder, {
                  get initKey() {
                    return keyBinds['shop_3'];
                  },
                  text: "#MenuButton_shop_3",
                  callback: (key, bInit) => {
                    useKeyBind('shop_3', key, select3, bInit);
                  }
                }), null);
                libs.insert(_el$, libs.createComponent(libs.Show, {
                  get when() {
                    return getGameplayModuleState("card_effect");
                  },
                  get children() {
                    return libs.createComponent(EOM_KeyBinder, {
                      get initKey() {
                        return keyBinds['shop_4'];
                      },
                      text: "#MenuButton_shop_4",
                      callback: (key, bInit) => {
                        useKeyBind('shop_4', key, select4, bInit);
                      }
                    });
                  }
                }), null);
                libs.insert(_el$, libs.createComponent(libs.Show, {
                  get when() {
                    return isGroupMode();
                  },
                  get children() {
                    return libs.createComponent(EOM_KeyBinder, {
                      get initKey() {
                        return keyBinds['team_portal'];
                      },
                      text: "#TeamBlessPortal_Keybinder",
                      callback: (key, bInit) => {
                        useKeyBind('team_portal', key, () => {
                          clientSideEvent("listener_Hotkey", {
                            event: "team_portal"
                          });
                        }, bInit);
                      }
                    });
                  }
                }), null);
                return _el$;
              })(), (() => {
                const _el$4 = libs.createElement("Panel", {
                    id: "CenterContainer"
                  }, null),
                  _el$5 = libs.createElement("Panel", {}, _el$4),
                  _el$6 = libs.createElement("Panel", {}, _el$4);
                libs.setProp(_el$5, "className", "TitleRow");
                libs.insert(_el$5, libs.createComponent(GenericPanel.CLabel, {
                  style: {
                    align: "left bottom"
                  },
                  text: "#game_setting",
                  className: "SectionHeader"
                }));
                libs.setProp(_el$6, "className", "SectionHeaderLine");
                libs.insert(_el$4, libs.createComponent(SettingMultiRadioButton, {
                  text: "#MenuButton_camera_move",
                  setting_name: "camera_move",
                  get serviceConfig() {
                    return serviceConfig();
                  },
                  settingList: ["camera_move_mode_0", "camera_move_mode_1", "camera_move_mode_2"],
                  selected: 1,
                  OnSelect: i => {
                    clientSideEvent("camera_move", {
                      type: i.toString()
                    });
                  }
                }), null);
                libs.insert(_el$4, libs.createComponent(SettingToggleButton, {
                  setting_name: "rookie",
                  get serviceConfig() {
                    return serviceConfig();
                  },
                  defaultOn: true
                }), null);
                libs.insert(_el$4, libs.createComponent(SettingToggleButton, {
                  setting_name: "hero_show_hidden",
                  get serviceConfig() {
                    return serviceConfig();
                  },
                  defaultOn: false
                }), null);
                libs.insert(_el$4, libs.createComponent(SettingToggleButton, {
                  setting_name: "close_chat",
                  get serviceConfig() {
                    return serviceConfig();
                  },
                  defaultOn: false
                }), null);
                return _el$4;
              })(), (() => {
                const _el$7 = libs.createElement("Panel", {
                    id: "RightContainer"
                  }, null),
                  _el$8 = libs.createElement("Panel", {}, _el$7),
                  _el$9 = libs.createElement("Panel", {}, _el$7);
                libs.setProp(_el$8, "className", "TitleRow");
                libs.insert(_el$8, libs.createComponent(GenericPanel.CLabel, {
                  style: {
                    align: "left bottom"
                  },
                  text: "#dota_settings_community",
                  className: "SectionHeader"
                }));
                libs.setProp(_el$9, "className", "SectionHeaderLine");
                libs.insert(_el$7, libs.createComponent(libs.Switch, {
                  get fallback() {
                    return libs.createComponent(EnglishCommunity, {});
                  },
                  get children() {
                    return libs.createComponent(libs.Match, {
                      when: language == "schinese",
                      get children() {
                        return libs.createComponent(SchineseCommunity, {});
                      }
                    });
                  }
                }), null);
                return _el$7;
              })()];
            }
          });
        }
      });
    }
  });
}
const SettingToggleButton = props => {
  const [selected, setSelected] = libs.createSignal(props.defaultOn == true);
  let inited = false;
  libs.createEffect(() => {
    if (!inited && props.serviceConfig) {
      if (props.serviceConfig[props.setting_name]) {
        inited = true;
        setSelected(props.serviceConfig[props.setting_name] == "1");
      }
    }
  });
  return (() => {
    const _el$0 = libs.createElement("Button", {}, null),
      _el$1 = libs.createElement("Panel", {}, _el$0);
    libs.setProp(_el$0, "onactivate", self => {
      GameEvents.SendCustomEventToServer("PlayerSettingToggleBoolean", {
        setting_name: props.setting_name,
        value: selected() ? "0" : "1"
      });
      inited = true;
      setSelected(v => !v);
    });
    libs.setProp(_el$1, "className", 'TickBox');
    libs.insert(_el$0, libs.createComponent(GenericPanel.CLabel, {
      get text() {
        return `#MenuButton_${props.setting_name}`;
      }
    }), null);
    libs.effect(_$p => libs.setProp(_el$0, "className", libs.classNames("ToggleButton SettingToggleButton", {
      selected: selected()
    }), _$p));
    return _el$0;
  })();
};
const SettingMultiRadioButton = props => {
  const [selected, setSelected] = libs.createSignal(props.selected ?? 0);
  const settingConfig = () => {
    return finiteNumber(Number(props.serviceConfig?.[props.setting_name]), props.selected ?? 0);
  };
  let inited = false;
  libs.createEffect(() => {
    if (!inited && props.serviceConfig) {
      if (props.serviceConfig[props.setting_name]) {
        inited = true;
        setSelected(settingConfig());
      }
    }
  });
  return libs.createComponent(EOM_Panel.EOM_Panel, {
    className: "SettingMultiRadioButton",
    get children() {
      return [libs.createComponent(GenericPanel.CLabel, {
        id: "title",
        get text() {
          return props.text;
        }
      }), libs.createComponent(EOM_Panel.EOM_Panel, {
        style: {
          width: "50%"
        },
        flowChildren: "down",
        get children() {
          return libs.createComponent(libs.Index, {
            get each() {
              return props.settingList;
            },
            children: (settingText, i) => {
              return libs.createComponent(EOM_Button.EOM_BaseButton, {
                get className() {
                  return libs.classNames("SettingRadioButton", {
                    Selected: selected() == i
                  });
                },
                onactivate: () => {
                  if (selected() == i && settingConfig() == selected()) return;
                  setSelected(i);
                  GameEvents.SendCustomEventToServer("PlayerSettingToggleBoolean", {
                    setting_name: props.setting_name,
                    value: i.toString()
                  });
                  if (props.OnSelect) {
                    props.OnSelect(i);
                  }
                },
                get children() {
                  return [libs.createComponent(EOM_Panel.EOM_Panel, {
                    id: "RadioButtonBox"
                  }), libs.createComponent(GenericPanel.CLabel, {
                    get text() {
                      return `#${settingText()}`;
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
};
function SchineseCommunity() {
  const jumpToQQGroup = i => {
    const text = $.Localize("#ContactUSInfoQQ" + i + "_address");
    if (text != "#ContactUSInfoQQ" + i + "_address") {
      $.DispatchEvent("ExternalBrowserGoToURL", text);
    }
  };
  return libs.createComponent(EOM_Panel.EOM_Panel, {
    id: "SchineseCommunity",
    width: "100%",
    height: "100%",
    flowChildren: "down",
    padding: "0px 20px",
    get children() {
      return [libs.createComponent(EOM_Panel.EOM_Panel, {
        horizontalAlign: "center",
        flowChildren: "right",
        marginBottom: "20px",
        get children() {
          return [libs.createComponent(EOM_Panel.EOM_Panel, {
            flowChildren: "down",
            marginRight: "10px",
            onactivate: () => jumpToQQGroup(1),
            get children() {
              return [libs.createElement("Image", {
                id: "QQGroup"
              }, null), libs.createComponent(EOM_Button.EOM_BaseButton, {
                get children() {
                  return libs.createComponent(EOM_Label.EOM_Label, {
                    horizontalAlign: "center",
                    marginTop: "5px",
                    fontSize: "18px",
                    color: "#fff",
                    textDecoration: "underline",
                    text: "#ContactUSInfoQQ1"
                  });
                }
              })];
            }
          }), libs.createComponent(EOM_Panel.EOM_Panel, {
            flowChildren: "down",
            get children() {
              return [libs.createElement("Image", {
                id: "QQChannel"
              }, null), libs.createComponent(EOM_Button.EOM_BaseButton, {
                onactivate: () => jumpToQQGroup(2),
                get children() {
                  return libs.createComponent(EOM_Label.EOM_Label, {
                    horizontalAlign: "center",
                    marginTop: "5px",
                    fontSize: "18px",
                    color: "#fff",
                    textDecoration: "underline",
                    text: "#ContactUSInfoQQ2"
                  });
                }
              })];
            }
          })];
        }
      }), libs.createComponent(GenericPanel.CLabel, {
        className: "CommunityTitle",
        text: "#community_bilibili_title"
      }), libs.createComponent(EOM_Button.EOM_BaseButton, {
        flowChildren: "right",
        horizontalAlign: "center",
        marginTop: "5px",
        onactivate: () => {
          $.DispatchEvent("ExternalBrowserGoToURL", "https://space.bilibili.com/3546640503802196");
        },
        get children() {
          return [libs.createElement("Image", {
            id: "Bilibili"
          }, null), libs.createComponent(EOM_Label.EOM_Label, {
            marginLeft: "10px",
            verticalAlign: "center",
            fontSize: "18px",
            color: "#fff",
            textDecoration: "underline",
            text: "#community_bilibili"
          })];
        }
      }), libs.createComponent(EOM_Panel.EOM_Panel, {
        height: "10px"
      }), libs.createComponent(GenericPanel.CLabel, {
        className: "CommunityTitle",
        text: "#community_weixin_title"
      }), libs.createElement("Image", {
        id: "Weixin"
      }, null), libs.createComponent(GenericPanel.CLabel, {
        id: "WeixinLabel",
        text: "#community_weixin"
      })];
    }
  });
}
function EnglishCommunity() {
  return libs.createComponent(EOM_Panel.EOM_Panel, {
    id: "SchineseCommunity",
    width: "100%",
    height: "100%",
    flowChildren: "down",
    padding: "0px 20px",
    get children() {
      return [libs.createComponent(GenericPanel.CLabel, {
        className: "CommunityTitle",
        text: "#community_discord_title"
      }), libs.createElement("Image", {
        id: "DiscordCode"
      }, null), libs.createComponent(EOM_Button.EOM_BaseButton, {
        flowChildren: "right",
        horizontalAlign: "center",
        marginTop: "5px",
        marginBottom: "20px",
        onactivate: () => {
          $.DispatchEvent("ExternalBrowserGoToURL", "https://discord.com/channels/1060397599380734002/1203688383298150460");
        },
        get children() {
          return [libs.createElement("Image", {
            id: "Discord"
          }, null), libs.createComponent(EOM_Label.EOM_Label, {
            marginLeft: "10px",
            verticalAlign: "center",
            fontSize: "18px",
            color: "#fff",
            textDecoration: "underline",
            text: "#community_discord"
          })];
        }
      })];
    }
  });
}
libs.render(() => libs.createComponent(Setting, {}), $.GetContextPanel());