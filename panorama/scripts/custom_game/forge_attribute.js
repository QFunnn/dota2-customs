--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 0b85d8d 
  ~ auto-generated — do not edit
]]


'use strict'; const require = GameUI.__require;

var libs = require('./libs.js');

let pTooltipPanel = $.GetContextPanel();
pTooltipPanel.style.minHeight = "0px";
pTooltipPanel.FindAncestor("forge_attribute").FindChildTraverse("LeftArrow").style.opacity = "0";
pTooltipPanel.FindAncestor("forge_attribute").FindChildTraverse("RightArrow").style.opacity = "0";
pTooltipPanel.FindAncestor("forge_attribute").FindChildTraverse("TopArrow").style.opacity = "0";
pTooltipPanel.FindAncestor("forge_attribute").FindChildTraverse("BottomArrow").style.opacity = "0";
function TooltipContents(props) {
  const playerData = CustomNetTables.GetTableValue("player_data", props.playerID.toString());
  const attributeList = Object.entries(playerData?.forgeAttributes ?? {}).filter(([, value]) => value > 0).sort(([a], [b]) => a < b ? -1 : a > b ? 1 : 0);
  return (() => {
    const _el$ = libs.createElement("Panel", {
        "class": "ForgeAttributeTooltip"
      }, null),
      _el$2 = libs.createElement("Panel", {
        "class": "ForgeAttributeTooltipHeader"
      }, _el$);
      libs.createElement("Label", {
        "class": "ForgeAttributeTooltipTitle",
        text: "已选择锻体加成"
      }, _el$2);
      libs.createElement("Label", {
        "class": "ForgeAttributeTooltipHint",
        text: "消耗 10 锻体碎片抽取 1 项属性"
      }, _el$2);
    libs.insert(_el$, libs.createComponent(libs.Show, {
      get when() {
        return attributeList.length > 0;
      },
      get fallback() {
        return libs.createElement("Label", {
          "class": "ForgeAttributeTooltipEmpty",
          text: "暂未选择锻体属性"
        }, null);
      },
      get children() {
        const _el$5 = libs.createElement("Panel", {
          "class": "ForgeAttributeTooltipList"
        }, null);
        libs.insert(_el$5, () => attributeList.map(([attributeName, value]) => (() => {
          const _el$7 = libs.createElement("Panel", {
              "class": "ForgeAttributeTooltipRow"
            }, null),
            _el$8 = libs.createElement("Label", {
              "class": "ForgeAttributeTooltipName",
              html: true,
              text: "#dota_tooltip_item_variable_" + attributeName
            }, _el$7),
            _el$9 = libs.createElement("Label", {
              "class": "ForgeAttributeTooltipValue",
              text: "+" + value
            }, _el$7);
          libs.setProp(_el$8, "text", "#dota_tooltip_item_variable_" + attributeName);
          libs.setProp(_el$9, "text", "+" + value);
          return _el$7;
        })()));
        return _el$5;
      }
    }), null);
    return _el$;
  })();
}
function SetupTooltip() {
  const playerID = pTooltipPanel.GetAttributeInt("player_id", Players.GetLocalPlayer());
  libs.render(() => libs.createComponent(TooltipContents, {
    playerID: playerID
  }), pTooltipPanel);
}
(function () {
  pTooltipPanel.SetPanelEvent("ontooltiploaded", SetupTooltip);
})();