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
____exports.item_0361 = __TS__Class()
local item_0361 = ____exports.item_0361
item_0361.name = "item_0361"
__TS__ClassExtends(item_0361, BaseItem_CS)
function item_0361.prototype.Precache(self, context)
	PrecacheResource("particle", "particles/spectre_arcana_minigame_v2_death_target_2.vpcf", context)
end
function item_0361.prototype.GetIntrinsicModifierName(self)
	return ____exports.modifier_item_0361_assassin_creed.name
end
item_0361 = __TS__DecorateLegacy({ registerAbility(nil) }, item_0361)
____exports.item_0361 = item_0361
____exports.modifier_item_0361_assassin_creed = __TS__Class()
local modifier_item_0361_assassin_creed = ____exports.modifier_item_0361_assassin_creed
modifier_item_0361_assassin_creed.name = "modifier_item_0361_assassin_creed"
__TS__ClassExtends(modifier_item_0361_assassin_creed, BaseModifier_CS)
function modifier_item_0361_assassin_creed.prototype.____constructor(self, ...)
	BaseModifier_CS.prototype.____constructor(self, ...)
	self._nextTriggerTime = 0
end
function modifier_item_0361_assassin_creed.prototype.DeclareEvents(self)
	return { BusinessEvents.ON_ATTACK_LANDED }
end
function modifier_item_0361_assassin_creed.prototype.IsHidden(self)
	return true
end
function modifier_item_0361_assassin_creed.prototype.IsPurgable(self)
	return false
end
function modifier_item_0361_assassin_creed.prototype.GetMutexKey(self)
	return "assassin_creed"
end
function modifier_item_0361_assassin_creed.prototype.GetMutexPriority(self)
	return 100
end
function modifier_item_0361_assassin_creed.prototype.OnAttackLanded_CS(self, event)
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
	local ability_current_time = GameRules:GetGameTime()
	if ability_current_time < (self._nextTriggerTime or 0) then
		return
	end
	local ability_trigger_chance_pct = math.max(0, ability:GetSpecialValueFor("ability_trigger_chance_pct"))
	if not RollPercentage(ability_trigger_chance_pct) then
		return
	end
	local ability_agility_damage_pct = math.max(0, ability:GetSpecialValueFor("ability_agility_damage_pct"))
	local ability_damage_pct_per_attack_speed =
		math.max(0, ability:GetSpecialValueFor("ability_damage_pct_per_attack_speed"))
	local ability_area_damage_pct = 50
	local ability_radius = 180
	local ability_internal_cooldown = 0.2
	local ability_extra_attack_speed = math.max(0, MyGameAttribute:GetAttribute(parent, "total_attack_speed") or 0)
	local ability_agility = math.max(0, MyGameAttribute:GetAttribute(parent, "total_agility") or 0)
	local ability_damage_multiplier = ability_agility_damage_pct
		/ 100
		* (1 + ability_extra_attack_speed * ability_damage_pct_per_attack_speed / 100)
	local ability_damage = ability_agility * ability_damage_multiplier
	if ability_damage <= 0 then
		return
	end
	self._nextTriggerTime = ability_current_time + ability_internal_cooldown
	self:ApplyPhysicalDamage(parent, target, ability, ability_damage)
	local ability_area_damage = ability_damage * (ability_area_damage_pct / 100)
	local enemies = FindUnitsInRadius(
		parent:GetTeamNumber(),
		target:GetAbsOrigin(),
		nil,
		ability_radius,
		DOTA_UNIT_TARGET_TEAM_ENEMY,
		DOTA_UNIT_TARGET_HEROES_AND_CREEPS,
		DOTA_UNIT_TARGET_FLAG_NONE,
		FIND_ANY_ORDER,
		false
	)
	for ____, enemy in ipairs(enemies) do
		do
			if enemy == target or not IsValidAlive(nil, enemy) or enemy:IsBuilding() then
				goto __continue17
			end
			self:ApplyPhysicalDamage(parent, enemy, ability, ability_area_damage)
		end
		::__continue17::
	end
	self:PlayEffects1(target)
end
function modifier_item_0361_assassin_creed.prototype.ApplyPhysicalDamage(self, parent, target, ability, ability_damage)
	Damage:ApplyDamage({
		attacker = parent,
		victim = target,
		ability = ability,
		damage = ability_damage,
		damage_type = 1,
		extra_data = { custom_tag = "item_0361_assassin_creed", source_name = "刺客信条" },
	})
end
function modifier_item_0361_assassin_creed.prototype.PlayEffects1(self, target)
	local particle = MyGameHeroParticleManager:CreateParticle(
		"particles/spectre_arcana_minigame_v2_death_target_2.vpcf",
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
	MyGameHeroParticleManager:SetParticleControlEnt(
		particle,
		2,
		target,
		PATTACH_ABSORIGIN_FOLLOW,
		"attach_hitloc",
		target:GetAbsOrigin(),
		true
	)
	MyGameHeroParticleManager:ReleaseParticleIndex(particle)
	EmitSoundOn("Hero_PhantomAssassin.CoupDeGrace", target)
end
modifier_item_0361_assassin_creed = __TS__DecorateLegacy({ registerModifier(nil) }, modifier_item_0361_assassin_creed)
____exports.modifier_item_0361_assassin_creed = modifier_item_0361_assassin_creed
return ____exports