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
____exports.item_0227 = __TS__Class()
local item_0227 = ____exports.item_0227
item_0227.name = "item_0227"
__TS__ClassExtends(item_0227, BaseItem_CS)
function item_0227.prototype.GetIntrinsicModifierName(self)
	return "modifier_item_0227"
end
item_0227 = __TS__DecorateLegacy({ registerAbility(nil) }, item_0227)
____exports.item_0227 = item_0227
____exports.modifier_item_0227 = __TS__Class()
local modifier_item_0227 = ____exports.modifier_item_0227
modifier_item_0227.name = "modifier_item_0227"
__TS__ClassExtends(modifier_item_0227, BaseModifier_CS)
function modifier_item_0227.prototype.GetAttributeBonus(self)
	local parent = self:GetParent()
	local ____temp_2 = not parent or parent:IsNull()
	if not ____temp_2 then
		local ____opt_0 = parent.IsRangedAttacker
		____temp_2 = (____opt_0 and ____opt_0(parent)) ~= true
	end
	if ____temp_2 then
		return {}
	end
	local ability = self:GetAbility()
	local ____ability_3
	if ability then
		____ability_3 = ability:GetSpecialValueFor("ability_bonus_attack_range")
	else
		____ability_3 = 0
	end
	local ability_bonus_attack_range = ____ability_3
	return { bonus_attack_range = ability_bonus_attack_range }
end
modifier_item_0227 = __TS__DecorateLegacy({ registerModifier(nil) }, modifier_item_0227)
____exports.modifier_item_0227 = modifier_item_0227
return ____exports