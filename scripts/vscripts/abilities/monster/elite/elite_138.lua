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
local modifier_elite_138_overgrowth_root, modifier_elite_138_overgrowth_form
local ____dota_ts_adapter = require("utils.dota_ts_adapter")
local registerAbility = ____dota_ts_adapter.registerAbility
local registerModifier = ____dota_ts_adapter.registerModifier
local ____monster_base = require("abilities.monster.monster_base")
local MonsterAbility_CS = ____monster_base.MonsterAbility_CS
local MonsterModifier_CS = ____monster_base.MonsterModifier_CS
local CAST_POINT = 1.2
local CAST_DURATION = 0.5
local OVERGROWTH_RADIUS = 680
local STOMP_ACTION_DURATION = 1.47
local STOMP_CYCLE_COUNT = 5
local STOMP_TOTAL_DURATION = STOMP_ACTION_DURATION * STOMP_CYCLE_COUNT
local ROOT_DURATION = 3.5
local SELF_BUFF_DURATION = STOMP_TOTAL_DURATION
local MODEL_SCALE_BONUS = 35
local MOVE_SPEED_BONUS_PCT = 100
local STOMP_THINK_INTERVAL = 0.03
local STOMP_MOVE_SPEED = 150
local STOMP_TURN_RATE_DEG = 115
local STOMP_TARGET_SEARCH_RADIUS = 1800
local STOMP_IMPACT_DELAY = 0.6
local STOMP_PRE_IMPACT_MOVE_RATIO = 1
local STOMP_FOOT_FORWARD_OFFSET = 50
local STOMP_FOOT_SIDE_OFFSET = 50
local STOMP_RADIUS = 350
local STOMP_DAMAGE_RATE = 10
local STOMP_STUN_DURATION = 0.5
local STOMP_LEFT_ANIMATION = "attack_overgrowth_L"
local STOMP_RIGHT_ANIMATION = "attack_overgrowth_R"
local OVERGROWTH_CAST_PARTICLE =
	"particles/econ/items/treant_protector/treant_ti10_immortal_head/treant_ti10_immortal_overgrowth_cast.vpcf"
local OVERGROWTH_ROOT_PARTICLE =
	"particles/econ/items/treant_protector/treant_ti10_immortal_head/treant_ti10_immortal_overgrowth_root_small.vpcf"
local STOMP_PARTICLE = "particles/econ/items/earthshaker/earthshaker_arcana/earthshaker_arcana_aftershock.vpcf"
local OVERGROWTH_CAST_SOUND = "Hero_Treant.Overgrowth.Cast"
local OVERGROWTH_TARGET_SOUND = "Hero_Treant.Overgrowth.Target"
local STOMP_SOUND = "Hero_EarthShaker.Totem.TI6.Layer"
local ROOT_LOOP_SOUND_INTERVAL = 1
--- 精英技能138 - 树界降临：大范围预警后缠绕敌人，并让自身进入巨树踩踏态
____exports.elite_138 = __TS__Class()
local elite_138 = ____exports.elite_138
elite_138.name = "elite_138"
__TS__ClassExtends(elite_138, MonsterAbility_CS)
function elite_138.prototype.Precache(self, context)
	PrecacheResource("particle", OVERGROWTH_CAST_PARTICLE, context)
	PrecacheResource("particle", OVERGROWTH_ROOT_PARTICLE, context)
	PrecacheResource("particle", STOMP_PARTICLE, context)
end
function elite_138.prototype.GetAOERadius(self)
	return OVERGROWTH_RADIUS
end
function elite_138.prototype.GetMosnterAbilityConfig(self)
	return {
		castRange = OVERGROWTH_RADIUS,
		castPoint = CAST_POINT,
		castDuration = CAST_DURATION,
		behavior = DOTA_ABILITY_BEHAVIOR_NO_TARGET,
		castAnimation = ACT_DOTA_CAST_ABILITY_4,
		animationPlaybackRate = 1,
		castColor = Vector(70, 190, 90),
		OnPhaseStart = function()
			local caster = self:GetCaster()
			if not IsValidAlive(nil, caster) then
				return
			end
			self._castCenter = caster:GetAbsOrigin()
			self:WarningRingEffect(self._castCenter, OVERGROWTH_RADIUS, CAST_POINT)
		end,
		OnStart = function()
			local caster = self:GetCaster()
			if not IsValidAlive(nil, caster) then
				return
			end
			local center = self._castCenter or caster:GetAbsOrigin()
			EmitSoundOnLocationWithCaster(center, OVERGROWTH_CAST_SOUND, caster)
			self:PlayOvergrowthCastEffect(center, caster)
			self:RootEnemiesInRange(caster, center)
			modifier_elite_138_overgrowth_form:applys(caster, caster, self, { duration = SELF_BUFF_DURATION })
			self._castCenter = nil
		end,
	}
