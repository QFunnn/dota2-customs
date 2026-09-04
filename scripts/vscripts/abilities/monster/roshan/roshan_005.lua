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
local __TS__ArrayIndexOf = ____lualib.__TS__ArrayIndexOf
local ____exports = {}
local ____dota_ts_adapter = require("utils.dota_ts_adapter")
local registerAbility = ____dota_ts_adapter.registerAbility
local registerModifier = ____dota_ts_adapter.registerModifier
local ____monster_base = require("abilities.monster.monster_base")
local MonsterAbility_CS = ____monster_base.MonsterAbility_CS
local ____modifier_base = require("modifiers.class.modifier_base")
local BaseModifier_CS = ____modifier_base.BaseModifier_CS
local CAST_POINT = 2
local COOLDOWN = 5
local TARGET_SEARCH_RANGE = 1500
local CHARGE_WARNING_DISTANCE = 1500
local CHARGE_HIT_RADIUS = 260
local CHARGE_DURATION = 0.441
local CHARGE_SPEED = 2500
local CHARGE_STUN_DURATION = 1.5
local CHARGE_KNOCKBACK_DISTANCE = 250
local CHARGE_STOP_AFTER_HIT_DELAY = 0.1
local CHARGE_BLOCK_STUN_DURATION = 0.25
local CHARGEUP_SLAM_COUNT = 2
local CHARGEUP_SLAM_START_DELAY = 0.45
local CHARGEUP_SLAM_INTERVAL = 0.75
local SLAM_RADIUS = 460
local FINAL_SLAM_DAMAGE_RATE = 24
local FINAL_SLAM_STUN_DURATION = 0.6
local FINAL_SLAM_WINDUP_LEAD_TIME = 0.18
local FINAL_SLAM_EFFECT_DELAY = 0.55
local CAST_DURATION = CHARGE_DURATION + FINAL_SLAM_EFFECT_DELAY + 0.15
local SCREEN_SHAKE_RADIUS = 1800
local CHARGEUP_PARTICLE = "particles/units/heroes/hero_primal_beast/primal_beast_onslaught_chargeup.vpcf"
local CHARGE_ACTIVE_PARTICLE = "particles/units/heroes/hero_primal_beast/primal_beast_onslaught_charge_active.vpcf"
local CHARGE_IMPACT_PARTICLE = "particles/units/heroes/hero_primal_beast/primal_beast_onslaught_impact.vpcf"
local SLAM_PARTICLE = "particles/units/heroes/hero_centaur/centaur_warstomp.vpcf"
local SLAM_RING_PARTICLE = "particles/neutral_fx/ursa_thunderclap.vpcf"
local CHARGEUP_SOUND = "Hero_PrimalBeast.Onslaught.Channel"
local CHARGE_SOUND = "Hero_PrimalBeast.Onslaught.Cast"
local SLAM_SOUND = "Roshan.Slam"
local IMPACT_SOUND = "Hero_Spirit_Breaker.GreaterBash"
____exports.roshan_005 = __TS__Class()
local roshan_005 = ____exports.roshan_005
roshan_005.name = "roshan_005"
__TS__ClassExtends(roshan_005, MonsterAbility_CS)
function roshan_005.prototype.____constructor(self, ...)
	MonsterAbility_CS.prototype.____constructor(self, ...)
	self.sequence = 0
end
function roshan_005.prototype.Precache(self, context)
	PrecacheResource("particle", CHARGEUP_PARTICLE, context)
	PrecacheResource("particle", CHARGE_ACTIVE_PARTICLE, context)
	PrecacheResource("particle", CHARGE_IMPACT_PARTICLE, context)
	PrecacheResource("particle", SLAM_PARTICLE, context)
	PrecacheResource("particle", SLAM_RING_PARTICLE, context)
end
function roshan_005.prototype.GetCooldown(self, _level)
	return COOLDOWN
end
function roshan_005.prototype.GetMosnterAbilityConfig(self)
	return {
		castRange = TARGET_SEARCH_RANGE,
		behavior = DOTA_ABILITY_BEHAVIOR_NO_TARGET,
		castPoint = CAST_POINT,
		castDuration = CAST_DURATION,
		castAnimation = "",
		isNotMove = true,
		castColor = Vector(255, 80, 60),
		OnPhaseStart = function()
			return self:PrepareCharge()
		end,
		OnStart = function()
			return self:StartChargeAfterWindup()
		end,
		OnInterrupt = function()
			return self:CleanupSequence()
		end,
		OnFinish = function()
			return self:CleanupSequence()
		end,
	}
