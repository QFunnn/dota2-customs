--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 16fdfbc · 2026-08-07 21:47:55 UTC
  ~ auto-generated — do not edit
]]


'use strict'; const require = GameUI.__require;

var libs = require('./libs.js');
var EOM_Panel = require('./EOM_Panel.js');
var GenericPanel = require('./GenericPanel.js');
var MedalBadgeIcon = require('./MedalBadgeIcon.js');

let pTooltipPanel = $.GetContextPanel();
pTooltipPanel.style.minHeight = "0px";
pTooltipPanel.FindAncestor("medal_info").FindChildTraverse("LeftArrow").style.opacity = "0";
pTooltipPanel.FindAncestor("medal_info").FindChildTraverse("RightArrow").style.opacity = "0";
pTooltipPanel.FindAncestor("medal_info").FindChildTraverse("TopArrow").style.opacity = "0";
pTooltipPanel.FindAncestor("medal_info").FindChildTraverse("BottomArrow").style.opacity = "0";
function TooltipContents() {
  return libs.createComponent(EOM_Panel.EOM_Panel, {
    get children() {
      return [libs.createComponent(EOM_Panel.EOM_Panel, {
        id: "Header",
        get children() {
          return libs.createComponent(GenericPanel.CLabel, {
            text: "#ProfileBadge"
          });
        }
      }), libs.createComponent(EOM_Panel.EOM_Panel, {
        id: "Content",
        get children() {
          return [libs.createComponent(EOM_Panel.EOM_Panel, {
            flowChildren: 'right-wrap',
            width: '100%',
            get children() {
              return libs.createComponent(libs.For, {
                get each() {
                  return Object.keys(KeyValues.MedalConfigKv);
                },
                children: (i, index) => {
                  return libs.createComponent(EOM_Panel.EOM_Panel, {
                    flowChildren: 'down',
                    get children() {
                      return [libs.createComponent(MedalBadgeIcon.MedalBadgeIcon, {
                        get medal_count() {
                          return KeyValues.MedalConfigKv[i].medal;
                        }
                      }), libs.createComponent(GenericPanel.CLabel, {
                        "class": 'MedalRequire',
                        get text() {
                          return KeyValues.MedalConfigKv[i].medal;
                        }
                      })];
                    }
                  });
                }
              });
            }
          }), libs.createComponent(GenericPanel.CLabel, {
            id: "Desc",
            text: "#ProfileBadge_Desc"
          })];
        }
      })];
    }
  });
}
function SetupTooltip() {
  libs.render(() => libs.createComponent(TooltipContents, {}), pTooltipPanel);
}
(function () {
  pTooltipPanel.SetPanelEvent("ontooltiploaded", SetupTooltip);
  {
    let pArrow = pTooltipPanel.GetParent()?.FindChildTraverse("LeftArrow");
    if (pArrow) {
      pArrow.style.washColor = "#12141a";
    }
    pArrow = pTooltipPanel.GetParent()?.FindChildTraverse("RightArrow");
    if (pArrow) {
      pArrow.style.washColor = "#12141a";
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
  pTooltipPanel.style.minHeight = "150px";
})();