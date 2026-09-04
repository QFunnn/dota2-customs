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
local __TS__ArrayMap = ____lualib.__TS__ArrayMap
local __TS__DecorateLegacy = ____lualib.__TS__DecorateLegacy
local ____exports = {}
local ____dota_ts_adapter = require("utils.dota_ts_adapter")
local registerAbility = ____dota_ts_adapter.registerAbility
local registerModifier = ____dota_ts_adapter.registerModifier
local ____monster_base = require("abilities.monster.monster_base")
local MonsterAbility_CS = ____monster_base.MonsterAbility_CS
local MonsterModifier_CS = ____monster_base.MonsterModifier_CS
local CAST_POINT = 0.55
local CHANNEL_DURATION = 3.4
local SPAWN_INTERVAL = 0.65
local STRIKE_WARNING_DURATION = 0.6
local STRIKE_START_RADIUS = 480
local STRIKE_PASS_DISTANCE = 420
local STRIKE_WARNING_WIDTH = 180
local STRIKE_PATH_OFFSET = 150
local SPAWN_TARGET_SEARCH_RANGE = 1800
local REMNANT_DURATION = 0.9
local REMNANT_MOVE_SPEED = 320
local REMNANT_MOVE_DELAY = 0.15
local REMNANT_END_DELAY = 0.25
--- 提高更新频率，避免 F1 模型粒子因追踪 CP0 出现明显的速度滞后。
local REMNANT_THINK_INTERVAL = 0.03
--- 残影生成后的安全时间，期间不会因碰撞或销毁触发爆炸。
local REMNANT_ARM_DELAY = 0.55
--- 爆炸伤害范围半径
local REMNANT_EXPLOSION_RADIUS = 240
local REMNANT_DAMAGE_RATE = 15
local PARTICLE_REMNANT = "particles/boss/boss_storm_spirit/ak_stormspirit_moving_remnant.vpcf"
local PARTICLE_REMNANT_B = "particles/units/heroes/hero_stormspirit/stormspirit_overload_discharge.vpcf"
local SOUND_CAST = "Hero_StormSpirit.StaticRemnantPlant"
local SOUND_EXPLODE = "Hero_StormSpirit.StaticRemnantExplode"
____exports.boss_storm_spirit_1 = __TS__Class()
local boss_storm_spirit_1 = ____exports.boss_storm_spirit_1
boss_storm_spirit_1.name = "boss_storm_spirit_1"
__TS__ClassExtends(boss_storm_spirit_1, MonsterAbility_CS)
function boss_storm_spirit_1.prototype.Precache(self, context)
	PrecacheResource("particle", PARTICLE_REMNANT, context)
	PrecacheResource("particle", PARTICLE_REMNANT_B, context)
end
function boss_storm_spirit_1.prototype.GetMosnterAbilityConfig(self)
	return {
		castPoint = CAST_POINT,
		castDuration = CHANNEL_DURATION,
		behavior = DOTA_ABILITY_BEHAVIOR_NO_TARGET,
		isNotMove = true,
		OnPhaseStart = function()
			local caster = self:GetCaster()
			local target = caster:GetMinDistanceUnit(SPAWN_TARGET_SEARCH_RANGE)
			if IsValidAlive(nil, target) then
				caster:LockTargetForSpeed(target, CAST_POINT, 0)
			end
		end,
		OnStart = function()
			return self:onStart()
		end,
	}
end
function boss_storm_spirit_1.prototype.onStart(self)
	if not IsServer() then
		return
	end
	local caster = self:GetCaster()
	if not IsValidAlive(nil, caster) then
		return
	end
	local totalSpawns = math.floor((CHANNEL_DURATION - STRIKE_WARNING_DURATION - 0.05) / SPAWN_INTERVAL) + 1
	do
		local i = 0
		while i < totalSpawns do
			self:Timer(i * SPAWN_INTERVAL, function()
				if not IsValidAlive(nil, caster) then
					return
				end
				if not caster:HasModifier("modifier_monster_cast_controller") then
					return
				end
				self:prepareRemnantWave(caster, i)
			end)
			i = i + 1
		end
	end
