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
local Map = ____lualib.Map
local __TS__New = ____lualib.__TS__New
local __TS__ArrayFilter = ____lualib.__TS__ArrayFilter
local __TS__ArrayIndexOf = ____lualib.__TS__ArrayIndexOf
local ____exports = {}
local modifier_boss_pangolier_2_cast_stance
local ____dota_ts_adapter = require("utils.dota_ts_adapter")
local registerAbility = ____dota_ts_adapter.registerAbility
local registerModifier = ____dota_ts_adapter.registerModifier
local ____monster_base = require("abilities.monster.monster_base")
local MonsterAbility_CS = ____monster_base.MonsterAbility_CS
local MonsterModifier_CS = ____monster_base.MonsterModifier_CS
local CAST_POINT = 1
local SKILL_DURATION = 4
local MINE_COUNT = 4
local MINE_SPAWN_RADIUS = 220
local MINE_DIRECTION_WARNING_DISTANCE = 320
local MINE_DIRECTION_WARNING_WIDTH = 48
local MINE_ROLL_MAX_DURATION = 6
local MINE_FINAL_SURVIVOR_LIMIT = 2
local MINE_FINAL_SURVIVOR_WINDOW = 1
local MINE_ROLL_SPEED = 859.248
local MINE_HIT_RADIUS = 180
local MINE_HIT_DAMAGE_RATE = 10
local MINE_HIT_COOLDOWN = 0.8
local MINE_KNOCKBACK_DISTANCE = 280
local MINE_KNOCKBACK_DURATION = 0.25
local MINE_KNOCKBACK_HEIGHT = 60
local SHIELD_CRASH_WARNING_RADIUS = 330
local SHIELD_CRASH_DAMAGE_RADIUS_RATIO = 0.95
local SHIELD_CRASH_DAMAGE_RATE = 12
local SHIELD_CRASH_FIRST_DELAY = 1
local SHIELD_CRASH_FIRST_RANDOM_DELAY_MIN = 0.2
local SHIELD_CRASH_FIRST_RANDOM_DELAY_MAX = 1.4
local SHIELD_CRASH_FINAL_ACCEL_START_TIME = 3.5
local SHIELD_CRASH_FINAL_MAX_FREQUENCY_MULTIPLIER = 32
local SHIELD_CRASH_RHYTHM_MIN_COUNT = 3
local SHIELD_CRASH_RHYTHM_MAX_COUNT = 7
local SHIELD_CRASH_JUMP_HEIGHT = 216
local SHIELD_CRASH_JUMP_ASCEND_DURATION = 0.2856
local SHIELD_CRASH_JUMP_DESCEND_DURATION = 0.3
local SHIELD_CRASH_JUMP_DURATION = SHIELD_CRASH_JUMP_ASCEND_DURATION + SHIELD_CRASH_JUMP_DESCEND_DURATION
local SHIELD_CRASH_MIN_JUMP_DURATION_MULTIPLIER = 0.9
local THINK_INTERVAL = 0.03
local BOUNCE_RANDOM_ANGLE = 65
local ROLL_VISUAL_Z_OFFSET = 77
local ROLL_VISUAL_RADIUS = 88
local ROLL_VISUAL_SPIN_RATE = 2.16
local ROLL_PARTICLE_CENTER_Z_OFFSET = 0
local ROLL_MODEL = "models/heroes/pangolier/pangolier_gyroshell2.vmdl"
local ROLL_MODEL_SCALE = 1.314
local ROLL_FINAL_GROWTH_START_TIME = SHIELD_CRASH_FINAL_ACCEL_START_TIME - 2
local ROLL_FINAL_MAX_GROWTH_SCALE = 1.008
local ROLL_WANDER_MIN_INTERVAL = 0.18
local ROLL_WANDER_MAX_INTERVAL = 0.42
local ROLL_WANDER_ANGLE = 28
local ROLL_TRAIL_PARTICLE = "particles/units/heroes/hero_pangolier/pangolier_gyroshell.vpcf"
local ROLL_START_PARTICLE = "particles/units/heroes/hero_centaur/centaur_warstomp.vpcf"
local BOSS_TRANSITION_PARTICLE = ROLL_START_PARTICLE
local ROLL_STATUS_PARTICLE = "particles/status_fx/status_effect_pangolier_gyroshell.vpcf"
local ROLL_TRAIL_CHILD_PARTICLES = {
	"particles/units/heroes/hero_pangolier/pangolier_gyroshell_dirt_decal.vpcf",
	"particles/units/heroes/hero_pangolier/pangolier_gyroshell_ground_decal.vpcf",
	"particles/units/heroes/hero_pangolier/pangolier_gyroshell_swirl.vpcf",
	"particles/units/heroes/hero_pangolier/pangolier_gyroshell_immunity.vpcf",
	"particles/units/heroes/hero_pangolier/pangolier_gyroshell_dustoff.vpcf",
	"particles/units/heroes/hero_pangolier/pangolier_gyroshell_rocks_trail.vpcf",
	"particles/units/heroes/hero_pangolier/pangolier_gyroshell_rocks_front.vpcf",
	"particles/units/heroes/hero_pangolier/pangolier_gyroshell_ground_streaks.vpcf",
	"particles/units/heroes/hero_pangolier/pangolier_gyroshell_endcap.vpcf",
}
local SHIELD_CRASH_RING_PARTICLE = "particles/econ/items/centaur/centaur_ti6/centaur_ti6_warstomp.vpcf"
local SHIELD_CRASH_DUST_PARTICLE = "particles/units/heroes/hero_dawnbreaker/dawnbreaker_elated_fury_landing_dust.vpcf"
local SHIELD_CRASH_CORE_PARTICLE = "particles/units/heroes/hero_primal_beast/primal_beast_onslaught_impact.vpcf"
local ROLL_SOUND_EVENTS = "soundevents/game_sounds_heroes/game_sounds_earth_spirit.vsndevts"
local SHIELD_CRASH_SOUND_EVENTS = "soundevents/game_sounds_heroes/game_sounds_centaur.vsndevts"
local ROLL_START_SOUND = "Hero_EarthSpirit.RollingBoulder.Cast"
local ROLL_LOOP_SOUND = "Hero_EarthSpirit.RollingBoulder.Loop"
local ROLL_HIT_SOUND = "Hero_EarthSpirit.RollingBoulder.Target"
local SHIELD_CRASH_SOUND = "Hero_Centaur.HoofStomp"
local activeRollMines = {}
local function getGroundPosition(self, pos, context)
	return GetGroundPosition(pos, context)
