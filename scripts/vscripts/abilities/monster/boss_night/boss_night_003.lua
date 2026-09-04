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
local __TS__ArrayForEach = ____lualib.__TS__ArrayForEach
local __TS__ArrayPush = ____lualib.__TS__ArrayPush
local __TS__DecorateLegacy = ____lualib.__TS__DecorateLegacy
local ____exports = {}
local modifier_boss_night_003_shadow_shrink
local ____dota_ts_adapter = require("utils.dota_ts_adapter")
local registerAbility = ____dota_ts_adapter.registerAbility
local registerModifier = ____dota_ts_adapter.registerModifier
local ____monster_base = require("abilities.monster.monster_base")
local MonsterAbility_CS = ____monster_base.MonsterAbility_CS
local ____modifier_base = require("modifiers.class.modifier_base")
local BaseModifier_CS = ____modifier_base.BaseModifier_CS
local CAST_POINT = 0.65
local PREPARE_BACKSTEP_DISTANCE = 660
local PREPARE_BACKSTEP_DURATION = 0.5
local PREPARE_SHRINK_DURATION = PREPARE_BACKSTEP_DURATION
local PROJECTILE_WAVE_COUNT = 7
local PROJECTILE_WAVE_DURATION = 2
local PROJECTILE_FIRE_INTERVAL = 0.115
local PROJECTILE_DAMAGE_RATE = 6
local PROJECTILE_BARRAGE_WIDTH = 3360
local PROJECTILE_START_OFFSET = 2300
local PROJECTILE_DISTANCE = 4500
local PROJECTILE_SPEED = 1200
local PROJECTILE_RADIUS = 80
local PROJECTILE_CLUSTER_CHANCE = 35
local PROJECTILE_CLUSTER_INITIAL_GROW_CHANCE = 75
local PROJECTILE_CLUSTER_GROW_CHANCE_DECAY = 0.55
local PROJECTILE_CLUSTER_MAX_LAYER = 4
local PROJECTILE_CLUSTER_SPACING = 154
local PROJECTILE_CLUSTER_INTERVAL_COST_PER_PROJECTILE = 0.35
local PROJECTILE_LEFT_ANGLE = 45
local PROJECTILE_RIGHT_ANGLE = -45
local PROJECTILE_TRAVEL_DURATION = PROJECTILE_DISTANCE / PROJECTILE_SPEED
local PROJECTILE_BARRAGE_DURATION = PROJECTILE_WAVE_COUNT * PROJECTILE_WAVE_DURATION + PROJECTILE_TRAVEL_DURATION + 0.2
local PROJECTILE_EFFECT = "particles/units/heroes/hero_hoodwink/hoodwink_sharpshooter_projectile_2.vpcf"
local PROJECTILE_HIT_EFFECT = "particles/nightstalker_black_nihility_void_hit.vpcf"
local PREPARE_PARTICLE = "particles/boss/boss_night_003post.vpcf"
local PREPARE_PARTICLE_THINKER_MODEL = "models/heroes/wisp/wisp.vmdl"
____exports.boss_night_003 = __TS__Class()
local boss_night_003 = ____exports.boss_night_003
boss_night_003.name = "boss_night_003"
__TS__ClassExtends(boss_night_003, MonsterAbility_CS)
function boss_night_003.prototype.____constructor(self, ...)
	MonsterAbility_CS.prototype.____constructor(self, ...)
	self.lockedForward = Vector(1, 0, 0)
	self.barrageCenter = Vector(0, 0, 0)
	self.barrageToken = 0
	self.barrageStartDirectionIndex = 0
	self.shadowHideToken = 0
end
function boss_night_003.prototype.Precache(self, context)
	PrecacheResource("particle", PROJECTILE_EFFECT, context)
	PrecacheResource("particle", PROJECTILE_HIT_EFFECT, context)
	PrecacheResource("particle", PREPARE_PARTICLE, context)
	PrecacheResource("model", PREPARE_PARTICLE_THINKER_MODEL, context)
