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
local modifier_elite_306_swarm_latch, modifier_elite_306_swarm_unit
local ____dota_ts_adapter = require("utils.dota_ts_adapter")
local registerAbility = ____dota_ts_adapter.registerAbility
local registerModifier = ____dota_ts_adapter.registerModifier
local ____monster_base = require("abilities.monster.monster_base")
local MonsterAbility_CS = ____monster_base.MonsterAbility_CS
local MonsterModifier_CS = ____monster_base.MonsterModifier_CS
local CAST_RANGE = 1200
local CAST_POINT = 0.5
local DISTANCE = 1050
local WIDTH = 120
local MAX_ANGLE = 45
local SWARM_SPIT_INTERVAL = 0.24
local SWARM_SPIT_MIN_COUNT = 1
local SWARM_SPIT_MAX_COUNT = 2
local SWARM_SPIT_RANDOM_ANGLE_OFFSET = 10
local SWARM_SPIT_ANGLES = {
	55,
	45,
	25,
	5,
	-15,
	-35,
	-45,
	-20,
	0,
	20,
	40,
}
local PROJECTILE_SPEED = 520
local SWARM_DURATION = 8
local SWARM_DAMAGE_INTERVAL = 0.7
local SWARM_DAMAGE_RATE = 3
local SWARM_ATTACH_DISTANCE = 95
local SWARM_UNIT_NAME = "monster_11303_swarm"
local PARTICLE = "particles/econ/items/weaver/weaver_immortal_ti7/weaver_swarm_projectile_ti7.vpcf"
local HIT_PARTICLE = "particles/units/heroes/hero_weaver/weaver_swarm_infected_debuff.vpcf"
local SWARM_LATCH_SOUND = "Hero_Weaver.SwarmAttach"
local SCREEN_SHAKE_AMPLITUDE = 12
local SCREEN_SHAKE_FREQUENCY = 12
local SCREEN_SHAKE_DURATION = 0.2
local SCREEN_SHAKE_RADIUS = 1800
____exports.elite_306 = __TS__Class()
local elite_306 = ____exports.elite_306
elite_306.name = "elite_306"
__TS__ClassExtends(elite_306, MonsterAbility_CS)
function elite_306.prototype.Precache(self, context)
	PrecacheResource("particle", PARTICLE, context)
	PrecacheResource("particle", HIT_PARTICLE, context)
	PrecacheUnitByNameSync(SWARM_UNIT_NAME, context)
end
function elite_306.prototype.GetMosnterAbilityConfig(self)
	return {
		castRange = CAST_RANGE,
		behavior = DOTA_ABILITY_BEHAVIOR_NO_TARGET,
		castPoint = CAST_POINT,
		castDuration = 3.2,
		castAnimation = ACT_DOTA_CAST_ABILITY_1,
		cooldown = 12,
		OnPhaseStart = function()
			return self:Warn()
		end,
		OnStart = function()
			return self:Fire()
		end,
	}
end
function elite_306.prototype.Warn(self)
	local caster = self:GetCaster()
	if not IsValidAlive(nil, caster) then
		return
	end
	local target = caster:GetMinDistanceUnit(CAST_RANGE)
	if IsValidAlive(nil, target) then
		caster:LockTargetForSpeed(target, CAST_POINT, 10)
	end
	local origin = caster:GetAbsOrigin()
	local baseDirection = self:DirectionToTarget(caster)
	local endWidth = DISTANCE * math.sin(math.rad(MAX_ANGLE)) + WIDTH
	local end_point = GetGroundPosition(origin:__add(baseDirection:__mul(500)), caster)
	self:WarningEffect(origin, end_point, CAST_POINT + 0.5, { startWidth = 100, endWidth = 500 })
end
function elite_306.prototype.Fire(self)
	local caster = self:GetCaster()
	if not IsValidAlive(nil, caster) then
		return
	end
	local baseDirection = self:DirectionToTarget(caster)
	EmitSoundOn("Hero_Weaver.Swarm.Cast", caster)
	do
		local index = 0
		while index < #SWARM_SPIT_ANGLES do
			local currentIndex = index
			local currentAngle = SWARM_SPIT_ANGLES[currentIndex + 1]
			self:Timer(currentIndex * SWARM_SPIT_INTERVAL, function()
				if not IsValidAlive(nil, caster) then
					return
				end
				local start = self:GetProjectileStart(caster)
				self:FireSwarmBurst(caster, start, baseDirection, currentAngle)
				caster:StartGestureWithPlaybackRate(ACT_DOTA_CAST_ABILITY_1, 1.35)
			end)
			index = index + 1
		end
	end
end
function elite_306.prototype.FireSwarmBurst(self, caster, start, baseDirection, baseAngle)
	local count = RandomInt(SWARM_SPIT_MIN_COUNT, SWARM_SPIT_MAX_COUNT)
	self:PlayFireScreenShake(start)
	do
		local index = 0
		while index < count do
			local angle = baseAngle + RandomFloat(-SWARM_SPIT_RANDOM_ANGLE_OFFSET, SWARM_SPIT_RANDOM_ANGLE_OFFSET)
			local direction = self:RotateDirection(baseDirection, angle)
			self:Timer((index - 1) * 0.06, function()
				self:FireSwarmLine(caster, start, direction)
			end)
			index = index + 1
		end
	end
