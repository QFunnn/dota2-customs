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
local Set = ____lualib.Set
local __TS__New = ____lualib.__TS__New
local ____exports = {}
local modifier_elite_150_stone
local ____dota_ts_adapter = require("utils.dota_ts_adapter")
local registerAbility = ____dota_ts_adapter.registerAbility
local registerModifier = ____dota_ts_adapter.registerModifier
local ____monster_base = require("abilities.monster.monster_base")
local MonsterAbility_CS = ____monster_base.MonsterAbility_CS
local MonsterModifier_CS = ____monster_base.MonsterModifier_CS
local CAST_RANGE = 1200
local CAST_POINT = 0.6
local STONE_PHASE_INTERVAL = 0.625
local STONE_COUNT = 3
local STONE_LAUNCH_DELAY = 0.4
local LEAP_START_TIME = STONE_PHASE_INTERVAL * STONE_COUNT + 0.6
local LEAP_DURATION = 0.8
local STONE_SPEED = 2050
local STONE_DISTANCE = 1200
local STONE_MOVE_DURATION = STONE_DISTANCE / STONE_SPEED
local STONE_RADIUS = 125
local STONE_DAMAGE_RATE = 15
local LEAP_DISTANCE = 650
local LEAP_HEIGHT = 360
local LEAP_RADIUS = 320
local LEAP_DAMAGE_RATE = 18
local LEAP_STUN_DURATION = 0.55
local LEAP_SAFE_POINT_STEP = 64
local FLOATING_STONE_HEIGHT = 200
local FLOATING_STONE_RADIUS = 260
local FIELD_STRIKE_COUNT = 3
local FIELD_WARNING_DURATION = 0.5
local FIELD_STRIKE_INTERVAL = 0.65
local FIELD_DURATION = FIELD_WARNING_DURATION + FIELD_STRIKE_INTERVAL * (FIELD_STRIKE_COUNT - 1)
local FIELD_DAMAGE_RATE = 10
local FIELD_DAMAGE_RADIUS = 128
local FIELD_TARGET_SEARCH_RADIUS = 1200
local FIELD_TARGET_OFFSET_MIN = 50
local FIELD_TARGET_OFFSET_MAX = 250
local CAST_DURATION = LEAP_START_TIME + LEAP_DURATION + FIELD_DURATION + 0.2
local STONE_PARTICLE = "particles/units/heroes/hero_earth_spirit/espirit_stoneremnant.vpcf"
local SMASH_PARTICLE = "particles/units/heroes/hero_earth_spirit/espirit_bouldersmash_caster.vpcf"
local SMASH_TARGET_PARTICLE = "particles/units/heroes/hero_earth_spirit/espirit_bouldersmash_target.vpcf"
local LAND_PARTICLE = "particles/units/heroes/hero_earth_spirit/espirit_geomagentic_grip_target.vpcf"
local FIELD_BOLT_PARTICLE = "particles/units/heroes/hero_earth_spirit/espirit_stone_explosion_bolt.vpcf"
local FIELD_BOLT_PARTICLE2 = "particles/espirit_stone_explosion_bolt_2.vpcf"
local SUMMON_SOUND = "Hero_EarthSpirit.StoneRemnant.Impact"
local STONE_LAUNCH_SOUND = "Hero_EarthSpirit.BoulderSmash.Target"
local STONE_HIT_SOUND = "Hero_EarthSpirit.RollingBoulder.Target"
local LEAP_SOUND = "Hero_EarthSpirit.RollingBoulder.Cast"
local LAND_SOUND = "Hero_EarthSpirit.Magnetize.Cast"
local FIELD_BOLT_SOUND = "Hero_Magnataur.ShockWave.Particle"
--- 精英技能 150 - 石像重拳
--
-- 技能流程：
-- 1. 前摇锁定目标，在施法者前方三角阵型召唤 3 块残岩
-- 2. 每隔 0.5 秒依次驱动一块残岩向目标方向冲撞
-- 3. 残岩全部出手后，自身抛物线跃向目标落点
-- 4. 跃砸造成范围伤害 + 眩晕，3 块残岩同步升至落点上方三角阵型
-- 5. 落地后连续 3 轮由 3 块残岩各射出一道预警落雷，对小范围敌人造成伤害
____exports.elite_150 = __TS__Class()
local elite_150 = ____exports.elite_150
elite_150.name = "elite_150"
__TS__ClassExtends(elite_150, MonsterAbility_CS)
function elite_150.prototype.____constructor(self, ...)
	MonsterAbility_CS.prototype.____constructor(self, ...)
	self.sequence = 0
	self.stones = {}
