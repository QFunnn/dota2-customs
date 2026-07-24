--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier( "modifier_antimage_mana_void_custom_legendary", "abilities/antimage/antimage_mana_overload_custom", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_antimage_mana_void_custom_anim", "abilities/antimage/antimage_mana_overload_custom", LUA_MODIFIER_MOTION_NONE )

antimage_spell_seal_custom = class({})

function antimage_spell_seal_custom:Init()
self.caster = self:GetCaster()
if IsServer() then 
	self:SetLevel(1)
end
self.duration = self:GetSpecialValueFor("duration")
self.damage = self:GetSpecialValueFor("damage")/100
self.mana_loss = self:GetSpecialValueFor("mana_loss")
end

function antimage_spell_seal_custom:OnAbilityPhaseStart()
if not IsServer() then return end
self:GetCaster():AddNewModifier(self.caster, self, "modifier_antimage_mana_void_custom_anim", {})
return true
end

function antimage_spell_seal_custom:OnAbilityPhaseInterrupted()
if not IsServer() then return end
self.caster:RemoveModifierByName("modifier_antimage_mana_void_custom_anim")
end

function antimage_spell_seal_custom:OnSpellStart()
local target = self:GetCursorTarget()
self.caster:RemoveModifierByName("modifier_antimage_mana_void_custom_anim")

if target:TriggerSpellAbsorb(self) then return end

local leakCast = ParticleManager:CreateParticle("particles/am_cast.vpcf", PATTACH_POINT_FOLLOW, target)
ParticleManager:SetParticleControlEnt(leakCast, 0, self.caster, PATTACH_POINT_FOLLOW, "attach_attack1", self.caster:GetAbsOrigin(), true) 
ParticleManager:SetParticleControlEnt(leakCast, 1, target, PATTACH_POINT_FOLLOW, "attach_hitloc", target:GetAbsOrigin(), true)
ParticleManager:ReleaseParticleIndex(leakCast)

target:AddNewModifier(self.caster, self, "modifier_antimage_mana_void_custom_legendary", {duration = self.duration})
end

modifier_antimage_mana_void_custom_legendary = class(mod_hidden)
function modifier_antimage_mana_void_custom_legendary:GetEffectName() return "particles/am_mana_mark.vpcf" end
function modifier_antimage_mana_void_custom_legendary:GetEffectAttachType() return PATTACH_OVERHEAD_FOLLOW end
function modifier_antimage_mana_void_custom_legendary:OnCreated(table)
self.ability = self:GetAbility()
self.parent = self:GetParent()
self.caster = self:GetCaster()

self.parent:AddSpellEvent(self, true)
self.damage = self.ability.damage
self.mana_loss = self.ability:GetSpecialValueFor("mana_loss")

if not IsServer() then return end
self.RemoveForDuel = true
self.ability:EndCd()
self.parent:AddNewModifier(self.parent, self.ability, "modifier_antimage_empowered_mana_break_debuff", {duration = self:GetRemainingTime()})

self.damageTable = {victim = self.parent, ability = self.ability, attacker = self.caster, damage_type = DAMAGE_TYPE_MAGICAL}

self.particle = ParticleManager:CreateParticle("particles/units/heroes/hero_silencer/silencer_last_word_status.vpcf", PATTACH_ABSORIGIN_FOLLOW, self:GetParent())
ParticleManager:SetParticleControl(self.particle, 1, self:GetParent():GetAbsOrigin())
self:AddParticle(self.particle, false, false, -1, false, false)
end

function modifier_antimage_mana_void_custom_legendary:OnDestroy()
if not IsServer() then return end
self.ability:StartCd()
end

function modifier_antimage_mana_void_custom_legendary:SpellEvent( params )
if not IsServer() then return end
if params.unit~=self.parent then return end
if params.ability:IsItem() then return end
if not params.ability:ProcsMagicStick() then return end

self.parent:EmitSound("Hero_Antimage.ManaVoid")

local particle = ParticleManager:CreateParticle( "particles/econ/items/antimage/antimage_weapon_basher_ti5/antimage_manavoid_ti_5.vpcf", PATTACH_POINT_FOLLOW, self.parent)
ParticleManager:SetParticleControlEnt( particle, 0, self.parent, PATTACH_POINT_FOLLOW, "attach_hitloc", self.parent:GetAbsOrigin(), true )
ParticleManager:SetParticleControl( particle, 1, Vector( 250, 0, 0 ) )
ParticleManager:ReleaseParticleIndex( particle )

local damage = self.parent:GetMaxHealth()*self.damage
self.damageTable.damage = damage
SendOverheadEventMessage(self.parent, 4, self.parent, damage, nil)
DoDamage(self.damageTable)
end

function modifier_antimage_mana_void_custom_legendary:DeclareFunctions()
return
{
	MODIFIER_PROPERTY_MANACOST_PERCENTAGE_STACKING,
}
end

function modifier_antimage_mana_void_custom_legendary:GetModifierPercentageManacostStacking(params)
return self.mana_loss
end

function modifier_antimage_mana_void_custom_legendary:GetStatusEffectName()
return "particles/units/heroes/hero_kez/status_effect_kez_afterimage_buff.vpcf"
end
 
function modifier_antimage_mana_void_custom_legendary:StatusEffectPriority()
return MODIFIER_PRIORITY_ULTRA
end
 


modifier_antimage_mana_void_custom_anim = class(mod_hidden)
function modifier_antimage_mana_void_custom_anim:DeclareFunctions()
return
{
	MODIFIER_PROPERTY_TRANSLATE_ACTIVITY_MODIFIERS
}
end

function modifier_antimage_mana_void_custom_anim:GetActivityTranslationModifiers()
return "basher"
end