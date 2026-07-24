--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_enigma_boss_malefice_custom_debuff", "abilities/enigma_boss/enigma_boss_malefice_custom.lua", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_enigma_boss_malefice_custom_caster", "abilities/enigma_boss/enigma_boss_malefice_custom.lua", LUA_MODIFIER_MOTION_NONE)


enigma_boss_malefice_custom = class({})


function enigma_boss_malefice_custom:Precache(context)
if self:GetCaster() and self:GetCaster():IsIllusion() then return end
PrecacheResource( "particle", "particles/units/heroes/hero_enigma/enigma_malefice.vpcf", context )
PrecacheResource( "particle", "particles/generic_gameplay/generic_has_quest.vpcf", context )
end

function enigma_boss_malefice_custom:OnSpellStart()
local caster = self:GetCaster()
local target = self:GetCursorTarget()
local duration = self:GetSpecialValueFor("duration")

target:AddNewModifier(caster, self, "modifier_enigma_boss_malefice_custom_debuff", {duration = duration})
caster:AddNewModifier(caster, self, "modifier_enigma_boss_malefice_custom_caster", {duration = duration})
end



modifier_enigma_boss_malefice_custom_caster = class({})
function modifier_enigma_boss_malefice_custom_caster:IsHidden() return true end
function modifier_enigma_boss_malefice_custom_caster:IsPurgable() return false end

function modifier_enigma_boss_malefice_custom_caster:OnCreated(table)
self.parent = self:GetParent()
if not IsServer() then return end
self.parent:GenericParticle("particles/generic_gameplay/generic_has_quest.vpcf", self, true)
end



modifier_enigma_boss_malefice_custom_debuff = class({})
function modifier_enigma_boss_malefice_custom_debuff:IsHidden() return false end
function modifier_enigma_boss_malefice_custom_debuff:IsPurgable() return false end

function modifier_enigma_boss_malefice_custom_debuff:OnCreated(table)
self.ability = self:GetAbility()
self.caster = self:GetCaster()
self.parent = self:GetParent()

self.stun = self.ability:GetSpecialValueFor("stun")
self.damage = self.ability:GetSpecialValueFor("damage")/100
self.heal_reduce = 0

if self.caster:GetUpgradeStack("modifier_waveupgrade_boss") == 2 then
	self.heal_reduce = self.ability:GetSpecialValueFor("heal_reduce")
end

self.damageTable = {victim = self.parent, attacker = self.caster, ability = self.ability, damage_type = DAMAGE_TYPE_PURE}

if not IsServer() then return end

self.parent:AddAttackEvent_out(self)

self.parent:GenericParticle("particles/generic_gameplay/generic_has_quest.vpcf", self, true)
self.parent:GenericParticle("particles/units/heroes/hero_enigma/enigma_malefice.vpcf", self)
self:Proc()
end

function modifier_enigma_boss_malefice_custom_debuff:GetStatusEffectName()
return "particles/status_fx/status_effect_enigma_malefice.vpcf"
end

function modifier_enigma_boss_malefice_custom_debuff:StatusEffectPriority()
return MODIFIER_PRIORITY_ULTRA 
end

function modifier_enigma_boss_malefice_custom_debuff:Proc()
if not IsServer() then return end


local damage = self.parent:GetMaxHealth()*self.damage
self.damageTable.damage = damage
DoDamage(self.damageTable)

self.parent:EmitSound("Enigma_boss.Malefice_proc")
self.parent:AddNewModifier(self.caster, self.ability, "modifier_bashed", {duration = self.stun*(1 - self.parent:GetStatusResistance())})

end


function modifier_enigma_boss_malefice_custom_debuff:AttackEvent_out(params)
if not IsServer() then return end
if self.parent ~= params.attacker then return end
if self.caster ~= params.target then return end

self:Proc()
end


function modifier_enigma_boss_malefice_custom_debuff:DeclareFunctions()
return
{
  --MODIFIER_PROPERTY_HEAL_AMPLIFY_PERCENTAGE_TARGET,
  MODIFIER_PROPERTY_HP_REGEN_AMPLIFY_PERCENTAGE,
  --MODIFIER_PROPERTY_LIFESTEAL_AMPLIFY_PERCENTAGE,
}
end

function modifier_enigma_boss_malefice_custom_debuff:GetModifierLifestealRegenAmplify_Percentage() 
return self.heal_reduce
end

function modifier_enigma_boss_malefice_custom_debuff:GetModifierHealChange() 
return self.heal_reduce
end

function modifier_enigma_boss_malefice_custom_debuff:GetModifierHPRegenAmplify_Percentage()
return self.heal_reduce
end