end
function elite_306.prototype.FireSwarmLine(self, caster, start, direction)
	local ____end = self:GroundLineEnd(start, direction, caster)
	CreateProjectile(nil, {
		ability = self,
		caster = caster,
		effect_name = PARTICLE,
		projectile_type = "linear",
		start_point = start,
		target = ____end,
		projectile_speed = PROJECTILE_SPEED,
		projectile_distance = DISTANCE,
		projectile_range = WIDTH,
		projectile_target_team = DOTA_UNIT_TARGET_TEAM_ENEMY,
		projectile_target_type = DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,
		projectile_target_flags = DOTA_UNIT_TARGET_FLAG_NONE,
		on_hit = function(____, hitTarget)
			if not hitTarget or not IsValidAlive(nil, hitTarget) then
				return true
			end
			self:AttachSwarm(caster, hitTarget)
			return false
		end,
	})
end
function elite_306.prototype.AttachSwarm(self, caster, target)
	modifier_elite_306_swarm_latch:applys(target, caster, self, { duration = SWARM_DURATION })
end
function elite_306.prototype.PlayFireScreenShake(self, point)
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
function elite_306.prototype.DirectionToTarget(self, caster)
	local target = caster:GetMinDistanceUnit(CAST_RANGE)
	if IsValidAlive(nil, target) then
		local direction = GetDirection(nil, target:GetAbsOrigin(), caster:GetAbsOrigin())
		if direction:Length2D() > 0.01 then
			return direction
		end
	end
	return caster:GetForwardVector():Normalized()
end
function elite_306.prototype.RotateDirection(self, direction, angleDegrees)
	local radians = angleDegrees * math.pi / 180
	local cos = math.cos(radians)
	local sin = math.sin(radians)
	return Vector(direction.x * cos - direction.y * sin, direction.x * sin + direction.y * cos, 0):Normalized()
end
function elite_306.prototype.GetProjectileStart(self, caster)
	return caster:GetAbsOrigin():__add(Vector(0, 0, 128)):__add(caster:GetForwardVector():__mul(80))
end
function elite_306.prototype.GroundLineEnd(self, start, direction, caster)
	return GetGroundPosition(start:__add(direction:__mul(DISTANCE)), caster)
end
elite_306 = __TS__DecorateLegacy({ registerAbility(nil) }, elite_306)
____exports.elite_306 = elite_306
modifier_elite_306_swarm_latch = __TS__Class()
modifier_elite_306_swarm_latch.name = "modifier_elite_306_swarm_latch"
__TS__ClassExtends(modifier_elite_306_swarm_latch, MonsterModifier_CS)
function modifier_elite_306_swarm_latch.prototype.____constructor(self, ...)
	MonsterModifier_CS.prototype.____constructor(self, ...)
	self.damageElapsed = 0
	self.destroyed = false
	self.swarmCreating = false
end
function modifier_elite_306_swarm_latch.prototype.OnCreated(self)
	if not IsServer() then
		return
	end
	self.destroyed = false
	self.damageElapsed = 0
	self:CreateDebuffParticle()
	self:CreateSwarmUnit()
	self:StartIntervalThink(FrameTime())
end
function modifier_elite_306_swarm_latch.prototype.OnRefresh(self)
	if not IsServer() then
		return
	end
	self.damageElapsed = 0
	self:SetDuration(SWARM_DURATION, true)
end
function modifier_elite_306_swarm_latch.prototype.OnIntervalThink(self)
	if not IsServer() then
		return
	end
	local target = self:GetParent()
	local caster = self:GetCaster()
	if not IsValidAlive(nil, target) or not IsValidAlive(nil, caster) then
		self:Destroy()
		return
	end
	if not self.swarm or not IsValidAlive(nil, self.swarm) then
		if self.swarmCreating then
			return
		end
		self:Destroy()
		return
	end
	self:UpdateSwarmPosition(target)
	self.damageElapsed = self.damageElapsed + FrameTime()
	if self.damageElapsed < SWARM_DAMAGE_INTERVAL then
		return
	end
	self.damageElapsed = 0
	caster:MonsterDamage({
		victim = target,
		damage_rate = SWARM_DAMAGE_RATE,
		ability = self:GetAbility(),
	})
end
function modifier_elite_306_swarm_latch.prototype.OnDestroy(self)
	if not IsServer() then
		return
	end
	self.destroyed = true
	self:StartIntervalThink(-1)
	self:DestroyDebuffParticle()
	self:DestroySwarmUnit()
end
function modifier_elite_306_swarm_latch.prototype.IsHidden(self)
	return false
end
function modifier_elite_306_swarm_latch.prototype.IsDebuff(self)
	return true
end
function modifier_elite_306_swarm_latch.prototype.IsPurgable(self)
	return false
end
function modifier_elite_306_swarm_latch.prototype.GetTexture(self)
	return "weaver_swarm"
