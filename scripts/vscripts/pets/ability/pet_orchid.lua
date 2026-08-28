--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 0b85d8d 
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_pet_orchid_passive_debuff", "pets/ability/pet_orchid", LUA_MODIFIER_MOTION_NONE)

pet_orchid = class({})

function pet_orchid:OnSpellStart()
	local target = self:GetCursorTarget()

	if target:GetTeam() ~= self:GetCaster():GetTeam() then
		if target:TriggerSpellAbsorb(self) then
			return nil
		end
	end

	if target:IsMagicImmune() then
		return nil
	end

	target:EmitSound("DOTA_Item.Orchid.Activate")

	target:AddNewModifier(
		self:GetCaster(),
		self,
		"modifier_pet_orchid_passive_debuff",
		{ duration = self:GetSpecialValueFor("duration") * (1 - target:GetStatusResistance()) }
	)
end

-----------------------------------------------------------------------------------------------------------

modifier_pet_orchid_passive_debuff = modifier_pet_orchid_passive_debuff or class({})
function modifier_pet_orchid_passive_debuff:IsHidden()
	return false
end
function modifier_pet_orchid_passive_debuff:IsDebuff()
	return true
end
function modifier_pet_orchid_passive_debuff:IsPurgable()
	return true
end

function modifier_pet_orchid_passive_debuff:GetEffectName()
	return "particles/items2_fx/orchid.vpcf"
end

function modifier_pet_orchid_passive_debuff:GetEffectAttachType()
	return PATTACH_OVERHEAD_FOLLOW
end

function modifier_pet_orchid_passive_debuff:OnCreated()
	if IsServer() then
		if not self:GetAbility() then
			self:Destroy()
		end
	end

	if IsServer() then
		local owner = self:GetParent()
		owner.orchid_damage_storage = owner.orchid_damage_storage or 0
		self.damage_factor = self:GetAbility():GetSpecialValueFor("damage")
	end
end

function modifier_pet_orchid_passive_debuff:DeclareFunctions()
	return {
		MODIFIER_EVENT_ON_TAKEDAMAGE,
	}
end

function modifier_pet_orchid_passive_debuff:CheckState()
	return {
		[MODIFIER_STATE_SILENCED] = true,
	}
end

function modifier_pet_orchid_passive_debuff:OnTakeDamage(keys)
	if IsServer() then
		local owner = self:GetParent()
		local target = keys.unit

		if owner == target then
			owner.orchid_damage_storage = owner.orchid_damage_storage + keys.damage
		end
	end
end

function modifier_pet_orchid_passive_debuff:OnDestroy()
	if IsServer() then
		local owner = self:GetParent()
		local ability = self:GetAbility()
		local caster = ability:GetCaster()

		if owner.orchid_damage_storage > 0 then
			local damage = owner.orchid_damage_storage * self.damage_factor * 0.01
			ApplyDamage({
				attacker = caster,
				victim = owner,
				ability = ability,
				damage = damage,
				damage_type = DAMAGE_TYPE_MAGICAL,
			})

			local orchid_end_pfx =
				ParticleManager:CreateParticle("particles/items2_fx/orchid_pop.vpcf", PATTACH_OVERHEAD_FOLLOW, owner)
			ParticleManager:SetParticleControl(orchid_end_pfx, 0, owner:GetAbsOrigin())
			ParticleManager:SetParticleControl(orchid_end_pfx, 1, Vector(100, 0, 0))
			ParticleManager:ReleaseParticleIndex(orchid_end_pfx)
		end

		self:GetParent().orchid_damage_storage = nil
	end
end