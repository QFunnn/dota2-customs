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
var EOM_Tooltip = require('./EOM_Tooltip.js');
var EOM_Image = require('./EOM_Image.js');
var EOM_Label = require('./EOM_Label.js');
var GenericPanel = require('./GenericPanel.js');

let pTooltipPanel = $.GetContextPanel();
pTooltipPanel.style.minHeight = "0px";
function getPath() {
  return GameUI.CustomUIConfig().__warlock_path_tip ?? "";
}
function TooltipContents() {
  const p = getPath();
  if (!p) return null;
  const titleKV = KeyValues.AbilityUpgradesMechenicsKv[p + "_1"];
  const titleKey = titleKV?.title ? "#" + titleKV.title : "";
  const rows = [];
  for (let i = 1; i <= 4; i++) {
    const id = p + "_" + i;
    const kv = KeyValues.AbilityUpgradesMechenicsKv[id];
    if (!kv?.description) continue;
    const textrue = kv.textrue;
    let src = "file://{images}/spellicons/empty.png";
    if (textrue) {
      src = $.BImageFileExists("file://{images}/spellicons/" + textrue + ".png") ? "file://{images}/spellicons/" + textrue + ".png" : "raw://resource/flash3/images/spellicons/" + textrue + ".png";
    }
    rows.push({
      src,
      text: getAbilityUpgradeMechanicsDescriptionByID(id)
    });
  }
  if (rows.length === 0) return null;
  return libs.createComponent(EOM_Panel.EOM_Panel, {
    flowChildren: "down-wrap",
    get children() {
      return libs.createComponent(EOM_Tooltip.EOM_Tooltip, {
        width: "380px",
        flowChildren: "down",
        get children() {
          return [libs.createComponent(EOM_Tooltip.EOM_TooltipHeader, {
            flowChildren: "right",
            get children() {
              return libs.createComponent(EOM_Panel.EOM_Panel, {
                flowChildren: "down",
                marginLeft: "0px",
                height: "100%",
                get children() {
                  return libs.createComponent(GenericPanel.CLabel, {
                    id: "WarlockPathTitle",
                    html: true,
                    text: titleKey
                  });
                }
              });
            }
          }), libs.createComponent(EOM_Panel.EOM_Panel, {
            id: "WarlockPathRowList",
            get children() {
              return rows.map(row => libs.createComponent(EOM_Panel.EOM_Panel, {
                className: "WarlockPathRow",
                get children() {
                  return [libs.createComponent(EOM_Panel.EOM_Panel, {
                    className: "WarlockPathRowTitle",
                    get children() {
                      return libs.createComponent(EOM_Image.EOM_Image, {
                        className: "WarlockPathRowImage",
                        scaling: "stretch",
                        get src() {
                          return row.src;
                        }
                      });
                    }
                  }), libs.createComponent(EOM_Panel.EOM_Panel, {
                    className: "WarlockPathRowDescription",
                    get children() {
                      return libs.createComponent(EOM_Label.EOM_Label, {
                        id: "WarlockPathDescLabel",
                        html: true,
                        get text() {
                          return row.text;
                        }
                      });
                    }
                  })];
                }
              }));
            }
          })];
        }
      });
    }
  });
}
libs.render(() => libs.createComponent(TooltipContents, {}), pTooltipPanel);