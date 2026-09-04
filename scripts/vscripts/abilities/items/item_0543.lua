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
____exports.item_0543 = __TS__Class()
local item_0543 = ____exports.item_0543
item_0543.name = "item_0543"
__TS__ClassExtends(item_0543, BaseItem_CS)
function item_0543.prototype.GetIntrinsicModifierName(self)
	return ____exports.modifier_item_0543.name
end
item_0543 = __TS__DecorateLegacy({ registerAbility(nil) }, item_0543)
____exports.item_0543 = item_0543
____exports.modifier_item_0543 = __TS__Class()
local modifier_item_0543 = ____exports.modifier_item_0543
modifier_item_0543.name = "modifier_item_0543"
__TS__ClassExtends(modifier_item_0543, BaseModifier_CS)
function modifier_item_0543.prototype.____constructor(self, ...)
	BaseModifier_CS.prototype.____constructor(self, ...)
	self.cachedLifesteal = -1
end
function modifier_item_0543.prototype.OnCreated(self)
	if not IsServer() then
		return
	end
	self:Recalc(true)
	self:StartIntervalThink(RECALC_INTERVAL)
end
function modifier_item_0543.prototype.OnDestroy(self)
	if not IsServer() then
		return
	end
	self:StartIntervalThink(-1)
end
function modifier_item_0543.prototype.OnIntervalThink(self)
	if not IsServer() then
		return
	end
	self:Recalc(false)
end
function modifier_item_0543.prototype.IsHidden(self)
	return true
end
function modifier_item_0543.prototype.IsPurgable(self)
	return false
end
function modifier_item_0543.prototype.GetMutexKey(self)
	return "item_0543_mutex"
end
function modifier_item_0543.prototype.GetMutexPriority(self)
	local ability = self:GetAbility()
	return ability and ability:GetAbilityName() == "item_0543" and 200 or 100
end
function modifier_item_0543.prototype.GetAttributeBonus(self)
	local ability = self:GetAbility()
	local ____temp_0
	if ability and IsValid(nil, ability) then
		____temp_0 = ability:GetSpecialValueFor("ability_value_c_lifesteal_reduce_pct")
	else
		____temp_0 = 0
	end
	local rolledReduce = ____temp_0
	local ____temp_3
	if ability and IsValid(nil, ability) then
		local ____math_max_2 = math.max
		local ____temp_1
		if rolledReduce > 0 then
			____temp_1 = rolledReduce
		else
			____temp_1 = ability:GetSpecialValueFor("ability_c_lifesteal_reduce_pct")
		end
		____temp_3 = ____math_max_2(0, ____temp_1)
	else
		____temp_3 = 0
	end
	local lifestealReduce = ____temp_3
	local ____temp_4
	if self.cachedLifesteal > 0 then
		____temp_4 = self.cachedLifesteal
	else
		____temp_4 = 0
	end
	return { magical_lifesteal_pct = ____temp_4, lifesteal_amp_pct = -lifestealReduce }
end
function modifier_item_0543.prototype.Recalc(self, force)
	local parent = self:GetParent()
	local ability = self:GetAbility()
	if not IsValid(nil, parent) or not ability then
		return
	end
	local mana = math.max(0, MyGameAttribute:GetAttribute(parent, "total_mana") or 0)
	local ability_mana_step = math.max(1, ability:GetSpecialValueFor("ability_mana_step"))
	local rolledPerStep = ability:GetSpecialValueFor("ability_value_magical_lifesteal_per_mana_step")
	local ____math_max_6 = math.max
	local ____temp_5
	if rolledPerStep > 0 then
		____temp_5 = rolledPerStep
	else
		____temp_5 = ability:GetSpecialValueFor("ability_magical_lifesteal_per_mana_step")
	end
	local ability_value_magical_lifesteal_per_mana_step = ____math_max_6(0, ____temp_5)
	local rolledCap = ability:GetSpecialValueFor("ability_value_magical_lifesteal_cap_pct")
	local ____math_max_8 = math.max
	local ____temp_7
	if rolledCap > 0 then
		____temp_7 = rolledCap
	else
		____temp_7 = ability:GetSpecialValueFor("ability_magical_lifesteal_cap_pct")
	end
	local ability_value_magical_lifesteal_cap_pct = ____math_max_8(0, ____temp_7)
	local value = math.min(
		ability_value_magical_lifesteal_cap_pct,
		mana / ability_mana_step * ability_value_magical_lifesteal_per_mana_step
	)
	if not force and math.abs(value - self.cachedLifesteal) < 0.01 then
		return
	end
	self.cachedLifesteal = value
	local ____ = not force and self:RefreshAttributes()
end
modifier_item_0543 = __TS__DecorateLegacy({ registerModifier(nil) }, modifier_item_0543)
____exports.modifier_item_0543 = modifier_item_0543
return ____exports