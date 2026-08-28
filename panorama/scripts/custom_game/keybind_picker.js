--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 0b85d8d 
  ~ auto-generated — do not edit
]]


'use strict'; const exports = {}; GameUI.__loadModule('keybind_picker', exports); const require = GameUI.__require;

var libs = require('./libs.js');
var EOM_GamePad = require('./EOM_GamePad.js');
var EOM_Button = require('./EOM_Button.js');

const EOM_RadioButton = props => {
  const merged = libs.mergeProps(props, {
    class: "EOM_RadioButton"
  });
  const [local, other] = libs.splitProps(merged, ["text"]);
  return (() => {
    const _el$ = libs.createElement("RadioButton", other, null),
      _el$2 = libs.createElement("Label", {
        get text() {
          return local.text;
        }
      }, _el$);
    libs.spread(_el$, other, true);
    libs.effect(_$p => libs.setProp(_el$2, "text", local.text, _$p));
    return _el$;
  })();
};

const gamepadKeys = new Set(["pov_up", "pov_down", "pov_left", "pov_right", "z_axis_pos", "v_axis_pos", "y_axis_neg", "y_axis_pos", "x_axis_neg", "x_axis_pos", "r_axis_neg", "r_axis_pos", "u_axis_neg", "u_axis_pos", "joy1", "joy2", "joy3", "joy4", "joy5", "joy6", "joy7", "joy8", "joy9", "joy10", "joy11"]);
const GamepadPicker = props => {
  const [pendingKey, setPendingKey] = libs.createSignal(props.currentKey ?? "");
  libs.createEffect(() => {
    if (props.visible === true) {
      setPendingKey(props.currentKey ?? "");
    }
  });
  useClientSideEvent("key_pressed", data => {
    if (props.visible !== true) {
      return;
    }
    if (typeof data.key !== "string") {
      return;
    }
    if (!gamepadKeys.has(data.key)) {
      return;
    }
    setPendingKey(data.key);
  });
  return (() => {
    const _el$ = libs.createElement("Panel", {
        "class": "GamepadPicker",
        get hittest() {
          return props.visible === true;
        }
      }, null),
      _el$2 = libs.createElement("Panel", {
        "class": "GamepadPickerWindow",
        hittest: true
      }, _el$);
      libs.createElement("Label", {
        "class": "GamepadPickerTitle",
        text: "#Setting_Gamepad"
      }, _el$2);
      const _el$4 = libs.createElement("Label", {
        "class": "GamepadPickerDesc",
        get text() {
          return props.descriptionText ?? "#Hotkey_Pick";
        }
      }, _el$2),
      _el$5 = libs.createElement("Panel", {
        "class": "GamepadPickerContent"
      }, _el$2),
      _el$6 = libs.createElement("Label", {
        "class": "GamepadPickerKeyName",
        get text() {
          return libs.memo(() => pendingKey() == "")() ? "#Setting_Gamepad" : GetLocalization("#" + pendingKey(), pendingKey());
        }
      }, _el$2);
    libs.insert(_el$5, libs.createComponent(EOM_GamePad.EOM_GamePad, {
      get keyName() {
        return pendingKey();
      }
    }));
    libs.insert(_el$2, libs.createComponent(EOM_Button.EOM_Button, {
      "class": "GamepadPickerConfirm",
      size: "Small",
      get enabled() {
        return pendingKey() != "";
      },
      text: "#DOTA_Confirm",
      onactivate: () => {
        if (pendingKey() != "") {
          props.onConfirm?.(pendingKey());
        }
      }
    }), null);
    libs.effect(_p$ => {
      const _v$ = {
          Show: props.visible === true
        },
        _v$2 = props.visible === true,
        _v$3 = props.descriptionText ?? "#Hotkey_Pick",
        _v$4 = libs.memo(() => pendingKey() == "")() ? "#Setting_Gamepad" : GetLocalization("#" + pendingKey(), pendingKey());
      _v$ !== _p$._v$ && (_p$._v$ = libs.setProp(_el$, "classList", _v$, _p$._v$));
      _v$2 !== _p$._v$2 && (_p$._v$2 = libs.setProp(_el$, "hittest", _v$2, _p$._v$2));
      _v$3 !== _p$._v$3 && (_p$._v$3 = libs.setProp(_el$4, "text", _v$3, _p$._v$3));
      _v$4 !== _p$._v$4 && (_p$._v$4 = libs.setProp(_el$6, "text", _v$4, _p$._v$4));
      return _p$;
    }, {
      _v$: undefined,
      _v$2: undefined,
      _v$3: undefined,
      _v$4: undefined
    });
    return _el$;
  })();
};

