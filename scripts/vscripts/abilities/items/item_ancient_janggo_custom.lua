--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_item_ancient_janggo_custom", "abilities/items/item_ancient_janggo_custom", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_item_ancient_janggo_custom_active", "abilities/items/item_ancient_janggo_custom", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_item_ancient_janggo_custom_aura", "abilities/items/item_ancient_janggo_custom", LUA_MODIFIER_MOTION_NONE)

item_ancient_janggo_custom = class({})

function item_ancient_janggo_custom:GetIntrinsicModifierName()
	return "modifier_item_ancient_janggo_custom"
end
function item_ancient_janggo_custom:Precache(context)
if self:GetCaster() and self:GetCaster():IsIllusion() then return end
PrecacheResource( "particle","particles/items_fx/drum_of_endurance_buff.vpcf", context )
end


function item_ancient_janggo_custom:OnSpellStart()
local caster = self:GetCaster()

local units = FindUnitsInRadius( self:GetTeamNumber(), caster:GetAbsOrigin(), nil, self.radius, DOTA_UNIT_TARGET_TEAM_FRIENDLY, DOTA_UNIT_TARGET_BASIC + DOTA_UNIT_TARGET_HERO, DOTA_UNIT_TARGET_FLAG_INVULNERABLE, FIND_CLOSEST,false)
for _,unit in pairs(units) do 
    unit:AddNewModifier(caster, self, "modifier_item_ancient_janggo_custom_active", {duration = self.duration})
end 

caster:EmitSound("DOTA_Item.DoE.Activate")
end

modifier_item_ancient_janggo_custom = class(mod_hidden)
function modifier_item_ancient_janggo_custom:DeclareFunctions()
return
{
    MODIFIER_PROPERTY_STATS_STRENGTH_BONUS,
}
end

function modifier_item_ancient_janggo_custom:OnCreated()
self.parent = self:GetParent()
self.ability = self:GetAbility()

self.ability.aura_movement_speed = self.ability:GetSpecialValueFor("aura_movement_speed")
self.ability.aura_regen = self.ability:GetSpecialValueFor("aura_regen")
self.ability.bonus_str = self.ability:GetSpecialValueFor("bonus_str")
self.ability.bonus_attack_speed_pct = self.ability:GetSpecialValueFor("bonus_attack_speed_pct")
self.ability.bonus_movement_speed_pct = self.ability:GetSpecialValueFor("bonus_movement_speed_pct")
self.ability.duration = self.ability:GetSpecialValueFor("duration")
self.ability.radius = self.ability:GetSpecialValueFor("radius")
end 

function modifier_item_ancient_janggo_custom:GetModifierBonusStats_Strength()
return self.ability.bonus_str
end

function modifier_item_ancient_janggo_custom:IsAura() return true end
function modifier_item_ancient_janggo_custom:GetAuraSearchTeam() return DOTA_UNIT_TARGET_TEAM_FRIENDLY end
function modifier_item_ancient_janggo_custom:GetAuraSearchType() return DOTA_UNIT_TARGET_BASIC + DOTA_UNIT_TARGET_HERO end
function modifier_item_ancient_janggo_custom:GetModifierAura() return "modifier_item_ancient_janggo_custom_aura" end
function modifier_item_ancient_janggo_custom:GetAuraRadius() return self.ability.radius end


modifier_item_ancient_janggo_custom_aura = class(mod_visible)
function modifier_item_ancient_janggo_custom_aura:OnCreated()
self.parent = self:GetParent()
self.ability = self:GetAbility()

self.speed = self.ability.aura_movement_speed
self.regen = self.ability.aura_regen
end 

function modifier_item_ancient_janggo_custom_aura:DeclareFunctions()
return
{
    MODIFIER_PROPERTY_MOVESPEED_BONUS_CONSTANT,
    MODIFIER_PROPERTY_HEALTH_REGEN_CONSTANT
}
end

function modifier_item_ancient_janggo_custom_aura:GetModifierConstantHealthRegen()
return self.regen
end

function modifier_item_ancient_janggo_custom_aura:GetModifierMoveSpeedBonus_Constant()
return self.speed
end


modifier_item_ancient_janggo_custom_active = class({})
function modifier_item_ancient_janggo_custom_active:IsHidden() return false end
function modifier_item_ancient_janggo_custom_active:IsPurgable() return true end
function modifier_item_ancient_janggo_custom_active:OnCreated(table)
self.parent = self:GetParent()
self.caster = self:GetCaster()
self.ability = self:GetAbility()

self.attack_speed =  self.ability.bonus_attack_speed_pct
self.move_speed = self.ability.bonus_movement_speed_pct

if not IsServer() then return end 
local particle_buff_fx = ParticleManager:CreateParticle("particles/items_fx/drum_of_endurance_buff.vpcf", PATTACH_ABSORIGIN_FOLLOW, self.parent)
ParticleManager:SetParticleControl(particle_buff_fx, 0, self.parent:GetAbsOrigin())
ParticleManager:SetParticleControl(particle_buff_fx, 1, Vector(0,0,0))
self:AddParticle(particle_buff_fx, false, false, -1, false, false)
end

function modifier_item_ancient_janggo_custom_active:DeclareFunctions()
return
{
    MODIFIER_PROPERTY_ATTACKSPEED_BONUS_CONSTANT,
    MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE
}
end

function modifier_item_ancient_janggo_custom_active:GetModifierMoveSpeedBonus_Percentage()
return self.move_speed
end

function modifier_item_ancient_janggo_custom_active:GetModifierAttackSpeedBonus_Constant()
return self.attack_speed
end