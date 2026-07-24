--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier( "modifier_ursa_clap_active_slow", "abilities/neutral_creeps_active/neutral_ursa_clap_active", LUA_MODIFIER_MOTION_NONE )

neutral_ursa_clap_active = class({})

function neutral_ursa_clap_active:OnAbilityPhaseStart()
local caster = self:GetCaster()

caster:EmitSound("n_creep_Ursa.Clap")
return true
end


function neutral_ursa_clap_active:OnSpellStart()
local caster = self:GetCaster()

local duration = self:GetSpecialValueFor("duration")
local radius = self:GetSpecialValueFor("aoe")
local damage = self:GetSpecialValueFor("damage")

local trail_pfx = ParticleManager:CreateParticle("particles/neutral_fx/ursa_thunderclap.vpcf", PATTACH_ABSORIGIN, caster)
ParticleManager:SetParticleControl(trail_pfx, 1, Vector(radius, radius, radius))
ParticleManager:ReleaseParticleIndex(trail_pfx) 

local damageTable = {attacker = caster, damage = damage, damage_type = DAMAGE_TYPE_MAGICAL, ability = self }

for _,target in pairs(caster:FindTargets(radius)) do
	damageTable.victim = target
	DoDamage(damageTable)
	target:AddNewModifier(caster, self, "modifier_ursa_clap_active_slow", { duration = duration * (1 - target:GetStatusResistance()) })
end
      
end






modifier_ursa_clap_active_slow = class({})
function modifier_ursa_clap_active_slow:IsPurgable() return true end
function modifier_ursa_clap_active_slow:IsHidden() return true end
function modifier_ursa_clap_active_slow:DeclareFunctions()
return 
{
  MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE
}
end


function modifier_ursa_clap_active_slow:OnCreated()
self.slow = self:GetAbility():GetSpecialValueFor("slow")
end

function modifier_ursa_clap_active_slow:GetModifierMoveSpeedBonus_Percentage()
return self.slow
end