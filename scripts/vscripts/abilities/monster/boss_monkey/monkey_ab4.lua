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
local ____monkey_movement = require("abilities.monster.boss_monkey.monkey_movement")
local ResolveMonkeyBlinkPoint = ____monkey_movement.ResolveMonkeyBlinkPoint
local DASH_DURATION = 0.2
local FOLLOW_UP_SLASH_DELAY = 0.5
local FOLLOW_UP_SLASH_EXTRA_DURATION = 0.1
local SLASH_RADIUS = 160
local SLASH_RADIUS2 = 460
local SLASH_DAMAGE_RATE = 10
local FOLLOW_UP_SLASH_PARTICLE = "particles/monster/wild_dance_blade_slash/wild_dance_blade_slash.vpcf"
--- 精英技能1 - 蓄力一段时间后使用冲向敌人并且进行重击
____exports.monkey_ab4 = __TS__Class()
local monkey_ab4 = ____exports.monkey_ab4
monkey_ab4.name = "monkey_ab4"
__TS__ClassExtends(monkey_ab4, MonsterAbility_CS)
function monkey_ab4.prototype.____constructor(self, ...)
	MonsterAbility_CS.prototype.____constructor(self, ...)
	self.damageOverTime = 0
end
function monkey_ab4.prototype.Precache(self, context)
	PrecacheResource("particle", FOLLOW_UP_SLASH_PARTICLE, context)
end
function monkey_ab4.prototype.GetMosnterAbilityConfig(self)
	return {
		castRange = 600,
		castPoint = 0.5,
		castDuration = DASH_DURATION + FOLLOW_UP_SLASH_DELAY + FOLLOW_UP_SLASH_EXTRA_DURATION,
		behavior = DOTA_ABILITY_BEHAVIOR_NO_TARGET,
		castAnimation = "",
		OnPhaseStart = function()
			local caster = self:GetCaster()
			local target = caster:GetMinDistanceUnit(4500)
			local forward = caster:GetForwardVector()
			if target then
				forward = GetDirection(nil, target:GetAbsOrigin(), caster:GetAbsOrigin())
				caster:LockTargetForSpeed(target, 0.4, 8)
			end
			self:Timer(0.1, function()
				caster:SetAnimation("mk_attack_04_effigy")
				caster:EmitSound("Hero_Weaver.Swarm.Cast")
				local backPos = ResolveMonkeyBlinkPoint(nil, caster, caster:GetAbsOrigin():__add(forward:__mul(-200)))
				self.damageOverTime = 0
				if backPos then
					caster:Mover(backPos, 0.2)
				end
			end)
		end,
		OnStart = function()
			local caster = self:GetCaster()
			local origin = caster:GetAbsOrigin()
			caster:EmitSound("Hero_Windrunner.ShackleshotCast")
			caster:AddNewModifier(caster, self, "monkey_ab4_pre", { duration = 0.35 })
			ScreenShake(caster:GetAbsOrigin(), 3, 3, 0.5, 2000, 0, true)
			local dashEnd = ResolveMonkeyBlinkPoint(nil, caster, origin:__add(caster:GetForwardVector():__mul(1050)))
			if not dashEnd then
				return
			end
			caster:Mover(dashEnd, DASH_DURATION, function(____, pos)
				if self.damageOverTime == 1 then
					if GetDistance(nil, pos, origin) > 400 then
						return true
					end
					return
				end
				local forward = pos:__add(caster:GetForwardVector():__mul(80))
				self:DamageArea(forward, SLASH_RADIUS, SLASH_DAMAGE_RATE)
			end)
			self:Timer(FOLLOW_UP_SLASH_DELAY + 0.2, function()
				self:WarningRingEffect(caster:GetAbsOrigin(), SLASH_RADIUS2, 0.4)
			end)
			self:Timer(FOLLOW_UP_SLASH_DELAY + 0.2, function()
				caster:SetAnimation("mk_attack_04_effigy")
			end)
			self:Timer(DASH_DURATION + FOLLOW_UP_SLASH_DELAY + 0.4, function()
				return self:PerformFollowUpSlash()
			end)
			self:Timer(0.28, function()
				if not IsServer() then
					return
				end
				caster:EmitSound("Hero_MonkeyKing.Strike.Impact")
				local pfx = ParticleManager:CreateParticle(
					"particles/bb/aoe_dmg_blade_red.vpcf",
					PATTACH_ABSORIGIN_FOLLOW,
					self._caster
				)
				ParticleManager:SetParticleControl(pfx, 0, self._caster:GetAbsOrigin())
				ParticleManager:SetParticleControl(
					pfx,
					4,
					caster:GetAbsOrigin():__add(caster:GetForwardVector():__mul(200))
				)
				ParticleManager:SetParticleControl(
					pfx,
					6,
					caster:GetAbsOrigin():__add(caster:GetForwardVector():__mul(200))
				)
				ParticleManager:SetParticleControl(pfx, 11, Vector(100, 0, 0))
				local released = false
				local function releasePfx()
					if released then
						return
					end
					released = true
					ParticleManager:DestroyParticle(pfx, false)
					ParticleManager:ReleaseParticleIndex(pfx)
				end
				Timers:CreateTimer(1.2, function()
					releasePfx(nil)
					return nil
				end)
			end)
		end,
	}
end
function monkey_ab4.prototype.PerformFollowUpSlash(self)
	local caster = self:GetCaster()
	if not IsValidAlive(nil, caster) then
		return
	end
	caster:EmitSound("Hero_MonkeyKing.Strike.Impact")
	local origin = caster:GetAbsOrigin()
	local pfx = ParticleManager:CreateParticle(FOLLOW_UP_SLASH_PARTICLE, PATTACH_WORLDORIGIN, caster)
	ParticleManager:SetParticleControl(pfx, 0, origin)
	ParticleManager:SetParticleControl(pfx, 2, Vector(SLASH_RADIUS2, 0, 1))
	ParticleManager:ReleaseParticleIndex(pfx)
	self:DamageArea(origin, SLASH_RADIUS2, SLASH_DAMAGE_RATE)
end
function monkey_ab4.prototype.DamageArea(self, origin, radius, damage)
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
monkey_ab4 = __TS__DecorateLegacy({ registerAbility(nil) }, monkey_ab4)
____exports.monkey_ab4 = monkey_ab4
____exports.monkey_ab4_pre = __TS__Class()
local monkey_ab4_pre = ____exports.monkey_ab4_pre
monkey_ab4_pre.name = "monkey_ab4_pre"
__TS__ClassExtends(monkey_ab4_pre, MonsterModifier_CS)
function monkey_ab4_pre.prototype.GetEffectName(self)
	return "particles/bb/ss_primal_beast_2022_prestige_onslaught_charge_active_test2.vpcf"
end
monkey_ab4_pre = __TS__DecorateLegacy({ registerModifier(nil) }, monkey_ab4_pre)
____exports.monkey_ab4_pre = monkey_ab4_pre
return ____exports