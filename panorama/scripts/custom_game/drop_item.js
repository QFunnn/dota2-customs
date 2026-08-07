--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 16fdfbc · 2026-08-07 21:47:55 UTC
  ~ auto-generated — do not edit
]]


'use strict'; const require = GameUI.__require;

var libs = require('./libs.js');
var common_item = require('./common_item.js');
var solid_utils = require('./solid_utils.js');

const DropItem = () => {
  const worldPanel = $.GetContextPanel();
  const entityID = worldPanel != undefined && worldPanel.GetOwnerEntityID != undefined ? worldPanel.GetOwnerEntityID() : -1;
  const dropItem = solid_utils.createNetDataSignal("dropped_item", String(entityID));
  return libs.createComponent(common_item.CommonItem, {
    get itemName() {
      return dropItem()?.item_name ?? "item_discount_card";
    },
    get rarity() {
      return dropItem()?.rarity ?? 1;
    }
  });
};
libs.render(() => libs.createComponent(DropItem, {}), $.GetContextPanel());