end
function boss_storm_spirit_1.prototype.prepareRemnantWave(self, caster, waveIndex)
	local plan = self:getPressurePlan(caster, waveIndex)
	local paths = __TS__ArrayMap(self:getWaveDirections(plan.baseDirection, waveIndex), function(____, direction)
		return self:createStrikePath(caster, plan.center, direction)
	end)
	for ____, path in ipairs(paths) do
		self:WarningEffect(
			path.start,
			path["end"],
			STRIKE_WARNING_DURATION + 0.1,
			{ startWidth = STRIKE_WARNING_WIDTH, endWidth = STRIKE_WARNING_WIDTH }
		)
	end
	self:Timer(STRIKE_WARNING_DURATION, function()
		if not IsValidAlive(nil, caster) then
			return
		end
		if not caster:HasModifier("modifier_monster_cast_controller") then
			return
		end
		caster:StartGestureWithPlaybackRate(ACT_DOTA_CAST_ABILITY_1, 1.5)
		for ____, path in ipairs(paths) do
			local duration = self:getRemnantDuration(path.start, path["end"])
			if not IsValidAlive(nil, caster) then
				return
			end
			if not caster:HasModifier("modifier_monster_cast_controller") then
				return
			end
			self:spawnRemnant(caster, path.start, path["end"], duration)
		end
	end)
end
function boss_storm_spirit_1.prototype.getPressurePlan(self, caster, waveIndex)
	local target = caster:GetMinDistanceUnit(SPAWN_TARGET_SEARCH_RANGE)
	if not IsValidAlive(nil, target) then
		local fallbackDirection = self:normalizeDirection(caster:GetForwardVector(), Vector(1, 0, 0))
		return {
			center = GetGroundPosition(caster:GetAbsOrigin(), caster),
			baseDirection = fallbackDirection,
		}
	end
	local targetOrigin = GetGroundPosition(target:GetAbsOrigin(), caster)
	local baseDirection = self:normalizeDirection(targetOrigin:__sub(caster:GetAbsOrigin()), caster:GetForwardVector())
	local pressureCenter = targetOrigin:__add(self:getPathCenterOffset(baseDirection, waveIndex))
	return {
		center = GetGroundPosition(pressureCenter, caster),
		baseDirection = baseDirection,
	}
end
function boss_storm_spirit_1.prototype.getPathCenterOffset(self, baseDirection, waveIndex)
	local sideDirection = Vector(-baseDirection.y, baseDirection.x, 0)
	local pattern = waveIndex % 6
	if pattern == 1 then
		return sideDirection:__mul(STRIKE_PATH_OFFSET)
	end
	if pattern == 2 then
		return sideDirection:__mul(-STRIKE_PATH_OFFSET)
	end
	if pattern == 3 then
		return baseDirection:__mul(STRIKE_PATH_OFFSET)
	end
	if pattern == 4 then
		return baseDirection:__mul(-STRIKE_PATH_OFFSET)
	end
	if pattern == 5 then
		return sideDirection:__mul(STRIKE_PATH_OFFSET * 0.7):__sub(baseDirection:__mul(STRIKE_PATH_OFFSET * 0.7))
	end
	return Vector(0, 0, 0)
end
function boss_storm_spirit_1.prototype.getWaveDirections(self, baseDirection, waveIndex)
	if waveIndex % 3 == 2 then
		local offset = waveIndex % 2 == 0 and 0 or math.pi / 6
		return {
			self:rotateDirection(baseDirection, offset),
			self:rotateDirection(baseDirection, offset + math.pi * 2 / 3),
			self:rotateDirection(baseDirection, offset + math.pi * 4 / 3),
		}
	end
	local angleOffset = waveIndex % 4 * math.pi / 4
	local axis = self:rotateDirection(baseDirection, angleOffset)
	return {
		axis,
		axis:__mul(-1),
	}
end
function boss_storm_spirit_1.prototype.createStrikePath(self, caster, center, direction)
	local start = GetGroundPosition(center:__add(direction:__mul(STRIKE_START_RADIUS)), caster)
	local ____end = GetGroundPosition(center:__add(direction:__mul(-STRIKE_PASS_DISTANCE)), caster)
	return { start = start, ["end"] = ____end }
end
function boss_storm_spirit_1.prototype.getRemnantDuration(self, start, ____end)
	local distance = GetDistance(nil, start, ____end)
	return math.max(REMNANT_ARM_DELAY + 0.2, REMNANT_MOVE_DELAY + distance / REMNANT_MOVE_SPEED + REMNANT_END_DELAY)
end
function boss_storm_spirit_1.prototype.rotateDirection(self, direction, angle)
	local cos = math.cos(angle)
	local sin = math.sin(angle)
	return Vector(direction.x * cos - direction.y * sin, direction.x * sin + direction.y * cos, 0):Normalized()
