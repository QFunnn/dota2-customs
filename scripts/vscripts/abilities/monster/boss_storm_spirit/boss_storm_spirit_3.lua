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
local modifier_boss_storm_spirit_3_slow
local ____dota_ts_adapter = require("utils.dota_ts_adapter")
local registerAbility = ____dota_ts_adapter.registerAbility
local registerModifier = ____dota_ts_adapter.registerModifier
local ____monster_base = require("abilities.monster.monster_base")
local MonsterAbility_CS = ____monster_base.MonsterAbility_CS
local MonsterModifier_CS = ____monster_base.MonsterModifier_CS
local CAST_POINT = 1.5
local CAST_DURATION = 5.65
local BLINK_STRIKE_COUNT = 9
local BLINK_START_INTERVAL = 0.95
local BLINK_END_INTERVAL = 0.32
local BLINK_START_PLAYBACK_RATE = 0.95
local BLINK_END_PLAYBACK_RATE = 2.1
local BLINK_WARNING_LEAD = 0.45
local BLINK_WARNING_RADIUS = 230
local BLINK_MIN_DISTANCE = 450
local BLINK_MAX_DISTANCE = 1000
local BLINK_TARGET_SEARCH_RANGE = 2200
local BLINK_POINT_ATTEMPTS = 40
local BLINK_PATH_WIDTH = 140
local BLINK_PATH_DAMAGE_RATE = 15
local BLINK_PATH_SLOW_DURATION = 0.55
local OVERLOAD_RADIUS = 220
local OVERLOAD_DAMAGE_RATE = 10
local OVERLOAD_STUN_DURATION = 0.15
local OVERLOAD_SLOW_DURATION = 0.55
local REMNANT_DURATION = 3
local REMNANT_THINKER_EXTRA_DURATION = 0.3
local REMNANT_HIT_RADIUS = 120
local REMNANT_EXPLOSION_RADIUS = 220
local REMNANT_DAMAGE_RATE = 12
local REMNANT_SLOW_DURATION = 1
local REMNANT_SLOW_MOVESPEED_PCT = -50
local REMNANT_THINK_INTERVAL = 0.03
local REMNANT_ARM_DELAY = 1
local PARTICLE_STATIC_REMNANT = "particles/boss/boss_storm_spirit/ak_stormspirit_static_remnant_image.vpcf"
local PARTICLE_REMNANT_EXPLOSION = "particles/units/heroes/hero_stormspirit/stormspirit_overload_discharge.vpcf"
local PARTICLE_BLINK_WARNING = "particles/units/heroes/hero_stormspirit/storm_spirit_new_loadout.vpcf"
local PARTICLE_BLINK_TRAIL = "particles/boss/void_spirit_astral_step_blue.vpcf"
local SOUND_BLINK = "Hero_StormSpirit.BallLightning"
local SOUND_REMNANT_CAST = "Hero_StormSpirit.StaticRemnantPlant"
local SOUND_REMNANT_EXPLODE = "Hero_StormSpirit.StaticRemnantExplode"
--- 闪烁打击：连续转向预警闪现，沿路径放电，并在原地留下可被触发的残影。
____exports.boss_storm_spirit_3 = __TS__Class()
local boss_storm_spirit_3 = ____exports.boss_storm_spirit_3
boss_storm_spirit_3.name = "boss_storm_spirit_3"
__TS__ClassExtends(boss_storm_spirit_3, MonsterAbility_CS)
function boss_storm_spirit_3.prototype.Precache(self, context)
	PrecacheResource("particle", PARTICLE_STATIC_REMNANT, context)
	PrecacheResource("particle", PARTICLE_REMNANT_EXPLOSION, context)
	PrecacheResource("particle", PARTICLE_BLINK_WARNING, context)
	PrecacheResource("particle", PARTICLE_BLINK_TRAIL, context)
