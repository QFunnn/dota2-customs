--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_item_ghost", "items/item_ghost.lua", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_item_ghost_active", "items/item_ghost.lua", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_item_crellas_crozier", "items/item_ghost.lua", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_item_crellas_crozier_aura_debuff", "items/item_ghost.lua", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_item_crellas_crozier_active_state", "items/item_ghost.lua", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_item_crellas_crozier_active_aura_debuff", "items/item_ghost.lua", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_item_crellas_crozier_ms_slow", "items/item_ghost.lua", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_item_crellas_crozier_ms_steal", "items/item_ghost.lua", LUA_MODIFIER_MOTION_NONE)

item_ghost_custom = class({})

function item_ghost_custom:GetIntrinsicModifierName()
    return "modifier_item_ghost"
end

function item_ghost_custom:OnSpellStart()
    if not IsServer() then return end
    self:GetCaster():EmitSound("DOTA_Item.GhostScepter.Activate")
    local duration = self:GetSpecialValueFor("duration")
    self:GetCaster():AddNewModifier(self:GetCaster(), self, "modifier_item_ghost_active", {duration = duration})
end

modifier_item_ghost = class({})

function modifier_item_ghost:IsHidden()       return true end
function modifier_item_ghost:IsPurgable()     return false end
function modifier_item_ghost:RemoveOnDeath()  return false end

function modifier_item_ghost:DeclareFunctions()
    return {
        MODIFIER_PROPERTY_STATS_STRENGTH_BONUS,
        MODIFIER_PROPERTY_STATS_AGILITY_BONUS,
        MODIFIER_PROPERTY_STATS_INTELLECT_BONUS,
    }
end

function modifier_item_ghost:GetModifierBonusStats_Strength()
    if self:GetAbility() then
        return self:GetAbility():GetSpecialValueFor("bonus_all_stats")
    end
end

function modifier_item_ghost:GetModifierBonusStats_Agility()
    if self:GetAbility() then
        return self:GetAbility():GetSpecialValueFor("bonus_all_stats")
    end
end

function modifier_item_ghost:GetModifierBonusStats_Intellect()
    if self:GetAbility() then
        return self:GetAbility():GetSpecialValueFor("bonus_all_stats")
    end
end

modifier_item_ghost_active = class({})

function modifier_item_ghost_active:IsPurgable() return true end
function modifier_item_ghost_active:IsPurgeException() return true end

function modifier_item_ghost_active:GetStatusEffectName()
    return "particles/status_fx/status_effect_ghost.vpcf"
end

function modifier_item_ghost_active:OnCreated()
    self.ability                    = self:GetAbility()
    self.caster                     = self:GetCaster()
    self.parent                     = self:GetParent()
    self.extra_spell_damage_percent      = self.ability:GetSpecialValueFor("extra_spell_damage_percent")
end

function modifier_item_ghost_active:OnRefresh()
    self:OnCreated()
end

function modifier_item_ghost_active:CheckState()
    local state = {
        [MODIFIER_STATE_ATTACK_IMMUNE] = true,
        [MODIFIER_STATE_DISARMED] = true
    }
    
    return state
end

function modifier_item_ghost_active:DeclareFunctions()
    local decFuncs = {
        MODIFIER_PROPERTY_MAGICAL_RESISTANCE_DECREPIFY_UNIQUE,
        MODIFIER_PROPERTY_ABSOLUTE_NO_DAMAGE_PHYSICAL,
    }
    
    return decFuncs
end

function modifier_item_ghost_active:GetModifierMagicalResistanceDecrepifyUnique()
    return self.extra_spell_damage_percent
end

function modifier_item_ghost_active:GetAbsoluteNoDamagePhysical()
    return 1
end

--//////////////////////////////////////////////////////////////////////////////
-- Crella's Crozier — использует наш кастомный modifier_item_ghost_active
--//////////////////////////////////////////////////////////////////////////////

item_crellas_crozier = class({})

function item_crellas_crozier:GetIntrinsicModifierName()
    return "modifier_item_crellas_crozier"
end

function item_crellas_crozier:GetAOERadius()
    return self:GetSpecialValueFor("aura_radius")
end

function item_crellas_crozier:OnSpellStart()
    if not IsServer() then return end
    local caster = self:GetCaster()
    caster:EmitSound("DOTA_Item.GhostScepter.Activate")
    local duration = self:GetSpecialValueFor("duration")
    caster:AddNewModifier(caster, self, "modifier_item_ghost_active", {duration = duration})
    caster:AddNewModifier(caster, self, "modifier_item_crellas_crozier_active_state", {duration = duration})
end

modifier_item_crellas_crozier = class({})

function modifier_item_crellas_crozier:IsHidden()      return true end
function modifier_item_crellas_crozier:IsPurgable()    return false end
function modifier_item_crellas_crozier:RemoveOnDeath() return false end

