--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_dazzle_grave", "abilities/npc_dazzle_grave", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_dazzle_grave_cd", "abilities/npc_dazzle_grave", LUA_MODIFIER_MOTION_NONE)

npc_dazzle_grave = class({})

function npc_dazzle_grave:OnSpellStart()

    if not IsServer() then
        return
    end
    self:GetCaster():AddNewModifier(self:GetCaster(), self, "modifier_dazzle_grave_cd", {duration = self:GetCooldownTimeRemaining()}) 

    self:GetCursorTarget():AddNewModifier(self:GetCaster(), self, "modifier_dazzle_grave", {duration = self:GetSpecialValueFor("duration")})

end



modifier_dazzle_grave = class({})

function modifier_dazzle_grave:IsPurgable() return false end

function modifier_dazzle_grave:IsHidden() return false end


function modifier_dazzle_grave:OnCreated(table)

if not IsServer() then return end
  self:GetParent():EmitSound("Hero_Dazzle.Shallow_Grave") 
  self.shallow_grave_particle = ParticleManager:CreateParticle("particles/econ/items/dazzle/dazzle_dark_light_weapon/dazzle_dark_shallow_grave.vpcf", PATTACH_ABSORIGIN_FOLLOW, self:GetParent())
    
end

function modifier_dazzle_grave:OnDestroy()
  if IsServer() then

    ParticleManager:DestroyParticle(self.shallow_grave_particle, true)
end
end

function modifier_dazzle_grave:GetEffectAttachType()
  return PATTACH_ABSORIGIN_FOLLOW end


function modifier_dazzle_grave:DeclareFunctions()

  return 
{

         MODIFIER_PROPERTY_MIN_HEALTH
}

end

function modifier_dazzle_grave:GetMinHealth()
if self:GetParent():HasModifier("modifier_death") then return end
  return 1 end
 
modifier_dazzle_grave_cd = class({})

function modifier_dazzle_grave_cd:IsHidden() return false end
function modifier_dazzle_grave_cd:IsPurgable() return false end