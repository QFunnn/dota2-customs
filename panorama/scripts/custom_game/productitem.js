--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 9d26fbd · 2026-08-07 04:51:43 UTC
  ~ auto-generated — do not edit
]]


'use strict'; const exports = {}; GameUI.__loadModule('ProductItem', exports); const require = GameUI.__require;

var libs = require('./libs.js');
var EOM_Panel = require('./EOM_Panel.js');
var GenericPanel = require('./GenericPanel.js');
var ProductImage = require('./ProductImage.js');

const ProductItem = props => {
  const merged = libs.mergeProps$1({
    rarity: 0
  }, props);
  const [local, others] = libs.splitProps(merged, ["children", "itemid", "cosmetic_id", "count", "rarity"]);
  const resolved = libs.children(() => local.children);
  const ItemID = () => {
    if (local.itemid.toString().startsWith("300")) {
      let heroName = GetHeroNameByGoodID(Number(local.itemid));
      if (heroName) {
        return heroName;
      }
    }
    return local.itemid;
  };
  return (() => {
    const _el$ = libs.createElement("Image", libs.mergeProps(() => EOM_Panel.EOMProps(others, {
        className: libs.classNames("ProductItem", "Rarity" + local.rarity)
      })), null),
      _el$2 = libs.createElement("Panel", {}, _el$),
      _el$3 = libs.createElement("Panel", {}, _el$2),
      _el$4 = libs.createElement("Image", {}, _el$3),
      _el$5 = libs.createElement("Image", {}, _el$3),
      _el$6 = libs.createElement("Image", {}, _el$3);
    libs.spread(_el$, libs.mergeProps(() => EOM_Panel.EOMProps(others, {
      className: libs.classNames("ProductItem", "Rarity" + local.rarity)
    })), true);
    libs.setProp(_el$2, "className", "ProductItemTitle");
    libs.setProp(_el$3, "className", "ProductItemTitleBG");
    libs.setProp(_el$4, "className", "Left");
    libs.setProp(_el$5, "className", "Center");
    libs.setProp(_el$6, "className", "Right");
    libs.insert(_el$2, libs.createComponent(GenericPanel.CLabel, {
      get text() {
        return "#" + ItemID();
      }
    }), null);
    libs.insert(_el$, libs.createComponent(ProductImage.ProductImage, {
      get itemid() {
        return local.itemid;
      },
      get count() {
        return local.count;
      },
      get cosmetic_id() {
        return local.cosmetic_id;
      }
    }), null);
    libs.insert(_el$, resolved, null);
    return _el$;
  })();
};

exports.ProductItem = ProductItem;