end
function boss_storm_spirit_3.prototype.GetMosnterAbilityConfig(self)
	return {
		behavior = DOTA_ABILITY_BEHAVIOR_NO_TARGET,
		castPoint = CAST_POINT,
		castDuration = CAST_DURATION,
		castAnimation = ACT_DOTA_CAST_ABILITY_4,
		animationPlaybackRate = 1.2,
		castColor = Vector(200, 240, 255),
		isNotMove = true,
		OnPhaseStart = function()
			local caster = self:GetCaster()
			local target = caster:GetMinDistanceUnit(BLINK_TARGET_SEARCH_RANGE)
			if target then
				caster:LockTargetForSpeed(target, CAST_POINT, 4)
			end
		end,
		OnInterrupt = function()
			return self:endCastSession()
		end,
		OnFinish = function()
			return self:endCastSession()
		end,
		OnStart = function()
			return self:onStart()
		end,
	}
end
function boss_storm_spirit_3.prototype.onStart(self)
	if not IsServer() then
		return
	end
	local caster = self:GetCaster()
	if not IsValidAlive(nil, caster) then
		return
	end
	local castToken = self:beginCastSession()
	caster:StartGestureWithPlaybackRate(ACT_DOTA_CAST_ABILITY_4, self:getStrikePlaybackRate(0))
	do
		local i = 0
		while i < BLINK_STRIKE_COUNT do
			local currentIndex = i
			local currentDelay = self:getStrikeDelay(currentIndex)
			local currentPlaybackRate = self:getStrikePlaybackRate(currentIndex)
			self:Timer(currentDelay, function()
				if not self:isCastingActive(castToken) then
					return
				end
				self:prepareBlinkStrike(castToken, currentIndex, currentPlaybackRate)
			end)
			i = i + 1
		end
	end
end
function boss_storm_spirit_3.prototype.getStrikeDelay(self, sequenceIndex)
	local delay = 0
	do
		local intervalIndex = 0
		while intervalIndex < sequenceIndex do
			delay = delay + self:getStrikeInterval(intervalIndex)
			intervalIndex = intervalIndex + 1
		end
	end
	return delay
end
function boss_storm_spirit_3.prototype.getStrikeInterval(self, intervalIndex)
	local intervalCount = math.max(BLINK_STRIKE_COUNT - 2, 1)
	local progress = intervalIndex / intervalCount
	return BLINK_START_INTERVAL + (BLINK_END_INTERVAL - BLINK_START_INTERVAL) * progress
end
function boss_storm_spirit_3.prototype.getStrikePlaybackRate(self, sequenceIndex)
	local progress = BLINK_STRIKE_COUNT <= 1 and 0 or sequenceIndex / (BLINK_STRIKE_COUNT - 1)
	return BLINK_START_PLAYBACK_RATE + (BLINK_END_PLAYBACK_RATE - BLINK_START_PLAYBACK_RATE) * progress
end
function boss_storm_spirit_3.prototype.beginCastSession(self)
	local token = DoUniqueString("boss_storm_spirit_3")
	self.activeCastToken = token
	return token
end
function boss_storm_spirit_3.prototype.endCastSession(self)
	self.activeCastToken = nil
end
function boss_storm_spirit_3.prototype.isCastingActive(self, castToken)
	local caster = self:GetCaster()
	return IsValidAlive(nil, caster)
		and self.activeCastToken == castToken
		and caster:HasModifier("modifier_monster_cast_controller")
end
function boss_storm_spirit_3.prototype.prepareBlinkStrike(self, castToken, sequenceIndex, playbackRate)
	local caster = self:GetCaster()
	if not IsValidAlive(nil, caster) then
		return
	end
	local startPos = GetGroundPosition(caster:GetAbsOrigin(), caster)
	local blinkPos = self:getPressureBlinkPosition(caster, sequenceIndex)
	self:faceBlinkPathForWarning(caster, startPos, blinkPos, playbackRate)
	self:playBlinkWarning(caster, startPos, blinkPos)
	self:Timer(BLINK_WARNING_LEAD, function()
		if not self:isCastingActive(castToken) then
			return
		end
		self:blinkAndReleaseRemnant(caster, blinkPos, playbackRate)
	end)
