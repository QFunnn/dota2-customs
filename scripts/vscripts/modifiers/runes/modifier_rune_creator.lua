--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


modifier_rune_creator = class({})

function modifier_rune_creator:IsHidden() return true end
function modifier_rune_creator:IsPurgable() return false end
function modifier_rune_creator:IsPurgeException() return false end
function modifier_rune_creator:RemoveOnDeath() return false end
function modifier_rune_creator:OnCreated() if IsServer() then self:GetParent():CalculateStatBonus(true) end end
function modifier_rune_creator:OnRefresh() if IsServer() then self:GetParent():CalculateStatBonus(true) end end