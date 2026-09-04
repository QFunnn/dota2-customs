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
local CAST_POINT = 2
local CAST_DURATION = 0
local SPEAR_COUNT = 7
local FAN_ANGLE = 7 * 20
local SPEAR_DISTANCE = 1500
local SPEAR_START_OFFSET = 60
local SPEAR_WIDTH = 100
local SPEAR_SPEED = 2300
local DAMAGE_RATE = 30
local MARS_SPEAR_PARTICLE = "particles/units/heroes/hero_mars/mars_spear_2.vpcf"
local MARS_SPEAR_SOUND_EVENTS = "soundevents/game_sounds_heroes/game_sounds_mars.vsndevts"
local MARS_SPEAR_CAST_SOUND = "Hero_Mars.Spear.Cast"
local MARS_SPEAR_PROJECTILE_SOUND = "Hero_Mars.Spear"
local MARS_SPEAR_HIT_SOUND = "Hero_Mars.Spear.Target"
--- 精英技能9 - 蓄力后面前 180 度 6 支长矛
____exports.elite_009 = __TS__Class()
local elite_009 = ____exports.elite_009
elite_009.name = "elite_009"
__TS__ClassExtends(elite_009, MonsterAbility_CS)
function elite_009.prototype.____constructor(self, ...)
	MonsterAbility_CS.prototype.____constructor(self, ...)
	self._precastSpears = {}
	self._interrupted = false
end
function elite_009.prototype.Precache(self, context)
	PrecacheResource("particle", MARS_SPEAR_PARTICLE, context)
	PrecacheResource("soundfile", MARS_SPEAR_SOUND_EVENTS, context)
end
function elite_009.prototype.GetMosnterAbilityConfig(self)
	return {
		castRange = SPEAR_DISTANCE,
		castPoint = CAST_POINT,
		castDuration = CAST_DURATION,
		behavior = DOTA_ABILITY_BEHAVIOR_NO_TARGET,
		castAnimation = ACT_DOTA_CAST_ABILITY_1,
		animationPlaybackRate = 0.5,
		OnInterrupt = function()
			self:ClearPrecastSpears()
			self._interrupted = true
		end,
		OnPhaseStart = function()
			local caster = self:GetCaster()
			local target = caster:GetMinDistanceUnit(1500)
			local forward = caster:GetForwardVector()
			if target then
				forward = GetDirection(nil, target:GetAbsOrigin(), caster:GetAbsOrigin())
				caster:SetForwardVector(forward)
			end
			local origin = caster:GetAbsOrigin()
			local interval = FAN_ANGLE / (SPEAR_COUNT - 1)
			ScreenShake(caster:GetAbsOrigin(), 3, 3, 1, 1500, 0, true)
			do
				local i = 0
				while i < SPEAR_COUNT do
					local angle = -(FAN_ANGLE / 2) + interval * i
					local dir = RotateVector2D(nil, forward, angle)
					local startPos = origin:__add(dir:__mul(SPEAR_START_OFFSET))
					local endPos = origin:__add(dir:__mul(SPEAR_DISTANCE))
					local delay = i * 0.15
					self:Timer(delay, function()
						if self._interrupted then
							return
						end
						self:WarningEffect(
							startPos,
							endPos,
							CAST_POINT - delay,
							{ startWidth = SPEAR_WIDTH + 10, endWidth = SPEAR_WIDTH + 10 }
						)
						local spearPfx = ParticleManager:CreateParticle(MARS_SPEAR_PARTICLE, PATTACH_WORLDORIGIN, nil)
						local groundOrigin = GetGroundPosition(startPos, caster)
						local dirNorm = dir:Normalized()
						local cp1 = Vector(dirNorm.x, dirNorm.y, dirNorm.z):__mul(1)
						ParticleManager:SetParticleControl(spearPfx, 0, groundOrigin)
						ParticleManager:SetParticleControl(spearPfx, 1, cp1)
						local ____self__precastSpears_0 = self._precastSpears
						____self__precastSpears_0[#____self__precastSpears_0 + 1] = spearPfx
					end)
					i = i + 1
				end
			end
		end,
		OnStart = function()
			local caster = self:GetCaster()
			EmitSoundOn(MARS_SPEAR_CAST_SOUND, caster)
			EmitSoundOn(MARS_SPEAR_PROJECTILE_SOUND, caster)
			caster:StartGestureWithPlaybackRate(ACT_DOTA_CAST_ABILITY_1, 1)
			self:ClearPrecastSpears()
			local origin = caster:GetAbsOrigin()
			local forward = caster:GetForwardVector()
			local interval = FAN_ANGLE / (SPEAR_COUNT - 1)
			if self._interrupted then
				return
			end
			do
				local i = 0
				while i < SPEAR_COUNT do
					local angle = -(FAN_ANGLE / 2) + interval * i
					local dir = RotateVector2D(nil, forward, angle)
					local startPos = origin:__add(dir:__mul(SPEAR_START_OFFSET))
					local targetPos = origin:__add(dir:__mul(SPEAR_DISTANCE))
					CreateProjectile(nil, {
						ability = self,
						caster = caster,
						effect_name = MARS_SPEAR_PARTICLE,
						projectile_type = "linear",
						start_point = startPos,
						target = targetPos,
						projectile_speed = SPEAR_SPEED,
						projectile_distance = SPEAR_DISTANCE,
						projectile_range = SPEAR_WIDTH,
						projectile_target_team = DOTA_UNIT_TARGET_TEAM_ENEMY,
						projectile_target_type = DOTA_UNIT_TARGET_HEROES_AND_CREEPS,
						projectile_target_flags = DOTA_UNIT_TARGET_FLAG_NONE,
						on_hit = function(____, hitTarget)
							if not hitTarget or not IsValidAlive(nil, hitTarget) then
								return true
							end
							if not IsValidAlive(nil, caster) then
								return true
							end
							EmitSoundOn(MARS_SPEAR_HIT_SOUND, hitTarget)
							caster:MonsterDamage({ victim = hitTarget, damage_rate = DAMAGE_RATE, ability = self })
							AddDeBuffStatus(
								nil,
								hitTarget,
								caster,
								self,
								DebuffStatusType.ICE_SLOW,
								{ stack = 5, duration = 2 }
							)
							hitTarget:KnockBack(caster, self, {
								duration = 0.5,
								origin_pos = caster:GetAbsOrigin(),
								stun = true,
								distance = 120,
								height = 0,
							})
							return true
						end,
					})
					i = i + 1
				end
			end
		end,
	}
end
function elite_009.prototype.ClearPrecastSpears(self)
	if not IsServer() then
		return
	end
	for ____, pfx in ipairs(self._precastSpears) do
		ParticleManager:DestroyParticle(pfx, false)
		ParticleManager:ReleaseParticleIndex(pfx)
	end
	self._precastSpears = {}
end
elite_009 = __TS__DecorateLegacy({ registerAbility(nil) }, elite_009)
____exports.elite_009 = elite_009
return ____exports