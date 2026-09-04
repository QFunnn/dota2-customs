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
local __TS__ObjectAssign = ____lualib.__TS__ObjectAssign
local __TS__DecorateLegacy = ____lualib.__TS__DecorateLegacy
local ____exports = {}
local modifier_boss_chaos_phase_field, modifier_boss_chaos_phase_follow_effect
local ____dota_ts_adapter = require("utils.dota_ts_adapter")
local registerAbility = ____dota_ts_adapter.registerAbility
local registerModifier = ____dota_ts_adapter.registerModifier
local ____monster_base = require("abilities.monster.monster_base")
local MonsterModifier_CS = ____monster_base.MonsterModifier_CS
local warningEffectRing = ____monster_base.warningEffectRing
local ____boss_simple_phase_summon = require("abilities.monster.boss.boss_simple_phase_summon")
local boss_simple_phase_summon = ____boss_simple_phase_summon.boss_simple_phase_summon
local SIMPLE_PHASE_SUMMON_COUNT = ____boss_simple_phase_summon.SIMPLE_PHASE_SUMMON_COUNT
local SIMPLE_PHASE_SUMMON_RADIUS = ____boss_simple_phase_summon.SIMPLE_PHASE_SUMMON_RADIUS
local CHAOS_PHASE_BLINK_EFFECT = "particles/blink_dagger_ti9_steam.vpcf"
local CHAOS_PHASE_ICE_EFFECT = "particles/dd/ice_buff.vpcf"
local CHAOS_PHASE_FIELD_EFFECT =
	"particles/econ/items/crystal_maiden/crystal_maiden_maiden_of_icewrack/maiden_freezing_field_snow_arcana1.vpcf"
local CHAOS_PHASE_ICE_STORM_EFFECT =
	"particles/units/heroes/hero_crystalmaiden_persona/cm_persona_freezing_field_explosion.vpcf"
local CHAOS_PHASE_ICE_PATH_EFFECT = "particles/units/heroes/hero_jakiro/jakiro_ice_path.vpcf"
local CHAOS_PHASE_CRYSTAL_SOUND_EVENTS = "soundevents/game_sounds_heroes/game_sounds_crystalmaiden.vsndevts"
local CHAOS_PHASE_ICE_PATH_SOUND_EVENTS = "soundevents/game_sounds_heroes/game_sounds_jakiro.vsndevts"
local CHAOS_PHASE_FROST_SOUND_EVENTS = "soundevents/game_sounds_heroes/game_sounds_lich.vsndevts"
local CHAOS_PHASE_BLINK_SOUND = "DOTA_Item.BlinkDagger.Activate"
local CHAOS_PHASE_SUMMON_SOUND = "Ability.FrostNova"
local CHAOS_PHASE_ICE_STORM_IMPACT_SOUND = "Hero_Crystal.FreezingField.Explosion"
local CHAOS_PHASE_ICE_PATH_IMPACT_SOUND = "Hero_Jakiro.IcePath"
local CHAOS_PHASE_DURATION = 6
local CHAOS_PHASE_FACE_INTERVAL = 0.03
local CHAOS_PHASE_TARGET_SEARCH_RANGE = 2500
local CHAOS_PHASE_SUMMON_ACQUISITION_RANGE = 2500
local CHAOS_PHASE_SUMMON_AT = 1.87
local CHAOS_PHASE_FOLLOW_EFFECT_DURATION = 3
local CHAOS_PHASE_ICE_STORM_AT = 1.3
local CHAOS_PHASE_ICE_STORM_COUNT = 5
local CHAOS_PHASE_ICE_STORM_RANDOM_RADIUS = 550
local CHAOS_PHASE_ICE_STORM_WARNING_DURATION = 0.5
local CHAOS_PHASE_ICE_STORM_DAMAGE_RADIUS = 150
local CHAOS_PHASE_ICE_STORM_DAMAGE_RATE = 12
local CHAOS_PHASE_ICE_PATH_AT = 2
local CHAOS_PHASE_ICE_PATH_EFFECT_DURATION = 1.6
local CHAOS_PHASE_ICE_PATH_DELAY = CHAOS_PHASE_ICE_PATH_EFFECT_DURATION
local CHAOS_PHASE_ICE_PATH_LENGTH = 1000
local CHAOS_PHASE_ICE_PATH_WIDTH = 100
local CHAOS_PHASE_ICE_PATH_DAMAGE_RATE = 16
local CHAOS_PHASE_ICE_PATH_STUN_DURATION = 1.2
____exports.boss_chaos_phase_summon = __TS__Class()
local boss_chaos_phase_summon = ____exports.boss_chaos_phase_summon
boss_chaos_phase_summon.name = "boss_chaos_phase_summon"
__TS__ClassExtends(boss_chaos_phase_summon, boss_simple_phase_summon)
function boss_chaos_phase_summon.prototype.Precache(self, context)
	boss_simple_phase_summon.prototype.Precache(self, context)
	PrecacheResource("particle", CHAOS_PHASE_BLINK_EFFECT, context)
	PrecacheResource("particle", CHAOS_PHASE_ICE_EFFECT, context)
	PrecacheResource("particle", CHAOS_PHASE_FIELD_EFFECT, context)
	PrecacheResource("particle", CHAOS_PHASE_ICE_STORM_EFFECT, context)
	PrecacheResource("particle", CHAOS_PHASE_ICE_PATH_EFFECT, context)
	PrecacheResource("soundfile", CHAOS_PHASE_CRYSTAL_SOUND_EVENTS, context)
	PrecacheResource("soundfile", CHAOS_PHASE_ICE_PATH_SOUND_EVENTS, context)
	PrecacheResource("soundfile", CHAOS_PHASE_FROST_SOUND_EVENTS, context)