end
function roshan_005.prototype.PrepareCharge(self)
	local caster = self:GetCaster()
	if not IsValidAlive(nil, caster) then
		return
	end
	self.sequence = self.sequence + 1
	local currentSequence = self.sequence
	local target = caster:GetMinDistanceUnit(TARGET_SEARCH_RANGE)
	local direction = self:ResolveChargeDirection(caster, target)
	self.chargeDirection = direction
	caster:SetForwardVectorWithoutInterrupt(direction)
	if IsValidAlive(nil, target) then
		caster:LockTargetForSpeed(target, CAST_POINT, 4)
	end
	caster:AddNewModifier(caster, self, "modifier_roshan_005_chargeup", { duration = CAST_POINT })
	self:WarningEffect(
		caster:GetAbsOrigin(),
		self:GroundLineEnd(caster:GetAbsOrigin(), direction, caster),
		CAST_POINT,
		{
			startWidth = CHARGE_HIT_RADIUS,
			endWidth = CHARGE_HIT_RADIUS,
			follow = true,
			getStartPosition = function()
				local ____IsValidAlive_result_0
				if IsValidAlive(nil, caster) then
					____IsValidAlive_result_0 = caster:GetAbsOrigin()
				else
					____IsValidAlive_result_0 = nil
				end
				return ____IsValidAlive_result_0
			end,
			getDirection = function()
				local ____IsValidAlive_result_1
				if IsValidAlive(nil, caster) then
					____IsValidAlive_result_1 = self:FlatDirection(caster:GetForwardVector())
				else
					____IsValidAlive_result_1 = nil
				end
				return ____IsValidAlive_result_1
			end,
		}
	)
	self:ScheduleChargeupSlams(currentSequence)
end
function roshan_005.prototype.ScheduleChargeupSlams(self, sequence)
	do
		local index = 0
		while index < CHARGEUP_SLAM_COUNT do
			local currentIndex = index
			local currentDelay = CHARGEUP_SLAM_START_DELAY + currentIndex * CHARGEUP_SLAM_INTERVAL
			self:Timer(currentDelay, function()
				return self:PerformChargeupSlam(sequence, currentIndex)
			end)
			index = index + 1
		end
	end
end
function roshan_005.prototype.StartChargeAfterWindup(self)
	local caster = self:GetCaster()
	if not IsValidAlive(nil, caster) then
		return
	end
	local currentSequence = self.sequence
	local direction = self:FlatDirection(caster:GetForwardVector())
	self.chargeDirection = direction
	caster:SetForwardVectorWithoutInterrupt(direction)
	caster:RemoveModifierByName("modifier_roshan_005_chargeup")
	self:StartCharge(currentSequence)
end
function roshan_005.prototype.PerformChargeupSlam(self, sequence, index)
	local caster = self:GetCaster()
	if sequence ~= self.sequence or not IsValidAlive(nil, caster) then
		return
	end
	caster:StartGestureWithPlaybackRate(ACT_DOTA_CAST_ABILITY_3, 1.25)
	local direction = self:FlatDirection(caster:GetForwardVector())
	self.chargeDirection = direction
	caster:SetForwardVectorWithoutInterrupt(direction)
	local center = GetGroundPosition(caster:GetAbsOrigin(), caster)
	self:PlaySlamEffect(caster, center, index)
end
function roshan_005.prototype.StartCharge(self, sequence)
	local caster = self:GetCaster()
	if sequence ~= self.sequence or not IsValidAlive(nil, caster) then
		return
	end
	local direction = self.chargeDirection or self:FlatDirection(caster:GetForwardVector())
	caster:SetForwardVectorWithoutInterrupt(direction)
	caster:AddNewModifier(
		caster,
		self,
		"modifier_roshan_005_charge",
		{ duration = CHARGE_DURATION, direction_x = direction.x, direction_y = direction.y, direction_z = direction.z }
	)
