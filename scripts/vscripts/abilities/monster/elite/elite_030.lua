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
local modifier_elite_030_hooked
local ____dota_ts_adapter = require("utils.dota_ts_adapter")
local registerAbility = ____dota_ts_adapter.registerAbility
local registerModifier = ____dota_ts_adapter.registerModifier
local ____monster_base = require("abilities.monster.monster_base")
local MonsterAbility_CS = ____monster_base.MonsterAbility_CS
local MonsterModifier_CS = ____monster_base.MonsterModifier_CS
local ELITE_030_HOOK_PARTICLE = "particles/unit/monster/pudge_meathook.vpcf"
local ELITE_030_ROOT_PARTICLE = "particles/unit/monster/broodmother_scepter_sticky_snare_root.vpcf"
local ELITE_030_HOOK_CAST_SOUND = "Hero_Pudge.AttackHookExtend"
local ELITE_030_HOOK_HIT_SOUND = "Hero_Pudge.AttackHookImpact"
local ELITE_030_CAST_RANGE = 1000
local ELITE_030_PROJECTILE_DISTANCE = 2200
local ELITE_030_PROJECTILE_SPEED = 2200
local ELITE_030_PROJECTILE_RADIUS = 120
local ELITE_030_WALL_CHECK_STEP = 24
local ELITE_030_DEBUFF_DURATION = 2
local ELITE_030_PULL_STEP_DISTANCE = 180
local ELITE_030_PULL_SAFE_SAMPLE_DISTANCE = 48
local ELITE_030_PULL_ACTIVE_DURATION = 0.18
local ELITE_030_PULL_PAUSE_DURATION = 0.32
local ELITE_030_PULL_STOP_DISTANCE = 140
local ELITE_030_IMPACT_DAMAGE_RATE = 25
local ELITE_030_LOCKED_ATTACK_INTERVAL = 1
local ELITE_030_ATTRACT_RADIUS = 500
local ELITE_030_AURA_RADIUS = 500
local ELITE_030_AURA_ATTACK_SPEED = 30
local ELITE_030_AURA_MOVESPEED_PCT = 30
local ELITE_030_AURA_ATTACK_DAMAGE_PCT = 30
local ELITE_030_ANIMATION_DURATION = 0.73
local ELITE_030_HOOK_END_BUFFER = 0.2
local ELITE_030_SEQUENCE_BUFFER = 0.35
local ELITE_030_AURA_EFFECT = "particles/units/heroes/hero_ogre_magi/ogre_magi_bloodlust_buff.vpcf"
--- 精英技能30 - 蜘蛛钩子（命中后缠绕并循环拉拽）
____exports.elite_030 = __TS__Class()
local elite_030 = ____exports.elite_030
elite_030.name = "elite_030"
__TS__ClassExtends(elite_030, MonsterAbility_CS)
function elite_030.prototype.____constructor(self, ...)
	MonsterAbility_CS.prototype.____constructor(self, ...)
	self._sequenceEnded = false
end
function elite_030.prototype.Precache(self, context)
	PrecacheResource("particle", ELITE_030_HOOK_PARTICLE, context)
	PrecacheResource("particle", ELITE_030_ROOT_PARTICLE, context)
