--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_item_psychic_headband_custom_active", "abilities/items/neutral/item_psychic_headband_custom", LUA_MODIFIER_MOTION_HORIZONTAL)

item_psychic_headband_custom = class({})

function item_psychic_headband_custom:Precache(context)
if self:GetCaster() and self:GetCaster():IsIllusion() then return end
PrecacheResource( "particle","particles/items_fx/force_staff.vpcf", context )
PrecacheResource( "particle","particles/items_fx/harpoon_pull.vpcf", context )
end

function item_psychic_headband_custom:OnSpellStart()
local caster = self:GetCaster()
local target = self:GetCursorTarget()
local distance = self:GetSpecialValueFor("push_length")
local knockback_duration = self:GetSpecialValueFor("push_duration")
local vec = target:GetForwardVector()

target:EmitSound("DOTA_Item.ForceStaff.Activate")

if target:GetTeamNumber() ~= caster:GetTeamNumber() then
    vec = target:GetAbsOrigin() - caster:GetAbsOrigin()
    vec.z = 0
    vec = vec:Normalized()
    if target:IsDebuffImmune() then
        return
    end
end

local mod = target:AddNewModifier( caster, self, "modifier_generic_knockback",
{ 
    direction_x = vec.x,
    direction_y = vec.y,
    distance = distance,
    height = 0, 
    duration = knockback_duration,
    IsStun = false,
    IsFlail = true,
    Purgable = 1,
})
if mod then
    target:GenericParticle("particles/items_fx/force_staff.vpcf", mod)
end

end



