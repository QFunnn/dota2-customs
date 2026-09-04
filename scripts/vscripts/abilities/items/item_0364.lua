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
____exports.item_0364 = __TS__Class()
local item_0364 = ____exports.item_0364
item_0364.name = "item_0364"
__TS__ClassExtends(item_0364, BaseItem_CS)
function item_0364.prototype.GetIntrinsicModifierName(self)
	return ____exports.modifier_item_0364_torment.name
end
item_0364 = __TS__DecorateLegacy({ registerAbility(nil) }, item_0364)
____exports.item_0364 = item_0364
____exports.modifier_item_0364_torment = __TS__Class()
local modifier_item_0364_torment = ____exports.modifier_item_0364_torment
modifier_item_0364_torment.name = "modifier_item_0364_torment"
__TS__ClassExtends(modifier_item_0364_torment, BaseModifier_CS)
function modifier_item_0364_torment.GetLocalizationCN(self)
	return { name = "折磨", description = "受到伤害时获得生命上限，层数会随时间流逝。" }
end
function modifier_item_0364_torment.prototype.DeclareEvents(self)
	return { BusinessEvents.ON_TAKE_DAMAGE }
end
function modifier_item_0364_torment.prototype.OnCreated(self)
	if not IsServer() then
		return
	end
	self:SetStackCount(0)
	self:RefreshAttributes()
	self:StartDecay()
end
function modifier_item_0364_torment.prototype.OnRefresh(self)
	if not IsServer() then
		return
	end
	self:StartDecay()
end
function modifier_item_0364_torment.prototype.OnTakeDamage_CS(self, event)
	if not IsServer() then
		return
	end
	local parent = self:GetParent()
	local ability = self:GetAbility()
	if not ability or event.victim ~= parent then
		return
	end
	if not IsValidAlive(nil, parent) then
		return
	end
	if (event.final_damage or 0) <= 0 then
		return
	end
	if CheckTag(nil, event.damage_flag, ApplyDamageFlag.HP_LOSS) then
		return
	end
	local ability_value_max_stacks = math.max(1, math.floor(ability:GetSpecialValueFor("ability_value_max_stacks")))
	local nextStacks = math.min(self:GetStackCount() + 1, ability_value_max_stacks)
	if nextStacks == self:GetStackCount() then
		return
	end
	self:SetStackCount(nextStacks)
	self:RefreshAttributes()
end
function modifier_item_0364_torment.prototype.OnIntervalThink(self)
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
function modifier_item_0364_torment.prototype.OnDestroy(self)
	if not IsServer() then
		return
	end
	self:StartIntervalThink(-1)
end
function modifier_item_0364_torment.prototype.GetAttributeBonus(self)
	local ability = self:GetAbility()
	if not ability or not IsValid(nil, ability) then
		return {}
	end
	local ability_value_bonus_health = math.max(0, ability:GetSpecialValueFor("ability_value_bonus_health"))
	local stacks = math.max(0, self:GetStackCount())
	if ability_value_bonus_health <= 0 or stacks <= 0 then
		return {}
	end
	return { bonus_health = ability_value_bonus_health * stacks }
end
function modifier_item_0364_torment.prototype.IsHidden(self)
	return self:GetStackCount() <= 0
end
function modifier_item_0364_torment.prototype.IsDebuff(self)
	return false
end
function modifier_item_0364_torment.prototype.IsPurgable(self)
	return false
end
function modifier_item_0364_torment.prototype.GetTexture(self)
	return "item_icon_m50_22"
end
function modifier_item_0364_torment.prototype.StartDecay(self)
	local ability = self:GetAbility()
	if not ability or not IsValid(nil, ability) then
		return
	end
	local ability_stack_decay_interval = math.max(0.03, ability:GetSpecialValueFor("ability_stack_decay_interval"))
	self:StartIntervalThink(ability_stack_decay_interval)
end
modifier_item_0364_torment = __TS__DecorateLegacy({ registerModifier(nil) }, modifier_item_0364_torment)
____exports.modifier_item_0364_torment = modifier_item_0364_torment
return ____exports