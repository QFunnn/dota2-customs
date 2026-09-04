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
local CAST_RANGE = 1100
local CAST_POINT = 0.55
local CAST_DURATION = 1.45
local LEAP_DURATION = 0.42
local LEAP_ARC_HEIGHT = 760
local IMPACT_RADIUS = 260
local IMPACT_STUN_DURATION = 0.45
local FISSURE_PRE_DELAY = 0.28
local FISSURE_DISTANCE = 1000
local FISSURE_DURATION = 5
local FISSURE_MOVE_DURATION = 0.4
local FISSURE_KNOCKBACK_DURATION = FISSURE_MOVE_DURATION
local FISSURE_KNOCKBACK_DISTANCE = FISSURE_DISTANCE
local SCREEN_SHAKE_AMPLITUDE = 12
local SCREEN_SHAKE_FREQUENCY = 12
local SCREEN_SHAKE_DURATION = 0.22
local SCREEN_SHAKE_RADIUS = 1800
local FISSURE_PARTICLE = "particles/monster/earthshaker_fissure.vpcf"
local TOTEM_CAST_PARTICLE = "particles/units/heroes/hero_earthshaker/earthshaker_totem_cast.vpcf"
local KNOCKBACK_STATUS_PARTICLE =
	"particles/econ/items/windrunner/windranger_arcana/windranger_arcana_item_force_staff_v2.vpcf"
local EARTHSHAKER_SOUND_EVENTS = "soundevents/game_sounds_heroes/game_sounds_earthshaker.vsndevts"
local TOTEM_SOUND = "Hero_EarthShaker.Totem"
local TOTEM_ATTACK_SOUND = "Hero_EarthShaker.Totem.Attack"
local FISSURE_SOUND = "Hero_EarthShaker.Fissure"
____exports.elite_310 = __TS__Class()
local elite_310 = ____exports.elite_310
elite_310.name = "elite_310"
__TS__ClassExtends(elite_310, MonsterAbility_CS)
function elite_310.prototype.____constructor(self, ...)
	MonsterAbility_CS.prototype.____constructor(self, ...)
	self.castToken = 0
end
function elite_310.prototype.Precache(self, context)
	PrecacheResource("particle", FISSURE_PARTICLE, context)
	PrecacheResource("particle", TOTEM_CAST_PARTICLE, context)
	PrecacheResource("particle", KNOCKBACK_STATUS_PARTICLE, context)
	PrecacheResource("soundfile", EARTHSHAKER_SOUND_EVENTS, context)
end
function elite_310.prototype.GetMosnterAbilityConfig(self)
	return {
		castRange = CAST_RANGE,
		behavior = DOTA_ABILITY_BEHAVIOR_NO_TARGET,
		castPoint = CAST_POINT,
		castDuration = CAST_DURATION,
		castAnimation = ACT_DOTA_CAST_ABILITY_2,
		cooldown = 12,
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
			return self:PrepareSlam()
		end,
		OnStart = function()
			return self:StartSlam()
		end,
		OnInterrupt = function()
			return self:CancelSlam()
		end,
		OnFinish = function()
			return self:ClearPreparedSlam()
		end,
	}
end
function elite_310.prototype.PrepareSlam(self)
	local caster = self:GetCaster()
	if not IsValidAlive(nil, caster) then
		return
	end
	local target = self:FindTarget()
	if not IsValidAlive(nil, target) then
		self.prepared = nil
		return
	end
	local landingPoint = GetGroundPosition(target:GetAbsOrigin(), caster)
	local direction = self:FlatDirection(landingPoint:__sub(caster:GetAbsOrigin()))
	self.prepared = { landingPoint = landingPoint, direction = direction }
	caster:LockTargetForSpeed(target, CAST_POINT, 8)
	caster:SetForwardVectorWithoutInterrupt(direction)
	self:WarningRingEffect(landingPoint, IMPACT_RADIUS, CAST_POINT + LEAP_DURATION)
end
function elite_310.prototype.StartSlam(self)
	local caster = self:GetCaster()
	if not IsValidAlive(nil, caster) then
		return
	end
	local prepared = self.prepared
	self.prepared = nil
	if not prepared then
		return
	end
	self.castToken = self.castToken + 1
	local token = self.castToken
	local start = GetGroundPosition(caster:GetAbsOrigin(), caster)
	local landingPoint = GetGroundPosition(prepared.landingPoint, caster)
	local direction = self:FlatDirection(prepared.direction)
	local peak = self:ResolveLeapPeak(start, landingPoint)
	caster:SetForwardVectorWithoutInterrupt(direction)
	caster:StartGestureWithFadeAndPlaybackRate(ACT_DOTA_CAST_ABILITY_2, 0.03, 0.12, 1.15)
	EmitSoundOn(TOTEM_SOUND, caster)
	caster:Bezier2Mover({ start, peak, landingPoint }, LEAP_DURATION, nil, true, true)
	self:Timer(LEAP_DURATION, function()
		if token ~= self.castToken or not IsValidAlive(nil, caster) then
			return
		end
		FindClearSpaceForUnit(caster, landingPoint, true)
		if not IsValidAlive(nil, caster) then
			return
		end
		self:ApplyImpact(caster, landingPoint, direction, token)
	end)
end
function elite_310.prototype.ApplyImpact(self, caster, landingPoint, direction, token)
	if not IsValidAlive(nil, caster) then
		return
	end
	self:PlayTotemCastEffect(caster, landingPoint)
	self:PlayScreenShake(landingPoint)
	EmitSoundOnLocationWithCaster(landingPoint, TOTEM_ATTACK_SOUND, caster)
	local enemies = self:FindEnemiesInRadius(caster, landingPoint, IMPACT_RADIUS)
	if #enemies <= 0 then
		self:DestroyDuration()
		return
	end
	for ____, enemy in ipairs(enemies) do
		do
			if not IsValidAlive(nil, caster) then
				return
			end
			if not IsValidAlive(nil, enemy) then
				goto __continue21
			end
			AddDeBuffStatus(nil, enemy, caster, self, DebuffStatusType.STUN, { duration = IMPACT_STUN_DURATION })
		end
		::__continue21::
	end
	self:StartFissureFollowUp(caster, landingPoint, direction, enemies, token)
