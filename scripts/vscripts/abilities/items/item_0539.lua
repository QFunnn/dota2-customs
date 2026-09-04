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
local RECALC_INTERVAL = 0.5
local MAX_CHARGE_REDUCTION_PCT = 99
____exports.item_0539 = __TS__Class()
local item_0539 = ____exports.item_0539
item_0539.name = "item_0539"
__TS__ClassExtends(item_0539, BaseItem_CS)
function item_0539.prototype.GetIntrinsicModifierName(self)
	return ____exports.modifier_item_0539_eternal_cycle.name
end
item_0539 = __TS__DecorateLegacy({ registerAbility(nil) }, item_0539)
____exports.item_0539 = item_0539
--- 固有被动「永续回环」：总冷却缩减÷2 × ability_value_charge_reduce_per_2cdr → charge_restore_time_pct（正数缩短充能恢复时间，受词条上限约束）。
____exports.modifier_item_0539_eternal_cycle = __TS__Class()
local modifier_item_0539_eternal_cycle = ____exports.modifier_item_0539_eternal_cycle
modifier_item_0539_eternal_cycle.name = "modifier_item_0539_eternal_cycle"
__TS__ClassExtends(modifier_item_0539_eternal_cycle, BaseModifier_CS)
function modifier_item_0539_eternal_cycle.prototype.____constructor(self, ...)
	BaseModifier_CS.prototype.____constructor(self, ...)
	self.cachedReduction = -1
end
function modifier_item_0539_eternal_cycle.prototype.OnCreated(self)
	if not IsServer() then
		return
	end
	self:Recalc(true)
	self:StartIntervalThink(RECALC_INTERVAL)
end
function modifier_item_0539_eternal_cycle.prototype.OnDestroy(self)
	if not IsServer() then
		return
	end
	self:StartIntervalThink(-1)
end
function modifier_item_0539_eternal_cycle.prototype.OnIntervalThink(self)
	if not IsServer() then
		return
	end
	self:Recalc(false)
end
function modifier_item_0539_eternal_cycle.prototype.IsHidden(self)
	return true
end
function modifier_item_0539_eternal_cycle.prototype.IsPurgable(self)
	return false
end
function modifier_item_0539_eternal_cycle.prototype.GetMutexKey(self)
	return "item_0539_mutex"
end
function modifier_item_0539_eternal_cycle.prototype.GetMutexPriority(self)
	local ability = self:GetAbility()
	return ability and ability:GetAbilityName() == "item_0539" and 200 or 100
end
function modifier_item_0539_eternal_cycle.prototype.GetAttributeBonus(self)
	local ____temp_0
	if self.cachedReduction > 0 then
		____temp_0 = self.cachedReduction
	else
		____temp_0 = 0
	end
	return { charge_restore_time_pct = ____temp_0 }
end
function modifier_item_0539_eternal_cycle.prototype.Recalc(self, force)
	local parent = self:GetParent()
	local ability = self:GetAbility()
	if not IsValid(nil, parent) or not ability then
		return
	end
	local cdrPct = math.max(0, MyGameAttribute:GetAttribute(parent, "cooldown_reduction_pct") or 0)
	local rolledRatio = ability:GetSpecialValueFor("ability_value_charge_reduce_per_2cdr")
	local ____math_max_2 = math.max
	local ____temp_1
	if rolledRatio > 0 then
		____temp_1 = rolledRatio
	else
		____temp_1 = ability:GetSpecialValueFor("ability_charge_reduce_per_2cdr")
	end
	local ratio = ____math_max_2(0, ____temp_1)
	local capRolled = ability:GetSpecialValueFor("ability_value_max_charge_reduce_pct")
	local ____temp_3
	if capRolled > 0 then
		____temp_3 = capRolled
	else
		____temp_3 = ability:GetSpecialValueFor("ability_max_charge_reduce_pct")
	end
	local capRaw = ____temp_3
	local ____temp_4
	if capRaw > 0 then
		____temp_4 = math.min(MAX_CHARGE_REDUCTION_PCT, capRaw)
	else
		____temp_4 = MAX_CHARGE_REDUCTION_PCT
	end
	local designCap = ____temp_4
	local value = math.min(designCap, cdrPct / 2 * ratio)
	if not force and math.abs(value - self.cachedReduction) < 0.01 then
		return
	end
	self.cachedReduction = value
	local ____ = not force and self:RefreshAttributes()
end
modifier_item_0539_eternal_cycle = __TS__DecorateLegacy({ registerModifier(nil) }, modifier_item_0539_eternal_cycle)
____exports.modifier_item_0539_eternal_cycle = modifier_item_0539_eternal_cycle
return ____exports