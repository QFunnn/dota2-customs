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
local CAST_RANGE = 1400
local FIRE_TIME = 1.4
local CAST_POINT = FIRE_TIME
local FIRE_DELAY_AFTER_START = FIRE_TIME - CAST_POINT
local FIRE_ROUND_COUNT = 3
local FIRE_ROUND_INTERVAL = 0.6
local REPEAT_FIRE_WARNING_TIME = 0.4
local REPEAT_FIRE_ATTACK_LEAD_TIME = 0.2
local REPEAT_FIRE_ATTACK_PLAYBACK_RATE = 1.3
local FINAL_ROUND_PROJECTILE_COUNT = 3
local FINAL_ROUND_SPREAD_ANGLE = 12
local LAST_FIRE_TIME = FIRE_TIME + (FIRE_ROUND_COUNT - 1) * FIRE_ROUND_INTERVAL
local TOTAL_DURATION = LAST_FIRE_TIME + 0.4
local CAST_DURATION = TOTAL_DURATION - CAST_POINT
local PROJECTILE_DISTANCE = 1600
local PROJECTILE_RADIUS = 100
local PROJECTILE_SPEED = 3000
local PROJECTILE_SPAWN_FORWARD = 80
local PROJECTILE_SPAWN_HEIGHT = 110
local RECOIL_DISTANCE = 20
local EARLY_ROUND_RECOIL_SCALE = 0.5
local REAIM_AFTER_FIRE_TIME = 0.3
local DAMAGE_RATE = 14
local CHANNEL_EFFECT =
	"particles/econ/items/windrunner/windranger_arcana/windranger_arcana_powershot_channel_combo.vpcf"
local PROJECTILE_EFFECT = "particles/windranger_arcana_spell_powershot.vpcf"
local CHANNEL_SOUND = "Ability.PowershotPull.Mh_bow.layer"
local FIRE_SOUND = "Ability.Powershot.Alt"
local DAMAGE_SOUND = "Hero_Windrunner.PowershotDamage"
--- 普通技能38 - 堕落强弓：持续瞄准最近敌人，蓄力后发射穿透箭矢
____exports.normal_038_2 = __TS__Class()
local normal_038_2 = ____exports.normal_038_2
normal_038_2.name = "normal_038_2"
__TS__ClassExtends(normal_038_2, MonsterAbility_CS)
function normal_038_2.prototype.____constructor(self, ...)
	MonsterAbility_CS.prototype.____constructor(self, ...)
	self.fireToken = 0
end
function normal_038_2.prototype.Precache(self, context)
	PrecacheResource("particle", CHANNEL_EFFECT, context)
	PrecacheResource("particle", PROJECTILE_EFFECT, context)
end
function normal_038_2.prototype.GetMosnterAbilityConfig(self)
	return {
		behavior = DOTA_ABILITY_BEHAVIOR_NO_TARGET,
		castRange = CAST_RANGE,
		castPoint = CAST_POINT,
		castDuration = CAST_DURATION,
		castAnimation = ACT_DOTA_CAST_ABILITY_2,
		cooldown = 7,
		OnPhaseStart = function()
			local caster = self:GetCaster()
			if not IsValidAlive(nil, caster) then
				return
			end
			self:LockAndWarn(caster)
			self:StartChannelEffect(caster)
			EmitSoundOn(CHANNEL_SOUND, caster)
		end,
		OnStart = function()
			local caster = self:GetCaster()
			if not IsValidAlive(nil, caster) then
				return
			end
			self.fireToken = self.fireToken + 1
			local token = self.fireToken
			self:ScheduleFireRound(caster, token, 1)
		end,
		OnFinish = function()
			return self:ClearChannelEffect()
		end,
		OnInterrupt = function()
			return self:ClearChannelEffect()
		end,
	}
end
function normal_038_2.prototype.LockAndWarn(self, caster)
	self:LockNearestTarget(caster, FIRE_TIME - 0.1)
	local start = self:GetProjectileStart(caster)
	local ____end = start:__add(caster:GetForwardVector():__mul(PROJECTILE_DISTANCE))
	self:WarningEffect(start, ____end, FIRE_TIME + 0.15, {
		startWidth = PROJECTILE_RADIUS + 20,
		endWidth = PROJECTILE_RADIUS + 20,
		getDirection = function()
			return caster:GetForwardVector()
		end,
		type = 1,
		follow = true,
	})
