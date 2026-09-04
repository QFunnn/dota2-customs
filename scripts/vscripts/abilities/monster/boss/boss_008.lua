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
local ____dota_ts_adapter = require("utils.dota_ts_adapter")
local registerModifier = ____dota_ts_adapter.registerModifier
local ____monster_base = require("abilities.monster.monster_base")
local MonsterModifier_CS = ____monster_base.MonsterModifier_CS
local BOSS_008_DASH_DISTANCE = 780
local BOSS_008_DASH_DURATION = 0.3
local BOSS_008_DASH_PROJECTILE_SPEED = BOSS_008_DASH_DISTANCE / BOSS_008_DASH_DURATION
local BOSS_008_DASH_PROJECTILE = "particles/units/heroes/hero_hoodwink/hoodwink_sharpshooter_projectile2.vpcf"
--- 精英技能1 - 蓄力一段时间后使用冲向敌人并且进行重击
____exports.boss_008 = __TS__Class()
local boss_008 = ____exports.boss_008
boss_008.name = "boss_008"
__TS__ClassExtends(boss_008, MonsterAbility_CS)
function boss_008.prototype.____constructor(self, ...)
	MonsterAbility_CS.prototype.____constructor(self, ...)
	self.damageOverTime = 0
end
function boss_008.prototype.Precache(self, context)
	PrecacheResource("particle", BOSS_008_DASH_PROJECTILE, context)
end
function boss_008.prototype.GetMosnterAbilityConfig(self)
	return {
		castRange = 1500,
		castPoint = 0.5,
		castDuration = 0.7,
		behavior = DOTA_ABILITY_BEHAVIOR_NO_TARGET,
		castAnimation = ACT_DOTA_ATTACK,
		animationPlaybackRate = 0.65,
		OnPhaseStart = function()
			local caster = self:GetCaster()
			local target = caster:GetMinDistanceUnit(1500)
			local forward = caster:GetForwardVector()
			if target then
				forward = GetDirection(nil, target:GetAbsOrigin(), caster:GetAbsOrigin())
				caster:LockTargetForSpeed(target, 0.4, 7)
			end
			caster:EmitSound("Hero_Weaver.Swarm.Cast")
			self.damageOverTime = 0
			self:Timer(0.25, function()
				caster:Mover(caster:GetAbsOrigin():__add(caster:GetForwardVector():__mul(-200)), 0.2)
			end)
		end,
		OnStart = function()
			local caster = self:GetCaster()
			self:Timer(0.1, function()
				if not IsValidAlive(nil, caster) then
					return
				end
				local origin = caster:GetAbsOrigin()
				local dashDirection = caster:GetForwardVector()
				local dashTarget = origin:__add(dashDirection:__mul(BOSS_008_DASH_DISTANCE))
				caster:EmitSound("Hero_Windrunner.ShackleshotCast")
				caster:AddNewModifier(caster, self, "modifier_boss_008_pre", { duration = 0.35 })
				ScreenShake(caster:GetAbsOrigin(), 3, 3, 0.5, 2000, 0, true)
				CreateProjectile(nil, {
					ability = self,
					caster = caster,
					effect_name = BOSS_008_DASH_PROJECTILE,
					projectile_type = "linear",
					start_point = origin:__add(Vector(0, 0, 100)):__add(dashDirection:__mul(100)),
					target = dashTarget,
					projectile_speed = BOSS_008_DASH_PROJECTILE_SPEED + 250,
					projectile_distance = BOSS_008_DASH_DISTANCE + 300,
					projectile_range = 0,
					projectile_target_team = DOTA_UNIT_TARGET_TEAM_ENEMY,
					projectile_target_type = DOTA_UNIT_TARGET_NONE,
					projectile_target_flags = DOTA_UNIT_TARGET_FLAG_NONE,
				})
				caster:Mover(dashTarget, BOSS_008_DASH_DURATION, function(____, pos)
					if self.damageOverTime == 1 then
						if GetDistance(nil, pos, origin) > 400 then
							return true
						end
						return
					end
					local forward = pos:__add(caster:GetForwardVector():__mul(80))
					self:DamageArea(forward, 160, 10)
				end)
			end)
		end,
	}
end
function boss_008.prototype.GetIntrinsicModifierName(self)
	return "modifier_boss_008"
end
function boss_008.prototype.DamageArea(self, origin, radius, damage)
	local caster = self:GetCaster()
	local enemies = FindUnitsInRadius(
		caster:GetTeamNumber(),
		origin,
		nil,
		radius,
		DOTA_UNIT_TARGET_TEAM_ENEMY,
		DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC + DOTA_UNIT_TARGET_BUILDING,
		DOTA_UNIT_TARGET_FLAG_NONE,
		0,
		false
	)
	__TS__ArrayForEach(enemies, function(____, enemy)
		caster:PerformAttack(enemy, true, true, true, false, true, false, true)
		caster:MonsterDamage({ victim = enemy, damage_rate = damage, ability = self })
		AddDeBuffStatus(nil, enemy, caster, self, DebuffStatusType.STUN, { duration = 0.65 })
		self.damageOverTime = 1
	end)
end
boss_008 = __TS__DecorateLegacy({ registerAbility(nil) }, boss_008)
____exports.boss_008 = boss_008
____exports.modifier_boss_008_pre = __TS__Class()
local modifier_boss_008_pre = ____exports.modifier_boss_008_pre
modifier_boss_008_pre.name = "modifier_boss_008_pre"
__TS__ClassExtends(modifier_boss_008_pre, MonsterModifier_CS)
function modifier_boss_008_pre.prototype.DeclareFunctions(self)
	return { MODIFIER_PROPERTY_VISUAL_Z_DELTA }
end
function modifier_boss_008_pre.prototype.GetEffectName(self)
	return "particles/bb/ss_primal_beast_2022_prestige_onslaught_charge_active_test3.vpcf"
end
modifier_boss_008_pre = __TS__DecorateLegacy({ registerModifier(nil) }, modifier_boss_008_pre)
____exports.modifier_boss_008_pre = modifier_boss_008_pre
____exports.modifier_boss_008 = __TS__Class()
local modifier_boss_008 = ____exports.modifier_boss_008
modifier_boss_008.name = "modifier_boss_008"
__TS__ClassExtends(modifier_boss_008, MonsterModifier_CS)
function modifier_boss_008.prototype.DeclareFunctions(self)
	return { MODIFIER_PROPERTY_VISUAL_Z_DELTA }
end
function modifier_boss_008.prototype.GetVisualZDelta(self)
	return -70
end
modifier_boss_008 = __TS__DecorateLegacy({ registerModifier(nil) }, modifier_boss_008)
____exports.modifier_boss_008 = modifier_boss_008
return ____exports