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
local _____base_item = require("abilities.items._base_item")
local BaseItem_CS = _____base_item.BaseItem_CS
local ____item_potion_base = require("abilities.items.potions.item_potion_base")
local BasePotionModifier_CS = ____item_potion_base.BasePotionModifier_CS
local ____dark_domain_lightning_flash = require("my_game_axe.room.dark_domain_lightning_flash")
local TriggerDarkDomainLightningFlash = ____dark_domain_lightning_flash.TriggerDarkDomainLightningFlash
____exports.item_P053 = __TS__Class()
local item_P053 = ____exports.item_P053
item_P053.name = "item_P053"
__TS__ClassExtends(item_P053, BaseItem_CS)
function item_P053.prototype.Precache(self, context)
	PrecacheResource("particle", "particles/items_fx/chain_lightning.vpcf", context)
end
function item_P053.prototype.GetItemConfig(self)
	return {
		behavior = DOTA_ABILITY_BEHAVIOR_NO_TARGET,
		useType = "slow",
		duration = 1,
		castAnimation = ACT_DOTA_GENERIC_CHANNEL_1,
		onSuccess = function()
			local caster = self:GetCaster()
			if not IsValidAlive(nil, caster) then
				return
			end
			local ability_duration = self:GetSpecialValueFor("ability_duration")
			local ability_attack_damage_pct = self:GetSpecialValueFor("ability_attack_damage_pct")
			local ability_jump_count = self:GetSpecialValueFor("ability_jump_count")
			local ability_jump_radius = self:GetSpecialValueFor("ability_jump_radius")
			local ability_internal_cooldown = self:GetSpecialValueFor("ability_internal_cooldown")
			self:ApplyPotionModifier(
				____exports.modifier_item_P053_lightning_potion.name,
				ability_duration,
				{
					ability_attack_damage_pct = ability_attack_damage_pct,
					ability_jump_count = ability_jump_count,
					ability_jump_radius = ability_jump_radius,
					ability_internal_cooldown = ability_internal_cooldown,
				}
			)
			self:PlayEffects1(caster)
			self:CostItemCharge(1)
		end,
		onInterrupted = function() end,
	}
end
function item_P053.prototype.PlayEffects1(self, caster)
	caster:EmitSound("DOTA_Item.FaerieSpark.Activate")
end
item_P053 = __TS__DecorateLegacy({ registerAbility(nil) }, item_P053)
____exports.item_P053 = item_P053
____exports.modifier_item_P053_lightning_potion = __TS__Class()
local modifier_item_P053_lightning_potion = ____exports.modifier_item_P053_lightning_potion
modifier_item_P053_lightning_potion.name = "modifier_item_P053_lightning_potion"
__TS__ClassExtends(modifier_item_P053_lightning_potion, BasePotionModifier_CS)
function modifier_item_P053_lightning_potion.prototype.____constructor(self, ...)
	BasePotionModifier_CS.prototype.____constructor(self, ...)
	self.abilityAttackDamagePct = 0
	self.abilityJumpCount = 0
	self.abilityJumpRadius = 0
	self.abilityInternalCooldown = 0
	self.nextTriggerTime = 0
end
function modifier_item_P053_lightning_potion.GetLocalizationCN(self)
	return { name = "闪电药剂", description = "主攻击命中时释放闪电链。" }
end
function modifier_item_P053_lightning_potion.prototype.OnCreated(self, params)
	BasePotionModifier_CS.prototype.OnCreated(self, params)
	self:ReadParams(params)
end
function modifier_item_P053_lightning_potion.prototype.OnRefresh(self, params)
	self:SetPotionSequence(params and params.ak_potion_sequence)
	self:ReadParams(params)
	self.nextTriggerTime = 0
end
function modifier_item_P053_lightning_potion.prototype.IsHidden(self)
	return false
end
function modifier_item_P053_lightning_potion.prototype.IsPurgable(self)
	return false
end
function modifier_item_P053_lightning_potion.prototype.GetTexture(self)
	return "item_maelstrom"
end
function modifier_item_P053_lightning_potion.prototype.DeclareEvents(self)
	return { BusinessEvents.ON_ATTACK_LANDED }
end
function modifier_item_P053_lightning_potion.prototype.OnAttackLanded_CS(self, event)
	if not IsServer() then
		return
	end
	local attacker = self:GetParent()
	if not IsValidAlive(nil, attacker) or event.attacker ~= attacker or event.is_sub_attack == true then
		return
	end
	if not self:IsValidEnemy(attacker, event.target) then
		return
	end
	local currentTime = GameRules:GetGameTime()
	if currentTime < self.nextTriggerTime then
		return
	end
	local damage = self:GetAllAttackDamage(attacker) * (self.abilityAttackDamagePct / 100)
	if damage <= 0 or self.abilityJumpCount <= 0 or self.abilityJumpRadius <= 0 then
		return
	end
	self.nextTriggerTime = currentTime + self.abilityInternalCooldown
	self:LaunchLightningChain(attacker, event.target, damage)
