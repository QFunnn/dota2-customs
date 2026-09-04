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
local registerModifier = ____dota_ts_adapter.registerModifier
local ____monster_base = require("abilities.monster.monster_base")
local MonsterAbility_CS = ____monster_base.MonsterAbility_CS
local ____modifier_base = require("modifiers.class.modifier_base")
local BaseModifier_CS = ____modifier_base.BaseModifier_CS
local ROLL_DURATION = 0.47
local ROLL_RECOVER_DELAY = 0.37
local ROLL_DISTANCE = 600
local ROLL_MIN_DISTANCE_FROM_ENEMY = 350
local ROLL_MAX_DISTANCE_FROM_ENEMY = 550
local ROLL_MIN_DISTANCE = 400
local ROLL_MAX_DISTANCE = 800
local ROLL_POINT_ATTEMPTS = 24
local SEARCH_RANGE = 2500
local SLAM_RADIUS = 120
local SLAM_LINE_DISTANCE = 1000
local SLAM_DAMAGE_RATE = 25
local SLAM_STUN_DURATION = 1.5
local SLAM_DIRECTION_LOCK_LEAD = 0
local SLAM_PARTICLE = "particles/cc/simayi_strike_line_hit.vpcf"
local function GetFlatDirection(self, direction)
	local flat = Vector(direction.x, direction.y, 0)
	local length = flat:Length2D()
	if length <= 0.001 then
		return Vector(1, 0, 0)
	end
	return flat:__mul(1 / length)
end
____exports.boss_kez_2 = __TS__Class()
local boss_kez_2 = ____exports.boss_kez_2
boss_kez_2.name = "boss_kez_2"
__TS__ClassExtends(boss_kez_2, MonsterAbility_CS)
function boss_kez_2.prototype.Precache(self, context)
	PrecacheResource("particle", SLAM_PARTICLE, context)
end
function boss_kez_2.prototype.GetMosnterAbilityConfig(self)
	return {
		castPoint = 0,
		castDuration = ROLL_DURATION + ROLL_RECOVER_DELAY + 0.2,
		behavior = DOTA_ABILITY_BEHAVIOR_NO_TARGET,
		isNotMove = true,
		castAnimation = "",
		OnStart = function()
			local caster = self:GetCaster()
			if not IsValidAlive(nil, caster) then
				return
			end
			local lockedSlamDirection
			caster:SetAnimation("forcestaff_roll_end")
			____exports.modifier_boss_kez_2_roll:applys(caster, caster, self, { duration = ROLL_DURATION })
			local target = caster:GetMinDistanceUnit(SEARCH_RANGE)
			caster:LockTargetForSpeed(target, ROLL_DURATION, 15)
			local lockDelay = math.max(0, ROLL_DURATION - SLAM_DIRECTION_LOCK_LEAD)
			self:Timer(lockDelay, function()
				if not IsValidAlive(nil, caster) then
					return
				end
				lockedSlamDirection = self:GetSlamDirection(caster)
				caster:SetForwardVector(lockedSlamDirection)
			end)
			self:Timer(ROLL_DURATION + ROLL_RECOVER_DELAY, function()
				if not IsValidAlive(nil, caster) then
					return
				end
				local startPos = caster:GetAbsOrigin()
				local direction = lockedSlamDirection or GetFlatDirection(nil, caster:GetForwardVector())
				caster:SetForwardVector(direction)
				local endPos = startPos:__add(direction:__mul(SLAM_LINE_DISTANCE))
				endPos.z = GetGroundHeight(endPos, caster)
				self:PlaySlam(startPos, endPos, direction)
				self:DamageAndStunSlam(startPos, endPos)
			end)
		end,
	}
end
function boss_kez_2.prototype.GetSlamDirection(self, caster)
	local startPos = caster:GetAbsOrigin()
	local target = caster:GetMinDistanceUnit(SEARCH_RANGE)
	local ____IsValidAlive_result_0
	if IsValidAlive(nil, target) then
		____IsValidAlive_result_0 = GetFlatDirection(nil, target:GetAbsOrigin():__sub(startPos))
	else
		____IsValidAlive_result_0 = GetFlatDirection(nil, caster:GetForwardVector())
	end
	return ____IsValidAlive_result_0
