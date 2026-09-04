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
____exports.item_0360 = __TS__Class()
local item_0360 = ____exports.item_0360
item_0360.name = "item_0360"
__TS__ClassExtends(item_0360, BaseItem_CS)
function item_0360.prototype.GetIntrinsicModifierName(self)
	return ____exports.modifier_item_0360_hunt.name
end
item_0360 = __TS__DecorateLegacy({ registerAbility(nil) }, item_0360)
____exports.item_0360 = item_0360
____exports.modifier_item_0360_hunt = __TS__Class()
local modifier_item_0360_hunt = ____exports.modifier_item_0360_hunt
modifier_item_0360_hunt.name = "modifier_item_0360_hunt"
__TS__ClassExtends(modifier_item_0360_hunt, BaseModifier_CS)
function modifier_item_0360_hunt.prototype.____constructor(self, ...)
	BaseModifier_CS.prototype.____constructor(self, ...)
	self.cachedBonusAgility = -1
end
function modifier_item_0360_hunt.GetLocalizationCN(self)
	return { name = "追猎", description = "移动速度超过阈值时获得敏捷。" }
end
function modifier_item_0360_hunt.prototype.OnCreated(self)
	if not IsServer() then
		return
	end
	self:RecalculateBonusAgility(true)
	self:StartIntervalThink(____exports.modifier_item_0360_hunt.RECALCULATE_INTERVAL)
end
function modifier_item_0360_hunt.prototype.OnRefresh(self)
	if not IsServer() then
		return
	end
	self:RecalculateBonusAgility(true)
end
function modifier_item_0360_hunt.prototype.OnIntervalThink(self)
	if not IsServer() then
		return
	end
	self:RecalculateBonusAgility(false)
end
function modifier_item_0360_hunt.prototype.OnDestroy(self)
	if not IsServer() then
		return
	end
	self:StartIntervalThink(-1)
end
function modifier_item_0360_hunt.prototype.GetAttributeBonus(self)
	return { bonus_agility = math.max(0, self.cachedBonusAgility) }
end
function modifier_item_0360_hunt.prototype.IsHidden(self)
	return self.cachedBonusAgility <= 0
end
function modifier_item_0360_hunt.prototype.IsPurgable(self)
	return false
end
function modifier_item_0360_hunt.prototype.GetTexture(self)
	return "item_icon_m100_04"
end
function modifier_item_0360_hunt.prototype.RecalculateBonusAgility(self, forceRefresh)
	local parent = self:GetParent()
	local ability = self:GetAbility()
	if not ability or not IsValidAlive(nil, parent) then
		return
	end
	local ability_movespeed_threshold = math.max(0, ability:GetSpecialValueFor("ability_value_c_movespeed_threshold"))
	local ability_movespeed_per_attack_damage =
		math.max(1, ability:GetSpecialValueFor("ability_value_c_movespeed_per_attack_damage"))
	local ability_bonus_attack_damage_per_step =
		math.max(0, ability:GetSpecialValueFor("ability_bonus_attack_damage_per_step"))
	local totalMovespeed = MyGameAttribute:GetAttribute(parent, "total_movespeed") or parent:GetIdealSpeed()
	local extraMovespeed = math.max(0, totalMovespeed - ability_movespeed_threshold)
	local stepCount = math.floor(extraMovespeed / ability_movespeed_per_attack_damage)
	local bonusAgility = stepCount * ability_bonus_attack_damage_per_step
	if not forceRefresh and bonusAgility == self.cachedBonusAgility then
		return
	end
	self.cachedBonusAgility = bonusAgility
	self:SetStackCount(bonusAgility)
	self:RefreshAttributes()
end
modifier_item_0360_hunt.RECALCULATE_INTERVAL = 0.2
modifier_item_0360_hunt = __TS__DecorateLegacy({ registerModifier(nil) }, modifier_item_0360_hunt)
____exports.modifier_item_0360_hunt = modifier_item_0360_hunt
return ____exports