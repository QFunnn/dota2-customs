--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 9d26fbd · 2026-08-07 04:51:43 UTC
  ~ auto-generated — do not edit
]]


'use strict'; const require = GameUI.__require;

var libs = require('./libs.js');
var CityDescription = require('./CityDescription.js');
var CityImage = require('./CityImage.js');
var EOM_Panel = require('./EOM_Panel.js');
var EOM_Tooltip = require('./EOM_Tooltip.js');
var EOM_Label = require('./EOM_Label.js');
var GenericPanel = require('./GenericPanel.js');

let pTooltipPanel = $.GetContextPanel();
pTooltipPanel.style.minHeight = "0px";
pTooltipPanel.FindAncestor("city_effect").FindChildTraverse("LeftArrow").style.opacity = "0";
pTooltipPanel.FindAncestor("city_effect").FindChildTraverse("RightArrow").style.opacity = "0";
pTooltipPanel.FindAncestor("city_effect").FindChildTraverse("TopArrow").style.opacity = "0";
pTooltipPanel.FindAncestor("city_effect").FindChildTraverse("BottomArrow").style.opacity = "0";
let bAltDown = GameUI.IsAltDown();
function Update() {
  if (GameUI.IsAltDown() != bAltDown) {
    bAltDown = GameUI.IsAltDown();
    SetupTooltip();
  }
  if (pTooltipPanel.IsValid()) {
    $.Schedule(Game.GetGameFrameTime(), Update);
  }
}
function TooltipContents(props) {
  const {
    abilityName,
    entIndex
  } = props;
  const getKeyWordList = str => {
    let arr = [];
    str.replace(/{KeyWord:(\w+?)}/g, (a, b, c) => {
      arr.push(b);
      return b;
    });
    return arr;
  };
  const getInfoList = str => {
    let arr = [];
    str.replace(/{Info:(\w+?)}/g, (a, b, c) => {
      arr.push(b);
      return b;
    });
    return arr;
  };
  const keywordList = getKeyWordList($.Localize("#DOTA_Tooltip_ability_" + abilityName + "_description"));
  const infoList = getInfoList($.Localize("#DOTA_Tooltip_ability_" + abilityName + "_description"));
  const player_city_abilities = Object.values(CustomNetTables.GetTableValue("player_extra_data", "city_abilities_" + Players.GetLocalPlayer()) ?? {});
  const limitCount = 10;
  const limitAbilitiesList = player_city_abilities.filter((v, i) => player_city_abilities.length - i <= limitCount + 1);
  const playerCityExtraData = CustomNetTables.GetTableValue("player_extra_data", "city_extra_data_" + Players.GetLocalPlayer()) ?? {};
  const playerCityExtraDataKeys = Object.keys(playerCityExtraData);
  const landName = KeyValues.CityEffectKv[abilityName]?.LandType ?? "";
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
              return [libs.createComponent(CityImage.CityImage, {
                city_name: abilityName
              }), libs.createComponent(EOM_Panel.EOM_Panel, {
                padding: "6px 0 0 6px",
                width: "100%",
                height: "100%",
                get children() {
                  return [libs.createComponent(GenericPanel.CLabel, {
                    id: "CityNameHeader",
                    html: true,
                    text: "#DOTA_Tooltip_ability_" + abilityName
                  }), libs.createComponent(GenericPanel.CLabel, {
                    id: "LandNameHeader",
                    html: true,
                    get text() {
                      return `${$.Localize("#LandType_" + landName)}`;
                    }
                  })];
                }
              })];
            }
          }), libs.createComponent(EOM_Panel.EOM_Panel, {
            className: "SectRow",
            flowChildren: "right",
            get children() {
              return libs.createComponent(CityDescription.CityDescription, {
                className: "CityDescription",
                abilityName: abilityName,
                entityIndex: entIndex
              });
            }
          }), libs.memo(() => libs.memo(() => limitAbilitiesList.length > 0)() && [libs.memo((() => {
            const _c$ = libs.memo(() => limitAbilitiesList.length > limitCount);
            return () => _c$() && libs.createComponent(EOM_Label.EOM_Label, {
              horizontalAlign: 'center',
              marginTop: '6px',
              fontSize: '16px',
              textShadow: '0 0 2px 2 #000000',
              color: 'white',
              style: {
                textAlign: "center"
              },
              text: "#landEffect_AbilityMaxCount",
              dialogVariables: {
                count: limitCount
              }
            });
          })()), libs.createComponent(EOM_Panel.EOM_Panel, {
            get className() {
              return libs.classNames("AbilityList", {
                OverFlow: limitAbilitiesList.length != player_city_abilities.length
              });
            },
            flowChildren: "down",
            get children() {
              return [libs.memo(() => limitAbilitiesList.map((abilityUpgradeID, index) => {
                const abilityUpgradeInfo = GameUI.CustomUIConfig().AbilityUpgradesKv[abilityUpgradeID];
                const rarity = abilityUpgradeInfo.rarity;
                return libs.createComponent(EOM_Panel.EOM_Panel, {
                  className: "AbilityRow",
                  flowChildren: "right",
                  get children() {
                    return [libs.createComponent(GenericPanel.CImage, {
                      className: "AbilityImage",
                      get src() {
                        return `file://{images}/spellicons/${abilityUpgradeInfo.Texture}.png`;
                      }
                    }), libs.createComponent(EOM_Panel.EOM_Panel, {
                      flowChildren: "down",
                      marginLeft: "8px",
                      get children() {
                        return [libs.createComponent(GenericPanel.CLabel, {
                          get className() {
                            return libs.classNames("SectName", {
                              Rare: rarity == "r",
                              SuperRare: rarity == "sr"
                            });
                          },
                          html: true,
                          get text() {
                            return $.Localize("#DOTA_Tooltip_ability_mechanics_" + abilityUpgradeID);
                          }
                        }), libs.createComponent(GenericPanel.CLabel, {
                          className: "AbilityDescription",
                          html: true,
                          get text() {
                            return getSectDescription(abilityUpgradeID, 1, true);
                          }
                        })];
                      }
                    })];
                  }
                });
              })), libs.createComponent(EOM_Label.EOM_Label, {
                id: "ExtraAbilityCount",
                get text() {
                  return `${$.Localize("#has_num")} ${player_city_abilities.length}`;
                }
              })];
            }
          })]), libs.memo(() => libs.memo(() => playerCityExtraDataKeys.length > 0)() && playerCityExtraDataKeys.map((key, index) => {
            if (playerCityExtraData[key] > 0) {
              return libs.createComponent(GenericPanel.CLabel, {
                id: "extraText",
                html: true,
                text: "#artifact_extra_data",
                get dialogVariables() {
                  return {
                    key: $.Localize("#" + key),
                    value: playerCityExtraData[key]
                  };
                }
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
  const keywordList = removeRepeatKeyword(props.keywordList);
  return libs.createComponent(EOM_Panel.EOM_Panel, {
    width: "380px",
    flowChildren: "down",
    get children() {
      return keywordList.map((keyword, index) => {
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
              text: "#KeyWord_" + keyword + "_description"
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
    width: "380px",
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
                return replaceBuffEnum($.Localize("#" + keyword + "_description"));
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
  let abilityName = pTooltipPanel.GetAttributeString("abilityName", "");
  let entIndex = pTooltipPanel.GetAttributeInt("entIndex", 0);
  if (entIndex == 0) {
    entIndex = undefined;
  }
  libs.render(() => libs.createComponent(TooltipContents, {
    abilityName: abilityName,
    entIndex: entIndex
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
  Update();
})();