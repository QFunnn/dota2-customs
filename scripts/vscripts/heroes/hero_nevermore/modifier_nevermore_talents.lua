--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_nevermore_presence_amp", "heroes/hero_nevermore/modifier_nevermore_talents", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_nevermore_presence_amp_debuff", "heroes/hero_nevermore/modifier_nevermore_talents", LUA_MODIFIER_MOTION_NONE)

-- =====================================================================
-- L10 (special_bonus_unique_nevermore_presence_amp_creep_4): −{value} брони
-- ДОПОЛНИТЕЛЬНО к Presence of the Dark Lord, но только не-героям (крипы,
-- нейтралы, саммоны). Реализовано как отдельная аура на SF с фильтром
-- DOTA_UNIT_TARGET_BASIC: ваниль-аура `modifier_nevermore_presence_aura`
-- продолжает работать как есть на всех (включая героев); наш дебаф
-- `modifier_nevermore_presence_amp_creep_debuff` висит отдельной иконкой
-- только на не-героях и даёт флэт −value брони. Видно, понятно, не лезет
-- в чужой KV. Тултип таланта: `+{s:value}` — совпадает с тем, что висит
-- на цели.
-- =====================================================================
modifier_nevermore_presence_amp = class({})

function modifier_nevermore_presence_amp:IsHidden() return true end
function modifier_nevermore_presence_amp:IsPurgable() return false end
function modifier_nevermore_presence_amp:RemoveOnDeath() return false end
function modifier_nevermore_presence_amp:IsAura() return true end

function modifier_nevermore_presence_amp:GetAuraRadius()
    local caster = self:GetParent()
    if caster and not caster:IsNull() then
        local dark_lord = caster:FindAbilityByName("nevermore_dark_lord")
        if dark_lord and not dark_lord:IsNull() then
            local r = dark_lord:GetSpecialValueFor("presence_radius")
            if r and r > 0 then return r end
        end
    end
    return 1200
end

function modifier_nevermore_presence_amp:GetAuraSearchTeam()  return DOTA_UNIT_TARGET_TEAM_ENEMY end
function modifier_nevermore_presence_amp:GetAuraSearchType()  return DOTA_UNIT_TARGET_BASIC end
function modifier_nevermore_presence_amp:GetAuraSearchFlags() return DOTA_UNIT_TARGET_FLAG_MAGIC_IMMUNE_ENEMIES end
function modifier_nevermore_presence_amp:GetModifierAura()    return "modifier_nevermore_presence_amp_debuff" end


modifier_nevermore_presence_amp_debuff = class({})

function modifier_nevermore_presence_amp_debuff:IsHidden()    return false end
function modifier_nevermore_presence_amp_debuff:IsDebuff()    return true end
function modifier_nevermore_presence_amp_debuff:IsPurgable()  return false end

function modifier_nevermore_presence_amp_debuff:DeclareFunctions()
    return { MODIFIER_PROPERTY_PHYSICAL_ARMOR_BONUS }
end

function modifier_nevermore_presence_amp_debuff:GetModifierPhysicalArmorBonus()
    local talent = self:GetAbility()
    if not talent or talent:IsNull() then return 0 end
    local v = talent:GetSpecialValueFor("value") or 0
    return -v
end

function modifier_nevermore_presence_amp_debuff:GetTexture()
    return "nevermore_dark_lord"
end