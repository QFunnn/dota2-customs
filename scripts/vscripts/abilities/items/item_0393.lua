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
____exports.item_0393 = __TS__Class()
local item_0393 = ____exports.item_0393
item_0393.name = "item_0393"
__TS__ClassExtends(item_0393, BaseItem_CS)
function item_0393.prototype.GetIntrinsicModifierName(self)
	return ____exports.modifier_item_0393_stealth_tracker.name
end
item_0393 = __TS__DecorateLegacy({ registerAbility(nil) }, item_0393)
____exports.item_0393 = item_0393
____exports.modifier_item_0393_stealth_tracker = __TS__Class()
local modifier_item_0393_stealth_tracker = ____exports.modifier_item_0393_stealth_tracker
modifier_item_0393_stealth_tracker.name = "modifier_item_0393_stealth_tracker"
__TS__ClassExtends(modifier_item_0393_stealth_tracker, BaseModifier_CS)
function modifier_item_0393_stealth_tracker.prototype.DeclareEvents(self)
	return { BusinessEvents.ON_ATTACK_LANDED }
end
function modifier_item_0393_stealth_tracker.prototype.OnAttackLanded_CS(self, event)
	if not IsServer() then
		return
	end
	local parent = self:GetParent()
	local ability = self:GetAbility()
	if not ability or event.attacker ~= parent then
		return
	end
	if not event.is_crit or event.is_sub_attack or not event.is_base_attack then
		return
	end
	local target = event.target
	if not IsValidAlive(nil, parent) or not IsValidAlive(nil, target) or target:IsBuilding() then
		return
	end
	if target:GetTeamNumber() == parent:GetTeamNumber() then
		return
	end
	parent:AddNewModifier(parent, ability, ____exports.modifier_item_0393_stealth_haste.name, {})
end
function modifier_item_0393_stealth_tracker.prototype.IsHidden(self)
	return true
end
function modifier_item_0393_stealth_tracker.prototype.IsPurgable(self)
	return false
end
modifier_item_0393_stealth_tracker = __TS__DecorateLegacy({ registerModifier(nil) }, modifier_item_0393_stealth_tracker)
____exports.modifier_item_0393_stealth_tracker = modifier_item_0393_stealth_tracker
____exports.modifier_item_0393_stealth_haste = __TS__Class()
local modifier_item_0393_stealth_haste = ____exports.modifier_item_0393_stealth_haste
modifier_item_0393_stealth_haste.name = "modifier_item_0393_stealth_haste"
__TS__ClassExtends(modifier_item_0393_stealth_haste, BaseModifier_CS)
function modifier_item_0393_stealth_haste.GetLocalizationCN(self)
	return { name = "隐匿", description = "攻击速度提升，可叠加。" }
end
function modifier_item_0393_stealth_haste.prototype.OnCreated(self)
	if not IsServer() then
		return
	end
	self:AddOneStack()
	self:StartDecay()
end
function modifier_item_0393_stealth_haste.prototype.OnRefresh(self)
	if not IsServer() then
		return
	end
	self:AddOneStack()
end
function modifier_item_0393_stealth_haste.prototype.OnIntervalThink(self)
	if not IsServer() then
		return
	end
	local nextStackCount = self:GetStackCount() - 1
	if nextStackCount <= 0 then
		self:Destroy()
		return
	end
	self:SetStackCount(nextStackCount)
	self:RefreshAttributes()
end
function modifier_item_0393_stealth_haste.prototype.OnDestroy(self)
	if not IsServer() then
		return
	end
	self:StartIntervalThink(-1)
end
function modifier_item_0393_stealth_haste.prototype.GetAttributeBonus(self)
	local ability = self:GetAbility()
	if not ability then
		return {}
	end
	local rolledPerStack = ability:GetSpecialValueFor("ability_value_attack_speed_pct_per_stack")
	local ____math_max_1 = math.max
	local ____temp_0
	if rolledPerStack > 0 then
		____temp_0 = rolledPerStack
	else
		____temp_0 = ability:GetSpecialValueFor("ability_attack_speed_pct_per_stack")
	end
	local ability_attack_speed_pct_per_stack = ____math_max_1(0, ____temp_0)
	return { attack_speed = self:GetStackCount() * ability_attack_speed_pct_per_stack }
end
function modifier_item_0393_stealth_haste.prototype.IsHidden(self)
	return false
end
function modifier_item_0393_stealth_haste.prototype.IsDebuff(self)
	return false
end
function modifier_item_0393_stealth_haste.prototype.IsPurgable(self)
	return false
end
function modifier_item_0393_stealth_haste.prototype.GetTexture(self)
	return "item_butterfly"
end
function modifier_item_0393_stealth_haste.prototype.AddOneStack(self)
	local ability = self:GetAbility()
	if not ability then
		return
	end
	local rolledMaxStacks = ability:GetSpecialValueFor("ability_value_max_stacks")
	local ____math_max_4 = math.max
	local ____math_floor_3 = math.floor
	local ____temp_2
	if rolledMaxStacks > 0 then
		____temp_2 = rolledMaxStacks
	else
		____temp_2 = ability:GetSpecialValueFor("ability_max_stacks")
	end
	local ability_max_stacks = ____math_max_4(1, ____math_floor_3(____temp_2))
	local nextStackCount = math.min(self:GetStackCount() + 1, ability_max_stacks)
	self:SetStackCount(nextStackCount)
	self:RefreshAttributes()
end
function modifier_item_0393_stealth_haste.prototype.StartDecay(self)
	local ability = self:GetAbility()
	if not ability then
		return
	end
	local ability_stack_decay_interval = math.max(0.1, ability:GetSpecialValueFor("ability_stack_decay_interval"))
	self:StartIntervalThink(ability_stack_decay_interval)
end
modifier_item_0393_stealth_haste = __TS__DecorateLegacy({ registerModifier(nil) }, modifier_item_0393_stealth_haste)
____exports.modifier_item_0393_stealth_haste = modifier_item_0393_stealth_haste
return ____exports