end
function boss_chaos_phase_summon.prototype.GetBossPhaseTransitionReturnToSpawnDuration(self)
	return 0
end
function boss_chaos_phase_summon.prototype.GetBossPhaseTransitionWindowDuration(self)
	return CHAOS_PHASE_DURATION
end
function boss_chaos_phase_summon.prototype.GetBossPhaseTransitionGesture(self)
	return nil
end
function boss_chaos_phase_summon.prototype.GetBossPhaseTransitionConfig(self)
	local cfg = boss_simple_phase_summon.prototype.GetBossPhaseTransitionConfig(self)
	return __TS__ObjectAssign({}, cfg, {
		OnStart = function()
			local caster = self:GetCaster()
			if not IsValidAlive(nil, caster) then
				return
			end
			self:StartChaosPhaseTransition(caster, self:GetSimplePhaseSummonConfig())
		end,
	})
end
function boss_chaos_phase_summon.prototype.GetSimplePhaseSummonConfig(self)
	return {
		summonUnitName = "monster_13014",
		note = "冰原领主：M003 普通怪无技能综合最高，企鹅卫士",
	}
end
function boss_chaos_phase_summon.prototype.StartChaosPhaseTransition(self, caster, config)
	local originalPos = caster:GetAbsOrigin()
	self:PlayBlinkEffect(originalPos, caster)
	local center = self:ResolveCenterPoint(caster)
	caster:SetAbsOrigin(center)
	FindClearSpaceForUnit(caster, center, true)
	caster:StartGestureWithPlaybackRate(ACT_DOTA_CAST_ABILITY_3, 1)
	modifier_boss_chaos_phase_field:applys(caster, caster, self, {
		duration = self:GetBossPhaseTransitionWindowDuration(),
		center_x = center.x,
		center_y = center.y,
		center_z = center.z,
		face_duration = CHAOS_PHASE_ICE_PATH_AT,
	})
	self:Timer(CHAOS_PHASE_SUMMON_AT, function()
		if not IsValidAlive(nil, caster) then
			return
		end
		self:PlayFollowEffect(caster, CHAOS_PHASE_FOLLOW_EFFECT_DURATION)
		self:SummonChaosPhaseMonsters(caster, config, center)
	end)
