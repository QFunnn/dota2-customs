--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_centaur_cd", "abilities/npc_centaur_stun", LUA_MODIFIER_MOTION_NONE)

npc_centaur_stun = class({})

function npc_centaur_stun:OnAbilityPhaseStart()
    self.sign = ParticleManager:CreateParticle( "particles/generic_gameplay/generic_has_quest.vpcf", PATTACH_OVERHEAD_FOLLOW, self:GetCaster())
    self:GetCaster():StartGestureWithPlaybackRate(ACT_DOTA_CAST_ABILITY_1, 0.6)
      
    self.radius = self:GetSpecialValueFor("radius")  
    
    local particle_cast = "particles/units/heroes/hero_snapfire/hero_snapfire_ultimate_calldown.vpcf"
    self.effect_cast = ParticleManager:CreateParticle(particle_cast, PATTACH_CUSTOMORIGIN, self:GetCaster())
    ParticleManager:SetParticleControl( self.effect_cast, 0, self:GetCaster():GetOrigin() )
    ParticleManager:SetParticleControl( self.effect_cast, 1, Vector( self.radius, 0, -self.radius) )
    ParticleManager:SetParticleControl( self.effect_cast, 2, Vector( 0.8, 0, 0 ) )

    return true
end 


function npc_centaur_stun:OnSpellStart()
if not IsServer() then return end


self:GetCaster():AddNewModifier(self:GetCaster(), self, "modifier_centaur_cd", {duration = self:GetCooldownTimeRemaining()})
ParticleManager:DestroyParticle(self.sign, true)
ParticleManager:DestroyParticle(self.effect_cast, true)

self:GetCaster():EmitSound("Hero_Centaur.HoofStomp")

local particle_stomp_fx = ParticleManager:CreateParticle("particles/units/heroes/hero_centaur/centaur_warstomp.vpcf", PATTACH_ABSORIGIN, self:GetCaster())
ParticleManager:SetParticleControl(particle_stomp_fx, 0, self:GetCaster():GetAbsOrigin())
ParticleManager:SetParticleControl(particle_stomp_fx, 1, Vector(self.radius, self.radius, self.radius))
ParticleManager:SetParticleControl(particle_stomp_fx, 2, self:GetCaster():GetAbsOrigin())
ParticleManager:ReleaseParticleIndex(particle_stomp_fx)

local targets = FindUnitsInRadius(self:GetCaster():GetTeamNumber(), self:GetCaster():GetAbsOrigin(), nil, self.radius, DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC, DOTA_UNIT_TARGET_FLAG_MAGIC_IMMUNE_ENEMIES + DOTA_UNIT_TARGET_FLAG_FOW_VISIBLE, FIND_ANY_ORDER, false)

for _,target in pairs(targets) do
    if not target:IsMagicImmune() then 
        target:AddNewModifier(self:GetCaster(), self, "modifier_stunned", {duration = self:GetSpecialValueFor("stun")*(1 - target:GetStatusResistance())})
        DoDamage({victim = target, attacker = self:GetCaster(), damage = self:GetSpecialValueFor("damage"), damage_type = DAMAGE_TYPE_MAGICAL, ability = self})
           
    end
end

end

function npc_centaur_stun:OnAbilityPhaseInterrupted()
ParticleManager:DestroyParticle(self.sign, true)
ParticleManager:DestroyParticle(self.effect_cast, true)
self:GetCaster():RemoveGesture(ACT_DOTA_CAST_ABILITY_1)
end

modifier_centaur_cd = class({})
function modifier_centaur_cd:IsHidden() return false end
function modifier_centaur_cd:IsPurgable() return false end
