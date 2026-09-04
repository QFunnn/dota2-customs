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
local __TS__StringIncludes = ____lualib.__TS__StringIncludes
local __TS__ObjectEntries = ____lualib.__TS__ObjectEntries
local ____exports = {}
local ____dota_ts_adapter = require("utils.dota_ts_adapter")
local registerAbility = ____dota_ts_adapter.registerAbility
local registerModifier = ____dota_ts_adapter.registerModifier
local ____modifier_base = require("modifiers.class.modifier_base")
local BaseModifier_CS = ____modifier_base.BaseModifier_CS
local _____base_item = require("abilities.items._base_item")
local BaseItem_CS = _____base_item.BaseItem_CS
local REFRESH_INTERVAL = 0.5
local AMP_SLOTS = {
	0,
	1,
	2,
	3,
	4,
	5,
	15,
	16,
	17,
}
____exports.item_0560 = __TS__Class()
local item_0560 = ____exports.item_0560
item_0560.name = "item_0560"
__TS__ClassExtends(item_0560, BaseItem_CS)
function item_0560.prototype.GetIntrinsicModifierName(self)
	return ____exports.modifier_item_0560.name
end
item_0560 = __TS__DecorateLegacy({ registerAbility(nil) }, item_0560)
____exports.item_0560 = item_0560
____exports.modifier_item_0560 = __TS__Class()
local modifier_item_0560 = ____exports.modifier_item_0560
modifier_item_0560.name = "modifier_item_0560"
__TS__ClassExtends(modifier_item_0560, BaseModifier_CS)
function modifier_item_0560.prototype.____constructor(self, ...)
	BaseModifier_CS.prototype.____constructor(self, ...)
	self.appliedOperationIds = {}
end
function modifier_item_0560.prototype.OnCreated(self)
	if not IsServer() then
		return
	end
	self:RefreshAmp()
	self:StartIntervalThink(REFRESH_INTERVAL)
end
function modifier_item_0560.prototype.OnIntervalThink(self)
	if not IsServer() then
		return
	end
	self:RefreshAmp()
end
function modifier_item_0560.prototype.OnDestroy(self)
	if not IsServer() then
		return
	end
	self:StartIntervalThink(-1)
	local parent = self:GetParent()
	if IsValid(nil, parent) then
		MyGameAttribute:RunAttributeBatch(parent, function()
			self:ClearApplied(parent)
		end)
	end
end
function modifier_item_0560.prototype.IsHidden(self)
	return true
end
function modifier_item_0560.prototype.IsPurgable(self)
	return false
end
function modifier_item_0560.prototype.RefreshAmp(self)
	local parent = self:GetParent()
	local ability = self:GetAbility()
	if not ability or not parent or not parent:IsHero() then
		return
	end
	local ampPct = math.max(0, ability:GetSpecialValueFor("ability_amp_pct"))
	MyGameAttribute:RunAttributeBatch(parent, function()
		self:ClearApplied(parent)
		if ampPct <= 0 then
			return
		end
		local selfIndex = ability:GetEntityIndex()
		for ____, slot in ipairs(AMP_SLOTS) do
			local item = parent:GetItemInSlot(slot)
			if item and IsValid(nil, item) and item:GetEntityIndex() ~= selfIndex then
				self:AmpItem(parent, item, slot, ampPct)
			end
		end
	end)
end
function modifier_item_0560.prototype.AmpItem(self, parent, item, slot, ampPct)
	if MyGameItemManager:IsGemItem(item) then
		return
	end
	local special = MyGameItemManager:GetParseAttribute(item)
	if not special then
		local rulesetValues = MyGameRulesetManager and MyGameRulesetManager:ResolveItemAbilityValues(item:GetName())
		local ____rulesetValues_managed_6
		if rulesetValues and rulesetValues.managed then
			____rulesetValues_managed_6 = rulesetValues.values
		else
			local ____opt_4 = GetAbilityKeyValuesByName(item:GetName())
			____rulesetValues_managed_6 = ____opt_4 and ____opt_4.AbilityValues
		end
		special = ____rulesetValues_managed_6
	end
	if not special then
		return
	end
	for key in pairs(special) do
		do
			if __TS__StringIncludes(key, "ability_") and key ~= "ability_crit_chance_pct" then
				goto __continue24
			end
			local base = tonumber(special[key]) or 0
			if not base then
				goto __continue24
			end
			local ampValue = base * ampPct / 100
			if not ampValue then
				goto __continue24
			end
			local source = (
				((((self:GetName() .. ":") .. tostring(slot)) .. ":") .. tostring(item:GetEntityIndex())) .. ":"
			) .. key
			local opId = MyGameAttribute:AddAttribute(parent, key, ampValue, source)
			if opId then
				local ____self_appliedOperationIds_7, ____key_8 = self.appliedOperationIds, key
				if not ____self_appliedOperationIds_7[____key_8] then
					____self_appliedOperationIds_7[____key_8] = {}
				end
				local ____self_appliedOperationIds_key_10 = self.appliedOperationIds[key]
				____self_appliedOperationIds_key_10[#____self_appliedOperationIds_key_10 + 1] = opId
			end
		end
		::__continue24::
	end
end
function modifier_item_0560.prototype.ClearApplied(self, parent)
	for ____, ____value in ipairs(__TS__ObjectEntries(self.appliedOperationIds)) do
		local rawKey = ____value[1]
		local opIds = ____value[2]
		do
			if not opIds or #opIds == 0 then
				goto __continue31
			end
			local key = rawKey
			for ____, opId in ipairs(opIds) do
				MyGameAttribute:RemoveAttribute(parent, key, opId)
			end
		end
		::__continue31::
	end
	self.appliedOperationIds = {}
end
modifier_item_0560 = __TS__DecorateLegacy({ registerModifier(nil) }, modifier_item_0560)
____exports.modifier_item_0560 = modifier_item_0560
return ____exports