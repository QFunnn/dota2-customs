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
local Set = ____lualib.Set
local __TS__New = ____lualib.__TS__New
local __TS__DecorateLegacy = ____lualib.__TS__DecorateLegacy
local ____exports = {}
local ____dota_ts_adapter = require("utils.dota_ts_adapter")
local registerAbility = ____dota_ts_adapter.registerAbility
local ____monster_base = require("abilities.monster.monster_base")
local MonsterAbility_CS = ____monster_base.MonsterAbility_CS
local ELITE_040_TOTAL_ACTION_TIME = 3
local ELITE_040_IMPACT_TIME = 1.57
local ELITE_040_LOCK_DURATION = 1
local ELITE_040_CAST_DURATION = ELITE_040_TOTAL_ACTION_TIME - ELITE_040_IMPACT_TIME
local ELITE_040_TARGET_SEARCH_RANGE = 1000
local ELITE_040_WAVE_LENGTH = 1200
local ELITE_040_WAVE_HALF_ANGLE_DEG = 50
local ELITE_040_WAVE_DAMAGE_RATE = 15
local ELITE_040_WAVE_STUN_DURATION = 1.4
local ELITE_040_SPIN_PLAYBACK_RATE = 1
local ELITE_040_SPIN_BASE_DURATION = 3.17
local ELITE_040_SPIN_BASE_START_TIME = 1
local ELITE_040_SPIN_BASE_END_TIME = 1.8
local ELITE_040_SPIN_DURATION = ELITE_040_SPIN_BASE_DURATION / ELITE_040_SPIN_PLAYBACK_RATE
local ELITE_040_SPIN_IMPACT_TIME = ELITE_040_SPIN_BASE_START_TIME / ELITE_040_SPIN_PLAYBACK_RATE
local ELITE_040_SPIN_ACTIVE_DURATION = (ELITE_040_SPIN_BASE_END_TIME - ELITE_040_SPIN_BASE_START_TIME)
	/ ELITE_040_SPIN_PLAYBACK_RATE
local ELITE_040_SPIN_RADIUS = 500
local ELITE_040_SPIN_MOVE_DISTANCE = 700
local ELITE_040_SPIN_DAMAGE_RATE = 40
local ELITE_040_SPIN_KNOCKBACK_DISTANCE = 280
local ELITE_040_SPIN_KNOCKBACK_DURATION = 0.3
local ELITE_040_SPIN_KNOCKBACK_HEIGHT = 100
local ELITE_040_WAVE_PARTICLE = "particles/unit/elite_032.vpcf"
local ELITE_040_SPIN_PARTICLE = "particles/unit/elite_040.vpcf"
local ELITE_040_WAVE_CAST_SOUND = "Hero_Magnataur.ShockWave.Cast"
local ELITE_040_WAVE_FLY_SOUND = "Hero_Magnataur.ShockWave.Particle"
--- 精英技能40 - 锁敌蓄力后发出眩晕冲击波，再旋转冲刺撞击
____exports.elite_040 = __TS__Class()
local elite_040 = ____exports.elite_040
elite_040.name = "elite_040"
__TS__ClassExtends(elite_040, MonsterAbility_CS)
function elite_040.prototype.Precache(self, context)
	PrecacheResource("particle", ELITE_040_WAVE_PARTICLE, context)
	PrecacheResource("particle", ELITE_040_SPIN_PARTICLE, context)
