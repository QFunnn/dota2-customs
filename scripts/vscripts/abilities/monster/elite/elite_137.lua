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
local __TS__ArrayFilter = ____lualib.__TS__ArrayFilter
local ____exports = {}
local modifier_elite_137_feast
local ____dota_ts_adapter = require("utils.dota_ts_adapter")
local registerAbility = ____dota_ts_adapter.registerAbility
local registerModifier = ____dota_ts_adapter.registerModifier
local ____monster_base = require("abilities.monster.monster_base")
local MonsterAbility_CS = ____monster_base.MonsterAbility_CS
local MonsterModifier_CS = ____monster_base.MonsterModifier_CS
local CAST_POINT = 0.6
local CAST_DURATION = 1
local CAST_RANGE = 900
local PROJECTILE_SPEED = 900
local PROJECTILE_START_FORWARD_OFFSET = 90
local PROJECTILE_START_HEIGHT = 180
local COUNTDOWN_HEIGHT = 220
local SEEDLING_WAVE_COUNT = 2
local SEEDLING_WAVE_INTERVAL = 0.2
local SELF_SCATTER_RADIUS = 520
local MIN_SCATTER_DISTANCE = 80
local SPIRIT_DURATION = 15
local COUNTDOWN_SHOW_DURATION = 15
local SPIRIT_ARM_DELAY = 1
local SPIRIT_DETECT_RADIUS = 300
local SPIRIT_THINK_INTERVAL = FrameTime()
local SPIRIT_WANDER_SPEED = 120
local SPIRIT_WANDER_REACH_DISTANCE = 70
local SPIRIT_WANDER_OUTWARD_STEP_MIN = 90
local SPIRIT_WANDER_OUTWARD_STEP_MAX = 180
local SPIRIT_WANDER_MAX_RADIUS = 920
local SPIRIT_WANDER_SPREAD_DEGREES = 45
local SPIRIT_CHASE_SPEED = 350
local SPIRIT_CATCH_RADIUS = 80
local FEAST_DURATION = 3
local FEAST_DAMAGE_INTERVAL = 0.5
local FEAST_DAMAGE_RATE = 1.2
local EXPLOSION_DAMAGE_RATE = FEAST_DAMAGE_RATE
local EXPLOSION_PARTICLE_RELEASE_DELAY = 2
local PLANT_RADIUS = 110
local LANDING_WARNING_MIN_DURATION = 0.35
local SEEDLING_PROJECTILE_PARTICLE = "particles/units/tree/ability_1.vpcf"
local PLANT_PARTICLE =
	"particles/econ/items/treant_protector/treant_ti10_immortal_head/treant_ti10_immortal_overgrowth_root.vpcf"
local ROOT_PARTICLE =
	"particles/econ/items/treant_protector/treant_ti10_immortal_head/treant_ti10_immortal_overgrowth_root_small.vpcf"
local COUNTDOWN_PARTICLE = "particles/units/heroes/heroes_underlord/abyssal_underlord_portal_timer.vpcf"
local EXPLOSION_PARTICLE = "particles/econ/items/abaddon/abaddon_alliance/abaddon_death_coil_alliance_explosion.vpcf"
local SEEDLING_CAST_SOUND = "Hero_Treant.LivingArmor.Cast"
local SEEDLING_LAND_SOUND = "Hero_Treant.LivingArmor.Target.ti7"
local SPIRIT_ACTIVATE_SOUND = "Hero_ArcWarden.SparkWraith.Activate"
local SPIRIT_HIT_SOUND = "Hero_ArcWarden.SparkWraith.Damage"
local ROOT_LOOP_SOUND = "Hero_Treant.Overgrowth.Target"
--- 精英技能137 - 怨灵播种：小精灵随机散落在自身周围，开启后形成禁流陷阱
____exports.elite_137 = __TS__Class()
local elite_137 = ____exports.elite_137
elite_137.name = "elite_137"
__TS__ClassExtends(elite_137, MonsterAbility_CS)
function elite_137.prototype.Precache(self, context)
	PrecacheResource("particle", SEEDLING_PROJECTILE_PARTICLE, context)
	PrecacheResource("particle", PLANT_PARTICLE, context)
	PrecacheResource("particle", ROOT_PARTICLE, context)
	PrecacheResource("particle", COUNTDOWN_PARTICLE, context)
	PrecacheResource("particle", EXPLOSION_PARTICLE, context)
