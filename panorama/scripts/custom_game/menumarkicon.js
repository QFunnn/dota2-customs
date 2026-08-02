--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build b9dc48c · 2026-08-02 17:42:46 UTC
  ~ auto-generated — do not edit
]]


'use strict'; const exports = {}; GameUI.__loadModule('MenuMarkIcon', exports); const require = GameUI.__require;

var libs = require('./libs.js');
var EOM_Panel = require('./EOM_Panel.js');

const MenuMarkIcon = props => {
  const merge = libs.mergeProps$1({
    type: "default"
  }, props);
  const [local, others] = libs.splitProps(merge, ["type", "children"]);
  return (() => {
    const _el$ = libs.createElement("Image", libs.mergeProps(() => EOM_Panel.EOMProps(others, {
      className: libs.classNames("MenuMarkIcon", local.type)
    })), null);
    libs.spread(_el$, libs.mergeProps(() => EOM_Panel.EOMProps(others, {
      className: libs.classNames("MenuMarkIcon", local.type)
    })), true);
    return _el$;
  })();
};

exports.MenuMarkIcon = MenuMarkIcon;