end
function modifier_item_P053_lightning_potion.prototype.LaunchLightningChain(self, attacker, firstTarget, damage)
	local ability_jump_interval = 0.12
	local hitTargets = {}
	local source = attacker
	local currentTarget = firstTarget
	local hitCount = 0
	local doJump
	doJump = function()
		if not IsValidAlive(nil, attacker) or not self:IsValidEnemy(attacker, currentTarget) then
			return
		end
		if hitCount >= self.abilityJumpCount then
			return
		end
		local ____IsValidAlive_result_2
		if IsValidAlive(nil, source) then
			____IsValidAlive_result_2 = source
		else
			____IsValidAlive_result_2 = attacker
		end
		local effectSource = ____IsValidAlive_result_2
		self:PlayEffects2(effectSource, currentTarget)
		hitTargets[#hitTargets + 1] = currentTarget
		self:ApplyLightningDamage(attacker, currentTarget, damage)
		TriggerDarkDomainLightningFlash(nil, attacker, currentTarget)
		hitCount = hitCount + 1
		if hitCount >= self.abilityJumpCount then
			return
		end
		local nextTarget = self:FindNextTarget(attacker, currentTarget, hitTargets)
		if not nextTarget then
			return
		end
		source = currentTarget
		currentTarget = nextTarget
		self:Timer(ability_jump_interval, doJump)
	end
	doJump(nil)
end
function modifier_item_P053_lightning_potion.prototype.FindNextTarget(self, attacker, source, hitTargets)
	local enemies = FindUnitsInRadius(
		attacker:GetTeamNumber(),
		source:GetAbsOrigin(),
		nil,
		self.abilityJumpRadius,
		DOTA_UNIT_TARGET_TEAM_ENEMY,
		DOTA_UNIT_TARGET_HEROES_AND_CREEPS,
		DOTA_UNIT_TARGET_FLAG_NONE,
		FIND_CLOSEST,
		false
	)
	for ____, enemy in ipairs(enemies) do
		do
			if not self:IsValidEnemy(attacker, enemy) then
				goto __continue28
			end
			if __TS__ArrayIncludes(hitTargets, enemy) then
				goto __continue28
			end
			return enemy
		end
		::__continue28::
	end
	return nil
end
function modifier_item_P053_lightning_potion.prototype.IsValidEnemy(self, attacker, target)
	if not target or not IsValidAlive(nil, target) or target:IsBuilding() then
		return false
	end
	return target:GetTeamNumber() ~= attacker:GetTeamNumber()
end
function modifier_item_P053_lightning_potion.prototype.ApplyLightningDamage(self, attacker, target, damage)
	local ability = self:GetAbility()
	local ____Damage_7 = Damage
	local ____Damage_ApplyDamage_8 = Damage.ApplyDamage
	local ____attacker_4 = attacker
	local ____target_5 = target
	local ____damage_6 = damage
	local ____temp_3
	if ability and IsValid(nil, ability) then
		____temp_3 = ability
	else
		____temp_3 = nil
	end
	____Damage_ApplyDamage_8(____Damage_7, {
		attacker = ____attacker_4,
		victim = ____target_5,
		damage = ____damage_6,
		damage_type = 2,
		ability = ____temp_3,
		extra_data = { source_name = "item_P053_lightning_chain" },
	})
end
function modifier_item_P053_lightning_potion.prototype.PlayEffects2(self, source, target)
	local particle =
		ParticleManager:CreateParticle("particles/items_fx/chain_lightning.vpcf", PATTACH_ABSORIGIN_FOLLOW, source)
	ParticleManager:SetParticleControlEnt(
		particle,
		0,
		source,
		PATTACH_POINT_FOLLOW,
		"attach_hitloc",
		source:GetAbsOrigin(),
		true
	)
	ParticleManager:SetParticleControlEnt(
		particle,
		1,
		target,
		PATTACH_POINT_FOLLOW,
		"attach_hitloc",
		target:GetAbsOrigin(),
		true
	)
	ParticleManager:ReleaseParticleIndex(particle)
	EmitSoundOn("Item.Maelstrom.Chain_Lightning.Jump", target)
end
function modifier_item_P053_lightning_potion.prototype.ReadParams(self, params)
	self.abilityAttackDamagePct = math.max(0, tonumber(params and params.ability_attack_damage_pct) or 0)
	self.abilityJumpCount = math.max(0, math.floor(tonumber(params and params.ability_jump_count) or 0))
	self.abilityJumpRadius = math.max(0, tonumber(params and params.ability_jump_radius) or 0)
	self.abilityInternalCooldown = math.max(0, tonumber(params and params.ability_internal_cooldown) or 0)
end
modifier_item_P053_lightning_potion =
	__TS__DecorateLegacy({ registerModifier(nil) }, modifier_item_P053_lightning_potion)
____exports.modifier_item_P053_lightning_potion = modifier_item_P053_lightning_potion
return ____exports