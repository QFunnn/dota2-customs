--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier( "modifier_ogre_armor_active_armor", "abilities/neutral_creeps_active/neutral_ogre_armor_active", LUA_MODIFIER_MOTION_NONE )

neutral_ogre_armor_active = class({})



function neutral_ogre_armor_active:OnSpellStart()
local caster = self:GetCaster()
local target = self:GetCursorTarget()

local duration = self:GetSpecialValueFor("duration")
target:EmitSound("n_creep_OgreMagi.FrostArmor")
target:AddNewModifier(caster, self, "modifier_ogre_armor_active_armor", {duration = duration}) 
end




modifier_ogre_armor_active_armor = class({})
function modifier_ogre_armor_active_armor:IsPurgable() return true end
function modifier_ogre_armor_active_armor:IsHidden() return false end
function modifier_ogre_armor_active_armor:OnCreated(table)
self.ability = self:GetAbility()
self.armor = self.ability:GetSpecialValueFor("armor")
self.magic = self.ability:GetSpecialValueFor("magic")
end

function modifier_ogre_armor_active_armor:DeclareFunctions()
return 
{
  MODIFIER_PROPERTY_PHYSICAL_ARMOR_BONUS,
  MODIFIER_PROPERTY_MAGICAL_RESISTANCE_BONUS,
}
end

function modifier_ogre_armor_active_armor:GetEffectName() return "particles/neutral_fx/ogre_magi_frost_armor.vpcf" end
function modifier_ogre_armor_active_armor:GetEffectAttachType() return PATTACH_OVERHEAD_FOLLOW end

function modifier_ogre_armor_active_armor:GetModifierMagicalResistanceBonus() return self.magic end
function modifier_ogre_armor_active_armor:GetModifierPhysicalArmorBonus() return self.armor end


function modifier_ogre_armor_active_armor:GetStatusEffectName()
return "particles/status_fx/status_effect_frost_lich.vpcf"
end

function modifier_ogre_armor_active_armor:StatusEffectPriority()
return MODIFIER_PRIORITY_NORMAL
end