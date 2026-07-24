--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


modifier_rune_spell = class({})

local VALUES = {10, 20, 30}

local function GetValue(self)
    local level = math.max(1, math.min(self:GetStackCount(), #VALUES))
    return VALUES[level] or 0
end

function modifier_rune_spell:IsHidden() return true end
function modifier_rune_spell:IsPurgable() return false end
function modifier_rune_spell:IsPurgeException() return false end
function modifier_rune_spell:RemoveOnDeath() return false end
function modifier_rune_spell:DeclareFunctions() return {MODIFIER_PROPERTY_SPELL_AMPLIFY_PERCENTAGE} end
function modifier_rune_spell:OnCreated() if IsServer() then self:GetParent():CalculateStatBonus(true) end end
function modifier_rune_spell:OnRefresh() if IsServer() then self:GetParent():CalculateStatBonus(true) end end
function modifier_rune_spell:GetModifierSpellAmplify_Percentage() return GetValue(self) end