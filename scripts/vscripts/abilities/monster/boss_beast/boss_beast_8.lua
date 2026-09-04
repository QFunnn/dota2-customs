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
local __TS__ObjectAssign = ____lualib.__TS__ObjectAssign
local __TS__ArrayFilter = ____lualib.__TS__ArrayFilter
local __TS__DecorateLegacy = ____lualib.__TS__DecorateLegacy
local __TS__ArrayIncludes = ____lualib.__TS__ArrayIncludes
local ____exports = {}
local ____dota_ts_adapter = require("utils.dota_ts_adapter")
local registerAbility = ____dota_ts_adapter.registerAbility
local registerModifier = ____dota_ts_adapter.registerModifier
local ____modifier_base = require("modifiers.class.modifier_base")
local BaseModifier_CS = ____modifier_base.BaseModifier_CS
local ____boss_phase_transition_ability = require("abilities.monster.boss.boss_phase_transition_ability")
local BossPhaseTransitionAbility_CS = ____boss_phase_transition_ability.BossPhaseTransitionAbility_CS
local SUMMON_NAME = "monster_13012"
local SUMMON_TAG = "boss_beast_8_hound"
local CAST_DURATION = 6
local WAVE_INTERVAL = 1.5
local SUMMON_BATCH_INTERVAL = 0.2
local WARNING_DURATION = 0.7
local SEARCH_RADIUS = 3500
local SUMMON_RADIUS = 900
local SUMMON_POSITION_RETRY = 24
local SUMMON_MIN_DISTANCE = 300
local CHARGE_TARGET_OFFSET_RADIUS = 100
local DASH_DISTANCE = 1300
local DASH_DURATION = 0.55
local DASH_STEP = 90
local DASH_HIT_RADIUS = 150
local DASH_DAMAGE_RATE = 10
local DASH_STUN_DURATION = 0.35
local WARNING_WIDTH = 180
local DOMAIN_RADIUS = 2500
local DOMAIN_EFFECT = "particles/boss/bs/ability_001_red.vpcf"
local SUMMON_EFFECT = "particles/units/heroes/hero_primal_beast/primal_beast_rock_throw_impact.vpcf"
local DASH_EFFECT = "particles/units/heroes/hero_primal_beast/primal_beast_onslaught_charge_active.vpcf"
local SUMMON_SOUND = "Hero_Beastmaster.Call.Boar"
local DASH_SOUND = "Hero_PrimalBeast.Onslaught.Cast"
local HIT_SOUND = "Hero_Spirit_Breaker.GreaterBash"
local WAVE_SUMMON_COUNTS = { 1, 1, 2, 2 }
--- 兽-猎犬围猎：持续召唤猎犬从敌人周围随机角度发起冲刺。
____exports.boss_beast_8 = __TS__Class()
local boss_beast_8 = ____exports.boss_beast_8
boss_beast_8.name = "boss_beast_8"
__TS__ClassExtends(boss_beast_8, BossPhaseTransitionAbility_CS)
function boss_beast_8.prototype.Precache(self, context)
	PrecacheResource("particle", DOMAIN_EFFECT, context)
	PrecacheResource("particle", SUMMON_EFFECT, context)
	PrecacheResource("particle", DASH_EFFECT, context)
end
function boss_beast_8.prototype.GetBossPhaseTransitionGesture(self)
	return ACT_DOTA_OVERRIDE_ABILITY_3
end
function boss_beast_8.prototype.GetBossPhaseTransitionGesturePlaybackRate(self)
	return 0.8
end
function boss_beast_8.prototype.GetBossPhaseTransitionConfig(self)
	return {
		behavior = DOTA_ABILITY_BEHAVIOR_NO_TARGET,
		castPoint = 0,
		castDuration = self:GetBossPhaseTransitionReturnToSpawnDuration() + self:GetBossPhaseTransitionWindowDuration(),
		castAnimation = ACT_DOTA_OVERRIDE_ABILITY_3,
		animationPlaybackRate = 0.8,
		isNotMove = true,
		OnPhaseStart = function()
			local caster = self:GetCaster()
			if not IsValidAlive(nil, caster) then
				return
			end
			caster:StartGestureWithPlaybackRate(ACT_DOTA_OVERRIDE_ABILITY_3, 0.8)
		end,
		OnStart = function()
			self:PlayDomainEffect()
			self:StartHoundWaves()
		end,
	}
