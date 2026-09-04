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
local ____elite_148 = require("abilities.monster.elite.elite_148")
local ELITE_148_BURROW_CAST_POINT = ____elite_148.ELITE_148_BURROW_CAST_POINT
local ELITE_148_BURROW_PARTICLE = ____elite_148.ELITE_148_BURROW_PARTICLE
local elite_148 = ____elite_148.elite_148
local modifier_elite_148_mound = ____elite_148.modifier_elite_148_mound
local CAST_RANGE = 1000
local UNBURROW_DURATION = 0.65
local IMPALE_CAST_DELAY = 0.35
local IMPALE_FINISH_DELAY = 0.25
local IMPALE_DISTANCE = 900
local IMPALE_WIDTH = 140
local IMPALE_SPEED = 1800
local IMPALE_DAMAGE_RATE = 14
local IMPALE_STUN_DURATION = 0.7
local IMPALE_KNOCKUP_HEIGHT = 160
local CAST_DURATION = UNBURROW_DURATION + IMPALE_CAST_DELAY + IMPALE_FINISH_DELAY + ELITE_148_BURROW_CAST_POINT + 0.25
local IMPALE_PARTICLE = "particles/econ/items/nyx_assassin/nyx_assassin_ti6/nyx_assassin_impale_ti6.vpcf"
local IMPALE_HIT_PARTICLE = "particles/units/heroes/hero_nyx_assassin/nyx_assassin_impale_hit.vpcf"
____exports.elite_149 = __TS__Class()
local elite_149 = ____exports.elite_149
elite_149.name = "elite_149"
__TS__ClassExtends(elite_149, MonsterAbility_CS)
function elite_149.prototype.____constructor(self, ...)
	MonsterAbility_CS.prototype.____constructor(self, ...)
	self.sequence = 0
end
function elite_149.prototype.Precache(self, context)
	PrecacheResource("particle", ELITE_148_BURROW_PARTICLE, context)
	PrecacheResource("particle", IMPALE_PARTICLE, context)
	PrecacheResource("particle", IMPALE_HIT_PARTICLE, context)
end
function elite_149.prototype.GetMosnterAbilityConfig(self)
	return {
		castRange = CAST_RANGE,
		behavior = DOTA_ABILITY_BEHAVIOR_NO_TARGET,
		castPoint = 0,
		castDuration = CAST_DURATION,
		castAnimation = ACT_DOTA_CAST_BURROW_END,
		cooldown = 10,
		canCast = function()
			local ____IsValidAlive_result_0
			if IsValidAlive(nil, self:FindTarget()) then
				____IsValidAlive_result_0 = UF_SUCCESS
			else
				____IsValidAlive_result_0 = UF_FAIL_CUSTOM
			end
			return ____IsValidAlive_result_0
		end,
		OnStart = function()
			local caster = self:GetCaster()
			if not IsValidAlive(nil, caster) then
				return
			end
			self.sequence = self.sequence + 1
			local sequence = self.sequence
			self:StartSequence(caster, sequence)
		end,
		OnInterrupt = function()
			self.sequence = self.sequence + 1
		end,
	}
end
function elite_149.prototype.StartSequence(self, caster, sequence)
	modifier_elite_148_mound:remove(caster)
	caster:StartGestureWithPlaybackRate(ACT_DOTA_CAST_BURROW_END, 1)
	self:Timer(UNBURROW_DURATION, function()
		if sequence ~= self.sequence or not IsValidAlive(nil, caster) then
			return
		end
		self:StartImpale(caster, sequence)
	end)
end
function elite_149.prototype.StartImpale(self, caster, sequence)
	local origin = GetGroundPosition(caster:GetAbsOrigin(), caster)
	local direction = self:ResolveImpaleDirection(caster)
	local ____end = GetGroundPosition(origin:__add(direction:__mul(IMPALE_DISTANCE)), caster)
	caster:SetForwardVector(direction)
	caster:StartGestureWithPlaybackRate(ACT_DOTA_CAST_ABILITY_1, 1)
	self:WarningEffect(origin, ____end, IMPALE_CAST_DELAY, { startWidth = IMPALE_WIDTH, endWidth = IMPALE_WIDTH })
	self:Timer(IMPALE_CAST_DELAY, function()
		if sequence ~= self.sequence or not IsValidAlive(nil, caster) then
			return
		end
		self:DoImpale(caster, origin, ____end)
	end)
	self:Timer(IMPALE_CAST_DELAY + IMPALE_FINISH_DELAY, function()
		if sequence ~= self.sequence or not IsValidAlive(nil, caster) then
			return
		end
		elite_148:StartBurrow(caster, self)
	end)
end
function elite_149.prototype.DoImpale(self, caster, start, ____end)
	CreateProjectile(nil, {
		ability = self,
		caster = caster,
		effect_name = IMPALE_PARTICLE,
		projectile_type = "linear",
		start_point = start,
		target = ____end,
		projectile_speed = IMPALE_SPEED,
		projectile_distance = IMPALE_DISTANCE,
		projectile_range = IMPALE_WIDTH,
		projectile_target_team = DOTA_UNIT_TARGET_TEAM_ENEMY,
		projectile_target_type = DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,
		projectile_target_flags = DOTA_UNIT_TARGET_FLAG_NONE,
		on_hit = function(____, hitTarget)
			if not hitTarget or not IsValidAlive(nil, hitTarget) then
				return true
			end
			if not IsValidAlive(nil, caster) then
				return
			end
			caster:MonsterDamage({ victim = hitTarget, damage_rate = IMPALE_DAMAGE_RATE, ability = self })
			AddDeBuffStatus(nil, hitTarget, caster, self, DebuffStatusType.STUN, { duration = IMPALE_STUN_DURATION })
			hitTarget:KnockBack(caster, self, {
				duration = IMPALE_STUN_DURATION,
				distance = 0,
				height = IMPALE_KNOCKUP_HEIGHT,
				stun = true,
				stunDuration = IMPALE_STUN_DURATION,
			})
			self:PlayImpaleHitEffect(hitTarget:GetAbsOrigin())
			return false
		end,
	})
end
function elite_149.prototype.ResolveImpaleDirection(self, caster)
	local target = self:FindTarget()
	if IsValidAlive(nil, target) then
		local direction = GetDirection(nil, target:GetAbsOrigin(), caster:GetAbsOrigin())
		if direction:Length2D() > 0.01 then
			return direction
		end
	end
	return caster:GetForwardVector()
end
function elite_149.prototype.FindTarget(self)
	local caster = self:GetCaster()
	if not IsValidAlive(nil, caster) then
		return nil
	end
	return caster:GetMinDistanceUnit(CAST_RANGE)
end
function elite_149.prototype.PlayImpaleHitEffect(self, origin)
	local particle = ParticleManager:CreateParticle(IMPALE_HIT_PARTICLE, PATTACH_WORLDORIGIN, nil)
	ParticleManager:SetParticleControl(particle, 0, origin)
	ParticleManager:ReleaseParticleIndex(particle)
end
elite_149 = __TS__DecorateLegacy({ registerAbility(nil) }, elite_149)
____exports.elite_149 = elite_149
return ____exports