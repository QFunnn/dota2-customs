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
local Set = ____lualib.Set
local __TS__New = ____lualib.__TS__New
local __TS__ArraySetLength = ____lualib.__TS__ArraySetLength
local __TS__DecorateLegacy = ____lualib.__TS__DecorateLegacy
local ____exports = {}
local ____dota_ts_adapter = require("utils.dota_ts_adapter")
local registerAbility = ____dota_ts_adapter.registerAbility
local registerModifier = ____dota_ts_adapter.registerModifier
local ____monster_base = require("abilities.monster.monster_base")
local MonsterModifier_CS = ____monster_base.MonsterModifier_CS
local ____boss_phase_transition_ability = require("abilities.monster.boss.boss_phase_transition_ability")
local BossPhaseTransitionAbility_CS = ____boss_phase_transition_ability.BossPhaseTransitionAbility_CS
local BOLT_EFFECT = "particles/boss/boss_006.vpcf"
local SUMMON_PROJECTILE_EFFECT = "particles/econ/items/skywrath_mage/skywrath_arcana/skywrath_arcana_base_attack.vpcf"
local SUMMON_GROUND_EFFECT = "particles/boss/boss_004debuff.vpcf"
local BOSS_004_DAMAGE_RADIUS = 120
local BOSS_004_DAMAGE_RATE = 30
local BOSS_004_TRANSITION_WAVE_COUNT = 4
local BOSS_004_WAVE_ANGLE_OFFSET_STEP = 10
local BOSS_004_CAST_SOUND = "Hero_SkywrathMage.MysticFlare.Cast"
local BOSS_004_TARGET_SOUND = "Greevil.Diabolic_Edict"
local BOSS_004_SUMMON_SOUND = "Hero_SkywrathMage.AncientSeal.Target"
--- 存活召唤单位达到此数则不再继续生成
local BOSS_004_MAX_SUMMONS = 4
--- 施法者身上用于记录当前存活召唤数的 CustomValue key
local BOSS_004_SUMMON_COUNT_KEY = "boss_004_summon_count"
local SUMMON_HIT_DIST = 500
local SUMMON_PROJECTILE_COUNT = 4
local SUMMON_SEMI_ARC_START = -90
local SUMMON_SEMI_ARC_SPAN = 300
--- Boss技能4：黑羽转场仪式，循环释放圆弧射线，并在开场落地召唤。
____exports.boss_004 = __TS__Class()
local boss_004 = ____exports.boss_004
boss_004.name = "boss_004"
__TS__ClassExtends(boss_004, BossPhaseTransitionAbility_CS)
function boss_004.prototype.____constructor(self, ...)
	BossPhaseTransitionAbility_CS.prototype.____constructor(self, ...)
	self.boltSpeed = 1800
	self.boltDurationSec = 1
	self.rayCount = 6
	self.arcAngularSpeedDegPerSec = 120
	self.pathSampleIntervalSec = 0.1
	self.warningRingDuration = 0.6
	self.damageDelaySec = 0
end
function boss_004.prototype.GetAliveCaster(self)
	local ____IsValidAlive_result_0
	if IsValidAlive(nil, self._caster) then
		____IsValidAlive_result_0 = self._caster
	else
		____IsValidAlive_result_0 = nil
	end
	return ____IsValidAlive_result_0
end
function boss_004.prototype.Precache(self, context)
	PrecacheResource("particle", BOLT_EFFECT, context)
	PrecacheResource("particle", SUMMON_PROJECTILE_EFFECT, context)
	PrecacheResource("particle", SUMMON_GROUND_EFFECT, context)
end
function boss_004.prototype.cleanupLoadout(self)
	if not IsServer() then
		return
	end
	local caster = self:GetAliveCaster()
	if not caster then
		return
	end
	caster:ClearActivityModifiers()
	caster:AddActivityModifier("attack_normal_range")
end
function boss_004.prototype.GetBossPhaseTransitionGesture(self)
	return nil
end
function boss_004.prototype.GetBossPhaseTransitionGesturePlaybackRate(self)
	return 1
