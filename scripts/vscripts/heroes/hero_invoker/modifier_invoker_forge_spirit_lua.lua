--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_forged_spirit_melting_strike_custom_debuff", "heroes/hero_invoker/modifier_invoker_forge_spirit_lua", LUA_MODIFIER_MOTION_NONE)

modifier_invoker_forge_spirit_lua = class({})

--------------------------------------------------------------------------------
-- Classifications
function modifier_invoker_forge_spirit_lua:IsHidden()
    return true
end

function modifier_invoker_forge_spirit_lua:IsDebuff()
    return false
end

function modifier_invoker_forge_spirit_lua:IsPurgable()
    return false
end

--------------------------------------------------------------------------------
-- Initializations
function modifier_invoker_forge_spirit_lua:OnCreated(kv)
    self.armor = self:GetAbility():GetSpecialValueFor("spirit_armor") - self:GetParent():GetPhysicalArmorBaseValue()
    self.attack_range = self:GetAbility():GetSpecialValueFor("spirit_attack_range")
end

--------------------------------------------------------------------------------
-- Modifier Effects
function modifier_invoker_forge_spirit_lua:DeclareFunctions()
    local funcs = {
        MODIFIER_PROPERTY_ATTACK_RANGE_BONUS,
        MODIFIER_PROPERTY_PHYSICAL_ARMOR_BONUS,
        MODIFIER_PROPERTY_ATTACKSPEED_BONUS_CONSTANT,
    }

    return funcs
end

function modifier_invoker_forge_spirit_lua:GetModifierAttackRangeBonus()
    return self.attack_range
end

function modifier_invoker_forge_spirit_lua:GetModifierPhysicalArmorBonus()
    return self.armor
end

function modifier_invoker_forge_spirit_lua:GetModifierAttackSpeedBonus_Constant()
    return self:GetAbility():GetSpecialValueFor("spirit_attack_speed")
end

function modifier_invoker_forge_spirit_lua:AttackLandedModifier( params )
    if params.attacker ~= self:GetParent() then return end
    if params.target == self:GetParent() then return end
    params.target:AddNewModifier(self:GetCaster(), self:GetAbility(), "modifier_forged_spirit_melting_strike_custom_debuff", {duration = self:GetAbility():GetSpecialValueFor("debuff_duration") })
end

modifier_forged_spirit_melting_strike_custom_debuff = class({})

function modifier_forged_spirit_melting_strike_custom_debuff:IsPurgable() return false end

function modifier_forged_spirit_melting_strike_custom_debuff:OnCreated()
    self.armor = self:GetAbility():GetSpecialValueFor("debuff_armor") * -1
    if not IsServer() then return end
    self:SetStackCount(1)
end

function modifier_forged_spirit_melting_strike_custom_debuff:OnRefresh()
    if not IsServer() then return end
    if self:GetStackCount() < 20 then
        self:IncrementStackCount()
    end
end

function modifier_forged_spirit_melting_strike_custom_debuff:DeclareFunctions()
    return {
        MODIFIER_PROPERTY_PHYSICAL_ARMOR_BONUS
    }
end

function modifier_forged_spirit_melting_strike_custom_debuff:GetModifierPhysicalArmorBonus()
    return self.armor * self:GetStackCount()
end