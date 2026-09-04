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
local ____item_0330 = require("abilities.items.item_0330")
local RegenShieldWithHealthRegenPct = ____item_0330.RegenShieldWithHealthRegenPct
local BU_MIE_MUTEX_KEY = ____item_0330.BU_MIE_MUTEX_KEY
local THINK_INTERVAL = 0.2
____exports.item_0203 = __TS__Class()
local item_0203 = ____exports.item_0203
item_0203.name = "item_0203"
__TS__ClassExtends(item_0203, BaseItem_CS)
function item_0203.prototype.GetIntrinsicModifierName(self)
	return ____exports.modifier_item_0203.name
end
item_0203 = __TS__DecorateLegacy({ registerAbility(nil) }, item_0203)
____exports.item_0203 = item_0203
____exports.modifier_item_0203 = __TS__Class()
local modifier_item_0203 = ____exports.modifier_item_0203
modifier_item_0203.name = "modifier_item_0203"
__TS__ClassExtends(modifier_item_0203, BaseModifier_CS)
function modifier_item_0203.prototype.IsHidden(self)
	return true
end
function modifier_item_0203.prototype.IsPurgable(self)
	return false
end
function modifier_item_0203.prototype.GetMutexKey(self)
	return BU_MIE_MUTEX_KEY
end
function modifier_item_0203.prototype.GetMutexPriority(self)
	return 100
end
function modifier_item_0203.prototype.OnCreated(self)
	if not IsServer() then
		return
	end
	self:StartIntervalThink(THINK_INTERVAL)
end
function modifier_item_0203.prototype.OnDestroy(self)
	if not IsServer() then
		return
	end
	self:StartIntervalThink(-1)
end
function modifier_item_0203.prototype.OnIntervalThink(self)
	if not IsServer() then
		return
	end
	RegenShieldWithHealthRegenPct(nil, self:GetParent(), self:GetAbility(), THINK_INTERVAL)
end
modifier_item_0203 = __TS__DecorateLegacy({ registerModifier(nil) }, modifier_item_0203)
____exports.modifier_item_0203 = modifier_item_0203
return ____exports