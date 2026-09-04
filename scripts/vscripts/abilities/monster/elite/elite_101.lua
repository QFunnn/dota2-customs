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
local CAST_RANGE = 1000
local CAST_POINT = 0.65
local WAVE_COUNT = 5
local STRIKE_INTERVAL = 0.1
local STRIKE_RADIUS = 120
local STRIKE_SPACING = 180
local FIRST_STRIKE_DISTANCE = STRIKE_RADIUS
local STRIKE_TOTAL_DISTANCE = FIRST_STRIKE_DISTANCE + STRIKE_SPACING * (WAVE_COUNT - 1)
local FAN_ANGLE = 45
local WARNING_END_WIDTH = math.floor(2 * STRIKE_TOTAL_DISTANCE * math.sin(math.rad(FAN_ANGLE / 2)) + STRIKE_RADIUS * 2)
local CAST_DURATION = STRIKE_INTERVAL * (WAVE_COUNT - 1) + 0.25
local DAMAGE_RATE = 20
local STUN_DURATION = 0.25
local LIGHTNING_SKY_Z = 2000
local LIGHTNING_PARTICLE = "particles/econ/items/zeus/arcana_chariot/zeus_arcana_thundergods_wrath_start.vpcf"
local LIGHTNING_SOUND_EVENTS = "soundevents/game_sounds_heroes/game_sounds_zuus.vsndevts"
local LIGHTNING_CAST_SOUND = "Hero_Zuus.LightningBolt.Cast"
local LIGHTNING_IMPACT_SOUND = "Hero_Zuus.LightningBolt"
____exports.elite_101 = __TS__Class()
local elite_101 = ____exports.elite_101
elite_101.name = "elite_101"
__TS__ClassExtends(elite_101, MonsterAbility_CS)
function elite_101.prototype.Precache(self, context)
	PrecacheResource("particle", LIGHTNING_PARTICLE, context)
	PrecacheResource("soundfile", LIGHTNING_SOUND_EVENTS, context)
end
function elite_101.prototype.GetMosnterAbilityConfig(self)
	return {
		behavior = DOTA_ABILITY_BEHAVIOR_NO_TARGET,
		castRange = CAST_RANGE,
		castPoint = CAST_POINT,
		castDuration = CAST_DURATION,
		castAnimation = ACT_DOTA_CAST_ABILITY_1,
		canCast = function()
			local target = self:GetCaster():GetMinDistanceUnit(CAST_RANGE)
			local ____IsValidAlive_result_0
			if IsValidAlive(nil, target) then
				____IsValidAlive_result_0 = UF_SUCCESS
			else
				____IsValidAlive_result_0 = UF_FAIL_CUSTOM
			end
			return ____IsValidAlive_result_0
		end,
		OnPhaseStart = function()
			local caster = self:GetCaster()
			local target = caster:GetMinDistanceUnit(CAST_RANGE)
			if not IsValidAlive(nil, target) then
				self.lockedDirection = nil
				return
			end
			local direction = GetDirection(nil, target:GetAbsOrigin(), caster:GetAbsOrigin())
			self.lockedDirection = direction
			caster:SetForwardVector(direction)
			caster:LockTargetForSpeed(target, CAST_POINT, 4)
			EmitSoundOn(LIGHTNING_CAST_SOUND, caster)
			caster:Mover(caster:GetAbsOrigin():__add(caster:GetForwardVector():__mul(-200)), 0.2)
			local start = GetGroundPosition(caster:GetAbsOrigin(), caster)
			local ____end = self:GetStrikeEnd(start, direction)
			local forward = caster:GetForwardVector()
			self:WarningEffect(start, start:__add(forward:__mul(400)), CAST_POINT, {
				startWidth = STRIKE_RADIUS,
				endWidth = 350,
				getDirection = function()
					return self.lockedDirection
				end,
				follow = true,
			})
		end,
		OnStart = function()
			local caster = self:GetCaster()
			if not IsValidAlive(nil, caster) then
				return
			end
			local direction = self:GetStrikeDirection(caster)
			caster:SetForwardVector(direction)
			caster:StartGestureWithPlaybackRate(ACT_DOTA_CAST_ABILITY_1, 1.2)
			do
				local waveIndex = 0
				while waveIndex < WAVE_COUNT do
					local points = self:BuildWaveStrikePoints(caster, direction, waveIndex)
					self:Timer(waveIndex * STRIKE_INTERVAL, function()
						return self:StrikeWave(points)
					end)
					waveIndex = waveIndex + 1
				end
			end
			self.lockedDirection = nil
		end,
		OnInterrupt = function()
			self.lockedDirection = nil
		end,
		OnFinish = function()
			self.lockedDirection = nil
		end,
	}
