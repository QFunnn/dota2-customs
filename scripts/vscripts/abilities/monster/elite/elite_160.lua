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
local modifier_elite_160_void
local ____dota_ts_adapter = require("utils.dota_ts_adapter")
local registerAbility = ____dota_ts_adapter.registerAbility
local registerModifier = ____dota_ts_adapter.registerModifier
local ____monster_base = require("abilities.monster.monster_base")
local MonsterAbility_CS = ____monster_base.MonsterAbility_CS
local MonsterModifier_CS = ____monster_base.MonsterModifier_CS
local CAST_RANGE = 900
local CAST_POINT = 0.5
local VOID_DELAY = 0.8
local LANDING_WARNING_LEAD = 0.3
local STRIKE_WARNING_DURATION = 0.35
local STRIKE_COUNT = 1
local SEGMENT_INTERVAL = 1.35
local CAST_DURATION = (STRIKE_COUNT - 1) * SEGMENT_INTERVAL + VOID_DELAY + STRIKE_WARNING_DURATION + 0.35
local BLINK_DISTANCE = 180
local POSITION_TRY_COUNT = 8
local DAMAGE_RATE = 15
local HIT_RADIUS = 500
local HIT_ANGLE_DEG = 270
local WARNING_START_WIDTH = 180
local FINAL_STUN_DURATION = 0.25
local START_PARTICLE = "particles/monster/elite/elite_160/void_sweep_start.vpcf"
local END_PARTICLE = "particles/monster/elite/elite_160/void_sweep_end.vpcf"
local HIT_PARTICLE = "particles/monster/elite/elite_160/void_sweep_hit.vpcf"
local SOUND_VOID_OUT = "Hero_FacelessVoid.TimeWalk"
local SOUND_HIT = "Hero_FacelessVoid.TimeLockImpact"
--- 虚空横扫：连续遁入虚空并从敌人随机侧面现身横扫。
____exports.elite_160 = __TS__Class()
local elite_160 = ____exports.elite_160
elite_160.name = "elite_160"
__TS__ClassExtends(elite_160, MonsterAbility_CS)
function elite_160.prototype.____constructor(self, ...)
	MonsterAbility_CS.prototype.____constructor(self, ...)
	self.sequence = 0
end
function elite_160.prototype.Precache(self, context)
	PrecacheResource("particle", START_PARTICLE, context)
	PrecacheResource("particle", END_PARTICLE, context)
	PrecacheResource("particle", HIT_PARTICLE, context)
	PrecacheResource("soundfile", "soundevents/game_sounds_heroes/game_sounds_faceless_void.vsndevts", context)
end
function elite_160.prototype.GetMosnterAbilityConfig(self)
	return {
		castRange = CAST_RANGE,
		behavior = DOTA_ABILITY_BEHAVIOR_NO_TARGET,
		castPoint = CAST_POINT,
		castDuration = CAST_DURATION,
		castAnimation = ACT_DOTA_CAST_ABILITY_1,
		castColor = Vector(0, 0, 219),
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
			return self:LockInitialTarget()
		end,
		OnStart = function()
			return self:StartVoidSweep()
		end,
		OnFinish = function()
			return self:Cleanup()
		end,
		OnInterrupt = function()
			return self:Cleanup()
		end,
	}
end
function elite_160.prototype.LockInitialTarget(self)
	local caster = self:GetCaster()
	local target = self:FindTarget()
	if not IsValidAlive(nil, caster) or not IsValidAlive(nil, target) then
		return
	end
	caster:LockTargetForSpeed(target, CAST_POINT, 10)
end
function elite_160.prototype.StartVoidSweep(self)
	local caster = self:GetCaster()
	if not IsValidAlive(nil, caster) then
		return
	end
	self.sequence = self.sequence + 1
	local currentSequence = self.sequence
	do
		local index = 0
		while index < STRIKE_COUNT do
			local currentIndex = index
			local currentDelay = currentIndex * SEGMENT_INTERVAL
			local isLast = currentIndex == STRIKE_COUNT - 1
			self:Timer(currentDelay, function()
				self:StartSegment(currentIndex, isLast, currentSequence)
			end)
			index = index + 1
		end
	end
end
function elite_160.prototype.StartSegment(self, segmentIndex, isLast, sequence)
	local caster = self:GetCaster()
	if sequence ~= self.sequence or not IsValidAlive(nil, caster) then
		return
	end
	local origin = caster:GetAbsOrigin()
	self:PlayWorldParticle(START_PARTICLE, origin, caster:GetForwardVector())
	EmitSoundOn(SOUND_VOID_OUT, caster)
	modifier_elite_160_void:applys(caster, caster, self, { duration = VOID_DELAY + 0.12 })
	self:Timer(math.max(VOID_DELAY - LANDING_WARNING_LEAD, 0), function()
		self:PreviewStrikeLanding(segmentIndex, isLast, sequence)
	end)
