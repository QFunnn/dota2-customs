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
var EOM_Panel = require('./EOM_Panel.js');
var ProductImage = require('./ProductImage.js');
require('./GenericPanel.js');

let pTooltipPanel = $.GetContextPanel();
pTooltipPanel.style.minHeight = "0px";
pTooltipPanel.FindAncestor("reward_tooltip").FindChildTraverse("LeftArrow").style.opacity = "1";
pTooltipPanel.FindAncestor("reward_tooltip").FindChildTraverse("RightArrow").style.opacity = "1";
pTooltipPanel.FindAncestor("reward_tooltip").FindChildTraverse("TopArrow").style.opacity = "1";
pTooltipPanel.FindAncestor("reward_tooltip").FindChildTraverse("BottomArrow").style.opacity = "1";
function TooltipContents(props) {
  let {
    reward_list
  } = props;
  return libs.createComponent(BubbleBox.EOMBubbleBox, {
    get children() {
      return libs.createComponent(EOM_Panel.EOM_Panel, {
        id: "Content",
        get children() {
          return reward_list.map(reward => libs.createComponent(EOM_Panel.EOM_Panel, {
            className: "Reward",
            get children() {
              return [libs.createComponent(ProductImage.ProductImage, {
                get itemid() {
                  return reward.item_id;
                }
              }), (() => {
                const _el$ = libs.createElement("Label", {
                  "class": "ProductCount",
                  get text() {
                    return "x" + reward.amounts;
                  }
                }, null);
                libs.effect(_$p => libs.setProp(_el$, "text", "x" + reward.amounts, _$p));
                return _el$;
              })(), (() => {
                const _el$2 = libs.createElement("Label", {
                  "class": "ProductName",
                  get text() {
                    return "#" + reward.item_id;
                  }
                }, null);
                libs.effect(_$p => libs.setProp(_el$2, "text", "#" + reward.item_id, _$p));
                return _el$2;
              })()];
            }
          }));
        }
      });
    }
  });
}
function SetupTooltip() {
  let reward_list = pTooltipPanel.GetAttributeString("reward_list", "[]");
  libs.render(() => libs.createComponent(TooltipContents, {
    get reward_list() {
      return JSON.parseSafe(reward_list);
    }
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
  pTooltipPanel.style.minHeight = "50px";
})();