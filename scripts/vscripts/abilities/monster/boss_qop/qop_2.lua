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
local PARTICLE_PROJECTILE = "particles/qop/qop_proj1.vpcf"
local PARTICLE_WARNING = "particles/qop/qop_range.vpcf"
local PARTICLE_POOL = "particles/qop/vip_1.vpcf"
local SONIC_WAVE_PARTICLE = "particles/econ/items/queen_of_pain/qop_arcana/qop_arcana_sonic_wave.vpcf"
local SONIC_WAVE_DISTANCE = 1200
local SONIC_WAVE_SPEED = 1200
local SONIC_WAVE_START_RANGE = 100
local SONIC_WAVE_END_RANGE = 300
local SONIC_WAVE_DAMAGE_RATE = 15
local SONIC_WAVE_INTERVAL = 0.7
local SONIC_WAVE_CAST_DURATION = SONIC_WAVE_INTERVAL * 2 + 0.8
local SONIC_WAVE_STRIKE_ANGLES = { 6, -6, 0 }
local M013_POWER_METEOR_UNIT_NAME = "monster_11316_meteor"
____exports.qop_2 = __TS__Class()
local qop_2 = ____exports.qop_2
qop_2.name = "qop_2"
__TS__ClassExtends(qop_2, MonsterAbility_CS)
function qop_2.prototype.Precache(self, context)
	PrecacheResource("particle", PARTICLE_PROJECTILE, context)
	PrecacheResource("particle", PARTICLE_WARNING, context)
	PrecacheResource("particle", PARTICLE_POOL, context)
end
function qop_2.prototype.GetMosnterAbilityConfig(self)
	return {
		behavior = DOTA_ABILITY_BEHAVIOR_NO_TARGET,
		castPoint = 0.7,
		castDuration = SONIC_WAVE_CAST_DURATION,
		castAnimation = ACT_DOTA_CAST_ABILITY_4,
		animationPlaybackRate = 0.7,
		isNotMove = true,
		OnPhaseStart = function()
			local caster = self:GetCaster()
			caster:EmitSound("Hero_QueenOfPain.ProjectileImpact")
			local target = caster:GetMinDistanceUnit(2000)
			if target then
				caster:LockTargetForSpeed(target, 2, 4)
			end
			local origin = caster:GetAbsOrigin()
			local endPos = origin:__add(caster:GetForwardVector():__mul(400))
			self:WarningEffect(origin, endPos, 0.7, {
				startWidth = 100,
				endWidth = 400,
				getDirection = function()
					return caster:GetForwardVector()
				end,
			})
		end,
		OnStart = function()
			local caster = self:GetCaster()
			local function fireProjectile(____, direction)
				caster:EmitSound("Hero_QueenOfPain.ScreamOfPain")
				local startPoint = caster:GetAbsOrigin():__add(Vector(0, 0, 50))
				CreateProjectile(nil, {
					ability = self,
					caster = caster,
					effect_name = SONIC_WAVE_PARTICLE,
					direction = direction,
					start_point = startPoint,
					projectile_type = "linear",
					projectile_speed = SONIC_WAVE_SPEED,
					projectile_target_team = DOTA_UNIT_TARGET_TEAM_BOTH,
					projectile_target_type = bit.bor(
						bit.bor(DOTA_UNIT_TARGET_HERO, DOTA_UNIT_TARGET_BASIC),
						DOTA_UNIT_TARGET_OTHER
					),
					projectile_target_flags = DOTA_UNIT_TARGET_FLAG_NONE,
					projectile_distance = SONIC_WAVE_DISTANCE,
					projectile_range = SONIC_WAVE_START_RANGE,
					projectile_end_range = SONIC_WAVE_END_RANGE,
					on_hit = function(____, hitTarget)
						if not hitTarget or not IsValidAlive(nil, hitTarget) then
							return true
						end
						if not IsValidAlive(nil, caster) then
							return true
						end
						if self:TryBlockSonicWaveByMeteor(caster, hitTarget) then
							return true
						end
						if hitTarget:GetTeamNumber() == caster:GetTeamNumber() then
							return false
						end
						caster:EmitSound("Hero_QueenOfPain.ProjectileImpact")
						caster:MonsterDamage({
							victim = hitTarget,
							damage_rate = SONIC_WAVE_DAMAGE_RATE,
							ability = self,
						})
						hitTarget:KnockBack(caster, self, {
							origin_pos = caster:GetAbsOrigin(),
							duration = 0.1,
							stunDuration = 0.3,
							stun = true,
							distance = 150,
							height = 0,
						})
						return false
					end,
				})
			end
			local function fireWave(____, waveIndex)
				if not IsValidAlive(nil, caster) then
					return
				end
				local angle = SONIC_WAVE_STRIKE_ANGLES[waveIndex + 1] or 0
				local direction = RotateVector2D(nil, caster:GetForwardVector(), angle)
				fireProjectile(nil, direction)
			end
			fireWave(nil, 0)
			caster:StartGestureWithPlaybackRate(ACT_DOTA_CAST_ABILITY_4, 0.7)
			Timers:CreateTimer(SONIC_WAVE_INTERVAL, function()
				fireWave(nil, 1)
				caster:StartGestureWithPlaybackRate(ACT_DOTA_CAST_ABILITY_4, 0.7)
			end)
			Timers:CreateTimer(SONIC_WAVE_INTERVAL * 2, function()
				fireWave(nil, 2)
			end)
		end,
	}
end
function qop_2.prototype.TryBlockSonicWaveByMeteor(self, caster, hitTarget)
	local ____this_1
	____this_1 = hitTarget
	local ____opt_0 = ____this_1.GetUnitName
	if (____opt_0 and ____opt_0(____this_1)) ~= M013_POWER_METEOR_UNIT_NAME then
		return false
	end
	if not IsValidAlive(nil, caster) then
		return false
	end
	local ____this_3
	____this_3 = caster
	local ____opt_2 = ____this_3.GetRoomId
	local roomId = ____opt_2 and ____opt_2(____this_3)
	if roomId ~= nil and roomId ~= nil then
		local room = MyGameRoomManager:GetRoom(roomId)
		local ____opt_4 = room and room.TryDestroyPowerMeteorMonsterByQop2
		if (____opt_4 and ____opt_4(room, hitTarget)) == true then
			return true
		end
	end
	if hitTarget.__qop_meteor_fallback_blocker__ ~= true then
		return false
	end
	SafeRemoveUnit(nil, hitTarget)
	return true
end
qop_2 = __TS__DecorateLegacy({ registerAbility(nil) }, qop_2)
____exports.qop_2 = qop_2
return ____exports