end
function boss_chaos_phase_summon.prototype.SummonChaosPhaseMonsters(self, caster, config, center)
	local roomId = caster:GetRoomId()
	EmitSoundOnLocationWithCaster(center, CHAOS_PHASE_SUMMON_SOUND, caster)
	do
		local i = 0
		while i < SIMPLE_PHASE_SUMMON_COUNT do
			local currentIndex = i
			local angle = math.pi * 2 * currentIndex / SIMPLE_PHASE_SUMMON_COUNT
			local offset =
				Vector(math.cos(angle) * SIMPLE_PHASE_SUMMON_RADIUS, math.sin(angle) * SIMPLE_PHASE_SUMMON_RADIUS, 0)
			local summonPos = GetGroundPosition(center:__add(offset), caster)
			MyGameUnit:CreateSummonedUnitAsync({
				unitName = config.summonUnitName,
				summonTag = "phase_summon_" .. caster:GetUnitName(),
				maxSummons = SIMPLE_PHASE_SUMMON_COUNT,
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
					unit:StartGestureWithPlaybackRate(ACT_DOTA_SPAWN, 0.8)
					unit:SetForwardVectorWithoutInterrupt(GetDirection(nil, summonPos, caster:GetAbsOrigin()))
					unit:SetAcquisitionRange(CHAOS_PHASE_SUMMON_ACQUISITION_RANGE)
					self:PlayFollowEffect(unit, CHAOS_PHASE_FOLLOW_EFFECT_DURATION)
				end,
			})
			i = i + 1
		end
	end
end
function boss_chaos_phase_summon.prototype.StartIceStorm(self, caster)
	local target = caster:GetMinDistanceUnit(CHAOS_PHASE_TARGET_SEARCH_RANGE)
	local ____IsValidAlive_result_0
	if IsValidAlive(nil, target) then
		____IsValidAlive_result_0 = target:GetAbsOrigin()
	else
		____IsValidAlive_result_0 = caster:GetAbsOrigin()
	end
	local stormCenter = ____IsValidAlive_result_0
	do
		local i = 0
		while i < CHAOS_PHASE_ICE_STORM_COUNT do
			local randomOffset = RandomVector(RandomFloat(0, CHAOS_PHASE_ICE_STORM_RANDOM_RADIUS))
			local impactPos = GetGroundPosition(stormCenter:__add(randomOffset), caster)
			self:PlayIceStormEffect(impactPos, caster)
			warningEffectRing(
				nil,
				caster,
				impactPos,
				CHAOS_PHASE_ICE_STORM_DAMAGE_RADIUS,
				CHAOS_PHASE_ICE_STORM_WARNING_DURATION,
				{ speed = 0 }
			)
			self:Timer(CHAOS_PHASE_ICE_STORM_WARNING_DURATION, function()
				if not IsValidAlive(nil, caster) then
					return
				end
				EmitSoundOnLocationWithCaster(impactPos, CHAOS_PHASE_ICE_STORM_IMPACT_SOUND, caster)
				self:DamageIceStormPoint(caster, impactPos)
			end)
			i = i + 1
		end
	end
end
function boss_chaos_phase_summon.prototype.PlayIceStormEffect(self, position, caster)
	local effect = ParticleManager:CreateParticle(CHAOS_PHASE_ICE_STORM_EFFECT, PATTACH_WORLDORIGIN, nil)
	ParticleManager:SetParticleControl(effect, 0, position)
	ParticleManager:ReleaseParticleIndex(effect)
end
function boss_chaos_phase_summon.prototype.DamageIceStormPoint(self, caster, position)
	local enemies = FindUnitsInRadius(
		caster:GetTeamNumber(),
		position,
		nil,
		CHAOS_PHASE_ICE_STORM_DAMAGE_RADIUS,
		DOTA_UNIT_TARGET_TEAM_ENEMY,
		DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,
		DOTA_UNIT_TARGET_FLAG_NONE,
		FIND_ANY_ORDER,
		false
	)
	for ____, enemy in ipairs(enemies) do
		do
			if not IsValidAlive(nil, enemy) then
				goto __continue24
			end
			caster:MonsterDamage({ victim = enemy, damage_rate = CHAOS_PHASE_ICE_STORM_DAMAGE_RATE, ability = self })
		end
		::__continue24::
	end
