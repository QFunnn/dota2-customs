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
local __TS__ArrayFilter = ____lualib.__TS__ArrayFilter
local __TS__DecorateLegacy = ____lualib.__TS__DecorateLegacy
local ____exports = {}
local ____dota_ts_adapter = require("utils.dota_ts_adapter")
local registerAbility = ____dota_ts_adapter.registerAbility
local ____monster_base = require("abilities.monster.monster_base")
local MonsterAbility_CS = ____monster_base.MonsterAbility_CS
local PARTICLE = "particles/units/heroes/hero_primal_beast/primal_beast_pulverize_hit.vpcf"
local CAST_POINT = 0.6
local CAST_RANGE = 1000
local SMASH_COUNT = 3
local CAST_ACTION_DURATION = 3
local WARNING_HIT_DELAY = 0.8
local SMASH_INTERVAL = CAST_ACTION_DURATION
local SMASH_RADIUS = 280
local DAMAGE_RATE = 25
local POINT_MIN_COUNT = 5
local POINT_MAX_COUNT = 9
local POINT_MIN_SEPARATION = SMASH_RADIUS * 1.3
local POINT_SEARCH_ATTEMPTS = 20
local RANDOM_MIN_DISTANCE = 180
local KNOCKBACK_DURATION = 0.35
local KNOCKBACK_DISTANCE = 70
local KNOCKBACK_HEIGHT = 260
local CAST_DURATION = SMASH_INTERVAL * (SMASH_COUNT - 1) + WARNING_HIT_DELAY + KNOCKBACK_DURATION
--- 精英技能120 - 蓄力后原地连续砸地，在随机预警圈内造成伤害并击飞。
____exports.elite_120 = __TS__Class()
local elite_120 = ____exports.elite_120
elite_120.name = "elite_120"
__TS__ClassExtends(elite_120, MonsterAbility_CS)
function elite_120.prototype.____constructor(self, ...)
	MonsterAbility_CS.prototype.____constructor(self, ...)
	self.castSequence = 0
end
function elite_120.prototype.Precache(self, context)
	PrecacheResource("particle", PARTICLE, context)
end
function elite_120.prototype.GetMosnterAbilityConfig(self)
	return {
		behavior = DOTA_ABILITY_BEHAVIOR_NO_TARGET,
		castRange = CAST_RANGE,
		castPoint = CAST_POINT,
		castDuration = 6,
		castAnimation = ACT_DOTA_CAST_ABILITY_1,
		animationPlaybackRate = 1,
		canCast = function()
			local ____IsValidAlive_result_0
			if IsValidAlive(nil, self:GetCaster()) then
				____IsValidAlive_result_0 = UF_SUCCESS
			else
				____IsValidAlive_result_0 = UF_FAIL_CUSTOM
			end
			return ____IsValidAlive_result_0
		end,
		OnPhaseStart = function()
			local caster = self:GetCaster()
			if not IsValidAlive(nil, caster) then
				return
			end
			self.castSequence = 1
			caster:EmitSound("Hero_Spirit_Breaker.ChargeOfDarkness")
		end,
		OnInterrupt = function()
			self.castSequence = self.castSequence + 1
		end,
		OnStart = function()
			local caster = self:GetCaster()
			if not IsValidAlive(nil, caster) then
				return
			end
			local sequence = self.castSequence
			self:WarningAndDamage(sequence)
			self:Timer(1.5, function()
				self.castSequence = self.castSequence + 1
				self:StartSmashRound(sequence)
				if self.castSequence == SMASH_COUNT then
					return
				end
				return 2
			end)
		end,
	}
end
function elite_120.prototype.StartSmashRound(self, sequence, playGesture)
	if playGesture == nil then
		playGesture = true
	end
	local caster = self:GetCaster()
	if not IsValidAlive(nil, caster) then
		return
	end
	if playGesture then
		caster:StartGestureWithPlaybackRate(ACT_DOTA_CAST_ABILITY_1, 1)
		self:Timer(0.8, function()
			self:WarningAndDamage(sequence)
		end)
	end
end
function elite_120.prototype.WarningAndDamage(self, sequence)
	local caster = self:GetCaster()
	local points = self:CreateSmashPoints(caster, RandomInt(POINT_MIN_COUNT, POINT_MAX_COUNT))
	for ____, point in ipairs(points) do
		self:WarningRingEffect(point, SMASH_RADIUS, 0.8)
	end
	self:Timer(0.8, function()
		self:ExecuteSmashRound(points)
		caster:EmitSound("Hero_Mars.Spear.Root")
		ScreenShake(caster:GetAbsOrigin(), 20, 20, 0.6, 2900, 0, true)
	end)
