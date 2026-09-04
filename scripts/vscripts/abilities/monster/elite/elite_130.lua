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
local CAST_POINT = 2.3
local CAST_DURATION = 0
local SPEAR_DISTANCE = 1600
local LOCK_RANGE = SPEAR_DISTANCE
local SPEAR_START_OFFSET = 60
local SPEAR_RIGHT_OFFSET = -70
local SPEAR_WIDTH = 100
local SPEAR_SPEED = 2600
local DAMAGE_RATE = 20
local PRECAST_SPEAR_UPDATE_INTERVAL = 0.03
local PRECAST_SPEAR_RECREATE_DOT = 0.999
local MARS_SPEAR_PARTICLE = "particles/units/heroes/hero_mars/mars_spear_2.vpcf"
local MARS_SPEAR_SOUND_EVENTS = "soundevents/game_sounds_heroes/game_sounds_mars.vsndevts"
local MARS_SPEAR_PROJECTILE_SOUND = "Hero_Mars.Spear"
--- 精英技能130 - 蓄力后向前方投掷一支长矛
____exports.elite_130 = __TS__Class()
local elite_130 = ____exports.elite_130
elite_130.name = "elite_130"
__TS__ClassExtends(elite_130, MonsterAbility_CS)
function elite_130.prototype.____constructor(self, ...)
	MonsterAbility_CS.prototype.____constructor(self, ...)
	self._precastSpearMonitorToken = 0
	self._interrupted = false
end
function elite_130.prototype.Precache(self, context)
	PrecacheResource("particle", MARS_SPEAR_PARTICLE, context)
	PrecacheResource("soundfile", MARS_SPEAR_SOUND_EVENTS, context)
end
function elite_130.prototype.GetMosnterAbilityConfig(self)
	return {
		castRange = SPEAR_DISTANCE,
		castPoint = CAST_POINT,
		castDuration = 1.5,
		behavior = DOTA_ABILITY_BEHAVIOR_NO_TARGET,
		castAnimation = ACT_DOTA_CAST_ABILITY_3,
		animationPlaybackRate = 0.5,
		OnInterrupt = function()
			self:ClearPrecastSpear()
			self._interrupted = true
		end,
		OnPhaseStart = function()
			local caster = self:GetCaster()
			local origin = caster:GetAbsOrigin()
			local target = self:GetMinDistanceUnit(LOCK_RANGE, origin)
			if IsValidAlive(nil, target) then
				caster:LockTargetForSpeed(target, CAST_POINT - 0.1)
			end
			local forward = caster:GetForwardVector():Normalized()
			local startPos = self:GetSpearStartPosition(caster, origin, forward)
			local endPos = origin:__add(forward:__mul(SPEAR_DISTANCE))
			self._interrupted = false
			self:ClearPrecastSpear()
			ScreenShake(caster:GetAbsOrigin(), 3, 3, 1, 1500, 0, true)
			self:WarningEffect(startPos, endPos, CAST_POINT, {
				startWidth = SPEAR_WIDTH + 10,
				endWidth = SPEAR_WIDTH + 10,
				getDirection = function()
					return caster:GetForwardVector()
				end,
			})
			self:UpdatePrecastSpear(caster, true)
			self:StartPrecastSpearMonitor(caster)
		end,
		OnStart = function()
			local caster = self:GetCaster()
			local origin = caster:GetAbsOrigin()
			local forward = caster:GetForwardVector():Normalized()
			local startPos = self:GetSpearStartPosition(caster, origin, forward)
			local targetPos = origin:__add(forward:__mul(SPEAR_DISTANCE))
			if self._interrupted then
				return
			end
			EmitSoundOn(MARS_SPEAR_PROJECTILE_SOUND, caster)
			caster:StartGestureWithPlaybackRate(ACT_DOTA_CAST_ABILITY_1, 1)
			ScreenShake(caster:GetAbsOrigin(), 8, 8, 0.3, 2000, 0, true)
			self:Timer(0.2, function()
				self:ClearPrecastSpear()
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
			end)
		end,
	}
end
function elite_130.prototype.ClearPrecastSpear(self)
	if not IsServer() then
		return
	end
	self._precastSpearMonitorToken = self._precastSpearMonitorToken + 1
	if self._precastSpear == nil then
		return
	end
	ParticleManager:DestroyParticle(self._precastSpear, false)
	ParticleManager:ReleaseParticleIndex(self._precastSpear)
	self._precastSpear = nil
	self._precastSpearForward = nil
