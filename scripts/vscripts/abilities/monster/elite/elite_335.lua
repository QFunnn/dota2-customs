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
local modifier_elite_335_dash, modifier_elite_335_burn
local ____dota_ts_adapter = require("utils.dota_ts_adapter")
local registerAbility = ____dota_ts_adapter.registerAbility
local registerModifier = ____dota_ts_adapter.registerModifier
local ____monster_base = require("abilities.monster.monster_base")
local MonsterAbility_CS = ____monster_base.MonsterAbility_CS
local MonsterModifier_CS = ____monster_base.MonsterModifier_CS
local ____monkey_movement = require("abilities.monster.boss_monkey.monkey_movement")
local ResolveMonkeyBlinkPoint = ____monkey_movement.ResolveMonkeyBlinkPoint
local FIRE_AMBIENT_PARTICLE = "particles/units/heroes/hero_brewmaster/brewmaster_fire_ambient.vpcf"
local FIRE_DASH_PARTICLE = "particles/units/heroes/hero_ember_spirit/ember_spirit_remnant_dash.vpcf"
local FIRE_DASH_HIT_PARTICLE = "particles/units/heroes/hero_ember_spirit/ember_spirit_hit.vpcf"
local FIRE_BURN_DURATION = 5
local FIRE_BURN_INTERVAL = 1
local FIRE_BURN_DAMAGE_RATE = 4
local FIRE_DASH_RANGE = 800
local FIRE_DASH_RADIUS = 200
local FIRE_DASH_DURATION = 0.25
local FIRE_DASH_DAMAGE_RATE = 8
--- 酒仙火灵的预留精英技能。
____exports.elite_335 = __TS__Class()
local elite_335 = ____exports.elite_335
elite_335.name = "elite_335"
__TS__ClassExtends(elite_335, MonsterAbility_CS)
function elite_335.prototype.____constructor(self, ...)
	MonsterAbility_CS.prototype.____constructor(self, ...)
	self.dashHit = false
	self.dashSequence = 0
end
function elite_335.prototype.Precache(self, context)
	PrecacheResource("particle", FIRE_AMBIENT_PARTICLE, context)
	PrecacheResource("particle", FIRE_DASH_PARTICLE, context)
	PrecacheResource("particle", FIRE_DASH_HIT_PARTICLE, context)
end
function elite_335.prototype.GetIntrinsicModifierName(self)
	return "modifier_elite_335_death_effect"
end
function elite_335.prototype.GetMosnterAbilityConfig(self)
	return {
		behavior = DOTA_ABILITY_BEHAVIOR_NO_TARGET,
		castRange = FIRE_DASH_RANGE,
		castPoint = 0.5,
		castDuration = FIRE_DASH_DURATION,
		castAnimation = ACT_DOTA_FLAIL,
		OnPhaseStart = function()
			return self:PrepareDash()
		end,
		OnStart = function()
			return self:PerformDash()
		end,
	}
end
function elite_335.prototype.PrepareDash(self)
	local caster = self:GetCaster()
	if not IsValidAlive(nil, caster) then
		return
	end
	local target = caster:GetMinDistanceUnit(FIRE_DASH_RANGE)
	local ____temp_0
	if target and IsValidAlive(nil, target) then
		____temp_0 = GetDirection(nil, target:GetAbsOrigin(), caster:GetAbsOrigin())
	else
		____temp_0 = caster:GetForwardVector()
	end
	self.dashDirection = ____temp_0
	if target and IsValidAlive(nil, target) then
		caster:LockTargetForSpeed(target, 0.5, 8)
	end
end
function elite_335.prototype.PerformDash(self)
	local caster = self:GetCaster()
	if not IsServer() or not IsValidAlive(nil, caster) then
		return
	end
	local direction = self.dashDirection or caster:GetForwardVector()
	local origin = caster:GetAbsOrigin()
	local dashEnd = ResolveMonkeyBlinkPoint(nil, caster, origin:__add(direction:__mul(FIRE_DASH_RANGE)))
	if not dashEnd then
		return
	end
	self.dashHit = false
	local ____self_1, ____dashSequence_2 = self, "dashSequence"
	local ____self_dashSequence_3 = ____self_1[____dashSequence_2] + 1
	____self_1[____dashSequence_2] = ____self_dashSequence_3
	local sequence = ____self_dashSequence_3
	caster:SetForwardVector(direction)
	modifier_elite_335_dash:applys(caster, caster, self, { duration = FIRE_DASH_DURATION + 0.1 })
	caster:Mover(dashEnd, FIRE_DASH_DURATION, function(____, position)
		if self.dashHit then
			return
		end
		if not self:DamageDashArea(position) then
			return
		end
		self.dashHit = true
		self:PlayDashImpact(position)
	end)
	self:Timer(FIRE_DASH_DURATION, function()
		if sequence ~= self.dashSequence or not IsValidAlive(nil, caster) then
			return
		end
		local landingPosition = caster:GetAbsOrigin()
		self:PlayDashImpact(landingPosition)
		self:DamageDashArea(landingPosition)
	end)
end
function elite_335.prototype.PlayDashImpact(self, position)
	local effect = ParticleManager:CreateParticle(FIRE_DASH_HIT_PARTICLE, PATTACH_WORLDORIGIN, nil)
	ParticleManager:SetParticleControl(effect, 0, position)
	ParticleManager:ReleaseParticleIndex(effect)
