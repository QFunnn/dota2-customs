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
____exports.item_0461 = __TS__Class()
local item_0461 = ____exports.item_0461
item_0461.name = "item_0461"
__TS__ClassExtends(item_0461, BaseItem_CS)
function item_0461.prototype.GetIntrinsicModifierName(self)
	return ____exports.modifier_item_0461.name
end
item_0461 = __TS__DecorateLegacy({ registerAbility(nil) }, item_0461)
____exports.item_0461 = item_0461
____exports.modifier_item_0461 = __TS__Class()
local modifier_item_0461 = ____exports.modifier_item_0461
modifier_item_0461.name = "modifier_item_0461"
__TS__ClassExtends(modifier_item_0461, BaseModifier_CS)
function modifier_item_0461.prototype.____constructor(self, ...)
	BaseModifier_CS.prototype.____constructor(self, ...)
	self.cached_total_movespeed = -1
	self.cached_bonus_damage_pct = 0
end
function modifier_item_0461.GetLocalizationCN(self)
	return { name = "无惧", description = "伤害加成提升。" }
end
function modifier_item_0461.prototype.OnCreated(self)
	if not IsServer() then
		return
	end
	self:RecalculateByMoveSpeed(true)
	self:StartIntervalThink(0.5)
end
function modifier_item_0461.prototype.OnRefresh(self)
	if not IsServer() then
		return
	end
	self:RecalculateByMoveSpeed(true)
end
function modifier_item_0461.prototype.OnIntervalThink(self)
	if not IsServer() then
		return
	end
	self:RecalculateByMoveSpeed(false)
end
function modifier_item_0461.prototype.OnDestroy(self)
	if not IsServer() then
		return
	end
	self:StartIntervalThink(-1)
end
function modifier_item_0461.prototype.GetAttributeBonus(self)
	return { outgoing_damage_pct = self.cached_bonus_damage_pct }
end
function modifier_item_0461.prototype.IsPurgable(self)
	return false
end
function modifier_item_0461.prototype.RecalculateByMoveSpeed(self, forceRefresh)
	local parent = self:GetParent()
	local ability = self:GetAbility()
	if not IsValid(nil, parent) or not ability then
		return
	end
	local ability_movespeed_threshold = math.max(0, ability:GetSpecialValueFor("ability_value_movespeed_threshold"))
	local ability_movespeed_step = math.max(1, ability:GetSpecialValueFor("ability_movespeed_step"))
	local ability_bonus_pct_per_step = math.max(0, ability:GetSpecialValueFor("ability_bonus_pct_per_step"))
	local ability_bonus_pct_max = math.max(0, ability:GetSpecialValueFor("ability_value_bonus_pct_max"))
	local totalMoveSpeed = MyGameAttribute:GetAttribute(parent, "total_movespeed") or parent:GetIdealSpeed()
	local speedLoss = math.max(0, ability_movespeed_threshold - totalMoveSpeed)
	local bonusDamagePct =
		math.min(ability_bonus_pct_max, math.floor(speedLoss / ability_movespeed_step) * ability_bonus_pct_per_step)
	local totalSpeedChanged = math.abs(totalMoveSpeed - self.cached_total_movespeed) > 0.01
	local bonusChanged = math.abs(bonusDamagePct - self.cached_bonus_damage_pct) > 0.01
	if not forceRefresh and not totalSpeedChanged and not bonusChanged then
		return
	end
	self.cached_total_movespeed = totalMoveSpeed
	self.cached_bonus_damage_pct = bonusDamagePct
	self:SetStackCount(bonusDamagePct)
	self:RefreshAttributes()
end
modifier_item_0461 = __TS__DecorateLegacy({ registerModifier(nil) }, modifier_item_0461)
____exports.modifier_item_0461 = modifier_item_0461
return ____exports