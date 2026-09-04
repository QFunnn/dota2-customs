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
local STRIKE_CAST_EFFECT_DELAY = 0.5
local STRIKE_K_POINT = 0.6
local STRIKE_COUNT = 3
local STRIKE_END_BUFFER = 0.2
local STRIKE_TOTAL_DURATION = STRIKE_ROUND_DURATION * (STRIKE_COUNT - 1)
	+ STRIKE_CAST_EFFECT_DELAY
	+ STRIKE_K_POINT
	+ STRIKE_END_BUFFER
	+ 0.2
local STRIKE_RADIUS = 253
local STRIKE_RADIUS_GROWTH_RATE = 0.2
local TARGET_OFFSET_DISTANCE = 120
local DAMAGE_RATE = 25
local STUN_DURATION = 0.3
local SEARCH_RANGE = 1500
local LIGHTNING_SOUND_EVENTS = "soundevents/game_sounds_heroes/game_sounds_zuus.vsndevts"
local LIGHTNING_CAST_SOUND = "Hero_Zuus.LightningBolt.Cast"
local LIGHTNING_IMPACT_SOUND = "Hero_Zuus.LightningBolt"
local FACE_LOCK_KEY = "elite_051_face_lock_timer"
local CAST_SOUND_LOCK_KEY = "elite_051_cast_sound_lock_until"
local FACE_LOCK_ROTATION_SPEED = 4 * 30
--- 精英技能 51 - 落雷风暴
--
-- 释放后按轮次产生落雷，持续时间覆盖最后一次动作、预警、命中和收尾，避免末尾调度被提前截断。
____exports.elite_051 = __TS__Class()
local elite_051 = ____exports.elite_051
elite_051.name = "elite_051"
__TS__ClassExtends(elite_051, MonsterAbility_CS)
function elite_051.prototype.____constructor(self, ...)
	MonsterAbility_CS.prototype.____constructor(self, ...)
	self.stormToken = 0
end
function elite_051.prototype.Precache(self, context)
	PrecacheResource("particle", STRIKE_PARTICLE, context)
	PrecacheResource("particle", STRIKE_CAST_PARTICLE, context)
	PrecacheResource("soundfile", LIGHTNING_SOUND_EVENTS, context)
end
function elite_051.prototype.GetMosnterAbilityConfig(self)
	return {
		behavior = DOTA_ABILITY_BEHAVIOR_NO_TARGET,
		castPoint = 0.3,
		castRange = function()
			if IsServer() then
				return self:GetCaster():GetAcquisitionRange()
			end
			return 1200
		end,
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
function elite_051.prototype.StartLightningStorm(self, caster)
	self:StopLightningStorm(false)
	self.stormToken = self.stormToken + 1
	local token = self.stormToken
	do
		local index = 0
		while index < STRIKE_COUNT do
			local currentIndex = index
			local currentDelay = currentIndex * STRIKE_ROUND_DURATION
			self:Timer(currentDelay, function()
				self:SpawnLightningRound(caster, token, currentIndex)
				caster:StopSound(LIGHTNING_CAST_SOUND)
			end)
			index = index + 1
		end
	end
end
function elite_051.prototype.StopLightningStorm(self, lockCastSound)
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
function elite_051.prototype.SpawnLightningRound(self, caster, token, roundIndex)
	if not self:IsStormTokenValid(token) or not IsValidAlive(nil, caster) then
		self:ClearFacingLock(caster)
		return
	end
	local targetPos = self:GetStrikeTargetPosition(caster)
	local strikeRadius = self:GetStrikeRadius(roundIndex)
	self:LockCasterFacingPoint(caster, targetPos, STRIKE_ROUND_DURATION)
	self:PlayStrikeGesture(caster)
	self:Timer(STRIKE_CAST_EFFECT_DELAY, function()
		if not self:IsStormTokenValid(token) or not IsValidAlive(nil, caster) then
			return
		end
		self:PlayCastEffect(caster)
		self:WarningRingEffect(targetPos, strikeRadius, STRIKE_K_POINT)
		self:Timer(STRIKE_K_POINT, function()
			if not self:IsStormTokenValid(token) then
				return
			end
			self:StrikeAtPoint(caster, targetPos, strikeRadius)
		end)
	end)
end
function elite_051.prototype.GetStrikeRadius(self, roundIndex)
	return STRIKE_RADIUS * (1 + roundIndex * STRIKE_RADIUS_GROWTH_RATE)
end
function elite_051.prototype.GetStrikeTargetPosition(self, caster)
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
			local targetPos = enemy:GetAbsOrigin():__add(RandomVector(TARGET_OFFSET_DISTANCE))
			return GetGroundPosition(targetPos, caster)
		end
	end
	local angle = RandomFloat(0, 2 * math.pi)
	local dist = RandomFloat(200, 600)
	local fallbackPos = caster:GetAbsOrigin():__add(Vector(math.cos(angle), math.sin(angle), 0):__mul(dist))
	return GetGroundPosition(fallbackPos, caster)
end
function elite_051.prototype.PlayStrikeGesture(self, caster)
	caster:RemoveGesture(ACT_DOTA_ATTACK)
	caster:StartGestureWithFadeAndPlaybackRate(ACT_DOTA_ATTACK, 0.05, 0.2, 1.2)
end
function elite_051.prototype.PlayCastEffect(self, caster)
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
function elite_051.prototype.PlayCastSound(self, caster)
	local lockUntil = caster:GetCustomValue(CAST_SOUND_LOCK_KEY) or 0
	if GameRules:GetGameTime() < lockUntil then
		return
	end
	caster:StopSound(LIGHTNING_CAST_SOUND)
	caster:EmitSound(LIGHTNING_CAST_SOUND)
end
function elite_051.prototype.StrikeAtPoint(self, caster, targetPos, strikeRadius)
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
		strikeRadius,
		DOTA_UNIT_TARGET_TEAM_ENEMY,
		DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,
		DOTA_UNIT_TARGET_FLAG_NONE,
		FIND_ANY_ORDER,
		false
	)
	for ____, enemy in ipairs(hitEnemies) do
		do
			if not IsValidAlive(nil, enemy) then
				goto __continue32
			end
			caster:MonsterDamage({ victim = enemy, damage_rate = DAMAGE_RATE, ability = self })
			AddDeBuffStatus(nil, enemy, caster, self, DebuffStatusType.STUN, { duration = STUN_DURATION })
		end
		::__continue32::
	end
end
function elite_051.prototype.LockCasterFacingPoint(self, caster, targetPos, duration)
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
function elite_051.prototype.ClearFacingLock(self, caster)
	local oldTimer = caster:GetCustomValue(FACE_LOCK_KEY)
	if not oldTimer then
		return
	end
	Timers:RemoveTimer(oldTimer)
	caster:SetCustomValue(FACE_LOCK_KEY, nil)
end
function elite_051.prototype.IsStormTokenValid(self, token)
	return token == self.stormToken and not self:IsNull()
end
elite_051 = __TS__DecorateLegacy({ registerAbility(nil) }, elite_051)
____exports.elite_051 = elite_051
return ____exports