end
function elite_137.prototype.GetMosnterAbilityConfig(self)
	return {
		castRange = CAST_RANGE,
		castPoint = CAST_POINT,
		castDuration = CAST_DURATION,
		behavior = DOTA_ABILITY_BEHAVIOR_NO_TARGET,
		castAnimation = ACT_DOTA_CAST_ABILITY_2,
		animationPlaybackRate = 1,
		castColor = Vector(80, 190, 100),
		OnStart = function()
			local caster = self:GetCaster()
			if not IsValidAlive(nil, caster) then
				return
			end
			EmitSoundOn(SEEDLING_CAST_SOUND, caster)
			self:StartSeedlingSequence(caster)
		end,
	}
end
function elite_137.prototype.StartSeedlingSequence(self, caster)
	do
		local waveIndex = 0
		while waveIndex < SEEDLING_WAVE_COUNT do
			local currentWaveIndex = waveIndex
			local currentDelay = currentWaveIndex * SEEDLING_WAVE_INTERVAL
			self:Timer(currentDelay, function()
				if not IsValidAlive(nil, caster) then
					return
				end
				do
					local seedIndex = 0
					while seedIndex < 2 do
						local selfLandingPoint =
							self:GetRandomGroundPoint(caster:GetAbsOrigin(), SELF_SCATTER_RADIUS, caster)
						self:LaunchSeedling(caster, selfLandingPoint)
						seedIndex = seedIndex + 1
					end
				end
			end)
			waveIndex = waveIndex + 1
		end
	end
end
function elite_137.prototype.LaunchSeedling(self, caster, targetPoint)
	local startPoint = self:GetProjectileStartPoint(caster)
	local travelTime =
		math.max(LANDING_WARNING_MIN_DURATION, targetPoint:__sub(startPoint):Length2D() / PROJECTILE_SPEED)
	CreateModifierThinker(caster, self, "modifier_elite_137_spirit_thinker", {
		duration = SPIRIT_DURATION + travelTime,
		landing_x = targetPoint.x,
		landing_y = targetPoint.y,
		landing_z = targetPoint.z,
		center_x = caster:GetAbsOrigin().x,
		center_y = caster:GetAbsOrigin().y,
		center_z = caster:GetAbsOrigin().z,
		fly_duration = travelTime,
	}, startPoint, caster:GetTeamNumber(), false)
end
function elite_137.prototype.TriggerFeast(self, caster, target)
	if not IsValidAlive(nil, caster) or not IsValidAlive(nil, target) then
		return
	end
	EmitSoundOn(SPIRIT_HIT_SOUND, target)
	modifier_elite_137_feast:applys(target, caster, self, { duration = FEAST_DURATION })
end
function elite_137.prototype.GetRandomGroundPoint(self, center, radius, context)
	local groundCenter = GetGroundPosition(center, context)
	do
		local attempt = 0
		while attempt < 8 do
			local currentDistance = RandomFloat(MIN_SCATTER_DISTANCE, radius)
			local currentPoint = groundCenter:__add(RandomVector(currentDistance))
			local currentGroundPoint = GetGroundPosition(currentPoint, context)
			if IsGridNavDisplacementWalkable(nil, currentGroundPoint) then
				return currentGroundPoint
			end
			attempt = attempt + 1
		end
	end
	return groundCenter
end
function elite_137.prototype.GetProjectileStartPoint(self, caster)
	local forward = caster:GetForwardVector()
	return caster
		:GetAbsOrigin()
		:__add(forward:__mul(PROJECTILE_START_FORWARD_OFFSET))
		:__add(Vector(0, 0, PROJECTILE_START_HEIGHT))
end
elite_137 = __TS__DecorateLegacy({ registerAbility(nil) }, elite_137)
____exports.elite_137 = elite_137
local modifier_elite_137_spirit_thinker = __TS__Class()
modifier_elite_137_spirit_thinker.name = "modifier_elite_137_spirit_thinker"
__TS__ClassExtends(modifier_elite_137_spirit_thinker, MonsterModifier_CS)
function modifier_elite_137_spirit_thinker.prototype.____constructor(self, ...)
	MonsterModifier_CS.prototype.____constructor(self, ...)
	self.origin = Vector(0, 0, 0)
	self.startPoint = Vector(0, 0, 0)
	self.landingPoint = Vector(0, 0, 0)
	self.scatterCenter = Vector(0, 0, 0)
	self.flyDuration = 0
	self.elapsed = 0
	self.landed = false
	self.armed = false
	self.armElapsed = 0
	self.isChasing = false
	self.hasTerminalExploded = false