end
function elite_150.prototype.Precache(self, context)
	PrecacheResource("particle", STONE_PARTICLE, context)
	PrecacheResource("particle", SMASH_PARTICLE, context)
	PrecacheResource("particle", SMASH_TARGET_PARTICLE, context)
	PrecacheResource("particle", LAND_PARTICLE, context)
	PrecacheResource("particle", FIELD_BOLT_PARTICLE, context)
end
function elite_150.prototype.GetMosnterAbilityConfig(self)
	return {
		castRange = 1000,
		behavior = DOTA_ABILITY_BEHAVIOR_NO_TARGET,
		castPoint = CAST_POINT,
		castDuration = CAST_DURATION,
		castAnimation = ACT_DOTA_CAST_ABILITY_1,
		cooldown = 6,
		canCast = function()
			local ____IsValidAlive_result_0
			if IsValidAlive(nil, self:FindTarget()) then
				____IsValidAlive_result_0 = UF_SUCCESS
			else
				____IsValidAlive_result_0 = UF_FAIL_CUSTOM
			end
			return ____IsValidAlive_result_0
		end,
		OnPhaseStart = function()
			local caster = self:GetCaster()
			local target = self:FindTarget()
			local ____IsValidAlive_result_1
			if IsValidAlive(nil, target) then
				____IsValidAlive_result_1 = target:entindex()
			else
				____IsValidAlive_result_1 = nil
			end
			self.lockedTargetIndex = ____IsValidAlive_result_1
			if IsValidAlive(nil, caster) and IsValidAlive(nil, target) then
				caster:LockTargetForSpeed(target, CAST_POINT, 8)
			end
		end,
		OnStart = function()
			local caster = self:GetCaster()
			if not IsValidAlive(nil, caster) then
				return
			end
			self.sequence = self.sequence + 1
			self:ClearStones()
			self:CreateStones(caster)
			self:StartStoneSequence(caster, self.sequence)
			self:Timer(LEAP_START_TIME, function()
				return self:StartLeap(caster, self.sequence)
			end)
		end,
		OnFinish = function()
			return self:Cleanup()
		end,
		OnInterrupt = function()
			return self:Cleanup()
		end,
	}