end
local function getRollVisualPosition(self, pos, context)
	local ground = getGroundPosition(nil, pos, context)
	return Vector(ground.x, ground.y, ground.z + ROLL_VISUAL_Z_OFFSET)
end
local function getRollParticleCenter(self, pos, context)
	local ground = getGroundPosition(nil, pos, context)
	return Vector(ground.x, ground.y, ground.z + ROLL_PARTICLE_CENTER_Z_OFFSET)
end
local function getRandomHorizontalDirection(self, index)
	local baseAngle = 360 / MINE_COUNT * index
	local angle = baseAngle + RandomFloat(-18, 18)
	return RotateVector2D(nil, Vector(1, 0, 0), angle):Normalized()
end
local function shouldBounceRollMine(self, from, to)
	if from:__sub(to):Length2D() <= 1 then
		return false
	end
	return GridNav:IsTraversable(from)
		and (not GridNav:IsTraversable(to) or GridNav:IsBlocked(to) or not GridNav:CanFindPath(from, to))
end
local function getRollMineSpawnInfo(self, caster, index)
	local origin = getGroundPosition(nil, caster:GetAbsOrigin(), caster)
	local direction = getRandomHorizontalDirection(nil, index)
	local startGroundPos = getGroundPosition(nil, origin:__add(direction:__mul(MINE_SPAWN_RADIUS)), caster)
	return {
		direction = direction,
		position = startGroundPos,
		speedScale = RandomFloat(0.82, 1.18),
	}
end
local function createRollMine(self, caster, ability, index, spawnInfo)
	local info = spawnInfo or getRollMineSpawnInfo(nil, caster, index)
	CreateModifierThinker(caster, ability, "modifier_boss_pangolier_2_roll_mine", {
		duration = -1,
		dir_x = info.direction.x,
		dir_y = info.direction.y,
		pos_x = info.position.x,
		pos_y = info.position.y,
		pos_z = info.position.z,
		speed_scale = info.speedScale,
	}, getRollVisualPosition(nil, info.position, caster), caster:GetTeamNumber(), false)
end
--- 滚滚技能2 - 原地举剑，向周围释放会反弹的地雷滚滚，并随机触发甲盾冲击。
____exports.boss_pangolier_2 = __TS__Class()
local boss_pangolier_2 = ____exports.boss_pangolier_2
boss_pangolier_2.name = "boss_pangolier_2"
__TS__ClassExtends(boss_pangolier_2, MonsterAbility_CS)
function boss_pangolier_2.prototype.____constructor(self, ...)
	MonsterAbility_CS.prototype.____constructor(self, ...)
	self.lockedMineSpawns = {}
end
function boss_pangolier_2.prototype.Precache(self, context)
	PrecacheResource("model", ROLL_MODEL, context)
	PrecacheResource("particle", ROLL_TRAIL_PARTICLE, context)
	PrecacheResource("particle", ROLL_START_PARTICLE, context)
	PrecacheResource("particle", ROLL_STATUS_PARTICLE, context)
	for ____, particle in ipairs(ROLL_TRAIL_CHILD_PARTICLES) do
		PrecacheResource("particle", particle, context)
	end
	PrecacheResource("particle", SHIELD_CRASH_RING_PARTICLE, context)
	PrecacheResource("particle", SHIELD_CRASH_DUST_PARTICLE, context)
	PrecacheResource("particle", SHIELD_CRASH_CORE_PARTICLE, context)
	PrecacheResource("soundfile", ROLL_SOUND_EVENTS, context)
	PrecacheResource("soundfile", SHIELD_CRASH_SOUND_EVENTS, context)
