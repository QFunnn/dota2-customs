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
local ____item_0409_shared = require("abilities.items.item_0409_shared")
local IsRealNonItemAbility = ____item_0409_shared.IsRealNonItemAbility
local StartAbilityCooldown = ____item_0409_shared.StartAbilityCooldown
____exports.item_0204 = __TS__Class()
local item_0204 = ____exports.item_0204
item_0204.name = "item_0204"
__TS__ClassExtends(item_0204, BaseItem_CS)
function item_0204.prototype.GetIntrinsicModifierName(self)
	return ____exports.modifier_item_0204_tracker.name
end
item_0204 = __TS__DecorateLegacy({ registerAbility(nil) }, item_0204)
____exports.item_0204 = item_0204
____exports.modifier_item_0204_tracker = __TS__Class()
local modifier_item_0204_tracker = ____exports.modifier_item_0204_tracker
modifier_item_0204_tracker.name = "modifier_item_0204_tracker"
__TS__ClassExtends(modifier_item_0204_tracker, BaseModifier_CS)
function modifier_item_0204_tracker.prototype.DeclareEvents(self)
	return { BusinessEvents.ON_ATTACK_LANDED, BusinessEvents.ON_AFTER_ABILITY_FULLY_CAST }
end
function modifier_item_0204_tracker.prototype.IsHidden(self)
	return true
end
function modifier_item_0204_tracker.prototype.IsPurgable(self)
	return false
end
function modifier_item_0204_tracker.prototype.OnAttackLanded_CS(self, event)
	if not IsServer() then
		return
	end
	local parent = self:GetParent()
	local ability = self:GetAbility()
	if not ability or event.attacker ~= parent or event.is_sub_attack then
		return
	end
	local target = event.target
	if not IsValidAlive(nil, parent) then
		return
	end
	if target:GetTeamNumber() == parent:GetTeamNumber() then
		return
	end
	self:TryAddValorStack(parent, ability)
end
function modifier_item_0204_tracker.prototype.OnAfterAbilityFullyCast_CS(self, event)
	if not IsServer() then
		return
	end
	local parent = self:GetParent()
	local ability = self:GetAbility()
	if not ability or not IsValidAlive(nil, parent) then
		return
	end
	if event.caster ~= parent:GetEntityIndex() then
		return
	end
	local castAbility = EntIndexToHScript(event.ability_index)
	if not IsRealNonItemAbility(nil, castAbility) then
		return
	end
	self:TryAddValorStack(parent, ability)
end
function modifier_item_0204_tracker.prototype.TryAddValorStack(self, parent, ability)
	if not ability:IsCooldownReady() then
		return
	end
	local ability_time = math.max(0.03, ability:GetSpecialValueFor("ability_time"))
	parent:AddNewModifier(parent, ability, ____exports.modifier_item_0204_valor.name, { duration = ability_time })
	StartAbilityCooldown(nil, ability, 0.5)
end
modifier_item_0204_tracker = __TS__DecorateLegacy({ registerModifier(nil) }, modifier_item_0204_tracker)
____exports.modifier_item_0204_tracker = modifier_item_0204_tracker
____exports.modifier_item_0204_valor = __TS__Class()
local modifier_item_0204_valor = ____exports.modifier_item_0204_valor
modifier_item_0204_valor.name = "modifier_item_0204_valor"
__TS__ClassExtends(modifier_item_0204_valor, BaseModifier_CS)
function modifier_item_0204_valor.GetLocalizationCN(self)
	return { name = "英勇", description = "攻击或释放技能时获得生命上限，最多叠加指定层数。" }
end
function modifier_item_0204_valor.prototype.OnCreated(self, params)
	if not IsServer() then
		return
	end
	self:SetStackCount(1)
	self:RefreshAttributes()
	self:RefreshDuration(params.duration)
end
function modifier_item_0204_valor.prototype.OnRefresh(self, params)
	if not IsServer() then
		return
	end
	local ability = self:GetAbility()
	if not ability then
		return
	end
	local ability_buff_max = math.max(1, math.floor(ability:GetSpecialValueFor("ability_buff_max")))
	local nextStacks = math.min(self:GetStackCount() + 1, ability_buff_max)
	self:SetStackCount(nextStacks)
	self:RefreshAttributes()
	self:RefreshDuration(params.duration)
end
function modifier_item_0204_valor.prototype.GetAttributeBonus(self)
	local ability = self:GetAbility()
	if not ability then
		return {}
	end
	local ability_item_0204_hp_buff = self:GetHealthPerStack(ability)
	return { bonus_health = self:GetStackCount() * ability_item_0204_hp_buff }
end
function modifier_item_0204_valor.prototype.IsHidden(self)
	return false
end
function modifier_item_0204_valor.prototype.IsDebuff(self)
	return false
end
function modifier_item_0204_valor.prototype.IsPurgable(self)
	return false
end
function modifier_item_0204_valor.prototype.RefreshDuration(self, duration)
	if not IsServer() then
		return
	end
	local nextDuration = math.max(duration or 0, 0.03)
	self:SetDuration(nextDuration, true)
end
function modifier_item_0204_valor.prototype.GetHealthPerStack(self, ability)
	return math.max(0, ability:GetSpecialValueFor("ability_item_0308_hp_buff"))
end
modifier_item_0204_valor = __TS__DecorateLegacy({ registerModifier(nil) }, modifier_item_0204_valor)
____exports.modifier_item_0204_valor = modifier_item_0204_valor
return ____exports