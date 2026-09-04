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
____exports.item_0453 = __TS__Class()
local item_0453 = ____exports.item_0453
item_0453.name = "item_0453"
__TS__ClassExtends(item_0453, BaseItem_CS)
function item_0453.prototype.Precache(self, context)
	PrecacheResource("particle", "particles/spectre_arcana_minigame_v2_death_target_1.vpcf", context)
end
function item_0453.prototype.GetIntrinsicModifierName(self)
	return ____exports.modifier_item_0453_assassin_creed.name
end
item_0453 = __TS__DecorateLegacy({ registerAbility(nil) }, item_0453)
____exports.item_0453 = item_0453
____exports.modifier_item_0453_assassin_creed = __TS__Class()
local modifier_item_0453_assassin_creed = ____exports.modifier_item_0453_assassin_creed
modifier_item_0453_assassin_creed.name = "modifier_item_0453_assassin_creed"
__TS__ClassExtends(modifier_item_0453_assassin_creed, BaseModifier_CS)
function modifier_item_0453_assassin_creed.prototype.____constructor(self, ...)
	BaseModifier_CS.prototype.____constructor(self, ...)
	self._nextTriggerTime = 0
end
function modifier_item_0453_assassin_creed.prototype.DeclareEvents(self)
	return { BusinessEvents.ON_ATTACK_LANDED }
end
function modifier_item_0453_assassin_creed.prototype.IsHidden(self)
	return true
end
function modifier_item_0453_assassin_creed.prototype.IsPurgable(self)
	return false
end
function modifier_item_0453_assassin_creed.prototype.GetMutexKey(self)
	return "assassin_creed"
end
function modifier_item_0453_assassin_creed.prototype.GetMutexPriority(self)
	return 200
end
function modifier_item_0453_assassin_creed.prototype.OnAttackLanded_CS(self, event)
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
	local ability_value_trigger_chance_pct = math.max(0, ability:GetSpecialValueFor("ability_value_trigger_chance_pct"))
	if not RollPercentage(ability_value_trigger_chance_pct) then
		return
	end
	local ability_agility_damage_pct = math.max(0, ability:GetSpecialValueFor("ability_value_agility_damage_pct"))
	local ability_damage_pct_per_attack_speed =
		math.max(0, ability:GetSpecialValueFor("ability_damage_pct_per_attack_speed"))
	local ability_target_damage_pct = math.max(0, ability:GetSpecialValueFor("ability_target_damage_pct"))
	local ability_area_damage_pct = math.max(0, ability:GetSpecialValueFor("ability_area_damage_pct"))
	local ability_radius = math.max(0, ability:GetSpecialValueFor("ability_radius"))
	local ability_internal_cooldown = math.max(0, ability:GetSpecialValueFor("ability_internal_cooldown"))
	local ability_extra_attack_speed = math.max(0, MyGameAttribute:GetAttribute(parent, "total_attack_speed") or 0)
	local ability_agility = math.max(0, MyGameAttribute:GetAttribute(parent, "total_agility") or 0)
	local ability_damage_multiplier = ability_agility_damage_pct
		/ 100
		* (1 + ability_extra_attack_speed * ability_damage_pct_per_attack_speed / 100)
	local ability_base_damage = ability_agility * ability_damage_multiplier
	if ability_base_damage <= 0 then
		return
	end
	self._nextTriggerTime = ability_current_time + ability_internal_cooldown
	local ability_target_damage = ability_base_damage * (ability_target_damage_pct / 100)
	if ability_target_damage > 0 then
		self:ApplyPhysicalDamage(parent, target, ability, ability_target_damage)
	end
	local ability_area_damage = ability_base_damage * (ability_area_damage_pct / 100)
	if ability_radius > 0 and ability_area_damage > 0 then
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
					goto __continue19
				end
				self:ApplyPhysicalDamage(parent, enemy, ability, ability_area_damage)
			end
			::__continue19::
		end
	end
	self:PlayEffects1(parent, target)
end
function modifier_item_0453_assassin_creed.prototype.ApplyPhysicalDamage(self, parent, target, ability, ability_damage)
	Damage:ApplyDamage({
		attacker = parent,
		victim = target,
		ability = ability,
		damage = ability_damage,
		damage_type = 1,
		extra_data = { custom_tag = "item_0453_assassin_creed", source_name = "刺客信条" },
	})
end
function modifier_item_0453_assassin_creed.prototype.PlayEffects1(self, parent, target)
	local particle = MyGameHeroParticleManager:CreateParticle(
		"particles/spectre_arcana_minigame_v2_death_target_1.vpcf",
		PATTACH_ABSORIGIN_FOLLOW,
		target,
		parent
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
modifier_item_0453_assassin_creed = __TS__DecorateLegacy({ registerModifier(nil) }, modifier_item_0453_assassin_creed)
____exports.modifier_item_0453_assassin_creed = modifier_item_0453_assassin_creed
return ____exports