end
function elite_160.prototype.PreviewStrikeLanding(self, _segmentIndex, isLast, sequence)
	local caster = self:GetCaster()
	if sequence ~= self.sequence or not IsValidAlive(nil, caster) then
		return
	end
	local target = self:FindTarget()
	if not IsValidAlive(nil, target) then
		modifier_elite_160_void:remove(caster)
		return
	end
	local position = self:FindStrikePosition(caster, target)
	local direction = self:GetSafeDirection(target:GetAbsOrigin(), position, caster:GetForwardVector())
	self:PlayWorldParticle(END_PARTICLE, position, direction)
	self:Timer(math.min(LANDING_WARNING_LEAD, VOID_DELAY), function()
		self:PerformStrike(position, direction, isLast, sequence)
	end)
end
function elite_160.prototype.PerformStrike(self, position, direction, isLast, sequence)
	local caster = self:GetCaster()
	if sequence ~= self.sequence or not IsValidAlive(nil, caster) then
		return
	end
	FindClearSpaceForUnit(caster, position, true)
	local strikeOrigin = caster:GetAbsOrigin()
	caster:SetForwardVector(direction)
	modifier_elite_160_void:remove(caster)
	self:WarningEffect(strikeOrigin, strikeOrigin:__add(direction:__mul(HIT_RADIUS)), STRIKE_WARNING_DURATION, {
		startWidth = WARNING_START_WIDTH,
		endWidth = HIT_RADIUS,
		follow = true,
		getStartPosition = function()
			local ____IsValidAlive_result_1
			if IsValidAlive(nil, caster) then
				____IsValidAlive_result_1 = caster:GetAbsOrigin()
			else
				____IsValidAlive_result_1 = strikeOrigin
			end
			return ____IsValidAlive_result_1
		end,
		getDirection = function()
			local ____IsValidAlive_result_2
			if IsValidAlive(nil, caster) then
				____IsValidAlive_result_2 = caster:GetForwardVector()
			else
				____IsValidAlive_result_2 = direction
			end
			return ____IsValidAlive_result_2
		end,
	})
	self:Timer(math.max(STRIKE_WARNING_DURATION - 0.3, 0), function()
		if sequence ~= self.sequence or not IsValidAlive(nil, caster) then
			return
		end
		caster:StartGestureWithFadeAndPlaybackRate(ACT_DOTA_CAST_ABILITY_1, 0.03, 0.15, 1)
	end)
	self:Timer(STRIKE_WARNING_DURATION, function()
		self:ExecuteStrike(caster, direction, isLast, sequence)
	end)
end
function elite_160.prototype.ExecuteStrike(self, caster, direction, isLast, sequence)
	if sequence ~= self.sequence or not IsValidAlive(nil, caster) then
		return
	end
	local strikeOrigin = caster:GetAbsOrigin()
	caster:SetForwardVector(direction)
	self:PlayHitParticle(strikeOrigin, direction)
	EmitSoundOnLocationWithCaster(strikeOrigin, SOUND_HIT, caster)
	self:DamageSweep(caster, strikeOrigin, direction, isLast)
	ScreenShake(strikeOrigin, 8, 8, 0.2, 1200, 0, true)
end
function elite_160.prototype.FindTarget(self)
	local caster = self:GetCaster()
	if not IsValidAlive(nil, caster) then
		return nil
	end
	return caster:GetMinDistanceUnit(CAST_RANGE)
end
function elite_160.prototype.FindStrikePosition(self, caster, target)
	if not IsValidAlive(nil, target) then
		return GetGroundPosition(caster:GetAbsOrigin(), caster)
	end
	local targetOrigin = target:GetAbsOrigin()
	local baseAngle = math.random() * math.pi * 2
	do
		local index = 0
		while index < POSITION_TRY_COUNT do
			local currentIndex = index
			local currentAngle = baseAngle + currentIndex * math.pi * 2 / POSITION_TRY_COUNT
			local direction = Vector(math.cos(currentAngle), math.sin(currentAngle), 0)
			local point = GetGroundPosition(targetOrigin:__add(direction:__mul(BLINK_DISTANCE)), caster)
			if IsGridNavDisplacementWalkable(nil, point) then
				return point
			end
			index = index + 1
		end
	end
	return GetGroundPosition(targetOrigin:__add(Vector(BLINK_DISTANCE, 0, 0)), caster)
