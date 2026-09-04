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
local modifier_elite_145_shadow
local ____dota_ts_adapter = require("utils.dota_ts_adapter")
local registerAbility = ____dota_ts_adapter.registerAbility
local registerModifier = ____dota_ts_adapter.registerModifier
local ____monster_base = require("abilities.monster.monster_base")
local MonsterAbility_CS = ____monster_base.MonsterAbility_CS
local MonsterModifier_CS = ____monster_base.MonsterModifier_CS
local CAST_POINT = 0.3
local SHADOW_DURATION = 1
local CAST_DURATION = SHADOW_DURATION
local SEARCH_RANGE = 1200
local BEHIND_DISTANCE = 180
local SLASH_RANGE = 380
local SLASH_HALF_ANGLE_DEG = 60
local SLASH_DAMAGE_RATE = 15
local SLASH_WARNING_DURATION = 0.2
local BLINK_START_EFFECT = "particles/units/heroes/hero_queenofpain/queen_blink_start.vpcf"
local BLINK_END_EFFECT = "particles/units/heroes/hero_queenofpain/queen_blink_end.vpcf"
local SLASH_EFFECT = "particles/dd/attack_02.vpcf"
--- 精英技能145 - 居合刺杀：隐入黑暗后绕至最近敌人身后并发动扇形斩击
____exports.elite_145 = __TS__Class()
local elite_145 = ____exports.elite_145
elite_145.name = "elite_145"
__TS__ClassExtends(elite_145, MonsterAbility_CS)
function elite_145.prototype.____constructor(self, ...)
	MonsterAbility_CS.prototype.____constructor(self, ...)
	self.castToken = 0
end
function elite_145.prototype.Precache(self, context)
	PrecacheResource("particle", BLINK_START_EFFECT, context)
	PrecacheResource("particle", BLINK_END_EFFECT, context)
	PrecacheResource("particle", SLASH_EFFECT, context)
end
function elite_145.prototype.GetMosnterAbilityConfig(self)
	return {
		castRange = SEARCH_RANGE,
		castPoint = CAST_POINT,
		castDuration = CAST_DURATION + 0.6,
		behavior = DOTA_ABILITY_BEHAVIOR_NO_TARGET + DOTA_ABILITY_BEHAVIOR_IGNORE_BACKSWING,
		castAnimation = ACT_DOTA_ATTACK,
		animationPlaybackRate = 1.2,
		isNotMove = true,
		castColor = Vector(80, 20, 120),
		OnPhaseStart = function()
			return self:PrepareCast()
		end,
		OnStart = function()
			return self:EnterShadow()
		end,
		OnFinish = function()
			return self:CleanupCast()
		end,
		OnInterrupt = function()
			return self:CleanupCast()
		end,
	}
end
function elite_145.prototype.PrepareCast(self)
	local caster = self:GetCaster()
	if not IsValidAlive(nil, caster) then
		return
	end
	local target = caster:GetMinDistanceUnit(SEARCH_RANGE)
	if target then
		caster:LockTargetForSpeed(target, CAST_POINT)
	end
	caster:EmitSound("Hero_QueenOfPain.Blink_out")
end
function elite_145.prototype.PlayPushEffect(self, caster)
	local origin = caster:GetAbsOrigin()
	local pfx = ParticleManager:CreateParticle("particles/kez_sai_ultimate_wave_2.vpcf", PATTACH_WORLDORIGIN, nil)
	ParticleManager:SetParticleControl(pfx, 0, origin)
	ParticleManager:SetParticleControl(pfx, 1, Vector(1250, 0, 1250))
	ParticleManager:ReleaseParticleIndex(pfx)