end
function modifier_elite_137_spirit_thinker.prototype.OnCreated(self, params)
	if not IsServer() then
		return
	end
	local parent = self:GetParent()
	local caster = self:GetCaster()
	if not IsValidAlive(nil, parent) or not IsValidAlive(nil, caster) then
		self:Destroy()
		return
	end
	self.startPoint = parent:GetAbsOrigin()
	self.landingPoint = Vector(
		params.landing_x or self.startPoint.x,
		params.landing_y or self.startPoint.y,
		params.landing_z or self.startPoint.z
	)
	self.scatterCenter = GetGroundPosition(
		Vector(
			params.center_x or self.startPoint.x,
			params.center_y or self.startPoint.y,
			params.center_z or self.startPoint.z
		),
		caster
	)
	self.flyDuration = math.max(params.fly_duration or LANDING_WARNING_MIN_DURATION, 0.03)
	self.origin = self.startPoint
	self:FaceMoveDirection(parent, self.landingPoint:__sub(self.startPoint))
	parent:SetAbsOrigin(self.origin)
	self.spiritPfx = ParticleManager:CreateParticle(SEEDLING_PROJECTILE_PARTICLE, PATTACH_ABSORIGIN_FOLLOW, parent)
	ParticleManager:SetParticleShouldCheckFoW(self.spiritPfx, false)
	ParticleManager:SetParticleControlEnt(
		self.spiritPfx,
		0,
		parent,
		PATTACH_ABSORIGIN_FOLLOW,
		"attach_hitloc",
		self.origin,
		true
	)
	self:StartIntervalThink(SPIRIT_THINK_INTERVAL)
end
function modifier_elite_137_spirit_thinker.prototype.OnIntervalThink(self)
	if not IsServer() then
		return
	end
	local parent = self:GetParent()
	local caster = self:GetCaster()
	local ability = self:GetAbility()
	if not IsValidAlive(nil, parent) or not IsValidAlive(nil, caster) or not ability then
		self:Destroy()
		return
	end
	self:UpdateCountdownEffect(parent)
	if self:ShouldNaturalExplode() then
		self.hasTerminalExploded = true
		self:ExplodeAt(caster, ability, parent:GetAbsOrigin(), true)
		self:Destroy()
		return
	end
	if not self.landed then
		self:MoveToLanding(parent, caster)
		return
	end
	if not self.armed then
		self:ArmTrap(parent, caster)
		return
	end
	local target = self:GetLockedTarget(caster, parent:GetAbsOrigin())
	if not IsValidAlive(nil, target) then
		self:WanderOutward(parent, caster)
		return
	end
	local origin = parent:GetAbsOrigin()
	local targetOrigin = target:GetAbsOrigin()
	local toTarget = targetOrigin:__sub(origin)
	local distance = toTarget:Length2D()
	if distance <= SPIRIT_CATCH_RADIUS then
		self.hasTerminalExploded = true
		self:ExplodeAt(caster, ability, targetOrigin, false)
		ability:TriggerFeast(caster, target)
		self:Destroy()
		return
	end
	local stepDistance = math.min(distance, SPIRIT_CHASE_SPEED * SPIRIT_THINK_INTERVAL)
	local direction = Vector(toTarget.x, toTarget.y, 0):Normalized()
	local nextPoint = GetGroundPosition(origin:__add(direction:__mul(stepDistance)), caster)
	self:FaceMoveDirection(parent, direction)
	parent:SetAbsOrigin(nextPoint)
	self.origin = nextPoint
end
function modifier_elite_137_spirit_thinker.prototype.OnDestroy(self)
	if not IsServer() then
		return
	end
	self:StartIntervalThink(-1)
	self:TryNaturalExplode()
	self:DestroyCountdownEffect()
	self:DestroySpiritEffect()
	local parent = self:GetParent()
	if IsValid(nil, parent) and not parent:IsNull() then
		parent:RemoveSelf()
	end
