--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1a5b3bb 
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_item_mekansm_custom", "abilities/items/item_mekansm_custom", LUA_MODIFIER_MOTION_NONE)

item_mekansm_custom = class({})

function item_mekansm_custom:Precache(context)
	if self:GetCaster() and self:GetCaster():IsIllusion() then
		return
	end
	PrecacheResource("particle", "particles/items2_fx/mekanism.vpcf", context)
	PrecacheResource("particle", "particles/items2_fx/mekanism_recipient.vpcf", context)
end

function item_mekansm_custom:GetIntrinsicModifierName()
	return "modifier_item_mekansm_custom"
end

function item_mekansm_custom:Spawn()
	self.heal_amount = self:GetSpecialValueFor("heal_amount")
	self.radius = self:GetSpecialValueFor("radius")
	self.bonus_armor = self:GetSpecialValueFor("bonus_armor")
	self.health_regen = self:GetSpecialValueFor("health_regen")
end

function item_mekansm_custom:OnSpellStart()
	local caster = self:GetCaster()
	local heal = self.heal_amount / 100
	local radius = self.radius
	caster:EmitSound("DOTA_Item.Mekansm.Activate")

	local player_id = caster:GetPlayerOwnerID()
	local custom_effect_data = shop:GetCurrentEffectData(player_id, "effect_mekansm")
	local default_effect = "particles/items2_fx/mekanism.vpcf"
	local default_effect_recipient = "particles/items2_fx/mekanism_recipient.vpcf"
	if custom_effect_data then
		default_effect = custom_effect_data[1]
		default_effect_recipient = custom_effect_data[2]
	end

	caster:GenericParticle(default_effect)

	local friends = caster:FindFriends(radius, nil, nil, DOTA_UNIT_TARGET_FLAG_INVULNERABLE)

	for _, friend in pairs(friends) do
		local heal_amount = heal * friend:GetMaxHealth()

		friend:GenericHeal(heal_amount, self)

		friend:EmitSound("DOTA_Item.Mekansm.Target")
		local particle_2 = ParticleManager:CreateParticle(default_effect_recipient, PATTACH_ABSORIGIN_FOLLOW, friend)
		ParticleManager:SetParticleControl(particle_2, 0, friend:GetAbsOrigin())
		ParticleManager:SetParticleControlEnt(
			particle_2,
			1,
			friend,
			PATTACH_ABSORIGIN_FOLLOW,
			nil,
			friend:GetAbsOrigin(),
			true
		)
		ParticleManager:ReleaseParticleIndex(particle_2)
	end
end

modifier_item_mekansm_custom = class(mod_hidden)
function modifier_item_mekansm_custom:RemoveOnDeath()
	return false
end
function modifier_item_mekansm_custom:GetAttributes()
	return MODIFIER_ATTRIBUTE_MULTIPLE
end
function modifier_item_mekansm_custom:OnCreated()
	self.ability = self:GetAbility()
end

function modifier_item_mekansm_custom:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_PHYSICAL_ARMOR_BONUS,
		MODIFIER_PROPERTY_HEALTH_REGEN_CONSTANT,
	}
end

function modifier_item_mekansm_custom:GetModifierPhysicalArmorBonus()
	return self.ability.bonus_armor
end

function modifier_item_mekansm_custom:GetModifierConstantHealthRegen()
	return self.ability.health_regen
end