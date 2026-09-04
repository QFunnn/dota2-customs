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
local item_kv_generator_test1 = __TS__Class()
item_kv_generator_test1.name = "item_kv_generator_test1"
__TS__ClassExtends(item_kv_generator_test1, BaseItem_CS)
function item_kv_generator_test1.prototype.OnCreated(self, params)
	print("创建了物品")
end
item_kv_generator_test1 = __TS__DecorateLegacy({ registerAbility(nil) }, item_kv_generator_test1)
return ____exports