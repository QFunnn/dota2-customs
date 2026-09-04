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
local FindEnemies = ____item_0409_shared.FindEnemies
local GetAgility = ____item_0409_shared.GetAgility
local IsRealNonItemAbility = ____item_0409_shared.IsRealNonItemAbility
local IsValidEnemyUnit = ____item_0409_shared.IsValidEnemyUnit
local ReduceCooldown = ____item_0409_shared.ReduceCooldown
local ReduceNonItemCooldowns = ____item_0409_shared.ReduceNonItemCooldowns
____exports.item_0423 = __TS__Class()
local item_0423 = ____exports.item_0423
item_0423.name = "item_0423"
__TS__ClassExtends(item_0423, BaseItem_CS)
function item_0423.prototype.GetIntrinsicModifierName(self)
	return ____exports.modifier_item_0423_empty_phase.name
end
item_0423 = __TS__DecorateLegacy({ registerAbility(nil) }, item_0423)
____exports.item_0423 = item_0423
____exports.modifier_item_0423_empty_phase = __TS__Class()
local modifier_item_0423_empty_phase = ____exports.modifier_item_0423_empty_phase
modifier_item_0423_empty_phase.name = "modifier_item_0423_empty_phase"
__TS__ClassExtends(modifier_item_0423_empty_phase, BaseModifier_CS)
function modifier_item_0423_empty_phase.prototype.____constructor(self, ...)
	BaseModifier_CS.prototype.____constructor(self, ...)
	self.nextEvasionGainTime = 0
end
function modifier_item_0423_empty_phase.prototype.DeclareEvents(self)
	return {
		BusinessEvents.ON_TAKE_ATTACK_MISS,
		BusinessEvents.ON_ATTACK_LANDED,
		BusinessEvents.ON_AFTER_ABILITY_FULLY_CAST,
	}
end
function modifier_item_0423_empty_phase.prototype.IsHidden(self)
	return true
end
function modifier_item_0423_empty_phase.prototype.OnTakeAttackMiss_CS(self, event)
	if not IsServer() then
		return
	end
	local parent = self:GetParent()
	local ability = self:GetAbility()
	if not ability or event.target ~= parent or event.is_miss ~= true then
		return
	end
	if not IsValidAlive(nil, parent) then
		return
	end
	local now = GameRules:GetGameTime()
	if now < self.nextEvasionGainTime then
		return
	end
	local ability_max_stacks = math.max(1, math.floor(ability:GetSpecialValueFor("ability_max_stacks")))
	local stackModifier = parent:FindModifierByName(____exports.modifier_item_0423_empty_phase_stack.name)
		or parent:AddNewModifier(
			parent,
			ability,
			____exports.modifier_item_0423_empty_phase_stack.name,
			{ duration = -1 }
		)
	if stackModifier then
		local nextStacks = math.min(ability_max_stacks, stackModifier:GetStackCount() + 1)
		stackModifier:SetStackCount(nextStacks)
	end
	local ability_trigger_cooldown = math.max(0.1, ability:GetSpecialValueFor("ability_trigger_cooldown"))
	self.nextEvasionGainTime = now + ability_trigger_cooldown
end
function modifier_item_0423_empty_phase.prototype.OnAttackLanded_CS(self, event)
	if not IsServer() then
		return
	end
	local parent = self:GetParent()
	local ability = self:GetAbility()
	if not ability or event.attacker ~= parent or event.is_sub_attack then
		return
	end
	if not IsValidEnemyUnit(nil, parent, event.target) then
		return
	end
	self:ConsumePhase(parent, ability, event.target, nil)
end
function modifier_item_0423_empty_phase.prototype.OnAfterAbilityFullyCast_CS(self, event)
	if not IsServer() then
		return
	end
	local parent = self:GetParent()
	local ability = self:GetAbility()
	if not ability or event.caster ~= parent:GetEntityIndex() then
		return
	end
	local castAbility = EntIndexToHScript(event.ability_index)
	if not IsRealNonItemAbility(nil, castAbility) then
		return
	end
	local ____temp_0
	if event.target and event.target > 0 then
		____temp_0 = EntIndexToHScript(event.target)
	else
		____temp_0 = nil
	end
	local explicitTarget = ____temp_0
	local ____IsValidEnemyUnit_result_1
	if IsValidEnemyUnit(nil, parent, explicitTarget) then
		____IsValidEnemyUnit_result_1 = explicitTarget
	else
		____IsValidEnemyUnit_result_1 = nil
	end
	local target = ____IsValidEnemyUnit_result_1
	if not target then
		local ability_search_radius = math.max(0, ability:GetSpecialValueFor("ability_search_radius"))
		target = FindEnemies(nil, parent, parent:GetAbsOrigin(), ability_search_radius)[1]
	end
	self:ConsumePhase(parent, ability, target, castAbility)
end
function modifier_item_0423_empty_phase.prototype.ConsumePhase(self, parent, ability, target, castAbility)
	local stackModifier = parent:FindModifierByName(____exports.modifier_item_0423_empty_phase_stack.name)
	if not stackModifier or stackModifier:GetStackCount() <= 0 then
		return
	end
	stackModifier:SetStackCount(stackModifier:GetStackCount() - 1)
	if stackModifier:GetStackCount() <= 0 then
		stackModifier:Destroy()
	end
	local ability_reduce_cooldown_sec = math.max(0, ability:GetSpecialValueFor("ability_reduce_cooldown_sec"))
	if castAbility then
		ReduceCooldown(nil, castAbility, ability_reduce_cooldown_sec)
	else
		ReduceNonItemCooldowns(nil, parent, ability_reduce_cooldown_sec)
	end
	if not IsValidEnemyUnit(nil, parent, target) then
		return
	end
	local ability_agility_damage_pct = math.max(0, ability:GetSpecialValueFor("ability_agility_damage_pct"))
	local damage = GetAgility(nil, parent) * (ability_agility_damage_pct / 100)
	if damage <= 0 then
		return
	end
	Damage:ApplyDamage({
		attacker = parent,
		victim = target,
		damage = damage,
		damage_type = 2,
		ability = ability,
		extra_data = {
			custom_tag = "item_0423_empty_phase",
			source_name = self:GetName(),
		},
	})
	EmitSoundOn("DOTA_Item.Butterfly", target)
end
modifier_item_0423_empty_phase = __TS__DecorateLegacy({ registerModifier(nil) }, modifier_item_0423_empty_phase)
____exports.modifier_item_0423_empty_phase = modifier_item_0423_empty_phase
____exports.modifier_item_0423_empty_phase_stack = __TS__Class()
local modifier_item_0423_empty_phase_stack = ____exports.modifier_item_0423_empty_phase_stack
modifier_item_0423_empty_phase_stack.name = "modifier_item_0423_empty_phase_stack"
__TS__ClassExtends(modifier_item_0423_empty_phase_stack, BaseModifier_CS)
function modifier_item_0423_empty_phase_stack.prototype.IsPurgable(self)
	return false
end
modifier_item_0423_empty_phase_stack =
	__TS__DecorateLegacy({ registerModifier(nil) }, modifier_item_0423_empty_phase_stack)
____exports.modifier_item_0423_empty_phase_stack = modifier_item_0423_empty_phase_stack
return ____exports