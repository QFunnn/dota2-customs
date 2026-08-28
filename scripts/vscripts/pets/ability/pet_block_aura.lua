--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 0b85d8d 
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_pet_block_aura_passive", "pets/ability/pet_block_aura", LUA_MODIFIER_MOTION_NONE)

pet_block_aura = class({})

function pet_block_aura:OnSpellStart()
	if IsServer() then
		local duration = self:GetSpecialValueFor("duration")
		local nearby_allies = FindUnitsInRadius(
			self:GetCaster():GetTeamNumber(),
			self:GetCaster():GetAbsOrigin(),
			self:GetCaster(),
			700,
			DOTA_UNIT_TARGET_TEAM_FRIENDLY,
			DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,
			DOTA_UNIT_TARGET_FLAG_NONE,
			FIND_ANY_ORDER,
			false
		)
		for _, ally in pairs(nearby_allies) do
			ally:AddNewModifier(self:GetCaster(), self, "modifier_pet_block_aura_passive", { duration = duration })
		end
	end
end

---------------------------------------------------------

modifier_pet_block_aura_passive = class({})

function modifier_pet_block_aura_passive:OnCreated()
	EmitSoundOn("sounds/items/crimson_guard.vsnd", self:GetCaster())

	self.particle = ParticleManager:CreateParticle(
		"particles/items2_fx/vanguard_active.vpcf",
		PATTACH_OVERHEAD_FOLLOW,
		self:GetParent()
	)
	ParticleManager:SetParticleControl(self.particle, 0, self:GetParent():GetAbsOrigin())
	ParticleManager:SetParticleControlEnt(
		self.particle,
		1,
		self:GetParent(),
		PATTACH_POINT_FOLLOW,
		"attach_origin",
		self:GetParent():GetAbsOrigin(),
		true
	)
	ParticleManager:SetParticleControl(self.particle, 2, Vector(self:GetParent():GetModelRadius() * 1.2, 0, 0))
	self:AddParticle(self.particle, false, false, -1, false, false)

	self.block = self:GetAbility():GetSpecialValueFor("block")
end

function modifier_pet_block_aura_passive:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_TOTAL_CONSTANT_BLOCK,
	}
end

function modifier_pet_block_aura_passive:GetModifierTotal_ConstantBlock()
	return self.block
end