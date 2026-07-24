--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_phantom_assassin_innate_cleave", "abilities/phantom_assassin_innate_cleave", LUA_MODIFIER_MOTION_NONE)

phantom_assassin_innate_cleave = class({})

function phantom_assassin_innate_cleave:GetIntrinsicModifierName()
    return "modifier_phantom_assassin_innate_cleave"
end

modifier_phantom_assassin_innate_cleave = class({})

function modifier_phantom_assassin_innate_cleave:IsHidden() return false end
function modifier_phantom_assassin_innate_cleave:IsPurgable() return false end
function modifier_phantom_assassin_innate_cleave:IsPurgeException() return false end
function modifier_phantom_assassin_innate_cleave:RemoveOnDeath() return false end

function modifier_phantom_assassin_innate_cleave:DeclareFunctions()
    return { MODIFIER_PROPERTY_TOOLTIP }
end

function modifier_phantom_assassin_innate_cleave:OnTooltip()
    return self:GetBonusCleavePct()
end

-- Возвращает текущий бонус прорубающего урона от врождённой (в процентах)
function modifier_phantom_assassin_innate_cleave:GetBonusCleavePct()
    local ability = self:GetAbility()
    if not ability or ability:IsNull() then return 0 end
    local parent = self:GetParent()
    if not parent or parent:IsNull() then return 0 end
    local level = parent:GetLevel()
    local per_level = ability:GetSpecialValueFor("cleave_per_level")
    local max_bonus = ability:GetSpecialValueFor("cleave_max")
    return math.min(max_bonus, level * per_level)
end