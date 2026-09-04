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
local ____ability_tag_context = require("shared.ability_tag_context")
local ResolveAbilityTags = ____ability_tag_context.ResolveAbilityTags
local _____base_item = require("abilities.items._base_item")
local BaseItem_CS = _____base_item.BaseItem_CS
____exports.item_0367 = __TS__Class()
local item_0367 = ____exports.item_0367
item_0367.name = "item_0367"
__TS__ClassExtends(item_0367, BaseItem_CS)
function item_0367.prototype.GetIntrinsicModifierName(self)
	return ____exports.modifier_item_0367_momentum.name
end
item_0367 = __TS__DecorateLegacy({ registerAbility(nil) }, item_0367)
____exports.item_0367 = item_0367
____exports.modifier_item_0367_momentum = __TS__Class()
local modifier_item_0367_momentum = ____exports.modifier_item_0367_momentum
modifier_item_0367_momentum.name = "modifier_item_0367_momentum"
__TS__ClassExtends(modifier_item_0367_momentum, BaseModifier_CS)
function modifier_item_0367_momentum.prototype.____constructor(self, ...)
	BaseModifier_CS.prototype.____constructor(self, ...)
	self.accumulatedDistance = 0
	self.decayRemainder = 0
end
function modifier_item_0367_momentum.GetLocalizationCN(self)
	return { name = "蓄势", description = "移动会积蓄攻击力，随后随时间流失。" }
end
function modifier_item_0367_momentum.prototype.DeclareEvents(self)
	return { BusinessEvents.ON_AFTER_ABILITY_FULLY_CAST }
end
function modifier_item_0367_momentum.prototype.OnCreated(self)
	if not IsServer() then
		return
	end
	local parent = self:GetParent()
	if IsValid(nil, parent) then
		self.lastPosition = parent:GetAbsOrigin()
	end
	self:StartIntervalThink(self:GetThinkInterval())
end
function modifier_item_0367_momentum.prototype.OnIntervalThink(self)
	if not IsServer() then
		return
	end
	local parent = self:GetParent()
	local ability = self:GetAbility()
	if not ability or not IsValidAlive(nil, parent) then
		return
	end
	local interval = self:GetThinkInterval()
	local currentPosition = parent:GetAbsOrigin()
	self:AccumulateMovedDistance(ability, currentPosition)
	self:DecayBonusAttackDamage(ability, interval)
	self.lastPosition = currentPosition
end
function modifier_item_0367_momentum.prototype.OnDestroy(self)
	if not IsServer() then
		return
	end
	self:StartIntervalThink(-1)
end
function modifier_item_0367_momentum.prototype.OnAfterAbilityFullyCast_CS(self, event)
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
	if not self:IsMovementAbility(castAbility) then
		return
	end
	local ability_duration = math.max(0, ability:GetSpecialValueFor("ability_duration"))
	if ability_duration <= 0 then
		return
	end
	parent:AddNewModifier(
		parent,
		ability,
		____exports.modifier_item_0367_sonic_barrier.name,
		{ duration = ability_duration }
	)
end
function modifier_item_0367_momentum.prototype.GetAttributeBonus(self)
	return { bonus_attack_damage = self:GetStackCount() }
end
function modifier_item_0367_momentum.prototype.IsHidden(self)
	return self:GetStackCount() <= 0
end
function modifier_item_0367_momentum.prototype.IsPurgable(self)
	return false
end
function modifier_item_0367_momentum.prototype.AccumulateMovedDistance(self, ability, currentPosition)
	if not self.lastPosition then
		self.lastPosition = currentPosition
		return
	end
	local ability_distance_per_step = math.max(1, ability:GetSpecialValueFor("ability_distance_per_step"))
	local ability_bonus_attack_damage_per_step =
		math.max(0, ability:GetSpecialValueFor("ability_bonus_attack_damage_per_step"))
	local ability_max_bonus_attack_damage = math.max(0, ability:GetSpecialValueFor("ability_max_bonus_attack_damage"))
	local movedDistance = math.max(0, GetDistance(nil, self.lastPosition, currentPosition))
	if movedDistance <= 0 or ability_bonus_attack_damage_per_step <= 0 or ability_max_bonus_attack_damage <= 0 then
		return
	end
	self.accumulatedDistance = self.accumulatedDistance + movedDistance
	local stepCount = math.floor(self.accumulatedDistance / ability_distance_per_step)
	if stepCount <= 0 then
		return
	end
	self.accumulatedDistance = self.accumulatedDistance - stepCount * ability_distance_per_step
	local nextBonus = math.min(
		ability_max_bonus_attack_damage,
		self:GetStackCount() + stepCount * ability_bonus_attack_damage_per_step
	)
	self:UpdateBonusAttackDamage(nextBonus)
