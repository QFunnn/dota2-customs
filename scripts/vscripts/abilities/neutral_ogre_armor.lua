--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_ogre_armor", "abilities/neutral_ogre_armor", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_ogre_armor_buff", "abilities/neutral_ogre_armor", LUA_MODIFIER_MOTION_NONE)



neutral_ogre_armor = class({})

function neutral_ogre_armor:GetIntrinsicModifierName()
if not self:GetCaster():IsCreep() then return end  
return "modifier_ogre_armor" 
end 


modifier_ogre_armor = class({})

function modifier_ogre_armor:IsPurgable() return false end
function modifier_ogre_armor:IsHidden() return true end

function modifier_ogre_armor:OnCreated(table)
if not IsServer() then return end
self.duration = self:GetAbility():GetSpecialValueFor("duration")
end


function modifier_ogre_armor:StartCast(target)
if not IsServer() then return end
local array_target = nil

if target then 
  array_target = target:entindex()
end

self:GetParent():AddNewModifier(self.parent, self:GetAbility(), "modifier_neutral_cast", {target = array_target, duration = 0.3, anim = ACT_DOTA_CAST_ABILITY_1, parent_mod = self:GetName()})
end


function modifier_ogre_armor:EndCast()
if not IsServer() then return end

self:GetParent():EmitSound("n_creep_OgreMagi.FrostArmor")

local targets = FindUnitsInRadius(self:GetParent():GetTeamNumber(), self:GetParent():GetAbsOrigin(), nil, 400, DOTA_UNIT_TARGET_TEAM_FRIENDLY, DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC, DOTA_UNIT_TARGET_FLAG_MAGIC_IMMUNE_ENEMIES + DOTA_UNIT_TARGET_FLAG_FOW_VISIBLE + DOTA_UNIT_TARGET_FLAG_INVULNERABLE, FIND_CLOSEST, false)

for _,target in pairs(targets) do
  if not target:HasModifier("modifier_ogre_armor_buff") then 
    target:AddNewModifier(self:GetParent(), self:GetAbility(), "modifier_ogre_armor_buff", {duration = self.duration})
    break
  end
end

end




modifier_ogre_armor_buff = class({})

function modifier_ogre_armor_buff:IsPurgable() return true end
function modifier_ogre_armor_buff:IsHidden() return false end
function modifier_ogre_armor_buff:OnCreated(table)

self.armor =  self:GetAbility():GetSpecialValueFor("armor")
self.magic = self:GetAbility():GetSpecialValueFor("magic")
end

function modifier_ogre_armor_buff:DeclareFunctions()
return 
{
  MODIFIER_PROPERTY_PHYSICAL_ARMOR_BONUS,
  MODIFIER_PROPERTY_MAGICAL_RESISTANCE_BONUS,
}
end

function modifier_ogre_armor_buff:GetEffectName() return "particles/neutral_fx/ogre_magi_frost_armor.vpcf" end
function modifier_ogre_armor_buff:GetEffectAttachType() return PATTACH_OVERHEAD_FOLLOW end

function modifier_ogre_armor_buff:GetModifierMagicalResistanceBonus() return self.magic end
function modifier_ogre_armor_buff:GetModifierPhysicalArmorBonus() return self.armor end


function modifier_ogre_armor_buff:GetStatusEffectName()
return "particles/status_fx/status_effect_frost_lich.vpcf"
end


function modifier_ogre_armor_buff:StatusEffectPriority()
  return MODIFIER_PRIORITY_HIGH 
end