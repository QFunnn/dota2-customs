--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_item_crippling_crossbow_custom", "abilities/items/neutral/item_crippling_crossbow_custom", LUA_MODIFIER_MOTION_NONE)

item_crippling_crossbow_custom = class({})

function item_crippling_crossbow_custom:Precache(context)
if self:GetCaster() and self:GetCaster():IsIllusion() then return end
PrecacheResource( "particle", "particles/items4_fx/hefty_crossbow.vpcf", context )
PrecacheResource( "particle", "particles/items4_fx/hefty_crossbow_debuff.vpcf", context )

end


function item_crippling_crossbow_custom:OnSpellStart()
local caster = self:GetCaster()
caster:EmitSound("item_crippling_crossbow.cast")

local info = 
{
   Target = self:GetCursorTarget(),
   Source = caster,
   Ability = self, 
   EffectName = "particles/items4_fx/hefty_crossbow.vpcf",
   iMoveSpeed = self:GetSpecialValueFor("projectile_speed"),
   bReplaceExisting = false,                         
   bProvidesVision = true,                           
   iVisionRadius = 30,        
   iVisionTeamNumber = caster:GetTeamNumber()      
}
ProjectileManager:CreateTrackingProjectile(info)
end

function item_crippling_crossbow_custom:OnProjectileHit(hTarget, vLocation)
if not IsServer() then return end
if hTarget==nil then return end

local caster = self:GetCaster()
DoDamage({victim = hTarget, attacker = caster, ability = self, damage_type = DAMAGE_TYPE_MAGICAL, damage = self:GetSpecialValueFor("damage")})
hTarget:AddNewModifier(caster, self, "modifier_item_crippling_crossbow_custom", {duration = self:GetSpecialValueFor("duration")*(1 - hTarget:GetStatusResistance())})
hTarget:EmitSound("item_crippling_crossbow.target")
end



modifier_item_crippling_crossbow_custom = class(mod_visible)
function modifier_item_crippling_crossbow_custom:IsPurgable() return true end
function modifier_item_crippling_crossbow_custom:GetEffectName() return "particles/items4_fx/hefty_crossbow_debuff.vpcf" end
function modifier_item_crippling_crossbow_custom:OnCreated(table)
self.parent = self:GetParent()
self.ability = self:GetAbility()

self.slow = self.ability:GetSpecialValueFor("slow_pct")
self.damage_reduce = self.ability:GetSpecialValueFor("damage_reduce")
end

function modifier_item_crippling_crossbow_custom:DeclareFunctions()
return
{
   MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE,
   MODIFIER_PROPERTY_SPELL_AMPLIFY_PERCENTAGE,
   MODIFIER_PROPERTY_DAMAGEOUTGOING_PERCENTAGE
}
end

function modifier_item_crippling_crossbow_custom:GetModifierMoveSpeedBonus_Percentage()
return self.slow
end

function modifier_item_crippling_crossbow_custom:GetModifierDamageOutgoing_Percentage()
return self.damage_reduce
end

function modifier_item_crippling_crossbow_custom:GetModifierSpellAmplify_Percentage()
return self.damage_reduce
end