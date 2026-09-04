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
local modifier_elite_043_slow
local ____dota_ts_adapter = require("utils.dota_ts_adapter")
local registerAbility = ____dota_ts_adapter.registerAbility
local registerModifier = ____dota_ts_adapter.registerModifier
local ____monster_base = require("abilities.monster.monster_base")
local MonsterAbility_CS = ____monster_base.MonsterAbility_CS
local MonsterModifier_CS = ____monster_base.MonsterModifier_CS
local ELITE_043_PROJECTILE_RANGE = 1300
local ELITE_043_PATH_EFFECT_DURATION = 0.5
local ELITE_043_PROJECTILE_SPEED = ELITE_043_PROJECTILE_RANGE / ELITE_043_PATH_EFFECT_DURATION
local ELITE_043_DAMAGE_RATE = 20
local ELITE_043_HIT_SLOW_DURATION = 2
local ELITE_043_HIT_SLOW_PCT = -75
local ELITE_043_LINE_WIDTH = 60
local ELITE_043_LINE_SPACING = 200
local ELITE_043_PROJECTILE_COUNT = 3
local PROJECTILE_PARTICLE = "particles/spectre_transversant_spectral_dagger_v2.vpcf"
local CAST_SOUND = "Hero_Spectre.DaggerCast"
local HIT_SOUND = "Hero_Spectre.DaggerImpact"
--- 精英技能43：发射虚空投射物，飞出后从极限距离折返。
____exports.elite_043 = __TS__Class()
local elite_043 = ____exports.elite_043
elite_043.name = "elite_043"
__TS__ClassExtends(elite_043, MonsterAbility_CS)
function elite_043.prototype.Precache(self, context)
	PrecacheResource("particle", PROJECTILE_PARTICLE, context)
end
function elite_043.prototype.GetMosnterAbilityConfig(self)
	return {
		castPoint = 0.8,
		castDuration = 1,
		behavior = DOTA_ABILITY_BEHAVIOR_NO_TARGET,
		castAnimation = ACT_DOTA_CAST_ABILITY_1,
		castRange = 1000,
		animationPlaybackRate = 0.5,
		OnPhaseStart = function()
			local caster = self:GetCaster()
			local target = self._caster:GetMinDistanceUnit(1500)
			if target then
				self._caster:LockTargetForSpeed(target, 0.5)
			end
			self:WarningEffect(
				caster:GetAbsOrigin(),
				caster:GetAbsOrigin():__add(caster:GetForwardVector():__mul(ELITE_043_PROJECTILE_RANGE)),
				0.8,
				{
					startWidth = 350,
					endWidth = 350,
					getDirection = function()
						return caster:GetForwardVector()
					end,
				}
			)
			self:Timer(0.6, function()
				self._caster:StartGesture(ACT_DOTA_CAST_ABILITY_1)
			end)
		end,
		OnStart = function()
			local caster = self:GetCaster()
			EmitSoundOn(CAST_SOUND, caster)
			local origin = caster:GetAbsOrigin()
			local direction = caster:GetForwardVector()
			local targetPos = origin:__add(direction:__mul(ELITE_043_PROJECTILE_RANGE))
			local perpDir = Vector(-direction.y, direction.x, 0)
			ScreenShake(caster:GetAbsOrigin(), 5, 5, 0.5, 3000, 0, true)
			do
				local i = 0
				while i < ELITE_043_PROJECTILE_COUNT do
					local currentOffset = (i - (ELITE_043_PROJECTILE_COUNT - 1) / 2) * ELITE_043_LINE_SPACING
					local currentOffsetVec = perpDir:__mul(currentOffset)
					local lineStart = origin:__add(currentOffsetVec)
					local lineEnd = targetPos:__add(currentOffsetVec)
					local returnStart = lineEnd
					local returnEnd = lineStart
					self:Timer(ELITE_043_PATH_EFFECT_DURATION, function()
						ScreenShake(caster:GetAbsOrigin(), 5, 5, 0.5, 3000, 0, true)
						self:createLineProjectile(caster, returnStart, returnEnd)
					end)
					self:createLineProjectile(caster, lineStart, lineEnd)
					i = i + 1
				end
			end
		end,
	}
end
function elite_043.prototype.createLineProjectile(self, caster, startPoint, targetPoint)
	if not IsValidAlive(nil, caster) then
		return
	end
	CreateProjectile(nil, {
		caster = caster,
		ability = self,
		effect_name = PROJECTILE_PARTICLE,
		projectile_type = "linear",
		start_point = startPoint,
		target = targetPoint,
		projectile_speed = ELITE_043_PROJECTILE_SPEED,
		projectile_distance = ELITE_043_PROJECTILE_RANGE,
		projectile_range = ELITE_043_LINE_WIDTH,
		projectile_target_team = DOTA_UNIT_TARGET_TEAM_ENEMY,
		projectile_target_type = DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,
		projectile_target_flags = DOTA_UNIT_TARGET_FLAG_NONE,
		extra_data = { pathExpireAt = GameRules:GetGameTime() + ELITE_043_PATH_EFFECT_DURATION },
		on_hit = function(____, hitTarget)
			return self:onProjectileHit(caster, hitTarget)
		end,
		on_think = function(____, _location, extraData)
			local pathExpireAt = tonumber(extraData.pathExpireAt) or 0
			if GameRules:GetGameTime() >= pathExpireAt then
				return true
			end
		end,
	})
end
function elite_043.prototype.onProjectileHit(self, caster, hitTarget)
	if not hitTarget or not IsValidAlive(nil, hitTarget) then
		return true
	end
	if not IsValidAlive(nil, caster) then
		return true
	end
	EmitSoundOn(HIT_SOUND, hitTarget)
	caster:MonsterDamage({ victim = hitTarget, damage_rate = ELITE_043_DAMAGE_RATE, ability = self })
	modifier_elite_043_slow:applys(hitTarget, caster, self, { duration = ELITE_043_HIT_SLOW_DURATION })
	return false
end
elite_043 = __TS__DecorateLegacy({ registerAbility(nil) }, elite_043)
____exports.elite_043 = elite_043
modifier_elite_043_slow = __TS__Class()
modifier_elite_043_slow.name = "modifier_elite_043_slow"
__TS__ClassExtends(modifier_elite_043_slow, MonsterModifier_CS)
function modifier_elite_043_slow.prototype.GetAttributeBonus(self)
	return { bonus_movespeed_pct = ELITE_043_HIT_SLOW_PCT }
end
function modifier_elite_043_slow.prototype.IsHidden(self)
	return false
end
function modifier_elite_043_slow.prototype.IsDebuff(self)
	return true
end
function modifier_elite_043_slow.prototype.IsPurgable(self)
	return true
end
function modifier_elite_043_slow.GetLocalizationCN(self)
	return { name = "虚空侵蚀", description = "被虚空能量侵蚀，移动速度降低75%。" }
end
modifier_elite_043_slow =
	__TS__DecorateLegacy({ registerModifier(nil, "modifier_elite_043_slow") }, modifier_elite_043_slow)
return ____exports