--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]





modifier_generic_taunt = class({})

function modifier_generic_taunt:IsPurgable()
  return false
end
function modifier_generic_taunt:IsHidden()
  return true
end

function modifier_generic_taunt:OnCreated( kv )
if not IsServer() then return end

self.parent = self:GetParent()
self.caster = self:GetCaster()

self.parent:Stop()
self.parent:Interrupt()

if not self.parent:IsCreep() then 
  self.parent:MoveToTargetToAttack( self.caster )
  --self.parent:MoveToPositionAggressive( self.caster:GetAbsOrigin() )
	self.parent:SetForceAttackTarget( self.caster )
end

self.parent:EmitSound("UI.Generic_taunt")
self:StartIntervalThink(FrameTime())
end

function modifier_generic_taunt:OnIntervalThink()
if not IsServer() then return end

if not self.caster or self.caster:IsNull() or not self.caster:IsAlive() then
  self:Destroy()
end



end

function modifier_generic_taunt:OnDestroy()
if not IsServer() then return end

if not self.parent:IsCreep() then 
	self.parent:SetForceAttackTarget( nil )
end

end


function modifier_generic_taunt:CheckState()
  local state = {
    --[MODIFIER_STATE_COMMAND_RESTRICTED] = true,
    [MODIFIER_STATE_TAUNTED] = true,
  }

  return state
end

function modifier_generic_taunt:GetStatusEffectName()
  return "particles/status_fx/status_effect_beserkers_call.vpcf"
end
