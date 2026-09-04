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
local __TS__ArrayIncludes = ____lualib.__TS__ArrayIncludes
local __TS__DecorateLegacy = ____lualib.__TS__DecorateLegacy
local ____exports = {}
local ____dota_ts_adapter = require("utils.dota_ts_adapter")
local registerAbility = ____dota_ts_adapter.registerAbility
local ____monster_base = require("abilities.monster.monster_base")
local MonsterAbility_CS = ____monster_base.MonsterAbility_CS
local PARTICLE = "particles/units/heroes/hero_kez/kez_sai_ultimate_wave.vpcf"
local CAST_POINT = 0.3
local CAST_RANGE = 1000
local PUSH_RADIUS = 850
local PUSH_EXPAND_DURATION = 0.8
local PUSH_THINK_INTERVAL = 0.04
local PUSH_WAVE_WIDTH = 100
local KNOCKBACK_DISTANCE = 100
local KNOCKBACK_DURATION = 0.15
local KNOCKBACK_HEIGHT = 20
local FOLLOW_UP_DELAY = PUSH_EXPAND_DURATION + 0.03
local EXCLUDED_ABILITY_NAMES = { "projectile_system_ability", "twin_gate_portal_warp" }
--- 精英技能121 - 短暂蓄力后释放扩散冲击波，击退波及到的周围单位，随后随机释放一个其他可用技能。
____exports.elite_121 = __TS__Class()
local elite_121 = ____exports.elite_121
elite_121.name = "elite_121"
__TS__ClassExtends(elite_121, MonsterAbility_CS)
function elite_121.prototype.Precache(self, context)
	PrecacheResource("particle", PARTICLE, context)
end
function elite_121.prototype.GetMosnterAbilityConfig(self)
	return {
		behavior = DOTA_ABILITY_BEHAVIOR_NO_TARGET,
		castRange = CAST_RANGE * 0.7,
		castPoint = CAST_POINT,
		castDuration = PUSH_EXPAND_DURATION,
		castAnimation = ACT_DOTA_CAST_ABILITY_2,
		animationPlaybackRate = 0.9,
		canCast = function()
			local caster = self:GetCaster()
			if not IsValidAlive(nil, caster) then
				return UF_FAIL_CUSTOM
			end
			local target = caster:GetMinDistanceUnit(CAST_RANGE)
			if not IsValidAlive(nil, target) then
				return UF_FAIL_CUSTOM
			end
			local ____temp_0
			if #self:GetReadyFollowUpAbilities(caster, target) > 0 then
				____temp_0 = UF_SUCCESS
			else
				____temp_0 = UF_FAIL_CUSTOM
			end
			return ____temp_0
		end,
		castError = function()
			return "没有可衔接释放的技能"
		end,
		OnPhaseStart = function()
			local caster = self:GetCaster()
			if not IsValidAlive(nil, caster) then
				return
			end
			caster:Mover(caster:GetAbsOrigin():__add(caster:GetForwardVector():__mul(-450)), 0.35)
			local target = caster:GetMinDistanceUnit(CAST_RANGE)
			if IsValidAlive(nil, target) then
				caster:LockTargetForSpeed(target, CAST_POINT)
			end
		end,
		OnStart = function()
			local caster = self:GetCaster()
			if not IsValidAlive(nil, caster) then
				return
			end
			EmitSoundOn("Hero_Kez.Parry.Sai.Cast", caster)
			self:PlayPushEffect(caster)
			self:StartExpandingPush(caster)
			self:Timer(FOLLOW_UP_DELAY, function()
				return self:CastRandomFollowUp()
			end)
		end,
	}
end
function elite_121.prototype.PlayPushEffect(self, caster)
	local origin = caster:GetAbsOrigin()
	local pfx = ParticleManager:CreateParticle(PARTICLE, PATTACH_WORLDORIGIN, nil)
	ParticleManager:SetParticleControl(pfx, 0, origin)
	ParticleManager:SetParticleControl(pfx, 1, Vector(PUSH_RADIUS, 0, PUSH_RADIUS))
	ParticleManager:ReleaseParticleIndex(pfx)
	ScreenShake(origin, 6, 80, 0.2, PUSH_RADIUS + 250, 0, true)
end
function elite_121.prototype.StartExpandingPush(self, caster)
	local origin = caster:GetAbsOrigin()
	local hitRecord = {}
	local startTime = GameRules:GetGameTime()
	local previousRadius = 0
	local think
	think = function()
		if not IsValidAlive(nil, caster) then
			return
		end
		local elapsed = math.min(GameRules:GetGameTime() - startTime, PUSH_EXPAND_DURATION)
		local currentRadius = self:GetPushRadiusByElapsed(elapsed)
		self:PushEnemiesOnWave(caster, origin, previousRadius, currentRadius, hitRecord)
		previousRadius = currentRadius
		if elapsed >= PUSH_EXPAND_DURATION then
			return
		end
		return self:Timer(PUSH_THINK_INTERVAL, think)
	end
	think(nil)
end
function elite_121.prototype.GetPushRadiusByElapsed(self, elapsed)
	local progress = math.min(math.max(elapsed / PUSH_EXPAND_DURATION, 0), 1)
	return PUSH_RADIUS * progress
