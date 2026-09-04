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
local registerModifier = ____dota_ts_adapter.registerModifier
local ____modifier_base = require("modifiers.class.modifier_base")
local BaseModifier_CS = ____modifier_base.BaseModifier_CS
local _____base_item = require("abilities.items._base_item")
local BaseItem_CS = _____base_item.BaseItem_CS
____exports.item_0239 = __TS__Class()
local item_0239 = ____exports.item_0239
item_0239.name = "item_0239"
__TS__ClassExtends(item_0239, BaseItem_CS)
function item_0239.prototype.GetIntrinsicModifierName(self)
	return "modifier_item_0239"
end
item_0239 = __TS__DecorateLegacy({ registerAbility(nil) }, item_0239)
____exports.item_0239 = item_0239
____exports.modifier_item_0239 = __TS__Class()
local modifier_item_0239 = ____exports.modifier_item_0239
modifier_item_0239.name = "modifier_item_0239"
__TS__ClassExtends(modifier_item_0239, BaseModifier_CS)
function modifier_item_0239.prototype.GetAttributeBonus(self)
	return { attack_speed_pct = -10, bonus_movespeed_pct = -10 }
end
function modifier_item_0239.prototype.IsHidden(self)
	return true
end
modifier_item_0239 = __TS__DecorateLegacy({ registerModifier(nil) }, modifier_item_0239)
____exports.modifier_item_0239 = modifier_item_0239
return ____exports