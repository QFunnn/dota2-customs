--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 0b85d8d 
  ~ auto-generated — do not edit
]]


'use strict'; const require = GameUI.__require;

var libs = require('./libs.js');
var EOM_Panel = require('./EOM_Panel.js');
var EOM_Label = require('./EOM_Label.js');
var HotKeyIcon = require('./HotKeyIcon.js');
require('./GenericPanel.js');

let pTooltipPanel = $.GetContextPanel();
pTooltipPanel.style.minHeight = "10px";
pTooltipPanel.FindAncestor("hotkey_tip").FindChildTraverse("LeftArrow").style.opacity = "0";
pTooltipPanel.FindAncestor("hotkey_tip").FindChildTraverse("RightArrow").style.opacity = "0";
pTooltipPanel.FindAncestor("hotkey_tip").FindChildTraverse("TopArrow").style.opacity = "0";
pTooltipPanel.FindAncestor("hotkey_tip").FindChildTraverse("BottomArrow").style.opacity = "0";
function TooltipContents({
  hotkey
}) {
  return libs.createComponent(EOM_Panel.EOM_Panel, {
    align: 'center center',
    flowChildren: "right-wrap",
    get children() {
      return hotkey == "" ? libs.createComponent(EOM_Label.EOM_Label, {
        text: "#Emoji_HotKeyNone"
      }) : libs.memo(() => {
        let labels = $.Localize("#Emoji_HotKey").split("${key}");
        if (labels.length == 2) {
          const label1 = labels[0];
          const label2 = labels[1];
          return [libs.createComponent(EOM_Label.EOM_Label, {
            text: label1
          }), libs.createComponent(HotKeyIcon.HotKeyIcon, {
            text: hotkey
          }), libs.createComponent(EOM_Label.EOM_Label, {
            text: label2
          })];
        } else {
          return libs.createComponent(EOM_Label.EOM_Label, {
            get text() {
              return $.Localize("#Emoji_HotKey").replace("${key}", `<font color='#FFEF83'>[${hotkey}]</font>`);
            }
          });
        }
      });
    }
  });
}
function SetupTooltip() {
  let hotkey = pTooltipPanel.GetAttributeString("hotkey", "");
  libs.render(() => libs.createComponent(TooltipContents, {
    hotkey: hotkey
  }), pTooltipPanel);
}
(function () {
  pTooltipPanel.SetPanelEvent("ontooltiploaded", SetupTooltip);
  {
    let pArrow = pTooltipPanel.GetParent()?.FindChildTraverse("LeftArrow");
    if (pArrow) {
      pArrow.style.washColor = "#12141a";
      pArrow.style.zIndex = -1;
    }
    pArrow = pTooltipPanel.GetParent()?.FindChildTraverse("RightArrow");
    if (pArrow) {
      pArrow.style.washColor = "#12141a";
      pArrow.style.zIndex = -1;
    }
  }
  {
    let pArrow = pTooltipPanel.GetParent()?.GetParent()?.FindChildTraverse("TopArrow");
    if (pArrow) {
      pArrow.style.washColor = "#12141a";
    }
    pArrow = pTooltipPanel.GetParent()?.GetParent()?.FindChildTraverse("BottomArrow");
    if (pArrow) {
      pArrow.style.washColor = "#12141a";
    }
  }
  pTooltipPanel.style.minHeight = "10px";
})();