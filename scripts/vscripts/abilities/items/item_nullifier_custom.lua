--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_item_nullifier_custom", "abilities/items/item_nullifier_custom", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_item_nullifier_custom_active_slow", "abilities/items/item_nullifier_custom", LUA_MODIFIER_MOTION_NONE)

item_nullifier_custom = class({})

function item_nullifier_custom:Precache(context)
if self:GetCaster() and self:GetCaster():IsIllusion() then return end
PrecacheResource( "particle","particles/items4_fx/nullifier_proj.vpcf", context )
PrecacheResource( "particle","particles/items4_fx/nullifier_mute.vpcf", context )
PrecacheResource( "particle","particles/items4_fx/nullifier_mute_debuff.vpcf", context )
PrecacheResource( "particle","particles/status_fx/status_effect_nullifier.vpcf", context )
PrecacheResource( "particle","particles/generic_gameplay/generic_purge.vpcf", context )
end

function item_nullifier_custom:GetIntrinsicModifierName()
return "modifier_item_nullifier_custom"
end

function item_nullifier_custom:Spawn()
self.bonus_damage = self:GetSpecialValueFor("bonus_damage")    
self.bonus_armor = self:GetSpecialValueFor("bonus_armor")     
self.bonus_regen = self:GetSpecialValueFor("bonus_regen")     
self.mute_duration = self:GetSpecialValueFor("mute_duration")   
self.projectile_speed = self:GetSpecialValueFor("projectile_speed")
self.slow_move = self:GetSpecialValueFor("slow_move")  
end

function item_nullifier_custom:OnSpellStart()
local caster = self:GetCaster()
local target = self:GetCursorTarget()

caster:EmitSound("DOTA_Item.Nullifier.Cast")


for _, mod in pairs(target:FindAllModifiers()) do
    local tables = {}
    mod:CheckStateToTable(tables)
    print(mod:GetName())
    for state_name, mod_table in pairs(tables) do
      print(mod:GetName(), state_name, mod_table)
    end
end

local info = 
{
   Target = target,
   Source = caster,
   Ability = self, 
   EffectName = "particles/items4_fx/nullifier_proj.vpcf",
   iMoveSpeed = self.projectile_speed,
   bReplaceExisting = false,                         
   bProvidesVision = true,                           
   iVisionRadius = 50,        
   iVisionTeamNumber = self:GetCaster():GetTeamNumber()      
}
ProjectileManager:CreateTrackingProjectile(info)
end


function item_nullifier_custom:OnProjectileHit(target, vLocation)
if not IsServer() then return end
if target == nil then return end
if target:TriggerSpellAbsorb(self) then return end
local caster = self:GetCaster()
target:Purge(true, false, false, false, false)
target:AddNewModifier(caster, self, "modifier_item_nullifier_custom_active_slow", {duration = self.mute_duration*(1 - target:GetStatusResistance())})
target:AddNewModifier(caster, self, "modifier_item_nullifier_mute", {duration = self.mute_duration*(1 - target:GetStatusResistance())})
target:EmitSound("DOTA_Item.Nullifier.Target")
target:EmitSound("DOTA_Item.Nullifier.Slow")
end



modifier_item_nullifier_custom_active_slow = class(mod_hidden)
function modifier_item_nullifier_custom_active_slow:GetStatusEffectName()
return "particles/status_fx/status_effect_nullifier.vpcf"
end 

function modifier_item_nullifier_custom_active_slow:StatusEffectPriority()
return MODIFIER_PRIORITY_NORMAL 
end

function modifier_item_nullifier_custom_active_slow:OnCreated(table)
self.parent = self:GetParent()
self.caster = self:GetCaster()
self.ability = self:GetAbility()
end

function modifier_item_nullifier_custom_active_slow:DeclareFunctions()
return
{
  MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE,
}
end

function modifier_item_nullifier_custom_active_slow:GetModifierMoveSpeedBonus_Percentage()
return self.ability.slow_move
end



modifier_item_nullifier_custom = class(mod_hidden)
function modifier_item_nullifier_custom:DeclareFunctions()
return
{
  MODIFIER_PROPERTY_PREATTACK_BONUS_DAMAGE,
  MODIFIER_PROPERTY_PHYSICAL_ARMOR_BONUS,
}
end

function modifier_item_nullifier_custom:OnCreated()
self.parent = self:GetParent()
self.ability = self:GetAbility()       

if not self.parent.cdr_items then
  self.parent.cdr_items = {}
end
self.parent.cdr_items[self] = self.ability:GetSpecialValueFor("cdr_bonus")
end

function modifier_item_nullifier_custom:GetModifierPhysicalArmorBonus()
return self.ability.bonus_armor
end

function modifier_item_nullifier_custom:GetModifierPreAttack_BonusDamage()
return self.ability.bonus_damage
end
