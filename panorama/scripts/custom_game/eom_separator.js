--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 16fdfbc · 2026-08-07 21:47:55 UTC
  ~ auto-generated — do not edit
]]


'use strict'; const exports = {}; GameUI.__loadModule('EOM_Separator', exports); const require = GameUI.__require;

var libs = require('./libs.js');
var EOM_Panel = require('./EOM_Panel.js');

const EOM_Separator = props => {
  const merged = libs.mergeProps$1({
    type: EOM_Panel.ADDON_NAME,
    size: "normal",
    direction: "horizontal"
  }, props);
  const [local, others] = libs.splitProps(merged, ["children", "type", "direction", "length", "size"]);
  const defaultStyle = () => {
    if (local.direction == "horizontal") {
      return {
        width: local.length
      };
    } else if (local.direction == "vertical") {
      return {
        height: local.length
      };
    }
    return {};
  };
  return (() => {
    const _el$ = libs.createElement("Panel", libs.mergeProps(() => EOM_Panel.EOMProps(others, {
      className: libs.classNames("EOM_Separator", local.direction, local.type, "Size_" + local.size),
      style: defaultStyle()
    })), null);
    libs.spread(_el$, libs.mergeProps(() => EOM_Panel.EOMProps(others, {
      className: libs.classNames("EOM_Separator", local.direction, local.type, "Size_" + local.size),
      style: defaultStyle()
    })), false);
    return _el$;
  })();
};

exports.EOM_Separator = EOM_Separator;