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
local ____dota_ts_adapter = require("utils.dota_ts_adapter")
local registerAbility = ____dota_ts_adapter.registerAbility
local registerModifier = ____dota_ts_adapter.registerModifier
local ____monster_base = require("abilities.monster.monster_base")
local MonsterModifier_CS = ____monster_base.MonsterModifier_CS
local ____boss_phase_transition_ability = require("abilities.monster.boss.boss_phase_transition_ability")
local BossPhaseTransitionAbility_CS = ____boss_phase_transition_ability.BossPhaseTransitionAbility_CS
local SUMMON_UNIT_NAME = "monster_10081"
local SUMMON_TAG = "tide_hunter_ab4_phase_summon"
local VOMIT_SUMMON_COUNT = 1
local VOMIT_SUMMON_FORWARD_DISTANCE = 520
local VOMIT_SUMMON_SIDE_SPACING = 190
local SUMMON_SEQUENCE_INTERVAL = 0.32
local TRANSITION_DURATION = 6
local RETURN_TO_SPAWN_DURATION = 0.6
local SUMMON_DELAY = 0.65
local SUMMON_EFFECT = "particles/boss/boss_004debuff.vpcf"
local SUMMON_SOUND = "Hero_Tidehunter.Ravage"
local VOMIT_PROJECTILE_EFFECT = "particles/units/heroes/hero_tidehunter/tidehunter_gush.vpcf"
local BIRTH_SCENE_EFFECT =
	"particles/econ/items/tidehunter/tidehunter_divinghelmet/tidehunter_gush_splash_diving_helmet.vpcf"
local VOMIT_PROJECTILE_CAST_SOUND = "Ability.GushCast"
local VOMIT_PROJECTILE_IMPACT_SOUND = "Ability.GushImpact"
local POST_VOMIT_GESTURE_SOUND = "Ability.Ravage"
local GROUND_BIRTH_SOUND = "Ability.GushImpact"
local VOMIT_PROJECTILE_SPEED = 850
local VOMIT_SPAWN_DURATION = 0.9
local VOMIT_SPAWN_START_SCALE = 0.18
local VOMIT_SPAWN_END_SCALE = 1
local GROUND_BIRTH_INVULNERABLE_DURATION = 1
local GROUND_BIRTH_EFFECT_DURATION = 1.2
local VOMIT_MOUTH_FORWARD_OFFSET = 135
local VOMIT_MOUTH_HEIGHT = 155
local POST_VOMIT_GESTURE_START_DELAY = SUMMON_DELAY
	+ (VOMIT_SUMMON_COUNT - 1) * SUMMON_SEQUENCE_INTERVAL
	+ VOMIT_SPAWN_DURATION
local POST_VOMIT_GESTURE_INTERVAL = 1.15
local POST_VOMIT_SUMMONS_PER_GESTURE = 2
local POST_VOMIT_SUMMON_FORWARD_DISTANCE = 360
local POST_VOMIT_SUMMON_SIDE_SPACING = 220
local POST_VOMIT_MAX_GESTURE_COUNT = 3
local TRANSITION_GESTURE = ACT_DOTA_CAST_ABILITY_4
--- 西瓜皮转阶段召唤：短位移后回出生点，并召唤房间普通怪。
____exports.tide_hunter_ab4 = __TS__Class()
local tide_hunter_ab4 = ____exports.tide_hunter_ab4
tide_hunter_ab4.name = "tide_hunter_ab4"
__TS__ClassExtends(tide_hunter_ab4, BossPhaseTransitionAbility_CS)
function tide_hunter_ab4.prototype.Precache(self, context)
	PrecacheResource("particle", SUMMON_EFFECT, context)
	PrecacheResource("particle", VOMIT_PROJECTILE_EFFECT, context)
	PrecacheResource("particle", BIRTH_SCENE_EFFECT, context)
	PrecacheResource("soundfile", "soundevents/game_sounds_heroes/game_sounds_tidehunter.vsndevts", context)
end
function tide_hunter_ab4.prototype.GetBossPhaseTransitionReturnToSpawnDuration(self)
	return RETURN_TO_SPAWN_DURATION
end
function tide_hunter_ab4.prototype.GetBossPhaseTransitionWindowDuration(self)
	return TRANSITION_DURATION
end
function tide_hunter_ab4.prototype.GetBossPhaseTransitionGesture(self)
	return nil
