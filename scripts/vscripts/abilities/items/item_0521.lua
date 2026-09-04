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
local ____items = require("abilities.items.items")
local item_0198 = ____items.item_0198
____exports.item_0521 = __TS__Class()
local item_0521 = ____exports.item_0521
item_0521.name = "item_0521"
__TS__ClassExtends(item_0521, item_0198)
item_0521 = __TS__DecorateLegacy({ registerAbility(nil) }, item_0521)
____exports.item_0521 = item_0521
return ____exports