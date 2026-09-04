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
____exports.item_0347 = __TS__Class()
local item_0347 = ____exports.item_0347
item_0347.name = "item_0347"
__TS__ClassExtends(item_0347, BaseItem_CS)
function item_0347.prototype.Precache(self, context)
	PrecacheResource("particle", "particles/items_fx/chain_lightning.vpcf", context)
end
function item_0347.prototype.GetIntrinsicModifierName(self)
	return ____exports.modifier_item_0347_thunder.name
end
item_0347 = __TS__DecorateLegacy({ registerAbility(nil) }, item_0347)
____exports.item_0347 = item_0347
____exports.modifier_item_0347_thunder = __TS__Class()
local modifier_item_0347_thunder = ____exports.modifier_item_0347_thunder
modifier_item_0347_thunder.name = "modifier_item_0347_thunder"
__TS__ClassExtends(modifier_item_0347_thunder, BaseModifier_CS)
function modifier_item_0347_thunder.prototype.DeclareEvents(self)
	return { BusinessEvents.ON_ATTACK_LANDED }
end
function modifier_item_0347_thunder.prototype.IsHidden(self)
	return true
end
function modifier_item_0347_thunder.prototype.IsPurgable(self)
	return false
end
function modifier_item_0347_thunder.prototype.OnAttackLanded_CS(self, event)
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
	local ability_trigger_chance_pct = ability:GetSpecialValueFor("ability_trigger_chance_pct")
	if not RollPercentage(ability_trigger_chance_pct) then
		return
	end
	local ability_all_stats_damage_pct = ability:GetSpecialValueFor("ability_all_stats_damage_pct")
	local damage = self:GetAllStats(parent) * (ability_all_stats_damage_pct / 100)
	if damage <= 0 then
		return
	end
	self:LaunchThunderChain(parent, ability, target, damage)
	self:StartAbilityCooldown(ability)
end
function modifier_item_0347_thunder.prototype.LaunchThunderChain(self, caster, ability, firstTarget, damage)
	local ability_jump_count = math.max(1, math.floor(ability:GetSpecialValueFor("ability_jump_count")))
	local ability_radius = ability:GetSpecialValueFor("ability_radius")
	if ability_radius <= 0 then
		return
	end
	local hitTargets = {}
	local currentTarget = firstTarget
	local jumps = 0
	local doJump
	doJump = function()
		if not IsValidAlive(nil, caster) or not IsValidAlive(nil, currentTarget) then
			return
		end
		if jumps >= ability_jump_count then
			return
		end
		hitTargets[#hitTargets + 1] = currentTarget
		self:ApplyThunderDamage(caster, ability, currentTarget, damage)
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
		Timers:CreateTimer(0.12, doJump)
	end
	doJump(nil)
end
function modifier_item_0347_thunder.prototype.ApplyThunderDamage(self, caster, ability, target, damage)
	Damage:ApplyDamage({
		attacker = caster,
		victim = target,
		damage = damage,
		damage_type = 2,
		ability = ability,
	})
end
function modifier_item_0347_thunder.prototype.FindNextTarget(self, caster, source, ability_radius, hitTargets)
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
				goto __continue24
			end
			if __TS__ArrayIncludes(hitTargets, enemy) then
				goto __continue24
			end
			return enemy
		end
		::__continue24::
	end
	return nil
end
function modifier_item_0347_thunder.prototype.IsValidEnemy(self, parent, target)
	if not target or not IsValidAlive(nil, target) or target:IsBuilding() then
		return false
	end
	return target:GetTeamNumber() ~= parent:GetTeamNumber()
end
function modifier_item_0347_thunder.prototype.StartAbilityCooldown(self, ability)
	local level = math.max(0, ability:GetLevel() - 1)
	local cooldown = ability:GetCooldown(level)
	local ____ability_1 = ability
	local ____ability_StartCooldown_2 = ability.StartCooldown
	local ____temp_0
	if cooldown > 0 then
		____temp_0 = cooldown
	else
		____temp_0 = 0.2
	end
	____ability_StartCooldown_2(____ability_1, ____temp_0)
end
function modifier_item_0347_thunder.prototype.GetAllStats(self, parent)
	local strength = MyGameAttribute:GetAttribute(parent, "total_strength") or 0
	local agility = MyGameAttribute:GetAttribute(parent, "total_agility") or 0
	local intelligence = MyGameAttribute:GetAttribute(parent, "total_intelligence") or 0
	return math.max(0, strength + agility + intelligence)
end
function modifier_item_0347_thunder.prototype.PlayEffects1(self, target)
	EmitSoundOn("Item.Maelstrom.Chain_Lightning", target)
end
function modifier_item_0347_thunder.prototype.PlayEffects2(self, caster, source, target)
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
modifier_item_0347_thunder = __TS__DecorateLegacy({ registerModifier(nil) }, modifier_item_0347_thunder)
____exports.modifier_item_0347_thunder = modifier_item_0347_thunder
return ____exports