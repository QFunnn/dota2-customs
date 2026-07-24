--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_item_pavise_custom", "abilities/items/item_pavise_custom", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_item_pavise_custom_active", "abilities/items/item_pavise_custom", LUA_MODIFIER_MOTION_NONE)

item_pavise_custom = class({})

function item_pavise_custom:Precache(context)
if self:GetCaster() and self:GetCaster():IsIllusion() then return end
PrecacheResource( "particle","particles/items/pavise_shield.vpcf", context )
end

function item_pavise_custom:GetIntrinsicModifierName()
return "modifier_item_pavise_custom"
end


function item_pavise_custom:GetBehavior()
if not IsSoloMode() then 
    return DOTA_ABILITY_BEHAVIOR_UNIT_TARGET + DOTA_ABILITY_BEHAVIOR_IMMEDIATE
end 
return DOTA_ABILITY_BEHAVIOR_NO_TARGET + DOTA_ABILITY_BEHAVIOR_IMMEDIATE
end


function item_pavise_custom:OnSpellStart()
local caster = self:GetCaster()
local target = caster
if self:GetCursorTarget() then
  target = self:GetCursorTarget()
end

target:EmitSound("Item.Pavise.Target")
target:AddNewModifier(caster, self, "modifier_item_pavise_custom_active", {duration = self.duration})
end

modifier_item_pavise_custom = class({})
function modifier_item_pavise_custom:IsHidden() return true end
function modifier_item_pavise_custom:IsPurgable() return false end
function modifier_item_pavise_custom:RemoveOnDeath() return false end
function modifier_item_pavise_custom:GetAttributes() return MODIFIER_ATTRIBUTE_MULTIPLE end

function modifier_item_pavise_custom:DeclareFunctions()
return 
{
	MODIFIER_PROPERTY_MANA_BONUS,
	MODIFIER_PROPERTY_HEALTH_BONUS,
	MODIFIER_PROPERTY_PHYSICAL_ARMOR_BONUS
}
end

function modifier_item_pavise_custom:OnCreated()
self.ability = self:GetAbility()

self.ability.bonus_armor = self.ability:GetSpecialValueFor("bonus_armor") 
self.ability.bonus_mana = self.ability:GetSpecialValueFor("bonus_mana") 
self.ability.bonus_health = self.ability:GetSpecialValueFor("bonus_health") 
self.ability.duration = self.ability:GetSpecialValueFor("duration") 
self.ability.absorb_amount = self.ability:GetSpecialValueFor("absorb_amount") 
self.ability.damage_block = self.ability:GetSpecialValueFor("damage_block")/100
end

function modifier_item_pavise_custom:GetModifierPhysicalArmorBonus()
return self.ability.bonus_armor
end

function modifier_item_pavise_custom:GetModifierManaBonus()
return self.ability.bonus_mana
end

function modifier_item_pavise_custom:GetModifierHealthBonus()
return self.ability.bonus_health
end


modifier_item_pavise_custom_active = class({})
function modifier_item_pavise_custom_active:IsHidden() return false end
function modifier_item_pavise_custom_active:IsPurgable() return false end
function modifier_item_pavise_custom_active:OnCreated( params )
self.parent = self:GetParent()
self.caster = self:GetCaster()
self.ability = self:GetAbility()

self.max_shield = self.ability.absorb_amount
self.shield = self.max_shield

if not IsServer() then return end
self.particle = ParticleManager:CreateParticle("particles/items/pavise_shield.vpcf", PATTACH_ABSORIGIN_FOLLOW, self.parent)
ParticleManager:SetParticleControl(self.particle, 0, self.parent:GetAbsOrigin())
ParticleManager:SetParticleControl(self.particle, 3, Vector(115, 115, 115))
self:AddParticle(self.particle, false, false, -1, false, false)

self:SetHasCustomTransmitterData(true)
self:SendBuffRefreshToClients()
end

function modifier_item_pavise_custom_active:OnRefresh()
if not IsServer() then return end
self.shield = self.max_shield
self:SendBuffRefreshToClients()
end

function modifier_item_pavise_custom_active:AddCustomTransmitterData() 
return 
{ 
  shield = self.shield,
}
end

function modifier_item_pavise_custom_active:HandleCustomTransmitterData(data)
self.shield = data.shield
end

function modifier_item_pavise_custom_active:DeclareFunctions()
return 
{
	MODIFIER_PROPERTY_INCOMING_DAMAGE_CONSTANT,
}
end

function modifier_item_pavise_custom_active:GetModifierIncomingDamageConstant(params)

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

if self.shield <= 0 then
  self:Destroy()
end
return -damage
end