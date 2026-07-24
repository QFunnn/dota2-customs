--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_item_ash_legion_shield_custom", "abilities/items/neutral/item_ash_legion_shield_custom", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_item_ash_legion_shield_custom_movespeed", "abilities/items/neutral/item_ash_legion_shield_custom", LUA_MODIFIER_MOTION_NONE)

item_ash_legion_shield_custom = class({})

function item_ash_legion_shield_custom:Precache(context)
if self:GetCaster() and self:GetCaster():IsIllusion() then return end
PrecacheResource( "particle", "particles/items/ash_legion_buckler_custom.vpcf", context )

end

function item_ash_legion_shield_custom:OnSpellStart()
local caster = self:GetCaster()

local radius = self:GetSpecialValueFor("block_radius")
local duration = self:GetSpecialValueFor("duration")
local friends = FindUnitsInRadius(caster:GetTeamNumber(), caster:GetAbsOrigin(), nil, radius, DOTA_UNIT_TARGET_TEAM_FRIENDLY, DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC, DOTA_UNIT_TARGET_FLAG_INVULNERABLE, FIND_CLOSEST, false)
caster:EmitSound("item_ash_legion_shield")

for _,friend in pairs(friends) do
    if friend:IsUnit() then
        friend:RemoveModifierByName("modifier_item_ash_legion_shield_custom")
        friend:AddNewModifier(caster, self, "modifier_item_ash_legion_shield_custom", {duration = duration})
    end
end

end

modifier_item_ash_legion_shield_custom = class(mod_visible)
function modifier_item_ash_legion_shield_custom:OnCreated( params )
self.parent = self:GetParent()
self.caster = self:GetCaster()
self.ability = self:GetAbility()
self.max_shield = self.ability:GetSpecialValueFor("block_amount")
self.slow = self.ability:GetSpecialValueFor("slow")
self.shield = self.max_shield

if not IsServer() then return end
self.parent:EmitSound("item_ash_legion_shield.target")
self.parent:GenericParticle("particles/items/ash_legion_buckler_custom.vpcf", self)
self:SetHasCustomTransmitterData(true)
end

function modifier_item_ash_legion_shield_custom:AddCustomTransmitterData() 
return 
{   
    shield = self.shield,
    max_shield = self.max_shield,
}
end

function modifier_item_ash_legion_shield_custom:HandleCustomTransmitterData(data)
self.shield = data.shield
self.max_shield = data.max_shield
end

function modifier_item_ash_legion_shield_custom:DeclareFunctions()
return 
{
  MODIFIER_PROPERTY_INCOMING_PHYSICAL_DAMAGE_CONSTANT,
  MODIFIER_PROPERTY_MOVESPEED_BONUS_CONSTANT
}
end

function modifier_item_ash_legion_shield_custom:GetModifierMoveSpeedBonus_Constant()
return self.slow
end

function modifier_item_ash_legion_shield_custom:GetModifierIncomingPhysicalDamageConstant(params)

if IsClient() then 
  if params.report_max then 
    return self.max_shield
  else 
      return self.shield
    end 
end

if not IsServer() then return end
if self.shield == 0 then return end

local damage = math.min(params.damage, self.shield)
local shield_damage = damage

self.parent:AddShieldInfo({shield_mod = self, healing = damage, healing_type = "shield"})

self.shield = self.shield - shield_damage
self:SendBuffRefreshToClients()

return -damage
end