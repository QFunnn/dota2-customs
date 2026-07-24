--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier( "modifier_item_mekansm_custom", "abilities/items/item_mekansm_custom", LUA_MODIFIER_MOTION_NONE )	

item_mekansm_custom = class({})

function item_mekansm_custom:Precache(context)
if self:GetCaster() and self:GetCaster():IsIllusion() then return end
PrecacheResource( "particle","particles/items2_fx/mekanism.vpcf", context )
PrecacheResource( "particle","particles/items2_fx/mekanism_recipient.vpcf", context )
end

function item_mekansm_custom:GetIntrinsicModifierName()
	return "modifier_item_mekansm_custom"
end

function item_mekansm_custom:OnSpellStart()

local caster = self:GetCaster()
local heal = self:GetSpecialValueFor("heal_amount")/100
local radius = self:GetSpecialValueFor("radius")
caster:EmitSound("DOTA_Item.Mekansm.Activate")

local player_id = caster:GetPlayerOwnerID()
local custom_effect_data = shop:GetCurrentEffectData(player_id, "effect_mekansm")
local default_effect = "particles/items2_fx/mekanism.vpcf"
local default_effect_recipient = "particles/items2_fx/mekanism_recipient.vpcf"
if custom_effect_data then
    default_effect = custom_effect_data[1]
    default_effect_recipient = custom_effect_data[2]
end

local particle_1 = ParticleManager:CreateParticle(default_effect, PATTACH_ABSORIGIN_FOLLOW, caster)
ParticleManager:ReleaseParticleIndex(particle_1)

local friends = FindUnitsInRadius(caster:GetTeamNumber(), caster:GetAbsOrigin(), nil, radius, DOTA_UNIT_TARGET_TEAM_FRIENDLY, DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC, DOTA_UNIT_TARGET_FLAG_INVULNERABLE, FIND_CLOSEST, false)

for _,friend in pairs(friends) do

	local heal_amount = heal*friend:GetMaxHealth()

	friend:GenericHeal(heal_amount, self)

	friend:EmitSound("DOTA_Item.Mekansm.Target")
	local particle_2 = ParticleManager:CreateParticle(default_effect_recipient, PATTACH_ABSORIGIN_FOLLOW, friend)
	ParticleManager:SetParticleControl(particle_2, 0, friend:GetAbsOrigin())
	ParticleManager:SetParticleControlEnt(particle_2, 1, friend, PATTACH_ABSORIGIN_FOLLOW, nil, friend:GetAbsOrigin(), true)
	ParticleManager:ReleaseParticleIndex(particle_2)
end


end

modifier_item_mekansm_custom = class({})

function modifier_item_mekansm_custom:IsHidden()		return true end
function modifier_item_mekansm_custom:IsPurgable()	return false end
function modifier_item_mekansm_custom:RemoveOnDeath()	return false end
function modifier_item_mekansm_custom:GetAttributes()	return MODIFIER_ATTRIBUTE_MULTIPLE end

function modifier_item_mekansm_custom:DeclareFunctions()
	local funcs = {

		MODIFIER_PROPERTY_PHYSICAL_ARMOR_BONUS,
		MODIFIER_PROPERTY_HEALTH_REGEN_CONSTANT,
	}
	return funcs
end

function modifier_item_mekansm_custom:GetModifierPhysicalArmorBonus()
	return self:GetAbility():GetSpecialValueFor("bonus_armor")
end

function modifier_item_mekansm_custom:GetModifierConstantHealthRegen()
	return self:GetAbility():GetSpecialValueFor("health_regen")
end
