--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 9d26fbd · 2026-08-07 04:51:43 UTC
  ~ auto-generated — do not edit
]]


'use strict'; const exports = {}; GameUI.__loadModule('EOM_Tooltip', exports); const require = GameUI.__require;

var libs = require('./libs.js');
var EOM_Panel = require('./EOM_Panel.js');

const EOM_Tooltip = props => {
  const [local, others] = libs.splitProps(props, ["children"]);
  const resolved = libs.children(() => local.children);
  return (() => {
    const _el$ = libs.createElement("Panel", libs.mergeProps(() => EOM_Panel.EOMProps(others, {
      className: "EOM_Tooltip"
    })), null);
    libs.spread(_el$, libs.mergeProps(() => EOM_Panel.EOMProps(others, {
      className: "EOM_Tooltip"
    }), {
      "onactivate": () => {},
      "onload": self => {
        self.AddClass("EOM_PopupMainShow");
      }
    }), true);
    libs.insert(_el$, resolved);
    return _el$;
  })();
};
const EOM_TooltipHeader = props => {
  const [local, others] = libs.splitProps(props, ["children"]);
  const resolved = libs.children(() => local.children);
  return (() => {
    const _el$3 = libs.createElement("Panel", libs.mergeProps(() => EOM_Panel.EOMProps(others, {
      className: "EOM_TooltipHeader"
    })), null);
    libs.spread(_el$3, libs.mergeProps(() => EOM_Panel.EOMProps(others, {
      className: "EOM_TooltipHeader"
    })), true);
    libs.insert(_el$3, resolved);
    return _el$3;
  })();
};

exports.EOM_Tooltip = EOM_Tooltip;
exports.EOM_TooltipHeader = EOM_TooltipHeader;