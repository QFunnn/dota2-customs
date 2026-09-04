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
local __TS__ArraySetLength = ____lualib.__TS__ArraySetLength
local ____exports = {}
local ____dota_ts_adapter = require("utils.dota_ts_adapter")
local registerAbility = ____dota_ts_adapter.registerAbility
local registerModifier = ____dota_ts_adapter.registerModifier
local ____monster_base = require("abilities.monster.monster_base")
local MonsterAbility_CS = ____monster_base.MonsterAbility_CS
local MonsterModifier_CS = ____monster_base.MonsterModifier_CS
____exports.FORCE_FIRE_HIT_FLASH_PARTICLE =
	"particles/units/heroes/hero_crystalmaiden_persona/cm_persona_attack_hit_flash.vpcf"
local PREPARE_EFFECT = "particles/underlord_2021_immortal_portal_buildup_crimson_max.vpcf"
____exports.FORCE_FIRE_BEAM_PARTICLE = "particles/units/heroes/hero_phoenix/phoenix_sunray.vpcf"
local PREPARE_STATUS_EFFECT = "particles/status_fx/status_effect_wraithking_ghosts.vpcf"
local CAST_SOUND = "Hero_RingMaster.TheWheel.Cast.Layer"
local LOOP_SOUND = "Hero_Phoenix.SunRay.Loop"
local CAST_POINT = 1
local CAST_DURATION = 13
local PREPARE_DURATION = 1
local BEAM_DURATION = 12
local LASER_COUNT = 3
local LASER_ANGLE_STEP = 120
local LASER_INTERVAL = 0.03
local LASER_DAMAGE_WIDTH = 90
local LASER_DAMAGE_THRESHOLD = 800
local LASER_LENGTH_START = 300
local LASER_LENGTH_MAX = 1400
local LASER_LENGTH_STEP = 30
local LASER_ROTATE_DURATION = 12
local LASER_DAMAGE_PER_TICK = 5
--- 受击闪白粒子保留时长（秒）
local HIT_FLASH_PFX_LIFETIME = 0.4
____exports.force_fire = __TS__Class()
local force_fire = ____exports.force_fire
force_fire.name = "force_fire"
__TS__ClassExtends(force_fire, MonsterAbility_CS)
function force_fire.prototype.Precache(self, context)
	PrecacheResource("particle", ____exports.FORCE_FIRE_HIT_FLASH_PARTICLE, context)
	PrecacheResource("particle", PREPARE_EFFECT, context)
	PrecacheResource("particle", ____exports.FORCE_FIRE_BEAM_PARTICLE, context)
	PrecacheResource("particle", PREPARE_STATUS_EFFECT, context)
end
function force_fire.prototype.GetMosnterAbilityConfig(self)
	return {
		castPoint = CAST_POINT,
		castDuration = CAST_DURATION,
		behavior = DOTA_ABILITY_BEHAVIOR_NO_TARGET,
		castAnimation = ACT_DOTA_CAST_ABILITY_4,
		isNotMove = false,
		OnPhaseStart = function()
			local caster = self:GetCaster()
			local target = caster:GetMinDistanceUnit(2000)
			if target then
				caster:LockTargetForSpeed(target, CAST_POINT, 4)
			end
		end,
		OnStart = function()
			return self:onStart()
		end,
	}
end
function force_fire.prototype.onStart(self)
	local caster = self:GetCaster()
	caster:EmitSound(CAST_SOUND)
	if not IsValidAlive(nil, caster) or not self then
		return
	end
	caster:StartGesture(ACT_DOTA_SPAWN)
	____exports.modifier_force_fire_modifier:applys(caster, caster, self, { duration = BEAM_DURATION })
	ScreenShake(caster:GetAbsOrigin(), 5, 5, 10, 2500, 0, true)
end
force_fire = __TS__DecorateLegacy({ registerAbility(nil, "force_fire") }, force_fire)
____exports.force_fire = force_fire
____exports.modifier_force_fire_modifier = __TS__Class()
local modifier_force_fire_modifier = ____exports.modifier_force_fire_modifier
modifier_force_fire_modifier.name = "modifier_force_fire_modifier"
__TS__ClassExtends(modifier_force_fire_modifier, MonsterModifier_CS)
function modifier_force_fire_modifier.prototype.____constructor(self, ...)
	MonsterModifier_CS.prototype.____constructor(self, ...)
	self.length = LASER_LENGTH_START
	self.rotateTime = 0
	self.rotateDuration = LASER_ROTATE_DURATION
	self.rotateSpeedMultiplier = 1
	self.damagePerTick = LASER_DAMAGE_PER_TICK
	self.damageWidth = LASER_DAMAGE_WIDTH
	self.damageThreshold = LASER_DAMAGE_THRESHOLD
	self.lengthMax = LASER_LENGTH_MAX
	self.lengthStep = LASER_LENGTH_STEP
	self.particleEffects = {}
end
function modifier_force_fire_modifier.prototype.IsHidden(self)
	return true
end
function modifier_force_fire_modifier.prototype.IsPurgable(self)
	return false
