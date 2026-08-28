--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 0b85d8d 
  ~ auto-generated — do not edit
]]


marci_call_to_arms = class({})
LinkLuaModifier("modifier_marci_call_to_arms", "abilities/heroes/marci/marci_call_to_arms", LUA_MODIFIER_MOTION_NONE)

function marci_call_to_arms:OnSpellStart()
	self.caster = self:GetCaster()
	if not IsValidEntity(self.caster) then
		return
	end

	EmitGlobalSound("Hero_Marci.SpecialDelivery.Cast")

	local duration = self:GetSpecialValueFor("duration")

	local allies = FindUnitsInRadius(
		self.caster:GetTeamNumber(),
		self.caster:GetAbsOrigin(),
		nil,
		-1,
		self:GetAbilityTargetTeam(),
		self:GetAbilityTargetType(),
		self:GetAbilityTargetFlags(),
		FIND_ANY_ORDER,
		false
	)
	for _, ally in pairs(allies) do
		if IsValidEntity(ally) and ally:IsAlive() then
			ally:AddNewModifier(self.caster, self, "modifier_marci_call_to_arms", { duration = duration })
		end
	end
end

-------------------------------------------------------------------------------------------------------------------------------------------

modifier_marci_call_to_arms = class({})

function modifier_marci_call_to_arms:IsHidden()
	return false
end
function modifier_marci_call_to_arms:IsPurgable()
	return true
end
function modifier_marci_call_to_arms:RemoveOnDeath()
	return true
end

function modifier_marci_call_to_arms:GetEffectName()
	return "particles/items_fx/drum_of_endurance_buff.vpcf"
end
function modifier_marci_call_to_arms:GetEffectAttachType()
	return PATTACH_CENTER_FOLLOW
end

function modifier_marci_call_to_arms:OnCreated()
	self.caster = self:GetCaster()
	self.parent = self:GetParent()
	self.ability = self:GetAbility()

	if not IsValidEntity(self.caster) then
		return
	end
	if not IsValidEntity(self.parent) then
		return
	end
	if not IsValidEntity(self.ability) then
		return
	end

	self.interval = 0.2
	self.movement_speed_pct = self.ability:GetSpecialValueFor("movement_speed_pct")
	self.angle_diff = self.ability:GetSpecialValueFor("angle_diff")

	if not IsServer() then
		return
	end

	if self.caster == self.parent then
		self:SetStackCount(self.movement_speed_pct)
		return
	end

	self:OnIntervalThink()
	self:StartIntervalThink(self.interval)
end

function marci_call_to_arms:OnRefresh()
	self:OnCreated()
end

function modifier_marci_call_to_arms:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE,
	}
end

function modifier_marci_call_to_arms:GetModifierMoveSpeedBonus_Percentage()
	return self:GetStackCount()
end

function modifier_marci_call_to_arms:OnIntervalThink()
	if not self or self:IsNull() then
		return
	end
	if not IsValidEntity(self.caster) then
		return
	end
	if not IsValidEntity(self.parent) then
		return
	end
	if not IsValidEntity(self.ability) then
		return
	end

	local facing_angle = self.parent:GetAnglesAsVector().y
	local parent_origin = self.parent:GetAbsOrigin()
	local caster_origin = self.caster:GetAbsOrigin()
	local direction_to_caster = (caster_origin - parent_origin):Normalized()
	local direction_to_caster_angle = VectorToAngles(direction_to_caster).y
	local angle_diff = math.abs(AngleDiff(facing_angle, direction_to_caster_angle))

	local previous_movement_speed_pct = self:GetStackCount()
	local current_movement_speed_pct = angle_diff <= self.angle_diff and self.movement_speed_pct or 0
	if previous_movement_speed_pct == current_movement_speed_pct then
		return
	end
	self:SetStackCount(current_movement_speed_pct)
end