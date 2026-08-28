--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 0b85d8d 
  ~ auto-generated — do not edit
]]


local ____lualib = require("lualib_bundle")
local __TS__Class = ____lualib.__TS__Class
local __TS__ClassExtends = ____lualib.__TS__ClassExtends
local __TS__Decorate = ____lualib.__TS__Decorate
local ____exports = {}
local ____dota_ts_adapter = require("utils.dota_ts_adapter")
local registerAbility = ____dota_ts_adapter.registerAbility
local _____item_bless_box_base = require("abilities.items._item_bless_box_base")
local _item_bless_box_base = _____item_bless_box_base._item_bless_box_base
____exports.item_bless_box_1 = __TS__Class()
local item_bless_box_1 = ____exports.item_bless_box_1
item_bless_box_1.name = "item_bless_box_1"
__TS__ClassExtends(item_bless_box_1, _item_bless_box_base)
function item_bless_box_1.prototype.____constructor(self, ...)
	_item_bless_box_base.prototype.____constructor(self, ...)
	self._bless_quality = 1
	self._check_record_key = "use_bless_box_1"
	self._draw_reason = 1001
end
item_bless_box_1 = __TS__Decorate({ registerAbility(nil) }, item_bless_box_1)
____exports.item_bless_box_1 = item_bless_box_1
return ____exports