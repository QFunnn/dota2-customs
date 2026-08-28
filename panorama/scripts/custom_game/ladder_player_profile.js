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
var profile_info = require('./profile_info.js');
require('./EOM_Button.js');
require('./GenericPanel.js');
require('./EOM_Icon.js');
require('./Player.js');
require('./EOM_Image.js');
require('./EOM_Label.js');

let pTooltipPanel = $.GetContextPanel();
pTooltipPanel.style.minHeight = "0px";
pTooltipPanel.FindAncestor("ladder_player_profile").FindChildTraverse("LeftArrow").style.opacity = "0";
pTooltipPanel.FindAncestor("ladder_player_profile").FindChildTraverse("RightArrow").style.opacity = "0";
pTooltipPanel.FindAncestor("ladder_player_profile").FindChildTraverse("TopArrow").style.opacity = "0";
pTooltipPanel.FindAncestor("ladder_player_profile").FindChildTraverse("BottomArrow").style.opacity = "0";
function TooltipContents({
  playerID,
  steamID,
  avatarBorder,
  avatarBG,
  avatarDecoration,
  ban
}) {
  return libs.createComponent(EOM_Panel.EOM_Panel, {
    id: "Content",
    get children() {
      return libs.createComponent(profile_info.ProfileInfo, {
        ban: ban,
        player_id: playerID,
        get steamID() {
          return steamID.toString();
        },
        avatar_border: avatarBorder,
        avatar_decoration: avatarDecoration,
        avatar_background: avatarBG
      });
    }
  });
}
function SetupTooltip() {
  let steamID = pTooltipPanel.GetAttributeInt("steamID", -1);
  let playerID = pTooltipPanel.GetAttributeInt("playerID", -1);
  if (playerID == -1) {
    playerID = undefined;
  }
  let avatarBorder = pTooltipPanel.GetAttributeInt("avatarBorder", 0);
  if (avatarBorder == 0) {
    avatarBorder = undefined;
  }
  let avatarBG = pTooltipPanel.GetAttributeInt("avatarBG", 0);
  if (avatarBG == 0) {
    avatarBG = undefined;
  }
  let avatarDecoration = pTooltipPanel.GetAttributeInt("avatarDecoration", 0);
  if (avatarDecoration == 0) {
    avatarDecoration = undefined;
  }
  let ban = pTooltipPanel.GetAttributeInt("ban", -1) == 1;
  libs.render(() => libs.createComponent(TooltipContents, {
    playerID: playerID,
    steamID: steamID,
    avatarBG: avatarBG,
    avatarDecoration: avatarDecoration,
    avatarBorder: avatarBorder,
    ban: ban
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