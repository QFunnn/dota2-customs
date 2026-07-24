--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_hero_unique_modifier_elder_titan_natural_order_debuff", "modifiers/hero_unique/modifier_hero_unique_modifier_elder_titan_natural_order", LUA_MODIFIER_MOTION_NONE)

modifier_hero_unique_modifier_elder_titan_natural_order = class({})
function modifier_hero_unique_modifier_elder_titan_natural_order:IsHidden() return true end
function modifier_hero_unique_modifier_elder_titan_natural_order:IsPurgable() return false end
function modifier_hero_unique_modifier_elder_titan_natural_order:IsPurgeException() return false end
function modifier_hero_unique_modifier_elder_titan_natural_order:RemoveOnDeath() return false end

function modifier_hero_unique_modifier_elder_titan_natural_order:IsAura()
	-- Проверяем, не находится ли кастер под эффектом Break (истощение пассивных способностей)
	local caster = self:GetCaster()
	if caster:PassivesDisabled() then
		return false
	end
	return true
end

function modifier_hero_unique_modifier_elder_titan_natural_order:GetModifierAura()
	return "modifier_hero_unique_modifier_elder_titan_natural_order_debuff"
end

function modifier_hero_unique_modifier_elder_titan_natural_order:GetAuraRadius()
	return self:GetAbility():GetSpecialValueFor("radius")
end

function modifier_hero_unique_modifier_elder_titan_natural_order:GetAuraDuration()
	return 0.3
end

function modifier_hero_unique_modifier_elder_titan_natural_order:GetAuraSearchTeam()
	return DOTA_UNIT_TARGET_TEAM_ENEMY
end

function modifier_hero_unique_modifier_elder_titan_natural_order:GetAuraSearchType()
	return DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC
end

-- [NP-11] Natural Order не должен влиять на Roshan/Nian (ancient). Армор-ветка
-- (ванильная) их и так не трогает; здесь исключаем их из маг-резист ауры.
function modifier_hero_unique_modifier_elder_titan_natural_order:GetAuraSearchFlags()
	return DOTA_UNIT_TARGET_FLAG_NOT_ANCIENTS
end

modifier_hero_unique_modifier_elder_titan_natural_order_debuff = class({})

function modifier_hero_unique_modifier_elder_titan_natural_order_debuff:DeclareFunctions()
    return
    {
        MODIFIER_PROPERTY_MAGICAL_RESISTANCE_DIRECT_MODIFICATION
    }
end

function modifier_hero_unique_modifier_elder_titan_natural_order_debuff:GetModifierMagicalResistanceDirectModification()
    -- Проверяем, не находится ли кастер под эффектом Break
    local caster = self:GetCaster()
    if caster and caster:PassivesDisabled() then
        return 0
    end
    
    -- [NP-11] Roshan/Nian (ancient) не затрагиваются вообще
    if self:GetParent():IsAncient() then
        return 0
    end

    local magic_resistance = self:GetAbility():GetSpecialValueFor("magic_resistance_pct")

    -- Если цель - герой, эффект в 2 раза слабее
    if self:GetParent():IsRealHero() then
        magic_resistance = magic_resistance / 2
    end
    
    return magic_resistance * (-1)
end