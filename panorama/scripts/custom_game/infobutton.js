--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 9d26fbd · 2026-08-07 04:51:43 UTC
  ~ auto-generated — do not edit
]]


'use strict'; const exports = {}; GameUI.__loadModule('InfoButton', exports); const require = GameUI.__require;

var libs = require('./libs.js');
var EOM_Panel = require('./EOM_Panel.js');
var GenericPanel = require('./GenericPanel.js');

const InfoButton = props => {
  const [local, others] = libs.splitProps(props, ["children", "info"]);
  const resolved = libs.children(() => local.children);
  return (() => {
    const _el$ = libs.createElement("Panel", libs.mergeProps(() => EOM_Panel.EOMProps(props, {
        className: "InfoButton"
      })), null),
      _el$2 = libs.createElement("Image", {}, _el$),
      _el$3 = libs.createElement("Panel", {}, _el$);
    libs.spread(_el$, libs.mergeProps(() => EOM_Panel.EOMProps(props, {
      className: "InfoButton"
    })), true);
    libs.setProp(_el$2, "className", "InfoButtonIcon");
    libs.insert(_el$3, libs.createComponent(GenericPanel.CLabel, {
      get text() {
        return props.info;
      }
    }));
    libs.insert(_el$, resolved, null);
    libs.effect(_$p => libs.setProp(_el$3, "className", libs.classNames("InfoButtonLabel", $.Language().toLowerCase()), _$p));
    return _el$;
  })();
};

exports.InfoButton = InfoButton;