end
function boss_storm_spirit_1.prototype.normalizeDirection(self, direction, fallback)
	local flatDirection = Vector(direction.x, direction.y, 0)
	if flatDirection:Length2D() > 0.01 then
		return flatDirection:Normalized()
	end
	local flatFallback = Vector(fallback.x, fallback.y, 0)
	if flatFallback:Length2D() > 0.01 then
		return flatFallback:Normalized()
	end
	return Vector(1, 0, 0)
end
function boss_storm_spirit_1.prototype.spawnRemnant(self, caster, start, target, duration)
	caster:EmitSound(SOUND_CAST)
	local baseDir = target:__sub(start)
	CreateModifierThinker(caster, self, "modifier_boss_storm_spirit_1_remnant", {
		duration = duration,
		parent_model = caster:GetModelName(),
		target_x = baseDir.x,
		target_y = baseDir.y,
		target_z = baseDir.z,
	}, start, caster:GetTeamNumber(), false)
end
boss_storm_spirit_1 = __TS__DecorateLegacy({ registerAbility(nil) }, boss_storm_spirit_1)
____exports.boss_storm_spirit_1 = boss_storm_spirit_1
local modifier_boss_storm_spirit_1_remnant = __TS__Class()
modifier_boss_storm_spirit_1_remnant.name = "modifier_boss_storm_spirit_1_remnant"
__TS__ClassExtends(modifier_boss_storm_spirit_1_remnant, MonsterModifier_CS)
function modifier_boss_storm_spirit_1_remnant.prototype.____constructor(self, ...)
	MonsterModifier_CS.prototype.____constructor(self, ...)
	self.exploded = false
	self.fallbackDir = Vector(1, 0, 0)
	self.moveElapsed = 0
	self.duration = REMNANT_DURATION
end
function modifier_boss_storm_spirit_1_remnant.prototype.IsHidden(self)
	return true
end
function modifier_boss_storm_spirit_1_remnant.prototype.CheckState(self)
	return { [MODIFIER_STATE_NO_UNIT_COLLISION] = true }
end
function modifier_boss_storm_spirit_1_remnant.prototype.OnCreated(self, params)
	if not IsServer() then
		return
	end
	local thinker = self:GetParent()
	if not IsValid(nil, thinker) or thinker:IsNull() then
		return
	end
	local rawDirection =
		Vector(params and params.target_x or 1, params and params.target_y or 0, params and params.target_z or 0)
	local ____temp_6
	if rawDirection:Length2D() > 0.01 then
		____temp_6 = rawDirection:Normalized()
	else
		____temp_6 = Vector(1, 0, 0)
	end
	self.fallbackDir = ____temp_6
	self._parent:SetOriginalModel(params and params.parent_model or "")
	self._parent:SetModel(params and params.parent_model or "")
	self._parent:SetModelScale(0.01)
	self:createRemnantParticle(thinker)
	self.duration = params and params.duration or REMNANT_DURATION
	self:StartIntervalThink(REMNANT_THINK_INTERVAL)
end
function modifier_boss_storm_spirit_1_remnant.prototype.createRemnantParticle(self, thinker)
	if not IsServer() or self.pfxRemnant ~= nil then
		return
	end
	self.pfxRemnant = ParticleManager:CreateParticle(PARTICLE_REMNANT, PATTACH_CUSTOMORIGIN, thinker)
	ParticleManager:SetParticleShouldCheckFoW(self.pfxRemnant, false)
	ParticleManager:SetParticleControl(self.pfxRemnant, 0, thinker:GetAbsOrigin())
end
function modifier_boss_storm_spirit_1_remnant.prototype.updateParticles(self, origin)
	if self.pfxRemnant ~= nil then
		ParticleManager:SetParticleControl(self.pfxRemnant, 0, origin)
	end
end
function modifier_boss_storm_spirit_1_remnant.prototype.destroyParticles(self)
	if self.pfxRemnant ~= nil then
		ParticleManager:DestroyParticle(self.pfxRemnant, false)
		ParticleManager:ReleaseParticleIndex(self.pfxRemnant)
		self.pfxRemnant = nil
	end
end
function modifier_boss_storm_spirit_1_remnant.prototype.explode(self)
	if self.exploded then
		return
	end
	local thinker = self:GetParent()
	if not IsValid(nil, thinker) or thinker:IsNull() then
		return
	end
	SafelyCall(nil, function()
		if self.exploded or self:IsRemoved() then
			return
		end
		self:Destroy()
	end)