end
function roshan_005.prototype.PerformFinalSlam(self, caster, isWindupStarted, chargeParticle, shouldStopChargeSound)
	if isWindupStarted == nil then
		isWindupStarted = false
	end
	if shouldStopChargeSound == nil then
		shouldStopChargeSound = false
	end
	if not IsValidAlive(nil, caster) then
		return
	end
	local center = GetGroundPosition(caster:GetAbsOrigin(), caster)
	if not isWindupStarted then
		caster:StartGestureWithPlaybackRate(ACT_DOTA_CAST_ABILITY_3, 1)
	end
	self:WarningRingEffect(center, SLAM_RADIUS, 0.65)
	self:Timer(FINAL_SLAM_EFFECT_DELAY + 0.05, function()
		if IsValidAlive(nil, caster) then
			self:PlaySlamEffect(caster, center, CHARGEUP_SLAM_COUNT)
			self:DamageFinalSlamEnemies(caster, center)
		end
		self:StopChargePresentation(caster, chargeParticle, shouldStopChargeSound)
	end)
end
function roshan_005.prototype.StopChargePresentation(self, caster, chargeParticle, shouldStopChargeSound)
	if shouldStopChargeSound == nil then
		shouldStopChargeSound = false
	end
	if shouldStopChargeSound and IsValid(nil, caster) and not caster:IsNull() then
		caster:StopSound(CHARGE_SOUND)
	end
	if chargeParticle == nil then
		return
	end
	ParticleManager:DestroyParticle(chargeParticle, false)
	ParticleManager:ReleaseParticleIndex(chargeParticle)
end
function roshan_005.prototype.DamageFinalSlamEnemies(self, caster, center)
	local enemies = FindUnitsInRadius(
		caster:GetTeamNumber(),
		center,
		nil,
		SLAM_RADIUS,
		DOTA_UNIT_TARGET_TEAM_ENEMY,
		DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC + DOTA_UNIT_TARGET_BUILDING,
		DOTA_UNIT_TARGET_FLAG_NONE,
		FIND_ANY_ORDER,
		false
	)
	for ____, enemy in ipairs(enemies) do
		do
			if not IsValidAlive(nil, enemy) then
				goto __continue32
			end
			caster:MonsterDamage({ victim = enemy, damage_rate = FINAL_SLAM_DAMAGE_RATE, ability = self })
			AddDeBuffStatus(nil, enemy, caster, self, DebuffStatusType.STUN, { duration = FINAL_SLAM_STUN_DURATION })
		end
		::__continue32::
	end
end
function roshan_005.prototype.PlaySlamEffect(self, caster, center, index)
	EmitSoundOnLocationWithCaster(center, SLAM_SOUND, caster)
	ScreenShake(center, 8 + index * 2, 10, 0.25, SCREEN_SHAKE_RADIUS, 0, true)
	local stomp = ParticleManager:CreateParticle(SLAM_PARTICLE, PATTACH_WORLDORIGIN, caster)
	ParticleManager:SetParticleControl(stomp, 0, center)
	ParticleManager:SetParticleControl(stomp, 1, Vector(SLAM_RADIUS, 0, 0))
	ParticleManager:ReleaseParticleIndex(stomp)
	local ring = ParticleManager:CreateParticle(SLAM_RING_PARTICLE, PATTACH_WORLDORIGIN, caster)
	ParticleManager:SetParticleControl(ring, 0, center)
	ParticleManager:SetParticleControl(ring, 1, Vector(SLAM_RADIUS, SLAM_RADIUS, SLAM_RADIUS))
	ParticleManager:ReleaseParticleIndex(ring)
end
function roshan_005.prototype.ResolveChargeDirection(self, caster, target)
	if IsValidAlive(nil, target) then
		local direction = GetDirection(nil, target:GetAbsOrigin(), caster:GetAbsOrigin())
		if direction:Length2D() > 0.01 then
			return direction
		end
	end
	return self:FlatDirection(caster:GetForwardVector())
end
function roshan_005.prototype.GroundLineEnd(self, origin, direction, caster)
	local ____end = origin:__add(self:FlatDirection(direction):__mul(CHARGE_WARNING_DISTANCE))
	return GetGroundPosition(____end, caster)
end
function roshan_005.prototype.FlatDirection(self, direction)
	local flat = Vector(direction.x, direction.y, 0)
	local ____temp_2
	if flat:Length2D() > 0.01 then
		____temp_2 = flat:Normalized()
	else
		____temp_2 = Vector(1, 0, 0)
	end
	return ____temp_2
