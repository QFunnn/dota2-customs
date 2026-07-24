--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


modifier_rune_antimagic = class({})

local VALUES = {10, 20, 30}

local function GetValue(self)
    local level = math.max(1, math.min(self:GetStackCount(), #VALUES))
    return VALUES[level] or 0
end

function modifier_rune_antimagic:IsHidden() return true end
function modifier_rune_antimagic:IsPurgable() return false end
function modifier_rune_antimagic:IsPurgeException() return false end
function modifier_rune_antimagic:RemoveOnDeath() return false end
function modifier_rune_antimagic:DeclareFunctions() return {MODIFIER_PROPERTY_MAGICAL_RESISTANCE_BONUS} end
function modifier_rune_antimagic:OnCreated() if IsServer() then self:GetParent():CalculateStatBonus(true) end end
function modifier_rune_antimagic:OnRefresh() if IsServer() then self:GetParent():CalculateStatBonus(true) end end
function modifier_rune_antimagic:GetModifierMagicalResistanceBonus() return GetValue(self) end