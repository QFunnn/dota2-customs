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
local modifier_boss_brewmaster_2_precast_activity, modifier_boss_brewmaster_2_face_nearest
local ____modifier_base = require("modifiers.class.modifier_base")
local BaseModifier_CS = ____modifier_base.BaseModifier_CS
local ____dota_ts_adapter = require("utils.dota_ts_adapter")
local registerAbility = ____dota_ts_adapter.registerAbility
local registerModifier = ____dota_ts_adapter.registerModifier
local ____monster_base = require("abilities.monster.monster_base")
local MonsterAbility_CS = ____monster_base.MonsterAbility_CS
local BOSS_BREWMASTER_2_CAST_POINT = 1
local BOSS_BREWMASTER_2_PRECAST_GESTURE_REPEAT_INTERVAL = 1
local BOSS_BREWMASTER_2_BREATH_ROUND_DURATION = 0.6
local BOSS_BREWMASTER_2_BREATH_PROJECTILE_DELAY = 0.33
local BOSS_BREWMASTER_2_FIRST_BREATH_WARNING_DURATION = BOSS_BREWMASTER_2_CAST_POINT
	+ BOSS_BREWMASTER_2_BREATH_PROJECTILE_DELAY
local BOSS_BREWMASTER_2_BREATH_COUNT = 3
local BOSS_BREWMASTER_2_ABILITY_4_ACTION_DURATION = 1.37
local BOSS_BREWMASTER_2_ABILITY_4_FIRE_DELAY = 1.03
local BOSS_BREWMASTER_2_CAST_DURATION = BOSS_BREWMASTER_2_BREATH_ROUND_DURATION * (BOSS_BREWMASTER_2_BREATH_COUNT - 1)
	+ BOSS_BREWMASTER_2_ABILITY_4_ACTION_DURATION
local BOSS_BREWMASTER_2_TOTAL_DURATION = BOSS_BREWMASTER_2_CAST_POINT + BOSS_BREWMASTER_2_CAST_DURATION
local BOSS_BREWMASTER_2_FACE_DURATION = BOSS_BREWMASTER_2_TOTAL_DURATION
local BOSS_BREWMASTER_2_FACE_SEARCH_RANGE = 2500
local BOSS_BREWMASTER_2_FACE_INTERVAL = 0.03
local BOSS_BREWMASTER_2_FACE_TURN_SPEED = 3
local BOSS_BREWMASTER_2_BREATH_DAMAGE_RATE = 26
local BOSS_BREWMASTER_2_BURN_DURATION = 3
local BOSS_BREWMASTER_2_BREATH_EFFECT = "particles/units/heroes/hero_dragon_knight/dragon_knight_breathe_fire.vpcf"
local BOSS_BREWMASTER_2_BREATH_SOUND = "Hero_DragonKnight.BreathFire"
local BOSS_BREWMASTER_2_FINAL_BREATH_SOUND = "Hero_Brewmaster.PrimalSplit.Spawn"
local BOSS_BREWMASTER_2_BREATH_PROJECTILE_DISTANCE = 1200
local BOSS_BREWMASTER_2_BREATH_PROJECTILE_WIDTH = 150
local BOSS_BREWMASTER_2_BREATH_PROJECTILE_SPEED = 1500
local BOSS_BREWMASTER_2_ILLUSION_EFFECT =
	"particles/units/heroes/hero_brewmaster/brewmaster_primal_split_fire_image.vpcf"