end
function modifier_elite_306_swarm_latch.prototype.CreateDebuffParticle(self)
	local target = self:GetParent()
	self:DestroyDebuffParticle()
	self.debuffParticle = ParticleManager:CreateParticle(HIT_PARTICLE, PATTACH_POINT_FOLLOW, target)
	ParticleManager:SetParticleControlEnt(
		self.debuffParticle,
		0,
		target,
		PATTACH_POINT_FOLLOW,
		"attach_hitloc",
		target:GetAbsOrigin(),
		true
	)
end
function modifier_elite_306_swarm_latch.prototype.DestroyDebuffParticle(self)
	if self.debuffParticle == nil then
		return
	end
	ParticleManager:DestroyParticle(self.debuffParticle, false)
	ParticleManager:ReleaseParticleIndex(self.debuffParticle)
	self.debuffParticle = nil
end
function modifier_elite_306_swarm_latch.prototype.CreateSwarmUnit(self, forcedCaster)
	local target = self:GetParent()
	local caster = forcedCaster or self:GetCaster()
	if not IsValidAlive(nil, target) or not IsValidAlive(nil, caster) then
		return
	end
	local spawnPos = self:GetSwarmPosition(target)
	local ____opt_0 = caster.GetRoomId
	local roomId = ____opt_0 and ____opt_0(caster)
	self.swarmCreating = true
	MyGameUnit:CreateSummonedUnitAsync({
		unitName = SWARM_UNIT_NAME,
		position = spawnPos,
		roomId = roomId,
		team = caster:GetTeamNumber(),
		owner = caster,
		summoner = caster,
		destroyWithSummoner = true,
		findClearSpace = false,
		summonTag = (((SWARM_UNIT_NAME .. "_") .. tostring(target:entindex())) .. "_") .. DoUniqueString("latch"),
		onSpawn = function(____, swarm)
			self.swarmCreating = false
			if not swarm or not IsValidAlive(nil, swarm) then
				return
			end
			if self.destroyed or not IsValidAlive(nil, target) or not IsValidAlive(nil, caster) then
				MyGameUnit:DestroyUnit(swarm)
				return
			end
			swarm:SetOwner(caster)
			swarm:SetForwardVector(GetDirection(nil, target:GetAbsOrigin(), spawnPos))
			swarm:AddNewModifier(
				caster,
				self:GetAbility(),
				modifier_elite_306_swarm_unit.name,
				{ duration = SWARM_DURATION + 0.2 }
			)
			self.swarm = swarm
			EmitSoundOn(SWARM_LATCH_SOUND, swarm)
		end,
	})
end
function modifier_elite_306_swarm_latch.prototype.DestroySwarmUnit(self)
	self.swarmCreating = false
	if not self.swarm or not IsValid(nil, self.swarm) then
		self.swarm = nil
		return
	end
	if IsValidAlive(nil, self.swarm) then
		MyGameUnit:DestroyUnit(self.swarm)
	end
	self.swarm = nil
end
function modifier_elite_306_swarm_latch.prototype.UpdateSwarmPosition(self, target)
	if not self.swarm or not IsValidAlive(nil, self.swarm) then
		return
	end
	if not IsValidAlive(nil, target) then
		return
	end
	local pos = self:GetSwarmPosition(target)
	self.swarm:SetAbsOrigin(pos)
	self.swarm:SetForwardVector(GetDirection(nil, target:GetAbsOrigin(), pos))
end
function modifier_elite_306_swarm_latch.prototype.GetSwarmPosition(self, target)
	local forward = target:GetForwardVector():__mul(SWARM_ATTACH_DISTANCE)
	local offset = forward:__add(Vector(0, 0, 70))
	return target:GetAbsOrigin():__add(offset)
end
function modifier_elite_306_swarm_latch.prototype.GetAttributes(self)
	return MODIFIER_ATTRIBUTE_MULTIPLE
end
function modifier_elite_306_swarm_latch.GetLocalizationCN(self)
	return {
		name = "虫群寄生",
		description = "一只虫子附着在身上持续造成伤害。击败虫子可以提前解除该效果。",
	}
end
modifier_elite_306_swarm_latch =
	__TS__DecorateLegacy({ registerModifier(nil, "modifier_elite_306_swarm_latch") }, modifier_elite_306_swarm_latch)
modifier_elite_306_swarm_unit = __TS__Class()
modifier_elite_306_swarm_unit.name = "modifier_elite_306_swarm_unit"
__TS__ClassExtends(modifier_elite_306_swarm_unit, MonsterModifier_CS)
function modifier_elite_306_swarm_unit.prototype.CheckState(self)
	return { [MODIFIER_STATE_NO_UNIT_COLLISION] = true }
end
function modifier_elite_306_swarm_unit.prototype.IsHidden(self)
	return true
end
function modifier_elite_306_swarm_unit.prototype.IsPurgable(self)
	return false
end
modifier_elite_306_swarm_unit =
	__TS__DecorateLegacy({ registerModifier(nil, "modifier_elite_306_swarm_unit") }, modifier_elite_306_swarm_unit)
return ____exports