end
function elite_120.prototype.CreateSmashPoints(self, caster, pointCount)
	local enemies = self:FindEnemies(caster)
	local points = {}
	do
		local index = 0
		while index < pointCount do
			points[#points + 1] = self:FindSmashPoint(caster, enemies, points)
			index = index + 1
		end
	end
	return points
end
function elite_120.prototype.FindEnemies(self, caster)
	return __TS__ArrayFilter(
		FindUnitsInRadius(caster:GetTeamNumber(), caster:GetAbsOrigin(), nil, CAST_RANGE, 2, 1 + 18, 0, 0, false),
		function(____, enemy)
			return IsValidAlive(nil, enemy)
		end
	)
end
function elite_120.prototype.FindSmashPoint(self, caster, enemies, selectedPoints)
	local fallbackPoint
	local fallbackDistance = -1
	do
		local attempt = 0
		while attempt < POINT_SEARCH_ATTEMPTS do
			do
				local point = self:CreatePointCandidate(caster, enemies)
				if not IsGridNavDisplacementWalkable(nil, point) then
					goto __continue25
				end
				local nearestDistance = self:GetNearestPointDistance(point, selectedPoints)
				if nearestDistance >= POINT_MIN_SEPARATION then
					return point
				end
				if not fallbackPoint or nearestDistance > fallbackDistance then
					fallbackPoint = point
					fallbackDistance = nearestDistance
				end
			end
			::__continue25::
			attempt = attempt + 1
		end
	end
	return fallbackPoint or GetGroundPosition(caster:GetAbsOrigin(), caster)
end
function elite_120.prototype.CreatePointCandidate(self, caster, enemies)
	if #enemies > 0 and RandomInt(1, 100) <= 75 then
		local enemy = enemies[RandomInt(0, #enemies - 1) + 1]
		if IsValidAlive(nil, enemy) then
			local candidate = enemy:GetAbsOrigin():__add(RandomVector(RandomFloat(0, SMASH_RADIUS * 1.5)))
			return GetGroundPosition(candidate, enemy)
		end
	end
	local candidate = caster:GetAbsOrigin():__add(RandomVector(RandomFloat(RANDOM_MIN_DISTANCE, CAST_RANGE)))
	return GetGroundPosition(candidate, caster)
end
function elite_120.prototype.GetNearestPointDistance(self, point, selectedPoints)
	if #selectedPoints <= 0 then
		return POINT_MIN_SEPARATION
	end
	local nearestDistance = 99999
	for ____, selectedPoint in ipairs(selectedPoints) do
		local distance = point:__sub(selectedPoint):Length2D()
		if distance < nearestDistance then
			nearestDistance = distance
		end
	end
	return nearestDistance
end
function elite_120.prototype.ExecuteSmashRound(self, points)
	local caster = self:GetCaster()
	if not IsValidAlive(nil, caster) then
		return
	end
	local hitRecord = {}
	for ____, point in ipairs(points) do
		local smashPoint = GetGroundPosition(point, caster)
		self:PlaySmashEffect(smashPoint)
		self:DamageAndKnockbackAt(caster, smashPoint, hitRecord)
	end
end
function elite_120.prototype.PlaySmashEffect(self, point)
	local pfx = ParticleManager:CreateParticle(PARTICLE, PATTACH_WORLDORIGIN, nil)
	ParticleManager:SetParticleControl(pfx, 0, point)
	ParticleManager:SetParticleControl(pfx, 1, Vector(SMASH_RADIUS, 0, 0))
	ParticleManager:ReleaseParticleIndex(pfx)
	ScreenShake(point, 10, 80, 0.25, 900, 0, true)
end
function elite_120.prototype.DamageAndKnockbackAt(self, caster, point, hitRecord)
	local enemies = FindUnitsInRadius(
		caster:GetTeamNumber(),
		point,
		nil,
		SMASH_RADIUS,
		DOTA_UNIT_TARGET_TEAM_ENEMY,
		DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,
		DOTA_UNIT_TARGET_FLAG_NONE,
		FIND_ANY_ORDER,
		false
	)
	for ____, enemy in ipairs(enemies) do
		do
			if not IsValidAlive(nil, enemy) then
				goto __continue43
			end
			local index = enemy:entindex()
			if hitRecord[index] then
				goto __continue43
			end
			hitRecord[index] = true
			caster:MonsterDamage({ victim = enemy, damage_rate = DAMAGE_RATE, ability = self })
			enemy:KnockBack(caster, self, {
				origin_pos = point,
				duration = KNOCKBACK_DURATION,
				distance = 0,
				height = KNOCKBACK_HEIGHT,
				stun = true,
				stunDuration = 1,
				particleName = "",
			})
		end
		::__continue43::
	end
end
elite_120 = __TS__DecorateLegacy({ registerAbility(nil) }, elite_120)
____exports.elite_120 = elite_120
return ____exports