end
function elite_138.prototype.PlayOvergrowthCastEffect(self, center, caster)
	local pfx = ParticleManager:CreateParticle(OVERGROWTH_CAST_PARTICLE, PATTACH_WORLDORIGIN, caster)
	ParticleManager:SetParticleShouldCheckFoW(pfx, false)
	ParticleManager:SetParticleControl(pfx, 0, center)
	ParticleManager:SetParticleControl(pfx, 1, Vector(OVERGROWTH_RADIUS, 0, 0))
	ParticleManager:ReleaseParticleIndex(pfx)
end
function elite_138.prototype.RootEnemiesInRange(self, caster, center)
	local enemies = FindUnitsInRadius(
		caster:GetTeamNumber(),
		center,
		nil,
		OVERGROWTH_RADIUS * 0.95,
		DOTA_UNIT_TARGET_TEAM_ENEMY,
		DOTA_UNIT_TARGET_HEROES_AND_CREEPS,
		DOTA_UNIT_TARGET_FLAG_NONE,
		FIND_ANY_ORDER,
		false
	)
	local rootedEnemies = {}
	for ____, enemy in ipairs(enemies) do
		do
			if not IsValidAlive(nil, enemy) then
				goto __continue11
			end
			rootedEnemies[#rootedEnemies + 1] = enemy
			modifier_elite_138_overgrowth_root:applys(enemy, caster, self, { duration = ROOT_DURATION })
		end
		::__continue11::
	end
	return rootedEnemies
end
elite_138 = __TS__DecorateLegacy({ registerAbility(nil) }, elite_138)
____exports.elite_138 = elite_138
modifier_elite_138_overgrowth_root = __TS__Class()
modifier_elite_138_overgrowth_root.name = "modifier_elite_138_overgrowth_root"
__TS__ClassExtends(modifier_elite_138_overgrowth_root, MonsterModifier_CS)
function modifier_elite_138_overgrowth_root.prototype.OnCreated(self)
	if not IsServer() then
		return
	end
	local parent = self:GetParent()
	EmitSoundOn(OVERGROWTH_TARGET_SOUND, parent)
	local pfx = ParticleManager:CreateParticle(OVERGROWTH_ROOT_PARTICLE, PATTACH_ABSORIGIN_FOLLOW, parent)
	ParticleManager:SetParticleControlEnt(
		pfx,
		0,
		parent,
		PATTACH_ABSORIGIN_FOLLOW,
		"attach_hitloc",
		parent:GetAbsOrigin(),
		true
	)
	self:AddParticle(pfx, false, false, -1, false, false)
	self:StartIntervalThink(ROOT_LOOP_SOUND_INTERVAL)
end
function modifier_elite_138_overgrowth_root.prototype.OnIntervalThink(self)
	if not IsServer() then
		return
	end
	local parent = self:GetParent()
	if not IsValidAlive(nil, parent) then
		self:Destroy()
		return
	end
	EmitSoundOn(OVERGROWTH_TARGET_SOUND, parent)
end
function modifier_elite_138_overgrowth_root.prototype.OnDestroy(self)
	if not IsServer() then
		return
	end
	self:StartIntervalThink(-1)
end
function modifier_elite_138_overgrowth_root.prototype.CheckState(self)
	return { [MODIFIER_STATE_ROOTED] = true, [MODIFIER_STATE_SILENCED] = true }
end
function modifier_elite_138_overgrowth_root.prototype.IsHidden(self)
	return false
end
function modifier_elite_138_overgrowth_root.prototype.IsDebuff(self)
	return true
end
function modifier_elite_138_overgrowth_root.prototype.IsPurgable(self)
	return true
end
function modifier_elite_138_overgrowth_root.GetLocalizationCN(self)
	return { name = "树界缠绕", description = "被树界根须缠住，无法移动和施法。" }
end
modifier_elite_138_overgrowth_root = __TS__DecorateLegacy(
	{ registerModifier(nil, "modifier_elite_138_overgrowth_root") },
	modifier_elite_138_overgrowth_root
)
--- 138 大招的陷阱基类：统一处理地面范围触发、特效和伤害
local Elite138TrapModifierBase = __TS__Class()
Elite138TrapModifierBase.name = "Elite138TrapModifierBase"
__TS__ClassExtends(Elite138TrapModifierBase, MonsterModifier_CS)
function Elite138TrapModifierBase.prototype.TriggerTrapArea(self, caster, ability, center, direction)
	local groundCenter = GetGroundPosition(center, caster)
	self:PlayTrapEffect(caster, groundCenter, direction)
	self:DamageTrapArea(caster, ability, groundCenter)
end
function Elite138TrapModifierBase.prototype.PlayTrapEffect(self, caster, center, direction)
	local effectDirection = self:NormalizeEffectDirection(direction)
	local pfx = ParticleManager:CreateParticle(STOMP_PARTICLE, PATTACH_WORLDORIGIN, nil)
	ParticleManager:SetParticleShouldCheckFoW(pfx, false)
	ParticleManager:SetParticleControl(pfx, 0, center)
	ParticleManager:SetParticleControlForward(pfx, 0, effectDirection)
	ParticleManager:SetParticleControl(pfx, 1, Vector(STOMP_RADIUS, 0, 0))
	ParticleManager:ReleaseParticleIndex(pfx)
	EmitSoundOnLocationWithCaster(center, STOMP_SOUND, caster)
end
function Elite138TrapModifierBase.prototype.NormalizeEffectDirection(self, direction)
	local flatDirection = Vector(direction.x, direction.y, 0)
	if flatDirection:Length2D() <= 0.01 then
		return Vector(1, 0, 0)
	end
	return flatDirection:Normalized()
end
function Elite138TrapModifierBase.prototype.DamageTrapArea(self, caster, ability, center)
	local enemies = FindUnitsInRadius(
		caster:GetTeamNumber(),
		center,
		nil,
		STOMP_RADIUS,
		DOTA_UNIT_TARGET_TEAM_ENEMY,
		DOTA_UNIT_TARGET_HEROES_AND_CREEPS,
		DOTA_UNIT_TARGET_FLAG_NONE,
		FIND_ANY_ORDER,
		false
	)
	for ____, enemy in ipairs(enemies) do
		do
			if not IsValidAlive(nil, enemy) then
				goto __continue31
			end
			caster:MonsterDamage({ victim = enemy, damage_rate = STOMP_DAMAGE_RATE, ability = ability })
			AddDeBuffStatus(nil, enemy, caster, ability, DebuffStatusType.STUN, { duration = STOMP_STUN_DURATION })
		end
		::__continue31::
	end
end
modifier_elite_138_overgrowth_form = __TS__Class()
modifier_elite_138_overgrowth_form.name = "modifier_elite_138_overgrowth_form"
__TS__ClassExtends(modifier_elite_138_overgrowth_form, Elite138TrapModifierBase)
function modifier_elite_138_overgrowth_form.prototype.____constructor(self, ...)
	Elite138TrapModifierBase.prototype.____constructor(self, ...)
	self.direction = Vector(1, 0, 0)
	self.cycleDirection = Vector(1, 0, 0)
	self.cycleStartPos = Vector(0, 0, 0)
	self.cycleStartTime = 0
	self.cycleEndTime = 0
	self.pendingImpactTime = -1
	self.pendingImpactIsLeft = true
	self.hasPendingImpact = false
	self.stepIndex = 0
end
function modifier_elite_138_overgrowth_form.prototype.OnCreated(self)
	if not IsServer() then
		return
	end
	local parent = self:GetParent()
	if not IsValidAlive(nil, parent) then
		self:Destroy()
		return
	end
	local forward = parent:GetForwardVector()
	self.direction = self:NormalizeDirection(forward)
	self:UpdateFacingDirection(parent)
	self:StartStompCycle(parent, GameRules:GetGameTime())
	self:StartIntervalThink(STOMP_THINK_INTERVAL)
end
function modifier_elite_138_overgrowth_form.prototype.OnIntervalThink(self)
	if not IsServer() then
		return
	end
	local parent = self:GetParent()
	local ability = self:GetAbility()
	if not IsValidAlive(nil, parent) or not ability then
		self:Destroy()
		return
	end
	self:UpdateStompCycle(parent, ability)
end
function modifier_elite_138_overgrowth_form.prototype.OnDestroy(self)
	if not IsServer() then
		return
	end
	self:StartIntervalThink(-1)
end
function modifier_elite_138_overgrowth_form.prototype.DeclareFunctions(self)
	return {
		MODIFIER_PROPERTY_MODEL_SCALE,
		MODIFIER_PROPERTY_MODEL_SCALE_ANIMATE_TIME,
		MODIFIER_PROPERTY_DISABLE_TURNING,
	}
end
function modifier_elite_138_overgrowth_form.prototype.GetModifierModelScaleAnimateTime(self)
	return 0.25
end
function modifier_elite_138_overgrowth_form.prototype.GetModifierModelScale(self)
	return MODEL_SCALE_BONUS
end
function modifier_elite_138_overgrowth_form.prototype.GetAttributeBonus(self)
	return { bonus_movespeed_pct = MOVE_SPEED_BONUS_PCT }
end
function modifier_elite_138_overgrowth_form.prototype.CheckState(self)
	return {
		[MODIFIER_STATE_ROOTED] = true,
		[MODIFIER_STATE_DISARMED] = true,
		[MODIFIER_STATE_COMMAND_RESTRICTED] = true,
		[MODIFIER_STATE_NO_UNIT_COLLISION] = true,
	}
end
function modifier_elite_138_overgrowth_form.prototype.IsHidden(self)
	return false
end
function modifier_elite_138_overgrowth_form.prototype.IsDebuff(self)
	return false
end
function modifier_elite_138_overgrowth_form.prototype.IsPurgable(self)
	return false
end
function modifier_elite_138_overgrowth_form.prototype.UpdateFacingDirection(self, parent)
	if not IsValidAlive(nil, parent) then
		return
	end
	local target = self:FindTarget(parent)
	if not IsValidAlive(nil, target) then
		parent:SetForwardVectorWithoutInterrupt(self.direction)
		return
	end
	local desiredDirection = self:NormalizeDirection(target:GetAbsOrigin():__sub(parent:GetAbsOrigin()))
	self.direction = self:RotateToward(self.direction, desiredDirection, STOMP_TURN_RATE_DEG * STOMP_ACTION_DURATION)
	parent:SetForwardVectorWithoutInterrupt(self.direction)
end
function modifier_elite_138_overgrowth_form.prototype.UpdateCyclePosition(self, parent, now)
	local elapsed = math.min(math.max(now - self.cycleStartTime, 0), STOMP_ACTION_DURATION)
	local moveRatio = self:GetCycleMoveRatio(elapsed)
	local cycleDistance = STOMP_MOVE_SPEED * STOMP_ACTION_DURATION
	local nextPoint = self.cycleStartPos:__add(self.cycleDirection:__mul(cycleDistance * moveRatio))
	if not IsValidAlive(nil, parent) then
		return
	end
	local groundPoint = GetGroundPosition(nextPoint, parent)
	parent:SetAbsOrigin(groundPoint)
end
function modifier_elite_138_overgrowth_form.prototype.StartStompCycle(self, parent, now)
	local isLeftStep = self.stepIndex % 2 == 0
	if not IsValidAlive(nil, parent) then
		return
	end
	parent:SetAnimation(isLeftStep and STOMP_LEFT_ANIMATION or STOMP_RIGHT_ANIMATION)
	self.cycleStartPos = parent:GetAbsOrigin()
	self.cycleDirection = self:NormalizeDirection(self.direction)
	self.cycleStartTime = now
	self.cycleEndTime = now + STOMP_ACTION_DURATION
	self.pendingImpactIsLeft = isLeftStep
	self.pendingImpactTime = now + STOMP_IMPACT_DELAY
	self.hasPendingImpact = true
	self.stepIndex = self.stepIndex + 1
end
function modifier_elite_138_overgrowth_form.prototype.UpdateStompCycle(self, parent, ability)
	local now = GameRules:GetGameTime()
	if not IsValidAlive(nil, parent) then
		return
	end
	parent:SetForwardVectorWithoutInterrupt(self.cycleDirection)
	self:UpdateCyclePosition(parent, now)
	self:TryTriggerPendingImpact(parent, ability, now)
	if now < self.cycleEndTime then
		return
	end
	self:UpdateFacingDirection(parent)
	self:StartStompCycle(parent, now)
end
function modifier_elite_138_overgrowth_form.prototype.TryTriggerPendingImpact(self, parent, ability, now)
	if not self.hasPendingImpact then
		return
	end
	if now < self.pendingImpactTime then
		return
	end
	if not IsValidAlive(nil, parent) then
		return
	end
	local stompPoint = self:GetFootPoint(parent, self.pendingImpactIsLeft)
	self:TriggerTrapArea(parent, ability, stompPoint, parent:GetForwardVector())
	self.hasPendingImpact = false
	self.pendingImpactTime = -1
end
function modifier_elite_138_overgrowth_form.prototype.GetCycleMoveRatio(self, elapsed)
	if elapsed <= 0 then
		return 0
	end
	if elapsed < STOMP_IMPACT_DELAY then
		local progress = elapsed / STOMP_IMPACT_DELAY
		return self:EaseInOutQuad(progress) * STOMP_PRE_IMPACT_MOVE_RATIO
	end
	return STOMP_PRE_IMPACT_MOVE_RATIO
end
function modifier_elite_138_overgrowth_form.prototype.EaseInOutQuad(self, progress)
	local clamped = math.min(math.max(progress, 0), 1)
	if clamped < 0.5 then
		return 2 * clamped * clamped
	end
	return 1 - (-2 * clamped + 2) ^ 2 / 2
end
function modifier_elite_138_overgrowth_form.prototype.FindTarget(self, parent)
	if not IsValidAlive(nil, parent) then
		return
	end
	local enemies = FindUnitsInRadius(
		parent:GetTeamNumber(),
		parent:GetAbsOrigin(),
		nil,
		STOMP_TARGET_SEARCH_RADIUS,
		DOTA_UNIT_TARGET_TEAM_ENEMY,
		DOTA_UNIT_TARGET_HEROES_AND_CREEPS,
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
function modifier_elite_138_overgrowth_form.prototype.GetFootPoint(self, parent, isLeftStep)
	local origin = parent:GetAbsOrigin()
	local forward = self:NormalizeDirection(self.direction)
	local ____isLeftStep_0
	if isLeftStep then
		____isLeftStep_0 = Vector(-forward.y, forward.x, 0)
	else
		____isLeftStep_0 = Vector(forward.y, -forward.x, 0)
	end
	local sideDirection = ____isLeftStep_0
	local rawPoint =
		origin:__add(forward:__mul(STOMP_FOOT_FORWARD_OFFSET)):__add(sideDirection:__mul(STOMP_FOOT_SIDE_OFFSET))
	return GetGroundPosition(rawPoint, parent)
end
function modifier_elite_138_overgrowth_form.prototype.RotateToward(self, current, desired, maxTurnDeg)
	local currentAngle = math.atan2(current.y, current.x) * (180 / math.pi)
	local desiredAngle = math.atan2(desired.y, desired.x) * (180 / math.pi)
	local delta = desiredAngle - currentAngle
	while delta > 180 do
		delta = delta - 360
	end
	while delta < -180 do
		delta = delta + 360
	end
	local turn = math.max(-maxTurnDeg, math.min(maxTurnDeg, delta))
	local newAngle = (currentAngle + turn) * (math.pi / 180)
	return Vector(math.cos(newAngle), math.sin(newAngle), 0):Normalized()
end
function modifier_elite_138_overgrowth_form.prototype.NormalizeDirection(self, direction)
	local flatDirection = Vector(direction.x, direction.y, 0)
	if flatDirection:Length2D() <= 0.01 then
		return Vector(1, 0, 0)
	end
	return flatDirection:Normalized()
end
function modifier_elite_138_overgrowth_form.GetLocalizationCN(self)
	return {
		name = "怨树降临",
		description = "体型变大并被缴械，以受限转向持续踩踏追击敌人。",
	}
end
modifier_elite_138_overgrowth_form = __TS__DecorateLegacy(
	{ registerModifier(nil, "modifier_elite_138_overgrowth_form") },
	modifier_elite_138_overgrowth_form
)
return ____exports