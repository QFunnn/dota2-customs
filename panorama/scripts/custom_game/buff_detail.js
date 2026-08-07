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
var GenericPanel = require('./GenericPanel.js');
var SectIcon = require('./SectIcon.js');
require('./EOM_Image.js');

let pTooltipPanel = $.GetContextPanel();
pTooltipPanel.style.minHeight = "0px";
pTooltipPanel.FindAncestor("buff_detail").FindChildTraverse("LeftArrow").style.opacity = "0";
pTooltipPanel.FindAncestor("buff_detail").FindChildTraverse("RightArrow").style.opacity = "0";
pTooltipPanel.FindAncestor("buff_detail").FindChildTraverse("TopArrow").style.opacity = "0";
pTooltipPanel.FindAncestor("buff_detail").FindChildTraverse("BottomArrow").style.opacity = "0";
const dataSum = damageList => {
  let total = 0;
  for (const damageType in damageList) {
    if (damageType != "count") {
      total += damageList[damageType];
    }
  }
  return total;
};
function TooltipContents(props) {
  let {
    sectName,
    playerID,
    entIndex
  } = props;
  const [battleDataNet, _setBattleDataNet] = libs.createSignal(CustomNetTables.GetTableValue("battle_record", entIndex));
  const battleData = () => battleDataNet() ?? {
    detail: {}
  };
  let key = sectName.replace("sect_", "");
  let detailData = battleData()[key] ?? {};
  let maxValue = 0;
  let allValue = 0;
  for (const abilityName in detailData) {
    maxValue = Math.max(Round(dataSum(detailData[abilityName])), maxValue);
    allValue += Round(dataSum(detailData[abilityName]));
  }
  libs.createEffect(() => {
    const id = CustomNetTables.SubscribeNetTableListener("battle_record", function (_, k, v) {
      if (k === entIndex) {
        _setBattleDataNet(v);
      }
    });
    libs.onCleanup(() => {
      CustomNetTables.UnsubscribeNetTableListener(id);
    });
  });
  return libs.createComponent(EOM_Panel.EOM_Panel, {
    width: "300px",
    flowChildren: "down",
    get children() {
      return [libs.createComponent(EOM_Tooltip.EOM_TooltipHeader, {
        flowChildren: "right",
        get children() {
          return [libs.createComponent(SectIcon.SectIcon, {
            width: "40px",
            height: "40px",
            sectName: sectName
          }), libs.createComponent(GenericPanel.CLabel, {
            id: "SectNameHeader",
            html: true,
            text: "#DOTA_Tooltip_ability_" + sectName
          })];
        }
      }), libs.createComponent(EOM_Panel.EOM_Panel, {
        get className() {
          return libs.classNames("RecordDataList", {
            Show: true
          });
        },
        flowChildren: "down",
        width: "100%",
        scroll: "y",
        get children() {
          return detailData && Object.keys(detailData).sort((a, b) => {
            return dataSum(detailData[b]) - dataSum(detailData[a]);
          }).map((abilityName, index) => {
            const amounts = Round(dataSum(detailData[abilityName]));
            const splits = abilityName.split("@");
            const dataSourceType = splits[0];
            const dataAbilityName = splits[1];
            const abilityUpgradeInfo = KeyValues.AbilityUpgradesKv[dataAbilityName];
            let bAttack = dataSourceType.indexOf("Attack") != -1;
            let bAbility = dataSourceType == "Ability";
            let bSect = dataSourceType.indexOf("Sect") != -1;
            let bAbilityUpgrade = dataSourceType == "AbilityUpgrade";
            let bTalent = bAbility && KeyValues.HeroTalentKv[dataAbilityName] != undefined;
            let tooltip = "";
            if (bTalent && typeof KeyValues.HeroTalentKv[dataAbilityName].RequiredLevel == "number") {
              tooltip = $.Localize("#CombatLog_TalentLabel").replace("${level}", finiteNumber(Number(KeyValues.HeroTalentKv[dataAbilityName].RequiredLevel), -1).toString());
            } else {
              tooltip = "#DOTA_Tooltip_ability_" + dataAbilityName;
              if (bAbilityUpgrade) {
                tooltip = "#DOTA_Tooltip_ability_mechanics_" + dataAbilityName;
              }
            }
            return libs.createComponent(EOM_Panel.EOM_Panel, {
              width: "100%",
              marginRight: "10px",
              tooltip: tooltip,
              marginBottom: "2px",
              get children() {
                return [libs.memo(() => bAttack && (() => {
                  const _el$ = libs.createElement("Image", {
                    src: `file://{images}/spellicons/attr_damage.png`
                  }, null);
                  libs.setProp(_el$, "className", "RecordImage");
                  libs.setProp(_el$, "src", `file://{images}/spellicons/attr_damage.png`);
                  return _el$;
                })()), libs.memo(() => bAbility && (() => {
                  const _el$2 = libs.createElement("DOTAAbilityImage", {
                    abilityname: dataAbilityName
                  }, null);
                  libs.setProp(_el$2, "className", "RecordImage");
                  libs.setProp(_el$2, "abilityname", dataAbilityName);
                  return _el$2;
                })()), libs.memo(() => bTalent && (() => {
                  const _el$3 = libs.createElement("DOTAAbilityImage", {
                    abilityname: "attribute_bonus"
                  }, null);
                  libs.setProp(_el$3, "className", "RecordImage");
                  return _el$3;
                })()), libs.memo(() => bSect && (() => {
                  const _el$4 = libs.createElement("DOTAAbilityImage", {
                    abilityname: dataAbilityName
                  }, null);
                  libs.setProp(_el$4, "className", "RecordImage");
                  libs.setProp(_el$4, "abilityname", dataAbilityName);
                  return _el$4;
                })()), libs.memo(() => bAbilityUpgrade && libs.createComponent(GenericPanel.CImage, {
                  className: "RecordImage",
                  get src() {
                    return `file://{images}/spellicons/${abilityUpgradeInfo.Texture}.png`;
                  }
                })), libs.createComponent(GenericPanel.CLabel, {
                  className: "RecordName",
                  html: true,
                  text: tooltip
                }), libs.createComponent(EOM_Icon.EOM_Icon, {
                  className: "RecordProgress",
                  get width() {
                    return amounts / Math.max(maxValue, 1) * 100 + "%";
                  },
                  height: "22px",
                  marginLeft: "28px",
                  verticalAlign: "center"
                }), libs.createComponent(GenericPanel.CLabel, {
                  className: "RecordDamagevalue",
                  get text() {
                    return amounts + " (" + Round(amounts / Math.max(allValue, 1) * 100) + "%)";
                  }
                })];
              }
            });
          });
        }
      }), libs.createComponent(EOM_Panel.EOM_Panel, {
        id: "LoreContainer",
        get children() {
          return libs.createComponent(GenericPanel.CLabel, {
            html: true,
            get text() {
              return replaceBuffEnum($.Localize("#DOTA_Tooltip_ability_" + sectName + "_Lore"));
            }
          });
        }
      })];
    }
  });
}
function SetupTooltip() {
  let sectName = pTooltipPanel.GetAttributeString("sectName", "");
  let playerID = pTooltipPanel.GetAttributeInt("playerID", -1);
  let entIndex = pTooltipPanel.GetAttributeInt("entIndex", -1);
  libs.render(() => libs.createComponent(TooltipContents, {
    sectName: sectName,
    playerID: playerID,
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
})();