--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 0b85d8d 
  ~ auto-generated — do not edit
]]


'use strict'; const require = GameUI.__require;

var libs = require('./libs.js');
var ShopAbilityCard = require('./ShopAbilityCard.js');
require('./EOM_Panel.js');
require('./EOMDesign.js');
require('./EOM_Image.js');
require('./EOM_Label.js');
require('./EOM_Button.js');
require('./GenericPanel.js');
require('./EOM_Icon.js');
require('./SectIcon.js');

let pTooltipPanel = $.GetContextPanel();
pTooltipPanel.style.minHeight = "0px";
pTooltipPanel.FindAncestor("greevil_ability_card").FindChildTraverse("LeftArrow").style.opacity = "0";
pTooltipPanel.FindAncestor("greevil_ability_card").FindChildTraverse("RightArrow").style.opacity = "0";
pTooltipPanel.FindAncestor("greevil_ability_card").FindChildTraverse("TopArrow").style.opacity = "0";
pTooltipPanel.FindAncestor("greevil_ability_card").FindChildTraverse("BottomArrow").style.opacity = "0";
function SetupTooltip() {
  const abilityName = pTooltipPanel.GetAttributeString("abilityName", "");
  pTooltipPanel.GetAttributeInt("cost", -1);
  pTooltipPanel.GetAttributeInt("rarity", 1);
  if (!abilityName || !KeyValues.AbilityUpgradesKv[abilityName]) {
    return;
  }
  libs.render(() => libs.createComponent(ShopAbilityCard.ShopAbilityCard, {
    name: abilityName,
    level: 0,
    soldOut: false,
    isLock: false,
    cost: -1,
    hittest: false
  }), pTooltipPanel);
}
(function () {
  pTooltipPanel.SetPanelEvent("ontooltiploaded", SetupTooltip);
})();