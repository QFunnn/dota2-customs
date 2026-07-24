--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


modifier_rune_restoration = class({})

local VALUES = {1, 2, 3}

local function GetValue(self)
    local level = math.max(1, math.min(self:GetStackCount(), #VALUES))
    return VALUES[level] or 0
end

function modifier_rune_restoration:IsHidden() return true end
function modifier_rune_restoration:IsPurgable() return false end
function modifier_rune_restoration:IsPurgeException() return false end
function modifier_rune_restoration:RemoveOnDeath() return false end
function modifier_rune_restoration:DeclareFunctions() return {MODIFIER_PROPERTY_MANA_REGEN_TOTAL_PERCENTAGE} end
function modifier_rune_restoration:OnCreated() if IsServer() then self:GetParent():CalculateStatBonus(true) end end
function modifier_rune_restoration:OnRefresh() if IsServer() then self:GetParent():CalculateStatBonus(true) end end
function modifier_rune_restoration:GetModifierTotalPercentageManaRegen() return GetValue(self) end