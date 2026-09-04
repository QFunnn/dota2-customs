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
____exports.item_0459 = __TS__Class()
local item_0459 = ____exports.item_0459
item_0459.name = "item_0459"
__TS__ClassExtends(item_0459, BaseItem_CS)
function item_0459.prototype.GetIntrinsicModifierName(self)
	return ____exports.modifier_item_0459_psionic_conversion.name
end
item_0459 = __TS__DecorateLegacy({ registerAbility(nil) }, item_0459)
____exports.item_0459 = item_0459
____exports.modifier_item_0459_psionic_conversion = __TS__Class()
local modifier_item_0459_psionic_conversion = ____exports.modifier_item_0459_psionic_conversion
modifier_item_0459_psionic_conversion.name = "modifier_item_0459_psionic_conversion"
__TS__ClassExtends(modifier_item_0459_psionic_conversion, BaseModifier_CS)
function modifier_item_0459_psionic_conversion.GetLocalizationCN(self)
	return { name = "灵能转换", description = "释放技能后获得智力，层数会随时间流逝。" }
end
function modifier_item_0459_psionic_conversion.prototype.DeclareEvents(self)
	return { BusinessEvents.ON_AFTER_ABILITY_FULLY_CAST }
end
function modifier_item_0459_psionic_conversion.prototype.OnCreated(self)
	if not IsServer() then
		return
	end
	self:SetStackCount(0)
	self:RefreshAttributes()
	self:StartDecay()
end
function modifier_item_0459_psionic_conversion.prototype.OnRefresh(self)
	if not IsServer() then
		return
	end
	self:StartDecay()
end
function modifier_item_0459_psionic_conversion.prototype.OnAfterAbilityFullyCast_CS(self, event)
	if not IsServer() then
		return
	end
	local parent = self:GetParent()
	local ability = self:GetAbility()
	if not ability or not IsValid(nil, ability) then
		return
	end
	if not IsValidAlive(nil, parent) then
		return
	end
	if event.caster ~= parent:GetEntityIndex() then
		return
	end
	local castAbility = EntIndexToHScript(event.ability_index)
	if not castAbility or not IsValid(nil, castAbility) or castAbility:IsNull() then
		return
	end
	local ____opt_0 = castAbility.IsItem
	if ____opt_0 and ____opt_0(castAbility) then
		return
	end
	local ____opt_2 = castAbility.IsToggle
	if ____opt_2 and ____opt_2(castAbility) then
		return
	end
	local ability_max_stacks = math.max(1, math.floor(ability:GetSpecialValueFor("ability_value_max_stacks")))
	local nextStacks = math.min(self:GetStackCount() + 1, ability_max_stacks)
	if nextStacks == self:GetStackCount() then
		return
	end
	self:SetStackCount(nextStacks)
	self:RefreshAttributes()
end
function modifier_item_0459_psionic_conversion.prototype.OnIntervalThink(self)
	if not IsServer() then
		return
	end
	local currentStacks = self:GetStackCount()
	if currentStacks <= 0 then
		return
	end
	self:SetStackCount(currentStacks - 1)
	self:RefreshAttributes()
end
function modifier_item_0459_psionic_conversion.prototype.OnDestroy(self)
	if not IsServer() then
		return
	end
	self:StartIntervalThink(-1)
end
function modifier_item_0459_psionic_conversion.prototype.GetAttributeBonus(self)
	local ability = self:GetAbility()
	if not ability or not IsValid(nil, ability) then
		return {}
	end
	local stacks = math.max(0, self:GetStackCount())
	if stacks <= 0 then
		return {}
	end
	local ability_intelligence_per_stack =
		math.max(0, ability:GetSpecialValueFor("ability_value_intelligence_per_stack"))
	if ability_intelligence_per_stack <= 0 then
		return {}
	end
	return { bonus_intelligence = stacks * ability_intelligence_per_stack }
end
function modifier_item_0459_psionic_conversion.prototype.IsHidden(self)
	return self:GetStackCount() <= 0
end
function modifier_item_0459_psionic_conversion.prototype.IsDebuff(self)
	return false
end
function modifier_item_0459_psionic_conversion.prototype.IsPurgable(self)
	return false
end
function modifier_item_0459_psionic_conversion.prototype.StartDecay(self)
	local ability = self:GetAbility()
	if not ability or not IsValid(nil, ability) then
		return
	end
	local ability_stack_decay_interval = math.max(0.1, ability:GetSpecialValueFor("ability_stack_decay_interval"))
	self:StartIntervalThink(ability_stack_decay_interval)
end
modifier_item_0459_psionic_conversion =
	__TS__DecorateLegacy({ registerModifier(nil) }, modifier_item_0459_psionic_conversion)
____exports.modifier_item_0459_psionic_conversion = modifier_item_0459_psionic_conversion
return ____exports