end
function boss_beast_8.prototype.PlayDomainEffect(self)
	local caster = self:GetCaster()
	if not IsValidAlive(nil, caster) then
		return
	end
	local origin = GetGroundPosition(caster:GetAbsOrigin(), caster)
	local effect = ParticleManager:CreateParticle(DOMAIN_EFFECT, PATTACH_WORLDORIGIN, caster)
	ParticleManager:SetParticleControl(effect, 0, origin)
	ParticleManager:SetParticleControl(effect, 1, Vector(DOMAIN_RADIUS, 0, 0))
	ParticleManager:SetParticleControl(effect, 2, Vector(DOMAIN_RADIUS, DOMAIN_RADIUS, DOMAIN_RADIUS))
	ParticleManager:SetParticleShouldCheckFoW(effect, false)
	Timers:CreateTimer(CAST_DURATION, function()
		ParticleManager:DestroyParticle(effect, false)
		ParticleManager:ReleaseParticleIndex(effect)
		return nil
	end)
end
function boss_beast_8.prototype.StartHoundWaves(self)
	if not IsServer() then
		return
	end
	local caster = self:GetCaster()
	if not IsValidAlive(nil, caster) then
		return
	end
	self:Timer(0, function()
		self:PrepareHoundWave(0)
	end)
	self:Timer(WAVE_INTERVAL, function()
		self:PrepareHoundWave(1)
	end)
	self:Timer(WAVE_INTERVAL * 2, function()
		self:PrepareHoundWave(2)
	end)
	self:Timer(WAVE_INTERVAL * 3, function()
		self:PrepareHoundWave(3)
	end)
