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
local __TS__ArrayMap = ____lualib.__TS__ArrayMap
local __TS__ArrayFilter = ____lualib.__TS__ArrayFilter
local __TS__DecorateLegacy = ____lualib.__TS__DecorateLegacy
local ____exports = {}
local ____dota_ts_adapter = require("utils.dota_ts_adapter")
local registerAbility = ____dota_ts_adapter.registerAbility
local ____monster_base = require("abilities.monster.monster_base")
local MonsterAbility_CS = ____monster_base.MonsterAbility_CS
local CAST_RANGE = 2000
local CAST_POINT = 0.8
local CAST_DURATION = 1.85
local COOLDOWN = 7
local WARNING_DURATION = 0.85
local CORE_WARNING_BONUS = 0.15
local WAVE_INTERVAL = 0.25
local STRIKE_RADIUS = 500
local PARTICLE_RADIUS = STRIKE_RADIUS / 0.8
local CORE_STRIKE_COUNT = 2
local NEAR_STRIKE_COUNT = 6
local OUTER_STRIKE_COUNT = 6
local STRIKE_COUNT = CORE_STRIKE_COUNT + NEAR_STRIKE_COUNT + OUTER_STRIKE_COUNT
local STRIKE_INTERVAL = 0.05
local CORE_OFFSET_RADIUS = 120
local NEAR_OFFSET_RADIUS = 600
local TARGET_OFFSET_RADIUS = 2000
local RANDOM_MIN_DISTANCE = 180
local MIN_POINT_SEPARATION = 320
local DAMAGE_RATE = 12
local RANDOM_POINT_TRY_COUNT = 12
local MAX_IMPACT_SOUND_COUNT = 4
local ODDS_STRIKE_PARTICLE = "particles/dd/arred_legion_commander_odds.vpcf"
local ODDS_SOUND_EVENTS = "soundevents/game_sounds_heroes/game_sounds_legion_commander.vsndevts"
local ODDS_CAST_SOUND = "Hero_LegionCommander.Overwhelming.Cast"
local ODDS_IMPACT_SOUND = "Hero_LegionCommander.Overwhelming.Location"
local function getGroundPosition(self, point, context)
	return GetGroundPosition(point, context)
end
local function getFlatDirection(self, direction)
	local flat = Vector(direction.x, direction.y, 0)
	local length = flat:Length2D()
	if length <= 0.001 then
		return Vector(1, 0, 0)
	end
	return flat:__mul(1 / length)
end
local function getTargetByIndex(self, targetIndex)
	if targetIndex == nil then
		return nil
	end
	return EntIndexToHScript(targetIndex)
end
____exports.boss_legion_2 = __TS__Class()
local boss_legion_2 = ____exports.boss_legion_2
boss_legion_2.name = "boss_legion_2"
__TS__ClassExtends(boss_legion_2, MonsterAbility_CS)
function boss_legion_2.prototype.____constructor(self, ...)
	MonsterAbility_CS.prototype.____constructor(self, ...)
	self.lockedStrikes = {}
end
function boss_legion_2.prototype.Precache(self, context)
	PrecacheResource("particle", ODDS_STRIKE_PARTICLE, context)
	PrecacheResource("soundfile", ODDS_SOUND_EVENTS, context)
end
function boss_legion_2.prototype.GetMosnterAbilityConfig(self)
	return {
		behavior = DOTA_ABILITY_BEHAVIOR_NO_TARGET,
		castRange = CAST_RANGE,
		castPoint = CAST_POINT,
		castDuration = CAST_DURATION,
		cooldown = COOLDOWN,
		castAnimation = ACT_DOTA_CAST_ABILITY_1,
		canCast = function()
			local caster = self:GetCaster()
			local ____temp_0
			if IsValidAlive(nil, caster) and IsValidAlive(nil, caster:GetMinDistanceUnit(CAST_RANGE)) then
				____temp_0 = UF_SUCCESS
			else
				____temp_0 = UF_FAIL_CUSTOM
			end
			return ____temp_0
		end,
		castError = function()
			return "附近没有可释放剑阵的目标"
		end,
		OnPhaseStart = function()
			return self:OnLegionPhaseStart()
		end,
		OnStart = function()
			return self:OnLegionStart()
		end,
		OnInterrupt = function()
			return self:ClearLockedPoints()
		end,
		OnFinish = function()
			return self:ClearLockedPoints()
		end,
	}
end
function boss_legion_2.prototype.GetAOERadius(self)
	return STRIKE_RADIUS
