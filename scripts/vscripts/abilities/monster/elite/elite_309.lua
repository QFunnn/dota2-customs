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
local modifier_elite_309_true_body_hidden, modifier_elite_309_shadow_clone
local ____dota_ts_adapter = require("utils.dota_ts_adapter")
local registerAbility = ____dota_ts_adapter.registerAbility
local registerModifier = ____dota_ts_adapter.registerModifier
local ____monster_base = require("abilities.monster.monster_base")
local MonsterAbility_CS = ____monster_base.MonsterAbility_CS
local MonsterModifier_CS = ____monster_base.MonsterModifier_CS
local ____elite_showcase_utils = require("abilities.monster.elite.elite_showcase_utils")
local EliteCreateLimitedWarningTargetTracker = ____elite_showcase_utils.EliteCreateLimitedWarningTargetTracker
local CAST_RANGE = 1000
local WARNING_RADIUS = 280
local WARNING_LOCK_RELEASE_GAP = 0.5
local WARNING_FOLLOW_SPEED = 380
local EMPTY_DASH_DURATION = 0.38
local MARK_BACKSTEP_DURATION = 0.3
local WARNING_DURATION = 1
local CAST_POINT = WARNING_DURATION
local WARNING_FOLLOW_DURATION = math.max(WARNING_DURATION - WARNING_LOCK_RELEASE_GAP, 0)
local MARK_BACKSTEP_DISTANCE = 160
local SHADOW_ANGLE = 120
local SHADOW_CLONE_COUNT = 3
local SHADOW_CLONE_MAX_COUNT = 3
local SHADOW_SUMMON_TAG = "elite_309_shadow_clone"
local SHADOW_DASH_DURATION = 0.42
local SHADOW_CLONE_END_HOLD_DURATION = 1
local SHADOW_CLONE_FADE_OUT_DURATION = 1
local SHADOW_CLONE_LIFETIME = SHADOW_DASH_DURATION
	+ SHADOW_CLONE_END_HOLD_DURATION
	+ SHADOW_CLONE_FADE_OUT_DURATION
	+ 0.1
local TRUE_BODY_REVEAL_DELAY = 1
local TRUE_BODY_AIR_HEIGHT = 460
local TRUE_BODY_ARC_HEIGHT = 620
local TRUE_BODY_DROP_DURATION = 0.5
local TARGET_POST_IMPACT_STUN_DURATION = 2
local TARGET_LOCK_STUN_DURATION = MARK_BACKSTEP_DURATION
	+ TRUE_BODY_REVEAL_DELAY
	+ TRUE_BODY_DROP_DURATION
	+ TARGET_POST_IMPACT_STUN_DURATION
local TRUE_BODY_HIT_RADIUS = 260
local SHADOW_DAMAGE_RATE = 5
local TRUE_BODY_DAMAGE_RATE = 25
local SCREEN_SHAKE_AMPLITUDE = 12
local SCREEN_SHAKE_FREQUENCY = 12
local SCREEN_SHAKE_DURATION = 0.2
local SCREEN_SHAKE_RADIUS = 1800
local WINDWALK_PARTICLE = "particles/units/heroes/hero_bounty_hunter/bounty_hunter_windwalk.vpcf"
local HIT_PARTICLE = "particles/bounty_hunter_jinda_slow2.vpcf"
local SHADOW_IMPACT_PARTICLE = "particles/monster/elite_309_1pa_persona_crit_impact.vpcf"
local SHADOW_STATUS_PARTICLE =
	"particles/econ/items/phantom_assassin/pa_fall20_immortal_shoulders/pa_fall20_blur_start.vpcf"
local SHADOW_SMOKE_PARTICLE =
	"particles/econ/items/windrunner/windranger_arcana/windranger_arcana_item_force_staff_v2.vpcf"
local TRUE_BODY_FALL_SLASH_PARTICLE = "particles/monster/elite_309_2.vpcf"
local TARGET_INK_BUFF_PARTICLE = "particles/bb/ink_grimstroke_ink_swell_buff.vpcf"
local TRUE_BODY_IMPACT_EXPLOSION_PARTICLE =
	"particles/units/heroes/hero_grimstroke/grimstroke_sfm_ink_swell_reveal.vpcf"
