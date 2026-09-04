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
local CAST_POINT = 1
local ACTION_DURATION = 1.08
local ACTION_POINT = 0.54
local FISSURE_COUNT = 3
local FISSURE_ACTION_LEAD_TIME = 0.15
local FISSURE_RELEASE_INTERVAL = ACTION_DURATION + 0.2
local FISSURE_LENGTH = 1200
local FISSURE_WIDTH = 140
local START_OFFSET = 80
local DAMAGE_RATE = 18
local KNOCKUP_DURATION = 0.25
local KNOCKUP_HEIGHT = 220
local AIM_TRACK_DURATION = 0.3
local FISSURE_PARTICLE = "particles/unit/deep_magma_cyan_fissure.vpcf"
local ICE_SHARDS_SOUND_EVENTS = "soundevents/game_sounds_heroes/game_sounds_tusk.vsndevts"
local CAST_SOUND = "Hero_Tusk.IceShards.Cast"
local FISSURE_SOUND = "Hero_Tusk.IceShards"
--- 精英技能69 - 裂谷寒刺：连续三次预警前方裂隙，在关键点引爆并击飞路径敌人
____exports.elite_069 = __TS__Class()
local elite_069 = ____exports.elite_069
elite_069.name = "elite_069"
__TS__ClassExtends(elite_069, MonsterAbility_CS)
function elite_069.prototype.Precache(self, context)
	PrecacheResource("particle", FISSURE_PARTICLE, context)
	PrecacheResource("soundfile", ICE_SHARDS_SOUND_EVENTS, context)
end
function elite_069.prototype.GetMosnterAbilityConfig(self)
	return {
		behavior = DOTA_ABILITY_BEHAVIOR_NO_TARGET,
		castRange = CAST_RANGE,
		castPoint = CAST_POINT,
		castDuration = ACTION_POINT + FISSURE_RELEASE_INTERVAL * (FISSURE_COUNT - 1),
		castAnimation = ACT_DOTA_CAST_ABILITY_2,
		OnPhaseStart = function()
			self:StartAiming(CAST_POINT)
			self:Timer(math.max(CAST_POINT - FISSURE_ACTION_LEAD_TIME, 0), function()
				return self:StartFissureAction()
			end)
		end,
		OnStart = function()
			self:ReleaseFissure()
			do
				local i = 1
				while i < FISSURE_COUNT do
					local currentIndex = i
					local releaseDelay = FISSURE_RELEASE_INTERVAL * currentIndex
					local actionStartDelay = releaseDelay - ACTION_POINT
					local fissureActionDelay = math.max(releaseDelay - FISSURE_ACTION_LEAD_TIME, 0)
					self:Timer(actionStartDelay, function()
						return self:StartRepeatAction()
					end)
					self:Timer(fissureActionDelay, function()
						return self:StartFissureAction()
					end)
					self:Timer(releaseDelay, function()
						return self:ReleaseFissure()
					end)
					i = i + 1
				end
			end
		end,
	}
end
function elite_069.prototype.StartFissureAction(self)
	local caster = self:GetCaster()
	if not IsValidAlive(nil, caster) then
		return
	end
	caster:StartGestureWithPlaybackRate(ACT_DOTA_CAST_ABILITY_2, 1)
end
function elite_069.prototype.StartRepeatAction(self)
	local caster = self:GetCaster()
	if not IsValidAlive(nil, caster) then
		return
	end
	self:StartAiming(ACTION_POINT)
end
function elite_069.prototype.StartAiming(self, duration)
	local caster = self:GetCaster()
	if not IsValidAlive(nil, caster) then
		return
	end
	EmitSoundOn(CAST_SOUND, caster)
	self:TrackNearestTarget(math.min(duration, AIM_TRACK_DURATION))
	local ____temp_0 = self:GetLinePoints(caster, caster:GetForwardVector())
	local start = ____temp_0.start
	local ____end = ____temp_0["end"]
	self:WarningEffect(start, ____end, duration, {
		startWidth = FISSURE_WIDTH,
		endWidth = FISSURE_WIDTH,
		getDirection = function()
			local currentCaster = self:GetCaster()
			if not IsValidAlive(nil, currentCaster) then
				return nil
			end
			return self:GetFlatDirection(currentCaster:GetForwardVector())
		end,
		type = 1,
	})
end
function elite_069.prototype.TrackNearestTarget(self, duration)
	local caster = self:GetCaster()
	if not IsValidAlive(nil, caster) then
		return
	end
	local target = caster:GetMinDistanceUnit(CAST_RANGE)
	if IsValidAlive(nil, target) then
		caster:LockTargetForSpeed(target, duration)
	end
end
function elite_069.prototype.ReleaseFissure(self)
	local caster = self:GetCaster()
	if not IsValidAlive(nil, caster) then
		return
	end
	local direction = self:GetFlatDirection(caster:GetForwardVector())
	local ____temp_1 = self:GetLinePoints(caster, direction)
	local start = ____temp_1.start
	local ____end = ____temp_1["end"]
	self:PlayFissureEffect(caster, start, ____end, direction)
	self:DamageFissure(caster, start, ____end, direction)
end
function elite_069.prototype.PlayFissureEffect(self, caster, start, ____end, direction)
	EmitSoundOnLocationWithCaster(start, FISSURE_SOUND, caster)
	local pfx = ParticleManager:CreateParticle(FISSURE_PARTICLE, PATTACH_WORLDORIGIN, nil)
	ParticleManager:SetParticleControl(pfx, 0, start)
	ParticleManager:SetParticleControl(pfx, 1, Vector(____end.x, ____end.y, start.z))
	ParticleManager:SetParticleControl(pfx, 2, Vector(1, 0, 0))
	self:Timer(1, function()
		ParticleManager:DestroyParticle(pfx, false)
		ParticleManager:ReleaseParticleIndex(pfx)
	end)
end
function elite_069.prototype.DamageFissure(self, caster, start, ____end, direction)
	local enemies = FindUnitsInLine(
		caster:GetTeamNumber(),
		start,
		____end,
		nil,
		FISSURE_WIDTH,
		DOTA_UNIT_TARGET_TEAM_ENEMY,
		DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,
		DOTA_UNIT_TARGET_FLAG_NONE
	)
	for ____, enemy in ipairs(enemies) do
		do
			if not IsValidAlive(nil, enemy) then
				goto __continue27
			end
			caster:MonsterDamage({ victim = enemy, damage_rate = DAMAGE_RATE, ability = self })
			enemy:KnockBack(caster, self, {
				duration = KNOCKUP_DURATION,
				distance = 0,
				height = KNOCKUP_HEIGHT,
				direction = direction,
				particleName = "",
				stun = true,
				stunDuration = 0.5,
			})
		end
		::__continue27::
	end
end
function elite_069.prototype.GetLinePoints(self, caster, direction)
	local startRaw = caster:GetAbsOrigin():__add(direction:__mul(START_OFFSET))
	local endRaw = startRaw:__add(direction:__mul(FISSURE_LENGTH))
	return {
		start = GetGroundPosition(startRaw, caster),
		["end"] = GetGroundPosition(endRaw, caster),
	}
end
function elite_069.prototype.GetFlatDirection(self, direction)
	local flat = Vector(direction.x, direction.y, 0)
	local length = flat:Length2D()
	if length <= 0.001 then
		return Vector(1, 0, 0)
	end
	return flat:__mul(1 / length)
end
elite_069 = __TS__DecorateLegacy({ registerAbility(nil) }, elite_069)
____exports.elite_069 = elite_069
return ____exports