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
local STRIKE_PARTICLE = "particles/units/heroes/hero_zeus/zeus_cloud_strike.vpcf"
local STRIKE_CAST_PARTICLE = "particles/units/heroes/hero_zuus/zuus_shard_head.vpcf"
local STRIKE_ROUND_DURATION = 1.5
local STRIKE_CAST_EFFECT_DELAY = 0.4
local STRIKE_K_POINT = 0.65
local STRIKE_COUNT = 3
local STRIKE_END_BUFFER = 0.2
local STRIKE_TOTAL_DURATION = STRIKE_ROUND_DURATION * (STRIKE_COUNT - 1)
	+ STRIKE_CAST_EFFECT_DELAY
	+ STRIKE_K_POINT
	+ STRIKE_END_BUFFER
	+ 0.2
local STRIKE_RADIUS = 223
local STRIKES_PER_ROUND = 2
local STRIKE_MIN_DISTANCE = 250
local STRIKE_POSITION_RETRY_COUNT = 12
local TARGET_OFFSET_DISTANCE = 250
local DAMAGE_RATE = 25
local STUN_DURATION = 0.3
local SEARCH_RANGE = 1500
local LIGHTNING_SOUND_EVENTS = "soundevents/game_sounds_heroes/game_sounds_zuus.vsndevts"
local LIGHTNING_CAST_SOUND = "Hero_Zuus.LightningBolt.Cast"
local LIGHTNING_IMPACT_SOUND = "Hero_Zuus.LightningBolt"
local FACE_LOCK_KEY = "elite_129_face_lock_timer"
local CAST_SOUND_LOCK_KEY = "elite_129_cast_sound_lock_until"
local FACE_LOCK_ROTATION_SPEED = 5 * 30
--- 精英技能 51 - 落雷风暴
--
-- 释放后按轮次产生落雷，持续时间覆盖最后一次动作、预警、命中和收尾，避免末尾调度被提前截断。
____exports.elite_129 = __TS__Class()
local elite_129 = ____exports.elite_129
elite_129.name = "elite_129"
__TS__ClassExtends(elite_129, MonsterAbility_CS)
function elite_129.prototype.____constructor(self, ...)
	MonsterAbility_CS.prototype.____constructor(self, ...)
	self.stormToken = 0
end
function elite_129.prototype.Precache(self, context)
	PrecacheResource("particle", STRIKE_PARTICLE, context)
	PrecacheResource("particle", STRIKE_CAST_PARTICLE, context)
	PrecacheResource("soundfile", LIGHTNING_SOUND_EVENTS, context)
end
function elite_129.prototype.GetMosnterAbilityConfig(self)
	return {
		behavior = DOTA_ABILITY_BEHAVIOR_NO_TARGET,
		castPoint = 0.3,
		castRange = 1000,
		castDuration = STRIKE_TOTAL_DURATION,
		OnStart = function()
			local caster = self:GetCaster()
			if not IsValidAlive(nil, caster) then
				return
			end
			self:StartLightningStorm(caster)
			self:PlayCastSound(caster)
		end,
		OnInterrupt = function()
			return self:StopLightningStorm(true)
		end,
		OnFinish = function()
			return self:StopLightningStorm(true)
		end,
	}
end
function elite_129.prototype.StartLightningStorm(self, caster)
	self:StopLightningStorm(false)
	self.stormToken = self.stormToken + 1
	local token = self.stormToken
	do
		local index = 0
		while index < STRIKE_COUNT do
			self:Timer(index * STRIKE_ROUND_DURATION, function()
				self:SpawnLightningRound(caster, token)
				caster:StopSound(LIGHTNING_CAST_SOUND)
			end)
			index = index + 1
		end
	end
end
function elite_129.prototype.StopLightningStorm(self, lockCastSound)
	self.stormToken = self.stormToken + 1
	local caster = self:GetCaster()
	if not caster or caster:IsNull() then
		return
	end
	self:ClearFacingLock(caster)
	caster:StopSound(LIGHTNING_CAST_SOUND)
	if lockCastSound then
		caster:SetCustomValue(CAST_SOUND_LOCK_KEY, GameRules:GetGameTime() + 0.8)
	end
