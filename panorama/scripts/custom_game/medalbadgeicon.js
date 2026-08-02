--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build b9dc48c · 2026-08-02 17:42:46 UTC
  ~ auto-generated — do not edit
]]


'use strict'; const exports = {}; GameUI.__loadModule('MedalBadgeIcon', exports); const require = GameUI.__require;

var libs = require('./libs.js');
var EOM_Panel = require('./EOM_Panel.js');
var GenericPanel = require('./GenericPanel.js');

const MedalBadgeIcon = props => {
  const merged = libs.mergeProps$1({
    size: "200"
  }, props);
  const [local, others] = libs.splitProps(merged, ["medal_count", "size", "children"]);
  const medalInfo = libs.createMemo(() => {
    return getMedalInfo(local.medal_count);
  });
  const src = () => {
    if (local.size == "64") {
      return medalInfo().icon.replace("_png", "_smallest_png");
    }
    return medalInfo().icon;
  };
  return (() => {
    const _el$ = libs.createElement("Image", libs.mergeProps(() => EOM_Panel.EOMProps(others, {
      className: "MedalBadgeIcon"
    }), {
      get src() {
        return src();
      }
    }), null);
    libs.spread(_el$, libs.mergeProps(() => EOM_Panel.EOMProps(others, {
      className: "MedalBadgeIcon"
    }), {
      get src() {
        return src();
      }
    }), true);
    libs.insert(_el$, libs.createComponent(GenericPanel.CLabel, {
      get className() {
        return "Level" + medalInfo().level;
      },
      get text() {
        return medalInfo().star;
      }
    }));
    return _el$;
  })();
};

exports.MedalBadgeIcon = MedalBadgeIcon;