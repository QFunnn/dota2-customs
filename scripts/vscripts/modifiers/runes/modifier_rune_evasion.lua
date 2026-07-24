--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


modifier_rune_evasion = class({})

local VALUES = {10, 20, 30}

local function GetValue(self)
    local level = math.max(1, math.min(self:GetStackCount(), #VALUES))
    return VALUES[level] or 0
end

function modifier_rune_evasion:IsHidden() return true end
function modifier_rune_evasion:IsPurgable() return false end
function modifier_rune_evasion:IsPurgeException() return false end
function modifier_rune_evasion:RemoveOnDeath() return false end
function modifier_rune_evasion:DeclareFunctions() return {MODIFIER_PROPERTY_EVASION_CONSTANT} end
function modifier_rune_evasion:OnCreated() if IsServer() then self:GetParent():CalculateStatBonus(true) end end
function modifier_rune_evasion:OnRefresh() if IsServer() then self:GetParent():CalculateStatBonus(true) end end
function modifier_rune_evasion:GetModifierEvasion_Constant() return GetValue(self) end