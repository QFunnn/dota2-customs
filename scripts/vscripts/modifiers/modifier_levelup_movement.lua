--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 9d26fbd · 2026-08-05 19:52:08 UTC
  ~ auto-generated — do not edit
]]


modifier_levelup_movement = class({})

function modifier_levelup_movement:IsHidden()
	return true
end
function modifier_levelup_movement:IsPurgable()
	return false
end

local function face_movement_direction(parent, direction)
	if not direction then
		return
	end
	parent:FaceTowards(parent:GetAbsOrigin() + direction * 100)
end

function modifier_levelup_movement:CheckState()
	return {
		[MODIFIER_STATE_NO_UNIT_COLLISION] = true,
	}
end

function modifier_levelup_movement:OnCreated(params)
	if not IsServer() then
		return
	end

	local parent = self:GetParent()
	local origin = parent:GetAbsOrigin()
	local target = Vector(tonumber(params.target_x) or origin.x, tonumber(params.target_y) or origin.y, origin.z)
	local direction = target - origin
	direction.z = 0

	self.speed = tonumber(params.speed) or 0
	self.distance = tonumber(params.distance) or direction:Length2D()
	self.traveled = 0

	if self.speed <= 0 or self.distance <= 0.01 or direction:Length2D() <= 0.01 then
		self:Destroy()
		return
	end

	self.direction = direction:Normalized()
	self.end_origin = origin + self.direction * self.distance
	self.end_origin.z = origin.z

	face_movement_direction(parent, self.direction)

	if not self:ApplyHorizontalMotionController() then
		self:Destroy()
		return
	end

	self.particle_name = tostring(params.particle or "")
	if self.particle_name ~= "" then
		self.particle = LevelUpParticleManager:CreateParticle(self.particle_name, PATTACH_ABSORIGIN_FOLLOW, parent)
	end

	self.loop_sound = tostring(params.loop_sound or "")
	if self.loop_sound ~= "" then
		EmitSoundOn(self.loop_sound, parent)
	end

	self.end_sound = tostring(params.end_sound or "")
	self.end_particle_cp = tonumber(params.end_particle_cp)
end

local function stop_optional_effects(self, parent)
	if self.particle then
		if self.end_particle_cp then
			LevelUpParticleManager:SetParticleControl(self.particle, self.end_particle_cp, parent:GetAbsOrigin())
		end
		LevelUpParticleManager:DestroyParticle(self.particle, false)
		LevelUpParticleManager:ReleaseParticleIndex(self.particle)
		self.particle = nil
	end

	if self.loop_sound and self.loop_sound ~= "" then
		StopSoundOn(self.loop_sound, parent)
		self.loop_sound = nil
	end

	if self.end_sound and self.end_sound ~= "" then
		EmitSoundOn(self.end_sound, parent)
		self.end_sound = nil
	end
end

function modifier_levelup_movement:OnDestroy()
	if not IsServer() then
		return
	end

	local parent = self:GetParent()
	parent:RemoveHorizontalMotionController(self)
	FindClearSpaceForUnit(parent, parent:GetAbsOrigin(), false)
	face_movement_direction(parent, self.direction)
	stop_optional_effects(self, parent)
end

function modifier_levelup_movement:UpdateHorizontalMotion(parent, dt)
	if parent:IsStunned() then
		self:Destroy()
		return
	end

	local step = math.min(self.speed * dt, self.distance - self.traveled)
	if step <= 0 then
		parent:SetOrigin(self.end_origin)
		self:Destroy()
		return
	end

	local current_origin = parent:GetAbsOrigin()
	local next_origin = current_origin + self.direction * step
	next_origin.z = current_origin.z

	GridNav:DestroyTreesAroundPoint(current_origin, 125, true)
	GridNav:DestroyTreesAroundPoint(next_origin, 125, true)

	if not GridNav:IsTraversable(next_origin) or not GridNav:CanFindPath(current_origin, next_origin) then
		self:Destroy()
		return
	end

	parent:SetOrigin(next_origin)
	face_movement_direction(parent, self.direction)
	self.traveled = self.traveled + step

	if self.traveled >= self.distance then
		parent:SetOrigin(self.end_origin)
		self:Destroy()
	end
end

function modifier_levelup_movement:OnHorizontalMotionInterrupted()
	if not IsServer() then
		return
	end
	self:Destroy()
end