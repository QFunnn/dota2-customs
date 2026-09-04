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
____exports.item_0329 = __TS__Class()
local item_0329 = ____exports.item_0329
item_0329.name = "item_0329"
__TS__ClassExtends(item_0329, BaseItem_CS)
function item_0329.prototype.GetIntrinsicModifierName(self)
	return ____exports.modifier_item_0329_lionheart.name
end
item_0329 = __TS__DecorateLegacy({ registerAbility(nil) }, item_0329)
____exports.item_0329 = item_0329
____exports.modifier_item_0329_lionheart = __TS__Class()
local modifier_item_0329_lionheart = ____exports.modifier_item_0329_lionheart
modifier_item_0329_lionheart.name = "modifier_item_0329_lionheart"
__TS__ClassExtends(modifier_item_0329_lionheart, BaseModifier_CS)
function modifier_item_0329_lionheart.prototype.____constructor(self, ...)
	BaseModifier_CS.prototype.____constructor(self, ...)
	self.cached_bonus_shield_from_strength = -1
end
function modifier_item_0329_lionheart.prototype.OnCreated(self)
	if not IsServer() then
		return
	end
	self:RecalculateBonusShieldFromStrength(true)
	self:StartIntervalThink(____exports.modifier_item_0329_lionheart.RECALCULATE_INTERVAL)
end
function modifier_item_0329_lionheart.prototype.OnIntervalThink(self)
	if not IsServer() then
		return
	end
	self:RecalculateBonusShieldFromStrength(false)
	self:RechargeEnergyShield()
end
function modifier_item_0329_lionheart.prototype.IsHidden(self)
	return true
end
function modifier_item_0329_lionheart.prototype.IsPurgable(self)
	return false
end
function modifier_item_0329_lionheart.prototype.GetAttributeBonus(self)
	local ____temp_0
	if self.cached_bonus_shield_from_strength > 0 then
		____temp_0 = self.cached_bonus_shield_from_strength
	else
		____temp_0 = 0
	end
	local ability_bonus_shield_from_strength = ____temp_0
	return { base_energy_shield = ability_bonus_shield_from_strength }
end
function modifier_item_0329_lionheart.prototype.RecalculateBonusShieldFromStrength(self, forceRefresh)
	local parent = self:GetParent()
	local ability = self:GetAbility()
	if not IsValid(nil, parent) or not ability then
		return
	end
	local ability_shield_per_strength = ability:GetSpecialValueFor("ability_shield_per_strength")
	local total_strength = MyGameAttribute:GetAttribute(parent, "total_strength") or 0
	local ability_bonus_shield_from_strength = math.max(0, total_strength * ability_shield_per_strength)
	if
		not forceRefresh
		and math.abs(ability_bonus_shield_from_strength - self.cached_bonus_shield_from_strength) < 0.01
	then
		return
	end
	self.cached_bonus_shield_from_strength = ability_bonus_shield_from_strength
	local ____ = not forceRefresh and self:RefreshAttributes()
end
function modifier_item_0329_lionheart.prototype.RechargeEnergyShield(self)
	local parent = self:GetParent()
	local ability = self:GetAbility()
	if not IsValidAlive(nil, parent) or not ability then
		return
	end
	if not parent.AddCurrentEnergyShield then
		return
	end
	local ability_shield_regen_pct_per_second = ability:GetSpecialValueFor("ability_value_shield_regen_pct_per_second")
	if ability_shield_regen_pct_per_second <= 0 then
		return
	end
	local total_energy_shield = MyGameAttribute:GetAttribute(parent, "total_energy_shield") or 0
	if total_energy_shield <= 0 then
		return
	end
	local interval = ____exports.modifier_item_0329_lionheart.RECALCULATE_INTERVAL
	local delta = total_energy_shield * (ability_shield_regen_pct_per_second / 100) * interval
	if delta <= 0 then
		return
	end
	parent:AddCurrentEnergyShield(delta)
end
modifier_item_0329_lionheart.RECALCULATE_INTERVAL = 0.5
modifier_item_0329_lionheart = __TS__DecorateLegacy({ registerModifier(nil) }, modifier_item_0329_lionheart)
____exports.modifier_item_0329_lionheart = modifier_item_0329_lionheart
return ____exports