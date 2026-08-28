--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 0b85d8d 
  ~ auto-generated — do not edit
]]


'use strict'; const exports = {}; GameUI.__loadModule('EOM_ProgressBar', exports); const require = GameUI.__require;

var libs = require('./libs.js');
var EOM_Panel = require('./EOM_Panel.js');

const EOM_ProgressBar = props => {
  const merged = libs.mergeProps$1({
    value: 0,
    min: 0,
    max: 100
  }, props);
  const [local, others] = libs.splitProps(merged, ["children", "value", "min", "max"]);
  const resolved = libs.children(() => local.children);
  const width = libs.createMemo(() => {
    return local.max == 0 ? 100 : (local.value - local.min) / (local.max - local.min) * 100;
  });
  return (() => {
    const _el$ = libs.createElement("Panel", libs.mergeProps(() => EOM_Panel.EOMProps(others, {
      className: "EOM_ProgressBar"
    })), null);
    libs.spread(_el$, libs.mergeProps(() => EOM_Panel.EOMProps(others, {
      className: "EOM_ProgressBar"
    })), true);
    libs.insert(_el$, libs.createComponent(EOM_Panel.EOM_Panel, {
      className: "EOM_ProgressBar_Left",
      get width() {
        return width() + "%";
      }
    }), null);
    libs.insert(_el$, libs.createComponent(EOM_Panel.EOM_Panel, {
      className: "EOM_ProgressBar_Right",
      get width() {
        return 100 - width() + "%";
      }
    }), null);
    libs.insert(_el$, resolved, null);
    return _el$;
  })();
};

exports.EOM_ProgressBar = EOM_ProgressBar;