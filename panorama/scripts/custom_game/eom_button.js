--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 0b85d8d 
  ~ auto-generated — do not edit
]]


'use strict'; const exports = {}; GameUI.__loadModule('EOM_Button', exports); const require = GameUI.__require;

var libs = require('./libs.js');
var GenericPanel = require('./GenericPanel.js');
var EOM_Icon = require('./EOM_Icon.js');
var EOM_Panel = require('./EOM_Panel.js');

const EOM_Button = props => {
  const merged = libs.mergeProps$1({
    loading: false,
    type: EOM_Panel.ADDON_NAME,
    color: "Green"
  }, props);
  const [local, others] = libs.splitProps(props, ["loading", "icon", "type", "text", "color", "dialogVariables", "children", "backgroundImage"]);
  const _icon = libs.children(() => local.icon);
  const resolved = libs.children(() => local.children);
  return (() => {
    const _el$ = libs.createElement("TextButton", libs.mergeProps(() => EOM_Panel.EOMProps(others, {
        className: libs.classNames(props.className, "EOM_Button", merged.type, merged.color, {
          Loading: merged.loading
        }),
        style: {
          backgroundImage: local.backgroundImage
        }
      }), {
        text: ""
      }), null),
      _el$2 = libs.createElement("Panel", {}, _el$);
    libs.spread(_el$, libs.mergeProps(() => EOM_Panel.EOMProps(others, {
      className: libs.classNames(props.className, "EOM_Button", merged.type, merged.color, {
        Loading: merged.loading
      }),
      style: {
        backgroundImage: local.backgroundImage
      }
    }), {
      "text": ""
    }), true);
    libs.setProp(_el$2, "className", "EOM_Button_Text");
    libs.insert(_el$2, _icon, null);
    libs.insert(_el$2, libs.createComponent(GenericPanel.CLabel, {
      get text() {
        return local.text ?? "";
      },
      html: true,
      get dialogVariables() {
        return local.dialogVariables;
      }
    }), null);
    libs.insert(_el$2, resolved, null);
    return _el$;
  })();
};
const EOM_BaseButton = props => {
  const [local, others] = libs.splitProps(props, ["children"]);
  const resolved = libs.children(() => local.children);
  return (() => {
    const _el$3 = libs.createElement("Button", libs.mergeProps(() => EOM_Panel.EOMProps(others, {
      className: "EOM_Button EOM_BaseButton"
    })), null);
    libs.spread(_el$3, libs.mergeProps(() => EOM_Panel.EOMProps(others, {
      className: "EOM_Button EOM_BaseButton"
    })), true);
    libs.insert(_el$3, resolved);
    return _el$3;
  })();
};
const EOM_IconButton = props => {
  const [local, others] = libs.splitProps(props, ["icon", "children"]);
  const icons = libs.children(() => local.icon);
  const revolved = libs.children(() => local.children);
  return (() => {
    const _el$4 = libs.createElement("Button", libs.mergeProps(() => EOM_Panel.EOMProps(others, {
      className: "EOM_IconButton"
    })), null);
    libs.spread(_el$4, libs.mergeProps(() => EOM_Panel.EOMProps(others, {
      className: "EOM_IconButton"
    })), true);
    libs.insert(_el$4, icons, null);
    libs.insert(_el$4, revolved, null);
    return _el$4;
  })();
};
const EOM_CloseButton = props => {
  const merged = libs.mergeProps$1({
    type: EOM_Panel.ADDON_NAME
  }, props);
  const [local, others] = libs.splitProps(merged, ["type", "children"]);
  const resolved = libs.children(() => local.children);
  return libs.createComponent(EOM_IconButton, libs.mergeProps({
    get icon() {
      return libs.createComponent(EOM_Icon.EOM_Icon, {
        type: "XClose",
        get extraType() {
          return local.type;
        }
      });
    }
  }, () => EOM_Panel.EOMProps(others, {
    className: "EOM_CloseButton"
  }), {
    get children() {
      return resolved();
    }
  }));
};
const EOM_DiamondButton = props => {
  const merged = libs.mergeProps$1({
    type: EOM_Panel.ADDON_NAME,
    direction: "right",
    hasAnimation: false
  }, props);
  const [local, others] = libs.splitProps(merged, ["type", "direction", "hasAnimation"]);
  return (() => {
    const _el$5 = libs.createElement("Button", libs.mergeProps(() => EOM_Panel.EOMProps(others, {
        className: libs.classNames("EOM_DiamondButton", local.direction, {
          animation: local.hasAnimation
        })
      })), null);
      libs.createElement("Panel", {
        id: "EOM_DiamondButton_Point"
      }, _el$5);
      libs.createElement("Panel", {
        id: "EOM_DiamondButton_Arrow"
      }, _el$5);
    libs.spread(_el$5, libs.mergeProps(() => EOM_Panel.EOMProps(others, {
      className: libs.classNames("EOM_DiamondButton", local.direction, {
        animation: local.hasAnimation
      })
    })), true);
    return _el$5;
  })();
};

exports.EOM_BaseButton = EOM_BaseButton;
exports.EOM_Button = EOM_Button;
exports.EOM_CloseButton = EOM_CloseButton;
exports.EOM_DiamondButton = EOM_DiamondButton;
exports.EOM_IconButton = EOM_IconButton;