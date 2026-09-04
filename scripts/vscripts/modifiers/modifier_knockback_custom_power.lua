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
local BaseModifierMotionBoth = ____dota_ts_adapter.BaseModifierMotionBoth
____exports.modifier_knockback_custom_power = __TS__Class()
local modifier_knockback_custom_power = ____exports.modifier_knockback_custom_power
modifier_knockback_custom_power.name = "modifier_knockback_custom_power"
__TS__ClassExtends(modifier_knockback_custom_power, BaseModifierMotionBoth)
function modifier_knockback_custom_power.prototype.IsDebuff(self)
	return true
end
function modifier_knockback_custom_power.prototype.IsHidden(self)
	return true
end
function modifier_knockback_custom_power.prototype.IsPurgable(self)
	return true
end
function modifier_knockback_custom_power.prototype.IsPurgeException(self)
	return true
end
function modifier_knockback_custom_power.prototype.RemoveOnDeath(self)
	local ____self_removeOnDeath_0 = self.removeOnDeath
	if ____self_removeOnDeath_0 == nil then
		____self_removeOnDeath_0 = true
	end
	return ____self_removeOnDeath_0
end
function modifier_knockback_custom_power.prototype.GetAttributes(self)
	return MODIFIER_ATTRIBUTE_MULTIPLE
end
function modifier_knockback_custom_power.prototype.OnCreated(self, params)
	if not IsServer() then
		return
	end
	local parent = self:GetParent()
	if not IsValid(nil, parent) then
		return
	end
	local caster = self:GetCaster()
	local data = params
	self.knockback_distance = data.distance or 0
	self.knockback_duration = data.duration
	self.knockback_height = data.height or 0
	self.g = data.gravity or 5000
	self.block = not (data.ignore_walls == 1 or data.ignore_terrain == 1 or data.block == 0 or data.block == false)
	local ____temp_1
	if data.blockUntraversable == 1 then
		____temp_1 = true
	else
		____temp_1 = false
	end
	self.blockUntraversable = ____temp_1
	local ____temp_2
	if data.direction_3d == 1 then
		____temp_2 = true
	else
		____temp_2 = false
	end
	local direction_3d = ____temp_2
	if not data.direction and not data.origin_pos then
		local ____IsValid_result_3
		if IsValid(nil, caster) then
			____IsValid_result_3 = GetDirection(nil, parent:GetAbsOrigin(), caster:GetAbsOrigin())
		else
			____IsValid_result_3 = parent:GetForwardVector()
		end
		self.direction = ____IsValid_result_3
	elseif data.origin_pos then
		local origin_pos = StringToVector(nil, data.origin_pos)
		if origin_pos:__eq(parent:GetAbsOrigin()) then
			self.direction = Vector(0, 0, 0)
		else
			self.direction = GetDirection(nil, parent:GetAbsOrigin(), StringToVector(nil, data.origin_pos))
		end
	else
		local ____direction_3d_4
		if direction_3d then
			____direction_3d_4 = StringToVector(nil, data.direction)
		else
			____direction_3d_4 = Vector(StringToVector(nil, data.direction).x, StringToVector(nil, data.direction).y, 0)
		end
		self.direction = ____direction_3d_4
	end
	self.power = data.power or 0.65
	self.heightPower = data.heightPower or 0.65
	self.heightPower2 = data.heightPower2 or 0.45
	local ____temp_5
	if data.uniform == 1 then
		____temp_5 = true
	else
		____temp_5 = false
	end
	self.uniform = ____temp_5
	self.heightType = data.heightType or "pow"
	self.destroyTreesRange = data.destroyTreesRange or 0
	self.destroyTreesType = data.destroyTreesType or nil
	self.knockBackForward = data.knockBackForward
	local ____temp_6
	if data.interruptMotionControllerOnDestroy == 1 then
		____temp_6 = true
	else
		____temp_6 = false
	end
	self.interruptMotionControllerOnDestroy = ____temp_6
	self.particleName = data.particleName == "" and "particles/modifier/knockback_custom.vpcf"
		or (data.particleName or "")
	local ____data_removeOnDeath_7 = data.removeOnDeath
	if ____data_removeOnDeath_7 == nil then
		____data_removeOnDeath_7 = true
	end
	self.removeOnDeath = ____data_removeOnDeath_7
	local pid = ParticleManager:CreateParticle(self.particleName, PATTACH_ABSORIGIN_FOLLOW, parent)
	self:AddParticle(pid, false, false, 1, false, false)
	self:KnockBackForward()
	if not self:ApplyVerticalMotionController() or not self:ApplyHorizontalMotionController() then
		self:Destroy()
	end
