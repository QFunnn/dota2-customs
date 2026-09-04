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
local CAST_RANGE = 2600
local CAST_DURATION = 7.2
local START_LOCK_FACE_DURATION = 1
local SLASH_LOCK_FACE_DURATION = 0.2
local START_BACK_STEP_DISTANCE = 100
local START_BACK_STEP_DURATION = 0.6
local SLASH_BACK_STEP_DISTANCE = 50
local FINAL_SLASH_BACK_STEP_DISTANCE = 160
local SLASH_BACK_STEP_DURATION = 0.1
local FINAL_SLASH_BACK_STEP_DURATION = 0.3
local PREPARE_TO_ATTACK_DELAY = 1
local ATTACK_START_DELAY = 0.55
local SLASH_MODIFIER_DURATION = 5
local NO_COLLISION_DURATION = 5.5
local FIRST_SLASH_RELEASE_DELAY = SLASH_LOCK_FACE_DURATION
local SECOND_SLASH_RELEASE_DELAY = FIRST_SLASH_RELEASE_DELAY + 0.5
local THIRD_SLASH_RELEASE_DELAY = SECOND_SLASH_RELEASE_DELAY + 2.3
local FIRST_SLASH_WARNING_DURATION = 1.8
local THIRD_SLASH_WARNING_DURATION = 1
local PROJECTILE_DAMAGE_RATE = 25
local HIT_KNOCKBACK_DISTANCE = 200
local HIT_KNOCKBACK_DURATION = 0.5
local HIT_STUN_EXTRA_DURATION = 0.5
local PROJECTILE_SPEED = 1500
local PROJECTILE_DISTANCE = 3300
local PROJECTILE_START_RADIUS = 100
local PROJECTILE_END_RADIUS = 150
local PROJECTILE_EXPIRE_TIME = 5
local FAN_WARNING_HALF_ANGLE = 23
local FAN_WARNING_END_WIDTH =
	math.floor(2 * PROJECTILE_DISTANCE * math.sin(math.rad(FAN_WARNING_HALF_ANGLE)) + PROJECTILE_END_RADIUS * 2)
local UNDERLORD_CORE_PARTICLE = "particles/underlord_debut_core_a.vpcf"
local PREPARE_PARTICLE = "particles/econ/items/invoker/invoker_ti6/invoker_deafening_blast_ti6_knockback_debuff.vpcf"
local THIRD_SLASH_FLASH_PARTICLE = "particles/ui/plus/ui_hero_relics_burst_uni_flash.vpcf"
local PROJECTILE_PARTICLE = "particles/kunkka_immortal_ghost_ship_2.vpcf"
local function CreateParticleOnBone(self, unit, particlePath, controlPoint, boneName)
	local particle = ParticleManager:CreateParticle(particlePath, PATTACH_CENTER_FOLLOW, unit)
	ParticleManager:SetParticleControlEnt(
		particle,
		controlPoint,
		unit,
		PATTACH_POINT_FOLLOW,
		boneName,
		unit:GetAbsOrigin(),
		true
	)
	return particle
end
____exports.power_slash = __TS__Class()
local power_slash = ____exports.power_slash
power_slash.name = "power_slash"
__TS__ClassExtends(power_slash, MonsterAbility_CS)
function power_slash.prototype.Precache(self, context)
	PrecacheResource("particle", UNDERLORD_CORE_PARTICLE, context)
	PrecacheResource("particle", PREPARE_PARTICLE, context)
	PrecacheResource("particle", THIRD_SLASH_FLASH_PARTICLE, context)
	PrecacheResource("particle", PROJECTILE_PARTICLE, context)
end
function power_slash.prototype.GetMosnterAbilityConfig(self)
	return {
		castRange = CAST_RANGE,
		castPoint = 0,
		castDuration = CAST_DURATION,
		behavior = DOTA_ABILITY_BEHAVIOR_NO_TARGET,
		OnPhaseStart = function()
			self:PhaseStart()
		end,
		OnStart = function()
			self:StartPowerSlash()
		end,
		OnFinish = function()
			self:DestroyPrepareParticle()
		end,
		OnInterrupt = function()
			self:DestroyPrepareParticle()
			local caster = self:GetCaster()
			if IsValid(nil, caster) and not caster:IsNull() then
				caster:SetColor(Vector(255, 255, 255), 0.3)
			end
		end,
	}