end
function boss_chaos_phase_summon.prototype.StartIcePath(self, caster)
	local start = GetGroundPosition(caster:GetAbsOrigin(), caster)
	local direction = caster:GetForwardVector()
	local ____end = GetGroundPosition(start:__add(direction:__mul(CHAOS_PHASE_ICE_PATH_LENGTH)), caster)
	local effect = ParticleManager:CreateParticle(CHAOS_PHASE_ICE_PATH_EFFECT, PATTACH_WORLDORIGIN, nil)
	ParticleManager:SetParticleControl(effect, 0, start)
	ParticleManager:SetParticleControl(effect, 1, ____end)
	ParticleManager:SetParticleControl(effect, 2, Vector(CHAOS_PHASE_ICE_PATH_DELAY, 0, 0))
	ParticleManager:SetParticleControl(effect, 3, Vector(100, 0, 0))
	self:Timer(CHAOS_PHASE_ICE_PATH_DELAY, function()
		if not IsValidAlive(nil, caster) then
			return
		end
		self:DamageIcePath(caster, start, ____end)
	end)
	Timers:CreateTimer(CHAOS_PHASE_ICE_PATH_DELAY, function()
		ParticleManager:DestroyParticle(effect, false)
		ParticleManager:ReleaseParticleIndex(effect)
		return nil
	end)
end
function boss_chaos_phase_summon.prototype.DamageIcePath(self, caster, start, ____end)
	EmitSoundOnLocationWithCaster(start, CHAOS_PHASE_ICE_PATH_IMPACT_SOUND, caster)
	local enemies = FindUnitsInLine(
		caster:GetTeamNumber(),
		start,
		____end,
		nil,
		CHAOS_PHASE_ICE_PATH_WIDTH,
		DOTA_UNIT_TARGET_TEAM_ENEMY,
		DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,
		DOTA_UNIT_TARGET_FLAG_NONE
	)
	for ____, enemy in ipairs(enemies) do
		do
			if not IsValidAlive(nil, enemy) then
				goto __continue32
			end
			caster:MonsterDamage({ victim = enemy, damage_rate = CHAOS_PHASE_ICE_PATH_DAMAGE_RATE, ability = self })
			AddDeBuffStatus(
				nil,
				enemy,
				caster,
				self,
				DebuffStatusType.STUN,
				{ duration = CHAOS_PHASE_ICE_PATH_STUN_DURATION }
			)
		end
		::__continue32::
	end
end
function boss_chaos_phase_summon.prototype.PlayBlinkEffect(self, position, caster)
	local effect = ParticleManager:CreateParticle(CHAOS_PHASE_BLINK_EFFECT, PATTACH_WORLDORIGIN, nil)
	ParticleManager:SetParticleControl(effect, 0, position)
	ParticleManager:ReleaseParticleIndex(effect)
	EmitSoundOnLocationWithCaster(position, CHAOS_PHASE_BLINK_SOUND, caster)
end
function boss_chaos_phase_summon.prototype.PlayFollowEffect(self, target, duration)
	modifier_boss_chaos_phase_follow_effect:applys(
		target,
		target,
		self,
		{ duration = duration, effect = CHAOS_PHASE_ICE_EFFECT }
	)
end
boss_chaos_phase_summon = __TS__DecorateLegacy({ registerAbility(nil) }, boss_chaos_phase_summon)
____exports.boss_chaos_phase_summon = boss_chaos_phase_summon
modifier_boss_chaos_phase_field = __TS__Class()
modifier_boss_chaos_phase_field.name = "modifier_boss_chaos_phase_field"
__TS__ClassExtends(modifier_boss_chaos_phase_field, MonsterModifier_CS)
function modifier_boss_chaos_phase_field.prototype.____constructor(self, ...)
	MonsterModifier_CS.prototype.____constructor(self, ...)
	self.center = Vector(0, 0, 0)
	self.faceDuration = 0
end
function modifier_boss_chaos_phase_field.prototype.IsHidden(self)
	return true
