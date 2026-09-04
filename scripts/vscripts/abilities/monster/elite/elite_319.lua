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
local modifier_elite_319_dodge_fx
local ____dota_ts_adapter = require("utils.dota_ts_adapter")
local registerAbility = ____dota_ts_adapter.registerAbility
local registerModifier = ____dota_ts_adapter.registerModifier
local ____monster_base = require("abilities.monster.monster_base")
local MonsterAbility_CS = ____monster_base.MonsterAbility_CS
local MonsterModifier_CS = ____monster_base.MonsterModifier_CS
local TRIGGER_CHANCE_PCT = 20
local TRIGGER_COOLDOWN = 8
local DODGE_MIN_PLAYER_DISTANCE = 400
local DODGE_MAX_PLAYER_DISTANCE = 600
local DODGE_PREFERRED_PLAYER_DISTANCE = 700
local DODGE_CANDIDATE_DISTANCES =
	{ DODGE_PREFERRED_PLAYER_DISTANCE, DODGE_MAX_PLAYER_DISTANCE, DODGE_MIN_PLAYER_DISTANCE }
local DODGE_CANDIDATE_ANGLE_OFFSETS = {
	0,
	20,
	-20,
	40,
	-40,
	60,
	-60,
	90,
	-90,
	120,
	-120,
	160,
	-160,
	180,
}
local DODGE_DURATION = 0.28
local DODGE_JUMP_HEIGHT = 180
local DODGE_PATH_CHECK_STEP = 96
local PUNCH_PROJECTILE_COUNT = 3
local PUNCH_PROJECTILE_ANGLE_STEP = 12
local PUNCH_PROJECTILE_DISTANCE = 1700
local PUNCH_PROJECTILE_WIDTH = 120
local PUNCH_PROJECTILE_SPEED = 1200
local PUNCH_DAMAGE_RATE = 25
local PUNCH_START_FORWARD_OFFSET = 120
local PUNCH_ATTACK_PLAYBACK_RATE = 0.8
local PUNCH_BARRAGE_DELAY = 0.8
local PUNCH_WARNING_DISTANCE = PUNCH_START_FORWARD_OFFSET + PUNCH_PROJECTILE_DISTANCE
local PUNCH_WARNING_HALF_ANGLE = (PUNCH_PROJECTILE_COUNT - 1) / 2 * PUNCH_PROJECTILE_ANGLE_STEP
local PUNCH_WARNING_START_WIDTH = PUNCH_PROJECTILE_WIDTH * 2
local PUNCH_SCREEN_SHAKE_AMPLITUDE = 10
local PUNCH_SCREEN_SHAKE_FREQUENCY = 12
local PUNCH_SCREEN_SHAKE_DURATION = 0.15
local PUNCH_SCREEN_SHAKE_RADIUS = 1600
local DODGE_PARTICLE = "particles/queen_blink_start_2.vpcf"
local DODGE_STATUS_EFFECT = "particles/status_fx/status_effect_phantom_assassin_blur.vpcf"
local PUNCH_PROJECTILE_PARTICLE =
	"particles/econ/items/puck/puck_merry_wanderer/puck_illusory_orb_merry_wanderer_linear_projectile.vpcf"
local PUNCH_CAST_EFFECT_PARTICLE = "particles/bb/pun_dark_seer_attack_normal_punch.vpcf"
local PUNCH_HIT_PARTICLE = "particles/units/heroes/hero_dark_seer/dark_seer_wall_of_replica_replicate.vpcf"
local DODGE_SOUND = "Hero_NyxAssassin.Vendetta"
local PUNCH_SOUND = "Hero_Dark_Seer.NormalPunch.Lv1"
local PUNCH_HIT_SOUND = "Hero_Dark_Seer.Surge"
____exports.elite_319 = __TS__Class()
local elite_319 = ____exports.elite_319
elite_319.name = "elite_319"
__TS__ClassExtends(elite_319, MonsterAbility_CS)
function elite_319.prototype.Precache(self, context)
	PrecacheResource("particle", DODGE_PARTICLE, context)
	PrecacheResource("particle", DODGE_STATUS_EFFECT, context)
	PrecacheResource("particle", PUNCH_PROJECTILE_PARTICLE, context)
	PrecacheResource("particle", PUNCH_CAST_EFFECT_PARTICLE, context)
	PrecacheResource("particle", PUNCH_HIT_PARTICLE, context)