end
function elite_130.prototype.StartPrecastSpearMonitor(self, caster)
	if not IsServer() then
		return
	end
	self._precastSpearMonitorToken = self._precastSpearMonitorToken + 1
	local token = self._precastSpearMonitorToken
	Timers:CreateTimer(PRECAST_SPEAR_UPDATE_INTERVAL, function()
		if token ~= self._precastSpearMonitorToken then
			return
		end
		if self._precastSpear == nil then
			return
		end
		if not IsValidAlive(nil, caster) then
			self:ClearPrecastSpear()
			return
		end
		if not self._interrupted then
			self:UpdatePrecastSpear(caster)
		end
		return PRECAST_SPEAR_UPDATE_INTERVAL
	end)
end
function elite_130.prototype.UpdatePrecastSpear(self, caster, forceRecreate)
	if forceRecreate == nil then
		forceRecreate = false
	end
	if not IsValidAlive(nil, caster) then
		return
	end
	local forward = self:GetFlatForward(caster)
	local startPos = self:GetSpearStartPosition(caster, caster:GetAbsOrigin(), forward)
	local groundOrigin = GetGroundPosition(startPos, caster)
	if forceRecreate or self:ShouldRecreatePrecastSpear(forward) then
		self:RecreatePrecastSpear(groundOrigin, forward)
		return
	end
	if self._precastSpear == nil then
		return
	end
	self:ApplyPrecastSpearControls(self._precastSpear, groundOrigin, forward)
end
function elite_130.prototype.RecreatePrecastSpear(self, origin, forward)
	self:DestroyPrecastSpearImmediately()
	local spearPfx = ParticleManager:CreateParticle(MARS_SPEAR_PARTICLE, PATTACH_WORLDORIGIN, nil)
	ParticleManager:SetParticleShouldCheckFoW(spearPfx, false)
	self._precastSpear = spearPfx
	self._precastSpearForward = Vector(forward.x, forward.y, forward.z)
	self:ApplyPrecastSpearControls(spearPfx, origin, forward)
end
function elite_130.prototype.ApplyPrecastSpearControls(self, spearPfx, origin, forward)
	local cp1 = Vector(forward.x, forward.y, forward.z):__mul(1)
	ParticleManager:SetParticleControl(spearPfx, 0, origin)
	ParticleManager:SetParticleControl(spearPfx, 1, cp1)
	ParticleManager:SetParticleControlForward(spearPfx, 1, forward)
	ParticleManager:SetParticleControlTransformForward(spearPfx, 0, origin, forward)
	ParticleManager:SetParticleControlForward(spearPfx, 0, forward)
end
function elite_130.prototype.ShouldRecreatePrecastSpear(self, forward)
	if self._precastSpear == nil then
		return true
	end
	if self._precastSpearForward == nil then
		return true
	end
	local dot = self._precastSpearForward.x * forward.x + self._precastSpearForward.y * forward.y
	return dot < PRECAST_SPEAR_RECREATE_DOT
end
function elite_130.prototype.DestroyPrecastSpearImmediately(self)
	if self._precastSpear == nil then
		return
	end
	ParticleManager:DestroyParticle(self._precastSpear, true)
	ParticleManager:ReleaseParticleIndex(self._precastSpear)
	self._precastSpear = nil
	self._precastSpearForward = nil
end
function elite_130.prototype.GetFlatForward(self, caster)
	local rawForward = caster:GetForwardVector()
	local flatForward = Vector(rawForward.x, rawForward.y, 0)
	if flatForward:Length2D() <= 0.001 then
		return Vector(1, 0, 0)
	end
	return flatForward:Normalized()
end
function elite_130.prototype.GetSpearStartPosition(self, caster, origin, forward)
	local rawRight = caster:GetRightVector()
	local right = Vector(rawRight.x, rawRight.y, 0)
	local ____temp_0
	if right:Length2D() <= 0.001 then
		____temp_0 = Vector(-forward.y, forward.x, 0)
	else
		____temp_0 = right:Normalized()
	end
	local flatRight = ____temp_0
	return origin:__add(forward:__mul(SPEAR_START_OFFSET)):__add(flatRight:__mul(SPEAR_RIGHT_OFFSET))
end
elite_130 = __TS__DecorateLegacy({ registerAbility(nil) }, elite_130)
____exports.elite_130 = elite_130
return ____exports