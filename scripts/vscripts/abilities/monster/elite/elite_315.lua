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
local CAST_RANGE = 1000
local CAST_POINT = 0.5
local RADIUS = 340
local MARK_PARTICLE = "particles/units/heroes/hero_spirit_breaker/spirit_breaker_charge_target.vpcf"
local HIT_PARTICLE = "particles/units/heroes/hero_spirit_breaker/spirit_breaker_nether_strike_end.vpcf"
____exports.elite_315 = __TS__Class()
local elite_315 = ____exports.elite_315
elite_315.name = "elite_315"
__TS__ClassExtends(elite_315, MonsterAbility_CS)
function elite_315.prototype.Precache(self, context)
	PrecacheResource("particle", MARK_PARTICLE, context)
	PrecacheResource("particle", HIT_PARTICLE, context)
end
function elite_315.prototype.GetMosnterAbilityConfig(self)
	return {
		castRange = CAST_RANGE,
		behavior = DOTA_ABILITY_BEHAVIOR_NO_TARGET,
		castPoint = CAST_POINT,
		castDuration = 1.4,
		castAnimation = ACT_DOTA_CAST_ABILITY_6,
		cooldown = 14,
		OnPhaseStart = function()
			return self:Mark()
		end,
		OnStart = function()
			return self:Strike()
		end,
	}
end
function elite_315.prototype.Mark(self)
	local caster = self:GetCaster()
	local target = caster:GetMinDistanceUnit(CAST_RANGE)
	local ____IsValidAlive_result_0
	if IsValidAlive(nil, target) then
		____IsValidAlive_result_0 = target:GetAbsOrigin()
	else
		____IsValidAlive_result_0 = caster:GetAbsOrigin():__add(caster:GetForwardVector():__mul(450))
	end
	self.point = ____IsValidAlive_result_0
	self:WarningRingEffect(self.point, RADIUS, CAST_POINT + 0.55)
	self:PlayChargeMarkEffect(caster, self.point)
end
function elite_315.prototype.Strike(self)
	local caster = self:GetCaster()
	if not IsValidAlive(nil, caster) then
		return
	end
	local point = self.point or caster:GetAbsOrigin()
	EmitSoundOn("Hero_Spirit_Breaker.NetherStrike.Begin", caster)
	self:Timer(0.55, function()
		if not IsValidAlive(nil, caster) then
			return
		end
		FindClearSpaceForUnit(caster, GetGroundPosition(point, caster), true)
		EmitSoundOn("Hero_Spirit_Breaker.NetherStrike.End", caster)
		self:PlayNetherStrikeEffect(caster, point)
		self:DamageEnemiesInRadius(caster, point)
	end)
end
function elite_315.prototype.PlayChargeMarkEffect(self, caster, point)
	local particle = ParticleManager:CreateParticle(MARK_PARTICLE, PATTACH_WORLDORIGIN, caster)
	ParticleManager:SetParticleControl(particle, 0, point)
	ParticleManager:SetParticleControl(particle, 1, Vector(RADIUS, 0, 0))
	ParticleManager:ReleaseParticleIndex(particle)
end
function elite_315.prototype.PlayNetherStrikeEffect(self, caster, point)
	local particle = ParticleManager:CreateParticle(HIT_PARTICLE, PATTACH_WORLDORIGIN, caster)
	ParticleManager:SetParticleControl(particle, 0, point)
	ParticleManager:SetParticleControl(particle, 1, Vector(RADIUS, RADIUS, 0))
	ParticleManager:ReleaseParticleIndex(particle)
end
function elite_315.prototype.DamageEnemiesInRadius(self, caster, point)
	local enemies = FindUnitsInRadius(
		caster:GetTeamNumber(),
		point,
		nil,
		RADIUS,
		DOTA_UNIT_TARGET_TEAM_ENEMY,
		DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,
		DOTA_UNIT_TARGET_FLAG_NONE,
		FIND_ANY_ORDER,
		false
	)
	for ____, enemy in ipairs(enemies) do
		do
			if not IsValidAlive(nil, enemy) then
				goto __continue14
			end
			caster:MonsterDamage({ victim = enemy, damage_rate = 16, ability = self, effectName = HIT_PARTICLE })
			AddDeBuffStatus(nil, enemy, caster, self, DebuffStatusType.STUN, { duration = 0.55 })
		end
		::__continue14::
	end
end
elite_315 = __TS__DecorateLegacy({ registerAbility(nil) }, elite_315)
____exports.elite_315 = elite_315
return ____exports