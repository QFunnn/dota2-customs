--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_omniknight_martyr", "abilities/omniknight_martyr", LUA_MODIFIER_MOTION_NONE)

omniknight_martyr = class({})

function omniknight_martyr:OnSpellStart()
    if not IsServer() then return end
    
    local caster = self:GetCaster()
    local duration = self:GetSpecialValueFor("duration")
    
    -- Сначала развеиваем все дебаффы
    caster:Purge(false, true, false, false, false)
    
    -- Применяем модификатор Repel на кастера
    caster:AddNewModifier(caster, self, "modifier_omniknight_martyr", {duration = duration})
    
    -- Эффекты
    caster:EmitSound("Hero_Omniknight.Repel")
end

-- Модификатор Repel (Heavenly Grace)
modifier_omniknight_martyr = class({})

function modifier_omniknight_martyr:IsDebuff()
    return false
end

function modifier_omniknight_martyr:IsPurgable()
    return false
end

function modifier_omniknight_martyr:GetTexture()
    return "omniknight_repel"
end

function modifier_omniknight_martyr:GetEffectName()
    return "particles/units/heroes/hero_omniknight/omniknight_repel_buff.vpcf"
end

function modifier_omniknight_martyr:GetEffectAttachType()
    return PATTACH_ABSORIGIN_FOLLOW
end

function modifier_omniknight_martyr:OnCreated()
    if not IsServer() then return end
    self:StartIntervalThink(0.1)
end

function modifier_omniknight_martyr:OnDestroy()
    if not IsServer() then return end
    -- Принудительно очищаем все эффекты при уничтожении модификатора
    local parent = self:GetParent()
    if parent and IsValidEntity(parent) then
        parent:StopSound("Hero_Omniknight.Repel")
    end
end

function modifier_omniknight_martyr:OnIntervalThink()
    if not IsServer() then return end
    -- Обновляем бонусы каждые 0.1 секунды
    self:GetParent():CalculateStatBonus(true)
end

function modifier_omniknight_martyr:DeclareFunctions()
    return {
        MODIFIER_PROPERTY_MAGICAL_RESISTANCE_BONUS,
        MODIFIER_PROPERTY_STATS_STRENGTH_BONUS,
        MODIFIER_PROPERTY_HEALTH_REGEN_CONSTANT
    }
end

function modifier_omniknight_martyr:GetModifierMagicalResistanceBonus()
    return self:GetAbility():GetSpecialValueFor("magic_resistance")
end

function modifier_omniknight_martyr:GetModifierBonusStats_Strength()
    local base_strength = self:GetAbility():GetSpecialValueFor("base_bonus_strength")
    local bonus_per_debuff = self:GetAbility():GetSpecialValueFor("bonus_per_debuff")
    
    -- Считаем количество дебаффов на цели
    local debuff_count = 0
    local modifiers = self:GetParent():FindAllModifiers()
    for _, modifier in pairs(modifiers) do
        if modifier:IsDebuff() and not modifier:IsHidden() then
            debuff_count = debuff_count + 1
        end
    end
    
    return base_strength + (debuff_count * bonus_per_debuff)
end

function modifier_omniknight_martyr:GetModifierConstantHealthRegen()
    local base_regen = self:GetAbility():GetSpecialValueFor("base_health_regen")
    local bonus_per_debuff = self:GetAbility():GetSpecialValueFor("bonus_per_debuff")
    
    -- Считаем количество дебаффов на цели
    local debuff_count = 0
    local modifiers = self:GetParent():FindAllModifiers()
    for _, modifier in pairs(modifiers) do
        if modifier:IsDebuff() and not modifier:IsHidden() then
            debuff_count = debuff_count + 1
        end
    end
    
    return base_regen + (debuff_count * bonus_per_debuff)
end