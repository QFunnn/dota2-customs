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
____exports.item_0211 = __TS__Class()
local item_0211 = ____exports.item_0211
item_0211.name = "item_0211"
__TS__ClassExtends(item_0211, BaseItem_CS)
function item_0211.prototype.GetIntrinsicModifierName(self)
	return ____exports.modifier_item_0211_inertia.name
end
item_0211 = __TS__DecorateLegacy({ registerAbility(nil) }, item_0211)
____exports.item_0211 = item_0211
____exports.modifier_item_0211_inertia = __TS__Class()
local modifier_item_0211_inertia = ____exports.modifier_item_0211_inertia
modifier_item_0211_inertia.name = "modifier_item_0211_inertia"
__TS__ClassExtends(modifier_item_0211_inertia, BaseModifier_CS)
function modifier_item_0211_inertia.prototype.____constructor(self, ...)
	BaseModifier_CS.prototype.____constructor(self, ...)
	self.cachedBonusAttackSpeed = -1
end
function modifier_item_0211_inertia.GetLocalizationCN(self)
	return { name = "惯性势能", description = "移动速度超过阈值时提升攻击速度。" }
end
function modifier_item_0211_inertia.prototype.OnCreated(self)
	if not IsServer() then
		return
	end
	self:RecalculateBonusAttackSpeed(true)
	self:StartIntervalThink(____exports.modifier_item_0211_inertia.RECALCULATE_INTERVAL)
end
function modifier_item_0211_inertia.prototype.OnRefresh(self)
	if not IsServer() then
		return
	end
	self:RecalculateBonusAttackSpeed(true)
end
function modifier_item_0211_inertia.prototype.OnIntervalThink(self)
	if not IsServer() then
		return
	end
	self:RecalculateBonusAttackSpeed(false)
end
function modifier_item_0211_inertia.prototype.OnDestroy(self)
	if not IsServer() then
		return
	end
	self:StartIntervalThink(-1)
end
function modifier_item_0211_inertia.prototype.GetAttributeBonus(self)
	return { attack_speed = math.max(0, self.cachedBonusAttackSpeed) }
end
function modifier_item_0211_inertia.prototype.IsHidden(self)
	return self.cachedBonusAttackSpeed <= 0
end
function modifier_item_0211_inertia.prototype.IsPurgable(self)
	return false
end
function modifier_item_0211_inertia.prototype.GetTexture(self)
	return "item_invis_sword"
end
function modifier_item_0211_inertia.prototype.RecalculateBonusAttackSpeed(self, forceRefresh)
	local parent = self:GetParent()
	local ability = self:GetAbility()
	if not ability or not IsValidAlive(nil, parent) then
		return
	end
	local ability_movespeed_threshold = math.max(0, ability:GetSpecialValueFor("ability_movespeed_threshold"))
	local ability_movespeed_per_attack_speed =
		math.max(1, ability:GetSpecialValueFor("ability_movespeed_per_attack_speed"))
	local ability_bonus_attack_speed_per_step =
		math.max(0, ability:GetSpecialValueFor("ability_bonus_attack_speed_per_step"))
	local totalMovespeed = MyGameAttribute:GetAttribute(parent, "total_movespeed") or parent:GetIdealSpeed()
	local extraMovespeed = math.max(0, totalMovespeed - ability_movespeed_threshold)
	local stepCount = math.floor(extraMovespeed / ability_movespeed_per_attack_speed)
	local bonusAttackSpeed = stepCount * ability_bonus_attack_speed_per_step
	if not forceRefresh and bonusAttackSpeed == self.cachedBonusAttackSpeed then
		return
	end
	self.cachedBonusAttackSpeed = bonusAttackSpeed
	self:SetStackCount(bonusAttackSpeed)
	self:RefreshAttributes()
end
modifier_item_0211_inertia.RECALCULATE_INTERVAL = 0.2
modifier_item_0211_inertia = __TS__DecorateLegacy({ registerModifier(nil) }, modifier_item_0211_inertia)
____exports.modifier_item_0211_inertia = modifier_item_0211_inertia
return ____exports