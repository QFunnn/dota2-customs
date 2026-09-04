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
local __TS__StringStartsWith = ____lualib.__TS__StringStartsWith
local ____exports = {}
local ____dota_ts_adapter = require("utils.dota_ts_adapter")
local registerAbility = ____dota_ts_adapter.registerAbility
local registerModifier = ____dota_ts_adapter.registerModifier
local ____modifier_base = require("modifiers.class.modifier_base")
local BaseModifier_CS = ____modifier_base.BaseModifier_CS
local _____base_item = require("abilities.items._base_item")
local BaseItem_CS = _____base_item.BaseItem_CS
____exports.item_0346 = __TS__Class()
local item_0346 = ____exports.item_0346
item_0346.name = "item_0346"
__TS__ClassExtends(item_0346, BaseItem_CS)
function item_0346.prototype.GetItemConfig(self)
	return {
		cooldown = function()
			return self:GetSpecialValueFor("ability_value_c_trigger_cooldown")
		end,
	}
end
function item_0346.prototype.GetIntrinsicModifierName(self)
	return ____exports.modifier_item_0346_retreat.name
end
item_0346 = __TS__DecorateLegacy({ registerAbility(nil) }, item_0346)
____exports.item_0346 = item_0346
____exports.modifier_item_0346_retreat = __TS__Class()
local modifier_item_0346_retreat = ____exports.modifier_item_0346_retreat
modifier_item_0346_retreat.name = "modifier_item_0346_retreat"
__TS__ClassExtends(modifier_item_0346_retreat, BaseModifier_CS)
function modifier_item_0346_retreat.prototype.DeclareEvents(self)
	return { BusinessEvents.ON_TAKE_ATTACK_MISS }
end
function modifier_item_0346_retreat.prototype.OnTakeAttackMiss_CS(self, event)
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
	local ability_reduce_cooldown_sec = math.max(0, ability:GetSpecialValueFor("ability_reduce_cooldown_sec"))
	if ability_reduce_cooldown_sec <= 0 then
		return
	end
	self:ReduceAbilityCooldowns(parent, ability_reduce_cooldown_sec)
	self:StartTriggerCooldown(ability)
	self:PlayEffects1(parent)
end
function modifier_item_0346_retreat.prototype.IsHidden(self)
	return true
end
function modifier_item_0346_retreat.prototype.IsPurgable(self)
	return false
end
function modifier_item_0346_retreat.prototype.ReduceAbilityCooldowns(self, parent, ability_reduce_cooldown_sec)
	local abilityCount = parent:GetAbilityCount()
	do
		local i = 0
		while i < abilityCount do
			do
				local ability = parent:GetAbilityByIndex(i)
				if not ability or not IsValid(nil, ability) or ability:IsNull() then
					goto __continue14
				end
				local ____opt_0 = ability.IsItem
				if ____opt_0 and ____opt_0(ability) then
					goto __continue14
				end
				local ____opt_2 = ability.GetAbilityName
				if ____opt_2 ~= nil then
					local ____opt_3 = ability.GetAbilityName
					____opt_2 = __TS__StringStartsWith(____opt_3 and ____opt_3(ability), "item_")
				end
				if ____opt_2 then
					goto __continue14
				end
				local remaining = ability:GetCooldownTimeRemaining()
				if remaining <= 0 then
					goto __continue14
				end
				ability:EndCooldown()
				local nextCooldown = math.max(0, remaining - ability_reduce_cooldown_sec)
				if nextCooldown > 0 then
					ability:StartCooldown(nextCooldown)
				end
			end
			::__continue14::
			i = i + 1
		end
	end
end
function modifier_item_0346_retreat.prototype.StartTriggerCooldown(self, ability)
	local level = math.max(0, ability:GetLevel() - 1)
	local cooldown = ability:GetCooldown(level)
	local ____ability_7 = ability
	local ____ability_StartCooldown_8 = ability.StartCooldown
	local ____temp_6
	if cooldown > 0 then
		____temp_6 = cooldown
	else
		____temp_6 = 0.7
	end
	____ability_StartCooldown_8(____ability_7, ____temp_6)
end
function modifier_item_0346_retreat.prototype.PlayEffects1(self, parent)
	parent:EmitSound("DOTA_Item.Butterfly")
end
modifier_item_0346_retreat = __TS__DecorateLegacy({ registerModifier(nil) }, modifier_item_0346_retreat)
____exports.modifier_item_0346_retreat = modifier_item_0346_retreat
return ____exports