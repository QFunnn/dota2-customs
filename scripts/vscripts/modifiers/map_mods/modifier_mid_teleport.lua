--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_mid_teleport", "modifiers/map_mods/modifier_mid_teleport", LUA_MODIFIER_MOTION_NONE)


modifier_mid_teleport = class({})

function modifier_mid_teleport:IsHidden() return false end
function modifier_mid_teleport:IsPurgable() return false end


function modifier_mid_teleport:CheckState()
return 
{
  [MODIFIER_STATE_NO_HEALTH_BAR] = true,
  [MODIFIER_STATE_MAGIC_IMMUNE] = true,
  [MODIFIER_STATE_STUNNED] = true,
  [MODIFIER_STATE_FLYING_FOR_PATHING_PURPOSES_ONLY] = true,
  [MODIFIER_STATE_CANNOT_BE_MOTION_CONTROLLED] = true,
}
end

function modifier_mid_teleport:DeclareFunctions() 
return 
{
  MODIFIER_PROPERTY_ABSOLUTE_NO_DAMAGE_PHYSICAL,
  MODIFIER_PROPERTY_ABSOLUTE_NO_DAMAGE_MAGICAL,
  MODIFIER_PROPERTY_ABSOLUTE_NO_DAMAGE_PURE,
  MODIFIER_PROPERTY_OVERRIDE_ANIMATION,
}
end

function modifier_mid_teleport:GetOverrideAnimation()
return ACT_DOTA_IDLE
end

function modifier_mid_teleport:GetAbsoluteNoDamagePhysical() return 1 end
function modifier_mid_teleport:GetAbsoluteNoDamageMagical() return 1 end
function modifier_mid_teleport:GetAbsoluteNoDamagePure() return 1 end


function modifier_mid_teleport:OnCreated(table)
if not IsServer() then return end
self.parent = self:GetParent()
local number = tonumber(self:GetParent():GetName())
self.parent:SetNeverMoveToClearSpace(true)

local cp = 1
if IsDire(self.parent:GetName()) then 
  cp = 0
end

self.parent:StartGesture(ACT_DOTA_IDLE)

local effect_cast = ParticleManager:CreateParticle("particles/portal_ring.vpcf", PATTACH_ABSORIGIN_FOLLOW, self:GetParent() )
ParticleManager:SetParticleControl( effect_cast, 12, Vector(cp,0,0) )
self:AddParticle(effect_cast, false, false, -1, false, false)
end









