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
local ____item_0401 = require("abilities.items.item_0401")
local item_0401 = ____item_0401.item_0401
local modifier_item_0401_void_blade = ____item_0401.modifier_item_0401_void_blade
____exports.item_0639 = __TS__Class()
local item_0639 = ____exports.item_0639
item_0639.name = "item_0639"
__TS__ClassExtends(item_0639, item_0401)
function item_0639.prototype.GetIntrinsicModifierName(self)
	return modifier_item_0401_void_blade.name
end
item_0639 = __TS__DecorateLegacy({ registerAbility(nil) }, item_0639)
____exports.item_0639 = item_0639
return ____exports