end
function elite_160.prototype.DamageSweep(self, caster, origin, forward, isLast)
	local enemies = FindUnitsInCone(
		nil,
		caster:GetTeamNumber(),
		origin,
		nil,
		HIT_RADIUS,
		forward,
		HIT_ANGLE_DEG,
		DOTA_UNIT_TARGET_TEAM_ENEMY,
		DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,
		DOTA_UNIT_TARGET_FLAG_NONE,
		FIND_ANY_ORDER,
		false
	)
	for ____, enemy in ipairs(enemies) do
		do
			if not IsValidAlive(nil, enemy) then
				goto __continue38
			end
			caster:MonsterDamage({ victim = enemy, damage_rate = DAMAGE_RATE, ability = self })
			enemy:KnockBack(caster, self, {
				duration = 0.4,
				block = true,
				direction = caster:GetForwardVector(),
				distance = 30,
				height = 20,
				stun = true,
			})
		end
		::__continue38::
	end
end
function elite_160.prototype.PlayWorldParticle(self, particleName, origin, direction)
	local particle = ParticleManager:CreateParticle(particleName, PATTACH_WORLDORIGIN, nil)
	ParticleManager:SetParticleControl(particle, 0, origin)
	ParticleManager:SetParticleControl(particle, 3, origin)
	ParticleManager:SetParticleControlForward(particle, 0, direction)
	ParticleManager:SetParticleControlForward(particle, 3, direction)
	ParticleManager:ReleaseParticleIndex(particle)
end
function elite_160.prototype.PlayHitParticle(self, origin, direction)
	local particle = ParticleManager:CreateParticle(HIT_PARTICLE, PATTACH_WORLDORIGIN, nil)
	ParticleManager:SetParticleControl(particle, 0, origin)
	ParticleManager:SetParticleControl(particle, 1, origin:__add(direction:__mul(HIT_RADIUS)))
	ParticleManager:SetParticleControl(particle, 3, origin)
	ParticleManager:SetParticleControlForward(particle, 0, direction)
	ParticleManager:SetParticleControlForward(particle, 3, direction)
	ParticleManager:ReleaseParticleIndex(particle)
end
function elite_160.prototype.GetSafeDirection(self, target, origin, fallback)
	local direction = GetDirection(nil, target, origin)
	if direction:Length2D() > 0.01 then
		return direction
	end
	local ____temp_3
	if fallback:Length2D() > 0.01 then
		____temp_3 = fallback:Normalized()
	else
		____temp_3 = Vector(1, 0, 0)
	end
	return ____temp_3
end
function elite_160.prototype.Cleanup(self)
	self.sequence = self.sequence + 1
	local caster = self:GetCaster()
	if IsValidAlive(nil, caster) then
		modifier_elite_160_void:remove(caster)
	end
end
elite_160 = __TS__DecorateLegacy({ registerAbility(nil) }, elite_160)
____exports.elite_160 = elite_160
modifier_elite_160_void = __TS__Class()
modifier_elite_160_void.name = "modifier_elite_160_void"
__TS__ClassExtends(modifier_elite_160_void, MonsterModifier_CS)
function modifier_elite_160_void.prototype.OnCreated(self)
	if not IsServer() then
		return
	end
	local parent = self:GetParent()
	if IsValid(nil, parent) and not parent:IsNull() then
		parent:AddNoDrawWithWearables()
	end
end
function modifier_elite_160_void.prototype.OnDestroy(self)
	if not IsServer() then
		return
	end
	local parent = self:GetParent()
	if IsValid(nil, parent) and not parent:IsNull() then
		parent:RemoveNoDrawWithWearables()
	end
end
function modifier_elite_160_void.prototype.CheckState(self)
	return {
		[MODIFIER_STATE_INVULNERABLE] = true,
		[MODIFIER_STATE_NO_UNIT_COLLISION] = true,
		[MODIFIER_STATE_DISARMED] = true,
		[MODIFIER_STATE_NO_HEALTH_BAR] = true,
		[MODIFIER_STATE_UNSELECTABLE] = true,
	}
end
function modifier_elite_160_void.prototype.IsHidden(self)
	return true
end
function modifier_elite_160_void.prototype.IsPurgable(self)
	return false
end
modifier_elite_160_void =
	__TS__DecorateLegacy({ registerModifier(nil, "modifier_elite_160_void") }, modifier_elite_160_void)
return ____exports