end
function tide_hunter_ab4.prototype.GetBossPhaseTransitionConfig(self)
	return {
		behavior = DOTA_ABILITY_BEHAVIOR_NO_TARGET,
		castPoint = 0,
		castDuration = TRANSITION_DURATION,
		castAnimation = "",
		animationPlaybackRate = 1,
		isNotMove = true,
		OnStart = function()
			local caster = self:GetCaster()
			if not IsValidAlive(nil, caster) then
				return
			end
			self:FaceNearestPlayer(caster)
			self:Timer(SUMMON_DELAY, function()
				if not IsValidAlive(nil, caster) then
					return
				end
				self:FaceNearestPlayer(caster)
				self:SummonPhaseMonsters(caster)
			end)
			self:Timer(POST_VOMIT_GESTURE_START_DELAY, function()
				if not IsValidAlive(nil, caster) then
					return
				end
				self:StartPostVomitGestureSummons(caster)
			end)
		end,
	}
end
function tide_hunter_ab4.prototype.GetVomitSummonUnitName(self)
	return SUMMON_UNIT_NAME
end
function tide_hunter_ab4.prototype.GetVomitSummonTag(self, caster)
	return (SUMMON_TAG .. "_") .. caster:GetUnitName()
end
function tide_hunter_ab4.prototype.GetVomitSummonCount(self)
	return VOMIT_SUMMON_COUNT
end
function tide_hunter_ab4.prototype.GetPostVomitSummonsPerGesture(self)
	return POST_VOMIT_SUMMONS_PER_GESTURE
end
function tide_hunter_ab4.prototype.GetTotalMaxSummons(self)
	return self:GetVomitSummonCount() + self:GetPostVomitSummonsPerGesture() * POST_VOMIT_MAX_GESTURE_COUNT
end
function tide_hunter_ab4.prototype.FaceNearestPlayer(self, caster)
	local target = caster:GetMinDistanceUnit(3000, caster:GetAbsOrigin())
	if not IsValidAlive(nil, target) then
		return
	end
	local direction = GetDirection(nil, target:GetAbsOrigin(), caster:GetAbsOrigin())
	caster:SetForwardVectorWithoutInterrupt(direction)
end
function tide_hunter_ab4.prototype.SummonPhaseMonsters(self, caster)
	local origin = caster:GetAbsOrigin()
	local roomId = caster:GetRoomId()
	local summonCount = self:GetVomitSummonCount()
	EmitSoundOnLocationWithCaster(origin, SUMMON_SOUND, caster)
	do
		local i = 0
		while i < summonCount do
			local currentIndex = i
			local currentDelay = currentIndex * SUMMON_SEQUENCE_INTERVAL
			self:Timer(currentDelay, function()
				if not IsValidAlive(nil, caster) then
					return
				end
				self:SpawnSingleVomitedUnit(caster, roomId, currentIndex)
			end)
			i = i + 1
		end
	end
end
function tide_hunter_ab4.prototype.SpawnSingleVomitedUnit(self, caster, roomId, currentIndex)
	local origin = caster:GetAbsOrigin()
	local forward = caster:GetForwardVector()
	local right = Vector(forward.y, -forward.x, 0)
	local summonCount = self:GetVomitSummonCount()
	local sideOffset = (currentIndex - (summonCount - 1) / 2) * VOMIT_SUMMON_SIDE_SPACING
	local targetOffset = forward:__mul(VOMIT_SUMMON_FORWARD_DISTANCE):__add(right:__mul(sideOffset))
	local summonPos = GetGroundPosition(origin:__add(targetOffset), caster)
	local mouthPos = self:ResolveMouthSpawnPoint(caster)
	caster:StartGestureWithPlaybackRate(ACT_DOTA_CAST_ABILITY_1, 1)
	MyGameUnit:CreateSummonedUnitAsync({
		unitName = self:GetVomitSummonUnitName(),
		summonTag = self:GetVomitSummonTag(caster),
		maxSummons = self:GetTotalMaxSummons(),
		position = mouthPos,
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
			unit:SetAbsOrigin(mouthPos)
			unit:StartGestureWithPlaybackRate(ACT_DOTA_CAST_ABILITY_1, 1)
			unit:SetForwardVectorWithoutInterrupt(GetDirection(nil, summonPos, mouthPos))
			____exports.modifier_tide_hunter_ab4_vomit_spawn:applys(
				unit,
				caster,
				self,
				{
					duration = VOMIT_SPAWN_DURATION,
					start_scale = VOMIT_SPAWN_START_SCALE,
					end_scale = VOMIT_SPAWN_END_SCALE,
				}
			)
			self:LaunchVomitedProjectile(caster, unit, mouthPos, summonPos)
		end,
	})
