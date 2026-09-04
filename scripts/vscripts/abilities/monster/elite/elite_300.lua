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
local modifier_elite_300_mirror_state, modifier_elite_300_mirror_wearable_status
local ____dota_ts_adapter = require("utils.dota_ts_adapter")
local registerAbility = ____dota_ts_adapter.registerAbility
local registerModifier = ____dota_ts_adapter.registerModifier
local ____monster_base = require("abilities.monster.monster_base")
local MonsterAbility_CS = ____monster_base.MonsterAbility_CS
local MonsterModifier_CS = ____monster_base.MonsterModifier_CS
local CAST_POINT = 1
local PUNCH_COUNT = 3
local PUNCH_INTERVAL = 0.75
local PUNCH_RELEASE_DELAY = 0.5
local CAST_DURATION = 3
local SEARCH_RANGE = 1200
local PUNCH_DISTANCE = 2000
local PUNCH_WIDTH = 128
local PUNCH_SPEED = 1300
local PUNCH_DAMAGE_RATE = 8
local PUNCH_STUN_DURATION = 0.1
local PUNCH_KNOCKBACK_DISTANCE = 180
local PUNCH_TURN_SPEED = 2
local PUNCH_SCREEN_SHAKE_AMPLITUDE = 12
local PUNCH_SCREEN_SHAKE_FREQUENCY = 12
local PUNCH_SCREEN_SHAKE_DURATION = 0.2
local PUNCH_SCREEN_SHAKE_RADIUS = 1800
local MIRROR_UNIT_NAME = "monster_11300_mirror"
local MIRROR_SUMMON_TAG = "monster_11300_mirror"
local MIRROR_MAX_COUNT = 4
local MIRROR_SPAWN_RADIUS = 140
local MIRROR_ATTRIBUTE_RATE = 0.3
local MIRROR_ATTRIBUTE_SOURCE_PREFIX = "elite_300_mirror"
local PUNCH_PROJECTILE_PARTICLE =
	"particles/econ/items/puck/puck_merry_wanderer/puck_illusory_orb_merry_wanderer_linear_projectile.vpcf"
local PUNCH_CAST_EFFECT_PARTICLE = "particles/bb/pun_dark_seer_attack_normal_punch.vpcf"
local PUNCH_HIT_PARTICLE = "particles/units/heroes/hero_dark_seer/dark_seer_wall_of_replica_replicate.vpcf"
local MIRROR_STATUS_EFFECT = "particles/status_fx/status_effect_dark_seer_illusion.vpcf"
local PUNCH_WAVE_SOUND = "Hero_Dark_Seer.NormalPunch.Lv1"
local PUNCH_HIT_SOUND = "Hero_Dark_Seer.Surge"
local MIRROR_SPAWN_SOUND = "Hero_Dark_Seer.Wall_of_Replica_Start"
____exports.elite_300 = __TS__Class()
local elite_300 = ____exports.elite_300
elite_300.name = "elite_300"
__TS__ClassExtends(elite_300, MonsterAbility_CS)
function elite_300.prototype.____constructor(self, ...)
	MonsterAbility_CS.prototype.____constructor(self, ...)
	self.castToken = 0
end
function elite_300.prototype.Precache(self, context)
	PrecacheResource("particle", PUNCH_PROJECTILE_PARTICLE, context)
	PrecacheResource("particle", PUNCH_CAST_EFFECT_PARTICLE, context)
	PrecacheResource("particle", PUNCH_HIT_PARTICLE, context)
	PrecacheResource("particle", MIRROR_STATUS_EFFECT, context)
end
function elite_300.prototype.GetMosnterAbilityConfig(self)
	return {
		castRange = SEARCH_RANGE,
		behavior = DOTA_ABILITY_BEHAVIOR_NO_TARGET,
		castPoint = CAST_POINT,
		castDuration = CAST_DURATION,
		castAnimation = ACT_DOTA_CAST_ABILITY_3,
		animationPlaybackRate = 1.1,
		cooldown = 5,
		isNotMove = true,
		castColor = Vector(80, 180, 255),
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
			return self:PreparePunchFlurry()
		end,
		OnStart = function()
			return self:StartPunchFlurry()
		end,
		OnFinish = function()
			return self:StopPunchFlurry()
		end,
		OnInterrupt = function()
			return self:StopPunchFlurry()
		end,
	}
