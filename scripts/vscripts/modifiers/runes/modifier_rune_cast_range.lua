--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


modifier_rune_cast_range = class({})

local VALUES = {200, 400, 600}

local function GetValue(self)
    local level = math.max(1, math.min(self:GetStackCount(), #VALUES))
    return VALUES[level] or 0
end

function modifier_rune_cast_range:IsHidden() return true end
function modifier_rune_cast_range:IsPurgable() return false end
function modifier_rune_cast_range:IsPurgeException() return false end
function modifier_rune_cast_range:RemoveOnDeath() return false end
function modifier_rune_cast_range:DeclareFunctions() return {MODIFIER_PROPERTY_CAST_RANGE_BONUS_STACKING} end
function modifier_rune_cast_range:OnCreated() if IsServer() then self:GetParent():CalculateStatBonus(true) end end
function modifier_rune_cast_range:OnRefresh() if IsServer() then self:GetParent():CalculateStatBonus(true) end end
function modifier_rune_cast_range:GetModifierCastRangeBonusStacking() return GetValue(self) end