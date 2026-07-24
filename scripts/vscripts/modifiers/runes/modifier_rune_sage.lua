--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


modifier_rune_sage = class({})

local VALUES = {10, 20, 30}

local function GetValue(self)
    local level = math.max(1, math.min(self:GetStackCount(), #VALUES))
    return VALUES[level] or 0
end

function modifier_rune_sage:IsHidden() return true end
function modifier_rune_sage:IsPurgable() return false end
function modifier_rune_sage:IsPurgeException() return false end
function modifier_rune_sage:RemoveOnDeath() return false end
function modifier_rune_sage:DeclareFunctions() return {MODIFIER_PROPERTY_EXTRA_MANA_PERCENTAGE} end
function modifier_rune_sage:OnCreated() if IsServer() then self:GetParent():CalculateStatBonus(true) end end
function modifier_rune_sage:OnRefresh() if IsServer() then self:GetParent():CalculateStatBonus(true) end end
function modifier_rune_sage:GetModifierExtraManaPercentage() return GetValue(self) end