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
local SPIRIT_5_HIT_EFFECT = "particles/units/heroes/hero_void_spirit/astral_step/void_spirit_astral_step_impact.vpcf"
local SPIRIT_5_PROJECTILE_EFFECT = "particles/econ/items/invoker/invoker_ti6/invoker_deafening_blast_ti6.vpcf"
local SPIRIT_5_STRIKE_INTERVAL = 0.8
local SPIRIT_5_THIRD_STRIKE_ANGLES = { -20, 0, 20 }
local SPIRIT_5_PROJECTILE_SPEED = 1500
local SPIRIT_5_PROJECTILE_DISTANCE = 1500
local SPIRIT_5_PROJECTILE_RADIUS = 250
local SPIRIT_5_DAMAGE_RATE = 15
local spirit_5 = __TS__Class()
spirit_5.name = "spirit_5"
__TS__ClassExtends(spirit_5, MonsterAbility_CS)
function spirit_5.prototype.GetMosnterAbilityConfig(self)
	return {
		castPoint = 0.5,
		castDuration = 2,
		animationPlaybackRate = 0.5,
		behavior = DOTA_ABILITY_BEHAVIOR_NO_TARGET,
		castAnimation = ACT_DOTA_CAST_ABILITY_2,
		OnPhaseStart = function()
			local caster = self:GetCaster()
			local forward = caster:GetForwardVector()
			local target = caster:GetMinDistanceUnit(3500)
			local ____ = target and caster:LockTargetForSpeed(target, 1, 3)
			local backward = caster:GetAbsOrigin():__add(forward:__mul(-80))
			caster:Mover(backward, 0.5)
			self:WarningEffect(backward, caster:GetAbsOrigin():__add(forward:__mul(1000)), 0.5, {
				getDirection = function()
					return self._caster:GetForwardVector()
				end,
				startWidth = 250,
				endWidth = 700,
				follow = true,
			})
		end,
		OnStart = function()
			return self:SpellStart()
		end,
	}
end
function spirit_5.prototype.SpellStart(self)
	local caster = self:GetCaster()
	caster:EmitSound("Hero_Invoker.DeafeningBlast")
	caster:StartGesture(ACT_DOTA_CAST_ABILITY_2_END)
	ScreenShake(caster:GetAbsOrigin(), 6, 6, 1, 3000, 0, true)
	self:FireSlash(0)
	local target = caster:GetMinDistanceUnit(3500)
	local ____ = target and caster:LockTargetForSpeed(target, 0.9)
	self:Timer(SPIRIT_5_STRIKE_INTERVAL, function()
		if not IsValidAlive(nil, caster) then
			return
		end
		caster:StartGesture(ACT_DOTA_ATTACK)
		self:Timer(0.15, function()
			local forward = caster:GetForwardVector()
			local backward = caster:GetAbsOrigin():__add(forward:__mul(-50))
			caster:Mover(backward, 0.2)
			ScreenShake(caster:GetAbsOrigin(), 6, 6, 1, 3000, 0, true)
			self:FireSlash(0)
			local target = caster:GetMinDistanceUnit(3500)
			local ____ = target and caster:LockTargetForSpeed(target, 0.9)
		end)
	end)
	self:Timer(SPIRIT_5_STRIKE_INTERVAL * 2 + 0.1, function()
		if not IsValidAlive(nil, caster) then
			return
		end
		caster:StartGesture(ACT_DOTA_CAST_ABILITY_4)
		self:Timer(0.15, function()
			local forward = caster:GetForwardVector()
			local backward = caster:GetAbsOrigin():__add(forward:__mul(220))
			caster:Mover(backward, 0.3)
			ScreenShake(caster:GetAbsOrigin(), 10, 10, 1, 3000, 0, true)
			self:FireSlash(SPIRIT_5_THIRD_STRIKE_ANGLES[1])
			self:FireSlash(SPIRIT_5_THIRD_STRIKE_ANGLES[2])
			self:FireSlash(SPIRIT_5_THIRD_STRIKE_ANGLES[3])
		end)
	end)
end
function spirit_5.prototype.FireSlash(self, angleOffset)
	local caster = self:GetCaster()
	if not IsValidAlive(nil, caster) then
		return
	end
	local direction = RotateVector2D(nil, caster:GetForwardVector(), angleOffset):Normalized()
	local info = {
		vSpawnOrigin = caster:GetAbsOrigin():__add(Vector(0, 0, 120)):__add(direction:__mul(100)),
		vVelocity = direction * SPIRIT_5_PROJECTILE_SPEED,
		vAcceleration = Vector(0, 0, 0),
		fMaxSpeed = SPIRIT_5_PROJECTILE_SPEED,
		fDistance = SPIRIT_5_PROJECTILE_DISTANCE,
		fStartRadius = SPIRIT_5_PROJECTILE_RADIUS,
		fEndRadius = SPIRIT_5_PROJECTILE_RADIUS,
		fExpireTime = GameRules:GetGameTime() + 1,
		iUnitTargetTeam = DOTA_UNIT_TARGET_TEAM_ENEMY,
		iUnitTargetFlags = DOTA_UNIT_TARGET_FLAG_MAGIC_IMMUNE_ENEMIES,
		iUnitTargetType = DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC + DOTA_UNIT_TARGET_BUILDING,
		bIgnoreSource = true,
		bHasFrontalCone = true,
		bDrawsOnMinimap = false,
		bVisibleToEnemies = true,
		EffectName = SPIRIT_5_PROJECTILE_EFFECT,
		Ability = self,
		Source = caster,
		bProvidesVision = false,
	}
	ProjectileManager:CreateLinearProjectile(info)
end
function spirit_5.prototype.OnProjectileHit_ExtraData(self, target)
	if not IsValidAlive(nil, target) then
		return true
	end
	local caster = self:GetCaster()
	if not IsValidAlive(nil, caster) then
		return true
	end
	caster:MonsterDamage({
		victim = target,
		damage_rate = SPIRIT_5_DAMAGE_RATE,
		ability = self,
		effectName = SPIRIT_5_HIT_EFFECT,
	})
	return false
end
spirit_5 = __TS__DecorateLegacy({ registerAbility(nil) }, spirit_5)
return ____exports