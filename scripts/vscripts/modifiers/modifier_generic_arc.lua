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
local BaseModifierMotionBoth = ____dota_ts_adapter.BaseModifierMotionBoth
local registerModifier = ____dota_ts_adapter.registerModifier
____exports.modifier_generic_arc = __TS__Class()
local modifier_generic_arc = ____exports.modifier_generic_arc
modifier_generic_arc.name = "modifier_generic_arc"
__TS__ClassExtends(modifier_generic_arc, BaseModifierMotionBoth)
function modifier_generic_arc.prototype.____constructor(self, ...)
	BaseModifierMotionBoth.prototype.____constructor(self, ...)
	self.direction = Vector(1, 1, 0)
	self.speed = 0
	self.duration = 0
	self.distance = 100
	self.height = 100
	self.start_offset = 0
	self.end_offset = 0
	self.fix_end = false
	self.fix_duration = false
	self.fix_height = false
	self.isStun = true
	self.isRestricted = true
	self.isForward = true
	self.activity = ACT_DOTA_FLAIL
	self.interrupted = false
	self.const1 = 0
	self.const2 = 0
	self.endCallback = function() end
end
function modifier_generic_arc.prototype.OnCreated(self, kv)
	if not IsServer() then
		return
	end
	self.interrupted = false
	self:SetJumpParameters(kv)
	self:Jump()
end
function modifier_generic_arc.prototype.OnRefresh(self, kv)
	self:OnCreated(kv)
end
function modifier_generic_arc.prototype.OnDestroy(self)
	if not IsServer() then
		return
	end
	local parent = self:GetParent()
	if not IsValid(nil, parent) or parent:IsNull() then
		if self.endCallback then
			self:endCallback(self.interrupted)
		end
		return
	end
	local pos = parent:GetOrigin()
	parent:RemoveHorizontalMotionController(self)
	parent:RemoveVerticalMotionController(self)
	if self.end_offset ~= 0 then
		parent:SetOrigin(pos)
	end
	if self.endCallback then
		self:endCallback(self.interrupted)
	end