end
function elite_040.prototype.GetMosnterAbilityConfig(self)
	return {
		behavior = DOTA_ABILITY_BEHAVIOR_NO_TARGET,
		castRange = ELITE_040_TARGET_SEARCH_RANGE,
		castPoint = ELITE_040_IMPACT_TIME,
		castDuration = 3.2,
		castAnimation = ACT_DOTA_CAST_ABILITY_1,
		OnPhaseStart = function()
			local caster = self:GetCaster()
			if not IsValidAlive(nil, caster) then
				return
			end
			local endPos = caster:GetAbsOrigin():__add(caster:GetForwardVector():__mul(500))
			self:WarningEffect(caster:GetAbsOrigin(), endPos, ELITE_040_IMPACT_TIME, {
				startWidth = 200,
				endWidth = 700,
				getDirection = function()
					return caster:GetForwardVector()
				end,
			})
			self:Timer(0.1, function()
				local target = caster:GetMinDistanceUnit(ELITE_040_TARGET_SEARCH_RANGE)
				if not IsValidAlive(nil, target) then
					return
				end
				caster:LockTargetForSpeed(target, ELITE_040_LOCK_DURATION * 0.9)
			end)
		end,
		OnStart = function()
			local caster = self:GetCaster()
			if not IsValidAlive(nil, caster) then
				return
			end
			local origin = caster:GetAbsOrigin()
			local forward = caster:GetForwardVector()
			EmitSoundOn(ELITE_040_WAVE_CAST_SOUND, caster)
			EmitSoundOn(ELITE_040_WAVE_FLY_SOUND, caster)
			self:PlayWaveEffect(origin + caster:GetForwardVector() * 50, forward)
			local hitEnemies = self:DamageAndStunWave(caster, origin, forward)
			self.spinDirection = self:ResolveSpinDirection(origin, forward, hitEnemies)
			ScreenShake(caster:GetAbsOrigin(), 20, 20, 0.3, 2500, 0, true)
			self:Timer(ELITE_040_CAST_DURATION - 1, function()
				return self:StartSpinAttack()
			end)
		end,
	}
end
function elite_040.prototype.PlayWaveEffect(self, origin, forward)
	local pfx = ParticleManager:CreateParticle(ELITE_040_WAVE_PARTICLE, PATTACH_WORLDORIGIN, nil)
	ParticleManager:SetParticleControlTransformForward(pfx, 0, origin, forward)
	ParticleManager:SetParticleControl(pfx, 11, Vector(ELITE_040_WAVE_LENGTH, 0, 0))
	Timers:CreateTimer(2, function()
		ParticleManager:DestroyParticle(pfx, false)
		ParticleManager:ReleaseParticleIndex(pfx)
	end)
