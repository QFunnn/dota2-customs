--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 9d26fbd · 2026-08-07 04:51:43 UTC
  ~ auto-generated — do not edit
]]


'use strict'; const require = GameUI.__require;

var libs = require('./libs.js');
var EOM_Panel = require('./EOM_Panel.js');
var EOM_Tooltip = require('./EOM_Tooltip.js');
var EOM_Label = require('./EOM_Label.js');
var GenericPanel = require('./GenericPanel.js');
var SectIcon = require('./SectIcon.js');
require('./EOM_Image.js');

let pTooltipPanel = $.GetContextPanel();
pTooltipPanel.style.minHeight = "0px";
pTooltipPanel.FindAncestor("sect_ability").FindChildTraverse("LeftArrow").style.opacity = "0";
pTooltipPanel.FindAncestor("sect_ability").FindChildTraverse("RightArrow").style.opacity = "0";
pTooltipPanel.FindAncestor("sect_ability").FindChildTraverse("TopArrow").style.opacity = "0";
pTooltipPanel.FindAncestor("sect_ability").FindChildTraverse("BottomArrow").style.opacity = "0";
function TooltipContents(props) {
  const {
    abilityUpgradeID
  } = props;
  const abilityUpgradeInfo = KeyValues.AbilityUpgradesKv[abilityUpgradeID];
  const lore = replaceBuffEnum($.Localize("#DOTA_Tooltip_ability_mechanics_" + abilityUpgradeID + "_Lore"));
  const sectList = abilityUpgradeInfo.sect.split("|");
  let abilityList = [];
  let keywordList = [];
  let infoList = [];
  let list = getKeyWordList($.Localize(`#DOTA_Tooltip_ability_mechanics_${abilityUpgradeID}_description`));
  for (let i = 0; i < list.length; i++) {
    switch (list[i].type) {
      case "Ability":
        abilityList.push(list[i].value);
        break;
      case "KeyWord":
        keywordList.push(list[i].value);
        break;
      case "Info":
        infoList.push(list[i].value);
        break;
    }
  }
  return libs.createComponent(EOM_Panel.EOM_Panel, {
    flowChildren: "down",
    get children() {
      return [libs.createComponent(EOM_Tooltip.EOM_Tooltip, {
        width: "380px",
        flowChildren: "down",
        onload: () => {
          $.GetContextPanel().style.minHeight = "0px";
        },
        get children() {
          return [libs.createComponent(EOM_Tooltip.EOM_TooltipHeader, {
            flowChildren: "right",
            get children() {
              return [libs.createComponent(GenericPanel.CImage, {
                className: "SectAbilityImage",
                get src() {
                  return `file://{images}/spellicons/${abilityUpgradeInfo.Texture}.png`;
                }
              }), libs.createComponent(EOM_Panel.EOM_Panel, {
                flowChildren: "down",
                marginLeft: "8px",
                height: "100%",
                get children() {
                  return [libs.createComponent(GenericPanel.CLabel, {
                    id: "SectNameHeader",
                    html: true,
                    get text() {
                      return $.Localize("#DOTA_Tooltip_ability_mechanics_" + abilityUpgradeID);
                    }
                  }), libs.createComponent(EOM_Panel.EOM_Panel, {
                    flowChildren: "right",
                    verticalAlign: "bottom",
                    get children() {
                      return sectList.map((sectName, index) => {
                        return libs.createComponent(SectIcon.SectIcon, {
                          width: "28px",
                          height: "28px",
                          sectName: sectName
                        });
                      });
                    }
                  })];
                }
              })];
            }
          }), libs.createComponent(EOM_Panel.EOM_Panel, {
            className: "SectRow",
            flowChildren: "right",
            get children() {
              return libs.createComponent(GenericPanel.CLabel, {
                className: "SectDescription",
                html: true,
                get text() {
                  return getSectDescription(abilityUpgradeID, -1, false);
                }
              });
            }
          }), libs.memo(() => lore != "#DOTA_Tooltip_ability_mechanics_" + abilityUpgradeID + "_Lore" && libs.createComponent(EOM_Panel.EOM_Panel, {
            id: "LoreContainer",
            get children() {
              return libs.createComponent(GenericPanel.CLabel, {
                html: true,
                text: lore
              });
            }
          }))];
        }
      }), libs.memo(() => libs.memo(() => !!(keywordList.length > 0 || infoList.length > 0))() && libs.createComponent(EOM_Tooltip.EOM_Tooltip, {
        width: "380px",
        flowChildren: "down",
        get children() {
          return [libs.memo(() => libs.memo(() => keywordList.length > 0)() && libs.createComponent(KeyWordList, {
            keywordList: keywordList
          })), libs.memo(() => libs.memo(() => infoList.length > 0)() && libs.createComponent(InfoList, {
            keywordList: infoList,
            get marginTop() {
              return keywordList.length > 0 ? "4px" : "0px";
            }
          }))];
        }
      }))];
    }
  });
}
function KeyWordList(props) {
  return libs.createComponent(EOM_Panel.EOM_Panel, {
    width: "380px",
    flowChildren: "down",
    get children() {
      return props.keywordList.map((keyword, index) => {
        return libs.createComponent(EOM_Tooltip.EOM_TooltipHeader, {
          flowChildren: "down",
          marginTop: index == 0 ? "0px" : "4px",
          get children() {
            return [libs.createComponent(EOM_Label.EOM_Label, {
              html: true,
              fontSize: "18px",
              get text() {
                return replaceKeyword(`{KeyWord:${keyword}}`);
              }
            }), libs.createComponent(EOM_Label.EOM_Label, {
              html: true,
              fontSize: "16px",
              marginTop: "2px",
              get text() {
                return replaceAll($.Localize("#KeyWord_" + keyword + "_description"));
              }
            })];
          }
        });
      });
    }
  });
}
function InfoList({
  keywordList,
  marginTop
}) {
  keywordList = removeRepeatKeyword(keywordList);
  return libs.createComponent(EOM_Panel.EOM_Panel, {
    width: "100%",
    flowChildren: "down",
    get children() {
      return keywordList.map((keyword, index) => {
        return libs.createComponent(EOM_Tooltip.EOM_TooltipHeader, {
          flowChildren: "down",
          marginTop: index == 0 ? marginTop : "4px",
          get children() {
            return [libs.createComponent(EOM_Label.EOM_Label, {
              html: true,
              fontSize: "18px",
              text: "#" + keyword
            }), libs.createComponent(EOM_Label.EOM_Label, {
              html: true,
              fontSize: "16px",
              marginTop: "2px",
              get text() {
                return replaceAll($.Localize("#" + keyword + "_description"));
              }
            })];
          }
        });
      });
    }
  });
}
function removeRepeatKeyword(keywordList) {
  var newList = [];
  for (const keyword of keywordList) {
    if (newList.indexOf(keyword) == -1) {
      newList.push(keyword);
    }
  }
  return newList;
}
function SetupTooltip() {
  let abilityUpgradeID = pTooltipPanel.GetAttributeString("abilityUpgradeID", "");
  libs.render(() => libs.createComponent(TooltipContents, {
    abilityUpgradeID: abilityUpgradeID
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