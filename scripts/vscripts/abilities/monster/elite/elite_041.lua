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
local modifier_elite_041_jump
local ____dota_ts_adapter = require("utils.dota_ts_adapter")
local registerAbility = ____dota_ts_adapter.registerAbility
local registerModifier = ____dota_ts_adapter.registerModifier
local ____monster_base = require("abilities.monster.monster_base")
local MonsterAbility_CS = ____monster_base.MonsterAbility_CS
local MonsterModifier_CS = ____monster_base.MonsterModifier_CS
local ELITE_041_TOTAL_ACTION_TIME = 3.33
local ELITE_041_CAST_POINT = 0.6
local ELITE_041_IMPACT_TIME = 1.63
local ELITE_041_AIR_TIME = ELITE_041_IMPACT_TIME - ELITE_041_CAST_POINT
local ELITE_041_CAST_DURATION = ELITE_041_TOTAL_ACTION_TIME - ELITE_041_CAST_POINT - 0.4
local ELITE_041_TARGET_SEARCH_RANGE = 1500
local ELITE_041_RISE_TIME = 0.2
local ELITE_041_FALL_TIME = 0.2
local ELITE_041_HOVER_TIME = ELITE_041_AIR_TIME - ELITE_041_RISE_TIME - ELITE_041_FALL_TIME
local ELITE_041_JUMP_HEIGHT = 400
local ELITE_041_WEAPON_HIT_OFFSET = 300
local ELITE_041_JUMP_EFFECT_RADIUS = 550
local ELITE_041_JUMP_DAMAGE_RATE = 20
local ELITE_041_JUMP_KNOCKBACK_DISTANCE = 220
local ELITE_041_JUMP_KNOCKBACK_DURATION = 0.25
local ELITE_041_JUMP_KNOCKBACK_HEIGHT = 120
local ELITE_041_LAND_EFFECT_FORWARD_OFFSET = 300
local ELITE_041_LAND_DAMAGE_RADIUS = 500
local ELITE_041_LAND_DAMAGE_RATE = 60
local ELITE_041_LAND_MIN_DAMAGE_RATE = 25
local ELITE_041_LAND_STUN_DURATION = 2
local ELITE_041_LAND_CORE_EFFECT_RADIUS = 400
local ELITE_041_LAND_WAVE_INTERVAL = 0.03
local ELITE_041_RISE_POWER = 0.25
local ELITE_041_FALL_POWER = 0.25
local ELITE_041_JUMP_EFFECT_PARTICLE =
	"particles/units/heroes/hero_dawnbreaker/dawnbreaker_elated_fury_landing_dust.vpcf"
local ELITE_041_LAND_CORE_EFFECT_PARTICLE = "particles/units/heroes/hero_primal_beast/primal_beast_pulverize_hit.vpcf"
local ELITE_041_LAND_EFFECT_PARTICLE = "particles/units/heroes/hero_primal_beast/primal_beast_rock_throw_impact.vpcf"
--- 精英技能41 - 原地跃起后落地砸地
____exports.elite_041 = __TS__Class()
local elite_041 = ____exports.elite_041
elite_041.name = "elite_041"
__TS__ClassExtends(elite_041, MonsterAbility_CS)
function elite_041.prototype.Precache(self, context)
	PrecacheResource("particle", ELITE_041_JUMP_EFFECT_PARTICLE, context)
	PrecacheResource("particle", ELITE_041_LAND_CORE_EFFECT_PARTICLE, context)
	PrecacheResource("particle", ELITE_041_LAND_EFFECT_PARTICLE, context)
