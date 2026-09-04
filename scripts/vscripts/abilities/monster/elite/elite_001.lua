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
--- 精英技能1 - 蓄力一段时间后使用冲向敌人并且进行重击
____exports.elite_001 = __TS__Class()
local elite_001 = ____exports.elite_001
elite_001.name = "elite_001"
__TS__ClassExtends(elite_001, MonsterAbility_CS)
function elite_001.prototype.GetMosnterAbilityConfig(self)
	return {
		castRange = 600,
		castPoint = 1.75,
		castDuration = 2.1,
		behavior = DOTA_ABILITY_BEHAVIOR_NO_TARGET,
		castAnimation = ACT_DOTA_CAST_ABILITY_2,
		OnPhaseStart = function()
			local caster = self:GetCaster()
			local target = caster:GetMinDistanceUnit(3500)
			caster:LockTargetForSpeed(target, 1.6)
			self:WarningEffect(
				caster:GetAbsOrigin(),
				caster:GetAbsOrigin():__add(caster:GetForwardVector():__mul(750)),
				1.65,
				{
					getDirection = function(self)
						return caster:GetForwardVector()
					end,
				}
			)
		end,
		OnStart = function()
			local caster = self:GetCaster()
			caster:EmitSound("Hero_EarthShaker.Totem")
			local origin = caster:GetAbsOrigin()
			caster:Mover(origin:__add(caster:GetForwardVector():__mul(-100)), 0.35)
			self:Timer(0.35, function()
				caster:Mover(origin:__add(caster:GetForwardVector():__mul(600)), 0.35, function(____, pos)
					local forward = pos:__add(caster:GetForwardVector():__mul(80))
					local enemies = self:GetMinDistanceUnit(80, forward)
					return not not enemies
				end)
				self:Timer(0.6, function()
					local target_pos = caster:GetAbsOrigin():__add(caster:GetForwardVector():__mul(120))
					self:CreateEffect(target_pos)
					self:DamageArea(target_pos, 260, 5)
				end)
			end)
		end,
	}
end
function elite_001.prototype.CreateEffect(self, origin)
	local caster = self:GetCaster()
	local effect = ParticleManager:CreateParticle(
		"particles/econ/items/centaur/centaur_ti6/centaur_ti6_warstomp.vpcf",
		PATTACH_WORLDORIGIN,
		nil
	)
	ParticleManager:SetParticleControl(effect, 0, origin)
	ParticleManager:SetParticleControl(effect, 1, Vector(300, 0, 0))
	ParticleManager:ReleaseParticleIndex(effect)
end
function elite_001.prototype.DamageArea(self, origin, radius, damage)
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
		caster:MonsterDamage({ victim = enemy, damage_rate = 20, ability = self })
		AddDeBuffStatus(nil, enemy, caster, self, DebuffStatusType.STUN, { duration = 2 })
	end)
end
elite_001 = __TS__DecorateLegacy({ registerAbility(nil) }, elite_001)
____exports.elite_001 = elite_001
return ____exports