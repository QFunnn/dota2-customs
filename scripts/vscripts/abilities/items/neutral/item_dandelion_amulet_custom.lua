--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_item_dandelion_amulet_custom", "abilities/items/neutral/item_dandelion_amulet_custom", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_item_dandelion_amulet_custom_shield", "abilities/items/neutral/item_dandelion_amulet_custom", LUA_MODIFIER_MOTION_NONE)

item_dandelion_amulet_custom = class({})

function item_dandelion_amulet_custom:Precache(context)
if self:GetCaster() and self:GetCaster():IsIllusion() then return end
PrecacheResource( "particle", "particles/items7_fx/medallion_of_valor_friend.vpcf", context )
end

function item_dandelion_amulet_custom:GetIntrinsicModifierName()
if not self:GetCaster():IsRealHero() then return end
return "modifier_item_dandelion_amulet_custom"
end

modifier_item_dandelion_amulet_custom = class(mod_hidden)
function modifier_item_dandelion_amulet_custom:RemoveOnDeath() return false end
function modifier_item_dandelion_amulet_custom:OnCreated(table)
self.parent = self:GetParent()
self.ability = self:GetAbility()

self.ability.shield = self.ability:GetSpecialValueFor("shield")
self.duration = self.ability:GetSpecialValueFor("duration")
self.ability.health = self.ability:GetSpecialValueFor("shield_health")/100
end

function modifier_item_dandelion_amulet_custom:DeclareFunctions()
return
{
    MODIFIER_PROPERTY_ABSORB_SPELL,
}
end

function modifier_item_dandelion_amulet_custom:GetAbsorbSpell(params)
if not IsServer() then return end
if not self.ability:IsFullyCastable() then return end
local attacker = params.ability:GetCaster()

if not attacker then return end
if attacker:GetTeamNumber() == self.parent:GetTeamNumber() then return end

self.parent:AddNewModifier(self.parent, self.ability, "modifier_item_dandelion_amulet_custom_shield", {duration = self.duration})
self.ability:UseResources(false, false, false, true)
end

modifier_item_dandelion_amulet_custom_shield = class({})
function modifier_item_dandelion_amulet_custom_shield:IsHidden() return true end
function modifier_item_dandelion_amulet_custom_shield:IsPurgable() return true end
function modifier_item_dandelion_amulet_custom_shield:OnCreated( params )
self.parent = self:GetParent()
self.caster = self:GetCaster()
self.ability = self:GetAbility()

self.max_shield = self.ability.shield + self.parent:GetMaxHealth()*self.ability.health
self.shield = self.max_shield

if not IsServer() then return end
self.parent:EmitSound("DOTA_Item.InfusedRaindrop")
local hit_effect = ParticleManager:CreateParticle("particles/items7_fx/medallion_of_valor_friend.vpcf", PATTACH_CUSTOMORIGIN_FOLLOW, self.parent)
ParticleManager:SetParticleControlEnt(hit_effect, 0, self.parent, PATTACH_OVERHEAD_FOLLOW, nil, self.parent:GetAbsOrigin(), false) 
ParticleManager:SetParticleControlEnt(hit_effect, 1, self.parent, PATTACH_ABSORIGIN_FOLLOW, nil, self.parent:GetAbsOrigin(), false) 
self:AddParticle( hit_effect, false, false, -1, false, false  )

self:SetHasCustomTransmitterData(true)
self:SendBuffRefreshToClients()
end

function modifier_item_dandelion_amulet_custom_shield:OnRefresh()
if not IsServer() then return end
self.shield = self.max_shield
self:SendBuffRefreshToClients()
end

function modifier_item_dandelion_amulet_custom_shield:AddCustomTransmitterData() 
return 
{ 
  shield = self.shield,
}
end

function modifier_item_dandelion_amulet_custom_shield:HandleCustomTransmitterData(data)
self.shield = data.shield
end

function modifier_item_dandelion_amulet_custom_shield:DeclareFunctions()
return 
{
    MODIFIER_PROPERTY_INCOMING_DAMAGE_CONSTANT,
}
end

function modifier_item_dandelion_amulet_custom_shield:GetModifierIncomingDamageConstant(params)

if IsClient() then 
  if params.report_max then 
    return self.max_shield 
  else 
    return self.shield
  end 
end

if not IsServer() then return end
if self:GetElapsedTime() < 0.1 then return end

local damage = math.min(params.damage, self.shield)

self.parent:GenericHeal(damage, self.ability, true, "particles/generic/lifesteal_blue.vpcf")
self.parent:AddShieldInfo({shield_mod = self, healing = damage, healing_type = "shield"})

self.shield = math.max(0, self.shield - damage)
self:SendBuffRefreshToClients()

if self.shield <= 0 then
  self:Destroy()
end
return -damage
end