end
function elite_041.prototype.GetMosnterAbilityConfig(self)
	return {
		behavior = DOTA_ABILITY_BEHAVIOR_NO_TARGET,
		castPoint = ELITE_041_CAST_POINT,
		castDuration = ELITE_041_CAST_DURATION,
		castAnimation = ACT_DOTA_CAST_ABILITY_3,
		OnPhaseStart = function()
			local caster = self:GetCaster()
			if not IsValidAlive(nil, caster) then
				return
			end
			self:Timer(ELITE_041_CAST_POINT - 0.2, function()
				return self:PlayJumpStartEffect(caster)
			end)
		end,
		OnStart = function()
			local caster = self:GetCaster()
			if not IsValidAlive(nil, caster) then
				return
			end
			caster:EmitSound("Hero_Spirit_Breaker.ChargeOfDarkness")
			local target = caster:GetMinDistanceUnit(ELITE_041_TARGET_SEARCH_RANGE)
			local targetPos = caster:GetAbsOrigin()
			if IsValidAlive(nil, target) then
				local origin = caster:GetAbsOrigin()
				local rawTargetPos = target:GetAbsOrigin()
				local direction = GetDirection(nil, rawTargetPos, origin)
				local distance = GetDistance(nil, origin, rawTargetPos)
				local landDistance = math.max(distance - ELITE_041_WEAPON_HIT_OFFSET, 0)
				targetPos = origin:__add(direction:__mul(landDistance))
				caster:LockTargetForSpeed(target, 0.8)
			end
			targetPos = Vector(targetPos.x, targetPos.y, GetGroundHeight(targetPos, caster) or targetPos.z)
			caster:SetCustomValue("elite_041_target_x", targetPos.x)
			caster:SetCustomValue("elite_041_target_y", targetPos.y)
			caster:SetCustomValue("elite_041_target_z", targetPos.z)
			modifier_elite_041_jump:remove(caster)
			modifier_elite_041_jump:applys(caster, caster, self, {
				duration = ELITE_041_AIR_TIME,
				target_x = caster:GetCustomValue("elite_041_target_x"),
				target_y = caster:GetCustomValue("elite_041_target_y"),
				target_z = caster:GetCustomValue("elite_041_target_z"),
			})
		end,
		OnInterrupt = function()
			local caster = self:GetCaster()
			if not IsValid(nil, caster) or caster:IsNull() then
				return
			end
			modifier_elite_041_jump:remove(caster)
		end,
	}
end
function elite_041.prototype.PlayJumpStartEffect(self, caster)
	local origin = caster:GetAbsOrigin()
	local pfx = ParticleManager:CreateParticle(ELITE_041_JUMP_EFFECT_PARTICLE, PATTACH_WORLDORIGIN, nil)
	ParticleManager:SetParticleControl(pfx, 0, origin)
	ParticleManager:SetParticleControl(pfx, 1, origin)
	ParticleManager:SetParticleControl(
		pfx,
		2,
		Vector(ELITE_041_JUMP_EFFECT_RADIUS, ELITE_041_JUMP_EFFECT_RADIUS, ELITE_041_JUMP_EFFECT_RADIUS)
	)
	ParticleManager:ReleaseParticleIndex(pfx)
end
function elite_041.prototype.HitJumpStartEnemies(self, caster)
	local origin = caster:GetAbsOrigin()
	local enemies = FindUnitsInRadius(
		caster:GetTeamNumber(),
		origin,
		nil,
		ELITE_041_JUMP_EFFECT_RADIUS,
		DOTA_UNIT_TARGET_TEAM_ENEMY,
		DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,
		DOTA_UNIT_TARGET_FLAG_NONE,
		FIND_ANY_ORDER,
		false
	)
	for ____, enemy in ipairs(enemies) do
		do
			if not IsValidAlive(nil, enemy) then
				goto __continue14
			end
			caster:MonsterDamage({ victim = enemy, damage_rate = ELITE_041_JUMP_DAMAGE_RATE, ability = self })
			enemy:KnockBack(caster, self, {
				duration = ELITE_041_JUMP_KNOCKBACK_DURATION,
				distance = ELITE_041_JUMP_KNOCKBACK_DISTANCE,
				height = ELITE_041_JUMP_KNOCKBACK_HEIGHT,
				particleName = "",
				stun = true,
			})
		end
		::__continue14::
	end
