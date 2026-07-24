--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


modifier_rune_radius = class({})

local VALUES = {100, 200, 300}

local function GetValue(self)
    local level = math.max(1, math.min(self:GetStackCount(), #VALUES))
    return VALUES[level] or 0
end

function modifier_rune_radius:IsHidden() return true end
function modifier_rune_radius:IsPurgable() return false end
function modifier_rune_radius:IsPurgeException() return false end
function modifier_rune_radius:RemoveOnDeath() return false end
function modifier_rune_radius:DeclareFunctions() return {MODIFIER_PROPERTY_AOE_BONUS_CONSTANT_STACKING} end
function modifier_rune_radius:OnCreated() if IsServer() then self:GetParent():CalculateStatBonus(true) end end
function modifier_rune_radius:OnRefresh() if IsServer() then self:GetParent():CalculateStatBonus(true) end end
function modifier_rune_radius:GetModifierAoEBonusConstantStacking() return GetValue(self) end