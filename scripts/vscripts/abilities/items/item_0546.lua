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
____exports.item_0546 = __TS__Class()
local item_0546 = ____exports.item_0546
item_0546.name = "item_0546"
__TS__ClassExtends(item_0546, BaseItem_CS)
function item_0546.prototype.GetIntrinsicModifierName(self)
	return ____exports.modifier_item_0546.name
end
item_0546 = __TS__DecorateLegacy({ registerAbility(nil) }, item_0546)
____exports.item_0546 = item_0546
--- 自身被动「迅疾」：移速超阈值后，按超过阈值的移速档位换算物理暴击率。
____exports.modifier_item_0546 = __TS__Class()
local modifier_item_0546 = ____exports.modifier_item_0546
modifier_item_0546.name = "modifier_item_0546"
__TS__ClassExtends(modifier_item_0546, BaseModifier_CS)
function modifier_item_0546.prototype.OnCreated(self)
	if not IsServer() then
		return
	end
	self:StartIntervalThink(THINK_INTERVAL)
end
function modifier_item_0546.prototype.OnIntervalThink(self)
	if not IsServer() then
		return
	end
	self:RefreshAttributes()
end
function modifier_item_0546.prototype.IsHidden(self)
	return true
end
function modifier_item_0546.prototype.IsPurgable(self)
	return false
end
function modifier_item_0546.prototype.GetAttributeBonus(self)
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
	local perStep = math.max(1, ability:GetSpecialValueFor("ability_movespeed_per_step"))
	local pctPerStep = math.max(0, ability:GetSpecialValueFor("ability_physcrit_pct_per_step"))
	local physCrit = math.floor((moveSpeed - threshold) / perStep) * pctPerStep
	return { physical_crit_chance_pct = physCrit }
end
modifier_item_0546 = __TS__DecorateLegacy({ registerModifier(nil) }, modifier_item_0546)
____exports.modifier_item_0546 = modifier_item_0546
return ____exports