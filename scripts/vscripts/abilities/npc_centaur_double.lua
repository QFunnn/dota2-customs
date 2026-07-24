--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_centaur_double_cd", "abilities/npc_centaur_double", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_centaur_double_heal", "abilities/npc_centaur_double", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_centaur_double_slow", "abilities/npc_centaur_double", LUA_MODIFIER_MOTION_NONE)

npc_centaur_double = class({})

function npc_centaur_double:OnAbilityPhaseStart()

self.phase_double_edge_pfx = ParticleManager:CreateParticle("particles/units/heroes/hero_centaur/centaur_double_edge_phase.vpcf", PATTACH_CUSTOMORIGIN, self:GetCaster())
ParticleManager:SetParticleControl(self.phase_double_edge_pfx, 0, self:GetCaster():GetAbsOrigin())
ParticleManager:SetParticleControl(self.phase_double_edge_pfx, 3, self:GetCaster():GetAbsOrigin())
ParticleManager:SetParticleControl(self.phase_double_edge_pfx, 9, self:GetCaster():GetAbsOrigin())

    return true
end 


function npc_centaur_double:OnSpellStart()
if not IsServer() then return end
self:GetCaster():AddNewModifier(self:GetCaster(), self, "modifier_centaur_double_cd", {duration = self:GetCooldownTimeRemaining()})
local caster = self:GetCaster()
local target = self:GetCursorTarget()
if target:TriggerSpellAbsorb(self) then return end


self:GetCaster():EmitSound("Hero_Centaur.DoubleEdge")

local particle_edge_fx = ParticleManager:CreateParticle("particles/units/heroes/hero_centaur/centaur_double_edge.vpcf", PATTACH_ABSORIGIN, caster)
ParticleManager:SetParticleControl(particle_edge_fx, 0, target:GetAbsOrigin())
ParticleManager:SetParticleControl(particle_edge_fx, 1, target:GetAbsOrigin())
ParticleManager:SetParticleControl(particle_edge_fx, 2, target:GetAbsOrigin())
ParticleManager:SetParticleControl(particle_edge_fx, 3, target:GetAbsOrigin())
ParticleManager:SetParticleControl(particle_edge_fx, 4, target:GetAbsOrigin())
ParticleManager:SetParticleControl(particle_edge_fx, 5, target:GetAbsOrigin())
ParticleManager:SetParticleControl(particle_edge_fx, 9, target:GetAbsOrigin())
ParticleManager:ReleaseParticleIndex(particle_edge_fx)

target:AddNewModifier(caster, self, "modifier_centaur_double_slow", {duration = self:GetSpecialValueFor("duration")})
target:AddNewModifier(caster, self, "modifier_centaur_double_heal", {duration = self:GetSpecialValueFor("duration_heal")})

if target:IsIllusion() then 
    DoDamage({victim = target, attacker = self:GetCaster(), damage = self:GetSpecialValueFor("damage"), damage_type = DAMAGE_TYPE_MAGICAL, ability = self})
end

end

function npc_centaur_double:OnAbilityPhaseInterrupted()
    if self.phase_double_edge_pfx then
        ParticleManager:DestroyParticle(self.phase_double_edge_pfx, false)
        ParticleManager:ReleaseParticleIndex(self.phase_double_edge_pfx)
    end
end


modifier_centaur_double_slow = class({})
function modifier_centaur_double_slow:IsHidden() return false end
function modifier_centaur_double_slow:IsPurgable() return true end
function modifier_centaur_double_slow:OnCreated(table)
    self.slow = self:GetAbility():GetSpecialValueFor("slow")
end

function modifier_centaur_double_slow:DeclareFunctions()
return
{
    MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE   
}

end

function modifier_centaur_double_slow:GetModifierMoveSpeedBonus_Percentage() return self.slow end


modifier_centaur_double_heal = class({})
function modifier_centaur_double_heal:IsHidden() return false end
function modifier_centaur_double_heal:IsPurgable() return true end
function modifier_centaur_double_heal:OnCreated(table)
self.heal = self:GetAbility():GetSpecialValueFor("heal")
if not IsServer() then return end
self:SetStackCount(1)
end

function modifier_centaur_double_heal:OnRefresh(table)
if not IsServer() then return end
self:IncrementStackCount()
end


function modifier_centaur_double_heal:DeclareFunctions()
return {
    --MODIFIER_PROPERTY_HEAL_AMPLIFY_PERCENTAGE_TARGET,
    MODIFIER_PROPERTY_HP_REGEN_AMPLIFY_PERCENTAGE,
    --MODIFIER_PROPERTY_LIFESTEAL_AMPLIFY_PERCENTAGE
    }
end

function modifier_centaur_double_heal:GetModifierLifestealRegenAmplify_Percentage() return -(self.heal * self:GetStackCount()) end
function modifier_centaur_double_heal:GetModifierHealChange() return -(self.heal * self:GetStackCount()) end
function modifier_centaur_double_heal:GetModifierHPRegenAmplify_Percentage() return -(self.heal * self:GetStackCount()) end



modifier_centaur_double_cd = class({})
function modifier_centaur_double_cd:IsHidden() return false end
function modifier_centaur_double_cd:IsPurgable() return false end
