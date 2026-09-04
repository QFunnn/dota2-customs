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
local __TS__ArrayIncludes = ____lualib.__TS__ArrayIncludes
local ____exports = {}
local ____dota_ts_adapter = require("utils.dota_ts_adapter")
local registerAbility = ____dota_ts_adapter.registerAbility
local registerModifier = ____dota_ts_adapter.registerModifier
local ____modifier_base = require("modifiers.class.modifier_base")
local BaseModifier_CS = ____modifier_base.BaseModifier_CS
local _____base_item = require("abilities.items._base_item")
local BaseItem_CS = _____base_item.BaseItem_CS
local ____dark_domain_lightning_flash = require("my_game_axe.room.dark_domain_lightning_flash")
local TriggerDarkDomainLightningFlash = ____dark_domain_lightning_flash.TriggerDarkDomainLightningFlash
____exports.item_0342 = __TS__Class()
local item_0342 = ____exports.item_0342
item_0342.name = "item_0342"
__TS__ClassExtends(item_0342, BaseItem_CS)
function item_0342.prototype.Precache(self, context)
	PrecacheResource("particle", "particles/items_fx/chain_lightning.vpcf", context)
end
function item_0342.prototype.GetIntrinsicModifierName(self)
	return ____exports.modifier_item_0342_frost_chain.name
end
item_0342 = __TS__DecorateLegacy({ registerAbility(nil) }, item_0342)
____exports.item_0342 = item_0342
____exports.modifier_item_0342_frost_chain = __TS__Class()
local modifier_item_0342_frost_chain = ____exports.modifier_item_0342_frost_chain
modifier_item_0342_frost_chain.name = "modifier_item_0342_frost_chain"
__TS__ClassExtends(modifier_item_0342_frost_chain, BaseModifier_CS)
function modifier_item_0342_frost_chain.prototype.DeclareEvents(self)
	return { BusinessEvents.ON_ATTACK_LANDED, BusinessEvents.ON_AFTER_ABILITY_FULLY_CAST }
end
function modifier_item_0342_frost_chain.prototype.IsHidden(self)
	return true
end
function modifier_item_0342_frost_chain.prototype.IsPurgable(self)
	return false
end
function modifier_item_0342_frost_chain.prototype.OnAttackLanded_CS(self, event)
	if not IsServer() then
		return
	end
	local parent = self:GetParent()
	local ability = self:GetAbility()
	if not ability or event.attacker ~= parent or event.is_sub_attack then
		return
	end
	if not ability:IsCooldownReady() then
		return
	end
	if not IsValidAlive(nil, parent) then
		return
	end
	local target = event.target
	if not self:IsValidEnemy(parent, target) then
		return
	end
	local ability_attack_damage_pct = ability:GetSpecialValueFor("ability_value_attack_damage_pct")
	local damage = self:GetAllAttackDamage(parent) * (ability_attack_damage_pct / 100)
	if damage <= 0 then
		return
	end
	self:LaunchFrostChain(parent, ability, target, damage)
	self:StartAbilityCooldown(ability)
end
function modifier_item_0342_frost_chain.prototype.OnAfterAbilityFullyCast_CS(self, event)
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
	if not ability:IsCooldownReady() then
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
	local target = self:FindInitialTarget(parent, ability)
	if not target then
		return
	end
	local ability_int_damage_pct = ability:GetSpecialValueFor("ability_value_int_damage_pct")
	local intelligence = MyGameAttribute:GetAttribute(parent, "total_intelligence") or 0
	local damage = intelligence * (ability_int_damage_pct / 100)
	if damage <= 0 then
		return
	end
	self:LaunchFrostChain(parent, ability, target, damage)
	self:StartAbilityCooldown(ability)
