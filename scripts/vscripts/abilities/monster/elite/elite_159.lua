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
local ELITE_159_CAST_POINT = 0.5
local ELITE_159_PULSE_COUNT = 3
local ELITE_159_PULSE_INTERVAL = 0.23
local ELITE_159_EXPLOSION_DELAY = 0.6
local ELITE_159_DAMAGE_RADIUS = 500
local ELITE_159_DAMAGE_RATES = { 15, 25, 35 }
local ELITE_159_KNOCKBACK_DURATION = 0.2
local ELITE_159_KNOCKBACK_DISTANCE = 10
local ELITE_159_KNOCKBACK_HEIGHT = 20
local ELITE_159_KNOCKBACK_STUN_DURATION = 0.2
local ELITE_159_DASH_SEARCH_RANGE = 2000
local ELITE_159_DASH_MAX_DISTANCE = 1200
local ELITE_159_DASH_SPEED = 1550
local ELITE_159_DASH_HIT_RADIUS = 200
local ELITE_159_DASH_DAMAGE_RATE = 8
local ELITE_159_DASH_STUN_DURATION = 0.6
local ELITE_159_TOTAL_DURATION = ELITE_159_PULSE_INTERVAL * (ELITE_159_PULSE_COUNT - 1) + 2.5
local ELITE_159_EXPLOSION_PARTICLE = "particles/units/heroes/hero_marci/marci_dispose_land_aoe.vpcf"
local ELITE_159_EXPLOSION_PARTICLE_2 = "particles/monster/ability/elite_159/dragon_fire_aoe.vpcf"
local ELITE_159_WAVE_PARTICLE = "particles/monster/ability/elite_159/pun_marci_unleash_pulse.vpcf"
local ELITE_159_DASH_PARTICLE = "particles/bb/ss_primal_beast_2022_prestige_onslaught_charge_active_test.vpcf"
local ELITE_159_EXPLOSION_SOUND = "Hero_FacelessVoid.TimeLockImpact"
local ELITE_159_WAVE_SOUND = "Hero_Marci.Unleash.Pulse"
local ELITE_159_DASH_SOUND = "Hero_PrimalBeast.Onslaught"
--- 精英技能159 - 脉动冲击：先冲向敌人，再连续三次爆炸，对范围内敌人造成伤害和轻微击飞
____exports.elite_159 = __TS__Class()
local elite_159 = ____exports.elite_159
elite_159.name = "elite_159"
__TS__ClassExtends(elite_159, MonsterAbility_CS)
function elite_159.prototype.Precache(self, context)
	PrecacheResource("particle", ELITE_159_EXPLOSION_PARTICLE, context)
	PrecacheResource("particle", ELITE_159_EXPLOSION_PARTICLE_2, context)
	PrecacheResource("particle", ELITE_159_WAVE_PARTICLE, context)
	PrecacheResource("particle", ELITE_159_DASH_PARTICLE, context)
end
function elite_159.prototype.GetMosnterAbilityConfig(self)
	return {
		behavior = DOTA_ABILITY_BEHAVIOR_NO_TARGET,
		castPoint = ELITE_159_CAST_POINT,
		castDuration = ELITE_159_TOTAL_DURATION,
		castAnimation = ACT_DOTA_CAST_ABILITY_2,
		animationPlaybackRate = 3.5,
		OnPhaseStart = function()
			local caster = self:GetCaster()
			if not IsValidAlive(nil, caster) then
				return
			end
		end,
		OnStart = function()
			local caster = self:GetCaster()
			if not IsValidAlive(nil, caster) then
				return
			end
			self:Timer(ELITE_159_EXPLOSION_DELAY, function()
				do
					local index = 0
					while index < ELITE_159_PULSE_COUNT do
						local currentIndex = index
						local currentDelay = currentIndex * ELITE_159_PULSE_INTERVAL
						local currentDamageRate = ELITE_159_DAMAGE_RATES[currentIndex + 1]
						self:Timer(currentDelay, function()
							self:releasePulse(currentDamageRate)
						end)
						index = index + 1
					end
				end
			end)
		end,
	}
end
function elite_159.prototype.prepareDash(self, caster)
	self._dashTarget = nil
	self._dashEnd = nil
	local target = caster:GetMinDistanceUnit(ELITE_159_DASH_SEARCH_RANGE)
	if not IsValidAlive(nil, target) then
		return
	end
	self._dashTarget = target
	self._dashEnd = self:getDashEnd(caster, target)
	caster:LockTargetForSpeed(target, ELITE_159_CAST_POINT, 12)
	self:WarningEffect(caster:GetAbsOrigin(), self._dashEnd, ELITE_159_EXPLOSION_DELAY, {
		startWidth = ELITE_159_DASH_HIT_RADIUS,
		endWidth = ELITE_159_DASH_HIT_RADIUS,
		getDirection = function()
			return caster:GetForwardVector()
		end,
	})
end
function elite_159.prototype.startDash(self, caster)
	local ____IsValidAlive_result_0
	if IsValidAlive(nil, self._dashTarget) then
		____IsValidAlive_result_0 = self._dashTarget
	else
		____IsValidAlive_result_0 = caster:GetMinDistanceUnit(ELITE_159_DASH_SEARCH_RANGE)
	end
	local target = ____IsValidAlive_result_0
	if not IsValidAlive(nil, target) then
		return
	end
	local origin = caster:GetAbsOrigin()
	local targetPosition = self:getDashEnd(caster, target)
	local offset = targetPosition:__sub(origin)
	local distance = offset:Length2D()
	if distance <= 1 then
		return
	end
	local dashDuration = math.max(distance / ELITE_159_DASH_SPEED, 0.1)
	local hitEnemies = __TS__New(Set)
	EmitSoundOn(ELITE_159_DASH_SOUND, caster)
	self:playDashEffect(caster, dashDuration)
	caster:Mover(targetPosition, dashDuration, function(____, position)
		self:damageDashArea(caster, position, hitEnemies)
	end)
