--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 9d26fbd · 2026-08-03 22:18:26 UTC
  ~ auto-generated — do not edit
]]


modifier_generic_knockback_lua = class({})

--------------------------------------------------------------------------------
-- Classifications
function modifier_generic_knockback_lua:IsHidden()
	return true
end

function modifier_generic_knockback_lua:IsPurgable()
	return false
end

function modifier_generic_knockback_lua:GetAttributes()
	return MODIFIER_ATTRIBUTE_MULTIPLE
end
--------------------------------------------------------------------------------
-- Initializations
function modifier_generic_knockback_lua:OnCreated(kv)
	if IsServer() then
		if IsLevelUpControlImmuneUnit and IsLevelUpControlImmuneUnit(self:GetParent()) then
			self.interrupted = true
			self:Destroy()
			return
		end
		-- creation data (default)
		-- kv.distance (0)
		-- kv.height (-1)
		-- kv.duration (0)
		-- kv.direction_x, kv.direction_y, kv.direction_z (xy:-forward vector, z:0)
		-- kv.tree_destroy_radius (hull-radius), can be null if -1
		-- kv.IsStun (false)
		-- kv.IsFlail (true)
		-- kv.IsPurgable() // later
		-- kv.IsMultiple() // later

		-- kv.aplly_pcf (0) use particle effect
		-- kv.pcf_name (string) custom particle effect name if aplly_pcf is 1, default (particles/items_fx/force_staff.vpcf)

		-- kv.apply_status_pcf (0) use status effect
		-- kv.pcf_status_name (string) custom status particle effect name if aplly_pcf is 1, default (particles/status_fx/status_effect_forcestaff.vpcf)

		-- kv.anim_target (int) override animation

		-- references
		self.aplly_pcf = kv.aplly_pcf or 0
		if self.aplly_pcf == 1 then
			local pcf_name = "particles/items_fx/force_staff.vpcf"
			if kv.pcf_name ~= nil then
				pcf_name = kv.pcf_name
			end
			self.particle = LevelUpParticleManager:CreateParticle(pcf_name, PATTACH_POINT_FOLLOW, self:GetParent())
		end
		self.apply_status_pcf = kv.apply_status_pcf or 0
		if self.apply_status_pcf == 1 then
			self.pcf_status_name = "particles/status_fx/status_effect_forcestaff.vpcf"
			if kv.pcf_status_name ~= nil then
				self.pcf_status_name = kv.pcf_status_name
			end
		end

		self.anim_target = kv.anim_target or 0
		self.distance = kv.distance or 0
		self.height = kv.height or -1
		self.duration = kv.duration or 0
		if kv.direction_x and kv.direction_y then
			self.direction = Vector(kv.direction_x, kv.direction_y, 0):Normalized()
		else
			self.direction = -(self:GetParent():GetForwardVector())
		end
		self.tree = kv.tree_destroy_radius or self:GetParent():GetHullRadius()

		if kv.IsStun then
			self.stun = kv.IsStun == 1
		else
			self.stun = false
		end
		if kv.IsFlail then
			self.flail = kv.IsFlail == 1
		else
			self.flail = true
		end

		-- check duration
		if self.duration == 0 then
			self:Destroy()
			return
		end

		-- load data
		self.parent = self:GetParent()
		self.origin = self.parent:GetOrigin()

		-- horizontal init
		self.hVelocity = self.distance / self.duration

		-- vertical init
		local half_duration = self.duration / 2
		self.gravity = 2 * self.height / (half_duration * half_duration)
		self.vVelocity = self.gravity * half_duration

		-- apply motion controllers
		if self.distance > 0 then
			if self:ApplyHorizontalMotionController() == false then
				self:Destroy()
				return
			end
		end
		if self.height >= 0 then
			if self:ApplyVerticalMotionController() == false then
				self:Destroy()
				return
			end
		end

		-- tell client of activity
		if self.flail then
			self:SetStackCount(1)
		elseif self.stun then
			self:SetStackCount(2)
		end
		self:SetHasCustomTransmitterData(true)
	else
		self.anim = self:GetStackCount()
		self:SetStackCount(0)
	end