end
function elite_300.prototype.PreparePunchFlurry(self)
	local caster = self:GetCaster()
	if not IsValidAlive(nil, caster) then
		return
	end
	self.lockedTarget = self:FindTarget()
	self:StartTargetLock(caster, CAST_POINT + CAST_DURATION)
end
function elite_300.prototype.StartPunchFlurry(self)
	local caster = self:GetCaster()
	if not IsValidAlive(nil, caster) then
		return
	end
	self.castToken = self.castToken + 1
	local token = self.castToken
	self:StartTargetLock(caster, CAST_DURATION)
	do
		local index = 0
		while index < PUNCH_COUNT do
			local currentIndex = index
			local attackDelay = currentIndex * PUNCH_INTERVAL
			local releaseDelay = attackDelay + PUNCH_RELEASE_DELAY
			self:Timer(attackDelay, function()
				if token ~= self.castToken or not IsValidAlive(nil, caster) then
					return
				end
				self:PlayAttackGesture(caster)
			end)
			self:Timer(releaseDelay, function()
				if token ~= self.castToken or not IsValidAlive(nil, caster) then
					return
				end
				self:FirePunchWave(caster)
			end)
			index = index + 1
		end
	end
end
function elite_300.prototype.StopPunchFlurry(self)
	self.castToken = self.castToken + 1
	local caster = self:GetCaster()
	if IsValidAlive(nil, caster) then
		self:StopTargetLock(caster)
	end
	self.lockedTarget = nil
end
function elite_300.prototype.PlayAttackGesture(self, caster)
	caster:StartGestureWithFadeAndPlaybackRate(ACT_DOTA_ATTACK, 0.03, 0.15, 1.4)
end
function elite_300.prototype.FirePunchWave(self, caster)
	local origin = caster:GetAbsOrigin()
	local forward = self:ResolvePunchDirection(caster)
	local start = GetGroundPosition(origin:__add(forward:__mul(110)), caster)
	local ____end = GetGroundPosition(start:__add(forward:__mul(PUNCH_DISTANCE)), caster)
	self:PlayPunchCastEffect(start, forward, caster)
	self:PlayPunchScreenShake(start)
	EmitSoundOn(PUNCH_WAVE_SOUND, caster)
	CreateProjectile(nil, {
		ability = self,
		caster = caster,
		effect_name = PUNCH_PROJECTILE_PARTICLE,
		projectile_type = "linear",
		start_point = start,
		target = ____end,
		projectile_speed = PUNCH_SPEED,
		projectile_distance = PUNCH_DISTANCE,
		projectile_range = PUNCH_WIDTH,
		projectile_target_team = DOTA_UNIT_TARGET_TEAM_ENEMY,
		projectile_target_type = DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,
		projectile_target_flags = DOTA_UNIT_TARGET_FLAG_NONE,
		on_hit = function(____, hitTarget)
			if not hitTarget or not IsValidAlive(nil, hitTarget) then
				return true
			end
			self:OnPunchHit(caster, hitTarget, forward)
			return false
		end,
	})
end
function elite_300.prototype.PlayPunchScreenShake(self, point)
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
function elite_300.prototype.PlayPunchCastEffect(self, origin, forward, caster)
	local pfx = ParticleManager:CreateParticle(PUNCH_CAST_EFFECT_PARTICLE, PATTACH_WORLDORIGIN, caster)
	ParticleManager:SetParticleControl(pfx, 0, origin)
	ParticleManager:SetParticleControlForward(pfx, 0, forward)
	ParticleManager:SetParticleControlTransformForward(pfx, 0, origin, forward)
	ParticleManager:ReleaseParticleIndex(pfx)
