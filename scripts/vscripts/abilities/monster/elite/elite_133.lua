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
local EffectName = "particles/riki_immortal_ti6_blinkstrike_stab_2.vpcf"
local SWEEP_HIT_EFFECT = "particles/units/heroes/hero_venomancer/venomancer_latent_poison_projectile_endcap.vpcf"
local VENOMANCER_SOUND_EVENTS = "soundevents/game_sounds_heroes/game_sounds_venomancer.vsndevts"
local DASH_SOUND = "Hero_Venomancer.VenomousGale"
local SWEEP_SOUND = "Hero_Venomancer.VenomousGaleImpact"
local SWEEP_HIT_SOUND = "Hero_Venomancer.VenomousGaleImpact"
local DASH_DISTANCE = 500
local DASH_DURATION = 0.2
local SWEEP_DELAY = 0.3
local SWEEP_RADIUS = 350
local SWEEP_ANGLE = 180
local SWEEP_DEBUG_SEGMENTS = 12
local DEBUG_DURATION = 2
local DASH_HIT_RADIUS = 140
local DASH_HIT_FORWARD_OFFSET = 80
local KNOCKBACK_LAND_FORWARD_DISTANCE = 250
local KNOCKBACK_DURATION = 0.3
local KNOCKBACK_HEIGHT = 0
local SWEEP_DAMAGE_RATE = 20
local SWEEP_POISON_STACK = 5
local SWEEP_HIT_KNOCKBACK_DISTANCE = 0
local SWEEP_HIT_KNOCKBACK_DURATION = 0.18
local SWEEP_HIT_KNOCKBACK_HEIGHT = 30
____exports.elite_133 = __TS__Class()
local elite_133 = ____exports.elite_133
elite_133.name = "elite_133"
__TS__ClassExtends(elite_133, MonsterAbility_CS)
function elite_133.prototype.Precache(self, context)
	PrecacheResource("particle", SWEEP_HIT_EFFECT, context)
	PrecacheResource("soundfile", VENOMANCER_SOUND_EVENTS, context)
end
function elite_133.prototype.GetMosnterAbilityConfig(self)
	return {
		castRange = 1200,
		castPoint = 0.8,
		castDuration = 1,
		behavior = DOTA_ABILITY_BEHAVIOR_NO_TARGET,
		castAnimation = ACT_DOTA_CAST_ABILITY_1,
		animationPlaybackRate = 0.95,
		OnPhaseStart = function()
			local caster = self:GetCaster()
			local target = caster:GetMinDistanceUnit(1200)
			if IsValidAlive(nil, target) then
				caster:LockTargetForSpeed(target, 0.8)
			end
			local origin = caster:GetAbsOrigin()
			local endPos = origin:__add(caster:GetForwardVector():__mul(DASH_DISTANCE))
			self:WarningEffect(origin, endPos, 0.8 + 0.1, {
				startWidth = 120,
				endWidth = 500,
				getDirection = function()
					return caster:GetForwardVector()
				end,
			})
		end,
		OnStart = function()
			EmitSoundOn(DASH_SOUND, self._caster)
			ScreenShake(self._caster:GetAbsOrigin(), 8, 8, 0.3, 3000, 0, true)
			self._caster:StartGestureWithPlaybackRate(ACT_DOTA_SPAWN, 1)
			local dashForward = self._caster:GetForwardVector()
			local dashStart = self._caster:GetAbsOrigin()
			local dashEnd = dashStart:__add(dashForward:__mul(DASH_DISTANCE))
			local debugTargets = __TS__New(Set)
			self:DrawDashKnockbackPathDebug(self._caster, dashStart, dashForward, dashEnd, debugTargets)
			self._caster:Mover(dashEnd, DASH_DURATION, function(____, position)
				self:DrawDashKnockbackPathDebug(self._caster, position, dashForward, dashEnd, debugTargets)
			end)
			self:Timer(SWEEP_DELAY, function()
				ScreenShake(self._caster:GetAbsOrigin(), 15, 15, 0.5, 3000, 0, true)
				EmitSoundOnLocationWithCaster(self._caster:GetAbsOrigin(), DASH_SOUND, self._caster)
				EmitSoundOnLocationWithCaster(self._caster:GetAbsOrigin(), SWEEP_SOUND, self._caster)
				local pfx = ParticleManager:CreateParticle(EffectName, PATTACH_ABSORIGIN_FOLLOW, self._caster)
				ParticleManager:SetParticleControl(pfx, 0, self._caster:GetAbsOrigin())
				self:ApplySweepHit(self._caster:GetAbsOrigin(), dashForward)
			end)
		end,
	}
end
function elite_133.prototype.DrawDashKnockbackPathDebug(self, caster, position, forward, sweepOrigin, debugTargets)
	if not IsValidAlive(nil, caster) then
		return
	end
	local hitCenter = position:__add(forward:__mul(DASH_HIT_FORWARD_OFFSET))
	local enemies = FindUnitsInRadius(
		caster:GetTeamNumber(),
		hitCenter,
		nil,
		DASH_HIT_RADIUS,
		DOTA_UNIT_TARGET_TEAM_ENEMY,
		DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,
		DOTA_UNIT_TARGET_FLAG_NONE,
		FIND_ANY_ORDER,
		false
	)
	local landingPoint = sweepOrigin:__add(forward:__mul(KNOCKBACK_LAND_FORWARD_DISTANCE))
	for ____, enemy in ipairs(enemies) do
		do
			if not IsValidAlive(nil, enemy) then
				goto __continue12
			end
			local index = enemy:GetEntityIndex()
			if debugTargets:has(index) then
				goto __continue12
			end
			debugTargets:add(index)
			local debugStart = enemy:GetAbsOrigin():__add(Vector(0, 0, 32))
			local debugEnd = landingPoint:__add(Vector(0, 0, 32))
			self:KnockEnemyToSweepArea(caster, enemy, landingPoint)
		end
		::__continue12::
	end