end
function power_slash.prototype.PlayFinishEffect(self, _interrupted) end
function power_slash.prototype.PhaseStart(self)
	local caster = self:GetCaster()
	if not IsValidAlive(nil, caster) then
		return
	end
	self:PlayFirstSlashLinearWarning(caster)
end
function power_slash.prototype.StartPowerSlash(self)
	local caster = self:GetCaster()
	if not IsValidAlive(nil, caster) then
		return
	end
	caster:SetColor(Vector(155, 0, 155), 0.6)
	caster:EmitSound("Hero_Kunkaa.Tidebringer")
	self:Timer(0.1, function()
		return self:PlayUnderlordCoreEffect()
	end)
	local target = caster:GetMinDistanceUnit(CAST_RANGE) or caster
	caster:LockTargetForSpeed(target, START_LOCK_FACE_DURATION, 4)
	caster:StartGestureWithPlaybackRate(ACT_DOTA_CAST_ABILITY_1, 0.5)
	self:DestroyPrepareParticle()
	self.prepareParticle = ParticleManager:CreateParticle(PREPARE_PARTICLE, PATTACH_CENTER_FOLLOW, caster)
	self:Timer(PREPARE_TO_ATTACK_DELAY, function()
		return self:BeginSlashGesture()
	end)
	local backStepPoint = caster:GetAbsOrigin():__sub(caster:GetForwardVector():__mul(START_BACK_STEP_DISTANCE))
	caster:Mover(backStepPoint, START_BACK_STEP_DURATION)
end
function power_slash.prototype.PlayUnderlordCoreEffect(self)
	local caster = self:GetCaster()
	if not IsValidAlive(nil, caster) then
		return
	end
	local position = caster:GetAbsOrigin():__add(Vector(0, 0, 150))
	local particle = ParticleManager:CreateParticle(UNDERLORD_CORE_PARTICLE, PATTACH_CUSTOMORIGIN, nil)
	ParticleManager:SetParticleControl(particle, 0, position)
	ParticleManager:SetParticleControl(particle, 4, position)
	ParticleManager:ReleaseParticleIndex(particle)
end
function power_slash.prototype.BeginSlashGesture(self)
	local caster = self:GetCaster()
	if not IsValidAlive(nil, caster) then
		return
	end
	caster:SetColor(Vector(255, 255, 255), 0.6)
	caster:StartGestureWithFadeAndPlaybackRate(ACT_DOTA_CAST_ABILITY_3, 0.1, 0.7, 0.7)
	self:Timer(ATTACK_START_DELAY, function()
		return self:StartSlashModifier()
	end)
end
function power_slash.prototype.StartSlashModifier(self)
	local caster = self:GetCaster()
	if not IsValidAlive(nil, caster) then
		return
	end
	self:DestroyPrepareParticle()
	____exports.power_slash_modifier:applys(caster, caster, self, { duration = SLASH_MODIFIER_DURATION })
	caster:AddNewModifier(caster, nil, "modifier_state_no_collision", { duration = NO_COLLISION_DURATION })
end
function power_slash.prototype.PlayFirstSlashLinearWarning(self, caster)
	local startPoint = caster:GetAbsOrigin()
	local endPoint = startPoint:__add(caster:GetForwardVector():__mul(900))
	self:WarningEffect(startPoint, endPoint, FIRST_SLASH_WARNING_DURATION, {
		startWidth = PROJECTILE_START_RADIUS,
		endWidth = PROJECTILE_END_RADIUS,
		getDirection = function()
			return caster:GetForwardVector()
		end,
		follow = true,
	})
end
function power_slash.prototype.DestroyPrepareParticle(self)
	if self.prepareParticle == nil then
		return
	end
	ParticleManager:DestroyParticle(self.prepareParticle, false)
	ParticleManager:ReleaseParticleIndex(self.prepareParticle)
	self.prepareParticle = nil
