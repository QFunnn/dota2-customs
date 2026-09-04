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
____exports.item_0444 = __TS__Class()
local item_0444 = ____exports.item_0444
item_0444.name = "item_0444"
__TS__ClassExtends(item_0444, BaseItem_CS)
function item_0444.prototype.GetIntrinsicModifierName(self)
	return ____exports.modifier_item_0444_armor_penetration.name
end
item_0444 = __TS__DecorateLegacy({ registerAbility(nil) }, item_0444)
____exports.item_0444 = item_0444
____exports.modifier_item_0444_armor_penetration = __TS__Class()
local modifier_item_0444_armor_penetration = ____exports.modifier_item_0444_armor_penetration
modifier_item_0444_armor_penetration.name = "modifier_item_0444_armor_penetration"
__TS__ClassExtends(modifier_item_0444_armor_penetration, BaseModifier_CS)
function modifier_item_0444_armor_penetration.prototype.GetAttributeBonus(self)
	local ability = self:GetAbility()
	if not ability then
		return {}
	end
	local ability_physical_armor_penetration_pct =
		math.max(0, ability:GetSpecialValueFor("ability_value_physical_armor_penetration_pct"))
	return { physical_armor_penetration_pct = ability_physical_armor_penetration_pct }
end
function modifier_item_0444_armor_penetration.prototype.IsHidden(self)
	return true
end
function modifier_item_0444_armor_penetration.prototype.IsPurgable(self)
	return false
end
modifier_item_0444_armor_penetration =
	__TS__DecorateLegacy({ registerModifier(nil) }, modifier_item_0444_armor_penetration)
____exports.modifier_item_0444_armor_penetration = modifier_item_0444_armor_penetration
return ____exports