local MARK_TRACK_PARTICLE = "particles/units/heroes/hero_bounty_hunter/bounty_hunter_track_cast.vpcf"
local SHADOW_CAST_ANIMATION = "hoard_cast_shadow_walk_ally"
local CLONE_ATTACK_ANIMATION = "twinblade_attack_c"
local EMPTY_DASH_ANIMATION = "attack_jinada_alt_anim"
local TRUE_BODY_ATTACK_ANIMATION = "hoard_attack_alt_d"
local MARK_SOUND = "Hero_Grimstroke.InkSwell.Cast"
local SHADOW_SPAWN_SOUND = "Hero_BountyHunter.WindWalk"
local SHADOW_IMPACT_SOUND = "Hero_BountyHunter.Jinada"
local TRUE_BODY_IMPACT_SOUND = "Hero_Grimstroke.InkSwell.Stun"
local SHADOW_CLONE_HIDDEN_MODEL = "models/heroes/wisp/wisp.vmdl"
local SHADOW_CLONE_HIDDEN_MODEL_SCALE = 0.01
--- 仅供影袭处决使用的单点落脚校验。
local function IsSafeElite309Point(self, unit, origin, target)
	local startPoint = GetGroundPosition(origin, unit)
	local targetPoint = GetGroundPosition(target, unit)
	if not IsGridNavDisplacementWalkable(nil, startPoint) or not IsGridNavDisplacementWalkable(nil, targetPoint) then
		return false
	end
	if not GridNav:CanFindPath(startPoint, targetPoint) then
		return false
	end
	return GridNav:FindPathLength(startPoint, targetPoint) ~= -1
end
--- 影分身移动前校验其整条直线路径，避免表现单位穿过边界。
local function IsSafeElite309ClonePath(self, unit, origin, target)
	if not IsSafeElite309Point(nil, unit, origin, target) then
		return false
	end
	local startPoint = GetGroundPosition(origin, unit)
	local targetPoint = GetGroundPosition(target, unit)
	local delta = targetPoint:__sub(startPoint)
	local sampleCount = math.max(1, math.ceil(delta:Length2D() / 32))
	do
		local index = 1
		while index <= sampleCount do
			local currentIndex = index
			local samplePoint = GetGroundPosition(startPoint:__add(delta:__mul(currentIndex / sampleCount)), unit)
			if not IsGridNavDisplacementWalkable(nil, samplePoint) then
				return false
			end
			index = index + 1
		end
	end
	return true
end
--- 影袭本体位移失败时留在原地，不为保留表现而进入不可达区。
local function ResolveSafeElite309Point(self, unit, origin, intendedPoint)
	local ____IsSafeElite309Point_result_0
	if IsSafeElite309Point(nil, unit, origin, intendedPoint) then
		____IsSafeElite309Point_result_0 = GetGroundPosition(intendedPoint, unit)
	else
		____IsSafeElite309Point_result_0 = nil
	end
	return ____IsSafeElite309Point_result_0
end
____exports.elite_309 = __TS__Class()
local elite_309 = ____exports.elite_309
elite_309.name = "elite_309"
__TS__ClassExtends(elite_309, MonsterAbility_CS)
function elite_309.prototype.____constructor(self, ...)
	MonsterAbility_CS.prototype.____constructor(self, ...)
	self.castToken = 0
end
function elite_309.prototype.Precache(self, context)
	PrecacheResource("particle", WINDWALK_PARTICLE, context)
	PrecacheResource("particle", HIT_PARTICLE, context)
	PrecacheResource("particle", SHADOW_IMPACT_PARTICLE, context)
	PrecacheResource("particle", SHADOW_STATUS_PARTICLE, context)
	PrecacheResource("particle", SHADOW_SMOKE_PARTICLE, context)
	PrecacheResource("particle", TRUE_BODY_FALL_SLASH_PARTICLE, context)
	PrecacheResource("particle", TARGET_INK_BUFF_PARTICLE, context)
	PrecacheResource("particle", TRUE_BODY_IMPACT_EXPLOSION_PARTICLE, context)
	PrecacheResource("particle", MARK_TRACK_PARTICLE, context)
	PrecacheResource("model", SHADOW_CLONE_HIDDEN_MODEL, context)
	PrecacheResource("soundfile", "soundevents/game_sounds_heroes/game_sounds_bounty_hunter.vsndevts", context)
	PrecacheResource("soundfile", "soundevents/game_sounds_heroes/game_sounds_grimstroke.vsndevts", context)
end
function elite_309.prototype.GetMosnterAbilityConfig(self)
	return {
		castRange = CAST_RANGE,
		behavior = DOTA_ABILITY_BEHAVIOR_NO_TARGET,
		castPoint = CAST_POINT,
		castDuration = MARK_BACKSTEP_DURATION + TRUE_BODY_REVEAL_DELAY + TRUE_BODY_DROP_DURATION + 0.3,
		cooldown = 13,
		OnPhaseStart = function()
			return self:PrepareAmbush()
		end,
		OnStart = function()
			return self:StartAmbush()
		end,
		OnInterrupt = function()
			return self:CancelAmbush()
		end,
		OnFinish = function()
			return self:ClearPreparedAmbush()
		end,
	}
