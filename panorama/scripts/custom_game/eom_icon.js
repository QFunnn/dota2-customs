--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build b9dc48c · 2026-08-02 17:42:46 UTC
  ~ auto-generated — do not edit
]]


'use strict'; const exports = {}; GameUI.__loadModule('EOM_Icon', exports); const require = GameUI.__require;

var libs = require('./libs.js');
var EOM_Panel = require('./EOM_Panel.js');

const EOM_Icon = props => {
  const merged = libs.mergeProps$1({
    size: "32"
  }, props);
  const [local, others] = libs.splitProps(merged, ["children", "rotate", "spin", "spinDirection", "spinDuration", "shadow", "size", "type", "extraType"]);
  const resolved = libs.children(() => local.children);
  return (() => {
    const _el$ = libs.createElement("Image", libs.mergeProps(() => EOM_Panel.EOMProps(others, {
      className: libs.classNames("EOM_Icon", {
        ["EOM_Icon" + local.type]: local.type != undefined
      }, local.extraType, "Size" + merged.size, {
        EOM_IconSpin: local.spin || local.spinDuration,
        EOM_IconShadow: local.shadow
      }),
      style: {
        preTransformRotate2d: local.rotate != undefined ? local.rotate + "deg" : undefined,
        animationDuration: local.spinDuration != undefined ? local.spinDuration + "s" : undefined,
        animationDirection: local.spinDirection
      }
    })), null);
    libs.spread(_el$, libs.mergeProps(() => EOM_Panel.EOMProps(others, {
      className: libs.classNames("EOM_Icon", {
        ["EOM_Icon" + local.type]: local.type != undefined
      }, local.extraType, "Size" + merged.size, {
        EOM_IconSpin: local.spin || local.spinDuration,
        EOM_IconShadow: local.shadow
      }),
      style: {
        preTransformRotate2d: local.rotate != undefined ? local.rotate + "deg" : undefined,
        animationDuration: local.spinDuration != undefined ? local.spinDuration + "s" : undefined,
        animationDirection: local.spinDirection
      }
    })), true);
    libs.insert(_el$, resolved);
    return _el$;
  })();
};

exports.EOM_Icon = EOM_Icon;