end
function boss_kez_2.prototype.PlaySlam(self, startPos, endPos, direction)
	local pfx = ParticleManager:CreateParticle(SLAM_PARTICLE, PATTACH_WORLDORIGIN, nil)
	ParticleManager:SetParticleControlTransformForward(pfx, 0, startPos, direction)
	ParticleManager:SetParticleControl(pfx, 1, endPos)
	ParticleManager:SetParticleControlForward(pfx, 1, direction)
	ParticleManager:SetParticleControl(pfx, 2, startPos)
	ParticleManager:SetParticleControl(pfx, 3, Vector(SLAM_LINE_DISTANCE, 1, 1))
	ParticleManager:SetParticleControl(pfx, 6, startPos)
	ParticleManager:SetParticleControl(pfx, 11, Vector(SLAM_LINE_DISTANCE, 1, 1))
	ParticleManager:SetParticleControl(pfx, 20, startPos)
	ParticleManager:ReleaseParticleIndex(pfx)
end
function boss_kez_2.prototype.DamageAndStunSlam(self, startPos, endPos)
	local caster = self:GetCaster()
	local enemies = FindUnitsInLine(
		caster:GetTeamNumber(),
		startPos,
		endPos,
		nil,
		SLAM_RADIUS,
		DOTA_UNIT_TARGET_TEAM_ENEMY,
		DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,
		DOTA_UNIT_TARGET_FLAG_NONE
	)
	ScreenShake(caster:GetAbsOrigin(), 10, 10, 0.1, 3000, 0, true)
	for ____, enemy in ipairs(enemies) do
		do
			if not IsValidAlive(nil, enemy) then
				goto __continue15
			end
			local ____opt_1 = enemy.GetUnitType
			local unitType = ____opt_1 and ____opt_1(enemy)
			if unitType == UnitType.BUILDING or unitType == UnitType.DESTRUCTIBLE then
				goto __continue15
			end
			caster:MonsterDamage({ victim = enemy, damage_rate = SLAM_DAMAGE_RATE, ability = self })
			AddDeBuffStatus(nil, enemy, caster, self, DebuffStatusType.STUN, { duration = SLAM_STUN_DURATION })
		end
		::__continue15::
	end
end
boss_kez_2 = __TS__DecorateLegacy({ registerAbility(nil) }, boss_kez_2)
____exports.boss_kez_2 = boss_kez_2
____exports.modifier_boss_kez_2_roll = __TS__Class()
local modifier_boss_kez_2_roll = ____exports.modifier_boss_kez_2_roll
modifier_boss_kez_2_roll.name = "modifier_boss_kez_2_roll"
__TS__ClassExtends(modifier_boss_kez_2_roll, BaseModifier_CS)
function modifier_boss_kez_2_roll.prototype.OnCreated(self)
	if not IsServer() then
		return
	end
	local caster = self:GetCaster()
	local origin = caster:GetAbsOrigin()
	local targetHero = self:FindRollTargetHero(caster)
	local targetPos
	if targetHero then
		targetPos = self:FindSmartRollPoint(caster, origin, targetHero)
		caster:LockTargetForSpeed(targetHero, ROLL_DURATION, 15)
	end
	if not targetPos then
		local fallback = origin:__add(
			GetFlatDirection(nil, caster:GetForwardVector()):__mul(math.min(ROLL_DISTANCE, ROLL_MAX_DISTANCE))
		)
		local ____table_IsValidRollPoint_result_3
		if self:IsValidRollPoint(origin, fallback) then
			____table_IsValidRollPoint_result_3 = fallback
		else
			____table_IsValidRollPoint_result_3 = origin
		end
		targetPos = ____table_IsValidRollPoint_result_3
	end
	targetPos.z = GetGroundHeight(targetPos, caster)
	caster:Mover(targetPos, ROLL_DURATION)
