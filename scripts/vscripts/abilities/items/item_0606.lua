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
____exports.item_0606 = __TS__Class()
local item_0606 = ____exports.item_0606
item_0606.name = "item_0606"
__TS__ClassExtends(item_0606, BaseItem_CS)
function item_0606.prototype.Precache(self, context)
	PrecacheResource("particle", "particles/units/heroes/hero_sven/sven_spell_storm_bolt.vpcf", context)
end
function item_0606.prototype.GetIntrinsicModifierName(self)
	return ____exports.modifier_item_0606.name
end
item_0606 = __TS__DecorateLegacy({ registerAbility(nil) }, item_0606)
____exports.item_0606 = item_0606
____exports.modifier_item_0606 = __TS__Class()
local modifier_item_0606 = ____exports.modifier_item_0606
modifier_item_0606.name = "modifier_item_0606"
__TS__ClassExtends(modifier_item_0606, BaseModifier_CS)
function modifier_item_0606.prototype.IsHidden(self)
	return true
end
function modifier_item_0606.prototype.IsPurgable(self)
	return false
end
function modifier_item_0606.prototype.GetMutexKey(self)
	return "item_0606_mutex"
end
function modifier_item_0606.prototype.GetMutexPriority(self)
	local ability = self:GetAbility()
	return ability and ability:GetAbilityName() == "item_0606" and 200 or 100
end
function modifier_item_0606.prototype.OnCreated(self)
	if not IsServer() then
		return
	end
	self:ScheduleNextHammer()
end
function modifier_item_0606.prototype.OnRefresh(self)
	if not IsServer() then
		return
	end
	self:ScheduleNextHammer()
end
function modifier_item_0606.prototype.OnDestroy(self)
	if not IsServer() then
		return
	end
	self:StartIntervalThink(-1)
end
function modifier_item_0606.prototype.OnIntervalThink(self)
	if not IsServer() then
		return
	end
	local caster = self:GetParent()
	local ability = self:GetAbility()
	if not ability or not IsValid(nil, ability) or ability:IsNull() or not IsValidAlive(nil, caster) then
		self:Destroy()
		return
	end
	local target = self:FindRandomTarget(caster, ability)
	if target then
		self:LaunchHammer(caster, target, ability)
	end
	self:ScheduleNextHammer()
end
function modifier_item_0606.prototype.ScheduleNextHammer(self)
	local caster = self:GetParent()
	local ability = self:GetAbility()
	if not ability or not IsValid(nil, ability) or ability:IsNull() or not IsValidAlive(nil, caster) then
		return
	end
	local ability_attack_speed_threshold = ability:GetSpecialValueFor("ability_attack_speed_threshold")
	local ability_attack_speed_step = ability:GetSpecialValueFor("ability_attack_speed_step")
	local ability_total_attack_speed = math.max(0, MyGameAttribute:GetAttribute(caster, "total_attack_speed") or 0)
	local ability_extra_attack_speed = math.max(0, ability_total_attack_speed - ability_attack_speed_threshold)
	local ability_frequency_bonus_pct =
		math.min(100, math.floor(ability_extra_attack_speed / ability_attack_speed_step) * 25)
	local ability_fire_interval = 1 / (1 + ability_frequency_bonus_pct / 100)
	self:StartIntervalThink(ability_fire_interval)
end
function modifier_item_0606.prototype.FindRandomTarget(self, caster, ability)
	local ability_search_radius = ability:GetSpecialValueFor("ability_search_radius")
	local enemies = FindUnitsInRadius(
		caster:GetTeamNumber(),
		caster:GetAbsOrigin(),
		nil,
		ability_search_radius,
		DOTA_UNIT_TARGET_TEAM_ENEMY,
		DOTA_UNIT_TARGET_HEROES_AND_CREEPS,
		DOTA_UNIT_TARGET_FLAG_NONE,
		FIND_ANY_ORDER,
		false
	)
	local validTargets = {}
	for ____, enemy in ipairs(enemies) do
		do
			if not IsValidAlive(nil, enemy) or enemy:IsBuilding() then
				goto __continue21
			end
			validTargets[#validTargets + 1] = enemy
		end
		::__continue21::
	end
	if #validTargets <= 0 then
		return nil
	end
	return validTargets[RandomInt(0, #validTargets - 1) + 1]
end
function modifier_item_0606.prototype.LaunchHammer(self, caster, target, ability)
	local ability_projectile_speed = ability:GetSpecialValueFor("ability_projectile_speed")
	CreateProjectile(nil, {
		ability = ability,
		caster = caster,
		effect_name = "particles/units/heroes/hero_sven/sven_spell_storm_bolt.vpcf",
		projectile_speed = ability_projectile_speed,
		projectile_type = "tracking",
		start_point = self:GetProjectileLaunchOrigin(caster),
		target = target,
		on_hit = function(____, hitTarget)
			if not hitTarget or not IsValidAlive(nil, hitTarget) then
				return true
			end
			if not IsValidAlive(nil, caster) or not IsValid(nil, ability) or ability:IsNull() then
				return true
			end
			self:OnHammerHit(caster, hitTarget, ability)
			return true
		end,
	})
end
function modifier_item_0606.prototype.OnHammerHit(self, caster, target, ability)
	local rolledDamagePct = ability:GetSpecialValueFor("ability_value_attack_damage_pct")
	local ____temp_0
	if rolledDamagePct > 0 then
		____temp_0 = rolledDamagePct
	else
		____temp_0 = ability:GetSpecialValueFor("ability_attack_damage_pct")
	end
	local ability_attack_damage_pct = ____temp_0
	local ability_damage = self:GetAllAttackDamage(caster) * ability_attack_damage_pct / 100
	MyGameAttack:PerformAttack(caster, target, {
		attack_damage = 0,
		disable_celled = true,
		is_sub_attack = true,
		never_miss = true,
		use_effect = true,
		use_projectile = false,
	})
	Damage:ApplyDamage({
		attacker = caster,
		victim = target,
		damage = ability_damage,
		damage_type = 4,
		ability = ability,
	})
	local rolledManaPct = ability:GetSpecialValueFor("ability_value_c_mana_restore_max_mana_pct")
	local ____temp_1
	if rolledManaPct > 0 then
		____temp_1 = rolledManaPct
	else
		____temp_1 = ability:GetSpecialValueFor("ability_c_mana_restore_max_mana_pct")
	end
	local ability_mana_restore_max_mana_pct = ____temp_1
	local ability_max_mana = math.max(0, caster:GetMaxMana())
	local ability_missing_mana = math.max(0, ability_max_mana - caster:GetMana())
	local ability_restore_mana =
		math.min(ability_missing_mana, ability_max_mana * (ability_mana_restore_max_mana_pct / 100))
	if ability_restore_mana > 0 then
		caster:GiveMana(ability_restore_mana)
	end
	self:PlayEffects2(target)
end
function modifier_item_0606.prototype.GetProjectileLaunchOrigin(self, caster)
	local attachment = caster:ScriptLookupAttachment("attach_attack1")
	local ____temp_2
	if attachment > 0 then
		____temp_2 = caster:GetAttachmentOrigin(attachment)
	else
		____temp_2 = caster:GetAbsOrigin()
	end
	return ____temp_2
end
function modifier_item_0606.prototype.PlayEffects2(self, target)
	EmitSoundOn("Hero_Sven.StormBoltImpact", target)
end
modifier_item_0606 = __TS__DecorateLegacy({ registerModifier(nil) }, modifier_item_0606)
____exports.modifier_item_0606 = modifier_item_0606
return ____exports