end
function elite_309.prototype.PrepareAmbush(self)
	local caster = self:GetCaster()
	if not IsValidAlive(nil, caster) then
		return
	end
	local target = self:FindTarget()
	local tracker = self:CreateWarningTargetTracker(caster, WARNING_FOLLOW_DURATION, target)
	self.prepared = { tracker = tracker }
	local warningPoint = tracker:getCenter()
	self:FacePoint(caster, warningPoint)
	caster:SetAnimation(SHADOW_CAST_ANIMATION)
	self:WarningRingEffect(warningPoint, WARNING_RADIUS, WARNING_DURATION, {
		getCenter = function()
			local center = tracker:update()
			self:FacePoint(caster, center)
			return center
		end,
	})
end
function elite_309.prototype.StartAmbush(self)
	local caster = self:GetCaster()
	if not IsValidAlive(nil, caster) then
		return
	end
	self.castToken = self.castToken + 1
	local currentToken = self.castToken
	local ____opt_1 = self.prepared
	local warningPoint = ____opt_1 and ____opt_1.tracker:getCenter() or self:ResolveFallbackPoint(caster)
	self:FacePoint(caster, warningPoint)
	local target = self:FindHeroInWarningArea(caster, warningPoint)
	if not IsValidAlive(nil, target) then
		self:StartEmptyDash(caster, warningPoint)
		return
	end
	self:StartShadowExecution(caster, target, currentToken)
end
function elite_309.prototype.StartEmptyDash(self, caster, warningPoint)
	if not IsValidAlive(nil, caster) then
		return
	end
	local endPoint = ResolveSafeElite309Point(nil, caster, caster:GetAbsOrigin(), warningPoint)
	if not endPoint then
		return
	end
	self:FacePoint(caster, endPoint)
	caster:SetAnimation(EMPTY_DASH_ANIMATION)
	EmitSoundOn(SHADOW_SPAWN_SOUND, caster)
	self:PlayWindwalkEffect(caster)
	caster:Mover(endPoint, EMPTY_DASH_DURATION, nil, false, true)
end
function elite_309.prototype.StartShadowExecution(self, caster, target, token)
	if not IsValidAlive(nil, caster) or not IsValidAlive(nil, target) then
		return
	end
	local targetPoint = GetGroundPosition(target:GetAbsOrigin(), caster)
	AddDeBuffStatus(nil, target, caster, self, DebuffStatusType.STUN, { duration = TARGET_LOCK_STUN_DURATION })
	if not IsValidAlive(nil, caster) or not IsValidAlive(nil, target) then
		return
	end
	self:PlayTargetInkBuffEffect(target, TARGET_LOCK_STUN_DURATION)
	self:StartMarkBackstep(caster, target, targetPoint)
	self:Timer(MARK_BACKSTEP_DURATION, function()
		if token ~= self.castToken or not IsValidAlive(nil, caster) then
			return
		end
		caster:FadeGesture(ACT_DOTA_CAST_ABILITY_4)
		if not IsValidAlive(nil, target) then
			self:StartEmptyDash(caster, targetPoint)
			return
		end
		local origin = GetGroundPosition(caster:GetAbsOrigin(), caster)
		local lockedTargetPoint = GetGroundPosition(target:GetAbsOrigin(), caster)
		local paths = self:ResolveShadowPaths(caster, origin, lockedTargetPoint)
		local hideDuration = TRUE_BODY_REVEAL_DELAY + TRUE_BODY_DROP_DURATION + 0.2
		modifier_elite_309_true_body_hidden:applys(caster, caster, self, { duration = hideDuration })
		EmitSoundOn(SHADOW_SPAWN_SOUND, caster)
		self:PlayWindwalkEffect(caster)
		self:SummonShadowClones(caster, target, paths)
		self:Timer(TRUE_BODY_REVEAL_DELAY, function()
			if token ~= self.castToken or not IsValidAlive(nil, caster) then
				return
			end
			self:StartTrueBodyDrop(caster, origin, lockedTargetPoint)
		end)
	end)