end
function boss_004.prototype.GetBossPhaseTransitionConfig(self)
	return {
		behavior = DOTA_ABILITY_BEHAVIOR_NO_TARGET + DOTA_ABILITY_BEHAVIOR_IGNORE_BACKSWING,
		castPoint = 0,
		castDuration = self:GetBossPhaseTransitionReturnToSpawnDuration() + self:GetBossPhaseTransitionWindowDuration(),
		castAnimation = ACT_DOTA_SPAWN,
		animationPlaybackRate = 1,
		canCast = function()
			return UF_SUCCESS
		end,
		castError = function()
			return "#boss_004_phase_transition"
		end,
		OnPhaseStart = function() end,
		OnStart = function()
			if not IsServer() then
				return
			end
			local caster = self:GetAliveCaster()
			if not caster then
				return
			end
			local windowDuration = self:GetBossPhaseTransitionWindowDuration()
			caster:AddActivityModifier("loadout")
			caster:AddNewModifier(caster, self, "modifier_boss_004", { duration = windowDuration + 1 })
			caster:EmitSound("Hero_SkywrathMage.MysticFlare.Empyrean")
			self:StartSummonVolley()
			self:StartTransitionFanBoltWaves(windowDuration)
		end,
		OnFinish = function()
			local caster = self:GetAliveCaster()
			if not caster then
				return
			end
			caster:RemoveGesture(ACT_DOTA_SPAWN)
			self:cleanupLoadout()
			caster:MoveToPositionAggressive(caster:GetAbsOrigin())
		end,
		OnInterrupt = function()
			local caster = self:GetAliveCaster()
			if not caster then
				return
			end
			caster:RemoveGesture(ACT_DOTA_SPAWN)
			self:cleanupLoadout()
			caster:MoveToPositionAggressive(caster:GetAbsOrigin())
		end,
	}
end
function boss_004.prototype.StartTransitionFanBoltWaves(self, windowDuration)
	local waveCount = math.max(1, BOSS_004_TRANSITION_WAVE_COUNT)
	local interval = windowDuration / waveCount
	do
		local waveIndex = 0
		while waveIndex < waveCount do
			local currentWave = waveIndex
			local currentDelay = currentWave * interval
			local currentAngleOffsetDeg = self:GetTransitionWaveAngleOffset(currentWave)
			self:Timer(currentDelay, function()
				if not self:GetAliveCaster() then
					return
				end
				self:PlayRandomFanBoltWave(currentAngleOffsetDeg)
			end)
			waveIndex = waveIndex + 1
		end
	end
end
function boss_004.prototype.GetTransitionWaveAngleOffset(self, waveIndex)
	return waveIndex * BOSS_004_WAVE_ANGLE_OFFSET_STEP % 360
end
function boss_004.prototype.PlayRandomFanBoltWave(self, angleOffsetDeg)
	local mode = RandomInt(0, 2)
	if mode == 0 then
		self:PlayFanBoltsWarningThenDamage(true, angleOffsetDeg)
		return
	end
	if mode == 1 then
		self:PlayFanBoltsWarningThenDamage(false, angleOffsetDeg)
		return
	end
	self:PlayFanBoltsWarningThenDamage(true, angleOffsetDeg)
	self:PlayFanBoltsWarningThenDamage(false, angleOffsetDeg)
end
function boss_004.prototype.StartSummonVolley(self)
	if not IsServer() then
		return
	end
	local caster = self:GetAliveCaster()
	if not caster then
		return
	end
	local currentSummonCount = tonumber(caster:GetCustomValue(BOSS_004_SUMMON_COUNT_KEY) or 0) or 0
	local projectileCount = math.min(SUMMON_PROJECTILE_COUNT, math.max(0, BOSS_004_MAX_SUMMONS - currentSummonCount))
	if projectileCount <= 0 then
		return
	end
	EmitSoundOn(BOSS_004_CAST_SOUND, caster)
	local origin = caster:GetAbsOrigin()
	local baseDir = self:GetForwardVector()
	local frameIndex = 0
	self:Timer(0, function()
		if not IsValidAlive(nil, caster) then
			return nil
		end
		local angleDeg = projectileCount <= 1 and 0
			or SUMMON_SEMI_ARC_START + frameIndex / (projectileCount - 1) * SUMMON_SEMI_ARC_SPAN
		local dir = RotateVector2D(nil, baseDir, angleDeg)
		local hitPoint = origin + dir * SUMMON_HIT_DIST
		hitPoint.z = origin.z
		CreateProjectile(nil, {
			ability = self,
			caster = caster,
			effect_name = SUMMON_PROJECTILE_EFFECT,
			target = hitPoint,
			start_point = caster:GetAttachmentOrigin(caster:ScriptLookupAttachment("attach_weapon_tip_fx")),
			projectile_type = "collideground",
			projectile_speed = 500,
			on_hit = function(____, _hitTarget, hp)
				self:PlaySummonEffects(caster, hp)
				return true
			end,
		})
		frameIndex = frameIndex + 1
		if frameIndex < projectileCount then
			return FrameTime()
		end
		return nil
	end)
