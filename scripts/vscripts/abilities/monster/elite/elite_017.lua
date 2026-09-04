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
local CAST_POINT = 0.6
local AOE_RADIUS = 225
local DAMAGE_RATE = 15
local SLOW_PCT = 30
local SLOW_DURATION = 1.5
local THUNDERCLAP_PARTICLE = "particles/ursa_thunderclap.vpcf"
local SLOW_DEBUFF_PARTICLE = "particles/units/heroes/hero_brewmaster/brewmaster_thunder_clap_debuff.vpcf"
--- 精英技能17 - 预警踩地板：前摇 0.4s 显示圆形预警，结束后范围 350 造成伤害并减速，播放 ursa_thunderclap 伤害特效
____exports.elite_017 = __TS__Class()
local elite_017 = ____exports.elite_017
elite_017.name = "elite_017"
__TS__ClassExtends(elite_017, MonsterAbility_CS)
function elite_017.prototype.Precache(self, context)
	PrecacheResource("particle", THUNDERCLAP_PARTICLE, context)
	PrecacheResource("particle", SLOW_DEBUFF_PARTICLE, context)
end
function elite_017.prototype.GetMosnterAbilityConfig(self)
	return {
		castRange = 400,
		behavior = DOTA_ABILITY_BEHAVIOR_NO_TARGET,
		castPoint = CAST_POINT,
		castDuration = 0.6,
		castAnimation = ACT_DOTA_CAST_ABILITY_1,
		OnPhaseStart = function()
			local caster = self:GetCaster()
			if not IsValidAlive(nil, caster) then
				return
			end
			caster:EmitSound("Hero_EarthShaker.Totem")
			local origin = caster:GetAbsOrigin() + caster:GetForwardVector():__mul(80)
			self:WarningRingEffect(origin, AOE_RADIUS, CAST_POINT)
		end,
		OnStart = function()
			local caster = self:GetCaster()
			if not IsValidAlive(nil, caster) then
				return
			end
			local origin = caster:GetAbsOrigin() + caster:GetForwardVector():__mul(80)
			local cp0 = origin
			local cp1 = Vector(AOE_RADIUS, AOE_RADIUS, AOE_RADIUS)
			local pfx = ParticleManager:CreateParticle(THUNDERCLAP_PARTICLE, PATTACH_WORLDORIGIN, nil)
			ParticleManager:SetParticleControl(pfx, 0, cp0)
			ParticleManager:SetParticleControl(pfx, 1, cp1)
			ParticleManager:ReleaseParticleIndex(pfx)
			local enemies = FindUnitsInRadius(
				caster:GetTeamNumber(),
				origin,
				nil,
				AOE_RADIUS,
				DOTA_UNIT_TARGET_TEAM_ENEMY,
				DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,
				DOTA_UNIT_TARGET_FLAG_NONE,
				FIND_ANY_ORDER,
				false
			)
			for ____, enemy in ipairs(enemies) do
				do
					if not IsValidAlive(nil, enemy) then
						goto __continue8
					end
					caster:MonsterDamage({ victim = enemy, damage_rate = DAMAGE_RATE, ability = self })
					AddDeBuffStatus(
						nil,
						enemy,
						caster,
						self,
						DebuffStatusType.ICE_SLOW,
						{ stack = 5, duration = SLOW_DURATION, effect_name = SLOW_DEBUFF_PARTICLE }
					)
				end
				::__continue8::
			end
		end,
	}
end
elite_017 = __TS__DecorateLegacy({ registerAbility(nil) }, elite_017)
____exports.elite_017 = elite_017
return ____exports