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
local ITEM_0205_MOVE_SPEED_THRESHOLD = 250
local ITEM_0205_MOVE_SPEED_PER_AGILITY = 5
local ITEM_0205_RECALCULATE_INTERVAL = 0.5
____exports.item_0205 = __TS__Class()
local item_0205 = ____exports.item_0205
item_0205.name = "item_0205"
__TS__ClassExtends(item_0205, BaseItem_CS)
function item_0205.prototype.GetIntrinsicModifierName(self)
	return "modifier_item_0205"
end
item_0205 = __TS__DecorateLegacy({ registerAbility(nil) }, item_0205)
____exports.item_0205 = item_0205
____exports.modifier_item_0205 = __TS__Class()
local modifier_item_0205 = ____exports.modifier_item_0205
modifier_item_0205.name = "modifier_item_0205"
__TS__ClassExtends(modifier_item_0205, BaseModifier_CS)
function modifier_item_0205.prototype.____constructor(self, ...)
	BaseModifier_CS.prototype.____constructor(self, ...)
	self.cachedTotalMoveSpeed = -1
	self.cachedBonusAgility = 0
end
function modifier_item_0205.prototype.OnCreated(self)
	if not IsServer() then
		return
	end
	self:recalculateByMoveSpeed(true)
	self:StartIntervalThink(ITEM_0205_RECALCULATE_INTERVAL)
end
function modifier_item_0205.prototype.OnIntervalThink(self)
	if not IsServer() then
		return
	end
	self:recalculateByMoveSpeed(false)
end
function modifier_item_0205.prototype.GetAttributeBonus(self)
	return { bonus_agility = self.cachedBonusAgility }
end
function modifier_item_0205.prototype.IsHidden(self)
	return true
end
function modifier_item_0205.prototype.recalculateByMoveSpeed(self, forceRefresh)
	local parent = self:GetParent()
	if not IsValid(nil, parent) then
		return
	end
	local totalMoveSpeed = MyGameAttribute:GetAttribute(parent, "total_movespeed") or 0
	local extraMoveSpeed = math.max(0, totalMoveSpeed - ITEM_0205_MOVE_SPEED_THRESHOLD)
	local bonusAgility = math.floor(extraMoveSpeed / ITEM_0205_MOVE_SPEED_PER_AGILITY)
	local totalSpeedChanged = math.abs(totalMoveSpeed - self.cachedTotalMoveSpeed) > 0.01
	local bonusChanged = math.abs(bonusAgility - self.cachedBonusAgility) > 0.01
	if not forceRefresh and not totalSpeedChanged and not bonusChanged then
		return
	end
	self.cachedTotalMoveSpeed = totalMoveSpeed
	self.cachedBonusAgility = bonusAgility
	self:RefreshAttributes()
end
modifier_item_0205 = __TS__DecorateLegacy({ registerModifier(nil) }, modifier_item_0205)
____exports.modifier_item_0205 = modifier_item_0205
return ____exports