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
local Set = ____lualib.Set
local __TS__New = ____lualib.__TS__New
local ____exports = {}
local modifier_boss_brewmaster_5_spirit_spawn, modifier_boss_brewmaster_5_spirit_health_bonus, modifier_boss_brewmaster_5_storm_death, modifier_boss_brewmaster_5_earth_death, modifier_boss_brewmaster_5_fire_death
local ____dota_ts_adapter = require("utils.dota_ts_adapter")
local registerAbility = ____dota_ts_adapter.registerAbility
local registerModifier = ____dota_ts_adapter.registerModifier
local ____boss_phase_transition_ability = require("abilities.monster.boss.boss_phase_transition_ability")
local BossPhaseTransitionAbility_CS = ____boss_phase_transition_ability.BossPhaseTransitionAbility_CS
local modifier_boss_phase_two_buff = ____boss_phase_transition_ability.modifier_boss_phase_two_buff
local ____monster_base = require("abilities.monster.monster_base")
local MonsterModifier_CS = ____monster_base.MonsterModifier_CS
local BREWMASTER_SPIRIT_NAMES = { "monster_11334", "monster_11335", "monster_11336" }
local BREWMASTER_SPIRIT_DEATH_PARTICLES = {
	"particles/units/heroes/hero_brewmaster/brewmaster_earth_death.vpcf",
	"particles/units/heroes/hero_brewmaster/brewmaster_fire_death.vpcf",
	"particles/units/heroes/hero_brewmaster/brewmaster_storm_death.vpcf",
}
local BREWMASTER_SPLIT_RELATIVE_ANGLES = { 0, 120, -120 }
local BREWMASTER_SPLIT_RADIUS = 150
--- 三灵继承酒仙基础生命百分比属性的三分之一。
local BREWMASTER_SPIRIT_BASE_HEALTH_PCT_RATIO = 1 / 3
local BREWMASTER_SPIRIT_SPAWN_PROTECTION_DURATION = 1.5
local BREWMASTER_SPIRIT_SPAWN_ACTIVITY = ACT_DOTA_SPAWN
local BREWMASTER_SPLIT_CAST_DURATION = 1
local BREWMASTER_SPLIT_PARTICLE = "particles/units/heroes/hero_brewmaster/brewmaster_primal_split.vpcf"
local BREWMASTER_SPLIT_SPAWN_SOUND = "Hero_Brewmaster.PrimalSplit.Spawn"
local BREWMASTER_SPLIT_RETURN_SOUND = "Hero_Brewmaster.PrimalSplit.Return"
--- 土灵死亡：落石撞击音
local BREWMASTER_EARTH_DEATH_SOUND = "Brewmaster_Earth.Boulder.Target"
--- 火灵死亡：火焰爆炸音
local BREWMASTER_FIRE_DEATH_SOUND = "Hero_Clinkz.Death"
--- 风灵死亡：落雷音
local BREWMASTER_STORM_DEATH_SOUND = "Hero_Zuus.LightningBolt"
local BREWMASTER_DEATH_WAVE_POINT_COUNTS = { 5, 8, 12 }
local BREWMASTER_EARTH_SPIRIT_DEATH_PARTICLE = BREWMASTER_SPIRIT_DEATH_PARTICLES[1]
local BREWMASTER_FIRE_SPIRIT_DEATH_PARTICLE = BREWMASTER_SPIRIT_DEATH_PARTICLES[2]
local BREWMASTER_STORM_DEATH_PARTICLE = BREWMASTER_SPIRIT_DEATH_PARTICLES[3]
local BREWMASTER_STORM_DEATH_WAVE_INTERVAL = 1
local BREWMASTER_STORM_DEATH_POINT_RADIUS = 2500
local BREWMASTER_STORM_DEATH_POINT_MIN_DISTANCE = 550
local BREWMASTER_STORM_DEATH_WARNING_RADIUS = 200
local BREWMASTER_STORM_DEATH_WARNING_PARTICLE = "particles/dd/rain_aoe.vpcf"
local BREWMASTER_STORM_DEATH_DAMAGE_RATE = 26
local BREWMASTER_EARTH_DEATH_POINT_RADIUS = 2500
local BREWMASTER_EARTH_DEATH_POINT_MIN_DISTANCE = 220
local BREWMASTER_EARTH_DEATH_WARNING_RADIUS = 200
local BREWMASTER_EARTH_DEATH_WARNING_INTERVAL = 0.1
local BREWMASTER_EARTH_DEATH_WARNING_DURATION = 1
local BREWMASTER_EARTH_DEATH_ROCK_DELAY = 0.5
local BREWMASTER_EARTH_DEATH_ROCK_PARTICLE = "particles/cb/rock_drop.vpcf"
local BREWMASTER_EARTH_DEATH_PARTICLE_DURATION = 1
local BREWMASTER_EARTH_DEATH_DAMAGE_RATE = 26
local BREWMASTER_FIRE_DEATH_WAVE_COUNT = 3
local BREWMASTER_FIRE_DEATH_WAVE_INTERVAL = 1
local BREWMASTER_FIRE_DEATH_LANE_COUNT = 6
local BREWMASTER_FIRE_DEATH_LANE_SPACING = 400
local BREWMASTER_FIRE_DEATH_PROJECTILE_WIDTH = 400
local BREWMASTER_FIRE_DEATH_START_DISTANCE = 2000
local BREWMASTER_FIRE_DEATH_PROJECTILE_DISTANCE = 4000
local BREWMASTER_FIRE_DEATH_PROJECTILE_SPEED = 1200
local BREWMASTER_FIRE_DEATH_PROJECTILE_PARTICLE = "particles/dd/fire_wall.vpcf"
local BREWMASTER_FIRE_DEATH_PROJECTILE_THICKNESS = 70
local BREWMASTER_FIRE_DEATH_DAMAGE_RATE = 26
--- 酒仙 BOSS 技能 5：血量转阶段时分裂为三灵。
____exports.boss_brewmaster_5 = __TS__Class()
local boss_brewmaster_5 = ____exports.boss_brewmaster_5
boss_brewmaster_5.name = "boss_brewmaster_5"
__TS__ClassExtends(boss_brewmaster_5, BossPhaseTransitionAbility_CS)
function boss_brewmaster_5.prototype.____constructor(self, ...)
	BossPhaseTransitionAbility_CS.prototype.____constructor(self, ...)
	self.casterRestored = false
	self.splitStarted = false
