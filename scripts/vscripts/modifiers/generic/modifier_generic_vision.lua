--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]



modifier_generic_vision = class({})

function modifier_generic_vision:IsHidden() return true end
function modifier_generic_vision:IsPurgable() return false end
function modifier_generic_vision:GetAttributes() return MODIFIER_ATTRIBUTE_MULTIPLE end
function modifier_generic_vision:OnCreated(table)
if not IsServer() then return end
self.caster_team = self:GetCaster():GetTeamNumber()
self.parent = self:GetParent()

self.interval = 0.3

self:OnIntervalThink()
self:StartIntervalThink(self.interval)
end

function modifier_generic_vision:OnIntervalThink()
if not IsServer() then return end 

AddFOWViewer(self.caster_team, self.parent:GetAbsOrigin(), 10, self.interval + 0.1, false)
end