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
local ____monster_base = require("abilities.monster.monster_base")
local MonsterAbility_CS = ____monster_base.MonsterAbility_CS
local ____elite_showcase_utils = require("abilities.monster.elite.elite_showcase_utils")
local EliteGroundLineEnd = ____elite_showcase_utils.EliteGroundLineEnd
local EliteRotateDirection = ____elite_showcase_utils.EliteRotateDirection
local ____elite_302 = require("abilities.monster.elite.elite_302")
local modifier_elite_302_mound = ____elite_302.modifier_elite_302_mound
local GROUND_IMPALE_DISTANCE = 800
local MOUND_IMPALE_DISTANCE = 1500
local IMPALE_CAST_POINT = 0.65
local IMPALE_WIDTH = 140
local IMPALE_SPEED = 1800
local IMPALE_DAMAGE_RATE = 14
local IMPALE_STUN_DURATION = 0.25
local IMPALE_KNOCKUP_HEIGHT = 160
local CAST_DURATION = 0.2
local GROUND_FAN_ANGLES = { -24, 0, 24 }
local GROUND_FAN_INTERVAL = 0.08
local GROUND_FAN_DAMAGE_RATE = 9
local SCREEN_SHAKE_AMPLITUDE = 12
local SCREEN_SHAKE_FREQUENCY = 12
local SCREEN_SHAKE_DURATION = 0.2
local SCREEN_SHAKE_RADIUS = 1800
local IMPALE_PARTICLE = "particles/units/heroes/hero_nyx_assassin/nyx_assassin_impale.vpcf"
local IMPALE_HIT_PARTICLE = "particles/units/heroes/hero_nyx_assassin/nyx_assassin_impale_hit.vpcf"
____exports.elite_303 = __TS__Class()
local elite_303 = ____exports.elite_303
elite_303.name = "elite_303"
__TS__ClassExtends(elite_303, MonsterAbility_CS)
function elite_303.prototype.Precache(self, context)
	PrecacheResource("particle", IMPALE_PARTICLE, context)
	PrecacheResource("particle", IMPALE_HIT_PARTICLE, context)
end
function elite_303.prototype.GetMosnterAbilityConfig(self)
	return {
		castRange = function()
			return self:GetImpaleDistance()
		end,
		behavior = DOTA_ABILITY_BEHAVIOR_NO_TARGET,
		castPoint = IMPALE_CAST_POINT,
		castDuration = CAST_DURATION,
		castAnimation = ACT_DOTA_CAST_ABILITY_1,
		cooldown = 10,
		canCast = function()
			local ____IsValidAlive_result_0
			if IsValidAlive(nil, self:FindTarget()) then
				____IsValidAlive_result_0 = UF_SUCCESS
			else
				____IsValidAlive_result_0 = UF_FAIL_CUSTOM
			end
			return ____IsValidAlive_result_0
		end,
		OnPhaseStart = function()
			return self:PrepareImpale()
		end,
		OnStart = function()
			local caster = self:GetCaster()
			if not IsValidAlive(nil, caster) then
				return
			end
			self:FireImpale(caster)
		end,
	}
end
function elite_303.prototype.PrepareImpale(self)
	local caster = self:GetCaster()
	if not IsValidAlive(nil, caster) then
		return
	end
	local origin = GetGroundPosition(caster:GetAbsOrigin(), caster)
	local direction = self:ResolveImpaleDirection(caster)
	local distance = self:GetImpaleDistance()
	local isMound = self:IsMoundState(caster)
	caster:LockTargetForSpeed(self:FindTarget() or caster, IMPALE_CAST_POINT, 8)
	if isMound then
		self:WarningEffect(
			origin,
			EliteGroundLineEnd(nil, origin, direction, distance, caster),
			IMPALE_CAST_POINT,
			{ startWidth = IMPALE_WIDTH, endWidth = IMPALE_WIDTH }
		)
		return
	end
	for ____, angle in ipairs(GROUND_FAN_ANGLES) do
		local fanDirection = EliteRotateDirection(nil, direction, angle)
		self:WarningEffect(
			origin,
			EliteGroundLineEnd(nil, origin, fanDirection, distance, caster),
			IMPALE_CAST_POINT,
			{ startWidth = IMPALE_WIDTH, endWidth = IMPALE_WIDTH }
		)
	end
