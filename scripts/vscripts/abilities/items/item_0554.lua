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
local ____ability_tag_context = require("shared.ability_tag_context")
local ResolveAbilityTags = ____ability_tag_context.ResolveAbilityTags
____exports.item_0554 = __TS__Class()
local item_0554 = ____exports.item_0554
item_0554.name = "item_0554"
__TS__ClassExtends(item_0554, BaseItem_CS)
function item_0554.prototype.GetIntrinsicModifierName(self)
	return ____exports.modifier_item_0554_blood_curse.name
end
item_0554 = __TS__DecorateLegacy({ registerAbility(nil) }, item_0554)
____exports.item_0554 = item_0554
____exports.modifier_item_0554_blood_curse = __TS__Class()
local modifier_item_0554_blood_curse = ____exports.modifier_item_0554_blood_curse
modifier_item_0554_blood_curse.name = "modifier_item_0554_blood_curse"
__TS__ClassExtends(modifier_item_0554_blood_curse, BaseModifier_CS)
function modifier_item_0554_blood_curse.prototype.____constructor(self, ...)
	BaseModifier_CS.prototype.____constructor(self, ...)
	self.cachedEvasionPct = -1
	self.cachedMagicResistancePct = 0
	self.legacyPatchesCleaned = false
end
function modifier_item_0554_blood_curse.GetLocalizationCN(self)
	return { name = "无光", description = "根据自身闪避率获得魔法抗性。" }
end
function modifier_item_0554_blood_curse.prototype.OnCreated(self)
	if not IsServer() then
		return
	end
	self:StartIntervalThink(0.5)
	self:SyncEffect(true)
end
function modifier_item_0554_blood_curse.prototype.OnRefresh(self)
	if not IsServer() then
		return
	end
	self:SyncEffect(true)
end
function modifier_item_0554_blood_curse.prototype.OnDestroy(self)
	if not IsServer() then
		return
	end
	self:StartIntervalThink(-1)
	self:ForEachMovementAbility(function(____, ability)
		return self:UnpatchAbility(ability)
	end)
end
function modifier_item_0554_blood_curse.prototype.OnIntervalThink(self)
	if not IsServer() then
		return
	end
	if not IsValidAlive(nil, self:GetParent()) then
		return
	end
	self:SyncEffect(false)
end
function modifier_item_0554_blood_curse.prototype.IsHidden(self)
	return false
end
function modifier_item_0554_blood_curse.prototype.IsDebuff(self)
	return false
end
function modifier_item_0554_blood_curse.prototype.IsPurgable(self)
	return false
end
function modifier_item_0554_blood_curse.prototype.GetTexture(self)
	return "item_icon_0554"
end
function modifier_item_0554_blood_curse.prototype.GetAttributeBonus(self)
	local ability = self:GetAbility()
	if not ability then
		return {}
	end
	return { base_magic_resistance = self.cachedMagicResistancePct }
end
function modifier_item_0554_blood_curse.prototype.SyncEffect(self, forceRefresh)
	if self.legacyPatchesCleaned ~= true then
		self:ForEachMovementAbility(function(____, ability)
			self:UnpatchAbility(ability)
			self:CleanupLegacyCapPatch(ability)
		end)
		self.legacyPatchesCleaned = true
	end
	self:RecalculateByEvasion(forceRefresh)
end
function modifier_item_0554_blood_curse.prototype.RecalculateByEvasion(self, forceRefresh)
	local parent = self:GetParent()
	local ability = self:GetAbility()
	if not IsValid(nil, parent) or not ability then
		return
	end
	local ability_evasion_step_pct = math.max(0.01, ability:GetSpecialValueFor("ability_evasion_step_pct"))
	local ability_magic_resistance_pct_per_step =
		math.max(0, ability:GetSpecialValueFor("ability_value_magic_resistance_pct_per_step"))
	local ability_magic_resistance_max_pct =
		math.max(0, ability:GetSpecialValueFor("ability_value_magic_resistance_max_pct"))
	local ability_evasion_pct = math.max(0, MyGameAttribute:GetAttribute(parent, "evasion_pct") or 0)
	local ability_magic_resistance_pct = math.min(
		ability_magic_resistance_max_pct,
		math.floor(ability_evasion_pct / ability_evasion_step_pct) * ability_magic_resistance_pct_per_step
	)
	local evasionChanged = math.abs(ability_evasion_pct - self.cachedEvasionPct) > 0.01
	local resistanceChanged = math.abs(ability_magic_resistance_pct - self.cachedMagicResistancePct) > 0.01
	if not forceRefresh and not evasionChanged and not resistanceChanged then
		return
	end
	self.cachedEvasionPct = ability_evasion_pct
	self.cachedMagicResistancePct = ability_magic_resistance_pct
	self:SetStackCount(ability_magic_resistance_pct)
	self:RefreshAttributes()
end
function modifier_item_0554_blood_curse.prototype.ForEachMovementAbility(self, callback)
	local parent = self:GetParent()
	if not parent or not IsValid(nil, parent) then
		return
	end
	local abilityCount = parent:GetAbilityCount()
	do
		local i = 0
		while i < abilityCount do
			do
				local ability = parent:GetAbilityByIndex(i)
				if not ability or not IsValid(nil, ability) or ability:IsNull() then
					goto __continue28
				end
				local ____opt_0 = ability.IsItem
				if ____opt_0 and ____opt_0(ability) then
					goto __continue28
				end
				local tags = ResolveAbilityTags(
					nil,
					MyGameRulesetManager and MyGameRulesetManager:GetAbilityConfig(ability:GetAbilityName())
				)
				if bit.band(tags, 4) == 0 then
					goto __continue28
				end
				callback(nil, ability)
			end
			::__continue28::
			i = i + 1
		end
	end
end
function modifier_item_0554_blood_curse.prototype.UnpatchAbility(self, ability)
	if ability.__item_0554_charge_time_increase_pct__ == nil then
		return
	end
	ability.__item_0554_charge_time_increase_pct__ = nil
	ability.GetCustomAbilityChargeRestoreTime = nil
	if MyGameAbilityChargeManager ~= nil then
		MyGameAbilityChargeManager:RefreshAbility(ability)
	end
end
function modifier_item_0554_blood_curse.prototype.CleanupLegacyCapPatch(self, ability)
	if ability.__item_0554_charge_cap_patched__ ~= true then
		return
	end
	ability.__item_0554_charge_cap_patched__ = nil
	ability.GetCustomAbilityMaxCharges = nil
	if MyGameAbilityChargeManager ~= nil then
		MyGameAbilityChargeManager:RefreshAbility(ability)
	end
end
modifier_item_0554_blood_curse = __TS__DecorateLegacy({ registerModifier(nil) }, modifier_item_0554_blood_curse)
____exports.modifier_item_0554_blood_curse = modifier_item_0554_blood_curse
return ____exports