end
function boss_brewmaster_5.prototype.Precache(self, context)
	PrecacheResource("particle", BREWMASTER_SPLIT_PARTICLE, context)
	PrecacheResource("particle", BREWMASTER_STORM_DEATH_WARNING_PARTICLE, context)
	PrecacheResource("particle", BREWMASTER_EARTH_DEATH_ROCK_PARTICLE, context)
	PrecacheResource("particle", BREWMASTER_FIRE_DEATH_PROJECTILE_PARTICLE, context)
	PrecacheResource("soundfile", "sounds/weapons/hero/brewmaster/primal_split_spawn.vsnd", context)
	PrecacheResource("soundfile", "sounds/weapons/hero/brewmaster/primal_split_return.vsnd", context)
	PrecacheResource("soundfile", "sounds/weapons/hero/tiny/tiny_toss_impact.vsnd", context)
	PrecacheResource("soundfile", "sounds/physics/deaths/specials/clinkz_death_explode.vsnd", context)
	PrecacheResource("soundfile", "sounds/weapons/hero/zuus/lightning_bolt.vsnd", context)
	for ____, particle in ipairs(BREWMASTER_SPIRIT_DEATH_PARTICLES) do
		PrecacheResource("particle", particle, context)
	end
end
function boss_brewmaster_5.prototype.GetBossPhaseTransitionReturnToSpawnDuration(self)
	return 0
end
function boss_brewmaster_5.prototype.GetBossPhaseTransitionWindowDuration(self)
	return 0
end
function boss_brewmaster_5.prototype.ShouldApplyDefaultBossPhaseTransitionWindow(self)
	return false
end
function boss_brewmaster_5.prototype.ShouldApplyDefaultBossPhaseTwoBuff(self)
	return false
end
function boss_brewmaster_5.prototype.GetBossPhaseTransitionConfig(self)
	return {
		behavior = DOTA_ABILITY_BEHAVIOR_NO_TARGET,
		castPoint = BREWMASTER_SPLIT_CAST_DURATION,
		castDuration = 0,
		castAnimation = ACT_DOTA_CAST_ABILITY_4,
		animationPlaybackRate = 1,
		isNotMove = true,
		OnPhaseStart = function()
			local caster = self:GetCaster()
			if IsValidAlive(nil, caster) then
				self:PlaySplitEffect(caster)
			end
		end,
		OnStart = function()
			return self:Split()
		end,
	}
