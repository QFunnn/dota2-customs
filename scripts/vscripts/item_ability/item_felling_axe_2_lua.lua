--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_item_felling_axe_lua", "item_ability/item_felling_axe_2_lua.lua", LUA_MODIFIER_MOTION_NONE)
--Abilities
if item_felling_axe_2_lua == nil then
    item_felling_axe_2_lua = class({})
end
function item_felling_axe_2_lua:GetIntrinsicModifierName()
    return "modifier_item_felling_axe_lua"
end
---------------------------------------------------------------------
--Modifiers
if modifier_item_felling_axe_lua == nil then
    modifier_item_felling_axe_lua = class({})
end
function modifier_item_felling_axe_lua:IsHidden()
    return true
end
function modifier_item_felling_axe_lua:IsPurgable()
    return false
end
function modifier_item_felling_axe_lua:OnCreated(params)
    self.bonus_range_active = false
    self.bonus_armor = self:GetAbility():GetSpecialValueFor("bonus_armor")
    self.bonus_damage = self:GetAbility():GetSpecialValueFor("bonus_damage")
    self.hp_regen = self:GetAbility():GetSpecialValueFor("hp_regen")
    self.bonus_evasion = self:GetAbility():GetSpecialValueFor("bonus_evasion")
    self.bonus_attack_speed = self:GetAbility():GetSpecialValueFor("bonus_attack_speed")
    self.bonus_attack_range = self:GetAbility():GetSpecialValueFor("bonus_attack_range")
    self.neutral_bonus_dmg_pct = self:GetAbility():GetSpecialValueFor("neutral_bonus_dmg_pct")
    if IsServer() then
    end
end
function modifier_item_felling_axe_lua:OnRefresh(params)
    self.bonus_range_active = false
    self.bonus_armor = self:GetAbility():GetSpecialValueFor("bonus_armor")
    self.bonus_damage = self:GetAbility():GetSpecialValueFor("bonus_damage")
    self.hp_regen = self:GetAbility():GetSpecialValueFor("hp_regen")
    self.bonus_evasion = self:GetAbility():GetSpecialValueFor("bonus_evasion")
    self.bonus_attack_speed = self:GetAbility():GetSpecialValueFor("bonus_attack_speed")
    self.bonus_attack_range = self:GetAbility():GetSpecialValueFor("bonus_attack_range")
    self.neutral_bonus_dmg_pct = self:GetAbility():GetSpecialValueFor("neutral_bonus_dmg_pct")
    if IsServer() then
    end
end
function modifier_item_felling_axe_lua:OnDestroy()
    if IsServer() then
    end
end
function modifier_item_felling_axe_lua:DeclareFunctions()
    return {
        MODIFIER_PROPERTY_PHYSICAL_ARMOR_BONUS,
        MODIFIER_PROPERTY_PREATTACK_BONUS_DAMAGE,
        MODIFIER_PROPERTY_TOTALDAMAGEOUTGOING_PERCENTAGE,
        MODIFIER_PROPERTY_EVASION_CONSTANT,
        MODIFIER_PROPERTY_HEALTH_REGEN_CONSTANT,
        MODIFIER_PROPERTY_ATTACKSPEED_BONUS_CONSTANT,
        MODIFIER_PROPERTY_ATTACK_RANGE_BONUS,
        MODIFIER_EVENT_ON_ORDER,
        MODIFIER_EVENT_ON_ATTACK_START,
        MODIFIER_EVENT_ON_ATTACK_CANCELLED,
    }
end
function modifier_item_felling_axe_lua:RemoveOnDeath()
    return false
end
function modifier_item_felling_axe_lua:GetAttributes()
    return MODIFIER_ATTRIBUTE_MULTIPLE
end
function modifier_item_felling_axe_lua:GetModifierPhysicalArmorBonus()
    return self.bonus_armor
end
function modifier_item_felling_axe_lua:GetModifierPreAttack_BonusDamage()
    return self.bonus_damage
end
function modifier_item_felling_axe_lua:GetModifierConstantHealthRegen()
    return self.hp_regen
end
function modifier_item_felling_axe_lua:GetModifierEvasion_Constant()
    return self.bonus_evasion
end
function modifier_item_felling_axe_lua:GetModifierAttackSpeedBonus_Constant()
    return self.bonus_attack_speed
end
function modifier_item_felling_axe_lua:GetModifierTotalDamageOutgoing_Percentage(params)
    if IsServer() then
        local name = self:GetName()
        local hParent = self:GetParent()
        local buffs = hParent:FindAllModifiersByName(name)

        if self == buffs[1] then
            if not params.target:IsConsideredHero() and params.damage_category == DOTA_DAMAGE_CATEGORY_ATTACK and not hParent:HasModifier("modifier_item_aeon_disk_lua_buff") then
                return self.neutral_bonus_dmg_pct
            end
        end
    end
end
function modifier_item_felling_axe_lua:OnOrder(params)
    if not IsServer() then return end

    local hParent = self:GetParent()
    if params.unit ~= hParent then return end

    local name = self:GetName()
    local buffs = hParent:FindAllModifiersByName(name)

    local is_attack_order =
        params.order_type == DOTA_UNIT_ORDER_ATTACK_TARGET
        or params.order_type == DOTA_UNIT_ORDER_ATTACK_MOVE

    self.bonus_range_active =
        self == buffs[1]
        and is_attack_order
        and (
            params.order_type == DOTA_UNIT_ORDER_ATTACK_MOVE
            or (
                IsValid(params.target)
                and not params.target:IsConsideredHero()
            )
        )
end
function modifier_item_felling_axe_lua:GetModifierAttackRangeBonus()
    if IsServer() then
        if self.bonus_range_active then
            return self.bonus_attack_range
        end
    end
    return 0
end
function modifier_item_felling_axe_lua:OnAttackStart(params)
    local hParent = self:GetParent()
    if params.attacker == hParent then
        local name = self:GetName()
        local buffs = hParent:FindAllModifiersByName(name)
        if IsValid(params.target) and params.target.IsConsideredHero ~= nil and (not params.target:IsConsideredHero()) and self == buffs[1] then
            self.bonus_range_active = true
        else
            self.bonus_range_active = false
        end
    end
end
function modifier_item_felling_axe_lua:OnAttackCancelled(params)
    local hParent = self:GetParent()
    if params.attacker == hParent then
        self.bonus_range_active = false
    end
end