end

function modifier_generic_knockback_lua:AddCustomTransmitterData()
	return {
		apply_status_pcf = self.apply_status_pcf,
		anim_target = self.anim_target,
		pcf_status_name = self.pcf_status_name,
	}
end

function modifier_generic_knockback_lua:HandleCustomTransmitterData(data)
	self.apply_status_pcf = data.apply_status_pcf
	self.anim_target = data.anim_target
	self.pcf_status_name = data.pcf_status_name
end

function modifier_generic_knockback_lua:OnRefresh(kv)
	if not IsServer() then
		return
	end
end

function modifier_generic_knockback_lua:OnDestroy(kv)
	if not IsServer() then
		return
	end

	if self.particle then
		LevelUpParticleManager:DestroyParticle(self.particle, false)
		LevelUpParticleManager:ReleaseParticleIndex(self.particle)
		self.particle = nil
	end

	if not self.interrupted then
		-- destroy trees
		if self.tree > 0 then
			GridNav:DestroyTreesAroundPoint(self:GetParent():GetOrigin(), self.tree, true)
		end
	end

	if self.EndCallback then
		self.EndCallback(self.interrupted)
	end

	self:GetParent():InterruptMotionControllers(true)
end

--------------------------------------------------------------------------------
-- Setter
function modifier_generic_knockback_lua:SetEndCallback(func)
	self.EndCallback = func
end

--------------------------------------------------------------------------------
-- Modifier Effects
function modifier_generic_knockback_lua:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_OVERRIDE_ANIMATION,
	}

	return funcs
end

function modifier_generic_knockback_lua:GetOverrideAnimation(params)
	if self.anim_target then
		return self.anim_target
	end
	if self.anim == 1 then
		return ACT_DOTA_FLAIL
	elseif self.anim == 2 then
		return ACT_DOTA_DISABLED
	end
end

--------------------------------------------------------------------------------
-- Status Effects
function modifier_generic_knockback_lua:CheckState()
	local state = {
		[MODIFIER_STATE_STUNNED] = self.stun,
	}

	return state
end

--------------------------------------------------------------------------------
-- Motion effects
function modifier_generic_knockback_lua:UpdateHorizontalMotion(me, dt)
	local parent = self:GetParent()

	-- set position
	local target = self.direction * self.distance * (dt / self.duration)

	if self.tree > 0 then
		GridNav:DestroyTreesAroundPoint(self:GetParent():GetOrigin(), self.tree, true)
	end

	parent:SetOrigin(parent:GetOrigin() + target)
end

function modifier_generic_knockback_lua:OnHorizontalMotionInterrupted()
	if IsServer() then
		self.interrupted = true
		self:Destroy()
	end
end

function modifier_generic_knockback_lua:UpdateVerticalMotion(me, dt)
	-- set time
	local time = dt / self.duration
	if self.height > 0 then
		-- change height
		self.parent:SetOrigin(self.parent:GetOrigin() + Vector(0, 0, self.vVelocity * dt))
		-- calculate vertical velocity
		self.vVelocity = self.vVelocity - self.gravity * dt
	elseif self.height == 0 then
		self.parent:SetOrigin(GetGroundPosition(self.parent:GetOrigin(), self.parent))
	end
end

function modifier_generic_knockback_lua:OnVerticalMotionInterrupted()
	if IsServer() then
		self.interrupted = true
		self:Destroy()
	end
end

--------------------------------------------------------------------------------
-- Graphics & Animations
function modifier_generic_knockback_lua:GetEffectName()
	if not IsServer() then
		return
	end
	if self.stun then
		return "particles/generic_gameplay/generic_stunned.vpcf"
	end
end

function modifier_generic_knockback_lua:GetEffectAttachType()
	if not IsServer() then
		return
	end
	return PATTACH_OVERHEAD_FOLLOW
end

function modifier_generic_knockback_lua:GetStatusEffectName()
	if not IsServer() then
		return
	end
	if self.apply_status_pcf then
		return self.pcf_status_name or "particles/status_fx/status_effect_forcestaff.vpcf"
	end
end