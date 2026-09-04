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
local ____item_0608_attribute_math = require("abilities.items.item_0608_attribute_math")
local GetItem0608FlatGrant = ____item_0608_attribute_math.GetItem0608FlatGrant
local GetItem0608TotalWithoutGrant = ____item_0608_attribute_math.GetItem0608TotalWithoutGrant
local THINK_INTERVAL = 0.5
____exports.item_0608 = __TS__Class()
local item_0608 = ____exports.item_0608
item_0608.name = "item_0608"
__TS__ClassExtends(item_0608, BaseItem_CS)
function item_0608.prototype.GetIntrinsicModifierName(self)
	return ____exports.modifier_item_0608.name
end
item_0608 = __TS__DecorateLegacy({ registerAbility(nil) }, item_0608)
____exports.item_0608 = item_0608
--- 固有被动「偏执」：强化裸值最高的一维，削弱其余两维（层数=当前强化项）。
____exports.modifier_item_0608 = __TS__Class()
local modifier_item_0608 = ____exports.modifier_item_0608
modifier_item_0608.name = "modifier_item_0608"
__TS__ClassExtends(modifier_item_0608, BaseModifier_CS)
function modifier_item_0608.prototype.____constructor(self, ...)
	BaseModifier_CS.prototype.____constructor(self, ...)
	self.grantStr = 0
	self.grantAgi = 0
	self.grantInt = 0
	self.target = 0
end
function modifier_item_0608.GetLocalizationCN(self)
	return {
		name = "偏执",
		description = "强化当前最高的一项属性，削弱其余两项（1=力量、2=敏捷、3=智力）。",
	}
end
function modifier_item_0608.prototype.OnCreated(self)
	if not IsServer() then
		return
	end
	self:StartIntervalThink(THINK_INTERVAL)
end
function modifier_item_0608.prototype.OnDestroy(self)
	if not IsServer() then
		return
	end
	self:StartIntervalThink(-1)
end
function modifier_item_0608.prototype.OnIntervalThink(self)
	if not IsServer() then
		return
	end
	local parent = self:GetParent()
	local ability = self:GetAbility()
	if not ability or not IsValid(nil, ability) or not IsValidAlive(nil, parent) then
		return
	end
	local allAllStatsPct = MyGameAttribute:GetAttribute(parent, "all_all_stats_pct") or 0
	local strengthPct = (MyGameAttribute:GetAttribute(parent, "all_strength_pct") or 0) + allAllStatsPct
	local agilityPct = (MyGameAttribute:GetAttribute(parent, "all_agility_pct") or 0) + allAllStatsPct
	local intelligencePct = (MyGameAttribute:GetAttribute(parent, "all_intelligence_pct") or 0) + allAllStatsPct
	local rawStr = GetItem0608TotalWithoutGrant(
		nil,
		MyGameAttribute:GetAttribute(parent, "total_strength") or 0,
		self.grantStr,
		strengthPct
	)
	local rawAgi = GetItem0608TotalWithoutGrant(
		nil,
		MyGameAttribute:GetAttribute(parent, "total_agility") or 0,
		self.grantAgi,
		agilityPct
	)
	local rawInt = GetItem0608TotalWithoutGrant(
		nil,
		MyGameAttribute:GetAttribute(parent, "total_intelligence") or 0,
		self.grantInt,
		intelligencePct
	)
	local raws = { rawStr, rawAgi, rawInt }
	local best = self.target
	do
		local i = 0
		while i < 3 do
			if raws[i + 1] > raws[best + 1] then
				best = i
			end
			i = i + 1
		end
	end
	self.target = best
	local ability_boost_pct = math.max(0, ability:GetSpecialValueFor("ability_value_boost_pct"))
	local ability_reduce_pct = math.max(0, ability:GetSpecialValueFor("ability_value_c_reduce_pct"))
	local ____GetItem0608FlatGrant_1 = GetItem0608FlatGrant
	local ____temp_0
	if best == 0 then
		____temp_0 = ability_boost_pct
	else
		____temp_0 = ability_reduce_pct
	end
	self.grantStr = ____GetItem0608FlatGrant_1(nil, rawStr, strengthPct, ____temp_0)
	local ____GetItem0608FlatGrant_3 = GetItem0608FlatGrant
	local ____temp_2
	if best == 1 then
		____temp_2 = ability_boost_pct
	else
		____temp_2 = ability_reduce_pct
	end
	self.grantAgi = ____GetItem0608FlatGrant_3(nil, rawAgi, agilityPct, ____temp_2)
	local ____GetItem0608FlatGrant_5 = GetItem0608FlatGrant
	local ____temp_4
	if best == 2 then
		____temp_4 = ability_boost_pct
	else
		____temp_4 = ability_reduce_pct
	end
	self.grantInt = ____GetItem0608FlatGrant_5(nil, rawInt, intelligencePct, ____temp_4)
	if best ~= 0 then
		self.grantStr = -self.grantStr
	end
	if best ~= 1 then
		self.grantAgi = -self.grantAgi
	end
	if best ~= 2 then
		self.grantInt = -self.grantInt
	end
	self:SetStackCount(best + 1)
	self:RefreshAttributes()
end
function modifier_item_0608.prototype.GetAttributeBonus(self)
	return { bonus_strength = self.grantStr, bonus_agility = self.grantAgi, bonus_intelligence = self.grantInt }
end
function modifier_item_0608.prototype.IsHidden(self)
	return false
end
function modifier_item_0608.prototype.IsDebuff(self)
	return false
end
function modifier_item_0608.prototype.IsPurgable(self)
	return false
end
function modifier_item_0608.prototype.GetTexture(self)
	return "item_seer_stone"
end
modifier_item_0608 = __TS__DecorateLegacy({ registerModifier(nil) }, modifier_item_0608)
____exports.modifier_item_0608 = modifier_item_0608
return ____exports