local BOSS_BREWMASTER_2_ILLUSION_COUNT_PER_BREATH = 4
local BOSS_BREWMASTER_2_ILLUSION_PREWARNING_DURATION = BOSS_BREWMASTER_2_PRECAST_GESTURE_REPEAT_INTERVAL
local BOSS_BREWMASTER_2_ILLUSION_FIRE_OFFSET = 0.6
local BOSS_BREWMASTER_2_ILLUSION_DURATION = 1.25
local BOSS_BREWMASTER_2_ILLUSION_RANDOM_MIN_DISTANCE = 300
local BOSS_BREWMASTER_2_ILLUSION_RANDOM_MAX_DISTANCE = 900
local BOSS_BREWMASTER_2_ILLUSION_DIRECTION_POINT_DISTANCE = 100
local BOSS_BREWMASTER_2_ILLUSION_LINE_SPACING = 220
local BOSS_BREWMASTER_2_ENABLE_ILLUSION_BREATH = false
local BOSS_BREWMASTER_2_FINAL_BREATH_ANGLES = { -15, 0, 15 }
local BOSS_BREWMASTER_2_RECOIL_DISTANCE = 80
local BOSS_BREWMASTER_2_RECOIL_DURATION = 0.25
--- 酒仙 BOSS 技能 2。
____exports.boss_brewmaster_2 = __TS__Class()
local boss_brewmaster_2 = ____exports.boss_brewmaster_2
boss_brewmaster_2.name = "boss_brewmaster_2"
__TS__ClassExtends(boss_brewmaster_2, MonsterAbility_CS)
function boss_brewmaster_2.prototype.____constructor(self, ...)
	MonsterAbility_CS.prototype.____constructor(self, ...)
	self.breathToken = 0
end
function boss_brewmaster_2.prototype.Precache(self, context)
	PrecacheResource("particle", BOSS_BREWMASTER_2_BREATH_EFFECT, context)
	PrecacheResource("particle", BOSS_BREWMASTER_2_ILLUSION_EFFECT, context)
	PrecacheResource("soundfile", "sounds/weapons/hero/dragon_knight/dragonknight_fire.vsnd", context)
end
function boss_brewmaster_2.prototype.GetMosnterAbilityConfig(self)
	return {
		behavior = DOTA_ABILITY_BEHAVIOR_NO_TARGET,
		castPoint = BOSS_BREWMASTER_2_CAST_POINT,
		castDuration = BOSS_BREWMASTER_2_CAST_DURATION,
		castAnimation = ACT_DOTA_OVERRIDE_ABILITY_4,
		isNotMove = true,
		counterBreakWindowDuration = BOSS_BREWMASTER_2_CAST_POINT,
		castPointDamageReduction = 0,
		OnPhaseStart = function()
			return self:StartPrecast()
		end,
		OnStart = function()
			return self:StartBreathSequence()
		end,
		OnInterrupt = function()
			return self:InterruptBreathSequence()
		end,
		OnFinish = function()
			return self:FinishBreathSequence()
		end,
	}
end
function boss_brewmaster_2.prototype.StartPrecast(self)
	local caster = self:GetCaster()
	if not IsValidAlive(nil, caster) then
		return
	end
	local ____self_0, ____breathToken_1 = self, "breathToken"
	local ____self_breathToken_2 = ____self_0[____breathToken_1] + 1
	____self_0[____breathToken_1] = ____self_breathToken_2
	local token = ____self_breathToken_2
	modifier_boss_brewmaster_2_precast_activity:applys(
		caster,
		caster,
		self,
		{ duration = BOSS_BREWMASTER_2_CAST_POINT }
	)
	modifier_boss_brewmaster_2_face_nearest:applys(caster, caster, self, { duration = BOSS_BREWMASTER_2_FACE_DURATION })
	self:SchedulePrecastGestures(caster, token)
	self:StartBreathWarning(caster, BOSS_BREWMASTER_2_FIRST_BREATH_WARNING_DURATION)
	if BOSS_BREWMASTER_2_ENABLE_ILLUSION_BREATH then
		self:ScheduleIllusionBreathWaves(caster, token)
	end
end
function boss_brewmaster_2.prototype.SchedulePrecastGestures(self, caster, token)
	local repeatCount = math.floor(BOSS_BREWMASTER_2_CAST_POINT / BOSS_BREWMASTER_2_PRECAST_GESTURE_REPEAT_INTERVAL)
	do
		local repeatIndex = 0
		while repeatIndex < repeatCount do
			local currentRepeatIndex = repeatIndex
			local repeatDelay = currentRepeatIndex * BOSS_BREWMASTER_2_PRECAST_GESTURE_REPEAT_INTERVAL
			self:Timer(repeatDelay, function()
				if token ~= self.breathToken or not IsValidAlive(nil, caster) then
					return
				end
				caster:FadeGesture(ACT_DOTA_OVERRIDE_ABILITY_4)
				caster:StartGestureWithPlaybackRate(ACT_DOTA_OVERRIDE_ABILITY_4, 1)
			end)
			repeatIndex = repeatIndex + 1
		end
	end
