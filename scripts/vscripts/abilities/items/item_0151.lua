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
local ITEM_0249_EXECUTE_PARTICLE = "particles/item/econ/items/necrolyte/necro_sullen_harvest/item_249.vpcf"
____exports.item_0141 = __TS__Class()
local item_0141 = ____exports.item_0141
item_0141.name = "item_0141"
__TS__ClassExtends(item_0141, BaseItem_CS)
function item_0141.prototype.GetIntrinsicModifierName(self)
	return "modifier_item_0141"
end
item_0141 = __TS__DecorateLegacy({ registerAbility(nil) }, item_0141)
____exports.item_0141 = item_0141
____exports.item_0151 = __TS__Class()
local item_0151 = ____exports.item_0151
item_0151.name = "item_0151"
__TS__ClassExtends(item_0151, BaseItem_CS)
function item_0151.prototype.GetIntrinsicModifierName(self)
	return "modifier_item_0141"
end
item_0151 = __TS__DecorateLegacy({ registerAbility(nil) }, item_0151)
____exports.item_0151 = item_0151
____exports.modifier_item_0141 = __TS__Class()
local modifier_item_0141 = ____exports.modifier_item_0141
modifier_item_0141.name = "modifier_item_0141"
__TS__ClassExtends(modifier_item_0141, BaseModifier_CS)
function modifier_item_0141.prototype.OnCreated(self, params)
	if not IsServer() then
		return
	end
	BaseModifier_CS.prototype.OnCreated(self, params)
	local parent = self:GetParent()
	parent:AddCustomValue("寒冷抗性", 68)
end
function modifier_item_0141.prototype.OnDestroy(self)
	if not IsServer() then
		return
	end
	local parent = self:GetParent()
	parent:AddCustomValue("寒冷抗性", -68)
end
function modifier_item_0141.prototype.IsHidden(self)
	return true
end
modifier_item_0141 = __TS__DecorateLegacy({ registerModifier(nil) }, modifier_item_0141)
____exports.modifier_item_0141 = modifier_item_0141
____exports.item_0175 = __TS__Class()
local item_0175 = ____exports.item_0175
item_0175.name = "item_0175"
__TS__ClassExtends(item_0175, BaseItem_CS)
function item_0175.prototype.GetIntrinsicModifierName(self)
	return "modifier_item_0175"
end
item_0175 = __TS__DecorateLegacy({ registerAbility(nil) }, item_0175)
____exports.item_0175 = item_0175
____exports.modifier_item_0175 = __TS__Class()
local modifier_item_0175 = ____exports.modifier_item_0175
modifier_item_0175.name = "modifier_item_0175"
__TS__ClassExtends(modifier_item_0175, BaseModifier_CS)
function modifier_item_0175.prototype.OnCreated(self, params)
	if not IsServer() then
		return
	end
	BaseModifier_CS.prototype.OnCreated(self, params)
	local parent = self:GetParent()
	parent:AddCustomValue("寒冷抗性", 100)
end
function modifier_item_0175.prototype.OnDestroy(self)
	if not IsServer() then
		return
	end
	local parent = self:GetParent()
	parent:AddCustomValue("寒冷抗性", -100)
end
function modifier_item_0175.prototype.IsHidden(self)
	return true
end
modifier_item_0175 = __TS__DecorateLegacy({ registerModifier(nil) }, modifier_item_0175)
____exports.modifier_item_0175 = modifier_item_0175
return ____exports