end
function elite_309.prototype.StartMarkBackstep(self, caster, target, targetPoint)
	local origin = caster:GetAbsOrigin()
	local awayDirection = GetDirection(nil, origin, targetPoint)
	local intendedBackstepPoint = GetGroundPosition(origin:__add(awayDirection:__mul(MARK_BACKSTEP_DISTANCE)), caster)
	local backstepPoint = ResolveSafeElite309Point(nil, caster, origin, intendedBackstepPoint) or origin
	caster:SetForwardVectorWithoutInterrupt(GetDirection(nil, targetPoint, origin))
	caster:StartGestureWithFadeAndPlaybackRate(ACT_DOTA_CAST_ABILITY_4, 0.05, 0.15, 1)
	caster:Mover(backstepPoint, MARK_BACKSTEP_DURATION, nil, false, true)
	self:PlayMarkTrackEffect(caster, target)
	EmitSoundOn(MARK_SOUND, caster)
end
function elite_309.prototype.SummonShadowClones(self, caster, target, paths)
	local unitName = caster:GetUnitName()
	local ____this_4
	____this_4 = caster
	local ____opt_3 = ____this_4.GetRoomId
	local roomId = ____opt_3 and ____opt_3(____this_4)
	if not IsValidAlive(nil, target) then
		return
	end
	local targetEntIndex = target:entindex()
	do
		local index = 0
		while index < #paths do
			local currentPath = paths[index + 1]
			local currentStart = currentPath.start
			local currentEnd = currentPath["end"]
			MyGameUnit:CreateSummonedUnitAsync({
				unitName = unitName,
				summonTag = (SHADOW_SUMMON_TAG .. "_") .. tostring(caster:entindex()),
				maxSummons = SHADOW_CLONE_MAX_COUNT,
				position = currentStart,
				roomId = roomId,
				team = caster:GetTeamNumber(),
				owner = caster,
				summoner = caster,
				destroyWithSummoner = true,
				findClearSpace = false,
				onSpawn = function(____, clone)
					if not clone or not IsValidAlive(nil, clone) then
						return
					end
					if not IsValidAlive(nil, caster) then
						MyGameUnit:DestroyUnit(clone)
						return
					end
					clone:SetOwner(caster)
					clone:SetAbsOrigin(currentStart)
					clone:SetForwardVectorWithoutInterrupt(GetDirection(nil, currentEnd, currentStart))
					self:PlayWindwalkEffect(clone)
					EmitSoundOn(SHADOW_SPAWN_SOUND, clone)
					modifier_elite_309_shadow_clone:applys(clone, caster, self, {
						duration = SHADOW_CLONE_LIFETIME,
						start_x = currentStart.x,
						start_y = currentStart.y,
						start_z = currentStart.z,
						end_x = currentEnd.x,
						end_y = currentEnd.y,
						end_z = currentEnd.z,
						target_entindex = targetEntIndex,
					})
				end,
			})
			index = index + 1
		end
	end
end
function elite_309.prototype.StartTrueBodyDrop(self, caster, origin, targetPoint)
	if not IsValidAlive(nil, caster) then
		return
	end
	local startPoint = GetGroundPosition(origin, caster)
	local landingPoint = ResolveSafeElite309Point(nil, caster, startPoint, targetPoint)
	if not landingPoint then
		return
	end
	local startAirPoint = startPoint:__add(Vector(0, 0, TRUE_BODY_AIR_HEIGHT))
	local arcControlPoint = self:ResolveDropArcControlPoint(startPoint, landingPoint)
	modifier_elite_309_true_body_hidden:remove(caster)
	if not IsValidAlive(nil, caster) then
		return
	end
	caster:SetAbsOrigin(startAirPoint)
	caster:SetForwardVectorWithoutInterrupt(GetDirection(nil, landingPoint, startPoint))
	caster:SetAnimation(TRUE_BODY_ATTACK_ANIMATION)
	caster:Bezier2Mover({ startAirPoint, arcControlPoint, landingPoint }, TRUE_BODY_DROP_DURATION, nil, true)
	self:Timer(TRUE_BODY_DROP_DURATION * 0.5, function()
		if not IsValidAlive(nil, caster) then
			return
		end
		self:PlayTrueBodyFallSlashEffect(caster, landingPoint)
	end)
	self:Timer(TRUE_BODY_DROP_DURATION, function()
		if not IsValidAlive(nil, caster) then
			return
		end
		FindClearSpaceForUnit(caster, landingPoint, true)
		if not IsValidAlive(nil, caster) then
			return
		end
		self:ApplyTrueBodyImpact(caster, landingPoint)
	end)