end
function boss_004.prototype.PlaySummonEffects(self, caster, hitPoint)
	if not IsServer() then
		return
	end
	if not IsValidAlive(nil, caster) then
		return
	end
	EmitSoundOnLocationWithCaster(hitPoint, BOSS_004_SUMMON_SOUND, caster)
	local effect = ParticleManager:CreateParticle(SUMMON_GROUND_EFFECT, PATTACH_WORLDORIGIN, caster)
	ParticleManager:SetParticleControl(effect, 0, hitPoint)
	ParticleManager:SetParticleControl(effect, 1, hitPoint)
	ParticleManager:SetParticleShouldCheckFoW(effect, false)
	local effectReleased = false
	local function releaseSummonGroundFx()
		if effectReleased then
			return
		end
		effectReleased = true
		ParticleManager:DestroyParticle(effect, false)
		ParticleManager:ReleaseParticleIndex(effect)
	end
	Timers:CreateTimer(1, function()
		releaseSummonGroundFx(nil)
		return nil
	end)
	local roomId = caster:GetRoomId()
	MyGameUnit:CreateSummonedUnitAsync({
		unitName = "monster_10078",
		maxSummons = BOSS_004_MAX_SUMMONS,
		position = hitPoint,
		roomId = roomId,
		team = DOTA_TEAM_BADGUYS,
		owner = caster,
		findClearSpace = true,
		onSpawn = function(____, unit)
			if IsValidAlive(nil, caster) and unit and IsValid(nil, unit) and not unit:IsNull() then
				caster:AddCustomValue(BOSS_004_SUMMON_COUNT_KEY, 1)
				unit:AddNewModifier(caster, self, "modifier_boss_004_summon_debuff", { duration = 0.5 })
				unit:StartGestureWithPlaybackRate(ACT_DOTA_SPAWN, 0.8)
				unit:SetForwardVectorWithoutInterrupt(GetDirection(nil, caster:GetAbsOrigin(), unit:GetAbsOrigin()))
				unit:AddNewModifier(unit, nil, "modifier_monster_born", { duration = 2 })
			end
		end,
		onDeath = function()
			if IsValidAlive(nil, caster) then
				caster:AddCustomValue(BOSS_004_SUMMON_COUNT_KEY, -1)
			end
		end,
	})
