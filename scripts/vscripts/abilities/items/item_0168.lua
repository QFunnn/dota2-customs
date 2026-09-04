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
____exports.item_0168 = __TS__Class()
local item_0168 = ____exports.item_0168
item_0168.name = "item_0168"
__TS__ClassExtends(item_0168, BaseItem_CS)
function item_0168.prototype.GetIntrinsicModifierName(self)
	return ____exports.modifier_item_0168.name
end
item_0168 = __TS__DecorateLegacy({ registerAbility(nil) }, item_0168)
____exports.item_0168 = item_0168
____exports.modifier_item_0168 = __TS__Class()
local modifier_item_0168 = ____exports.modifier_item_0168
modifier_item_0168.name = "modifier_item_0168"
__TS__ClassExtends(modifier_item_0168, BaseModifier_CS)
function modifier_item_0168.prototype.DeclareEvents(self)
	return { BusinessEvents.ON_TAKE_ATTACK_MISS }
end
function modifier_item_0168.prototype.OnTakeAttackMiss_CS(self, event)
	if not IsServer() then
		return
	end
	local parent = self:GetParent()
	local ability = self:GetAbility()
	if not ability or event.target ~= parent or event.is_miss ~= true then
		return
	end
	if not IsValidAlive(nil, parent) or not ability:IsCooldownReady() then
		return
	end
	local ability_heal_agility_pct = math.max(0, ability:GetSpecialValueFor("ability_value_heal_agility_pct"))
	if ability_heal_agility_pct <= 0 then
		return
	end
	local agility = math.max(0, MyGameAttribute:GetAttribute(parent, "total_agility") or 0)
	local healAmount = agility * (ability_heal_agility_pct / 100)
	if healAmount <= 0 then
		return
	end
	parent:CustomHeal(healAmount, { ability = ability, source = "item" })
	self:StartTriggerCooldown(ability)
	self:PlayEffects1(parent)
end
function modifier_item_0168.prototype.IsHidden(self)
	return true
end
function modifier_item_0168.prototype.IsPurgable(self)
	return false
end
function modifier_item_0168.prototype.StartTriggerCooldown(self, ability)
	local ability_cooldown = math.max(0, ability:GetSpecialValueFor("ability_cooldown"))
	if ability_cooldown > 0 then
		ability:StartCooldown(ability_cooldown)
		return
	end
	local level = math.max(0, ability:GetLevel() - 1)
	local cooldown = ability:GetCooldown(level)
	local ____ability_1 = ability
	local ____ability_StartCooldown_2 = ability.StartCooldown
	local ____temp_0
	if cooldown > 0 then
		____temp_0 = cooldown
	else
		____temp_0 = 1
	end
	____ability_StartCooldown_2(____ability_1, ____temp_0)
end
function modifier_item_0168.prototype.PlayEffects1(self, parent)
	parent:EmitSound("DOTA_Item.Butterfly")
end
modifier_item_0168 = __TS__DecorateLegacy({ registerModifier(nil) }, modifier_item_0168)
____exports.modifier_item_0168 = modifier_item_0168
return ____exports