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
local __TS__DecorateLegacy = ____lualib.__TS__DecorateLegacy
local __TS__New = ____lualib.__TS__New
local ____exports = {}
local modifier_elite_054_dash
local ____dota_ts_adapter = require("utils.dota_ts_adapter")
local registerAbility = ____dota_ts_adapter.registerAbility
local registerModifier = ____dota_ts_adapter.registerModifier
local ____monster_base = require("abilities.monster.monster_base")
local MonsterAbility_CS = ____monster_base.MonsterAbility_CS
local MonsterModifier_CS = ____monster_base.MonsterModifier_CS
local CAST_RANGE = 1400
local CAST_POINT = 1
local DASH_DISTANCE = 760
local DASH_DURATION = 0.45
local HIT_RADIUS = 150
local DAMAGE_RATE = 22
local DASH_KNOCKBACK_DISTANCE = 220
local TORNADO_KNOCKBACK_DISTANCE = 160
local KNOCKBACK_DURATION = 0.25
local KNOCKBACK_HEIGHT = 120
local KNOCKBACK_STUN_DURATION = 0.2
local TORNADO_PARTICLE = "particles/units/heroes/hero_invoker/invoker_tornado.vpcf"
local TORNADO_INTERVAL = 0.1
local TORNADO_DISTANCE = 500
local TORNADO_SPEED = 800
local TORNADO_RADIUS = 50
local TORNADO_SOUND_EVENTS = "soundevents/game_sounds_heroes/game_sounds_invoker.vsndevts"
local DASH_CAST_SOUND = "Hero_Invoker.Tornado.Cast"
local TORNADO_HIT_SOUND = "Hero_Invoker.Tornado.Target"
--- 精英技能54 - 掠影突袭：向最近敌人方向快速突进，伤害路径敌人
____exports.elite_054 = __TS__Class()
local elite_054 = ____exports.elite_054
elite_054.name = "elite_054"
__TS__ClassExtends(elite_054, MonsterAbility_CS)
function elite_054.prototype.Precache(self, context)
	PrecacheResource("particle", TORNADO_PARTICLE, context)
	PrecacheResource("soundfile", TORNADO_SOUND_EVENTS, context)
end
function elite_054.prototype.GetMosnterAbilityConfig(self)
	return {
		behavior = DOTA_ABILITY_BEHAVIOR_NO_TARGET,
		castRange = CAST_RANGE,
		castPoint = CAST_POINT,
		castDuration = DASH_DURATION,
		castAnimation = ACT_DOTA_CAST_ABILITY_1,
		animationPlaybackRate = 0.75,
		OnPhaseStart = function()
			local caster = self:GetCaster()
			local target = caster:GetMinDistanceUnit(CAST_RANGE)
			if IsValidAlive(nil, target) then
				caster:LockTargetForSpeed(target, CAST_POINT, 4)
				local start = caster:GetAbsOrigin()
				self:WarningEffect(start, target:GetAbsOrigin(), CAST_POINT + 0.1, {
					startWidth = HIT_RADIUS,
					endWidth = HIT_RADIUS,
					getDirection = function()
						return GetDirection(nil, target:GetAbsOrigin(), caster:GetAbsOrigin())
					end,
				})
				self:Timer(0.5, function()
					caster:Mover(start:__add(caster:GetForwardVector():__mul(-100)), 0.2)
				end)
			end
		end,
		OnStart = function()
			local caster = self:GetCaster()
			local target = caster:GetMinDistanceUnit(CAST_RANGE)
			if not IsValidAlive(nil, caster) or not IsValidAlive(nil, target) then
				return
			end
			EmitSoundOn(DASH_CAST_SOUND, caster)
			local direction = GetDirection(nil, target:GetAbsOrigin(), caster:GetAbsOrigin())
			local endPos = caster:GetAbsOrigin():__add(direction:__mul(DASH_DISTANCE))
			modifier_elite_054_dash:applys(
				caster,
				caster,
				self,
				{ duration = DASH_DURATION, direction_x = direction.x, direction_y = direction.y }
			)
			caster:Mover(endPos, DASH_DURATION, function(____, pos)
				self:DamageAt(pos)
				return false
			end, nil, true)
		end,
	}
end
function elite_054.prototype.DamageAt(self, pos)
	local caster = self:GetCaster()
	if not IsValidAlive(nil, caster) then
		return
	end
	local enemies = FindUnitsInRadius(
		caster:GetTeamNumber(),
		pos,
		nil,
		HIT_RADIUS,
		DOTA_UNIT_TARGET_TEAM_ENEMY,
		DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,
		DOTA_UNIT_TARGET_FLAG_NONE,
		FIND_ANY_ORDER,
		false
	)
	for ____, enemy in ipairs(enemies) do
		do
			if not IsValidAlive(nil, enemy) then
				goto __continue13
			end
			local idx = enemy:GetEntityIndex()
			local dashHit = self._dashHitTargets
			if dashHit and dashHit:has(idx) then
				goto __continue13
			end
			if dashHit ~= nil then
				dashHit:add(idx)
			end
			caster:MonsterDamage({ victim = enemy, damage_rate = DAMAGE_RATE, ability = self })
			self:KnockBackEnemy(
				caster,
				enemy,
				GetDirection(nil, enemy:GetAbsOrigin(), caster:GetAbsOrigin()),
				DASH_KNOCKBACK_DISTANCE
			)
		end
		::__continue13::
	end
