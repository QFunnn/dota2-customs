--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


modifier_hero_unique_modifier_spirit_breaker_bulldoze = class({})
function modifier_hero_unique_modifier_spirit_breaker_bulldoze:IsHidden() return true end
function modifier_hero_unique_modifier_spirit_breaker_bulldoze:IsPurgable() return false end
function modifier_hero_unique_modifier_spirit_breaker_bulldoze:IsPurgeException() return false end
function modifier_hero_unique_modifier_spirit_breaker_bulldoze:RemoveOnDeath() return false end

function modifier_hero_unique_modifier_spirit_breaker_bulldoze:OnCreated(params)
    self.parent = self:GetParent()
    self.ability = self:GetAbility()
    if not IsServer() then return end
    self:StartIntervalThink(1)
end

function modifier_hero_unique_modifier_spirit_breaker_bulldoze:OnIntervalThink()
    if not IsServer() then return end
    if self.ability == nil or self.ability:IsNull() then
        self:Destroy()
    end
end

function modifier_hero_unique_modifier_spirit_breaker_bulldoze:DeclareFunctions()
    return
    {
        MODIFIER_PROPERTY_STATUS_RESISTANCE_STACKING
    }
end

function modifier_hero_unique_modifier_spirit_breaker_bulldoze:GetModifierStatusResistanceStacking()
    -- Lazy-read: BonusModifier добавляется в hero_builder.lua ДО SetLevel(1) (см. строки 861-874),
    -- поэтому в OnCreated ability ещё level=0 и GetSpecialValueFor вернёт 0. Читаем здесь,
    -- к этому моменту ability уже на уровне 1.
    if not self.ability or self.ability:IsNull() or self.ability:GetLevel() <= 0 then return 0 end
    return self.ability:GetSpecialValueFor("bonus_status_resistance")
end