--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier( "modifier_item_phase_boots_custom", "abilities/items/item_phase_boots_custom", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_item_phase_boots_custom_active", "abilities/items/item_phase_boots_custom", LUA_MODIFIER_MOTION_NONE )

item_phase_boots_custom = class({})

function item_phase_boots_custom:Precache(context)
if self:GetCaster() and self:GetCaster():IsIllusion() then return end
PrecacheResource( "particle","particles/items2_fx/phase_boots.vpcf", context )
end

function item_phase_boots_custom:GetIntrinsicModifierName()
return "modifier_item_phase_boots_custom"
end

function item_phase_boots_custom:OnSpellStart()
local caster = self:GetCaster()
caster:EmitSound("DOTA_Item.PhaseBoots.Activate")
caster:AddNewModifier(caster, self, "modifier_item_phase_boots_custom_active", {duration = self.phase_duration})
end

modifier_item_phase_boots_custom = class(mod_hidden)
function modifier_item_phase_boots_custom:RemoveOnDeath() return false end
function modifier_item_phase_boots_custom:DeclareFunctions()
return 
{
	MODIFIER_PROPERTY_PHYSICAL_ARMOR_BONUS,
	MODIFIER_PROPERTY_MOVESPEED_BONUS_UNIQUE,
	MODIFIER_PROPERTY_PREATTACK_BONUS_DAMAGE,
}
end

function modifier_item_phase_boots_custom:OnCreated(table)
self.parent = self:GetParent()
self.ability = self:GetAbility()

self.ability.bonus_movement_speed = self.ability:GetSpecialValueFor("bonus_movement_speed")
self.ability.bonus_damage_melee = self.ability:GetSpecialValueFor("bonus_damage_melee")
self.ability.bonus_damage_range = self.ability:GetSpecialValueFor("bonus_damage_range")
self.ability.phase_movement_speed = self.ability:GetSpecialValueFor("phase_movement_speed")
self.ability.phase_movement_speed_range = self.ability:GetSpecialValueFor("phase_movement_speed_range")
self.ability.phase_duration = self.ability:GetSpecialValueFor("phase_duration")
self.ability.bonus_armor = self.ability:GetSpecialValueFor("bonus_armor")
end

function modifier_item_phase_boots_custom:GetModifierMoveSpeedBonus_Special_Boots()
return self.ability.bonus_movement_speed
end

function modifier_item_phase_boots_custom:GetModifierPreAttack_BonusDamage()
return self.parent:IsRangedAttacker() and self.ability.bonus_damage_range or self.ability.bonus_damage_melee
end

function modifier_item_phase_boots_custom:GetModifierPhysicalArmorBonus()
return self.ability.bonus_armor
end


modifier_item_phase_boots_custom_active = class(mod_visible)
function modifier_item_phase_boots_custom_active:IsPurgable() return true end
function modifier_item_phase_boots_custom_active:OnCreated()
self.parent = self:GetParent()
self.ability = self:GetAbility()

self.move_ranged = self.ability.phase_movement_speed_range
self.move_melle = self.ability.phase_movement_speed
if not IsServer() then return end
local player_id = self.parent:GetPlayerOwnerID()
local custom_effect_data = shop:GetCurrentEffectData(player_id, "effect_phase_boots")
local pfx_name = "particles/items2_fx/phase_boots.vpcf"
if custom_effect_data then
    pfx_name = custom_effect_data[1]
end

self.parent:GenericParticle(pfx_name, self)
end

function modifier_item_phase_boots_custom_active:CheckState()
return
{
	[MODIFIER_STATE_NO_UNIT_COLLISION] = true,
}
end

function modifier_item_phase_boots_custom_active:DeclareFunctions()
return
{
	MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE
}
end

function modifier_item_phase_boots_custom_active:GetModifierMoveSpeedBonus_Percentage()
return self.parent:IsRangedAttacker() and self.move_ranged or self.move_melle
end