end
function boss_legion_2.prototype.OnLegionPhaseStart(self)
	local caster = self:GetCaster()
	if not IsValidAlive(nil, caster) then
		return
	end
	local target = caster:GetMinDistanceUnit(CAST_RANGE)
	if IsValidAlive(nil, target) then
		self.lockedTargetIndex = target:entindex()
		caster:SetForwardVector(getFlatDirection(nil, target:GetAbsOrigin():__sub(caster:GetAbsOrigin())))
		caster:LockTargetForSpeed(target, CAST_POINT)
	end
	self.lockedStrikes = self:CreateStrikePoints(caster, target)
end
function boss_legion_2.prototype.OnLegionStart(self)
	local caster = self:GetCaster()
	if not IsValidAlive(nil, caster) then
		return
	end
	EmitSoundOn(ODDS_CAST_SOUND, caster)
	caster:StartGestureWithPlaybackRate(ACT_DOTA_CAST_ABILITY_1, 1.15)
	local target = getTargetByIndex(nil, self.lockedTargetIndex)
	if IsValidAlive(nil, target) then
		caster:SetForwardVector(getFlatDirection(nil, target:GetAbsOrigin():__sub(caster:GetAbsOrigin())))
	end
	local ____temp_1
	if #self.lockedStrikes > 0 then
		____temp_1 = self.lockedStrikes
	else
		____temp_1 = self:CreateStrikePoints(caster, target)
	end
	local strikes = ____temp_1
	do
		local index = 0
		while index < #strikes do
			local strike = strikes[index + 1]
			self:Timer(strike.waveDelay, function()
				return self:WarningRingEffect(strike.position, STRIKE_RADIUS, strike.warningDuration, { speed = 0 })
			end)
			self:Timer(strike.strikeDelay, function()
				return self:StrikeAt(strike)
			end)
			index = index + 1
		end
	end
end
function boss_legion_2.prototype.ClearLockedPoints(self)
	self.lockedStrikes = {}
	self.lockedTargetIndex = nil
