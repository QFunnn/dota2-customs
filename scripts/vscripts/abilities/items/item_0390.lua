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
____exports.item_0390 = __TS__Class()
local item_0390 = ____exports.item_0390
item_0390.name = "item_0390"
__TS__ClassExtends(item_0390, BaseItem_CS)
function item_0390.prototype.GetIntrinsicModifierName(self)
	return "modifier_item_0390"
end
item_0390 = __TS__DecorateLegacy({ registerAbility(nil) }, item_0390)
____exports.item_0390 = item_0390
____exports.modifier_item_0390 = __TS__Class()
local modifier_item_0390 = ____exports.modifier_item_0390
modifier_item_0390.name = "modifier_item_0390"
__TS__ClassExtends(modifier_item_0390, BaseModifier_CS)
function modifier_item_0390.prototype.GetAttributeBonus(self)
	local ____opt_0 = self:GetAbility()
	local ____temp_4 = -(____opt_0 and ____opt_0:GetSpecialValueFor("ability_value_rate_move") or 0)
	local ____opt_2 = self:GetAbility()
	return {
		bonus_movespeed_pct = ____temp_4,
		damage_reduction_pct = ____opt_2 and ____opt_2:GetSpecialValueFor("ability_value_rate") or 0,
	}
end
function modifier_item_0390.prototype.IsHidden(self)
	return true
end
modifier_item_0390 = __TS__DecorateLegacy({ registerModifier(nil) }, modifier_item_0390)
____exports.modifier_item_0390 = modifier_item_0390
return ____exports