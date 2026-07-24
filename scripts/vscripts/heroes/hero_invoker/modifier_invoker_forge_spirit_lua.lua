--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


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
    self.armor = self:GetAbilitySpecialValueFor("spirit_armor")
    self.attack_range = self:GetAbilitySpecialValueFor("spirit_attack_range")
    self.spirit_attack_speed = self:GetAbilitySpecialValueFor("spirit_attack_speed")
    self.spirit_mana = self:GetAbilitySpecialValueFor("spirit_mana")
end

--------------------------------------------------------------------------------
-- Modifier Effects
function modifier_invoker_forge_spirit_lua:DeclareFunctions()
    local funcs = {
        MODIFIER_PROPERTY_ATTACK_RANGE_BONUS,
        MODIFIER_PROPERTY_PHYSICAL_ARMOR_BONUS,
        MODIFIER_PROPERTY_ATTACKSPEED_BONUS_CONSTANT,
        MODIFIER_PROPERTY_MANA_BONUS,
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
    return self.spirit_attack_speed
end
function modifier_invoker_forge_spirit_lua:GetModifierManaBonus()
    return self.spirit_mana
end