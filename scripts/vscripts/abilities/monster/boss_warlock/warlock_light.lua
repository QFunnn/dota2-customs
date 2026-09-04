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
local ____modifier_base = require("modifiers.class.modifier_base")
local BaseModifier_CS = ____modifier_base.BaseModifier_CS
local CAST_POINT = 1
local CAST_DURATION = 9.5
local TURRET_SPAWN_DELAY = 1
local TURRET_COUNT = 4
local TURRET_DISTANCE = 1200
local TURRET_MOVE_DURATION = 0.6
local TURRET_DURATION = 12
local TURRET_ATTACK_INTERVAL = 1
local TURRET_ATTACK_DELAY = 0.5
local TURRET_ATTACK_ROUNDS = 5
local TURRET_PROJECTILE_COUNT_PER_ROUND = 3
local PROJECTILE_SPEED = 1000
local PROJECTILE_DISTANCE = 3200
local DAMAGE_RATE = 15
local TARGET_SEARCH_RANGE = 2000
--- 准备阶段脚下圈粒子保留时长（秒）
local PREPARE_PFX_LIFETIME = 10
--- 炮台落点出生/就绪粒子保留时长（秒）
local TURRET_SPAWN_PFX_LIFETIME = 2
local TURRET_READY_PFX_LIFETIME = 2
local PREPARE_EFFECT =
	"particles/econ/items/ogre_magi/ogre_ti8_immortal_weapon/ogre_ti8_immortal_bloodlust_buff_circle_outer_pulse.vpcf"
local TURRET_SPAWN_EFFECT = "particles/units/heroes/hero_clinkz/clinkz_windwalk.vpcf"
local TURRET_READY_EFFECT = "particles/generic_hero_status/status_invisibility_start.vpcf"
local PROJECTILE_EFFECT = "particles/ti10_dire_tower_attack.vpcf"
local CAST_SOUND = "Hero_Warlock.RainOfChaos_buildup"
local PROJECTILE_SOUND = "Hero_Mars.Spear.Cast"
--- 从指定单位朝给定方向发射直线穿透弹道。
local function launchForceFireProjectile(self, ability, source, direction)
	if not IsValidAlive(nil, source) then
		return
	end
	source:EmitSound(PROJECTILE_SOUND)
	local spawnOrigin = source:GetAbsOrigin():__add(source:GetForwardVector():__mul(100))
	CreateProjectile(nil, {
		ability = ability,
		caster = source,
		effect_name = "particles/dragon_knight_elder_dragon_fire.vpcf",
		target = spawnOrigin:__add(direction:__mul(PROJECTILE_DISTANCE)),
		start_point = source:GetAbsOrigin():__add(Vector(0, 0, 50)),
		projectile_type = "linear",
		projectile_speed = PROJECTILE_SPEED,
		projectile_target_team = DOTA_UNIT_TARGET_TEAM_ENEMY,
		projectile_target_type = bit.bor(DOTA_UNIT_TARGET_HERO, DOTA_UNIT_TARGET_BASIC),
		projectile_target_flags = DOTA_UNIT_TARGET_FLAG_NONE,
		projectile_distance = PROJECTILE_DISTANCE,
		projectile_range = 80,
		on_hit = function(____, hitTarget)
			if not hitTarget or not IsValidAlive(nil, hitTarget) then
				return true
			end
			if not IsValidAlive(nil, source) then
				return true
			end
			EmitSoundOn(PROJECTILE_SOUND, hitTarget)
			source:MonsterDamage({ victim = hitTarget, damage_rate = DAMAGE_RATE, ability = ability })
			return true
		end,
	})
end
____exports.warlock_light = __TS__Class()
local warlock_light = ____exports.warlock_light
warlock_light.name = "warlock_light"
__TS__ClassExtends(warlock_light, MonsterAbility_CS)
function warlock_light.prototype.____constructor(self, ...)
	MonsterAbility_CS.prototype.____constructor(self, ...)
	self.castSequenceId = 0
	self.turretIndices = {}
end
function warlock_light.prototype.Precache(self, context)
	PrecacheResource("particle", PREPARE_EFFECT, context)
	PrecacheResource("particle", TURRET_SPAWN_EFFECT, context)
	PrecacheResource("particle", TURRET_READY_EFFECT, context)
	PrecacheResource("particle", PROJECTILE_EFFECT, context)
end
function warlock_light.prototype.GetMosnterAbilityConfig(self)
	return {
		castPoint = CAST_POINT,
		castDuration = 4,
		behavior = DOTA_ABILITY_BEHAVIOR_NO_TARGET,
		castAnimation = ACT_DOTA_CAST_ABILITY_4,
		animationPlaybackRate = 0.7,
		isNotMove = true,
		OnInterrupt = function()
			return self:stopLightSequence()
		end,
		OnStart = function()
			return self:onStart()
		end,
	}
end
function warlock_light.prototype.OnOwnerDied(self)
	if not IsServer() then
		return
	end
	self:stopLightSequence()
