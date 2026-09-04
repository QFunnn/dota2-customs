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
____exports.item_0395 = __TS__Class()
local item_0395 = ____exports.item_0395
item_0395.name = "item_0395"
__TS__ClassExtends(item_0395, BaseItem_CS)
function item_0395.prototype.GetIntrinsicModifierName(self)
	return ____exports.modifier_item_0395_blood_shield.name
end
item_0395 = __TS__DecorateLegacy({ registerAbility(nil) }, item_0395)
____exports.item_0395 = item_0395
____exports.modifier_item_0395_blood_shield = __TS__Class()
local modifier_item_0395_blood_shield = ____exports.modifier_item_0395_blood_shield
modifier_item_0395_blood_shield.name = "modifier_item_0395_blood_shield"
__TS__ClassExtends(modifier_item_0395_blood_shield, BaseModifier_CS)
function modifier_item_0395_blood_shield.prototype.DeclareEvents(self)
	return { BusinessEvents.ON_HEAL_PRE_APPLY, BusinessEvents.ON_HEAL_RECEIVED }
end
function modifier_item_0395_blood_shield.prototype.IsHidden(self)
	return true
end
function modifier_item_0395_blood_shield.prototype.IsDebuff(self)
	return false
end
function modifier_item_0395_blood_shield.prototype.IsPurgable(self)
	return false
end
function modifier_item_0395_blood_shield.prototype.OnHealPreApply_CS(self, event)
	if not IsServer() then
		return
	end
	local parent = self:GetParent()
	local ability = self:GetAbility()
	if not ability or not IsValidAlive(nil, parent) then
		return
	end
	if ability:GetAbilityName() ~= "item_0395" then
		return
	end
	if event.target ~= parent then
		return
	end
	if event.source ~= "attack_lifesteal" and event.source ~= "spell_lifesteal" then
		return
	end
	local ability_lifesteal_amount = math.max(0, event.requested_amount or 0)
	if ability_lifesteal_amount <= 0 then
		return
	end
	local ability_lifesteal_conversion_pct =
		math.min(100, math.max(0, ability:GetSpecialValueFor("ability_value_lifesteal_conversion_pct")))
	local ability_shield_conversion_efficiency_pct =
		math.max(0, ability:GetSpecialValueFor("ability_value_shield_conversion_efficiency_pct"))
	local ability_converted_lifesteal = ability_lifesteal_amount * (ability_lifesteal_conversion_pct / 100)
	event.requested_amount = math.max(0, ability_lifesteal_amount - ability_converted_lifesteal)
	local ability_restore_shield = ability_converted_lifesteal * (ability_shield_conversion_efficiency_pct / 100)
	self:RestoreShield(parent, ability_restore_shield)
end
function modifier_item_0395_blood_shield.prototype.OnHealReceived_CS(self, event)
	if not IsServer() then
		return
	end
	local parent = self:GetParent()
	local ability = self:GetAbility()
	if not ability or not IsValidAlive(nil, parent) then
		return
	end
	if event.target ~= parent then
		return
	end
	if ability:GetAbilityName() == "item_0395" then
		return
	end
	local overheal = math.max(0, event.overheal or 0)
	if overheal <= 0 then
		return
	end
	local ability_overheal_shield_pct = math.max(0, ability:GetSpecialValueFor("ability_value_overheal_shield_pct"))
	local ability_restore_shield = overheal * (ability_overheal_shield_pct / 100)
	self:RestoreShield(parent, ability_restore_shield)
end
function modifier_item_0395_blood_shield.prototype.RestoreShield(self, parent, restoreAmount)
	if restoreAmount <= 0 then
		return
	end
	if not parent.GetCurrentEnergyShield or not parent.GetTotalEnergyShield or not parent.AddCurrentEnergyShield then
		return
	end
	local totalShield = math.max(0, parent:GetTotalEnergyShield())
	local currentShield = math.max(0, parent:GetCurrentEnergyShield())
	local missingShield = math.max(0, totalShield - currentShield)
	if missingShield <= 0 then
		return
	end
	local ability_restore_shield = math.min(missingShield, restoreAmount)
	if ability_restore_shield <= 0 then
		return
	end
	parent:AddCurrentEnergyShield(ability_restore_shield)
	self:PlayEffects1(parent)
end
function modifier_item_0395_blood_shield.prototype.PlayEffects1(self, parent)
	parent:EmitSound("Item.Lotus.Heal")
end
modifier_item_0395_blood_shield = __TS__DecorateLegacy({ registerModifier(nil) }, modifier_item_0395_blood_shield)
____exports.modifier_item_0395_blood_shield = modifier_item_0395_blood_shield
return ____exports