end
function modifier_knockback_custom_power.prototype.KnockBackForward(self)
	local parent = self:GetParent()
	if not self.knockBackForward or not self.direction then
		return
	end
	local ____temp_9
	if self.knockBackForward == "towardsCaster" then
		____temp_9 = -self.direction
	else
		local ____temp_8
		if self.knockBackForward == "backCaster" then
			____temp_8 = self.direction
		else
			____temp_8 = StringToVector(nil, self.knockBackForward) or nil
		end
		____temp_9 = ____temp_8
	end
	local knockBackForward = ____temp_9
	if knockBackForward then
		parent:SetForwardVectorWithoutInterrupt(knockBackForward)
	end
end
function modifier_knockback_custom_power.prototype.OnDestroy(self)
	if IsServer() then
		local parent = self:GetParent()
		if not IsValid(nil, parent) then
			return
		end
		if IsValid(nil, self) then
			parent:RemoveHorizontalMotionController(self)
			parent:RemoveVerticalMotionController(self)
		end
		if self.destroyTreesType == "onDestroy" then
			self:DestroyTrees()
		end
		local ____parent_SetOnClearGround_11 = parent.SetOnClearGround
		local ____self_interruptMotionControllerOnDestroy_10 = self.interruptMotionControllerOnDestroy
		if ____self_interruptMotionControllerOnDestroy_10 == nil then
			____self_interruptMotionControllerOnDestroy_10 = false
		end
		____parent_SetOnClearGround_11(parent, ____self_interruptMotionControllerOnDestroy_10)
	end
end
function modifier_knockback_custom_power.prototype.OnHorizontalMotionInterrupted(self)
	if not IsServer() then
		return
	end
	self:Destroy()
end
function modifier_knockback_custom_power.prototype.OnVerticalMotionInterrupted(self)
	if not IsServer() then
		return
	end
	self:Destroy()
end
function modifier_knockback_custom_power.prototype.UpdateHorizontalMotion(self, parent, dt)
	if not IsValid(nil, parent) or not IsServer() then
		return
	end
	if self:GetElapsedTime() > self.knockback_duration then
		self:Destroy()
		return
	end
	local position = GetGroundPosition(parent:GetAbsOrigin() + self.direction * self:GetKnockDistanceByPower(), parent)
	if
		self.block
		and (
			not GridNav:CanFindPath(parent:GetAbsOrigin(), position) or not IsGridNavDisplacementWalkable(nil, position)
		)
	then
		self:Destroy()
		return
	end
	if self.blockUntraversable == true then
		local blocked = GridNav:IsBlocked(position)
		local traversable = GridNav:IsTraversable(position)
		if blocked or not traversable then
			self:Destroy()
			return
		end
	end
	if self.destroyTreesType == "continues" then
		self:DestroyTrees()
	end
	if position then
		parent:SetAbsOrigin(position)
	end
end
function modifier_knockback_custom_power.prototype.UpdateVerticalMotion(self, parent, dt)
	if not IsValid(nil, parent) or not IsServer() then
		return
	end
	if self:GetElapsedTime() > self.knockback_duration then
		self:Destroy()
		return
	end
	local z = self:GetFlyHeight() or 0
	local height = GetGroundHeight(parent:GetAbsOrigin(), parent) + z
	local p_pos = parent:GetAbsOrigin()
	parent:SetAbsOrigin(Vector(p_pos.x, p_pos.y, height))
end
function modifier_knockback_custom_power.prototype.DeclareFunctions(self)
	return { MODIFIER_PROPERTY_OVERRIDE_ANIMATION }
