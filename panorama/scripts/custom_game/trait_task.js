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
var EOM_Tooltip = require('./EOM_Tooltip.js');
var EOM_Icon = require('./EOM_Icon.js');
var EOM_Label = require('./EOM_Label.js');
var GenericPanel = require('./GenericPanel.js');

let pTooltipPanel = $.GetContextPanel();
pTooltipPanel.style.minHeight = "0px";
pTooltipPanel.FindAncestor("trait_task").FindChildTraverse("LeftArrow").style.opacity = "0";
pTooltipPanel.FindAncestor("trait_task").FindChildTraverse("RightArrow").style.opacity = "0";
pTooltipPanel.FindAncestor("trait_task").FindChildTraverse("TopArrow").style.opacity = "0";
pTooltipPanel.FindAncestor("trait_task").FindChildTraverse("BottomArrow").style.opacity = "0";
function TooltipContents(props) {
  const {
    playerID
  } = props;
  const runeTaskData = CustomNetTables.GetTableValue("common", "rune_task_" + playerID);
  let showRuneTaskProgess = Players.GetLocalPlayer() == playerID || isSpectator();
  const runeTaskList = (() => {
    let list = [];
    const data = runeTaskData;
    if (data) {
      for (const key in data) {
        const v = data[key];
        list.push({
          id: v.id,
          progress: v.progress,
          finish: v.finish == 1
        });
      }
    }
    return list;
  })();
  return libs.createComponent(EOM_Panel.EOM_Panel, {
    flowChildren: "down",
    get children() {
      return libs.memo(() => runeTaskList.length > 0)() && libs.createComponent(EOM_Tooltip.EOM_Tooltip, {
        flowChildren: "down",
        onload: () => {
          $.GetContextPanel().style.minHeight = "0px";
        },
        get children() {
          return [libs.createComponent(EOM_Tooltip.EOM_TooltipHeader, {
            flowChildren: "right",
            get children() {
              return libs.createComponent(GenericPanel.CLabel, {
                text: "#GameState_RuneTask"
              });
            }
          }), libs.memo(() => runeTaskList.map((data, i) => {
            const taskType = KeyValues.RuneTaskKV[data.id]?.type ?? "none";
            const target = KeyValues.RuneTaskKV[data.id]?.target ?? -1;
            return libs.createComponent(EOM_Panel.EOM_Panel, {
              get className() {
                return libs.classNames("RuneTaskInfo", {
                  finish: showRuneTaskProgess && data.finish
                });
              },
              get children() {
                return [libs.createComponent(EOM_Panel.EOM_Panel, {
                  id: "RuneTaskDesc",
                  get children() {
                    return [libs.createComponent(libs.Show, {
                      when: showRuneTaskProgess,
                      get children() {
                        return libs.createComponent(EOM_Label.EOM_Label, {
                          id: "RuneTaskProgress",
                          get text() {
                            return `(${data.progress}/${target})`;
                          }
                        });
                      }
                    }), libs.createComponent(EOM_Label.EOM_Label, {
                      id: "RuneTaskDescription",
                      text: "#RuneTask_" + taskType + "_description",
                      dialogVariables: {
                        target: target
                      },
                      html: true
                    })];
                  }
                }), libs.createComponent(libs.Show, {
                  get when() {
                    return showRuneTaskProgess && data.finish;
                  },
                  get children() {
                    return libs.createComponent(EOM_Icon.EOM_Icon, {
                      id: "finishIcon",
                      size: "32",
                      get src() {
                        return getSrcPath("icon/selected.png");
                      }
                    });
                  }
                })];
              }
            });
          }))];
        }
      });
    }
  });
}
function SetupTooltip() {
  let playerID = pTooltipPanel.GetAttributeInt("playerID", -1);
  libs.render(() => libs.createComponent(TooltipContents, {
    playerID: playerID
  }), pTooltipPanel);
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