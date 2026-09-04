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
local SUMMON_UNIT_NAME = "monster_11310"
local SUMMON_TAG = "roshan_004_dragon"
local SUMMON_COUNT = 5
local SUMMON_DISTANCE = 420
local SUMMON_ANGLE_INTERVAL = 20
local CAST_POINT = 0.7
local CAST_DURATION = 0.5
local COOLDOWN = 6
local TURN_SPEED = 6
local TURN_TARGET_RANGE = 1200
local SUMMON_EFFECT = "particles/units/heroes/hero_primal_beast/primal_beast_rock_throw_impact.vpcf"
local SUMMON_SOUND = "Roshan.Slam"
____exports.roshan_004 = __TS__Class()
local roshan_004 = ____exports.roshan_004
roshan_004.name = "roshan_004"
__TS__ClassExtends(roshan_004, MonsterAbility_CS)
function roshan_004.prototype.Precache(self, context)
	PrecacheResource("particle", SUMMON_EFFECT, context)
end
function roshan_004.prototype.GetCooldown(self, _level)
	return COOLDOWN
end
function roshan_004.prototype.GetMosnterAbilityConfig(self)
	return {
		behavior = DOTA_ABILITY_BEHAVIOR_NO_TARGET,
		castPoint = CAST_POINT,
		castDuration = CAST_DURATION,
		castAnimation = ACT_DOTA_CAST_ABILITY_3,
		animationPlaybackRate = 0.85,
		isNotMove = true,
		castColor = Vector(255, 120, 80),
		OnPhaseStart = function()
			return self:TurnToNearestTarget()
		end,
		OnStart = function()
			return self:SummonDragons()
		end,
	}
end
function roshan_004.prototype.TurnToNearestTarget(self)
	local caster = self:GetCaster()
	if not IsValidAlive(nil, caster) then
		return
	end
	local target = caster:GetMinDistanceUnit(TURN_TARGET_RANGE)
	if IsValidAlive(nil, target) then
		caster:LockTargetForSpeed(target, CAST_POINT, TURN_SPEED)
	end
end
function roshan_004.prototype.SummonDragons(self)
	local caster = self:GetCaster()
	if not IsValidAlive(nil, caster) then
		return
	end
	local origin = caster:GetAbsOrigin()
	local forward = self:GetPlanarForward(caster)
	local ____opt_0 = caster.GetRoomId
	local roomId = ____opt_0 and ____opt_0(caster)
	local summonTag = (SUMMON_TAG .. "_") .. tostring(caster:entindex())
	EmitSoundOn(SUMMON_SOUND, caster)
	do
		local index = 0
		while index < SUMMON_COUNT do
			local currentIndex = index
			local angleOffset = (currentIndex - (SUMMON_COUNT - 1) / 2) * SUMMON_ANGLE_INTERVAL
			local currentDirection = RotateVector2D(nil, forward, angleOffset):Normalized()
			local rawSpawnPos = origin:__add(currentDirection:__mul(SUMMON_DISTANCE))
			local currentSpawnPos = GetGroundPosition(rawSpawnPos, caster)
			local currentForward = Vector(forward.x, forward.y, 0):Normalized()
			self:PlaySummonEffect(currentSpawnPos, caster)
			MyGameUnit:CreateSummonedUnitAsync({
				unitName = SUMMON_UNIT_NAME,
				summonTag = summonTag,
				maxSummons = SUMMON_COUNT,
				position = currentSpawnPos,
				roomId = roomId,
				team = caster:GetTeamNumber(),
				owner = caster,
				summoner = caster,
				destroyWithSummoner = true,
				findClearSpace = true,
				onSpawn = function(____, unit)
					if not unit or not IsValidAlive(nil, unit) then
						return
					end
					if not IsValidAlive(nil, caster) then
						MyGameUnit:DestroyUnit(unit)
						return
					end
					unit:SetForwardVectorWithoutInterrupt(currentForward)
					unit:StartGestureWithPlaybackRate(ACT_DOTA_SPAWN, 0.8)
					unit:AddNewModifier(unit, self, "modifier_monster_born", { duration = 1 })
				end,
			})
			index = index + 1
		end
	end
end
function roshan_004.prototype.GetPlanarForward(self, caster)
	local forward = caster:GetForwardVector()
	local planarForward = Vector(forward.x, forward.y, 0)
	local ____temp_2
	if planarForward:Length2D() > 0.01 then
		____temp_2 = planarForward:Normalized()
	else
		____temp_2 = Vector(1, 0, 0)
	end
	return ____temp_2
end
function roshan_004.prototype.PlaySummonEffect(self, position, caster)
	local effect = ParticleManager:CreateParticle(SUMMON_EFFECT, PATTACH_WORLDORIGIN, caster)
	ParticleManager:SetParticleControl(effect, 0, position)
	ParticleManager:SetParticleControl(effect, 3, position)
	ParticleManager:SetParticleShouldCheckFoW(effect, false)
	ParticleManager:ReleaseParticleIndex(effect)
end
roshan_004 = __TS__DecorateLegacy({ registerAbility(nil) }, roshan_004)
____exports.roshan_004 = roshan_004
return ____exports