end
function elite_300.prototype.ResolvePunchDirection(self, caster)
	local forward = caster:GetForwardVector()
	local ____temp_1
	if forward:Length2D() > 0.01 then
		____temp_1 = forward:Normalized()
	else
		____temp_1 = Vector(1, 0, 0)
	end
	return ____temp_1
end
function elite_300.prototype.StartTargetLock(self, caster, duration)
	local ____IsValidAlive_result_2
	if IsValidAlive(nil, self.lockedTarget) then
		____IsValidAlive_result_2 = self.lockedTarget
	else
		____IsValidAlive_result_2 = self:FindTarget()
	end
	local target = ____IsValidAlive_result_2
	local ____IsValidAlive_result_3
	if IsValidAlive(nil, target) then
		____IsValidAlive_result_3 = target
	else
		____IsValidAlive_result_3 = nil
	end
	self.lockedTarget = ____IsValidAlive_result_3
	if not IsValidAlive(nil, self.lockedTarget) then
		return
	end
	caster:LockTargetForSpeed(self.lockedTarget, duration, PUNCH_TURN_SPEED)
end
function elite_300.prototype.StopTargetLock(self, caster)
	local timerId = caster:GetCustomValue("目标计时器")
	if not timerId then
		return
	end
	Timers:RemoveTimer(timerId)
	caster:SetCustomValue("目标计时器", "")
end
function elite_300.prototype.OnPunchHit(self, caster, target, direction)
	if not IsValidAlive(nil, caster) then
		return
	end
	if not IsValidAlive(nil, target) then
		return
	end
	caster:MonsterDamage({
		victim = target,
		damage_rate = PUNCH_DAMAGE_RATE,
		ability = self,
		effectName = PUNCH_HIT_PARTICLE,
	})
	EmitSoundOn(PUNCH_HIT_SOUND, target)
	AddDeBuffStatus(nil, target, caster, self, DebuffStatusType.STUN, { duration = PUNCH_STUN_DURATION })
	target:KnockBack(caster, self, {
		duration = PUNCH_STUN_DURATION,
		distance = PUNCH_KNOCKBACK_DISTANCE,
		height = 0,
		stun = true,
		stunDuration = PUNCH_STUN_DURATION,
		direction = direction,
	})
	self:SummonMirror(caster, target)
end
function elite_300.prototype.SummonMirror(self, caster, target)
	if not IsValidAlive(nil, target) then
		return
	end
	if not IsValidAlive(nil, caster) then
		return
	end
	local summonPos = self:ResolveSafeMirrorSpawnPoint(caster, target)
	if not summonPos then
		return
	end
	local ____this_5
	____this_5 = caster
	local ____opt_4 = ____this_5.GetRoomId
	local roomId = ____opt_4 and ____opt_4(____this_5)
	MyGameUnit:CreateSummonedUnitAsync({
		unitName = MIRROR_UNIT_NAME,
		summonTag = (MIRROR_SUMMON_TAG .. "_") .. tostring(caster:entindex()),
		maxSummons = MIRROR_MAX_COUNT,
		position = summonPos,
		roomId = roomId,
		team = caster:GetTeamNumber(),
		owner = caster,
		summoner = caster,
		destroyWithSummoner = true,
		findClearSpace = true,
		onSpawn = function(____, unit)
			if not unit or not IsValidAlive(nil, unit) then
				return
			end
			if not IsValidAlive(nil, caster) then
				MyGameUnit:DestroyUnit(unit)
				return
			end
			local actualSpawnPos = GetGroundPosition(unit:GetAbsOrigin(), unit)
			if not self:IsSafeMirrorSpawnPoint(caster, actualSpawnPos) then
				MyGameUnit:DestroyUnit(unit)
				return
			end
			self:ApplyMirrorCombatAttributes(caster, unit)
			EmitSoundOn(MIRROR_SPAWN_SOUND, unit)
			local mirrorState = modifier_elite_300_mirror_state:applys(
				unit,
				caster,
				self,
				{ duration = -1, visual_player_id = -1, invisibility_level = 1 }
			)
			self:Timer(FrameTime(), function()
				if not IsValidAlive(nil, unit) or not IsValidAlive(nil, caster) then
					return
				end
				local ____IsValidAlive_result_6
				if IsValidAlive(nil, target) then
					____IsValidAlive_result_6 = self:ApplyMirrorVisuals(target, unit)
				else
					____IsValidAlive_result_6 = -1
				end
				local visualPlayerId = ____IsValidAlive_result_6
				mirrorState:RevealAfterVisuals(visualPlayerId)
				if IsValidAlive(nil, target) then
					unit:SetForwardVectorWithoutInterrupt(GetDirection(nil, target:GetAbsOrigin(), unit:GetAbsOrigin()))
					unit:MoveToTargetToAttack(target)
				end
			end)
		end,
		onDeath = function(____, unit)
			unit:AddNoDraw()
		end,
	})
