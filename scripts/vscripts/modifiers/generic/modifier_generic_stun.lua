--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]




modifier_generic_stun = class({})

function modifier_generic_stun:IsHidden() return false end
function modifier_generic_stun:IsStunDebuff() return true end
function modifier_generic_stun:IsPurgeException() return true end
function modifier_generic_stun:GetAttributes() return MODIFIER_ATTRIBUTE_MULTIPLE end
function modifier_generic_stun:CheckState()
return
{
  [MODIFIER_STATE_STUNNED] = true
}
end

function modifier_generic_stun:GetEffectName() return "particles/generic_gameplay/generic_stunned.vpcf" end
function modifier_generic_stun:GetEffectAttachType() return PATTACH_OVERHEAD_FOLLOW end

function modifier_generic_stun:DeclareFunctions()
return
{
  MODIFIER_PROPERTY_OVERRIDE_ANIMATION
}
end


function modifier_generic_stun:OnCreated(table)
if not IsServer() then return end 

self.caster = self:GetCaster()
self.parent = self:GetParent()

self.end_rule = nil
end 


function modifier_generic_stun:SetEndRule( func )
  self.end_rule = func
end


function modifier_generic_stun:GetOverrideAnimation()
return ACT_DOTA_DISABLED
end

function modifier_generic_stun:OnDestroy()
if not IsServer() then return end
if self.end_rule == nil then return end

self.end_rule()
end