end
function modifier_boss_storm_spirit_1_remnant.prototype.playExplosionParticle(self, center)
	local pfx = ParticleManager:CreateParticle(PARTICLE_REMNANT_B, PATTACH_WORLDORIGIN, nil)
	ParticleManager:SetParticleShouldCheckFoW(pfx, false)
	ParticleManager:SetParticleControl(pfx, 0, center)
	Timers:CreateTimer(5, function()
		ParticleManager:DestroyParticle(pfx, false)
		ParticleManager:ReleaseParticleIndex(pfx)
		return nil
	end)
end
function modifier_boss_storm_spirit_1_remnant.prototype.OnIntervalThink(self)
	if not IsServer() or self.exploded then
		return
	end
	local thinker = self:GetParent()
	if not IsValidAlive(nil, thinker) then
		return
	end
	if not IsValid(nil, thinker) or thinker:IsNull() then
		self:Destroy()
		return
	end
	self.moveElapsed = self.moveElapsed + REMNANT_THINK_INTERVAL
	local origin = thinker:GetAbsOrigin()
	local team = thinker:GetTeamNumber()
	if self:isArmed() then
		local touchUnits = FindUnitsInRadius(
			team,
			origin,
			nil,
			REMNANT_EXPLOSION_RADIUS * 0.7,
			DOTA_UNIT_TARGET_TEAM_ENEMY,
			bit.bor(DOTA_UNIT_TARGET_HERO, DOTA_UNIT_TARGET_BASIC),
			DOTA_UNIT_TARGET_FLAG_NONE,
			FIND_ANY_ORDER,
			false
		)
		for ____, u in ipairs(touchUnits) do
			if IsValidAlive(nil, u) then
				self:explode()
				return
			end
		end
	end
	if self.moveElapsed >= self.duration then
		self:explode()
		return
	end
	if self.moveElapsed < REMNANT_MOVE_DELAY then
		return
	end
	local dir = self.fallbackDir
	local move = dir:__mul(REMNANT_MOVE_SPEED * REMNANT_THINK_INTERVAL)
	local newPos = origin:__add(move)
	local gz = GetGroundHeight(newPos, thinker)
	local ____temp_13
	if gz ~= nil then
		____temp_13 = gz
	else
		____temp_13 = newPos.z
	end
	newPos.z = ____temp_13
	thinker:SetForwardVector(dir)
	thinker:SetAbsOrigin(newPos)
	self:updateParticles(newPos)
end
function modifier_boss_storm_spirit_1_remnant.prototype.isArmed(self)
	return self:GetElapsedTime() >= REMNANT_ARM_DELAY
end
function modifier_boss_storm_spirit_1_remnant.prototype.OnDestroy(self)
	if not IsServer() then
		return
	end
	self:StartIntervalThink(-1)
	self:destroyParticles()
	local thinker = self:GetParent()
	if not IsValid(nil, thinker) or thinker:IsNull() then
		return
	end
	if not self:isArmed() then
		thinker:SelfRemoveSelf()
		return
	end
	local center = thinker:GetAbsOrigin()
	thinker:EmitSound(SOUND_EXPLODE)
	self:playExplosionParticle(center)
	local enemies = FindUnitsInRadius(
		thinker:GetTeamNumber(),
		center,
		nil,
		REMNANT_EXPLOSION_RADIUS,
		DOTA_UNIT_TARGET_TEAM_ENEMY,
		bit.bor(DOTA_UNIT_TARGET_HERO, DOTA_UNIT_TARGET_BASIC),
		DOTA_UNIT_TARGET_FLAG_NONE,
		FIND_ANY_ORDER,
		false
	)
	local caster = self:GetCaster()
	local ability = self:GetAbility()
	for ____, victim in ipairs(enemies) do
		do
			if not IsValidAlive(nil, victim) then
				goto __continue75
			end
			if IsValidAlive(nil, caster) and ability then
				caster:MonsterDamage({ victim = victim, damage_rate = REMNANT_DAMAGE_RATE, ability = ability })
				goto __continue75
			end
			ApplyMonsterDamage(nil, thinker, { victim = victim, damage_rate = REMNANT_DAMAGE_RATE, damage_type = 2 })
		end
		::__continue75::
	end
	thinker:SelfRemoveSelf()
end
modifier_boss_storm_spirit_1_remnant = __TS__DecorateLegacy(
	{ registerModifier(nil, "modifier_boss_storm_spirit_1_remnant") },
	modifier_boss_storm_spirit_1_remnant
)
return ____exports