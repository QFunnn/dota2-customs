--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


modifier_aegis_buff = class({})

function modifier_aegis_buff:IsDebuff()
	return false
end
function modifier_aegis_buff:GetTexture()
	return "omniknight_repel"
end

function modifier_aegis_buff:IsPurgable()
  return false
end

function modifier_aegis_buff:OnCreated(table)
     local nWingsParticleIndex = ParticleManager:CreateParticle("particles/units/heroes/hero_omniknight/omniknight_guardian_angel_omni.vpcf", PATTACH_ABSORIGIN_FOLLOW, self:GetParent())
     ParticleManager:SetParticleControl(nWingsParticleIndex, 0, self:GetParent():GetAbsOrigin())
     ParticleManager:SetParticleControlEnt(nWingsParticleIndex, 5, self:GetParent(), PATTACH_POINT_FOLLOW, "attach_hitloc", self:GetParent():GetAbsOrigin(), true)
     self:AddParticle(nWingsParticleIndex, false, false, -1, false, false)    

    -- Halo particle
    local nHaloParticleIndex = ParticleManager:CreateParticle("particles/units/heroes/hero_omniknight/omniknight_guardian_angel_halo_buff.vpcf", PATTACH_OVERHEAD_FOLLOW, self:GetParent())
    ParticleManager:SetParticleControlEnt(nHaloParticleIndex, 0, self:GetParent(), PATTACH_POINT_FOLLOW, "attach_hitloc", self:GetParent():GetAbsOrigin(), true)    
    self:AddParticle(nHaloParticleIndex, false, false, -1, false, false)    
end

function modifier_aegis_buff:DeclareFunctions()
  local funcs = 
  {
       MODIFIER_PROPERTY_INCOMING_DAMAGE_PERCENTAGE,
       MODIFIER_PROPERTY_TOTALDAMAGEOUTGOING_PERCENTAGE
  }

  return funcs
end


function modifier_aegis_buff:GetModifierIncomingDamage_Percentage()
     return -65
end

function modifier_aegis_buff:GetModifierTotalDamageOutgoing_Percentage()
     return 100
end