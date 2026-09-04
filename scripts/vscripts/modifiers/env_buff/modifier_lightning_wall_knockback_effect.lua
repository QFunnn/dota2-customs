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
local registerModifier = ____dota_ts_adapter.registerModifier
local ____modifier_base = require("modifiers.class.modifier_base")
local BaseModifier_CS = ____modifier_base.BaseModifier_CS
local LIGHTNING_WALL_KNOCKBACK_EFFECT = "particles/units/heroes/hero_zuus/zuus_shard_head.vpcf"
local LIGHTNING_WALL_KNOCKBACK_LIGHTNING_HEIGHT = 125
--- 雷墙击退时绑定在单位身上的雷电演出与短时兜底击退
____exports.modifier_lightning_wall_knockback_effect = __TS__Class()
local modifier_lightning_wall_knockback_effect = ____exports.modifier_lightning_wall_knockback_effect
modifier_lightning_wall_knockback_effect.name = "modifier_lightning_wall_knockback_effect"
__TS__ClassExtends(modifier_lightning_wall_knockback_effect, BaseModifier_CS)
function modifier_lightning_wall_knockback_effect.prototype.____constructor(self, ...)
	BaseModifier_CS.prototype.____constructor(self, ...)
	self.fallbackDirection = Vector(0, -1, 0)
	self.wallStart = Vector(0, 0, 0)
	self.wallEnd = Vector(0, 0, 0)
	self.wallHalfWidth = 0
	self.initialDuration = 0.2
	self.initialDistance = 250
	self.fallbackInterval = 0.1
	self.fallbackDuration = 0.08
	self.fallbackDistance = 80
end
function modifier_lightning_wall_knockback_effect.prototype.OnCreated(self, params)
	self:ReadParams(params)
	self:CreateKnockbackEffect()
	self:ApplyKnockback(self.initialDuration, self.initialDistance, true)
	self:StartIntervalThink(self.fallbackInterval)
end
function modifier_lightning_wall_knockback_effect.prototype.OnRefresh(self, params)
	self:ReadParams(params)
	self:DestroyKnockbackEffect()
	self:CreateKnockbackEffect()
	self:ApplyKnockback(self.initialDuration, self.initialDistance, true)
	self:StartIntervalThink(self.fallbackInterval)
end
function modifier_lightning_wall_knockback_effect.prototype.OnIntervalThink(self)
	if not IsServer() then
		return
	end
	local parent = self:GetParent()
	if not IsValidAlive(nil, parent) then
		self:Destroy()
		return
	end
	if not self:IsParentStillInWallArea(parent) then
		self:Destroy()
		return
	end
	self:ApplyKnockback(self.fallbackDuration, self.fallbackDistance, false)
end
function modifier_lightning_wall_knockback_effect.prototype.IsHidden(self)
	return true
end
function modifier_lightning_wall_knockback_effect.prototype.IsPurgable(self)
	return false
end
function modifier_lightning_wall_knockback_effect.prototype.CreateKnockbackEffect(self)
	if not IsServer() then
		return
	end
	local parent = self:GetParent()
	local pfx = ParticleManager:CreateParticle(LIGHTNING_WALL_KNOCKBACK_EFFECT, PATTACH_WORLDORIGIN, parent)
	ParticleManager:SetParticleControl(pfx, 0, Vector(LIGHTNING_WALL_KNOCKBACK_LIGHTNING_HEIGHT, 0, 0))
	ParticleManager:SetParticleControlEnt(
		pfx,
		1,
		parent,
		PATTACH_POINT_FOLLOW,
		"attach_hitloc",
		parent:GetAbsOrigin(),
		true
	)
	ParticleManager:SetParticleControlEnt(
		pfx,
		2,
		parent,
		PATTACH_POINT_FOLLOW,
		"attach_hitloc",
		parent:GetAbsOrigin(),
		true
	)
	self.particleId = pfx