end
function tide_hunter_ab4.prototype.LaunchVomitedProjectile(self, caster, unit, mouthPos, summonPos)
	EmitSoundOnLocationWithCaster(mouthPos, VOMIT_PROJECTILE_CAST_SOUND, caster)
	CreateProjectile(nil, {
		ability = self,
		caster = caster,
		projectile_type = "collideground",
		effect_name = VOMIT_PROJECTILE_EFFECT,
		projectile_speed = VOMIT_PROJECTILE_SPEED,
		start_point = mouthPos,
		target = summonPos,
		on_think = function(____, location)
			if not IsValidAlive(nil, unit) then
				return true
			end
			unit:SetAbsOrigin(location)
			unit:SetForwardVectorWithoutInterrupt(GetDirection(nil, summonPos, mouthPos))
			return false
		end,
		on_hit = function(____, _hitTarget, location)
			if not IsValidAlive(nil, unit) then
				return true
			end
			local groundZ = GetGroundHeight(location, unit) or location.z
			local landingPos = Vector(location.x, location.y, groundZ)
			unit:SetAbsOrigin(landingPos)
			FindClearSpaceForUnit(unit, landingPos, true)
			____exports.modifier_tide_hunter_ab4_vomit_spawn:remove(unit)
			EmitSoundOnLocationWithCaster(landingPos, VOMIT_PROJECTILE_IMPACT_SOUND, caster)
			self:PlaySummonEffect(landingPos, caster)
			return true
		end,
	})
end
function tide_hunter_ab4.prototype.ResolveMouthSpawnPoint(self, caster)
	local origin = caster:GetAbsOrigin()
	local forward = caster:GetForwardVector()
	return origin:__add(forward:__mul(VOMIT_MOUTH_FORWARD_OFFSET)):__add(Vector(0, 0, VOMIT_MOUTH_HEIGHT))
end
function tide_hunter_ab4.prototype.StartPostVomitGestureSummons(self, caster)
	local roomId = caster:GetRoomId()
	do
		local i = 0
		while i < POST_VOMIT_MAX_GESTURE_COUNT do
			local currentGestureIndex = i
			local currentDelay = currentGestureIndex * POST_VOMIT_GESTURE_INTERVAL
			self:Timer(currentDelay, function()
				if not IsValidAlive(nil, caster) then
					return
				end
				self:FaceNearestPlayer(caster)
				local summonPositions = self:ResolveGroundBirthPositions(caster)
				self:PlayGroundBirthEffects(summonPositions, caster)
				caster:StartGestureWithPlaybackRate(TRANSITION_GESTURE, 1)
				EmitSoundOnLocationWithCaster(caster:GetAbsOrigin(), POST_VOMIT_GESTURE_SOUND, caster)
				self:SummonGroundBirthPair(caster, roomId, summonPositions)
			end)
			i = i + 1
		end
	end