end
function elite_054.prototype.LaunchSideTornadoPair(self, caster, dashDirection)
	if not IsValidAlive(nil, caster) then
		return
	end
	local startPoint = caster:GetAbsOrigin():__add(Vector(0, 0, 96))
	local sideDirections = {
		RotateVector2D(nil, dashDirection, -60):Normalized(),
		RotateVector2D(nil, dashDirection, 60):Normalized(),
	}
	for ____, sideDirection in ipairs(sideDirections) do
		CreateProjectile(nil, {
			ability = self,
			caster = caster,
			effect_name = TORNADO_PARTICLE,
			projectile_type = "linear",
			start_point = startPoint,
			direction = sideDirection,
			projectile_speed = TORNADO_SPEED,
			projectile_distance = TORNADO_DISTANCE,
			projectile_range = TORNADO_RADIUS,
			projectile_target_team = DOTA_UNIT_TARGET_TEAM_ENEMY,
			projectile_target_type = DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,
			projectile_target_flags = DOTA_UNIT_TARGET_FLAG_NONE,
			on_hit = function(____, hitTarget)
				if not hitTarget or not IsValidAlive(nil, hitTarget) then
					return true
				end
				local tornadoHit = self._tornadoHitTargets
				local idx = hitTarget:GetEntityIndex()
				if tornadoHit and tornadoHit:has(idx) then
					return false
				end
				if not IsValidAlive(nil, caster) then
					return true
				end
				if tornadoHit ~= nil then
					tornadoHit:add(idx)
				end
				EmitSoundOn(TORNADO_HIT_SOUND, hitTarget)
				caster:MonsterDamage({ victim = hitTarget, damage_rate = DAMAGE_RATE * 0.35, ability = self })
				self:KnockBackEnemy(caster, hitTarget, sideDirection, TORNADO_KNOCKBACK_DISTANCE)
				return true
			end,
		})
	end
end
function elite_054.prototype.KnockBackEnemy(self, caster, enemy, direction, distance)
	if not IsValidAlive(nil, enemy) then
		return
	end
	enemy:KnockBack(caster, self, {
		duration = KNOCKBACK_DURATION,
		distance = distance,
		height = KNOCKBACK_HEIGHT,
		direction = direction,
		stun = true,
		stunDuration = KNOCKBACK_STUN_DURATION,
	})
end
elite_054 = __TS__DecorateLegacy({ registerAbility(nil) }, elite_054)
____exports.elite_054 = elite_054
modifier_elite_054_dash = __TS__Class()
modifier_elite_054_dash.name = "modifier_elite_054_dash"
__TS__ClassExtends(modifier_elite_054_dash, MonsterModifier_CS)
function modifier_elite_054_dash.prototype.____constructor(self, ...)
	MonsterModifier_CS.prototype.____constructor(self, ...)
	self._dashDirection = Vector(1, 0, 0)
end
function modifier_elite_054_dash.prototype.OnCreated(self, params)
	if not IsServer() then
		return
	end
	local ability = self:GetAbility()
	ability._dashHitTargets = __TS__New(Set)
	ability._tornadoHitTargets = __TS__New(Set)
	local directionX = params.direction_x or self:GetParent():GetForwardVector().x
	local directionY = params.direction_y or self:GetParent():GetForwardVector().y
	self._dashDirection = Vector(directionX, directionY, 0):Normalized()
	self:FireSideTornadoes()
	self:StartIntervalThink(TORNADO_INTERVAL)
end
function modifier_elite_054_dash.prototype.OnIntervalThink(self)
	if not IsServer() then
		return
	end
	self:FireSideTornadoes()
end
function modifier_elite_054_dash.prototype.FireSideTornadoes(self)
	local parent = self:GetParent()
	local ability = self:GetAbility()
	if not IsValidAlive(nil, parent) or not ability then
		self:Destroy()
		return
	end
	ability:LaunchSideTornadoPair(parent, self._dashDirection)
end
function modifier_elite_054_dash.prototype.OnDestroy(self)
	if not IsServer() then
		return
	end
	local ability = self:GetAbility()
	ability._dashHitTargets = nil
	ability._tornadoHitTargets = nil
end
function modifier_elite_054_dash.prototype.DeclareFunctions(self)
	return { MODIFIER_PROPERTY_OVERRIDE_ANIMATION, MODIFIER_PROPERTY_OVERRIDE_ANIMATION_RATE }
end
function modifier_elite_054_dash.prototype.GetOverrideAnimation(self)
	return ACT_DOTA_CAST_ABILITY_1
end
function modifier_elite_054_dash.prototype.GetOverrideAnimationRate(self)
	return 2.2
end
function modifier_elite_054_dash.prototype.CheckState(self)
	return { [MODIFIER_STATE_NO_UNIT_COLLISION] = true }
end
function modifier_elite_054_dash.prototype.GetModifierConfig(self)
	return { isHidden = true, isDebuff = false, isPurgable = false }
end
modifier_elite_054_dash =
	__TS__DecorateLegacy({ registerModifier(nil, "modifier_elite_054_dash") }, modifier_elite_054_dash)
return ____exports