end
function boss_pangolier_2.prototype.GetMosnterAbilityConfig(self)
	return {
		castRange = 1000,
		castPoint = CAST_POINT,
		castDuration = SKILL_DURATION,
		behavior = DOTA_ABILITY_BEHAVIOR_NO_TARGET,
		isNotMove = true,
		castAnimation = ACT_DOTA_CAST_ABILITY_4,
		OnPhaseStart = function()
			local caster = self:GetCaster()
			if not IsValidAlive(nil, caster) then
				return
			end
			self.lockedMineSpawns = {}
			caster:StartGestureWithPlaybackRate(ACT_DOTA_CAST_ABILITY_4, 0.45)
			do
				local i = 0
				while i < MINE_COUNT do
					local spawnInfo = getRollMineSpawnInfo(nil, caster, i)
					local ____self_lockedMineSpawns_0 = self.lockedMineSpawns
					____self_lockedMineSpawns_0[#____self_lockedMineSpawns_0 + 1] = spawnInfo
					local warningEnd = getGroundPosition(
						nil,
						spawnInfo.position:__add(spawnInfo.direction:__mul(MINE_DIRECTION_WARNING_DISTANCE)),
						caster
					)
					self:WarningEffect(
						spawnInfo.position,
						warningEnd,
						CAST_POINT,
						{ startWidth = MINE_DIRECTION_WARNING_WIDTH, endWidth = MINE_DIRECTION_WARNING_WIDTH }
					)
					i = i + 1
				end
			end
		end,
		OnStart = function()
			local caster = self:GetCaster()
			if not IsValidAlive(nil, caster) then
				return
			end
			caster:RemoveGesture(ACT_DOTA_CAST_ABILITY_4)
			caster:StartGestureWithPlaybackRate(ACT_DOTA_CAST_ABILITY_2, 1.1)
			modifier_boss_pangolier_2_cast_stance:applys(caster, caster, self, { duration = SKILL_DURATION })
			self:PlayRollStartEffect(caster)
			EmitSoundOn(ROLL_START_SOUND, caster)
			caster:ClearDebuffs()
			do
				local i = 0
				while i < MINE_COUNT do
					createRollMine(nil, caster, self, i, self.lockedMineSpawns[i + 1])
					i = i + 1
				end
			end
			self.lockedMineSpawns = {}
		end,
		OnFinish = function()
			local caster = self:GetCaster()
			if IsValidAlive(nil, caster) then
				caster:RemoveModifierByName("modifier_boss_pangolier_2_cast_stance")
			end
			self.lockedMineSpawns = {}
		end,
		OnInterrupt = function()
			local caster = self:GetCaster()
			if IsValidAlive(nil, caster) then
				caster:RemoveGesture(ACT_DOTA_CAST_ABILITY_4)
			end
			self.lockedMineSpawns = {}
		end,
	}
end
function boss_pangolier_2.prototype.PlayRollStartEffect(self, caster)
	local origin = caster:GetAbsOrigin()
	local pfx = ParticleManager:CreateParticle(ROLL_START_PARTICLE, PATTACH_WORLDORIGIN, nil)
	ParticleManager:SetParticleControl(pfx, 0, origin)
	ParticleManager:SetParticleControl(
		pfx,
		1,
		Vector(MINE_SPAWN_RADIUS * 2, MINE_SPAWN_RADIUS * 2, MINE_SPAWN_RADIUS * 2)
	)
	ParticleManager:ReleaseParticleIndex(pfx)
end
boss_pangolier_2 = __TS__DecorateLegacy({ registerAbility(nil) }, boss_pangolier_2)
____exports.boss_pangolier_2 = boss_pangolier_2
modifier_boss_pangolier_2_cast_stance = __TS__Class()
modifier_boss_pangolier_2_cast_stance.name = "modifier_boss_pangolier_2_cast_stance"
__TS__ClassExtends(modifier_boss_pangolier_2_cast_stance, MonsterModifier_CS)
function modifier_boss_pangolier_2_cast_stance.prototype.OnCreated(self)
	if not IsServer() then
		return
	end
	local parent = self:GetParent()
	if IsValid(nil, parent) and not parent:IsNull() then
		self:PlayTransitionEffect(parent)
		parent:AddNoDrawWithWearables()
	end
end
function modifier_boss_pangolier_2_cast_stance.prototype.OnDestroy(self)
	if not IsServer() then
		return
	end
	local parent = self:GetParent()
	if IsValid(nil, parent) and not parent:IsNull() then
		self:PlayTransitionEffect(parent)
		parent:RemoveNoDrawWithWearables()
	end
end
function modifier_boss_pangolier_2_cast_stance.prototype.PlayTransitionEffect(self, parent)
	local origin = parent:GetAbsOrigin()
	local pfx = ParticleManager:CreateParticle(BOSS_TRANSITION_PARTICLE, PATTACH_WORLDORIGIN, nil)
	ParticleManager:SetParticleControl(pfx, 0, origin)
	ParticleManager:SetParticleControl(pfx, 1, Vector(260, 260, 260))
	ParticleManager:ReleaseParticleIndex(pfx)
end
function modifier_boss_pangolier_2_cast_stance.prototype.DeclareFunctions(self)
	return { MODIFIER_PROPERTY_OVERRIDE_ANIMATION, MODIFIER_PROPERTY_OVERRIDE_ANIMATION_RATE }
end
function modifier_boss_pangolier_2_cast_stance.prototype.GetOverrideAnimation(self)
	return ACT_DOTA_CAST_ABILITY_2
end
function modifier_boss_pangolier_2_cast_stance.prototype.GetOverrideAnimationRate(self)
	return 0.55
end
function modifier_boss_pangolier_2_cast_stance.prototype.CheckState(self)
	return {
		[MODIFIER_STATE_INVULNERABLE] = true,
		[MODIFIER_STATE_COMMAND_RESTRICTED] = true,
		[MODIFIER_STATE_DISARMED] = true,
	}
end
function modifier_boss_pangolier_2_cast_stance.prototype.IsHidden(self)
	return true
end
modifier_boss_pangolier_2_cast_stance =
	__TS__DecorateLegacy({ registerModifier(nil) }, modifier_boss_pangolier_2_cast_stance)
local modifier_boss_pangolier_2_roll_mine = __TS__Class()
modifier_boss_pangolier_2_roll_mine.name = "modifier_boss_pangolier_2_roll_mine"
__TS__ClassExtends(modifier_boss_pangolier_2_roll_mine, MonsterModifier_CS)
function modifier_boss_pangolier_2_roll_mine.prototype.____constructor(self, ...)
	MonsterModifier_CS.prototype.____constructor(self, ...)
	self.direction = Vector(1, 0, 0)
	self.speedScale = 1
	self.rollAngle = 0
	self.nextWanderTime = 0
	self.isShieldCrashing = false
	self.shieldCrashStartTime = 0
	self.shieldCrashLandTime = 0
	self.shieldCrashJumpDurationScale = 1
	self.nextShieldCrashTime = 0
	self.shieldCrashCount = 0
	self.shieldCrashRhythmCount = SHIELD_CRASH_RHYTHM_MAX_COUNT
	self.shieldCrashTimeScale = 1
	self.shieldCrashWarningShown = false
	self.destroyAfterShieldCrash = false
	self.hitCooldowns = __TS__New(Map)
end
function modifier_boss_pangolier_2_roll_mine.prototype.CheckState(self)
	return {
		[MODIFIER_STATE_NO_UNIT_COLLISION] = true,
		[MODIFIER_STATE_INVULNERABLE] = true,
		[MODIFIER_STATE_NO_HEALTH_BAR] = true,
		[MODIFIER_STATE_UNSELECTABLE] = true,
		[MODIFIER_STATE_COMMAND_RESTRICTED] = true,
		[MODIFIER_STATE_DISARMED] = true,
	}
end
function modifier_boss_pangolier_2_roll_mine.prototype.OnCreated(self, params)
	if not IsServer() then
		return
	end
	local parent = self:GetParent()
	if not IsValidAlive(nil, parent) then
		self:Destroy()
		return
	end
	self.direction = Vector(params.dir_x or 1, params.dir_y or 0, 0):Normalized()
	self.groundPosition = Vector(
		params.pos_x or parent:GetAbsOrigin().x,
		params.pos_y or parent:GetAbsOrigin().y,
		params.pos_z or parent:GetAbsOrigin().z
	)
	self.speedScale = params.speed_scale or 1
	self.shieldCrashRhythmCount = RandomInt(SHIELD_CRASH_RHYTHM_MIN_COUNT, SHIELD_CRASH_RHYTHM_MAX_COUNT)
	self.shieldCrashDisappearCount = self:GetRandomShieldCrashDisappearCount()
	self.shieldCrashTimeScale = RandomFloat(0.88, 1.18)
	self.nextWanderTime = RandomFloat(ROLL_WANDER_MIN_INTERVAL, ROLL_WANDER_MAX_INTERVAL)
	parent:SetMoveCapability(DOTA_UNIT_CAP_MOVE_NONE)
	parent:SetAttackCapability(DOTA_UNIT_CAP_NO_ATTACK)
	parent:RemoveModifierByName("boss_ai")
	parent:RemoveModifierByName("collision_effect")
	parent:SetAbsOrigin(getRollVisualPosition(nil, self.groundPosition, parent))
	self.nextShieldCrashTime = SHIELD_CRASH_FIRST_DELAY
		+ RandomFloat(SHIELD_CRASH_FIRST_RANDOM_DELAY_MIN, SHIELD_CRASH_FIRST_RANDOM_DELAY_MAX)
	self:CreateRollModel(parent)
	self:CreateRollTrail(parent)
	self:ApplyRollOrientation(parent)
	activeRollMines[#activeRollMines + 1] = self
	EmitSoundOn(ROLL_LOOP_SOUND, parent)
	self:StartIntervalThink(THINK_INTERVAL)
end
function modifier_boss_pangolier_2_roll_mine.prototype.OnIntervalThink(self)
	if not IsServer() then
		return
	end
	local caster = self:GetCaster()
	local ability = self:GetAbility()
	local parent = self:GetParent()
	if not IsValidAlive(nil, caster) or not ability or not IsValid(nil, parent) or parent:IsNull() then
		self:Destroy()
		return
	end
	if self:ShouldDestroyForFinalSurvivorLimit() then
		self.destroyAfterShieldCrash = true
		if not self.isShieldCrashing then
			self:StartShieldCrash(parent)
		end
	end
	if not self.isShieldCrashing and self:GetElapsedTime() >= MINE_ROLL_MAX_DURATION then
		self.destroyAfterShieldCrash = true
		self:StartShieldCrash(parent)
		return
	end
	if not self.isShieldCrashing and self:GetElapsedTime() >= self.nextShieldCrashTime then
		self:StartShieldCrash(parent)
	end
	self:MoveMine(parent)
	self:HitEnemies(parent, caster, ability)
	self:ShowShieldCrashWarning(parent)
	if self.isShieldCrashing and self:GetElapsedTime() >= self.shieldCrashLandTime then
		self:FinishShieldCrash(parent, caster, ability)
	end
end
function modifier_boss_pangolier_2_roll_mine.prototype.OnDestroy(self)
	if not IsServer() then
		return
	end
	self:StartIntervalThink(-1)
	local parent = self:GetParent()
	activeRollMines = __TS__ArrayFilter(activeRollMines, function(____, modifier)
		return modifier ~= self
	end)
	self:DestroyRollTrail()
	if IsValid(nil, parent) and not parent:IsNull() then
		StopSoundOn(ROLL_LOOP_SOUND, parent)
	end
	if IsValid(nil, parent) and not parent:IsNull() then
		parent:RemoveSelf()
	end
end
function modifier_boss_pangolier_2_roll_mine.prototype.CreateRollModel(self, parent)
	parent:SetOriginalModel(ROLL_MODEL)
	parent:SetModel(ROLL_MODEL)
	parent:SetModelScale(ROLL_MODEL_SCALE)
	parent:StartGestureWithPlaybackRate(ACT_DOTA_CAST_ABILITY_4, 1.25)
end
function modifier_boss_pangolier_2_roll_mine.prototype.CreateRollTrail(self, parent)
	local pfx = ParticleManager:CreateParticle(ROLL_TRAIL_PARTICLE, PATTACH_CUSTOMORIGIN, nil)
	self.rollTrailParticle = pfx
	ParticleManager:SetParticleShouldCheckFoW(pfx, false)
	self:UpdateRollTrail(parent)
end
function modifier_boss_pangolier_2_roll_mine.prototype.DestroyRollTrail(self)
	if self.rollTrailParticle == nil then
		return
	end
	ParticleManager:DestroyParticle(self.rollTrailParticle, true)
	ParticleManager:ReleaseParticleIndex(self.rollTrailParticle)
	self.rollTrailParticle = nil
end
function modifier_boss_pangolier_2_roll_mine.prototype.UpdateRollTrail(self, parent)
	if self.rollTrailParticle == nil then
		return
	end
	if not IsValidAlive(nil, parent) then
		return
	end
	local origin = self.groundPosition or getGroundPosition(nil, parent:GetAbsOrigin(), parent)
	local particleCenter =
		getRollParticleCenter(nil, origin, parent):__add(Vector(0, 0, self:GetShieldCrashJumpOffset()))
	local growthScale = self:GetFinalGrowthScale()
	ParticleManager:SetParticleControlTransformForward(self.rollTrailParticle, 0, particleCenter, self.direction)
	ParticleManager:SetParticleControl(self.rollTrailParticle, 1, particleCenter)
	ParticleManager:SetParticleControl(
		self.rollTrailParticle,
		2,
		Vector(ROLL_MODEL_SCALE * growthScale, ROLL_MODEL_SCALE * growthScale, ROLL_MODEL_SCALE * growthScale)
	)
	ParticleManager:SetParticleControl(self.rollTrailParticle, 3, particleCenter)
	ParticleManager:SetParticleControlForward(self.rollTrailParticle, 4, self.direction)
	ParticleManager:SetParticleControl(self.rollTrailParticle, 10, Vector(MINE_ROLL_SPEED * self.speedScale, 0, 0))
end
function modifier_boss_pangolier_2_roll_mine.prototype.UpdateRollModelScale(self, parent)
	if not IsValidAlive(nil, parent) then
		return
	end
	parent:SetModelScale(ROLL_MODEL_SCALE * self:GetFinalGrowthScale())
end
function modifier_boss_pangolier_2_roll_mine.prototype.ApplyRollOrientation(self, parent)
	local yaw = VectorToAngles(self.direction).y
	if not IsValidAlive(nil, parent) then
		return
	end
	parent:SetAbsAngles(self.rollAngle, yaw, 0)
end
function modifier_boss_pangolier_2_roll_mine.prototype.MoveMine(self, parent)
	if not IsValidAlive(nil, parent) then
		return
	end
	local origin = self.groundPosition or getGroundPosition(nil, parent:GetAbsOrigin(), parent)
	self:UpdateWanderDirection(parent)
	local step = self.direction:__mul(MINE_ROLL_SPEED * self.speedScale * THINK_INTERVAL)
	local next = getGroundPosition(nil, origin:__add(step), parent)
	if shouldBounceRollMine(nil, origin, next) then
		self.direction = RotateVector2D(
			nil,
			self.direction:__mul(-1),
			RandomFloat(-BOUNCE_RANDOM_ANGLE, BOUNCE_RANDOM_ANGLE)
		):Normalized()
		self:ApplyRollOrientation(parent)
		self:UpdateRollTrail(parent)
		return
	end
	self.groundPosition = next
	local movedDistance = origin:__sub(next):Length2D()
	self.rollAngle = (self.rollAngle + movedDistance / ROLL_VISUAL_RADIUS * 57.2958 * ROLL_VISUAL_SPIN_RATE) % 360
	parent:SetAbsOrigin(self:GetCurrentVisualPosition(next, parent))
	self:UpdateRollModelScale(parent)
	self:ApplyRollOrientation(parent)
	self:UpdateRollTrail(parent)
	GridNav:DestroyTreesAroundPoint(next, 80, false)
end
function modifier_boss_pangolier_2_roll_mine.prototype.UpdateWanderDirection(self, parent)
	if self:GetElapsedTime() < self.nextWanderTime then
		return
	end
	self.nextWanderTime = self:GetElapsedTime() + RandomFloat(ROLL_WANDER_MIN_INTERVAL, ROLL_WANDER_MAX_INTERVAL)
	self.direction =
		RotateVector2D(nil, self.direction, RandomFloat(-ROLL_WANDER_ANGLE, ROLL_WANDER_ANGLE)):Normalized()
	self:ApplyRollOrientation(parent)
	self:UpdateRollTrail(parent)
end
function modifier_boss_pangolier_2_roll_mine.prototype.HitEnemies(self, parent, caster, ability)
	local now = GameRules:GetGameTime()
	if not IsValidAlive(nil, caster) then
		return
	end
	if not IsValidAlive(nil, parent) then
		return
	end
	local enemies = FindUnitsInRadius(
		caster:GetTeamNumber(),
		parent:GetAbsOrigin(),
		nil,
		MINE_HIT_RADIUS,
		DOTA_UNIT_TARGET_TEAM_ENEMY,
		DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,
		DOTA_UNIT_TARGET_FLAG_NONE,
		FIND_ANY_ORDER,
		false
	)
	for ____, enemy in ipairs(enemies) do
		do
			if not IsValidAlive(nil, enemy) then
				goto __continue73
			end
			local index = enemy:GetEntityIndex()
			local nextHitTime = self.hitCooldowns:get(index) or 0
			if nextHitTime > now then
				goto __continue73
			end
			self.hitCooldowns:set(index, now + MINE_HIT_COOLDOWN)
			caster:MonsterDamage({
				victim = enemy,
				damage_rate = MINE_HIT_DAMAGE_RATE,
				ability = ability,
				damage_type = 2,
			})
			local knockDirection = GetDirection(nil, enemy:GetAbsOrigin(), parent:GetAbsOrigin())
			enemy:KnockBack(caster, ability, {
				duration = MINE_KNOCKBACK_DURATION,
				distance = MINE_KNOCKBACK_DISTANCE,
				height = MINE_KNOCKBACK_HEIGHT,
				direction = knockDirection,
				particleName = "",
			})
			EmitSoundOn(ROLL_HIT_SOUND, enemy)
		end
		::__continue73::
	end
end
function modifier_boss_pangolier_2_roll_mine.prototype.GetStatusEffectName(self)
	return ROLL_STATUS_PARTICLE
end
function modifier_boss_pangolier_2_roll_mine.prototype.StatusEffectPriority(self)
	return MODIFIER_PRIORITY_NORMAL
end
function modifier_boss_pangolier_2_roll_mine.prototype.StartShieldCrash(self, parent)
	if not IsValidAlive(nil, parent) then
		return
	end
	self.isShieldCrashing = true
	self.shieldCrashStartTime = self:GetElapsedTime()
	self.shieldCrashJumpDurationScale = self:GetShieldCrashJumpDurationScale()
	self.shieldCrashLandTime = self.shieldCrashStartTime
		+ SHIELD_CRASH_JUMP_DURATION * self.shieldCrashJumpDurationScale
	self.shieldCrashWarningShown = false
	local groundPos = self.groundPosition or getGroundPosition(nil, parent:GetAbsOrigin(), parent)
	parent:SetAbsOrigin(self:GetCurrentVisualPosition(groundPos, parent))
	self:ShowShieldCrashWarning(parent)
	self:UpdateRollTrail(parent)
end
function modifier_boss_pangolier_2_roll_mine.prototype.FinishShieldCrash(self, parent, caster, ability)
	if not IsValidAlive(nil, parent) then
		return
	end
	local groundPos = self.groundPosition or getGroundPosition(nil, parent:GetAbsOrigin(), parent)
	parent:SetAbsOrigin(getRollVisualPosition(nil, groundPos, parent))
	self:ApplyRollOrientation(parent)
	self:UpdateRollTrail(parent)
	self:PlayEffectsCrash(groundPos, caster, ability)
	self.shieldCrashCount = self.shieldCrashCount + 1
	if self:ShouldDestroyAfterShieldCrash() then
		self:Destroy()
		return
	end
	self.isShieldCrashing = false
	self:ScheduleNextShieldCrash()
end
function modifier_boss_pangolier_2_roll_mine.prototype.ScheduleNextShieldCrash(self, extraDelay)
	if extraDelay == nil then
		extraDelay = 0
	end
	local window = self:GetShieldCrashDelayWindow()
	self.nextShieldCrashTime = self:GetElapsedTime()
		+ extraDelay
		+ RandomFloat(window[1], window[2]) * self.shieldCrashTimeScale
end
function modifier_boss_pangolier_2_roll_mine.prototype.GetRandomShieldCrashDisappearCount(self)
	local roll = RandomFloat(0, 1)
	if roll < 0.45 then
		return 3
	end
	if roll < 0.72 then
		return RandomInt(4, 5)
	end
	if roll < 0.9 then
		return RandomInt(6, 7)
	end
	return nil
end
function modifier_boss_pangolier_2_roll_mine.prototype.ShouldDestroyAfterShieldCrash(self)
	if self.destroyAfterShieldCrash then
		return true
	end
	if self:GetElapsedTime() >= MINE_ROLL_MAX_DURATION then
		return true
	end
	return self.shieldCrashDisappearCount ~= nil and self.shieldCrashCount >= self.shieldCrashDisappearCount
end
function modifier_boss_pangolier_2_roll_mine.prototype.ShouldDestroyForFinalSurvivorLimit(self)
	local finalWindowStartTime = MINE_ROLL_MAX_DURATION - MINE_FINAL_SURVIVOR_WINDOW
	if self:GetElapsedTime() < finalWindowStartTime then
		return false
	end
	activeRollMines = __TS__ArrayFilter(activeRollMines, function(____, modifier)
		local parent = modifier:GetParent()
		return IsValid(nil, parent) and not parent:IsNull()
	end)
	local finalSurvivors = __TS__ArrayFilter(activeRollMines, function(____, modifier)
		return modifier:GetElapsedTime() >= finalWindowStartTime
	end)
	return __TS__ArrayIndexOf(finalSurvivors, self) >= MINE_FINAL_SURVIVOR_LIMIT
end
function modifier_boss_pangolier_2_roll_mine.prototype.GetShieldCrashDelayWindow(self)
	local countFactor = (self.shieldCrashRhythmCount - SHIELD_CRASH_RHYTHM_MIN_COUNT)
		/ (SHIELD_CRASH_RHYTHM_MAX_COUNT - SHIELD_CRASH_RHYTHM_MIN_COUNT)
	local baseMinDelay = 1.9 - countFactor * 0.55
	local baseMaxDelay = 2.65 - countFactor * 0.75
	local finalAccelSeconds = math.max(0, self:GetElapsedTime() - SHIELD_CRASH_FINAL_ACCEL_START_TIME)
	local frequencyMultiplier =
		math.min(SHIELD_CRASH_FINAL_MAX_FREQUENCY_MULTIPLIER, math.pow(2, math.floor(finalAccelSeconds)))
	local minDelay = baseMinDelay / frequencyMultiplier
	local maxDelay = baseMaxDelay / frequencyMultiplier
	return { minDelay, maxDelay }
end
function modifier_boss_pangolier_2_roll_mine.prototype.GetFinalAccelProgress(self)
	return math.min(
		1,
		math.max(
			0,
			(self:GetElapsedTime() - SHIELD_CRASH_FINAL_ACCEL_START_TIME)
				/ (MINE_ROLL_MAX_DURATION - SHIELD_CRASH_FINAL_ACCEL_START_TIME)
		)
	)
end
function modifier_boss_pangolier_2_roll_mine.prototype.GetFinalGrowthScale(self)
	local progress = math.min(
		1,
		math.max(
			0,
			(self:GetElapsedTime() - ROLL_FINAL_GROWTH_START_TIME)
				/ (MINE_ROLL_MAX_DURATION - ROLL_FINAL_GROWTH_START_TIME)
		)
	)
	return 1 + (ROLL_FINAL_MAX_GROWTH_SCALE - 1) * progress
end
function modifier_boss_pangolier_2_roll_mine.prototype.GetShieldCrashWarningRadius(self)
	return SHIELD_CRASH_WARNING_RADIUS * self:GetFinalGrowthScale()
end
function modifier_boss_pangolier_2_roll_mine.prototype.GetShieldCrashDamageRadius(self)
	return self:GetShieldCrashWarningRadius() * SHIELD_CRASH_DAMAGE_RADIUS_RATIO
end
function modifier_boss_pangolier_2_roll_mine.prototype.GetShieldCrashJumpDurationScale(self)
	return 1 - (1 - SHIELD_CRASH_MIN_JUMP_DURATION_MULTIPLIER) * self:GetFinalAccelProgress()
end
function modifier_boss_pangolier_2_roll_mine.prototype.ShowShieldCrashWarning(self, parent)
	if not self.isShieldCrashing or self.shieldCrashWarningShown then
		return
	end
	if not IsValidAlive(nil, parent) then
		return
	end
	self.shieldCrashWarningShown = true
	local groundPos = self.groundPosition or getGroundPosition(nil, parent:GetAbsOrigin(), parent)
	local remaining = math.max(0.1, self.shieldCrashLandTime - self:GetElapsedTime())
	local predicted = getGroundPosition(
		nil,
		groundPos:__add(self.direction:__mul(MINE_ROLL_SPEED * self.speedScale * remaining)),
		parent
	)
	self:WarningRingEffect(predicted, self:GetShieldCrashDamageRadius(), remaining, { speed = 0 })
end
function modifier_boss_pangolier_2_roll_mine.prototype.GetCurrentVisualPosition(self, groundPos, parent)
	local visual = getRollVisualPosition(nil, groundPos, parent)
	local offset = self:GetShieldCrashJumpOffset()
	return Vector(visual.x, visual.y, visual.z + offset)
end
function modifier_boss_pangolier_2_roll_mine.prototype.GetShieldCrashJumpOffset(self)
	if not self.isShieldCrashing then
		return 0
	end
	local elapsed = math.max(0, self:GetElapsedTime() - self.shieldCrashStartTime)
	local ascendDuration = SHIELD_CRASH_JUMP_ASCEND_DURATION * self.shieldCrashJumpDurationScale
	local descendDuration = SHIELD_CRASH_JUMP_DESCEND_DURATION * self.shieldCrashJumpDurationScale
	if elapsed <= ascendDuration then
		local progress = elapsed / ascendDuration
		return math.sin(progress * math.pi * 0.5) * SHIELD_CRASH_JUMP_HEIGHT
	end
	local descendElapsed = math.min(descendDuration, elapsed - ascendDuration)
	local progress = descendElapsed / descendDuration
	return math.cos(progress * math.pi * 0.5) * SHIELD_CRASH_JUMP_HEIGHT
end
function modifier_boss_pangolier_2_roll_mine.prototype.PlayEffectsCrash(self, origin, caster, ability)
	local crashRadius = self:GetShieldCrashWarningRadius()
	local damageRadius = self:GetShieldCrashDamageRadius()
	if not IsValidAlive(nil, caster) then
		return
	end
	local dustPfx = ParticleManager:CreateParticle(SHIELD_CRASH_DUST_PARTICLE, PATTACH_WORLDORIGIN, nil)
	ParticleManager:SetParticleControl(dustPfx, 0, origin)
	ParticleManager:SetParticleControl(dustPfx, 1, origin)
	ParticleManager:SetParticleControl(dustPfx, 2, Vector(crashRadius, crashRadius, crashRadius))
	ParticleManager:ReleaseParticleIndex(dustPfx)
	local corePfx = ParticleManager:CreateParticle(SHIELD_CRASH_CORE_PARTICLE, PATTACH_WORLDORIGIN, nil)
	ParticleManager:SetParticleControl(corePfx, 0, origin)
	ParticleManager:SetParticleControl(corePfx, 1, Vector(crashRadius, 0, 0))
	ParticleManager:ReleaseParticleIndex(corePfx)
	local ringPfx = ParticleManager:CreateParticle(SHIELD_CRASH_RING_PARTICLE, PATTACH_WORLDORIGIN, nil)
	ParticleManager:SetParticleControl(ringPfx, 0, origin)
	ParticleManager:SetParticleControl(ringPfx, 1, Vector(crashRadius, 0, 0))
	ParticleManager:ReleaseParticleIndex(ringPfx)
	EmitSoundOnLocationWithCaster(origin, SHIELD_CRASH_SOUND, caster)
	ScreenShake(origin, 4, 4, 0.2, 700, 0, true)
	local enemies = FindUnitsInRadius(
		caster:GetTeamNumber(),
		origin,
		nil,
		damageRadius,
		DOTA_UNIT_TARGET_TEAM_ENEMY,
		DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,
		DOTA_UNIT_TARGET_FLAG_NONE,
		FIND_ANY_ORDER,
		false
	)
	for ____, enemy in ipairs(enemies) do
		do
			if not IsValidAlive(nil, enemy) then
				goto __continue111
			end
			caster:MonsterDamage({
				victim = enemy,
				damage_rate = SHIELD_CRASH_DAMAGE_RATE,
				ability = ability,
				damage_type = 2,
			})
		end
		::__continue111::
	end
end
function modifier_boss_pangolier_2_roll_mine.prototype.IsHidden(self)
	return true
end
modifier_boss_pangolier_2_roll_mine =
	__TS__DecorateLegacy({ registerModifier(nil) }, modifier_boss_pangolier_2_roll_mine)
return ____exports