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
local MonsterAbility_CS = ____monster_base.MonsterAbility_CS
local MonsterModifier_CS = ____monster_base.MonsterModifier_CS
local ELITE_158_CAST_POINT = 0.6
local ELITE_158_CHANNEL_DURATION = 3
local ELITE_158_SEARCH_RANGE = 3000
local ELITE_158_BEAM_SPEED = 400
local ELITE_158_BEAM_RADIUS = 300
local ELITE_158_LINGER_TIME = 0.45
local ELITE_158_LINGER_CREATE_INTERVAL = 0.1
local ELITE_158_DAMAGE_INTERVAL = 0.3
local ELITE_158_DAMAGE_RATE = 8
local PARTICLE_STAFF_BEAM = "particles/monster/elite/elite_158/staff_beam.vpcf"
local PARTICLE_BEAM_CHANNEL = "particles/monster/elite/elite_158/aghanim_beam_channel.vpcf"
local PARTICLE_BEAM_BURN = "particles/monster/elite/elite_158/aghanim_beam_burn.vpcf"
local PARTICLE_STAFF_BEAM_LINGER = "particles/monster/elite/elite_158/staff_beam_linger.vpcf"
local PARTICLE_STAFF_BEAM_TARGET_RING = "particles/monster/elite/elite_158/staff_beam_tgt_ring.vpcf"
local PARTICLE_DEBUG_RING = "particles/monster/elite/elite_158/aghanim_debug_ring.vpcf"
local SOUND_WIND_UP = "Aghanim.StaffBeams.WindUp"
local SOUND_BEAM_CAST = "Hero_Phoenix.SunRay.Cast"
local SOUND_BEAM_LOOP = "Hero_Phoenix.SunRay.Loop"
local SOUND_BEAM_STOP = "Hero_Phoenix.SunRay.Stop"
local SOUND_LINGER = "n_black_dragon.Fireball.Target"
local SOUND_BURN = "Hero_Huskar.Burning_Spear"
--- 精英技能158 - 激光射线：按 Aghanim Staff Beams 的粒子链路发射追踪射线
____exports.elite_158 = __TS__Class()
local elite_158 = ____exports.elite_158
elite_158.name = "elite_158"
__TS__ClassExtends(elite_158, MonsterAbility_CS)
function elite_158.prototype.____constructor(self, ...)
	MonsterAbility_CS.prototype.____constructor(self, ...)
	self._warnings = {}
	self._projectiles = {}
end
function elite_158.prototype.Precache(self, context)
	PrecacheResource("particle", PARTICLE_STAFF_BEAM, context)
	PrecacheResource("particle", PARTICLE_BEAM_CHANNEL, context)
	PrecacheResource("particle", PARTICLE_BEAM_BURN, context)
	PrecacheResource("particle", PARTICLE_STAFF_BEAM_LINGER, context)
	PrecacheResource("particle", PARTICLE_STAFF_BEAM_TARGET_RING, context)
	PrecacheResource("particle", PARTICLE_DEBUG_RING, context)
	PrecacheResource("soundfile", "soundevents/game_sounds_heroes/game_sounds_phoenix.vsndevts", context)
	PrecacheResource("soundfile", "soundevents/game_sounds_heroes/game_sounds_huskar.vsndevts", context)
	PrecacheResource("soundfile", "soundevents/game_sounds_heroes/game_sounds_jakiro.vsndevts", context)
end
function elite_158.prototype.GetMosnterAbilityConfig(self)
	return {
		behavior = DOTA_ABILITY_BEHAVIOR_NO_TARGET,
		castPoint = ELITE_158_CAST_POINT,
		castDuration = ELITE_158_CHANNEL_DURATION,
		castAnimation = ACT_DOTA_CAST_ABILITY_1,
		OnPhaseStart = function()
			return self:StartBeamPhase()
		end,
		OnStart = function()
			return self:StartBeams()
		end,
		OnInterrupt = function()
			return self:CleanupBeams()
		end,
		OnFinish = function()
			return self:CleanupBeams()
		end,
	}
