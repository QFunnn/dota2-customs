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
local THINK_INTERVAL = 0.3
____exports.item_0562 = __TS__Class()
local item_0562 = ____exports.item_0562
item_0562.name = "item_0562"
__TS__ClassExtends(item_0562, BaseItem_CS)
function item_0562.prototype.GetIntrinsicModifierName(self)
	return ____exports.modifier_item_0562.name
end
item_0562 = __TS__DecorateLegacy({ registerAbility(nil) }, item_0562)
____exports.item_0562 = item_0562
--- 自身被动「掠影」：移速超阈值后，按超过阈值的移速档位换算闪避率。
____exports.modifier_item_0562 = __TS__Class()
local modifier_item_0562 = ____exports.modifier_item_0562
modifier_item_0562.name = "modifier_item_0562"
__TS__ClassExtends(modifier_item_0562, BaseModifier_CS)
function modifier_item_0562.prototype.OnCreated(self)
	if not IsServer() then
		return
	end
	self:StartIntervalThink(THINK_INTERVAL)
end
function modifier_item_0562.prototype.OnIntervalThink(self)
	if not IsServer() then
		return
	end
	self:RefreshAttributes()
end
function modifier_item_0562.prototype.IsHidden(self)
	return true
end
function modifier_item_0562.prototype.IsPurgable(self)
	return false
end
function modifier_item_0562.prototype.GetMutexKey(self)
	return "item_0562_mutex"
end
function modifier_item_0562.prototype.GetMutexPriority(self)
	local ability = self:GetAbility()
	return ability and ability:GetAbilityName() == "item_0562" and 200 or 100
end
function modifier_item_0562.prototype.GetAttributeBonus(self)
	local parent = self:GetParent()
	local ability = self:GetAbility()
	if not ability or not IsValidAlive(nil, parent) then
		return {}
	end
	local moveSpeed = MyGameAttribute:GetAttribute(parent, "total_movespeed") or 0
	local threshold = math.max(0, ability:GetSpecialValueFor("ability_movespeed_threshold"))
	if moveSpeed <= threshold then
		return {}
	end
	local rolledPerStep = ability:GetSpecialValueFor("ability_value_c_movespeed_per_step")
	local ____math_max_1 = math.max
	local ____temp_0
	if rolledPerStep > 0 then
		____temp_0 = rolledPerStep
	else
		____temp_0 = ability:GetSpecialValueFor("ability_c_movespeed_per_step")
	end
	local perStep = ____math_max_1(1, ____temp_0)
	local pctPerStep = math.max(0, ability:GetSpecialValueFor("ability_evasion_pct_per_step"))
	local rolledCap = ability:GetSpecialValueFor("ability_value_max_evasion_pct")
	local ____math_max_3 = math.max
	local ____temp_2
	if rolledCap > 0 then
		____temp_2 = rolledCap
	else
		____temp_2 = ability:GetSpecialValueFor("ability_max_evasion_pct")
	end
	local cap = ____math_max_3(0, ____temp_2)
	local rawEvasion = math.floor((moveSpeed - threshold) / perStep) * pctPerStep
	local ____temp_4
	if cap > 0 then
		____temp_4 = math.min(cap, rawEvasion)
	else
		____temp_4 = rawEvasion
	end
	local evasion = ____temp_4
	return { evasion_pct = evasion }
end
modifier_item_0562 = __TS__DecorateLegacy({ registerModifier(nil) }, modifier_item_0562)
____exports.modifier_item_0562 = modifier_item_0562
return ____exports