end
function boss_storm_spirit_3.prototype.blinkAndReleaseRemnant(self, caster, blinkPos, playbackRate)
	local startPos = caster:GetAbsOrigin()
	local direction = self:normalizeDirection(blinkPos:__sub(startPos), caster:GetForwardVector())
	self:spawnRemnant(caster, startPos)
	self:strikeBlinkPath(caster, startPos, blinkPos)
	ProjectileManager:ProjectileDodge(caster)
	caster:EmitSound(SOUND_BLINK)
	FindClearSpaceForUnit(caster, blinkPos, true)
	caster:SetForwardVector(direction)
	caster:StartGestureWithPlaybackRate(ACT_DOTA_CAST_ABILITY_1, playbackRate)
	self:releaseOverload(caster, caster:GetAbsOrigin())
end
function boss_storm_spirit_3.prototype.getPressureBlinkPosition(self, caster, sequenceIndex)
	local origin = GetGroundPosition(caster:GetAbsOrigin(), caster)
	local enemy = caster:GetMinDistanceUnit(BLINK_TARGET_SEARCH_RANGE)
	if IsValidAlive(nil, enemy) then
		local center = GetGroundPosition(enemy:GetAbsOrigin(), caster)
		local approachDir = self:normalizeDirection(center:__sub(origin), caster:GetForwardVector())
		local playerForwardDir = self:normalizeDirection(enemy:GetForwardVector(), approachDir)
		local playerBackDir = playerForwardDir:__mul(-1)
		local sideDir = Vector(-playerForwardDir.y, playerForwardDir.x, 0)
		local sideSign = RandomInt(0, 1) == 0 and 1 or -1
		local jitterDir = self:rotateDirection(playerForwardDir, RandomFloat(-75, 75))
		local wideOrbitDir = self:rotateDirection(playerForwardDir, RandomFloat(110, 250) * sideSign)
		local shortOrbitDir = self:rotateDirection(approachDir, RandomFloat(45, 135) * sideSign)
		local candidates = self:shuffleBlinkCandidates({
			center:__add(playerForwardDir:__mul(RandomFloat(300, 520))):__add(sideDir:__mul(RandomFloat(-180, 180))),
			center
				:__add(sideDir:__mul(RandomFloat(360, 620) * sideSign))
				:__add(playerForwardDir:__mul(RandomFloat(-160, 220))),
			center
				:__add(playerBackDir:__mul(RandomFloat(260, 460)))
				:__add(sideDir:__mul(RandomFloat(160, 320) * -sideSign)),
			center:__add(jitterDir:__mul(RandomFloat(260, 540))),
			center:__add(wideOrbitDir:__mul(RandomFloat(420, 760))),
			center:__add(shortOrbitDir:__mul(RandomFloat(320, 620))),
			center:__add(approachDir:__mul(RandomFloat(240, 420))):__add(sideDir:__mul(RandomFloat(-360, 360))),
		})
		local pressurePoint = self:findPreferredBlinkPoint(caster, origin, candidates)
		if pressurePoint then
			return pressurePoint
		end
	end
	local ____IsValidAlive_result_0
	if IsValidAlive(nil, enemy) then
		____IsValidAlive_result_0 = enemy:GetAbsOrigin()
	else
		____IsValidAlive_result_0 = origin
	end
	local center = ____IsValidAlive_result_0
	local targetPoint = self:findWalkableBlinkPoint(caster, origin, center, BLINK_MIN_DISTANCE, BLINK_MAX_DISTANCE)
	if targetPoint then
		return targetPoint
	end
	local fallbackPoint = self:findWalkableBlinkPoint(caster, origin, origin, 0, BLINK_MIN_DISTANCE)
	return fallbackPoint or origin
end
function boss_storm_spirit_3.prototype.findPreferredBlinkPoint(self, caster, origin, candidates)
	for ____, candidate in ipairs(candidates) do
		local point = GetGroundPosition(candidate, caster)
		if self:isValidBlinkPoint(origin, point) then
			return point
		end
		do
			local i = 0
			while i < 3 do
				local jitteredPoint = GetGroundPosition(point:__add(RandomVector(RandomFloat(80, 160))), caster)
				if self:isValidBlinkPoint(origin, jitteredPoint) then
					return jitteredPoint
				end
				i = i + 1
			end
		end
	end
	return nil