end
function elite_101.prototype.GetStrikeDirection(self, caster)
	if self.lockedDirection and self.lockedDirection:Length2D() > 0.01 then
		return self.lockedDirection:Normalized()
	end
	local forward = caster:GetForwardVector()
	if forward:Length2D() > 0.01 then
		return forward:Normalized()
	end
	return Vector(1, 0, 0)
end
function elite_101.prototype.GetStrikeEnd(self, start, direction)
	return GetGroundPosition(start:__add(direction:__mul(STRIKE_TOTAL_DISTANCE)), self:GetCaster())
end
function elite_101.prototype.BuildWaveStrikePoints(self, caster, direction, waveIndex)
	local strikeCount = waveIndex + 1
	local distance = FIRST_STRIKE_DISTANCE + STRIKE_SPACING * waveIndex
	local points = {}
	for ____, strikeDirection in ipairs(self:GetWaveDirections(direction, strikeCount)) do
		local rawPoint = caster:GetAbsOrigin():__add(strikeDirection:__mul(distance))
		points[#points + 1] = GetGroundPosition(rawPoint, caster)
	end
	return points
end
function elite_101.prototype.GetWaveDirections(self, direction, strikeCount)
	if strikeCount <= 1 then
		return { direction:Normalized() }
	end
	local interval = FAN_ANGLE / (strikeCount - 1)
	local directions = {}
	do
		local index = 0
		while index < strikeCount do
			local angle = -(FAN_ANGLE / 2) + interval * index
			directions[#directions + 1] = RotateVector2D(nil, direction, angle):Normalized()
			index = index + 1
		end
	end
	return directions
end
function elite_101.prototype.StrikeWave(self, points)
	for ____, point in ipairs(points) do
		self:StrikeAt(point)
	end
end
function elite_101.prototype.StrikeAt(self, point)
	local caster = self:GetCaster()
	if not IsValidAlive(nil, caster) then
		return
	end
	local strikePoint = GetGroundPosition(point, caster)
	self:CreateLightningEffect(strikePoint)
	self:DamageAt(strikePoint)
end
function elite_101.prototype.CreateLightningEffect(self, point)
	local caster = self:GetCaster()
	if not IsValidAlive(nil, caster) then
		return
	end
	local pfx = ParticleManager:CreateParticle(LIGHTNING_PARTICLE, PATTACH_WORLDORIGIN, nil)
	ParticleManager:SetParticleControl(pfx, 0, point:__add(Vector(0, 0, 50)))
	ParticleManager:SetParticleControl(pfx, 1, point:__add(Vector(0, 0, 50)))
	ParticleManager:SetParticleControl(pfx, 2, point:__add(Vector(0, 0, 50)))
	ParticleManager:SetParticleControl(pfx, 3, point:__add(Vector(0, 0, 50)))
	ParticleManager:SetParticleControl(pfx, 6, point:__add(Vector(0, 0, 50)))
	ParticleManager:ReleaseParticleIndex(pfx)
	EmitSoundOnLocationWithCaster(point, LIGHTNING_IMPACT_SOUND, caster)
end
function elite_101.prototype.DamageAt(self, point)
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
				goto __continue33
			end
			caster:MonsterDamage({ victim = enemy, damage_rate = DAMAGE_RATE, ability = self })
			AddDeBuffStatus(nil, enemy, caster, self, DebuffStatusType.STUN, { duration = STUN_DURATION })
		end
		::__continue33::
	end
end
elite_101 = __TS__DecorateLegacy({ registerAbility(nil) }, elite_101)
____exports.elite_101 = elite_101
return ____exports