end
function elite_129.prototype.SpawnLightningRound(self, caster, token)
	if not self:IsStormTokenValid(token) or not IsValidAlive(nil, caster) then
		self:ClearFacingLock(caster)
		return
	end
	local targetPositions = self:GetStrikeTargetPositions(caster)
	local facingPos = self:GetStrikeFacingPosition(targetPositions)
	self:LockCasterFacingPoint(caster, facingPos, STRIKE_ROUND_DURATION)
	self:PlayStrikeGesture(caster)
	self:Timer(STRIKE_CAST_EFFECT_DELAY, function()
		if not self:IsStormTokenValid(token) or not IsValidAlive(nil, caster) then
			return
		end
		self:PlayCastEffect(caster)
		self:WarningStrikePoints(targetPositions)
		self:Timer(STRIKE_K_POINT, function()
			if not self:IsStormTokenValid(token) then
				return
			end
			self:StrikeAtPoints(caster, targetPositions)
		end)
	end)
end
function elite_129.prototype.GetStrikeTargetPositions(self, caster)
	local firstPos = self:GetStrikeTargetPosition(caster)
	local positions = { firstPos }
	do
		local index = 1
		while index < STRIKES_PER_ROUND do
			positions[#positions + 1] = self:GetSeparatedStrikePosition(caster, firstPos)
			index = index + 1
		end
	end
	return positions
end
function elite_129.prototype.GetSeparatedStrikePosition(self, caster, basePos)
	do
		local attempt = 0
		while attempt < STRIKE_POSITION_RETRY_COUNT do
			local candidatePos = self:GetStrikeTargetPosition(caster)
			if self:GetPointDistance2D(basePos, candidatePos) >= (math.random() + 0.5) * STRIKE_MIN_DISTANCE then
				return candidatePos
			end
			attempt = attempt + 1
		end
	end
	local angle = RandomFloat(0, 2 * math.pi)
	local fallbackPos = basePos:__add(Vector(math.cos(angle), math.sin(angle), 0):__mul(STRIKE_MIN_DISTANCE))
	return GetGroundPosition(fallbackPos, caster)
end
function elite_129.prototype.GetPointDistance2D(self, a, b)
	local dx = a.x - b.x
	local dy = a.y - b.y
	return math.sqrt(dx * dx + dy * dy)
end
function elite_129.prototype.GetStrikeFacingPosition(self, targetPositions)
	if #targetPositions <= 1 then
		return targetPositions[1]
	end
	local x = 0
	local y = 0
	local z = 0
	for ____, targetPos in ipairs(targetPositions) do
		x = x + targetPos.x
		y = y + targetPos.y
		z = z + targetPos.z
	end
	return Vector(x / #targetPositions, y / #targetPositions, z / #targetPositions)
end
function elite_129.prototype.WarningStrikePoints(self, targetPositions)
	for ____, targetPos in ipairs(targetPositions) do
		self:WarningRingEffect(targetPos, STRIKE_RADIUS, STRIKE_K_POINT)
	end
end
function elite_129.prototype.StrikeAtPoints(self, caster, targetPositions)
	for ____, targetPos in ipairs(targetPositions) do
		self:StrikeAtPoint(caster, targetPos)
	end
end
function elite_129.prototype.GetStrikeTargetPosition(self, caster)
	local enemies = FindUnitsInRadius(
		caster:GetTeamNumber(),
		caster:GetAbsOrigin(),
		nil,
		SEARCH_RANGE,
		DOTA_UNIT_TARGET_TEAM_ENEMY,
		DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,
		DOTA_UNIT_TARGET_FLAG_NONE,
		FIND_ANY_ORDER,
		false
	)
	if #enemies > 0 then
		local enemy = enemies[RandomInt(0, #enemies - 1) + 1]
		if IsValidAlive(nil, enemy) then
			local targetPos = enemy:GetAbsOrigin():__add(RandomVector((math.random() + 0.5) * TARGET_OFFSET_DISTANCE))
			return GetGroundPosition(targetPos, caster)
		end
	end
	local angle = RandomFloat(0, 2 * math.pi)
	local dist = RandomFloat(200, 600)
	local fallbackPos = caster:GetAbsOrigin():__add(Vector(math.cos(angle), math.sin(angle), 0):__mul(dist))
	return GetGroundPosition(fallbackPos, caster)
end
function elite_129.prototype.PlayStrikeGesture(self, caster)
	caster:RemoveGesture(ACT_DOTA_ATTACK)
	caster:StartGestureWithFadeAndPlaybackRate(ACT_DOTA_ATTACK, 0.05, 0.2, 0.8)
end
function elite_129.prototype.PlayCastEffect(self, caster)
	local pfx = ParticleManager:CreateParticle(STRIKE_CAST_PARTICLE, PATTACH_POINT_FOLLOW, caster)
	ParticleManager:SetParticleControlEnt(
		pfx,
		0,
		caster,
		PATTACH_POINT_FOLLOW,
		"attach_hitloc",
		caster:GetAbsOrigin(),
		true
	)
	ParticleManager:SetParticleControlEnt(
		pfx,
		1,
		caster,
		PATTACH_POINT_FOLLOW,
		"attach_attack1",
		caster:GetAbsOrigin(),
		true
	)
	ParticleManager:SetParticleControlEnt(
		pfx,
		2,
		caster,
		PATTACH_POINT_FOLLOW,
		"attach_attack1",
		caster:GetAbsOrigin(),
		true
	)
	ParticleManager:ReleaseParticleIndex(pfx)
end
function elite_129.prototype.PlayCastSound(self, caster)
	local lockUntil = caster:GetCustomValue(CAST_SOUND_LOCK_KEY) or 0
	if GameRules:GetGameTime() < lockUntil then
		return
	end
	caster:StopSound(LIGHTNING_CAST_SOUND)
	caster:EmitSound(LIGHTNING_CAST_SOUND)
end
function elite_129.prototype.StrikeAtPoint(self, caster, targetPos)
	if not IsValidAlive(nil, caster) or self:IsNull() then
		return
	end
	local pfx = ParticleManager:CreateParticle(STRIKE_PARTICLE, PATTACH_WORLDORIGIN, nil)
	ParticleManager:SetParticleControl(pfx, 0, targetPos:__add(Vector(0, 0, 900)))
	ParticleManager:SetParticleControl(pfx, 1, targetPos)
	ParticleManager:ReleaseParticleIndex(pfx)
	EmitSoundOnLocationWithCaster(targetPos, LIGHTNING_IMPACT_SOUND, caster)
	local hitEnemies = FindUnitsInRadius(
		caster:GetTeamNumber(),
		targetPos,
		nil,
		STRIKE_RADIUS,
		DOTA_UNIT_TARGET_TEAM_ENEMY,
		DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,
		DOTA_UNIT_TARGET_FLAG_NONE,
		FIND_ANY_ORDER,
		false
	)
	for ____, enemy in ipairs(hitEnemies) do
		do
			if not IsValidAlive(nil, enemy) then
				goto __continue45
			end
			caster:MonsterDamage({ victim = enemy, damage_rate = DAMAGE_RATE, ability = self })
			AddDeBuffStatus(nil, enemy, caster, self, DebuffStatusType.STUN, { duration = STUN_DURATION })
		end
		::__continue45::
	end
end
function elite_129.prototype.LockCasterFacingPoint(self, caster, targetPos, duration)
	self:ClearFacingLock(caster)
	local frameInterval = FrameTime()
	local id = Timers:CreateTimer(0, function()
		if not IsValidAlive(nil, caster) or self:IsNull() then
			return
		end
		local origin = caster:GetOrigin()
		local rawDirection = targetPos:__sub(origin)
		if rawDirection:Length2D() <= 1 then
			return
		end
		local directionToPoint = Vector(rawDirection.x, rawDirection.y, 0):Normalized()
		local current = caster:GetForwardVector()
		local cross = current.x * directionToPoint.y - current.y * directionToPoint.x
		local dot = current.x * directionToPoint.x + current.y * directionToPoint.y
		local deltaDeg = math.atan2(cross, dot) * 180 / math.pi
		local stepDeg = math.max(
			-FACE_LOCK_ROTATION_SPEED * frameInterval,
			math.min(FACE_LOCK_ROTATION_SPEED * frameInterval, deltaDeg)
		)
		local newForward = RotateVector2D(nil, current, stepDeg)
		caster:SetForwardVector(Vector(newForward.x, newForward.y, 0))
		duration = duration - frameInterval
		local ____temp_0
		if duration > 0 then
			____temp_0 = frameInterval
		else
			____temp_0 = nil
		end
		return ____temp_0
	end)
	caster:SetCustomValue(FACE_LOCK_KEY, id)
end
function elite_129.prototype.ClearFacingLock(self, caster)
	local oldTimer = caster:GetCustomValue(FACE_LOCK_KEY)
	if not oldTimer then
		return
	end
	Timers:RemoveTimer(oldTimer)
	caster:SetCustomValue(FACE_LOCK_KEY, nil)
end
function elite_129.prototype.IsStormTokenValid(self, token)
	return token == self.stormToken and not self:IsNull()
end
elite_129 = __TS__DecorateLegacy({ registerAbility(nil) }, elite_129)
____exports.elite_129 = elite_129
return ____exports