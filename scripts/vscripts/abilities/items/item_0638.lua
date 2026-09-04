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
local ____item_0420 = require("abilities.items.item_0420")
local item_0420 = ____item_0420.item_0420
local modifier_item_0420_blood_moon_hunt = ____item_0420.modifier_item_0420_blood_moon_hunt
____exports.item_0638 = __TS__Class()
local item_0638 = ____exports.item_0638
item_0638.name = "item_0638"
__TS__ClassExtends(item_0638, item_0420)
function item_0638.prototype.GetIntrinsicModifierName(self)
	return modifier_item_0420_blood_moon_hunt.name
end
item_0638 = __TS__DecorateLegacy({ registerAbility(nil) }, item_0638)
____exports.item_0638 = item_0638
return ____exports