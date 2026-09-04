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
local Set = ____lualib.Set
local __TS__New = ____lualib.__TS__New
local __TS__DecorateLegacy = ____lualib.__TS__DecorateLegacy
local ____exports = {}
local ____dota_ts_adapter = require("utils.dota_ts_adapter")
local registerAbility = ____dota_ts_adapter.registerAbility
local registerModifier = ____dota_ts_adapter.registerModifier
local ____monster_base = require("abilities.monster.monster_base")
local MonsterAbility_CS = ____monster_base.MonsterAbility_CS
local MonsterModifier_CS = ____monster_base.MonsterModifier_CS
local ELITE_034_CAST_POINT = 0.7
local ELITE_034_CAST_DURATION = 3.5
local ELITE_034_CHARGE_ACTION_TOTAL_TIME = 1.2
local ELITE_034_CHARGE_ACTIVE_DURATION = 0.4
local ELITE_034_SMASH_START_DELAY = ELITE_034_CHARGE_ACTION_TOTAL_TIME - ELITE_034_CAST_POINT
local ELITE_034_SMASH_PREP_TIME = 1.2
local ELITE_034_DASH_DISTANCE = 900
local ELITE_034_JUMP_BEFORE_CAST_END = 0.3
local ELITE_034_JUMP_MAX_DISTANCE = 600
local ELITE_034_JUMP_TARGET_OFFSET = 150
local ELITE_034_SMASH_RADIUS = 250
local ELITE_034_SMASH_DAMAGE_RATE = 35
local ELITE_034_CHARGE_HIT_RADIUS = 100
local ELITE_034_CHARGE_DAMAGE_RATE = 35
local ELITE_034_CHARGE_STUN_DURATION = 1.45
local ELITE_034_TARGET_SEARCH_RANGE = 1200
local ELITE_034_SMASH_SOUND = "Hero_PrimalBeast.RockThrow.Impact"
local ELITE_034_DASH_SOUND = "Hero_PrimalBeast.Onslaught.Cast"
local ELITE_034_CHARGE_HIT_SOUND = "Hero_Spirit_Breaker.GreaterBash"
local ELITE_034_SMASH_PARTICLE = "particles/dd/showin.vpcf"
local ELITE_034_CHARGE_HIT_PARTICLE = "particles/bash.vpcf"
--- 精英技能34 - 先冲撞，再跃起砸地的两段连招
____exports.elite_034 = __TS__Class()
local elite_034 = ____exports.elite_034
elite_034.name = "elite_034"
__TS__ClassExtends(elite_034, MonsterAbility_CS)
function elite_034.prototype.Precache(self, context)
	PrecacheResource("particle", ELITE_034_SMASH_PARTICLE, context)
	PrecacheResource("particle", ELITE_034_CHARGE_HIT_PARTICLE, context)
end
function elite_034.prototype.GetMosnterAbilityConfig(self)
	return {
		behavior = DOTA_ABILITY_BEHAVIOR_NO_TARGET,
		castRange = ELITE_034_DASH_DISTANCE,
		castPoint = ELITE_034_CAST_POINT,
		castDuration = ELITE_034_CAST_DURATION,
		castAnimation = "",
		OnPhaseStart = function()
			local caster = self:GetCaster()
			if not IsValidAlive(nil, caster) then
				return
			end
			caster:StartGestureWithPlaybackRate(ACT_DOTA_CAST_ABILITY_3, 1.2)
			local target = caster:GetMinDistanceUnit(ELITE_034_TARGET_SEARCH_RANGE)
			local ____IsValidAlive_result_0
			if IsValidAlive(nil, target) then
				____IsValidAlive_result_0 = GetDirection(nil, target:GetAbsOrigin(), caster:GetAbsOrigin())
			else
				____IsValidAlive_result_0 = caster:GetForwardVector()
			end
			self._chargeDirection = ____IsValidAlive_result_0
			if IsValidAlive(nil, target) then
				caster:LockTargetForSpeed(target, ELITE_034_CAST_POINT, 12)
			end
			self:Timer(0.1, function()
				caster:Mover(caster:GetAbsOrigin():__add(caster:GetForwardVector():__mul(-150)), 0.4)
			end)
		end,
		OnStart = function()
			local caster = self:GetCaster()
			if not IsValidAlive(nil, caster) then
				return
			end
			self:StartChargeSequence(caster)
			self:Timer(ELITE_034_SMASH_START_DELAY - 0.2, function()
				return self:StartSmashSequence(caster)
			end)
		end,
		OnFinish = function()
			self._chargeDirection = nil
		end,
		OnInterrupt = function()
			self._chargeDirection = nil
		end,
	}
