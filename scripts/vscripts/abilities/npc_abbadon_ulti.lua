--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_abbadon_passive", "abilities/npc_abbadon_ulti.lua", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_abbadon_buff", "abilities/npc_abbadon_ulti.lua", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_abbadon_cd", "abilities/npc_abbadon_ulti.lua", LUA_MODIFIER_MOTION_NONE)

npc_abbadon_ulti = class({})


function npc_abbadon_ulti:GetIntrinsicModifierName() return "modifier_abbadon_passive" end
 

modifier_abbadon_passive = class(mod_hidden)

function modifier_abbadon_passive:OnCreated(table)
self.parent = self:GetParent()
self.ability = self:GetAbility()
self.health = self.ability:GetSpecialValueFor("health")
self.cd = self.ability:GetSpecialValueFor("cd")
self.duration = self.ability:GetSpecialValueFor("duration")

self.parent:AddDamageEvent_inc(self, true)
end

function modifier_abbadon_passive:DamageEvent_inc(params)
if not IsServer() then end 
if self.parent ~= params.unit then return end
if self.parent:GetHealthPercent() > self.health then return end
if self.parent:HasModifier("modifier_abbadon_cd") then return end
if not self.parent:IsAlive() then return end

self.parent:EmitSound("Hero_Abaddon.BorrowedTime")
self.parent:AddNewModifier(self.parent, self.ability, "modifier_abbadon_cd", {duration = self.cd})
self.parent:AddNewModifier(self.parent, self.ability, "modifier_abbadon_buff", {duration = self.duration})
end



modifier_abbadon_buff = class ({})

function modifier_abbadon_buff:IsHidden() return false end
function modifier_abbadon_buff:IsPurgable() return false end

function modifier_abbadon_buff:OnCreated()
self.parent = self:GetParent()
self.ability = self:GetAbility()
self.heal = self.ability:GetSpecialValueFor("heal")/100

end

function modifier_abbadon_buff:DeclareFunctions() 
return
{
  MODIFIER_PROPERTY_ABSOLUTE_NO_DAMAGE_PHYSICAL,
  MODIFIER_PROPERTY_ABSOLUTE_NO_DAMAGE_MAGICAL,
  MODIFIER_PROPERTY_ABSOLUTE_NO_DAMAGE_PURE,
}
end

function modifier_abbadon_buff:DamageLogic(params)
if not IsServer() then return end 
if self.parent:HasModifier("modifier_death") then return 0 end

local attacker = params.attacker

if not attacker then return 0 end

local heal_particle = ParticleManager:CreateParticle("particles/units/heroes/hero_abaddon/abaddon_borrowed_time_heal.vpcf", PATTACH_CUSTOMORIGIN_FOLLOW, self.parent)
ParticleManager:SetParticleControlEnt( heal_particle, 0, self.parent, PATTACH_POINT_FOLLOW, "attach_hitloc", self.parent:GetAbsOrigin(), true )
ParticleManager:SetParticleControl(heal_particle, 1, attacker:GetAbsOrigin())
ParticleManager:ReleaseParticleIndex(heal_particle)

self.parent:GenericHeal(params.damage*self.heal, self.ability, true, "")
return 1
end 

function modifier_abbadon_buff:GetAbsoluteNoDamagePhysical(params)
return self:DamageLogic(params)
end

function modifier_abbadon_buff:GetAbsoluteNoDamageMagical(params)
return self:DamageLogic(params)
end

function modifier_abbadon_buff:GetAbsoluteNoDamagePure(params)
return self:DamageLogic(params)
end


function modifier_abbadon_buff:GetEffectName() return "particles/units/heroes/hero_abaddon/abaddon_borrowed_time.vpcf" end
function modifier_abbadon_buff:GetEffectAttachType() return PATTACH_ABSORIGIN_FOLLOW end
function modifier_abbadon_buff:GetStatusEffectName() return "particles/status_fx/status_effect_abaddon_borrowed_time.vpcf" end
function modifier_abbadon_buff:StatusEffectPriority() return MODIFIER_PRIORITY_SUPER_ULTRA  end






modifier_abbadon_cd = class({})
function modifier_abbadon_cd:IsHidden() return false end
function modifier_abbadon_cd:IsPurgable() return false end
function modifier_abbadon_cd:IsDebuff() return true end