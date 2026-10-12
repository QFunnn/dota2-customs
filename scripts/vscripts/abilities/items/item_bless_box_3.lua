--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1a5b3bb 
  ~ auto-generated — do not edit
]]


-- abilities/items/item_bless_box_3.lua
local ____debugRuntime = require("utils.debug_runtime")
local debug = ____debugRuntime.safe_debug
local ____lualib = require("lualib_bundle")
local __TS__Class = ____lualib.__TS__Class
local __TS__ClassExtends = ____lualib.__TS__ClassExtends
local __TS__Decorate = ____lualib.__TS__Decorate
____debugRuntime.register(
	"abilities/items/item_bless_box_3.lua",
	{
		["10"] = "1:1",
		["11"] = "1:10",
		["12"] = "2:1",
		["13"] = "2:10",
		["14"] = "4:1",
		["15"] = "5:14",
		["16"] = "4:1",
		["17"] = "5:31",
		["19"] = "5:39",
		["20"] = "6:5",
		["21"] = "7:5",
		["22"] = "8:5",
		["23"] = "4:1",
		["24"] = "5:14",
		["25"] = "4:2",
		["26"] = "4:2",
		["27"] = "4:2",
		["29"] = "4:2",
		["30"] = "5:14",
		["32"] = "5:14",
	}
)
local ____exports = {}
local ____dota_ts_adapter = require("utils.dota_ts_adapter")
local registerAbility = ____dota_ts_adapter.registerAbility
local _____item_bless_box_base = require("abilities.items._item_bless_box_base")
local _item_bless_box_base = _____item_bless_box_base._item_bless_box_base
____exports.item_bless_box_3 = __TS__Class()
local item_bless_box_3 = ____exports.item_bless_box_3
item_bless_box_3.name = "item_bless_box_3"
__TS__ClassExtends(item_bless_box_3, _item_bless_box_base)
function item_bless_box_3.prototype.____constructor(self, ...)
	_item_bless_box_base.prototype.____constructor(self, ...)
	self._bless_quality = 3
	self._check_record_key = "use_bless_box_3"
	self._draw_reason = 1003
end
item_bless_box_3 = __TS__Decorate({ registerAbility(nil, nil, getfenv()) }, item_bless_box_3)
____exports.item_bless_box_3 = item_bless_box_3
return ____exports