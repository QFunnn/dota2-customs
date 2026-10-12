--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1a5b3bb 
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_centaur_aura", "abilities/creeps_neutral/neutral_centaur_aura", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_centaur_aura_buff", "abilities/creeps_neutral/neutral_centaur_aura", LUA_MODIFIER_MOTION_NONE)

neutral_centaur_aura = class({})

function neutral_centaur_aura:Precache(context)
	PrecacheResource("particle", "particles/creeps/centaur_cloak_cast.vpcf", context)
	PrecacheResource("particle", "particles/creeps/centaur_cloak_buff.vpcf", context)
end

function neutral_centaur_aura:GetIntrinsicModifierName()
	return "modifier_centaur_aura"
end

modifier_centaur_aura = class(mod_hidden)
function modifier_centaur_aura:OnCreated()
	self.parent = self:GetParent()
	self.ability = self:GetAbility()

	self.ability.armor = self.ability:GetSpecialValueFor("armor")
	self.ability.magic = self.ability:GetSpecialValueFor("magic")
	self.ability.radius = self.ability:GetSpecialValueFor("radius")
	self.ability.duration = self.ability:GetSpecialValueFor("duration")

	if not IsServer() then
		return
	end
	self.parent:AddDamageEvent_inc(self, true)
end

function modifier_centaur_aura:DamageEvent_inc(params)
	if not IsServer() then
		return
	end
	if self.parent ~= params.unit then
		return
	end
	if not self.parent:CheckCd("centaur_aura", self.ability.duration) then
		return
	end

	self.parent:EmitSound("Creep.Centaur_cloak")
	self.parent:GenericParticle("particles/creeps/centaur_cloak_cast.vpcf")
	for _, unit in pairs(self.parent:FindFriends(self.ability.radius)) do
		unit:AddNewModifier(
			self.parent,
			self.ability,
			"modifier_centaur_aura_buff",
			{ duration = self.ability.duration }
		)
	end
end

modifier_centaur_aura_buff = class(mod_visible)
function modifier_centaur_aura_buff:GetEffectName()
	return "particles/creeps/centaur_cloak_buff.vpcf"
end
function modifier_centaur_aura_buff:OnCreated()
	self.ability = self:GetAbility()

	self.armor = self.ability.armor
	self.magic = self.ability.magic
end

function modifier_centaur_aura_buff:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_PHYSICAL_ARMOR_BONUS,
		MODIFIER_PROPERTY_MAGICAL_RESISTANCE_BONUS,
	}
end

function modifier_centaur_aura_buff:GetModifierPhysicalArmorBonus()
	return self.armor
end

function modifier_centaur_aura_buff:GetModifierMagicalResistanceBonus()
	return self.magic
end