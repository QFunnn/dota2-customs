--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_item_swift_blink_custom", "abilities/items/item_swift_blink_custom", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_item_swift_blink_custom_active", "abilities/items/item_swift_blink_custom", LUA_MODIFIER_MOTION_NONE)

item_swift_blink_custom = class({})

function item_swift_blink_custom:Precache(context)
if self:GetCaster() and self:GetCaster():IsIllusion() then return end
PrecacheResource( "particle","particles/items3_fx/blink_swift_start.vpcf", context )
PrecacheResource( "particle","particles/items3_fx/blink_swift_end.vpcf", context )
end

function item_swift_blink_custom:GetIntrinsicModifierName()
return "modifier_item_swift_blink_custom"
end

function item_swift_blink_custom:GetAbilityTextureName()
if self:GetCaster():HasModifier("modifier_blink_break_custom") then
    return "items/item_swift_blink_break"
end
return "item_swift_blink"
end

function item_swift_blink_custom:Spawn()
self.blink_range = self:GetSpecialValueFor("blink_range")
self.break_range = self:GetSpecialValueFor("break_range")
self.break_duration = self:GetSpecialValueFor("break_duration")
self.bonus_agility = self:GetSpecialValueFor("bonus_agility")
self.bonus_movement = self:GetSpecialValueFor("bonus_movement")
self.bonus_agi_active = self:GetSpecialValueFor("bonus_agi_active")
self.attack_range_melle = self:GetSpecialValueFor("attack_range_melle")
self.attack_range_ranged = self:GetSpecialValueFor("attack_range_ranged")
self.duration = self:GetSpecialValueFor("duration")
end
 
function item_swift_blink_custom:GetCastRange(Vector, hTarget)
if IsServer() then
    return 99999
end
local caster = self:GetCaster()
return self:MaxRange() - (caster:HasModifier("modifier_blink_break_custom") and caster:GetCastRangeBonus() or 0)
end

function item_swift_blink_custom:MaxRange()
local caster = self:GetCaster()
if caster:HasModifier("modifier_blink_break_custom") then
    return (self.break_range and self.break_range or 0)
end
return (self.blink_range and self.blink_range or 0)
end

function item_swift_blink_custom:OnSpellStart()
local caster = self:GetCaster()
local point = caster:CastPosition(self:GetCursorPosition())
local max_range = self:MaxRange() + (not caster:HasModifier("modifier_blink_break_custom") and caster:GetCastRangeBonus() or 0)
local dir = (point - caster:GetAbsOrigin())

if dir:Length2D() > max_range then
    point = caster:GetAbsOrigin() + max_range*dir:Normalized()
end

local player_id = caster:GetPlayerOwnerID()
local custom_effect_data = shop:GetCurrentEffectData(player_id, "effect_blink")
local pfx_name_start = "particles/items3_fx/blink_swift_start.vpcf"
local pfx_name_end = "particles/items3_fx/blink_swift_end.vpcf"
if custom_effect_data then
    pfx_name_start = custom_effect_data[2]
    pfx_name_end = custom_effect_data[1]
end

if not self.multicast_k then
    caster:SetForwardVector(dir:Normalized())
    caster:FaceTowards(point)
    caster:Teleport(point, not caster:HasModifier("modifier_blink_break_custom"), pfx_name_start, pfx_name_end)
end

caster:EmitSound("DOTA_Item.Swift_Blink.Activate")

caster:AddNewModifier(caster, self, "modifier_item_swift_blink_custom_active", {duration = self.duration})
if caster:GetQuest() == "General.Quest_15" then
    caster:AddNewModifier(caster, nil, "modifier_quest_blink", {duration = caster.quest.number})
end

end


modifier_item_swift_blink_custom = class(mod_hidden)
function modifier_item_swift_blink_custom:DeclareFunctions()
return
{
    MODIFIER_PROPERTY_STATS_AGILITY_BONUS
}
end

function modifier_item_swift_blink_custom:GetModifierBonusStats_Agility()
return self.ability.bonus_agility
end

function modifier_item_swift_blink_custom:OnCreated()
self.ability = self:GetAbility()
self.parent = self:GetParent()

self.parent:AddDamageEvent_inc(self)
end

function modifier_item_swift_blink_custom:DamageEvent_inc(params)
if not IsServer() then return end
self.parent:CheckBlink(params, self.ability)
end


modifier_item_swift_blink_custom_active = class(mod_visible)
function modifier_item_swift_blink_custom_active:IsPurgable() return true end
function modifier_item_swift_blink_custom_active:OnCreated()
self.parent = self:GetParent()
self.ability = self:GetAbility()

self.move = self.ability.bonus_movement
self.agility = self.ability.bonus_agi_active

if not IsServer() then return end
self.parent:GenericParticle("particles/items3_fx/blink_swift_buff.vpcf", self)
self.parent:CalculateStatBonus(true)
end

function modifier_item_swift_blink_custom_active:OnDestroy()
if not IsServer() then return end
self.parent:CalculateStatBonus(true)
end

function modifier_item_swift_blink_custom_active:CheckState()
return
{
    [MODIFIER_STATE_NO_UNIT_COLLISION] = true
}
end

function modifier_item_swift_blink_custom_active:DeclareFunctions()
return
{
    MODIFIER_PROPERTY_STATS_AGILITY_BONUS,
    MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE,
    MODIFIER_PROPERTY_ATTACK_RANGE_BONUS,
}
end

function modifier_item_swift_blink_custom_active:GetModifierMoveSpeedBonus_Percentage()
return self.move
end

function modifier_item_swift_blink_custom_active:GetModifierBonusStats_Agility()
return self.agility
end

function modifier_item_swift_blink_custom_active:GetModifierAttackRangeBonus()
return self.parent:IsRangedAttacker() and self.ability.attack_range_ranged or self.ability.attack_range_melle
end