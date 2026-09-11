--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 5e0d361 
  ~ auto-generated — do not edit
]]


'use strict'; const exports = {}; GameUI.__loadModule('EOM_DebugTool', exports); const require = GameUI.__require;

var libs = require('./libs.js');
var solid_utils = require('./solid_utils.js');
var EOM_Icon = require('./EOM_Icon.js');
var EOM_Button = require('./EOM_Button.js');
var EOM_DropDown = require('./EOM_DropDown.js');
var EOM_Breadcrumb = require('./EOM_Breadcrumb.js');

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
  const merged = libs.mergeProps({
    type: KeyBinderType.Normal,
    text: "",
    initKey: "",
    initDropIndex: 0
  }, props, {
    class: libs.classNames("SettingsKeyBinder", "BindingRow", {
      HeroAbilityBindAbilityButton: props.type == KeyBinderType.Ability,
      ItemBindButton: props.type == KeyBinderType.Item
    })
  });
  const [local, others] = libs.splitProps(merged, ["callback", "onChange", "initKey", "initDropIndex", "text", "tooltip", "type"]);
  let panel;
  let eventKey;
  const [keyName, setKeyName] = libs.createSignal(local.initKey ?? "");
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
      const current_initKey = local.initKey;
      setKeyName(current_initKey ?? "");
      if (LoadData(panel, "keybind") != current_initKey && current_initKey != "") {
        local.onChange?.(current_initKey, true, local.initDropIndex ? local.initDropIndex - 1 : 0);
        RegisterKeyEvent(current_initKey, local.callback);
      }
      SaveData(panel, "keybind", current_initKey);
    }
  });
  const OnLoad = self => {
    if (LoadData(self, "keybind") != local.initKey && local.initKey != "") {
      local.onChange?.(local.initKey, true, local.initDropIndex ? local.initDropIndex - 1 : 0);
      if (eventKey) UnregisterKeyEvent(eventKey);
      eventKey = RegisterKeyEvent(local.initKey, local.callback);
    }
    SaveData(self, "keybind", local.initKey);
    for (const key in Key2Command) {
      let command = Key2Command[key];
      $.RegisterKeyBind(self, key, () => {
        if (self.IsValid()) {
          setKeyName(command);
          SaveData(self, "keybind", command);
          OnCancel(self);
          if (typeof local.text == "string") {
            local.onChange?.(command, false, dropIndex());
            if (eventKey) UnregisterKeyEvent(eventKey);
            eventKey = RegisterKeyEvent(command, local.callback);
          }
          if (Array.isArray(local.text)) {
            const childList = self.FindChildTraverse("title")?.Children();
            if (childList) {
              for (let index = 0; index < childList.length; index++) {
                const element = childList[index];
                if (element.IsValid() && element.visible && element.BHasClass("EOM_DropDownChild")) {
                  local.onChange?.(command, false, index);
                  if (eventKey) UnregisterKeyEvent(eventKey);
                  eventKey = RegisterKeyEvent(command, local.callback);
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
      if (eventKey) UnregisterKeyEvent(eventKey);
      local.onChange?.("", false, dropIndex());
      OnCancel(pSelf);
    }
  };
  return (() => {
    const _el$ = libs.createElement("Panel", libs.mergeProps$1({
        id: "EOM_KeyBinder"
      }, others), null),
      _el$3 = libs.createElement("Panel", {
        id: "LabelFXContainer"
      }, _el$),
      _el$4 = libs.createElement("Panel", {
        id: "BindingLabelContainer"
      }, _el$3);
      libs.createElement("Label", {
        id: "mod",
        text: "",
        "class": "BindingRowButton"
      }, _el$4);
      libs.createElement("Label", {
        id: "dash",
        text: "-",
        "class": "BindingRowButton"
      }, _el$4);
      const _el$7 = libs.createElement("Label", {
        id: "value",
        get text() {
          return libs.memo(() => GetLocalization("#" + keyName()) == "#" + keyName())() ? keyName() : "#" + keyName();
        },
        "class": "BindingRowButton"
      }, _el$4),
      _el$8 = libs.createElement("Button", {
        "class": "ClearKeybinding"
      }, _el$3);
    const _ref$ = panel;
    typeof _ref$ === "function" ? libs.use(_ref$, _el$) : panel = _el$;
    libs.setProp(_el$, "onactivate", self => OnActivate(self));
    libs.setProp(_el$, "onfocus", self => OnFocus(self));
    libs.setProp(_el$, "onblur", self => OnBlur(self));
    libs.setProp(_el$, "oncancel", self => OnCancel(self));
    libs.setProp(_el$, "onload", self => OnLoad(self));
    libs.spread(_el$, libs.mergeProps$1({
      get tooltip() {
        return local.tooltip;
      }
    }, others), true);
    libs.insert(_el$, libs.createComponent(libs.Show, {
      get when() {
        return typeof local.text == "string";
      },
      get children() {
        const _el$2 = libs.createElement("Label", {
          id: "title",
          get text() {
            return local.text;
          },
          "class": "BindingRowLabel",
          html: true
        }, null);
        libs.effect(_$p => libs.setProp(_el$2, "text", local.text, _$p));
        return _el$2;
      }
    }), _el$3);
    libs.setProp(_el$8, "onactivate", self => OnClear(self));
    libs.effect(_$p => libs.setProp(_el$7, "text", libs.memo(() => GetLocalization("#" + keyName()) == "#" + keyName())() ? keyName() : "#" + keyName(), _$p));
    return _el$;
  })();
};

const player_key_values = solid_utils.createServiceNetData("player_key_values", {});
const GetPlayerConfig = (key, defaultValue) => {
  return player_key_values()[key] != undefined ? player_key_values()[key].value : defaultValue;
};
const EOM_DebugTool = props => {
  const [minimized, setMinimized] = libs.createSignal(true);
  const [manualShowPanel, setManualShowPanel] = libs.createSignal(false);
  const [direction, setDirection] = libs.createSignal(props.direction);
  const [tabIndex, setTabIndex] = libs.createSignal(0);
  const Update = () => {
    if (!manualShowPanel()) {
      if (minimized() == GameUI.IsAltDown() && GetPlayerConfig("alt_tool", true)) {
        setMinimized(!GameUI.IsAltDown());
      }
    } else {
      if (GameUI.IsAltDown() && GetPlayerConfig("alt_tool", true)) {
        setManualShowPanel(false);
      }
    }
  };
  const timer = setInterval(Update, Game.GetGameFrameTime());
  libs.onCleanup(() => clearInterval(timer));
  return (() => {
    const _el$ = libs.createElement("Panel", {
        id: "EOM_DebugTool",
        hittest: false
      }, null),
      _el$2 = libs.createElement("Panel", {
        id: "EOM_DebugToolControlPanel",
        get ["class"]() {
          return libs.classNames("ControlPanel", {
            Minimized: minimized(),
            DirectionLeft: direction() == "left",
            DirectionRight: direction() == "right"
          });
        },
        hittest: false
      }, _el$),
      _el$3 = libs.createElement("Panel", {
        get ["class"]() {
          return "ControlPanelContainer TabShow" + tabIndex();
        }
      }, _el$2),
      _el$4 = libs.createElement("Panel", {
        "class": "ControlPanelTitle"
      }, _el$3);
      libs.createElement("Panel", {
        "class": "CategoryHeaderFilledFront"
      }, _el$4);
      const _el$6 = libs.createElement("Panel", {
        "class": "CategoryHeaderFilledNext"
      }, _el$4),
      _el$9 = libs.createElement("Panel", {
        id: "ExpandButtonContainer",
        verticalAlign: "center"
      }, _el$2),
      _el$0 = libs.createElement("Button", {
        id: "ExpandButton"
      }, _el$9);
    libs.insert(_el$, () => props.containerElement, _el$2);
    libs.insert(_el$, libs.createComponent(EOM_DebugTool_Setting, {}), _el$2);
    libs.insert(_el$4, libs.createComponent(libs.Switch, {
      get fallback() {
        return (() => {
          const _el$1 = libs.createElement("Label", {
            "class": "CategoryHeader",
            text: `工具`
          }, null);
          libs.setProp(_el$1, "text", `工具`);
          return _el$1;
        })();
      },
      get children() {
        return libs.createComponent(libs.Match, {
          get when() {
            return props.tabList != undefined && props.tabList.length > 0;
          },
          get children() {
            return libs.createComponent(EOM_Breadcrumb.EOM_Breadcrumb, {
              "class": "CategoryHeader",
              get list() {
                return props.tabList;
              },
              onChange: (index, text) => setTabIndex(index)
            });
          }
        });
      }
    }), _el$6);
    libs.insert(_el$4, libs.createComponent(EOM_Button.EOM_IconButton, {
      "class": "CategoryHeaderIcon",
      tooltip: "切换布局",
      verticalAlign: "center",
      get icon() {
        return libs.createComponent(EOM_Icon.EOM_Icon, {
          type: "Popout",
          size: "24"
        });
      },
      get children() {
        return libs.createComponent(EOM_DropDown.EOM_DropDown, {
          id: "ToggleSize",
          width: "100px",
          onChange: (index, item) => {
            const nextDirection = item.id == "right" ? "right" : "left";
            setDirection(nextDirection);
            SaveConfig("direction", nextDirection);
          },
          get children() {
            return [libs.createElement("Label", {
              text: "左侧",
              id: "left"
            }, null), libs.createElement("Label", {
              text: "右侧",
              id: "right"
            }, null)];
          }
        });
      }
    }), null);
    libs.insert(_el$4, libs.createComponent(EOM_Button.EOM_IconButton, {
      "class": "CategoryHeaderIcon",
      tooltip: "重载数据",
      verticalAlign: "center",
      get icon() {
        return libs.createComponent(EOM_Icon.EOM_Icon, {
          type: "Refresh",
          size: "24"
        });
      },
      onactivate: () => {
        GameEvents.SendEventClientSide("client_side_event", {
          event_name: "RefreshDebugToolData",
          event_data: JSON.stringify({})
        });
      }
    }), null);
    libs.insert(_el$4, libs.createComponent(EOM_Button.EOM_IconButton, {
      "class": "CategoryHeaderIcon",
      tooltip: "设置",
      verticalAlign: "center",
      get icon() {
        return libs.createComponent(EOM_Icon.EOM_Icon, {
          type: "Gear",
          size: "24",
          onactivate: () => ToggleSelection("EOM_DebugTool_Setting")
        });
      }
    }), null);
    libs.insert(_el$3, () => props.children, null);
    libs.setProp(_el$9, "verticalAlign", "center");
    libs.setProp(_el$0, "onactivate", () => {
      setManualShowPanel(minimized());
      setMinimized(!minimized());
    });
    libs.insert(_el$0, libs.createComponent(EOM_Icon.EOM_Icon, {
      type: "ArrowRight",
      width: "8px",
      height: "14px",
      align: "center center",
      get preTransformRotate2d() {
        return (minimized() ? 0 : 180) + "deg";
      }
    }));
    libs.effect(_p$ => {
      const _v$ = libs.classNames("ControlPanel", {
          Minimized: minimized(),
          DirectionLeft: direction() == "left",
          DirectionRight: direction() == "right"
        }),
        _v$2 = "ControlPanelContainer TabShow" + tabIndex();
      _v$ !== _p$._v$ && (_p$._v$ = libs.setProp(_el$2, "class", _v$, _p$._v$));
      _v$2 !== _p$._v$2 && (_p$._v$2 = libs.setProp(_el$3, "class", _v$2, _p$._v$2));
      return _p$;
    }, {
      _v$: undefined,
      _v$2: undefined
    });
    return _el$;
  })();
};
function EOM_DebugTool_Setting() {
  const [deleteMode, setDeleteMode] = libs.createSignal(false);
  const [customKeyBindCount, setCustomKeyBindCount] = libs.createSignal(0);
  const [eventNameList, setEventNameList] = libs.createSignal([]);
  const [buttonTextList, setButtonTextList] = libs.createSignal([]);
  const [buttonTypeList, setButtonTypeList] = libs.createSignal([]);
  const RegisterDemoButton = (key, eventName, bInit) => {
    return;
  };
  const findHotKeyValidButton = self => {
    const root = self.FindAncestor("EOM_DebugTool");
    let eventList = [];
    let textList = [];
    let typeList = [];
    if (root) {
      const demoButtonList = root.FindChildrenWithClassTraverse("HotKeyValid");
      demoButtonList.map(element => {
        eventList.push(element.id);
        textList.push(element.text);
        typeList.push((() => {
          let result = "";
          if (element.BHasClass("FireEvent")) {
            result = "FireEvent";
          } else if (element.BHasClass("ToggleSelection")) {
            result = "ToggleSelection";
          }
          return result;
        })());
      });
      setEventNameList(eventList);
      setButtonTextList(textList);
      setButtonTypeList(typeList);
    }
  };
  const OnLoad = self => {
    findHotKeyValidButton(self);
  };
  return libs.createComponent(SelectionContainer, {
    eventName: "EOM_DebugTool_Setting",
    title: "调试工具设置",
    width: "500px",
    height: "700px",
    hasRawMode: false,
    hasToggleSize: false,
    hasFilter: false,
    get children() {
      const _el$10 = libs.createElement("Panel", {
          id: "EOM_DebugTool_Setting",
          "class": "EOM_DebugTool_Setting",
          flowChildren: "down",
          width: "100%",
          height: "100%"
        }, null),
        _el$11 = libs.createElement("Panel", {
          flowChildren: "down",
          width: "100%",
          marginTop: "12px"
        }, _el$10),
        _el$12 = libs.createElement("ToggleButton", {
          "class": "HotKeyValid FireEvent",
          get selected() {
            return GetPlayerConfig("alt_tool", true);
          },
          text: "ALT切换调试工具"
        }, _el$11);
      libs.setProp(_el$10, "flowChildren", "down");
      libs.setProp(_el$10, "width", "100%");
      libs.setProp(_el$10, "height", "100%");
      libs.setProp(_el$11, "flowChildren", "down");
      libs.setProp(_el$11, "width", "100%");
      libs.setProp(_el$11, "marginTop", "12px");
      libs.setProp(_el$11, "onload", self => OnLoad(self));
      libs.setProp(_el$12, "onactivate", self => {
        SaveConfig("alt_tool", self.IsSelected());
      });
      libs.insert(_el$11, () => [...Array(customKeyBindCount)].map((_, index) => {
        if (buttonTextList.length > 0) {
          return (() => {
            const _el$13 = libs.createElement("Panel", {
              width: "100%",
              height: "36px",
              flowChildren: "right",
              get ["class"]() {
                return libs.classNames("CanRemoveKeyBind", {
                  deleteMode: deleteMode
                });
              }
            }, null);
            libs.setProp(_el$13, "width", "100%");
            libs.setProp(_el$13, "height", "36px");
            libs.setProp(_el$13, "flowChildren", "right");
            libs.insert(_el$13, libs.createComponent(EOM_Button.EOM_IconButton, {
              verticalAlign: "center",
              get icon() {
                return libs.createElement("Image", {
                  src: "s2r://panorama/images/control_icons/x_close_png.vtex"
                }, null);
              },
              onactivate: self => setCustomKeyBindCount(customKeyBindCount() - 1)
            }), null);
            libs.insert(_el$13, libs.createComponent(EOM_KeyBinder, {
              get text() {
                return buttonTextList();
              },
              onChange: (key, bInit, dropIndex) => {
                if (eventNameList()[dropIndex]) {
                  if (key && key != "") {
                    RegisterDemoButton(key, "hotkey_" + eventNameList()[dropIndex]);
                  }
                }
              },
              callback: () => {}
            }), null);
            libs.effect(_$p => libs.setProp(_el$13, "class", libs.classNames("CanRemoveKeyBind", {
              deleteMode: deleteMode
            }), _$p));
            return _el$13;
          })();
        }
      }), null);
      libs.effect(_$p => libs.setProp(_el$12, "selected", GetPlayerConfig("alt_tool", true), _$p));
      return _el$10;
    }
  });
}
function EOM_DebugTool_Category(props) {
  const col = () => props.col ?? 2;
  const childs = libs.children(() => props.children).toArray();
  return (() => {
    const _el$19 = libs.createElement("Panel", {
        get ["class"]() {
          return libs.classNames("Category", "TabIndex" + (props.tabIndex ?? ""), {
            SingleCol: col() <= 1
          });
        }
      }, null),
      _el$20 = libs.createElement("Panel", {
        "class": "CategoryHeader"
      }, _el$19),
      _el$21 = libs.createElement("Label", {
        "class": "CategoryHeaderLabel",
        get text() {
          return props.title;
        }
      }, _el$20),
      _el$22 = libs.createElement("Panel", {
        width: "fill-parent-flow(1)"
      }, _el$20),
      _el$23 = libs.createElement("Panel", {
        "class": "CategoryButtonContainer"
      }, _el$19);
    libs.setProp(_el$22, "width", "fill-parent-flow(1)");
    libs.insert(_el$23, libs.createComponent(libs.Show, {
      get when() {
        return !(props.layout ?? false);
      },
      get fallback() {
        return props.children;
      },
      get children() {
        return libs.createComponent(libs.For, {
          get each() {
            return Array.from({
              length: Math.ceil(childs.length / col())
            });
          },
          children: (child, rowIndex) => (() => {
            const _el$24 = libs.createElement("Panel", {
              "class": "Row"
            }, null);
            libs.insert(_el$24, libs.createComponent(libs.For, {
              get each() {
                return Array.from({
                  length: col()
                });
              },
              children: (_, idx) => {
                let childIndex = rowIndex() * col() + idx();
                return childs[childIndex];
              }
            }));
            return _el$24;
          })()
        });
      }
    }));
    libs.effect(_p$ => {
      const _v$5 = libs.classNames("Category", "TabIndex" + (props.tabIndex ?? ""), {
          SingleCol: col() <= 1
        }),
        _v$6 = props.title;
      _v$5 !== _p$._v$5 && (_p$._v$5 = libs.setProp(_el$19, "class", _v$5, _p$._v$5));
      _v$6 !== _p$._v$6 && (_p$._v$6 = libs.setProp(_el$21, "text", _v$6, _p$._v$6));
      return _p$;
    }, {
      _v$5: undefined,
      _v$6: undefined
    });
    return _el$19;
  })();
}
function FireEvent(sEventName, str = "", extraParams) {
  if (!(Players.GetLocalPlayer() == -1 || Players.IsSpectator(Players.GetLocalPlayer()) || Players.IsLocalPlayerLiveSpectating())) {
    const params = {
      event_name: sEventName,
      player_id: Players.GetLocalPlayer(),
      unit: Players.GetLocalPlayerPortraitUnit(),
      position: GameUI.GetCameraLookAtPosition(),
      str: str
    };
    if (extraParams) {
      Object.entries(extraParams).forEach(([key, value]) => {
        params[key] = value;
      });
    }
    GameEvents.SendCustomEventToServer("DemoEvent", params);
  }
}
function SaveConfig(key, value) {
  if (value == true) {
    value = "TRUE";
  }
  if (value == false) {
    value = "FALSE";
  }
  CallAction("/v1/key/save", {
    type: "tool_settings",
    key,
    value: String(value)
  });
}
function ToggleSelection(sPickerName) {
  let aPickerList = $.GetContextPanel().FindChildrenWithClassTraverse("SelectionContainer");
  if (aPickerList !== null) {
    for (const iterator of aPickerList) {
      if (iterator.id == sPickerName) {
        iterator.ToggleClass("Show");
      } else if (iterator.BHasClass("LockWindow") == false) {
        iterator.SetHasClass("Show", false);
      }
    }
  }
}
const DemoButton = props => {
  const onactivate = props.onactivate ?? (() => FireEvent(props.eventName, props.str));
  return (() => {
    const _el$25 = libs.createElement("TextButton", {
      get id() {
        return props.eventName;
      },
      get ["class"]() {
        return libs.classNames("DemoButton", "HotKeyValid", "FireEvent", props.color);
      },
      get text() {
        return props.text;
      },
      onactivate: onactivate
    }, null);
    libs.setProp(_el$25, "onactivate", onactivate);
    libs.effect(_p$ => {
      const _v$7 = props.eventName,
        _v$8 = libs.classNames("DemoButton", "HotKeyValid", "FireEvent", props.color),
        _v$9 = props.text;
      _v$7 !== _p$._v$7 && (_p$._v$7 = libs.setProp(_el$25, "id", _v$7, _p$._v$7));
      _v$8 !== _p$._v$8 && (_p$._v$8 = libs.setProp(_el$25, "class", _v$8, _p$._v$8));
      _v$9 !== _p$._v$9 && (_p$._v$9 = libs.setProp(_el$25, "text", _v$9, _p$._v$9));
      return _p$;
    }, {
      _v$7: undefined,
      _v$8: undefined,
      _v$9: undefined
    });
    return _el$25;
  })();
};
const DemoToggle = props => {
  const selected = props.selected ?? false;
  return (() => {
    const _el$26 = libs.createElement("ToggleButton", {
      get id() {
        return props.eventName;
      },
      "class": "HotKeyValid FireEvent",
      selected: selected,
      get text() {
        return props.text;
      }
    }, null);
    libs.setProp(_el$26, "selected", selected);
    libs.setProp(_el$26, "onactivate", self => {
      FireEvent(props.eventName, self.IsSelected() ? "1" : "0");
    });
    libs.effect(_p$ => {
      const _v$0 = props.eventName,
        _v$1 = props.text;
      _v$0 !== _p$._v$0 && (_p$._v$0 = libs.setProp(_el$26, "id", _v$0, _p$._v$0));
      _v$1 !== _p$._v$1 && (_p$._v$1 = libs.setProp(_el$26, "text", _v$1, _p$._v$1));
      return _p$;
    }, {
      _v$0: undefined,
      _v$1: undefined
    });
    return _el$26;
  })();
};
const DemoTextEntry = props => {
  return (() => {
    const _el$27 = libs.createElement("TextButton", {
        "class": "DemoTextEntry",
        flowChildren: "right",
        get text() {
          return props.text;
        }
      }, null),
      _el$28 = libs.createElement("TextEntry", {
        id: "DemoTextEntry",
        get text() {
          return props.defaultValue;
        }
      }, _el$27);
    libs.setProp(_el$27, "flowChildren", "right");
    libs.setProp(_el$27, "onactivate", self => {
      let TextEntry = self.FindChildTraverse("DemoTextEntry");
      FireEvent(props.eventName, TextEntry.text);
      if (props.onClick) {
        props.onClick(TextEntry.text);
      }
    });
    libs.setProp(_el$28, "onload", self => {
      self.SetDisableFocusOnMouseDown(false);
    });
    libs.setProp(_el$28, "oninputsubmit", self => {
      FireEvent(props.eventName, self.text);
      if (props.onClick) {
        props.onClick(self.text);
      }
      $.DispatchEvent("DropInputFocus", self);
    });
    libs.setProp(_el$28, "oncancel", self => {
      $.DispatchEvent("DropInputFocus", self);
    });
    libs.effect(_p$ => {
      const _v$10 = props.text,
        _v$11 = props.defaultValue;
      _v$10 !== _p$._v$10 && (_p$._v$10 = libs.setProp(_el$27, "text", _v$10, _p$._v$10));
      _v$11 !== _p$._v$11 && (_p$._v$11 = libs.setProp(_el$28, "text", _v$11, _p$._v$11));
      return _p$;
    }, {
      _v$10: undefined,
      _v$11: undefined
    });
    return _el$27;
  })();
};
const DemoSelectionButton = props => {
  return (() => {
    const _el$34 = libs.createElement("TextButton", {
      get id() {
        return props.eventName;
      },
      "class": "DemoButton HotKeyValid ToggleSelection",
      get text() {
        return props.text;
      }
    }, null);
    libs.setProp(_el$34, "onactivate", () => {
      if (props.onactivate) props.onactivate();else ToggleSelection(props.eventName);
    });
    libs.insert(_el$34, libs.createComponent(EOM_Icon.EOM_Icon, {
      type: "ArrowSolidRight",
      width: "10px",
      height: "16px",
      align: "right center",
      marginRight: "4px"
    }));
    libs.effect(_p$ => {
      const _v$15 = props.eventName,
        _v$16 = props.text;
      _v$15 !== _p$._v$15 && (_p$._v$15 = libs.setProp(_el$34, "id", _v$15, _p$._v$15));
      _v$16 !== _p$._v$16 && (_p$._v$16 = libs.setProp(_el$34, "text", _v$16, _p$._v$16));
      return _p$;
    }, {
      _v$15: undefined,
      _v$16: undefined
    });
    return _el$34;
  })();
};
const SelectionContainer = props => {
  const merged = libs.mergeProps({
    canScroll: false
  }, props);
  const [local, others] = libs.splitProps(merged, ["eventName", "title", "itemNames", "toggleList", "defaultLock", "defaultRawMode", "hasRawMode", "hasToggleSize", "hasLock", "hasFilter", "hasDragable", "onSearch", "onToggleType", "onChangeRawMode", "canScroll"]);
  const resolvedChildren = libs.children(() => libs.untrack(() => props.children));
  const [lock, setLock] = libs.createSignal(local.defaultLock ?? false);
  const [rawMode, setRawMode] = libs.createSignal(local.defaultRawMode ?? false);
  const [hasToggleList, setHasToggleList] = libs.createSignal(Object.keys(local.toggleList ?? {}).length > 0);
  const [size, setSize] = libs.createSignal({
    width: props.width ?? "864px",
    height: props.height ?? "620px"
  });
  const toggleRawMode = () => {
    setRawMode(!rawMode());
    if (local.onChangeRawMode) {
      local.onChangeRawMode(rawMode());
    }
  };
  const toggleSize = sizeText => {
    setSize({
      width: sizeText[0] + "px",
      height: sizeText[1] + "px"
    });
    SaveConfig("size_" + local.eventName, sizeText[0] + "px" + "," + sizeText[1] + "px");
  };
  let dragable = false;
  let dragPanel = undefined;
  const dragStart = panel => {
    if (local.hasDragable != false) {
      dragable = true;
      let parent = panel.FindAncestor(local.eventName);
      if (parent) {
        dragPanel = parent;
        dragTimer();
      }
    }
  };
  const dragTimer = () => {
    if (dragable) {
      if (dragPanel != undefined && dragPanel.IsValid()) {
        if (GameUI.IsMouseDown(0)) {
          let position = GameUI.GetCursorPosition();
          if (dragPanel.offsetX == undefined || dragPanel.offsetY == undefined) {
            dragPanel.offsetX = dragPanel.GetPositionWithinWindow().x - position[0];
            dragPanel.offsetY = dragPanel.GetPositionWithinWindow().y - position[1];
            dragPanel.style.align = "left top";
            dragPanel.style.margin = "0px 0px 0px 0px";
          }
          if (dragPanel.offsetX != undefined && dragPanel.offsetY != undefined) {
            dragPanel.SetPositionInPixels((position[0] + dragPanel.offsetX) / dragPanel.actualuiscale_x, (position[1] + dragPanel.offsetY) / dragPanel.actualuiscale_y, 0);
          }
        } else {
          dragPanel.offsetX = undefined;
          dragPanel.offsetY = undefined;
        }
        $.Schedule(Game.GetGameFrameTime(), dragTimer);
      }
    } else {
      dragPanel = undefined;
    }
  };
  libs.onMount(() => {
    const sizeConfig = GetPlayerConfig("size_" + local.eventName);
    if (sizeConfig) {
      const sizeText = sizeConfig.split(",");
      if (sizeText.length == 2) {
        setSize({
          width: sizeText[0],
          height: sizeText[1]
        });
      }
    }
  });
  return (() => {
    const _el$35 = libs.createElement("Panel", {
        get id() {
          return local.eventName;
        },
        get ["class"]() {
          return libs.classNames("SelectionContainer", {
            LockWindow: lock()
          });
        },
        hittest: true,
        get width() {
          return size().width;
        },
        get height() {
          return size().height;
        }
      }, null),
      _el$36 = libs.createElement("Panel", {
        id: "SelectionPicker"
      }, _el$35),
      _el$37 = libs.createElement("Panel", {
        id: "SelectionPickerHeader"
      }, _el$36),
      _el$38 = libs.createElement("Label", {
        id: "SelectionTitle",
        get text() {
          return local.title;
        }
      }, _el$37);
      libs.createElement("Panel", {
        "class": "FillWidth"
      }, _el$37);
      const _el$51 = libs.createElement("Panel", {
        id: "SelectionList",
        get overflow() {
          return local.canScroll ? "squish scroll" : "clip";
        }
      }, _el$36);
    libs.setProp(_el$37, "onactivate", () => {});
    libs.setProp(_el$37, "onmouseover", self => dragStart(self));
    libs.setProp(_el$37, "onmouseout", self => dragable = false);
    libs.insert(_el$37, libs.createComponent(libs.Show, {
      get when() {
        return local.hasFilter != false;
      },
      get children() {
        const _el$40 = libs.createElement("Panel", {
            id: "SelectionSearch",
            "class": "SearchBox"
          }, null),
          _el$42 = libs.createElement("TextEntry", {
            id: "SelectionSearchTextEntry",
            get borderLeftWidth() {
              return hasToggleList() ? "0px" : "1px";
            },
            placeholder: "#DOTA_Search"
          }, _el$40);
        libs.insert(_el$40, libs.createComponent(libs.Show, {
          get when() {
            return hasToggleList();
          },
          get children() {
            return libs.createComponent(EOM_DropDown.EOM_DropDown, {
              placeholder: "筛选",
              onChange: (index, item) => {
                if (local.onToggleType) {
                  local.onToggleType(Object.keys(local.toggleList ?? {})[index - 1]);
                }
              },
              onClear: () => {
                if (local.onToggleType) {
                  local.onToggleType("");
                }
              },
              get children() {
                return [libs.createElement("Label", {
                  id: "EOM_DropDown_Clear",
                  text: "X 清除筛选"
                }, null), libs.createComponent(libs.For, {
                  get each() {
                    return Object.keys(local.toggleList ?? {});
                  },
                  children: (key, index) => (() => {
                    const _el$52 = libs.createElement("Label", {
                      get text() {
                        return local.toggleList?.[key] ?? "";
                      }
                    }, null);
                    libs.effect(_$p => libs.setProp(_el$52, "text", local.toggleList?.[key] ?? "", _$p));
                    return _el$52;
                  })()
                })];
              }
            });
          }
        }), _el$42);
        libs.setProp(_el$42, "onload", self => {
          self.SetDisableFocusOnMouseDown(false);
        });
        libs.setProp(_el$42, "oninputsubmit", self => {
          if (local.onSearch) {
            local.onSearch(self.text);
          }
        });
        libs.setProp(_el$42, "ontextentrychange", self => {
          if (self.text == "") {
            if (local.onSearch) {
              local.onSearch("");
            }
          }
        });
        libs.effect(_$p => libs.setProp(_el$42, "borderLeftWidth", hasToggleList() ? "0px" : "1px", _$p));
        return _el$40;
      }
    }), null);
    libs.insert(_el$37, libs.createComponent(libs.Show, {
      get when() {
        return local.hasRawMode != false;
      },
      get children() {
        return libs.createComponent(EOM_Button.EOM_BaseButton, {
          "class": "HeaderButton",
          get classList() {
            return {
              Enable: rawMode()
            };
          },
          tooltip: "查看内部编码",
          onactivate: () => toggleRawMode(),
          get children() {
            const _el$43 = libs.createElement("Image", {
              width: "26px",
              svgfill: "white",
              src: "s2r://panorama/images/control_icons/24px/alt.vsvg"
            }, null);
            libs.setProp(_el$43, "width", "26px");
            return _el$43;
          }
        });
      }
    }), null);
    libs.insert(_el$37, libs.createComponent(libs.Show, {
      get when() {
        return local.hasToggleSize != false;
      },
      get children() {
        return libs.createComponent(EOM_Button.EOM_BaseButton, {
          "class": "HeaderButton",
          tooltip: "切换窗口大小",
          get children() {
            return [(() => {
              const _el$44 = libs.createElement("Image", {
                width: "26px",
                svgfill: "white",
                src: "s2r://panorama/images/control_icons/24px/full_screen.vsvg"
              }, null);
              libs.setProp(_el$44, "width", "26px");
              return _el$44;
            })(), libs.createComponent(EOM_DropDown.EOM_DropDown, {
              id: "ToggleSize",
              width: "100px",
              onChange: (index, item) => {
                toggleSize(item.text.split("x"));
              },
              get children() {
                return [libs.createElement("Label", {
                  text: "1280x720"
                }, null), libs.createElement("Label", {
                  text: "864x620"
                }, null), libs.createElement("Label", {
                  text: "620x360"
                }, null), libs.createElement("Label", {
                  text: "620x620"
                }, null)];
              }
            })];
          }
        });
      }
    }), null);
    libs.insert(_el$37, libs.createComponent(libs.Show, {
      get when() {
        return local.hasLock != false;
      },
      get children() {
        return libs.createComponent(EOM_Button.EOM_BaseButton, {
          "class": "HeaderButton",
          get classList() {
            return {
              Enable: lock()
            };
          },
          tooltip: "锁定窗口",
          onactivate: () => setLock(!lock()),
          get children() {
            const _el$49 = libs.createElement("Image", {
              svgfill: "white",
              get src() {
                return `s2r://panorama/images/custom_game/eom_design/codicon/${lock() ? "lock" : "unlock"}.svg`;
              }
            }, null);
            libs.effect(_$p => libs.setProp(_el$49, "src", `s2r://panorama/images/custom_game/eom_design/codicon/${lock() ? "lock" : "unlock"}.svg`, _$p));
            return _el$49;
          }
        });
      }
    }), null);
    libs.insert(_el$37, libs.createComponent(EOM_Button.EOM_BaseButton, {
      "class": "HeaderButton",
      tooltip: "关闭窗口",
      onactivate: () => ToggleSelection(local.eventName),
      get children() {
        return libs.createElement("Image", {
          svgfill: "white",
          src: "s2r://panorama/images/control_icons/24px/x_close.vsvg"
        }, null);
      }
    }), null);
    libs.insert(_el$51, resolvedChildren);
    libs.effect(_p$ => {
      const _v$17 = local.eventName,
        _v$18 = libs.classNames("SelectionContainer", {
          LockWindow: lock()
        }),
        _v$19 = size().width,
        _v$20 = size().height,
        _v$21 = local.title,
        _v$22 = local.canScroll ? "squish scroll" : "clip";
      _v$17 !== _p$._v$17 && (_p$._v$17 = libs.setProp(_el$35, "id", _v$17, _p$._v$17));
      _v$18 !== _p$._v$18 && (_p$._v$18 = libs.setProp(_el$35, "class", _v$18, _p$._v$18));
      _v$19 !== _p$._v$19 && (_p$._v$19 = libs.setProp(_el$35, "width", _v$19, _p$._v$19));
      _v$20 !== _p$._v$20 && (_p$._v$20 = libs.setProp(_el$35, "height", _v$20, _p$._v$20));
      _v$21 !== _p$._v$21 && (_p$._v$21 = libs.setProp(_el$38, "text", _v$21, _p$._v$21));
      _v$22 !== _p$._v$22 && (_p$._v$22 = libs.setProp(_el$51, "overflow", _v$22, _p$._v$22));
      return _p$;
    }, {
      _v$17: undefined,
      _v$18: undefined,
      _v$19: undefined,
      _v$20: undefined,
      _v$21: undefined,
      _v$22: undefined
    });
    return _el$35;
  })();
};
const EOM_DebugTool_TextPicker = props => {
  const [rawMode, setRawMode] = libs.createSignal(false);
  const [filterWord, setFilterWord] = libs.createSignal("");
  const [toggleType, setToggleType] = libs.createSignal("");
  const visiable = itemName => {
    if (props.filterFunc) {
      if (!props.filterFunc(toggleType(), itemName)) {
        return false;
      }
    }
    if (itemName.search(filterWord()) == -1 && GetLocalization("#" + itemName).search(filterWord()) == -1) {
      return false;
    }
    return true;
  };
  libs.createEffect(() => {
    if (props.toggleCallback) {
      if (toggleType() != "") {
        props.toggleCallback(toggleType());
      }
    }
  });
  return libs.createComponent(SelectionContainer, {
    get eventName() {
      return props.eventName;
    },
    get title() {
      return props.title;
    },
    hasFilter: true,
    get toggleList() {
      return props.toggleList;
    },
    onChangeRawMode: rawMode => setRawMode(rawMode),
    onSearch: text => setFilterWord(text),
    onToggleType: text => setToggleType(text),
    get children() {
      const _el$53 = libs.createElement("Panel", {
        "class": "EOM_DebugTool_TextPicker",
        flowChildren: "right-wrap",
        width: "100%",
        height: "100%",
        scroll: "y"
      }, null);
      libs.setProp(_el$53, "flowChildren", "right-wrap");
      libs.setProp(_el$53, "width", "100%");
      libs.setProp(_el$53, "height", "100%");
      libs.setProp(_el$53, "scroll", "y");
      libs.insert(_el$53, libs.createComponent(libs.For, {
        get each() {
          return props.itemNames;
        },
        children: (itemName, index) => (() => {
          const _el$54 = libs.createElement("TextButton", {
            "class": "EOM_DebugTool_TextPickerItem",
            get text() {
              return rawMode() ? itemName : "#" + itemName;
            }
          }, null);
          libs.setProp(_el$54, "onactivate", self => FireEvent(props.eventName, itemName, props.extraEventParams));
          libs.effect(_p$ => {
            const _v$23 = visiable(itemName),
              _v$24 = rawMode() ? itemName : "#" + itemName,
              _v$25 = props.tooltipText ? props.tooltipText(itemName) : "#" + itemName + "_description";
            _v$23 !== _p$._v$23 && (_p$._v$23 = libs.setProp(_el$54, "visible", _v$23, _p$._v$23));
            _v$24 !== _p$._v$24 && (_p$._v$24 = libs.setProp(_el$54, "text", _v$24, _p$._v$24));
            _v$25 !== _p$._v$25 && (_p$._v$25 = libs.setProp(_el$54, "tooltip_text", _v$25, _p$._v$25));
            return _p$;
          }, {
            _v$23: undefined,
            _v$24: undefined,
            _v$25: undefined
          });
          return _el$54;
        })()
      }));
      return _el$53;
    }
  });
};

exports.DemoButton = DemoButton;
exports.DemoSelectionButton = DemoSelectionButton;
exports.DemoTextEntry = DemoTextEntry;
exports.DemoToggle = DemoToggle;
exports.EOM_DebugTool = EOM_DebugTool;
exports.EOM_DebugTool_Category = EOM_DebugTool_Category;
exports.EOM_DebugTool_TextPicker = EOM_DebugTool_TextPicker;
exports.FireEvent = FireEvent;
exports.SelectionContainer = SelectionContainer;