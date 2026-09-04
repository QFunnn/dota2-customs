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
local CAST_RANGE = 1200
local CAST_POINT = 0.55
local WAVE_INTERVAL = 1
local WARNING_DURATION = 1
local FEAST_WAVE_POINT_COUNTS = {
	3,
	4,
	5,
	6,
	7,
}
local CAST_DURATION = WARNING_DURATION + WAVE_INTERVAL * (#FEAST_WAVE_POINT_COUNTS - 1)
local FEAST_POINT_MIN_DISTANCE = 360
local FEAST_POINT_MAX_DISTANCE = 720
local FEAST_RADIUS = 240
local FEAST_POINT_MIN_SEPARATION = FEAST_RADIUS * 2 + 40
local FEAST_POINT_SEARCH_ATTEMPTS = 24
local DAMAGE_RATE = 25
local HEAL_MAX_HEALTH_PCT = 12
local CAST_PARTICLE = "particles/bane_fiends_grip.vpcf"
local HIT_PARTICLE = "particles/units/heroes/hero_bane/bane_sap.vpcf"
local BANE_SOUND_EVENTS = "soundevents/game_sounds_heroes/game_sounds_bane.vsndevts"
local CAST_SOUND = "Hero_Bane.Projection"
local WAVE_SOUND = "Hero_Bane.Nightmare"
local IMPACT_SOUND = "Hero_Bane.BrainSap.Target"
--- 精英技能112 - 盛宴啃噬：随机预警三个啃噬点，未逃出范围的敌人受到大伤害并为自身回血
____exports.elite_112 = __TS__Class()
local elite_112 = ____exports.elite_112
elite_112.name = "elite_112"
__TS__ClassExtends(elite_112, MonsterAbility_CS)
function elite_112.prototype.____constructor(self, ...)
	MonsterAbility_CS.prototype.____constructor(self, ...)
	self.targetEnemy = nil
end
function elite_112.prototype.Precache(self, context)
	PrecacheResource("particle", CAST_PARTICLE, context)
	PrecacheResource("particle", HIT_PARTICLE, context)
	PrecacheResource("soundfile", BANE_SOUND_EVENTS, context)
end
function elite_112.prototype.GetMosnterAbilityConfig(self)
	return {
		behavior = DOTA_ABILITY_BEHAVIOR_NO_TARGET,
		castRange = CAST_RANGE,
		castPoint = CAST_POINT,
		castDuration = CAST_DURATION,
		castAnimation = ACT_DOTA_CAST_ABILITY_4,
		canCast = function()
			local caster = self:GetCaster()
			local ____temp_0
			if IsValidAlive(nil, caster) and IsValidAlive(nil, self:FindNearestEnemy(caster)) then
				____temp_0 = UF_SUCCESS
			else
				____temp_0 = UF_FAIL_CUSTOM
			end
			return ____temp_0
		end,
		OnPhaseStart = function()
			local caster = self:GetCaster()
			if not IsValidAlive(nil, caster) then
				return
			end
			local target = self:FindNearestEnemy(caster)
			local ____IsValidAlive_result_1
			if IsValidAlive(nil, target) then
				____IsValidAlive_result_1 = target
			else
				____IsValidAlive_result_1 = nil
			end
			self.targetEnemy = ____IsValidAlive_result_1
			if self.targetEnemy then
				caster:LockTargetForSpeed(self.targetEnemy, CAST_POINT)
			end
		end,
		OnInterrupt = function()
			self.targetEnemy = nil
		end,
		OnStart = function()
			local caster = self:GetCaster()
			local target = self.targetEnemy or self:FindNearestEnemy(caster)
			self.targetEnemy = nil
			if not IsValidAlive(nil, caster) or not IsValidAlive(nil, target) then
				return
			end
			EmitSoundOn(CAST_SOUND, caster)
			self:StartFeastWaves(caster, target)
		end,
	}
end
function elite_112.prototype.FindNearestEnemy(self, caster)
	return caster:GetMinDistanceUnit(CAST_RANGE)
end
function elite_112.prototype.ExecuteFeast(self, caster, points)
	if not IsValidAlive(nil, caster) then
		return
	end
	local hitRecord = {}
	local hitCount = 0
	for ____, point in ipairs(points) do
		local enemies = FindUnitsInRadius(
			caster:GetTeamNumber(),
			point,
			nil,
			FEAST_RADIUS,
			DOTA_UNIT_TARGET_TEAM_ENEMY,
			DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,
			DOTA_UNIT_TARGET_FLAG_NONE,
			FIND_CLOSEST,
			false
		)
		for ____, enemy in ipairs(enemies) do
			do
				if not IsValidAlive(nil, enemy) then
					goto __continue15
				end
				local index = enemy:entindex()
				if hitRecord[index] then
					goto __continue15
				end
				hitRecord[index] = true
				hitCount = hitCount + 1
				caster:MonsterDamage({ victim = enemy, damage_rate = DAMAGE_RATE, ability = self })
				self:PlayHitEffects(caster, enemy)
			end
			::__continue15::
		end
	end
	if hitCount <= 0 then
		return
	end
	local healAmount = caster:GetMaxHealth() * (HEAL_MAX_HEALTH_PCT / 100)
	caster:CustomHeal(healAmount, { ability = self, source = "spell" })
end
function elite_112.prototype.StartFeastWaves(self, caster, target)
	local trackingState = { lastCenter = GetGroundPosition(target:GetAbsOrigin(), caster) }
	local delay = 0
	for ____, pointCount in ipairs(FEAST_WAVE_POINT_COUNTS) do
		local currentPointCount = pointCount
		local currentDelay = delay
		self:Timer(currentDelay, function()
			return self:CreateFeastWave(caster, target, trackingState, currentPointCount)
		end)
		delay = delay + WAVE_INTERVAL
	end
end
function elite_112.prototype.CreateFeastWave(self, caster, target, trackingState, pointCount)
	if not IsValidAlive(nil, caster) then
		return
	end
	if IsValidAlive(nil, target) then
		trackingState.lastCenter = GetGroundPosition(target:GetAbsOrigin(), caster)
	end
	local center = trackingState.lastCenter
	EmitSoundOn(WAVE_SOUND, caster)
	local feastPoints = self:CreateFeastWarnings(caster, center, pointCount)
	caster:StartGestureWithPlaybackRate(ACT_DOTA_CAST_ABILITY_3, 1)
	self:Timer(WARNING_DURATION, function()
		return self:ExecuteFeast(caster, feastPoints)
	end)
end
function elite_112.prototype.CreateFeastWarnings(self, caster, center, pointCount)
	local points = self:BuildFeastPoints(caster, center, pointCount)
	for ____, point in ipairs(points) do
		local currentPoint = point
		self:WarningRingEffect(currentPoint, FEAST_RADIUS, WARNING_DURATION)
		EmitSoundOnLocationWithCaster(currentPoint, WAVE_SOUND, caster)
		self:Timer(WARNING_DURATION, function()
			self:PlayCastParticleAtPoint(caster, currentPoint)
			EmitSoundOnLocationWithCaster(currentPoint, CAST_SOUND, caster)
		end)
	end
	self:Timer(WARNING_DURATION, function()
		ScreenShake(caster:GetAbsOrigin(), 12, 12, 0.2, 3200, 0, true)
	end)
	return points
end
function elite_112.prototype.BuildFeastPoints(self, caster, center, pointCount)
	local points = { GetGroundPosition(center, caster) }
	local startAngle = RandomFloat(0, 360)
	local randomPointCount = math.max(0, pointCount - 1)
	local sectorAngle = 360 / math.max(1, randomPointCount)
	do
		local i = 0
		while i < randomPointCount do
			local point = self:FindFeastPoint(caster, center, points, startAngle + sectorAngle * i, sectorAngle)
			points[#points + 1] = point
			i = i + 1
		end
	end
	return points
end
function elite_112.prototype.FindFeastPoint(self, caster, center, selectedPoints, baseAngle, sectorAngle)
	local fallbackPoint
	local fallbackDistance = -1
	do
		local i = 0
		while i < FEAST_POINT_SEARCH_ATTEMPTS do
			do
				local useSector = i < FEAST_POINT_SEARCH_ATTEMPTS * 0.75
				local ____useSector_2
				if useSector then
					____useSector_2 = baseAngle + RandomFloat(-sectorAngle * 0.34, sectorAngle * 0.34)
				else
					____useSector_2 = RandomFloat(0, 360)
				end
				local angle = ____useSector_2
				local distance = RandomFloat(FEAST_POINT_MIN_DISTANCE, FEAST_POINT_MAX_DISTANCE)
				local offset = RotateVector2D(nil, Vector(1, 0, 0), angle):__mul(distance)
				local candidate = center:__add(offset)
				local point = GetGroundPosition(candidate, caster)
				if not IsGridNavDisplacementWalkable(nil, point) then
					goto __continue37
				end
				local nearestDistance = self:GetNearestFeastPointDistance(point, selectedPoints)
				if nearestDistance >= FEAST_POINT_MIN_SEPARATION then
					return point
				end
				if not fallbackPoint or nearestDistance > fallbackDistance then
					fallbackPoint = point
					fallbackDistance = nearestDistance
				end
			end
			::__continue37::
			i = i + 1
		end
	end
	return fallbackPoint or GetGroundPosition(center, caster)
end
function elite_112.prototype.GetNearestFeastPointDistance(self, point, selectedPoints)
	if #selectedPoints <= 0 then
		return FEAST_POINT_MIN_SEPARATION
	end
	local nearestDistance = 99999
	for ____, selectedPoint in ipairs(selectedPoints) do
		local distance = point:__sub(selectedPoint):Length2D()
		if distance < nearestDistance then
			nearestDistance = distance
		end
	end
	return nearestDistance
end
function elite_112.prototype.PlayCastParticleAtPoint(self, caster, point)
	local pfx = ParticleManager:CreateParticle(CAST_PARTICLE, PATTACH_WORLDORIGIN, nil)
	ParticleManager:SetParticleControl(pfx, 0, point)
	Timers:CreateTimer(WARNING_DURATION, function()
		ParticleManager:DestroyParticle(pfx, false)
		ParticleManager:ReleaseParticleIndex(pfx)
	end)
end
function elite_112.prototype.PlayHitEffects(self, caster, enemy)
	if not IsValidAlive(nil, enemy) then
		return
	end
	EmitSoundOn(IMPACT_SOUND, enemy)
	local pfx = ParticleManager:CreateParticle(HIT_PARTICLE, PATTACH_ABSORIGIN_FOLLOW, caster)
	ParticleManager:SetParticleControlEnt(
		pfx,
		0,
		caster,
		PATTACH_ABSORIGIN_FOLLOW,
		"attach_hitloc",
		caster:GetAbsOrigin(),
		true
	)
	ParticleManager:SetParticleControlEnt(
		pfx,
		1,
		enemy,
		PATTACH_ABSORIGIN_FOLLOW,
		"attach_hitloc",
		enemy:GetAbsOrigin(),
		true
	)
	ParticleManager:ReleaseParticleIndex(pfx)
	ScreenShake(enemy:GetAbsOrigin(), 12, 12, 0.2, 1200, 0, true)
end
elite_112 = __TS__DecorateLegacy({ registerAbility(nil) }, elite_112)
____exports.elite_112 = elite_112
return ____exports