end
function elite_121.prototype.PushEnemiesOnWave(self, caster, origin, previousRadius, currentRadius, hitRecord)
	local minRadius = math.max(math.min(previousRadius, currentRadius) - PUSH_WAVE_WIDTH, 0)
	local maxRadius = math.min(math.max(previousRadius, currentRadius) + PUSH_WAVE_WIDTH, PUSH_RADIUS + PUSH_WAVE_WIDTH)
	local enemies = FindUnitsInRadius(
		caster:GetTeamNumber(),
		origin,
		nil,
		maxRadius * 0.8,
		DOTA_UNIT_TARGET_TEAM_ENEMY,
		DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,
		DOTA_UNIT_TARGET_FLAG_NONE,
		FIND_ANY_ORDER,
		false
	)
	for ____, enemy in ipairs(enemies) do
		do
			if not IsValidAlive(nil, enemy) then
				goto __continue21
			end
			local distance = GetDistance(nil, origin, enemy:GetAbsOrigin())
			if distance < minRadius or distance > maxRadius then
				goto __continue21
			end
			local index = enemy:entindex()
			if hitRecord[index] then
				goto __continue21
			end
			hitRecord[index] = true
			enemy:KnockBack(caster, self, {
				origin_pos = origin,
				duration = KNOCKBACK_DURATION,
				distance = KNOCKBACK_DISTANCE,
				height = KNOCKBACK_HEIGHT,
				stun = true,
				stunDuration = KNOCKBACK_DURATION,
				particleName = "",
			})
		end
		::__continue21::
	end
end
function elite_121.prototype.CastRandomFollowUp(self)
	local caster = self:GetCaster()
	if not IsValidAlive(nil, caster) then
		return
	end
	if caster:IsStunned() or caster:IsSilenced() or caster:IsChanneling() or caster:IsMonsterCasting() then
		return
	end
	local target = caster:GetMinDistanceUnit(CAST_RANGE)
	if not IsValidAlive(nil, target) then
		return
	end
	local readyAbilities = self:GetReadyFollowUpAbilities(caster, target)
	if #readyAbilities <= 0 then
		return
	end
	local ability = readyAbilities[RandomInt(0, #readyAbilities - 1) + 1]
	self:CastFollowUpAbility(caster, ability, target)
end
function elite_121.prototype.GetReadyFollowUpAbilities(self, caster, target)
	local abilities = {}
	local abilityCount = caster:GetAbilityCount()
	do
		local index = 0
		while index < abilityCount do
			do
				local ability = caster:GetAbilityByIndex(index)
				if not self:CanUseAsFollowUp(caster, ability, target) then
					goto __continue32
				end
				abilities[#abilities + 1] = ability
			end
			::__continue32::
			index = index + 1
		end
	end
	return abilities
end
function elite_121.prototype.CanUseAsFollowUp(self, caster, ability, target)
	if not ability or ability == self then
		return false
	end
	if ability:IsPassive() or not ability:IsCooldownReady() then
		return false
	end
	local abilityName = ability:GetAbilityName()
	if abilityName == self:GetAbilityName() then
		return false
	end
	if __TS__ArrayIncludes(EXCLUDED_ABILITY_NAMES, abilityName) then
		return false
	end
	local behavior = ability:GetBehavior()
	if not self:IsTargetInCastRange(caster, ability, target, behavior) then
		return false
	end
	local monsterAbility = ability
	local ____opt_1 = monsterAbility.GetMosnterAbilityConfig
	local canCast = ____opt_1 and ____opt_1(monsterAbility).canCast
	if not canCast then
		return true
	end
	local result = canCast(nil, { target = target })
	return result == nil or result == UF_SUCCESS
end
function elite_121.prototype.IsTargetInCastRange(self, caster, ability, target, behavior)
	if
		not CheckTag(nil, behavior, DOTA_ABILITY_BEHAVIOR_POINT)
		and not CheckTag(nil, behavior, DOTA_ABILITY_BEHAVIOR_UNIT_TARGET)
	then
		return true
	end
	local casterPos = caster:GetAbsOrigin()
	if not IsValidAlive(nil, target) then
		return false
	end
	local castRange = ability:GetEffectiveCastRange(casterPos, target)
	return castRange <= 0 or GetDistance(nil, casterPos, target:GetAbsOrigin()) <= castRange
end
function elite_121.prototype.CastFollowUpAbility(self, caster, ability, target)
	local behavior = ability:GetBehavior()
	local playerId = caster:GetPlayerOwnerID()
	if CheckTag(nil, behavior, DOTA_ABILITY_BEHAVIOR_POINT) then
		if not IsValidAlive(nil, target) then
			return
		end
		caster:CastAbilityOnPosition(target:GetAbsOrigin(), ability, playerId)
		return
	end
	if CheckTag(nil, behavior, DOTA_ABILITY_BEHAVIOR_UNIT_TARGET) then
		caster:CastAbilityOnTarget(target, ability, playerId)
		return
	end
	caster:CastAbilityNoTarget(ability, playerId)
end
elite_121 = __TS__DecorateLegacy({ registerAbility(nil) }, elite_121)
____exports.elite_121 = elite_121
return ____exports