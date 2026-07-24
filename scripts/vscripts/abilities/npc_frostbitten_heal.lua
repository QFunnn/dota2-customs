--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_frostbitten_heal", "abilities/npc_frostbitten_heal", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_frostbitten_heal_cd", "abilities/npc_frostbitten_heal", LUA_MODIFIER_MOTION_NONE)

npc_frostbitten_heal = class({})

function npc_frostbitten_heal:OnSpellStart()
if not IsServer() then return end

    self:GetCaster():AddNewModifier(self:GetCaster(), self, "modifier_frostbitten_heal_cd", {duration = self:GetCooldownTimeRemaining()}) 

    self:GetCursorTarget():AddNewModifier(self:GetCaster(), self, "modifier_frostbitten_heal", {duration = self:GetSpecialValueFor("duration")})

end



modifier_frostbitten_heal = class({})

function modifier_frostbitten_heal:IsPurgable() return false end

function modifier_frostbitten_heal:IsHidden() return false end


function modifier_frostbitten_heal:OnCreated(table)

if not IsServer() then return end
  self:GetParent():EmitSound("Creep.Wyvern_heal") 
  self.shallow_grave_particle = ParticleManager:CreateParticle("particles/units/heroes/hero_winter_wyvern/wyvern_cold_embrace_buff.vpcf", PATTACH_ABSORIGIN_FOLLOW, self:GetParent())
  ParticleManager:SetParticleControl( self.shallow_grave_particle, 0, self:GetParent():GetOrigin() ) 
  ParticleManager:SetParticleControl( self.shallow_grave_particle, 1, self:GetParent():GetOrigin() ) 
  ParticleManager:SetParticleControl( self.shallow_grave_particle, 2, self:GetParent():GetOrigin() ) 
end

function modifier_frostbitten_heal:OnDestroy()
  if IsServer() then

    ParticleManager:DestroyParticle(self.shallow_grave_particle, true)
end
end

function modifier_frostbitten_heal:CheckState() return 
{
  [MODIFIER_STATE_STUNNED] = true,
  [MODIFIER_STATE_FROZEN] = true
}
end


function modifier_frostbitten_heal:DeclareFunctions()

  return 
{

         MODIFIER_PROPERTY_HEALTH_REGEN_PERCENTAGE,
         MODIFIER_PROPERTY_ABSOLUTE_NO_DAMAGE_PHYSICAL
}

end

function modifier_frostbitten_heal:GetAbsoluteNoDamagePhysical() return 1 end

function modifier_frostbitten_heal:GetModifierHealthRegenPercentage()
return 
  self:GetAbility():GetSpecialValueFor("heal")
end
 
modifier_frostbitten_heal_cd = class({})

function modifier_frostbitten_heal_cd:IsHidden() return false end
function modifier_frostbitten_heal_cd:IsPurgable() return false end