end
function boss_legion_2.prototype.CreateStrikePoints(self, caster, lockedTarget)
	local enemies = self:FindEnemies(caster)
	local ____IsValidAlive_result_3
	if IsValidAlive(nil, lockedTarget) then
		____IsValidAlive_result_3 = lockedTarget
	else
		local ____temp_2
		if #enemies > 0 then
			____temp_2 = enemies[RandomInt(0, #enemies - 1) + 1]
		else
			____temp_2 = caster
		end
		____IsValidAlive_result_3 = ____temp_2
	end
	local anchor = ____IsValidAlive_result_3
	local positions = {}
	do
		local index = 0
		while index < CORE_STRIKE_COUNT do
			local maxDistance = index == 0 and 0 or CORE_OFFSET_RADIUS
			positions[#positions + 1] = self:CreateStrikePoint(anchor, positions, 0, maxDistance, 0)
			index = index + 1
		end
	end
	do
		local index = 0
		while index < NEAR_STRIKE_COUNT do
			positions[#positions + 1] =
				self:CreateStrikePoint(anchor, positions, RANDOM_MIN_DISTANCE, NEAR_OFFSET_RADIUS, MIN_POINT_SEPARATION)
			index = index + 1
		end
	end
	do
		local index = 0
		while index < OUTER_STRIKE_COUNT do
			positions[#positions + 1] = self:CreateStrikePoint(
				anchor,
				positions,
				NEAR_OFFSET_RADIUS,
				TARGET_OFFSET_RADIUS,
				MIN_POINT_SEPARATION
			)
			index = index + 1
		end
	end
	return __TS__ArrayMap(positions, function(____, position, index)
		return self:CreateStrikeInfo(position, index)
	end)
end
function boss_legion_2.prototype.CreateStrikeInfo(self, position, index)
	local waveDelay = 0
	local localIndex = index
	local warningDuration = WARNING_DURATION + CORE_WARNING_BONUS
	if index >= CORE_STRIKE_COUNT + NEAR_STRIKE_COUNT then
		waveDelay = WAVE_INTERVAL * 2
		localIndex = index - CORE_STRIKE_COUNT - NEAR_STRIKE_COUNT
		warningDuration = WARNING_DURATION
	elseif index >= CORE_STRIKE_COUNT then
		waveDelay = WAVE_INTERVAL
		localIndex = index - CORE_STRIKE_COUNT
		warningDuration = WARNING_DURATION
	end
	return {
		position = position,
		playSound = index < MAX_IMPACT_SOUND_COUNT,
		waveDelay = waveDelay,
		warningDuration = warningDuration,
		strikeDelay = waveDelay + warningDuration + localIndex * STRIKE_INTERVAL,
	}
end
function boss_legion_2.prototype.CreateStrikePoint(self, anchor, existing, minDistance, maxDistance, minSeparation)
	local fallback = getGroundPosition(nil, anchor:GetAbsOrigin(), anchor)
	if maxDistance <= 0 then
		return fallback
	end
	do
		local retry = 0
		while retry < RANDOM_POINT_TRY_COUNT do
			local point = self:CreateStrikePointCandidate(anchor, minDistance, maxDistance)
			if self:IsValidStrikePoint(anchor, point, existing, minSeparation) then
				return point
			end
			retry = retry + 1
		end
	end
	do
		local retry = 0
		while retry < RANDOM_POINT_TRY_COUNT do
			local point = self:CreateStrikePointCandidate(anchor, minDistance, maxDistance)
			if self:IsValidStrikePoint(anchor, point, existing, 0) then
				return point
			end
			retry = retry + 1
		end
	end
	return getGroundPosition(nil, anchor:GetAbsOrigin(), anchor)
end
function boss_legion_2.prototype.CreateStrikePointCandidate(self, anchor, minDistance, maxDistance)
	local candidate = anchor:GetAbsOrigin():__add(RandomVector(RandomFloat(minDistance, maxDistance)))
	return getGroundPosition(nil, candidate, anchor)
end
function boss_legion_2.prototype.IsValidStrikePoint(self, anchor, point, existing, minSeparation)
	local origin = getGroundPosition(nil, anchor:GetAbsOrigin(), anchor)
	if not IsGridNavDisplacementWalkable(nil, point) then
		return false
	end
	for ____, placed in ipairs(existing) do
		if GetDistance(nil, placed, point) < minSeparation then
			return false
		end
	end
	return GridNav:FindPathLength(origin, point) ~= -1
end
function boss_legion_2.prototype.FindEnemies(self, caster)
	return __TS__ArrayFilter(
		FindUnitsInRadius(caster:GetTeamNumber(), caster:GetAbsOrigin(), nil, CAST_RANGE, 2, 1 + 18, 0, 0, false),
		function(____, enemy)
			return IsValidAlive(nil, enemy)
		end
	)
end
function boss_legion_2.prototype.StrikeAt(self, strike)
	local caster = self:GetCaster()
	if not IsValidAlive(nil, caster) then
		return
	end
	local strikePoint = getGroundPosition(nil, strike.position, caster)
	self:PlayStrikeEffect(strikePoint, strike.playSound)
	self:DamageAt(strikePoint)
end
function boss_legion_2.prototype.PlayStrikeEffect(self, point, playSound)
	local caster = self:GetCaster()
	if not IsValidAlive(nil, caster) then
		return
	end
	local pfx = ParticleManager:CreateParticle(ODDS_STRIKE_PARTICLE, PATTACH_WORLDORIGIN, nil)
	ParticleManager:SetParticleShouldCheckFoW(pfx, false)
	ParticleManager:SetParticleControl(pfx, 0, point)
	ParticleManager:SetParticleControl(pfx, 1, point)
	ParticleManager:SetParticleControl(pfx, 2, point)
	ParticleManager:SetParticleControl(pfx, 3, point)
	ParticleManager:SetParticleControl(pfx, 4, Vector(PARTICLE_RADIUS, 0, 0))
	ParticleManager:SetParticleControl(pfx, 5, point)
	ParticleManager:SetParticleControl(pfx, 6, point)
	ParticleManager:ReleaseParticleIndex(pfx)
	if playSound then
		EmitSoundOnLocationWithCaster(point, ODDS_IMPACT_SOUND, caster)
	end
end
function boss_legion_2.prototype.DamageAt(self, point)
	local caster = self:GetCaster()
	if not IsValidAlive(nil, caster) then
		return
	end
	local enemies = FindUnitsInRadius(
		caster:GetTeamNumber(),
		point,
		nil,
		STRIKE_RADIUS,
		DOTA_UNIT_TARGET_TEAM_ENEMY,
		DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,
		DOTA_UNIT_TARGET_FLAG_NONE,
		FIND_ANY_ORDER,
		false
	)
	for ____, enemy in ipairs(enemies) do
		do
			if not IsValidAlive(nil, enemy) then
				goto __continue55
			end
			caster:MonsterDamage({ victim = enemy, damage_rate = DAMAGE_RATE, ability = self, damage_type = 2 })
		end
		::__continue55::
	end
end
boss_legion_2 = __TS__DecorateLegacy({ registerAbility(nil) }, boss_legion_2)
____exports.boss_legion_2 = boss_legion_2
return ____exports