end
function elite_319.prototype.GetMosnterAbilityConfig(self)
	return { behavior = DOTA_ABILITY_BEHAVIOR_PASSIVE, castPoint = 0, castDuration = 0, cooldown = TRIGGER_COOLDOWN }
end
function elite_319.prototype.GetIntrinsicModifierName(self)
	return "modifier_elite_319_shadow_dodge"
end
elite_319 = __TS__DecorateLegacy({ registerAbility(nil) }, elite_319)
____exports.elite_319 = elite_319
local modifier_elite_319_shadow_dodge = __TS__Class()
modifier_elite_319_shadow_dodge.name = "modifier_elite_319_shadow_dodge"
__TS__ClassExtends(modifier_elite_319_shadow_dodge, MonsterModifier_CS)
function modifier_elite_319_shadow_dodge.prototype.____constructor(self, ...)
	MonsterModifier_CS.prototype.____constructor(self, ...)
	self.dodgeToken = 0
	self.completedDodgeToken = 0
end
function modifier_elite_319_shadow_dodge.prototype.DeclareEvents(self)
	return { BusinessEvents.ON_DAMAGE_PRE_APPLY }
end
function modifier_elite_319_shadow_dodge.prototype.OnDamagePreApply_CS(self, event)
	if not IsServer() then
		return
	end
	local parent = self:GetParent()
	local ability = self:GetAbility()
	if not ability or not IsValidAlive(nil, parent) then
		return
	end
	if event.ctx.spec.victim ~= parent then
		return
	end
	if event.prevent_apply then
		return
	end
	if not IsValidAlive(nil, event.ctx.spec.attacker) then
		return
	end
	if event.ctx.spec.attacker == parent then
		return
	end
	local ____temp_2 = parent:IsStunned()
	if not ____temp_2 then
		local ____opt_0 = parent.IsMonsterCasting
		____temp_2 = (____opt_0 and ____opt_0(parent)) == true
	end
	if ____temp_2 then
		return
	end
	if CheckTag(nil, event.ctx.spec.damage_flag, ApplyDamageFlag.HP_LOSS) then
		return
	end
	if not event.ctx.spec.is_base_attack then
		return
	end
	if not ability:IsCooldownReady() then
		return
	end
	if self:GetCurrentPipeDamage(event.final) <= 0 then
		return
	end
	if RollPercentage(TRIGGER_CHANCE_PCT) ~= true then
		return
	end
	local attacker = event.ctx.spec.attacker
	local dodgeTarget = self:ResolveDodgeTarget(parent, attacker)
	if not dodgeTarget then
		return
	end
	local jumpOrigin = GetGroundPosition(parent:GetAbsOrigin(), parent)
	if not self:IsConnectedDodgeTarget(jumpOrigin, dodgeTarget) then
		return
	end
	event.prevent_apply = true
	ability:StartCooldown(TRIGGER_COOLDOWN)
	self:TriggerShadowDodge(parent, ability, attacker, dodgeTarget)
end
function modifier_elite_319_shadow_dodge.prototype.TriggerShadowDodge(self, parent, ability, attacker, dodgeTarget)
	local ____self_3, ____dodgeToken_4 = self, "dodgeToken"
	local ____self_dodgeToken_5 = ____self_3[____dodgeToken_4] + 1
	____self_3[____dodgeToken_4] = ____self_dodgeToken_5
	local dodgeToken = ____self_dodgeToken_5
	local punchForward = self:ResolvePunchForward(attacker, dodgeTarget)
	local origin = GetGroundPosition(parent:GetAbsOrigin(), parent)
	local peak = origin:__add(Vector(0, 0, DODGE_JUMP_HEIGHT))
	parent:SetForwardVectorWithoutInterrupt(punchForward)
	parent:AddNewModifier(parent, ability, "modifier_pause_actions", { duration = 1.5 })
	modifier_elite_319_dodge_fx:applys(parent, parent, ability, { duration = DODGE_DURATION })
	EmitSoundOn(DODGE_SOUND, parent)
	parent:Bezier2Mover({ origin, peak, dodgeTarget }, DODGE_DURATION, nil, false, false)
	local target = self:GetParent():GetMinDistanceUnit(3500)
	if IsValidAlive(nil, target) then
		parent:LockTargetForSpeed(target, 0.5, 10)
	end
	self:Timer(DODGE_DURATION, function()
		if not self:TryFinishShadowDodge(parent, ability, origin, dodgeTarget, punchForward, dodgeToken) then
			return
		end
		self.completedDodgeToken = dodgeToken
	end)
	self:Timer(DODGE_DURATION + PUNCH_BARRAGE_DELAY, function()
		if self.completedDodgeToken ~= dodgeToken then
			return
		end
		self:FireDelayedPunchBarrage(parent, ability, punchForward)
	end)