end
function modifier_lightning_wall_knockback_effect.prototype.ReadParams(self, params)
	local direction = Vector(
		tonumber(params and params.direction_x) or 0,
		tonumber(params and params.direction_y) or 0,
		tonumber(params and params.direction_z) or 0
	)
	local ____temp_6
	if direction:Length2D() > 0.01 then
		____temp_6 = direction:Normalized()
	else
		____temp_6 = Vector(0, -1, 0)
	end
	self.fallbackDirection = ____temp_6
	self.wallStart = Vector(
		tonumber(params and params.wall_start_x) or 0,
		tonumber(params and params.wall_start_y) or 0,
		tonumber(params and params.wall_start_z) or 0
	)
	self.wallEnd = Vector(
		tonumber(params and params.wall_end_x) or 0,
		tonumber(params and params.wall_end_y) or 0,
		tonumber(params and params.wall_end_z) or 0
	)
	self.wallHalfWidth = math.max(0, tonumber(params and params.wall_half_width) or 0)
	self.initialDuration = math.max(0.01, tonumber(params and params.initial_duration) or self.initialDuration)
	self.initialDistance = math.max(0, tonumber(params and params.initial_distance) or self.initialDistance)
	self.fallbackInterval = math.max(0.03, tonumber(params and params.fallback_interval) or self.fallbackInterval)
	self.fallbackDuration = math.max(0.01, tonumber(params and params.fallback_duration) or self.fallbackDuration)
	self.fallbackDistance = math.max(0, tonumber(params and params.fallback_distance) or self.fallbackDistance)
end
function modifier_lightning_wall_knockback_effect.prototype.ApplyKnockback(self, duration, distance, withStun)
	if not IsServer() then
		return
	end
	local parent = self:GetParent()
	if not IsValidAlive(nil, parent) then
		return
	end
	local caster = self:GetCaster()
	local ____temp_31
	if caster and IsValid(nil, caster) and not caster:IsNull() then
		____temp_31 = caster
	else
		____temp_31 = parent
	end
	local attacker = ____temp_31
	local direction = self:GetKnockDirection()
	local ____parent_KnockBack_37 = parent.KnockBack
	local ____duration_33 = duration
	local ____distance_34 = distance
	local ____direction_35 = direction
	local ____withStun_36 = withStun
	local ____withStun_32
	if withStun then
		____withStun_32 = math.max(0, self:GetDuration() - duration)
	else
		____withStun_32 = 0
	end
	____parent_KnockBack_37(parent, attacker, nil, {
		duration = ____duration_33,
		distance = ____distance_34,
		direction = ____direction_35,
		stun = ____withStun_36,
		stunDuration = ____withStun_32,
		blockUntraversable = true,
	})
end
function modifier_lightning_wall_knockback_effect.prototype.GetKnockDirection(self)
	return self.fallbackDirection
end
function modifier_lightning_wall_knockback_effect.prototype.IsParentStillInWallArea(self, parent)
	if self.wallHalfWidth <= 0 then
		return true
	end
	local closest = self:GetClosestPointOnSegment2D(parent:GetAbsOrigin(), self.wallStart, self.wallEnd)
	return parent:GetAbsOrigin():__sub(closest):Length2D() <= self.wallHalfWidth
end
function modifier_lightning_wall_knockback_effect.prototype.GetClosestPointOnSegment2D(self, point, start, ____end)
	local segment = ____end:__sub(start)
	local lengthSq = self:Dot2D(segment, segment)
	if lengthSq <= 0.0001 then
		return start
	end
	local t = math.max(0, math.min(1, self:Dot2D(point:__sub(start), segment) / lengthSq))
	return Vector(start.x + segment.x * t, start.y + segment.y * t, start.z)
end
function modifier_lightning_wall_knockback_effect.prototype.Dot2D(self, a, b)
	return a.x * b.x + a.y * b.y
end
function modifier_lightning_wall_knockback_effect.prototype.DestroyKnockbackEffect(self)
	if self.particleId == nil then
		return
	end
	ParticleManager:DestroyParticle(self.particleId, false)
	ParticleManager:ReleaseParticleIndex(self.particleId)
	self.particleId = nil
end
function modifier_lightning_wall_knockback_effect.prototype.OnDestroy(self)
	self:StartIntervalThink(-1)
	local parent = self:GetParent()
	if IsServer() and IsValid(nil, parent) and not parent:IsNull() then
		FindClearSpaceForUnit(parent, parent:GetAbsOrigin(), true)
	end
	self:DestroyKnockbackEffect()
end
modifier_lightning_wall_knockback_effect =
	__TS__DecorateLegacy({ registerModifier(nil) }, modifier_lightning_wall_knockback_effect)
____exports.modifier_lightning_wall_knockback_effect = modifier_lightning_wall_knockback_effect
return ____exports