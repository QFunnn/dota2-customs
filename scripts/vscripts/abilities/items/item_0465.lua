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
local THINK_INTERVAL = 0.2
____exports.item_0465 = __TS__Class()
local item_0465 = ____exports.item_0465
item_0465.name = "item_0465"
__TS__ClassExtends(item_0465, BaseItem_CS)
function item_0465.prototype.GetIntrinsicModifierName(self)
	return ____exports.modifier_item_0465.name
end
item_0465 = __TS__DecorateLegacy({ registerAbility(nil) }, item_0465)
____exports.item_0465 = item_0465
____exports.modifier_item_0465 = __TS__Class()
local modifier_item_0465 = ____exports.modifier_item_0465
modifier_item_0465.name = "modifier_item_0465"
__TS__ClassExtends(modifier_item_0465, BaseModifier_CS)
function modifier_item_0465.GetLocalizationCN(self)
	return { name = "裂血", description = "生命越低，伤害抵抗越高。" }
end
function modifier_item_0465.prototype.OnCreated(self)
	if not IsServer() then
		return
	end
	self:StartIntervalThink(THINK_INTERVAL)
end
function modifier_item_0465.prototype.OnDestroy(self)
	if not IsServer() then
		return
	end
	self:StartIntervalThink(-1)
end
function modifier_item_0465.prototype.OnIntervalThink(self)
	if not IsServer() then
		return
	end
	if not IsValidAlive(nil, self:GetParent()) then
		return
	end
	self:RefreshAttributes()
end
function modifier_item_0465.prototype.GetAttributeBonus(self)
	local parent = self:GetParent()
	local ability = self:GetAbility()
	if not ability or not IsValidAlive(nil, parent) then
		return {}
	end
	local maxHp = math.max(1, parent:GetMaxHealth())
	local curHp = math.max(0, parent:GetHealth())
	local lossPct = math.max(0, (maxHp - curHp) / maxHp * 100)
	local ability_health_loss_step = math.max(1, ability:GetSpecialValueFor("ability_health_loss_step"))
	local ability_value_reduction_per_step = math.max(0, ability:GetSpecialValueFor("ability_value_reduction_per_step"))
	local ability_step_reduction = math.floor(lossPct / ability_health_loss_step) * ability_value_reduction_per_step
	local ability_value_max_reduction = math.max(0, ability:GetSpecialValueFor("ability_value_max_reduction"))
	return { damage_resistance_pct = math.min(ability_value_max_reduction, ability_step_reduction) }
end
function modifier_item_0465.prototype.IsHidden(self)
	return false
end
function modifier_item_0465.prototype.IsDebuff(self)
	return false
end
function modifier_item_0465.prototype.IsPurgable(self)
	return false
end
function modifier_item_0465.prototype.GetTexture(self)
	return "icon_eq400_20"
end
modifier_item_0465 = __TS__DecorateLegacy({ registerModifier(nil) }, modifier_item_0465)
____exports.modifier_item_0465 = modifier_item_0465
return ____exports