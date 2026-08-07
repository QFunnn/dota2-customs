--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 16fdfbc · 2026-08-07 21:47:55 UTC
  ~ auto-generated — do not edit
]]


local ____lualib = require("lualib_bundle")
local __TS__Class = ____lualib.__TS__Class
local __TS__ClassExtends = ____lualib.__TS__ClassExtends
local __TS__Decorate = ____lualib.__TS__Decorate
local ____exports = {}
local ____dota_ts_adapter = require("utils.dota_ts_adapter")
local registerModifier = ____dota_ts_adapter.registerModifier
local ____sl_modifier_base = require("modifiers.sl_modifier_base")
local SLModifierBase_MotionBoth = ____sl_modifier_base.SLModifierBase_MotionBoth
____exports.sl_modifier_custom_knockback = __TS__Class()
local sl_modifier_custom_knockback = ____exports.sl_modifier_custom_knockback
sl_modifier_custom_knockback.name = "sl_modifier_custom_knockback"
__TS__ClassExtends(sl_modifier_custom_knockback, SLModifierBase_MotionBoth)
function sl_modifier_custom_knockback.prototype.IsDebuff(self)
	return true
end
function sl_modifier_custom_knockback.prototype.IsHidden(self)
	return true
end
function sl_modifier_custom_knockback.prototype.IsPurgable(self)
	return true
end
function sl_modifier_custom_knockback.prototype.IsPurgeException(self)
	return true
end
function sl_modifier_custom_knockback.prototype.RemoveOnDeath(self)
	return true
end
function sl_modifier_custom_knockback.prototype.GetAttributes(self)
	return MODIFIER_ATTRIBUTE_MULTIPLE
end
function sl_modifier_custom_knockback.prototype._Boolean(self, value)
	if type(value) == "boolean" then
		return value
	end
	local ____temp_3
	if tonumber(value) == 1 then
		____temp_3 = true
	else
		____temp_3 = false
	end
	return ____temp_3
end
function sl_modifier_custom_knockback.prototype.OnCreated(self, params)
	if not IsServer() then
		return
	end
	local parent = self:GetParent()
	self._duration = params.knockDuration
	self._stun = self:_Boolean(params.stun)
	local ____params_stunDuration_4 = params.stunDuration
	if ____params_stunDuration_4 == nil then
		____params_stunDuration_4 = 0
	end
	self._stun_duration = ____params_stunDuration_4
	local ____params_destroyTreesRange_5 = params.destroyTreesRange
	if ____params_destroyTreesRange_5 == nil then
		____params_destroyTreesRange_5 = 0
	end
	self._destroy_trees_range = ____params_destroyTreesRange_5
	local ____params_destroyTreesType_6 = params.destroyTreesType
	if ____params_destroyTreesType_6 == nil then
		____params_destroyTreesType_6 = nil
	end
	self._destroy_trees_type = ____params_destroyTreesType_6
	self._knockback_forward = params.knockBackForward
	self._interrupt_on_destroy = self:_Boolean(params.interruptMotionControllerOnDestroy)
	local ____params_distance_7 = params.distance
	if ____params_distance_7 == nil then
		____params_distance_7 = 0
	end
	self._distance = ____params_distance_7
	self._block = self:_Boolean(params.block)
	self._uniform = self:_Boolean(params.uniform)
	local ____params_power_8 = params.power
	if ____params_power_8 == nil then
		____params_power_8 = 0.65
	end
	self._power = ____params_power_8
	local ____params_height_9 = params.height
	if ____params_height_9 == nil then
		____params_height_9 = 0
	end
	self._height = ____params_height_9
	local ____params_heightPower_10 = params.heightPower
	if ____params_heightPower_10 == nil then
		____params_heightPower_10 = 0.65
	end
	self._height_power = ____params_heightPower_10
	local ____params_heightPower2_11 = params.heightPower2
	if ____params_heightPower2_11 == nil then
		____params_heightPower2_11 = 0.45
	end
	self._height_power2 = ____params_heightPower2_11
	local ____params_heightType_12 = params.heightType
	if ____params_heightType_12 == nil then
		____params_heightType_12 = "pow"
	end
	self._height_type = ____params_heightType_12
	local ____params_gravity_13 = params.gravity
	if ____params_gravity_13 == nil then
		____params_gravity_13 = 5000
	end
	self._gravity = ____params_gravity_13
	local height_calculator = ____exports.sl_modifier_custom_knockback._height_calculators[self._height_type]
	self._height_calculator = function(____, elapsed, timeline)
		return height_calculator(nil, self, elapsed, timeline)
	end
	local ____table__uniform_14
	if self._uniform then
		____table__uniform_14 = ____exports.sl_modifier_custom_knockback._distance_calculators.uniform
	else
		____table__uniform_14 = ____exports.sl_modifier_custom_knockback._distance_calculators.power
	end
	local distance_calculator = ____table__uniform_14
	self._distance_calculator = function(____, elapsed, last_frame_time)
		return distance_calculator(nil, self, elapsed, last_frame_time)
	end
	self._direction = self:_calculate_direction(params, parent)
	local ____params_particleName_15 = params.particleName
	if ____params_particleName_15 == nil then
		____params_particleName_15 = GENERIC_PARTICLES.knockback
	end
	local particle_name = ____params_particleName_15
	if particle_name then
		local pid = SParticleManager:CreateGenericParticle(particle_name, PATTACH_ABSORIGIN_FOLLOW, parent)
		self:AddParticle(pid, false, false, 1, false, false)
	end
	self:_apply_knockback_forward()
	if not self:ApplyVerticalMotionController() or not self:ApplyHorizontalMotionController() then
		self:Destroy()
	end
