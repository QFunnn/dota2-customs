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
____exports.item_0208 = __TS__Class()
local item_0208 = ____exports.item_0208
item_0208.name = "item_0208"
__TS__ClassExtends(item_0208, BaseItem_CS)
function item_0208.prototype.GetIntrinsicModifierName(self)
	return ____exports.modifier_item_0208_nullification.name
end
item_0208 = __TS__DecorateLegacy({ registerAbility(nil) }, item_0208)
____exports.item_0208 = item_0208
____exports.modifier_item_0208_nullification = __TS__Class()
local modifier_item_0208_nullification = ____exports.modifier_item_0208_nullification
modifier_item_0208_nullification.name = "modifier_item_0208_nullification"
__TS__ClassExtends(modifier_item_0208_nullification, BaseModifier_CS)
function modifier_item_0208_nullification.prototype.____constructor(self, ...)
	BaseModifier_CS.prototype.____constructor(self, ...)
	self.cachedEffectiveMagicalLifestealPct = -1
	self.cachedMagicalDamageAddPct = -1
end
function modifier_item_0208_nullification.prototype.GetAttributes(self)
	return MODIFIER_ATTRIBUTE_MULTIPLE
end
function modifier_item_0208_nullification.prototype.OnCreated(self)
	if not IsServer() then
		return
	end
	self:RecalculateDamageBonus(true)
	self:StartIntervalThink(0.2)
end
function modifier_item_0208_nullification.prototype.OnRefresh(self)
	if not IsServer() then
		return
	end
	self:RecalculateDamageBonus(true)
end
function modifier_item_0208_nullification.prototype.OnIntervalThink(self)
	if not IsServer() then
		return
	end
	self:RecalculateDamageBonus(false)
end
function modifier_item_0208_nullification.prototype.OnDestroy(self)
	if not IsServer() then
		return
	end
	self:StartIntervalThink(-1)
end
function modifier_item_0208_nullification.prototype.GetAttributeBonus(self)
	return { magical_damage_add_pct = self.cachedMagicalDamageAddPct }
end
function modifier_item_0208_nullification.prototype.IsHidden(self)
	return true
end
function modifier_item_0208_nullification.prototype.IsPurgable(self)
	return false
end
function modifier_item_0208_nullification.prototype.RecalculateDamageBonus(self, forceRefresh)
	local parent = self:GetParent()
	local ability = self:GetAbility()
	if not IsValid(nil, parent) or not ability then
		return
	end
	local ability_lifesteal_step_pct = math.max(0.01, ability:GetSpecialValueFor("ability_lifesteal_step_pct"))
	local ability_value_damage_bonus_per_step_pct =
		math.max(0, ability:GetSpecialValueFor("ability_value_damage_bonus_per_step_pct"))
	local ability_damage_bonus_max_pct = math.max(0, ability:GetSpecialValueFor("ability_value_damage_bonus_max_pct"))
	local ability_magical_lifesteal_pct =
		math.max(0, MyGameAttribute:GetAttribute(parent, "magical_lifesteal_pct") or 0)
	local ability_omni_lifesteal_pct = math.max(0, MyGameAttribute:GetAttribute(parent, "omni_lifesteal_pct") or 0)
	local ability_effective_magical_lifesteal_pct = ability_magical_lifesteal_pct + ability_omni_lifesteal_pct
	local ability_magical_damage_add_pct = math.min(
		ability_damage_bonus_max_pct,
		math.floor(ability_effective_magical_lifesteal_pct / ability_lifesteal_step_pct)
			* ability_value_damage_bonus_per_step_pct
	)
	local lifestealChanged = math.abs(ability_effective_magical_lifesteal_pct - self.cachedEffectiveMagicalLifestealPct)
		> 0.01
	local bonusChanged = ability_magical_damage_add_pct ~= self.cachedMagicalDamageAddPct
	if not forceRefresh and not lifestealChanged and not bonusChanged then
		return
	end
	self.cachedEffectiveMagicalLifestealPct = ability_effective_magical_lifesteal_pct
	self.cachedMagicalDamageAddPct = ability_magical_damage_add_pct
	self:RefreshAttributes()
end
modifier_item_0208_nullification = __TS__DecorateLegacy({ registerModifier(nil) }, modifier_item_0208_nullification)
____exports.modifier_item_0208_nullification = modifier_item_0208_nullification
return ____exports