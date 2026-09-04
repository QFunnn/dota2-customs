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
local LOCK_RANGE = 1000
local CAST_RANGE = 700
local STEP_DISTANCE = 150
local HIT_COUNT = 4
local HIT_INTERVAL = 0.3
local DAMAGE_RADIUS = 150
local TOTAL_DISTANCE = STEP_DISTANCE * HIT_COUNT
local DAMAGE_RATE = 15
local LIGHTNING_HEIGHT = 1500
local LIGHTNING_PARTICLE = "particles/units/heroes/hero_leshrac/leshrac_lightning_bolt.vpcf"
local EDICT_PARTICLE = "particles/units/heroes/hero_leshrac/leshrac_diabolic_edict.vpcf"
--- 精英技能19 - 预警 0.6s 后向前逐步释放 4 次闪电，间隔 0.3s，每次移动 150，范围 150，闪电+落点特效
____exports.elite_019 = __TS__Class()
local elite_019 = ____exports.elite_019
elite_019.name = "elite_019"
__TS__ClassExtends(elite_019, MonsterAbility_CS)
function elite_019.prototype.Precache(self, context)
	PrecacheResource("particle", LIGHTNING_PARTICLE, context)
	PrecacheResource("particle", EDICT_PARTICLE, context)
end
function elite_019.prototype.GetMosnterAbilityConfig(self)
	return {
		castRange = CAST_RANGE,
		behavior = DOTA_ABILITY_BEHAVIOR_NO_TARGET,
		castPoint = CAST_POINT,
		castDuration = HIT_INTERVAL * (HIT_COUNT - 1) + 0.5,
		castAnimation = ACT_DOTA_CAST_ABILITY_1,
		OnPhaseStart = function()
			local caster = self:GetCaster()
			if not IsValidAlive(nil, caster) then
				return
			end
			local origin = caster:GetAbsOrigin()
			local target = self:GetMinDistanceUnit(LOCK_RANGE, origin)
			if IsValidAlive(nil, target) then
				caster:LockTargetForSpeed(target, CAST_POINT)
			end
			local forward = caster:GetForwardVector()
			local warnEnd = origin:__add(forward:__mul(TOTAL_DISTANCE))
			self:WarningEffect(origin, warnEnd, CAST_POINT, {
				startWidth = DAMAGE_RADIUS,
				endWidth = DAMAGE_RADIUS,
				getDirection = function()
					return caster:GetForwardVector()
				end,
			})
		end,
		OnStart = function()
			local caster = self:GetCaster()
			if not IsValidAlive(nil, caster) then
				return
			end
			caster:EmitSound("Hero_Disruptor.ThunderStrike.Cast")
			caster:StartGestureWithPlaybackRate(ACT_DOTA_CAST_ABILITY_1, 1)
			local origin = caster:GetAbsOrigin()
			local forward = caster:GetForwardVector()
			do
				local i = 0
				while i < HIT_COUNT do
					local delay = i * HIT_INTERVAL
					self:Timer(delay, function()
						if not IsValidAlive(nil, caster) then
							return
						end
						local hitDistance = STEP_DISTANCE * (i + 1)
						local groundPos = GetGroundPosition(origin:__add(forward:__mul(hitDistance)), nil)
						local lightningStart = groundPos:__add(Vector(0, 0, LIGHTNING_HEIGHT))
						self:PlayLightningEffect(lightningStart, groundPos)
						self:PlayEdictEffect(groundPos)
						self:DamageArea(groundPos, DAMAGE_RADIUS, DAMAGE_RATE)
					end)
					i = i + 1
				end
			end
		end,
	}
end
function elite_019.prototype.PlayLightningEffect(self, cp0, cp1)
	local pfx = ParticleManager:CreateParticle(LIGHTNING_PARTICLE, PATTACH_WORLDORIGIN, nil)
	ParticleManager:SetParticleControl(pfx, 0, cp0)
	ParticleManager:SetParticleControl(pfx, 1, cp1)
	ParticleManager:ReleaseParticleIndex(pfx)
end
function elite_019.prototype.PlayEdictEffect(self, origin)
	local pfx = ParticleManager:CreateParticle(EDICT_PARTICLE, PATTACH_WORLDORIGIN, nil)
	ParticleManager:SetParticleControl(pfx, 1, origin)
	ParticleManager:ReleaseParticleIndex(pfx)
end
function elite_019.prototype.DamageArea(self, center, radius, damageRate)
	local caster = self:GetCaster()
	if not IsValidAlive(nil, caster) then
		return
	end
	local enemies = FindUnitsInRadius(
		caster:GetTeamNumber(),
		center,
		nil,
		radius,
		DOTA_UNIT_TARGET_TEAM_ENEMY,
		DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,
		DOTA_UNIT_TARGET_FLAG_NONE,
		FIND_ANY_ORDER,
		false
	)
	for ____, enemy in ipairs(enemies) do
		do
			if not IsValidAlive(nil, enemy) then
				goto __continue17
			end
			caster:MonsterDamage({ victim = enemy, damage_rate = damageRate, ability = self })
		end
		::__continue17::
	end
end
elite_019 = __TS__DecorateLegacy({ registerAbility(nil) }, elite_019)
____exports.elite_019 = elite_019
return ____exports