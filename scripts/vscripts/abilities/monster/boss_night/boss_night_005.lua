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
local modifier_boss_night_005_illusion_state, modifier_boss_night_005_illusion_status
local ____dota_ts_adapter = require("utils.dota_ts_adapter")
local registerAbility = ____dota_ts_adapter.registerAbility
local registerModifier = ____dota_ts_adapter.registerModifier
local ____modifier_base = require("modifiers.class.modifier_base")
local BaseModifier_CS = ____modifier_base.BaseModifier_CS
local ____effect_modifiers = require("modifiers.effect_modifiers")
local modifier_wearable_unit_state = ____effect_modifiers.modifier_wearable_unit_state
local ____monster_base = require("abilities.monster.monster_base")
local MonsterAbility_CS = ____monster_base.MonsterAbility_CS
local BOSS_NIGHT_005_PHASE_DURATION = 19
local BOSS_NIGHT_005_BOSS_MOVE_DURATION = 0.5
local BOSS_NIGHT_005_ILLUSION_COUNT = 3
local BOSS_NIGHT_005_ILLUSION_HEALTH_PCT = 8
local BOSS_NIGHT_005_ILLUSION_UNIT_NAME = "monster_12019_illusion"
local BOSS_NIGHT_005_ILLUSION_SUMMON_TAG = "boss_night_005_illusion"
local BOSS_NIGHT_005_ILLUSION_DISTANCE = 560
local BOSS_NIGHT_005_ILLUSION_SHOT_INTERVAL = 3
local BOSS_NIGHT_005_ILLUSION_SHOT_FIRST_DELAY = 1
local BOSS_NIGHT_005_ILLUSION_WARNING_DURATION = 1.5
local BOSS_NIGHT_005_ILLUSION_AIM_FREEZE_BEFORE_FIRE = 0.5
local BOSS_NIGHT_005_ILLUSION_FIRE_ANIMATION = "night_castvoid_nihility_flying"
local BOSS_NIGHT_005_ILLUSION_FIRE_ANIMATION_K_POINT = 0.43
local BOSS_NIGHT_005_PROJECTILE_DISTANCE = 2600
local BOSS_NIGHT_005_PROJECTILE_SPEED = 1100
local BOSS_NIGHT_005_PROJECTILE_RADIUS = 120
local BOSS_NIGHT_005_PROJECTILE_DAMAGE_RATE = 5
local BOSS_NIGHT_005_COUNTDOWN_HEIGHT = 260
local BOSS_NIGHT_005_WEARABLE_MODELS = {
	"models/items/nightstalker/dusk_reaper_tail/dusk_reaper_tail.vmdl",
	"models/items/nightstalker/dusk_reaper_legs/dusk_reaper_legs.vmdl",
	"models/items/nightstalker/dusk_reaper_head/dusk_reaper_head.vmdl",
	"models/items/nightstalker/dusk_reaper_back/dusk_reaper_back.vmdl",
	"models/items/nightstalker/dusk_reaper_arms/dusk_reaper_arms.vmdl",
}
local NIGHTFALL_PARTICLE = "particles/units/heroes/hero_night_stalker/nightstalker_ulti.vpcf"
local NIGHTFALL_MODEL = "models/heroes/nightstalker/nightstalker_night.vmdl"
local ILLUSION_SUMMON_PARTICLE = "particles/generic_hero_status/status_invisibility_start.vpcf"
local ILLUSION_STATUS_EFFECT = "particles/status_fx/status_effect_illusion.vpcf"
local ILLUSION_ABSORB_PARTICLE = "particles/units/heroes/hero_night_stalker/nightstalker_shard_hunter.vpcf"
local ILLUSION_PROJECTILE_PARTICLE =
	"particles/econ/items/death_prophet/death_prophet_acherontia/death_prophet_acher_swarm.vpcf"
local ILLUSION_HIT_PARTICLE =
	"particles/econ/items/nightstalker/nightstalker_black_nihility/nightstalker_black_nihility_void_hit.vpcf"
