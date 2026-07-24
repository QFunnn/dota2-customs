--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_item_solar_crest_custom", "abilities/items/item_solar_crest_custom", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_item_solar_crest_custom_speed", "abilities/items/item_solar_crest_custom", LUA_MODIFIER_MOTION_NONE)


item_solar_crest_custom = class({})

function item_solar_crest_custom:GetIntrinsicModifierName()
return "modifier_item_solar_crest_custom"
end

function item_solar_crest_custom:Precache(context)
if self:GetCaster() and self:GetCaster():IsIllusion() then return end
PrecacheResource( "particle","particles/items3_fx/star_emblem_friend.vpcf", context )
PrecacheResource( "particle","particles/items2_fx/pavise_friend.vpcf", context )
PrecacheResource( "particle","particles/general/generic_armor_reduction.vpcf", context )
PrecacheResource( "particle","particles/items/pavise_shield.vpcf", context )
end


function item_solar_crest_custom:GetBehavior()
if not IsSoloMode() then 
    return DOTA_ABILITY_BEHAVIOR_UNIT_TARGET + DOTA_ABILITY_BEHAVIOR_IMMEDIATE
end 
return DOTA_ABILITY_BEHAVIOR_NO_TARGET + DOTA_ABILITY_BEHAVIOR_IMMEDIATE
end

function item_solar_crest_custom:OnSpellStart()
local caster = self:GetCaster()
local target = caster
if self:GetCursorTarget() then
    target = self:GetCursorTarget()
end

target:EmitSound("Item.Pavise.Target")
caster:EmitSound("Item.Star_emblem_cast")
target:AddNewModifier(caster, self, "modifier_item_solar_crest_custom_speed", {duration = self.duration})
end 

modifier_item_solar_crest_custom = class(mod_hidden)
function modifier_item_solar_crest_custom:GetAttributes() return MODIFIER_ATTRIBUTE_MULTIPLE end
function modifier_item_solar_crest_custom:DeclareFunctions()
return 
{
    MODIFIER_PROPERTY_MANA_BONUS,
    MODIFIER_PROPERTY_HEALTH_BONUS,
    MODIFIER_PROPERTY_PHYSICAL_ARMOR_BONUS,
    MODIFIER_PROPERTY_MOVESPEED_BONUS_CONSTANT,
}
end

function modifier_item_solar_crest_custom:OnCreated()
self.ability = self:GetAbility()

self.ability.bonus_armor = self.ability:GetSpecialValueFor("bonus_armor")
self.ability.self_movement_speed = self.ability:GetSpecialValueFor("self_movement_speed")
self.ability.bonus_mana = self.ability:GetSpecialValueFor("bonus_mana")
self.ability.bonus_health = self.ability:GetSpecialValueFor("bonus_health")
self.ability.target_movement_speed = self.ability:GetSpecialValueFor("target_movement_speed")
self.ability.target_attack_speed = self.ability:GetSpecialValueFor("target_attack_speed")
self.ability.duration = self.ability:GetSpecialValueFor("duration")
self.ability.absorb_amount = self.ability:GetSpecialValueFor("absorb_amount")
self.ability.bonus_attack = self.ability:GetSpecialValueFor("bonus_attack")
self.ability.bonus_move = self.ability:GetSpecialValueFor("bonus_move")
self.ability.damage_block = self.ability:GetSpecialValueFor("damage_block")/100
end

function modifier_item_solar_crest_custom:GetModifierPhysicalArmorBonus()
return self.ability.bonus_armor
end

function modifier_item_solar_crest_custom:GetModifierManaBonus()
return self.ability.bonus_mana
end

function modifier_item_solar_crest_custom:GetModifierHealthBonus()
return self.ability.bonus_health
end

function modifier_item_solar_crest_custom:GetModifierMoveSpeedBonus_Constant()
return self.ability.self_movement_speed
end


modifier_item_solar_crest_custom_speed = class({})
function modifier_item_solar_crest_custom_speed:IsHidden() return false end
function modifier_item_solar_crest_custom_speed:IsPurgable() return false end
function modifier_item_solar_crest_custom_speed:OnCreated( params )
self.parent = self:GetParent()
self.caster = self:GetCaster()
self.ability = self:GetAbility()

self.max_shield = self.ability.absorb_amount
self.shield = self.max_shield

self.movement_speed = self.ability.target_movement_speed
self.attack_speed = self.ability.target_attack_speed
self.bonus_attack = self.ability.bonus_attack
self.bonus_move = self.ability.bonus_move

if not IsServer() then return end
self.RemoveForDuel = true

self.nFXIndex = self.parent:GenericParticle("particles/general/generic_shield.vpcf", self, true)

self.particle = ParticleManager:CreateParticle("particles/items/pavise_shield.vpcf", PATTACH_ABSORIGIN_FOLLOW, self.parent)
ParticleManager:SetParticleControl(self.particle, 0, self.parent:GetAbsOrigin())
ParticleManager:SetParticleControl(self.particle, 3, Vector(115, 115, 115))
self:AddParticle(self.particle, false, false, -1, false, false)

self:SetHasCustomTransmitterData(true)
self:SendBuffRefreshToClients()
end

function modifier_item_solar_crest_custom_speed:OnRefresh()
if not IsServer() then return end
self.shield = self.max_shield
self:SendBuffRefreshToClients()
end

function modifier_item_solar_crest_custom_speed:AddCustomTransmitterData() 
return 
{ 
  shield = self.shield,
}
end

function modifier_item_solar_crest_custom_speed:HandleCustomTransmitterData(data)
self.shield = data.shield
end

function modifier_item_solar_crest_custom_speed:DeclareFunctions()
return 
{
    MODIFIER_PROPERTY_INCOMING_DAMAGE_CONSTANT,
    MODIFIER_PROPERTY_ATTACKSPEED_BONUS_CONSTANT,
    MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE
}
end

function modifier_item_solar_crest_custom_speed:GetModifierAttackSpeedBonus_Constant()
return self.attack_speed + (self.shield <= 0 and self.bonus_attack or 0)
end 

function modifier_item_solar_crest_custom_speed:GetModifierMoveSpeedBonus_Percentage()
return self.movement_speed + (self.shield <= 0 and self.bonus_move or 0)
end 

function modifier_item_solar_crest_custom_speed:GetModifierIncomingDamageConstant(params)

if IsClient() then 
  if params.report_max then 
    return self.max_shield 
  else 
    return self.shield
  end 
end

if not IsServer() then return end
if self.shield <= 0 then return end

local damage = math.min(params.damage*self.ability.damage_block, self.shield)

self.parent:AddShieldInfo({shield_mod = self, healing = damage, healing_type = "shield"})

self.shield = math.max(0, self.shield - damage)
self:SendBuffRefreshToClients()

if self.shield <= 0 and self.nFXIndex then
    ParticleManager:DestroyParticle(self.nFXIndex, true)
    ParticleManager:ReleaseParticleIndex(self.nFXIndex)

    ParticleManager:DestroyParticle(self.particle, false)
    ParticleManager:ReleaseParticleIndex(self.particle)

    self.parent:GenericParticle("particles/general/generic_armor_reduction.vpcf", self, true)
    self.parent:EmitSound("Item.Star_emblem_break")
    self.nFXIndex = nil
end
return -damage
end