end
function boss_storm_spirit_3.prototype.findWalkableBlinkPoint(self, caster, origin, center, minDistance, maxDistance)
	do
		local i = 0
		while i < BLINK_POINT_ATTEMPTS do
			local distance = RandomFloat(minDistance, maxDistance)
			local point = center:__add(RandomVector(distance))
			local groundedPoint = GetGroundPosition(point, caster)
			if self:isValidBlinkPoint(origin, groundedPoint) then
				return groundedPoint
			end
			i = i + 1
		end
	end
	return nil
end
function boss_storm_spirit_3.prototype.isValidBlinkPoint(self, origin, point)
	if not IsGridNavDisplacementWalkable(nil, point) then
		return false
	end
	if not GridNav:CanFindPath(origin, point) then
		return false
	end
	if GridNav:FindPathLength(origin, point) == -1 then
		return false
	end
	return true
end
function boss_storm_spirit_3.prototype.strikeBlinkPath(self, caster, startPos, blinkPos)
	local pathDirection = self:normalizeDirection(blinkPos:__sub(startPos), caster:GetForwardVector())
	if GetDistance(nil, startPos, blinkPos) <= 20 then
		return
	end
	self:playBlinkTrail(startPos, blinkPos)
	local enemies = FindUnitsInLine(
		caster:GetTeamNumber(),
		startPos,
		blinkPos:__add(pathDirection:__mul(BLINK_PATH_WIDTH)),
		nil,
		BLINK_PATH_WIDTH,
		DOTA_UNIT_TARGET_TEAM_ENEMY,
		DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,
		DOTA_UNIT_TARGET_FLAG_NONE
	)
	for ____, enemy in ipairs(enemies) do
		do
			if not IsValidAlive(nil, enemy) then
				goto __continue46
			end
			caster:MonsterDamage({ victim = enemy, damage_rate = BLINK_PATH_DAMAGE_RATE, ability = self })
			modifier_boss_storm_spirit_3_slow:applys(enemy, caster, self, { duration = BLINK_PATH_SLOW_DURATION })
		end
		::__continue46::
	end
end
function boss_storm_spirit_3.prototype.playBlinkTrail(self, startPos, blinkPos)
	local pfx = ParticleManager:CreateParticle(PARTICLE_BLINK_TRAIL, PATTACH_WORLDORIGIN, nil)
	ParticleManager:SetParticleShouldCheckFoW(pfx, false)
	ParticleManager:SetParticleControl(pfx, 0, startPos)
	ParticleManager:SetParticleControl(pfx, 1, blinkPos)
	ParticleManager:ReleaseParticleIndex(pfx)
end
function boss_storm_spirit_3.prototype.releaseOverload(self, caster, position)
	local center = GetGroundPosition(position, caster)
	self:playOverloadParticle(center)
	local enemies = FindUnitsInRadius(
		caster:GetTeamNumber(),
		center,
		nil,
		OVERLOAD_RADIUS,
		DOTA_UNIT_TARGET_TEAM_ENEMY,
		DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,
		DOTA_UNIT_TARGET_FLAG_NONE,
		FIND_ANY_ORDER,
		false
	)
	for ____, enemy in ipairs(enemies) do
		do
			if not IsValidAlive(nil, enemy) then
				goto __continue51
			end
			caster:MonsterDamage({ victim = enemy, damage_rate = OVERLOAD_DAMAGE_RATE, ability = self })
			AddDeBuffStatus(nil, enemy, caster, self, DebuffStatusType.STUN, { duration = OVERLOAD_STUN_DURATION })
			modifier_boss_storm_spirit_3_slow:applys(enemy, caster, self, { duration = OVERLOAD_SLOW_DURATION })
		end
		::__continue51::
	end
end
function boss_storm_spirit_3.prototype.playOverloadParticle(self, position)
	local pfx = ParticleManager:CreateParticle(PARTICLE_REMNANT_EXPLOSION, PATTACH_WORLDORIGIN, nil)
	ParticleManager:SetParticleShouldCheckFoW(pfx, false)
	ParticleManager:SetParticleControl(pfx, 0, position)
	ParticleManager:ReleaseParticleIndex(pfx)