local COUNTDOWN_PARTICLE = "particles/units/heroes/heroes_underlord/abyssal_underlord_portal_timer.vpcf"
local NIGHTFALL_ACTIVITY_MODIFIER = "hunter_night"
local NIGHTFALL_RETURN_ANIMATION = "night_cast_hunter_night_flying_shard"
local NIGHTFALL_RETURN_ANIMATION_K_POINT = 0.23
local NIGHTFALL_RETURN_SOUND = "Hero_DoomBringer.Devour"
local ILLUSION_PROJECTILE_CAST_SOUND = "Hero_DeathProphet.CarrionSwarm"
local NIGHTFALL_LOOP_ANIMATION = "night_daytonightulti"
local NIGHTFALL_LOOP_ANIMATION_INTERVAL = 0.9
local NIGHTFALL_BOSS_FORWARD = Vector(0, -1, 0)
local function CreateNightfallWearables(self, parent)
	local wearableEntities = {}
	if not IsValidAlive(nil, parent) then
		return wearableEntities
	end
	for ____, model in ipairs(BOSS_NIGHT_005_WEARABLE_MODELS) do
		do
			local wearable =
				SpawnEntityFromTableSynchronous("npc_dota_creature", { model = model, StatusHealth = 99999 })
			if not IsValidAlive(nil, wearable) then
				goto __continue4
			end
			wearable:SetOwner(parent)
			wearable:SetParent(parent, "")
			wearable:FollowEntity(parent, true)
			wearable:SetTeam(parent:GetTeamNumber())
			modifier_wearable_unit_state:applys(wearable, parent, nil, { duration = -1, invisibility_level = 0 })
			wearableEntities[#wearableEntities + 1] = wearable:entindex()
		end
		::__continue4::
	end
	return wearableEntities
end
local function RemoveNightfallWearables(self, wearableEntities)
	for ____, entityIndex in ipairs(wearableEntities) do
		local entity = EntIndexToHScript(entityIndex)
		if entity and IsValid(nil, entity) then
			entity:RemoveSelf()
		end
	end
end
local function ApplyIllusionStatusToWearables(self, wearableEntities, caster, ability)
	for ____, entityIndex in ipairs(wearableEntities) do
		local wearable = EntIndexToHScript(entityIndex)
		if wearable and IsValid(nil, wearable) then
			modifier_boss_night_005_illusion_status:applys(wearable, caster, ability, { duration = -1 })
		end
	end
end
--- 倒计时粒子 CP1：X=十位（仅识别 1，无十位时为 0），Y=个位。
local function CountdownParticleCp1(self, displaySeconds)
	local value = math.max(0, math.min(19, math.floor(displaySeconds)))
	local tens = math.floor(value / 10)
	local ones = value % 10
	return Vector(tens, ones, 0)
end
local function PlayPointParticle(self, name, origin, duration, owner)
	local pfx = ParticleManager:CreateParticle(name, PATTACH_WORLDORIGIN, owner)
	ParticleManager:SetParticleControl(pfx, 0, origin)
	Timers:CreateTimer(duration, function()
		ParticleManager:DestroyParticle(pfx, false)
		ParticleManager:ReleaseParticleIndex(pfx)
		return nil
	end)
end
____exports.boss_night_005 = __TS__Class()
local boss_night_005 = ____exports.boss_night_005
boss_night_005.name = "boss_night_005"
__TS__ClassExtends(boss_night_005, MonsterAbility_CS)
function boss_night_005.prototype.____constructor(self, ...)
	MonsterAbility_CS.prototype.____constructor(self, ...)
	self.phaseToken = 0
	self.illusionEntIndexes = {}
end
function boss_night_005.prototype.Precache(self, context)
	for ____, model in ipairs(BOSS_NIGHT_005_WEARABLE_MODELS) do
		PrecacheResource("model", model, context)
	end
	PrecacheResource("particle", NIGHTFALL_PARTICLE, context)
	PrecacheResource("particle", ILLUSION_SUMMON_PARTICLE, context)
	PrecacheResource("particle", ILLUSION_STATUS_EFFECT, context)
	PrecacheResource("particle", ILLUSION_ABSORB_PARTICLE, context)
	PrecacheResource("particle", ILLUSION_PROJECTILE_PARTICLE, context)
	PrecacheResource("particle", ILLUSION_HIT_PARTICLE, context)
	PrecacheResource("particle", COUNTDOWN_PARTICLE, context)
	PrecacheResource("particle", "particles/range_finder_linear_1.vpcf", context)
end
function boss_night_005.prototype.GetMosnterAbilityConfig(self)
	return {
		castPoint = 0.4,
		castDuration = BOSS_NIGHT_005_PHASE_DURATION + BOSS_NIGHT_005_BOSS_MOVE_DURATION + 0.2,
		behavior = DOTA_ABILITY_BEHAVIOR_NO_TARGET,
		castAnimation = ACT_DOTA_CAST_ABILITY_4,
		isNotMove = true,
		castColor = Vector(20, 0, 90),
		OnStart = function()
			return self:StartNightfall()
		end,
		OnFinish = function()
			return self:FinishNightfall(self.activePhaseToken or -1)
		end,
		OnInterrupt = function()
			return self:FinishNightfall(self.activePhaseToken or -1)
		end,
	}
end
function boss_night_005.prototype.StartNightfall(self)
	local caster = self:GetCaster()
	if not IsValidAlive(nil, caster) then
		return
	end
	self:FinishNightfall(self.activePhaseToken or -1)
	self.phaseToken = self.phaseToken + 1
	local token = self.phaseToken
	self.activePhaseToken = token
	self.illusionEntIndexes = {}
	____exports.modifier_boss_night_005_buff:applys(
		caster,
		caster,
		self,
		{ duration = BOSS_NIGHT_005_PHASE_DURATION + BOSS_NIGHT_005_BOSS_MOVE_DURATION + 0.3 }
	)
	local center = self:ResolveArenaCenter(caster)
	self:MoveBossToCenter(caster, center)
	caster:ClearDebuffs()
	self:SummonIllusions(caster, center, token)
	self:Timer(BOSS_NIGHT_005_PHASE_DURATION, function()
		return self:FinishNightfall(token)
	end)
end
function boss_night_005.prototype.FinishNightfall(self, token)
	local caster = self:GetCaster()
	if token ~= self.activePhaseToken then
		return
	end
	self.activePhaseToken = nil
	local illusions = self:GetAliveIllusions()
	local healAmount = 0
	for ____, illusion in ipairs(illusions) do
		healAmount = healAmount + math.max(0, illusion:GetHealth())
	end
	if IsValidAlive(nil, caster) then
		caster:SetAnimation(NIGHTFALL_RETURN_ANIMATION)
		self:Timer(NIGHTFALL_RETURN_ANIMATION_K_POINT, function()
			self:PlayReturnEffectsAndHeal(caster, illusions, healAmount)
			____exports.modifier_boss_night_005_buff:remove(caster)
			self:DestroyDuration()
		end)
	else
		self:CleanupIllusions(illusions)
	end
	self.illusionEntIndexes = {}
end
function boss_night_005.prototype.ResolveArenaCenter(self, caster)
	local ____this_1
	____this_1 = caster
	local ____opt_0 = ____this_1.GetSpawnPoint
	local spawnPoint = ____opt_0 and ____opt_0(____this_1)
	return GetGroundPosition(spawnPoint or caster:GetAbsOrigin(), caster)
end
function boss_night_005.prototype.MoveBossToCenter(self, caster, center)
	caster:SetForwardVectorWithoutInterrupt(NIGHTFALL_BOSS_FORWARD)
	caster:Mover(center, BOSS_NIGHT_005_BOSS_MOVE_DURATION)
	self:Timer(BOSS_NIGHT_005_BOSS_MOVE_DURATION, function()
		if not IsValidAlive(nil, caster) then
			return
		end
		caster:SetAbsOrigin(center)
		FindClearSpaceForUnit(caster, center, true)
		caster:SetForwardVectorWithoutInterrupt(NIGHTFALL_BOSS_FORWARD)
	end)
end
function boss_night_005.prototype.SummonIllusions(self, caster, center, token)
	local baseDirection = caster:GetForwardVector()
	local baseAngle = math.atan2(baseDirection.y, baseDirection.x)
	do
		local index = 0
		while index < BOSS_NIGHT_005_ILLUSION_COUNT do
			local angle = baseAngle + math.pi * 2 * index / BOSS_NIGHT_005_ILLUSION_COUNT
			local pos = GetGroundPosition(
				center:__add(Vector(math.cos(angle), math.sin(angle), 0):__mul(BOSS_NIGHT_005_ILLUSION_DISTANCE)),
				caster
			)
			self:SummonIllusion(caster, pos, center, token)
			index = index + 1
		end
	end
end
function boss_night_005.prototype.SummonIllusion(self, caster, summonPos, lookTarget, token)
	MyGameUnit:CreateSummonedUnitAsync({
		unitName = BOSS_NIGHT_005_ILLUSION_UNIT_NAME,
		position = summonPos,
		roomId = caster:GetRoomId(),
		team = caster:GetTeamNumber(),
		owner = caster,
		summoner = caster,
		summonTag = BOSS_NIGHT_005_ILLUSION_SUMMON_TAG,
		maxSummons = BOSS_NIGHT_005_ILLUSION_COUNT,
		findClearSpace = true,
		onSpawn = function(____, unit)
			if not unit or not IsValidAlive(nil, unit) or token ~= self.activePhaseToken then
				return
			end
			local illusionHealth =
				math.max(1, math.floor(caster:GetMaxHealth() * (BOSS_NIGHT_005_ILLUSION_HEALTH_PCT / 100)))
			unit:SetForwardVectorWithoutInterrupt(GetDirection(nil, lookTarget, unit:GetAbsOrigin()))
			unit:SetRenderColor(80, 80, 150)
			local ____self_illusionEntIndexes_2 = self.illusionEntIndexes
			____self_illusionEntIndexes_2[#____self_illusionEntIndexes_2 + 1] = unit:entindex()
			modifier_boss_night_005_illusion_state:applys(
				unit,
				caster,
				self,
				{
					duration = BOSS_NIGHT_005_PHASE_DURATION,
					token = token,
					reveal_delay = BOSS_NIGHT_005_BOSS_MOVE_DURATION,
				}
			)
		end,
	})
end
function boss_night_005.prototype.FireIllusionProjectile(self, illusion, token)
	local startTime
	local caster = self:GetCaster()
	if token ~= self.activePhaseToken or not IsValidAlive(nil, caster) or not IsValidAlive(nil, illusion) then
		return
	end
	local origin = illusion:GetAbsOrigin()
	local target = illusion:GetMinDistanceUnit(2600, origin) or caster:GetMinDistanceUnit(2600, origin)
	local lockedDirection = self:ResolveForwardDirection(illusion)
	local aimDuration =
		math.max(0, BOSS_NIGHT_005_ILLUSION_WARNING_DURATION - BOSS_NIGHT_005_ILLUSION_AIM_FREEZE_BEFORE_FIRE)
	if IsValidAlive(nil, target) then
		lockedDirection = GetDirection(nil, target:GetAbsOrigin(), origin)
		illusion:LockTargetForSpeed(target, aimDuration, 12)
	end
	local function getWarningDirection()
		if aimDuration > 0 and GameRules:GetGameTime() - startTime < aimDuration then
			lockedDirection = self:ResolveForwardDirection(illusion)
		end
		return lockedDirection
	end
	startTime = GameRules:GetGameTime()
	local endPos = origin:__add(getWarningDirection(nil):__mul(BOSS_NIGHT_005_PROJECTILE_DISTANCE))
	self:WarningEffect(origin, endPos, BOSS_NIGHT_005_ILLUSION_WARNING_DURATION, {
		startWidth = BOSS_NIGHT_005_PROJECTILE_RADIUS,
		endWidth = BOSS_NIGHT_005_PROJECTILE_RADIUS,
		getDirection = function()
			return getWarningDirection(nil)
		end,
	})
	self:Timer(aimDuration, function()
		if token ~= self.activePhaseToken or not IsValidAlive(nil, illusion) then
			return
		end
		lockedDirection = self:ResolveForwardDirection(illusion)
		illusion:SetForwardVectorWithoutInterrupt(lockedDirection)
	end)
	local animationStartDelay =
		math.max(0, BOSS_NIGHT_005_ILLUSION_WARNING_DURATION - BOSS_NIGHT_005_ILLUSION_FIRE_ANIMATION_K_POINT)
	self:Timer(animationStartDelay, function()
		if token ~= self.activePhaseToken or not IsValidAlive(nil, illusion) then
			return
		end
		illusion:SetAnimation(BOSS_NIGHT_005_ILLUSION_FIRE_ANIMATION)
	end)
	self:Timer(BOSS_NIGHT_005_ILLUSION_WARNING_DURATION, function()
		if token ~= self.activePhaseToken or not IsValidAlive(nil, caster) or not IsValidAlive(nil, illusion) then
			return
		end
		local projectileDirection = lockedDirection
		EmitSoundOn(ILLUSION_PROJECTILE_CAST_SOUND, illusion)
		self:PlayIllusionProjectileParticle(illusion:GetAbsOrigin(), projectileDirection)
		CreateProjectile(nil, {
			caster = caster,
			ability = self,
			effect_name = "",
			projectile_type = "linear",
			start_point = illusion:GetAbsOrigin(),
			direction = projectileDirection,
			projectile_speed = BOSS_NIGHT_005_PROJECTILE_SPEED,
			projectile_distance = BOSS_NIGHT_005_PROJECTILE_DISTANCE,
			projectile_range = BOSS_NIGHT_005_PROJECTILE_RADIUS,
			projectile_target_team = DOTA_UNIT_TARGET_TEAM_ENEMY,
			projectile_target_type = DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC + DOTA_UNIT_TARGET_BUILDING,
			projectile_target_flags = DOTA_UNIT_TARGET_FLAG_MAGIC_IMMUNE_ENEMIES,
			on_hit = function(____, hitTarget)
				if not hitTarget or not IsValidAlive(nil, hitTarget) then
					return true
				end
				if not IsValidAlive(nil, caster) then
					return
				end
				caster:MonsterDamage({
					victim = hitTarget,
					damage_rate = BOSS_NIGHT_005_PROJECTILE_DAMAGE_RATE,
					ability = self,
					effectName = ILLUSION_HIT_PARTICLE,
				})
				return true
			end,
		})
	end)
end
function boss_night_005.prototype.ResolveForwardDirection(self, unit)
	if not IsValidAlive(nil, unit) then
		return Vector(0, 1, 0)
	end
	local forward = unit:GetForwardVector()
	local ____temp_3
	if forward:Length2D() > 0.01 then
		____temp_3 = forward:Normalized()
	else
		____temp_3 = Vector(0, 1, 0)
	end
	return ____temp_3
end
function boss_night_005.prototype.PlayIllusionProjectileParticle(self, startPoint, direction)
	local pfx = ParticleManager:CreateParticle(ILLUSION_PROJECTILE_PARTICLE, PATTACH_WORLDORIGIN, nil)
	ParticleManager:SetParticleControl(pfx, 0, startPoint)
	ParticleManager:SetParticleControl(pfx, 1, direction:__mul(BOSS_NIGHT_005_PROJECTILE_SPEED))
	ParticleManager:SetParticleControl(
		pfx,
		2,
		Vector(BOSS_NIGHT_005_PROJECTILE_RADIUS, BOSS_NIGHT_005_PROJECTILE_RADIUS, BOSS_NIGHT_005_PROJECTILE_RADIUS)
	)
	local travelDuration = BOSS_NIGHT_005_PROJECTILE_DISTANCE / BOSS_NIGHT_005_PROJECTILE_SPEED
	Timers:CreateTimer(travelDuration + 0.2, function()
		ParticleManager:DestroyParticle(pfx, false)
		ParticleManager:ReleaseParticleIndex(pfx)
		return nil
	end)
end
function boss_night_005.prototype.GetAliveIllusions(self)
	local illusions = {}
	for ____, entIndex in ipairs(self.illusionEntIndexes) do
		local unit = EntIndexToHScript(entIndex)
		if IsValidAlive(nil, unit) then
			illusions[#illusions + 1] = unit
		end
	end
	return illusions
end
function boss_night_005.prototype.PlayReturnEffectsAndHeal(self, boss, illusions, healAmount)
	if not IsValidAlive(nil, boss) then
		self:CleanupIllusions(illusions)
		return
	end
	if #illusions > 0 then
		EmitSoundOn(NIGHTFALL_RETURN_SOUND, boss)
	end
	for ____, illusion in ipairs(illusions) do
		do
			if not IsValidAlive(nil, illusion) then
				goto __continue70
			end
			self:PlayAbsorbEffect(illusion, boss)
			PlayPointParticle(nil, ILLUSION_SUMMON_PARTICLE, illusion:GetAbsOrigin(), 1, illusion)
			illusion:AddNoDrawWithWearables()
			MyGameUnit:DestroyUnit(illusion)
		end
		::__continue70::
	end
	if healAmount > 0 then
		boss:CustomHeal(healAmount, { ability = self, source = "spell" })
	end
end
function boss_night_005.prototype.CleanupIllusions(self, illusions)
	for ____, illusion in ipairs(illusions) do
		do
			if not IsValid(nil, illusion) or illusion:IsNull() then
				goto __continue75
			end
			illusion:AddNoDrawWithWearables()
			MyGameUnit:DestroyUnit(illusion)
		end
		::__continue75::
	end
end
function boss_night_005.prototype.PlayAbsorbEffect(self, illusion, boss)
	if not IsValidAlive(nil, boss) or not IsValidAlive(nil, illusion) then
		return
	end
	local origin = illusion:GetAbsOrigin()
	local thinker = CreateModifierThinker(
		illusion,
		self,
		"modifier_dummy_thinker",
		{ duration = 2 },
		origin,
		illusion:GetTeamNumber(),
		false
	)
	local pfx = ParticleManager:CreateParticle(ILLUSION_ABSORB_PARTICLE, PATTACH_ABSORIGIN_FOLLOW, thinker)
	ParticleManager:SetParticleControl(pfx, 0, origin)
	ParticleManager:SetParticleControlEnt(
		pfx,
		1,
		boss,
		PATTACH_POINT_FOLLOW,
		"attach_attack1",
		boss:GetAbsOrigin(),
		true
	)
	Timers:CreateTimer(1.5, function()
		ParticleManager:DestroyParticle(pfx, false)
		ParticleManager:ReleaseParticleIndex(pfx)
		if IsValid(nil, thinker) and not thinker:IsNull() then
			thinker:RemoveSelf()
		end
		return nil
	end)
end
boss_night_005 = __TS__DecorateLegacy({ registerAbility(nil) }, boss_night_005)
____exports.boss_night_005 = boss_night_005
--- 夜幕分身阶段：Boss 位于中心并处于无敌状态。
____exports.modifier_boss_night_005_buff = __TS__Class()
local modifier_boss_night_005_buff = ____exports.modifier_boss_night_005_buff
modifier_boss_night_005_buff.name = "modifier_boss_night_005_buff"
__TS__ClassExtends(modifier_boss_night_005_buff, BaseModifier_CS)
function modifier_boss_night_005_buff.prototype.____constructor(self, ...)
	BaseModifier_CS.prototype.____constructor(self, ...)
	self.wearableEntities = {}
end
function modifier_boss_night_005_buff.GetLocalizationCN(self)
	return {
		name = "夜幕分身",
		description = "分身阶段中处于无敌状态。击破分身可减少结束时的回血。",
	}
end
function modifier_boss_night_005_buff.prototype.OnCreated(self)
	if not IsServer() then
		return
	end
	self:ApplyWearables()
	self:PlayNightfallEffects()
	self:StartIntervalThink(NIGHTFALL_LOOP_ANIMATION_INTERVAL)
	self:PlayLoopAnimation()
	EmitSoundOn("Hero_Nightstalker.Darkness.Team", self:GetParent())
end
function modifier_boss_night_005_buff.prototype.OnIntervalThink(self)
	if not IsServer() then
		return
	end
	self:PlayLoopAnimation()
end
function modifier_boss_night_005_buff.prototype.OnDestroy(self)
	if not IsServer() then
		return
	end
	self:RemoveWearables()
	self:DestroyNightfallParticle()
end
function modifier_boss_night_005_buff.prototype.PlayNightfallEffects(self)
	local parent = self:GetParent()
	self:DestroyNightfallParticle()
	self.darknessParticle = ParticleManager:CreateParticle(NIGHTFALL_PARTICLE, PATTACH_ABSORIGIN_FOLLOW, parent)
	ParticleManager:SetParticleControlEnt(
		self.darknessParticle,
		0,
		parent,
		PATTACH_POINT_FOLLOW,
		"attach_hitloc",
		parent:GetAbsOrigin(),
		true
	)
end
function modifier_boss_night_005_buff.prototype.PlayLoopAnimation(self)
	local parent = self:GetParent()
	if not IsValidAlive(nil, parent) then
		return
	end
	parent:SetForwardVectorWithoutInterrupt(NIGHTFALL_BOSS_FORWARD)
	parent:SetAnimation(NIGHTFALL_LOOP_ANIMATION)
end
function modifier_boss_night_005_buff.prototype.DestroyNightfallParticle(self)
	if self.darknessParticle == nil then
		return
	end
	ParticleManager:DestroyParticle(self.darknessParticle, false)
	ParticleManager:ReleaseParticleIndex(self.darknessParticle)
	self.darknessParticle = nil
end
function modifier_boss_night_005_buff.prototype.ApplyWearables(self)
	self:RemoveWearables()
	self.wearableEntities = CreateNightfallWearables(nil, self:GetParent())
end
function modifier_boss_night_005_buff.prototype.RemoveWearables(self)
	RemoveNightfallWearables(nil, self.wearableEntities)
	self.wearableEntities = {}
end
function modifier_boss_night_005_buff.prototype.CheckState(self)
	return {
		[MODIFIER_STATE_INVULNERABLE] = true,
		[MODIFIER_STATE_UNSELECTABLE] = true,
		[MODIFIER_STATE_NO_HEALTH_BAR] = true,
		[MODIFIER_STATE_ROOTED] = true,
		[MODIFIER_STATE_DISARMED] = true,
		[MODIFIER_STATE_SILENCED] = true,
	}
end
function modifier_boss_night_005_buff.prototype.DeclareFunctions(self)
	return { MODIFIER_PROPERTY_MODEL_CHANGE, MODIFIER_PROPERTY_TRANSLATE_ACTIVITY_MODIFIERS }
end
function modifier_boss_night_005_buff.prototype.GetModifierModelChange(self)
	return NIGHTFALL_MODEL
end
function modifier_boss_night_005_buff.prototype.GetActivityTranslationModifiers(self)
	return NIGHTFALL_ACTIVITY_MODIFIER
end
function modifier_boss_night_005_buff.prototype.IsHidden(self)
	return false
end
function modifier_boss_night_005_buff.prototype.IsPurgable(self)
	return false
end
function modifier_boss_night_005_buff.prototype.GetTexture(self)
	return "night_stalker_darkness"
end
modifier_boss_night_005_buff = __TS__DecorateLegacy({ registerModifier(nil) }, modifier_boss_night_005_buff)
____exports.modifier_boss_night_005_buff = modifier_boss_night_005_buff
--- 夜幕分身：固定炮台，显示倒计时并周期预警发射投射物。
modifier_boss_night_005_illusion_state = __TS__Class()
modifier_boss_night_005_illusion_state.name = "modifier_boss_night_005_illusion_state"
__TS__ClassExtends(modifier_boss_night_005_illusion_state, BaseModifier_CS)
function modifier_boss_night_005_illusion_state.prototype.____constructor(self, ...)
	BaseModifier_CS.prototype.____constructor(self, ...)
	self.wearableEntities = {}
	self.remaining = BOSS_NIGHT_005_PHASE_DURATION
	self.token = 0
	self.nextShotTime = BOSS_NIGHT_005_ILLUSION_SHOT_FIRST_DELAY
	self.revealed = false
end
function modifier_boss_night_005_illusion_state.prototype.OnCreated(self, params)
	if not IsServer() then
		return
	end
	local parent = self:GetParent()
	self.token = params.token or 0
	self.remaining = BOSS_NIGHT_005_PHASE_DURATION
	self.nextShotTime = BOSS_NIGHT_005_ILLUSION_SHOT_FIRST_DELAY
	self.revealed = false
	parent:SetMoveCapability(DOTA_UNIT_CAP_MOVE_NONE)
	parent:SetAttackCapability(DOTA_UNIT_CAP_NO_ATTACK)
	parent:AddNoDrawWithWearables()
	local revealDelay = params.reveal_delay or 0
	if revealDelay <= 0 then
		self:RevealIllusion()
	else
		self:Timer(revealDelay, function()
			return self:RevealIllusion()
		end)
	end
	self:StartIntervalThink(0.25)
end
function modifier_boss_night_005_illusion_state.prototype.RevealIllusion(self)
	if not IsServer() or self.revealed or self:IsRemoved() then
		return
	end
	local parent = self:GetParent()
	if not IsValidAlive(nil, parent) then
		return
	end
	self.revealed = true
	parent:RemoveNoDrawWithWearables()
	self.wearableEntities = CreateNightfallWearables(nil, parent)
	ApplyIllusionStatusToWearables(nil, self.wearableEntities, parent, self:GetAbility())
	self:CreateCountdownParticle()
	PlayPointParticle(nil, ILLUSION_SUMMON_PARTICLE, parent:GetAbsOrigin(), 1, parent)
	parent:StartGesture(ACT_DOTA_SPAWN)
end
function modifier_boss_night_005_illusion_state.prototype.OnIntervalThink(self)
	if not IsServer() then
		return
	end
	local parent = self:GetParent()
	if not IsValidAlive(nil, parent) then
		self:Destroy()
		return
	end
	local elapsed = self:GetElapsedTime()
	self.remaining = math.max(0, BOSS_NIGHT_005_PHASE_DURATION - elapsed)
	self:UpdateCountdownParticle()
	if elapsed >= self.nextShotTime then
		self.nextShotTime = self.nextShotTime + BOSS_NIGHT_005_ILLUSION_SHOT_INTERVAL
		local ability = self:GetAbility()
		if ability ~= nil then
			ability:FireIllusionProjectile(parent, self.token)
		end
	end
end
function modifier_boss_night_005_illusion_state.prototype.OnDestroy(self)
	if not IsServer() then
		return
	end
	self:DestroyCountdownParticle()
	RemoveNightfallWearables(nil, self.wearableEntities)
	self.wearableEntities = {}
	self.revealed = false
end
function modifier_boss_night_005_illusion_state.prototype.CreateCountdownParticle(self)
	local parent = self:GetParent()
	if not IsValidAlive(nil, parent) then
		return
	end
	local pos = parent:GetAbsOrigin():__add(Vector(0, 0, BOSS_NIGHT_005_COUNTDOWN_HEIGHT))
	self.countdownPfx = ParticleManager:CreateParticle(COUNTDOWN_PARTICLE, PATTACH_WORLDORIGIN, parent)
	ParticleManager:SetParticleControl(self.countdownPfx, 0, pos)
	ParticleManager:SetParticleControl(self.countdownPfx, 1, CountdownParticleCp1(nil, BOSS_NIGHT_005_PHASE_DURATION))
	ParticleManager:SetParticleShouldCheckFoW(self.countdownPfx, false)
end
function modifier_boss_night_005_illusion_state.prototype.UpdateCountdownParticle(self)
	if self.countdownPfx == nil then
		return
	end
	local parent = self:GetParent()
	if not IsValidAlive(nil, parent) then
		return
	end
	local pos = parent:GetAbsOrigin():__add(Vector(0, 0, BOSS_NIGHT_005_COUNTDOWN_HEIGHT))
	local displayValue = math.max(1, math.ceil(self.remaining))
	ParticleManager:SetParticleControl(self.countdownPfx, 0, pos)
	ParticleManager:SetParticleControl(self.countdownPfx, 1, CountdownParticleCp1(nil, displayValue))
end
function modifier_boss_night_005_illusion_state.prototype.DestroyCountdownParticle(self)
	if self.countdownPfx == nil then
		return
	end
	ParticleManager:DestroyParticle(self.countdownPfx, false)
	ParticleManager:ReleaseParticleIndex(self.countdownPfx)
	self.countdownPfx = nil
end
function modifier_boss_night_005_illusion_state.prototype.CheckState(self)
	return {
		[MODIFIER_STATE_COMMAND_RESTRICTED] = true,
		[MODIFIER_STATE_ROOTED] = true,
		[MODIFIER_STATE_DISARMED] = true,
		[MODIFIER_STATE_SILENCED] = true,
		[MODIFIER_STATE_NO_UNIT_COLLISION] = true,
	}
end
function modifier_boss_night_005_illusion_state.prototype.DeclareFunctions(self)
	return { MODIFIER_PROPERTY_MODEL_CHANGE, MODIFIER_PROPERTY_TRANSLATE_ACTIVITY_MODIFIERS }
end
function modifier_boss_night_005_illusion_state.prototype.GetModifierModelChange(self)
	return NIGHTFALL_MODEL
end
function modifier_boss_night_005_illusion_state.prototype.GetActivityTranslationModifiers(self)
	return NIGHTFALL_ACTIVITY_MODIFIER
end
function modifier_boss_night_005_illusion_state.prototype.GetStatusEffectName(self)
	return ILLUSION_STATUS_EFFECT
end
function modifier_boss_night_005_illusion_state.prototype.IsHidden(self)
	return true
end
function modifier_boss_night_005_illusion_state.prototype.IsPurgable(self)
	return false
end
modifier_boss_night_005_illusion_state =
	__TS__DecorateLegacy({ registerModifier(nil) }, modifier_boss_night_005_illusion_state)
modifier_boss_night_005_illusion_status = __TS__Class()
modifier_boss_night_005_illusion_status.name = "modifier_boss_night_005_illusion_status"
__TS__ClassExtends(modifier_boss_night_005_illusion_status, BaseModifier_CS)
function modifier_boss_night_005_illusion_status.prototype.GetStatusEffectName(self)
	return ILLUSION_STATUS_EFFECT
end
function modifier_boss_night_005_illusion_status.prototype.RemoveOnDeath(self)
	return false
end
function modifier_boss_night_005_illusion_status.prototype.IsHidden(self)
	return true
end
function modifier_boss_night_005_illusion_status.prototype.IsPurgable(self)
	return false
end
modifier_boss_night_005_illusion_status =
	__TS__DecorateLegacy({ registerModifier(nil) }, modifier_boss_night_005_illusion_status)
return ____exports