end
function modifier_elite_137_spirit_thinker.prototype.CheckState(self)
	return {
		[MODIFIER_STATE_PROVIDES_VISION] = true,
		[MODIFIER_STATE_NO_UNIT_COLLISION] = true,
		[MODIFIER_STATE_INVULNERABLE] = true,
		[MODIFIER_STATE_NO_HEALTH_BAR] = true,
	}
end
function modifier_elite_137_spirit_thinker.prototype.IsHidden(self)
	return true
end
function modifier_elite_137_spirit_thinker.prototype.IsPurgable(self)
	return false
end
function modifier_elite_137_spirit_thinker.prototype.MoveToLanding(self, parent, caster)
	self.elapsed = self.elapsed + SPIRIT_THINK_INTERVAL
	local progress = math.min(self.elapsed / self.flyDuration, 1)
	local moveVector = self.landingPoint:__sub(self.startPoint)
	local nextPoint = self.startPoint:__add(moveVector:__mul(progress))
	if not IsValidAlive(nil, parent) then
		return
	end
	self:FaceMoveDirection(parent, moveVector)
	parent:SetAbsOrigin(nextPoint)
	self.origin = nextPoint
	if progress < 1 then
		return
	end
	local groundZ = GetGroundHeight(self.landingPoint, caster) or self.landingPoint.z
	self.origin = Vector(self.landingPoint.x, self.landingPoint.y, groundZ)
	parent:SetAbsOrigin(self.origin)
	self:DestroySpiritEffect()
	self.landed = true
	self.elapsed = 0
end
function modifier_elite_137_spirit_thinker.prototype.ArmTrap(self, parent, caster)
	if not IsValidAlive(nil, parent) or not IsValidAlive(nil, caster) then
		return
	end
	self.armElapsed = self.armElapsed + SPIRIT_THINK_INTERVAL
	if self.armElapsed < SPIRIT_ARM_DELAY then
		return
	end
	self.armed = true
	self:CreateSpiritEffect(parent)
	EmitSoundOnLocationWithCaster(parent:GetAbsOrigin(), SEEDLING_LAND_SOUND, caster)
end
function modifier_elite_137_spirit_thinker.prototype.WanderOutward(self, parent, caster)
	if not IsValidAlive(nil, parent) then
		return
	end
	local origin = parent:GetAbsOrigin()
	if self.wanderTarget == nil or self.wanderTarget:__sub(origin):Length2D() <= SPIRIT_WANDER_REACH_DISTANCE then
		self.wanderTarget = self:ChooseNextWanderTarget(origin, caster)
	end
	local toTarget = self.wanderTarget:__sub(origin)
	local distance = toTarget:Length2D()
	if distance <= 0.01 then
		return
	end
	local stepDistance = math.min(distance, SPIRIT_WANDER_SPEED * SPIRIT_THINK_INTERVAL)
	local direction = Vector(toTarget.x, toTarget.y, 0):Normalized()
	local nextPoint = GetGroundPosition(origin:__add(direction:__mul(stepDistance)), caster)
	self:FaceMoveDirection(parent, direction)
	parent:SetAbsOrigin(nextPoint)
	self.origin = nextPoint
end
function modifier_elite_137_spirit_thinker.prototype.ChooseNextWanderTarget(self, origin, caster)
	local fromCenter = origin:__sub(self.scatterCenter)
	local currentRadius = math.max(fromCenter:Length2D(), MIN_SCATTER_DISTANCE)
	local nextRadius = math.min(
		SPIRIT_WANDER_MAX_RADIUS,
		currentRadius + RandomFloat(SPIRIT_WANDER_OUTWARD_STEP_MIN, SPIRIT_WANDER_OUTWARD_STEP_MAX)
	)
	local baseDirection = self:GetOutwardDirection(fromCenter)
	do
		local attempt = 0
		while attempt < 8 do
			local direction = self:RotateDirection(
				baseDirection,
				RandomFloat(-SPIRIT_WANDER_SPREAD_DEGREES, SPIRIT_WANDER_SPREAD_DEGREES)
			)
			local currentPoint = self.scatterCenter:__add(direction:__mul(nextRadius))
			local groundPoint = GetGroundPosition(currentPoint, caster)
			if IsGridNavDisplacementWalkable(nil, groundPoint) then
				return groundPoint
			end
			attempt = attempt + 1
		end
	end
	return GetGroundPosition(self.scatterCenter:__add(baseDirection:__mul(nextRadius)), caster)
