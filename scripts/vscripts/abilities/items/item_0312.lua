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
local SHIELD_REGEN_INTERVAL = 1
____exports.item_0312 = __TS__Class()
local item_0312 = ____exports.item_0312
item_0312.name = "item_0312"
__TS__ClassExtends(item_0312, BaseItem_CS)
function item_0312.prototype.GetIntrinsicModifierName(self)
	return ____exports.modifier_item_0312_heal.name
end
item_0312 = __TS__DecorateLegacy({ registerAbility(nil) }, item_0312)
____exports.item_0312 = item_0312
____exports.modifier_item_0312_heal = __TS__Class()
local modifier_item_0312_heal = ____exports.modifier_item_0312_heal
modifier_item_0312_heal.name = "modifier_item_0312_heal"
__TS__ClassExtends(modifier_item_0312_heal, BaseModifier_CS)
function modifier_item_0312_heal.GetLocalizationCN(self)
	return { name = "治愈", description = "每秒恢复最大生命值与护盾值。" }
end
function modifier_item_0312_heal.prototype.OnCreated(self)
	if not IsServer() then
		return
	end
	self:StartIntervalThink(SHIELD_REGEN_INTERVAL)
end
function modifier_item_0312_heal.prototype.OnDestroy(self)
	if not IsServer() then
		return
	end
	self:StartIntervalThink(-1)
end
function modifier_item_0312_heal.prototype.OnIntervalThink(self)
	if not IsServer() then
		return
	end
	local parent = self:GetParent()
	local ability = self:GetAbility()
	if not ability or not IsValid(nil, ability) or ability:IsNull() or not IsValidAlive(nil, parent) then
		return
	end
	if not parent.GetTotalEnergyShield or not parent.GetCurrentEnergyShield or not parent.AddCurrentEnergyShield then
		return
	end
	local totalShield = math.max(0, parent:GetTotalEnergyShield())
	if totalShield <= 0 then
		return
	end
	local pct = math.max(0, ability:GetSpecialValueFor("ability_shield_regen_pct"))
	if pct <= 0 then
		return
	end
	local current = math.max(0, parent:GetCurrentEnergyShield())
	local missing = math.max(0, totalShield - current)
	if missing <= 0 then
		return
	end
	local restore = math.min(totalShield * (pct / 100), missing)
	if restore <= 0 then
		return
	end
	parent:AddCurrentEnergyShield(restore)
end
function modifier_item_0312_heal.prototype.IsHidden(self)
	return true
end
function modifier_item_0312_heal.prototype.IsDebuff(self)
	return false
end
function modifier_item_0312_heal.prototype.IsPurgable(self)
	return false
end
modifier_item_0312_heal = __TS__DecorateLegacy({ registerModifier(nil) }, modifier_item_0312_heal)
____exports.modifier_item_0312_heal = modifier_item_0312_heal
return ____exports