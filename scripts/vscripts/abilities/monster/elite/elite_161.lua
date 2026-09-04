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
local ____monster_base = require("abilities.monster.monster_base")
local MonsterAbility_CS = ____monster_base.MonsterAbility_CS
local ____elite_showcase_utils = require("abilities.monster.elite.elite_showcase_utils")
local EliteGroundLineEnd = ____elite_showcase_utils.EliteGroundLineEnd
local EliteRotateDirection = ____elite_showcase_utils.EliteRotateDirection
local CAST_RANGE = 900
local CAST_POINT = 0.7
local CAST_DURATION = 0.9
local DASH_DISTANCE = 500
local DASH_DURATION = 0.2
local DASH_HIT_RADIUS = 140
local DASH_KNOCKBACK_DISTANCE = 100
local DASH_KNOCKBACK_DURATION = 0.15
local DASH_PROJECTILE_DISTANCE = 900
local DASH_PROJECTILE_SIDE_OFFSETS = { -100, 0, 100 }
local DASH_PROJECTILE_FORWARD_OFFSETS = { 150, 250, 150 }
local PIERCE_DISTANCE = 900
local PIERCE_WIDTH = 100
local PIERCE_SPEED = 2200
local DAMAGE_RATE = 10
local PIERCE_INTERVAL = 0.18
local PIERCE_ANGLES = { 30, 0, -30 }
local PIERCE_KNOCKBACK_DISTANCE = 80
local PIERCE_KNOCKBACK_DURATION = 0.15
local PIERCE_STUN_DURATION = 0.2
local PIERCE_PARTICLE = "particles/units/heroes/hero_hoodwink/hoodwink_sharpshooter_projectile.vpcf"
local MARS_SPEAR_SOUND_EVENTS = "soundevents/game_sounds_heroes/game_sounds_mars.vsndevts"
local MARS_SPEAR_CAST_SOUND = "Hero_Mars.Spear.Cast"
local MARS_SPEAR_PROJECTILE_SOUND = "Hero_Mars.Spear"
local MARS_SPEAR_HIT_SOUND = "Hero_Mars.Spear.Target"
--- 战矛穿刺：蓄力后向前方三个方向依次发射穿透战矛。
____exports.elite_161 = __TS__Class()
local elite_161 = ____exports.elite_161
elite_161.name = "elite_161"
__TS__ClassExtends(elite_161, MonsterAbility_CS)
function elite_161.prototype.Precache(self, context)
	PrecacheResource("particle", PIERCE_PARTICLE, context)
	PrecacheResource("soundfile", MARS_SPEAR_SOUND_EVENTS, context)
end
function elite_161.prototype.GetMosnterAbilityConfig(self)
	return {
		behavior = DOTA_ABILITY_BEHAVIOR_NO_TARGET,
		castPoint = CAST_POINT,
		castDuration = CAST_DURATION,
		castAnimation = "",
		OnPhaseStart = function()
			return self:PreparePierce()
		end,
		OnStart = function()
			return self:StartPierce()
		end,
	}
end
function elite_161.prototype.PreparePierce(self)
	local caster = self:GetCaster()
	if not IsValidAlive(nil, caster) then
		return
	end
	local target = self:FindTarget()
	if IsValidAlive(nil, target) then
		caster:LockTargetForSpeed(target, 0.5, 5)
	end
	caster:Mover(caster:GetAbsOrigin():__add(caster:GetForwardVector():__mul(-150)), 0.15)
	caster:StartGestureWithFadeAndPlaybackRate(ACT_DOTA_ATTACK, 0, 0.1, 0.55)
	self:Timer(0.1, function()
		self:WarningEffect(
			caster:GetAbsOrigin(),
			caster:GetAbsOrigin():__add(caster:GetForwardVector():__mul(500)),
			CAST_POINT - 0.1,
			{
				startWidth = PIERCE_WIDTH,
				endWidth = 300,
				getDirection = function()
					return caster:GetForwardVector()
				end,
			}
		)
	end)
end
function elite_161.prototype.StartPierce(self)
	local caster = self:GetCaster()
	if not IsValidAlive(nil, caster) then
		return
	end
	local hasDashHit = false
	local secondStarted = false
	local function startSecondPierce()
		if secondStarted then
			return
		end
		secondStarted = true
		self:StartSecondPierce(caster)
	end
	self:FireDashParallelProjectiles(caster)
	local dashEnd = caster:GetAbsOrigin():__add(caster:GetForwardVector():__mul(DASH_DISTANCE))
	caster:Mover(dashEnd, DASH_DURATION, function(____, position)
		if hasDashHit then
			return true
		end
		local hitEnemy = self:FindDashHitEnemy(caster, position)
		if not hitEnemy then
			return
		end
		hasDashHit = true
		self:OnDashHit(caster, hitEnemy)
		startSecondPierce(nil)
		return true
	end)
	self:Timer(DASH_DURATION + FrameTime(), function()
		return startSecondPierce(nil)
	end)
end
function elite_161.prototype.FireDashParallelProjectiles(self, caster)
	if not IsValidAlive(nil, caster) then
		return
	end
	local origin = caster:GetAbsOrigin()
	local direction = self:GetFlatForward(caster)
	local right = caster:GetRightVector()
	do
		local index = 0
		while index < #DASH_PROJECTILE_SIDE_OFFSETS do
			local currentIndex = index
			local currentSideOffset = DASH_PROJECTILE_SIDE_OFFSETS[currentIndex + 1]
			local currentForwardOffset = DASH_PROJECTILE_FORWARD_OFFSETS[currentIndex + 1]
			local startPoint = origin:__add(right:__mul(currentSideOffset)):__add(direction:__mul(currentForwardOffset))
			self:CreateProjectile(caster, startPoint, direction, DASH_PROJECTILE_DISTANCE, false)
			index = index + 1
		end
	end