end
function elite_335.prototype.DamageDashArea(self, position)
	local caster = self:GetCaster()
	if not IsValidAlive(nil, caster) then
		return false
	end
	local enemies = FindUnitsInRadius(
		caster:GetTeamNumber(),
		position,
		nil,
		FIRE_DASH_RADIUS,
		DOTA_UNIT_TARGET_TEAM_ENEMY,
		DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC + DOTA_UNIT_TARGET_BUILDING,
		DOTA_UNIT_TARGET_FLAG_NONE,
		FIND_ANY_ORDER,
		false
	)
	local hit = false
	for ____, enemy in ipairs(enemies) do
		do
			if not IsValidAlive(nil, enemy) then
				goto __continue21
			end
			caster:MonsterDamage({ victim = enemy, damage_rate = FIRE_DASH_DAMAGE_RATE, ability = self })
			hit = true
		end
		::__continue21::
	end
	return hit
end
elite_335 = __TS__DecorateLegacy({ registerAbility(nil) }, elite_335)
____exports.elite_335 = elite_335
local modifier_elite_335_death_effect = __TS__Class()
modifier_elite_335_death_effect.name = "modifier_elite_335_death_effect"
__TS__ClassExtends(modifier_elite_335_death_effect, MonsterModifier_CS)
function modifier_elite_335_death_effect.prototype.GetEffectName(self)
	return FIRE_AMBIENT_PARTICLE
end
function modifier_elite_335_death_effect.prototype.GetEffectAttachType(self)
	return PATTACH_ABSORIGIN_FOLLOW
end
function modifier_elite_335_death_effect.prototype.DeclareEvents(self)
	return { BusinessEvents.ON_ATTACK_LANDED }
end
function modifier_elite_335_death_effect.prototype.OnAttackLanded_CS(self, event)
	if not IsServer() then
		return
	end
	local parent = self:GetParent()
	if event.attacker ~= parent or event.is_sub_attack then
		return
	end
	local target = event.target
	local ability = self:GetAbility()
	if not ability or ability:IsNull() or not IsValidAlive(nil, target) then
		return
	end
	if target:GetTeamNumber() == parent:GetTeamNumber() then
		return
	end
	modifier_elite_335_burn:applys(target, parent, ability, { duration = FIRE_BURN_DURATION })
end
modifier_elite_335_death_effect =
	__TS__DecorateLegacy({ registerModifier(nil, "modifier_elite_335_death_effect") }, modifier_elite_335_death_effect)
modifier_elite_335_dash = __TS__Class()
modifier_elite_335_dash.name = "modifier_elite_335_dash"
__TS__ClassExtends(modifier_elite_335_dash, MonsterModifier_CS)
function modifier_elite_335_dash.prototype.OnCreated(self)
	if not IsServer() then
		return
	end
	local parent = self:GetParent()
	self.particle = ParticleManager:CreateParticle(FIRE_DASH_PARTICLE, PATTACH_ABSORIGIN_FOLLOW, parent)
	ParticleManager:SetParticleControlEnt(
		self.particle,
		0,
		parent,
		PATTACH_ABSORIGIN_FOLLOW,
		"attach_hitloc",
		parent:GetAbsOrigin(),
		true
	)
	ParticleManager:SetParticleControlEnt(
		self.particle,
		1,
		parent,
		PATTACH_ABSORIGIN_FOLLOW,
		"attach_hitloc",
		parent:GetAbsOrigin(),
		true
	)
end
function modifier_elite_335_dash.prototype.OnDestroy(self)
	if not IsServer() or self.particle == nil then
		return
	end
	ParticleManager:DestroyParticle(self.particle, false)
	ParticleManager:ReleaseParticleIndex(self.particle)
	self.particle = nil
end
function modifier_elite_335_dash.prototype.DeclareFunctions(self)
	return { MODIFIER_PROPERTY_TRANSLATE_ACTIVITY_MODIFIERS, MODIFIER_PROPERTY_OVERRIDE_ANIMATION }
end
function modifier_elite_335_dash.prototype.GetOverrideAnimation(self)
	return ACT_DOTA_FLAIL
end
function modifier_elite_335_dash.prototype.GetActivityTranslationModifiers(self)
	return "forcestaff_friendly"
end
function modifier_elite_335_dash.prototype.CheckState(self)
	return { [MODIFIER_STATE_INVULNERABLE] = true }
end
function modifier_elite_335_dash.prototype.IsHidden(self)
	return true
end
modifier_elite_335_dash =
	__TS__DecorateLegacy({ registerModifier(nil, "modifier_elite_335_dash") }, modifier_elite_335_dash)
modifier_elite_335_burn = __TS__Class()
modifier_elite_335_burn.name = "modifier_elite_335_burn"
__TS__ClassExtends(modifier_elite_335_burn, MonsterModifier_CS)
function modifier_elite_335_burn.prototype.OnCreated(self)
	if not IsServer() then
		return
	end
	self:StartIntervalThink(FIRE_BURN_INTERVAL)
end
function modifier_elite_335_burn.prototype.OnIntervalThink(self)
	if not IsServer() then
		return
	end
	local parent = self:GetParent()
	local caster = self:GetCaster()
	local ability = self:GetAbility()
	if not IsValidAlive(nil, parent) or not IsValidAlive(nil, caster) or not ability or ability:IsNull() then
		self:Destroy()
		return
	end
	caster:MonsterDamage({ victim = parent, damage_rate = FIRE_BURN_DAMAGE_RATE, ability = ability })
end
function modifier_elite_335_burn.prototype.IsDebuff(self)
	return true
end
function modifier_elite_335_burn.prototype.IsPurgable(self)
	return true
end
modifier_elite_335_burn =
	__TS__DecorateLegacy({ registerModifier(nil, "modifier_elite_335_burn") }, modifier_elite_335_burn)
return ____exports