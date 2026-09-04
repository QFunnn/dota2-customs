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
local CAST_RANGE = 800
local CAST_POINT = 1.7
local IMPACT_DELAY = 0.65
local IMPACT_RADIUS = 520
local DAMAGE_RATE = 38
local STUN_DURATION = 0.35
local IMPACT_PARTICLE = "particles/units/heroes/hero_leshrac/leshrac_split_earth.vpcf"
local IMPACT_SOUND_EVENTS = "soundevents/game_sounds_heroes/game_sounds_leshrac.vsndevts"
local IMPACT_SOUND = "Hero_Leshrac.Split_Earth"
--- 精英技能49 - 裂地重踏：锁定最近敌人，短暂预警后造成范围伤害和短眩晕
____exports.elite_049 = __TS__Class()
local elite_049 = ____exports.elite_049
elite_049.name = "elite_049"
__TS__ClassExtends(elite_049, MonsterAbility_CS)
function elite_049.prototype.____constructor(self, ...)
	MonsterAbility_CS.prototype.____constructor(self, ...)
	self.target_pos_049 = nil
end
function elite_049.prototype.Precache(self, context)
	PrecacheResource("particle", IMPACT_PARTICLE, context)
	PrecacheResource("soundfile", IMPACT_SOUND_EVENTS, context)
end
function elite_049.prototype.GetMosnterAbilityConfig(self)
	return {
		behavior = DOTA_ABILITY_BEHAVIOR_NO_TARGET,
		castRange = CAST_RANGE,
		castPoint = CAST_POINT,
		castDuration = IMPACT_DELAY + 0.2,
		castAnimation = ACT_DOTA_CAST_ABILITY_3,
		OnPhaseStart = function()
			local caster = self:GetCaster()
			caster:EmitSound("Hero_ElderTitan.EarthSplitter.Cast")
			local target = caster:GetMinDistanceUnit(CAST_RANGE)
			if IsValidAlive(nil, target) then
				caster:LockTargetForSpeed(target, 1)
				self:Timer(1, function()
					if not IsValidAlive(nil, target) then
						return
					end
					self.target_pos_049 = target:GetAbsOrigin()
					self:WarningRingEffect(self.target_pos_049, IMPACT_RADIUS, IMPACT_DELAY)
				end)
			end
		end,
		OnStart = function()
			if not self.target_pos_049 then
				return
			end
			self:Impact(self.target_pos_049)
		end,
	}
end
function elite_049.prototype.Impact(self, origin)
	local caster = self:GetCaster()
	if not IsValidAlive(nil, caster) then
		return
	end
	local pfx = ParticleManager:CreateParticle(IMPACT_PARTICLE, PATTACH_WORLDORIGIN, nil)
	ParticleManager:SetParticleControl(pfx, 0, origin)
	ParticleManager:SetParticleControl(pfx, 1, Vector(IMPACT_RADIUS, IMPACT_RADIUS, IMPACT_RADIUS))
	ParticleManager:ReleaseParticleIndex(pfx)
	EmitSoundOnLocationWithCaster(origin, IMPACT_SOUND, caster)
	local enemies = FindUnitsInRadius(
		caster:GetTeamNumber(),
		origin,
		nil,
		IMPACT_RADIUS,
		DOTA_UNIT_TARGET_TEAM_ENEMY,
		DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,
		DOTA_UNIT_TARGET_FLAG_NONE,
		FIND_ANY_ORDER,
		false
	)
	for ____, enemy in ipairs(enemies) do
		do
			if not IsValidAlive(nil, enemy) then
				goto __continue12
			end
			caster:MonsterDamage({ victim = enemy, damage_rate = DAMAGE_RATE, ability = self })
			AddDeBuffStatus(nil, enemy, caster, self, DebuffStatusType.STUN, { duration = STUN_DURATION })
		end
		::__continue12::
	end
end
elite_049 = __TS__DecorateLegacy({ registerAbility(nil) }, elite_049)
____exports.elite_049 = elite_049
return ____exports