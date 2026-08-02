--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build b9dc48c · 2026-08-02 17:42:46 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_pet_magic_block_aura_passive", "pets/ability/pet_magic_block_aura", LUA_MODIFIER_MOTION_NONE)

pet_magic_block_aura = class({})

function pet_magic_block_aura:OnSpellStart()
	if IsServer() then
		EmitSoundOn("DOTA_Item.Pipe.Activate", self:GetCaster())
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
			ally:AddNewModifier(
				self:GetCaster(),
				self,
				"modifier_pet_magic_block_aura_passive",
				{ duration = duration }
			)
		end
	end
end

---------------------------------------------------------

modifier_pet_magic_block_aura_passive = class({})

function modifier_pet_magic_block_aura_passive:OnCreated()
	self.particle = ParticleManager:CreateParticle(
		"particles/items2_fx/pipe_of_insight.vpcf",
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

function modifier_pet_magic_block_aura_passive:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_MAGICAL_RESISTANCE_BONUS,
	}
end

function modifier_pet_magic_block_aura_passive:GetModifierMagicalResistanceBonus()
	return self.block
end