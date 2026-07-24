--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


modifier_equipped_pet = modifier_equipped_pet or class({})


function modifier_equipped_pet:IsPurgable() return false end
function modifier_equipped_pet:RemoveOnDeath() return false end


function modifier_equipped_pet:OnCreated()
	self.parent = self:GetParent()
	self.owner = self:GetCaster()

	self.is_pet_invisible = false

	self.teleport_distance = 900
	self.move_distance = 350
	self.flee_distance = 200

	self.movespeed_multiplier = 1.2

	if not IsServer() then return end
	self:StartIntervalThink(0.1)
end


function modifier_equipped_pet:CheckState()
	return {
		[MODIFIER_STATE_INVULNERABLE] = true,
		[MODIFIER_STATE_UNSELECTABLE] = true,
		[MODIFIER_STATE_NO_UNIT_COLLISION] = true,
		[MODIFIER_STATE_NO_HEALTH_BAR] = true,
		[MODIFIER_STATE_UNTARGETABLE] = true,
		[MODIFIER_STATE_MAGIC_IMMUNE] = true,
		[MODIFIER_STATE_CANNOT_BE_MOTION_CONTROLLED] = true,
		[MODIFIER_STATE_FLYING_FOR_PATHING_PURPOSES_ONLY] = true,
		[MODIFIER_STATE_DISARMED] = true,
		[MODIFIER_STATE_OUT_OF_GAME] = true,
		[MODIFIER_STATE_NOT_ON_MINIMAP] = true,
		[MODIFIER_STATE_TRUESIGHT_IMMUNE] = true,
		[MODIFIER_STATE_BLIND] = true,
		[MODIFIER_STATE_FLYING] = self:GetStackCount() > 0
	}
end


function modifier_equipped_pet:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_MOVESPEED_BASE_OVERRIDE,
		MODIFIER_PROPERTY_IGNORE_MOVESPEED_LIMIT,
	}
end


function modifier_equipped_pet:GetModifierMoveSpeedOverride()
	return self.owner:GetMoveSpeedModifier(self.owner:GetBaseMoveSpeed(), false) * self.movespeed_multiplier
end


function modifier_equipped_pet:GetModifierIgnoreMovespeedLimit() return 1 end


if not IsServer() then return end


function modifier_equipped_pet:PlayBlinkParticle(from, to)
	local equipped_pet = Equipment:GetItemInSlot(self.owner:GetPlayerOwnerID(), INVENTORY_SLOTS.PET)

	local start_particle_name = "particles/items_fx/blink_dagger_start.vpcf"
	local end_particle_name = "particles/items_fx/blink_dagger_start.vpcf"

	if equipped_pet then
		local pet_data = WebInventory:GetItemDefinition(equipped_pet.name)
		if pet_data and pet_data.blink_particles then
			start_particle_name = pet_data.blink_particles.start_name or start_particle_name
			end_particle_name = pet_data.blink_particles.end_name or start_particle_name
		end
	end

	local particle = ParticleManager:CreateParticle(start_particle_name, PATTACH_WORLDORIGIN, nil)
	ParticleManager:SetParticleControl(particle, 0, from)
	ParticleManager:ReleaseParticleIndex(particle)

	if to then
		local particle = ParticleManager:CreateParticle(end_particle_name, PATTACH_WORLDORIGIN, nil)
		ParticleManager:SetParticleControl(particle, 0, to)
		ParticleManager:ReleaseParticleIndex(particle)
	end
end


function modifier_equipped_pet:OnIntervalThink()
	if not self.parent or self.parent:IsNull() then return end
	if not self.owner or self.owner:IsNull() then return end

	if self.owner:IsInvisible() then
		if not self._invisible then
			self.parent:AddNewModifier(self.parent, nil, "modifier_invisible", {})
			self._invisible = true
		end
	elseif self._invisible then
		self.parent:RemoveModifierByName("modifier_invisible")
		self._invisible = false
	end

	-- hide pet if owner is fully dead, and stop moving
	if not self.owner:IsAlive() and not self.owner:IsReincarnating() then
		if not self._hidden_until_respawn then
			self._hidden_until_respawn = true

			self:PlayBlinkParticle(self.parent:GetAbsOrigin())

			self.parent:AddNoDraw()
		end

		return
	elseif self._hidden_until_respawn then
		self.parent:RemoveNoDraw()
		self._hidden_until_respawn = false
	end

	local parent_location = self.parent:GetAbsOrigin()
	local owner_location = self.owner:GetAbsOrigin()
	local direction = parent_location - owner_location
	local direction_normalized = direction:Normalized()
	local distance_to_owner = direction:Length2D()


	if distance_to_owner >= self.teleport_distance then
		local new_location = owner_location + RandomVector(250)
		FindClearSpaceForUnit(self.parent, new_location, true)

		self.parent:SetForwardVector(self.owner:GetForwardVector())

		self:PlayBlinkParticle(parent_location, new_location)
	end

	if distance_to_owner > self.move_distance then
		local right_side = owner_location + RotateVector2D(direction_normalized, -70, false) * 250
		local left_side = owner_location + RotateVector2D(direction_normalized, 70, false) * 250

		-- DebugDrawLine_vCol(left_side, right_side, Vector(255, 0, 0), true, 0.51)

		-- prefer right side, unless it's way too far away
		if (right_side - parent_location):Length2D() > 350 then
			self.parent:MoveToPosition(left_side)
		else
			self.parent:MoveToPosition(right_side)
		end
	end

	if distance_to_owner < self.flee_distance then
		self.parent:MoveToPosition(owner_location + direction_normalized * RandomInt(220, 270))
	end

	if self.parent:IsMoving() then
		self.parent:FadeGesture(ACT_DOTA_IDLE)
		self.parent:StartGesture(ACT_DOTA_RUN)
	else
		self.parent:FadeGesture(ACT_DOTA_RUN)
		self.parent:StartGesture(ACT_DOTA_IDLE)
	end
end