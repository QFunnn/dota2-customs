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
local _____base_item = require("abilities.items._base_item")
local BaseItem_CS = _____base_item.BaseItem_CS
local ____item_0604 = require("abilities.items.item_0604")
local modifier_item_0604 = ____item_0604.modifier_item_0604
____exports.item_0631 = __TS__Class()
local item_0631 = ____exports.item_0631
item_0631.name = "item_0631"
__TS__ClassExtends(item_0631, BaseItem_CS)
function item_0631.prototype.GetIntrinsicModifierName(self)
	return modifier_item_0604.name
end
item_0631 = __TS__DecorateLegacy({ registerAbility(nil) }, item_0631)
____exports.item_0631 = item_0631
return ____exports