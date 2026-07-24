--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_item_blink_custom", "abilities/items/item_blink_custom", LUA_MODIFIER_MOTION_NONE)

item_blink_custom = class({})

function item_blink_custom:Precache(context)
if self:GetCaster() and self:GetCaster():IsIllusion() then return end
PrecacheResource( "particle","particles/items_fx/blink_dagger_start.vpcf", context )
PrecacheResource( "particle","particles/items_fx/blink_dagger_end.vpcf", context )
end

function item_blink_custom:GetIntrinsicModifierName()
return "modifier_item_blink_custom"
end

function item_blink_custom:GetAbilityTextureName()
if self:GetCaster():HasModifier("modifier_blink_break_custom") then
    return "items/item_blink_break"
end
return "item_blink"
end

function item_blink_custom:Spawn()
self.blink_range = self:GetSpecialValueFor("blink_range")        
self.break_range = self:GetSpecialValueFor("break_range")
self.break_duration = self:GetSpecialValueFor("break_duration")
end

function item_blink_custom:GetCastRange(Vector, hTarget)
if IsServer() then
    return 99999
end
local caster = self:GetCaster()
return self:MaxRange() - (caster:HasModifier("modifier_blink_break_custom") and caster:GetCastRangeBonus() or 0)
end

function item_blink_custom:MaxRange()
local caster = self:GetCaster()
if caster:HasModifier("modifier_blink_break_custom") then
    return (self.break_range and self.break_range or 0)
end
return (self.blink_range and self.blink_range or 0)
end

function item_blink_custom:OnSpellStart()
local caster = self:GetCaster()
local point = caster:CastPosition(self:GetCursorPosition())
local max_range = self:MaxRange() + (not caster:HasModifier("modifier_blink_break_custom") and caster:GetCastRangeBonus() or 0)
local dir = (point - caster:GetAbsOrigin())

if dir:Length2D() > max_range then
    point = caster:GetAbsOrigin() + max_range*dir:Normalized()
end

local player_id = caster:GetPlayerOwnerID()
local custom_effect_data = shop:GetCurrentEffectData(player_id, "effect_blink")
local pfx_name_start = "particles/items_fx/blink_dagger_start.vpcf"
local pfx_name_end = "particles/items_fx/blink_dagger_end.vpcf"
if custom_effect_data then
    pfx_name_start = custom_effect_data[2]
    pfx_name_end = custom_effect_data[1]
end

if not self.multicast_k then
    caster:SetForwardVector(dir:Normalized())
    caster:FaceTowards(point)
    caster:Teleport(point, not caster:HasModifier("modifier_blink_break_custom"), pfx_name_start, pfx_name_end)
end

caster:EmitSound("DOTA_Item.BlinkDagger.Activate")

if caster:GetQuest() == "General.Quest_15" then
    caster:AddNewModifier(caster, nil, "modifier_quest_blink", {duration = caster.quest.number})
end

end


modifier_item_blink_custom = class(mod_hidden)
function modifier_item_blink_custom:OnCreated()
self.ability = self:GetAbility()
self.parent = self:GetParent()

self.parent:AddDamageEvent_inc(self)
end

function modifier_item_blink_custom:DamageEvent_inc(params)
if not IsServer() then return end
self.parent:CheckBlink(params, self.ability)
end
