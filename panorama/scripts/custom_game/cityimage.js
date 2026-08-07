--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 9d26fbd · 2026-08-07 04:51:43 UTC
  ~ auto-generated — do not edit
]]


'use strict'; const exports = {}; GameUI.__loadModule('CityImage', exports); const require = GameUI.__require;

var libs = require('./libs.js');
var EOM_Panel = require('./EOM_Panel.js');

const CityImage = props => {
  const merged = libs.mergeProps$1({
    size: "normal"
  }, props);
  const [local, others] = libs.splitProps(merged, ["city_name", "size", "show_tooltip", "children"]);
  return (() => {
    const _el$ = libs.createElement("Image", libs.mergeProps(() => EOM_Panel.EOMProps(others, {
      className: libs.classNames("CityImage", local.size)
    }), {
      get src() {
        return getSrcPath(`city_land/icon_${(KeyValues.CityEffectKv[local.city_name]?.LandType ?? "") + (local.size == "normal" ? "_small" : "")}.png`);
      }
    }), null);
    libs.spread(_el$, libs.mergeProps(() => EOM_Panel.EOMProps(others, {
      className: libs.classNames("CityImage", local.size)
    }), {
      get src() {
        return getSrcPath(`city_land/icon_${(KeyValues.CityEffectKv[local.city_name]?.LandType ?? "") + (local.size == "normal" ? "_small" : "")}.png`);
      }
    }), false);
    return _el$;
  })();
};

exports.CityImage = CityImage;