end
function elite_030.prototype.GetMosnterAbilityConfig(self)
	return {
		behavior = DOTA_ABILITY_BEHAVIOR_NO_TARGET,
		castRange = ELITE_030_CAST_RANGE,
		castPoint = 1.1,
		castDuration = self:GetMaxSequenceDuration(),
		castAnimation = ACT_DOTA_CAST_ABILITY_1,
		canCast = function()
			local caster = self:GetCaster()
			local target = caster:GetMinDistanceUnit(ELITE_030_CAST_RANGE)
			local ____target_0
			if target then
				____target_0 = UF_SUCCESS
			else
				____target_0 = UF_FAIL_CUSTOM
			end
			return ____target_0
		end,
		OnPhaseStart = function()
			local caster = self:GetCaster()
			local target = caster:GetMinDistanceUnit(ELITE_030_CAST_RANGE)
			if not IsValidAlive(nil, target) then
				self._lockedDirection = nil
				return
			end
			caster:LockTargetForSpeed(target, 1)
			local delta = target:GetAbsOrigin():__sub(caster:GetAbsOrigin())
			local dir = Vector(delta.x, delta.y, 0):Normalized()
			self._lockedDirection = dir
			caster:SetForwardVector(dir)
			self:WarningEffect(
				caster:GetAbsOrigin(),
				caster:GetAbsOrigin():__add(caster:GetForwardVector():__mul(ELITE_030_PROJECTILE_DISTANCE)),
				1,
				{
					getDirection = function()
						self._lockedDirection = caster:GetForwardVector()
						return caster:GetForwardVector()
					end,
					startWidth = ELITE_030_PROJECTILE_RADIUS + 30,
					endWidth = ELITE_030_PROJECTILE_RADIUS + 30,
				}
			)
			self:WarningEffect(
				caster:GetAbsOrigin(),
				caster:GetAbsOrigin():__add(caster:GetForwardVector():__mul(800)),
				1,
				{
					getDirection = function()
						return caster:GetForwardVector()
					end,
					startWidth = ELITE_030_PROJECTILE_RADIUS + 30,
					endWidth = 500,
				}
			)
		end,
		OnStart = function()
			if not IsServer() then
				return
			end
			local caster = self:GetCaster()
			if not IsValidAlive(nil, caster) then
				return
			end
			local startPoint = self:GetHookOrigin(caster)
			local forward = self:GetHookDirection(startPoint)
			local endPoint = startPoint:__add(forward:__mul(ELITE_030_PROJECTILE_DISTANCE))
			local duration = self:GetMaxSequenceDuration()
			self:BeginHookSequence()
			self:ClearHookVisual()
			EmitSoundOn(ELITE_030_HOOK_CAST_SOUND, caster)
			local hookPfx = ParticleManager:CreateParticle(ELITE_030_HOOK_PARTICLE, PATTACH_CUSTOMORIGIN, nil)
			self:BindHookOriginParticle(hookPfx, caster)
			ParticleManager:SetParticleControl(hookPfx, 1, startPoint)
			ParticleManager:SetParticleControl(hookPfx, 2, Vector(ELITE_030_PROJECTILE_SPEED, 0, 0))
			ParticleManager:SetParticleControl(hookPfx, 3, Vector(duration, 0, 0))
			ParticleManager:SetParticleControl(hookPfx, 4, Vector(1, 0, 0))
			ParticleManager:SetParticleControl(hookPfx, 5, Vector(1, 0, 0))
			self._hookVisual = {
				pfx = hookPfx,
				cp1 = startPoint,
				speed = ELITE_030_PROJECTILE_SPEED,
				lastUpdateTime = GameRules:GetGameTime(),
				totalDuration = duration,
			}
			local lastProjectileLocation = startPoint
			CreateProjectile(nil, {
				ability = self,
				caster = caster,
				effect_name = "",
				projectile_type = "linear",
				start_point = startPoint,
				target = endPoint,
				projectile_speed = ELITE_030_PROJECTILE_SPEED,
				projectile_distance = ELITE_030_PROJECTILE_DISTANCE,
				projectile_range = ELITE_030_PROJECTILE_RADIUS,
				projectile_target_team = DOTA_UNIT_TARGET_TEAM_ENEMY,
				projectile_target_type = bit.bor(DOTA_UNIT_TARGET_HERO, DOTA_UNIT_TARGET_BASIC),
				projectile_target_flags = DOTA_UNIT_TARGET_FLAG_NONE,
				on_hit = function(____, hitTarget, location)
					if not IsServer() or not IsValidAlive(nil, caster) then
						self:EndHookSequence()
						return true
					end
					if IsValidAlive(nil, hitTarget) then
						self:AttachHookTarget(hitTarget, location)
					else
						self:BeginReturnVisual(location)
					end
					return true
				end,
				on_think = function(____, location)
					if not IsServer() then
						return false
					end
					local wallHitLocation = self:GetHookWallHitLocation(lastProjectileLocation, location)
					lastProjectileLocation = location
					if wallHitLocation then
						self:BeginReturnVisual(wallHitLocation)
						return true
					end
					self:UpdateHookVisual(location)
					return false
				end,
			})
			self._lockedDirection = nil
		end,
		OnInterrupt = function()
			self:ResetSequenceState()
		end,
		OnFinish = function()
			self:ResetSequenceState()
		end,
	}
