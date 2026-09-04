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
local LOOP_COUNT = 2
local STOMP_DURATION = 1.2
local STOMP_ACTION_POINT = 0.65
local WAVE_ACTION_DURATION = 2.5
local WAVE_ACTION_POINT = 1.3
local WAVE_LOCK_DURATION = WAVE_ACTION_DURATION / 2
local WAVE_LENGTH = 1000
local WAVE_HALF_ANGLE_DEG = 50
local WAVE_LINE_ANGLES = {
	-50,
	-30,
	-10,
	10,
	30,
	50,
}
local WAVE_DAMAGE_RATE = 30
local WAVE_JUMP_DURATION = 0.2
local WAVE_JUMP_MAX_DISTANCE = 600
local WAVE_JUMP_TARGET_OFFSET = 150
local WAVE_JUMP_HEIGHT = 350
local STOMP_RADIUS = 400
local STOMP_DAMAGE_RATE = 30
local STOMP_KNOCKUP_DURATION = 0.5
local STOMP_KNOCKUP_HEIGHT = 450
local CAST_DURATION = LOOP_COUNT * (STOMP_DURATION + WAVE_ACTION_DURATION)
local STOMP_PARTICLE = "particles/dd/kk_kunkka_spell_torrent_splash.vpcf"
local WAVE_PARTICLE = "particles/unit/elite_032.vpcf"
local WAVE_CAST_SOUND = "Hero_Magnataur.ShockWave.Cast"
local WAVE_FLY_SOUND = "Hero_Magnataur.ShockWave.Particle"
--- 精英技能33 - 踩地板与前方发波交替循环 2 组
____exports.elite_033 = __TS__Class()
local elite_033 = ____exports.elite_033
elite_033.name = "elite_033"
__TS__ClassExtends(elite_033, MonsterAbility_CS)
function elite_033.prototype.Precache(self, context)
	PrecacheResource("particle", STOMP_PARTICLE, context)
	PrecacheResource("particle", WAVE_PARTICLE, context)
end
function elite_033.prototype.GetMosnterAbilityConfig(self)
	return {
		behavior = DOTA_ABILITY_BEHAVIOR_NO_TARGET,
		castPoint = 0.1,
		castDuration = CAST_DURATION,
		castAnimation = "",
		OnStart = function()
			local caster = self:GetCaster()
			if not IsValidAlive(nil, caster) then
				return
			end
			do
				local i = 0
				while i < LOOP_COUNT do
					local loopStart = i * (STOMP_DURATION + WAVE_ACTION_DURATION)
					self:Timer(loopStart, function()
						return self:StartStomp()
					end)
					self:Timer(loopStart + STOMP_ACTION_POINT, function()
						return self:PlayStomp()
					end)
					self:Timer(loopStart + STOMP_DURATION, function()
						return self:StartWave()
					end)
					self:Timer(loopStart + STOMP_DURATION + WAVE_ACTION_POINT - WAVE_JUMP_DURATION, function()
						return self:JumpBeforeWave()
					end)
					self:Timer(loopStart + STOMP_DURATION + WAVE_ACTION_POINT, function()
						return self:FireWave()
					end)
					i = i + 1
				end
			end
		end,
	}
end
function elite_033.prototype.StartStomp(self)
	local caster = self:GetCaster()
	if not IsValidAlive(nil, caster) then
		return
	end
	caster:StartGestureWithPlaybackRate(ACT_DOTA_CAST_ABILITY_2, 2)
	self:WarningRingEffect(caster:GetAbsOrigin(), STOMP_RADIUS, STOMP_ACTION_POINT)
	caster:EmitSound("Hero_Bloodseeker.BloodRite.Cast")
	caster:EmitSound("hero_bloodseeker.bloodRite")
end
function elite_033.prototype.PlayStomp(self)
	local caster = self:GetCaster()
	if not IsValidAlive(nil, caster) then
		return
	end
	local origin = caster:GetAbsOrigin():__add(Vector(0, 0, 96))
	local pfx = ParticleManager:CreateParticle(STOMP_PARTICLE, PATTACH_ABSORIGIN_FOLLOW, caster)
	ParticleManager:SetParticleControl(pfx, 0, origin)
	ParticleManager:ReleaseParticleIndex(pfx)
	EmitSoundOnLocationWithCaster(origin, "Ability.Torrent", caster)
	EmitSoundOnLocationWithCaster(origin, "hero_bloodseeker.bloodRite.silence", caster)
	self:DamageStomp(caster, caster:GetAbsOrigin())
end
function elite_033.prototype.DamageStomp(self, caster, origin)
	local enemies = FindUnitsInRadius(
		caster:GetTeamNumber(),
		origin,
		nil,
		STOMP_RADIUS,
		DOTA_UNIT_TARGET_TEAM_ENEMY,
		DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,
		DOTA_UNIT_TARGET_FLAG_NONE,
		FIND_ANY_ORDER,
		false
	)
	for ____, enemy in ipairs(enemies) do
		do
			if not IsValidAlive(nil, enemy) then
				goto __continue17
			end
			caster:MonsterDamage({ victim = enemy, damage_rate = STOMP_DAMAGE_RATE, ability = self })
			enemy:KnockBack(caster, self, {
				duration = STOMP_KNOCKUP_DURATION,
				distance = 0,
				height = STOMP_KNOCKUP_HEIGHT,
				particleName = "",
				stun = true,
			})
		end
		::__continue17::
	end