end
function elite_310.prototype.StartFissureFollowUp(self, caster, landingPoint, direction, enemies, token)
	if not IsValidAlive(nil, caster) then
		return
	end
	caster:SetForwardVectorWithoutInterrupt(direction)
	caster:StartGestureWithFadeAndPlaybackRate(ACT_DOTA_CAST_ABILITY_1, 0.03, 0.15, 1.2)
	self:Timer(FISSURE_PRE_DELAY, function()
		if token ~= self.castToken or not IsValidAlive(nil, caster) then
			return
		end
		self:ReleaseFissure(caster, landingPoint, enemies, direction)
	end)
end
function elite_310.prototype.ReleaseFissure(self, caster, landingPoint, enemies, direction)
	if not IsValidAlive(nil, caster) then
		return
	end
	EmitSoundOnLocationWithCaster(landingPoint, FISSURE_SOUND, caster)
	for ____, enemy in ipairs(enemies) do
		do
			if not IsValidAlive(nil, caster) then
				return
			end
			if not IsValidAlive(nil, enemy) then
				goto __continue31
			end
			local fissureDirection = self:GetFissureDirectionForTarget(caster, enemy, direction)
			local fissureStart = GetGroundPosition(enemy:GetAbsOrigin(), enemy)
			self:PlayFissureEffect(caster, fissureStart, fissureDirection)
			self:KnockEnemyByFissure(caster, enemy, fissureDirection)
		end
		::__continue31::
	end
end
function elite_310.prototype.KnockEnemyByFissure(self, caster, enemy, direction)
	if not IsValidAlive(nil, caster) or not IsValidAlive(nil, enemy) then
		return
	end
	enemy:KnockBack(caster, self, {
		duration = FISSURE_KNOCKBACK_DURATION,
		distance = FISSURE_KNOCKBACK_DISTANCE,
		height = 0,
		direction = direction,
		particleName = KNOCKBACK_STATUS_PARTICLE,
	})
end
function elite_310.prototype.GetFissureDirectionForTarget(self, caster, enemy, fallbackDirection)
	local casterOrigin = GetGroundPosition(caster:GetAbsOrigin(), caster)
	if not IsValidAlive(nil, enemy) then
		return fallbackDirection
	end
	local enemyOrigin = GetGroundPosition(enemy:GetAbsOrigin(), enemy)
	local direction = enemyOrigin:__sub(casterOrigin)
	if direction:Length2D() <= 0.001 then
		return fallbackDirection
	end
	return self:FlatDirection(direction)
end
function elite_310.prototype.CancelSlam(self)
	self.castToken = self.castToken + 1
	self:ClearPreparedSlam()
end
function elite_310.prototype.ClearPreparedSlam(self)
	self.prepared = nil
end
function elite_310.prototype.FindTarget(self)
	local caster = self:GetCaster()
	if not IsValidAlive(nil, caster) then
		return nil
	end
	return caster:GetMinDistanceUnit(CAST_RANGE)
end
function elite_310.prototype.FindEnemiesInRadius(self, caster, origin, radius)
	return FindUnitsInRadius(
		caster:GetTeamNumber(),
		origin,
		nil,
		radius,
		DOTA_UNIT_TARGET_TEAM_ENEMY,
		DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,
		DOTA_UNIT_TARGET_FLAG_NONE,
		FIND_ANY_ORDER,
		false
	)
end
function elite_310.prototype.ResolveLeapPeak(self, start, landingPoint)
	local middle = start:__add(landingPoint):__mul(0.5)
	return Vector(middle.x, middle.y, math.max(start.z, landingPoint.z) + LEAP_ARC_HEIGHT)
end
function elite_310.prototype.PlayTotemCastEffect(self, caster, origin)
	local particle = ParticleManager:CreateParticle(TOTEM_CAST_PARTICLE, PATTACH_WORLDORIGIN, caster)
	ParticleManager:SetParticleControl(particle, 0, origin)
	ParticleManager:SetParticleControl(particle, 1, Vector(IMPACT_RADIUS, IMPACT_RADIUS, 0))
	ParticleManager:ReleaseParticleIndex(particle)
end
function elite_310.prototype.PlayFissureEffect(self, caster, start, direction)
	local ____end = GetGroundPosition(start:__add(direction:__mul(FISSURE_DISTANCE)), caster)
	local particle = ParticleManager:CreateParticle(FISSURE_PARTICLE, PATTACH_WORLDORIGIN, caster)
	ParticleManager:SetParticleControl(particle, 0, start)
	ParticleManager:SetParticleControl(particle, 1, ____end)
	ParticleManager:SetParticleControl(particle, 2, Vector(FISSURE_DURATION, 0, 0))
	ParticleManager:SetParticleControlForward(particle, 0, direction)
	ParticleManager:ReleaseParticleIndex(particle)
end
function elite_310.prototype.PlayScreenShake(self, point)
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
function elite_310.prototype.FlatDirection(self, direction)
	local flat = Vector(direction.x, direction.y, 0)
	local length = flat:Length2D()
	if length <= 0.001 then
		return Vector(1, 0, 0)
	end
	return flat:__mul(1 / length)
end
elite_310 = __TS__DecorateLegacy({ registerAbility(nil) }, elite_310)
____exports.elite_310 = elite_310
return ____exports