end
function elite_030.prototype.UpdateHookVisual(self, targetPos, followTarget)
	if not IsServer() then
		return
	end
	local caster = self:GetCaster()
	local visual = self._hookVisual
	if not visual or not IsValidAlive(nil, caster) then
		return
	end
	local now = GameRules:GetGameTime()
	local dt = math.max(FrameTime(), now - visual.lastUpdateTime)
	visual.lastUpdateTime = now
	local desired = Vector(targetPos.x, targetPos.y, targetPos.z)
	local delta = desired:__sub(visual.cp1)
	local maxStep = visual.speed * dt
	local nextCp1 = desired
	if delta:Length2D() > maxStep and maxStep > 0 then
		local dir = delta:Normalized()
		nextCp1 = visual.cp1:__add(dir:__mul(maxStep))
	end
	visual.cp1 = nextCp1
	ParticleManager:SetParticleControl(visual.pfx, 1, nextCp1)
	if IsValidAlive(nil, followTarget) then
		visual.ownerEntIndex = followTarget:entindex()
		self._hookTarget = followTarget
	end
end
function elite_030.prototype.ClearHookVisual(self, target)
	if not IsServer() then
		return
	end
	local visual = self._hookVisual
	if not visual then
		return
	end
	if IsValidAlive(nil, target) and visual.ownerEntIndex ~= target:entindex() then
		return
	end
	ParticleManager:DestroyParticle(visual.pfx, false)
	ParticleManager:ReleaseParticleIndex(visual.pfx)
	self._hookVisual = nil
	if not target or self._hookTarget == target then
		self._hookTarget = nil
	end
end
function elite_030.prototype.EndHookSequence(self, target)
	if not IsServer() then
		return
	end
	if self._sequenceEnded then
		return
	end
	self._sequenceEnded = true
	local currentTarget = target or self._hookTarget
	if IsValid(nil, currentTarget) and not currentTarget:IsNull() then
		modifier_elite_030_hooked:remove(currentTarget)
	end
	self:ClearHookVisual()
	self:StopSequenceAnimation()
	self:DestroyDuration()
end
function elite_030.prototype.OnHookedTargetFinished(self, target)
	if not IsServer() then
		return
	end
	if self._hookTarget ~= target then
		return
	end
	self:EndHookSequence(target)
end
function elite_030.prototype.AttachHookTarget(self, target, hitLocation)
	if not IsServer() then
		return
	end
	local prevTarget = self._hookTarget
	if IsValidAlive(nil, prevTarget) and prevTarget ~= target then
		modifier_elite_030_hooked:remove(prevTarget)
	end
	if not IsValidAlive(nil, self:GetCaster()) then
		return
	end
	EmitSoundOn(ELITE_030_HOOK_HIT_SOUND, target)
	self:UpdateHookVisual(hitLocation, target)
	self:GetCaster():MonsterDamage({ victim = target, damage_rate = ELITE_030_IMPACT_DAMAGE_RATE, ability = self })
	modifier_elite_030_hooked:remove(target)
	modifier_elite_030_hooked:applys(target, self:GetCaster(), self, { duration = ELITE_030_DEBUFF_DURATION })
end
function elite_030.prototype.BeginHookSequence(self)
	self._sequenceEnded = false
	self._sequenceToken = DoUniqueString("elite_030_hook") or nil
	self._hookTarget = nil
	self:StartSequenceAnimation()
end
function elite_030.prototype.GetPullDurationByDistance(self, distanceToCaster)
	local remaining = math.max(0, distanceToCaster - ELITE_030_PULL_STOP_DISTANCE)
	if remaining <= 0 then
		return 0
	end
	local segments = math.ceil(remaining / ELITE_030_PULL_STEP_DISTANCE)
	if segments <= 0 then
		return 0
	end
	local activeDuration = segments * ELITE_030_PULL_ACTIVE_DURATION
	local pauseDuration = math.max(0, segments - 1) * ELITE_030_PULL_PAUSE_DURATION
	return activeDuration + pauseDuration