end
function elite_034.prototype.StartChargeSequence(self, caster)
	____exports.elite_034_charge_pre:applys(caster, caster, self, { duration = 0.4 })
	____exports.elite_034_charge_post:applys(caster, caster, self, { duration = 0.3 })
	local dashForward = self._chargeDirection or caster:GetForwardVector()
	caster:SetForwardVector(dashForward)
	local dashStart = caster:GetAbsOrigin()
	local dashEnd = dashStart:__add(dashForward:__mul(ELITE_034_DASH_DISTANCE))
	local hitTargets = __TS__New(Set)
	EmitSoundOn(ELITE_034_DASH_SOUND, caster)
	self:HitChargeEnemies(caster, caster:GetAbsOrigin(), dashForward, hitTargets)
	caster:Mover(dashEnd, ELITE_034_CHARGE_ACTIVE_DURATION, function(____, position)
		self:HitChargeEnemies(caster, position, dashForward, hitTargets)
	end)
end
function elite_034.prototype.StartSmashSequence(self, caster)
	if not IsValidAlive(nil, caster) then
		return
	end
	caster:SetAnimation("monster00037_attack1_anim")
	local lockTarget = caster:GetMinDistanceUnit(ELITE_034_TARGET_SEARCH_RANGE)
	if IsValidAlive(nil, lockTarget) then
		caster:LockTargetForSpeed(lockTarget, 0.7, 5)
		self:Timer(ELITE_034_SMASH_PREP_TIME - 0.4, function()
			if not IsValidAlive(nil, caster) or not IsValidAlive(nil, lockTarget) then
				return
			end
			local origin = caster:GetAbsOrigin()
			local targetPos = lockTarget:GetAbsOrigin()
			local direction = GetDirection(nil, targetPos, origin)
			local distance = math.min(GetDistance(nil, origin, targetPos), ELITE_034_JUMP_MAX_DISTANCE)
			local jumpDistance = math.max(distance - ELITE_034_JUMP_TARGET_OFFSET, 0)
			local landPos = origin:__add(direction:__mul(jumpDistance))
			caster:Mover(landPos, ELITE_034_JUMP_BEFORE_CAST_END, nil, true, true)
		end)
	end
	self:Timer(ELITE_034_SMASH_PREP_TIME, function()
		if not IsValidAlive(nil, caster) then
			return
		end
		local smashOrigin = caster:GetAbsOrigin():__add(caster:GetForwardVector():__mul(200))
		local enemies = FindUnitsInRadius(
			caster:GetTeamNumber(),
			smashOrigin,
			nil,
			ELITE_034_SMASH_RADIUS,
			DOTA_UNIT_TARGET_TEAM_ENEMY,
			DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,
			DOTA_UNIT_TARGET_FLAG_NONE,
			FIND_CLOSEST,
			false
		)
		ScreenShake(caster:GetAbsOrigin(), 12, 12, 0.2, 3500, 0, true)
		self:PlayEffect(smashOrigin)
		EmitSoundOnLocationWithCaster(smashOrigin, ELITE_034_SMASH_SOUND, caster)
		for ____, enemy in ipairs(enemies) do
			do
				if not IsValidAlive(nil, enemy) then
					goto __continue22
				end
				caster:MonsterDamage({ victim = enemy, damage_rate = ELITE_034_SMASH_DAMAGE_RATE, ability = self })
				enemy:KnockBack(caster, self, {
					duration = 0.3,
					distance = 150,
					height = 250,
					stunDuration = 1,
					heightPower = 0.3,
					particleName = "",
					stun = true,
				})
			end
			::__continue22::
		end
	end)
