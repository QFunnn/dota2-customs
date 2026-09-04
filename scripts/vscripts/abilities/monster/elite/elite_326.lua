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
local modifier_elite_326_frost_dash
local ____dota_ts_adapter = require("utils.dota_ts_adapter")
local registerAbility = ____dota_ts_adapter.registerAbility
local registerModifier = ____dota_ts_adapter.registerModifier
local ____monster_base = require("abilities.monster.monster_base")
local MonsterAbility_CS = ____monster_base.MonsterAbility_CS
local MonsterModifier_CS = ____monster_base.MonsterModifier_CS
local CAST_RANGE = 950
local CAST_POINT = 0.5
local DASH_DISTANCE = 720
local DASH_DURATION = 0.3
local SLASH_DELAY = 0.08
local CAST_DURATION = DASH_DURATION + SLASH_DELAY + 0.3
local STOP_DISTANCE = 90
local WARNING_WIDTH = 180
local SLASH_RADIUS = 360
local SLASH_ANGLE_DEG = 120
local SLASH_DAMAGE_RATE = 28
local SLASH_FORWARD_OFFSET = 80
local SCREEN_SHAKE_AMPLITUDE = 10
local SCREEN_SHAKE_FREQUENCY = 10
local SCREEN_SHAKE_DURATION = 0.2
local SCREEN_SHAKE_RADIUS = 1600
local DASH_PARTICLE = "particles/bb/ss_primal_beast_2022_prestige_onslaught_charge_active_test2.vpcf"
local SLASH_PARTICLE = "particles/dd/attack_01.vpcf"
local IMPACT_PARTICLE = "particles/units/heroes/hero_abaddon/abaddon_death_coil.vpcf"
local DASH_SOUND = "Hero_Abaddon.DeathCoil.Cast"
local SLASH_SOUND = "Hero_Abaddon.DeathCoil.Target"
____exports.elite_326 = __TS__Class()
local elite_326 = ____exports.elite_326
elite_326.name = "elite_326"
__TS__ClassExtends(elite_326, MonsterAbility_CS)
function elite_326.prototype.____constructor(self, ...)
	MonsterAbility_CS.prototype.____constructor(self, ...)
	self.sequence = 0
end
function elite_326.prototype.Precache(self, context)
	PrecacheResource("particle", DASH_PARTICLE, context)
	PrecacheResource("particle", SLASH_PARTICLE, context)
	PrecacheResource("particle", IMPACT_PARTICLE, context)
end
function elite_326.prototype.GetMosnterAbilityConfig(self)
	return {
		castRange = CAST_RANGE,
		behavior = DOTA_ABILITY_BEHAVIOR_NO_TARGET,
		castPoint = CAST_POINT,
		castDuration = CAST_DURATION,
		castAnimation = ACT_DOTA_CAST_ABILITY_1,
		cooldown = 5,
		OnPhaseStart = function()
			return self:PrepareDash()
		end,
		OnStart = function()
			return self:StartDashSlash()
		end,
		OnInterrupt = function()
			return self:CleanupDashState()
		end,
		OnFinish = function()
			return self:CleanupDashState()
		end,
	}
end
function elite_326.prototype.PrepareDash(self)
	local caster = self:GetCaster()
	if not IsValidAlive(nil, caster) then
		return
	end
	local target = self:FindTarget()
	local direction = self:ResolveDashDirection(caster, target)
	local endPoint = self:ResolveDashEndPoint(caster, direction, target)
	self.dashDirection = direction
	self.dashEndPoint = endPoint
	if IsValidAlive(nil, target) then
		caster:LockTargetForSpeed(target, CAST_POINT, 5)
	end
	caster:SetForwardVectorWithoutInterrupt(direction)
	local origin = GetGroundPosition(caster:GetAbsOrigin(), caster)
	self:WarningEffect(origin, endPoint, CAST_POINT, { startWidth = WARNING_WIDTH, endWidth = WARNING_WIDTH })
	self:WarningRingEffect(
		self:ResolveSlashCenter(endPoint, direction, caster),
		SLASH_RADIUS,
		CAST_POINT + DASH_DURATION + SLASH_DELAY
	)