end
function elite_030.prototype.GetMaxSequenceDuration(self)
	local flightDuration = ELITE_030_PROJECTILE_DISTANCE / ELITE_030_PROJECTILE_SPEED
	local returnDuration = flightDuration
	local maxPullDuration = self:GetPullDurationByDistance(ELITE_030_PROJECTILE_DISTANCE)
	local hookedDuration = flightDuration + ELITE_030_DEBUFF_DURATION
	return math.max(flightDuration + returnDuration, flightDuration + maxPullDuration, hookedDuration)
		+ ELITE_030_SEQUENCE_BUFFER
end
function elite_030.prototype.BeginReturnVisual(self, fromPos)
	if not IsServer() then
		return
	end
	self:UpdateHookVisual(fromPos)
	local returnStart = Vector(fromPos.x, fromPos.y, fromPos.z)
	local token = self._sequenceToken
	self:Timer(FrameTime(), function()
		if not self:IsCurrentSequence(token) then
			return
		end
		local caster = self:GetCaster()
		if not IsValidAlive(nil, caster) or not self._hookVisual then
			self:EndHookSequence()
			return
		end
		local origin = self:GetHookOrigin(caster)
		self:UpdateHookVisual(origin)
		local movedFromStart = GetDistance(nil, self._hookVisual.cp1, returnStart)
		local totalReturnDistance = GetDistance(nil, returnStart, origin)
		local remain = GetDistance(nil, self._hookVisual.cp1, origin)
		if totalReturnDistance <= 24 then
			self:EndHookSequence()
			return
		end
		if movedFromStart <= 1 then
			return FrameTime()
		end
		if remain <= 24 then
			self:EndHookSequence()
			return
		end
		return FrameTime()
	end)
end
function elite_030.prototype.GetHookDirection(self, origin)
	if self._lockedDirection and self._lockedDirection:Length2D() > 0.01 then
		return self._lockedDirection
	end
	local target = self:GetCaster():GetMinDistanceUnit(ELITE_030_CAST_RANGE)
	if IsValidAlive(nil, target) then
		local delta = target:GetAbsOrigin():__sub(origin)
		return Vector(delta.x, delta.y, 0):Normalized()
	end
	return self:GetCaster():GetForwardVector()
end
function elite_030.prototype.GetHookWallHitLocation(self, from, to)
	local delta = to:__sub(from)
	local distance = delta:Length2D()
	if distance <= 0 then
		return nil
	end
	local stepCount = math.max(1, math.ceil(distance / ELITE_030_WALL_CHECK_STEP))
	local lastSafeLocation = from
	do
		local i = 1
		while i <= stepCount do
			local sampleLocation = from:__add(delta:__mul(i / stepCount))
			if GridNav:IsBlocked(sampleLocation) or not GridNav:IsTraversable(sampleLocation) then
				return lastSafeLocation
			end
			lastSafeLocation = sampleLocation
			i = i + 1
		end
	end
	return nil
end
function elite_030.prototype.GetHookOrigin(self, caster)
	local attachId = caster:ScriptLookupAttachment("attach_thorax")
	if attachId > 0 then
		return caster:GetAttachmentOrigin(attachId)
	end
	return caster:GetAbsOrigin()
end
function elite_030.prototype.BindHookOriginParticle(self, pfx, caster)
	local attachId = caster:ScriptLookupAttachment("attach_thorax")
	if attachId > 0 then
		ParticleManager:SetParticleControlEnt(
			pfx,
			0,
			caster,
			PATTACH_POINT_FOLLOW,
			"attach_thorax",
			caster:GetAttachmentOrigin(attachId),
			true
		)
		return
	end
	ParticleManager:SetParticleControlEnt(
		pfx,
		0,
		caster,
		PATTACH_ABSORIGIN_FOLLOW,
		"attach_hitloc",
		caster:GetAbsOrigin(),
		true
	)
end
function elite_030.prototype.StartSequenceAnimation(self)
	local caster = self:GetCaster()
	local token = self._sequenceToken
	if not IsValidAlive(nil, caster) or not token then
		return
	end
	local playbackRate = 1
	caster:StartGestureWithPlaybackRate(ACT_DOTA_CAST_ABILITY_1, playbackRate)
	self:Timer(ELITE_030_ANIMATION_DURATION, function()
		if not self:IsCurrentSequence(token) then
			return
		end
		if not IsValidAlive(nil, caster) then
			return
		end
		caster:StartGestureWithPlaybackRate(ACT_DOTA_CAST_ABILITY_1, playbackRate)
		return ELITE_030_ANIMATION_DURATION
	end)
