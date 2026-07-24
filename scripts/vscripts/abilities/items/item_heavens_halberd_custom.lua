--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_item_heavens_halberd_custom", "abilities/items/item_heavens_halberd_custom", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_item_heavens_halberd_custom_disarm", "abilities/items/item_heavens_halberd_custom", LUA_MODIFIER_MOTION_HORIZONTAL)
LinkLuaModifier("modifier_item_heavens_halberd_custom_speed", "abilities/items/item_heavens_halberd_custom", LUA_MODIFIER_MOTION_HORIZONTAL)

item_heavens_halberd_custom = class({})

function item_heavens_halberd_custom:Precache(context)
if self:GetCaster() and self:GetCaster():IsIllusion() then return end
PrecacheResource( "particle","particles/items2_fx/heavens_halberd.vpcf", context )
PrecacheResource( "particle","particles/items_fx/harpoon_pull.vpcf", context )
end

function item_heavens_halberd_custom:GetIntrinsicModifierName()
return "modifier_item_heavens_halberd_custom"
end

function item_heavens_halberd_custom:OnSpellStart()
local caster = self:GetCaster()
local target = self:GetCursorTarget()

caster:EmitSound("Item.heavens_halberd.Cast")

if target:TriggerSpellAbsorb(self) then
    return nil
end

local duration = self.disarm_duration

local dir = (caster:GetAbsOrigin() - target:GetAbsOrigin()):Normalized()
local point = caster:GetAbsOrigin() - dir*100
local distance = (point - target:GetAbsOrigin()):Length2D()
local max_dist = self.pull_distance
local pull_duration = self.pull_duration

distance = math.min(max_dist, math.max(40, distance))
point = target:GetAbsOrigin() + dir*distance

local mod = target:AddNewModifier( caster, self,  "modifier_generic_arc",  
{
    target_x = point.x,
    target_y = point.y,
    distance = distance,
    duration = pull_duration,
    height = 0,
    fix_end = false,
    isStun = false,
    activity = ACT_DOTA_FLAIL,
})

if mod then 
    target:GenericParticle("particles/items_fx/harpoon_pull.vpcf", mod)
end 

target:EmitSound("DOTA_Item.HeavensHalberd.Activate")
target:AddNewModifier(caster, self, "modifier_item_heavens_halberd_custom_disarm", {duration = (1 - target:GetStatusResistance())*duration})
caster:AddNewModifier(caster, self, "modifier_item_heavens_halberd_custom_speed", {duration = self.speed_duration})
end


modifier_item_heavens_halberd_custom = class(mod_hidden)
function modifier_item_heavens_halberd_custom:RemoveOnDeath() return false end
function modifier_item_heavens_halberd_custom:DeclareFunctions()
return
{
    MODIFIER_PROPERTY_STATS_STRENGTH_BONUS,
    MODIFIER_PROPERTY_EVASION_CONSTANT,
    MODIFIER_PROPERTY_PHYSICAL_ARMOR_BONUS,
    MODIFIER_PROPERTY_HEALTH_BONUS,
}
end

function modifier_item_heavens_halberd_custom:GetModifierBonusStats_Strength() 
return self.ability.bonus_str
end

function modifier_item_heavens_halberd_custom:GetModifierPhysicalArmorBonus()
return self.ability.bonus_armor
end

function modifier_item_heavens_halberd_custom:GetModifierHealthBonus()
return self.ability.bonus_health
end

function modifier_item_heavens_halberd_custom:GetModifierEvasion_Constant()
return self.ability.bonus_evasion
end

function modifier_item_heavens_halberd_custom:OnCreated(table)
self.parent = self:GetParent()
self.ability = self:GetAbility()

self.ability.bonus_str = self.ability:GetSpecialValueFor("bonus_str")
self.ability.bonus_armor = self.ability:GetSpecialValueFor("bonus_armor")
self.ability.bonus_health = self.ability:GetSpecialValueFor("bonus_health")
self.ability.bonus_evasion = self.ability:GetSpecialValueFor("bonus_evasion")
self.ability.pull_distance = self.ability:GetSpecialValueFor("pull_distance")
self.ability.attack_range = self.ability:GetSpecialValueFor("attack_range")
self.ability.pull_duration = self.ability:GetSpecialValueFor("pull_duration")
self.ability.speed_duration = self.ability:GetSpecialValueFor("speed_duration")
self.ability.attack_speed = self.ability:GetSpecialValueFor("attack_speed")
self.ability.disarm_duration = self.ability:GetSpecialValueFor("disarm_duration")
end

modifier_item_heavens_halberd_custom_disarm = class({})
function modifier_item_heavens_halberd_custom_disarm:IsHidden() return true end
function modifier_item_heavens_halberd_custom_disarm:IsPurgable() return false end
function modifier_item_heavens_halberd_custom_disarm:IsPurgeException() return true end
function modifier_item_heavens_halberd_custom_disarm:CheckState()
return
{
    [MODIFIER_STATE_DISARMED] = true
}
end

function modifier_item_heavens_halberd_custom_disarm:OnCreated()
if not IsServer() then return end
self:GetParent():GenericParticle("particles/items2_fx/heavens_halberd.vpcf", self, true)
end


modifier_item_heavens_halberd_custom_speed = class({})
function modifier_item_heavens_halberd_custom_speed:IsHidden() return false end
function modifier_item_heavens_halberd_custom_speed:IsPurgable() return true end
function modifier_item_heavens_halberd_custom_speed:OnCreated()
self.speed = self:GetAbility().attack_speed
end

function modifier_item_heavens_halberd_custom_speed:DeclareFunctions()
return
{
    MODIFIER_PROPERTY_ATTACKSPEED_BONUS_CONSTANT
}
end

function modifier_item_heavens_halberd_custom_speed:GetModifierAttackSpeedBonus_Constant()
return self.speed
end