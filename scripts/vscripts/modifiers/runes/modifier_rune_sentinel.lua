--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


modifier_rune_sentinel = class({})

local VALUES = {-5, -10, -15}

local function GetValue(self)
    local level = math.max(1, math.min(self:GetStackCount(), #VALUES))
    return VALUES[level] or 0
end

function modifier_rune_sentinel:IsHidden() return true end
function modifier_rune_sentinel:IsPurgable() return false end
function modifier_rune_sentinel:IsPurgeException() return false end
function modifier_rune_sentinel:RemoveOnDeath() return false end
function modifier_rune_sentinel:DeclareFunctions() return {MODIFIER_PROPERTY_INCOMING_PHYSICAL_DAMAGE_PERCENTAGE} end
function modifier_rune_sentinel:OnCreated() if IsServer() then self:GetParent():CalculateStatBonus(true) end end
function modifier_rune_sentinel:OnRefresh() if IsServer() then self:GetParent():CalculateStatBonus(true) end end
function modifier_rune_sentinel:GetModifierIncomingPhysicalDamage_Percentage(params)
    if params.damage_category == DOTA_DAMAGE_CATEGORY_SPELL then return 0 end 
    return GetValue(self) 
end