end
function boss_storm_spirit_3.prototype.normalizeDirection(self, direction, fallback)
	local flatDirection = Vector(direction.x, direction.y, 0)
	if flatDirection:Length2D() > 0.01 then
		return flatDirection:Normalized()
	end
	local flatFallback = Vector(fallback.x, fallback.y, 0)
	if flatFallback:Length2D() > 0.01 then
		return flatFallback:Normalized()
	end
	return Vector(1, 0, 0)
end
function boss_storm_spirit_3.prototype.rotateDirection(self, direction, degrees)
	local radians = degrees * math.pi / 180
	local cos = math.cos(radians)
	local sin = math.sin(radians)
	return self:normalizeDirection(
		Vector(direction.x * cos - direction.y * sin, direction.x * sin + direction.y * cos, 0),
		direction
	)
end
function boss_storm_spirit_3.prototype.shuffleBlinkCandidates(self, candidates)
	do
		local i = #candidates - 1
		while i > 0 do
			local swapIndex = RandomInt(0, i)
			local currentCandidate = candidates[i + 1]
			candidates[i + 1] = candidates[swapIndex + 1]
			candidates[swapIndex + 1] = currentCandidate
			i = i - 1
		end
	end
	return candidates
end
function boss_storm_spirit_3.prototype.faceBlinkPathForWarning(self, caster, startPos, blinkPos, playbackRate)
	local warningDirection = self:normalizeDirection(blinkPos:__sub(startPos), caster:GetForwardVector())
	caster:SetForwardVector(warningDirection)
	caster:StartGestureWithPlaybackRate(ACT_DOTA_CAST_ABILITY_4, playbackRate)
end
function boss_storm_spirit_3.prototype.spawnRemnant(self, caster, startPos)
	caster:EmitSound(SOUND_REMNANT_CAST)
	CreateModifierThinker(caster, self, "modifier_boss_storm_spirit_3_remnant", {
		duration = REMNANT_DURATION + REMNANT_THINKER_EXTRA_DURATION,
		parent_model = caster:GetModelName(),
	}, startPos, caster:GetTeamNumber(), false)
end
function boss_storm_spirit_3.prototype.playBlinkWarning(self, caster, startPos, blinkPos)
	self:WarningRingEffect(blinkPos, BLINK_WARNING_RADIUS, BLINK_WARNING_LEAD)
	self:playBlinkLinearWarning(caster, startPos, blinkPos)
	self:playBlinkPointWarning(blinkPos)
end
function boss_storm_spirit_3.prototype.playBlinkLinearWarning(self, caster, startPos, blinkPos)
	local endPos = blinkPos:__add(
		self:normalizeDirection(blinkPos:__sub(startPos), caster:GetForwardVector()):__mul(BLINK_PATH_WIDTH)
	)
	self:WarningEffect(
		startPos,
		endPos,
		BLINK_WARNING_LEAD,
		{ startWidth = BLINK_PATH_WIDTH, endWidth = BLINK_PATH_WIDTH }
	)
end
function boss_storm_spirit_3.prototype.playBlinkPointWarning(self, position)
	local pfx = ParticleManager:CreateParticle(PARTICLE_BLINK_WARNING, PATTACH_WORLDORIGIN, nil)
	ParticleManager:SetParticleShouldCheckFoW(pfx, false)
	ParticleManager:SetParticleControl(pfx, 0, position)
	ParticleManager:SetParticleControl(pfx, 1, Vector(BLINK_WARNING_RADIUS, 0, 0))
	Timers:CreateTimer(BLINK_WARNING_LEAD + 0.2, function()
		ParticleManager:DestroyParticle(pfx, false)
		ParticleManager:ReleaseParticleIndex(pfx)
		return nil
	end)
end
boss_storm_spirit_3 = __TS__DecorateLegacy({ registerAbility(nil) }, boss_storm_spirit_3)
____exports.boss_storm_spirit_3 = boss_storm_spirit_3
local modifier_boss_storm_spirit_3_remnant = __TS__Class()
modifier_boss_storm_spirit_3_remnant.name = "modifier_boss_storm_spirit_3_remnant"
__TS__ClassExtends(modifier_boss_storm_spirit_3_remnant, MonsterModifier_CS)
function modifier_boss_storm_spirit_3_remnant.prototype.____constructor(self, ...)
	MonsterModifier_CS.prototype.____constructor(self, ...)
	self.staticExploded = false
	self.staticOrigin = Vector(0, 0, 0)
