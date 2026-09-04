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
local ITEM_0336_REFRESH_INTERVAL = 0.2
____exports.item_0336 = __TS__Class()
local item_0336 = ____exports.item_0336
item_0336.name = "item_0336"
__TS__ClassExtends(item_0336, BaseItem_CS)
function item_0336.prototype.GetIntrinsicModifierName(self)
	return ____exports.modifier_item_0336_sage_boots.name
end
item_0336 = __TS__DecorateLegacy({ registerAbility(nil) }, item_0336)
____exports.item_0336 = item_0336
____exports.modifier_item_0336_sage_boots = __TS__Class()
local modifier_item_0336_sage_boots = ____exports.modifier_item_0336_sage_boots
modifier_item_0336_sage_boots.name = "modifier_item_0336_sage_boots"
__TS__ClassExtends(modifier_item_0336_sage_boots, BaseModifier_CS)
function modifier_item_0336_sage_boots.prototype.____constructor(self, ...)
	BaseModifier_CS.prototype.____constructor(self, ...)
	self.cachedCurrentMana = -1
	self.cachedMagicalDamageAddPct = -1
end
function modifier_item_0336_sage_boots.GetLocalizationCN(self)
	return { name = "魔法伤害加成", description = "根据最大魔法值获得的魔法伤害加成。" }
end
function modifier_item_0336_sage_boots.prototype.GetAttributes(self)
	return MODIFIER_ATTRIBUTE_MULTIPLE
end
function modifier_item_0336_sage_boots.prototype.OnCreated(self)
	if not IsServer() then
		return
	end
	self:RecalculateMysticBonus(true)
	self:StartIntervalThink(ITEM_0336_REFRESH_INTERVAL)
end
function modifier_item_0336_sage_boots.prototype.OnRefresh(self)
	if not IsServer() then
		return
	end
	self:RecalculateMysticBonus(true)
end
function modifier_item_0336_sage_boots.prototype.OnIntervalThink(self)
	if not IsServer() then
		return
	end
	self:RecalculateMysticBonus(false)
end
function modifier_item_0336_sage_boots.prototype.OnDestroy(self)
	if not IsServer() then
		return
	end
	self:StartIntervalThink(-1)
end
function modifier_item_0336_sage_boots.prototype.GetAttributeBonus(self)
	return { magical_damage_add_pct = self.cachedMagicalDamageAddPct }
end
function modifier_item_0336_sage_boots.prototype.IsPurgable(self)
	return false
end
function modifier_item_0336_sage_boots.prototype.RecalculateMysticBonus(self, forceRefresh)
	local parent = self:GetParent()
	local ability = self:GetAbility()
	if not IsValid(nil, parent) or not ability then
		return
	end
	local ability_mana_threshold = math.max(0, ability:GetSpecialValueFor("ability_mana_threshold"))
	local ability_mana_per_magic_damage_pct =
		math.max(1, ability:GetSpecialValueFor("ability_value_c_mana_per_magic_damage_pct"))
	local ability_bonus_magic_damage_pct_per_step =
		math.max(0, ability:GetSpecialValueFor("ability_bonus_magic_damage_pct_per_step"))
	local ability_bonus_magic_damage_pct_max =
		math.max(0, ability:GetSpecialValueFor("ability_value_bonus_magic_damage_pct_max"))
	local cap = ability_bonus_magic_damage_pct_max
	local currentMana = math.max(0, MyGameAttribute:GetAttribute(parent, "total_mana") or parent:GetMaxMana())
	local extraMana = math.max(0, currentMana - ability_mana_threshold)
	local magicalDamageAddPct = math.min(
		cap,
		math.floor(extraMana / ability_mana_per_magic_damage_pct) * ability_bonus_magic_damage_pct_per_step
	)
	local manaChanged = math.abs(currentMana - self.cachedCurrentMana) > 0.01
	local bonusChanged = magicalDamageAddPct ~= self.cachedMagicalDamageAddPct
	if not forceRefresh and not manaChanged and not bonusChanged then
		return
	end
	self.cachedCurrentMana = currentMana
	self.cachedMagicalDamageAddPct = magicalDamageAddPct
	self:SetStackCount(magicalDamageAddPct)
	self:RefreshAttributes()
end
modifier_item_0336_sage_boots = __TS__DecorateLegacy({ registerModifier(nil) }, modifier_item_0336_sage_boots)
____exports.modifier_item_0336_sage_boots = modifier_item_0336_sage_boots
return ____exports