function modifier_item_crellas_crozier:DeclareFunctions()
    return {
        MODIFIER_PROPERTY_STATS_STRENGTH_BONUS,
        MODIFIER_PROPERTY_STATS_AGILITY_BONUS,
        MODIFIER_PROPERTY_STATS_INTELLECT_BONUS,
        MODIFIER_PROPERTY_HEALTH_BONUS,
        MODIFIER_PROPERTY_MANA_BONUS,
    }
end

function modifier_item_crellas_crozier:GetModifierBonusStats_Strength()
    if self:GetAbility() then return self:GetAbility():GetSpecialValueFor("bonus_strength") end
    return 0
end

function modifier_item_crellas_crozier:GetModifierBonusStats_Agility()
    if self:GetAbility() then return self:GetAbility():GetSpecialValueFor("bonus_agility") end
    return 0
end

function modifier_item_crellas_crozier:GetModifierBonusStats_Intellect()
    if self:GetAbility() then return self:GetAbility():GetSpecialValueFor("bonus_intellect") end
    return 0
end

function modifier_item_crellas_crozier:GetModifierHealthBonus()
    if self:GetAbility() then return self:GetAbility():GetSpecialValueFor("bonus_health") end
    return 0
end

function modifier_item_crellas_crozier:GetModifierManaBonus()
    if self:GetAbility() then return self:GetAbility():GetSpecialValueFor("bonus_mana") end
    return 0
end

-- Putrefaction Aura — аура-эмиттер на владельце предмета
function modifier_item_crellas_crozier:IsAura() return true end
function modifier_item_crellas_crozier:GetModifierAura() return "modifier_item_crellas_crozier_aura_debuff" end
function modifier_item_crellas_crozier:GetAuraRadius()
    if self:GetAbility() then return self:GetAbility():GetSpecialValueFor("aura_radius") end
    return 900
end
function modifier_item_crellas_crozier:GetAuraDuration() return 0.5 end
function modifier_item_crellas_crozier:GetAuraSearchFlags() return DOTA_UNIT_TARGET_FLAG_NONE end
function modifier_item_crellas_crozier:GetAuraSearchTeam() return DOTA_UNIT_TARGET_TEAM_ENEMY end
function modifier_item_crellas_crozier:GetAuraSearchType() return DOTA_UNIT_TARGET_HERO end

--//////////////////////////////////////////////////////////////////////////////
-- Putrefaction Aura debuff — применяется к вражеским героям в радиусе
--//////////////////////////////////////////////////////////////////////////////

modifier_item_crellas_crozier_aura_debuff = class({})

function modifier_item_crellas_crozier_aura_debuff:IsHidden()   return false end
function modifier_item_crellas_crozier_aura_debuff:IsPurgable() return false end
function modifier_item_crellas_crozier_aura_debuff:IsDebuff()   return true end

function modifier_item_crellas_crozier_aura_debuff:DeclareFunctions()
    return {
        MODIFIER_PROPERTY_HP_REGEN_AMPLIFY_PERCENTAGE,
        MODIFIER_PROPERTY_HEAL_AMPLIFY_PERCENTAGE_TARGET,
    }
end

function modifier_item_crellas_crozier_aura_debuff:_GetReduction()
    local ability = self:GetAbility()
    if not ability or ability:IsNull() then return 0 end
    return ability:GetSpecialValueFor("passive_health_restore_reduction")
end

function modifier_item_crellas_crozier_aura_debuff:GetModifierHPRegenAmplify_Percentage()
    return -self:_GetReduction()
end

function modifier_item_crellas_crozier_aura_debuff:GetModifierHealAmplify_PercentageTarget()
    return -self:_GetReduction()
end

--//////////////////////////////////////////////////////////////////////////////
-- Активное состояние Crella's Crozier — маркер + тикер воровства скорости
--//////////////////////////////////////////////////////////////////////////////

modifier_item_crellas_crozier_active_state = class({})

function modifier_item_crellas_crozier_active_state:IsHidden()   return true end
function modifier_item_crellas_crozier_active_state:IsPurgable() return false end

-- Дельта-аура: добавляет ещё -(75-30)=-45% health restoration поверх пассивной ауры
function modifier_item_crellas_crozier_active_state:IsAura() return true end
function modifier_item_crellas_crozier_active_state:GetModifierAura() return "modifier_item_crellas_crozier_active_aura_debuff" end
function modifier_item_crellas_crozier_active_state:GetAuraRadius()
    if self:GetAbility() then return self:GetAbility():GetSpecialValueFor("aura_radius") end
    return 900
end
function modifier_item_crellas_crozier_active_state:GetAuraDuration() return 0.5 end
function modifier_item_crellas_crozier_active_state:GetAuraSearchFlags() return DOTA_UNIT_TARGET_FLAG_NONE end
function modifier_item_crellas_crozier_active_state:GetAuraSearchTeam() return DOTA_UNIT_TARGET_TEAM_ENEMY end
function modifier_item_crellas_crozier_active_state:GetAuraSearchType() return DOTA_UNIT_TARGET_HERO end