end
function modifier_elite_137_spirit_thinker.prototype.GetOutwardDirection(self, fromCenter)
	if fromCenter:Length2D() > 0.01 then
		return Vector(fromCenter.x, fromCenter.y, 0):Normalized()
	end
	return RandomVector(1)
end
function modifier_elite_137_spirit_thinker.prototype.RotateDirection(self, direction, degrees)
	local radians = degrees * math.pi / 180
	local cosValue = math.cos(radians)
	local sinValue = math.sin(radians)
	return Vector(direction.x * cosValue - direction.y * sinValue, direction.x * sinValue + direction.y * cosValue, 0):Normalized()
end
function modifier_elite_137_spirit_thinker.prototype.FaceMoveDirection(self, parent, direction)
	if direction:Length2D() <= 0.01 then
		return
	end
	if not IsValidAlive(nil, parent) then
		return
	end
	parent:SetForwardVector(Vector(direction.x, direction.y, 0):Normalized())
end
function modifier_elite_137_spirit_thinker.prototype.CreateSpiritEffect(self, parent)
	if self.spiritPfx ~= nil then
		return
	end
	if not IsValidAlive(nil, parent) then
		return
	end
	self.spiritPfx = ParticleManager:CreateParticle(SEEDLING_PROJECTILE_PARTICLE, PATTACH_ABSORIGIN_FOLLOW, parent)
	ParticleManager:SetParticleShouldCheckFoW(self.spiritPfx, false)
	ParticleManager:SetParticleControlEnt(
		self.spiritPfx,
		0,
		parent,
		PATTACH_ABSORIGIN_FOLLOW,
		"attach_hitloc",
		parent:GetAbsOrigin(),
		true
	)
	ParticleManager:SetParticleControl(
		self.spiritPfx,
		1,
		Vector(SPIRIT_DETECT_RADIUS, SPIRIT_DETECT_RADIUS, SPIRIT_DETECT_RADIUS)
	)
end
function modifier_elite_137_spirit_thinker.prototype.DestroySpiritEffect(self)
	if self.spiritPfx == nil then
		return
	end
	ParticleManager:DestroyParticle(self.spiritPfx, false)
	ParticleManager:ReleaseParticleIndex(self.spiritPfx)
	self.spiritPfx = nil
end
function modifier_elite_137_spirit_thinker.prototype.CreateCountdownEffect(self, parent)
	if self.countdownPfx ~= nil then
		return
	end
	if not IsValidAlive(nil, parent) then
		return
	end
	self.countdownPfx = ParticleManager:CreateParticle(COUNTDOWN_PARTICLE, PATTACH_WORLDORIGIN, nil)
	ParticleManager:SetParticleShouldCheckFoW(self.countdownPfx, false)
	ParticleManager:SetParticleControl(self.countdownPfx, 0, self:GetCountdownOrigin(parent))
	ParticleManager:SetParticleControl(self.countdownPfx, 1, self:GetCountdownDigits(SPIRIT_DURATION))
end
function modifier_elite_137_spirit_thinker.prototype.UpdateCountdownEffect(self, parent)
	if not IsValidAlive(nil, parent) then
		return
	end
	local remainingTime = math.max(self:GetRemainingTime(), 0)
	if remainingTime > COUNTDOWN_SHOW_DURATION then
		self:DestroyCountdownEffect()
		return
	end
	self:CreateCountdownEffect(parent)
	if self.countdownPfx == nil then
		return
	end
	local displaySeconds = math.min(remainingTime, SPIRIT_DURATION)
	ParticleManager:SetParticleControl(self.countdownPfx, 0, self:GetCountdownOrigin(parent))
	ParticleManager:SetParticleControl(self.countdownPfx, 1, self:GetCountdownDigits(displaySeconds))
end
function modifier_elite_137_spirit_thinker.prototype.GetCountdownOrigin(self, parent)
	return parent:GetAbsOrigin():__add(Vector(0, 0, COUNTDOWN_HEIGHT))
