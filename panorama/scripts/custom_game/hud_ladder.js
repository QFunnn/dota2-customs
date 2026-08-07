--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 16fdfbc · 2026-08-07 21:47:55 UTC
  ~ auto-generated — do not edit
]]


'use strict'; const require = GameUI.__require;

var libs = require('./libs.js');
var EOM_MenuLayout = require('./EOM_MenuLayout.js');
require('./service_netdata_helper.js');
require('./solid_utils.js');
require('./EOM_RedMark.js');
require('./EOM_Button.js');

const menuList = {
  ladder: []
};
const {
  LayoutMenu,
  show,
  menuName,
  secondTabName
} = EOM_MenuLayout.createMenuLayout("ladder", () => menuList);
function HUDLadder() {
  return libs.createComponent(EOM_MenuLayout.EOM_MenuLayout, {
    renderOnShow: true,
    id: "HUDLadderRoot",
    get show() {
      return show();
    },
    name: "MenuButton_ladder",
    get children() {
      return libs.createComponent(LayoutMenu, {});
    }
  });
}
libs.render(() => libs.createComponent(HUDLadder, {}), $.GetContextPanel());