end
function elite_030.prototype.StopSequenceAnimation(self)
	local caster = self:GetCaster()
	if not IsValidAlive(nil, caster) then
		return
	end
	if not IsValid(nil, caster) or caster:IsNull() then
		return
	end
	caster:FadeGesture(ACT_DOTA_CAST_ABILITY_1)
end
function elite_030.prototype.IsCurrentSequence(self, token)
	return not not token and token == self._sequenceToken and self._sequenceEnded == false
end
function elite_030.prototype.ResetSequenceState(self)
	self._lockedDirection = nil
	self._sequenceEnded = true
	self._sequenceToken = nil
	self:StopSequenceAnimation()
	self:ClearHookVisual()
	self._hookTarget = nil
end
elite_030 = __TS__DecorateLegacy({ registerAbility(nil) }, elite_030)
____exports.elite_030 = elite_030
modifier_elite_030_hooked = __TS__Class()
modifier_elite_030_hooked.name = "modifier_elite_030_hooked"
__TS__ClassExtends(modifier_elite_030_hooked, MonsterModifier_CS)
function modifier_elite_030_hooked.prototype.____constructor(self, ...)
	MonsterModifier_CS.prototype.____constructor(self, ...)
	self.phaseElapsed = 0
	self.isPulling = true
	self.finishing = false
	self.attackElapsed = 0
	self.attractElapsed = 0
end
function modifier_elite_030_hooked.prototype.DeclareFunctions(self)
	return { MODIFIER_PROPERTY_OVERRIDE_ANIMATION }
end
function modifier_elite_030_hooked.prototype.GetOverrideAnimation(self)
	return ACT_DOTA_FLAIL
end
function modifier_elite_030_hooked.prototype.OnCreated(self)
	if not IsServer() then
		return
	end
	local rootPfx = ParticleManager:CreateParticle(ELITE_030_ROOT_PARTICLE, PATTACH_ABSORIGIN_FOLLOW, self:GetParent())
	ParticleManager:SetParticleControlEnt(
		rootPfx,
		0,
		self:GetParent(),
		PATTACH_ABSORIGIN_FOLLOW,
		"attach_hitloc",
		self:GetParent():GetAbsOrigin(),
		true
	)
	self:AddParticle(rootPfx, true, false, -1, false, false)
	self.phaseElapsed = 0
	self.isPulling = true
	self.attackElapsed = 0
	self.attractElapsed = 0
	self:BeginPullSegment()
	self:StartIntervalThink(FrameTime())
end
function modifier_elite_030_hooked.prototype.OnIntervalThink(self)
	if not IsServer() then
		return
	end
	local parent = self:GetParent()
	local caster = self:GetCaster()
	local ability = self:GetAbility()
	if not IsValidAlive(nil, parent) or not IsValidAlive(nil, caster) or not ability then
		self:Destroy()
		return
	end
	ability:UpdateHookVisual(self:GetVisualTargetPos(parent), parent)
	self:ProcessHookedEffects()
	local remaining = GetDistance(nil, parent:GetAbsOrigin(), caster:GetAbsOrigin())
	if remaining <= ELITE_030_PULL_STOP_DISTANCE then
		self.isPulling = false
		self.phaseElapsed = 0
		return
	end
	self.phaseElapsed = self.phaseElapsed + FrameTime()
	if self.isPulling then
		if self.phaseElapsed >= ELITE_030_PULL_ACTIVE_DURATION then
			self.isPulling = false
			self.phaseElapsed = 0
		end
		return
	end
	if self.phaseElapsed >= ELITE_030_PULL_PAUSE_DURATION then
		self:BeginPullSegment()
	end
end
function modifier_elite_030_hooked.prototype.OnDestroy(self)
	if not IsServer() then
		return
	end
	local ability = self:GetAbility()
	if not ability then
		return
	end
	if self.finishing then
		return
	end
	ability:OnHookedTargetFinished(self:GetParent())
end
function modifier_elite_030_hooked.prototype.CheckState(self)
	return { [MODIFIER_STATE_ROOTED] = true, [MODIFIER_STATE_STUNNED] = true }
end
function modifier_elite_030_hooked.prototype.IsAura(self)
	return true