end
function modifier_knockback_custom_power.prototype.GetOverrideAnimation(self)
	return ACT_DOTA_DISABLED
end
function modifier_knockback_custom_power.prototype.GetFlyHeight(self)
	local elapsedTime = self:GetElapsedTime()
	if elapsedTime <= 0 then
		return 0
	end
	local z
	local timeline = elapsedTime / self.knockback_duration
	local point
	local factor
	local pow
	repeat
		local ____switch44 = self.heightType
		local v0
		local ____cond44 = ____switch44 == "sin"
		if ____cond44 then
			z = math.sin(elapsedTime * (math.pi / self.knockback_duration)) * self.knockback_height
			break
		end
		____cond44 = ____cond44 or ____switch44 == "parabola"
		if ____cond44 then
			do
				local t = math.min(math.max(elapsedTime / self.knockback_duration, 0), 1)
				z = 4 * self.knockback_height * t * (1 - t)
				break
			end
		end
		____cond44 = ____cond44 or ____switch44 == "pow"
		if ____cond44 then
			point = 0.6
			local ____temp_12
			if timeline <= point then
				____temp_12 = point
			else
				____temp_12 = 1 - point
			end
			factor = ____temp_12
			local ____temp_13
			if timeline <= point then
				____temp_13 = self.heightPower
			else
				____temp_13 = self.heightPower2
			end
			pow = ____temp_13
			local ____temp_14
			if timeline <= point then
				____temp_14 = timeline
			else
				____temp_14 = 1 - timeline
			end
			timeline = ____temp_14
			z = math.pow(timeline * (1 / factor), pow) * self.knockback_height
			break
		end
		____cond44 = ____cond44 or ____switch44 == "pow2sin"
		if ____cond44 then
			point = 1 / 3
			local ____temp_15
			if timeline < point then
				____temp_15 = point
			else
				____temp_15 = 1 - point
			end
			factor = ____temp_15
			if timeline >= point and timeline <= 1 - point then
				z = math.sin(timeline * math.pi) * self.knockback_height
			else
				local ____temp_16
				if timeline <= point then
					____temp_16 = timeline
				else
					____temp_16 = 1 - timeline
				end
				timeline = ____temp_16
				pow = 0.35
				z = math.pow(timeline * 2, pow) * self.knockback_height
			end
			break
		end
		____cond44 = ____cond44 or ____switch44 == "gravity"
		if ____cond44 then
			v0 = self.knockback_duration * self.g / 2
			z = elapsedTime * v0 - 0.5 * self.g * math.pow(elapsedTime, 2)
			break
		end
		do
			break
		end
	until true
	return z
end
function modifier_knockback_custom_power.prototype.GetKnockDistanceByPower(self)
	local dt = 0.03333
	local elapsedTime = self:GetElapsedTime()
	if elapsedTime <= 0 then
		return 0
	end
	local lastFrame = math.max(elapsedTime - dt, 0)
	local ____table_uniform_17
	if self.uniform then
		____table_uniform_17 = self.knockback_distance / self.knockback_duration * elapsedTime
	else
		____table_uniform_17 = math.pow(elapsedTime / self.knockback_duration, self.power) * self.knockback_distance
	end
	local distance = ____table_uniform_17
	local ____table_uniform_18
	if self.uniform then
		____table_uniform_18 = self.knockback_distance / self.knockback_duration * lastFrame
	else
		____table_uniform_18 = math.pow(lastFrame / self.knockback_duration, self.power) * self.knockback_distance
	end
	local lastDistance = ____table_uniform_18
	return math.max(distance - lastDistance, 0)
end
function modifier_knockback_custom_power.prototype.DestroyTrees(self)
	local parent = self:GetParent()
	if not IsValid(nil, parent) then
		return
	end
	local pos = parent:GetAbsOrigin()
	GridNav:DestroyTreesAroundPoint(pos, self.destroyTreesRange, true)
end
modifier_knockback_custom_power = __TS__DecorateLegacy({ registerModifier(nil) }, modifier_knockback_custom_power)
____exports.modifier_knockback_custom_power = modifier_knockback_custom_power
return ____exports