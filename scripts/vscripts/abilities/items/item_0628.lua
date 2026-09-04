--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build ec5ff63 
  ~ auto-generated — do not edit
]]


local ____lualib = require("lualib_bundle")
local __TS__Class = ____lualib.__TS__Class
local __TS__ClassExtends = ____lualib.__TS__ClassExtends
local __TS__DecorateLegacy = ____lualib.__TS__DecorateLegacy
local ____exports = {}
local ____dota_ts_adapter = require("utils.dota_ts_adapter")
local registerAbility = ____dota_ts_adapter.registerAbility
local ____item_0598 = require("abilities.items.item_0598")
local item_0598 = ____item_0598.item_0598
____exports.item_0628 = __TS__Class()
local item_0628 = ____exports.item_0628
item_0628.name = "item_0628"
__TS__ClassExtends(item_0628, item_0598)
item_0628 = __TS__DecorateLegacy({ registerAbility(nil) }, item_0628)
____exports.item_0628 = item_0628
return ____exports