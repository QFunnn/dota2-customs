--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


modifier_rune_regeneration = class({})

local VALUES = {1, 2, 3}

local function GetValue(self)
    local level = math.max(1, math.min(self:GetStackCount(), #VALUES))
    return VALUES[level] or 0
end

function modifier_rune_regeneration:IsHidden() return true end
function modifier_rune_regeneration:IsPurgable() return false end
function modifier_rune_regeneration:IsPurgeException() return false end
function modifier_rune_regeneration:RemoveOnDeath() return false end
function modifier_rune_regeneration:DeclareFunctions() return {MODIFIER_PROPERTY_HEALTH_REGEN_PERCENTAGE} end
function modifier_rune_regeneration:OnCreated() if IsServer() then self:GetParent():CalculateStatBonus(true) end end
function modifier_rune_regeneration:OnRefresh() if IsServer() then self:GetParent():CalculateStatBonus(true) end end
function modifier_rune_regeneration:GetModifierHealthRegenPercentage() return GetValue(self) end