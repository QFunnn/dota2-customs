--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


modifier_rune_cleansing = class({})

local VALUES = {10, 20, 30}

local function GetValue(self)
    local level = math.max(1, math.min(self:GetStackCount(), #VALUES))
    return VALUES[level] or 0
end

function modifier_rune_cleansing:IsHidden() return true end
function modifier_rune_cleansing:IsPurgable() return false end
function modifier_rune_cleansing:IsPurgeException() return false end
function modifier_rune_cleansing:RemoveOnDeath() return false end
function modifier_rune_cleansing:DeclareFunctions() return {MODIFIER_PROPERTY_MANACOST_PERCENTAGE_STACKING} end
function modifier_rune_cleansing:OnCreated() if IsServer() then self:GetParent():CalculateStatBonus(true) end end
function modifier_rune_cleansing:OnRefresh() if IsServer() then self:GetParent():CalculateStatBonus(true) end end
function modifier_rune_cleansing:GetModifierPercentageManacostStacking() return GetValue(self) end