end
function elite_150.prototype.CreateStones(self, caster)
	local origin = GetGroundPosition(caster:GetAbsOrigin(), caster)
	local forward = caster:GetForwardVector()
	local right = RotateVector2D(nil, forward, 90)
	local offsets = {
		forward:__mul(180):__add(right:__mul(-220)),
		forward:__mul(280),
		forward:__mul(180):__add(right:__mul(220)),
	}
	EmitSoundOn(SUMMON_SOUND, caster)
	do
		local i = 0
		while i < STONE_COUNT do
			local spawnPos = GetGroundPosition(origin:__add(offsets[i + 1]), caster)
			local stone = CreateModifierThinker(
				caster,
				self,
				"modifier_elite_150_stone",
				{ duration = CAST_DURATION + 0.6 },
				spawnPos,
				caster:GetTeamNumber(),
				false
			)
			local ____self_stones_2 = self.stones
			____self_stones_2[#____self_stones_2 + 1] = stone
			i = i + 1
		end
	end
end
function elite_150.prototype.StartStoneSequence(self, caster, sequence)
	local actions = { ACT_DOTA_CAST_ABILITY_1, ACT_DOTA_CAST_ABILITY_3, ACT_DOTA_CAST_ABILITY_5 }
	do
		local i = 0
		while i < STONE_COUNT do
			local phaseIndex = i
			self:Timer(STONE_PHASE_INTERVAL * phaseIndex, function()
				if sequence ~= self.sequence or not IsValidAlive(nil, caster) then
					return
				end
				self:LaunchStonePhase(caster, phaseIndex, actions[phaseIndex + 1])
			end)
			i = i + 1
		end
	end
end
function elite_150.prototype.LaunchStonePhase(self, caster, phaseIndex, action)
	local stone = self.stones[phaseIndex + 1]
	if not IsValidAlive(nil, stone) then
		return
	end
	local targetPos = self:ResolveTargetPosition(caster)
	caster:SetForwardVector(self:GetDirectionTo(caster:GetAbsOrigin(), targetPos))
	caster:StartGestureWithPlaybackRate(action, 1)
	local start = stone:GetAbsOrigin()
	local direction = self:GetDirectionTo(start, targetPos)
	local ____end = GetGroundPosition(start:__add(direction:__mul(STONE_DISTANCE)), caster)
	self:WarningEffect(
		start,
		____end,
		STONE_LAUNCH_DELAY + 0.1,
		{ startWidth = STONE_RADIUS * 1.1, endWidth = STONE_RADIUS * 1.1 }
	)
	self:Timer(STONE_LAUNCH_DELAY, function()
		if not IsValidAlive(nil, caster) or not IsValid(nil, stone) or stone:IsNull() then
			return
		end
		local modifier = modifier_elite_150_stone:find_on(stone)
		if modifier ~= nil then
			modifier:Launch(direction, STONE_MOVE_DURATION)
		end
	end)
end
function elite_150.prototype.StartLeap(self, caster, sequence)
	if sequence ~= self.sequence or not IsValidAlive(nil, caster) then
		return
	end
	local origin = GetGroundPosition(caster:GetAbsOrigin(), caster)
	local targetPos = self:ResolveTargetPosition(caster)
	local direction = self:GetDirectionTo(origin, targetPos)
	local landPos = self:ResolveSafeLeapLandPosition(caster, origin, direction)
	local peak = origin:__add(Vector(0, 0, LEAP_HEIGHT))
	caster:SetForwardVector(direction)
	caster:StartGestureWithPlaybackRate(ACT_DOTA_CAST_ABILITY_2_ES_ROLL_START, 1)
	self:WarningRingEffect(landPos, LEAP_RADIUS, LEAP_DURATION)
	EmitSoundOn(LEAP_SOUND, caster)
	caster:Bezier2Mover({ origin, peak, landPos }, LEAP_DURATION, nil, true)
	self:MoveStonesToFloatingTriangle(caster, landPos)
	self:Timer(LEAP_DURATION, function()
		if sequence ~= self.sequence or not IsValidAlive(nil, caster) then
			return
		end
		FindClearSpaceForUnit(caster, landPos, false)
		self:SmashAt(caster, landPos)
		self:StartField(caster, landPos, sequence)
	end)
end
function elite_150.prototype.SmashAt(self, caster, origin)
	local smashPoint = GetGroundPosition(origin, caster)
	EmitSoundOnLocationWithCaster(smashPoint, LAND_SOUND, caster)
	EmitSoundOnLocationWithCaster(smashPoint, STONE_HIT_SOUND, caster)
	self:PlayLandEffect(smashPoint)
	ScreenShake(smashPoint, 14, 14, 0.35, 1600, 0, true)
	local enemies = FindUnitsInRadius(
		caster:GetTeamNumber(),
		smashPoint,
		nil,
		LEAP_RADIUS,
		DOTA_UNIT_TARGET_TEAM_ENEMY,
		DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,
		DOTA_UNIT_TARGET_FLAG_NONE,
		FIND_ANY_ORDER,
		false
	)
	for ____, enemy in ipairs(enemies) do
		do
			if not IsValidAlive(nil, enemy) then
				goto __continue27
			end
			caster:MonsterDamage({ victim = enemy, damage_rate = LEAP_DAMAGE_RATE, ability = self })
			AddDeBuffStatus(nil, enemy, caster, self, DebuffStatusType.STUN, { duration = LEAP_STUN_DURATION })
		end
		::__continue27::
	end
end
function elite_150.prototype.StartField(self, caster, origin, sequence)
	local center = GetGroundPosition(origin, caster)
	do
		local i = 0
		while i < FIELD_STRIKE_COUNT do
			local currentDelay = FIELD_STRIKE_INTERVAL * i
			self:Timer(currentDelay, function()
				if sequence ~= self.sequence or not IsValidAlive(nil, caster) then
					return
				end
				self:StartFieldLightningRound(caster, center, sequence)
			end)
			i = i + 1
		end
	end
end
function elite_150.prototype.StartFieldLightningRound(self, caster, center, sequence)
	caster:StartGestureWithPlaybackRate(ACT_DOTA_CAST_ABILITY_6, 1)
	local lightningPlans = self:CreateFieldLightningPlans(caster, center)
	do
		local i = 0
		while i < #lightningPlans do
			local currentPlan = lightningPlans[i + 1]
			self:WarningRingEffect(currentPlan.point, FIELD_DAMAGE_RADIUS, FIELD_WARNING_DURATION)
			self:Timer(FIELD_WARNING_DURATION, function()
				if sequence ~= self.sequence or not IsValidAlive(nil, caster) then
					return
				end
				if not IsValidAlive(nil, currentPlan.stone) then
					return
				end
				if not IsValid(nil, currentPlan.stone) or currentPlan.stone:IsNull() then
					return
				end
				self:PlayFieldBoltEffect(caster, currentPlan.stone:GetAbsOrigin(), currentPlan.point)
				self:DamageField(caster, currentPlan.point)
			end)
			i = i + 1
		end
	end
end
function elite_150.prototype.CreateFieldLightningPlans(self, caster, center)
	local plans = {}
	for ____, stone in ipairs(self.stones) do
		do
			if not IsValidAlive(nil, stone) then
				goto __continue41
			end
			if not IsValid(nil, stone) or stone:IsNull() then
				goto __continue41
			end
			plans[#plans + 1] = {
				stone = stone,
				point = self:ResolveFieldLightningPoint(caster, stone:GetAbsOrigin(), center),
			}
		end
		::__continue41::
	end
	return plans
end
function elite_150.prototype.ResolveFieldLightningPoint(self, caster, source, fallbackCenter)
	local target = caster:GetMinDistanceUnit(FIELD_TARGET_SEARCH_RADIUS, source)
	local ____IsValidAlive_result_5
	if IsValidAlive(nil, target) then
		____IsValidAlive_result_5 = target:GetAbsOrigin()
	else
		____IsValidAlive_result_5 = fallbackCenter
	end
	local basePoint = ____IsValidAlive_result_5
	local angle = RandomFloat(0, math.pi * 2)
	local distance = RandomFloat(FIELD_TARGET_OFFSET_MIN, FIELD_TARGET_OFFSET_MAX)
	local offset = Vector(math.cos(angle) * distance, math.sin(angle) * distance, 0)
	return GetGroundPosition(basePoint:__add(offset), caster)
end
function elite_150.prototype.PlayFieldBoltEffect(self, caster, stonePos, damagePos)
	self:CreateFieldBoltParticle(stonePos, caster:GetAbsOrigin())
	self:CreateFieldBoltParticle2(damagePos, stonePos)
	EmitSoundOnLocationWithCaster(damagePos, FIELD_BOLT_SOUND, caster)
end
function elite_150.prototype.CreateFieldBoltParticle(self, start, ____end)
	local particle = ParticleManager:CreateParticle(FIELD_BOLT_PARTICLE, PATTACH_WORLDORIGIN, nil)
	ParticleManager:SetParticleControl(particle, 0, start)
	ParticleManager:SetParticleControl(particle, 1, ____end)
	ParticleManager:ReleaseParticleIndex(particle)
end
function elite_150.prototype.CreateFieldBoltParticle2(self, start, ____end)
	local particle = ParticleManager:CreateParticle(FIELD_BOLT_PARTICLE2, PATTACH_WORLDORIGIN, nil)
	ParticleManager:SetParticleControl(particle, 0, start)
	ParticleManager:SetParticleControl(particle, 1, ____end)
	ParticleManager:ReleaseParticleIndex(particle)
end
function elite_150.prototype.DamageField(self, caster, origin)
	local enemies = FindUnitsInRadius(
		caster:GetTeamNumber(),
		origin,
		nil,
		FIELD_DAMAGE_RADIUS,
		DOTA_UNIT_TARGET_TEAM_ENEMY,
		DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,
		DOTA_UNIT_TARGET_FLAG_NONE,
		FIND_ANY_ORDER,
		false
	)
	for ____, enemy in ipairs(enemies) do
		do
			if not IsValidAlive(nil, enemy) then
				goto __continue50
			end
			caster:MonsterDamage({ victim = enemy, damage_rate = FIELD_DAMAGE_RATE, ability = self })
		end
		::__continue50::
	end
end
function elite_150.prototype.ResolveTargetPosition(self, caster)
	local target = self:GetLockedTarget() or self:FindTarget()
	if IsValidAlive(nil, target) then
		return GetGroundPosition(target:GetAbsOrigin(), target)
	end
	return GetGroundPosition(caster:GetAbsOrigin():__add(caster:GetForwardVector():__mul(LEAP_DISTANCE)), caster)
end
function elite_150.prototype.FindTarget(self)
	local caster = self:GetCaster()
	if not IsValidAlive(nil, caster) then
		return nil
	end
	return caster:GetMinDistanceUnit(CAST_RANGE)
end
function elite_150.prototype.GetLockedTarget(self)
	if self.lockedTargetIndex == nil then
		return nil
	end
	local target = EntIndexToHScript(self.lockedTargetIndex)
	local ____IsValidAlive_result_6
	if IsValidAlive(nil, target) then
		____IsValidAlive_result_6 = target
	else
		____IsValidAlive_result_6 = nil
	end
	return ____IsValidAlive_result_6
end
function elite_150.prototype.GetDirectionTo(self, start, ____end)
	local direction = Vector(____end.x - start.x, ____end.y - start.y, 0)
	if direction:Length2D() <= 0.01 then
		return Vector(1, 0, 0)
	end
	return direction:Normalized()
end
function elite_150.prototype.ResolveSafeLeapLandPosition(self, caster, origin, direction)
	do
		local distance = LEAP_DISTANCE
		while distance >= 0 do
			local candidate = GetGroundPosition(origin:__add(direction:__mul(distance)), caster)
			if IsGridNavDisplacementWalkable(nil, candidate) then
				return candidate
			end
			distance = distance - LEAP_SAFE_POINT_STEP
		end
	end
	return origin
end
function elite_150.prototype.PlayLandEffect(self, origin)
	local particle = ParticleManager:CreateParticle(LAND_PARTICLE, PATTACH_WORLDORIGIN, nil)
	ParticleManager:SetParticleControl(particle, 0, origin)
	ParticleManager:SetParticleControl(particle, 1, Vector(LEAP_RADIUS, 0, 0))
	ParticleManager:SetParticleControl(particle, 2, Vector(LEAP_DURATION, 0, 0))
	ParticleManager:ReleaseParticleIndex(particle)
end
function elite_150.prototype.MoveStonesToFloatingTriangle(self, caster, landPos)
	local base = GetGroundPosition(landPos, caster)
	local forward = caster:GetForwardVector()
	do
		local i = 0
		while i < STONE_COUNT do
			do
				local stone = self.stones[i + 1]
				if not IsValid(nil, stone) or stone:IsNull() then
					goto __continue66
				end
				local direction = RotateVector2D(nil, forward, i * 120)
				local ____end = base:__add(direction:__mul(FLOATING_STONE_RADIUS))
				____end.z = (GetGroundHeight(____end, caster) or base.z) + FLOATING_STONE_HEIGHT
				local modifier = modifier_elite_150_stone:find_on(stone)
				if modifier ~= nil then
					modifier:MoveToFloatingPoint(____end, LEAP_DURATION)
				end
			end
			::__continue66::
			i = i + 1
		end
	end
end
function elite_150.prototype.Cleanup(self)
	self.sequence = self.sequence + 1
	self.lockedTargetIndex = nil
	self:ClearStones()
end
function elite_150.prototype.ClearStones(self)
	for ____, stone in ipairs(self.stones) do
		if IsValid(nil, stone) and not stone:IsNull() then
			stone:RemoveSelf()
		end
	end
	self.stones = {}
end
elite_150 = __TS__DecorateLegacy({ registerAbility(nil) }, elite_150)
____exports.elite_150 = elite_150
--- 残岩 thinker：待命 → 直线冲撞 → 升至悬浮点
modifier_elite_150_stone = __TS__Class()
modifier_elite_150_stone.name = "modifier_elite_150_stone"
__TS__ClassExtends(modifier_elite_150_stone, MonsterModifier_CS)
function modifier_elite_150_stone.prototype.____constructor(self, ...)
	MonsterModifier_CS.prototype.____constructor(self, ...)
	self.direction = Vector(1, 0, 0)
	self.traveled = 0
	self.hitTargets = __TS__New(Set)
	self.launched = false
	self.movingToFloat = false
	self.floatDuration = 0
	self.floatElapsed = 0
end
function modifier_elite_150_stone.prototype.OnCreated(self)
	if not IsServer() then
		return
	end
	local parent = self:GetParent()
	self.particleId = ParticleManager:CreateParticle(STONE_PARTICLE, PATTACH_ABSORIGIN_FOLLOW, parent)
	ParticleManager:SetParticleControlEnt(
		self.particleId,
		0,
		parent,
		PATTACH_ABSORIGIN_FOLLOW,
		"attach_hitloc",
		parent:GetAbsOrigin(),
		true
	)
	ParticleManager:SetParticleControl(self.particleId, 1, parent:GetAbsOrigin() + Vector(0, 0, 1500))
	local pfx = ParticleManager:CreateParticle(
		"particles/units/heroes/hero_earth_spirit/espirit_spawn.vpcf",
		PATTACH_ABSORIGIN_FOLLOW,
		parent
	)
	ParticleManager:ReleaseParticleIndex(pfx)
end
function modifier_elite_150_stone.prototype.OnDestroy(self)
	if not IsServer() then
		return
	end
	if self.particleId ~= nil then
		ParticleManager:DestroyParticle(self.particleId, false)
		ParticleManager:ReleaseParticleIndex(self.particleId)
		self.particleId = nil
	end
	local parent = self:GetParent()
	if IsValid(nil, parent) and not parent:IsNull() then
		parent:RemoveSelf()
	end
end
function modifier_elite_150_stone.prototype.Launch(self, direction, duration)
	if not IsServer() or self.launched then
		return
	end
	local parent = self:GetParent()
	if not IsValidAlive(nil, parent) then
		return
	end
	ScreenShake(parent:GetAbsOrigin(), 12, 12, 0.35, 3000, 0, true)
	self.launched = true
	local ____temp_9
	if direction:Length2D() > 0.01 then
		____temp_9 = direction:Normalized()
	else
		____temp_9 = Vector(1, 0, 0)
	end
	self.direction = ____temp_9
	self.traveled = 0
	self.hitTargets:clear()
	self:UpdateMovingParticle(duration)
	self:PlaySmashTargetEffect(duration)
	EmitSoundOn(STONE_LAUNCH_SOUND, self:GetParent())
	self:StartIntervalThink(FrameTime())
end
function modifier_elite_150_stone.prototype.OnIntervalThink(self)
	if self.movingToFloat then
		self:UpdateFloatingMove()
		return
	end
	local parent = self:GetParent()
	local caster = self:GetCaster()
	local ability = self:GetAbility()
	if not IsValidAlive(nil, parent) then
		return
	end
	if not IsValid(nil, parent) or parent:IsNull() or not IsValidAlive(nil, caster) or not ability then
		self:Destroy()
		return
	end
	local step = STONE_SPEED * FrameTime()
	local origin = parent:GetAbsOrigin()
	local next = origin:__add(self.direction:__mul(step))
	local groundPos = GetGroundPosition(next, parent)
	parent:SetAbsOrigin(groundPos)
	self.traveled = self.traveled + step
	self:HitEnemies(groundPos, caster, ability)
	if self.traveled >= STONE_DISTANCE then
		self:StartIntervalThink(-1)
	end
end
function modifier_elite_150_stone.prototype.MoveToFloatingPoint(self, endPos, duration)
	if not IsServer() then
		return
	end
	local parent = self:GetParent()
	if not IsValidAlive(nil, parent) then
		return
	end
	if not IsValid(nil, parent) or parent:IsNull() then
		return
	end
	self.movingToFloat = true
	self.floatStart = parent:GetAbsOrigin()
	self.floatEnd = endPos
	self.floatDuration = math.max(duration, 0.03)
	self.floatElapsed = 0
	self:StartIntervalThink(FrameTime())
end
function modifier_elite_150_stone.prototype.IsHidden(self)
	return true
end
function modifier_elite_150_stone.prototype.HitEnemies(self, center, caster, ability)
	if not IsValidAlive(nil, caster) then
		return
	end
	local enemies = FindUnitsInRadius(
		caster:GetTeamNumber(),
		center,
		nil,
		STONE_RADIUS,
		DOTA_UNIT_TARGET_TEAM_ENEMY,
		DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,
		DOTA_UNIT_TARGET_FLAG_NONE,
		FIND_ANY_ORDER,
		false
	)
	for ____, enemy in ipairs(enemies) do
		do
			if not IsValidAlive(nil, enemy) then
				goto __continue94
			end
			local index = enemy:GetEntityIndex()
			if self.hitTargets:has(index) then
				goto __continue94
			end
			self.hitTargets:add(index)
			caster:MonsterDamage({ victim = enemy, damage_rate = STONE_DAMAGE_RATE, ability = ability })
			EmitSoundOn(STONE_HIT_SOUND, enemy)
			enemy:KnockBack(caster, self:GetAbility(), {
				duration = 0.1,
				stunDuration = 0.2,
				stun = true,
				distance = 100,
				height = 0,
				origin_pos = caster:GetAbsOrigin(),
			})
		end
		::__continue94::
	end
end
function modifier_elite_150_stone.prototype.UpdateFloatingMove(self)
	local parent = self:GetParent()
	if not IsValidAlive(nil, parent) then
		return
	end
	if not IsValid(nil, parent) or parent:IsNull() or not self.floatStart or not self.floatEnd then
		self:Destroy()
		return
	end
	self.floatElapsed = self.floatElapsed + FrameTime()
	local t = math.min(self.floatElapsed / self.floatDuration, 1)
	local next = Vector(
		self.floatStart.x + (self.floatEnd.x - self.floatStart.x) * t,
		self.floatStart.y + (self.floatEnd.y - self.floatStart.y) * t,
		self.floatStart.z + (self.floatEnd.z - self.floatStart.z) * t
	)
	parent:SetAbsOrigin(next)
	if t >= 1 then
		self.movingToFloat = false
		self:StartIntervalThink(-1)
	end
end
function modifier_elite_150_stone.prototype.UpdateMovingParticle(self, duration)
	if self.particleId == nil then
		return
	end
	local parent = self:GetParent()
	if not IsValidAlive(nil, parent) then
		return
	end
	local origin = parent:GetAbsOrigin()
	ParticleManager:SetParticleControlTransformForward(self.particleId, 0, origin, self.direction)
	ParticleManager:SetParticleControlForward(self.particleId, 0, self.direction)
	ParticleManager:SetParticleControl(self.particleId, 2, Vector(duration, 0, 0))
end
function modifier_elite_150_stone.prototype.PlaySmashTargetEffect(self, duration)
	local parent = self:GetParent()
	if not IsValidAlive(nil, parent) then
		return
	end
	local origin = parent:GetAbsOrigin()
	local start = origin:__add(Vector(0, 0, 1500))
	local particle = ParticleManager:CreateParticle(SMASH_TARGET_PARTICLE, PATTACH_WORLDORIGIN, nil)
	ParticleManager:SetParticleControl(particle, 0, origin)
	ParticleManager:SetParticleControl(particle, 1, start)
	ParticleManager:SetParticleControl(particle, 2, Vector(duration, 0, 0))
	ParticleManager:ReleaseParticleIndex(particle)
end
modifier_elite_150_stone =
	__TS__DecorateLegacy({ registerModifier(nil, "modifier_elite_150_stone") }, modifier_elite_150_stone)
return ____exports