end
function elite_033.prototype.StartWave(self)
	local caster = self:GetCaster()
	if not IsValidAlive(nil, caster) then
		return
	end
	caster:SetAnimation("attack1_anim")
	local target = caster:GetMinDistanceUnit(WAVE_LENGTH)
	if IsValidAlive(nil, target) then
		caster:LockTargetForSpeed(target, WAVE_LOCK_DURATION)
	end
end
function elite_033.prototype.FireWave(self)
	local caster = self:GetCaster()
	if not IsValidAlive(nil, caster) then
		return
	end
	local origin = caster:GetAbsOrigin()
	local forward = caster:GetForwardVector()
	EmitSoundOn(WAVE_CAST_SOUND, caster)
	EmitSoundOn(WAVE_FLY_SOUND, caster)
	self:PlayWaveEffect(origin, forward)
	self:DrawWaveDebug(origin, forward)
	self:DamageWave(caster, origin, forward)
end
function elite_033.prototype.JumpBeforeWave(self)
	local caster = self:GetCaster()
	if not IsValidAlive(nil, caster) then
		return
	end
	local lockTarget = caster:GetMinDistanceUnit(WAVE_LENGTH)
	if not IsValidAlive(nil, lockTarget) then
		return
	end
	caster:LockTargetForSpeed(lockTarget, WAVE_JUMP_DURATION, 12)
	local origin = caster:GetAbsOrigin()
	local targetPos = lockTarget:GetAbsOrigin()
	local direction = GetDirection(nil, targetPos, origin)
	local distance = math.min(GetDistance(nil, origin, targetPos), WAVE_JUMP_MAX_DISTANCE)
	local jumpDistance = math.max(distance - WAVE_JUMP_TARGET_OFFSET, 0)
	local landPos = origin:__add(direction:__mul(jumpDistance))
	local peak = origin:__add(Vector(0, 0, WAVE_JUMP_HEIGHT))
	caster:Bezier2Mover({ origin, peak, landPos }, WAVE_JUMP_DURATION, nil, true, true)
end
function elite_033.prototype.PlayWaveEffect(self, origin, forward)
	local pfx = ParticleManager:CreateParticle(WAVE_PARTICLE, PATTACH_WORLDORIGIN, nil)
	ParticleManager:SetParticleControlTransformForward(pfx, 0, origin, forward)
	ParticleManager:SetParticleControl(pfx, 11, Vector(WAVE_LENGTH, 0, 0))
	Timers:CreateTimer(WAVE_ACTION_POINT, function()
		ParticleManager:DestroyParticle(pfx, true)
		ParticleManager:ReleaseParticleIndex(pfx)
	end)
end
function elite_033.prototype.DamageWave(self, caster, origin, forward)
	local minDot = math.cos(math.rad(WAVE_HALF_ANGLE_DEG))
	local enemies = FindUnitsInRadius(
		caster:GetTeamNumber(),
		origin,
		nil,
		WAVE_LENGTH,
		DOTA_UNIT_TARGET_TEAM_ENEMY,
		DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,
		DOTA_UNIT_TARGET_FLAG_NONE,
		FIND_ANY_ORDER,
		false
	)
	for ____, enemy in ipairs(enemies) do
		do
			if not IsValidAlive(nil, enemy) then
				goto __continue31
			end
			local delta = enemy:GetAbsOrigin():__sub(origin)
			local distance = delta:Length2D()
			if distance <= 0.01 or distance > WAVE_LENGTH then
				goto __continue31
			end
			local direction = Vector(delta.x / distance, delta.y / distance, 0)
			local dot = forward.x * direction.x + forward.y * direction.y
			if dot < minDot then
				goto __continue31
			end
			caster:MonsterDamage({ victim = enemy, damage_rate = WAVE_DAMAGE_RATE, ability = self })
		end
		::__continue31::
	end
end
function elite_033.prototype.DrawWaveDebug(self, origin, forward)
	local leftOuterEnd
	local rightOuterEnd
	for ____, angle in ipairs(WAVE_LINE_ANGLES) do
		local dir = RotatePosition(Vector(0, 0, 0), QAngle(0, angle, 0), forward)
		local ____end = origin:__add(dir:__mul(WAVE_LENGTH))
		local debugEnd = ____end:__add(Vector(0, 0, 32))
		if angle == -WAVE_HALF_ANGLE_DEG then
			leftOuterEnd = debugEnd
		elseif angle == WAVE_HALF_ANGLE_DEG then
			rightOuterEnd = debugEnd
		end
	end
	if leftOuterEnd and rightOuterEnd then
	end
end
elite_033 = __TS__DecorateLegacy({ registerAbility(nil) }, elite_033)
____exports.elite_033 = elite_033
return ____exports