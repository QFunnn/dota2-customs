--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build b9dc48c · 2026-08-02 17:42:46 UTC
  ~ auto-generated — do not edit
]]


'use strict'; const exports = {}; GameUI.__loadModule('BubbleBox', exports); const require = GameUI.__require;

var libs = require('./libs.js');
var EOM_Panel = require('./EOM_Panel.js');

const EOMBubbleBox = props => {
  const [local, others] = libs.splitProps(props, ["children"]);
  const resolved = libs.children(() => local.children);
  return libs.createComponent(EOM_Panel.EOM_Panel, {
    get className() {
      return libs.classNames("EOMBubbleBox");
    },
    get children() {
      return [libs.createComponent(EOM_Panel.EOM_Panel, {
        className: "EOMBubbleBoxBg",
        get children() {
          return [(() => {
            const _el$ = libs.createElement("Panel", {}, null);
            libs.setProp(_el$, "className", "EOMBubbleBoxBg_LeftTopBG");
            return _el$;
          })(), (() => {
            const _el$2 = libs.createElement("Panel", {}, null);
            libs.setProp(_el$2, "className", "EOMBubbleBoxBg_CenterTopBG");
            return _el$2;
          })(), (() => {
            const _el$3 = libs.createElement("Panel", {}, null);
            libs.setProp(_el$3, "className", "EOMBubbleBoxBg_RightTopBG");
            return _el$3;
          })(), (() => {
            const _el$4 = libs.createElement("Panel", {}, null);
            libs.setProp(_el$4, "className", "EOMBubbleBoxBg_LeftCenterBG");
            return _el$4;
          })(), (() => {
            const _el$5 = libs.createElement("Panel", {}, null);
            libs.setProp(_el$5, "className", "EOMBubbleBoxBg_CenterCenterBG");
            return _el$5;
          })(), (() => {
            const _el$6 = libs.createElement("Panel", {}, null);
            libs.setProp(_el$6, "className", "EOMBubbleBoxBg_RightCenterBG");
            return _el$6;
          })(), (() => {
            const _el$7 = libs.createElement("Panel", {}, null);
            libs.setProp(_el$7, "className", "EOMBubbleBoxBg_LeftBottomBG");
            return _el$7;
          })(), (() => {
            const _el$8 = libs.createElement("Panel", {}, null);
            libs.setProp(_el$8, "className", "EOMBubbleBoxBg_CenterBottomBG");
            return _el$8;
          })(), (() => {
            const _el$9 = libs.createElement("Panel", {}, null);
            libs.setProp(_el$9, "className", "EOMBubbleBoxBg_RightBottomBG");
            return _el$9;
          })()];
        }
      }), libs.createComponent(EOM_Panel.EOM_Panel, libs.mergeProps(() => EOM_Panel.EOMProps(others, {
        className: libs.classNames("EOMBubbleBox_Content")
      }), {
        get children() {
          return resolved();
        }
      }))];
    }
  });
};

exports.EOMBubbleBox = EOMBubbleBox;