end
function boss_brewmaster_2.prototype.StartBreathSequence(self)
	local caster = self:GetCaster()
	if not IsValidAlive(nil, caster) then
		return
	end
	local ____temp_6
	if self.breathToken > 0 then
		____temp_6 = self.breathToken
	else
		local ____self_3, ____breathToken_4 = self, "breathToken"
		local ____self_breathToken_5 = ____self_3[____breathToken_4] + 1
		____self_3[____breathToken_4] = ____self_breathToken_5
		____temp_6 = ____self_breathToken_5
	end
	local token = ____temp_6
	caster:FadeGesture(ACT_DOTA_OVERRIDE_ABILITY_4)
	self:PlayBreathRound(caster, token, 1)
end
function boss_brewmaster_2.prototype.PlayBreathRound(self, caster, token, round)
	if not IsValidAlive(nil, caster) or token ~= self.breathToken then
		return
	end
	local currentRound = round
	local isFinalRound = currentRound == BOSS_BREWMASTER_2_BREATH_COUNT
	local ____isFinalRound_7
	if isFinalRound then
		____isFinalRound_7 = ACT_DOTA_CAST_ABILITY_4
	else
		____isFinalRound_7 = ACT_DOTA_CAST_ABILITY_2
	end
	local activity = ____isFinalRound_7
	local fireDelay = isFinalRound and BOSS_BREWMASTER_2_ABILITY_4_FIRE_DELAY
		or BOSS_BREWMASTER_2_BREATH_PROJECTILE_DELAY
	local roundDuration = isFinalRound and BOSS_BREWMASTER_2_ABILITY_4_ACTION_DURATION
		or BOSS_BREWMASTER_2_BREATH_ROUND_DURATION
	caster:FadeGesture(ACT_DOTA_CAST_ABILITY_2)
	caster:FadeGesture(ACT_DOTA_CAST_ABILITY_4)
	caster:StartGestureWithPlaybackRate(activity, 1)
	if isFinalRound then
		EmitSoundOn(BOSS_BREWMASTER_2_FINAL_BREATH_SOUND, caster)
	end
	self:Timer(fireDelay, function()
		if token ~= self.breathToken or not IsValidAlive(nil, caster) then
			return
		end
		EmitSoundOn(BOSS_BREWMASTER_2_BREATH_SOUND, caster)
		if isFinalRound then
			self:FireFinalBreathFan(caster, token)
		else
			self:FireBreathProjectile(caster, token)
		end
	end)
	self:Timer(roundDuration, function()
		if token ~= self.breathToken or not IsValidAlive(nil, caster) then
			return
		end
		caster:FadeGesture(activity)
		if currentRound < BOSS_BREWMASTER_2_BREATH_COUNT then
			self:PlayBreathRound(caster, token, currentRound + 1)
		end
	end)