end
function power_slash.prototype.OnProjectileHit_ExtraData(self, target, _location, _extraData)
	if not IsValidAlive(nil, target) then
		return true
	end
	local caster = self:GetCaster()
	if not IsValidAlive(nil, caster) then
		return true
	end
	caster:MonsterDamage({ victim = target, damage_rate = PROJECTILE_DAMAGE_RATE, ability = self })
	target:KnockBack(caster, self, {
		origin_pos = caster:GetAbsOrigin(),
		duration = HIT_KNOCKBACK_DURATION,
		distance = HIT_KNOCKBACK_DISTANCE,
		height = 100,
		stun = true,
		stunDuration = HIT_STUN_EXTRA_DURATION,
	})
	return false
end
power_slash = __TS__DecorateLegacy({ registerAbility(nil) }, power_slash)
____exports.power_slash = power_slash
____exports.power_slash_modifier = __TS__Class()
local power_slash_modifier = ____exports.power_slash_modifier
power_slash_modifier.name = "power_slash_modifier"
__TS__ClassExtends(power_slash_modifier, MonsterModifier_CS)
function power_slash_modifier.prototype.OnCreated(self, _params)
	if not IsServer() then
		return
	end
	local caster = self:GetCaster()
	if not IsValidAlive(nil, caster) then
		return
	end
	self:ScheduleSlashSequence()
end
function power_slash_modifier.prototype.ScheduleSlashSequence(self)
	self:Timer(0, function()
		return self:PrepareSlashStep(1)
	end)
	self:Timer(FIRST_SLASH_RELEASE_DELAY, function()
		return self:FireSlashStep(1)
	end)
	self:Timer(SECOND_SLASH_RELEASE_DELAY - SLASH_LOCK_FACE_DURATION, function()
		return self:PrepareSlashStep(2)
	end)
	self:Timer(SECOND_SLASH_RELEASE_DELAY, function()
		return self:FireSlashStep(2)
	end)
	self:Timer(THIRD_SLASH_RELEASE_DELAY - THIRD_SLASH_WARNING_DURATION, function()
		return self:PlayThirdSlashFanWarning()
	end)
	self:Timer(THIRD_SLASH_RELEASE_DELAY - SLASH_LOCK_FACE_DURATION, function()
		return self:PrepareSlashStep(3)
	end)
	self:Timer(THIRD_SLASH_RELEASE_DELAY, function()
		return self:FireSlashStep(3)
	end)
end
function power_slash_modifier.prototype.PlayThirdSlashFanWarning(self)
	local caster = self:GetCaster()
	if not IsValidAlive(nil, caster) then
		return
	end
	local target = caster:GetMinDistanceUnit(CAST_RANGE) or caster
	caster:LockTargetForSpeed(target, THIRD_SLASH_WARNING_DURATION * 0.8, 4)
	local startPoint = caster:GetAbsOrigin()
	local endPoint = startPoint:__add(self:GetFlatDirection(caster:GetForwardVector()):__mul(650))
	self:WarningEffect(startPoint, endPoint, THIRD_SLASH_WARNING_DURATION, {
		startWidth = 200,
		endWidth = 600,
		getDirection = function()
			local ____IsValidAlive_result_0
			if IsValidAlive(nil, caster) then
				____IsValidAlive_result_0 = self:GetFlatDirection(caster:GetForwardVector())
			else
				____IsValidAlive_result_0 = nil
			end
			return ____IsValidAlive_result_0
		end,
		follow = true,
	})
end
function power_slash_modifier.prototype.PrepareSlashStep(self, waveIndex)
	local caster = self:GetCaster()
	if not IsValidAlive(nil, caster) then
		return
	end
	self:LockSlashTarget(caster)
	self:PlaySlashAction(caster, waveIndex)
	if waveIndex >= 3 then
		CreateParticleOnBone(nil, caster, THIRD_SLASH_FLASH_PARTICLE, 0, "attach_attack1")
		return
	end