end
function elite_300.prototype.ResolveSafeMirrorSpawnPoint(self, caster, target)
	local targetOrigin = GetGroundPosition(target:GetAbsOrigin(), target)
	local candidates = {
		targetOrigin:__add(RandomVector(MIRROR_SPAWN_RADIUS)),
		targetOrigin:__add(Vector(MIRROR_SPAWN_RADIUS, 0, 0)),
		targetOrigin:__add(Vector(-MIRROR_SPAWN_RADIUS, 0, 0)),
		targetOrigin:__add(Vector(0, MIRROR_SPAWN_RADIUS, 0)),
		targetOrigin:__add(Vector(0, -MIRROR_SPAWN_RADIUS, 0)),
		targetOrigin,
	}
	for ____, candidate in ipairs(candidates) do
		local currentCandidate = GetGroundPosition(candidate, caster)
		if self:IsSafeMirrorSpawnPoint(caster, currentCandidate) then
			return currentCandidate
		end
	end
	return nil
end
function elite_300.prototype.IsSafeMirrorSpawnPoint(self, caster, point)
	local casterOrigin = GetGroundPosition(caster:GetAbsOrigin(), caster)
	if not IsGridNavDisplacementWalkable(nil, casterOrigin) then
		return false
	end
	if not IsGridNavDisplacementWalkable(nil, point) then
		return false
	end
	if not GridNav:CanFindPath(casterOrigin, point) then
		return false
	end
	return GridNav:FindPathLength(casterOrigin, point) ~= -1
end
function elite_300.prototype.ApplyMirrorCombatAttributes(self, caster, mirror)
	if not MyGameAttribute:HasAttributes(caster) or not MyGameAttribute:HasAttributes(mirror) then
		return
	end
	local targetHealth = math.max(1, MyGameAttribute:GetAttribute(caster, "total_health") * MIRROR_ATTRIBUTE_RATE)
	local targetAttack =
		math.max(0, MyGameAttribute:GetAttribute(caster, "total_attack_damage") * MIRROR_ATTRIBUTE_RATE)
	local targetArmor = MyGameAttribute:GetAttribute(caster, "total_armor") * MIRROR_ATTRIBUTE_RATE
	local targetMagicResistance = MyGameAttribute:GetAttribute(caster, "total_magic_resistance") * MIRROR_ATTRIBUTE_RATE
	MyGameAttribute:RunAttributeBatch(mirror, function()
		self:SetMirrorTotalAttribute(mirror, "bonus_health", "total_health", targetHealth, "health")
		self:SetMirrorTotalAttribute(mirror, "bonus_attack_damage", "total_attack_damage", targetAttack, "attack")
		self:SetMirrorTotalAttribute(mirror, "base_armor", "total_armor", targetArmor, "armor")
		self:SetMirrorTotalAttribute(
			mirror,
			"base_magic_resistance",
			"total_magic_resistance",
			targetMagicResistance,
			"magic_resistance"
		)
	end)
	mirror:SetHealth(mirror:GetMaxHealth())
