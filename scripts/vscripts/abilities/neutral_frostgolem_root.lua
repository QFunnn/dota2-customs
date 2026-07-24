--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_frostgolem_root_ability", "abilities/neutral_frostgolem_root.lua", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_frostbitten_thinker", "abilities/neutral_frostgolem_root.lua", LUA_MODIFIER_MOTION_NONE)


neutral_frostgolem_root = class({})

function neutral_frostgolem_root:GetIntrinsicModifierName()
if not self:GetCaster():IsCreep() then return end  
return "modifier_frostgolem_root_ability"
end 


modifier_frostgolem_root_ability = class({})

function modifier_frostgolem_root_ability:IsPurgable() return false end

function modifier_frostgolem_root_ability:IsHidden() return true end

function modifier_frostgolem_root_ability:OnCreated(table)
if not IsServer() then return end

self.delay = self:GetAbility():GetSpecialValueFor("delay")
self.target = nil
end



function modifier_frostgolem_root_ability:StartCast(target)
if not IsServer() then return end
local array_target = nil

if target then 
  array_target = target:entindex()
  self.target = target

end

self:GetParent():AddNewModifier(self.parent, self:GetAbility(), "modifier_neutral_cast", {target = array_target, duration = 0.7, effect = 1, anim = ACT_DOTA_CAST_ABILITY_3, parent_mod = self:GetName()})
end


function modifier_frostgolem_root_ability:EndCast()
if not IsServer() then return end
if not self.target or self.target:IsNull() or not self.target:IsAlive() then return end

CreateModifierThinker(self:GetParent(), self:GetAbility(), "modifier_frostbitten_thinker", {duration = self.delay}, self.target:GetAbsOrigin(), self:GetCaster():GetTeamNumber(), false)
end 




modifier_frostbitten_thinker = class({})

function modifier_frostbitten_thinker:IsHidden() return true end

function modifier_frostbitten_thinker:IsPurgable() return false end

function modifier_frostbitten_thinker:OnCreated(table)
if not IsServer() then return end

self.caster = self:GetCaster()
self.damage = self:GetAbility():GetSpecialValueFor("damage")
self.radius = self:GetAbility():GetSpecialValueFor("radius")

local particle_cast = "particles/units/heroes/hero_snapfire/hero_snapfire_ultimate_calldown.vpcf"
self.effect_cast = ParticleManager:CreateParticle(particle_cast, PATTACH_CUSTOMORIGIN, self:GetParent())
ParticleManager:SetParticleControl( self.effect_cast, 0, self:GetParent():GetOrigin() )
ParticleManager:SetParticleControl( self.effect_cast, 1, Vector( self.radius, 0, -self.radius) )
ParticleManager:SetParticleControl( self.effect_cast, 2, Vector( self:GetRemainingTime(), 0, 0 ) )
self:AddParticle(self.effect_cast, false, false, -1, false, false)
end



function modifier_frostbitten_thinker:OnDestroy(table)
if not IsServer() then return end
if not self.caster then return end
if self.caster:IsNull() then return end

local zap_pfx = ParticleManager:CreateParticle("particles/frostbitten_strike.vpcf", PATTACH_ABSORIGIN_FOLLOW, self.caster)
ParticleManager:SetParticleControlEnt(zap_pfx, 0, self.caster, PATTACH_POINT_FOLLOW, "attach_staff", self.caster:GetAbsOrigin(), true)
ParticleManager:SetParticleControl(zap_pfx, 1, self:GetParent():GetAbsOrigin())
ParticleManager:ReleaseParticleIndex(zap_pfx)

self:GetCaster():EmitSound("UI.Ability_frost")  

local seed_particle = ParticleManager:CreateParticle("particles/econ/items/lich/frozen_chains_ti6/lich_frozenchains_frostnova.vpcf", PATTACH_WORLDORIGIN, nil)
ParticleManager:SetParticleControl(seed_particle, 0, self:GetParent():GetAbsOrigin())
ParticleManager:SetParticleControl(seed_particle, 1, self:GetParent():GetAbsOrigin())
ParticleManager:SetParticleControl(seed_particle, 2, self:GetParent():GetAbsOrigin())
ParticleManager:ReleaseParticleIndex(seed_particle)

for _,target in pairs(self:GetCaster():FindTargets(self.radius, self:GetParent():GetAbsOrigin())) do

 DoDamage({ victim = target, attacker = self.caster, ability = self:GetAbility(), damage = self.damage, damage_type = DAMAGE_TYPE_MAGICAL})
end
   
end