end
function modifier_boss_storm_spirit_3_remnant.prototype.CheckState(self)
	return { [MODIFIER_STATE_NO_UNIT_COLLISION] = true }
end
function modifier_boss_storm_spirit_3_remnant.prototype.IsHidden(self)
	return true
end
function modifier_boss_storm_spirit_3_remnant.prototype.IsPurgable(self)
	return false
end
function modifier_boss_storm_spirit_3_remnant.prototype.OnCreated(self, params)
	if not IsServer() then
		return
	end
	local parent = self:GetParent()
	if not IsValid(nil, parent) or parent:IsNull() then
		self:Destroy()
		return
	end
	self._parent:SetOriginalModel(params.parent_model or "")
	self._parent:SetModel(params.parent_model or "")
	self._parent:SetModelScale(0.01)
	self:createStaticParticle(parent)
	self:StartIntervalThink(REMNANT_THINK_INTERVAL)
	self:Timer(REMNANT_DURATION, function()
		if self:IsRemoved() then
			return
		end
		self:explodeStaticRemnant()
		self:Destroy()
	end)
end
function modifier_boss_storm_spirit_3_remnant.prototype.OnIntervalThink(self)
	if not IsServer() then
		return
	end
	local parent = self:GetParent()
	local caster = self:GetCaster()
	if not IsValid(nil, parent) or parent:IsNull() or not IsValidAlive(nil, caster) then
		self:Destroy()
		return
	end
	if self:isArmed() then
		self:checkStaticRemnantCollision()
	end
end
function modifier_boss_storm_spirit_3_remnant.prototype.OnDestroy(self)
	if not IsServer() then
		return
	end
	self:StartIntervalThink(-1)
	local parent = self:GetParent()
	if self:isArmed() then
		self:explodeStaticRemnant()
	end
	self:destroyParticles()
	if IsValid(nil, parent) and not parent:IsNull() then
		parent:SelfRemoveSelf()
	end
end
function modifier_boss_storm_spirit_3_remnant.prototype.isArmed(self)
	return self:GetElapsedTime() >= REMNANT_ARM_DELAY
end
function modifier_boss_storm_spirit_3_remnant.prototype.createStaticParticle(self, parent)
	local position = parent:GetAbsOrigin()
	self.staticOrigin = Vector(position.x, position.y, position.z)
	self.pfxStatic = ParticleManager:CreateParticle(PARTICLE_STATIC_REMNANT, PATTACH_WORLDORIGIN, parent)
	ParticleManager:SetParticleShouldCheckFoW(self.pfxStatic, false)
	ParticleManager:SetParticleControl(self.pfxStatic, 0, position)
	local random = RandomInt(0, 10)
	ParticleManager:SetParticleControl(self.pfxStatic, 2, Vector(random, 1, 100))
end
function modifier_boss_storm_spirit_3_remnant.prototype.findHitTarget(self, position)
	local caster = self:GetCaster()
	if not IsValidAlive(nil, caster) then
		return
	end
	local enemies = FindUnitsInRadius(
		caster:GetTeamNumber(),
		position,
		nil,
		REMNANT_HIT_RADIUS,
		DOTA_UNIT_TARGET_TEAM_ENEMY,
		DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,
		DOTA_UNIT_TARGET_FLAG_NONE,
		FIND_CLOSEST,
		false
	)
	for ____, enemy in ipairs(enemies) do
		if IsValidAlive(nil, enemy) then
			return enemy
		end
	end
	return nil
end
function modifier_boss_storm_spirit_3_remnant.prototype.checkStaticRemnantCollision(self)
	if self.staticExploded then
		return
	end
	local hitTarget = self:findHitTarget(self.staticOrigin)
	if not hitTarget then
		return
	end
	self:explodeStaticRemnant()
	self:Destroy()
