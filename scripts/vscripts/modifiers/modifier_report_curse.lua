--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


-- Курса за репорты (наказание, MF-2). ОТДЕЛЬНАЯ от обычной modifier_loser_curse,
-- стакается с ней. Активна ВСЕГДА (в т.ч. в PVP/дуэлях, в отличие от обычной курсы).
-- MULTIPLE: несколько экземпляров (по одному на строку наказания в БД), у каждого свои
-- стаки и свой срок; эффекты складываются. Даёт +20% входящего и −10% статов за стак.
-- Исходящий урон (−20%/стак) режется в глобальном фильтре utils/damage_filter_util.lua
-- (там же суммируется со стаками обычной курсы), поэтому здесь его НЕТ.
modifier_report_curse = class({})

function modifier_report_curse:GetTexture() return "punishment_curse" end
function modifier_report_curse:IsHidden() return false end
function modifier_report_curse:IsDebuff() return true end
function modifier_report_curse:IsPurgable() return false end
function modifier_report_curse:RemoveOnDeath() return false end
function modifier_report_curse:GetAttributes() return MODIFIER_ATTRIBUTE_MULTIPLE end

function modifier_report_curse:OnCreated()
    self.parent = self:GetParent()
end

function modifier_report_curse:OnRefresh()
    self.parent = self:GetParent()
end

function modifier_report_curse:DeclareFunctions()
    return {
        MODIFIER_PROPERTY_INCOMING_DAMAGE_PERCENTAGE,
        MODIFIER_PROPERTY_STATS_STRENGTH_BONUS,
        MODIFIER_PROPERTY_STATS_AGILITY_BONUS,
        MODIFIER_PROPERTY_STATS_INTELLECT_BONUS,
    }
end

function modifier_report_curse:GetModifierIncomingDamage_Percentage(params)
    if self.parent == nil or self.parent:IsNull() then return end
    return 20 * self:GetStackCount()
end

function modifier_report_curse:GetModifierBonusStats_Strength(params)
    if not IsServer() or self.parent == nil or self.parent:IsNull() then return end
    return -0.1 * self:GetStackCount() * self.parent:GetBaseStrength()
end

function modifier_report_curse:GetModifierBonusStats_Agility(params)
    if not IsServer() or self.parent == nil or self.parent:IsNull() then return end
    return -0.1 * self:GetStackCount() * self.parent:GetBaseAgility()
end

function modifier_report_curse:GetModifierBonusStats_Intellect(params)
    if not IsServer() or self.parent == nil or self.parent:IsNull() then return end
    return -0.1 * self:GetStackCount() * self.parent:GetBaseIntellect()
end