end
function elite_326.prototype.StartDashSlash(self)
	local caster = self:GetCaster()
	if not IsValidAlive(nil, caster) then
		return
	end
	self.sequence = self.sequence + 1
	local currentSequence = self.sequence
	local target = self:FindTarget()
	local direction = self.dashDirection or self:ResolveDashDirection(caster, target)
	local endPoint = self.dashEndPoint or self:ResolveDashEndPoint(caster, direction, target)
	caster:SetForwardVectorWithoutInterrupt(direction)
	modifier_elite_326_frost_dash:applys(caster, caster, self, { duration = DASH_DURATION + SLASH_DELAY })
	EmitSoundOn(DASH_SOUND, caster)
	ScreenShake(
		caster:GetAbsOrigin(),
		SCREEN_SHAKE_AMPLITUDE,
		SCREEN_SHAKE_FREQUENCY,
		SCREEN_SHAKE_DURATION,
		SCREEN_SHAKE_RADIUS,
		0,
		true
	)
	caster:Mover(endPoint, DASH_DURATION, nil, nil, true)
	self:Timer(DASH_DURATION + SLASH_DELAY, function()
		return self:PerformSlash(currentSequence, direction)
	end)
end
function elite_326.prototype.PerformSlash(self, sequence, direction)
	local caster = self:GetCaster()
	if sequence ~= self.sequence or not IsValidAlive(nil, caster) then
		return
	end
	FindClearSpaceForUnit(caster, caster:GetAbsOrigin(), true)
	local origin = GetGroundPosition(caster:GetAbsOrigin(), caster)
	local forward = self:FlatDirection(direction)
	caster:SetForwardVectorWithoutInterrupt(forward)
	caster:StartGestureWithPlaybackRate(ACT_DOTA_ATTACK, 1.35)
	local slashCenter = self:ResolveSlashCenter(origin, forward, caster)
	self:PlaySlashEffect(caster, slashCenter, forward)
	self:DamageSlashEnemies(caster, slashCenter, forward)
	modifier_elite_326_frost_dash:remove(caster)
end
function elite_326.prototype.DamageSlashEnemies(self, caster, origin, forward)
	local enemies = FindUnitsInCone(
		nil,
		caster:GetTeamNumber(),
		origin,
		nil,
		SLASH_RADIUS,
		forward,
		SLASH_ANGLE_DEG,
		DOTA_UNIT_TARGET_TEAM_ENEMY,
		DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,
		DOTA_UNIT_TARGET_FLAG_NONE,
		FIND_ANY_ORDER,
		false
	)
	for ____, enemy in ipairs(enemies) do
		do
			if not IsValidAlive(nil, enemy) then
				goto __continue17
			end
			caster:MonsterDamage({
				victim = enemy,
				damage_rate = SLASH_DAMAGE_RATE,
				ability = self,
				effectName = IMPACT_PARTICLE,
			})
		end
		::__continue17::
	end
end
function elite_326.prototype.PlaySlashEffect(self, caster, origin, forward)
	local particle = ParticleManager:CreateParticle(SLASH_PARTICLE, PATTACH_WORLDORIGIN, caster)
	ParticleManager:SetParticleControl(particle, 0, origin)
	ParticleManager:SetParticleControl(particle, 4, origin:__add(forward:__mul(SLASH_RADIUS)))
	ParticleManager:SetParticleControlForward(particle, 0, forward)
	ParticleManager:ReleaseParticleIndex(particle)
	EmitSoundOnLocationWithCaster(origin, SLASH_SOUND, caster)
	ScreenShake(
		origin,
		SCREEN_SHAKE_AMPLITUDE,
		SCREEN_SHAKE_FREQUENCY,
		SCREEN_SHAKE_DURATION,
		SCREEN_SHAKE_RADIUS,
		0,
		true
	)
