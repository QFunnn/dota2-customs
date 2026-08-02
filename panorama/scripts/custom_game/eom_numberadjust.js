--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build b9dc48c · 2026-08-02 17:42:46 UTC
  ~ auto-generated — do not edit
]]


'use strict'; const exports = {}; GameUI.__loadModule('EOM_NumberAdjust', exports); const require = GameUI.__require;

var libs = require('./libs.js');
var EOM_Panel = require('./EOM_Panel.js');

const EOM_NumberAdjust = props => {
  const [local, others] = libs.splitProps(props, ["children", "value", "onChange", "onvaluechanged"]);
  const [value, setValue] = libs.createSignal(local.value);
  return (() => {
    const _el$ = libs.createElement("NumberEntry", libs.mergeProps(() => EOM_Panel.EOMProps(others, {
      className: "EOM_NumberAdjust"
    })), null);
    libs.spread(_el$, libs.mergeProps(() => EOM_Panel.EOMProps(others, {
      className: "EOM_NumberAdjust"
    }), {
      "onload": self => {
        if (local.value) {
          self.value = local.value;
        }
      },
      "onvaluechanged": self => {
        if (local.onvaluechanged) {
          local.onvaluechanged(self);
        }
        if (local.onChange) {
          local.onChange(self, value(), self.value);
        }
        setValue(self.value);
      }
    }), true);
    libs.insert(_el$, () => local.children);
    return _el$;
  })();
};

exports.EOM_NumberAdjust = EOM_NumberAdjust;