end
function boss_night_003.prototype.GetMosnterAbilityConfig(self)
	return {
		castPoint = CAST_POINT,
		castDuration = PROJECTILE_BARRAGE_DURATION,
		behavior = DOTA_ABILITY_BEHAVIOR_NO_TARGET,
		castAnimation = ACT_DOTA_CAST_ABILITY_1,
		animationPlaybackRate = 0.85,
		isNotMove = true,
		OnPhaseStart = function()
			return self:PrepareShadowBarrage()
		end,
		OnStart = function()
			return self:startProjectileBarrage()
		end,
		OnFinish = function()
			return self:RevealCaster()
		end,
		OnInterrupt = function()
			return self:RevealCaster()
		end,
	}
end
function boss_night_003.prototype.PrepareShadowBarrage(self)
	local caster = self:GetCaster()
	if not IsValidAlive(nil, caster) then
		return
	end
	self.shadowHideToken = self.shadowHideToken + 1
	local hideToken = self.shadowHideToken
	local target = caster:GetMinDistanceUnit(2200)
	local ____target_0
	if target then
		____target_0 = GetDirection(nil, target:GetAbsOrigin(), caster:GetAbsOrigin())
	else
		____target_0 = caster:GetForwardVector()
	end
	local forward = ____target_0
	local ____temp_1
	if forward:Length2D() > 0.01 then
		____temp_1 = forward:Normalized()
	else
		____temp_1 = Vector(1, 0, 0)
	end
	self.lockedForward = ____temp_1
	self.barrageCenter = caster:GetAbsOrigin()
	if target then
		caster:LockTargetForSpeed(target, CAST_POINT, 8)
	end
	caster:StartGestureWithPlaybackRate(ACT_DOTA_CAST_ABILITY_1, 0.85)
	caster:EmitSound("Hero_Nightstalker.Void")
	modifier_boss_night_003_shadow_shrink:applys(
		caster,
		caster,
		self,
		{ duration = CAST_POINT + PROJECTILE_BARRAGE_DURATION + 0.5, shrink_duration = PREPARE_SHRINK_DURATION }
	)
	local thinker = self:playPointParticle(PREPARE_PARTICLE, caster:GetAbsOrigin(), 0.8)
	caster:Mover(
		caster:GetAbsOrigin():__add(self.lockedForward:__mul(-PREPARE_BACKSTEP_DISTANCE)),
		PREPARE_BACKSTEP_DURATION,
		function(____, position, time)
			if not IsValidAlive(nil, thinker) then
				return
			end
			thinker:SetAbsOrigin(position)
		end
	)
	self:Timer(PREPARE_BACKSTEP_DURATION, function()
		local caster = self:GetCaster()
		if hideToken ~= self.shadowHideToken or not IsValidAlive(nil, caster) then
			return
		end
		caster:AddNoDraw()
	end)
end
function boss_night_003.prototype.startProjectileBarrage(self)
	local caster = self:GetCaster()
	if not IsValidAlive(nil, caster) then
		return
	end
	caster:ClearDebuffs()
	self.barrageToken = self.barrageToken + 1
	local token = self.barrageToken
	local center = self.barrageCenter
	self.barrageStartDirectionIndex = RandomInt(0, 1)
	self:playPointParticle(PREPARE_PARTICLE, caster:GetAbsOrigin(), 0.8)
	caster:EmitSound("Hero_Nightstalker.Darkness.Team")
	ScreenShake(center, 10, 10, PROJECTILE_BARRAGE_DURATION, 3000, 0, true)
	caster:StartGesture(ACT_DOTA_CAST_ABILITY_1)
	self:ScheduleProjectileWave(center, token, 0)
