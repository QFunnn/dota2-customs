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
____exports.elite_031 = __TS__Class()
local elite_031 = ____exports.elite_031
elite_031.name = "elite_031"
__TS__ClassExtends(elite_031, MonsterAbility_CS)
function elite_031.prototype.____constructor(self, ...)
	MonsterAbility_CS.prototype.____constructor(self, ...)
	self.damageOverTime = 0
end
function elite_031.prototype.GetMosnterAbilityConfig(self)
	return {
		castRange = 600,
		castPoint = 0.35,
		castDuration = 0.8,
		behavior = DOTA_ABILITY_BEHAVIOR_NO_TARGET,
		castAnimation = ACT_DOTA_ATTACK,
		animationPlaybackRate = 0.8,
		OnPhaseStart = function()
			local caster = self:GetCaster()
			local target = caster:GetMinDistanceUnit(800)
			local forward = caster:GetForwardVector()
			if target then
				forward = GetDirection(nil, target:GetAbsOrigin(), caster:GetAbsOrigin())
				caster:LockTargetForSpeed(target, 0.3)
			end
			self.damageOverTime = 0
			caster:Mover(caster:GetAbsOrigin():__add(forward:__mul(-150)), 0.2)
			caster:EmitSound("Hero_Weaver.Swarm.Cast")
		end,
		OnStart = function()
			local caster = self:GetCaster()
			local origin = caster:GetAbsOrigin()
			caster:EmitSound("Hero_Windrunner.ShackleshotCast")
			caster:AddNewModifier(caster, self, "modifier_elite_031", { duration = 0.35 })
			caster:Mover(origin:__add(caster:GetForwardVector():__mul(500)), 0.35, function(____, pos)
				if self.damageOverTime == 1 then
					if GetDistance(nil, pos, origin) > 300 then
						return true
					end
					return
				end
				local forward = pos:__add(caster:GetForwardVector():__mul(80))
				self:DamageArea(forward, 120, 10)
			end)
		end,
	}
end
function elite_031.prototype.DamageArea(self, origin, radius, damage)
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
		AddDeBuffStatus(nil, enemy, caster, self, DebuffStatusType.STUN, { duration = 0.45 })
		self.damageOverTime = 1
	end)
end
elite_031 = __TS__DecorateLegacy({ registerAbility(nil) }, elite_031)
____exports.elite_031 = elite_031
____exports.modifier_elite_031 = __TS__Class()
local modifier_elite_031 = ____exports.modifier_elite_031
modifier_elite_031.name = "modifier_elite_031"
__TS__ClassExtends(modifier_elite_031, MonsterModifier_CS)
function modifier_elite_031.prototype.GetEffectName(self)
	return "particles/bb/ss_primal_beast_2022_prestige_onslaught_charge_active_test2.vpcf"
end
modifier_elite_031 = __TS__DecorateLegacy({ registerModifier(nil) }, modifier_elite_031)
____exports.modifier_elite_031 = modifier_elite_031
return ____exports