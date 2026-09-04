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
--- 精英技能1 - 蓄力一段时间后使用冲向敌人并且进行重击
____exports.qop_3 = __TS__Class()
local qop_3 = ____exports.qop_3
qop_3.name = "qop_3"
__TS__ClassExtends(qop_3, MonsterAbility_CS)
function qop_3.prototype.____constructor(self, ...)
	MonsterAbility_CS.prototype.____constructor(self, ...)
	self.damageOverTime = 0
end
function qop_3.prototype.GetMosnterAbilityConfig(self)
	return {
		castRange = 600,
		castPoint = 0.35,
		castDuration = 0.2,
		behavior = DOTA_ABILITY_BEHAVIOR_NO_TARGET,
		castAnimation = ACT_DOTA_CAST_ABILITY_4,
		animationPlaybackRate = 0.8,
		OnPhaseStart = function()
			local caster = self:GetCaster()
			local target = caster:GetMinDistanceUnit(800)
			local forward = caster:GetForwardVector()
			if target then
				forward = GetDirection(nil, target:GetAbsOrigin(), caster:GetAbsOrigin())
				caster:LockTargetForSpeed(target, 0.4)
			end
			caster:EmitSound("Hero_Weaver.Swarm.Cast")
			self.damageOverTime = 0
			caster:Mover(caster:GetAbsOrigin():__add(forward:__mul(-200)), 0.2)
		end,
		OnStart = function()
			local caster = self:GetCaster()
			local origin = caster:GetAbsOrigin()
			caster:EmitSound("Hero_Windrunner.ShackleshotCast")
			caster:AddNewModifier(caster, self, "qop_3_pre2", { duration = 0.35 })
			caster:AddNewModifier(caster, self, "qop_3_pre1", { duration = 0.35 })
			ScreenShake(caster:GetAbsOrigin(), 3, 3, 0.5, 2000, 0, true)
			caster:Mover(origin:__add(caster:GetForwardVector():__mul(850)), 0.3, function(____, pos)
				if self.damageOverTime == 1 then
					if GetDistance(nil, pos, origin) > 400 then
						return true
					end
					return
				end
				local forward = pos:__add(caster:GetForwardVector():__mul(80))
				self:DamageArea(forward, 160, 10)
			end)
			self:Timer(0.28, function()
				if not IsServer() then
					return
				end
				caster:EmitSound("Hero_MonkeyKing.Strike.Impact")
				local pfx = ParticleManager:CreateParticle(
					"particles/bb/aoe_dmg_blade_red_2.vpcf",
					PATTACH_ABSORIGIN_FOLLOW,
					self._caster
				)
				ParticleManager:SetParticleControl(pfx, 0, self._caster:GetAbsOrigin())
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
function qop_3.prototype.DamageArea(self, origin, radius, damage)
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
		AddDeBuffStatus(nil, enemy, caster, self, DebuffStatusType.STUN, { duration = 1.2 })
		self.damageOverTime = 1
	end)
end
qop_3 = __TS__DecorateLegacy({ registerAbility(nil) }, qop_3)
____exports.qop_3 = qop_3
____exports.qop_3_pre1 = __TS__Class()
local qop_3_pre1 = ____exports.qop_3_pre1
qop_3_pre1.name = "qop_3_pre1"
__TS__ClassExtends(qop_3_pre1, MonsterModifier_CS)
function qop_3_pre1.prototype.GetEffectName(self)
	return "particles/bb/ss_primal_beast_2022_prestige_onslaught_charge_active_test2.vpcf"
end
qop_3_pre1 = __TS__DecorateLegacy({ registerModifier(nil) }, qop_3_pre1)
____exports.qop_3_pre1 = qop_3_pre1
____exports.qop_3_pre2 = __TS__Class()
local qop_3_pre2 = ____exports.qop_3_pre2
qop_3_pre2.name = "qop_3_pre2"
__TS__ClassExtends(qop_3_pre2, MonsterModifier_CS)
function qop_3_pre2.prototype.GetEffectName(self)
	return "particles/econ/items/queen_of_pain/qop_arcana/qop_arcana_blink_start_model.vpcf"
end
qop_3_pre2 = __TS__DecorateLegacy({ registerModifier(nil) }, qop_3_pre2)
____exports.qop_3_pre2 = qop_3_pre2
return ____exports