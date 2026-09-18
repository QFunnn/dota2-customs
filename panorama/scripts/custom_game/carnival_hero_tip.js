--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build c158db4 
  ~ auto-generated — do not edit
]]


'use strict'; const require = GameUI.__require;

var libs = require('./libs.js');
var EOM_Panel = require('./EOM_Panel.js');
var EOM_Label = require('./EOM_Label.js');

const tooltipPanel = $.GetContextPanel();
const CarnivalHeroTip = () => libs.createComponent(EOM_Panel.EOM_Panel, {
  id: "CarnivalHeroTip",
  hittest: false,
  hittestchildren: false,
  get children() {
    return libs.createComponent(EOM_Panel.EOM_Panel, {
      className: "CarnivalHeroTipText",
      get children() {
        return [libs.createComponent(EOM_Label.EOM_Label, {
          text: "#carnival_entry_tip_rewards"
        }), libs.createComponent(EOM_Label.EOM_Label, {
          text: "#carnival_entry_tip_day14"
        })];
      }
    });
  }
});
const setupTooltip = () => {
  libs.render(() => libs.createComponent(CarnivalHeroTip, {}), tooltipPanel);
};
tooltipPanel.SetPanelEvent("ontooltiploaded", setupTooltip);
const tooltipRoot = tooltipPanel.FindAncestor("carnival_hero_tip");
for (const arrowName of ["LeftArrow", "RightArrow", "TopArrow", "BottomArrow"]) {
  const arrow = tooltipRoot?.FindChildTraverse(arrowName);
  if (arrow) arrow.style.opacity = "0";
}