end
function boss_night_003.prototype.ScheduleProjectileWave(self, center, token, waveIndex)
	local caster = self:GetCaster()
	if token ~= self.barrageToken or not IsValidAlive(nil, caster) then
		return
	end
	if waveIndex >= PROJECTILE_WAVE_COUNT then
		return
	end
	local direction = self:GetWaveDirection(waveIndex)
	self:ScheduleProjectileWaveTick(center, direction, token, 0)
	self:Timer(PROJECTILE_WAVE_DURATION, function()
		return self:ScheduleProjectileWave(center, token, waveIndex + 1)
	end)
end
function boss_night_003.prototype.GetWaveDirection(self, waveIndex)
	local directionIndex = (self.barrageStartDirectionIndex + waveIndex) % 2
	local angle = directionIndex == 0 and PROJECTILE_LEFT_ANGLE or PROJECTILE_RIGHT_ANGLE
	return RotateVector2D(nil, Vector(0, 1, 0), angle):Normalized()
end
function boss_night_003.prototype.ScheduleProjectileWaveTick(self, center, direction, token, elapsed)
	local caster = self:GetCaster()
	if token ~= self.barrageToken or not IsValidAlive(nil, caster) then
		return
	end
	if elapsed >= PROJECTILE_WAVE_DURATION then
		return
	end
	local side = RotateVector2D(nil, direction, 90):Normalized()
	local randomOffset = RandomFloat(-PROJECTILE_BARRAGE_WIDTH / 2, PROJECTILE_BARRAGE_WIDTH / 2)
	local rawStart = Vector(
		center.x - direction.x * PROJECTILE_START_OFFSET + side.x * randomOffset,
		center.y - direction.y * PROJECTILE_START_OFFSET + side.y * randomOffset,
		center.z - direction.z * PROJECTILE_START_OFFSET + side.z * randomOffset
	)
	local start = GetGroundPosition(rawStart, caster)
	local projectileCount = self:ScheduleRandomProjectile(start, direction, side, token)
	local nextDelay = math.max(
		PROJECTILE_FIRE_INTERVAL,
		PROJECTILE_FIRE_INTERVAL * projectileCount * PROJECTILE_CLUSTER_INTERVAL_COST_PER_PROJECTILE
	)
	self:Timer(nextDelay, function()
		return self:ScheduleProjectileWaveTick(center, direction, token, elapsed + nextDelay)
	end)
end
function boss_night_003.prototype.ScheduleRandomProjectile(self, start, direction, side, token)
	if token ~= self.barrageToken then
		return 0
	end
	local layer = self:RollProjectileClusterLayer()
	local offsets = self:GetProjectileClusterOffsets(layer)
	__TS__ArrayForEach(offsets, function(____, offset)
		local sideDistance = offset.side * PROJECTILE_CLUSTER_SPACING
		local forwardDistance = offset.forward * PROJECTILE_CLUSTER_SPACING
		local clusterStart = Vector(
			start.x + side.x * sideDistance + direction.x * forwardDistance,
			start.y + side.y * sideDistance + direction.y * forwardDistance,
			start.z + side.z * sideDistance + direction.z * forwardDistance
		)
		self:createLineProjectile(clusterStart, direction)
	end)
	return #offsets
end
function boss_night_003.prototype.RollProjectileClusterLayer(self)
	if RandomFloat(0, 100) > PROJECTILE_CLUSTER_CHANCE then
		return 0
	end
	local layer = 1
	local growChance = PROJECTILE_CLUSTER_INITIAL_GROW_CHANCE
	while layer < PROJECTILE_CLUSTER_MAX_LAYER and RandomFloat(0, 100) <= growChance do
		layer = layer + 1
		growChance = growChance * PROJECTILE_CLUSTER_GROW_CHANCE_DECAY
	end
	return layer