end
function boss_004.prototype.recordPathSequence(self, caster, origin, baseDir, bendRight)
	local boltSpeed = self.boltSpeed
	local boltDurationSec = self.boltDurationSec
	local rayCount = self.rayCount
	local arcAngularSpeedDegPerSec = self.arcAngularSpeedDegPerSec
	local pathSampleIntervalSec = self.pathSampleIntervalSec
	local ____bendRight_1
	if bendRight then
		____bendRight_1 = -arcAngularSpeedDegPerSec
	else
		____bendRight_1 = arcAngularSpeedDegPerSec
	end
	local angularSpeed = ____bendRight_1
	local pathSequence = {}
	local step = pathSampleIntervalSec
	local states = {}
	do
		local i = 0
		while i < rayCount do
			local angleDeg = i / rayCount * 360
			local dir = RotateVector2D(nil, baseDir, angleDeg)
			dir.z = 0
			states[#states + 1] = {
				pos = Vector(origin.x, origin.y, origin.z),
				dir = dir,
			}
			i = i + 1
		end
	end
	do
		local t = 0
		while t < boltDurationSec do
			local frame = {}
			for ____, s in ipairs(states) do
				frame[#frame + 1] = { x = s.pos.x, y = s.pos.y, z = s.pos.z }
				s.pos = s.pos + s.dir * (boltSpeed * step)
				s.dir = RotateVector2D(nil, s.dir, angularSpeed * step)
				s.pos.z = GetGroundHeight(s.pos, caster) or origin.z
			end
			pathSequence[#pathSequence + 1] = frame
			t = t + step
		end
	end
	return pathSequence
end
function boss_004.prototype.applyEffectAtPathPoints(self, pathSequence, effect)
	if not IsServer() then
		return
	end
	for ____, frame in ipairs(pathSequence) do
		for ____, p in ipairs(frame) do
			effect(nil, Vector(p.x, p.y, p.z))
		end
	end
end
function boss_004.prototype.PlayFanBoltsWarningThenDamage(self, bendRight, angleOffsetDeg)
	if angleOffsetDeg == nil then
		angleOffsetDeg = 0
	end
	if not IsServer() then
		return
	end
	local caster = self:GetAliveCaster()
	if not caster then
		return
	end
	local origin = caster:GetAbsOrigin()
	EmitSoundOn(BOSS_004_CAST_SOUND, caster)
	local forward = caster:GetForwardVector()
	local baseDir = RotateVector2D(nil, Vector(forward.x, forward.y, 0):Normalized(), angleOffsetDeg)
	if baseDir:Length2D() < 0.01 then
		baseDir.x = 1
		baseDir.y = 0
	end
	local pathSequence = self:recordPathSequence(caster, origin, baseDir, bendRight)
	self:PlayFanBolts(pathSequence, {
		warningOnly = true,
		onEnd = function()
			if not IsValidAlive(nil, caster) then
				return
			end
			local frameIndex = 0
			Timers:CreateTimer(self.damageDelaySec, function()
				if not IsValidAlive(nil, caster) then
					return nil
				end
				local pathSampleIntervalSec = self.pathSampleIntervalSec
				local warningRingDuration = self.warningRingDuration
				if frameIndex >= #pathSequence then
					return nil
				end
				local frame = pathSequence[frameIndex + 1]
				for ____, p in ipairs(frame) do
					local currentPosition = Vector(p.x, p.y, p.z)
					self:WarningRingEffect(currentPosition, BOSS_004_DAMAGE_RADIUS, warningRingDuration)
					self:Timer(warningRingDuration, function()
						if not IsValidAlive(nil, caster) then
							return
						end
						self:PlayParticle(caster, currentPosition)
					end)
				end
				frameIndex = frameIndex + 1
				return frameIndex < #pathSequence and pathSampleIntervalSec or nil
			end)
		end,
	})
end
function boss_004.prototype.PlayParticle(self, caster, pos)
	if not IsValidAlive(nil, caster) then
		return
	end
	EmitSoundOnLocationWithCaster(pos, BOSS_004_TARGET_SOUND, caster)
	local fx = ParticleManager:CreateParticle("particles/hero/hero_006.vpcf", PATTACH_WORLDORIGIN, caster)
	ParticleManager:SetParticleControl(fx, 0, pos)
	ParticleManager:SetParticleControl(fx, 1, pos)
	ParticleManager:SetParticleControl(fx, 3, pos)
	ParticleManager:SetParticleShouldCheckFoW(fx, false)
	ParticleManager:ReleaseParticleIndex(fx)
	local units = self:FindUnitInRange(pos, BOSS_004_DAMAGE_RADIUS)
	if units then
		for ____, unit in ipairs(units) do
			do
				if not IsValidAlive(nil, caster) or not IsValidAlive(nil, unit) then
					goto __continue73
				end
				caster:MonsterDamage({ victim = unit, damage_rate = BOSS_004_DAMAGE_RATE, ability = self })
			end
			::__continue73::
		end
	end
end
function boss_004.prototype.PlayFanBolts(self, pathSequence, options)
	local caster = self:GetAliveCaster()
	if not caster then
		return
	end
	local origin = caster:GetAbsOrigin()
	local boltSpeed = self.boltSpeed
	local pathSampleIntervalSec = self.pathSampleIntervalSec
	local ____temp_4 = options and options.warningOnly
	if ____temp_4 == nil then
		____temp_4 = false
	end
	local warningOnly = ____temp_4
	local onEnd = options and options.onEnd
	local firstFrame = pathSequence[1]
	if not firstFrame or #firstFrame <= 0 then
		if onEnd ~= nil then
			onEnd(nil)
		end
		return
	end
	local bolts = {}
	do
		local i = 0
		while i < #firstFrame do
			local p = firstFrame[i + 1]
			local pos = Vector(p.x, p.y, p.z)
			local fx = ParticleManager:CreateParticle(BOLT_EFFECT, PATTACH_WORLDORIGIN, caster)
			ParticleManager:SetParticleControl(fx, 0, origin)
			ParticleManager:SetParticleControl(fx, 1, pos + Vector(0, 0, 75))
			ParticleManager:SetParticleControl(fx, 2, Vector(boltSpeed, 0, 0))
			ParticleManager:SetParticleShouldCheckFoW(fx, false)
			bolts[#bolts + 1] = {
				fx = fx,
				hitUnits = __TS__New(Set),
			}
			i = i + 1
		end
	end
	local frameIndex = 0
	local function cleanupBolts()
		for ____, b in ipairs(bolts) do
			ParticleManager:DestroyParticle(b.fx, false)
			ParticleManager:ReleaseParticleIndex(b.fx)
		end
		__TS__ArraySetLength(bolts, 0)
	end
	local function tick()
		if not IsValidAlive(nil, caster) then
			cleanupBolts(nil)
			return nil
		end
		if frameIndex >= #pathSequence then
			cleanupBolts(nil)
			if IsValidAlive(nil, caster) then
				if onEnd ~= nil then
					onEnd(nil)
				end
			end
			return nil
		end
		local frame = pathSequence[frameIndex + 1]
		do
			local i = 0
			while i < #bolts do
				do
					local b = bolts[i + 1]
					local p = frame[i + 1]
					if not p then
						goto __continue87
					end
					local pos = Vector(p.x, p.y, p.z)
					ParticleManager:SetParticleControl(b.fx, 1, pos + Vector(0, 0, 75))
					if not warningOnly then
					end
				end
				::__continue87::
				i = i + 1
			end
		end
		frameIndex = frameIndex + 1
		if frameIndex >= #pathSequence then
			cleanupBolts(nil)
			if IsValidAlive(nil, caster) then
				if onEnd ~= nil then
					onEnd(nil)
				end
			end
			return nil
		end
		return pathSampleIntervalSec
	end
	Timers:CreateTimer(FrameTime(), function()
		local next = tick(nil)
		if next == nil then
			return nil
		end
		return next
	end)
end
boss_004 = __TS__DecorateLegacy({ registerAbility(nil) }, boss_004)
____exports.boss_004 = boss_004
____exports.modifier_boss_004_summon_debuff = __TS__Class()
local modifier_boss_004_summon_debuff = ____exports.modifier_boss_004_summon_debuff
modifier_boss_004_summon_debuff.name = "modifier_boss_004_summon_debuff"
__TS__ClassExtends(modifier_boss_004_summon_debuff, MonsterModifier_CS)
function modifier_boss_004_summon_debuff.prototype.CheckState(self)
	return {
		[MODIFIER_STATE_STUNNED] = true,
		[MODIFIER_STATE_NO_UNIT_COLLISION] = true,
		[MODIFIER_STATE_INVULNERABLE] = true,
	}
end
modifier_boss_004_summon_debuff = __TS__DecorateLegacy({ registerModifier(nil) }, modifier_boss_004_summon_debuff)
____exports.modifier_boss_004_summon_debuff = modifier_boss_004_summon_debuff
____exports.modifier_boss_004 = __TS__Class()
local modifier_boss_004 = ____exports.modifier_boss_004
modifier_boss_004.name = "modifier_boss_004"
__TS__ClassExtends(modifier_boss_004, MonsterModifier_CS)
function modifier_boss_004.prototype.DeclareFunctions(self)
	return { MODIFIER_PROPERTY_VISUAL_Z_DELTA }
end
function modifier_boss_004.prototype.GetVisualZDelta(self)
	return 0
end
function modifier_boss_004.prototype.GetPriority(self)
	return MODIFIER_PRIORITY_HIGH
end
modifier_boss_004 = __TS__DecorateLegacy({ registerModifier(nil) }, modifier_boss_004)
____exports.modifier_boss_004 = modifier_boss_004
return ____exports