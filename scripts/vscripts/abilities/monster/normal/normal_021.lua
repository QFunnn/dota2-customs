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
local modifier_normal_021_roll
local ____modifier_base = require("modifiers.class.modifier_base")
local BaseModifierMotionHorizontal_CS = ____modifier_base.BaseModifierMotionHorizontal_CS
local ____dota_ts_adapter = require("utils.dota_ts_adapter")
local registerAbility = ____dota_ts_adapter.registerAbility
local registerModifier = ____dota_ts_adapter.registerModifier
local ____monster_base = require("abilities.monster.monster_base")
local MonsterAbility_CS = ____monster_base.MonsterAbility_CS
local CAST_RANGE = 1600
local CAST_POINT = 0.6
local ROLL_SPEED = 1600
local ROLL_DURATION = CAST_RANGE / ROLL_SPEED
local HIT_RADIUS = 160
local HIT_DAMAGE = 15
local HIT_STUN_DURATION = 0.8
local STOP_BEHIND_DISTANCE = 120
local CAST_SOUND = "Hero_EarthSpirit.RollingBoulder.Cast"
local LOOP_SOUND = "Hero_EarthSpirit.RollingBoulder.Loop"
local HIT_SOUND = "Hero_EarthSpirit.RollingBoulder.Target"
local DESTROY_SOUND = "Hero_EarthSpirit.RollingBoulder.Destroy"
local ROLL_PARTICLE = "particles/units/heroes/hero_earth_spirit/espirit_rollingboulder.vpcf"
--- 普通技能021 - 巨石翻滚：延迟后向目标点翻滚，碰敌即停并造成伤害与眩晕
____exports.normal_021 = __TS__Class()
local normal_021 = ____exports.normal_021
normal_021.name = "normal_021"
__TS__ClassExtends(normal_021, MonsterAbility_CS)
function normal_021.prototype.Precache(self, context)
	PrecacheResource("particle", ROLL_PARTICLE, context)
end
function normal_021.prototype.GetMosnterAbilityConfig(self)
	return {
		castRange = CAST_RANGE,
		castPoint = CAST_POINT,
		castDuration = 0,
		behavior = DOTA_ABILITY_BEHAVIOR_POINT,
		castAnimation = ACT_DOTA_CAST_ABILITY_2,
		cooldown = 8,
		OnPhaseStart = function()
			local caster = self:GetCaster()
			if not IsValidAlive(nil, caster) then
				return
			end
			self.targetPoint = self:GetCursorPosition()
			local dir = self:getRollDirection(caster, self.targetPoint)
			local warningEnd = caster:GetAbsOrigin():__add(dir:__mul(CAST_RANGE))
			self:WarningEffect(
				caster:GetAbsOrigin(),
				warningEnd,
				CAST_POINT,
				{ startWidth = HIT_RADIUS * 2, endWidth = HIT_RADIUS * 2 }
			)
		end,
		OnStart = function()
			local caster = self:GetCaster()
			if not IsValidAlive(nil, caster) then
				return
			end
			local targetPoint = self.targetPoint or self:GetCursorPosition()
			local dir = self:getRollDirection(caster, targetPoint)
			EmitSoundOn(CAST_SOUND, caster)
			modifier_normal_021_roll:applys(caster, caster, self, {
				duration = ROLL_DURATION + 0.2,
				dirX = dir.x,
				dirY = dir.y,
				dirZ = dir.z,
				maxDistance = CAST_RANGE,
				speed = ROLL_SPEED,
				hitRadius = HIT_RADIUS,
				hitDamage = HIT_DAMAGE,
				stunDuration = HIT_STUN_DURATION,
				stopBehindDistance = STOP_BEHIND_DISTANCE,
			})
		end,
		OnFinish = function()
			self.targetPoint = nil
		end,
		OnInterrupt = function()
			self.targetPoint = nil
		end,
	}
end
function normal_021.prototype.getRollDirection(self, caster, targetPoint)
	local origin = caster:GetAbsOrigin()
	local dir = GetDirection(nil, targetPoint, origin)
	if dir:Length2D() <= 0.01 then
		return caster:GetForwardVector()
	end
	return dir
end
normal_021 = __TS__DecorateLegacy({ registerAbility(nil) }, normal_021)
____exports.normal_021 = normal_021
modifier_normal_021_roll = __TS__Class()
modifier_normal_021_roll.name = "modifier_normal_021_roll"
__TS__ClassExtends(modifier_normal_021_roll, BaseModifierMotionHorizontal_CS)
function modifier_normal_021_roll.prototype.____constructor(self, ...)
	BaseModifierMotionHorizontal_CS.prototype.____constructor(self, ...)
	self.speed = ROLL_SPEED
	self.maxDistance = CAST_RANGE
	self.hitRadius = HIT_RADIUS
	self.hitDamage = HIT_DAMAGE
	self.stunDuration = HIT_STUN_DURATION
	self.stopBehindDistance = STOP_BEHIND_DISTANCE
	self.traveled = 0
	self.hitTarget = false