end
function sl_modifier_custom_knockback.prototype._calculate_direction(self, params, parent)
	if not params.direction then
		local caster = self:GetCaster()
		local ____IsValid_result_16
		if IsValid(caster) then
			____IsValid_result_16 = SLVector:Normalized2D(parent:GetAbsOrigin() - caster:GetAbsOrigin())
		else
			____IsValid_result_16 = parent:GetForwardVector()
		end
		return ____IsValid_result_16
	end
	local direction_vec = StringToVector(params.direction)
	local is_3d = self:_Boolean(params.direction_3d)
	local ____is_3d_17
	if is_3d then
		____is_3d_17 = direction_vec
	else
		____is_3d_17 = Vector(direction_vec.x, direction_vec.y, 0)
	end
	return ____is_3d_17
end
function sl_modifier_custom_knockback.prototype._apply_knockback_forward(self)
	if not self._knockback_forward or not self._direction then
		return
	end
	local parent = self:GetParent()
	local forward = nil
	if self._knockback_forward == "towardsCaster" then
		forward = -self._direction
	elseif self._knockback_forward == "backCaster" then
		forward = self._direction
	else
		local ____StringToVector_result_18 = StringToVector(self._knockback_forward)
		if ____StringToVector_result_18 == nil then
			____StringToVector_result_18 = nil
		end
		forward = ____StringToVector_result_18
	end
	if forward then
		parent:SetForwardVectorWithoutInterrupt(forward)
	end
end
function sl_modifier_custom_knockback.prototype.OnDestroy(self)
	if not IsServer() then
		return
	end
	local parent = self:GetParent()
	if not IsValid(parent) then
		return
	end
	if IsValid(self) then
		parent:RemoveHorizontalMotionController(self)
		parent:RemoveVerticalMotionController(self)
	end
	if self._destroy_trees_type == "onDestroy" then
		self:_destroy_trees()
	end
	FindClearSpaceForUnit(parent, parent:GetAbsOrigin(), self._interrupt_on_destroy)
	if self._stun_duration > self._duration and IsValidAlive(parent) then
		parent:AddSLModifier("modifier_stunned", {
			ability = self:GetAbility(),
			caster = self:GetCaster(),
			calculate_status_resistance = true,
			duration = self._stun_duration - self._duration,
		})
	end
end
function sl_modifier_custom_knockback.prototype.OnHorizontalMotionInterrupted(self)
	if not IsServer() then
		return
	end
	self:Destroy()
end
function sl_modifier_custom_knockback.prototype.OnVerticalMotionInterrupted(self)
	if not IsServer() then
		return
	end
	self:Destroy()
end
function sl_modifier_custom_knockback.prototype.UpdateHorizontalMotion(self, parent, dt)
	if not IsValid(parent) or not IsServer() then
		return
	end
	if self:GetElapsedTime() > self._duration then
		self:Destroy()
		return
	end
	local distance_delta = self:_get_knock_distance_delta()
	local position = GetGroundPosition(parent:GetAbsOrigin() + self._direction * distance_delta, parent)
	if self._block and not GridNav:CanFindPath(parent:GetAbsOrigin(), position) then
		self:Destroy()
		return
	end
	if self._destroy_trees_type == "continues" then
		self:_destroy_trees()
	end
	if position then
		parent:SetAbsOrigin(position)
	end