end
function modifier_elite_319_shadow_dodge.prototype.TryFinishShadowDodge(
	self,
	parent,
	ability,
	origin,
	dodgeTarget,
	forward,
	dodgeToken
)
	if dodgeToken ~= self.dodgeToken then
		return false
	end
	if not IsValidAlive(nil, parent) then
		return false
	end
	local arrivalPoint = GetGroundPosition(parent:GetAbsOrigin(), parent)
	if GetDistance(nil, arrivalPoint, dodgeTarget) > 64 then
		return false
	end
	if not self:IsConnectedDodgeTarget(origin, arrivalPoint) then
		return false
	end
	if not self:IsStraightDodgePathWalkable(parent, origin, arrivalPoint) then
		return false
	end
	FindClearSpaceForUnit(parent, dodgeTarget, true)
	if not IsValidAlive(nil, parent) then
		return false
	end
	local actualLandingPoint = GetGroundPosition(parent:GetAbsOrigin(), parent)
	if
		not self:IsConnectedDodgeTarget(origin, actualLandingPoint)
		or not self:IsStraightDodgePathWalkable(parent, origin, actualLandingPoint)
	then
		parent:SetAbsOrigin(arrivalPoint)
		return false
	end
	parent:SetForwardVectorWithoutInterrupt(self:FlatDirection(forward))
	parent:RemoveGesture(ACT_DOTA_ATTACK)
	parent:StartGestureWithPlaybackRate(ACT_DOTA_ATTACK, PUNCH_ATTACK_PLAYBACK_RATE)
	self:PlayPunchFanWarning(parent, ability, forward)
	return true
end
function modifier_elite_319_shadow_dodge.prototype.PlayPunchFanWarning(self, parent, ability, forward)
	if not IsValidAlive(nil, parent) then
		return
	end
	local origin = parent:GetAbsOrigin()
	local warningForward = self:FlatDirection(forward)
	local endPosition = origin:__add(warningForward:__mul(600))
	ability:WarningEffect(origin, endPosition, PUNCH_BARRAGE_DELAY, {
		startWidth = PUNCH_WARNING_START_WIDTH,
		endWidth = 400,
		getDirection = function()
			local ____IsValidAlive_result_6
			if IsValidAlive(nil, parent) then
				____IsValidAlive_result_6 = self:FlatDirection(parent:GetForwardVector())
			else
				____IsValidAlive_result_6 = nil
			end
			return ____IsValidAlive_result_6
		end,
		follow = true,
	})
end
function modifier_elite_319_shadow_dodge.prototype.FireDelayedPunchBarrage(self, parent, ability, forward)
	if not IsValidAlive(nil, parent) or not IsValid(nil, ability) or ability:IsNull() then
		return
	end
	parent:SetForwardVectorWithoutInterrupt(self:FlatDirection(forward))
	self:FirePunchBarrage(parent, ability, forward)
