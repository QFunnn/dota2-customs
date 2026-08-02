--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build b9dc48c · 2026-08-02 17:42:46 UTC
  ~ auto-generated — do not edit
]]


'use strict'; const require = GameUI.__require;

var libs = require('./libs.js');
var EOM_Panel = require('./EOM_Panel.js');
var EOM_Label = require('./EOM_Label.js');

let pTooltipPanel = $.GetContextPanel();
function TooltipContents(props) {
  return libs.createComponent(EOM_Panel.EOM_Panel, {
    get children() {
      const _el$ = libs.createElement("Panel", {
        id: "CustomContents"
      }, null);
      libs.insert(_el$, libs.createComponent(EOM_Label.EOM_Label, {
        get text() {
          return props.text;
        },
        html: true
      }));
      return _el$;
    }
  });
}
function SetupTooltip() {
  libs.render(() => libs.createComponent(TooltipContents, {
    get text() {
      return pTooltipPanel.GetAttributeString("text", "");
    }
  }), pTooltipPanel);
}
(function () {
  pTooltipPanel.SetPanelEvent("ontooltiploaded", SetupTooltip);
})();