end
function boss_beast_8.prototype.PrepareHoundWave(self, waveIndex)
	local caster = self:GetCaster()
	if not IsValidAlive(nil, caster) then
		return
	end
	local enemies = self:FindWaveTargets(caster)
	if #enemies <= 0 then
		return
	end
	local summonCount = WAVE_SUMMON_COUNTS[waveIndex + 1] or 0
	local plans = {}
	for ____, target in ipairs(enemies) do
		do
			if not IsValidAlive(nil, target) then
				goto __continue22
			end
			local usedSpawnPositions = {}
			do
				local i = 0
				while i < summonCount do
					do
						local plan = self:CreateChargePlan(caster, target, usedSpawnPositions)
						if not plan then
							goto __continue24
						end
						plans[#plans + 1] = __TS__ObjectAssign({}, plan, { delay = i * SUMMON_BATCH_INTERVAL })
						usedSpawnPositions[#usedSpawnPositions + 1] = plan.spawnPos
					end
					::__continue24::
					i = i + 1
				end
			end
		end
		::__continue22::
	end
	for ____, plan in ipairs(plans) do
		self:Timer(plan.delay, function()
			if not IsValidAlive(nil, caster) or not IsValidAlive(nil, plan.target) then
				return
			end
			self:WarningEffect(
				plan.spawnPos,
				self:GetWarningEnd(plan.spawnPos, plan.direction),
				WARNING_DURATION,
				{ startWidth = WARNING_WIDTH, endWidth = WARNING_WIDTH }
			)
			self:PlaySummonEffect(plan.spawnPos, caster)
			self:SummonPreparingHound(plan.target, plan.spawnPos, plan.direction)
		end)
	end
end
function boss_beast_8.prototype.FindWaveTargets(self, caster)
	return __TS__ArrayFilter(
		FindUnitsInRadius(caster:GetTeamNumber(), caster:GetAbsOrigin(), nil, SEARCH_RADIUS, 2, 1 + 18, 0, 0, false),
		function(____, enemy)
			return IsValidAlive(nil, enemy)
		end
	)
end
function boss_beast_8.prototype.CreateChargePlan(self, caster, target, usedSpawnPositions)
	if not IsValidAlive(nil, target) then
		return
	end
	local targetPos = GetGroundPosition(target:GetAbsOrigin(), target)
	local spawnPos = self:FindRandomTraversablePointAroundTarget(caster, target, targetPos, usedSpawnPositions)
	if not spawnPos then
		return nil
	end
	local chargeTargetPos = self:GetRandomChargeTargetPosition(target, targetPos)
	local direction = GetDirection(nil, chargeTargetPos, spawnPos)
	return { target = target, spawnPos = spawnPos, direction = direction }
end
function boss_beast_8.prototype.FindRandomTraversablePointAroundTarget(
	self,
	caster,
	target,
	targetPos,
	usedSpawnPositions
)
	local casterOrigin = GetGroundPosition(caster:GetAbsOrigin(), caster)
	local baseDirection = GetDirection(nil, casterOrigin, targetPos)
	do
		local i = 0
		while i < SUMMON_POSITION_RETRY do
			local direction = RotateVector2D(nil, baseDirection, RandomFloat(-180, 180)):Normalized()
			local candidate = targetPos:__add(direction:__mul(SUMMON_RADIUS))
			local point = GetGroundPosition(candidate, target)
			local invalidReason = self:GetInvalidSummonPointReason(targetPos, point, usedSpawnPositions)
			if not invalidReason then
				return point
			end
			i = i + 1
		end
	end
	local fallback = GetGroundPosition(targetPos:__add(baseDirection:__mul(SUMMON_RADIUS)), target)
	local fallbackReason = self:GetInvalidSummonPointReason(targetPos, fallback, usedSpawnPositions)
	local ____fallbackReason_0
	if fallbackReason then
		____fallbackReason_0 = nil
	else
		____fallbackReason_0 = fallback
	end
	return ____fallbackReason_0
end
function boss_beast_8.prototype.GetRandomChargeTargetPosition(self, target, targetPos)
	local direction = RotateVector2D(nil, Vector(1, 0, 0), RandomFloat(0, 360)):Normalized()
	local distance = RandomFloat(0, CHARGE_TARGET_OFFSET_RADIUS)
	return GetGroundPosition(targetPos:__add(direction:__mul(distance)), target)
end
function boss_beast_8.prototype.IsValidSummonPoint(self, origin, point)
	return self:GetInvalidSummonPointReason(origin, point) == nil
end
function boss_beast_8.prototype.GetInvalidSummonPointReason(self, origin, point, usedSpawnPositions)
	if usedSpawnPositions == nil then
		usedSpawnPositions = {}
	end
	if not GridNav:IsTraversable(point) or GridNav:IsBlocked(point) then
		return "blocked"
	end
	if not GridNav:CanFindPath(origin, point) then
		return "no_path"
	end
	if GridNav:FindPathLength(origin, point) == -1 then
		return "no_path"
	end
	for ____, usedPos in ipairs(usedSpawnPositions) do
		if GetDistance(nil, point, usedPos) < SUMMON_MIN_DISTANCE then
			return "too_close"
		end
	end
	return nil
end
function boss_beast_8.prototype.SummonPreparingHound(self, target, spawnPos, direction)
	local caster = self:GetCaster()
	if not IsValidAlive(nil, caster) or not IsValidAlive(nil, target) then
		return
	end
	local ____caster_GetRoomId_1
	if caster.GetRoomId then
		____caster_GetRoomId_1 = caster:GetRoomId()
	else
		____caster_GetRoomId_1 = nil
	end
	local roomId = ____caster_GetRoomId_1
	EmitSoundOnLocationWithCaster(spawnPos, SUMMON_SOUND, caster)
	MyGameUnit:CreateSummonedUnitAsync({
		unitName = SUMMON_NAME,
		summoner = caster,
		summonTag = SUMMON_TAG,
		position = spawnPos,
		roomId = roomId,
		team = caster:GetTeamNumber(),
		owner = caster,
		findClearSpace = true,
		destroyWithSummoner = true,
		onSpawn = function(____, unit)
			if not unit or not IsValidAlive(nil, unit) then
				return
			end
			if not IsValidAlive(nil, caster) then
				MyGameUnit:DestroyUnit(unit)
				return
			end
			unit:SetForwardVectorWithoutInterrupt(direction)
			unit:AddNewModifier(caster, self, "modifier_boss_beast_8_hound_prepare", { duration = WARNING_DURATION })
			self:Timer(WARNING_DURATION, function()
				return self:StartHoundCharge(unit, direction)
			end)
		end,
	})
end
function boss_beast_8.prototype.StartHoundCharge(self, unit, direction)
	local caster = self:GetCaster()
	if not IsValidAlive(nil, caster) or not IsValidAlive(nil, unit) then
		return
	end
	caster:StartGestureWithPlaybackRate(ACT_DOTA_CAST_ABILITY_2, 1)
	unit:RemoveModifierByName("modifier_boss_beast_8_hound_prepare")
	unit:SetForwardVectorWithoutInterrupt(direction)
	unit:AddNewModifier(caster, self, "modifier_boss_beast_8_hound_charge", {
		duration = DASH_DURATION,
		direction_x = direction.x,
		direction_y = direction.y,
		direction_z = direction.z,
		ability_index = self:entindex(),
	})
end
function boss_beast_8.prototype.GetWarningEnd(self, startPos, direction)
	return startPos:__add(direction:__mul(DASH_DISTANCE))
end
function boss_beast_8.prototype.PlaySummonEffect(self, pos, caster)
	local effect = ParticleManager:CreateParticle(SUMMON_EFFECT, PATTACH_WORLDORIGIN, caster)
	ParticleManager:SetParticleControl(effect, 0, pos)
	ParticleManager:SetParticleControl(effect, 3, pos)
	ParticleManager:SetParticleShouldCheckFoW(effect, false)
	Timers:CreateTimer(WARNING_DURATION + 0.3, function()
		ParticleManager:DestroyParticle(effect, false)
		ParticleManager:ReleaseParticleIndex(effect)
		return nil
	end)
end
boss_beast_8 = __TS__DecorateLegacy({ registerAbility(nil) }, boss_beast_8)
____exports.boss_beast_8 = boss_beast_8
local modifier_boss_beast_8_hound_prepare = __TS__Class()
modifier_boss_beast_8_hound_prepare.name = "modifier_boss_beast_8_hound_prepare"
__TS__ClassExtends(modifier_boss_beast_8_hound_prepare, BaseModifier_CS)
function modifier_boss_beast_8_hound_prepare.prototype.IsHidden(self)
	return true
end
function modifier_boss_beast_8_hound_prepare.prototype.OnCreated(self)
	if not IsServer() then
		return
	end
	local parent = self:GetParent()
	parent:StartGestureWithPlaybackRate(ACT_DOTA_CAST_ABILITY_4, 1)
end
function modifier_boss_beast_8_hound_prepare.prototype.OnDestroy(self)
	if not IsServer() then
		return
	end
	local parent = self:GetParent()
	if not IsValid(nil, parent) or parent:IsNull() then
		return
	end
end
function modifier_boss_beast_8_hound_prepare.prototype.DeclareFunctions(self)
	return { MODIFIER_PROPERTY_OVERRIDE_ANIMATION, MODIFIER_PROPERTY_OVERRIDE_ANIMATION_RATE }
end
function modifier_boss_beast_8_hound_prepare.prototype.GetOverrideAnimation(self)
	return ACT_DOTA_OVERRIDE_ABILITY_4
end
function modifier_boss_beast_8_hound_prepare.prototype.GetOverrideAnimationRate(self)
	return 1
end
function modifier_boss_beast_8_hound_prepare.prototype.CheckState(self)
	return {
		[MODIFIER_STATE_INVULNERABLE] = true,
		[MODIFIER_STATE_UNSELECTABLE] = true,
		[MODIFIER_STATE_NO_HEALTH_BAR] = true,
		[MODIFIER_STATE_NO_UNIT_COLLISION] = true,
		[MODIFIER_STATE_COMMAND_RESTRICTED] = true,
		[MODIFIER_STATE_ROOTED] = true,
		[MODIFIER_STATE_DISARMED] = true,
	}
end
modifier_boss_beast_8_hound_prepare =
	__TS__DecorateLegacy({ registerModifier(nil) }, modifier_boss_beast_8_hound_prepare)
local modifier_boss_beast_8_hound_charge = __TS__Class()
modifier_boss_beast_8_hound_charge.name = "modifier_boss_beast_8_hound_charge"
__TS__ClassExtends(modifier_boss_beast_8_hound_charge, BaseModifier_CS)
function modifier_boss_beast_8_hound_charge.prototype.____constructor(self, ...)
	BaseModifier_CS.prototype.____constructor(self, ...)
	self.direction = Vector(1, 0, 0)
	self.hitTargets = {}
end
function modifier_boss_beast_8_hound_charge.prototype.OnCreated(self, params)
	if not IsServer() then
		return
	end
	local parent = self:GetParent()
	self.direction = Vector(params.direction_x, params.direction_y, params.direction_z):Normalized()
	self.ability = EntIndexToHScript(params.ability_index)
	parent:SetForwardVectorWithoutInterrupt(self.direction)
	EmitSoundOn(DASH_SOUND, parent)
	local pfx = ParticleManager:CreateParticle(DASH_EFFECT, PATTACH_ABSORIGIN_FOLLOW, parent)
	self:AddParticle(pfx, false, false, -1, false, false)
	self:StartIntervalThink(FrameTime())
end
function modifier_boss_beast_8_hound_charge.prototype.OnIntervalThink(self)
	if not IsServer() then
		return
	end
	local parent = self:GetParent()
	if not IsValidAlive(nil, parent) then
		self:Destroy()
		return
	end
	local nextPos = GetGroundPosition(parent:GetAbsOrigin():__add(self.direction:__mul(DASH_STEP)), parent)
	if not GridNav:IsTraversable(nextPos) or GridNav:IsBlocked(nextPos) then
		self:Destroy()
		return
	end
	parent:SetAbsOrigin(nextPos)
	GridNav:DestroyTreesAroundPoint(nextPos, DASH_HIT_RADIUS, false)
	self:HitEnemies(nextPos)
end
function modifier_boss_beast_8_hound_charge.prototype.OnDestroy(self)
	if not IsServer() then
		return
	end
	local parent = self:GetParent()
	if not IsValid(nil, parent) or parent:IsNull() then
		return
	end
	FindClearSpaceForUnit(parent, parent:GetAbsOrigin(), true)
	parent:MoveToPositionAggressive(parent:GetAbsOrigin())
end
function modifier_boss_beast_8_hound_charge.prototype.HitEnemies(self, position)
	local parent = self:GetParent()
	local caster = self:GetCaster()
	if not IsValidAlive(nil, parent) or not IsValidAlive(nil, caster) or not self.ability then
		return
	end
	local enemies = FindUnitsInRadius(
		parent:GetTeamNumber(),
		position,
		nil,
		DASH_HIT_RADIUS,
		DOTA_UNIT_TARGET_TEAM_ENEMY,
		DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,
		DOTA_UNIT_TARGET_FLAG_NONE,
		FIND_ANY_ORDER,
		false
	)
	for ____, enemy in ipairs(enemies) do
		do
			if not IsValidAlive(nil, enemy) then
				goto __continue80
			end
			local index = enemy:GetEntityIndex()
			if __TS__ArrayIncludes(self.hitTargets, index) then
				goto __continue80
			end
			local ____self_hitTargets_2 = self.hitTargets
			____self_hitTargets_2[#____self_hitTargets_2 + 1] = index
			caster:MonsterDamage({ victim = enemy, damage_rate = DASH_DAMAGE_RATE, ability = self.ability })
			AddDeBuffStatus(nil, enemy, caster, self.ability, DebuffStatusType.STUN, { duration = DASH_STUN_DURATION })
			enemy:KnockBack(parent, self.ability, {
				duration = 0.2,
				distance = 180,
				height = 60,
				direction = self.direction,
				particleName = "",
			})
			EmitSoundOn(HIT_SOUND, enemy)
		end
		::__continue80::
	end
end
function modifier_boss_beast_8_hound_charge.prototype.CheckState(self)
	return { [MODIFIER_STATE_DISARMED] = true, [MODIFIER_STATE_NO_UNIT_COLLISION] = true }
end
modifier_boss_beast_8_hound_charge = __TS__DecorateLegacy({ registerModifier(nil) }, modifier_boss_beast_8_hound_charge)
return ____exports