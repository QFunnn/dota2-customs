--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


modifier_bristleback_persona_custom = class(mod_hidden)
function modifier_bristleback_persona_custom:RemoveOnDeath() return false end
function modifier_bristleback_persona_custom:OnCreated()
if not IsServer() then return end
self:GetCaster():EmitSound("Hero_Bristleback.IdleLoop.Automaton")
end
function modifier_bristleback_persona_custom:OnDestroy()
if not IsServer() then return end
self:GetCaster():StopSound("Hero_Bristleback.IdleLoop.Automaton")
end