end
function elite_159.prototype.getDashEnd(self, caster, target)
	local origin = caster:GetAbsOrigin()
	local targetPosition = GetGroundPosition(target:GetAbsOrigin(), caster)
	local offset = targetPosition:__sub(origin)
	local distance = offset:Length2D()
	if distance <= ELITE_159_DASH_MAX_DISTANCE then
		return targetPosition
	end
	local direction = Vector(offset.x, offset.y, 0):Normalized()
	return GetGroundPosition(origin:__add(direction:__mul(ELITE_159_DASH_MAX_DISTANCE)), caster)
end
function elite_159.prototype.playDashEffect(self, caster, duration)
	local pfx = ParticleManager:CreateParticle(ELITE_159_DASH_PARTICLE, PATTACH_ABSORIGIN_FOLLOW, caster)
	ParticleManager:SetParticleControlEnt(
		pfx,
		0,
		caster,
		PATTACH_ABSORIGIN_FOLLOW,
		"attach_hitloc",
		caster:GetAbsOrigin(),
		true
	)
	Timers:CreateTimer(duration, function()
		ParticleManager:DestroyParticle(pfx, false)
		ParticleManager:ReleaseParticleIndex(pfx)
	end)
end
function elite_159.prototype.damageDashArea(self, caster, origin, hitEnemies)
	if not IsValidAlive(nil, caster) then
		return
	end
	local enemies = FindUnitsInRadius(
		caster:GetTeamNumber(),
		origin,
		nil,
		ELITE_159_DASH_HIT_RADIUS,
		DOTA_UNIT_TARGET_TEAM_ENEMY,
		DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,
		DOTA_UNIT_TARGET_FLAG_NONE,
		FIND_ANY_ORDER,
		false
	)
	for ____, enemy in ipairs(enemies) do
		do
			if not IsValidAlive(nil, enemy) then
				goto __continue24
			end
			local index = enemy:GetEntityIndex()
			if hitEnemies:has(index) then
				goto __continue24
			end
			hitEnemies:add(index)
			caster:MonsterDamage({ victim = enemy, damage_rate = ELITE_159_DASH_DAMAGE_RATE, ability = self })
			AddDeBuffStatus(
				nil,
				enemy,
				caster,
				self,
				DebuffStatusType.STUN,
				{ duration = ELITE_159_DASH_STUN_DURATION }
			)
		end
		::__continue24::
	end
end
function elite_159.prototype.releasePulse(self, damageRate)
	local caster = self:GetCaster()
	if not IsValidAlive(nil, caster) then
		return
	end
	local origin = caster:GetAbsOrigin()
	self:playExplosionEffect(origin)
	self:playWaveEffect(origin)
	self:damageArea(caster, origin, damageRate)
	ScreenShake(origin, 12, 12, 0.25, 1800, 0, true)
end
function elite_159.prototype.playExplosionEffect(self, origin)
	local caster = self:GetCaster()
	EmitSoundOnLocationWithCaster(origin, ELITE_159_EXPLOSION_SOUND, caster)
	local pfx = ParticleManager:CreateParticle(ELITE_159_EXPLOSION_PARTICLE, PATTACH_WORLDORIGIN, nil)
	ParticleManager:SetParticleControl(pfx, 0, origin)
	ParticleManager:SetParticleControl(pfx, 1, Vector(ELITE_159_DAMAGE_RADIUS, 0, 0))
	ParticleManager:ReleaseParticleIndex(pfx)
	local pfx2 = ParticleManager:CreateParticle(ELITE_159_EXPLOSION_PARTICLE_2, PATTACH_WORLDORIGIN, nil)
	ParticleManager:SetParticleControl(pfx2, 0, origin)
	ParticleManager:SetParticleControl(pfx2, 1, Vector(ELITE_159_DAMAGE_RADIUS, 0, 0))
	ParticleManager:ReleaseParticleIndex(pfx2)
end
function elite_159.prototype.playWaveEffect(self, origin)
	local caster = self:GetCaster()
	EmitSoundOnLocationWithCaster(origin, ELITE_159_WAVE_SOUND, caster)
	local pfx = ParticleManager:CreateParticle(ELITE_159_WAVE_PARTICLE, PATTACH_WORLDORIGIN, nil)
	ParticleManager:SetParticleControl(pfx, 0, origin)
	ParticleManager:SetParticleControl(pfx, 1, Vector(ELITE_159_DAMAGE_RADIUS, 0, 0))
	ParticleManager:ReleaseParticleIndex(pfx)
end
function elite_159.prototype.damageArea(self, caster, origin, damageRate)
	local enemies = FindUnitsInRadius(
		caster:GetTeamNumber(),
		origin,
		nil,
		ELITE_159_DAMAGE_RADIUS,
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
			caster:MonsterDamage({ victim = enemy, damage_rate = damageRate, ability = self })
			enemy:KnockBack(caster, self, {
				origin_pos = origin,
				duration = ELITE_159_KNOCKBACK_DURATION,
				distance = ELITE_159_KNOCKBACK_DISTANCE,
				height = ELITE_159_KNOCKBACK_HEIGHT,
				stun = true,
				stunDuration = ELITE_159_KNOCKBACK_STUN_DURATION,
			})
		end
		::__continue33::
	end
end
elite_159 = __TS__DecorateLegacy({ registerAbility(nil) }, elite_159)
____exports.elite_159 = elite_159
return ____exports