end
function elite_158.prototype.OnProjectileThinkHandle(self, projectileHandle)
	if not IsServer() then
		return
	end
	local runtime = self:FindProjectile(projectileHandle)
	if not runtime then
		return
	end
	local location = ProjectileManager:GetTrackingProjectileLocation(projectileHandle)
	local caster = self:GetCaster()
	if not IsValidAlive(nil, runtime.thinker) or not IsValidAlive(nil, caster) then
		return
	end
	local groundLocation = GetGroundPosition(location, runtime.thinker)
	runtime.thinker:SetOrigin(groundLocation)
	ParticleManager:SetParticleControlFallback(runtime.beamFx, 0, caster:GetAbsOrigin())
	ParticleManager:SetParticleControlFallback(runtime.beamFx, 1, groundLocation)
	ParticleManager:SetParticleControlFallback(runtime.beamFx, 9, caster:GetAbsOrigin())
end
function elite_158.prototype.StartBeamPhase(self)
	local caster = self:GetCaster()
	if not IsValidAlive(nil, caster) then
		return
	end
	self:CleanupBeams(false)
	StartSoundEventFromPositionReliable(SOUND_WIND_UP, caster:GetAbsOrigin())
	self._channelFx = ParticleManager:CreateParticle(PARTICLE_BEAM_CHANNEL, PATTACH_ABSORIGIN_FOLLOW, caster)
	local targets = FindUnitsInRadius(
		caster:GetTeamNumber(),
		caster:GetAbsOrigin(),
		nil,
		ELITE_158_SEARCH_RANGE,
		DOTA_UNIT_TARGET_TEAM_ENEMY,
		DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,
		DOTA_UNIT_TARGET_FLAG_MAGIC_IMMUNE_ENEMIES,
		FIND_CLOSEST,
		false
	)
	for ____, target in ipairs(targets) do
		do
			if not IsValidAlive(nil, target) then
				goto __continue14
			end
			local sourceLoc = target:GetAbsOrigin()
			local warningFx = ParticleManager:CreateParticle(PARTICLE_DEBUG_RING, PATTACH_CUSTOMORIGIN, caster)
			ParticleManager:SetParticleControl(warningFx, 0, sourceLoc)
			local targetRingFx =
				ParticleManager:CreateParticle(PARTICLE_STAFF_BEAM_TARGET_RING, PATTACH_CUSTOMORIGIN, caster)
			ParticleManager:SetParticleControl(targetRingFx, 0, sourceLoc)
			ParticleManager:SetParticleControl(targetRingFx, 1, Vector(ELITE_158_BEAM_RADIUS, 1, 1))
			local ____self__warnings_0 = self._warnings
			____self__warnings_0[#____self__warnings_0 + 1] =
				{ target = target, sourceLoc = sourceLoc, warningFx = warningFx, targetRingFx = targetRingFx }
		end
		::__continue14::
	end
end
function elite_158.prototype.StartBeams(self)
	local caster = self:GetCaster()
	if not IsValidAlive(nil, caster) then
		return
	end
	EmitSoundOn(SOUND_BEAM_CAST, caster)
	EmitSoundOn(SOUND_BEAM_LOOP, caster)
	if #self._warnings == 0 then
		self:CreateFallbackWarning(caster)
	end
	for ____, warning in ipairs(self._warnings) do
		do
			if not IsValidAlive(nil, warning.target) then
				self:DestroyWarning(warning)
				goto __continue20
			end
			local thinker = CreateModifierThinker(
				caster,
				self,
				"modifier_elite_158_beam_thinker",
				{ duration = ELITE_158_CHANNEL_DURATION },
				warning.sourceLoc,
				caster:GetTeamNumber(),
				false
			)
			self:DestroyWarning(warning)
			local projectileId = ProjectileManager:CreateTrackingProjectile({
				Target = warning.target,
				Source = thinker,
				Ability = self,
				EffectName = "",
				iMoveSpeed = ELITE_158_BEAM_SPEED,
				vSourceLoc = warning.sourceLoc,
				bDodgeable = false,
				bProvidesVision = false,
				flExpireTime = GameRules:GetGameTime() + ELITE_158_CHANNEL_DURATION,
				bIgnoreObstructions = true,
				bSuppressTargetCheck = true,
			})
			local beamFx = ParticleManager:CreateParticle(PARTICLE_STAFF_BEAM, PATTACH_ABSORIGIN_FOLLOW, caster)
			ParticleManager:SetParticleControl(beamFx, 0, caster:GetAbsOrigin():__add(Vector(0, 0, 300)))
			ParticleManager:SetParticleControlEnt(
				beamFx,
				0,
				caster,
				PATTACH_POINT_FOLLOW,
				"attach_hitloc",
				caster:GetAbsOrigin(),
				true
			)
			ParticleManager:SetParticleControlEnt(
				beamFx,
				1,
				thinker,
				PATTACH_ABSORIGIN_FOLLOW,
				nil,
				thinker:GetOrigin(),
				true
			)
			ParticleManager:SetParticleControlEnt(
				beamFx,
				2,
				caster,
				PATTACH_ABSORIGIN_FOLLOW,
				nil,
				thinker:GetOrigin(),
				true
			)
			local ____self__projectiles_1 = self._projectiles
			____self__projectiles_1[#____self__projectiles_1 + 1] =
				{ target = warning.target, thinker = thinker, projectileId = projectileId, beamFx = beamFx }
		end
		::__continue20::
	end
	self._warnings = {}
end
function elite_158.prototype.CreateFallbackWarning(self, caster)
	local target = caster:GetMinDistanceUnit(ELITE_158_SEARCH_RANGE)
	if not IsValidAlive(nil, target) then
		return
	end
	local sourceLoc = target:GetAbsOrigin()
	local warningFx = ParticleManager:CreateParticle(PARTICLE_DEBUG_RING, PATTACH_CUSTOMORIGIN, caster)
	ParticleManager:SetParticleControl(warningFx, 0, sourceLoc)
	local targetRingFx = ParticleManager:CreateParticle(PARTICLE_STAFF_BEAM_TARGET_RING, PATTACH_CUSTOMORIGIN, caster)
	ParticleManager:SetParticleControl(targetRingFx, 0, sourceLoc)
	ParticleManager:SetParticleControl(targetRingFx, 1, Vector(ELITE_158_BEAM_RADIUS, 1, 1))
	local ____self__warnings_2 = self._warnings
	____self__warnings_2[#____self__warnings_2 + 1] =
		{ target = target, sourceLoc = sourceLoc, warningFx = warningFx, targetRingFx = targetRingFx }
end
function elite_158.prototype.FindProjectile(self, projectileHandle)
	for ____, runtime in ipairs(self._projectiles) do
		if runtime.projectileId == projectileHandle then
			return runtime
		end
	end
	return nil
end
function elite_158.prototype.CleanupBeams(self, playStopSound)
	if playStopSound == nil then
		playStopSound = true
	end
	local caster = self:GetCaster()
	if playStopSound and IsValid(nil, caster) and not caster:IsNull() then
		StopSoundOn(SOUND_BEAM_CAST, caster)
		StopSoundOn(SOUND_BEAM_LOOP, caster)
		EmitSoundOn(SOUND_BEAM_STOP, caster)
	end
	if self._channelFx ~= nil then
		ParticleManager:DestroyParticle(self._channelFx, false)
		ParticleManager:ReleaseParticleIndex(self._channelFx)
		self._channelFx = nil
	end
	for ____, warning in ipairs(self._warnings) do
		self:DestroyWarning(warning)
	end
	self._warnings = {}
	for ____, runtime in ipairs(self._projectiles) do
		ParticleManager:DestroyParticle(runtime.beamFx, false)
		ParticleManager:ReleaseParticleIndex(runtime.beamFx)
		if IsValid(nil, runtime.thinker) and not runtime.thinker:IsNull() then
			runtime.thinker:RemoveSelf()
		end
	end
	self._projectiles = {}
end
function elite_158.prototype.DestroyWarning(self, warning)
	ParticleManager:DestroyParticle(warning.warningFx, false)
	ParticleManager:ReleaseParticleIndex(warning.warningFx)
	ParticleManager:DestroyParticle(warning.targetRingFx, false)
	ParticleManager:ReleaseParticleIndex(warning.targetRingFx)
end
elite_158 = __TS__DecorateLegacy({ registerAbility(nil) }, elite_158)
____exports.elite_158 = elite_158
local modifier_elite_158_beam_thinker = __TS__Class()
modifier_elite_158_beam_thinker.name = "modifier_elite_158_beam_thinker"
__TS__ClassExtends(modifier_elite_158_beam_thinker, MonsterModifier_CS)
function modifier_elite_158_beam_thinker.prototype.OnCreated(self)
	if not IsServer() then
		return
	end
	self:StartIntervalThink(ELITE_158_LINGER_CREATE_INTERVAL)
end
function modifier_elite_158_beam_thinker.prototype.OnIntervalThink(self)
	if not IsServer() then
		return
	end
	local caster = self:GetCaster()
	local ability = self:GetAbility()
	local parent = self:GetParent()
	if not IsValidAlive(nil, parent) then
		return
	end
	if not IsValidAlive(nil, caster) or not ability or not IsValid(nil, parent) or parent:IsNull() then
		self:Destroy()
		return
	end
	CreateModifierThinker(
		caster,
		ability,
		"modifier_elite_158_linger_thinker",
		{ duration = ELITE_158_LINGER_TIME },
		parent:GetAbsOrigin(),
		caster:GetTeamNumber(),
		false
	)
end
function modifier_elite_158_beam_thinker.prototype.IsHidden(self)
	return true
end
function modifier_elite_158_beam_thinker.prototype.IsPurgable(self)
	return false
end
modifier_elite_158_beam_thinker = __TS__DecorateLegacy({ registerModifier(nil) }, modifier_elite_158_beam_thinker)
local modifier_elite_158_linger_thinker = __TS__Class()
modifier_elite_158_linger_thinker.name = "modifier_elite_158_linger_thinker"
__TS__ClassExtends(modifier_elite_158_linger_thinker, MonsterModifier_CS)
function modifier_elite_158_linger_thinker.prototype.OnCreated(self)
	if not IsServer() then
		return
	end
	local parent = self:GetParent()
	EmitSoundOn(SOUND_LINGER, parent)
	self._lingerFx = ParticleManager:CreateParticle(PARTICLE_STAFF_BEAM_LINGER, PATTACH_CUSTOMORIGIN, nil)
	ParticleManager:SetParticleControl(self._lingerFx, 0, parent:GetAbsOrigin())
	ParticleManager:SetParticleControl(self._lingerFx, 1, Vector(ELITE_158_BEAM_RADIUS, 1, 1))
	self:OnIntervalThink()
	self:StartIntervalThink(ELITE_158_DAMAGE_INTERVAL)
end
function modifier_elite_158_linger_thinker.prototype.OnIntervalThink(self)
	if not IsServer() then
		return
	end
	local caster = self:GetCaster()
	local ability = self:GetAbility()
	local parent = self:GetParent()
	if not IsValidAlive(nil, parent) then
		return
	end
	if not IsValidAlive(nil, caster) or not ability or not IsValid(nil, parent) or parent:IsNull() then
		self:Destroy()
		return
	end
	local origin = parent:GetAbsOrigin()
	local enemies = FindUnitsInRadius(
		caster:GetTeamNumber(),
		origin,
		nil,
		ELITE_158_BEAM_RADIUS,
		DOTA_UNIT_TARGET_TEAM_ENEMY,
		DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,
		DOTA_UNIT_TARGET_FLAG_NONE,
		FIND_ANY_ORDER,
		false
	)
	for ____, enemy in ipairs(enemies) do
		do
			if not IsValidAlive(nil, enemy) then
				goto __continue52
			end
			caster:MonsterDamage({ victim = enemy, damage_rate = ELITE_158_DAMAGE_RATE, ability = ability })
			self:PlayBurnEffect(enemy)
		end
		::__continue52::
	end
end
function modifier_elite_158_linger_thinker.prototype.OnDestroy(self)
	if not IsServer() then
		return
	end
	local parent = self:GetParent()
	if IsValid(nil, parent) and not parent:IsNull() then
		StopSoundOn(SOUND_LINGER, parent)
		parent:RemoveSelf()
	end
	if self._lingerFx ~= nil then
		ParticleManager:DestroyParticle(self._lingerFx, false)
		ParticleManager:ReleaseParticleIndex(self._lingerFx)
		self._lingerFx = nil
	end
end
function modifier_elite_158_linger_thinker.prototype.IsHidden(self)
	return true
end
function modifier_elite_158_linger_thinker.prototype.IsPurgable(self)
	return false
end
function modifier_elite_158_linger_thinker.prototype.PlayBurnEffect(self, target)
	if not IsValidAlive(nil, target) then
		return
	end
	EmitSoundOn(SOUND_BURN, target)
	local burnFx = ParticleManager:CreateParticle(PARTICLE_BEAM_BURN, PATTACH_ABSORIGIN_FOLLOW, target)
	ParticleManager:SetParticleControlEnt(
		burnFx,
		1,
		target,
		PATTACH_POINT_FOLLOW,
		"attach_hitloc",
		target:GetAbsOrigin(),
		true
	)
	ParticleManager:ReleaseParticleIndex(burnFx)
end
modifier_elite_158_linger_thinker = __TS__DecorateLegacy({ registerModifier(nil) }, modifier_elite_158_linger_thinker)
return ____exports