end
function modifier_elite_137_spirit_thinker.prototype.GetCountdownDigits(self, displaySeconds)
	local value = math.max(0, math.min(99, math.floor(displaySeconds)))
	local tens = math.floor(value / 10)
	local ones = value % 10
	return Vector(tens, ones, 0)
end
function modifier_elite_137_spirit_thinker.prototype.DestroyCountdownEffect(self)
	if self.countdownPfx == nil then
		return
	end
	ParticleManager:DestroyParticle(self.countdownPfx, false)
	ParticleManager:ReleaseParticleIndex(self.countdownPfx)
	self.countdownPfx = nil
end
function modifier_elite_137_spirit_thinker.prototype.TryNaturalExplode(self)
	if not self:ShouldNaturalExplode() then
		return
	end
	local parent = self:GetParent()
	local caster = self:GetCaster()
	local ability = self:GetAbility()
	if not IsValid(nil, parent) or parent:IsNull() or not IsValidAlive(nil, caster) or not ability then
		return
	end
	self.hasTerminalExploded = true
	self:ExplodeAt(caster, ability, parent:GetAbsOrigin(), true)
end
function modifier_elite_137_spirit_thinker.prototype.ShouldNaturalExplode(self)
	if self.hasTerminalExploded then
		return false
	end
	if not self.armed then
		return false
	end
	return self:GetRemainingTime() <= SPIRIT_THINK_INTERVAL * 2
end
function modifier_elite_137_spirit_thinker.prototype.ExplodeAt(self, caster, ability, center, rootEnemies)
	if not IsValidAlive(nil, caster) then
		return
	end
	local origin = GetGroundPosition(center, caster)
	self:PlayExplosionEffect(origin)
	local enemies = self:FindEnemiesInExplosion(caster, origin)
	for ____, enemy in ipairs(enemies) do
		caster:MonsterDamage({ victim = enemy, damage_rate = EXPLOSION_DAMAGE_RATE, ability = ability })
		if rootEnemies then
			ability:TriggerFeast(caster, enemy)
		end
	end
end
function modifier_elite_137_spirit_thinker.prototype.PlayExplosionEffect(self, origin)
	local pfx = ParticleManager:CreateParticle(EXPLOSION_PARTICLE, PATTACH_WORLDORIGIN, nil)
	ParticleManager:SetParticleShouldCheckFoW(pfx, false)
	ParticleManager:SetParticleControl(pfx, 1, origin)
	Timers:CreateTimer(EXPLOSION_PARTICLE_RELEASE_DELAY, function()
		ParticleManager:DestroyParticle(pfx, false)
		ParticleManager:ReleaseParticleIndex(pfx)
	end)
end
function modifier_elite_137_spirit_thinker.prototype.FindEnemiesInExplosion(self, caster, center)
	if not IsValidAlive(nil, caster) then
		return {}
	end
	return __TS__ArrayFilter(
		FindUnitsInRadius(caster:GetTeamNumber(), center, nil, SPIRIT_DETECT_RADIUS, 2, 19, 0, 0, false),
		function(____, enemy)
			return IsValidAlive(nil, enemy)
		end
	)
