--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 9d26fbd · 2026-08-07 04:51:43 UTC
  ~ auto-generated — do not edit
]]


'use strict'; const exports = {}; GameUI.__loadModule('SectIcon', exports); const require = GameUI.__require;

var libs = require('./libs.js');
var EOM_Image = require('./EOM_Image.js');
var EOM_Panel = require('./EOM_Panel.js');

const SectIcon = props => {
  const merged = libs.mergeProps$1({
    active: true,
    large: false
  }, props);
  const [local, others] = libs.splitProps(merged, ["children", "sectName", "active", "large"]);
  return (() => {
    const _el$ = libs.createElement("Panel", libs.mergeProps(() => EOM_Panel.EOMProps(others, {
      className: libs.classNames("SectIcon", local.sectName, {
        Active: local.active,
        Large: local.large
      })
    })), null);
    libs.spread(_el$, libs.mergeProps(() => EOM_Panel.EOMProps(others, {
      className: libs.classNames("SectIcon", local.sectName, {
        Active: local.active,
        Large: local.large
      })
    })), true);
    libs.insert(_el$, libs.createComponent(EOM_Image.EOM_Image, {
      className: "SectImage"
    }));
    return _el$;
  })();
};

exports.SectIcon = SectIcon;