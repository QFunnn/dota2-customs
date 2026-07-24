--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_item_echo_sabre_custom", "items/item_echo_sabre_custom", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_item_echo_sabre_custom_speed", "items/item_echo_sabre_custom", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_item_echo_sabre_custom_slow", "items/item_echo_sabre_custom", LUA_MODIFIER_MOTION_NONE)

item_echo_sabre_custom = class({})

function item_echo_sabre_custom:GetIntrinsicModifierName()
    return "modifier_item_echo_sabre_custom"
end

modifier_item_echo_sabre_custom = class({})
function modifier_item_echo_sabre_custom:IsHidden() return true end
function modifier_item_echo_sabre_custom:IsPurgable() return false end
function modifier_item_echo_sabre_custom:RemoveOnDeath() return false end
function modifier_item_echo_sabre_custom:GetAttributes() return MODIFIER_ATTRIBUTE_MULTIPLE end
function modifier_item_echo_sabre_custom:DeclareFunctions()
    return 
    {
        MODIFIER_PROPERTY_STATS_STRENGTH_BONUS,
        MODIFIER_PROPERTY_PREATTACK_BONUS_DAMAGE,
        MODIFIER_PROPERTY_MANA_REGEN_CONSTANT,
         
        MODIFIER_EVENT_ON_ATTACK_FAIL,
        MODIFIER_EVENT_ON_ATTACK,
    }
end

function modifier_item_echo_sabre_custom:StartSpeed(target, slow)
    if not IsServer() then return end
    if not self:GetParent():IsRealHero() then return end
    if self:GetParent():HasItemInInventory("item_harpoon") then return end
    if self:GetParent():HasModifier("modifier_monkey_king_wukongs_command_custom_soldier") then return end
    self:GetAbility():UseResources(false, false, false, true)
    self:GetParent():AddNewModifier(self:GetParent(), self:GetAbility(), "modifier_item_echo_sabre_custom_speed", {})
    for i = 0,8 do 
        local item = self:GetParent():GetItemInSlot(i)
        if item and item:GetName() == "item_echo_sabre_custom" then 
            item:UseResources(false, false, false, true)
        end
    end
    if self:GetAbility() and not target:IsBuilding() and not target:IsMagicImmune() and slow then 
        target:AddNewModifier(self:GetCaster(), self:GetAbility(), "modifier_item_echo_sabre_custom_slow", {duration = (1 - target:GetStatusResistance())*self:GetAbility():GetSpecialValueFor("slow_duration")})
    end
end

function modifier_item_echo_sabre_custom:OnAttackFail(params)
    if not IsServer() then return end
    if self:GetParent() ~= params.attacker then return end
    if params.attacker:FindAllModifiersByName(self:GetName())[1] ~= self then return end 
    if not self:GetAbility():IsFullyCastable() then return end
    if self:GetParent():IsRangedAttacker() and not self:GetParent():HasModifier("modifier_vengefulspirit_retribution") then return end
    if self:GetParent():HasItemInInventory("item_harpoon") then return end
    if self:GetParent():HasModifier("modifier_monkey_king_wukongs_command_custom_soldier") then return end
    self:StartSpeed(params.target, false)
end

function modifier_item_echo_sabre_custom:OnAttackLanded(params)
    if not IsServer() then return end
    if self:GetParent() ~= params.attacker then return end
    if params.attacker:FindAllModifiersByName(self:GetName())[1] ~= self then return end 
    if not self:GetAbility():IsFullyCastable() then return end
    if self:GetParent():IsRangedAttacker() then return end
    if self:GetParent():HasModifier("modifier_vengefulspirit_retribution") then return end
    if self:GetParent():HasItemInInventory("item_harpoon") then return end
    if self:GetParent():HasModifier("modifier_monkey_king_wukongs_command_custom_soldier") then return end
    self:StartSpeed(params.target, true)
end

