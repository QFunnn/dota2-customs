--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_item_echo_slayer", "items/item_echo_slayer", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_item_echo_slayer_speed", "items/item_echo_slayer", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_item_echo_slayer_slow", "items/item_echo_slayer", LUA_MODIFIER_MOTION_NONE)

item_echo_slayer = class({})

function item_echo_slayer:GetIntrinsicModifierName()
    return "modifier_item_echo_slayer"
end

modifier_item_echo_slayer = class({})

function modifier_item_echo_slayer:IsHidden()      return true end
function modifier_item_echo_slayer:IsPurgable() return false end
function modifier_item_echo_slayer:IsPurgeException() return false end
function modifier_item_echo_slayer:RemoveOnDeath() return false end
function modifier_item_echo_slayer:GetAttributes() return MODIFIER_ATTRIBUTE_MULTIPLE end

function modifier_item_echo_slayer:DeclareFunctions()
    return {
        MODIFIER_PROPERTY_STATS_INTELLECT_BONUS,
        MODIFIER_PROPERTY_STATS_STRENGTH_BONUS,
        MODIFIER_PROPERTY_PREATTACK_BONUS_DAMAGE,
        MODIFIER_PROPERTY_ATTACKSPEED_BONUS_CONSTANT,
        MODIFIER_PROPERTY_MANA_REGEN_CONSTANT,
         
        MODIFIER_EVENT_ON_ATTACK_FAIL,
        MODIFIER_PROPERTY_MAGICAL_RESISTANCE_BONUS
    }
end

function modifier_item_echo_slayer:StartSpeed(target, slow)
    if not IsServer() then return end
    if not self:GetParent():IsRealHero() then return end

    if self:GetParent():FindAllModifiersByName("modifier_item_echo_slayer")[1] ~= self then return end

    self:GetParent():AddNewModifier(self:GetParent(), self:GetAbility(), "modifier_item_echo_slayer_speed", {})
    self:GetAbility():UseResources(false, false, false, true)
    
    for i = 0,8 do 
        local item = self:GetParent():GetItemInSlot(i)
        if item and item:GetName() == "item_echo_sabre_custom" then 
            item:StartCooldown(6*self:GetParent():GetCooldownReduction())
        end
    end

    if self:GetAbility() and not target:IsBuilding() and not target:IsMagicImmune() and slow then 
        target:AddNewModifier(self:GetCaster(), self:GetAbility(), "modifier_item_echo_slayer_slow", {duration = self:GetAbility():GetSpecialValueFor("slow_duration") * (1 - target:GetStatusResistance())})
    end
end

function modifier_item_echo_slayer:OnAttackFail(params)
    if not IsServer() then return end
    if self:GetParent() ~= params.attacker then return end
    if params.attacker:FindAllModifiersByName(self:GetName())[1] ~= self then return end 
    if not self:GetAbility():IsFullyCastable() then return end
    if self:GetParent():IsRangedAttacker() and not self:GetParent():HasModifier("modifier_vengefulspirit_retribution") then return end
    self:StartSpeed(params.target, false)
end

function modifier_item_echo_slayer:OnAttackLanded(params)
    if not IsServer() then return end
    if self:GetParent() ~= params.attacker then return end
    if not self:GetParent():IsIllusion() then
        params.target:AddNewModifier(self:GetParent(), self:GetAbility(), "modifier_item_mage_slayer_debuff", {duration = (1 - params.target:GetStatusResistance())*self:GetAbility():GetSpecialValueFor("mage_slayer_duration")})
    end
    if params.attacker:FindAllModifiersByName(self:GetName())[1] ~= self then return end 
    if not self:GetAbility():IsFullyCastable() then return end
    if self:GetParent():IsRangedAttacker() and not self:GetParent():HasModifier("modifier_vengefulspirit_retribution") then return end
    self:StartSpeed(params.target, true)
end

function modifier_item_echo_slayer:GetModifierBonusStats_Intellect()
    return self:GetAbility():GetSpecialValueFor("bonus_intellect")
end

function modifier_item_echo_slayer:GetModifierConstantManaRegen()
    return self:GetAbility():GetSpecialValueFor("bonus_mana_regen")
end

function modifier_item_echo_slayer:GetModifierAttackSpeedBonus_Constant()
    return self:GetAbility():GetSpecialValueFor("bonus_attack_speed")
end

function modifier_item_echo_slayer:GetModifierPreAttack_BonusDamage()
    return self:GetAbility():GetSpecialValueFor("bonus_damage")
end

function modifier_item_echo_slayer:GetModifierBonusStats_Strength()
    return self:GetAbility():GetSpecialValueFor("bonus_strength")
end

function modifier_item_echo_slayer:GetModifierMagicalResistanceBonus()
    return self:GetAbility():GetSpecialValueFor("bonus_magical_resistance")
end

modifier_item_echo_slayer_speed = class({})

function modifier_item_echo_slayer_speed:IsHidden() return true end
function modifier_item_echo_slayer_speed:IsPurgable() return false end

function modifier_item_echo_slayer_speed:DeclareFunctions()
    return
    {
        MODIFIER_PROPERTY_ATTACKSPEED_BONUS_CONSTANT,
         
        MODIFIER_EVENT_ON_ATTACK_FAIL,
        MODIFIER_EVENT_ON_ATTACK
    }
end

function modifier_item_echo_slayer_speed:GetModifierAttackSpeedBonus_Constant()
    if self:GetParent().jousting ~= nil then return end
    if self.is_attacked ~= nil then return end
    if IsClient() then return 0 end
    return 700
end

function modifier_item_echo_slayer_speed:OnCreated(table)
    if not IsServer() then return end
    self:StartIntervalThink(0.2)
end

function modifier_item_echo_slayer_speed:OnIntervalThink()
    if (self:GetParent():IsRangedAttacker() and not self:GetParent():HasModifier("modifier_vengefulspirit_retribution")) or not self:GetAbility() then 
        self:Destroy()
    end
end

function modifier_item_echo_slayer_speed:OnAttack(params)
    if not IsServer() then return end
    if self:GetParent() ~= params.attacker then return end
    if self:GetParent():HasModifier("modifier_vengefulspirit_retribution") then
        self.is_attacked = true
    end
end

function modifier_item_echo_slayer_speed:OnAttackLanded(params)
    if not IsServer() then return end
    if self:GetParent() ~= params.attacker then return end
    if self:GetParent():IsRangedAttacker() and not self:GetParent():HasModifier("modifier_vengefulspirit_retribution") then return end

    if self:GetAbility() and not params.target:IsBuilding() and not params.target:IsMagicImmune() then 
        params.target:AddNewModifier(self:GetCaster(), self:GetAbility(), "modifier_item_echo_slayer_slow", {duration = self:GetAbility():GetSpecialValueFor("slow_duration") * (1 - params.target:GetStatusResistance())})
    end

    self:Destroy()
end

function modifier_item_echo_slayer_speed:OnAttackFail(params)
    if not IsServer() then return end
    if self:GetParent() ~= params.attacker then return end
    if self:GetParent():IsRangedAttacker() and not self:GetParent():HasModifier("modifier_vengefulspirit_retribution") then return end
    self:Destroy()
end

modifier_item_echo_slayer_slow = class({})

function modifier_item_echo_slayer_slow:IsHidden() return false end
function modifier_item_echo_slayer_slow:IsPurgable() return true end

function modifier_item_echo_slayer_slow:DeclareFunctions()
    return
    {
        MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE
    }
end

function modifier_item_echo_slayer_slow:GetModifierMoveSpeedBonus_Percentage()
    return self:GetAbility():GetSpecialValueFor("movement_slow")
end
