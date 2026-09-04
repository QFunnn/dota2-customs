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
____exports.item_0351 = __TS__Class()
local item_0351 = ____exports.item_0351
item_0351.name = "item_0351"
__TS__ClassExtends(item_0351, BaseItem_CS)
function item_0351.prototype.Precache(self, context)
	PrecacheResource(
		"particle",
		"particles/units/heroes/hero_phantom_assassin/phantom_assassin_crit_impact.vpcf",
		context
	)
end
function item_0351.prototype.GetIntrinsicModifierName(self)
	return ____exports.modifier_item_0351_storm_combo.name
end
item_0351 = __TS__DecorateLegacy({ registerAbility(nil) }, item_0351)
____exports.item_0351 = item_0351
____exports.modifier_item_0351_storm_combo = __TS__Class()
local modifier_item_0351_storm_combo = ____exports.modifier_item_0351_storm_combo
modifier_item_0351_storm_combo.name = "modifier_item_0351_storm_combo"
__TS__ClassExtends(modifier_item_0351_storm_combo, BaseModifier_CS)
function modifier_item_0351_storm_combo.prototype.____constructor(self, ...)
	BaseModifier_CS.prototype.____constructor(self, ...)
	self.consecutiveAttackCount = 0
end
function modifier_item_0351_storm_combo.prototype.DeclareEvents(self)
	return { BusinessEvents.ON_ATTACK_LANDED }
end
function modifier_item_0351_storm_combo.prototype.IsHidden(self)
	return true
end
function modifier_item_0351_storm_combo.prototype.IsPurgable(self)
	return false
end
function modifier_item_0351_storm_combo.prototype.OnAttackLanded_CS(self, event)
	if not IsServer() then
		return
	end
	local parent = self:GetParent()
	local ability = self:GetAbility()
	if not ability or event.attacker ~= parent or event.is_sub_attack or event.is_base_attack == false then
		return
	end
	local target = event.target
	if not IsValidAlive(nil, parent) or not IsValidAlive(nil, target) or target:IsBuilding() then
		return
	end
	if target:GetTeamNumber() == parent:GetTeamNumber() then
		return
	end
	if parent:HasModifier(____exports.modifier_item_0351_storm_ready.name) then
		return
	end
	local targetIndex = target:GetEntityIndex()
	if self.lastTargetIndex == targetIndex then
		self.consecutiveAttackCount = self.consecutiveAttackCount + 1
	else
		self.lastTargetIndex = targetIndex
		self.consecutiveAttackCount = 1
	end
	local ability_required_attack_count =
		math.max(1, math.floor(ability:GetSpecialValueFor("ability_required_attack_count")))
	if self.consecutiveAttackCount < ability_required_attack_count then
		return
	end
	parent:AddNewModifier(parent, ability, ____exports.modifier_item_0351_storm_ready.name, {})
	self:ResetCombo()
end
function modifier_item_0351_storm_combo.prototype.ResetCombo(self)
	self.lastTargetIndex = nil
	self.consecutiveAttackCount = 0
end
modifier_item_0351_storm_combo = __TS__DecorateLegacy({ registerModifier(nil) }, modifier_item_0351_storm_combo)
____exports.modifier_item_0351_storm_combo = modifier_item_0351_storm_combo
____exports.modifier_item_0351_storm_ready = __TS__Class()
local modifier_item_0351_storm_ready = ____exports.modifier_item_0351_storm_ready
modifier_item_0351_storm_ready.name = "modifier_item_0351_storm_ready"
__TS__ClassExtends(modifier_item_0351_storm_ready, BaseModifier_CS)
function modifier_item_0351_storm_ready.GetLocalizationCN(self)
	return { name = "风暴连打", description = "下一次普通攻击附加高额物理伤害。" }
end
function modifier_item_0351_storm_ready.prototype.DeclareEvents(self)
	return { BusinessEvents.ON_ATTACK, BusinessEvents.ON_DAMAGE_PRE_APPLY_ATTACKER }
end
function modifier_item_0351_storm_ready.prototype.OnAttack_CS(self, event)
	if not IsServer() then
		return
	end
	local parent = self:GetParent()
	if event.attacker ~= parent or event.is_sub_attack or event.is_base_attack == false then
		return
	end
	local target = event.target
	if not IsValidAlive(nil, parent) or not IsValidAlive(nil, target) or target:IsBuilding() then
		return
	end
	if target:GetTeamNumber() == parent:GetTeamNumber() then
		return
	end
	self.pendingTargetIndex = target:GetEntityIndex()
end
function modifier_item_0351_storm_ready.prototype.OnDamagePreApplyAttacker_CS(self, event)
	if not IsServer() then
		return
	end
	local parent = self:GetParent()
	local ability = self:GetAbility()
	if not ability or event.ctx.spec.attacker ~= parent or not event.ctx.spec.is_base_attack then
		return
	end
	local victim = event.ctx.spec.victim
	if not IsValidAlive(nil, victim) or victim:GetEntityIndex() ~= self.pendingTargetIndex then
		return
	end
	local ability_damage_multiplier = math.max(0, ability:GetSpecialValueFor("ability_damage_multiplier") / 100)
	local ____event_final_0, ____add_1 = event.final, "add"
	if ____event_final_0[____add_1] == nil then
		____event_final_0[____add_1] = {}
	end
	local ____event_final_add_2 = event.final.add
	____event_final_add_2[#____event_final_add_2 + 1] =
		{ value = event.final.base * ability_damage_multiplier, source = "item_0351:蓄力攻击增伤" }
	self:PlayEffects1(victim)
	self:Destroy()
end
function modifier_item_0351_storm_ready.prototype.OnDestroy(self)
	if not IsServer() then
		return
	end
	self.pendingTargetIndex = nil
end
function modifier_item_0351_storm_ready.prototype.IsHidden(self)
	return false
end
function modifier_item_0351_storm_ready.prototype.IsDebuff(self)
	return false
end
function modifier_item_0351_storm_ready.prototype.IsPurgable(self)
	return false
end
function modifier_item_0351_storm_ready.prototype.GetTexture(self)
	return "item_icon__09"
end
function modifier_item_0351_storm_ready.prototype.PlayEffects1(self, target)
	local particle = MyGameHeroParticleManager:CreateParticle(
		"particles/units/heroes/hero_phantom_assassin/phantom_assassin_crit_impact.vpcf",
		PATTACH_ABSORIGIN_FOLLOW,
		target,
		self:GetParent()
	)
	MyGameHeroParticleManager:SetParticleControlEnt(
		particle,
		0,
		target,
		PATTACH_ABSORIGIN_FOLLOW,
		"attach_hitloc",
		target:GetAbsOrigin(),
		true
	)
	MyGameHeroParticleManager:SetParticleControlEnt(
		particle,
		1,
		target,
		PATTACH_ABSORIGIN_FOLLOW,
		"attach_hitloc",
		target:GetAbsOrigin(),
		true
	)
	MyGameHeroParticleManager:ReleaseParticleIndex(particle)
	EmitSoundOn("Hero_PhantomAssassin.CoupDeGrace", target)
end
modifier_item_0351_storm_ready = __TS__DecorateLegacy({ registerModifier(nil) }, modifier_item_0351_storm_ready)
____exports.modifier_item_0351_storm_ready = modifier_item_0351_storm_ready
return ____exports