end
function tide_hunter_ab4.prototype.ResolveGroundBirthPositions(self, caster)
	local origin = caster:GetAbsOrigin()
	local forward = caster:GetForwardVector()
	local right = Vector(forward.y, -forward.x, 0)
	local positions = {}
	local summonCount = self:GetPostVomitSummonsPerGesture()
	do
		local i = 0
		while i < summonCount do
			local currentIndex = i
			local sideOffset = (currentIndex - (summonCount - 1) / 2) * POST_VOMIT_SUMMON_SIDE_SPACING
			local targetOffset = forward:__mul(POST_VOMIT_SUMMON_FORWARD_DISTANCE):__add(right:__mul(sideOffset))
			local summonPos = GetGroundPosition(origin:__add(targetOffset), caster)
			positions[#positions + 1] = summonPos
			i = i + 1
		end
	end
	return positions
end
function tide_hunter_ab4.prototype.SummonGroundBirthPair(self, caster, roomId, summonPositions)
	do
		local i = 0
		while i < #summonPositions do
			local currentIndex = i
			local currentSummonPos = summonPositions[currentIndex + 1]
			MyGameUnit:CreateSummonedUnitAsync({
				unitName = self:GetVomitSummonUnitName(),
				summonTag = self:GetVomitSummonTag(caster),
				maxSummons = self:GetTotalMaxSummons(),
				position = currentSummonPos,
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
					unit:SetForwardVectorWithoutInterrupt(GetDirection(nil, currentSummonPos, caster:GetAbsOrigin()))
					unit:AddNewModifier(
						caster,
						self,
						"modifier_cs_spawn_intro_rise",
						{ duration = GROUND_BIRTH_INVULNERABLE_DURATION }
					)
				end,
			})
			i = i + 1
		end
	end
end
function tide_hunter_ab4.prototype.PlaySummonEffect(self, position, caster)
	local effect = ParticleManager:CreateParticle(SUMMON_EFFECT, PATTACH_WORLDORIGIN, caster)
	ParticleManager:SetParticleControl(effect, 0, position)
	ParticleManager:SetParticleControl(effect, 1, position)
	ParticleManager:SetParticleShouldCheckFoW(effect, false)
	Timers:CreateTimer(1, function()
		ParticleManager:DestroyParticle(effect, false)
		ParticleManager:ReleaseParticleIndex(effect)
		return nil
	end)
end
function tide_hunter_ab4.prototype.PlayGroundBirthEffects(self, positions, caster)
	do
		local i = 0
		while i < #positions do
			local currentIndex = i
			local currentPosition = positions[currentIndex + 1]
			self:PlayGroundBirthEffect(currentPosition, caster)
			i = i + 1
		end
	end
end
function tide_hunter_ab4.prototype.PlayGroundBirthEffect(self, position, caster)
	local effect = ParticleManager:CreateParticle(BIRTH_SCENE_EFFECT, PATTACH_WORLDORIGIN, caster)
	ParticleManager:SetParticleControl(effect, 0, position)
	ParticleManager:SetParticleControl(effect, 3, position)
	ParticleManager:SetParticleShouldCheckFoW(effect, false)
	EmitSoundOnLocationWithCaster(position, GROUND_BIRTH_SOUND, caster)
	Timers:CreateTimer(GROUND_BIRTH_EFFECT_DURATION, function()
		ParticleManager:DestroyParticle(effect, false)
		ParticleManager:ReleaseParticleIndex(effect)
		return nil
	end)
end
tide_hunter_ab4 = __TS__DecorateLegacy({ registerAbility(nil) }, tide_hunter_ab4)
____exports.tide_hunter_ab4 = tide_hunter_ab4
____exports.modifier_tide_hunter_ab4_vomit_spawn = __TS__Class()
local modifier_tide_hunter_ab4_vomit_spawn = ____exports.modifier_tide_hunter_ab4_vomit_spawn
modifier_tide_hunter_ab4_vomit_spawn.name = "modifier_tide_hunter_ab4_vomit_spawn"
__TS__ClassExtends(modifier_tide_hunter_ab4_vomit_spawn, MonsterModifier_CS)
function modifier_tide_hunter_ab4_vomit_spawn.prototype.____constructor(self, ...)
	MonsterModifier_CS.prototype.____constructor(self, ...)
	self.elapsed = 0
	self.duration = VOMIT_SPAWN_DURATION
	self.startScale = VOMIT_SPAWN_START_SCALE
	self.endScale = VOMIT_SPAWN_END_SCALE
end
function modifier_tide_hunter_ab4_vomit_spawn.prototype.IsHidden(self)
	return true
end
function modifier_tide_hunter_ab4_vomit_spawn.prototype.IsPurgable(self)
	return false
end
function modifier_tide_hunter_ab4_vomit_spawn.prototype.OnCreated(self, params)
	if not IsServer() then
		return
	end
	local parent = self:GetParent()
	if not IsValidAlive(nil, parent) then
		return
	end
	self.elapsed = 0
	self.duration = math.max(FrameTime(), params.duration or VOMIT_SPAWN_DURATION)
	self.startScale = params.start_scale or VOMIT_SPAWN_START_SCALE
	self.endScale = params.end_scale or VOMIT_SPAWN_END_SCALE
	parent:SetModelScale(self.startScale)
	parent:StartGestureWithPlaybackRate(ACT_DOTA_CAST_ABILITY_1, 1)
	self:StartIntervalThink(FrameTime())
end
function modifier_tide_hunter_ab4_vomit_spawn.prototype.OnDestroy(self)
	if not IsServer() then
		return
	end
	local parent = self:GetParent()
	if not IsValidAlive(nil, parent) then
		return
	end
	parent:SetModelScale(self.endScale)
end
function modifier_tide_hunter_ab4_vomit_spawn.prototype.OnIntervalThink(self)
	if not IsServer() then
		return
	end
	local parent = self:GetParent()
	if not IsValidAlive(nil, parent) then
		self:Destroy()
		return
	end
	self.elapsed = self.elapsed + FrameTime()
	local progress = math.min(1, self.elapsed / self.duration)
	local easedProgress = progress * progress * (3 - 2 * progress)
	local scale = self.startScale + (self.endScale - self.startScale) * easedProgress
	parent:SetModelScale(scale)
end
function modifier_tide_hunter_ab4_vomit_spawn.prototype.CheckState(self)
	return {
		[MODIFIER_STATE_INVULNERABLE] = true,
		[MODIFIER_STATE_NO_HEALTH_BAR] = true,
		[MODIFIER_STATE_STUNNED] = true,
		[MODIFIER_STATE_COMMAND_RESTRICTED] = true,
		[MODIFIER_STATE_DISARMED] = true,
		[MODIFIER_STATE_ROOTED] = true,
		[MODIFIER_STATE_NO_UNIT_COLLISION] = true,
	}
end
modifier_tide_hunter_ab4_vomit_spawn = __TS__DecorateLegacy(
	{ registerModifier(nil, "modifier_tide_hunter_ab4_vomit_spawn") },
	modifier_tide_hunter_ab4_vomit_spawn
)
____exports.modifier_tide_hunter_ab4_vomit_spawn = modifier_tide_hunter_ab4_vomit_spawn
return ____exports