end
function modifier_boss_kez_2_roll.prototype.FindRollTargetHero(self, caster)
	local enemies = FindUnitsInRadius(
		caster:GetTeamNumber(),
		caster:GetAbsOrigin(),
		nil,
		SEARCH_RANGE,
		DOTA_UNIT_TARGET_TEAM_ENEMY,
		DOTA_UNIT_TARGET_HERO,
		DOTA_UNIT_TARGET_FLAG_NONE,
		FIND_CLOSEST,
		false
	)
	for ____, enemy in ipairs(enemies) do
		if IsValidAlive(nil, enemy) then
			return enemy
		end
	end
	return nil
end
function modifier_boss_kez_2_roll.prototype.FindSmartRollPoint(self, caster, origin, enemy)
	local enemyPos = enemy:GetAbsOrigin()
	local bestPoint
	local bestScore = -1
	do
		local i = 0
		while i < ROLL_POINT_ATTEMPTS do
			do
				local angle = RandomFloat(0, 360)
				local distance = RandomFloat(ROLL_MIN_DISTANCE_FROM_ENEMY, ROLL_MAX_DISTANCE_FROM_ENEMY)
				local direction = RotateVector2D(nil, Vector(1, 0, 0), angle)
				local candidate = enemyPos:__add(direction:__mul(distance))
				candidate.z = GetGroundHeight(candidate, caster)
				if not self:IsValidRollPoint(origin, candidate) then
					goto __continue28
				end
				local rollDistance = origin:__sub(candidate):Length2D()
				local enemyDistance = enemyPos:__sub(candidate):Length2D()
				local idealEnemyDistance = (ROLL_MIN_DISTANCE_FROM_ENEMY + ROLL_MAX_DISTANCE_FROM_ENEMY) * 0.5
				local score = ROLL_MAX_DISTANCE - rollDistance - math.abs(enemyDistance - idealEnemyDistance)
				if not bestPoint or score > bestScore then
					bestPoint = candidate
					bestScore = score
				end
			end
			::__continue28::
			i = i + 1
		end
	end
	if bestPoint then
		return bestPoint
	end
	local fallbackDirection = GetFlatDirection(nil, origin:__sub(enemyPos))
	do
		local distance = ROLL_MIN_DISTANCE_FROM_ENEMY
		while distance <= ROLL_MAX_DISTANCE_FROM_ENEMY do
			local fallback = enemyPos:__add(fallbackDirection:__mul(distance))
			fallback.z = GetGroundHeight(fallback, caster)
			if self:IsValidRollPoint(origin, fallback) then
				return fallback
			end
			distance = distance + 50
		end
	end
	return nil
end
function modifier_boss_kez_2_roll.prototype.IsValidRollPoint(self, origin, point)
	local rollDistance = origin:__sub(point):Length2D()
	if rollDistance < ROLL_MIN_DISTANCE or rollDistance > ROLL_MAX_DISTANCE then
		return false
	end
	if not GridNav:IsTraversable(point) or GridNav:IsBlocked(point) then
		return false
	end
	if not GridNav:CanFindPath(origin, point) then
		return false
	end
	return GridNav:FindPathLength(origin, point) ~= -1
end
function modifier_boss_kez_2_roll.prototype.OnDestroy(self)
	if not IsServer() then
		return
	end
	self._caster:SetAnimation("echo_slash_alt_b_fx")
end
function modifier_boss_kez_2_roll.prototype.CheckState(self)
	return { [MODIFIER_STATE_INVULNERABLE] = true, [MODIFIER_STATE_NO_UNIT_COLLISION] = true }
end
function modifier_boss_kez_2_roll.prototype.GetModifierConfig(self)
	return { isHidden = true, isDebuff = false, isPurgable = false }
end
modifier_boss_kez_2_roll = __TS__DecorateLegacy({ registerModifier(nil) }, modifier_boss_kez_2_roll)
____exports.modifier_boss_kez_2_roll = modifier_boss_kez_2_roll
return ____exports