end
function normal_038_2.prototype.StartChannelEffect(self, caster)
	self:ClearChannelParticle()
	local pfx = ParticleManager:CreateParticle(CHANNEL_EFFECT, PATTACH_POINT_FOLLOW, caster)
	ParticleManager:SetParticleControlEnt(
		pfx,
		0,
		caster,
		PATTACH_POINT_FOLLOW,
		"attach_attack1",
		caster:GetAbsOrigin() + caster:GetForwardVector() * 100,
		true
	)
	ParticleManager:SetParticleControlEnt(
		pfx,
		1,
		caster,
		PATTACH_CENTER_FOLLOW,
		"attach_attack1",
		caster:GetAbsOrigin() + caster:GetForwardVector() * 100,
		false
	)
	self.channelPfx = pfx
	self:UpdateChannelForward(caster, 0)
end
function normal_038_2.prototype.UpdateChannelForward(self, caster, elapsed)
	if self.channelPfx == nil or not IsValidAlive(nil, caster) then
		return
	end
	local forward = caster:GetForwardVector()
	ParticleManager:SetParticleControlForward(self.channelPfx, 0, forward)
	ParticleManager:SetParticleControlForward(self.channelPfx, 1, forward)
	if elapsed >= FIRE_TIME then
		return
	end
	return self:Timer(FrameTime(), function()
		return self:UpdateChannelForward(caster, elapsed + FrameTime())
	end)
end
function normal_038_2.prototype.ScheduleFireRound(self, caster, token, round)
	local ____temp_0
	if round == 1 then
		____temp_0 = FIRE_DELAY_AFTER_START
	else
		____temp_0 = FIRE_ROUND_INTERVAL
	end
	local delay = ____temp_0
	local warningTime = round == 1 and 0 or REPEAT_FIRE_WARNING_TIME
	local warningDelay = math.max(delay - warningTime, 0)
	self:Timer(warningDelay, function()
		if token ~= self.fireToken or not IsValidAlive(nil, caster) then
			return
		end
		local projectileCount = round >= FIRE_ROUND_COUNT and FINAL_ROUND_PROJECTILE_COUNT or 1
		if warningTime > 0 then
			self:ShowFireWarning(caster, projectileCount, warningTime)
			self:Timer(math.max(warningTime - REPEAT_FIRE_ATTACK_LEAD_TIME, 0), function()
				if token ~= self.fireToken or not IsValidAlive(nil, caster) then
					return
				end
				caster:StartGestureWithPlaybackRate(ACT_DOTA_ATTACK, REPEAT_FIRE_ATTACK_PLAYBACK_RATE)
			end)
		end
		self:Timer(warningTime, function()
			if token ~= self.fireToken or not IsValidAlive(nil, caster) then
				return
			end
			self:FireArrows(caster, projectileCount, round)
			local nextRound = round + 1
			if nextRound <= FIRE_ROUND_COUNT then
				self:ScheduleFireRound(caster, token, nextRound)
			end
		end)
	end)
end
function normal_038_2.prototype.ShowFireWarning(self, caster, projectileCount, duration)
	local start = self:GetProjectileStart(caster)
	do
		local index = 0
		while index < projectileCount do
			local currentIndex = index
			local angleOffset = self:GetProjectileAngleOffset(currentIndex, projectileCount)
			local direction = RotateVector2D(nil, caster:GetForwardVector(), angleOffset):Normalized()
			local ____end = start:__add(direction:__mul(PROJECTILE_DISTANCE))
			self:WarningEffect(
				start,
				____end,
				duration,
				{ startWidth = PROJECTILE_RADIUS + 20, endWidth = PROJECTILE_RADIUS + 20, type = 1 }
			)
			index = index + 1
		end
	end
