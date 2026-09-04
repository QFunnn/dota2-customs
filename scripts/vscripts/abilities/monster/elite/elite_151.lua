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
local modifier_elite_151_roll
local ____dota_ts_adapter = require("utils.dota_ts_adapter")
local registerAbility = ____dota_ts_adapter.registerAbility
local registerModifier = ____dota_ts_adapter.registerModifier
local ____monster_base = require("abilities.monster.monster_base")
local MonsterAbility_CS = ____monster_base.MonsterAbility_CS
local MonsterModifier_CS = ____monster_base.MonsterModifier_CS
local CAST_RANGE = 1200
local CAST_POINT = 0
local ROLL_COUNT = 3
local ROLL_PREP_DURATION = 0.7
local ROLL_DISTANCE = 1100
local ROLL_SPEED = 3000
local ROLL_DURATION = ROLL_DISTANCE / ROLL_SPEED
local CAST_DURATION = ROLL_COUNT * (ROLL_PREP_DURATION + ROLL_DURATION) + 0.35
local HIT_RADIUS = 175
local WARNING_WIDTH = HIT_RADIUS
local DAMAGE_RATE = 20
local STUN_DURATION = 0.45
local ROLL_PARTICLE = "particles/units/heroes/hero_earth_spirit/espirit_rollingboulder.vpcf"
local CAST_SOUND = "Hero_EarthSpirit.RollingBoulder.Cast"
local LOOP_SOUND = "Hero_EarthSpirit.RollingBoulder.Loop"
local HIT_SOUND = "Hero_EarthSpirit.RollingBoulder.Target"
local DESTROY_SOUND = "Hero_EarthSpirit.RollingBoulder.Destroy"
--- 岩轮连冲：连续三次锁定最近敌人方向翻滚，穿透路径敌人并造成短眩晕。
____exports.elite_151 = __TS__Class()
local elite_151 = ____exports.elite_151
elite_151.name = "elite_151"
__TS__ClassExtends(elite_151, MonsterAbility_CS)
function elite_151.prototype.____constructor(self, ...)
	MonsterAbility_CS.prototype.____constructor(self, ...)
	self.sequence = 0
end
function elite_151.prototype.Precache(self, context)
	PrecacheResource("particle", ROLL_PARTICLE, context)
end
function elite_151.prototype.GetMosnterAbilityConfig(self)
	return {
		castRange = CAST_RANGE,
		behavior = DOTA_ABILITY_BEHAVIOR_NO_TARGET,
		castPoint = CAST_POINT,
		castDuration = CAST_DURATION,
		castAnimation = ACT_DOTA_CAST_ABILITY_2,
		cooldown = 8,
		OnPhaseStart = function()
			local caster = self:GetCaster()
			if not IsValidAlive(nil, caster) then
				return
			end
			local direction = self:ResolveRollDirection(caster)
			self.currentDirection = direction
		end,
		OnStart = function()
			local caster = self:GetCaster()
			if not IsValidAlive(nil, caster) then
				return
			end
			self.sequence = self.sequence + 1
			self:StartRollSegment(caster, 1, self.currentDirection or self:ResolveRollDirection(caster), self.sequence)
		end,
		OnFinish = function()
			return self:Cleanup()
		end,
		OnInterrupt = function()
			return self:Cleanup()
		end,
	}
end
function elite_151.prototype.OnRollSegmentFinished(self, segment, sequence)
	local caster = self:GetCaster()
	if sequence ~= self.sequence or not IsValidAlive(nil, caster) then
		return
	end
	if segment >= ROLL_COUNT then
		return
	end
	local nextSegment = segment + 1
	local direction = self:ResolveRollDirection(caster)
	local target = caster:GetMinDistanceUnit(CAST_RANGE)
	if IsValidAlive(nil, target) then
		caster:LockTargetForSpeed(target, ROLL_PREP_DURATION, 8)
	end
	self:StartRollSegment(caster, nextSegment, direction, sequence)
end
function elite_151.prototype.StartRollSegment(self, caster, segment, direction, sequence)
	local startPos = caster:GetAbsOrigin()
	caster:SetForwardVector(direction)
	self:WarnRollPath(caster, direction, ROLL_PREP_DURATION)
	EmitSoundOn(CAST_SOUND, caster)
	modifier_elite_151_roll:applys(caster, caster, self, {
		duration = ROLL_PREP_DURATION + ROLL_DURATION + 0.15,
		dirX = direction.x,
		dirY = direction.y,
		dirZ = direction.z,
		startX = startPos.x,
		startY = startPos.y,
		startZ = startPos.z,
		segment = segment,
		sequence = sequence,
	})
