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
local TOTAL_DURATION = 7
local CAST_POINT = 1.3
local THINKER_DURATION = TOTAL_DURATION - CAST_POINT
local DUMMY_MOVE_SPEED = 400
local DUMMY_MAX_SPEED = 1200
local DUMMY_TURN_RATE_DEG = 90
local DUMMY_SEARCH_RADIUS = 1800
local DUMMY_COLLISION_RADIUS = 100
local HIT_DAMAGE_RATE = 36
local HIT_KNOCKBACK_DURATION = 0.4
local HIT_KNOCKBACK_DISTANCE = 200
local HIT_KNOCKBACK_HEIGHT = 80
local HIT_SLOW_DURATION = 4
local SNOWBALL_PARTICLE = "particles/units/heroes/hero_tusk/tusk_snowball.vpcf"
--- 精英技能8 - 召唤雪球马甲追踪英雄
____exports.elite_008 = __TS__Class()
local elite_008 = ____exports.elite_008
elite_008.name = "elite_008"
__TS__ClassExtends(elite_008, MonsterAbility_CS)
function elite_008.prototype.Precache(self, context)
	PrecacheResource("particle", SNOWBALL_PARTICLE, context)
end
function elite_008.prototype.GetMosnterAbilityConfig(self)
	return {
		castRange = 600,
		castPoint = CAST_POINT,
		castDuration = THINKER_DURATION,
		behavior = DOTA_ABILITY_BEHAVIOR_NO_TARGET,
		castAnimation = ACT_DOTA_CAST_ABILITY_4,
		OnPhaseStart = function()
			local caster = self:GetCaster()
			local target = caster:GetMinDistanceUnit(3500)
			caster:LockTargetForSpeed(target, CAST_POINT, 2)
		end,
		OnStart = function()
			local caster = self:GetCaster()
			caster:EmitSound("Hero_Tusk.Snowball.Loop")
			local origin = caster:GetAbsOrigin()
			local forward = caster:GetForwardVector()
			local spawnPos = origin:__add(forward:__mul(120))
			local groundPos = GetGroundPosition(spawnPos, caster)
			local thinker = CreateModifierThinker(
				caster,
				self,
				"modifier_elite_008_snowball",
				{ duration = THINKER_DURATION },
				groundPos,
				caster:GetTeamNumber(),
				false
			)
			thinker:SetForwardVector(forward)
		end,
	}
end
function elite_008.prototype.getThinkerMoveSpeed(self)
	return DUMMY_MOVE_SPEED
end
function elite_008.prototype.getThinkerMaxSpeed(self)
	return DUMMY_MAX_SPEED
end
function elite_008.prototype.getThinkerMaxTurnDegPerSec(self)
	return DUMMY_TURN_RATE_DEG
end
function elite_008.prototype.getThinkerSearchRadius(self)
	return DUMMY_SEARCH_RADIUS
end
function elite_008.prototype.getThinkerCollisionRadius(self)
	return DUMMY_COLLISION_RADIUS
end
function elite_008.prototype.getThinkerHitDamageRate(self)
	return HIT_DAMAGE_RATE
end
function elite_008.prototype.finishSnowballCast(self)
	self:DestroyDuration()
	self:GetCaster():StopSound("Hero_Tusk.Snowball.Loop")
	self:GetCaster():RemoveGesture(ACT_DOTA_CAST_ABILITY_4)
	self:GetCaster():MoveToPositionAggressive(self:GetCaster():GetAbsOrigin())
end
elite_008 = __TS__DecorateLegacy({ registerAbility(nil) }, elite_008)
____exports.elite_008 = elite_008
local modifier_elite_008_snowball = __TS__Class()
modifier_elite_008_snowball.name = "modifier_elite_008_snowball"
__TS__ClassExtends(modifier_elite_008_snowball, MonsterModifier_CS)
function modifier_elite_008_snowball.prototype.OnCreated(self)
	if not IsServer() then
		return
	end
	self.ability = self:GetAbility()
	local parent = self:GetParent()
	local caster = self:GetCaster()
	if not IsValidAlive(nil, parent) or not IsValidAlive(nil, caster) then
		self:Destroy()
		return
	end
	local forward = caster:GetForwardVector()
	self.dir = Vector(forward.x, forward.y, 0):Normalized()
	if self.dir:Length2D() < 0.01 then
		self.dir.x = 1
		self.dir.y = 0
	end
	self.speed = self.ability:getThinkerMoveSpeed()
	local pos = parent:GetAbsOrigin()
	self.fxId = ParticleManager:CreateParticle(SNOWBALL_PARTICLE, PATTACH_ABSORIGIN_FOLLOW, parent)
	ParticleManager:SetParticleControl(self.fxId, 0, pos)
	ParticleManager:SetParticleControl(self.fxId, 1, pos)
	ParticleManager:SetParticleControl(self.fxId, 2, Vector(self.ability:getThinkerMoveSpeed() + 500, 0, 0))
	ParticleManager:SetParticleControl(self.fxId, 3, Vector(0, 0, 100))
	self:StartIntervalThink(0.03)