end
function elite_145.prototype.EnterShadow(self)
	local caster = self:GetCaster()
	if not IsValidAlive(nil, caster) then
		return
	end
	self:PlayPushEffect(caster)
	self.castToken = (self.castToken or 0) + 1
	local token = self.castToken
	self:PlayPointEffect(BLINK_START_EFFECT, caster:GetAbsOrigin())
	modifier_elite_145_shadow:applys(caster, caster, self, { duration = SHADOW_DURATION + 0.1 })
	caster:EmitSound("Hero_Nightstalker.Darkness.Team")
	self:Timer(SHADOW_DURATION, function()
		if token ~= self.castToken then
			return
		end
		if not IsValidAlive(nil, caster) then
			return
		end
		self:AmbushNearestEnemy(caster)
	end)
end
function elite_145.prototype.AmbushNearestEnemy(self, caster)
	modifier_elite_145_shadow:remove(caster)
	local target = caster:GetMinDistanceUnit(SEARCH_RANGE)
	if not IsValidAlive(nil, target) then
		self.castToken = (self.castToken or 0) + 1
		return
	end
	local landPos = self:ResolveBehindPosition(caster, target)
	if not self:IsValidBlinkPath(caster:GetAbsOrigin(), landPos) then
		return
	end
	FindClearSpaceForUnit(caster, landPos, true)
	local slashDirection = GetDirection(nil, target:GetAbsOrigin(), landPos)
	if slashDirection:Length2D() > 0.01 then
		caster:SetForwardVector(slashDirection)
	end
	self:PlayPointEffect(BLINK_END_EFFECT, landPos)
	caster:EmitSound("Hero_QueenOfPain.Blink_in")
	self:WarningEffect(
		landPos,
		landPos:__add(caster:GetForwardVector():__mul(200)),
		0.3,
		{ startWidth = 200, endWidth = 400, follow = true }
	)
	self:Timer(SLASH_WARNING_DURATION - 0.2, function()
		if not IsValidAlive(nil, caster) then
			return
		end
		caster:StartGestureWithPlaybackRate(ACT_DOTA_ATTACK, 1.2)
	end)
	self:Timer(SLASH_WARNING_DURATION, function()
		if not IsValidAlive(nil, caster) then
			return
		end
		caster:EmitSound("Hero_PhantomAssassin.CoupDeGrace")
		self:PlaySlashEffect(caster)
		self:Timer(0.1, function()
			self:DamageSlashCone(caster)
		end)
		self:Timer(0.18, function()
			caster:StartGestureWithPlaybackRate(ACT_DOTA_ATTACK, 1.5)
		end)
		self:Timer(0.28, function()
			self:DamageSlashCone(caster)
		end)
	end)
end
function elite_145.prototype.ResolveBehindPosition(self, caster, target)
	if not IsValidAlive(nil, target) then
		return GetGroundPosition(caster:GetAbsOrigin(), caster)
	end
	local targetOrigin = GetGroundPosition(target:GetAbsOrigin(), target)
	local targetBackward = Vector(-target:GetForwardVector().x, -target:GetForwardVector().y, 0):Normalized()
	local preferred = GetGroundPosition(targetOrigin:__add(targetBackward:__mul(BEHIND_DISTANCE)), caster)
	if IsGridNavDisplacementWalkable(nil, preferred) then
		return preferred
	end
	local fromTargetToCaster = GetDirection(nil, caster:GetAbsOrigin(), targetOrigin)
	do
		local i = 0
		while i < 8 do
			local currentDirection = RotateVector2D(nil, fromTargetToCaster, i * 45):Normalized()
			local currentPoint = GetGroundPosition(targetOrigin:__add(currentDirection:__mul(BEHIND_DISTANCE)), caster)
			if IsGridNavDisplacementWalkable(nil, currentPoint) then
				return currentPoint
			end
			i = i + 1
		end
	end
	return GetGroundPosition(caster:GetAbsOrigin(), caster)
end
function elite_145.prototype.IsValidBlinkPath(self, origin, point)
	if not GridNav:IsTraversable(origin) or GridNav:IsBlocked(origin) then
		return false
	end
	if not GridNav:IsTraversable(point) or GridNav:IsBlocked(point) then
		return false
	end
	if not GridNav:CanFindPath(origin, point) then
		return false
	end
	return GridNav:FindPathLength(origin, point) ~= -1
