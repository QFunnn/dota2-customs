--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


modifier_rune_thought = class({})

local VALUES = {5, 10, 15}

local function GetValue(self)
    local level = math.max(1, math.min(self:GetStackCount(), #VALUES))
    return VALUES[level] or 0
end

function modifier_rune_thought:IsHidden() return true end
function modifier_rune_thought:IsPurgable() return false end
function modifier_rune_thought:IsPurgeException() return false end
function modifier_rune_thought:RemoveOnDeath() return false end
function modifier_rune_thought:DeclareFunctions() return {MODIFIER_PROPERTY_COOLDOWN_PERCENTAGE} end
function modifier_rune_thought:OnCreated() if IsServer() then self:GetParent():CalculateStatBonus(true) end end
function modifier_rune_thought:OnRefresh() if IsServer() then self:GetParent():CalculateStatBonus(true) end end
function modifier_rune_thought:GetModifierPercentageCooldown() return GetValue(self) end