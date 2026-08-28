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
var EOM_Image = require('./EOM_Image.js');
var EOM_Label = require('./EOM_Label.js');
var GenericPanel = require('./GenericPanel.js');

let pTooltipPanel = $.GetContextPanel();
pTooltipPanel.style.minHeight = "0px";
pTooltipPanel.FindAncestor("ladder_info").FindChildTraverse("LeftArrow").style.opacity = "0";
pTooltipPanel.FindAncestor("ladder_info").FindChildTraverse("RightArrow").style.opacity = "0";
pTooltipPanel.FindAncestor("ladder_info").FindChildTraverse("TopArrow").style.opacity = "0";
pTooltipPanel.FindAncestor("ladder_info").FindChildTraverse("BottomArrow").style.opacity = "0";
function TooltipContents() {
  return libs.createComponent(EOM_Panel.EOM_Panel, {
    get children() {
      return [libs.createComponent(EOM_Panel.EOM_Panel, {
        id: "Header",
        get children() {
          return libs.createComponent(GenericPanel.CLabel, {
            text: "#LadderInfo"
          });
        }
      }), libs.createComponent(EOM_Panel.EOM_Panel, {
        id: "Content",
        get children() {
          return [libs.createComponent(EOM_Panel.EOM_Panel, {
            horizontalAlign: "center",
            flowChildren: "right",
            get children() {
              return libs.createComponent(libs.For, {
                each: [1, 2, 3, 4, 5],
                children: index => {
                  return libs.createComponent(EOM_Panel.EOM_Panel, {
                    flowChildren: "down",
                    get children() {
                      return [libs.createComponent(EOM_Image.EOM_Image, {
                        className: "RankIcon",
                        get backgroundImage() {
                          return getImagePath("rank_score/j_rank_icon_0" + index + ".png");
                        }
                      }), libs.createComponent(EOM_Label.EOM_Label, {
                        className: "RankLabel",
                        horizontalAlign: "center",
                        text: "#RankTitle_" + index
                      })];
                    }
                  });
                }
              });
            }
          }), libs.createComponent(EOM_Panel.EOM_Panel, {
            marginTop: "10px",
            horizontalAlign: "center",
            flowChildren: "right",
            get children() {
              return libs.createComponent(libs.For, {
                each: [6, 7, 8, 0],
                children: index => {
                  return libs.createComponent(EOM_Panel.EOM_Panel, {
                    flowChildren: "down",
                    get children() {
                      return [libs.createComponent(EOM_Image.EOM_Image, {
                        className: "RankIcon",
                        get backgroundImage() {
                          return getImagePath("rank_score/j_rank_icon_0" + index + ".png");
                        }
                      }), libs.createComponent(EOM_Label.EOM_Label, {
                        className: "RankLabel",
                        horizontalAlign: "center",
                        text: "#RankTitle_" + index
                      })];
                    }
                  });
                }
              });
            }
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