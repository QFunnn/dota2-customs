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
local ____item_0599 = require("abilities.items.item_0599")
local item_0599 = ____item_0599.item_0599
local modifier_item_0599 = ____item_0599.modifier_item_0599
____exports.item_0700 = __TS__Class()
local item_0700 = ____exports.item_0700
item_0700.name = "item_0700"
__TS__ClassExtends(item_0700, item_0599)
function item_0700.prototype.GetIntrinsicModifierName(self)
	return modifier_item_0599.name
end
item_0700 = __TS__DecorateLegacy({ registerAbility(nil) }, item_0700)
____exports.item_0700 = item_0700
return ____exports