end
function elite_303.prototype.FireImpale(self, caster)
	local origin = GetGroundPosition(caster:GetAbsOrigin(), caster)
	local direction = self:ResolveImpaleDirection(caster)
	caster:SetForwardVectorWithoutInterrupt(direction)
	caster:StartGestureWithPlaybackRate(ACT_DOTA_CAST_ABILITY_1, 1)
	if self:IsMoundState(caster) then
		self:DoImpale(caster, origin, direction, MOUND_IMPALE_DISTANCE, IMPALE_DAMAGE_RATE, IMPALE_STUN_DURATION)
		return
	end
	do
		local index = 0
		while index < #GROUND_FAN_ANGLES do
			local currentIndex = index
			self:Timer(currentIndex * GROUND_FAN_INTERVAL, function()
				if not IsValidAlive(nil, caster) then
					return
				end
				local fanDirection = EliteRotateDirection(nil, direction, GROUND_FAN_ANGLES[currentIndex + 1])
				self:DoImpale(
					caster,
					origin,
					fanDirection,
					GROUND_IMPALE_DISTANCE,
					GROUND_FAN_DAMAGE_RATE,
					IMPALE_STUN_DURATION
				)
			end)
			index = index + 1
		end
	end
end
function elite_303.prototype.DoImpale(self, caster, start, direction, distance, damageRate, stunDuration)
	local ____end = EliteGroundLineEnd(nil, start, direction, distance, caster)
	self:PlayImpaleScreenShake(start)
	CreateProjectile(nil, {
		ability = self,
		caster = caster,
		effect_name = IMPALE_PARTICLE,
		projectile_type = "linear",
		start_point = start,
		target = ____end,
		projectile_speed = IMPALE_SPEED,
		projectile_distance = distance,
		projectile_range = IMPALE_WIDTH,
		projectile_target_team = DOTA_UNIT_TARGET_TEAM_ENEMY,
		projectile_target_type = DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,
		projectile_target_flags = DOTA_UNIT_TARGET_FLAG_NONE,
		on_hit = function(____, hitTarget)
			if not hitTarget or not IsValidAlive(nil, hitTarget) then
				return true
			end
			if not IsValidAlive(nil, caster) then
				return
			end
			caster:MonsterDamage({ victim = hitTarget, damage_rate = damageRate, ability = self })
			AddDeBuffStatus(nil, hitTarget, caster, self, DebuffStatusType.STUN, { duration = stunDuration })
			hitTarget:KnockBack(caster, self, {
				duration = stunDuration,
				distance = 0,
				height = IMPALE_KNOCKUP_HEIGHT,
				stun = true,
				stunDuration = stunDuration,
			})
			self:PlayImpaleHitEffect(hitTarget:GetAbsOrigin())
			return false
		end,
	})
end
function elite_303.prototype.GetImpaleDistance(self)
	if not IsServer() then
		return GROUND_IMPALE_DISTANCE
	end
	local caster = self:GetCaster()
	if not IsValidAlive(nil, caster) then
		return GROUND_IMPALE_DISTANCE
	end
	return self:IsMoundState(caster) and MOUND_IMPALE_DISTANCE or GROUND_IMPALE_DISTANCE
end
function elite_303.prototype.IsMoundState(self, caster)
	return not not modifier_elite_302_mound:find_on(caster)
end
function elite_303.prototype.ResolveImpaleDirection(self, caster)
	local target = self:FindTarget()
	if IsValidAlive(nil, target) then
		local direction = GetDirection(nil, target:GetAbsOrigin(), caster:GetAbsOrigin())
		if direction:Length2D() > 0.01 then
			return direction
		end
	end
	return caster:GetForwardVector()
end
function elite_303.prototype.FindTarget(self)
	local caster = self:GetCaster()
	if not IsValidAlive(nil, caster) then
		return nil
	end
	return caster:GetMinDistanceUnit(self:GetImpaleDistance())
end
function elite_303.prototype.PlayImpaleHitEffect(self, origin)
	local particle = ParticleManager:CreateParticle(IMPALE_HIT_PARTICLE, PATTACH_WORLDORIGIN, nil)
	ParticleManager:SetParticleControl(particle, 0, origin)
	ParticleManager:ReleaseParticleIndex(particle)
end
function elite_303.prototype.PlayImpaleScreenShake(self, point)
	ScreenShake(
		point,
		SCREEN_SHAKE_AMPLITUDE,
		SCREEN_SHAKE_FREQUENCY,
		SCREEN_SHAKE_DURATION,
		SCREEN_SHAKE_RADIUS,
		0,
		true
	)
end
elite_303 = __TS__DecorateLegacy({ registerAbility(nil) }, elite_303)
____exports.elite_303 = elite_303
return ____exports