end
function sl_modifier_custom_knockback.prototype.UpdateVerticalMotion(self, parent, dt)
	if not IsValid(parent) or not IsServer() then
		return
	end
	if self:GetElapsedTime() > self._duration then
		self:Destroy()
		return
	end
	local fly_height = self:_get_fly_height()
	local ground_height = GetGroundHeight(parent:GetAbsOrigin(), parent)
	local pos = parent:GetAbsOrigin()
	parent:SetAbsOrigin(Vector(pos.x, pos.y, ground_height + fly_height))
end
function sl_modifier_custom_knockback.prototype.DeclareFunctions(self)
	return { MODIFIER_PROPERTY_OVERRIDE_ANIMATION }
end
function sl_modifier_custom_knockback.prototype.GetOverrideAnimation(self)
	return ACT_DOTA_FLAIL
end
function sl_modifier_custom_knockback.prototype.CheckState(self)
	return { [MODIFIER_STATE_STUNNED] = self._stun }
end
function sl_modifier_custom_knockback.prototype._get_fly_height(self)
	local elapsed = self:GetElapsedTime()
	if elapsed <= 0 then
		return 0
	end
	local timeline = elapsed / self._duration
	return self:_height_calculator(elapsed, timeline)
end
function sl_modifier_custom_knockback.prototype._get_knock_distance_delta(self)
	local elapsed = self:GetElapsedTime()
	if elapsed <= 0 then
		return 0
	end
	local dt = 0.03333
	local last_frame_time = math.max(elapsed - dt, 0)
	return math.max(self:_distance_calculator(elapsed, last_frame_time), 0)
end
function sl_modifier_custom_knockback.prototype._destroy_trees(self)
	local parent = self:GetParent()
	if not IsValid(parent) then
		return
	end
	GridNav:DestroyTreesAroundPoint(parent:GetAbsOrigin(), self._destroy_trees_range, true)
end
sl_modifier_custom_knockback._height_calculators = {
	sin = function(____, ____self, elapsed)
		return math.sin(elapsed * (math.pi / ____self._duration)) * ____self._height
	end,
	pow = function(____, ____self, elapsed, timeline)
		local point = 0.6
		local is_rising = timeline <= point
		local factor = is_rising and point or 1 - point
		local ____is_rising_0
		if is_rising then
			____is_rising_0 = ____self._height_power
		else
			____is_rising_0 = ____self._height_power2
		end
		local power = ____is_rising_0
		local ____is_rising_1
		if is_rising then
			____is_rising_1 = timeline
		else
			____is_rising_1 = 1 - timeline
		end
		local t = ____is_rising_1
		return math.pow(t / factor, power) * ____self._height
	end,
	pow2sin = function(____, ____self, elapsed, timeline)
		local split_point = 1 / 3
		if timeline >= split_point and timeline <= 1 - split_point then
			return math.sin(timeline * math.pi) * ____self._height
		else
			local ____temp_2
			if timeline <= split_point then
				____temp_2 = timeline
			else
				____temp_2 = 1 - timeline
			end
			local t = ____temp_2
			return math.pow(t * 2, 0.35) * ____self._height
		end
	end,
	gravity = function(____, ____self, elapsed)
		local initial_velocity = ____self._duration * ____self._gravity / 2
		return elapsed * initial_velocity - 0.5 * ____self._gravity * math.pow(elapsed, 2)
	end,
}
sl_modifier_custom_knockback._distance_calculators = {
	uniform = function(____, ____self, elapsed, last_frame_time)
		local current = ____self._distance / ____self._duration * elapsed
		local last = ____self._distance / ____self._duration * last_frame_time
		return current - last
	end,
	power = function(____, ____self, elapsed, last_frame_time)
		local current = math.pow(elapsed / ____self._duration, ____self._power) * ____self._distance
		local last = math.pow(last_frame_time / ____self._duration, ____self._power) * ____self._distance
		return current - last
	end,
}
sl_modifier_custom_knockback = __TS__Decorate(
	{ registerModifier(nil, "modifiers/game_modifiers/sl_modifier_custom_knockback") },
	sl_modifier_custom_knockback
)
____exports.sl_modifier_custom_knockback = sl_modifier_custom_knockback
return ____exports