end
function elite_161.prototype.FindDashHitEnemy(self, caster, position)
	local enemies = FindUnitsInRadius(
		caster:GetTeamNumber(),
		position,
		nil,
		DASH_HIT_RADIUS,
		DOTA_UNIT_TARGET_TEAM_ENEMY,
		DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,
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
function elite_161.prototype.OnDashHit(self, caster, enemy)
	EmitSoundOn(MARS_SPEAR_HIT_SOUND, enemy)
	caster:MonsterDamage({ victim = enemy, damage_rate = DAMAGE_RATE, ability = self })
	enemy:KnockBack(caster, self, {
		direction = caster:GetForwardVector(),
		distance = DASH_KNOCKBACK_DISTANCE,
		duration = DASH_KNOCKBACK_DURATION,
		height = 0,
		block = true,
		blockUntraversable = true,
	})
end
function elite_161.prototype.StartSecondPierce(self, caster)
	if not IsValidAlive(nil, caster) then
		return
	end
	local origin = caster:GetAbsOrigin()
	local baseDirection = self:GetFlatForward(caster)
	do
		local index = 0
		while index < #PIERCE_ANGLES do
			local currentAngle = PIERCE_ANGLES[index + 1]
			local currentDirection = EliteRotateDirection(nil, baseDirection, currentAngle)
			self:WarningEffect(
				origin,
				EliteGroundLineEnd(nil, origin, currentDirection, PIERCE_DISTANCE, caster),
				CAST_POINT,
				{ startWidth = PIERCE_WIDTH, endWidth = PIERCE_WIDTH }
			)
			index = index + 1
		end
	end
	self:Timer(0.25, function()
		EmitSoundOn(MARS_SPEAR_CAST_SOUND, caster)
		do
			local index = 0
			while index < #PIERCE_ANGLES do
				local currentIndex = index
				local currentAngle = PIERCE_ANGLES[currentIndex + 1]
				local currentDelay = currentIndex * PIERCE_INTERVAL
				local currentDirection = EliteRotateDirection(nil, baseDirection, currentAngle)
				self:Timer(currentDelay, function()
					self:FirePierce(caster, origin, currentDirection)
				end)
				index = index + 1
			end
		end
	end)
end
function elite_161.prototype.FirePierce(self, caster, origin, direction)
	if not IsValidAlive(nil, caster) then
		return
	end
	local startPoint = GetGroundPosition(origin, caster)
	caster:StartGestureWithFadeAndPlaybackRate(ACT_DOTA_ATTACK, 0.03, 0.12, 2.2)
	self:CreateProjectile(caster, startPoint, direction, PIERCE_DISTANCE, true)
end
function elite_161.prototype.CreateProjectile(self, caster, origin, direction, distance, applyPierceControl)
	local startPoint = GetGroundPosition(origin, caster)
	local endPoint = EliteGroundLineEnd(nil, startPoint, direction, distance, caster)
	EmitSoundOn(MARS_SPEAR_PROJECTILE_SOUND, caster)
	CreateProjectile(nil, {
		ability = self,
		caster = caster,
		effect_name = PIERCE_PARTICLE,
		projectile_type = "linear",
		start_point = startPoint,
		target = endPoint,
		projectile_speed = PIERCE_SPEED,
		projectile_distance = distance,
		projectile_range = PIERCE_WIDTH,
		projectile_target_team = DOTA_UNIT_TARGET_TEAM_ENEMY,
		projectile_target_type = DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,
		projectile_target_flags = DOTA_UNIT_TARGET_FLAG_NONE,
		on_hit = function(____, hitTarget)
			if hitTarget and IsValidAlive(nil, hitTarget) then
				if not IsValidAlive(nil, caster) then
					return true
				end
				EmitSoundOn(MARS_SPEAR_HIT_SOUND, hitTarget)
				caster:MonsterDamage({ victim = hitTarget, damage_rate = DAMAGE_RATE, ability = self })
				if not applyPierceControl then
					return false
				end
				hitTarget:KnockBack(caster, self, {
					direction = direction,
					distance = PIERCE_KNOCKBACK_DISTANCE,
					duration = PIERCE_KNOCKBACK_DURATION,
					height = 0,
					stun = true,
					stunDuration = PIERCE_STUN_DURATION,
					block = true,
					blockUntraversable = true,
				})
				return false
			end
			return true
		end,
	})
end
function elite_161.prototype.FindTarget(self)
	local caster = self:GetCaster()
	if not IsValidAlive(nil, caster) then
		return nil
	end
	return caster:GetMinDistanceUnit(CAST_RANGE)
end
function elite_161.prototype.GetFlatForward(self, caster)
	local forward = caster:GetForwardVector()
	local flat = Vector(forward.x, forward.y, 0)
	if flat:Length2D() <= 0.001 then
		return Vector(1, 0, 0)
	end
	return flat:Normalized()
end
elite_161 = __TS__DecorateLegacy({ registerAbility(nil) }, elite_161)
____exports.elite_161 = elite_161
return ____exports