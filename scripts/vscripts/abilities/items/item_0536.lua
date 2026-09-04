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
local armorRefreshInterval = 0.2
____exports.item_0536 = __TS__Class()
local item_0536 = ____exports.item_0536
item_0536.name = "item_0536"
__TS__ClassExtends(item_0536, BaseItem_CS)
function item_0536.prototype.GetIntrinsicModifierName(self)
	return ____exports.modifier_item_0536_passive.name
end
item_0536 = __TS__DecorateLegacy({ registerAbility(nil) }, item_0536)
____exports.item_0536 = item_0536
____exports.modifier_item_0536_passive = __TS__Class()
local modifier_item_0536_passive = ____exports.modifier_item_0536_passive
modifier_item_0536_passive.name = "modifier_item_0536_passive"
__TS__ClassExtends(modifier_item_0536_passive, BaseModifier_CS)
function modifier_item_0536_passive.prototype.____constructor(self, ...)
	BaseModifier_CS.prototype.____constructor(self, ...)
	self.cachedTotalArmor = -1
	self.cachedOutgoingDamagePct = 0
end
function modifier_item_0536_passive.GetLocalizationCN(self)
	return { name = "碎甲", description = "受到的伤害增加，并按当前总护甲获得最终伤害增幅。" }
end
function modifier_item_0536_passive.prototype.OnCreated(self)
	if not IsServer() then
		return
	end
	local parent = self:GetParent()
	if not IsValidAlive(nil, parent) then
		return
	end
	self:RecalculateByArmor(true)
	self:StartIntervalThink(armorRefreshInterval)
end
function modifier_item_0536_passive.prototype.OnRefresh(self)
	if not IsServer() then
		return
	end
	local parent = self:GetParent()
	if not IsValidAlive(nil, parent) then
		return
	end
	self:RecalculateByArmor(true)
end
function modifier_item_0536_passive.prototype.OnIntervalThink(self)
	if not IsServer() then
		return
	end
	local parent = self:GetParent()
	if not IsValidAlive(nil, parent) then
		return
	end
	self:RecalculateByArmor(false)
end
function modifier_item_0536_passive.prototype.OnDestroy(self)
	if not IsServer() then
		return
	end
	self:StartIntervalThink(-1)
end
function modifier_item_0536_passive.prototype.GetAttributeBonus(self)
	local ability = self:GetAbility()
	if not ability or not IsValid(nil, ability) then
		return {}
	end
	local ability_incoming_damage_increase_pct =
		math.max(0, ability:GetSpecialValueFor("ability_incoming_damage_increase_pct"))
	return {
		incoming_damage_increase_pct = ability_incoming_damage_increase_pct,
		outgoing_damage_pct_2 = self.cachedOutgoingDamagePct,
	}
end
function modifier_item_0536_passive.prototype.IsDebuff(self)
	return true
end
function modifier_item_0536_passive.prototype.IsPurgable(self)
	return false
end
function modifier_item_0536_passive.prototype.RecalculateByArmor(self, forceRefresh)
	local parent = self:GetParent()
	local ability = self:GetAbility()
	if not IsValid(nil, parent) or not ability or not IsValid(nil, ability) then
		return
	end
	local ability_armor_step = math.max(1, ability:GetSpecialValueFor("ability_value_c_armor_step"))
	local ability_outgoing_damage_pct_per_step =
		math.max(0, ability:GetSpecialValueFor("ability_outgoing_damage_pct_per_step"))
	local ability_outgoing_damage_max_pct =
		math.max(0, ability:GetSpecialValueFor("ability_value_outgoing_damage_max_pct"))
	local ability_total_armor = math.max(0, MyGameAttribute:GetAttribute(parent, "total_armor") or 0)
	local ability_outgoing_damage_pct = math.min(
		ability_outgoing_damage_max_pct,
		math.floor(ability_total_armor / ability_armor_step) * ability_outgoing_damage_pct_per_step
	)
	local ability_armor_changed = math.abs(ability_total_armor - self.cachedTotalArmor) > 0.01
	local ability_damage_changed = math.abs(ability_outgoing_damage_pct - self.cachedOutgoingDamagePct) > 0.01
	if not forceRefresh and not ability_armor_changed and not ability_damage_changed then
		return
	end
	self.cachedTotalArmor = ability_total_armor
	self.cachedOutgoingDamagePct = ability_outgoing_damage_pct
	self:SetStackCount(ability_outgoing_damage_pct)
	self:RefreshAttributes()
end
function modifier_item_0536_passive.prototype.GetEffectName(self)
	return "item_icon_zb98_26"
end
modifier_item_0536_passive = __TS__DecorateLegacy({ registerModifier(nil) }, modifier_item_0536_passive)
____exports.modifier_item_0536_passive = modifier_item_0536_passive
return ____exports