end
function elite_300.prototype.SetMirrorTotalAttribute(self, mirror, addKey, totalKey, targetValue, sourceSuffix)
	local currentValue = MyGameAttribute:GetAttribute(mirror, totalKey)
	MyGameAttribute:SetOrReplaceModifierBySource(
		mirror,
		addKey,
		targetValue - currentValue,
		(MIRROR_ATTRIBUTE_SOURCE_PREFIX .. "_") .. sourceSuffix
	)
end
function elite_300.prototype.ApplyMirrorVisuals(self, source, mirror)
	if not IsValidAlive(nil, source) then
		return -1
	end
	local playerId = source:GetPlayerId()
	if playerId < 0 then
		return playerId
	end
	local player = MyGamePlayers:getPlayer(playerId)
	local ____opt_7 = player and player.playerWearables
	if ____opt_7 ~= nil then
		____opt_7:copyManagedVisuals(source, mirror)
	end
	return playerId
end
function elite_300.prototype.FindTarget(self)
	local caster = self:GetCaster()
	if not IsValidAlive(nil, caster) then
		return nil
	end
	return caster:GetMinDistanceUnit(SEARCH_RANGE)
end
elite_300 = __TS__DecorateLegacy({ registerAbility(nil) }, elite_300)
____exports.elite_300 = elite_300
modifier_elite_300_mirror_state = __TS__Class()
modifier_elite_300_mirror_state.name = "modifier_elite_300_mirror_state"
__TS__ClassExtends(modifier_elite_300_mirror_state, MonsterModifier_CS)
function modifier_elite_300_mirror_state.prototype.____constructor(self, ...)
	MonsterModifier_CS.prototype.____constructor(self, ...)
	self.invisibilityLevel = 1
end
function modifier_elite_300_mirror_state.prototype.OnCreated(self, params)
	if not IsServer() then
		return
	end
	self.visualPlayerId = params and params.visual_player_id
	self.invisibilityLevel = self:normalizeInvisibilityLevel(params and params.invisibility_level)
	self:SetHasCustomTransmitterData(true)
	self:SendBuffRefreshToClients()
	self:applyRenderColor(120, 180, 255)
end
function modifier_elite_300_mirror_state.prototype.AddCustomTransmitterData(self)
	return { invisibilityLevel = self.invisibilityLevel }
end
function modifier_elite_300_mirror_state.prototype.HandleCustomTransmitterData(self, data)
	self.invisibilityLevel = self:normalizeInvisibilityLevel(data and data.invisibilityLevel)
end
function modifier_elite_300_mirror_state.prototype.DeclareFunctions(self)
	return { MODIFIER_PROPERTY_INVISIBILITY_LEVEL }
end
function modifier_elite_300_mirror_state.prototype.CheckState(self)
	return { [MODIFIER_STATE_INVISIBLE] = self.invisibilityLevel > 0 }
end
function modifier_elite_300_mirror_state.prototype.GetModifierInvisibilityLevel(self)
	return self.invisibilityLevel
end
function modifier_elite_300_mirror_state.prototype.RevealAfterVisuals(self, visualPlayerId)
	if not IsServer() then
		return
	end
	self.visualPlayerId = visualPlayerId
	self.invisibilityLevel = 0
	self:applyWearableStatusEffects()
end
function modifier_elite_300_mirror_state.prototype.OnDestroy(self)
	if not IsServer() then
		return
	end
	local parent = self:GetParent()
	if IsValid(nil, parent) and not parent:IsNull() then
		self:applyRenderColor(255, 255, 255)
		self:clearMirrorWearables(parent)
		local pfx =
			ParticleManager:CreateParticle("particles/generic_gameplay/illusion_killed.vpcf", PATTACH_WORLDORIGIN, nil)
		ParticleManager:SetParticleControl(pfx, 0, parent:GetAbsOrigin() + Vector(0, 0, 150))
		ParticleManager:ReleaseParticleIndex(pfx)
	end