end
function boss_night_003.prototype.GetProjectileClusterOffsets(self, layer)
	local offsets = { { side = 0, forward = 0 } }
	if layer <= 0 then
		return offsets
	end
	__TS__ArrayPush(
		offsets,
		{ side = 0, forward = 1 },
		{ side = 0, forward = -1 },
		{ side = -1, forward = 0 },
		{ side = 1, forward = 0 }
	)
	if layer <= 1 then
		return offsets
	end
	__TS__ArrayPush(
		offsets,
		{ side = -1, forward = 1 },
		{ side = 1, forward = 1 },
		{ side = -1, forward = -1 },
		{ side = 1, forward = -1 }
	)
	do
		local ring = 2
		while ring < layer do
			__TS__ArrayPush(
				offsets,
				{ side = 0, forward = ring },
				{ side = 0, forward = -ring },
				{ side = -ring, forward = 0 },
				{ side = ring, forward = 0 },
				{ side = -ring, forward = ring },
				{ side = ring, forward = ring },
				{ side = -ring, forward = -ring },
				{ side = ring, forward = -ring }
			)
			ring = ring + 1
		end
	end
	return offsets
end
function boss_night_003.prototype.createLineProjectile(self, origin, forward)
	local caster = self:GetCaster()
	if not IsValidAlive(nil, caster) then
		return
	end
	local startPoint = Vector(origin.x, origin.y, GetGroundHeight(origin, caster) or origin.z)
	local ____temp_2
	if forward:Length2D() > 0.01 then
		____temp_2 = forward:Normalized()
	else
		____temp_2 = Vector(0, 1, 0)
	end
	local flyDirection = ____temp_2
	self:playProjectileParticle(startPoint, flyDirection)
	CreateProjectile(nil, {
		caster = caster,
		ability = self,
		effect_name = "",
		projectile_type = "linear",
		start_point = startPoint,
		direction = flyDirection,
		projectile_speed = PROJECTILE_SPEED,
		projectile_distance = PROJECTILE_DISTANCE,
		projectile_range = PROJECTILE_RADIUS,
		projectile_target_team = DOTA_UNIT_TARGET_TEAM_ENEMY,
		projectile_target_type = DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC + DOTA_UNIT_TARGET_BUILDING,
		projectile_target_flags = DOTA_UNIT_TARGET_FLAG_MAGIC_IMMUNE_ENEMIES,
		on_think = function(____, location)
			DebugRing(nil, location, PROJECTILE_RADIUS, 0.1)
		end,
		on_hit = function(____, target)
			if not target or not IsValidAlive(nil, target) then
				return true
			end
			if not IsValidAlive(nil, caster) then
				return true
			end
			caster:MonsterDamage({ victim = target, damage_rate = PROJECTILE_DAMAGE_RATE, ability = self })
			AddDeBuffStatus(nil, target, caster, self, DebuffStatusType.STUN, { duration = 0.1 })
			local pfx = ParticleManager:CreateParticle(PROJECTILE_HIT_EFFECT, PATTACH_ABSORIGIN_FOLLOW, target)
			ParticleManager:ReleaseParticleIndex(pfx)
			return true
		end,
	})
end
function boss_night_003.prototype.playProjectileParticle(self, startPoint, direction)
	local pfx = ParticleManager:CreateParticle(PROJECTILE_EFFECT, PATTACH_WORLDORIGIN, nil)
	ParticleManager:SetParticleControl(pfx, 0, startPoint)
	ParticleManager:SetParticleControl(pfx, 1, direction:__mul(PROJECTILE_SPEED))
	ParticleManager:SetParticleControl(pfx, 2, Vector(PROJECTILE_RADIUS, PROJECTILE_RADIUS, PROJECTILE_RADIUS))
	Timers:CreateTimer(PROJECTILE_TRAVEL_DURATION + 0.2, function()
		ParticleManager:DestroyParticle(pfx, false)
		ParticleManager:ReleaseParticleIndex(pfx)
		return nil
	end)
