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
local CAST_RANGE = 1200
local CAST_POINT = 0.55
local SPIKE_DELAY = 0.7
local SPIKE_RADIUS = 230
local SPIKE_COUNT = 4
local SPIKE_RING_RADIUS = 260
local DAMAGE_RATE = 16
local STUN_DURATION = 0.2
local SPIKE_PARTICLE = "particles/units/heroes/hero_tiny/tiny_avalanche.vpcf"
local SPIKE_SOUND_EVENTS = "soundevents/game_sounds_heroes/game_sounds_tiny.vsndevts"
local SPIKE_SOUND = "Ability.Avalanche"
--- 精英技能55 - 晶刺爆发：在目标周围生成多段晶刺爆炸
____exports.elite_055 = __TS__Class()
local elite_055 = ____exports.elite_055
elite_055.name = "elite_055"
__TS__ClassExtends(elite_055, MonsterAbility_CS)
function elite_055.prototype.Precache(self, context)
	PrecacheResource("particle", SPIKE_PARTICLE, context)
	PrecacheResource("soundfile", SPIKE_SOUND_EVENTS, context)
end
function elite_055.prototype.GetMosnterAbilityConfig(self)
	return {
		behavior = DOTA_ABILITY_BEHAVIOR_NO_TARGET,
		castRange = CAST_RANGE,
		castPoint = CAST_POINT,
		castDuration = SPIKE_DELAY + 0.3,
		castAnimation = ACT_DOTA_CAST_ABILITY_2,
		canCast = function()
			local ____IsValidAlive_result_0
			if IsValidAlive(nil, self:GetCaster():GetMinDistanceUnit(CAST_RANGE)) then
				____IsValidAlive_result_0 = UF_SUCCESS
			else
				____IsValidAlive_result_0 = UF_FAIL_CUSTOM
			end
			return ____IsValidAlive_result_0
		end,
		OnPhaseStart = function()
			local caster = self:GetCaster()
			local target = caster:GetMinDistanceUnit(CAST_RANGE)
			if IsValidAlive(nil, target) then
				caster:LockTargetForSpeed(target, CAST_POINT)
			end
		end,
		OnStart = function()
			local caster = self:GetCaster()
			local target = caster:GetMinDistanceUnit(CAST_RANGE)
			if not IsValidAlive(nil, target) then
				return
			end
			local center = GetGroundPosition(target:GetAbsOrigin(), caster)
			local points = self:GetSpikePoints(center)
			for ____, point in ipairs(points) do
				self:WarningRingEffect(point, SPIKE_RADIUS, SPIKE_DELAY)
			end
			self:Timer(SPIKE_DELAY, function()
				for ____, point in ipairs(points) do
					self:Spike(point)
				end
			end)
		end,
	}
end
function elite_055.prototype.GetSpikePoints(self, center)
	local points = { center }
	do
		local i = 0
		while i < SPIKE_COUNT do
			local angle = 360 / SPIKE_COUNT * i
			points[#points + 1] = center:__add(RotateVector2D(nil, Vector(1, 0, 0), angle):__mul(SPIKE_RING_RADIUS))
			i = i + 1
		end
	end
	return points
end
function elite_055.prototype.Spike(self, origin)
	local caster = self:GetCaster()
	if not IsValidAlive(nil, caster) then
		return
	end
	local pfx = ParticleManager:CreateParticle(SPIKE_PARTICLE, PATTACH_WORLDORIGIN, nil)
	ParticleManager:SetParticleControl(pfx, 0, origin)
	ParticleManager:SetParticleControl(pfx, 1, Vector(SPIKE_RADIUS, SPIKE_RADIUS, SPIKE_RADIUS))
	ParticleManager:ReleaseParticleIndex(pfx)
	EmitSoundOnLocationWithCaster(origin, SPIKE_SOUND, caster)
	local enemies = FindUnitsInRadius(
		caster:GetTeamNumber(),
		origin,
		nil,
		SPIKE_RADIUS,
		DOTA_UNIT_TARGET_TEAM_ENEMY,
		DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,
		DOTA_UNIT_TARGET_FLAG_NONE,
		FIND_ANY_ORDER,
		false
	)
	for ____, enemy in ipairs(enemies) do
		do
			if not IsValidAlive(nil, enemy) then
				goto __continue18
			end
			caster:MonsterDamage({ victim = enemy, damage_rate = DAMAGE_RATE, ability = self })
			AddDeBuffStatus(nil, enemy, caster, self, DebuffStatusType.STUN, { duration = STUN_DURATION })
		end
		::__continue18::
	end
end
elite_055 = __TS__DecorateLegacy({ registerAbility(nil) }, elite_055)
____exports.elite_055 = elite_055
return ____exports