end
function modifier_elite_300_mirror_state.prototype.clearMirrorWearables(self, parent)
	if self.visualPlayerId ~= nil and self.visualPlayerId >= 0 then
		local player = MyGamePlayers:getPlayer(self.visualPlayerId)
		local ____opt_17 = player and player.playerWearables
		if ____opt_17 ~= nil then
			____opt_17:clearManagedWearables(parent)
		end
	end
	local ____this_22
	____this_22 = parent
	local ____opt_21 = ____this_22.GetManagedWearableUnits
	for ____, wearable in ipairs(____opt_21 and ____opt_21(____this_22) or {}) do
		do
			if not wearable or not IsValid(nil, wearable) or wearable:IsNull() then
				goto __continue77
			end
			wearable:RemoveSelf()
		end
		::__continue77::
	end
end
function modifier_elite_300_mirror_state.prototype.applyRenderColor(self, red, green, blue)
	local parent = self:GetParent()
	if not parent or not IsValid(nil, parent) or parent:IsNull() then
		return
	end
	parent:SetRenderColor(red, green, blue)
	local ____opt_23 = parent.GetManagedWearableUnits
	for ____, wearable in ipairs(____opt_23 and ____opt_23(parent) or {}) do
		do
			if not wearable or not IsValid(nil, wearable) or wearable:IsNull() then
				goto __continue82
			end
			wearable:SetRenderColor(red, green, blue)
		end
		::__continue82::
	end
end
function modifier_elite_300_mirror_state.prototype.GetStatusEffectName(self)
	return MIRROR_STATUS_EFFECT
end
function modifier_elite_300_mirror_state.prototype.IsHidden(self)
	return true
end
function modifier_elite_300_mirror_state.prototype.IsPurgable(self)
	return false
end
function modifier_elite_300_mirror_state.prototype.RemoveOnDeath(self)
	return true
end
function modifier_elite_300_mirror_state.prototype.normalizeInvisibilityLevel(self, rawValue)
	local level = tonumber(rawValue or 0)
	if level ~= level or level <= 0 then
		return 0
	end
	return math.floor(level)
end
function modifier_elite_300_mirror_state.prototype.applyWearableStatusEffects(self)
	local parent = self:GetParent()
	if not IsValidAlive(nil, parent) then
		return
	end
	if not parent or not IsValid(nil, parent) or parent:IsNull() then
		return
	end
	local ____opt_25 = parent.GetManagedWearableUnits
	for ____, wearable in ipairs(____opt_25 and ____opt_25(parent) or {}) do
		do
			if not wearable or not IsValid(nil, wearable) or wearable:IsNull() then
				goto __continue94
			end
			modifier_elite_300_mirror_wearable_status:applys(wearable, parent, self:GetAbility(), { duration = -1 })
		end
		::__continue94::
	end
end
modifier_elite_300_mirror_state =
	__TS__DecorateLegacy({ registerModifier(nil, "modifier_elite_300_mirror_state") }, modifier_elite_300_mirror_state)
modifier_elite_300_mirror_wearable_status = __TS__Class()
modifier_elite_300_mirror_wearable_status.name = "modifier_elite_300_mirror_wearable_status"
__TS__ClassExtends(modifier_elite_300_mirror_wearable_status, MonsterModifier_CS)
function modifier_elite_300_mirror_wearable_status.prototype.OnCreated(self, _params) end
function modifier_elite_300_mirror_wearable_status.prototype.GetStatusEffectName(self)
	return MIRROR_STATUS_EFFECT
end
function modifier_elite_300_mirror_wearable_status.prototype.IsHidden(self)
	return true
end
function modifier_elite_300_mirror_wearable_status.prototype.IsPurgable(self)
	return false
end
function modifier_elite_300_mirror_wearable_status.prototype.RemoveOnDeath(self)
	return true
end
modifier_elite_300_mirror_wearable_status = __TS__DecorateLegacy(
	{ registerModifier(nil, "modifier_elite_300_mirror_wearable_status") },
	modifier_elite_300_mirror_wearable_status
)
return ____exports