end
function boss_brewmaster_2.prototype.ScheduleIllusionBreathWaves(self, caster, token)
	do
		local roundIndex = 0
		while roundIndex < BOSS_BREWMASTER_2_BREATH_COUNT do
			local currentRoundIndex = roundIndex
			local mainFireTime = BOSS_BREWMASTER_2_CAST_POINT
				+ currentRoundIndex * BOSS_BREWMASTER_2_BREATH_ROUND_DURATION
				+ BOSS_BREWMASTER_2_BREATH_PROJECTILE_DELAY
			local currentPlans = self:CreateIllusionBreathWavePlans(caster)
			local warningDelay = currentRoundIndex * BOSS_BREWMASTER_2_PRECAST_GESTURE_REPEAT_INTERVAL
			self:Timer(warningDelay, function()
				if token ~= self.breathToken or not IsValidAlive(nil, caster) then
					return
				end
				for ____, plan in ipairs(currentPlans) do
					local currentPlan = plan
					self:WarningEffect(
						currentPlan.startPoint,
						currentPlan.endPoint,
						BOSS_BREWMASTER_2_ILLUSION_PREWARNING_DURATION,
						{
							startWidth = BOSS_BREWMASTER_2_BREATH_PROJECTILE_WIDTH,
							endWidth = BOSS_BREWMASTER_2_BREATH_PROJECTILE_WIDTH,
						}
					)
				end
			end)
			local illusionAppearDelay = math.max(0, mainFireTime - BOSS_BREWMASTER_2_ILLUSION_FIRE_OFFSET)
			self:Timer(illusionAppearDelay, function()
				if token ~= self.breathToken or not IsValidAlive(nil, caster) then
					return
				end
				for ____, plan in ipairs(currentPlans) do
					local currentPlan = plan
					self:PlayIllusionEffect(currentPlan.origin, currentPlan.forward)
				end
			end)
			self:Timer(mainFireTime, function()
				if token ~= self.breathToken or not IsValidAlive(nil, caster) then
					return
				end
				for ____, plan in ipairs(currentPlans) do
					local currentPlan = plan
					self:FireBreathProjectileFrom(
						caster,
						token,
						currentPlan.startPoint,
						currentPlan.forward,
						currentPlan.endPoint
					)
				end
			end)
			roundIndex = roundIndex + 1
		end
	end
end
function boss_brewmaster_2.prototype.CreateIllusionBreathWavePlans(self, caster)
	local centerOrigin = self:GetRandomIllusionOrigin(caster)
	local casterOrigin = GetGroundPosition(caster:GetAbsOrigin(), caster)
	local forward = GetDirection(nil, casterOrigin, centerOrigin)
	local lateral = Vector(-forward.y, forward.x, 0):Normalized()
	local plans = {}
	local centerIndex = (BOSS_BREWMASTER_2_ILLUSION_COUNT_PER_BREATH - 1) / 2
	do
		local illusionIndex = 0
		while illusionIndex < BOSS_BREWMASTER_2_ILLUSION_COUNT_PER_BREATH do
			local currentIllusionIndex = illusionIndex
			local lateralOffset = (currentIllusionIndex - centerIndex) * BOSS_BREWMASTER_2_ILLUSION_LINE_SPACING
			local origin = GetGroundPosition(centerOrigin:__add(lateral:__mul(lateralOffset)), caster)
			local startPoint = self:GetIllusionBreathStartPoint(origin, forward)
			plans[#plans + 1] = {
				origin = origin,
				forward = forward,
				startPoint = startPoint,
				endPoint = self:GetBreathEndPoint(startPoint, forward),
			}
			illusionIndex = illusionIndex + 1
		end
	end
	return plans
end
function boss_brewmaster_2.prototype.PlayIllusionEffect(self, origin, forward)
	local effect = ParticleManager:CreateParticle(BOSS_BREWMASTER_2_ILLUSION_EFFECT, PATTACH_WORLDORIGIN, nil)
	local directionPoint = origin:__sub(forward:__mul(BOSS_BREWMASTER_2_ILLUSION_DIRECTION_POINT_DISTANCE))
	ParticleManager:SetParticleControl(effect, 1, origin)
	ParticleManager:SetParticleControl(effect, 0, directionPoint)
	ParticleManager:SetParticleShouldCheckFoW(effect, false)
	self:Timer(BOSS_BREWMASTER_2_ILLUSION_DURATION, function()
		ParticleManager:DestroyParticle(effect, false)
		ParticleManager:ReleaseParticleIndex(effect)
	end)
end
function boss_brewmaster_2.prototype.StartBreathWarning(self, caster, duration)
	local startPoint = self:GetBreathStartPoint(caster)
	local endPoint = self:GetBreathEndPoint(startPoint, caster:GetForwardVector())
	self:WarningEffect(startPoint, endPoint, duration, {
		startWidth = BOSS_BREWMASTER_2_BREATH_PROJECTILE_WIDTH,
		endWidth = BOSS_BREWMASTER_2_BREATH_PROJECTILE_WIDTH,
		getStartPosition = function()
			local ____IsValidAlive_result_8
			if IsValidAlive(nil, caster) then
				____IsValidAlive_result_8 = self:GetBreathStartPoint(caster)
			else
				____IsValidAlive_result_8 = nil
			end
			return ____IsValidAlive_result_8
		end,
		getDirection = function()
			local ____IsValidAlive_result_9
			if IsValidAlive(nil, caster) then
				____IsValidAlive_result_9 = caster:GetForwardVector()
			else
				____IsValidAlive_result_9 = nil
			end
			return ____IsValidAlive_result_9
		end,
	})
