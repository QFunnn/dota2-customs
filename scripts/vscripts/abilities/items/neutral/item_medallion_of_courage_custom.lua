--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_item_medallion_of_courage_custom", "abilities/items/neutral/item_medallion_of_courage_custom", LUA_MODIFIER_MOTION_NONE)

item_medallion_of_courage_custom = class({})

function item_medallion_of_courage_custom:Precache(context)
if self:GetCaster() and self:GetCaster():IsIllusion() then return end
PrecacheResource( "particle", "particles/items7_fx/medallion_of_valor_enemy.vpcf", context )
PrecacheResource( "particle", "particles/items7_fx/medallion_of_valor_friend.vpcf", context )

end

function item_medallion_of_courage_custom:Spawn()
self.ally_armor = self:GetSpecialValueFor("ally_armor")
self.enemy_armor = self:GetSpecialValueFor("enemy_armor")
self.duration = self:GetSpecialValueFor("duration")
end

function item_medallion_of_courage_custom:OnSpellStart()
local caster = self:GetCaster()
local target = self:GetCursorTarget()

target:AddNewModifier(caster, self, "modifier_item_medallion_of_courage_custom", {duration = self.duration})
end


modifier_item_medallion_of_courage_custom = class(mod_visible)
function modifier_item_medallion_of_courage_custom:IsPurgable() return true end
function modifier_item_medallion_of_courage_custom:OnCreated(table)
self.parent = self:GetParent()
self.caster = self:GetCaster()
self.ability = self:GetAbility()

self.armor = self.ability.ally_armor
local effect = "particles/items7_fx/medallion_of_valor_friend.vpcf"
local sound = "DOTA_Item.MedallionOfCourage.Ally"
if self.parent:GetTeamNumber() ~= self.caster:GetTeamNumber() then
   self.armor = self.ability.enemy_armor
   effect = "particles/items7_fx/medallion_of_valor_enemy.vpcf"
   sound = "DOTA_Item.MedallionOfCourage.Enemy"
end

if not IsServer() then return end
self.parent:EmitSound(sound)
local hit_effect = ParticleManager:CreateParticle(effect, PATTACH_CUSTOMORIGIN_FOLLOW, self.parent)
ParticleManager:SetParticleControlEnt(hit_effect, 0, self.parent, PATTACH_OVERHEAD_FOLLOW, nil, self.parent:GetAbsOrigin(), false) 
ParticleManager:SetParticleControlEnt(hit_effect, 1, self.parent, PATTACH_ABSORIGIN_FOLLOW, nil, self.parent:GetAbsOrigin(), false) 
self:AddParticle( hit_effect, false, false, -1, false, false  )
end

function modifier_item_medallion_of_courage_custom:DeclareFunctions()
return
{
   MODIFIER_PROPERTY_PHYSICAL_ARMOR_BONUS
}
end

function modifier_item_medallion_of_courage_custom:GetModifierPhysicalArmorBonus()
return self.armor
end