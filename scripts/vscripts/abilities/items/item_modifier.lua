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
local __TS__StringIncludes = ____lualib.__TS__StringIncludes
local __TS__ObjectEntries = ____lualib.__TS__ObjectEntries
local __TS__DecorateLegacy = ____lualib.__TS__DecorateLegacy
local ____exports = {}
local ____dota_ts_adapter = require("utils.dota_ts_adapter")
local registerModifier = ____dota_ts_adapter.registerModifier
local ____modifier_base = require("modifiers.class.modifier_base")
local BaseModifier_CS = ____modifier_base.BaseModifier_CS
local PET_EQUIPMENT_SLOT = 17
____exports.hero_item_base_modifier = __TS__Class()
local hero_item_base_modifier = ____exports.hero_item_base_modifier
hero_item_base_modifier.name = "hero_item_base_modifier"
__TS__ClassExtends(hero_item_base_modifier, BaseModifier_CS)
function hero_item_base_modifier.prototype.____constructor(self, ...)
	BaseModifier_CS.prototype.____constructor(self, ...)
	self.appliedOperationIds = {}
end
function hero_item_base_modifier.prototype.OnCreated(self, parameters)
	if not IsServer() then
		return
	end
	BaseModifier_CS.prototype.OnCreated(self, parameters)
	self:RefreshAllItemAttributes()
end
function hero_item_base_modifier.prototype.RefreshAllItemAttributes(self)
	local parent = self:GetParent()
	if not parent or not parent:IsHero() then
		return
	end
	MyGameAttribute:RunAttributeBatch(parent, function()
		self:ClearAppliedAttributes(parent)
		do
			local i = 0
			while i <= 5 do
				local item = parent:GetItemInSlot(i)
				if item and IsValid(nil, item) then
					self:ParseAttribute(parent, item, i)
				end
				i = i + 1
			end
		end
		local item = parent:GetItemInSlot(15)
		if item and IsValid(nil, item) then
			self:ParseAttribute(parent, item, 15)
		end
		local item16 = parent:GetItemInSlot(16)
		if item16 and IsValid(nil, item16) then
			self:ParseAttribute(parent, item16, 16)
		end
		local petItem = parent:GetItemInSlot(PET_EQUIPMENT_SLOT)
		if petItem and IsValid(nil, petItem) then
			self:ParseAttribute(parent, petItem, PET_EQUIPMENT_SLOT)
		end
	end)
end
function hero_item_base_modifier.prototype.ParseAttribute(self, parent, item, slot)
	if MyGameItemManager:IsGemItem(item) then
		return
	end
	local special = MyGameItemManager:GetParseAttribute(item)
	if special then
		for key in pairs(special) do
			do
				if __TS__StringIncludes(key, "ability_") and key ~= "ability_crit_chance_pct" then
					goto __continue15
				end
				self:ApplySingleAttribute(parent, key, tonumber(special[key]) or 0, item, slot)
			end
			::__continue15::
		end
	else
		local rulesetValues = MyGameRulesetManager and MyGameRulesetManager:ResolveItemAbilityValues(item:GetName())
		local ____rulesetValues_managed_6
		if rulesetValues and rulesetValues.managed then
			____rulesetValues_managed_6 = rulesetValues.values
		else
			local ____opt_4 = GetAbilityKeyValuesByName(item:GetName())
			____rulesetValues_managed_6 = ____opt_4 and ____opt_4.AbilityValues
		end
		local fallbackValues = ____rulesetValues_managed_6
		if fallbackValues then
			for key in pairs(fallbackValues) do
				do
					if __TS__StringIncludes(key, "ability_") and key ~= "ability_crit_chance_pct" then
						goto __continue20
					end
					self:ApplySingleAttribute(parent, key, tonumber(fallbackValues[key]) or 0, item, slot)
				end
				::__continue20::
			end
		end
	end
end
function hero_item_base_modifier.prototype.ApplySingleAttribute(self, parent, key, value, item, slot)
	if not value then
		return
	end
	local source = (((((self:GetName() .. ":") .. tostring(slot)) .. ":") .. tostring(item:GetEntityIndex())) .. ":")
		.. key
	local opId = MyGameAttribute:AddAttribute(parent, key, value, source)
	if not opId then
		return
	end
	local ____self_appliedOperationIds_7, ____key_8 = self.appliedOperationIds, key
	if not ____self_appliedOperationIds_7[____key_8] then
		____self_appliedOperationIds_7[____key_8] = {}
	end
	local ____self_appliedOperationIds_key_10 = self.appliedOperationIds[key]
	____self_appliedOperationIds_key_10[#____self_appliedOperationIds_key_10 + 1] = opId
end
function hero_item_base_modifier.prototype.ClearAppliedAttributes(self, parent)
	for ____, ____value in ipairs(__TS__ObjectEntries(self.appliedOperationIds)) do
		local rawKey = ____value[1]
		local opIds = ____value[2]
		do
			if not opIds or #opIds == 0 then
				goto __continue27
			end
			local key = rawKey
			for ____, opId in ipairs(opIds) do
				MyGameAttribute:RemoveAttribute(parent, key, opId)
			end
		end
		::__continue27::
	end
	self.appliedOperationIds = {}
end
function hero_item_base_modifier.prototype.OnDestroy(self)
	if not IsServer() then
		return
	end
	local parent = self:GetParent()
	if IsValid(nil, parent) then
		MyGameAttribute:RunAttributeBatch(parent, function()
			self:ClearAppliedAttributes(parent)
		end)
	end
	BaseModifier_CS.prototype.OnDestroy(self)
end
function hero_item_base_modifier.prototype.DeclareEvents(self)
	return { BusinessEvents.ON_HERO_INVENTORY_ITEM_CHANGE }
end
function hero_item_base_modifier.prototype.OnHeroInventoryItemChange_CS(self, event)
	self:RefreshAllItemAttributes()
end
function hero_item_base_modifier.prototype.GetEffectName(self)
	return "particles/dire_creep_banner_ring12.vpcf"
end
function hero_item_base_modifier.prototype.IsHidden(self)
	return true
end
hero_item_base_modifier = __TS__DecorateLegacy({ registerModifier(nil) }, hero_item_base_modifier)
____exports.hero_item_base_modifier = hero_item_base_modifier
return ____exports