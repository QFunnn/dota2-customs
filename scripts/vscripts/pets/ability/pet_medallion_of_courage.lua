--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 9d26fbd · 2026-08-05 05:42:45 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier(
	"modifier_pet_medallion_of_courage_passive_debuff",
	"pets/ability/pet_medallion_of_courage",
	LUA_MODIFIER_MOTION_NONE
)

pet_medallion_of_courage = class({})

function pet_medallion_of_courage:Precache(context)
	PrecacheResource("particle", "particles/units/heroes/hero_slardar/slardar_amp_damage.vpcf", context)
end

function pet_medallion_of_courage:OnSpellStart()
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
		"modifier_pet_medallion_of_courage_passive_debuff",
		{ duration = self:GetSpecialValueFor("duration") * (1 - target:GetStatusResistance()) }
	)
end

-----------------------------------------------------------------------------------------------------------

modifier_pet_medallion_of_courage_passive_debuff = modifier_pet_medallion_of_courage_passive_debuff or class({})
function modifier_pet_medallion_of_courage_passive_debuff:IsHidden()
	return false
end
function modifier_pet_medallion_of_courage_passive_debuff:IsDebuff()
	return true
end
function modifier_pet_medallion_of_courage_passive_debuff:IsPurgable()
	return true
end

function modifier_pet_medallion_of_courage_passive_debuff:GetEffectName()
	return "particles/items2_fx/medallion_of_courage_friend.vpcf"
end

function modifier_pet_medallion_of_courage_passive_debuff:GetEffectAttachType()
	return PATTACH_OVERHEAD_FOLLOW
end

function modifier_pet_medallion_of_courage_passive_debuff:OnCreated()
	EmitSoundOn("Hero_Slardar.Amplify_Damage", self:GetParent())
	self.particle_haze_fx = ParticleManager:CreateParticle(
		"particles/units/heroes/hero_slardar/slardar_amp_damage.vpcf",
		PATTACH_OVERHEAD_FOLLOW,
		self:GetParent()
	)
	ParticleManager:SetParticleControlEnt(
		self.particle_haze_fx,
		1,
		self:GetParent(),
		PATTACH_OVERHEAD_FOLLOW,
		"attach_hitloc",
		self:GetParent():GetAbsOrigin(),
		true
	)
	ParticleManager:SetParticleControlEnt(
		self.particle_haze_fx,
		2,
		self:GetParent(),
		PATTACH_OVERHEAD_FOLLOW,
		"attach_hitloc",
		self:GetParent():GetAbsOrigin(),
		true
	)
	self:AddParticle(self.particle_haze_fx, false, false, -1, false, true)
end

function modifier_pet_medallion_of_courage_passive_debuff:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_PHYSICAL_ARMOR_BONUS,
	}
end

function modifier_pet_medallion_of_courage_passive_debuff:GetModifierPhysicalArmorBonus()
	return self:GetAbility():GetSpecialValueFor("armor") * -1
end