end
function modifier_item_0342_frost_chain.prototype.LaunchFrostChain(self, caster, ability, firstTarget, baseDamage)
	local ability_jump_count = math.max(1, math.floor(ability:GetSpecialValueFor("ability_jump_count")))
	local ability_radius = ability:GetSpecialValueFor("ability_radius")
	if ability_radius <= 0 then
		return
	end
	local hitTargets = {}
	local currentTarget = firstTarget
	local jumps = 0
	local currentDamage = baseDamage
	local doJump
	doJump = function()
		if not IsValidAlive(nil, caster) or not IsValidAlive(nil, currentTarget) then
			return
		end
		if jumps >= ability_jump_count then
			return
		end
		hitTargets[#hitTargets + 1] = currentTarget
		self:ApplyFrostChainDamage(caster, ability, currentTarget, currentDamage)
		self:PlayEffects1(currentTarget)
		TriggerDarkDomainLightningFlash(nil, caster, currentTarget)
		jumps = jumps + 1
		if jumps >= ability_jump_count then
			return
		end
		local nextTarget = self:FindNextTarget(caster, currentTarget, ability_radius, hitTargets)
		if not nextTarget then
			return
		end
		self:PlayEffects2(caster, currentTarget, nextTarget)
		currentTarget = nextTarget
		currentDamage = currentDamage * 0.75
		Timers:CreateTimer(0.12, doJump)
	end
	doJump(nil)
end
function modifier_item_0342_frost_chain.prototype.ApplyFrostChainDamage(self, caster, ability, target, damage)
	Damage:ApplyDamage({
		attacker = caster,
		victim = target,
		damage = damage,
		damage_type = 2,
		ability = ability,
	})
end
function modifier_item_0342_frost_chain.prototype.FindInitialTarget(self, parent, ability)
	local ability_radius = ability:GetSpecialValueFor("ability_radius")
	if ability_radius <= 0 then
		return nil
	end
	local enemies = FindUnitsInRadius(
		parent:GetTeamNumber(),
		parent:GetAbsOrigin(),
		nil,
		ability_radius,
		DOTA_UNIT_TARGET_TEAM_ENEMY,
		DOTA_UNIT_TARGET_HEROES_AND_CREEPS,
		DOTA_UNIT_TARGET_FLAG_NONE,
		FIND_CLOSEST,
		false
	)
	for ____, enemy in ipairs(enemies) do
		if self:IsValidEnemy(parent, enemy) then
			return enemy
		end
	end
	return nil
end
function modifier_item_0342_frost_chain.prototype.FindNextTarget(self, caster, source, ability_radius, hitTargets)
	local enemies = FindUnitsInRadius(
		caster:GetTeamNumber(),
		source:GetAbsOrigin(),
		nil,
		ability_radius,
		DOTA_UNIT_TARGET_TEAM_ENEMY,
		DOTA_UNIT_TARGET_HEROES_AND_CREEPS,
		DOTA_UNIT_TARGET_FLAG_NONE,
		FIND_CLOSEST,
		false
	)
	for ____, enemy in ipairs(enemies) do
		do
			if not self:IsValidEnemy(caster, enemy) then
				goto __continue38
			end
			if __TS__ArrayIncludes(hitTargets, enemy) then
				goto __continue38
			end
			return enemy
		end
		::__continue38::
	end
	return nil
end
function modifier_item_0342_frost_chain.prototype.IsValidEnemy(self, parent, target)
	if not target or not IsValidAlive(nil, target) or target:IsBuilding() then
		return false
	end
	return target:GetTeamNumber() ~= parent:GetTeamNumber()
end
function modifier_item_0342_frost_chain.prototype.StartAbilityCooldown(self, ability)
	local level = math.max(0, ability:GetLevel() - 1)
	local cooldown = ability:GetCooldown(level)
	local ____ability_5 = ability
	local ____ability_StartCooldown_6 = ability.StartCooldown
	local ____temp_4
	if cooldown > 0 then
		____temp_4 = cooldown
	else
		____temp_4 = 0.5
	end
	____ability_StartCooldown_6(____ability_5, ____temp_4)
end
function modifier_item_0342_frost_chain.prototype.PlayEffects1(self, target)
	EmitSoundOn("Item.Maelstrom.Chain_Lightning", target)
end
function modifier_item_0342_frost_chain.prototype.PlayEffects2(self, caster, source, target)
	local particle = MyGameHeroParticleManager:CreateParticle(
		"particles/items_fx/chain_lightning.vpcf",
		PATTACH_ABSORIGIN_FOLLOW,
		source,
		caster
	)
	MyGameHeroParticleManager:SetParticleControlEnt(
		particle,
		0,
		source,
		PATTACH_POINT_FOLLOW,
		"attach_hitloc",
		source:GetAbsOrigin(),
		true
	)
	MyGameHeroParticleManager:SetParticleControlEnt(
		particle,
		1,
		target,
		PATTACH_POINT_FOLLOW,
		"attach_hitloc",
		target:GetAbsOrigin(),
		true
	)
	MyGameHeroParticleManager:ReleaseParticleIndex(particle)
	EmitSoundOn("Item.Maelstrom.Chain_Lightning.Jump", target)
end
modifier_item_0342_frost_chain = __TS__DecorateLegacy({ registerModifier(nil) }, modifier_item_0342_frost_chain)
____exports.modifier_item_0342_frost_chain = modifier_item_0342_frost_chain
return ____exports