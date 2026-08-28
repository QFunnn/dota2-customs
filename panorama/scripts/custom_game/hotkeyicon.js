--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 0b85d8d 
  ~ auto-generated — do not edit
]]


'use strict'; const exports = {}; GameUI.__loadModule('HotKeyIcon', exports); const require = GameUI.__require;

var libs = require('./libs.js');
var EOM_Panel = require('./EOM_Panel.js');
var GenericPanel = require('./GenericPanel.js');

const HotKeyIcon = props => {
  const [local, others] = libs.splitProps(props, ["text", "children"]);
  const resolved = libs.children(() => local.children);
  return (() => {
    const _el$ = libs.createElement("Panel", libs.mergeProps(() => EOM_Panel.EOMProps(others, {
      className: "HotKeyIcon"
    })), null);
    libs.spread(_el$, libs.mergeProps(() => EOM_Panel.EOMProps(others, {
      className: "HotKeyIcon"
    })), true);
    libs.insert(_el$, libs.createComponent(GenericPanel.CLabel, {
      get text() {
        return local.text;
      }
    }), null);
    libs.insert(_el$, resolved, null);
    return _el$;
  })();
};

exports.HotKeyIcon = HotKeyIcon;