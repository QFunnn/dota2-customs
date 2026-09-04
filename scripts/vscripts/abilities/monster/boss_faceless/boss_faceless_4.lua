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
local __TS__ArrayForEach = ____lualib.__TS__ArrayForEach
local __TS__DecorateLegacy = ____lualib.__TS__DecorateLegacy
local ____exports = {}
local ____dota_ts_adapter = require("utils.dota_ts_adapter")
local registerAbility = ____dota_ts_adapter.registerAbility
local ____monster_base = require("abilities.monster.monster_base")
local MonsterAbility_CS = ____monster_base.MonsterAbility_CS
local pfx4 = "particles/units/heroes/hero_void_spirit/astral_step/void_spirit_astral_step_impact.vpcf"
local pfx_name = "particles/boss/faceless/faceless_deafening_blast_ti6.vpcf"
local SINGLE_WAVE_RADIUS = 300
local TRIPLE_WAVE_RADIUS = 180
local TRIPLE_WAVE_ANGLE = 40
local WARNING_TIME = 0.7
local boss_faceless_4 = __TS__Class()
boss_faceless_4.name = "boss_faceless_4"
__TS__ClassExtends(boss_faceless_4, MonsterAbility_CS)
function boss_faceless_4.prototype.____constructor(self, ...)
	MonsterAbility_CS.prototype.____constructor(self, ...)
	self.useTripleWave = false
end
function boss_faceless_4.prototype.GetMosnterAbilityConfig(self)
	return {
		castPoint = WARNING_TIME,
		castDuration = 0.1,
		animationPlaybackRate = 0.3,
		behavior = DOTA_ABILITY_BEHAVIOR_NO_TARGET,
		castAnimation = ACT_DOTA_CAST_ABILITY_2,
		OnPhaseStart = function()
			local caster = self:GetCaster()
			local target = caster:GetMinDistanceUnit(3500)
			local ____ = target and caster:LockTargetForSpeed(target, 1, 0.1)
			local forward = caster:GetForwardVector()
			local backward = caster:GetAbsOrigin():__add(forward:__mul(-100))
			caster:Mover(backward, 0.5)
			self.useTripleWave = RandomInt(0, 1) == 1
			if self.useTripleWave then
				__TS__ArrayForEach({ -TRIPLE_WAVE_ANGLE, 0, TRIPLE_WAVE_ANGLE }, function(____, angle)
					self:WarningEffect(backward, caster:GetAbsOrigin():__add(forward:__mul(1600)), WARNING_TIME, {
						getDirection = function()
							return RotateVector2D(nil, caster:GetForwardVector(), angle)
						end,
						startWidth = TRIPLE_WAVE_RADIUS,
						endWidth = TRIPLE_WAVE_RADIUS,
						follow = true,
					})
				end)
			else
				self:WarningEffect(backward, caster:GetAbsOrigin():__add(forward:__mul(1600)), WARNING_TIME, {
					getDirection = function()
						return caster:GetForwardVector()
					end,
					startWidth = SINGLE_WAVE_RADIUS,
					endWidth = SINGLE_WAVE_RADIUS,
					follow = true,
				})
			end
		end,
		OnStart = function()
			return self:SpellStart()
		end,
	}
end
function boss_faceless_4.prototype.SpellStart(self)
	local caster = self:GetCaster()
	local fow = caster:GetForwardVector()
	caster:StartGesture(ACT_DOTA_CAST_ABILITY_2_END)
	ScreenShake(caster:GetAbsOrigin(), 10, 10, 1, 3000, 0, true)
	caster:EmitSound("Hero_Invoker.DeafeningBlast")
	local ____table_useTripleWave_0
	if self.useTripleWave then
		____table_useTripleWave_0 = { -TRIPLE_WAVE_ANGLE, 0, TRIPLE_WAVE_ANGLE }
	else
		____table_useTripleWave_0 = { 0 }
	end
	local angles = ____table_useTripleWave_0
	local radius = self.useTripleWave and TRIPLE_WAVE_RADIUS or SINGLE_WAVE_RADIUS
	__TS__ArrayForEach(angles, function(____, angle)
		local dir = RotateVector2D(nil, fow, angle)
		local info = {
			vSpawnOrigin = caster:GetAbsOrigin():__add(Vector(0, 0, 120)):__add(dir:__mul(100)),
			vVelocity = dir * 1500,
			vAcceleration = Vector(0, 0, 0),
			fMaxSpeed = 1500,
			fDistance = 1500,
			fStartRadius = radius,
			fEndRadius = radius,
			fExpireTime = GameRules:GetGameTime() + 1,
			iUnitTargetTeam = DOTA_UNIT_TARGET_TEAM_ENEMY,
			iUnitTargetFlags = DOTA_UNIT_TARGET_FLAG_MAGIC_IMMUNE_ENEMIES,
			iUnitTargetType = DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC + DOTA_UNIT_TARGET_BUILDING,
			bIgnoreSource = true,
			bHasFrontalCone = true,
			bDrawsOnMinimap = false,
			bVisibleToEnemies = true,
			EffectName = pfx_name,
			Ability = self,
			Source = caster,
			bProvidesVision = false,
		}
		ProjectileManager:CreateLinearProjectile(info)
	end)
end
function boss_faceless_4.prototype.OnProjectileHit_ExtraData(self, target, location, extraData)
	if not IsValidAlive(nil, target) then
		return true
	end
	local caster = self:GetCaster()
	if not IsValidAlive(nil, caster) then
		return true
	end
	caster:MonsterDamage({ victim = target, damage_rate = 15, ability = self, effectName = pfx4 })
	return false
end
boss_faceless_4 = __TS__DecorateLegacy({ registerAbility(nil) }, boss_faceless_4)
return ____exports