const KeyBindPicker = props => {
  return (() => {
    const _el$ = libs.createElement("Panel", {
        "class": "KeyBindPicker",
        acceptsfocus: true,
        id: "KeyBindPicker"
      }, null),
      _el$2 = libs.createElement("Panel", {
        id: "Header"
      }, _el$);
      libs.createElement("Label", {
        id: "Instructions",
        text: "#Hotkey_Pick"
      }, _el$2);
      const _el$4 = libs.createElement("Panel", {
        id: "KeyBindOption"
      }, _el$),
      _el$5 = libs.createElement("Panel", {
        "class": "KeyboardOption"
      }, _el$4),
      _el$6 = libs.createElement("Panel", {
        "class": "LeftRightFlow"
      }, _el$5),
      _el$7 = libs.createElement("Panel", {
        "class": "LeftRightFlow"
      }, _el$5),
      _el$8 = libs.createElement("Panel", {
        "class": "LeftRightFlow"
      }, _el$5),
      _el$9 = libs.createElement("Panel", {
        "class": "LeftRightFlow"
      }, _el$5),
      _el$0 = libs.createElement("Panel", {
        "class": "LeftRightFlow"
      }, _el$5),
      _el$1 = libs.createElement("Panel", {
        "class": "MouseOption"
      }, _el$4);
    libs.insert(_el$6, libs.createComponent(KeyBinder, {
      keyName: "`",
      get onSelect() {
        return props.onKeySelected;
      }
    }), null);
    libs.insert(_el$6, libs.createComponent(KeyBinder, {
      keyName: "scancode30",
      get onSelect() {
        return props.onKeySelected;
      }
    }), null);
    libs.insert(_el$6, libs.createComponent(KeyBinder, {
      keyName: "scancode31",
      get onSelect() {
        return props.onKeySelected;
      }
    }), null);
    libs.insert(_el$6, libs.createComponent(KeyBinder, {
      keyName: "scancode32",
      get onSelect() {
        return props.onKeySelected;
      }
    }), null);
    libs.insert(_el$6, libs.createComponent(KeyBinder, {
      keyName: "scancode33",
      get onSelect() {
        return props.onKeySelected;
      }
    }), null);
    libs.insert(_el$6, libs.createComponent(KeyBinder, {
      keyName: "scancode34",
      get onSelect() {
        return props.onKeySelected;
      }
    }), null);
    libs.insert(_el$6, libs.createComponent(KeyBinder, {
      keyName: "scancode35",
      get onSelect() {
        return props.onKeySelected;
      }
    }), null);
    libs.insert(_el$6, libs.createComponent(KeyBinder, {
      keyName: "scancode36",
      get onSelect() {
        return props.onKeySelected;
      }
    }), null);
    libs.insert(_el$6, libs.createComponent(KeyBinder, {
      keyName: "scancode37",
      get onSelect() {
        return props.onKeySelected;
      }
    }), null);
    libs.insert(_el$6, libs.createComponent(KeyBinder, {
      keyName: "scancode38",
      get onSelect() {
        return props.onKeySelected;
      }
    }), null);
    libs.insert(_el$6, libs.createComponent(KeyBinder, {
      keyName: "scancode39",
      get onSelect() {
        return props.onKeySelected;
      }
    }), null);
    libs.insert(_el$6, libs.createComponent(KeyBinder, {
      keyName: "-",
      enable: false,
      get onSelect() {
        return props.onKeySelected;
      }
    }), null);
    libs.insert(_el$6, libs.createComponent(KeyBinder, {
      keyName: "+",
      enable: false,
      get onSelect() {
        return props.onKeySelected;
      }
    }), null);
    libs.insert(_el$6, libs.createComponent(KeyBinder, {
      keyName: "BACK",
      type: "Back",
      enable: false,
      get onSelect() {
        return props.onKeySelected;
      }
    }), null);
    libs.insert(_el$7, libs.createComponent(KeyBinder, {
      keyName: "TAB",
      type: "Tab",
      get onSelect() {
        return props.onKeySelected;
      }
    }), null);
    libs.insert(_el$7, libs.createComponent(KeyBinder, {
      keyName: "Q",
      get onSelect() {
        return props.onKeySelected;
      }
    }), null);
    libs.insert(_el$7, libs.createComponent(KeyBinder, {
      keyName: "W",
      get onSelect() {
        return props.onKeySelected;
      }
    }), null);
    libs.insert(_el$7, libs.createComponent(KeyBinder, {
      keyName: "E",
      get onSelect() {
        return props.onKeySelected;
      }
    }), null);
    libs.insert(_el$7, libs.createComponent(KeyBinder, {
      keyName: "R",
      get onSelect() {
        return props.onKeySelected;
      }
    }), null);
    libs.insert(_el$7, libs.createComponent(KeyBinder, {
      keyName: "T",
      get onSelect() {
        return props.onKeySelected;
      }
    }), null);
    libs.insert(_el$7, libs.createComponent(KeyBinder, {
      keyName: "Y",
      get onSelect() {
        return props.onKeySelected;
      }
    }), null);
    libs.insert(_el$7, libs.createComponent(KeyBinder, {
      keyName: "U",
      get onSelect() {
        return props.onKeySelected;
      }
    }), null);
    libs.insert(_el$7, libs.createComponent(KeyBinder, {
      keyName: "I",
      enable: false,
      get onSelect() {
        return props.onKeySelected;
      }
    }), null);
    libs.insert(_el$7, libs.createComponent(KeyBinder, {
      keyName: "O",
      get onSelect() {
        return props.onKeySelected;
      }
    }), null);
    libs.insert(_el$7, libs.createComponent(KeyBinder, {
      keyName: "P",
      get onSelect() {
        return props.onKeySelected;
      }
    }), null);
    libs.insert(_el$7, libs.createComponent(KeyBinder, {
      keyName: "[",
      enable: false,
      get onSelect() {
        return props.onKeySelected;
      }
    }), null);
    libs.insert(_el$7, libs.createComponent(KeyBinder, {
      keyName: "]",
      enable: false,
      get onSelect() {
        return props.onKeySelected;
      }
    }), null);
    libs.insert(_el$7, libs.createComponent(KeyBinder, {
      keyName: "\\",
      type: "Tab",
      enable: false,
      get onSelect() {
        return props.onKeySelected;
      }
    }), null);
    libs.insert(_el$8, libs.createComponent(KeyBinder, {
      keyName: "CAPSLOCK",
      type: "CapLk",
      get onSelect() {
        return props.onKeySelected;
      }
    }), null);
    libs.insert(_el$8, libs.createComponent(KeyBinder, {
      keyName: "A",
      get onSelect() {
        return props.onKeySelected;
      }
    }), null);
    libs.insert(_el$8, libs.createComponent(KeyBinder, {
      keyName: "S",
      get onSelect() {
        return props.onKeySelected;
      }
    }), null);
    libs.insert(_el$8, libs.createComponent(KeyBinder, {
      keyName: "D",
      get onSelect() {
        return props.onKeySelected;
      }
    }), null);
    libs.insert(_el$8, libs.createComponent(KeyBinder, {
      keyName: "F",
      get onSelect() {
        return props.onKeySelected;
      }
    }), null);
    libs.insert(_el$8, libs.createComponent(KeyBinder, {
      keyName: "G",
      get onSelect() {
        return props.onKeySelected;
      }
    }), null);
    libs.insert(_el$8, libs.createComponent(KeyBinder, {
      keyName: "H",
      get onSelect() {
        return props.onKeySelected;
      }
    }), null);
    libs.insert(_el$8, libs.createComponent(KeyBinder, {
      keyName: "J",
      get onSelect() {
        return props.onKeySelected;
      }
    }), null);
    libs.insert(_el$8, libs.createComponent(KeyBinder, {
      keyName: "K",
      get onSelect() {
        return props.onKeySelected;
      }
    }), null);
    libs.insert(_el$8, libs.createComponent(KeyBinder, {
      keyName: "L",
      get onSelect() {
        return props.onKeySelected;
      }
    }), null);
    libs.insert(_el$8, libs.createComponent(KeyBinder, {
      keyName: ";",
      enable: false,
      get onSelect() {
        return props.onKeySelected;
      }
    }), null);
    libs.insert(_el$8, libs.createComponent(KeyBinder, {
      keyName: "'",
      enable: false,
      get onSelect() {
        return props.onKeySelected;
      }
    }), null);
    libs.insert(_el$8, libs.createComponent(KeyBinder, {
      keyName: "Enter",
      type: "Enter",
      enable: false,
      get onSelect() {
        return props.onKeySelected;
      }
    }), null);
    libs.insert(_el$9, libs.createComponent(KeyBinder, {
      keyName: "SHIFT",
      type: "Shift",
      get onSelect() {
        return props.onKeySelected;
      }
    }), null);
    libs.insert(_el$9, libs.createComponent(KeyBinder, {
      keyName: "Z",
      get onSelect() {
        return props.onKeySelected;
      }
    }), null);
    libs.insert(_el$9, libs.createComponent(KeyBinder, {
      keyName: "X",
      get onSelect() {
        return props.onKeySelected;
      }
    }), null);
    libs.insert(_el$9, libs.createComponent(KeyBinder, {
      keyName: "C",
      get onSelect() {
        return props.onKeySelected;
      }
    }), null);
    libs.insert(_el$9, libs.createComponent(KeyBinder, {
      keyName: "V",
      get onSelect() {
        return props.onKeySelected;
      }
    }), null);
    libs.insert(_el$9, libs.createComponent(KeyBinder, {
      keyName: "B",
      get onSelect() {
        return props.onKeySelected;
      }
    }), null);
    libs.insert(_el$9, libs.createComponent(KeyBinder, {
      keyName: "N",
      get onSelect() {
        return props.onKeySelected;
      }
    }), null);
    libs.insert(_el$9, libs.createComponent(KeyBinder, {
      keyName: "M",
      get onSelect() {
        return props.onKeySelected;
      }
    }), null);
    libs.insert(_el$9, libs.createComponent(KeyBinder, {
      keyName: ",",
      enable: false,
      get onSelect() {
        return props.onKeySelected;
      }
    }), null);
    libs.insert(_el$9, libs.createComponent(KeyBinder, {
      keyName: ".",
      enable: false,
      get onSelect() {
        return props.onKeySelected;
      }
    }), null);
    libs.insert(_el$9, libs.createComponent(KeyBinder, {
      keyName: "/",
      enable: false,
      get onSelect() {
        return props.onKeySelected;
      }
    }), null);
    libs.insert(_el$9, libs.createComponent(KeyBinder, {
      keyName: "SHIFT",
      type: "Shift",
      get onSelect() {
        return props.onKeySelected;
      }
    }), null);
    libs.insert(_el$0, libs.createComponent(KeyBinder, {
      keyName: "CTRL",
      type: "Ctrl",
      get onSelect() {
        return props.onKeySelected;
      }
    }), null);
    libs.insert(_el$0, libs.createComponent(KeyBinder, {
      keyName: "ALT",
      type: "Alt",
      enable: false,
      get onSelect() {
        return props.onKeySelected;
      }
    }), null);
    libs.insert(_el$0, libs.createComponent(KeyBinder, {
      keyName: "SPACE",
      type: "Space",
      get onSelect() {
        return props.onKeySelected;
      }
    }), null);
    libs.insert(_el$0, libs.createComponent(KeyBinder, {
      keyName: "ALT",
      type: "Alt",
      enable: false,
      get onSelect() {
        return props.onKeySelected;
      }
    }), null);
    libs.insert(_el$0, libs.createComponent(KeyBinder, {
      keyName: "CTRL",
      type: "Ctrl",
      get onSelect() {
        return props.onKeySelected;
      }
    }), null);
    libs.insert(_el$1, libs.createComponent(KeyBinder, {
      keyName: "MOUSE0",
      type: "Mouse",
      get onSelect() {
        return props.onKeySelected;
      }
    }), null);
    libs.insert(_el$1, libs.createComponent(KeyBinder, {
      keyName: "MOUSE1",
      type: "Mouse",
      get onSelect() {
        return props.onKeySelected;
      }
    }), null);
    return _el$;
  })();
};
const KeyBinder = props => {
  return (() => {
    const _el$10 = libs.createElement("Panel", {
        get id() {
          return props.keyName;
        },
        get ["class"]() {
          return libs.classNames("SettingsKeyBinder", "BindingRow", "HeroAbilityBindAbilityButton", {
            Disable: !props.enable
          }, props.type);
        }
      }, null),
      _el$11 = libs.createElement("Panel", {
        id: "LabelFXContainer"
      }, _el$10);
      libs.createElement("Panel", {
        id: "KeyBinderBG"
      }, _el$11);
      const _el$13 = libs.createElement("Panel", {
        id: "BindingLabelContainer"
      }, _el$11);
      libs.createElement("Label", {
        id: "mod",
        text: "",
        "class": "BindingRowButton"
      }, _el$13);
      libs.createElement("Label", {
        id: "dash",
        text: "-",
        "class": "BindingRowButton"
      }, _el$13);
      const _el$16 = libs.createElement("Label", {
        id: "value",
        get text() {
          return GetLocalization("#" + props.keyName, props.keyName);
        },
        "class": "BindingRowButton"
      }, _el$13);
      libs.createElement("Button", {
        "class": "ClearKeybinding"
      }, _el$11);
    libs.setProp(_el$10, "onactivate", self => {
      if (props.enable !== false && props.onSelect) {
        props.onSelect(props.keyName);
      }
    });
    libs.effect(_p$ => {
      const _v$ = props.keyName,
        _v$2 = props.enable,
        _v$3 = libs.classNames("SettingsKeyBinder", "BindingRow", "HeroAbilityBindAbilityButton", {
          Disable: !props.enable
        }, props.type),
        _v$4 = GetLocalization("#" + props.keyName, props.keyName);
      _v$ !== _p$._v$ && (_p$._v$ = libs.setProp(_el$10, "id", _v$, _p$._v$));
      _v$2 !== _p$._v$2 && (_p$._v$2 = libs.setProp(_el$10, "enabled", _v$2, _p$._v$2));
      _v$3 !== _p$._v$3 && (_p$._v$3 = libs.setProp(_el$10, "class", _v$3, _p$._v$3));
      _v$4 !== _p$._v$4 && (_p$._v$4 = libs.setProp(_el$16, "text", _v$4, _p$._v$4));
      return _p$;
    }, {
      _v$: undefined,
      _v$2: undefined,
      _v$3: undefined,
      _v$4: undefined
    });
    return _el$10;
  })();
};

exports.EOM_RadioButton = EOM_RadioButton;
exports.GamepadPicker = GamepadPicker;
exports.KeyBindPicker = KeyBindPicker;