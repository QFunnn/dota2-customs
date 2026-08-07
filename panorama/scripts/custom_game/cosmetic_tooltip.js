--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 16fdfbc · 2026-08-07 21:47:55 UTC
  ~ auto-generated — do not edit
]]


'use strict'; const require = GameUI.__require;

var libs = require('./libs.js');
var BubbleBox = require('./BubbleBox.js');
var CosmeticCard = require('./CosmeticCard.js');
var CosmeticPreview = require('./CosmeticPreview.js');
var EOM_Panel = require('./EOM_Panel.js');
var EOM_Image = require('./EOM_Image.js');
var EOM_Label = require('./EOM_Label.js');
require('./EOM_Countdown.js');
require('./GenericPanel.js');
require('./CourierTitle.js');
require('./EOM_PortraitFullBody.js');
require('./EOM_Button.js');
require('./EOM_Icon.js');
require('./Player.js');
require('./WinStreak.js');
require('./Heroes.js');
require('./profile_info.js');

let pTooltipPanel = $.GetContextPanel();
pTooltipPanel.style.minHeight = "0px";
pTooltipPanel.FindAncestor("cosmetic_tooltip").FindChildTraverse("LeftArrow").style.opacity = "1";
pTooltipPanel.FindAncestor("cosmetic_tooltip").FindChildTraverse("RightArrow").style.opacity = "1";
pTooltipPanel.FindAncestor("cosmetic_tooltip").FindChildTraverse("TopArrow").style.opacity = "1";
pTooltipPanel.FindAncestor("cosmetic_tooltip").FindChildTraverse("BottomArrow").style.opacity = "1";
let bAltDown = false;
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
  let {
    cosmeticID,
    text,
    showPreview
  } = props;
  if (text == "") {
    text = $.Localize("#" + cosmeticID);
  }
  return libs.createComponent(BubbleBox.EOMBubbleBox, {
    get children() {
      return [libs.createComponent(EOM_Panel.EOM_Panel, {
        id: "CosmeticPreviewContainer",
        get children() {
          return libs.createComponent(libs.Show, {
            when: showPreview == 1,
            get fallback() {
              return libs.createComponent(libs.Show, {
                get when() {
                  return KeyValues.CosmeticsKv[cosmeticID] != undefined;
                },
                get fallback() {
                  return libs.createComponent(EOM_Image.EOM_Image, {
                    className: "ProductImage",
                    get src() {
                      return getSrcPath("store_items/" + cosmeticID + ".png");
                    }
                  });
                },
                get children() {
                  return libs.createComponent(CosmeticCard.CosmeticImage, {
                    itemid: cosmeticID
                  });
                }
              });
            },
            get children() {
              return libs.createComponent(CosmeticPreview.CosmeticPreview, {
                cosmetic_id: cosmeticID,
                showPedestal: false,
                showCourierPedestal: false
              });
            }
          });
        }
      }), libs.createComponent(EOM_Label.EOM_Label, {
        id: "CosmeticLabel",
        text: text,
        html: true
      })];
    }
  });
}
function SetupTooltip() {
  let text = pTooltipPanel.GetAttributeString("text", "");
  let cosmeticID = pTooltipPanel.GetAttributeInt("cosmeticID", 0);
  let showPreview = pTooltipPanel.GetAttributeInt("showPreview", 0);
  libs.render(() => libs.createComponent(TooltipContents, {
    cosmeticID: cosmeticID,
    text: text,
    showPreview: showPreview
  }), pTooltipPanel);
}
(function () {
  pTooltipPanel.SetPanelEvent("ontooltiploaded", SetupTooltip);
  {
    let pArrow = pTooltipPanel.GetParent()?.FindChildTraverse("LeftArrow");
    if (pArrow) {
      pArrow.style.backgroundImage = `url("file://{images}/custom_game/hud/bubble_arrow_left.png")`;
      pArrow.style.backgroundSize = "100%";
      pArrow.style.washColor = "none";
    }
    pArrow = pTooltipPanel.GetParent()?.FindChildTraverse("RightArrow");
    if (pArrow) {
      pArrow.style.washColor = "none";
      pArrow.style.backgroundSize = "100%";
      pArrow.style.backgroundImage = `url("file://{images}/custom_game/hud/bubble_arrow_right.png")`;
    }
  }
  {
    let pArrow = pTooltipPanel.GetParent()?.GetParent()?.FindChildTraverse("TopArrow");
    if (pArrow) {
      pArrow.style.backgroundImage = `url("file://{images}/custom_game/hud/bubble_arrow.png")`;
      pArrow.style.backgroundSize = "100%";
      pArrow.style.washColor = "none";
    }
    pArrow = pTooltipPanel.GetParent()?.GetParent()?.FindChildTraverse("BottomArrow");
    if (pArrow) {
      pArrow.style.backgroundImage = `url("file://{images}/custom_game/hud/bubble_arrow_bottom.png")`;
      pArrow.style.washColor = "none";
      pArrow.style.backgroundSize = "100%";
    }
  }
  pTooltipPanel.style.minHeight = "100px";
  Update();
})();