end
function boss_brewmaster_2.prototype.FireBreathProjectile(self, caster, token)
	local forward = caster:GetForwardVector()
	local startPoint = self:GetBreathStartPoint(caster)
	local endPoint = self:GetBreathEndPoint(startPoint, forward)
	self:FireBreathProjectileFrom(caster, token, startPoint, forward, endPoint)
	self:ApplyBreathRecoil(caster)
end
function boss_brewmaster_2.prototype.FireFinalBreathFan(self, caster, token)
	local startPoint = self:GetBreathStartPoint(caster)
	for ____, angle in ipairs(BOSS_BREWMASTER_2_FINAL_BREATH_ANGLES) do
		local currentAngle = angle
		local forward = RotateVector2D(nil, caster:GetForwardVector(), currentAngle):Normalized()
		self:FireBreathProjectileFrom(caster, token, startPoint, forward, self:GetBreathEndPoint(startPoint, forward))
	end
	self:ApplyBreathRecoil(caster)
end
function boss_brewmaster_2.prototype.ApplyBreathRecoil(self, caster)
	if not IsValidAlive(nil, caster) then
		return
	end
	caster:Mover(
		caster:GetAbsOrigin():__add(caster:GetForwardVector():__mul(-BOSS_BREWMASTER_2_RECOIL_DISTANCE)),
		BOSS_BREWMASTER_2_RECOIL_DURATION
	)
end
function boss_brewmaster_2.prototype.FireBreathProjectileFrom(self, caster, token, startPoint, forward, endPoint)
	local targetPoint = endPoint or self:GetBreathEndPoint(startPoint, forward)
	CreateProjectile(nil, {
		ability = self,
		caster = caster,
		effect_name = BOSS_BREWMASTER_2_BREATH_EFFECT,
		projectile_type = "linear",
		start_point = startPoint,
		target = targetPoint,
		projectile_speed = BOSS_BREWMASTER_2_BREATH_PROJECTILE_SPEED,
		projectile_distance = BOSS_BREWMASTER_2_BREATH_PROJECTILE_DISTANCE,
		projectile_range = BOSS_BREWMASTER_2_BREATH_PROJECTILE_WIDTH,
		projectile_target_team = DOTA_UNIT_TARGET_TEAM_ENEMY,
		projectile_target_type = DOTA_UNIT_TARGET_HEROES_AND_CREEPS,
		projectile_target_flags = DOTA_UNIT_TARGET_FLAG_NONE,
		on_hit = function(____, hitTarget)
			if hitTarget and IsValidAlive(nil, hitTarget) then
				if not IsValidAlive(nil, caster) or token ~= self.breathToken then
					return true
				end
				caster:MonsterDamage({
					victim = hitTarget,
					damage_rate = BOSS_BREWMASTER_2_BREATH_DAMAGE_RATE,
					ability = self,
				})
				AddDeBuffStatus(
					nil,
					hitTarget,
					caster,
					self,
					DebuffStatusType.BURN,
					{ duration = BOSS_BREWMASTER_2_BURN_DURATION }
				)
				return false
			end
			return true
		end,
	})
end
function boss_brewmaster_2.prototype.GetRandomIllusionOrigin(self, caster)
	local distance =
		RandomFloat(BOSS_BREWMASTER_2_ILLUSION_RANDOM_MIN_DISTANCE, BOSS_BREWMASTER_2_ILLUSION_RANDOM_MAX_DISTANCE)
	local position = caster:GetAbsOrigin():__add(RandomVector(distance))
	return GetGroundPosition(position, caster)
end
function boss_brewmaster_2.prototype.GetBreathStartPoint(self, caster)
	return caster:GetAbsOrigin():__add(Vector(0, 0, 96)):__add(caster:GetForwardVector())