end
function roshan_005.prototype.CleanupSequence(self)
	self.sequence = self.sequence + 1
	self.chargeDirection = nil
	local caster = self:GetCaster()
	if not IsValidAlive(nil, caster) then
		return
	end
	caster:RemoveModifierByName("modifier_roshan_005_chargeup")
	caster:RemoveModifierByName("modifier_roshan_005_charge")
	caster:StopSound(CHARGEUP_SOUND)
	caster:StopSound(CHARGE_SOUND)
end
roshan_005 = __TS__DecorateLegacy({ registerAbility(nil) }, roshan_005)
____exports.roshan_005 = roshan_005
local modifier_roshan_005_chargeup = __TS__Class()
modifier_roshan_005_chargeup.name = "modifier_roshan_005_chargeup"
__TS__ClassExtends(modifier_roshan_005_chargeup, BaseModifier_CS)
function modifier_roshan_005_chargeup.prototype.IsHidden(self)
	return true
end
function modifier_roshan_005_chargeup.prototype.IsPurgable(self)
	return false
end
function modifier_roshan_005_chargeup.prototype.OnCreated(self)
	if not IsServer() then
		return
	end
	local parent = self:GetParent()
	EmitSoundOn(CHARGEUP_SOUND, parent)
	local particle = ParticleManager:CreateParticle(CHARGEUP_PARTICLE, PATTACH_ABSORIGIN_FOLLOW, parent)
	ParticleManager:SetParticleShouldCheckFoW(particle, false)
	self:AddParticle(particle, false, false, -1, false, false)
end
function modifier_roshan_005_chargeup.prototype.OnDestroy(self)
	if not IsServer() then
		return
	end
	self:GetParent():StopSound(CHARGEUP_SOUND)
end
function modifier_roshan_005_chargeup.prototype.DeclareFunctions(self)
	return {
		MODIFIER_PROPERTY_DISABLE_TURNING,
		MODIFIER_PROPERTY_IGNORE_CAST_ANGLE,
		MODIFIER_PROPERTY_OVERRIDE_ANIMATION,
		MODIFIER_PROPERTY_OVERRIDE_ANIMATION_RATE,
	}
end
function modifier_roshan_005_chargeup.prototype.GetOverrideAnimation(self)
	return ACT_DOTA_RUN
end
function modifier_roshan_005_chargeup.prototype.GetOverrideAnimationRate(self)
	return 1.35
end
function modifier_roshan_005_chargeup.prototype.GetModifierIgnoreCastAngle(self)
	return 1
end
function modifier_roshan_005_chargeup.prototype.GetModifierDisableTurning(self)
	return 1
end
function modifier_roshan_005_chargeup.prototype.CheckState(self)
	return { [MODIFIER_STATE_DISARMED] = true }
end
modifier_roshan_005_chargeup = __TS__DecorateLegacy({ registerModifier(nil) }, modifier_roshan_005_chargeup)
local modifier_roshan_005_charge = __TS__Class()
modifier_roshan_005_charge.name = "modifier_roshan_005_charge"
__TS__ClassExtends(modifier_roshan_005_charge, BaseModifier_CS)
function modifier_roshan_005_charge.prototype.____constructor(self, ...)
	BaseModifier_CS.prototype.____constructor(self, ...)
	self.isBlocked = false
	self.shouldFinalSlam = false
	self.finalSlamDone = false
end
function modifier_roshan_005_charge.prototype.IsHidden(self)
	return true
end
function modifier_roshan_005_charge.prototype.IsPurgable(self)
	return false
end
function modifier_roshan_005_charge.prototype.OnCreated(self, params)
	if not IsServer() then
		return
	end
	local parent = self:GetParent()
	local rawDirection = Vector(
		params.direction_x or parent:GetForwardVector().x,
		params.direction_y or parent:GetForwardVector().y,
		params.direction_z or 0
	)
	self.direction = self:FlatDirection(rawDirection)
	self.hitTargetIndexes = {}
	self.chargeParticle = nil
	self.stopAfterHitRemaining = nil
	self.shouldFinalSlam = false
	self.finalSlamDone = false
	parent:SetForwardVectorWithoutInterrupt(self.direction)
	EmitSoundOn(CHARGE_SOUND, parent)
	self.chargeParticle = ParticleManager:CreateParticle(CHARGE_ACTIVE_PARTICLE, PATTACH_ABSORIGIN_FOLLOW, parent)
	ParticleManager:SetParticleShouldCheckFoW(self.chargeParticle, false)
	ScreenShake(parent:GetAbsOrigin(), 8, 10, CHARGE_DURATION, SCREEN_SHAKE_RADIUS, 0, true)
	self:StartIntervalThink(FrameTime())