end
function modifier_item_0367_momentum.prototype.DecayBonusAttackDamage(self, ability, interval)
	local currentBonus = self:GetStackCount()
	if currentBonus <= 0 then
		self.decayRemainder = 0
		return
	end
	local ability_decay_attack_damage_pct_per_second =
		math.max(0, ability:GetSpecialValueFor("ability_decay_attack_damage_pct_per_second"))
	if ability_decay_attack_damage_pct_per_second <= 0 then
		return
	end
	local decayPerSecond = math.max(10, currentBonus * (ability_decay_attack_damage_pct_per_second / 100))
	local decayAmount = decayPerSecond * interval + self.decayRemainder
	local decayCount = math.floor(decayAmount)
	self.decayRemainder = decayAmount - decayCount
	if decayCount <= 0 then
		return
	end
	local nextBonus = math.max(0, currentBonus - decayCount)
	self:UpdateBonusAttackDamage(nextBonus)
end
function modifier_item_0367_momentum.prototype.UpdateBonusAttackDamage(self, nextBonus)
	local normalizedBonus = math.max(0, math.floor(nextBonus + 0.5))
	if normalizedBonus == self:GetStackCount() then
		return
	end
	self:SetStackCount(normalizedBonus)
	self:RefreshAttributes()
end
function modifier_item_0367_momentum.prototype.IsMovementAbility(self, ability)
	local tags = ResolveAbilityTags(
		nil,
		MyGameRulesetManager and MyGameRulesetManager:GetAbilityConfig(ability:GetAbilityName())
	)
	return bit.band(tags, 4) ~= 0
end
function modifier_item_0367_momentum.prototype.GetThinkInterval(self)
	return 0.1
end
modifier_item_0367_momentum = __TS__DecorateLegacy({ registerModifier(nil) }, modifier_item_0367_momentum)
____exports.modifier_item_0367_momentum = modifier_item_0367_momentum
____exports.modifier_item_0367_sonic_barrier = __TS__Class()
local modifier_item_0367_sonic_barrier = ____exports.modifier_item_0367_sonic_barrier
modifier_item_0367_sonic_barrier.name = "modifier_item_0367_sonic_barrier"
__TS__ClassExtends(modifier_item_0367_sonic_barrier, BaseModifier_CS)
function modifier_item_0367_sonic_barrier.GetLocalizationCN(self)
	return { name = "音障", description = "攻击速度和移动速度提高。" }
end
function modifier_item_0367_sonic_barrier.prototype.OnCreated(self)
	if not IsServer() then
		return
	end
	local parent = self:GetParent()
	local particle =
		ParticleManager:CreateParticle("particles/items2_fx/mask_of_madness.vpcf", PATTACH_ABSORIGIN_FOLLOW, parent)
	ParticleManager:SetParticleControl(particle, 0, parent:GetAbsOrigin())
	self:AddParticle(particle, false, false, -1, false, false)
end
function modifier_item_0367_sonic_barrier.prototype.GetAttributeBonus(self)
	local ability = self:GetAbility()
	if not ability or not IsValid(nil, ability) then
		return {}
	end
	return {
		attack_speed = math.max(0, ability:GetSpecialValueFor("ability_bonus_attack_speed")),
		bonus_movespeed_pct = math.max(0, ability:GetSpecialValueFor("ability_bonus_movespeed_pct")),
	}
end
function modifier_item_0367_sonic_barrier.prototype.IsHidden(self)
	return false
end
function modifier_item_0367_sonic_barrier.prototype.IsDebuff(self)
	return false
end
function modifier_item_0367_sonic_barrier.prototype.IsPurgable(self)
	return true
end
function modifier_item_0367_sonic_barrier.prototype.GetTexture(self)
	return "item_force_boots"
end
modifier_item_0367_sonic_barrier = __TS__DecorateLegacy({ registerModifier(nil) }, modifier_item_0367_sonic_barrier)
____exports.modifier_item_0367_sonic_barrier = modifier_item_0367_sonic_barrier
return ____exports