end
function warlock_light.prototype.onStart(self)
	local caster = self:GetCaster()
	if not IsValidAlive(nil, caster) then
		return
	end
	local currentCastSequenceId = self:beginLightSequence()
	caster:EmitSound(CAST_SOUND)
	caster:StartGestureWithPlaybackRate(ACT_DOTA_CAST_ABILITY_4, 0.7)
	local spawnPoint = caster:GetSpawnPoint()
	if spawnPoint then
		caster:SetAbsOrigin(spawnPoint)
		FindClearSpaceForUnit(caster, spawnPoint, true)
	end
	self:playPrepareEffect(caster)
	self:Timer(TURRET_SPAWN_DELAY, function()
		if not self:isCastingActive(currentCastSequenceId) then
			return
		end
		self:spawnTurrets(currentCastSequenceId)
	end)
	self:Timer(2, function()
		if not self:isCastingActive(currentCastSequenceId) then
			return
		end
		ScreenShake(caster:GetAbsOrigin(), 100, 100, 0.5, 3000, 0, true)
		caster:StartGestureWithPlaybackRate(ACT_DOTA_CAST_ABILITY_4, 1)
	end)
end
function warlock_light.prototype.beginLightSequence(self)
	self.castSequenceId = self.castSequenceId + 1
	return self.castSequenceId
end
function warlock_light.prototype.stopLightSequence(self)
	self.castSequenceId = self.castSequenceId + 1
	self:DestroyDuration()
	self:cleanupTurrets()
end
function warlock_light.prototype.isCastingActive(self, castSequenceId)
	local caster = self:GetCaster()
	return IsValidAlive(nil, caster) and self.castSequenceId == castSequenceId
end
function warlock_light.prototype.playPrepareEffect(self, target)
	if not IsValidAlive(nil, target) then
		return
	end
	local pfx = ParticleManager:CreateParticle(PREPARE_EFFECT, PATTACH_ABSORIGIN_FOLLOW, target)
	Timers:CreateTimer(PREPARE_PFX_LIFETIME, function()
		ParticleManager:DestroyParticle(pfx, false)
		ParticleManager:ReleaseParticleIndex(pfx)
		return nil
	end)