end
function modifier_elite_319_shadow_dodge.prototype.FirePunchBarrage(self, parent, ability, forward)
	local baseForward = self:FlatDirection(forward)
	if not IsValidAlive(nil, parent) then
		return
	end
	EmitSoundOn(PUNCH_SOUND, parent)
	self:PlayPunchScreenShake(parent:GetAbsOrigin())
	local halfCount = (PUNCH_PROJECTILE_COUNT - 1) / 2
	do
		local index = 0
		while index < PUNCH_PROJECTILE_COUNT do
			local currentIndex = index
			local currentAngle = (currentIndex - halfCount) * PUNCH_PROJECTILE_ANGLE_STEP
			local currentDirection = self:FlatDirection(RotateVector2D(nil, baseForward, currentAngle))
			local currentStart = GetGroundPosition(
				parent:GetAbsOrigin():__add(currentDirection:__mul(PUNCH_START_FORWARD_OFFSET)),
				parent
			)
			local currentEnd =
				GetGroundPosition(currentStart:__add(currentDirection:__mul(PUNCH_PROJECTILE_DISTANCE)), parent)
			self:PlayPunchCastEffect(currentStart, currentDirection, parent)
			CreateProjectile(nil, {
				ability = ability,
				caster = parent,
				effect_name = PUNCH_PROJECTILE_PARTICLE,
				projectile_type = "linear",
				start_point = currentStart,
				target = currentEnd,
				projectile_speed = PUNCH_PROJECTILE_SPEED,
				projectile_distance = PUNCH_PROJECTILE_DISTANCE,
				projectile_range = PUNCH_PROJECTILE_WIDTH,
				projectile_target_team = DOTA_UNIT_TARGET_TEAM_ENEMY,
				projectile_target_type = DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,
				projectile_target_flags = DOTA_UNIT_TARGET_FLAG_NONE,
				on_hit = function(____, hitTarget)
					if not hitTarget or not IsValidAlive(nil, hitTarget) then
						return true
					end
					if not IsValidAlive(nil, parent) then
						return
					end
					parent:MonsterDamage({
						victim = hitTarget,
						damage_rate = PUNCH_DAMAGE_RATE,
						ability = ability,
						effectName = PUNCH_HIT_PARTICLE,
					})
					hitTarget:KnockBack(parent, ability, {
						duration = 0.15,
						distance = 100,
						stun = true,
						stunDuration = 0.5,
						height = 0,
						direction = GetDirection(nil, hitTarget:GetAbsOrigin(), parent:GetAbsOrigin()),
					})
					EmitSoundOn(PUNCH_HIT_SOUND, hitTarget)
					return false
				end,
			})
			index = index + 1
		end
	end
end
function modifier_elite_319_shadow_dodge.prototype.ResolveDodgeTarget(self, parent, attacker)
	local parentOrigin = GetGroundPosition(parent:GetAbsOrigin(), parent)
	if not IsGridNavDisplacementWalkable(nil, parentOrigin) then
		return nil
	end
	local attackerOrigin = GetGroundPosition(attacker:GetAbsOrigin(), attacker)
	local baseDirection = self:ResolveDodgeDirection(parentOrigin, attackerOrigin)
	for ____, angleOffset in ipairs(DODGE_CANDIDATE_ANGLE_OFFSETS) do
		local currentDirection = self:FlatDirection(RotateVector2D(nil, baseDirection, angleOffset))
		for ____, distance in ipairs(DODGE_CANDIDATE_DISTANCES) do
			local point = self:TryBuildDodgeTarget(parent, attackerOrigin, currentDirection, distance)
			if point and self:IsValidDodgeTarget(attackerOrigin, point) then
				return point
			end
		end
	end
	return nil
end
function modifier_elite_319_shadow_dodge.prototype.ResolveDodgeDirection(self, parentOrigin, attackerOrigin)
	local direction = GetDirection(nil, parentOrigin, attackerOrigin)
	return self:FlatDirection(direction)
end
function modifier_elite_319_shadow_dodge.prototype.ResolvePunchForward(self, attacker, dodgeTarget)
	if not IsValidAlive(nil, attacker) then
		return self:FlatDirection(self:GetParent():GetForwardVector())
	end
	return self:FlatDirection(GetDirection(nil, attacker:GetAbsOrigin(), dodgeTarget))
end
function modifier_elite_319_shadow_dodge.prototype.TryBuildDodgeTarget(
	self,
	parent,
	attackerOrigin,
	direction,
	distance
)
	local parentOrigin = GetGroundPosition(parent:GetAbsOrigin(), parent)
	local rawTarget = attackerOrigin:__add(direction:__mul(distance))
	local target = GetGroundPosition(rawTarget, parent)
	if not IsGridNavDisplacementWalkable(nil, target) then
		return nil
	end
	if not self:IsConnectedDodgeTarget(parentOrigin, target) then
		return nil
	end
	if not self:IsStraightDodgePathWalkable(parent, parentOrigin, target) then
		return nil
	end
	return target
end
function modifier_elite_319_shadow_dodge.prototype.IsConnectedDodgeTarget(self, parentOrigin, target)
	if not IsGridNavDisplacementWalkable(nil, parentOrigin) then
		return false
	end
	if not IsGridNavDisplacementWalkable(nil, target) then
		return false
	end
	if not GridNav:CanFindPath(parentOrigin, target) then
		return false
	end
	if GridNav:FindPathLength(parentOrigin, target) == -1 then
		return false
	end
	return true
