--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_item_echo_spear", "items/item_echo_lance", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_item_echo_spear_speed", "items/item_echo_lance", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_item_echo_spear_slow", "items/item_echo_lance", LUA_MODIFIER_MOTION_NONE)

item_echo_lance = class({})

function item_echo_lance:GetIntrinsicModifierName()
    return "modifier_item_echo_spear"
end

modifier_item_echo_spear = class({})

function modifier_item_echo_spear:IsHidden()      return true end
function modifier_item_echo_spear:RemoveOnDeath() return false end
function modifier_item_echo_spear:IsPurgable() return false end
function modifier_item_echo_spear:IsPurgeException() return false end
function modifier_item_echo_spear:GetAttributes() return MODIFIER_ATTRIBUTE_MULTIPLE end

function modifier_item_echo_spear:DeclareFunctions()
    return {
        MODIFIER_PROPERTY_HEALTH_BONUS,
        MODIFIER_PROPERTY_STATS_INTELLECT_BONUS,
        MODIFIER_PROPERTY_STATS_STRENGTH_BONUS,
        MODIFIER_PROPERTY_PREATTACK_BONUS_DAMAGE,
        MODIFIER_PROPERTY_ATTACKSPEED_BONUS_CONSTANT,
        MODIFIER_PROPERTY_MANA_REGEN_CONSTANT,
        MODIFIER_EVENT_ON_ATTACK,
        MODIFIER_EVENT_ON_ATTACK_FAIL,
        MODIFIER_PROPERTY_STATS_AGILITY_BONUS,
        MODIFIER_PROPERTY_ATTACK_RANGE_BONUS_UNIQUE  
    }
end

function modifier_item_echo_spear:StartSpeed(target, slow)
    if not IsServer() then return end
    if not self:GetParent():IsRealHero() then return end
    if self:GetParent():FindAllModifiersByName("modifier_item_echo_spear")[1] ~= self then return end

    self:GetParent():AddNewModifier(self:GetParent(), self:GetAbility(), "modifier_item_echo_spear_speed", {})
    self:GetAbility():UseResources(false, false, false, true)

    for i = 0,8 do 
        local item = self:GetParent():GetItemInSlot(i)
        if item and item:GetName() == "item_echo_lance" then 
            item:StartCooldown(6*self:GetParent():GetCooldownReduction())
        end
    end

    if self:GetAbility() and not target:IsBuilding() and not target:IsMagicImmune() and slow then 
        target:AddNewModifier(self:GetCaster(), self:GetAbility(), "modifier_item_echo_spear_slow", {duration = self:GetAbility():GetSpecialValueFor("slow_duration") * (1 - target:GetStatusResistance())})
    end
end

function modifier_item_echo_spear:OnAttackFail(params)
    if not IsServer() then return end
    if self:GetParent() ~= params.attacker then return end
    if params.attacker:FindAllModifiersByName(self:GetName())[1] ~= self then return end 
    if not self:GetAbility():IsFullyCastable() then return end
    if not self:GetParent():IsRangedAttacker() then return end
    self:StartSpeed(params.target, false)
end

function modifier_item_echo_spear:OnAttack(params)
    if not IsServer() then return end
    if self:GetParent() ~= params.attacker then return end
    if params.attacker:FindAllModifiersByName(self:GetName())[1] ~= self then return end 
    if not self:GetAbility():IsFullyCastable() then return end
    if not self:GetParent():IsRangedAttacker() then return end
    self:StartSpeed(params.target, true)
end

function modifier_item_echo_spear:GetModifierBonusStats_Agility()
    return self:GetAbility():GetSpecialValueFor("bonus_agility")
end

function modifier_item_echo_spear:GetModifierAttackRangeBonusUnique()
    if not self:GetParent():IsRangedAttacker() then return 0 end
    --if self:GetParent():FindAllModifiersByName("modifier_item_echo_spear")[1] ~= self then return end
    return self:GetAbility():GetSpecialValueFor("bonus_attack_range")
end

function modifier_item_echo_spear:GetModifierBonusStats_Intellect()
    return self:GetAbility():GetSpecialValueFor("bonus_intellect")
end

function modifier_item_echo_spear:GetModifierConstantManaRegen()
    return self:GetAbility():GetSpecialValueFor("bonus_mana_regen")
end

function modifier_item_echo_spear:GetModifierAttackSpeedBonus_Constant()
    return self:GetAbility():GetSpecialValueFor("bonus_attack_speed")
end

function modifier_item_echo_spear:GetModifierPreAttack_BonusDamage()
    return self:GetAbility():GetSpecialValueFor("bonus_damage")
end

function modifier_item_echo_spear:GetModifierBonusStats_Strength()
    return self:GetAbility():GetSpecialValueFor("bonus_strength")
end

modifier_item_echo_spear_speed = class({})

function modifier_item_echo_spear_speed:IsHidden() return true end
function modifier_item_echo_spear_speed:IsPurgable() return false end

function modifier_item_echo_spear_speed:DeclareFunctions()
    return
    {
        MODIFIER_PROPERTY_ATTACKSPEED_BONUS_CONSTANT,
        MODIFIER_EVENT_ON_ATTACK,
        MODIFIER_EVENT_ON_ATTACK_FAIL
    }
end

function modifier_item_echo_spear_speed:GetModifierAttackSpeedBonus_Constant()
    return 500
end

function modifier_item_echo_spear_speed:OnCreated(table)
    if not IsServer() then return end
    self:StartIntervalThink(0.2)
end

function modifier_item_echo_spear_speed:OnIntervalThink()
    if not self:GetParent():IsRangedAttacker() or not self:GetAbility() then 
        self:Destroy()
    end
end

function modifier_item_echo_spear_speed:OnAttack(params)
    if not IsServer() then return end
    if self:GetParent() ~= params.attacker then return end
    if not self:GetParent():IsRangedAttacker() then return end

    if self:GetAbility() and not params.target:IsBuilding() and not params.target:IsMagicImmune() then 
        params.target:AddNewModifier(self:GetCaster(), self:GetAbility(), "modifier_item_echo_spear_slow", {duration = self:GetAbility():GetSpecialValueFor("slow_duration") * (1 - params.target:GetStatusResistance())})
    end

    self:Destroy()
end

function modifier_item_echo_spear_speed:OnAttackFail(params)
    if not IsServer() then return end
    if self:GetParent() ~= params.attacker then return end
    if not self:GetParent():IsRangedAttacker() then return end
    self:Destroy()
end

modifier_item_echo_spear_slow = class({})

function modifier_item_echo_spear_slow:IsHidden() return false end
function modifier_item_echo_spear_slow:IsPurgable() return true end

function modifier_item_echo_spear_slow:DeclareFunctions()
    return
    {
        MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE
    }
end

function modifier_item_echo_spear_slow:GetModifierMoveSpeedBonus_Percentage()
    return self:GetAbility():GetSpecialValueFor("movement_slow")
end