function modifier_item_echo_sabre_custom:OnAttack(params)
    if not IsServer() then return end
    if self:GetParent() ~= params.attacker then return end
    if params.attacker:FindAllModifiersByName(self:GetName())[1] ~= self then return end 
    if not self:GetAbility():IsFullyCastable() then return end
    if not self:GetParent():HasModifier("modifier_vengefulspirit_retribution") then return end
    if self:GetParent():HasItemInInventory("item_harpoon") then return end
    if self:GetParent():HasModifier("modifier_monkey_king_wukongs_command_custom_soldier") then return end
    self:StartSpeed(params.target, true)    
end

function modifier_item_echo_sabre_custom:GetModifierConstantManaRegen()
    return self:GetAbility():GetSpecialValueFor("bonus_mana_regen")
end

function modifier_item_echo_sabre_custom:GetModifierPreAttack_BonusDamage()
    return self:GetAbility():GetSpecialValueFor("bonus_damage")
end

function modifier_item_echo_sabre_custom:GetModifierBonusStats_Strength()
    return self:GetAbility():GetSpecialValueFor("bonus_strength")
end

modifier_item_echo_sabre_custom_speed = class({})
function modifier_item_echo_sabre_custom_speed:IsHidden() return true end
function modifier_item_echo_sabre_custom_speed:IsPurgable() return false end
function modifier_item_echo_sabre_custom_speed:DeclareFunctions()
    return
    {
        MODIFIER_PROPERTY_ATTACKSPEED_BONUS_CONSTANT,
         
        MODIFIER_EVENT_ON_ATTACK_FAIL,
        MODIFIER_EVENT_ON_ATTACK
    }
end

function modifier_item_echo_sabre_custom_speed:GetModifierAttackSpeedBonus_Constant()
    if self:GetParent().jousting ~= nil then return end
    if self.is_attacked ~= nil then return end
    if IsClient() then return 0 end
    return 700
end

function modifier_item_echo_sabre_custom_speed:OnCreated(table)
    if not IsServer() then return end
    self.slow_duration = self:GetAbility():GetSpecialValueFor("slow_duration")
    self:StartIntervalThink(0.2)
end

function modifier_item_echo_sabre_custom_speed:OnAttack(params)
    if not IsServer() then return end
    if self:GetParent() ~= params.attacker then return end
    if self:GetParent():HasModifier("modifier_vengefulspirit_retribution") then
        self.is_attacked = true
    end
end

function modifier_item_echo_sabre_custom_speed:OnIntervalThink()
    if (self:GetParent():IsRangedAttacker() and not self:GetParent():HasModifier("modifier_vengefulspirit_retribution")) or not self:GetAbility() then 
        self:Destroy()
    end
end

function modifier_item_echo_sabre_custom_speed:OnAttackLanded(params)
    if not IsServer() then return end
    if self:GetParent() ~= params.attacker then return end
    if self:GetParent():IsRangedAttacker() and not self:GetParent():HasModifier("modifier_vengefulspirit_retribution") then return end
    if self:GetAbility() and not params.target:IsBuilding() then 
        params.target:AddNewModifier(self:GetCaster(), self:GetAbility(), "modifier_item_echo_sabre_custom_slow", {duration = (1 - params.target:GetStatusResistance())*self.slow_duration})
    end
    self:Destroy()
end

function modifier_item_echo_sabre_custom_speed:OnAttackFail(params)
    if not IsServer() then return end
    if self:GetParent() ~= params.attacker then return end
    if self:GetParent():IsRangedAttacker() and not self:GetParent():HasModifier("modifier_vengefulspirit_retribution") then return end
    self:Destroy()
end

modifier_item_echo_sabre_custom_slow = class({})
function modifier_item_echo_sabre_custom_slow:IsHidden() return false end
function modifier_item_echo_sabre_custom_slow:IsPurgable() return true end
function modifier_item_echo_sabre_custom_slow:DeclareFunctions()
    return
    {
        MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE
    }
end

function modifier_item_echo_sabre_custom_slow:GetModifierMoveSpeedBonus_Percentage()
    return -100
end