end
function elite_133.prototype.KnockEnemyToSweepArea(self, caster, enemy, landingPoint)
	local enemyOrigin = enemy:GetAbsOrigin()
	local rawDirection = landingPoint:__sub(enemyOrigin)
	local distance = rawDirection:Length2D()
	if distance <= 1 then
		return
	end
	local direction = Vector(rawDirection.x, rawDirection.y, 0):Normalized()
	enemy:KnockBack(caster, self, {
		direction = direction,
		distance = distance,
		duration = KNOCKBACK_DURATION,
		height = KNOCKBACK_HEIGHT,
		stun = true,
		stunDuration = KNOCKBACK_DURATION,
		block = true,
		blockUntraversable = true,
	})
end
function elite_133.prototype.ApplySweepHit(self, origin, forward)
	local caster = self:GetCaster()
	if not IsValidAlive(nil, caster) then
		return
	end
	local planarForward = Vector(forward.x, forward.y, 0)
	if planarForward:Length2D() <= 0.1 then
		return
	end
	local normalizedForward = planarForward:Normalized()
	local halfAngleCos = math.cos(SWEEP_ANGLE * 0.5 * math.pi / 180)
	local enemies = FindUnitsInRadius(
		caster:GetTeamNumber(),
		origin,
		nil,
		SWEEP_RADIUS,
		DOTA_UNIT_TARGET_TEAM_ENEMY,
		DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,
		DOTA_UNIT_TARGET_FLAG_NONE,
		FIND_ANY_ORDER,
		false
	)
	for ____, enemy in ipairs(enemies) do
		do
			if not IsValidAlive(nil, enemy) then
				goto __continue21
			end
			local offset = enemy:GetAbsOrigin():__sub(origin)
			local direction = Vector(offset.x, offset.y, 0)
			if direction:Length2D() <= 0.1 then
				goto __continue21
			end
			local normalizedDirection = direction:Normalized()
			local dot = normalizedForward.x * normalizedDirection.x + normalizedForward.y * normalizedDirection.y
			if dot < halfAngleCos then
				goto __continue21
			end
			caster:MonsterDamage({ victim = enemy, damage_rate = SWEEP_DAMAGE_RATE, ability = self })
			AddDeBuffStatus(
				nil,
				enemy,
				caster,
				self,
				DebuffStatusType.POISON,
				{ stack = SWEEP_POISON_STACK, duration = 5 }
			)
			self:ApplySweepHitKnockback(caster, enemy, origin, normalizedForward)
			self:PlaySweepHitEffects(enemy)
		end
		::__continue21::
	end
end
function elite_133.prototype.ApplySweepHitKnockback(self, caster, enemy, origin, fallbackDirection)
	if not IsValidAlive(nil, enemy) then
		return
	end
	local offset = enemy:GetAbsOrigin():__sub(origin)
	local direction = Vector(offset.x, offset.y, 0)
	if direction:Length2D() <= 0.1 then
		direction = Vector(fallbackDirection.x, fallbackDirection.y, 0)
	end
	if direction:Length2D() <= 0.1 then
		return
	end
	enemy:KnockBack(caster, self, {
		direction = direction:Normalized(),
		distance = SWEEP_HIT_KNOCKBACK_DISTANCE,
		duration = SWEEP_HIT_KNOCKBACK_DURATION,
		height = SWEEP_HIT_KNOCKBACK_HEIGHT,
		stun = true,
		stunDuration = 0.5,
		block = false,
	})
end
function elite_133.prototype.PlaySweepHitEffects(self, enemy)
	if not IsValidAlive(nil, enemy) then
		return
	end
	EmitSoundOn(SWEEP_HIT_SOUND, enemy)
	local pfx = ParticleManager:CreateParticle(SWEEP_HIT_EFFECT, PATTACH_CENTER_FOLLOW, enemy)
	ParticleManager:SetParticleControlEnt(
		pfx,
		0,
		enemy,
		PATTACH_CENTER_FOLLOW,
		"attach_hitloc",
		enemy:GetAbsOrigin(),
		true
	)
	ParticleManager:ReleaseParticleIndex(pfx)
end
function elite_133.prototype.DrawSweepDamageAreaDebug(self, origin, forward)
	local planarForward = Vector(forward.x, forward.y, 0)
	if planarForward:Length2D() <= 0.1 then
		return
	end
	local center = origin:__add(Vector(0, 0, 32))
	local normalizedForward = planarForward:Normalized()
	local halfAngle = SWEEP_ANGLE * 0.5
	local previousArcPoint
	do
		local i = 0
		while i <= SWEEP_DEBUG_SEGMENTS do
			local angle = -halfAngle + SWEEP_ANGLE * i / SWEEP_DEBUG_SEGMENTS
			local direction = RotatePosition(Vector(0, 0, 0), QAngle(0, angle, 0), normalizedForward):Normalized()
			local arcPoint = origin:__add(direction:__mul(SWEEP_RADIUS)):__add(Vector(0, 0, 32))
			if i == 0 or i == SWEEP_DEBUG_SEGMENTS or math.abs(angle) <= 0.01 then
				DebugLine(nil, center, arcPoint, DEBUG_DURATION)
			end
			if previousArcPoint then
				DebugLine(nil, previousArcPoint, arcPoint, DEBUG_DURATION)
			end
			previousArcPoint = arcPoint
			i = i + 1
		end
	end
end
elite_133 = __TS__DecorateLegacy({ registerAbility(nil) }, elite_133)
____exports.elite_133 = elite_133
return ____exports