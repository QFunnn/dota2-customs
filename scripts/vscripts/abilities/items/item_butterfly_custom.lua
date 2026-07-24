--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_item_butterfly_custom", "abilities/items/item_butterfly_custom", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_item_butterfly_custom_move", "abilities/items/item_butterfly_custom", LUA_MODIFIER_MOTION_NONE)

item_butterfly_custom = class({})

function item_butterfly_custom:Precache(context)
if self:GetCaster() and self:GetCaster():IsIllusion() then return end
PrecacheResource( "particle","particles/items2_fx/butterfly_active.vpcf", context )
PrecacheResource( "particle","particles/units/heroes/hero_morphling/morphling_morph_agi.vpcf", context ) 
PrecacheResource( "particle","particles/items3_fx/blink_swift_buff.vpcf", context )
PrecacheResource( "particle","particles/butterfly_status.vpcf", context ) 
PrecacheResource( "particle","particles/butterfly_proc.vpcf", context )
end

function item_butterfly_custom:GetIntrinsicModifierName()
return "modifier_item_butterfly_custom"
end

function item_butterfly_custom:Spawn()
self.bonus_agility = self:GetSpecialValueFor("bonus_agility")
self.bonus_damage = self:GetSpecialValueFor("bonus_damage")
self.bonus_health = self:GetSpecialValueFor("bonus_health")
self.bonus_evasion = self:GetSpecialValueFor("bonus_evasion")
self.bonus_speed = self:GetSpecialValueFor("bonus_speed")/100
self.duration = self:GetSpecialValueFor("duration")
self.shield_base = self:GetSpecialValueFor("shield_base")
self.shield_agi = self:GetSpecialValueFor("shield_agi")/100
self.movespeed = self:GetSpecialValueFor("movespeed")
end

function item_butterfly_custom:OnSpellStart()
local caster = self:GetCaster()
self:EmitSound("DOTA_Item.Butterfly")

caster:GenericParticle("particles/butterfly_proc.vpcf")
caster:EmitSound("Butterfly.Attack_absorb")
caster:AddNewModifier(caster, self, "modifier_generic_shield_multiple",
{
    duration = self.duration,
    max_shield = self.shield_base + caster:GetAgility()*self.shield_agi,
    start_full = 1,
})
caster:AddNewModifier(caster, self, "modifier_item_butterfly_custom_move", {duration = self.duration})
end


modifier_item_butterfly_custom = class(mod_hidden)
function modifier_item_butterfly_custom:GetAttributes() return MODIFIER_ATTRIBUTE_MULTIPLE end
function modifier_item_butterfly_custom:DeclareFunctions()
return
{
    MODIFIER_PROPERTY_STATS_AGILITY_BONUS,
    MODIFIER_PROPERTY_PREATTACK_BONUS_DAMAGE,
    MODIFIER_PROPERTY_ATTACKSPEED_BONUS_CONSTANT,
    MODIFIER_PROPERTY_HEALTH_BONUS,
    MODIFIER_PROPERTY_EVASION_CONSTANT
}
end

function modifier_item_butterfly_custom:OnCreated()
self.parent = self:GetParent()
self.ability = self:GetAbility()
end


function modifier_item_butterfly_custom:GetModifierBonusStats_Agility()
if self.parent:HasModifier("modifier_item_butterfly_custom_move") then return end
return self.ability.bonus_agility
end

function modifier_item_butterfly_custom:GetModifierPreAttack_BonusDamage()
if self.parent:HasModifier("modifier_item_butterfly_custom_move") then return end
return self.ability.bonus_damage
end

function modifier_item_butterfly_custom:GetModifierAttackSpeedBonus_Constant()
if self.parent:HasModifier("modifier_item_butterfly_custom_move") then return end
return self.ability.bonus_speed*self.parent:GetAgility()
end

function modifier_item_butterfly_custom:GetModifierEvasion_Constant()
return self.ability.bonus_evasion
end

function modifier_item_butterfly_custom:GetModifierHealthBonus()
return self.ability.bonus_health
end


modifier_item_butterfly_custom_move = class(mod_visible)
function modifier_item_butterfly_custom_move:GetStatusEffectName() return "particles/butterfly_status.vpcf" end
function modifier_item_butterfly_custom_move:StatusEffectPriority() return MODIFIER_PRIORITY_HIGH end
function modifier_item_butterfly_custom_move:OnCreated(table)
self.parent = self:GetParent()
self.ability = self:GetAbility()

self.move = self.ability.movespeed
if not IsServer() then return end
self.parent:GenericParticle("particles/items3_fx/blink_swift_buff.vpcf", self)
self.parent:CalculateStatBonus(true)
end

function modifier_item_butterfly_custom_move:OnDestroy()
if not IsServer() then return end
self.parent:CalculateStatBonus(true)
end

function modifier_item_butterfly_custom_move:DeclareFunctions()
return
{
    MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE
}
end

function modifier_item_butterfly_custom_move:GetModifierMoveSpeedBonus_Percentage()
return self.move
end