end
function elite_151.prototype.ResolveRollDirection(self, caster)
	local target = caster:GetMinDistanceUnit(CAST_RANGE)
	if IsValidAlive(nil, target) then
		caster:LockTargetForSpeed(target, ROLL_PREP_DURATION, 8)
		local direction = GetDirection(nil, target:GetAbsOrigin(), caster:GetAbsOrigin())
		if direction:Length2D() > 0.01 then
			return direction
		end
	end
	return caster:GetForwardVector()
end
function elite_151.prototype.WarnRollPath(self, caster, direction, duration)
	local origin = caster:GetAbsOrigin()
	local ____end = origin:__add(direction:__mul(ROLL_DISTANCE))
	self:WarningEffect(origin, ____end, duration, { startWidth = WARNING_WIDTH, endWidth = WARNING_WIDTH })
end
function elite_151.prototype.Cleanup(self)
	self.sequence = self.sequence + 1
	local caster = self:GetCaster()
	if IsValidAlive(nil, caster) then
		caster:RemoveModifierByName("modifier_elite_151_roll")
	end
	self.currentDirection = nil
end
elite_151 = __TS__DecorateLegacy({ registerAbility(nil) }, elite_151)
____exports.elite_151 = elite_151
modifier_elite_151_roll = __TS__Class()
modifier_elite_151_roll.name = "modifier_elite_151_roll"
__TS__ClassExtends(modifier_elite_151_roll, MonsterModifier_CS)
function modifier_elite_151_roll.prototype.____constructor(self, ...)
	MonsterModifier_CS.prototype.____constructor(self, ...)
	self.direction = Vector(1, 0, 0)
	self.segment = 1
	self.sequence = 0
	self.traveled = 0
	self.elapsed = 0
	self.rolling = false
	self.hitTargets = __TS__New(Set)
	self.finished = false
end
function modifier_elite_151_roll.prototype.OnCreated(self, params)
	if not IsServer() then
		return
	end
	self.direction = Vector(tonumber(params.dirX) or 0, tonumber(params.dirY) or 0, tonumber(params.dirZ) or 0)
	if self.direction:Length2D() <= 0.01 then
		self.direction = self:GetParent():GetForwardVector()
	else
		self.direction = self.direction:Normalized()
	end
	self.segment = math.max(1, math.floor(tonumber(params.segment) or 1))
	self.sequence = math.floor(tonumber(params.sequence) or 0)
	self:GetParent():SetForwardVector(self.direction)
	self:GetParent():StartGesture(ACT_DOTA_CAST_ABILITY_2_ES_ROLL_START)
	self:CreateRollParticle(params)
	EmitSoundOn(LOOP_SOUND, self:GetParent())
	self:StartIntervalThink(FrameTime())
end
function modifier_elite_151_roll.prototype.OnDestroy(self)
	if not IsServer() then
		return
	end
	local parent = self:GetParent()
	self:DestroyRollParticle()
	StopSoundOn(LOOP_SOUND, parent)
	parent:RemoveGesture(ACT_DOTA_CAST_ABILITY_2_ES_ROLL_START)
	parent:RemoveGesture(ACT_DOTA_CAST_ABILITY_2_ES_ROLL)
	parent:StartGesture(ACT_DOTA_CAST_ABILITY_2_ES_ROLL_END)
	Timers:CreateTimer(0.6, function()
		if not IsValidAlive(nil, parent) then
			return
		end
		if not IsValid(nil, parent) or parent:IsNull() then
			return
		end
		parent:RemoveGesture(ACT_DOTA_CAST_ABILITY_2_ES_ROLL_END)
	end)
	if IsValid(nil, parent) and not parent:IsNull() then
		FindClearSpaceForUnit(parent, parent:GetAbsOrigin(), false)
	end
	EmitSoundOn(DESTROY_SOUND, parent)
	local ability = self:GetAbility()
	if ability and not self.finished then
		self.finished = true
		ability:OnRollSegmentFinished(self.segment, self.sequence)
	end
end
function modifier_elite_151_roll.prototype.DeclareFunctions(self)
	return { MODIFIER_PROPERTY_OVERRIDE_ANIMATION }
end
function modifier_elite_151_roll.prototype.GetOverrideAnimation(self)
	local ____table_rolling_0
	if self.rolling then
		____table_rolling_0 = ACT_DOTA_CAST_ABILITY_2_ES_ROLL
	else
		____table_rolling_0 = ACT_DOTA_CAST_ABILITY_2_ES_ROLL_START
	end
	return ____table_rolling_0