end
function elite_040.prototype.DamageAndStunWave(self, caster, origin, forward)
	local minDot = math.cos(math.rad(ELITE_040_WAVE_HALF_ANGLE_DEG))
	local hitEnemies = {}
	local enemies = FindUnitsInRadius(
		caster:GetTeamNumber(),
		origin,
		nil,
		ELITE_040_WAVE_LENGTH,
		DOTA_UNIT_TARGET_TEAM_ENEMY,
		DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,
		DOTA_UNIT_TARGET_FLAG_NONE,
		FIND_ANY_ORDER,
		false
	)
	for ____, enemy in ipairs(enemies) do
		do
			if not IsValidAlive(nil, enemy) then
				goto __continue15
			end
			local delta = enemy:GetAbsOrigin():__sub(origin)
			local distance = delta:Length2D()
			if distance <= 0.01 or distance > ELITE_040_WAVE_LENGTH then
				goto __continue15
			end
			local direction = Vector(delta.x / distance, delta.y / distance, 0)
			local dot = forward.x * direction.x + forward.y * direction.y
			if dot < minDot then
				goto __continue15
			end
			hitEnemies[#hitEnemies + 1] = enemy
			caster:MonsterDamage({ victim = enemy, damage_rate = ELITE_040_WAVE_DAMAGE_RATE, ability = self })
			AddDeBuffStatus(
				nil,
				enemy,
				caster,
				self,
				DebuffStatusType.STUN,
				{ duration = ELITE_040_WAVE_STUN_DURATION }
			)
		end
		::__continue15::
	end
	return hitEnemies
end
function elite_040.prototype.ResolveSpinDirection(self, origin, forward, hitEnemies)
	if #hitEnemies <= 0 then
		return forward
	end
	local target = hitEnemies[RandomInt(0, #hitEnemies - 1) + 1]
	if not IsValidAlive(nil, target) then
		return forward
	end
	local direction = GetDirection(nil, target:GetAbsOrigin(), origin)
	if direction:Length2D() <= 0.01 then
		return forward
	end
	return direction
end
function elite_040.prototype.StartSpinAttack(self)
	local caster = self:GetCaster()
	if not IsValidAlive(nil, caster) then
		return
	end
	caster:StartGestureWithPlaybackRate(ACT_DOTA_CAST_ABILITY_2, ELITE_040_SPIN_PLAYBACK_RATE)
	self:Timer(ELITE_040_SPIN_IMPACT_TIME, function()
		return self:BeginSpinAdvance(caster)
	end)
end
function elite_040.prototype.PlaySpinEffect(self, caster)
	local pfx = ParticleManager:CreateParticle(ELITE_040_SPIN_PARTICLE, PATTACH_ABSORIGIN_FOLLOW, caster)
	ParticleManager:SetParticleControl(pfx, 0, caster:GetAbsOrigin())
	ParticleManager:SetParticleControl(
		pfx,
		1,
		Vector(ELITE_040_SPIN_RADIUS, ELITE_040_SPIN_RADIUS, ELITE_040_SPIN_RADIUS)
	)
	Timers:CreateTimer(ELITE_040_SPIN_DURATION, function()
		ParticleManager:DestroyParticle(pfx, false)
		ParticleManager:ReleaseParticleIndex(pfx)
	end)
	Timers:CreateTimer(0.5, function()
		local pfx2 = ParticleManager:CreateParticle(ELITE_040_SPIN_PARTICLE, PATTACH_ABSORIGIN_FOLLOW, caster)
		ParticleManager:SetParticleControl(pfx2, 0, caster:GetAbsOrigin())
		ParticleManager:SetParticleControl(
			pfx2,
			1,
			Vector(ELITE_040_SPIN_RADIUS, ELITE_040_SPIN_RADIUS, ELITE_040_SPIN_RADIUS)
		)
		Timers:CreateTimer(ELITE_040_SPIN_DURATION, function()
			ParticleManager:DestroyParticle(pfx2, false)
			ParticleManager:ReleaseParticleIndex(pfx2)
		end)
	end)
end
function elite_040.prototype.BeginSpinAdvance(self, caster)
	if not IsValidAlive(nil, caster) then
		return
	end
	self:PlaySpinEffect(caster)
	caster:EmitSound("Hero_Mars.Shield.Cast")
	local origin = caster:GetAbsOrigin()
	local moveDirection = self.spinDirection or caster:GetForwardVector()
	caster:SetForwardVector(moveDirection)
	ScreenShake(caster:GetAbsOrigin(), 10, 10, ELITE_040_SPIN_ACTIVE_DURATION, 1500, 0, true)
	local endPos = origin:__add(moveDirection:__mul(ELITE_040_SPIN_MOVE_DISTANCE))
	local hitTargets = __TS__New(Set)
	caster:Mover(endPos, ELITE_040_SPIN_ACTIVE_DURATION * 1.2, function(____, position)
		if not IsValidAlive(nil, caster) then
			return true
		end
		self:DamageSpinEnemies(caster, position, hitTargets)
	end)
end
function elite_040.prototype.DamageSpinEnemies(self, caster, position, hitTargets)
	local enemies = FindUnitsInRadius(
		caster:GetTeamNumber(),
		position,
		nil,
		ELITE_040_SPIN_RADIUS * 0.9,
		DOTA_UNIT_TARGET_TEAM_ENEMY,
		DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,
		DOTA_UNIT_TARGET_FLAG_NONE,
		FIND_ANY_ORDER,
		false
	)
	for ____, enemy in ipairs(enemies) do
		do
			if not IsValidAlive(nil, enemy) then
				goto __continue36
			end
			local enemyIndex = enemy:entindex()
			if hitTargets:has(enemyIndex) then
				goto __continue36
			end
			hitTargets:add(enemyIndex)
			caster:MonsterDamage({ victim = enemy, damage_rate = ELITE_040_SPIN_DAMAGE_RATE, ability = self })
			enemy:KnockBack(caster, self, {
				duration = ELITE_040_SPIN_KNOCKBACK_DURATION,
				distance = ELITE_040_SPIN_KNOCKBACK_DISTANCE,
				height = ELITE_040_SPIN_KNOCKBACK_HEIGHT,
				particleName = "",
				stun = true,
			})
			enemy:EmitSound("Hero_Mars.Spear.Root")
		end
		::__continue36::
	end
end
elite_040 = __TS__DecorateLegacy({ registerAbility(nil) }, elite_040)
____exports.elite_040 = elite_040
return ____exports