end
function elite_034.prototype.HitChargeEnemies(self, caster, position, forward, hitTargets)
	if not IsValidAlive(nil, caster) then
		return
	end
	if not position or not forward then
		return
	end
	ScreenShake(position, 8, 8, 0.1, 3500, 0, true)
	local hitCenter = position:__add(forward:__mul(100))
	local hitEnemies = FindUnitsInRadius(
		caster:GetTeamNumber(),
		hitCenter,
		nil,
		ELITE_034_CHARGE_HIT_RADIUS,
		DOTA_UNIT_TARGET_TEAM_ENEMY,
		DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,
		DOTA_UNIT_TARGET_FLAG_NONE,
		FIND_ANY_ORDER,
		false
	)
	for ____, enemy in ipairs(hitEnemies) do
		do
			if not IsValidAlive(nil, enemy) then
				goto __continue28
			end
			if hitTargets:has(enemy:entindex()) then
				goto __continue28
			end
			hitTargets:add(enemy:entindex())
			caster:MonsterDamage({ victim = enemy, damage_rate = ELITE_034_CHARGE_DAMAGE_RATE, ability = self })
			AddDeBuffStatus(
				nil,
				enemy,
				caster,
				self,
				DebuffStatusType.STUN,
				{ duration = ELITE_034_CHARGE_STUN_DURATION }
			)
			self:PlayChargeHitEffect(enemy)
			EmitSoundOn(ELITE_034_CHARGE_HIT_SOUND, enemy)
			enemy:KnockBack(caster, self, { duration = 0.2, distance = 350, height = 50, particleName = "" })
		end
		::__continue28::
	end
end
function elite_034.prototype.PlayChargeHitEffect(self, target)
	local pfx = ParticleManager:CreateParticle(ELITE_034_CHARGE_HIT_PARTICLE, PATTACH_ABSORIGIN_FOLLOW, target)
	ParticleManager:SetParticleControl(pfx, 0, target:GetAbsOrigin())
	ParticleManager:ReleaseParticleIndex(pfx)
end
function elite_034.prototype.PlayEffect(self, pos)
	local pfx = ParticleManager:CreateParticle(ELITE_034_SMASH_PARTICLE, PATTACH_WORLDORIGIN, self:GetCaster())
	ParticleManager:SetParticleControl(pfx, 0, pos)
	ParticleManager:SetParticleControl(pfx, 1, pos)
	ParticleManager:ReleaseParticleIndex(pfx)
end
elite_034 = __TS__DecorateLegacy({ registerAbility(nil) }, elite_034)
____exports.elite_034 = elite_034
____exports.elite_034_charge_pre = __TS__Class()
local elite_034_charge_pre = ____exports.elite_034_charge_pre
elite_034_charge_pre.name = "elite_034_charge_pre"
__TS__ClassExtends(elite_034_charge_pre, MonsterModifier_CS)
function elite_034_charge_pre.prototype.GetEffectName(self)
	return "particles/bb/ss_primal_beast_2022_prestige_onslaught_charge_active_test4.vpcf"
end
elite_034_charge_pre = __TS__DecorateLegacy({ registerModifier(nil) }, elite_034_charge_pre)
____exports.elite_034_charge_pre = elite_034_charge_pre
____exports.elite_034_charge_post = __TS__Class()
local elite_034_charge_post = ____exports.elite_034_charge_post
elite_034_charge_post.name = "elite_034_charge_post"
__TS__ClassExtends(elite_034_charge_post, MonsterModifier_CS)
function elite_034_charge_post.prototype.GetEffectName(self)
	return "particles/econ/items/queen_of_pain/qop_arcana/qop_arcana_blink_start_model.vpcf"
end
elite_034_charge_post = __TS__DecorateLegacy({ registerModifier(nil) }, elite_034_charge_post)
____exports.elite_034_charge_post = elite_034_charge_post
return ____exports