end
function modifier_elite_030_hooked.prototype.GetModifierAura(self)
	return "modifier_elite_030_hooked_aura_buff"
end
function modifier_elite_030_hooked.prototype.GetAuraRadius(self)
	return ELITE_030_AURA_RADIUS
end
function modifier_elite_030_hooked.prototype.GetAuraSearchTeam(self)
	return DOTA_UNIT_TARGET_TEAM_ENEMY
end
function modifier_elite_030_hooked.prototype.GetAuraSearchType(self)
	return DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC
end
function modifier_elite_030_hooked.prototype.GetAuraSearchFlags(self)
	return DOTA_UNIT_TARGET_FLAG_NONE
end
function modifier_elite_030_hooked.prototype.GetAuraDuration(self)
	return 0.2
end
function modifier_elite_030_hooked.prototype.GetAuraEntityReject(self, unit)
	return unit == self:GetParent()
end
function modifier_elite_030_hooked.prototype.IsHidden(self)
	return false
end
function modifier_elite_030_hooked.prototype.IsDebuff(self)
	return true
end
function modifier_elite_030_hooked.prototype.IsPurgable(self)
	return false
end
function modifier_elite_030_hooked.GetLocalizationCN(self)
	return {
		name = "蜘蛛钩缚",
		description = "被蜘蛛钩命中后无法行动，并会被持续拖向施法者，同时引来周围敌人围攻。",
	}
end
function modifier_elite_030_hooked.prototype.BeginPullSegment(self)
	local parent = self:GetParent()
	local caster = self:GetCaster()
	if not IsValidAlive(nil, parent) or not IsValidAlive(nil, caster) then
		self:Destroy()
		return
	end
	local parentPos = parent:GetAbsOrigin()
	local casterPos = caster:GetAbsOrigin()
	local delta = casterPos:__sub(parentPos)
	local distance = delta:Length2D()
	if distance <= ELITE_030_PULL_STOP_DISTANCE then
		self.isPulling = false
		return
	end
	local dir = Vector(delta.x, delta.y, 0):Normalized()
	local pullDistance = math.min(ELITE_030_PULL_STEP_DISTANCE, math.max(0, distance - ELITE_030_PULL_STOP_DISTANCE))
	if pullDistance <= 0 then
		self.isPulling = false
		return
	end
	local safeTargetPos = self:GetSafePullTarget(parentPos, dir, pullDistance, parent)
	if not safeTargetPos then
		FindClearSpaceForUnit(parent, parent:GetAbsOrigin(), true)
		self:Destroy()
		return
	end
	self.targetPos = safeTargetPos
	self.targetPos.z = GetGroundHeight(self.targetPos, parent) or parentPos.z
	self.phaseElapsed = 0
	self.isPulling = true
	parent:Mover(self.targetPos, ELITE_030_PULL_ACTIVE_DURATION, function(____, position)
		if self:IsPullPointWalkable(position) then
			return
		end
		FindClearSpaceForUnit(parent, parent:GetAbsOrigin(), true)
		self:Destroy()
		return true
	end, false, true)
end
function modifier_elite_030_hooked.prototype.GetSafePullTarget(self, origin, direction, maxDistance, parent)
	do
		local distance = maxDistance
		while distance > 0 do
			local candidate = origin:__add(direction:__mul(distance))
			candidate.z = GetGroundHeight(candidate, parent) or origin.z
			if self:IsPullPathWalkable(origin, candidate, parent) then
				return candidate
			end
			distance = distance - ELITE_030_PULL_SAFE_SAMPLE_DISTANCE
		end
	end
	return nil
end
function modifier_elite_030_hooked.prototype.IsPullPathWalkable(self, origin, target, parent)
	if not self:IsPullPointWalkable(origin) or not self:IsPullPointWalkable(target) then
		return false
	end
	if GridNav:FindPathLength(origin, target) == -1 then
		return false
	end
	local distance = GetDistance(nil, origin, target)
	local steps = math.max(1, math.ceil(distance / ELITE_030_PULL_SAFE_SAMPLE_DISTANCE))
	local direction = GetDirection(nil, target, origin)
	do
		local index = 1
		while index <= steps do
			local sampleDistance = distance * index / steps
			local sample = origin:__add(direction:__mul(sampleDistance))
			sample.z = GetGroundHeight(sample, parent) or origin.z
			if not self:IsPullPointWalkable(sample) then
				return false
			end
			index = index + 1
		end
	end
	return true