end
function modifier_generic_arc.prototype.DeclareFunctions(self)
	local funcs = { MODIFIER_PROPERTY_DISABLE_TURNING }
	if self:GetStackCount() > 0 then
		funcs[#funcs + 1] = MODIFIER_PROPERTY_OVERRIDE_ANIMATION
	end
	return funcs
end
function modifier_generic_arc.prototype.GetModifierDisableTurning(self)
	if not self.isForward then
		return 0
	end
	return 1
end
function modifier_generic_arc.prototype.GetOverrideAnimation(self)
	return self:GetStackCount()
end
function modifier_generic_arc.prototype.CheckState(self)
	return {
		[MODIFIER_STATE_STUNNED] = self.isStun or false,
		[MODIFIER_STATE_COMMAND_RESTRICTED] = self.isRestricted or false,
		[MODIFIER_STATE_NO_UNIT_COLLISION] = true,
	}
end
function modifier_generic_arc.prototype.UpdateHorizontalMotion(self, me, dt)
	if not IsValid(nil, me) or me:IsNull() then
		self:Destroy()
		return
	end
	if self.fix_duration and self:GetElapsedTime() >= self.duration then
		return
	end
	local pos = me:GetOrigin() + self.direction * self.speed * dt
	me:SetOrigin(pos)
end
function modifier_generic_arc.prototype.UpdateVerticalMotion(self, me, dt)
	if not IsValid(nil, me) or me:IsNull() then
		self:Destroy()
		return
	end
	if self.fix_duration and self:GetElapsedTime() >= self.duration then
		return
	end
	local pos = me:GetOrigin()
	local time = self:GetElapsedTime()
	local height = pos.z
	local speed = self:GetVerticalSpeed(time)
	pos.z = height + speed * dt
	me:SetOrigin(pos)
	if not self.fix_duration then
		local ground = GetGroundHeight(pos, me) + self.end_offset
		if pos.z <= ground then
			pos.z = ground
			me:SetOrigin(pos)
			self:Destroy()
		end
	end
end
function modifier_generic_arc.prototype.OnHorizontalMotionInterrupted(self)
	self.interrupted = true
	self:Destroy()
end
function modifier_generic_arc.prototype.OnVerticalMotionInterrupted(self)
	self.interrupted = true
	self:Destroy()
end
function modifier_generic_arc.prototype.SetJumpParameters(self, kv)
	local parent = self:GetParent()
	self.fix_end = true
	self.fix_duration = true
	self.fix_height = true
	if kv.fix_end then
		self.fix_end = kv.fix_end == 1
	end
	if kv.fix_duration then
		self.fix_duration = kv.fix_duration == 1
	end
	if kv.fix_height then
		self.fix_height = kv.fix_height == 1
	end
	self.isStun = kv.isStun == 1
	self.isRestricted = kv.isRestricted == 1
	self.isForward = kv.isForward == 1
	self.activity = kv.activity or 0
	self:SetStackCount(self.activity)
	if kv.target_x and kv.target_y then
		local origin = parent:GetOrigin()
		local dir = Vector(kv.target_x, kv.target_y, 0) - origin
		dir.z = 0
		dir = dir:Normalized()
		self.direction = dir
	end
	if kv.dir_x and kv.dir_y then
		self.direction = Vector(kv.dir_x, kv.dir_y, 0):Normalized()
	end
	if not self.direction then
		self.direction = parent:GetForwardVector()
	end
	self.duration = kv.duration
	self.distance = kv.distance
	self.speed = kv.speed
	if not self.duration then
		self.duration = self.distance / self.speed
	end
	if not self.distance then
		self.distance = self.speed * self.duration
	end
	if not self.speed then
		self.distance = self.distance or 0
		self.speed = self.distance / self.duration
	end
	self.height = kv.height or 0
	self.start_offset = kv.start_offset or 0
	self.end_offset = kv.end_offset or 0
	local pos_start = parent:GetOrigin()
	local pos_end = pos_start + self.direction * self.distance
	local height_start = GetGroundHeight(pos_start, parent) + self.start_offset
	local height_end = GetGroundHeight(pos_end, parent) + self.end_offset
	local height_max
	if not self.fix_height then
		self.height = math.min(self.height, self.distance / 4)
	end
	if self.fix_end then
		height_end = height_start
		height_max = height_start + self.height
	else
		local tmin = height_start
		local tmax = height_end
		if tmin > tmax then
			tmin = height_end
			tmax = height_start
		end
		local delta = (tmax - tmin) * 2 / 3
		height_max = tmin + delta + self.height
		if not self.fix_duration then
			self:SetDuration(-1, false)
		else
			self:SetDuration(self.duration, true)
		end
	end
	self:InitVerticalArc(height_start, height_max, height_end, self.duration)
end
function modifier_generic_arc.prototype.InitVerticalArc(self, height_start, height_max, height_end, duration)
	height_end = height_end - height_start
	height_max = height_max - height_start
	if height_max < height_end then
		height_max = height_end + 0.01
	end
	if height_max <= 0 then
		height_max = 0.01
	end
	local duration_end = (1 + math.sqrt(1 - height_end / height_max)) / 2
	self.const1 = 4 * height_max * duration_end / duration
	self.const2 = 4 * height_max * duration_end * duration_end / (duration * duration)
end
function modifier_generic_arc.prototype.Jump(self)
	if self.distance > 0 then
		if not self:ApplyHorizontalMotionController() then
			self.interrupted = true
			self:Destroy()
		end
	end
	if self.height > 0 then
		if not self:ApplyVerticalMotionController() then
			self.interrupted = true
			self:Destroy()
		end
	end
end
function modifier_generic_arc.prototype.GetVerticalPos(self, time)
	return self.const1 * time - self.const2 * time * time
end
function modifier_generic_arc.prototype.GetVerticalSpeed(self, time)
	return self.const1 - 2 * self.const2 * time
end
function modifier_generic_arc.prototype.SetEndCallback(self, func)
	self.endCallback = func
end
function modifier_generic_arc.prototype.IsHidden(self)
	return true
end
function modifier_generic_arc.prototype.IsDebuff(self)
	return false
end
function modifier_generic_arc.prototype.IsStunDebuff(self)
	return false
end
function modifier_generic_arc.prototype.IsPurgable(self)
	return true
end
function modifier_generic_arc.prototype.GetAttributes(self)
	return MODIFIER_ATTRIBUTE_MULTIPLE
end
modifier_generic_arc = __TS__DecorateLegacy({ registerModifier(nil) }, modifier_generic_arc)
____exports.modifier_generic_arc = modifier_generic_arc
return ____exports