end
function modifier_boss_chaos_phase_field.prototype.IsPurgable(self)
	return false
end
function modifier_boss_chaos_phase_field.prototype.OnCreated(self, params)
	if not IsServer() then
		return
	end
	local parent = self:GetParent()
	if not IsValidAlive(nil, parent) then
		return
	end
	self.center = Vector(
		params.center_x or parent:GetAbsOrigin().x,
		params.center_y or parent:GetAbsOrigin().y,
		params.center_z or parent:GetAbsOrigin().z
	)
	self.faceDuration = math.max(0, params.face_duration or 0)
	self.effect = ParticleManager:CreateParticle(CHAOS_PHASE_FIELD_EFFECT, PATTACH_WORLDORIGIN, nil)
	ParticleManager:SetParticleShouldCheckFoW(self.effect, false)
	ParticleManager:SetParticleControl(self.effect, 0, self.center)
	if self.faceDuration > 0 then
		self:StartIntervalThink(CHAOS_PHASE_FACE_INTERVAL)
		self:OnIntervalThink()
	end
end
function modifier_boss_chaos_phase_field.prototype.OnDestroy(self)
	if not IsServer() then
		return
	end
	self:StartIntervalThink(-1)
	if self.effect ~= nil then
		ParticleManager:DestroyParticle(self.effect, false)
		ParticleManager:ReleaseParticleIndex(self.effect)
		self.effect = nil
	end
end
function modifier_boss_chaos_phase_field.prototype.OnIntervalThink(self)
	if not IsServer() then
		return
	end
	local parent = self:GetParent()
	if not IsValidAlive(nil, parent) then
		self:Destroy()
		return
	end
	local remain = self.faceDuration - self:GetElapsedTime()
	if remain <= 0 then
		self:StartIntervalThink(-1)
		return
	end
	local target = parent:GetMinDistanceUnit(CHAOS_PHASE_TARGET_SEARCH_RANGE)
	if not IsValidAlive(nil, target) then
		return
	end
	parent:LockTargetForSpeed(target, math.min(CHAOS_PHASE_FACE_INTERVAL + FrameTime(), remain), 8)
end
modifier_boss_chaos_phase_field =
	__TS__DecorateLegacy({ registerModifier(nil, "modifier_boss_chaos_phase_field") }, modifier_boss_chaos_phase_field)
modifier_boss_chaos_phase_follow_effect = __TS__Class()
modifier_boss_chaos_phase_follow_effect.name = "modifier_boss_chaos_phase_follow_effect"
__TS__ClassExtends(modifier_boss_chaos_phase_follow_effect, MonsterModifier_CS)
function modifier_boss_chaos_phase_follow_effect.prototype.IsHidden(self)
	return true
end
function modifier_boss_chaos_phase_follow_effect.prototype.IsPurgable(self)
	return false
end
function modifier_boss_chaos_phase_follow_effect.prototype.OnCreated(self, params)
	if not IsServer() then
		return
	end
	local parent = self:GetParent()
	if not IsValidAlive(nil, parent) then
		return
	end
	local effectName = params.effect or CHAOS_PHASE_ICE_EFFECT
	self.effect = ParticleManager:CreateParticle(effectName, PATTACH_ABSORIGIN_FOLLOW, parent)
	ParticleManager:SetParticleControlEnt(
		self.effect,
		0,
		parent,
		PATTACH_ABSORIGIN_FOLLOW,
		"attach_hitloc",
		parent:GetAbsOrigin(),
		true
	)
end
function modifier_boss_chaos_phase_follow_effect.prototype.OnDestroy(self)
	if not IsServer() then
		return
	end
	if self.effect ~= nil then
		ParticleManager:DestroyParticle(self.effect, false)
		ParticleManager:ReleaseParticleIndex(self.effect)
		self.effect = nil
	end
end
modifier_boss_chaos_phase_follow_effect = __TS__DecorateLegacy(
	{ registerModifier(nil, "modifier_boss_chaos_phase_follow_effect") },
	modifier_boss_chaos_phase_follow_effect
)
return ____exports