function modifier_item_crellas_crozier_active_state:OnCreated()
    if not IsServer() then return end
    self:StartIntervalThink(1.0)
    self:OnIntervalThink()
end

function modifier_item_crellas_crozier_active_state:OnIntervalThink()
    if not IsServer() then return end
    local caster = self:GetParent()
    local ability = self:GetAbility()
    if not caster or caster:IsNull() then return end
    if not ability or ability:IsNull() then return end

    local radius = ability:GetSpecialValueFor("aura_radius")
    local steal_duration = ability:GetSpecialValueFor("move_speed_steal_duration")

    local enemies = FindUnitsInRadius(
        caster:GetTeamNumber(), caster:GetAbsOrigin(), nil, radius,
        DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_HERO,
        DOTA_UNIT_TARGET_FLAG_NONE, FIND_ANY_ORDER, false
    )

    local stacks = 0
    for _, enemy in pairs(enemies) do
        if enemy and not enemy:IsNull() then
            enemy:AddNewModifier(caster, ability, "modifier_item_crellas_crozier_ms_slow", {duration = steal_duration})
            stacks = stacks + 1
        end
    end

    for s = 1, stacks do
        caster:AddNewModifier(caster, ability, "modifier_item_crellas_crozier_ms_steal", {duration = steal_duration})
    end
end

--//////////////////////////////////////////////////////////////////////////////
-- Дельта-дебафф активки Crella's Crozier — скрытый, складывается с пассивным
--//////////////////////////////////////////////////////////////////////////////

modifier_item_crellas_crozier_active_aura_debuff = class({})

function modifier_item_crellas_crozier_active_aura_debuff:IsHidden()   return true end
function modifier_item_crellas_crozier_active_aura_debuff:IsPurgable() return false end
function modifier_item_crellas_crozier_active_aura_debuff:IsDebuff()   return true end

function modifier_item_crellas_crozier_active_aura_debuff:DeclareFunctions()
    return {
        MODIFIER_PROPERTY_HP_REGEN_AMPLIFY_PERCENTAGE,
        MODIFIER_PROPERTY_HEAL_AMPLIFY_PERCENTAGE_TARGET,
    }
end

function modifier_item_crellas_crozier_active_aura_debuff:_GetDelta()
    local ability = self:GetAbility()
    if not ability or ability:IsNull() then return 0 end
    local passive = ability:GetSpecialValueFor("passive_health_restore_reduction")
    local active  = ability:GetSpecialValueFor("active_health_restore_reduction")
    local delta   = active - passive
    if delta < 0 then delta = 0 end
    return delta
end

function modifier_item_crellas_crozier_active_aura_debuff:GetModifierHPRegenAmplify_Percentage()
    return -self:_GetDelta()
end

function modifier_item_crellas_crozier_active_aura_debuff:GetModifierHealAmplify_PercentageTarget()
    return -self:_GetDelta()
end

--//////////////////////////////////////////////////////////////////////////////
-- Стакающийся слоу на врагах (−5% MS за стак, 1.5с)
--//////////////////////////////////////////////////////////////////////////////

modifier_item_crellas_crozier_ms_slow = class({})

function modifier_item_crellas_crozier_ms_slow:IsHidden()    return false end
function modifier_item_crellas_crozier_ms_slow:IsPurgable()  return true end
function modifier_item_crellas_crozier_ms_slow:IsDebuff()    return true end
function modifier_item_crellas_crozier_ms_slow:GetAttributes() return MODIFIER_ATTRIBUTE_MULTIPLE end

function modifier_item_crellas_crozier_ms_slow:DeclareFunctions()
    return { MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE }
end

function modifier_item_crellas_crozier_ms_slow:GetModifierMoveSpeedBonus_Percentage()
    if self:GetAbility() then return -self:GetAbility():GetSpecialValueFor("move_speed_steal") end
    return 0
end

--//////////////////////////////////////////////////////////////////////////////
-- Стакающийся бафф скорости на кастере (+5% MS за стак, 1.5с)
--//////////////////////////////////////////////////////////////////////////////

modifier_item_crellas_crozier_ms_steal = class({})

function modifier_item_crellas_crozier_ms_steal:IsHidden()    return false end
function modifier_item_crellas_crozier_ms_steal:IsPurgable()  return false end
function modifier_item_crellas_crozier_ms_steal:GetAttributes() return MODIFIER_ATTRIBUTE_MULTIPLE end

function modifier_item_crellas_crozier_ms_steal:DeclareFunctions()
    return { MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE }
end

function modifier_item_crellas_crozier_ms_steal:GetModifierMoveSpeedBonus_Percentage()
    if self:GetAbility() then return self:GetAbility():GetSpecialValueFor("move_speed_steal") end
    return 0
end