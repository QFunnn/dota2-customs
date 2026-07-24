--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


modifier_hero_unique_modifier_alchemist_corrosive_weaponry = class({})
function modifier_hero_unique_modifier_alchemist_corrosive_weaponry:IsHidden() return true end
function modifier_hero_unique_modifier_alchemist_corrosive_weaponry:IsPurgable() return false end
function modifier_hero_unique_modifier_alchemist_corrosive_weaponry:IsPurgeException() return false end
function modifier_hero_unique_modifier_alchemist_corrosive_weaponry:RemoveOnDeath() return false end
function modifier_hero_unique_modifier_alchemist_corrosive_weaponry:DeclareFunctions()
    return
    {
        MODIFIER_PROPERTY_STATUS_RESISTANCE_CASTER,
    }
end
function modifier_hero_unique_modifier_alchemist_corrosive_weaponry:GetModifierStatusResistanceCaster()
    -- Lazy-read: BonusModifier добавляется в hero_builder.lua ДО SetLevel(1) (см. строки 861-874),
    -- поэтому в OnCreated ability ещё level=0 и GetSpecialValueFor вернёт 0. Читаем здесь,
    -- к этому моменту ability уже на уровне 1.
    -- KV хранит положительное значение (30 = "+30% длительность дебаффов"),
    -- движок через STATUS_RESISTANCE_CASTER ждёт отрицательное (target теряет резист).
    local ability = self:GetAbility()
    if not ability or ability:IsNull() then return 0 end
    return -ability:GetSpecialValueFor("bonus_debuff_amplify")
end