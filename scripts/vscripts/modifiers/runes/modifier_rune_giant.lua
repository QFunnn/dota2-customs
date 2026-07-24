--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


modifier_rune_giant = class({})

local VALUES = {-5, -10, -15}

local function GetValue(self)
    local level = math.max(1, math.min(self:GetStackCount(), #VALUES))
    return VALUES[level] or 0
end

function modifier_rune_giant:IsHidden() return true end
function modifier_rune_giant:IsPurgable() return false end
function modifier_rune_giant:IsPurgeException() return false end
function modifier_rune_giant:RemoveOnDeath() return false end
function modifier_rune_giant:DeclareFunctions() return {MODIFIER_PROPERTY_INCOMING_DAMAGE_PERCENTAGE} end
function modifier_rune_giant:OnCreated() if IsServer() then self:GetParent():CalculateStatBonus(true) end end
function modifier_rune_giant:OnRefresh() if IsServer() then self:GetParent():CalculateStatBonus(true) end end
function modifier_rune_giant:GetModifierIncomingDamage_Percentage() return GetValue(self) end