end
function modifier_elite_030_hooked.prototype.IsPullPointWalkable(self, position)
	return GridNav:IsTraversable(position) and not GridNav:IsBlocked(position)
end
function modifier_elite_030_hooked.prototype.ProcessHookedEffects(self)
	local parent = self:GetParent()
	local caster = self:GetCaster()
	local ability = self:GetAbility()
	if not IsValidAlive(nil, parent) or not IsValidAlive(nil, caster) or not ability then
		self:Destroy()
		return
	end
	local dt = FrameTime()
	self.attackElapsed = self.attackElapsed + dt
	self.attractElapsed = self.attractElapsed + dt
	if self.attackElapsed >= ELITE_030_LOCKED_ATTACK_INTERVAL then
		self.attackElapsed = 0
		MyGameAttack:PerformAttack(caster, parent, { use_projectile = false, use_effect = true })
	end
	if self.attractElapsed >= ELITE_030_LOCKED_ATTACK_INTERVAL then
		self.attractElapsed = 0
		self:AttractNearbyAlliesToAttack(parent, caster)
	end
end
function modifier_elite_030_hooked.prototype.AttractNearbyAlliesToAttack(self, target, caster)
	if not IsValidAlive(nil, caster) then
		return
	end
	if not IsValidAlive(nil, target) then
		return
	end
	local allies = FindUnitsInRadius(
		caster:GetTeamNumber(),
		target:GetAbsOrigin(),
		nil,
		ELITE_030_ATTRACT_RADIUS,
		DOTA_UNIT_TARGET_TEAM_FRIENDLY,
		DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,
		DOTA_UNIT_TARGET_FLAG_NONE,
		FIND_CLOSEST,
		false
	)
	for ____, ally in ipairs(allies) do
		do
			if not IsValidAlive(nil, ally) or ally == target or ally == caster then
				goto __continue127
			end
			ExecuteOrderFromTable({
				UnitIndex = ally:entindex(),
				OrderType = DOTA_UNIT_ORDER_ATTACK_TARGET,
				TargetIndex = target:entindex(),
				Queue = false,
			})
		end
		::__continue127::
	end
end
function modifier_elite_030_hooked.prototype.GetVisualTargetPos(self, parent)
	return parent:GetAbsOrigin():__add(Vector(0, 0, 60))
end
modifier_elite_030_hooked =
	__TS__DecorateLegacy({ registerModifier(nil, "modifier_elite_030_hooked") }, modifier_elite_030_hooked)
local modifier_elite_030_hooked_aura_buff = __TS__Class()
modifier_elite_030_hooked_aura_buff.name = "modifier_elite_030_hooked_aura_buff"
__TS__ClassExtends(modifier_elite_030_hooked_aura_buff, MonsterModifier_CS)
function modifier_elite_030_hooked_aura_buff.prototype.GetAttributeBonus(self)
	return {
		attack_speed = ELITE_030_AURA_ATTACK_SPEED,
		bonus_movespeed_pct = ELITE_030_AURA_MOVESPEED_PCT,
		all_attack_damage_percent = ELITE_030_AURA_ATTACK_DAMAGE_PCT,
	}
end
function modifier_elite_030_hooked_aura_buff.prototype.GetEffectName(self)
	return ELITE_030_AURA_EFFECT
end
function modifier_elite_030_hooked_aura_buff.prototype.IsHidden(self)
	return false
end
function modifier_elite_030_hooked_aura_buff.prototype.IsDebuff(self)
	return false
end
function modifier_elite_030_hooked_aura_buff.prototype.IsPurgable(self)
	return false
end
function modifier_elite_030_hooked_aura_buff.GetLocalizationCN(self)
	return {
		name = "猎群狂热",
		description = "受到蜘蛛钩缚目标的气息鼓舞，提升攻击、攻速与移速。",
	}
end
modifier_elite_030_hooked_aura_buff = __TS__DecorateLegacy(
	{ registerModifier(nil, "modifier_elite_030_hooked_aura_buff") },
	modifier_elite_030_hooked_aura_buff
)
return ____exports