end
function modifier_normal_021_roll.prototype.OnCreated(self, params)
	if not IsServer() then
		return
	end
	self.direction = Vector(tonumber(params.dirX) or 0, tonumber(params.dirY) or 0, tonumber(params.dirZ) or 0)
	if self.direction:Length2D() <= 0.01 then
		self.direction = self:GetParent():GetForwardVector()
	else
		self.direction = self.direction:Normalized()
	end
	self.speed = tonumber(params.speed) or ROLL_SPEED
	self.maxDistance = tonumber(params.maxDistance) or CAST_RANGE
	self.hitRadius = tonumber(params.hitRadius) or HIT_RADIUS
	self.hitDamage = tonumber(params.hitDamage) or HIT_DAMAGE
	self.stunDuration = tonumber(params.stunDuration) or HIT_STUN_DURATION
	self.stopBehindDistance = tonumber(params.stopBehindDistance) or STOP_BEHIND_DISTANCE
	self:GetParent():SetForwardVector(self.direction)
	self:GetParent():StartGesture(ACT_DOTA_CAST_ABILITY_2_ES_ROLL)
	EmitSoundOn(LOOP_SOUND, self:GetParent())
	if not self:ApplyHorizontalMotionController() then
		self:Destroy()
	end
end
function modifier_normal_021_roll.prototype.OnDestroy(self)
	if not IsServer() then
		return
	end
	local parent = self:GetParent()
	if not IsValid(nil, parent) or parent:IsNull() then
		return
	end
	parent:RemoveHorizontalMotionController(self)
	StopSoundOn(LOOP_SOUND, parent)
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
end
function modifier_normal_021_roll.prototype.DeclareFunctions(self)
	return { MODIFIER_PROPERTY_OVERRIDE_ANIMATION }
end
function modifier_normal_021_roll.prototype.GetOverrideAnimation(self)
	return ACT_DOTA_CAST_ABILITY_2_ES_ROLL
end
function modifier_normal_021_roll.prototype.CheckState(self)
	return {
		[MODIFIER_STATE_ROOTED] = true,
		[MODIFIER_STATE_DISARMED] = true,
		[MODIFIER_STATE_NO_UNIT_COLLISION] = true,
	}
end
function modifier_normal_021_roll.prototype.UpdateHorizontalMotion(self, me, dt)
	if not IsValid(nil, me) or me:IsNull() then
		self:Destroy()
		return
	end
	local origin = me:GetAbsOrigin()
	local step = self.speed * dt
	local move = self.direction:__mul(step)
	local nextPos = origin:__add(move)
	nextPos.z = GetGroundHeight(nextPos, me) or origin.z
	if not GridNav:IsTraversable(nextPos) or GridNav:IsBlocked(nextPos) then
		self:Destroy()
		return
	end
	me:SetForwardVector(self.direction)
	me:SetAbsOrigin(nextPos)
	GridNav:DestroyTreesAroundPoint(nextPos, self.hitRadius, false)
	self.traveled = self.traveled + step
	local enemy = self:findCollisionTarget(nextPos)
	if enemy then
		self:hitEnemy(enemy)
		return
	end
	if self.traveled >= self.maxDistance then
		self:Destroy()
	end
end
function modifier_normal_021_roll.prototype.OnHorizontalMotionInterrupted(self)
	self:Destroy()
end
function modifier_normal_021_roll.prototype.IsHidden(self)
	return true
end
function modifier_normal_021_roll.prototype.GetEffectName(self)
	return ROLL_PARTICLE
end
function modifier_normal_021_roll.prototype.GetEffectAttachType(self)
	return PATTACH_ABSORIGIN_FOLLOW
end
function modifier_normal_021_roll.prototype.findCollisionTarget(self, center)
	local parent = self:GetParent()
	if not IsValidAlive(nil, parent) then
		return
	end
	local enemies = FindUnitsInRadius(
		parent:GetTeamNumber(),
		center,
		nil,
		self.hitRadius,
		DOTA_UNIT_TARGET_TEAM_ENEMY,
		DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,
		DOTA_UNIT_TARGET_FLAG_NONE,
		FIND_CLOSEST,
		false
	)
	for ____, enemy in ipairs(enemies) do
		do
			if not IsValidAlive(nil, enemy) then
				goto __continue38
			end
			if enemy:GetTeamNumber() == parent:GetTeamNumber() then
				goto __continue38
			end
			return enemy
		end
		::__continue38::
	end
	return nil
end
function modifier_normal_021_roll.prototype.hitEnemy(self, target)
	if self.hitTarget then
		return
	end
	self.hitTarget = true
	local parent = self:GetParent()
	local ability = self:GetAbility()
	if not ability or not IsValidAlive(nil, parent) or not IsValidAlive(nil, target) then
		self:Destroy()
		return
	end
	Damage:ApplyDamage({
		victim = target,
		attacker = parent,
		damage = self.hitDamage,
		damage_type = 2,
		ability = ability,
	})
	AddDeBuffStatus(nil, target, parent, ability, DebuffStatusType.STUN, { duration = self.stunDuration })
	EmitSoundOn(HIT_SOUND, target)
	local stopPos = target:GetAbsOrigin():__add(self.direction:__mul(self.stopBehindDistance))
	stopPos.z = GetGroundHeight(stopPos, parent) or stopPos.z
	parent:SetAbsOrigin(stopPos)
	parent:SetForwardVector(self.direction)
	self:Destroy()
end
modifier_normal_021_roll = __TS__DecorateLegacy({ registerModifier(nil) }, modifier_normal_021_roll)
return ____exports