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
local ____item_0544 = require("abilities.items.item_0544")
local item_0544 = ____item_0544.item_0544
local modifier_item_0544 = ____item_0544.modifier_item_0544
____exports.item_0583 = __TS__Class()
local item_0583 = ____exports.item_0583
item_0583.name = "item_0583"
__TS__ClassExtends(item_0583, item_0544)
function item_0583.prototype.GetIntrinsicModifierName(self)
	return modifier_item_0544.name
end
item_0583 = __TS__DecorateLegacy({ registerAbility(nil) }, item_0583)
____exports.item_0583 = item_0583
return ____exports