end
function modifier_boss_storm_spirit_3_remnant.prototype.explodeStaticRemnant(self)
	if self.staticExploded then
		return
	end
	self.staticExploded = true
	self:destroyStaticParticle()
	self:explodeAt(self.staticOrigin)
end
function modifier_boss_storm_spirit_3_remnant.prototype.explodeAt(self, position)
	local caster = self:GetCaster()
	local ability = self:GetAbility()
	local parent = self:GetParent()
	if IsValidAlive(nil, caster) then
		EmitSoundOnLocationWithCaster(position, SOUND_REMNANT_EXPLODE, caster)
	elseif IsValidAlive(nil, parent) then
		parent:EmitSound(SOUND_REMNANT_EXPLODE)
	end
	self:playExplosionParticle(position)
	if not IsValidAlive(nil, caster) or not ability or ability:IsNull() then
		return
	end
	local enemies = FindUnitsInRadius(
		caster:GetTeamNumber(),
		position,
		nil,
		REMNANT_EXPLOSION_RADIUS,
		DOTA_UNIT_TARGET_TEAM_ENEMY,
		DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,
		DOTA_UNIT_TARGET_FLAG_NONE,
		FIND_ANY_ORDER,
		false
	)
	for ____, enemy in ipairs(enemies) do
		do
			if not IsValidAlive(nil, enemy) then
				goto __continue99
			end
			caster:MonsterDamage({ victim = enemy, damage_rate = REMNANT_DAMAGE_RATE, ability = ability })
			modifier_boss_storm_spirit_3_slow:applys(enemy, caster, ability, { duration = REMNANT_SLOW_DURATION })
		end
		::__continue99::
	end
end
function modifier_boss_storm_spirit_3_remnant.prototype.playExplosionParticle(self, position)
	local pfx = ParticleManager:CreateParticle(PARTICLE_REMNANT_EXPLOSION, PATTACH_WORLDORIGIN, nil)
	ParticleManager:SetParticleShouldCheckFoW(pfx, false)
	ParticleManager:SetParticleControl(pfx, 0, position)
	ParticleManager:ReleaseParticleIndex(pfx)
end
function modifier_boss_storm_spirit_3_remnant.prototype.destroyParticles(self)
	self:destroyStaticParticle()
end
function modifier_boss_storm_spirit_3_remnant.prototype.destroyStaticParticle(self)
	if self.pfxStatic ~= nil then
		ParticleManager:DestroyParticle(self.pfxStatic, false)
		ParticleManager:ReleaseParticleIndex(self.pfxStatic)
		self.pfxStatic = nil
	end
end
modifier_boss_storm_spirit_3_remnant = __TS__DecorateLegacy(
	{ registerModifier(nil, "modifier_boss_storm_spirit_3_remnant") },
	modifier_boss_storm_spirit_3_remnant
)
modifier_boss_storm_spirit_3_slow = __TS__Class()
modifier_boss_storm_spirit_3_slow.name = "modifier_boss_storm_spirit_3_slow"
__TS__ClassExtends(modifier_boss_storm_spirit_3_slow, MonsterModifier_CS)
function modifier_boss_storm_spirit_3_slow.prototype.IsHidden(self)
	return false
end
function modifier_boss_storm_spirit_3_slow.prototype.IsDebuff(self)
	return true
end
function modifier_boss_storm_spirit_3_slow.prototype.IsPurgable(self)
	return true
end
function modifier_boss_storm_spirit_3_slow.prototype.GetAttributeBonus(self)
	return { bonus_movespeed_pct = REMNANT_SLOW_MOVESPEED_PCT }
end
function modifier_boss_storm_spirit_3_slow.prototype.GetEffectName(self)
	return "particles/void_spirit_astral_step_debuff_ember_blue.vpcf"
end
function modifier_boss_storm_spirit_3_slow.prototype.GetEffectAttachType(self)
	return PATTACH_ABSORIGIN_FOLLOW
end
modifier_boss_storm_spirit_3_slow = __TS__DecorateLegacy(
	{ registerModifier(nil, "modifier_boss_storm_spirit_3_slow") },
	modifier_boss_storm_spirit_3_slow
)
return ____exports