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
var EOM_Icon = require('./EOM_Icon.js');
var EOM_Label = require('./EOM_Label.js');

let pTooltipPanel = $.GetContextPanel();
pTooltipPanel.style.minHeight = "0px";
function TooltipContents(props) {
  return libs.createComponent(EOM_Panel.EOM_Panel, {
    id: "ProficiencyTooltipContainer",
    get children() {
      return [libs.createComponent(EOM_Icon.EOM_Icon, {
        width: '50px',
        height: '50px',
        get src() {
          return getSrcPath("icon/medal.png");
        }
      }), libs.createComponent(EOM_Label.EOM_Label, {
        get text() {
          return props.value;
        }
      })];
    }
  });
}
function SetupTooltip() {
  let value = pTooltipPanel.GetAttributeInt("value", 0);
  libs.render(() => libs.createComponent(TooltipContents, {
    value: value
  }), pTooltipPanel);
}
(function () {
  pTooltipPanel.SetPanelEvent("ontooltiploaded", SetupTooltip);
  {
    let pArrow = pTooltipPanel.GetParent()?.FindChildTraverse("LeftArrow");
    if (pArrow) {
      pArrow.style.washColor = "#353861";
    }
    pArrow = pTooltipPanel.GetParent()?.FindChildTraverse("RightArrow");
    if (pArrow) {
      pArrow.style.washColor = "#353861";
    }
  }
  {
    let pArrow = pTooltipPanel.GetParent()?.GetParent()?.FindChildTraverse("TopArrow");
    if (pArrow) {
      pArrow.style.backgroundImage = 'url("file://{images}/custom_game/proficiency_icon/s6_tooltip_arrow.png")';
      pArrow.style.washColor = "#ffffff";
    }
    pArrow = pTooltipPanel.GetParent()?.GetParent()?.FindChildTraverse("BottomArrow");
    if (pArrow) {
      pArrow.style.washColor = "#353861";
    }
  }
  pTooltipPanel.style.minHeight = "50px";
})();