end
function boss_brewmaster_5.prototype.Split(self)
	local caster = self:GetCaster()
	if not IsValidAlive(nil, caster) then
		return
	end
	local center = caster:GetAbsOrigin()
	self.splitOrigin = center
	local summons = {}
	self.casterRestored = false
	self.splitStarted = true
	caster:AddNoDraw()
	caster:AddNewModifier(caster, self, "modifier_invulnerable", {})
	caster:AddNewModifier(caster, self, "modifier_stunned", {})
	EmitSoundOn(BREWMASTER_SPLIT_SPAWN_SOUND, caster)
	self:SummonSpirits(caster, center, summons)
end
function boss_brewmaster_5.prototype.SummonSpirits(self, caster, center, summons)
	if not IsValidAlive(nil, caster) or self.casterRestored then
		return
	end
	local forward = Vector(caster:GetForwardVector().x, caster:GetForwardVector().y, 0):Normalized()
	do
		local i = 0
		while i < #BREWMASTER_SPIRIT_NAMES do
			local currentIndex = i
			local relativeAngle = BREWMASTER_SPLIT_RELATIVE_ANGLES[currentIndex + 1]
			local direction = RotateVector2D(nil, forward, relativeAngle):Normalized()
			local position = GetGroundPosition(center:__add(direction:__mul(BREWMASTER_SPLIT_RADIUS)), caster)
			local deathParticle = BREWMASTER_SPIRIT_DEATH_PARTICLES[currentIndex + 1]
			MyGameUnit:CreateSummonedUnitAsync({
				unitName = BREWMASTER_SPIRIT_NAMES[currentIndex + 1],
				summonTag = "brewmaster_split_" .. tostring(caster:entindex()),
				maxSummons = 3,
				position = position,
				roomId = caster:GetRoomId(),
				team = caster:GetTeamNumber(),
				owner = caster,
				summoner = caster,
				destroyWithSummoner = true,
				findClearSpace = true,
				onSpawn = function(____, unit)
					if IsValidAlive(nil, unit) then
						modifier_boss_brewmaster_5_spirit_health_bonus:applys(unit, caster, self, { duration = -1 })
						summons[#summons + 1] = unit
						unit:AddNewModifier(
							unit,
							self,
							"modifier_invulnerable",
							{ duration = BREWMASTER_SPIRIT_SPAWN_PROTECTION_DURATION }
						)
						modifier_boss_brewmaster_5_spirit_spawn:applys(
							unit,
							unit,
							self,
							{ duration = BREWMASTER_SPIRIT_SPAWN_PROTECTION_DURATION }
						)
					end
					if IsInToolsMode() then
						unit:SetControllableByPlayer(0, true)
					end
				end,
				onDeath = function(____, unit)
					return self:HandleSpiritDeath(unit, deathParticle)
				end,
			})
			i = i + 1
		end
	end
	self:Timer(0.5, function()
		return self:WaitForSpirits(caster, summons)
	end)
end
function boss_brewmaster_5.prototype.HandleSpiritDeath(self, unit, deathParticle)
	if not IsServer() or not unit or not IsValid(nil, unit) or unit:IsNull() then
		return
	end
	local caster = self:GetCaster()
	local deathOrigin = unit:GetAbsOrigin()
	local deathForward = unit:GetForwardVector()
	local deathSound = self:GetSpiritDeathSound(deathParticle)
	unit:AddNoDraw()
	local particle = ParticleManager:CreateParticle(deathParticle, PATTACH_WORLDORIGIN, nil)
	ParticleManager:SetParticleControlTransformForward(particle, 0, deathOrigin, deathForward)
	ParticleManager:ReleaseParticleIndex(particle)
	if deathSound then
		local ____IsValidAlive_result_0
		if IsValidAlive(nil, caster) then
			____IsValidAlive_result_0 = caster
		else
			____IsValidAlive_result_0 = unit
		end
		local soundCaster = ____IsValidAlive_result_0
		EmitSoundOnLocationWithCaster(deathOrigin, deathSound, soundCaster)
	end
	if deathParticle == BREWMASTER_FIRE_SPIRIT_DEATH_PARTICLE then
		if IsValidAlive(nil, caster) then
			modifier_boss_brewmaster_5_fire_death:applys(
				caster,
				caster,
				self,
				{ duration = BREWMASTER_FIRE_DEATH_WAVE_COUNT * BREWMASTER_FIRE_DEATH_WAVE_INTERVAL }
			)
		end
		return
	end
	if deathParticle == BREWMASTER_EARTH_SPIRIT_DEATH_PARTICLE then
		if IsValidAlive(nil, caster) then
			modifier_boss_brewmaster_5_earth_death:applys(
				caster,
				caster,
				self,
				{ duration = self:GetEarthDeathDuration() }
			)
		end
		return
	end
	if deathParticle == BREWMASTER_STORM_DEATH_PARTICLE then
		if IsValidAlive(nil, caster) then
			modifier_boss_brewmaster_5_storm_death:applys(
				caster,
				caster,
				self,
				{ duration = #BREWMASTER_DEATH_WAVE_POINT_COUNTS * BREWMASTER_STORM_DEATH_WAVE_INTERVAL }
			)
		end
	end
end
function boss_brewmaster_5.prototype.GetSpiritDeathSound(self, deathParticle)
	if deathParticle == BREWMASTER_EARTH_SPIRIT_DEATH_PARTICLE then
		return BREWMASTER_EARTH_DEATH_SOUND
	end
	if deathParticle == BREWMASTER_FIRE_SPIRIT_DEATH_PARTICLE then
		return BREWMASTER_FIRE_DEATH_SOUND
	end
	if deathParticle == BREWMASTER_STORM_DEATH_PARTICLE then
		return BREWMASTER_STORM_DEATH_SOUND
	end
	return nil
end
function boss_brewmaster_5.prototype.GetEarthDeathDuration(self)
	local duration = 0
	for ____, pointCount in ipairs(BREWMASTER_DEATH_WAVE_POINT_COUNTS) do
		duration = duration
			+ ((pointCount - 1) * BREWMASTER_EARTH_DEATH_WARNING_INTERVAL + BREWMASTER_EARTH_DEATH_WARNING_DURATION)
	end
	return duration + 0.1
end
function boss_brewmaster_5.prototype.GetSplitOrigin(self)
	return self.splitOrigin or self:GetCaster():GetAbsOrigin()
end
function boss_brewmaster_5.prototype.WaitForSpirits(self, caster, summons)
	if not IsValidAlive(nil, caster) then
		return nil
	end
	if #summons < #BREWMASTER_SPIRIT_NAMES then
		return 0.5
	end
	for ____, summon in ipairs(summons) do
		if IsValidAlive(nil, summon) then
			return 0.5
		end
	end
	self:RestoreCaster(caster)
	return nil
end
function boss_brewmaster_5.prototype.RestoreCaster(self, caster)
	if caster == nil then
		caster = self:GetCaster()
	end
	if not IsValidAlive(nil, caster) or not self.splitStarted or self.casterRestored then
		return
	end
	self.casterRestored = true
	caster:RemoveNoDraw()
	caster:RemoveModifierByName("modifier_invulnerable")
	caster:RemoveModifierByName("modifier_stunned")
	FindClearSpaceForUnit(caster, caster:GetAbsOrigin(), true)
	modifier_boss_phase_two_buff:applys(caster, caster, self, {})
	caster:SetBossPhaseTransitionState(BossPhaseTransitionState.AFTER)
	EmitSoundOn(BREWMASTER_SPLIT_RETURN_SOUND, caster)
end
function boss_brewmaster_5.prototype.PlaySplitEffect(self, caster)
	local effect = ParticleManager:CreateParticle(BREWMASTER_SPLIT_PARTICLE, PATTACH_ABSORIGIN_FOLLOW, caster)
	ParticleManager:ReleaseParticleIndex(effect)
end
boss_brewmaster_5 = __TS__DecorateLegacy({ registerAbility(nil) }, boss_brewmaster_5)
____exports.boss_brewmaster_5 = boss_brewmaster_5
--- 三灵出生演出：仅模拟眩晕状态并强制保持出生动作，不使用原生眩晕 Modifier。
modifier_boss_brewmaster_5_spirit_spawn = __TS__Class()
modifier_boss_brewmaster_5_spirit_spawn.name = "modifier_boss_brewmaster_5_spirit_spawn"
__TS__ClassExtends(modifier_boss_brewmaster_5_spirit_spawn, MonsterModifier_CS)
function modifier_boss_brewmaster_5_spirit_spawn.prototype.OnCreated(self)
	if not IsServer() then
		return
	end
	local parent = self:GetParent()
	if not IsValidAlive(nil, parent) then
		return
	end
	parent:FadeGesture(BREWMASTER_SPIRIT_SPAWN_ACTIVITY)
	parent:StartGestureWithPlaybackRate(BREWMASTER_SPIRIT_SPAWN_ACTIVITY, 1)
end
function modifier_boss_brewmaster_5_spirit_spawn.prototype.DeclareFunctions(self)
	return { MODIFIER_PROPERTY_OVERRIDE_ANIMATION }
end
function modifier_boss_brewmaster_5_spirit_spawn.prototype.GetOverrideAnimation(self)
	return BREWMASTER_SPIRIT_SPAWN_ACTIVITY
end
function modifier_boss_brewmaster_5_spirit_spawn.prototype.CheckState(self)
	return { [MODIFIER_STATE_STUNNED] = true }
end
function modifier_boss_brewmaster_5_spirit_spawn.prototype.IsHidden(self)
	return true
end
function modifier_boss_brewmaster_5_spirit_spawn.prototype.IsPurgable(self)
	return false
end
modifier_boss_brewmaster_5_spirit_spawn = __TS__DecorateLegacy(
	{ registerModifier(nil, "modifier_boss_brewmaster_5_spirit_spawn") },
	modifier_boss_brewmaster_5_spirit_spawn
)
--- 三灵专属生命加成：读取酒仙的基础生命百分比属性，并只继承其中三分之一。
modifier_boss_brewmaster_5_spirit_health_bonus = __TS__Class()
modifier_boss_brewmaster_5_spirit_health_bonus.name = "modifier_boss_brewmaster_5_spirit_health_bonus"
__TS__ClassExtends(modifier_boss_brewmaster_5_spirit_health_bonus, MonsterModifier_CS)
function modifier_boss_brewmaster_5_spirit_health_bonus.prototype.IsHidden(self)
	return true
end
function modifier_boss_brewmaster_5_spirit_health_bonus.prototype.IsPurgable(self)
	return false
end
function modifier_boss_brewmaster_5_spirit_health_bonus.prototype.GetAttributeBonus(self)
	local caster = self:GetCaster()
	if not caster or not IsValid(nil, caster) or caster:IsNull() then
		return {}
	end
	local baseHealthPct = MyGameAttribute:GetAttribute(caster, "base_health_pct")
	return { base_health_pct = baseHealthPct * BREWMASTER_SPIRIT_BASE_HEALTH_PCT_RATIO }
end
modifier_boss_brewmaster_5_spirit_health_bonus = __TS__DecorateLegacy(
	{ registerModifier(nil, "modifier_boss_brewmaster_5_spirit_health_bonus") },
	modifier_boss_brewmaster_5_spirit_health_bonus
)
modifier_boss_brewmaster_5_storm_death = __TS__Class()
modifier_boss_brewmaster_5_storm_death.name = "modifier_boss_brewmaster_5_storm_death"
__TS__ClassExtends(modifier_boss_brewmaster_5_storm_death, MonsterModifier_CS)
function modifier_boss_brewmaster_5_storm_death.prototype.____constructor(self, ...)
	MonsterModifier_CS.prototype.____constructor(self, ...)
	self.waveCount = 0
end
function modifier_boss_brewmaster_5_storm_death.prototype.OnCreated(self)
	if not IsServer() then
		return
	end
	self:StartIntervalThink(BREWMASTER_STORM_DEATH_WAVE_INTERVAL)
	self:OnIntervalThink()
end
function modifier_boss_brewmaster_5_storm_death.prototype.OnIntervalThink(self)
	if not IsServer() then
		return
	end
	local caster = self:GetCaster()
	local ability = self:GetAbility()
	if not IsValidAlive(nil, caster) or not ability then
		self:Destroy()
		return
	end
	local ____self_1, ____waveCount_2 = self, "waveCount"
	local ____self_waveCount_3 = ____self_1[____waveCount_2]
	____self_1[____waveCount_2] = ____self_waveCount_3 + 1
	local currentWave = ____self_waveCount_3
	local pointCount = BREWMASTER_DEATH_WAVE_POINT_COUNTS[currentWave + 1]
	local points = GetRandomPointsInCircle(
		nil,
		caster:GetAbsOrigin(),
		BREWMASTER_STORM_DEATH_POINT_RADIUS,
		pointCount,
		BREWMASTER_STORM_DEATH_POINT_MIN_DISTANCE
	)
	do
		local pointIndex = 0
		while pointIndex < #points do
			local currentPoint = GetGroundPosition(points[pointIndex + 1], caster)
			self:PlayWarning(currentPoint)
			Timers:CreateTimer(BREWMASTER_STORM_DEATH_WAVE_INTERVAL, function()
				if not IsValidAlive(nil, caster) then
					return
				end
				local enemies = FindUnitsInRadius(
					caster:GetTeamNumber(),
					currentPoint,
					nil,
					BREWMASTER_STORM_DEATH_WARNING_RADIUS,
					DOTA_UNIT_TARGET_TEAM_ENEMY,
					DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,
					DOTA_UNIT_TARGET_FLAG_NONE,
					FIND_ANY_ORDER,
					false
				)
				for ____, enemy in ipairs(enemies) do
					do
						if not IsValidAlive(nil, enemy) then
							goto __continue69
						end
						caster:MonsterDamage({
							victim = enemy,
							damage_rate = BREWMASTER_STORM_DEATH_DAMAGE_RATE,
							ability = ability,
						})
					end
					::__continue69::
				end
			end)
			pointIndex = pointIndex + 1
		end
	end
	if currentWave + 1 >= #BREWMASTER_DEATH_WAVE_POINT_COUNTS then
		self:StartIntervalThink(-1)
	end
end
function modifier_boss_brewmaster_5_storm_death.prototype.PlayWarning(self, position)
	self:WarningRingEffect(position, BREWMASTER_STORM_DEATH_WARNING_RADIUS, BREWMASTER_STORM_DEATH_WAVE_INTERVAL)
	local effect = ParticleManager:CreateParticle(BREWMASTER_STORM_DEATH_WARNING_PARTICLE, PATTACH_WORLDORIGIN, nil)
	ParticleManager:SetParticleControl(effect, 0, position)
	ParticleManager:SetParticleControl(effect, 1, Vector(BREWMASTER_STORM_DEATH_WARNING_RADIUS, 1, 600))
	Timers:CreateTimer(BREWMASTER_STORM_DEATH_WAVE_INTERVAL, function()
		ParticleManager:DestroyParticle(effect, false)
		ParticleManager:ReleaseParticleIndex(effect)
	end)
end
function modifier_boss_brewmaster_5_storm_death.prototype.OnDestroy(self)
	if not IsServer() then
		return
	end
	self:StartIntervalThink(-1)
end
function modifier_boss_brewmaster_5_storm_death.prototype.IsHidden(self)
	return true
end
function modifier_boss_brewmaster_5_storm_death.prototype.IsPurgable(self)
	return false
end
modifier_boss_brewmaster_5_storm_death = __TS__DecorateLegacy(
	{ registerModifier(nil, "modifier_boss_brewmaster_5_storm_death") },
	modifier_boss_brewmaster_5_storm_death
)
modifier_boss_brewmaster_5_earth_death = __TS__Class()
modifier_boss_brewmaster_5_earth_death.name = "modifier_boss_brewmaster_5_earth_death"
__TS__ClassExtends(modifier_boss_brewmaster_5_earth_death, MonsterModifier_CS)
function modifier_boss_brewmaster_5_earth_death.prototype.OnCreated(self)
	if not IsServer() then
		return
	end
	local caster = self:GetCaster()
	local ability = self:GetAbility()
	if not IsValidAlive(nil, caster) or not ability then
		self:Destroy()
		return
	end
	local waveDelay = 0
	do
		local waveIndex = 0
		while waveIndex < #BREWMASTER_DEATH_WAVE_POINT_COUNTS do
			local currentWaveIndex = waveIndex
			local pointCount = BREWMASTER_DEATH_WAVE_POINT_COUNTS[currentWaveIndex + 1]
			self:Timer(waveDelay, function()
				return self:StartWave(caster, ability, pointCount)
			end)
			waveDelay = waveDelay
				+ ((pointCount - 1) * BREWMASTER_EARTH_DEATH_WARNING_INTERVAL + BREWMASTER_EARTH_DEATH_WARNING_DURATION)
			waveIndex = waveIndex + 1
		end
	end
end
function modifier_boss_brewmaster_5_earth_death.prototype.StartWave(self, caster, ability, pointCount)
	if not IsValidAlive(nil, caster) or not IsValid(nil, ability) or ability:IsNull() then
		return
	end
	local points = GetRandomPointsInCircle(
		nil,
		caster:GetAbsOrigin(),
		BREWMASTER_EARTH_DEATH_POINT_RADIUS,
		pointCount,
		BREWMASTER_EARTH_DEATH_POINT_MIN_DISTANCE
	)
	do
		local pointIndex = 0
		while pointIndex < #points do
			local currentPoint = GetGroundPosition(points[pointIndex + 1], caster)
			local warningDelay = pointIndex * BREWMASTER_EARTH_DEATH_WARNING_INTERVAL
			self:Timer(warningDelay, function()
				return self:StartRockWarning(caster, ability, currentPoint)
			end)
			pointIndex = pointIndex + 1
		end
	end
end
function modifier_boss_brewmaster_5_earth_death.prototype.StartRockWarning(self, caster, ability, position)
	if not IsValidAlive(nil, caster) or not IsValid(nil, ability) or ability:IsNull() then
		return
	end
	self:WarningRingEffect(position, BREWMASTER_EARTH_DEATH_WARNING_RADIUS, BREWMASTER_EARTH_DEATH_WARNING_DURATION)
	self:Timer(BREWMASTER_EARTH_DEATH_ROCK_DELAY, function()
		return self:PlayRockEffect(position)
	end)
	self:Timer(BREWMASTER_EARTH_DEATH_WARNING_DURATION, function()
		return self:DamageRockArea(caster, ability, position)
	end)
end
function modifier_boss_brewmaster_5_earth_death.prototype.PlayRockEffect(self, position)
	local effect = ParticleManager:CreateParticle(BREWMASTER_EARTH_DEATH_ROCK_PARTICLE, PATTACH_WORLDORIGIN, nil)
	ParticleManager:SetParticleControl(effect, 0, position)
	ParticleManager:SetParticleControl(
		effect,
		1,
		Vector(
			BREWMASTER_EARTH_DEATH_WARNING_RADIUS,
			BREWMASTER_EARTH_DEATH_WARNING_RADIUS,
			BREWMASTER_EARTH_DEATH_WARNING_RADIUS * 3
		)
	)
	Timers:CreateTimer(BREWMASTER_EARTH_DEATH_PARTICLE_DURATION, function()
		ParticleManager:DestroyParticle(effect, false)
		ParticleManager:ReleaseParticleIndex(effect)
	end)
end
function modifier_boss_brewmaster_5_earth_death.prototype.DamageRockArea(self, caster, ability, position)
	if not IsValidAlive(nil, caster) or not IsValid(nil, ability) or ability:IsNull() then
		return
	end
	local enemies = FindUnitsInRadius(
		caster:GetTeamNumber(),
		position,
		nil,
		BREWMASTER_EARTH_DEATH_WARNING_RADIUS,
		DOTA_UNIT_TARGET_TEAM_ENEMY,
		DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,
		DOTA_UNIT_TARGET_FLAG_NONE,
		FIND_ANY_ORDER,
		false
	)
	for ____, enemy in ipairs(enemies) do
		do
			if not IsValidAlive(nil, enemy) then
				goto __continue96
			end
			caster:MonsterDamage({ victim = enemy, damage_rate = BREWMASTER_EARTH_DEATH_DAMAGE_RATE, ability = ability })
		end
		::__continue96::
	end
end
function modifier_boss_brewmaster_5_earth_death.prototype.IsHidden(self)
	return true
end
function modifier_boss_brewmaster_5_earth_death.prototype.IsPurgable(self)
	return false
end
modifier_boss_brewmaster_5_earth_death = __TS__DecorateLegacy(
	{ registerModifier(nil, "modifier_boss_brewmaster_5_earth_death") },
	modifier_boss_brewmaster_5_earth_death
)
modifier_boss_brewmaster_5_fire_death = __TS__Class()
modifier_boss_brewmaster_5_fire_death.name = "modifier_boss_brewmaster_5_fire_death"
__TS__ClassExtends(modifier_boss_brewmaster_5_fire_death, MonsterModifier_CS)
function modifier_boss_brewmaster_5_fire_death.prototype.OnCreated(self)
	if not IsServer() then
		return
	end
	local caster = self:GetCaster()
	local ability = self:GetAbility()
	if not IsValidAlive(nil, caster) or not ability then
		self:Destroy()
		return
	end
	do
		local waveIndex = 0
		while waveIndex < BREWMASTER_FIRE_DEATH_WAVE_COUNT do
			local currentWaveIndex = waveIndex
			self:Timer(currentWaveIndex * BREWMASTER_FIRE_DEATH_WAVE_INTERVAL, function()
				self:FireWallWave(caster, ability, currentWaveIndex)
			end)
			waveIndex = waveIndex + 1
		end
	end
end
function modifier_boss_brewmaster_5_fire_death.prototype.FireWallWave(self, caster, ability, waveIndex)
	if not IsValidAlive(nil, caster) or not IsValid(nil, ability) or ability:IsNull() then
		return
	end
	local origin = ability:GetSplitOrigin()
	local ____temp_4
	if waveIndex % 2 == 0 then
		____temp_4 = Vector(0, -1, 0)
	else
		____temp_4 = Vector(-1, 0, 0)
	end
	local direction = ____temp_4
	local ____temp_5
	if waveIndex % 2 == 0 then
		____temp_5 = Vector(1, 0, 0)
	else
		____temp_5 = Vector(0, 1, 0)
	end
	local lateral = ____temp_5
	local emptyLane = RandomInt(0, BREWMASTER_FIRE_DEATH_LANE_COUNT - 1)
	local laneCenter = (BREWMASTER_FIRE_DEATH_LANE_COUNT - 1) / 2
	do
		local laneIndex = 0
		while laneIndex < BREWMASTER_FIRE_DEATH_LANE_COUNT do
			do
				if laneIndex == emptyLane then
					goto __continue108
				end
				local lateralOffset = (laneIndex - laneCenter) * BREWMASTER_FIRE_DEATH_LANE_SPACING
				local startPoint = origin
					:__sub(direction:__mul(BREWMASTER_FIRE_DEATH_START_DISTANCE))
					:__add(lateral:__mul(lateralOffset))
				local targetPoint = startPoint:__add(direction:__mul(BREWMASTER_FIRE_DEATH_PROJECTILE_DISTANCE))
				local damagedTargets = __TS__New(Set)
				CreateProjectile(nil, {
					ability = ability,
					caster = caster,
					effect_name = BREWMASTER_FIRE_DEATH_PROJECTILE_PARTICLE,
					start_point = startPoint,
					target = targetPoint,
					projectile_type = "linear",
					projectile_speed = BREWMASTER_FIRE_DEATH_PROJECTILE_SPEED,
					projectile_distance = BREWMASTER_FIRE_DEATH_PROJECTILE_DISTANCE,
					projectile_range = 0,
					projectile_target_team = DOTA_UNIT_TARGET_TEAM_ENEMY,
					projectile_target_type = bit.bor(DOTA_UNIT_TARGET_HERO, DOTA_UNIT_TARGET_BASIC),
					projectile_target_flags = DOTA_UNIT_TARGET_FLAG_NONE,
					on_think = function(____, location)
						if not IsValidAlive(nil, caster) then
							return true
						end
						local halfWidth = BREWMASTER_FIRE_DEATH_PROJECTILE_WIDTH / 2
						local lineStart = location:__sub(lateral:__mul(halfWidth))
						local lineEnd = location:__add(lateral:__mul(halfWidth))
						local enemies = FindUnitsInLine(
							caster:GetTeamNumber(),
							lineStart,
							lineEnd,
							nil,
							BREWMASTER_FIRE_DEATH_PROJECTILE_THICKNESS,
							DOTA_UNIT_TARGET_TEAM_ENEMY,
							bit.bor(DOTA_UNIT_TARGET_HERO, DOTA_UNIT_TARGET_BASIC),
							DOTA_UNIT_TARGET_FLAG_NONE
						)
						for ____, enemy in ipairs(enemies) do
							do
								local enemyIndex = enemy:entindex()
								if not IsValidAlive(nil, enemy) or damagedTargets:has(enemyIndex) then
									goto __continue112
								end
								damagedTargets:add(enemyIndex)
								caster:MonsterDamage({
									victim = enemy,
									damage_rate = BREWMASTER_FIRE_DEATH_DAMAGE_RATE,
									ability = ability,
								})
							end
							::__continue112::
						end
						return false
					end,
				})
			end
			::__continue108::
			laneIndex = laneIndex + 1
		end
	end
end
function modifier_boss_brewmaster_5_fire_death.prototype.IsHidden(self)
	return true
end
function modifier_boss_brewmaster_5_fire_death.prototype.IsPurgable(self)
	return false
end
modifier_boss_brewmaster_5_fire_death = __TS__DecorateLegacy(
	{ registerModifier(nil, "modifier_boss_brewmaster_5_fire_death") },
	modifier_boss_brewmaster_5_fire_death
)
return ____exports