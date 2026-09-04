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
local ____bleed_set = require("shared.bleed_set")
local CountBleedItems = ____bleed_set.CountBleedItems
local refreshInterval = 0.5
____exports.item_0516 = __TS__Class()
local item_0516 = ____exports.item_0516
item_0516.name = "item_0516"
__TS__ClassExtends(item_0516, BaseItem_CS)
function item_0516.prototype.GetIntrinsicModifierName(self)
	return ____exports.modifier_item_0516.name
end
item_0516 = __TS__DecorateLegacy({ registerAbility(nil) }, item_0516)
____exports.item_0516 = item_0516
____exports.modifier_item_0516 = __TS__Class()
local modifier_item_0516 = ____exports.modifier_item_0516
modifier_item_0516.name = "modifier_item_0516"
__TS__ClassExtends(modifier_item_0516, BaseModifier_CS)
function modifier_item_0516.prototype.____constructor(self, ...)
	BaseModifier_CS.prototype.____constructor(self, ...)
	self.cachedAttackPct = -1
	self.cachedPhysicalLifestealPct = -1
end
function modifier_item_0516.GetLocalizationCN(self)
	return {
		name = "魔神共鸣",
		description = "每件【魔神】套装备提高攻击力与物理吸血，最多生效3件（层数=当前生效件数）。",
	}
end
function modifier_item_0516.prototype.OnCreated(self)
	if not IsServer() then
		return
	end
	self:RecalculateDemonResonance(true)
	self:StartIntervalThink(refreshInterval)
end
function modifier_item_0516.prototype.OnIntervalThink(self)
	if not IsServer() then
		return
	end
	self:RecalculateDemonResonance(false)
end
function modifier_item_0516.prototype.OnDestroy(self)
	if not IsServer() then
		return
	end
	self:StartIntervalThink(-1)
end
function modifier_item_0516.prototype.IsHidden(self)
	return false
end
function modifier_item_0516.prototype.IsPurgable(self)
	return false
end
function modifier_item_0516.prototype.GetAttributeBonus(self)
	local ____temp_0
	if self.cachedAttackPct > 0 then
		____temp_0 = self.cachedAttackPct
	else
		____temp_0 = 0
	end
	local ____temp_1
	if self.cachedPhysicalLifestealPct > 0 then
		____temp_1 = self.cachedPhysicalLifestealPct
	else
		____temp_1 = 0
	end
	return { all_attack_damage_percent = ____temp_0, physical_lifesteal_pct = ____temp_1 }
end
function modifier_item_0516.prototype.RecalculateDemonResonance(self, forceRefresh)
	local parent = self:GetParent()
	local ability = self:GetAbility()
	if not IsValid(nil, parent) or not ability then
		return
	end
	local ability_demon_item_count = math.min(3, CountBleedItems(nil, parent))
	if self:GetStackCount() ~= ability_demon_item_count then
		self:SetStackCount(ability_demon_item_count)
	end
	local ability_value_demon_attack_pct = math.max(0, ability:GetSpecialValueFor("ability_value_demon_attack_pct"))
	local ability_value_demon_lifesteal_pct =
		math.max(0, ability:GetSpecialValueFor("ability_value_demon_lifesteal_pct"))
	local ability_attack_pct = math.max(0, ability_demon_item_count * ability_value_demon_attack_pct)
	local ability_physical_lifesteal_pct = math.max(0, ability_demon_item_count * ability_value_demon_lifesteal_pct)
	local ability_attack_changed = math.abs(ability_attack_pct - self.cachedAttackPct) >= 0.01
	local ability_lifesteal_changed = math.abs(ability_physical_lifesteal_pct - self.cachedPhysicalLifestealPct) >= 0.01
	if not forceRefresh and not ability_attack_changed and not ability_lifesteal_changed then
		return
	end
	self.cachedAttackPct = ability_attack_pct
	self.cachedPhysicalLifestealPct = ability_physical_lifesteal_pct
	if not forceRefresh then
		self:RefreshAttributes()
	end
end
modifier_item_0516 = __TS__DecorateLegacy({ registerModifier(nil) }, modifier_item_0516)
____exports.modifier_item_0516 = modifier_item_0516
return ____exports