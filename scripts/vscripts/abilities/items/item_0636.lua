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
local ____item_0382 = require("abilities.items.item_0382")
local item_0382 = ____item_0382.item_0382
local modifier_item_0382_chaos_poison = ____item_0382.modifier_item_0382_chaos_poison
____exports.item_0636 = __TS__Class()
local item_0636 = ____exports.item_0636
item_0636.name = "item_0636"
__TS__ClassExtends(item_0636, item_0382)
function item_0636.prototype.GetIntrinsicModifierName(self)
	return modifier_item_0382_chaos_poison.name
end
item_0636 = __TS__DecorateLegacy({ registerAbility(nil) }, item_0636)
____exports.item_0636 = item_0636
return ____exports