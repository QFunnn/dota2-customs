--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 9d26fbd · 2026-08-07 04:51:43 UTC
  ~ auto-generated — do not edit
]]


'use strict'; const exports = {}; GameUI.__loadModule('EOM_Popup', exports); const require = GameUI.__require;

var libs = require('./libs.js');
var GenericPanel = require('./GenericPanel.js');
var EOM_Icon = require('./EOM_Icon.js');
var EOM_Panel = require('./EOM_Panel.js');
var EOM_Button = require('./EOM_Button.js');

const EOM_Popup = props => {
  const merged = libs.mergeProps$1({
    type: EOM_Panel.ADDON_NAME,
    popType: "PopupType_LeftTop",
    hideClose: false,
    size: "normal",
    onClose: () => {}
  }, props);
  const [local, others] = libs.splitProps(merged, ["children", "title", "type", "size", "popType", "hideClose", "onClose"]);
  const {
    title,
    type,
    hideClose
  } = local;
  const revolved = libs.children(() => local.children);
  return (() => {
    const _el$ = libs.createElement("Panel", libs.mergeProps(() => EOM_Panel.EOMProps(others, {
        className: libs.classNames("EOM_PopupMain", local.popType, local.type, local.size)
      })), null),
      _el$2 = libs.createElement("Panel", {
        hittest: false
      }, _el$);
    libs.setProp(_el$, "onactivate", () => {});
    libs.spread(_el$, libs.mergeProps(() => EOM_Panel.EOMProps(others, {
      className: libs.classNames("EOM_PopupMain", local.popType, local.type, local.size)
    })), true);
    libs.insert(_el$, libs.createComponent(EOM_PopupBG, {
      type: type,
      hasTitle: title != undefined && title != "",
      get size() {
        return local.size;
      }
    }), _el$2);
    libs.insert(_el$, title != undefined && title != "" && libs.createComponent(GenericPanel.CLabel, {
      get className() {
        return libs.classNames("EOM_PopupTitle", type);
      },
      get text() {
        return $.Localize(title);
      }
    }), _el$2);
    libs.insert(_el$, !hideClose && libs.createComponent(EOM_Button.EOM_IconButton, {
      className: type,
      get icon() {
        return libs.createComponent(EOM_Icon.EOM_Icon, {
          type: "XClose",
          get extraType() {
            return local.type;
          }
        });
      },
      onactivate: () => local.onClose()
    }), _el$2);
    libs.insert(_el$2, revolved);
    libs.effect(_$p => libs.setProp(_el$2, "className", libs.classNames("EOM_PopupContent", type), _$p));
    return _el$;
  })();
};
const EOM_PopupBG = props => {
  const merged = libs.mergeProps$1({
    type: EOM_Panel.ADDON_NAME,
    hasTitle: true,
    size: "Normal"
  }, props);
  const [local, others] = libs.splitProps(merged, ["children", "type", "size", "hasTitle"]);
  return (() => {
    const _el$3 = libs.createElement("Panel", libs.mergeProps(() => EOM_Panel.EOMProps(others, {
        className: libs.classNames("EOM_PopupBG", local.type, local.size)
      }), {
        hittest: false,
        hittestchildren: false
      }), null),
      _el$4 = libs.createElement("Panel", {}, _el$3),
      _el$5 = libs.createElement("Panel", {}, _el$3),
      _el$6 = libs.createElement("Panel", {}, _el$3),
      _el$7 = libs.createElement("Panel", {}, _el$3),
      _el$8 = libs.createElement("Panel", {}, _el$3),
      _el$9 = libs.createElement("Panel", {}, _el$3),
      _el$0 = libs.createElement("Panel", {}, _el$3),
      _el$1 = libs.createElement("Panel", {}, _el$3),
      _el$10 = libs.createElement("Panel", {}, _el$3),
      _el$11 = libs.createElement("Panel", {}, _el$3),
      _el$12 = libs.createElement("Panel", {}, _el$3);
    libs.spread(_el$3, libs.mergeProps(() => EOM_Panel.EOMProps(others, {
      className: libs.classNames("EOM_PopupBG", local.type, local.size)
    }), {
      "hittest": false,
      "hittestchildren": false
    }), true);
    libs.setProp(_el$4, "className", "EOM_Texture");
    libs.insert(_el$3, (() => {
      const _c$ = libs.memo(() => !!(local.hasTitle && local.type != "C4"));
      return () => _c$() && (() => {
        const _el$13 = libs.createElement("Panel", {}, null);
        libs.setProp(_el$13, "className", "EOM_TitleBG");
        return _el$13;
      })();
    })(), _el$5);
    libs.insert(_el$3, (() => {
      const _c$2 = libs.memo(() => !!(local.hasTitle && local.type == "C4"));
      return () => _c$2() && (() => {
        const _el$14 = libs.createElement("Panel", {}, null),
          _el$15 = libs.createElement("Panel", {}, _el$14),
          _el$16 = libs.createElement("Panel", {}, _el$14),
          _el$17 = libs.createElement("Panel", {}, _el$14),
          _el$18 = libs.createElement("Panel", {}, _el$14),
          _el$19 = libs.createElement("Panel", {}, _el$14),
          _el$20 = libs.createElement("Panel", {}, _el$14),
          _el$21 = libs.createElement("Panel", {}, _el$14),
          _el$22 = libs.createElement("Panel", {}, _el$14),
          _el$23 = libs.createElement("Panel", {}, _el$14);
        libs.setProp(_el$14, "className", "EOM_TitleBG");
        libs.setProp(_el$15, "className", "EOM_Title_Color");
        libs.setProp(_el$16, "className", "EOM_Title_HighLightLeft");
        libs.setProp(_el$17, "className", "EOM_Title_HighLightRight");
        libs.setProp(_el$18, "className", "EOM_Title_HighLightTop");
        libs.setProp(_el$19, "className", "EOM_Title_HighLightBottom");
        libs.setProp(_el$20, "className", "EOM_Title_Material");
        libs.setProp(_el$21, "className", "EOM_Title_LeftBG");
        libs.setProp(_el$22, "className", "EOM_Title_CenterBG");
        libs.setProp(_el$23, "className", "EOM_Title_RightBG");
        return _el$14;
      })();
    })(), _el$5);
    libs.insert(_el$3, (() => {
      const _c$3 = libs.memo(() => local.type == "C4");
      return () => _c$3() && (() => {
        const _el$24 = libs.createElement("Panel", {}, null);
        libs.setProp(_el$24, "className", "EOM_Material");
        return _el$24;
      })();
    })(), _el$5);
    libs.insert(_el$3, (() => {
      const _c$4 = libs.memo(() => local.type == "Tui10");
      return () => _c$4() && (() => {
        const _el$25 = libs.createElement("Panel", {}, null);
        libs.setProp(_el$25, "className", "EOM_TitleRect");
        return _el$25;
      })();
    })(), _el$5);
    libs.setProp(_el$5, "className", "EOM_HeaderBG");
    libs.setProp(_el$6, "className", "EOM_LeftTopBG");
    libs.setProp(_el$7, "className", "EOM_CenterTopBG");
    libs.setProp(_el$8, "className", "EOM_RightTopBG");
    libs.setProp(_el$9, "className", "EOM_LeftCenterBG");
    libs.setProp(_el$0, "className", "EOM_CenterCenterBG");
    libs.setProp(_el$1, "className", "EOM_RightCenterBG");
    libs.setProp(_el$10, "className", "EOM_LeftBottomBG");
    libs.setProp(_el$11, "className", "EOM_CenterBottomBG");
    libs.setProp(_el$12, "className", "EOM_RightBottomBG");
    return _el$3;
  })();
};

exports.EOM_Popup = EOM_Popup;