end
function warlock_light.prototype.spawnTurrets(self, castSequenceId)
	local caster = self:GetCaster()
	if not IsValidAlive(nil, caster) then
		return
	end
	local center = caster:GetAbsOrigin()
	local points = self:generateDiagonalPoints(center, TURRET_DISTANCE)
	for ____, point in ipairs(points) do
		local currentPoint = point
		MyGameUnit:CreateUnitAsync({
			unitName = "monster_12016",
			position = center,
			findClearSpace = false,
			owner = caster,
			entityOwner = caster,
			team = caster:GetTeamNumber(),
			unitType = UnitType.SUMMONED,
			roomId = caster:GetRoomId(),
			onSpawn = function(____, turret)
				if not turret or not IsValidAlive(nil, turret) then
					return
				end
				if not self:isCastingActive(castSequenceId) then
					MyGameUnit:DestroyUnit(turret)
					return
				end
				local ____self_turretIndices_0 = self.turretIndices
				____self_turretIndices_0[#____self_turretIndices_0 + 1] = turret:entindex()
				self:playTurretSpawnEffect(currentPoint)
				turret:AddNewModifier(turret, nil, "modifier_pause_actions", { duration = TURRET_DURATION })
				turret:Mover(currentPoint, TURRET_MOVE_DURATION)
				turret:SetForwardVector(center:__sub(currentPoint):Normalized())
				turret:SetMoveCapability(DOTA_UNIT_CAP_MOVE_NONE)
				local target = turret:GetMinDistanceUnit(TARGET_SEARCH_RANGE)
				if IsValidAlive(nil, target) then
					turret:LockTargetForSpeed(target, 1, 3)
				end
				local noPlayer = turret:FindAbilityByName("no_player") or turret:AddAbility("no_player")
				if noPlayer then
					noPlayer:SetLevel(1)
				end
				turret:SetColor(Vector(0, 255, 255), 0.5)
				self:playTurretReadyEffect(turret)
				____exports.modifier_force_fire_turret:applys(turret, turret, self, { duration = TURRET_DURATION })
			end,
		})
	end
end
function warlock_light.prototype.cleanupTurrets(self)
	for ____, turretIndex in ipairs(self.turretIndices) do
		local currentTurretIndex = turretIndex
		local turret = EntIndexToHScript(currentTurretIndex)
		if IsValid(nil, turret) and not turret:IsNull() then
			turret:AddNoDraw()
			turret:RemoveModifierByName("warlock_start_shot_weapon")
			turret:RemoveSelf()
		end
	end
	self.turretIndices = {}
end
function warlock_light.prototype.playTurretSpawnEffect(self, position)
	local pfx = ParticleManager:CreateParticle(TURRET_SPAWN_EFFECT, PATTACH_WORLDORIGIN, nil)
	ParticleManager:SetParticleControl(pfx, 0, position)
	Timers:CreateTimer(TURRET_SPAWN_PFX_LIFETIME, function()
		ParticleManager:DestroyParticle(pfx, false)
		ParticleManager:ReleaseParticleIndex(pfx)
		return nil
	end)
end
function warlock_light.prototype.playTurretReadyEffect(self, unit)
	local pfx = ParticleManager:CreateParticle(TURRET_READY_EFFECT, PATTACH_ABSORIGIN_FOLLOW, unit)
	Timers:CreateTimer(TURRET_READY_PFX_LIFETIME, function()
		ParticleManager:DestroyParticle(pfx, false)
		ParticleManager:ReleaseParticleIndex(pfx)
		return nil
	end)
end
function warlock_light.prototype.generateDiagonalPoints(self, centerPoint, distance)
	local points = {}
	do
		local i = 0
		while i < TURRET_COUNT do
			local angle = math.pi / 2 * i + math.pi / 4
			local xOffset = distance * math.cos(angle)
			local yOffset = distance * math.sin(angle)
			local point = Vector(centerPoint.x + xOffset, centerPoint.y + yOffset, centerPoint.z)
			points[#points + 1] = point
			i = i + 1
		end
	end
	return points
end
warlock_light = __TS__DecorateLegacy({ registerAbility(nil, "warlock_light") }, warlock_light)
____exports.warlock_light = warlock_light
____exports.modifier_force_fire_turret = __TS__Class()
local modifier_force_fire_turret = ____exports.modifier_force_fire_turret
modifier_force_fire_turret.name = "modifier_force_fire_turret"
__TS__ClassExtends(modifier_force_fire_turret, BaseModifier_CS)
function modifier_force_fire_turret.prototype.____constructor(self, ...)
	BaseModifier_CS.prototype.____constructor(self, ...)
	self.round = 0
end
function modifier_force_fire_turret.prototype.IsHidden(self)
	return true
end
function modifier_force_fire_turret.prototype.IsPurgable(self)
	return false
end
function modifier_force_fire_turret.prototype.OnCreated(self)
	if not IsServer() then
		return
	end
	self:StartIntervalThink(TURRET_ATTACK_INTERVAL)
end
function modifier_force_fire_turret.prototype.OnIntervalThink(self)
	if not IsServer() then
		return
	end
	local turret = self:GetParent()
	local ability = self:GetAbility()
	if not IsValidAlive(nil, turret) or not ability or not IsValidAlive(nil, ability:GetCaster()) then
		self:Destroy()
		return
	end
	self.round = self.round + 1
	if self.round > TURRET_ATTACK_ROUNDS then
		self:Destroy()
		return
	end
	if not IsValidAlive(nil, turret) or self:IsRemoved() then
		return
	end
	local projectileCount = math.min(TURRET_PROJECTILE_COUNT_PER_ROUND, self.round)
	local directions = GetRotateVectors(nil, turret:GetForwardVector(), projectileCount, 30)
	for ____, direction in ipairs(directions) do
		local currentDirection = direction
		Timers:CreateTimer(0.3, function()
			if not IsValidAlive(nil, turret) or not IsValidAlive(nil, ability:GetCaster()) or self:IsRemoved() then
				return nil
			end
			turret:StartGestureWithPlaybackRate(ACT_DOTA_CAST_ABILITY_2, 0.8)
			return nil
		end)
		Timers:CreateTimer(TURRET_ATTACK_DELAY + 0.2, function()
			if not IsValidAlive(nil, turret) or not IsValidAlive(nil, ability:GetCaster()) or self:IsRemoved() then
				return nil
			end
			launchForceFireProjectile(nil, ability, turret, currentDirection)
			return nil
		end)
		Timers:CreateTimer(TURRET_ATTACK_DELAY + 0.4, function()
			if not IsValidAlive(nil, turret) or not IsValidAlive(nil, ability:GetCaster()) or self:IsRemoved() then
				return nil
			end
			local target = turret:GetMinDistanceUnit(TARGET_SEARCH_RANGE)
			if IsValidAlive(nil, target) then
				turret:LockTargetForSpeed(target, 1, 3)
			end
			return nil
		end)
	end
end
function modifier_force_fire_turret.prototype.OnDestroy(self)
	if not IsServer() then
		return
	end
	local turret = self:GetParent()
	if not IsValid(nil, turret) or turret:IsNull() then
		return
	end
	turret:AddNoDraw()
	Timers:CreateTimer(0.5, function()
		if IsValid(nil, turret) and not turret:IsNull() then
			turret:RemoveSelf()
		end
	end)
end
modifier_force_fire_turret =
	__TS__DecorateLegacy({ registerModifier(nil, "warlock_start_shot_weapon") }, modifier_force_fire_turret)
____exports.modifier_force_fire_turret = modifier_force_fire_turret
return ____exports