end
function elite_326.prototype.ResolveDashDirection(self, caster, target)
	if IsValidAlive(nil, target) then
		local direction = GetDirection(nil, target:GetAbsOrigin(), caster:GetAbsOrigin())
		if direction:Length2D() > 0.01 then
			return direction
		end
	end
	return self:FlatDirection(caster:GetForwardVector())
end
function elite_326.prototype.ResolveDashEndPoint(self, caster, direction, target)
	local origin = GetGroundPosition(caster:GetAbsOrigin(), caster)
	local distance = DASH_DISTANCE
	if IsValidAlive(nil, target) then
		distance = math.min(math.max(GetDistance(nil, origin, target:GetAbsOrigin()) - STOP_DISTANCE, 0), DASH_DISTANCE)
	end
	local intendedEndPoint = GetGroundPosition(origin:__add(self:FlatDirection(direction):__mul(distance)), caster)
	return self:ResolveSafeDashEndPoint(caster, origin, intendedEndPoint) or origin
end
function elite_326.prototype.ResolveSafeDashEndPoint(self, caster, origin, intendedEndPoint)
	local startPoint = GetGroundPosition(origin, caster)
	local endPoint = GetGroundPosition(intendedEndPoint, caster)
	if not IsGridNavDisplacementWalkable(nil, startPoint) or not IsGridNavDisplacementWalkable(nil, endPoint) then
		return nil
	end
	if not GridNav:CanFindPath(startPoint, endPoint) then
		return nil
	end
	local ____temp_0
	if GridNav:FindPathLength(startPoint, endPoint) ~= -1 then
		____temp_0 = endPoint
	else
		____temp_0 = nil
	end
	return ____temp_0
end
function elite_326.prototype.ResolveSlashCenter(self, origin, direction, caster)
	return GetGroundPosition(origin:__add(self:FlatDirection(direction):__mul(SLASH_FORWARD_OFFSET)), caster)
end
function elite_326.prototype.FindTarget(self)
	local caster = self:GetCaster()
	if not IsValidAlive(nil, caster) then
		return nil
	end
	return caster:GetMinDistanceUnit(CAST_RANGE)
end
function elite_326.prototype.FlatDirection(self, direction)
	local flat = Vector(direction.x, direction.y, 0)
	local ____temp_1
	if flat:Length2D() > 0.01 then
		____temp_1 = flat:Normalized()
	else
		____temp_1 = Vector(1, 0, 0)
	end
	return ____temp_1
end
function elite_326.prototype.CleanupDashState(self)
	self.sequence = self.sequence + 1
	self.dashDirection = nil
	self.dashEndPoint = nil
	local caster = self:GetCaster()
	if IsValidAlive(nil, caster) then
		modifier_elite_326_frost_dash:remove(caster)
	end
end
elite_326 = __TS__DecorateLegacy({ registerAbility(nil) }, elite_326)
____exports.elite_326 = elite_326
modifier_elite_326_frost_dash = __TS__Class()
modifier_elite_326_frost_dash.name = "modifier_elite_326_frost_dash"
__TS__ClassExtends(modifier_elite_326_frost_dash, MonsterModifier_CS)
function modifier_elite_326_frost_dash.prototype.GetEffectName(self)
	return DASH_PARTICLE
end
function modifier_elite_326_frost_dash.prototype.CheckState(self)
	return { [MODIFIER_STATE_NO_UNIT_COLLISION] = true }
end
function modifier_elite_326_frost_dash.prototype.IsHidden(self)
	return true
end
function modifier_elite_326_frost_dash.prototype.IsPurgable(self)
	return false
end
modifier_elite_326_frost_dash =
	__TS__DecorateLegacy({ registerModifier(nil, "modifier_elite_326_frost_dash") }, modifier_elite_326_frost_dash)
return ____exports