end
function normal_038_2.prototype.FireArrows(self, caster, projectileCount, round)
	self:ClearChannelParticle()
	EmitSoundOn(FIRE_SOUND, caster)
	local ____temp_1
	if round < FIRE_ROUND_COUNT then
		____temp_1 = RECOIL_DISTANCE * EARLY_ROUND_RECOIL_SCALE
	else
		____temp_1 = RECOIL_DISTANCE
	end
	local recoilDistance = ____temp_1
	caster:Mover(caster:GetAbsOrigin():__add(caster:GetForwardVector():__mul(-recoilDistance)), 0.1)
	do
		local index = 0
		while index < projectileCount do
			local currentIndex = index
			local angleOffset = self:GetProjectileAngleOffset(currentIndex, projectileCount)
			local direction = RotateVector2D(nil, caster:GetForwardVector(), angleOffset):Normalized()
			self:FireArrow(caster, direction)
			index = index + 1
		end
	end
	self:LockNearestTarget(caster, REAIM_AFTER_FIRE_TIME)
	if projectileCount >= FINAL_ROUND_PROJECTILE_COUNT then
		self.lockedTargetIndex = nil
	end
end
function normal_038_2.prototype.FireArrow(self, caster, direction)
	local start = self:GetProjectileStart(caster)
	local target = start:__add(direction:__mul(PROJECTILE_DISTANCE)):__add(Vector(0, 0, 120))
	CreateProjectile(nil, {
		ability = self,
		caster = caster,
		effect_name = PROJECTILE_EFFECT,
		target = target,
		start_point = start,
		projectile_type = "linear",
		projectile_speed = PROJECTILE_SPEED,
		projectile_target_team = DOTA_UNIT_TARGET_TEAM_ENEMY,
		projectile_target_type = bit.bor(DOTA_UNIT_TARGET_HERO, DOTA_UNIT_TARGET_BASIC),
		projectile_target_flags = DOTA_UNIT_TARGET_FLAG_NONE,
		projectile_distance = PROJECTILE_DISTANCE,
		projectile_range = PROJECTILE_RADIUS,
		on_hit = function(____, hitTarget)
			if hitTarget and IsValidAlive(nil, hitTarget) then
				if not IsValidAlive(nil, caster) then
					return
				end
				EmitSoundOn(DAMAGE_SOUND, hitTarget)
				caster:MonsterDamage({ victim = hitTarget, damage_rate = DAMAGE_RATE, ability = self })
				hitTarget:KnockBack(caster, self, {
					origin_pos = caster:GetAbsOrigin(),
					duration = 0.1,
					stunDuration = 0.1,
					stun = true,
					distance = 50,
				})
				return false
			end
			return true
		end,
	})
end
function normal_038_2.prototype.GetProjectileAngleOffset(self, index, projectileCount)
	if projectileCount <= 1 then
		return 0
	end
	local centerIndex = (projectileCount - 1) / 2
	return (index - centerIndex) * FINAL_ROUND_SPREAD_ANGLE
end
function normal_038_2.prototype.LockNearestTarget(self, caster, duration)
	local target = caster:GetMinDistanceUnit(CAST_RANGE)
	if IsValidAlive(nil, target) then
		self.lockedTargetIndex = target:entindex()
		caster:LockTargetForSpeed(target, duration)
	end
end
function normal_038_2.prototype.GetProjectileStart(self, caster)
	return caster
		:GetAbsOrigin()
		:__add(caster:GetForwardVector():__mul(PROJECTILE_SPAWN_FORWARD))
		:__add(Vector(0, 0, PROJECTILE_SPAWN_HEIGHT))
end
function normal_038_2.prototype.ClearChannelEffect(self)
	self.fireToken = self.fireToken + 1
	self:ClearChannelParticle()
	self.lockedTargetIndex = nil
end
function normal_038_2.prototype.ClearChannelParticle(self)
	if self.channelPfx ~= nil then
		ParticleManager:DestroyParticle(self.channelPfx, false)
		ParticleManager:ReleaseParticleIndex(self.channelPfx)
		self.channelPfx = nil
	end
end
normal_038_2 = __TS__DecorateLegacy({ registerAbility(nil) }, normal_038_2)
____exports.normal_038_2 = normal_038_2
return ____exports