end
function modifier_elite_137_spirit_thinker.prototype.FindNearestEnemy(self, caster, center)
	if not IsValidAlive(nil, caster) then
		return
	end
	local enemies = FindUnitsInRadius(
		caster:GetTeamNumber(),
		center,
		nil,
		SPIRIT_DETECT_RADIUS,
		DOTA_UNIT_TARGET_TEAM_ENEMY,
		DOTA_UNIT_TARGET_HEROES_AND_CREEPS,
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
function modifier_elite_137_spirit_thinker.prototype.GetLockedTarget(self, caster, center)
	if IsValidAlive(nil, self.lockedTarget) then
		return self.lockedTarget
	end
	local target = self:FindNearestEnemy(caster, center)
	if not IsValidAlive(nil, target) then
		self.lockedTarget = nil
		self.isChasing = false
		return nil
	end
	self.lockedTarget = target
	self.isChasing = true
	EmitSoundOnLocationWithCaster(center, SPIRIT_ACTIVATE_SOUND, caster)
	return target
end
modifier_elite_137_spirit_thinker = __TS__DecorateLegacy(
	{ registerModifier(nil, "modifier_elite_137_spirit_thinker") },
	modifier_elite_137_spirit_thinker
)
modifier_elite_137_feast = __TS__Class()
modifier_elite_137_feast.name = "modifier_elite_137_feast"
__TS__ClassExtends(modifier_elite_137_feast, MonsterModifier_CS)
function modifier_elite_137_feast.prototype.____constructor(self, ...)
	MonsterModifier_CS.prototype.____constructor(self, ...)
	self.rootSoundElapsed = 0
end
function modifier_elite_137_feast.prototype.OnCreated(self)
	if not IsServer() then
		return
	end
	local parent = self:GetParent()
	self:CreatePlantEffect(parent)
	self:CreateRootEffect(parent)
	EmitSoundOn(ROOT_LOOP_SOUND, parent)
	self:StartIntervalThink(FEAST_DAMAGE_INTERVAL)
end
function modifier_elite_137_feast.prototype.OnIntervalThink(self)
	if not IsServer() then
		return
	end
	local caster = self:GetCaster()
	local parent = self:GetParent()
	local ability = self:GetAbility()
	if not IsValidAlive(nil, caster) or not IsValidAlive(nil, parent) or not ability then
		self:Destroy()
		return
	end
	self:UpdatePlantEffect(parent)
	self:TickRootLoopSound(parent)
	caster:MonsterDamage({ victim = parent, damage_rate = FEAST_DAMAGE_RATE, ability = ability })
end
function modifier_elite_137_feast.prototype.TickRootLoopSound(self, parent)
	self.rootSoundElapsed = self.rootSoundElapsed + FEAST_DAMAGE_INTERVAL
	if self.rootSoundElapsed < 1 then
		return
	end
	self.rootSoundElapsed = 0
	EmitSoundOn(ROOT_LOOP_SOUND, parent)
end
function modifier_elite_137_feast.prototype.OnDestroy(self)
	if not IsServer() then
		return
	end
	self:StartIntervalThink(-1)
end
function modifier_elite_137_feast.prototype.CheckState(self)
	return { [MODIFIER_STATE_ROOTED] = true, [MODIFIER_STATE_SILENCED] = true }
end
function modifier_elite_137_feast.prototype.IsHidden(self)
	return false
end
function modifier_elite_137_feast.prototype.IsDebuff(self)
	return true
end
function modifier_elite_137_feast.prototype.IsPurgable(self)
	return true
end
function modifier_elite_137_feast.prototype.CreatePlantEffect(self, parent)
	local origin = GetGroundPosition(parent:GetAbsOrigin(), parent)
	self.plantPfx = ParticleManager:CreateParticle(PLANT_PARTICLE, PATTACH_WORLDORIGIN, nil)
	ParticleManager:SetParticleShouldCheckFoW(self.plantPfx, false)
	ParticleManager:SetParticleControl(self.plantPfx, 0, origin)
	ParticleManager:SetParticleControl(self.plantPfx, 1, Vector(PLANT_RADIUS, 0, 0))
	ParticleManager:SetParticleControl(self.plantPfx, 3, origin)
	self:AddParticle(self.plantPfx, false, false, -1, false, false)
end
function modifier_elite_137_feast.prototype.CreateRootEffect(self, parent)
	local pfx = ParticleManager:CreateParticle(ROOT_PARTICLE, PATTACH_ABSORIGIN_FOLLOW, parent)
	ParticleManager:SetParticleControlEnt(
		pfx,
		0,
		parent,
		PATTACH_ABSORIGIN_FOLLOW,
		"attach_hitloc",
		parent:GetAbsOrigin(),
		true
	)
	self:AddParticle(pfx, false, false, -1, false, false)
end
function modifier_elite_137_feast.prototype.UpdatePlantEffect(self, parent)
	if self.plantPfx == nil then
		return
	end
	if not IsValidAlive(nil, parent) then
		return
	end
	local origin = GetGroundPosition(parent:GetAbsOrigin(), parent)
	ParticleManager:SetParticleControl(self.plantPfx, 0, origin)
	ParticleManager:SetParticleControl(self.plantPfx, 3, origin)
end
function modifier_elite_137_feast.GetLocalizationCN(self)
	return { name = "食人花撕咬", description = "被食人花定身并沉默，持续受到伤害。" }
end
modifier_elite_137_feast =
	__TS__DecorateLegacy({ registerModifier(nil, "modifier_elite_137_feast") }, modifier_elite_137_feast)
return ____exports