end
function power_slash_modifier.prototype.PlaySlashAction(self, caster, waveIndex)
	self:SetStackCount(waveIndex)
	if waveIndex == 2 then
		caster:SetColor(Vector(155, 0, 155), 2)
	end
	if waveIndex >= 3 then
		caster:SetColor(Vector(255, 255, 255), 0.3)
	end
	self:StartSlashBackStep(caster, waveIndex >= 3)
end
function power_slash_modifier.prototype.FireSlashStep(self, waveIndex)
	local caster = self:GetCaster()
	if not IsValidAlive(nil, caster) then
		return
	end
	self:SetStackCount(waveIndex)
	ScreenShake(caster:GetAbsOrigin(), 5, 2, 2, 1300, 0, true)
	self:StopTargetLock(caster)
	local forward = self:GetFlatDirection(caster:GetForwardVector())
	if waveIndex >= 3 then
		self:FireSlashProjectiles(GetRotateVectors(nil, forward, 3, 23))
		self:Destroy()
		return
	end
	self:FireSlashProjectiles(GetRotateVectors(nil, forward, 1, 32))
end
function power_slash_modifier.prototype.LockSlashTarget(self, caster)
	local target = caster:GetMinDistanceUnit(CAST_RANGE)
	if not IsValidAlive(nil, target) then
		return
	end
	caster:LockTargetForSpeed(target, SLASH_LOCK_FACE_DURATION, 3)
end
function power_slash_modifier.prototype.StartSlashBackStep(self, caster, isFinalSlash)
	local backStepDistance = isFinalSlash and FINAL_SLASH_BACK_STEP_DISTANCE or SLASH_BACK_STEP_DISTANCE
	local backStepDuration = isFinalSlash and FINAL_SLASH_BACK_STEP_DURATION or SLASH_BACK_STEP_DURATION
	local backStepPoint = caster:GetAbsOrigin():__sub(caster:GetForwardVector():__mul(backStepDistance))
	caster:Mover(backStepPoint, backStepDuration)
end
function power_slash_modifier.prototype.FireSlashProjectiles(self, directions)
	local caster = self:GetCaster()
	if not IsValidAlive(nil, caster) then
		return
	end
	for ____, direction in ipairs(directions) do
		caster:EmitSound("Hero_Kunkka.SharkShip.Crash")
		ProjectileManager:CreateLinearProjectile({
			vSpawnOrigin = caster:GetAbsOrigin(),
			vVelocity = direction:__mul(PROJECTILE_SPEED),
			vAcceleration = Vector(0, 0, 0),
			fMaxSpeed = PROJECTILE_SPEED,
			fDistance = PROJECTILE_DISTANCE,
			fStartRadius = PROJECTILE_START_RADIUS,
			fEndRadius = PROJECTILE_END_RADIUS,
			fExpireTime = GameRules:GetGameTime() + PROJECTILE_EXPIRE_TIME,
			iUnitTargetTeam = DOTA_UNIT_TARGET_TEAM_ENEMY,
			iUnitTargetFlags = DOTA_UNIT_TARGET_FLAG_MAGIC_IMMUNE_ENEMIES,
			iUnitTargetType = DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC + DOTA_UNIT_TARGET_BUILDING,
			bIgnoreSource = true,
			bHasFrontalCone = true,
			bDrawsOnMinimap = false,
			bVisibleToEnemies = true,
			EffectName = PROJECTILE_PARTICLE,
			Ability = self:GetAbility(),
			Source = caster,
			bProvidesVision = false,
		})
	end
end
function power_slash_modifier.prototype.StopTargetLock(self, caster)
	local timerId = caster:GetCustomValue("目标计时器")
	if not timerId then
		return
	end
	Timers:RemoveTimer(timerId)
	caster:SetCustomValue("目标计时器", "")
end
function power_slash_modifier.prototype.GetFlatDirection(self, direction)
	local flatDirection = Vector(direction.x, direction.y, 0)
	if flatDirection:Length2D() <= 0.001 then
		return Vector(1, 0, 0)
	end
	return flatDirection:Normalized()
end
power_slash_modifier = __TS__DecorateLegacy({ registerModifier(nil) }, power_slash_modifier)
____exports.power_slash_modifier = power_slash_modifier
return ____exports