end
function boss_night_003.prototype.playPointParticle(self, name, point, duration)
	local caster = self:GetCaster()
	if not IsValidAlive(nil, caster) then
		return
	end
	local thinker = CreateModifierThinker(
		caster,
		self,
		"modifier_dummy_thinker",
		{ duration = duration + 5 },
		point,
		caster:GetTeamNumber(),
		false
	)
	Timers:CreateTimer(FrameTime(), function()
		if not IsValidAlive(nil, thinker) then
			return
		end
		thinker:SetOriginalModel(PREPARE_PARTICLE_THINKER_MODEL)
		thinker:SetModel(PREPARE_PARTICLE_THINKER_MODEL)
	end)
	Timers:CreateTimer(FrameTime() * 2, function()
		local pfx = ParticleManager:CreateParticle(name, PATTACH_ABSORIGIN_FOLLOW, thinker)
		ParticleManager:SetParticleControlEnt(pfx, 0, thinker, PATTACH_ABSORIGIN_FOLLOW, "attach_hitloc", point, true)
		Timers:CreateTimer(duration, function()
			ParticleManager:DestroyParticle(pfx, false)
			ParticleManager:ReleaseParticleIndex(pfx)
			if IsValid(nil, thinker) and not thinker:IsNull() then
				thinker:RemoveSelf()
			end
			return nil
		end)
	end)
	return thinker
end
function boss_night_003.prototype.RevealCaster(self)
	local caster = self:GetCaster()
	if not caster or not IsValid(nil, caster) or caster:IsNull() then
		return
	end
	self.barrageToken = self.barrageToken + 1
	self.shadowHideToken = self.shadowHideToken + 1
	caster:RemoveNoDraw()
	modifier_boss_night_003_shadow_shrink:remove(caster)
	self:playPointParticle(PREPARE_PARTICLE, caster:GetAbsOrigin(), 0.8)
end
boss_night_003 = __TS__DecorateLegacy({ registerAbility(nil) }, boss_night_003)
____exports.boss_night_003 = boss_night_003
modifier_boss_night_003_shadow_shrink = __TS__Class()
modifier_boss_night_003_shadow_shrink.name = "modifier_boss_night_003_shadow_shrink"
__TS__ClassExtends(modifier_boss_night_003_shadow_shrink, BaseModifier_CS)
function modifier_boss_night_003_shadow_shrink.prototype.____constructor(self, ...)
	BaseModifier_CS.prototype.____constructor(self, ...)
	self.shrinkDuration = PREPARE_SHRINK_DURATION
end
function modifier_boss_night_003_shadow_shrink.prototype.OnCreated(self, params)
	if not IsServer() then
		return
	end
	self.shrinkDuration = math.max(params and params.shrink_duration or PREPARE_SHRINK_DURATION, FrameTime())
	self:SetStackCount(0)
	self:StartIntervalThink(FrameTime())
end
function modifier_boss_night_003_shadow_shrink.prototype.OnIntervalThink(self)
	if not IsServer() then
		return
	end
	local progress = math.min(self:GetElapsedTime() / self.shrinkDuration, 1)
	self:SetStackCount(math.floor(progress * 100))
	if progress >= 1 then
		self:StartIntervalThink(-1)
	end
end
function modifier_boss_night_003_shadow_shrink.prototype.DeclareFunctions(self)
	return { MODIFIER_PROPERTY_MODEL_SCALE, MODIFIER_PROPERTY_MODEL_SCALE_ANIMATE_TIME }
end
function modifier_boss_night_003_shadow_shrink.prototype.GetModifierModelScaleAnimateTime(self)
	return FrameTime()
end
function modifier_boss_night_003_shadow_shrink.prototype.GetModifierModelScale(self)
	return -self:GetStackCount()
end
function modifier_boss_night_003_shadow_shrink.prototype.IsHidden(self)
	return true
end
function modifier_boss_night_003_shadow_shrink.prototype.IsPurgable(self)
	return false
end
modifier_boss_night_003_shadow_shrink =
	__TS__DecorateLegacy({ registerModifier(nil) }, modifier_boss_night_003_shadow_shrink)
return ____exports