end
function elite_041.prototype.PlayLandingImpact(self, caster, forward)
	if not IsValidAlive(nil, caster) then
		return
	end
	caster:EmitSound("Hero_Mars.Spear.Root")
	local center = caster:GetAbsOrigin():__add(forward:__mul(ELITE_041_LAND_EFFECT_FORWARD_OFFSET))
	center.z = GetGroundHeight(center, caster) or center.z
	self:PlayLandingCoreEffect(center)
	self:PlayLandingWaveEffects(center, caster)
	ScreenShake(center, 25, 25, 1, 2500, 0, true)
	local enemies = FindUnitsInRadius(
		caster:GetTeamNumber(),
		center,
		nil,
		ELITE_041_LAND_DAMAGE_RADIUS,
		DOTA_UNIT_TARGET_TEAM_ENEMY,
		DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,
		DOTA_UNIT_TARGET_FLAG_NONE,
		FIND_ANY_ORDER,
		false
	)
	for ____, enemy in ipairs(enemies) do
		do
			if not IsValidAlive(nil, enemy) then
				goto __continue19
			end
			local distance = GetDistance(nil, center, enemy:GetAbsOrigin())
			local clampedDistance = math.min(distance, ELITE_041_LAND_DAMAGE_RADIUS)
			local t = clampedDistance / ELITE_041_LAND_DAMAGE_RADIUS
			local damageRate = ELITE_041_LAND_DAMAGE_RATE
				- (ELITE_041_LAND_DAMAGE_RATE - ELITE_041_LAND_MIN_DAMAGE_RATE) * t
			AddDeBuffStatus(
				nil,
				enemy,
				caster,
				self,
				DebuffStatusType.STUN,
				{ duration = ELITE_041_LAND_STUN_DURATION }
			)
			caster:MonsterDamage({ victim = enemy, damage_rate = damageRate, ability = self })
		end
		::__continue19::
	end
end
function elite_041.prototype.PlayLandingWarning(self, landPos, caster, forward)
	local center = landPos:__add(forward:__mul(ELITE_041_LAND_EFFECT_FORWARD_OFFSET))
	center.z = GetGroundHeight(center, caster) or center.z
	self:WarningRingEffect(center, 450, 0.3)
end
function elite_041.prototype.PlayLandingCoreEffect(self, center)
	local pfx = ParticleManager:CreateParticle(ELITE_041_LAND_CORE_EFFECT_PARTICLE, PATTACH_WORLDORIGIN, nil)
	ParticleManager:SetParticleControl(pfx, 0, center)
	ParticleManager:SetParticleControl(pfx, 1, Vector(ELITE_041_LAND_CORE_EFFECT_RADIUS, 0, 0))
	ParticleManager:SetParticleControl(pfx, 3, center)
	ParticleManager:ReleaseParticleIndex(pfx)
end
function elite_041.prototype.PlayLandingWaveEffects(self, center, caster)
	local dummy = CreateModifierThinker(
		caster,
		self,
		"modifier_dummy_thinker",
		{ duration = 5 },
		center,
		caster:GetTeamNumber(),
		false
	)
	EmitSoundOnLocationWithCaster(center, "Hero_Mars.Spear.Target", dummy)
	Timers:CreateTimer(ELITE_041_LAND_WAVE_INTERVAL, function()
		local pfx = ParticleManager:CreateParticle(ELITE_041_LAND_EFFECT_PARTICLE, PATTACH_WORLDORIGIN, nil)
		ParticleManager:SetParticleControl(pfx, 3, center)
		ParticleManager:ReleaseParticleIndex(pfx)
	end)
end
elite_041 = __TS__DecorateLegacy({ registerAbility(nil) }, elite_041)
____exports.elite_041 = elite_041
modifier_elite_041_jump = __TS__Class()
modifier_elite_041_jump.name = "modifier_elite_041_jump"
__TS__ClassExtends(modifier_elite_041_jump, MonsterModifier_CS)
function modifier_elite_041_jump.prototype.____constructor(self, ...)
	MonsterModifier_CS.prototype.____constructor(self, ...)
	self._groundZ = 0
	self._elapsed = 0
	self._warningShown = false
