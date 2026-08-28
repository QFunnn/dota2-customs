--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 0b85d8d 
  ~ auto-generated — do not edit
]]


'use strict'; const exports = {}; GameUI.__loadModule('EOM_XP', exports); const require = GameUI.__require;

var libs = require('./libs.js');
var GenericPanel = require('./GenericPanel.js');
var EOM_Panel = require('./EOM_Panel.js');

const EOM_XP = props => {
  const merged = libs.mergeProps$1({
    type: EOM_Panel.ADDON_NAME,
    level: 1,
    maxLevel: 100,
    exp: 100,
    maxExp: 100
  }, props);
  const [local, others] = libs.splitProps(merged, ["children", "level", "maxLevel", "exp", "maxExp", "type"]);
  let deg = 0;
  if (local.maxExp != 0) {
    deg = Math.max(0, 360 * (local.exp ?? 0) / Math.max(1, local.maxExp ?? 1));
  }
  return (() => {
    const _el$ = libs.createElement("Panel", libs.mergeProps(() => EOM_Panel.EOMProps(others, {
      className: libs.classNames("EOM_XP", local.type)
    })), null);
    libs.spread(_el$, libs.mergeProps(() => EOM_Panel.EOMProps(others, {
      className: libs.classNames("EOM_XP", local.type)
    })), true);
    libs.insert(_el$, libs.createComponent(GenericPanel.CImage, {
      className: "EOM_XPBorder",
      style: {
        clip: `radial( 50.0% 50.0%, 0.0deg, ${deg}deg)`
      }
    }), null);
    libs.insert(_el$, libs.createComponent(GenericPanel.CLabel, {
      className: "EOM_XPLabel",
      get text() {
        return libs.memo(() => local.level == local.maxLevel)() ? "MAX" : String(local.level);
      }
    }), null);
    return _el$;
  })();
};

exports.EOM_XP = EOM_XP;