--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


modifier_rune_berserker = class({})

local VALUES = {1.5,1.4,1.3}

local function GetValue(self)
    local level = math.max(1, math.min(self:GetStackCount(), #VALUES))
    return VALUES[level] or 0
end

function modifier_rune_berserker:IsHidden() return true end
function modifier_rune_berserker:IsPurgable() return false end
function modifier_rune_berserker:IsPurgeException() return false end
function modifier_rune_berserker:RemoveOnDeath() return false end
function modifier_rune_berserker:DeclareFunctions() return {MODIFIER_PROPERTY_BASE_ATTACK_TIME_CONSTANT} end
function modifier_rune_berserker:OnCreated() if IsServer() then self:GetParent():CalculateStatBonus(true) end end
function modifier_rune_berserker:OnRefresh() if IsServer() then self:GetParent():CalculateStatBonus(true) end end
function modifier_rune_berserker:GetModifierBaseAttackTimeConstant() return GetValue(self) end