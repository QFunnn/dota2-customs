--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


modifier_woda_illusion = class({})
function modifier_woda_illusion:IsHidden() return true end
function modifier_woda_illusion:IsPurgeException() return false end
function modifier_woda_illusion:IsPurgable() return false end
function modifier_woda_illusion:OnDestroy()
    if not IsServer() then return end
    local parent = self:GetParent()
    Timers:CreateTimer(1, function()
        UTIL_Remove(parent)
    end)
end