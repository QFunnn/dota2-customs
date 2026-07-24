--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_item_gods_locket", "items/item_gods_locket", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_item_gods_locket_aura", "items/item_gods_locket", LUA_MODIFIER_MOTION_NONE)

item_gods_locket = class({})

function item_gods_locket:GetIntrinsicModifierName() 
    return "modifier_item_gods_locket"
end

function item_gods_locket:OnAbilityPhaseStart() 
    if not IsServer() then return end
    if self:GetCurrentCharges() <= 0 then
        return false
    end
    return true
end

function item_gods_locket:OnSpellStart() 
    if not IsServer() then return end

    local target = self:GetCursorTarget()

    local bonus_charge = self:GetSpecialValueFor("heal_increase")

    local bonus_mana = self:GetCurrentCharges() * (self:GetCaster():GetMaxMana() / 100 * bonus_charge)
    local bonus_heal = self:GetCurrentCharges() * (self:GetCaster():GetMaxHealth() / 100 * bonus_charge)

    target:Heal(bonus_heal, self)
    target:GiveMana(bonus_mana)

    self:SetCurrentCharges(0)

    self:GetCaster():EmitSound("DOTA_Item.MagicWand.Activate")

    local particle = ParticleManager:CreateParticle("particles/items3_fx/fish_bones_active.vpcf", PATTACH_ABSORIGIN_FOLLOW, target)
    ParticleManager:SetParticleControl( particle, 0, target:GetAbsOrigin() )
end

modifier_item_gods_locket = class({})

function modifier_item_gods_locket:IsHidden()
    return true
end

function modifier_item_gods_locket:IsPurgable() return false end
function modifier_item_gods_locket:IsPurgeException() return false end

function modifier_item_gods_locket:OnCreated()
    if not IsServer() then return end
    self:StartIntervalThink(self:GetAbility():GetSpecialValueFor("charge_gain_timer"))
end

function modifier_item_gods_locket:OnIntervalThink()
    if not IsServer() then return end
    if self:GetAbility():GetCurrentCharges() < self:GetAbility():GetSpecialValueFor("max_charges") then
        self:GetAbility():SetCurrentCharges(self:GetAbility():GetCurrentCharges() + 1)
        if self:GetAbility():GetCurrentCharges() > self:GetAbility():GetSpecialValueFor("max_charges") then
            self:GetAbility():SetCurrentCharges(self:GetAbility():GetSpecialValueFor("max_charges"))
        end
    end
end

function modifier_item_gods_locket:DeclareFunctions()
    return  
    {
        MODIFIER_PROPERTY_STATS_STRENGTH_BONUS,
        MODIFIER_PROPERTY_STATS_INTELLECT_BONUS,
        MODIFIER_PROPERTY_STATS_AGILITY_BONUS,
        MODIFIER_PROPERTY_HEALTH_BONUS,
        MODIFIER_PROPERTY_MANA_BONUS,
        MODIFIER_PROPERTY_HEALTH_REGEN_CONSTANT,
        MODIFIER_PROPERTY_HEAL_AMPLIFY_PERCENTAGE_SOURCE 
    }
end

function modifier_item_gods_locket:GetModifierHealAmplify_PercentageSource()
    if self:GetAbility() then
        return self:GetAbility():GetSpecialValueFor("amplify_heal")
    end
end

function modifier_item_gods_locket:GetModifierConstantHealthRegen()
    if self:GetAbility() then
        return self:GetAbility():GetSpecialValueFor('health_regen')
    end
end

function modifier_item_gods_locket:GetModifierHealthBonus()
    if self:GetAbility() then
        return self:GetAbility():GetSpecialValueFor('bonus_health')
    end
end

function modifier_item_gods_locket:GetModifierManaBonus()
    if self:GetAbility() then
        return self:GetAbility():GetSpecialValueFor('bonus_health')
    end
end

function modifier_item_gods_locket:GetModifierBonusStats_Strength()
    if self:GetAbility() then
        return self:GetAbility():GetSpecialValueFor('bonus_all_stats')
    end
end

function modifier_item_gods_locket:GetModifierBonusStats_Agility()
    if self:GetAbility() then
        return self:GetAbility():GetSpecialValueFor('bonus_all_stats')
    end
end

function modifier_item_gods_locket:GetModifierBonusStats_Intellect()
    if self:GetAbility() then
        return self:GetAbility():GetSpecialValueFor('bonus_all_stats')
    end
end

function modifier_item_gods_locket:IsAura()
    return true
end

function modifier_item_gods_locket:GetModifierAura()
    return "modifier_item_gods_locket_aura"
end

function modifier_item_gods_locket:GetAuraRadius()
    return self:GetAbility():GetSpecialValueFor("radius")
end

function modifier_item_gods_locket:GetAuraSearchTeam()
    return DOTA_UNIT_TARGET_TEAM_ENEMY
end

function modifier_item_gods_locket:GetAuraSearchType()
    return DOTA_UNIT_TARGET_HERO
end

function modifier_item_gods_locket:GetAuraSearchFlags()
    return DOTA_UNIT_TARGET_FLAG_MAGIC_IMMUNE_ENEMIES + DOTA_UNIT_TARGET_FLAG_INVULNERABLE + DOTA_UNIT_TARGET_FLAG_FOW_VISIBLE
end

modifier_item_gods_locket_aura = class({})

function modifier_item_gods_locket_aura:IsHidden()
    return true
end

function modifier_item_gods_locket_aura:IsPurgable()
    return false
end

function modifier_item_gods_locket_aura:DeclareFunctions()
    return  
    {
        MODIFIER_EVENT_ON_ABILITY_EXECUTED
    }
end

function modifier_item_gods_locket_aura:OnAbilityExecuted( params )
    if IsServer() then
        local hAbility = params.ability
        if hAbility == nil or not ( hAbility:GetCaster() == self:GetParent() ) then
            return 0
        end

        if hAbility:IsToggle() then
            return 0
        end

        if not hAbility:ProcsMagicStick() then
            return 0
        end

        if self:GetAbility():GetCurrentCharges() < self:GetAbility():GetSpecialValueFor("max_charges") then
            self:GetAbility():SetCurrentCharges(self:GetAbility():GetCurrentCharges() + 1)
            if self:GetAbility():GetCurrentCharges() > self:GetAbility():GetSpecialValueFor("max_charges") then
                self:GetAbility():SetCurrentCharges(self:GetAbility():GetSpecialValueFor("max_charges"))
            end
        end
    end    
end