end
function boss_brewmaster_2.prototype.GetIllusionBreathStartPoint(self, origin, forward)
	return origin:__add(Vector(0, 0, 96)):__add(forward:__mul(80))
end
function boss_brewmaster_2.prototype.GetBreathEndPoint(self, startPoint, forward)
	return startPoint:__add(forward:__mul(BOSS_BREWMASTER_2_BREATH_PROJECTILE_DISTANCE))
end
function boss_brewmaster_2.prototype.InterruptBreathSequence(self)
	self.breathToken = self.breathToken + 1
	self:FinishBreathSequence()
end
function boss_brewmaster_2.prototype.FinishBreathSequence(self)
	local caster = self:GetCaster()
	if not IsValid(nil, caster) then
		return
	end
	caster:FadeGesture(ACT_DOTA_OVERRIDE_ABILITY_4)
	caster:FadeGesture(ACT_DOTA_CAST_ABILITY_2)
	caster:RemoveModifierByName("modifier_boss_brewmaster_2_precast_activity")
	caster:RemoveModifierByName("modifier_boss_brewmaster_2_face_nearest")
end
boss_brewmaster_2 = __TS__DecorateLegacy({ registerAbility(nil) }, boss_brewmaster_2)
____exports.boss_brewmaster_2 = boss_brewmaster_2
modifier_boss_brewmaster_2_precast_activity = __TS__Class()
modifier_boss_brewmaster_2_precast_activity.name = "modifier_boss_brewmaster_2_precast_activity"
__TS__ClassExtends(modifier_boss_brewmaster_2_precast_activity, BaseModifier_CS)
function modifier_boss_brewmaster_2_precast_activity.prototype.DeclareFunctions(self)
	return { MODIFIER_PROPERTY_TRANSLATE_ACTIVITY_MODIFIERS }
end
function modifier_boss_brewmaster_2_precast_activity.prototype.GetActivityTranslationModifiers(self)
	return "self"
end
function modifier_boss_brewmaster_2_precast_activity.prototype.IsHidden(self)
	return true
end
function modifier_boss_brewmaster_2_precast_activity.prototype.IsPurgable(self)
	return false
end
modifier_boss_brewmaster_2_precast_activity =
	__TS__DecorateLegacy({ registerModifier(nil) }, modifier_boss_brewmaster_2_precast_activity)
modifier_boss_brewmaster_2_face_nearest = __TS__Class()
modifier_boss_brewmaster_2_face_nearest.name = "modifier_boss_brewmaster_2_face_nearest"
__TS__ClassExtends(modifier_boss_brewmaster_2_face_nearest, BaseModifier_CS)
function modifier_boss_brewmaster_2_face_nearest.prototype.OnCreated(self)
	if not IsServer() then
		return
	end
	self:StartIntervalThink(BOSS_BREWMASTER_2_FACE_INTERVAL)
	self:OnIntervalThink()
end
function modifier_boss_brewmaster_2_face_nearest.prototype.OnIntervalThink(self)
	if not IsServer() then
		return
	end
	local caster = self:GetCaster()
	if not IsValidAlive(nil, caster) then
		self:Destroy()
		return
	end
	local target = caster:GetMinDistanceUnit(BOSS_BREWMASTER_2_FACE_SEARCH_RANGE)
	if IsValidAlive(nil, target) then
		caster:LockTargetForSpeed(target, BOSS_BREWMASTER_2_FACE_INTERVAL, BOSS_BREWMASTER_2_FACE_TURN_SPEED)
	end
end
function modifier_boss_brewmaster_2_face_nearest.prototype.OnDestroy(self)
	if not IsServer() then
		return
	end
	self:StartIntervalThink(-1)
end
function modifier_boss_brewmaster_2_face_nearest.prototype.IsHidden(self)
	return true
end
function modifier_boss_brewmaster_2_face_nearest.prototype.IsPurgable(self)
	return false
end
modifier_boss_brewmaster_2_face_nearest =
	__TS__DecorateLegacy({ registerModifier(nil) }, modifier_boss_brewmaster_2_face_nearest)
return ____exports