end
function modifier_elite_041_jump.prototype.OnCreated(self, params)
	if not IsServer() then
		return
	end
	local parent = self:GetParent()
	if not IsValidAlive(nil, parent) then
		self:Destroy()
		return
	end
	local origin = parent:GetAbsOrigin()
	self._groundZ = GetGroundHeight(origin, parent) or origin.z
	self._originPos = Vector(origin.x, origin.y, self._groundZ)
	local targetX = params.target_x or origin.x
	local targetY = params.target_y or origin.y
	local rawTargetZ = params.target_z or self._groundZ
	self._targetPos = Vector(targetX, targetY, rawTargetZ)
	self._forward = GetDirection(nil, self._targetPos, self._originPos)
	if self._forward:Length2D() > 0.01 then
		parent:SetForwardVector(self._forward)
	end
	self._elapsed = 0
	self:OnIntervalThink()
	self:StartIntervalThink(FrameTime())
end
function modifier_elite_041_jump.prototype.OnIntervalThink(self)
	if not IsServer() then
		return
	end
	local parent = self:GetParent()
	if not IsValidAlive(nil, parent) or not self._originPos or not self._targetPos then
		self:Destroy()
		return
	end
	local dt = FrameTime()
	self._elapsed = self._elapsed + dt
	local time = math.min(self._elapsed, ELITE_041_AIR_TIME)
	local x = self._originPos.x
	local y = self._originPos.y
	if time > ELITE_041_RISE_TIME + ELITE_041_HOVER_TIME then
		self:TryPlayLandingWarning(parent)
		local fallProgress = math.min((time - ELITE_041_RISE_TIME - ELITE_041_HOVER_TIME) / ELITE_041_FALL_TIME, 1)
		local horizontalProgress = 1 - math.pow(1 - fallProgress, 1.6)
		x = self._originPos.x + (self._targetPos.x - self._originPos.x) * horizontalProgress
		y = self._originPos.y + (self._targetPos.y - self._originPos.y) * horizontalProgress
	end
	local height = 0
	if time <= ELITE_041_RISE_TIME then
		local riseProgress = math.min(time / ELITE_041_RISE_TIME, 1)
		height = ELITE_041_JUMP_HEIGHT * math.pow(riseProgress, ELITE_041_RISE_POWER)
	elseif time <= ELITE_041_RISE_TIME + ELITE_041_HOVER_TIME then
		height = ELITE_041_JUMP_HEIGHT
	else
		local fallProgress = math.min((time - ELITE_041_RISE_TIME - ELITE_041_HOVER_TIME) / ELITE_041_FALL_TIME, 1)
		height = ELITE_041_JUMP_HEIGHT * (1 - math.pow(fallProgress, ELITE_041_FALL_POWER))
	end
	parent:SetAbsOrigin(Vector(x, y, self._groundZ + height))
	if time >= ELITE_041_AIR_TIME then
		self:Destroy()
	end
end
function modifier_elite_041_jump.prototype.TryPlayLandingWarning(self, parent)
	if self._warningShown or not self._targetPos or not self._forward then
		return
	end
	self._warningShown = true
	local ability = self:GetAbility()
	if not ability then
		return
	end
	ability:PlayLandingWarning(self._targetPos, parent, self._forward)
end
function modifier_elite_041_jump.prototype.OnDestroy(self)
	if not IsServer() then
		return
	end
	local parent = self:GetParent()
	if not IsValid(nil, parent) or parent:IsNull() or not self._originPos or not self._targetPos then
		return
	end
	if not IsValidAlive(nil, parent) then
		return
	end
	parent:SetAbsOrigin(Vector(self._targetPos.x, self._targetPos.y, self._targetPos.z))
	FindClearSpaceForUnit(parent, parent:GetAbsOrigin(), true)
	local ability = self:GetAbility()
	if not ability or not self._forward then
		return
	end
	ability:PlayLandingImpact(parent, self._forward)
end
function modifier_elite_041_jump.prototype.CheckState(self)
	return { [MODIFIER_STATE_NO_UNIT_COLLISION] = true }
end
function modifier_elite_041_jump.prototype.IsHidden(self)
	return true
end
function modifier_elite_041_jump.prototype.IsPurgable(self)
	return false
end
modifier_elite_041_jump =
	__TS__DecorateLegacy({ registerModifier(nil, "modifier_elite_041_jump") }, modifier_elite_041_jump)
return ____exports