--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 16fdfbc · 2026-08-07 21:47:55 UTC
  ~ auto-generated — do not edit
]]


'use strict'; const exports = {}; GameUI.__loadModule('EOM_Label', exports); const require = GameUI.__require;

var libs = require('./libs.js');
var EOM_Panel = require('./EOM_Panel.js');

const EOM_Label = props => {
  const [local, others] = libs.splitProps(props, ["children", "fontSize", "fontFamily", "color", "type", "textDecoration", "textShadow", "textOverflow"]);
  const resolved = libs.children(() => local.children);
  return (() => {
    const _el$ = libs.createElement("Label", libs.mergeProps(() => EOM_Panel.EOMProps(others, {
      className: libs.classNames("EOM_Label", {
        EOM_LabelTitle: local.type == "Title",
        EOM_LabelNormal: local.type == "Normal",
        EOM_LabelMoney: local.type == "Money",
        EOM_LabelTip: local.type == "Tip"
      }),
      style: {
        fontSize: local.fontSize,
        fontFamily: local.fontFamily,
        color: local.color,
        textShadow: local.textShadow,
        textDecoration: local.textDecoration,
        textOverflow: local.textOverflow
      }
    })), null);
    libs.spread(_el$, libs.mergeProps(() => EOM_Panel.EOMProps(others, {
      className: libs.classNames("EOM_Label", {
        EOM_LabelTitle: local.type == "Title",
        EOM_LabelNormal: local.type == "Normal",
        EOM_LabelMoney: local.type == "Money",
        EOM_LabelTip: local.type == "Tip"
      }),
      style: {
        fontSize: local.fontSize,
        fontFamily: local.fontFamily,
        color: local.color,
        textShadow: local.textShadow,
        textDecoration: local.textDecoration,
        textOverflow: local.textOverflow
      }
    })), true);
    libs.insert(_el$, resolved);
    return _el$;
  })();
};

exports.EOM_Label = EOM_Label;