end
function modifier_roshan_005_charge.prototype.OnIntervalThink(self)
	if not IsServer() then
		return
	end
	local parent = self:GetParent()
	if not IsValidAlive(nil, parent) or self.direction == nil then
		self:Destroy()
		return
	end
	if self:UpdateStopAfterHit() then
		return
	end
	self:TryStartFinalSlamWindup(parent)
	local current = parent:GetAbsOrigin()
	local rawNext = current:__add(self.direction:__mul(CHARGE_SPEED * FrameTime()))
	local next = GetGroundPosition(rawNext, parent)
	GridNav:DestroyTreesAroundPoint(next, CHARGE_HIT_RADIUS, false)
	if GridNav:IsBlocked(next) or not GridNav:IsTraversable(next) then
		self.isBlocked = true
		self:Destroy()
		parent:AddNewModifier(parent, self:GetAbility(), "modifier_stunned", { duration = CHARGE_BLOCK_STUN_DURATION })
		return
	end
	parent:SetAbsOrigin(next)
	parent:SetForwardVectorWithoutInterrupt(self.direction)
	self:HitEnemies(parent)
	self:TryStartFinalSlamWindup(parent)
end
function modifier_roshan_005_charge.prototype.OnDestroy(self)
	if not IsServer() then
		return
	end
	local parent = self:GetParent()
	if not IsValid(nil, parent) or parent:IsNull() then
		self:StopChargePresentation()
		return
	end
	FindClearSpaceForUnit(parent, parent:GetAbsOrigin(), true)
	local finalSlamStarted = self:TryFinalSlamOnEnd(parent)
	if not finalSlamStarted then
		self:StopChargePresentation(parent)
	end
	if self.isBlocked and self.direction ~= nil then
		local backPoint = GetGroundPosition(parent:GetAbsOrigin():__sub(self.direction:__mul(120)), parent)
		parent:Mover(backPoint, CHARGE_BLOCK_STUN_DURATION)
	end
end
function modifier_roshan_005_charge.prototype.TryFinalSlamOnEnd(self, parent)
	if not IsValidAlive(nil, parent) then
		return false
	end
	if self.finalSlamDone or self.isBlocked then
		return false
	end
	if not self.shouldFinalSlam and self:GetRemainingTime() > FrameTime() + 0.03 then
		return false
	end
	self.finalSlamDone = true
	local ability = self:GetAbility()
	if ability == nil or not IsValid(nil, ability) then
		return false
	end
	local chargeParticle = self.chargeParticle
	self.chargeParticle = nil
	ability:PerformFinalSlam(parent, self:GetStackCount() > 0, chargeParticle, true)
	return true
end
function modifier_roshan_005_charge.prototype.StopChargePresentation(self, parent)
	if parent ~= nil and IsValid(nil, parent) and not parent:IsNull() then
		parent:StopSound(CHARGE_SOUND)
	end
	if self.chargeParticle == nil then
		return
	end
	ParticleManager:DestroyParticle(self.chargeParticle, false)
	ParticleManager:ReleaseParticleIndex(self.chargeParticle)
	self.chargeParticle = nil
end
function modifier_roshan_005_charge.prototype.UpdateStopAfterHit(self)
	if self.stopAfterHitRemaining == nil then
		return false
	end
	self.stopAfterHitRemaining = self.stopAfterHitRemaining - FrameTime()
	if self.stopAfterHitRemaining > 0 then
		return false
	end
	self.shouldFinalSlam = true
	self:Destroy()
	return true
end
function modifier_roshan_005_charge.prototype.TryStartFinalSlamWindup(self, parent)
	if self:GetStackCount() > 0 then
		return
	end
	local isHitStopEnding = self.stopAfterHitRemaining ~= nil
		and self.stopAfterHitRemaining <= FINAL_SLAM_WINDUP_LEAD_TIME
	local isChargeEnding = self:GetRemainingTime() <= FINAL_SLAM_WINDUP_LEAD_TIME
	if not isHitStopEnding and not isChargeEnding then
		return
	end
	if not IsValidAlive(nil, parent) then
		return
	end
	self:SetStackCount(1)
	parent:StartGestureWithPlaybackRate(ACT_DOTA_CAST_ABILITY_3, 1)
