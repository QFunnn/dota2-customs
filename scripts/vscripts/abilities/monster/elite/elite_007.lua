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
local TOTAL_DURATION = 4
local CAST_POINT = 2
local EXPLOSION_COUNT = 3
local EXPLOSION_INTERVAL = 0.25
local EXPLOSION_DISTANCE_STEP = 270
local EXPLOSION_RADIUS = 130
local DAMAGE_RATE = 24
local EXPECTED_DAMAGE_HEALTH_PCT_SCALE = 18 / DAMAGE_RATE
local SPLIT_EARTH_PARTICLE = "particles/units/heroes/hero_leshrac/leshrac_split_earth_2.vpcf"
--- 精英技能7 - 前摇后沿面向方向连续裂地爆炸
____exports.elite_007 = __TS__Class()
local elite_007 = ____exports.elite_007
elite_007.name = "elite_007"
__TS__ClassExtends(elite_007, MonsterAbility_CS)
function elite_007.prototype.Precache(self, context)
	PrecacheResource("particle", SPLIT_EARTH_PARTICLE, context)
end
function elite_007.prototype.GetMosnterAbilityConfig(self)
	local maxDistance = EXPLOSION_DISTANCE_STEP * EXPLOSION_COUNT + EXPLOSION_RADIUS
	return {
		castRange = maxDistance,
		castPoint = CAST_POINT,
		castDuration = TOTAL_DURATION - CAST_POINT + 0.1,
		behavior = DOTA_ABILITY_BEHAVIOR_NO_TARGET,
		castAnimation = ACT_DOTA_CAST_ABILITY_3,
		OnPhaseStart = function()
			local caster = self:GetCaster()
			local target = caster:GetMinDistanceUnit(3500)
			caster:LockTargetForSpeed(target, CAST_POINT - 0.1, 2)
			local start_pos = caster:GetAbsOrigin()
			local end_pos = start_pos:__add(caster:GetForwardVector():__mul(maxDistance + 100))
			self:WarningEffect(caster:GetAbsOrigin(), end_pos, CAST_POINT, {
				getDirection = function()
					return self._caster:GetForwardVector()
				end,
			})
		end,
		OnStart = function()
			local caster = self:GetCaster()
			caster:EmitSound("Hero_Jakiro.IcePath")
			local origin = caster:GetAbsOrigin()
			local forward = caster:GetForwardVector()
			do
				local i = 0
				while i < EXPLOSION_COUNT do
					local delay = i * EXPLOSION_INTERVAL
					local distance = EXPLOSION_DISTANCE_STEP * (i + 1)
					local radius = EXPLOSION_RADIUS + i * 30
					self:Timer(delay, function()
						local center = origin:__add(forward:__mul(distance - 80))
						self:CreateSplitEarth(center, radius)
						self:DamageArea(center, radius, DAMAGE_RATE)
						ScreenShake(center, 15, 15, 0.15, 2000, 0, true)
					end)
					i = i + 1
				end
			end
		end,
	}
end
function elite_007.prototype.CreateSplitEarth(self, center, radius)
	local effect = ParticleManager:CreateParticle(SPLIT_EARTH_PARTICLE, PATTACH_WORLDORIGIN, nil)
	local ground = GetGroundPosition(center, nil)
	ParticleManager:SetParticleControl(effect, 0, ground)
	ParticleManager:SetParticleControl(effect, 1, Vector(radius, 0, 0))
	ParticleManager:ReleaseParticleIndex(effect)
end
function elite_007.prototype.DamageArea(self, origin, radius, damageRate)
	local caster = self:GetCaster()
	local enemies = FindUnitsInRadius(
		caster:GetTeamNumber(),
		origin,
		nil,
		radius,
		DOTA_UNIT_TARGET_TEAM_ENEMY,
		DOTA_UNIT_TARGET_HEROES_AND_CREEPS,
		DOTA_UNIT_TARGET_FLAG_NONE,
		0,
		false
	)
	__TS__ArrayForEach(enemies, function(____, enemy)
		enemy:KnockBack(caster, self, {
			duration = 0.3,
			origin_pos = origin,
			stunDuration = 1.2,
			stun = true,
			distance = 0,
			height = 200,
		})
		AddDeBuffStatus(nil, enemy, caster, self, DebuffStatusType.ICE_SLOW, { stack = 5, duration = 3 })
		caster:MonsterDamage({
			victim = enemy,
			damage_rate = damageRate,
			ability = self,
			expected_damage_health_pct = EXPECTED_DAMAGE_HEALTH_PCT_SCALE,
		})
	end)
end
elite_007 = __TS__DecorateLegacy({ registerAbility(nil) }, elite_007)
____exports.elite_007 = elite_007
return ____exports