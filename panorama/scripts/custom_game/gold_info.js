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
var EOM_Label = require('./EOM_Label.js');

let pTooltipPanel = $.GetContextPanel();
pTooltipPanel.style.minHeight = "0px";
pTooltipPanel.FindAncestor("gold_info").FindChildTraverse("LeftArrow").style.opacity = "1";
pTooltipPanel.FindAncestor("gold_info").FindChildTraverse("RightArrow").style.opacity = "1";
pTooltipPanel.FindAncestor("gold_info").FindChildTraverse("TopArrow").style.opacity = "1";
pTooltipPanel.FindAncestor("gold_info").FindChildTraverse("BottomArrow").style.opacity = "1";
function TooltipContents(props) {
  const {
    playerID
  } = props;
  const ent = Players.GetPlayerHeroEntityIndex(playerID);
  let RoundGold = 250;
  let RateThreshold = 100;
  let RateGold = 10;
  let RateMax = 100;
  let WinGold = 50;
  let WinStack = 25;
  let LoseStack = 20;
  let WinStackGoldLimit = 150;
  let LoseStackGoldLimit = 100;
  let LosePerHP = 20;
  const config = CustomNetTables.GetTableValue("common", "constant");
  const configInterest = config?.GOLD_INTEREST_CONFIG;
  const configBattle = config?.GOLD_BATTLE_CONFIG;
  if (configInterest) {
    RateThreshold = configInterest.Rate;
    RateMax = configInterest.Max;
    RateGold = configInterest.Gold;
  }
  if (configBattle) {
    WinGold = configBattle.WinBase;
    LoseStack = configBattle.LoseStack;
    WinStack = configBattle.WinStack;
    WinStackGoldLimit = configBattle.MaxWinStack;
    LoseStackGoldLimit = configBattle.MaxLoseStack;
    LosePerHP = configBattle.LosePerHP;
  }
  if (config?.GOLD_PER_ROUND && typeof Number(config?.GOLD_PER_ROUND?.[1]) == "number") {
    RoundGold = Number(config?.GOLD_PER_ROUND?.[1]);
  }
  let nowData = {
    RoundGold: RoundGold + finiteNumber(Number(Entities.GetUnitData(ent, "GetRoundExtraWages")), RoundGold),
    RateThreshold: finiteNumber(Number(Entities.GetUnitData(ent, "GetInterestRate")), RateThreshold),
    RateGold: finiteNumber(Number(Entities.GetUnitData(ent, "GetInterestPerGold")), RateGold),
    RateMax: finiteNumber(Number(Entities.GetUnitData(ent, "GetMaxInterest")), RateMax),
    WinGold: finiteNumber(Number(Entities.GetUnitData(ent, "GetWinGold")), WinGold),
    WinStack: finiteNumber(Number(Entities.GetUnitData(ent, "GetWinStackGold")), WinStack),
    WinStackGoldLimit: finiteNumber(Number(Entities.GetUnitData(ent, "GetWinStackGoldLimit")), WinStackGoldLimit),
    LoseStack: finiteNumber(Number(Entities.GetUnitData(ent, "GetLoseStackGold")), LoseStack),
    LoseStackGoldLimit: finiteNumber(Number(Entities.GetUnitData(ent, "GetLoseStackGoldLimit")), LoseStackGoldLimit),
    LosePerHP: finiteNumber(Number(Entities.GetUnitData(ent, "GetLosePerHealthGold")), LosePerHP)
  };
  let text = $.Localize("#Gold_Description");
  text = replaceByEnum(text, "GOLD_PER_ROUND.1", nowData.RoundGold);
  text = replaceByEnum(text, "GOLD_INTEREST_CONFIG.Rate", nowData.RateThreshold);
  text = replaceByEnum(text, "GOLD_INTEREST_CONFIG.Gold", nowData.RateGold);
  text = replaceByEnum(text, "GOLD_INTEREST_CONFIG.Max", nowData.RateMax);
  text = replaceByEnum(text, "GOLD_BATTLE_CONFIG.WinBase", nowData.WinGold);
  text = replaceByEnum(text, "GOLD_BATTLE_CONFIG.WinStack", nowData.WinStack);
  text = replaceByEnum(text, "GOLD_BATTLE_CONFIG.MaxWinStack", nowData.WinStackGoldLimit);
  text = replaceByEnum(text, "GOLD_BATTLE_CONFIG.LoseStack", nowData.LoseStack);
  text = replaceByEnum(text, "GOLD_BATTLE_CONFIG.MaxLoseStack", nowData.LoseStackGoldLimit);
  text = replaceByEnum(text, "GOLD_BATTLE_CONFIG.LosePerHP", nowData.LosePerHP);
  text += "<br><br>" + $.Localize("#max_interest_need") + `<font color='#fedc80'>${FormatNumber(nowData.RateThreshold * Math.ceil(nowData.RateMax / nowData.RateGold))}</font>`;
  return libs.createComponent(EOM_Panel.EOM_Panel, {
    flowChildren: "down",
    get children() {
      return libs.createComponent(EOM_Label.EOM_Label, {
        text: text,
        html: true
      });
    }
  });
}
function replaceByEnum(text, key, value) {
  let valueText = `${value}`;
  const config = CustomNetTables.GetTableValue("common", "constant");
  let keys = key.split(".");
  if (config) {
    let t = config;
    for (let i = 0; i < keys.length; i++) {
      if (t[keys[i]]) {
        t = t[keys[i]];
      }
    }
    let v = Number(t);
    if (typeof v == "number" && v != value) {
      let isAdd = value > v;
      valueText = `<font color='white'>${FormatNumber(v)}</font>(<font color='${isAdd ? "#adf885" : "#f88585"}'>${isAdd ? "+" : ""}${FormatNumber(value - v)}</font>)`;
    } else {
      valueText = `<font color='white'>${FormatNumber(valueText)}</font>`;
    }
  } else {
    valueText = `<font color='white'>${FormatNumber(valueText)}</font>`;
  }
  return text.replace(`{Enum:${key}}`, valueText);
}
function FormatNumber(value) {
  if (typeof Number(value) != "number") return "";
  return value.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
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