end
function modifier_elite_008_snowball.prototype.OnDestroy(self)
	if not IsServer() then
		return
	end
	if self.fxId ~= nil then
		ParticleManager:DestroyParticle(self.fxId, false)
		ParticleManager:ReleaseParticleIndex(self.fxId)
		self.fxId = nil
	end
	local ____opt_0 = self.ability
	if ____opt_0 ~= nil then
		____opt_0:finishSnowballCast()
	end
end
function modifier_elite_008_snowball.prototype.OnIntervalThink(self)
	if not IsServer() then
		return
	end
	local parent = self:GetParent()
	local caster = self:GetCaster()
	if not IsValidAlive(nil, parent) then
		return
	end
	if not IsValid(nil, parent) or parent:IsNull() then
		self:Destroy()
		return
	end
	if not IsValidAlive(nil, caster) then
		self:Destroy()
		return
	end
	if self:GetElapsedTime() < 1 then
		return
	end
	local origin = parent:GetAbsOrigin()
	local moveSpeed = self.ability:getThinkerMoveSpeed()
	local maxSpeed = self.ability:getThinkerMaxSpeed()
	local maxTurnDegPerSec = self.ability:getThinkerMaxTurnDegPerSec()
	local searchRadius = self.ability:getThinkerSearchRadius()
	local collisionRadius = self.ability:getThinkerCollisionRadius()
	local heroes = FindUnitsInRadius(
		caster:GetTeamNumber(),
		origin,
		nil,
		searchRadius,
		DOTA_UNIT_TARGET_TEAM_ENEMY,
		DOTA_UNIT_TARGET_HERO,
		DOTA_UNIT_TARGET_FLAG_NONE,
		FIND_ANY_ORDER,
		false
	)
	local desiredDir = nil
	local minDist = searchRadius + 1
	for ____, u in ipairs(heroes) do
		do
			if not IsValidAlive(nil, u) then
				goto __continue26
			end
			local to = u:GetAbsOrigin() - origin
			local d = to:Length2D()
			if d < minDist then
				minDist = d
				local len = math.sqrt(to.x * to.x + to.y * to.y) or 1
				desiredDir = Vector(to.x / len, to.y / len, 0)
			end
		end
		::__continue26::
	end
	if not desiredDir then
		self.speed = 10
	else
		local currentAngle = math.atan2(self.dir.y, self.dir.x) * (180 / math.pi)
		local desiredAngle = math.atan2(desiredDir.y, desiredDir.x) * (180 / math.pi)
		local delta = desiredAngle - currentAngle
		while delta > 180 do
			delta = delta - 360
		end
		while delta < -180 do
			delta = delta + 360
		end
		local maxTurn = maxTurnDegPerSec * 0.03
		local turn = math.max(-maxTurn, math.min(maxTurn, delta))
		local newAngle = (currentAngle + turn) * (math.pi / 180)
		self.dir = Vector(math.cos(newAngle), math.sin(newAngle), 0)
	end
	if desiredDir then
		self.speed = math.min(maxSpeed, self.speed + moveSpeed * 0.1 * 0.03)
	end
	local move = self.dir * self.speed * 0.03
	local newPos = origin + move
	newPos.z = GetGroundHeight(newPos, parent) or origin.z
	parent:SetAbsOrigin(newPos)
	if self.fxId ~= nil then
		ParticleManager:SetParticleControl(self.fxId, 1, newPos)
		ParticleManager:SetParticleControl(self.fxId, 2, Vector(self.speed + 500, 0, 0))
	end
	local hitUnits = FindUnitsInRadius(
		caster:GetTeamNumber(),
		newPos,
		nil,
		collisionRadius,
		DOTA_UNIT_TARGET_TEAM_ENEMY,
		DOTA_UNIT_TARGET_HERO,
		DOTA_UNIT_TARGET_FLAG_NONE,
		FIND_ANY_ORDER,
		false
	)
	for ____, u in ipairs(hitUnits) do
		do
			if not IsValidAlive(nil, u) then
				goto __continue36
			end
			local knockDir = Vector(self.dir.x, self.dir.y, 0)
			u:KnockBack(caster, self.ability, {
				duration = HIT_KNOCKBACK_DURATION,
				distance = HIT_KNOCKBACK_DISTANCE,
				height = HIT_KNOCKBACK_HEIGHT,
				direction = knockDir,
				heightType = "parabola",
				destroyTreesType = "onDestroy",
				particleName = "",
				removeOnDeath = true,
				stun = true,
				stunDuration = 1,
			})
			AddDeBuffStatus(
				nil,
				u,
				caster,
				self.ability,
				DebuffStatusType.ICE_SLOW,
				{ stack = 5, duration = HIT_SLOW_DURATION }
			)
			caster:MonsterDamage({
				victim = u,
				damage_rate = self.ability:getThinkerHitDamageRate(),
				ability = self.ability,
			})
			self:Destroy()
			return
		end
		::__continue36::
	end
end
function modifier_elite_008_snowball.prototype.IsHidden(self)
	return true
end
function modifier_elite_008_snowball.prototype.IsPurgable(self)
	return false
end
modifier_elite_008_snowball =
	__TS__DecorateLegacy({ registerModifier(nil, "modifier_elite_008_snowball") }, modifier_elite_008_snowball)
return ____exports