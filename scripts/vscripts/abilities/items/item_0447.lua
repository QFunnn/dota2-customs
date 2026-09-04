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
____exports.item_0447 = __TS__Class()
local item_0447 = ____exports.item_0447
item_0447.name = "item_0447"
__TS__ClassExtends(item_0447, BaseItem_CS)
function item_0447.prototype.GetIntrinsicModifierName(self)
	return ____exports.modifier_item_0447_assault_tracker.name
end
item_0447 = __TS__DecorateLegacy({ registerAbility(nil) }, item_0447)
____exports.item_0447 = item_0447
____exports.modifier_item_0447_assault_tracker = __TS__Class()
local modifier_item_0447_assault_tracker = ____exports.modifier_item_0447_assault_tracker
modifier_item_0447_assault_tracker.name = "modifier_item_0447_assault_tracker"
__TS__ClassExtends(modifier_item_0447_assault_tracker, BaseModifier_CS)
function modifier_item_0447_assault_tracker.prototype.DeclareEvents(self)
	return { BusinessEvents.ON_HEALTH_COST }
end
function modifier_item_0447_assault_tracker.prototype.IsHidden(self)
	return true
end
function modifier_item_0447_assault_tracker.prototype.IsPurgable(self)
	return false
end
function modifier_item_0447_assault_tracker.prototype.OnHealthCost_CS(self, event)
	if not IsServer() then
		return
	end
	local parent = self:GetParent()
	if event.unit ~= parent then
		return
	end
	if event.attacker ~= parent then
		return
	end
	local ability = self:GetAbility()
	if not ability then
		return
	end
	local actualCost = math.max(0, math.floor(event.actual_cost or 0))
	if actualCost <= 0 then
		return
	end
	local ability_duration = ability:GetSpecialValueFor("ability_duration")
	if ability_duration <= 0 then
		return
	end
	parent:AddNewModifier(parent, ability, ____exports.modifier_item_0447_assault.name, { duration = ability_duration })
end
modifier_item_0447_assault_tracker = __TS__DecorateLegacy({ registerModifier(nil) }, modifier_item_0447_assault_tracker)
____exports.modifier_item_0447_assault_tracker = modifier_item_0447_assault_tracker
____exports.modifier_item_0447_assault = __TS__Class()
local modifier_item_0447_assault = ____exports.modifier_item_0447_assault
modifier_item_0447_assault.name = "modifier_item_0447_assault"
__TS__ClassExtends(modifier_item_0447_assault, BaseModifier_CS)
function modifier_item_0447_assault.GetLocalizationCN(self)
	return { name = "强袭", description = "攻击速度和攻击力提高（可叠加）。" }
end
function modifier_item_0447_assault.prototype.OnCreated(self)
	if not IsServer() then
		return
	end
	self:AddOneStack()
end
function modifier_item_0447_assault.prototype.OnRefresh(self)
	if not IsServer() then
		return
	end
	self:AddOneStack()
end
function modifier_item_0447_assault.prototype.IsHidden(self)
	return false
end
function modifier_item_0447_assault.prototype.IsDebuff(self)
	return false
end
function modifier_item_0447_assault.prototype.IsPurgable(self)
	return true
end
function modifier_item_0447_assault.prototype.GetAttributeBonus(self)
	local ability = self:GetAbility()
	local ____ability_0
	if ability then
		____ability_0 = math.max(0, ability:GetSpecialValueFor("ability_attack_speed_pct_per_stack"))
	else
		____ability_0 = 0
	end
	local ability_attack_speed_pct_per_stack = ____ability_0
	local ____ability_1
	if ability then
		____ability_1 = math.max(0, ability:GetSpecialValueFor("ability_attack_damage_pct_per_stack"))
	else
		____ability_1 = 0
	end
	local ability_attack_damage_pct_per_stack = ____ability_1
	local stacks = math.max(0, self:GetStackCount())
	return {
		attack_speed_pct = stacks * ability_attack_speed_pct_per_stack,
		all_attack_damage_percent = stacks * ability_attack_damage_pct_per_stack,
	}
end
function modifier_item_0447_assault.prototype.AddOneStack(self)
	local ability = self:GetAbility()
	local ____ability_2
	if ability then
		____ability_2 = math.max(0, ability:GetSpecialValueFor("ability_max_stacks"))
	else
		____ability_2 = 0
	end
	local ability_max_stacks = ____ability_2
	if ability_max_stacks <= 0 then
		return
	end
	local currentStacks = math.max(0, self:GetStackCount())
	local nextStacks = math.min(ability_max_stacks, currentStacks + 1)
	self:SetStackCount(nextStacks)
	self:RefreshAttributes()
end
modifier_item_0447_assault = __TS__DecorateLegacy({ registerModifier(nil) }, modifier_item_0447_assault)
____exports.modifier_item_0447_assault = modifier_item_0447_assault
return ____exports