end
function elite_309.prototype.ApplyTrueBodyImpact(self, caster, point)
	if not IsValidAlive(nil, caster) then
		return
	end
	self:PlayHitEffect(caster, point, TRUE_BODY_HIT_RADIUS)
	self:PlayTrueBodyImpactExplosionEffect(caster, point)
	self:PlayScreenShake(point)
	EmitSoundOnLocationWithCaster(point, TRUE_BODY_IMPACT_SOUND, caster)
	local enemies = FindUnitsInRadius(
		caster:GetTeamNumber(),
		point,
		nil,
		TRUE_BODY_HIT_RADIUS,
		DOTA_UNIT_TARGET_TEAM_ENEMY,
		DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,
		DOTA_UNIT_TARGET_FLAG_NONE,
		FIND_ANY_ORDER,
		false
	)
	for ____, enemy in ipairs(enemies) do
		do
			if not IsValidAlive(nil, enemy) then
				goto __continue51
			end
			caster:MonsterDamage({
				victim = enemy,
				damage_rate = TRUE_BODY_DAMAGE_RATE,
				ability = self,
				effectName = HIT_PARTICLE,
			})
		end
		::__continue51::
	end
end
function elite_309.prototype.ResolveShadowPaths(self, caster, origin, targetPoint)
	local distance = math.max(GetDistance(nil, origin, targetPoint), 220)
	local fromTargetToOrigin = GetDirection(nil, origin, targetPoint)
	local starts = {
		origin,
		GetGroundPosition(
			targetPoint:__add(RotateVector2D(nil, fromTargetToOrigin, SHADOW_ANGLE):__mul(distance)),
			caster
		),
		GetGroundPosition(
			targetPoint:__add(RotateVector2D(nil, fromTargetToOrigin, -SHADOW_ANGLE):__mul(distance)),
			caster
		),
	}
	local paths = {}
	do
		local index = 0
		while index < math.min(SHADOW_CLONE_COUNT, #starts) do
			do
				local currentStart = starts[index + 1]
				local safeStart = ResolveSafeElite309Point(nil, caster, targetPoint, currentStart)
				if not safeStart or not IsSafeElite309ClonePath(nil, caster, safeStart, targetPoint) then
					goto __continue55
				end
				paths[#paths + 1] = { start = safeStart, ["end"] = targetPoint }
			end
			::__continue55::
			index = index + 1
		end
	end
	return paths
end
function elite_309.prototype.ResolveDropArcControlPoint(self, startPoint, landingPoint)
	local middle = startPoint:__add(landingPoint):__mul(0.5)
	return Vector(middle.x, middle.y, math.max(startPoint.z, landingPoint.z) + TRUE_BODY_ARC_HEIGHT)
end
function elite_309.prototype.CreateWarningTargetTracker(self, caster, followDuration, initialTarget)
	return EliteCreateLimitedWarningTargetTracker(nil, {
		caster = caster,
		initialTarget = initialTarget,
		followDuration = followDuration,
		followSpeed = WARNING_FOLLOW_SPEED,
		resolveTarget = function()
			return self:FindTarget()
		end,
		resolveTargetPoint = function(____, target)
			return self:ResolveWarningPoint(caster, target)
		end,
		resolveFallbackPoint = function()
			return self:ResolveFallbackPoint(caster)
		end,
	})
end
function elite_309.prototype.FindHeroInWarningArea(self, caster, warningPoint)
	local enemies = FindUnitsInRadius(
		caster:GetTeamNumber(),
		warningPoint,
		nil,
		WARNING_RADIUS,
		DOTA_UNIT_TARGET_TEAM_ENEMY,
		DOTA_UNIT_TARGET_HERO,
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
function elite_309.prototype.ResolveFallbackPoint(self, caster)
	local origin = caster:GetAbsOrigin()
	return GetGroundPosition(origin:__add(caster:GetForwardVector():__mul(520)), caster)
end
function elite_309.prototype.ResolveWarningPoint(self, caster, target)
	local ____IsValidAlive_result_5
	if IsValidAlive(nil, target) then
		____IsValidAlive_result_5 = GetGroundPosition(target:GetAbsOrigin(), caster)
	else
		____IsValidAlive_result_5 = self:ResolveFallbackPoint(caster)
	end
	return ____IsValidAlive_result_5
end
function elite_309.prototype.FacePoint(self, caster, point)
	if not IsValidAlive(nil, caster) or point == nil then
		return
	end
	local direction = GetDirection(nil, point, caster:GetAbsOrigin())
	if direction:Length2D() > 0.01 then
		caster:SetForwardVectorWithoutInterrupt(direction)
	end
end
function elite_309.prototype.FindTarget(self)
	local caster = self:GetCaster()
	if not IsValidAlive(nil, caster) then
		return nil
	end
	return caster:GetMinDistanceUnit(CAST_RANGE)
end
function elite_309.prototype.PlayWindwalkEffect(self, caster)
	local particle = ParticleManager:CreateParticle(WINDWALK_PARTICLE, PATTACH_ABSORIGIN_FOLLOW, caster)
	ParticleManager:SetParticleControlEnt(
		particle,
		0,
		caster,
		PATTACH_POINT_FOLLOW,
		"attach_hitloc",
		caster:GetAbsOrigin(),
		true
	)
	ParticleManager:ReleaseParticleIndex(particle)
end
function elite_309.prototype.PlayHitEffect(self, caster, point, radius)
	local particle = ParticleManager:CreateParticle(HIT_PARTICLE, PATTACH_WORLDORIGIN, caster)
	ParticleManager:SetParticleControl(particle, 0, point)
	ParticleManager:SetParticleControl(particle, 1, Vector(radius, radius, 0))
	ParticleManager:ReleaseParticleIndex(particle)
end
function elite_309.prototype.PlayTrueBodyFallSlashEffect(self, caster, landingPoint)
	local particle = ParticleManager:CreateParticle(TRUE_BODY_FALL_SLASH_PARTICLE, PATTACH_CENTER_FOLLOW, caster)
	ParticleManager:SetParticleControlEnt(
		particle,
		0,
		caster,
		PATTACH_CENTER_FOLLOW,
		"attach_hitloc",
		caster:GetAbsOrigin(),
		true
	)
	ParticleManager:SetParticleControlForward(particle, 0, GetDirection(nil, landingPoint, caster:GetAbsOrigin()))
	ParticleManager:ReleaseParticleIndex(particle)
end
function elite_309.prototype.PlayTargetInkBuffEffect(self, target, duration)
	local particle = ParticleManager:CreateParticle(TARGET_INK_BUFF_PARTICLE, PATTACH_CENTER_FOLLOW, target)
	ParticleManager:SetParticleControlEnt(
		particle,
		0,
		target,
		PATTACH_CENTER_FOLLOW,
		"attach_hitloc",
		target:GetAbsOrigin(),
		true
	)
	self:Timer(duration, function()
		ParticleManager:DestroyParticle(particle, false)
		ParticleManager:ReleaseParticleIndex(particle)
	end)
end
function elite_309.prototype.PlayTrueBodyImpactExplosionEffect(self, caster, point)
	local particle = ParticleManager:CreateParticle(TRUE_BODY_IMPACT_EXPLOSION_PARTICLE, PATTACH_WORLDORIGIN, caster)
	ParticleManager:SetParticleControl(particle, 0, point)
	ParticleManager:SetParticleControl(particle, 1, point)
	ParticleManager:ReleaseParticleIndex(particle)
end
function elite_309.prototype.PlayMarkTrackEffect(self, caster, target)
	local particle = ParticleManager:CreateParticle(MARK_TRACK_PARTICLE, PATTACH_CUSTOMORIGIN, caster)
	ParticleManager:SetParticleControlEnt(
		particle,
		0,
		caster,
		PATTACH_POINT_FOLLOW,
		"attach_hitloc",
		caster:GetAbsOrigin(),
		true
	)
	ParticleManager:SetParticleControlEnt(
		particle,
		1,
		target,
		PATTACH_POINT_FOLLOW,
		"attach_hitloc",
		target:GetAbsOrigin(),
		true
	)
	ParticleManager:ReleaseParticleIndex(particle)
end
function elite_309.prototype.PlayScreenShake(self, point)
	ScreenShake(
		point,
		SCREEN_SHAKE_AMPLITUDE,
		SCREEN_SHAKE_FREQUENCY,
		SCREEN_SHAKE_DURATION,
		SCREEN_SHAKE_RADIUS,
		0,
		true
	)
end
function elite_309.prototype.CancelAmbush(self)
	self.castToken = self.castToken + 1
	local caster = self:GetCaster()
	if IsValidAlive(nil, caster) then
		caster:FadeGesture(ACT_DOTA_CAST_ABILITY_4)
		modifier_elite_309_true_body_hidden:remove(caster)
	end
	self:ClearPreparedAmbush()
end
function elite_309.prototype.ClearPreparedAmbush(self)
	self.prepared = nil
end
elite_309 = __TS__DecorateLegacy({ registerAbility(nil) }, elite_309)
____exports.elite_309 = elite_309
modifier_elite_309_true_body_hidden = __TS__Class()
modifier_elite_309_true_body_hidden.name = "modifier_elite_309_true_body_hidden"
__TS__ClassExtends(modifier_elite_309_true_body_hidden, MonsterModifier_CS)
function modifier_elite_309_true_body_hidden.prototype.OnCreated(self)
	if not IsServer() then
		return
	end
	self:GetParent():AddNoDrawWithWearables()
end
function modifier_elite_309_true_body_hidden.prototype.OnDestroy(self)
	if not IsServer() then
		return
	end
	local parent = self:GetParent()
	if not IsValid(nil, parent) or parent:IsNull() then
		return
	end
	parent:RemoveNoDrawWithWearables()
end
function modifier_elite_309_true_body_hidden.prototype.CheckState(self)
	return {
		[MODIFIER_STATE_STUNNED] = true,
		[MODIFIER_STATE_INVULNERABLE] = true,
		[MODIFIER_STATE_NO_UNIT_COLLISION] = true,
		[MODIFIER_STATE_NO_HEALTH_BAR] = true,
	}
end
function modifier_elite_309_true_body_hidden.prototype.IsHidden(self)
	return true
end
function modifier_elite_309_true_body_hidden.prototype.IsPurgable(self)
	return false
end
modifier_elite_309_true_body_hidden = __TS__DecorateLegacy(
	{ registerModifier(nil, "modifier_elite_309_true_body_hidden") },
	modifier_elite_309_true_body_hidden
)
modifier_elite_309_shadow_clone = __TS__Class()
modifier_elite_309_shadow_clone.name = "modifier_elite_309_shadow_clone"
__TS__ClassExtends(modifier_elite_309_shadow_clone, MonsterModifier_CS)
function modifier_elite_309_shadow_clone.prototype.____constructor(self, ...)
	MonsterModifier_CS.prototype.____constructor(self, ...)
	self.startPoint = Vector(0, 0, 0)
	self.endPoint = Vector(0, 0, 0)
	self.pathForward = Vector(1, 0, 0)
	self.hasPlayedImpact = false
	self.hasStartedFadeOut = false
end
function modifier_elite_309_shadow_clone.prototype.OnCreated(self, params)
	if not IsServer() then
		return
	end
	self.startPoint =
		Vector(params and params.start_x or 0, params and params.start_y or 0, params and params.start_z or 0)
	self.endPoint = Vector(params and params.end_x or 0, params and params.end_y or 0, params and params.end_z or 0)
	self.targetEntIndex = params and params.target_entindex
	self.pathForward = GetDirection(nil, self.endPoint, self.startPoint)
	local clone = self:GetParent()
	if not IsValidAlive(nil, clone) then
		self:Destroy()
		return
	end
	if not IsSafeElite309ClonePath(nil, clone, self.startPoint, self.endPoint) then
		self:Destroy()
		return
	end
	clone:SetAbsOrigin(self.startPoint)
	clone:SetForwardVectorWithoutInterrupt(self.pathForward)
	clone:SetAnimation(CLONE_ATTACK_ANIMATION)
	self:StartCloneEffects()
	self:StartIntervalThink(FrameTime())
end
function modifier_elite_309_shadow_clone.prototype.OnIntervalThink(self)
	if not IsServer() then
		return
	end
	local clone = self:GetParent()
	local caster = self:GetCaster()
	if not IsValidAlive(nil, clone) or not IsValidAlive(nil, caster) then
		self:Destroy()
		return
	end
	local elapsedTime = self:GetElapsedTime()
	local progress = math.min(elapsedTime / SHADOW_DASH_DURATION, 1)
	local nextPosition = self:ResolvePosition(progress)
	clone:SetForwardVectorWithoutInterrupt(self.pathForward)
	clone:SetAbsOrigin(nextPosition)
	if not self.hasPlayedImpact and progress >= 0.85 then
		self.hasPlayedImpact = true
		self:PlayShadowImpact()
	end
	local fadeOutStartTime = SHADOW_DASH_DURATION + SHADOW_CLONE_END_HOLD_DURATION
	if elapsedTime >= fadeOutStartTime then
		if not self.hasStartedFadeOut then
			self:BeginCloneFadeOut()
		end
		if elapsedTime >= fadeOutStartTime + SHADOW_CLONE_FADE_OUT_DURATION then
			self:Destroy()
		end
	end
end
function modifier_elite_309_shadow_clone.prototype.BeginCloneFadeOut(self)
	local clone = self:GetParent()
	if not IsValidAlive(nil, clone) then
		return
	end
	if not IsValid(nil, clone) or clone:IsNull() then
		return
	end
	self.hasStartedFadeOut = true
	clone:SetAbsOrigin(self.endPoint)
	clone:SetForwardVectorWithoutInterrupt(self.pathForward)
	clone:SetOriginalModel(SHADOW_CLONE_HIDDEN_MODEL)
	clone:SetModel(SHADOW_CLONE_HIDDEN_MODEL)
	clone:SetModelScale(SHADOW_CLONE_HIDDEN_MODEL_SCALE)
	clone:AddNoDrawToManagedWearables()
	self:StopCloneEffects()
end
function modifier_elite_309_shadow_clone.prototype.OnDestroy(self)
	if not IsServer() then
		return
	end
	self:StartIntervalThink(-1)
	self:StopCloneEffects()
	local clone = self:GetParent()
	if not IsValid(nil, clone) or clone:IsNull() or clone.__remove then
		return
	end
	clone:AddNoDraw()
	MyGameUnit:DestroyUnit(clone)
end
function modifier_elite_309_shadow_clone.prototype.DeclareFunctions(self)
	return { MODIFIER_PROPERTY_OVERRIDE_ANIMATION }
end
function modifier_elite_309_shadow_clone.prototype.GetOverrideAnimation(self)
	return ACT_DOTA_ATTACK
end
function modifier_elite_309_shadow_clone.prototype.CheckState(self)
	return {
		[MODIFIER_STATE_STUNNED] = true,
		[MODIFIER_STATE_SILENCED] = true,
		[MODIFIER_STATE_DISARMED] = true,
		[MODIFIER_STATE_INVULNERABLE] = true,
		[MODIFIER_STATE_UNSELECTABLE] = true,
		[MODIFIER_STATE_NO_HEALTH_BAR] = true,
		[MODIFIER_STATE_NO_UNIT_COLLISION] = true,
	}
end
function modifier_elite_309_shadow_clone.prototype.IsHidden(self)
	return true
end
function modifier_elite_309_shadow_clone.prototype.IsPurgable(self)
	return false
end
function modifier_elite_309_shadow_clone.prototype.ResolvePosition(self, progress)
	local offset = self.endPoint:__sub(self.startPoint)
	return self.startPoint:__add(offset:__mul(progress))
end
function modifier_elite_309_shadow_clone.prototype.StartCloneEffects(self)
	local clone = self:GetParent()
	self:StopCloneEffects()
	self.smokeParticle = ParticleManager:CreateParticle(SHADOW_SMOKE_PARTICLE, PATTACH_ABSORIGIN_FOLLOW, clone)
	ParticleManager:SetParticleControlEnt(
		self.smokeParticle,
		0,
		clone,
		PATTACH_POINT_FOLLOW,
		"attach_hitloc",
		clone:GetAbsOrigin(),
		true
	)
	ParticleManager:SetParticleControlForward(self.smokeParticle, 0, self.pathForward)
end
function modifier_elite_309_shadow_clone.prototype.StopCloneEffects(self)
	if self.smokeParticle ~= nil then
		ParticleManager:DestroyParticle(self.smokeParticle, false)
		ParticleManager:ReleaseParticleIndex(self.smokeParticle)
		self.smokeParticle = nil
	end
end
function modifier_elite_309_shadow_clone.prototype.PlayShadowImpact(self)
	local target = self:GetImpactTarget()
	if not IsValidAlive(nil, target) then
		return
	end
	local caster = self:GetCaster()
	if not IsValidAlive(nil, caster) then
		return
	end
	local particle = ParticleManager:CreateParticle(SHADOW_IMPACT_PARTICLE, PATTACH_ABSORIGIN_FOLLOW, target)
	ParticleManager:SetParticleControlEnt(
		particle,
		0,
		target,
		PATTACH_POINT_FOLLOW,
		"attach_hitloc",
		target:GetAbsOrigin(),
		true
	)
	ParticleManager:SetParticleControlEnt(
		particle,
		1,
		target,
		PATTACH_POINT_FOLLOW,
		"attach_hitloc",
		target:GetAbsOrigin(),
		true
	)
	ParticleManager:SetParticleControlForward(particle, 1, self.pathForward)
	ParticleManager:ReleaseParticleIndex(particle)
	EmitSoundOn(SHADOW_IMPACT_SOUND, target)
	caster:MonsterDamage({
		victim = target,
		damage_rate = SHADOW_DAMAGE_RATE,
		ability = self:GetAbility(),
	})
end
function modifier_elite_309_shadow_clone.prototype.GetImpactTarget(self)
	if self.targetEntIndex == nil then
		return nil
	end
	local target = EntIndexToHScript(self.targetEntIndex)
	if not target or not IsValid(nil, target) or target:IsNull() then
		return nil
	end
	return target
end
modifier_elite_309_shadow_clone =
	__TS__DecorateLegacy({ registerModifier(nil, "modifier_elite_309_shadow_clone") }, modifier_elite_309_shadow_clone)
return ____exports