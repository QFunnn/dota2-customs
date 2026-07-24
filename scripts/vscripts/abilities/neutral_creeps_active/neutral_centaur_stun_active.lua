--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


neutral_centaur_stun_active = class({})

function neutral_centaur_stun_active:OnAbilityPhaseStart()
local caster = self:GetCaster()

caster:EmitSound("n_creep_Centaur.Stomp")
return true
end


function neutral_centaur_stun_active:OnSpellStart()
local caster = self:GetCaster()

local stun = self:GetSpecialValueFor("stun")
local radius = self:GetSpecialValueFor("aoe")
local damage = self:GetSpecialValueFor("damage")

local trail_pfx = ParticleManager:CreateParticle("particles/neutral_fx/neutral_centaur_khan_war_stomp.vpcf", PATTACH_ABSORIGIN, caster)
ParticleManager:SetParticleControl(trail_pfx, 1, Vector(radius, radius, radius))
ParticleManager:ReleaseParticleIndex(trail_pfx) 

local damageTable = {attacker = caster, damage = damage, damage_type = DAMAGE_TYPE_MAGICAL, ability = self }

for _,target in pairs(caster:FindTargets(radius)) do
	damageTable.victim = target
	DoDamage(damageTable)
	target:AddNewModifier(caster, self, "modifier_stunned", { duration = stun * (1 - target:GetStatusResistance()) })
end
      
end



