--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 9d26fbd · 2026-08-07 04:51:43 UTC
  ~ auto-generated — do not edit
]]


modifier_levelup_service_pet = class({})

function modifier_levelup_service_pet:IsHidden()
	return true
end
function modifier_levelup_service_pet:IsPurgable()
	return false
end
function modifier_levelup_service_pet:IsPurgeException()
	return false
end

function modifier_levelup_service_pet:OnCreated(params)
	if not IsServer() then
		return
	end

	self.owner = params and params.owner_entindex and EntIndexToHScript(params.owner_entindex)
		or self:GetParent():GetOwner()
	self:StartIntervalThink(0.4)
end

function modifier_levelup_service_pet:CheckState()
	return {
		[MODIFIER_STATE_INVULNERABLE] = true,
		[MODIFIER_STATE_ATTACK_IMMUNE] = true,
		[MODIFIER_STATE_MAGIC_IMMUNE] = true,
		[MODIFIER_STATE_DISARMED] = true,
		[MODIFIER_STATE_NO_UNIT_COLLISION] = true,
		[MODIFIER_STATE_UNSELECTABLE] = true,
		[MODIFIER_STATE_NO_HEALTH_BAR] = true,
	}
end

function modifier_levelup_service_pet:OnIntervalThink()
	if not IsServer() then
		return
	end

	local pet = self:GetParent()
	local owner = self.owner
	if not IsValid(pet) or not IsValid(owner) then
		if IsValid(pet) then
			UTIL_Remove(pet)
		end
		return
	end

	if not owner:IsAlive() then
		pet:AddNoDraw()
		return
	end

	pet:RemoveNoDraw()

	local owner_pos = owner:GetAbsOrigin()
	local pet_pos = pet:GetAbsOrigin()
	local distance = (owner_pos - pet_pos):Length2D()
	local owner_dir = owner:GetForwardVector()
	local preferred_offset = owner_dir * RandomInt(110, 140)

	if distance > 900 then
		local angle = RandomInt(60, 120)
		if RandomInt(1, 2) == 1 then
			angle = angle * -1
		end
		local offset = RotatePosition(Vector(0, 0, 0), QAngle(0, angle, 0), preferred_offset)
		pet:SetAbsOrigin(owner_pos + offset)
		pet:SetForwardVector(owner_dir)
		FindClearSpaceForUnit(pet, owner_pos + offset, true)
	elseif distance > 150 then
		local right = RotatePosition(Vector(0, 0, 0), QAngle(0, RandomInt(70, 110) * -1, 0), preferred_offset)
			+ owner_pos
		local left = RotatePosition(Vector(0, 0, 0), QAngle(0, RandomInt(70, 110), 0), preferred_offset) + owner_pos
		if (pet_pos - right):Length2D() > (pet_pos - left):Length2D() then
			pet:MoveToPosition(left)
		else
			pet:MoveToPosition(right)
		end
	elseif distance < 90 then
		local away = pet_pos - owner_pos
		if away:Length2D() < 1 then
			away = owner_dir * -1
		end
		pet:MoveToPosition(owner_pos + away:Normalized() * RandomInt(110, 140))
	end
end