end
function modifier_elite_151_roll.prototype.CheckState(self)
	return {
		[MODIFIER_STATE_ROOTED] = true,
		[MODIFIER_STATE_DISARMED] = true,
		[MODIFIER_STATE_NO_UNIT_COLLISION] = true,
		[MODIFIER_STATE_INVULNERABLE] = true,
		[MODIFIER_STATE_UNSELECTABLE] = true,
		[MODIFIER_STATE_NO_HEALTH_BAR] = true,
	}
end
function modifier_elite_151_roll.prototype.OnIntervalThink(self)
	local me = self:GetParent()
	if not IsValidAlive(nil, me) then
		self:Destroy()
		return
	end
	local dt = FrameTime()
	self.elapsed = self.elapsed + dt
	me:SetForwardVector(self.direction)
	if not self.rolling then
		if self.elapsed < ROLL_PREP_DURATION then
			return
		end
		self.rolling = true
		me:RemoveGesture(ACT_DOTA_CAST_ABILITY_2_ES_ROLL_START)
		me:StartGesture(ACT_DOTA_CAST_ABILITY_2_ES_ROLL)
	end
	local origin = me:GetAbsOrigin()
	local step = ROLL_SPEED * dt
	local nextPos = origin:__add(self.direction:__mul(step))
	nextPos.z = GetGroundHeight(nextPos, me) or origin.z
	if not GridNav:IsTraversable(nextPos) or GridNav:IsBlocked(nextPos) then
		self:Destroy()
		return
	end
	me:SetForwardVector(self.direction)
	me:SetAbsOrigin(nextPos)
	GridNav:DestroyTreesAroundPoint(nextPos, HIT_RADIUS, false)
	self.traveled = self.traveled + step
	self:HitEnemies(nextPos)
	if self.traveled >= ROLL_DISTANCE then
		self:Destroy()
	end
end
function modifier_elite_151_roll.prototype.IsHidden(self)
	return true
end
function modifier_elite_151_roll.prototype.HitEnemies(self, center)
	local parent = self:GetParent()
	local ability = self:GetAbility()
	if not ability or not IsValidAlive(nil, parent) then
		return
	end
	local enemies = FindUnitsInRadius(
		parent:GetTeamNumber(),
		center,
		nil,
		HIT_RADIUS,
		DOTA_UNIT_TARGET_TEAM_ENEMY,
		DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,
		DOTA_UNIT_TARGET_FLAG_NONE,
		FIND_ANY_ORDER,
		false
	)
	for ____, enemy in ipairs(enemies) do
		do
			if not IsValidAlive(nil, enemy) then
				goto __continue44
			end
			local index = enemy:GetEntityIndex()
			if self.hitTargets:has(index) then
				goto __continue44
			end
			self.hitTargets:add(index)
			parent:MonsterDamage({ victim = enemy, damage_rate = DAMAGE_RATE, ability = ability })
			AddDeBuffStatus(nil, enemy, parent, ability, DebuffStatusType.STUN, { duration = STUN_DURATION })
			EmitSoundOn(HIT_SOUND, enemy)
		end
		::__continue44::
	end
end
function modifier_elite_151_roll.prototype.CreateRollParticle(self, params)
	local parent = self:GetParent()
	local startPos = Vector(
		tonumber(params.startX) or parent:GetAbsOrigin().x,
		tonumber(params.startY) or parent:GetAbsOrigin().y,
		tonumber(params.startZ) or parent:GetAbsOrigin().z
	)
	self.particleId = ParticleManager:CreateParticle(ROLL_PARTICLE, PATTACH_ABSORIGIN_FOLLOW, parent)
	ParticleManager:SetParticleControlEnt(
		self.particleId,
		0,
		parent,
		PATTACH_ABSORIGIN_FOLLOW,
		"attach_hitloc",
		parent:GetAbsOrigin(),
		true
	)
	ParticleManager:SetParticleControl(self.particleId, 3, startPos)
end
function modifier_elite_151_roll.prototype.DestroyRollParticle(self)
	if self.particleId == nil then
		return
	end
	ParticleManager:DestroyParticle(self.particleId, false)
	ParticleManager:ReleaseParticleIndex(self.particleId)
	self.particleId = nil
end
modifier_elite_151_roll =
	__TS__DecorateLegacy({ registerModifier(nil, "modifier_elite_151_roll") }, modifier_elite_151_roll)
return ____exports