end
function elite_145.prototype.DamageSlashCone(self, caster)
	local origin = caster:GetAbsOrigin()
	local forward = caster:GetForwardVector()
	local minDot = math.cos(math.rad(SLASH_HALF_ANGLE_DEG))
	local enemies = FindUnitsInRadius(
		caster:GetTeamNumber(),
		origin,
		nil,
		SLASH_RANGE,
		DOTA_UNIT_TARGET_TEAM_ENEMY,
		DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,
		DOTA_UNIT_TARGET_FLAG_NONE,
		FIND_ANY_ORDER,
		false
	)
	for ____, enemy in ipairs(enemies) do
		do
			if not IsValidAlive(nil, enemy) then
				goto __continue38
			end
			local delta = enemy:GetAbsOrigin():__sub(origin)
			local distance = delta:Length2D()
			if distance <= 0.01 or distance > SLASH_RANGE then
				goto __continue38
			end
			local direction = Vector(delta.x / distance, delta.y / distance, 0)
			local dot = forward.x * direction.x + forward.y * direction.y
			if dot < minDot then
				goto __continue38
			end
			caster:MonsterDamage({ victim = enemy, damage_rate = SLASH_DAMAGE_RATE, ability = self })
			AddDeBuffStatus(nil, enemy, caster, self, DebuffStatusType.STUN, { duration = 0.5 })
		end
		::__continue38::
	end
end
function elite_145.prototype.PlaySlashEffect(self, caster)
	local effect = ParticleManager:CreateParticle(SLASH_EFFECT, PATTACH_POINT_FOLLOW, caster)
	ParticleManager:SetParticleControl(effect, 0, caster:GetAbsOrigin())
	ParticleManager:SetParticleControl(effect, 4, caster:GetAbsOrigin())
	ParticleManager:ReleaseParticleIndex(effect)
end
function elite_145.prototype.PlayPointEffect(self, effectName, point)
	local effect = ParticleManager:CreateParticle(effectName, PATTACH_WORLDORIGIN, nil)
	ParticleManager:SetParticleControl(effect, 0, point)
	ParticleManager:ReleaseParticleIndex(effect)
end
function elite_145.prototype.CleanupCast(self)
	self.castToken = (self.castToken or 0) + 1
	local caster = self:GetCaster()
	if not IsValid(nil, caster) then
		return
	end
	caster:RemoveNoDraw()
	modifier_elite_145_shadow:remove(caster)
end
elite_145 = __TS__DecorateLegacy({ registerAbility(nil) }, elite_145)
____exports.elite_145 = elite_145
modifier_elite_145_shadow = __TS__Class()
modifier_elite_145_shadow.name = "modifier_elite_145_shadow"
__TS__ClassExtends(modifier_elite_145_shadow, MonsterModifier_CS)
function modifier_elite_145_shadow.prototype.OnCreated(self)
	if not IsServer() then
		return
	end
	self:GetParent():AddNoDraw()
end
function modifier_elite_145_shadow.prototype.OnDestroy(self)
	if not IsServer() then
		return
	end
	local parent = self:GetParent()
	if IsValid(nil, parent) then
		parent:RemoveNoDraw()
	end
end
function modifier_elite_145_shadow.prototype.CheckState(self)
	return {
		[MODIFIER_STATE_INVULNERABLE] = true,
		[MODIFIER_STATE_NO_HEALTH_BAR] = true,
		[MODIFIER_STATE_NO_UNIT_COLLISION] = true,
		[MODIFIER_STATE_COMMAND_RESTRICTED] = true,
		[MODIFIER_STATE_DISARMED] = true,
	}
end
function modifier_elite_145_shadow.prototype.IsHidden(self)
	return true
end
function modifier_elite_145_shadow.prototype.IsPurgable(self)
	return false
end
modifier_elite_145_shadow =
	__TS__DecorateLegacy({ registerModifier(nil, "modifier_elite_145_shadow") }, modifier_elite_145_shadow)
return ____exports