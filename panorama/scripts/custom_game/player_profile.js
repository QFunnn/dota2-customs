--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build b9dc48c · 2026-08-02 17:42:46 UTC
  ~ auto-generated — do not edit
]]


'use strict'; const require = GameUI.__require;

var libs = require('./libs.js');
var EOM_Panel = require('./EOM_Panel.js');
var profile_simplify = require('./profile_simplify.js');
require('./EOM_Countdown.js');
require('./GenericPanel.js');
require('./EOM_Icon.js');
require('./EOM_PortraitFullBody.js');
require('./EOM_DropDown.js');
require('./MedalBadgeIcon.js');
require('./profile_info.js');
require('./EOM_Button.js');
require('./Player.js');
require('./EOM_Image.js');
require('./EOM_Label.js');
require('./RankTierIcon.js');
require('./netdata_utils.js');
require('./game_utils.js');
require('./CosmeticCard.js');
require('./MenuMarkIcon.js');

let pTooltipPanel = $.GetContextPanel();
pTooltipPanel.style.minHeight = "0px";
pTooltipPanel.FindAncestor("player_profile").FindChildTraverse("LeftArrow").style.opacity = "0";
pTooltipPanel.FindAncestor("player_profile").FindChildTraverse("RightArrow").style.opacity = "0";
pTooltipPanel.FindAncestor("player_profile").FindChildTraverse("TopArrow").style.opacity = "0";
pTooltipPanel.FindAncestor("player_profile").FindChildTraverse("BottomArrow").style.opacity = "0";
function TooltipContents({
  player_id
}) {
  return libs.createComponent(EOM_Panel.EOM_Panel, {
    id: "Content",
    get children() {
      return libs.createComponent(EOM_Panel.EOM_Panel, {
        id: 'Profile',
        get children() {
          return libs.createComponent(profile_simplify.ProfileInfoSimplify, {
            player_id: player_id
          });
        }
      });
    }
  });
}
function SetupTooltip() {
  let player_id = pTooltipPanel.GetAttributeInt("playerID", -1);
  let sSteamID = pTooltipPanel.GetAttributeString("steamID", "");
  if (sSteamID == "") {
    sSteamID = getPlayerData(player_id, "steamID");
    if (sSteamID == undefined) {
      let tPlayerInfo = Game.GetPlayerInfo(player_id);
      sSteamID = steam_64_3(tPlayerInfo.player_steamid);
    }
  }
  if (sSteamID == "NaN") {
    libs.render(() => [], pTooltipPanel);
    return;
  }
  libs.render(() => libs.createComponent(TooltipContents, {
    player_id: player_id
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