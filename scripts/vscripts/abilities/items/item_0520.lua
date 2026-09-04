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
____exports.item_0520 = __TS__Class()
local item_0520 = ____exports.item_0520
item_0520.name = "item_0520"
__TS__ClassExtends(item_0520, BaseItem_CS)
function item_0520.prototype.GetIntrinsicModifierName(self)
	return ____exports.modifier_item_0520_orbit.name
end
item_0520 = __TS__DecorateLegacy({ registerAbility(nil) }, item_0520)
____exports.item_0520 = item_0520
--- 自身被动「噬魂疾锋」：攻速超阈值后，按超过阈值的攻速档位换算全域暴击率，并受上限约束。
____exports.modifier_item_0520_orbit = __TS__Class()
local modifier_item_0520_orbit = ____exports.modifier_item_0520_orbit
modifier_item_0520_orbit.name = "modifier_item_0520_orbit"
__TS__ClassExtends(modifier_item_0520_orbit, BaseModifier_CS)
function modifier_item_0520_orbit.prototype.OnCreated(self)
	if not IsServer() then
		return
	end
	self:StartIntervalThink(THINK_INTERVAL)
end
function modifier_item_0520_orbit.prototype.OnIntervalThink(self)
	if not IsServer() then
		return
	end
	self:RefreshAttributes()
end
function modifier_item_0520_orbit.prototype.IsHidden(self)
	return true
end
function modifier_item_0520_orbit.prototype.IsPurgable(self)
	return false
end
function modifier_item_0520_orbit.prototype.GetAttributeBonus(self)
	local parent = self:GetParent()
	local ability = self:GetAbility()
	if not ability or not IsValidAlive(nil, parent) then
		return {}
	end
	local attackSpeed = MyGameAttribute:GetAttribute(parent, "total_attack_speed") or 0
	local ability_attackspeed_threshold =
		math.max(0, ability:GetSpecialValueFor("ability_value_c_attackspeed_threshold"))
	if attackSpeed <= ability_attackspeed_threshold then
		return {}
	end
	local ability_attackspeed_per_step = math.max(1, ability:GetSpecialValueFor("ability_value_c_attackspeed_per_step"))
	local ability_omnicrit_pct_per_step = math.max(0, ability:GetSpecialValueFor("ability_omnicrit_pct_per_step"))
	local ability_omnicrit_pct_max = math.max(0, ability:GetSpecialValueFor("ability_omnicrit_pct_max"))
	local ability_omnicrit_pct = math.floor(
		(attackSpeed - ability_attackspeed_threshold) / ability_attackspeed_per_step
	) * ability_omnicrit_pct_per_step
	return { physical_crit_chance_pct = math.min(ability_omnicrit_pct, ability_omnicrit_pct_max) }
end
modifier_item_0520_orbit = __TS__DecorateLegacy({ registerModifier(nil) }, modifier_item_0520_orbit)
____exports.modifier_item_0520_orbit = modifier_item_0520_orbit
return ____exports