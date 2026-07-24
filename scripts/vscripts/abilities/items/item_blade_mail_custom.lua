--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_item_blade_mail_custom", "abilities/items/item_blade_mail_custom", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_item_blade_mail_custom_reflect", "abilities/items/item_blade_mail_custom", LUA_MODIFIER_MOTION_NONE)

item_blade_mail_custom = class({})

function item_blade_mail_custom:Precache(context)
if self:GetCaster() and self:GetCaster():IsIllusion() then return end
PrecacheResource( "particle","particles/items_fx/blademail.vpcf", context )
end

function item_blade_mail_custom:GetIntrinsicModifierName()
return "modifier_item_blade_mail_custom"
end

function item_blade_mail_custom:GetAbilityTextureName()
return wearables_system:GetAbilityIconReplacement(self.caster, "item_blade_mail", self)
end

function item_blade_mail_custom:OnSpellStart()
local caster = self:GetCaster()
caster:EmitSound("DOTA_Item.BladeMail.Activate")
caster:AddNewModifier(caster, self, "modifier_item_blade_mail_custom_reflect", {duration = self:GetSpecialValueFor("duration")})
end


modifier_item_blade_mail_custom = class(mod_hidden)
function modifier_item_blade_mail_custom:IsHidden() return true end
function modifier_item_blade_mail_custom:IsPurgable() return false end
function modifier_item_blade_mail_custom:DeclareFunctions()
return 
{
    MODIFIER_PROPERTY_PREATTACK_BONUS_DAMAGE,
    MODIFIER_PROPERTY_PHYSICAL_ARMOR_BONUS,
}
end

function modifier_item_blade_mail_custom:GetModifierPreAttack_BonusDamage()
return self.bonus_damage
end

function modifier_item_blade_mail_custom:GetModifierPhysicalArmorBonus()
return self.bonus_armor
end

function modifier_item_blade_mail_custom:OnCreated(table)
self.ability = self:GetAbility()
self.parent = self:GetParent()

self.bonus_armor = self.ability:GetSpecialValueFor("bonus_armor")
self.bonus_damage = self.ability:GetSpecialValueFor("bonus_damage")
 
self.active_reflect = self.ability:GetSpecialValueFor("active_reflection")/100
self.const_reflect = self.ability:GetSpecialValueFor("passive_reflection_constant")

if self.parent:IsRealHero() then 
    self.parent:AddDamageEvent_inc(self, true)
end 

end

function modifier_item_blade_mail_custom:DamageEvent_inc(params)
if not IsServer() then return end
if not IsValid(self.ability) then return end
if params.unit ~= self.parent then return end
if not params.attacker:IsUnit() then return end
if not self.parent:IsRealHero() then return end
if params.attacker == self.parent then return end
if bit.band(params.damage_flags, DOTA_DAMAGE_FLAG_REFLECTION) == DOTA_DAMAGE_FLAG_REFLECTION then return end
local mod = self.parent:FindModifierByName("modifier_item_blade_mail_custom_reflect")

if not mod and params.inflictor then return end

local target = params.attacker
local original_damage = params.original_damage

local damage = 0
if not params.inflictor then
    damage = self.const_reflect
end

if mod then
    damage = damage + original_damage*self.active_reflect
    if target:IsRealHero() then 
        CustomGameEventManager:Send_ServerToPlayer(PlayerResource:GetPlayer(target:GetPlayerOwnerID()), "generic_sound",  {sound = "DOTA_Item.BladeMail.Damage"})
    end
end

DoDamage({victim = target, attacker = self.parent, damage = damage, damage_type = params.damage_type, damage_flags = DOTA_DAMAGE_FLAG_BYPASSES_PHYSICAL_BLOCK + DOTA_DAMAGE_FLAG_NO_SPELL_AMPLIFICATION + DOTA_DAMAGE_FLAG_REFLECTION, ability = self.ability})
end




modifier_item_blade_mail_custom_reflect = class(mod_visible)
function modifier_item_blade_mail_custom_reflect:GetEffectName() return "particles/items_fx/blademail.vpcf" end