end
function modifier_force_fire_modifier.prototype.OnCreated(self, params)
	if not IsServer() then
		return
	end
	self.rotateDuration = math.max(LASER_INTERVAL, params and params.rotate_duration or LASER_ROTATE_DURATION)
	self.rotateSpeedMultiplier = math.max(0, params and params.rotate_speed_multiplier or 1)
	self.damagePerTick = params and params.damage_per_tick or LASER_DAMAGE_PER_TICK
	self.damageWidth = params and params.damage_width or LASER_DAMAGE_WIDTH
	self.damageThreshold = params and params.damage_threshold or LASER_DAMAGE_THRESHOLD
	self.lengthMax = params and params.length_max or LASER_LENGTH_MAX
	self.lengthStep = params and params.length_step or LASER_LENGTH_STEP
	local caster = self:GetParent()
	caster:EmitSound(LOOP_SOUND)
	do
		local i = 0
		while i < LASER_COUNT do
			local particle =
				ParticleManager:CreateParticle(____exports.FORCE_FIRE_BEAM_PARTICLE, PATTACH_WORLDORIGIN, caster)
			ParticleManager:SetParticleControl(particle, 1, caster:GetAbsOrigin():__add(Vector(0, 0, 80)))
			ParticleManager:SetParticleControl(particle, 9, caster:GetAbsOrigin():__add(Vector(0, 0, 80)))
			ParticleManager:SetParticleShouldCheckFoW(particle, false)
			local ____self_particleEffects_14 = self.particleEffects
			____self_particleEffects_14[#____self_particleEffects_14 + 1] = particle
			self:AddParticle(particle, false, false, -1, false, false)
			i = i + 1
		end
	end
	self:StartIntervalThink(LASER_INTERVAL)
end
function modifier_force_fire_modifier.prototype.OnIntervalThink(self)
	if not IsServer() then
		return
	end
	local caster = self:GetParent()
	if not IsValidAlive(nil, caster) then
		self:Destroy()
		return
	end
	if self.length < self.lengthMax then
		self.length = math.min(self.length + self.lengthStep, self.lengthMax)
	else
		self.rotateTime = self.rotateTime + LASER_INTERVAL
		if self.rotateTime >= self.rotateDuration then
			self:Destroy()
			return
		end
	end
	local rotationSpeedDegPerSec = 360 / self.rotateDuration * self.rotateSpeedMultiplier
	local startBase = caster:GetAbsOrigin():__add(Vector(0, 0, 120))
	do
		local i = 0
		while i < LASER_COUNT do
			do
				local spinDeg = (LASER_ANGLE_STEP * i + self.rotateTime * rotationSpeedDegPerSec) % 360
				local rad = spinDeg * math.pi / 180
				local direction = Vector(math.cos(rad), math.sin(rad), 0):Normalized()
				local endPos = startBase:__add(direction:__mul(self.length)):__add(Vector(0, 0, 120))
				local pfx = self.particleEffects[i + 1]
				ParticleManager:SetParticleControl(pfx, 9, startBase)
				ParticleManager:SetParticleControl(pfx, 0, startBase)
				ParticleManager:SetParticleControl(pfx, 1, endPos)
				if self.length <= self.damageThreshold then
					goto __continue20
				end
				local enemies = FindUnitsInLine(
					caster:GetTeamNumber(),
					startBase,
					endPos,
					nil,
					self.damageWidth,
					DOTA_UNIT_TARGET_TEAM_ENEMY,
					bit.bor(bit.bor(DOTA_UNIT_TARGET_HERO, DOTA_UNIT_TARGET_BASIC), DOTA_UNIT_TARGET_BUILDING),
					DOTA_UNIT_TARGET_FLAG_NOT_MAGIC_IMMUNE_ALLIES
				)
				for ____, enemy in ipairs(enemies) do
					do
						if not IsValidAlive(nil, enemy) then
							goto __continue22
						end
						self:MonsterDamage(enemy, self.damagePerTick)
						local hitPfx = ParticleManager:CreateParticle(
							____exports.FORCE_FIRE_HIT_FLASH_PARTICLE,
							PATTACH_POINT_FOLLOW,
							enemy
						)
						ParticleManager:SetParticleControlEnt(
							hitPfx,
							1,
							enemy,
							PATTACH_POINT_FOLLOW,
							"attach_hitloc",
							enemy:GetAbsOrigin(),
							false
						)
						Timers:CreateTimer(HIT_FLASH_PFX_LIFETIME, function()
							ParticleManager:DestroyParticle(hitPfx, false)
							ParticleManager:ReleaseParticleIndex(hitPfx)
							return nil
						end)
					end
					::__continue22::
				end
			end
			::__continue20::
			i = i + 1
		end
	end
end
function modifier_force_fire_modifier.prototype.DeclareFunctions(self)
	return {
		MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE,
		MODIFIER_PROPERTY_TURN_RATE_PERCENTAGE,
		MODIFIER_PROPERTY_ATTACKSPEED_BONUS_CONSTANT,
		MODIFIER_PROPERTY_OVERRIDE_ANIMATION,
		MODIFIER_PROPERTY_OVERRIDE_ANIMATION_RATE,
	}
end
function modifier_force_fire_modifier.prototype.GetOverrideAnimationRate(self)
	return 1.5
end
function modifier_force_fire_modifier.prototype.GetOverrideAnimation(self)
	return ACT_DOTA_TELEPORT_STATUE
end
function modifier_force_fire_modifier.prototype.GetModifierTurnRate_Percentage(self)
	return -1000
end
function modifier_force_fire_modifier.prototype.GetModifierAttackSpeedBonus_Constant(self)
	return -100
end
function modifier_force_fire_modifier.prototype.GetModifierMoveSpeedBonus_Percentage(self)
	return -50
end
function modifier_force_fire_modifier.prototype.OnDestroy(self)
	if not IsServer() then
		return
	end
	self:GetParent():StopSound(LOOP_SOUND)
	for ____, id in ipairs(self.particleEffects) do
		ParticleManager:DestroyParticle(id, false)
		ParticleManager:ReleaseParticleIndex(id)
	end
	__TS__ArraySetLength(self.particleEffects, 0)
end
modifier_force_fire_modifier =
	__TS__DecorateLegacy({ registerModifier(nil, "force_fire_modifier") }, modifier_force_fire_modifier)
____exports.modifier_force_fire_modifier = modifier_force_fire_modifier
return ____exports