end
function modifier_elite_319_shadow_dodge.prototype.IsStraightDodgePathWalkable(self, parent, parentOrigin, target)
	local delta = target:__sub(parentOrigin)
	local distance = delta:Length2D()
	if distance <= 0.01 then
		return true
	end
	local stepCount = math.max(1, math.ceil(distance / DODGE_PATH_CHECK_STEP))
	do
		local index = 1
		while index <= stepCount do
			local currentIndex = index
			local ratio = currentIndex / stepCount
			local checkPoint = GetGroundPosition(parentOrigin:__add(delta:__mul(ratio)), parent)
			if not IsGridNavDisplacementWalkable(nil, checkPoint) then
				return false
			end
			index = index + 1
		end
	end
	return true
end
function modifier_elite_319_shadow_dodge.prototype.IsValidDodgeTarget(self, attackerOrigin, point)
	local distanceToAttacker = GetDistance(nil, attackerOrigin, point)
	return distanceToAttacker >= DODGE_MIN_PLAYER_DISTANCE and distanceToAttacker <= DODGE_MAX_PLAYER_DISTANCE
end
function modifier_elite_319_shadow_dodge.prototype.PlayPunchCastEffect(self, origin, forward, parent)
	local particle = ParticleManager:CreateParticle(PUNCH_CAST_EFFECT_PARTICLE, PATTACH_WORLDORIGIN, parent)
	ParticleManager:SetParticleControl(particle, 0, origin)
	ParticleManager:SetParticleControlForward(particle, 0, forward)
	ParticleManager:SetParticleControlTransformForward(particle, 0, origin, forward)
	ParticleManager:ReleaseParticleIndex(particle)
end
function modifier_elite_319_shadow_dodge.prototype.PlayPunchScreenShake(self, point)
	ScreenShake(
		point,
		PUNCH_SCREEN_SHAKE_AMPLITUDE,
		PUNCH_SCREEN_SHAKE_FREQUENCY,
		PUNCH_SCREEN_SHAKE_DURATION,
		PUNCH_SCREEN_SHAKE_RADIUS,
		0,
		true
	)
end
function modifier_elite_319_shadow_dodge.prototype.GetCurrentPipeDamage(self, final)
	local damage = final.base
	if final.add then
		for ____, value in ipairs(final.add) do
			damage = damage + value.value
		end
	end
	if final.mul then
		for ____, value in ipairs(final.mul) do
			damage = damage * value.value
		end
	end
	return math.max(0, damage)
end
function modifier_elite_319_shadow_dodge.prototype.FlatDirection(self, direction)
	local flat = Vector(direction.x, direction.y, 0)
	local ____temp_7
	if flat:Length2D() > 0.01 then
		____temp_7 = flat:Normalized()
	else
		____temp_7 = Vector(1, 0, 0)
	end
	return ____temp_7
end
function modifier_elite_319_shadow_dodge.prototype.IsHidden(self)
	return true
end
function modifier_elite_319_shadow_dodge.prototype.IsPurgable(self)
	return false
end
modifier_elite_319_shadow_dodge =
	__TS__DecorateLegacy({ registerModifier(nil, "modifier_elite_319_shadow_dodge") }, modifier_elite_319_shadow_dodge)
modifier_elite_319_dodge_fx = __TS__Class()
modifier_elite_319_dodge_fx.name = "modifier_elite_319_dodge_fx"
__TS__ClassExtends(modifier_elite_319_dodge_fx, MonsterModifier_CS)
function modifier_elite_319_dodge_fx.prototype.GetEffectName(self)
	return DODGE_PARTICLE
end
function modifier_elite_319_dodge_fx.prototype.GetEffectAttachType(self)
	return PATTACH_ABSORIGIN_FOLLOW
end
function modifier_elite_319_dodge_fx.prototype.StatusEffectPriority(self)
	return MODIFIER_PRIORITY_HIGH
end
function modifier_elite_319_dodge_fx.prototype.CheckState(self)
	return { [MODIFIER_STATE_NO_UNIT_COLLISION] = true }
end
function modifier_elite_319_dodge_fx.prototype.IsHidden(self)
	return true
end
function modifier_elite_319_dodge_fx.prototype.IsPurgable(self)
	return false
end
modifier_elite_319_dodge_fx =
	__TS__DecorateLegacy({ registerModifier(nil, "modifier_elite_319_dodge_fx") }, modifier_elite_319_dodge_fx)
return ____exports