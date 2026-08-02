--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build b9dc48c · 2026-08-02 17:42:46 UTC
  ~ auto-generated — do not edit
]]


'use strict'; const exports = {}; GameUI.__loadModule('EOM_Image', exports); const require = GameUI.__require;

var libs = require('./libs.js');
var EOM_Panel = require('./EOM_Panel.js');

const EOM_Image = props => {
  const [local, others] = libs.splitProps(props, ["children", "rotate"]);
  const resolved = libs.children(() => local.children);
  return (() => {
    const _el$ = libs.createElement("Image", libs.mergeProps(() => EOM_Panel.EOMProps(others, {
      className: "EOM_Image",
      style: {
        preTransformRotate2d: local.rotate != undefined ? local.rotate + "deg" : undefined
      }
    })), null);
    libs.spread(_el$, libs.mergeProps(() => EOM_Panel.EOMProps(others, {
      className: "EOM_Image",
      style: {
        preTransformRotate2d: local.rotate != undefined ? local.rotate + "deg" : undefined
      }
    })), true);
    libs.insert(_el$, resolved);
    return _el$;
  })();
};

exports.EOM_Image = EOM_Image;