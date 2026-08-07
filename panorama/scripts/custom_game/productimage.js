--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 9d26fbd · 2026-08-07 04:51:43 UTC
  ~ auto-generated — do not edit
]]


'use strict'; const exports = {}; GameUI.__loadModule('ProductImage', exports); const require = GameUI.__require;

var libs = require('./libs.js');
var EOM_Panel = require('./EOM_Panel.js');
var GenericPanel = require('./GenericPanel.js');

const ProductImage = props => {
  const [local, other] = libs.splitProps(props, ["children", "itemid", "cosmetic_id", "count", "hidetooltip"]);
  const ItemID = () => {
    if (props.itemid.toString().startsWith("300")) {
      let heroName = GetHeroNameByGoodID(Number(props.itemid));
      if (heroName) {
        return heroName;
      }
    }
    return props.itemid;
  };
  const src = libs.createMemo(() => getProductSrc(props.itemid, props.cosmetic_id));
  return (() => {
    const _el$ = libs.createElement("Image", libs.mergeProps(() => EOM_Panel.EOMProps(other, {
      className: "ProductImage ItemID_" + props.itemid
    }), {
      get src() {
        return src();
      }
    }), null);
    libs.spread(_el$, libs.mergeProps(() => EOM_Panel.EOMProps(other, {
      className: "ProductImage ItemID_" + props.itemid
    }), {
      get src() {
        return src();
      },
      "onmouseover": self => {
        if (!props.hidetooltip) {
          $.DispatchEvent("DOTAShowTitleTextTooltip", self, "#" + ItemID(), ItemID() == props.itemid ? "#" + props.itemid + "_description" : "#" + ItemID());
        }
      },
      "onmouseout": self => {
        if (!props.hidetooltip) {
          $.DispatchEvent("DOTAHideTitleTextTooltip", self);
        }
      }
    }), true);
    libs.insert(_el$, libs.createComponent(libs.Show, {
      get when() {
        return props.count && props.count > 1;
      },
      get children() {
        return libs.createComponent(GenericPanel.CLabel, {
          className: "ProductCount",
          get text() {
            return "×" + props.count;
          }
        });
      }
    }));
    return _el$;
  })();
};

exports.ProductImage = ProductImage;