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
____exports.item_0376 = __TS__Class()
local item_0376 = ____exports.item_0376
item_0376.name = "item_0376"
__TS__ClassExtends(item_0376, BaseItem_CS)
function item_0376.prototype.GetIntrinsicModifierName(self)
	return ____exports.modifier_item_0376_adventure.name
end
item_0376 = __TS__DecorateLegacy({ registerAbility(nil) }, item_0376)
____exports.item_0376 = item_0376
____exports.modifier_item_0376_adventure = __TS__Class()
local modifier_item_0376_adventure = ____exports.modifier_item_0376_adventure
modifier_item_0376_adventure.name = "modifier_item_0376_adventure"
__TS__ClassExtends(modifier_item_0376_adventure, BaseModifier_CS)
function modifier_item_0376_adventure.GetLocalizationCN(self)
	return {
		name = "冒险",
		description = "提高幸运值，但自身更容易受到伤害，造成的伤害降低。",
	}
end
function modifier_item_0376_adventure.prototype.GetAttributeBonus(self)
	local ability = self:GetAbility()
	if not ability then
		return {}
	end
	local ability_incoming_damage_increase_pct =
		ability:GetSpecialValueFor("ability_value_c_incoming_damage_increase_pct")
	local ability_outgoing_damage_reduction_pct =
		ability:GetSpecialValueFor("ability_value_c_outgoing_damage_reduction_pct")
	return {
		incoming_damage_increase_pct = ability_incoming_damage_increase_pct,
		outgoing_damage_pct = -math.abs(ability_outgoing_damage_reduction_pct),
	}
end
function modifier_item_0376_adventure.prototype.IsHidden(self)
	return true
end
function modifier_item_0376_adventure.prototype.IsPurgable(self)
	return false
end
modifier_item_0376_adventure = __TS__DecorateLegacy({ registerModifier(nil) }, modifier_item_0376_adventure)
____exports.modifier_item_0376_adventure = modifier_item_0376_adventure
return ____exports