end
function modifier_roshan_005_charge.prototype.HitEnemies(self, parent)
	local ability = self:GetAbility()
	if ability == nil or self.hitTargetIndexes == nil then
		return
	end
	if not IsValidAlive(nil, parent) then
		return
	end
	local enemies = FindUnitsInRadius(
		parent:GetTeamNumber(),
		parent:GetAbsOrigin(),
		nil,
		CHARGE_HIT_RADIUS,
		DOTA_UNIT_TARGET_TEAM_ENEMY,
		DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC + DOTA_UNIT_TARGET_BUILDING,
		DOTA_UNIT_TARGET_FLAG_NONE,
		FIND_ANY_ORDER,
		false
	)
	for ____, enemy in ipairs(enemies) do
		do
			if not IsValidAlive(nil, enemy) then
				goto __continue87
			end
			local entityIndex = enemy:entindex()
			if __TS__ArrayIndexOf(self.hitTargetIndexes, entityIndex) >= 0 then
				goto __continue87
			end
			local ____self_hitTargetIndexes_3 = self.hitTargetIndexes
			____self_hitTargetIndexes_3[#____self_hitTargetIndexes_3 + 1] = entityIndex
			if self.stopAfterHitRemaining == nil then
				self.stopAfterHitRemaining = CHARGE_STOP_AFTER_HIT_DELAY
			end
			self:PlayImpactEffect(enemy)
			enemy:KnockBack(parent, ability, {
				direction = self.direction,
				duration = 0.25,
				stunDuration = CHARGE_STUN_DURATION,
				stun = true,
				distance = CHARGE_KNOCKBACK_DISTANCE,
				height = 60,
				uniform = true,
			})
		end
		::__continue87::
	end
end
function modifier_roshan_005_charge.prototype.PlayImpactEffect(self, target)
	if not IsValidAlive(nil, target) then
		return
	end
	EmitSoundOn(IMPACT_SOUND, target)
	local particle = ParticleManager:CreateParticle(CHARGE_IMPACT_PARTICLE, PATTACH_WORLDORIGIN, target)
	ParticleManager:SetParticleControl(particle, 0, target:GetAbsOrigin())
	ParticleManager:SetParticleControl(particle, 1, Vector(120, 0, 0))
	ParticleManager:ReleaseParticleIndex(particle)
end
function modifier_roshan_005_charge.prototype.FlatDirection(self, direction)
	local flat = Vector(direction.x, direction.y, 0)
	local ____temp_4
	if flat:Length2D() > 0.01 then
		____temp_4 = flat:Normalized()
	else
		____temp_4 = Vector(1, 0, 0)
	end
	return ____temp_4
end
function modifier_roshan_005_charge.prototype.DeclareFunctions(self)
	return {
		MODIFIER_PROPERTY_DISABLE_TURNING,
		MODIFIER_PROPERTY_IGNORE_CAST_ANGLE,
		MODIFIER_PROPERTY_OVERRIDE_ANIMATION,
		MODIFIER_PROPERTY_OVERRIDE_ANIMATION_RATE,
	}
end
function modifier_roshan_005_charge.prototype.GetOverrideAnimation(self)
	local ____temp_5
	if self:GetStackCount() > 0 then
		____temp_5 = ACT_DOTA_CAST_ABILITY_3
	else
		____temp_5 = ACT_DOTA_RUN
	end
	return ____temp_5
end
function modifier_roshan_005_charge.prototype.GetOverrideAnimationRate(self)
	return self:GetStackCount() > 0 and 1 or 2
end
function modifier_roshan_005_charge.prototype.GetModifierIgnoreCastAngle(self)
	return 1
end
function modifier_roshan_005_charge.prototype.GetModifierDisableTurning(self)
	return 1
end
function modifier_roshan_005_charge.prototype.CheckState(self)
	return { [MODIFIER_STATE_DISARMED] = true, [MODIFIER_STATE_NO_UNIT_COLLISION] = true }
end
modifier_roshan_005_charge = __TS__DecorateLegacy({ registerModifier(nil) }, modifier_roshan_005_charge)
return ____exports